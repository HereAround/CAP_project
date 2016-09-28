#############################################################################
##
## TruncationsOfGradedModulePresentationsForCAP package
##
## Copyright 2016,  Martin Bies,       ITP Heidelberg
##
## Chapter Functors for graded module presentations for CAP
##
#############################################################################



###############################################
##
## Section The truncation functor to cones
##
###############################################

InstallMethod( Truncation,
               [ IsGradedLeftOrRightModulePresentationForCAP, IsConeHPresentationList ],
  function( module_presentation, cone_hpresentation_list )
    local underlying_morphism;

    underlying_morphism := PreCompose( [
                            EmbeddingOfTruncationOfProjectiveGradedModule(
                                                 Source( UnderlyingMorphism( module_presentation ) ), cone_hpresentation_list ),
                            UnderlyingMorphism( module_presentation ),
                            ProjectionOntoTruncationOfProjectiveGradedModule(
                                                 Range( UnderlyingMorphism( module_presentation ) ), cone_hpresentation_list )
                           ] );

    return CAPPresentationCategoryObject( underlying_morphism );

end );

InstallMethod( Truncation,
               [ IsGradedLeftOrRightSubmoduleForCAP, IsConeHPresentationList ],
  function( submodule, cone_hpresentation_list )
    local new_presentation, embedding;
  
    # compute a new presentation
    new_presentation := Truncation( PresentationForCAP( submodule ), cone_hpresentation_list );

    # compute the embedding
    embedding := EmbeddingInProjectiveObject( new_presentation );
    
    # and return the associated subobject
    if IsGradedLeftSubmoduleForCAP( submodule ) then
      return GradedLeftSubmoduleForCAP( UnderlyingMorphism( embedding ) );
    else
      return GradedRightSubmoduleForCAP( UnderlyingMorphism( embedding ) );
    fi;
    
end );

InstallMethod( Truncation,
               [ IsGradedLeftOrRightModulePresentationMorphismForCAP, IsConeHPresentationList ],
  function( module_presentation_morphism, cone_hpresentation_list )
    local embedding, projection, underlying_morphism, underlying_morphism_source, new_source,
         underlying_morphism_range, new_range;

    # compute the new mapping 'prescription'
    embedding := EmbeddingOfTruncationOfProjectiveGradedModule(
                        Range( UnderlyingMorphism( Source( module_presentation_morphism ) ) ), cone_hpresentation_list );
    projection := ProjectionOntoTruncationOfProjectiveGradedModule(
                        Range( UnderlyingMorphism( Range( module_presentation_morphism ) ) ), cone_hpresentation_list );
    underlying_morphism := PreCompose( [ embedding, UnderlyingMorphism( module_presentation_morphism ), projection ] );

    # compute the new source
    underlying_morphism_source := PreCompose( [
                           EmbeddingOfTruncationOfProjectiveGradedModule(
                                                   Source( UnderlyingMorphism( Source( module_presentation_morphism ) ) ),
                                                   cone_hpresentation_list
                                                   ),
                           UnderlyingMorphism( Source( module_presentation_morphism ) ),
                           ProjectionOntoTruncationOfProjectiveGradedModule(
                                                   Range( UnderlyingMorphism( Source( module_presentation_morphism ) ) ),
                                                   cone_hpresentation_list
                                                   )
                           ] );
    new_source := CAPPresentationCategoryObject( underlying_morphism_source );

    # compute the new range
    underlying_morphism_range := PreCompose( [
                           EmbeddingOfTruncationOfProjectiveGradedModule(
                                                   Source( UnderlyingMorphism( Range( module_presentation_morphism ) ) ),
                                                   cone_hpresentation_list
                                                   ),
                           UnderlyingMorphism( Range( module_presentation_morphism ) ),
                           projection
                           ] );
    new_range := CAPPresentationCategoryObject( underlying_morphism_range );

    # and finally return the new morphism
    return CAPPresentationCategoryMorphism( new_source,
                                            underlying_morphism,
                                            new_range,
                                            CapCategory( new_source )!.constructor_checks_wished 
                                           );

end );

# this function computes the truncation functor for both left and right presentations
InstallGlobalFunction( TruncationFunctorToCones,
  function( graded_ring, cone_hpresentation_list, left )
    local rank, i, category, functor;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( graded_ring ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if the subsemigroup is contained in the DegreeGroup
    rank := Rank( DegreeGroup( graded_ring ) );
    if EmbeddingDimension( cone_hpresentation_list ) <> rank then

      Error( "The semigroup is not contained in the degree_group of the graded ring" );
      return;

    fi;

    # first compute the category under consideration
    if left = true then    
      category := SfpgrmodLeft( graded_ring );
    else
      category := SfpgrmodRight( graded_ring );
    fi;

    # then initialise the functor
    functor := CapFunctor(
                      Concatenation( "Truncation functor for ", Name( category ), 
                                     " to the cone given by the h-constraints ", 
                                     String( UnderlyingList( cone_hpresentation_list ) ) ), 
                      category,
                      category
                      );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

        return Truncation( object, cone_hpresentation_list );

    end );

    # now define the functor operation on the morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        local underlying_morphism;

        underlying_morphism := PreCompose( [
           EmbeddingOfTruncationOfProjectiveGradedModuleWithGivenTruncationObject(
                                 Range( UnderlyingMorphism( Source( morphism ) ) ), Range( UnderlyingMorphism( new_source ) ) ),
           UnderlyingMorphism( morphism ),
           ProjectionOntoTruncationOfProjectiveGradedModuleWithGivenTruncationObject( 
                                   Range( UnderlyingMorphism( Range( morphism ) ) ), Range( UnderlyingMorphism( new_range ) ) )
           ] );

        return CAPPresentationCategoryMorphism( new_source,
                                                underlying_morphism,
                                                new_range,
                                                CapCategory( new_source )!.constructor_checks_wished
                                               );

    end );

    # finally return the functor
    return functor;

end );

# functor to compute the truncation of left presentations
InstallMethod( TruncationFunctorLeft,
               [ IsHomalgGradedRing, IsConeHPresentationList ],
  function( graded_ring, cone_hpresentation_list )

    return TruncationFunctorToCones( graded_ring, cone_hpresentation_list, true );

end );

# functor to compute the truncation of left presentations
InstallMethod( TruncationFunctorRight,
               [ IsHomalgGradedRing, IsConeHPresentationList ],
  function( graded_ring, cone_hpresentation_list )

    return TruncationFunctorToCones( graded_ring, cone_hpresentation_list, false );

end );



###############################################
##
## Section The truncation functor to cones
##
###############################################

InstallMethod( Truncation,
               [ IsGradedLeftOrRightModulePresentationForCAP, IsSemigroupGeneratorList ],
  function( module_presentation, semigroup_generator_list )
    local conversion, underlying_morphism;

    # check if the semigroup is the semigroup of a cone
    conversion := UnderlyingConeHPresentationList( semigroup_generator_list );
    if conversion <> fail then
      return Truncation( module_presentation, conversion );
    fi;

    # otherwise do the computation here
    underlying_morphism := PreCompose( [
                            EmbeddingOfTruncationOfProjectiveGradedModule(
                                                 Source( UnderlyingMorphism( module_presentation ) ), semigroup_generator_list ),
                            UnderlyingMorphism( module_presentation ),
                            ProjectionOntoTruncationOfProjectiveGradedModule(
                                                 Range( UnderlyingMorphism( module_presentation ) ), semigroup_generator_list )
                           ] );

    return CAPPresentationCategoryObject( underlying_morphism );

end );

InstallMethod( Truncation,
               [ IsGradedLeftOrRightSubmoduleForCAP, IsSemigroupGeneratorList ],
  function( submodule, semigroup_generator_list )

    local new_presentation, embedding;
  
    # compute a new presentation
    new_presentation := Truncation( PresentationForCAP( submodule ), semigroup_generator_list );

    # compute the embedding
    embedding := EmbeddingInProjectiveObject( new_presentation );
    
    # and return the associated subobject
    if IsGradedLeftSubmoduleForCAP( submodule ) then
      return GradedLeftSubmoduleForCAP( UnderlyingMorphism( embedding ) );
    else
      return GradedRightSubmoduleForCAP( UnderlyingMorphism( embedding ) );
    fi;

end );

InstallMethod( Truncation,
               [ IsGradedLeftOrRightModulePresentationMorphismForCAP, IsSemigroupGeneratorList ],
  function( module_presentation_morphism, semigroup_generator_list )
    local conversion, embedding, projection, underlying_morphism, underlying_morphism_source, new_source,
         underlying_morphism_range, new_range;

    # check if the semigroup is the semigroup of a cone
    conversion := UnderlyingConeHPresentationList( semigroup_generator_list );
    if conversion <> fail then
      return Truncation( module_presentation_morphism, conversion );
    fi;

    # compute the new mapping 'prescription'
    embedding := EmbeddingOfTruncationOfProjectiveGradedModule(
                        Range( UnderlyingMorphism( Source( module_presentation_morphism ) ) ), semigroup_generator_list );
    projection := ProjectionOntoTruncationOfProjectiveGradedModule(
                        Range( UnderlyingMorphism( Range( module_presentation_morphism ) ) ), semigroup_generator_list );
    underlying_morphism := PreCompose( [ embedding, UnderlyingMorphism( module_presentation_morphism ), projection ] );

    # compute the new source
    underlying_morphism_source := PreCompose( [
                           EmbeddingOfTruncationOfProjectiveGradedModule(
                                                   Source( UnderlyingMorphism( Source( module_presentation_morphism ) ) ),
                                                   semigroup_generator_list
                                                   ),
                           UnderlyingMorphism( Source( module_presentation_morphism ) ),
                           ProjectionOntoTruncationOfProjectiveGradedModule(
                                                   Range( UnderlyingMorphism( Source( module_presentation_morphism ) ) ),
                                                   semigroup_generator_list
                                                   )
                           ] );
    new_source := CAPPresentationCategoryObject( underlying_morphism_source );

    # compute the new range
    underlying_morphism_range := PreCompose( [
                           EmbeddingOfTruncationOfProjectiveGradedModule(
                                                   Source( UnderlyingMorphism( Range( module_presentation_morphism ) ) ),
                                                   semigroup_generator_list
                                                   ),
                           UnderlyingMorphism( Range( module_presentation_morphism ) ),
                           projection
                           ] );
    new_range := CAPPresentationCategoryObject( underlying_morphism_range );

    # and finally return the new morphism
    return CAPPresentationCategoryMorphism( new_source,
                                            underlying_morphism,
                                            new_range,
                                            CapCategory( new_source )!.constructor_checks_wished 
                                           );

end );

# this function computes the truncation functor for both left and right presentations
InstallGlobalFunction( TruncationFunctorToSemigroups,
  function( graded_ring, semigroup_generator_list, left )
    local conversion, rank, i, category, functor;

    # check if the semigroup is the semigroup of a cone
    conversion := UnderlyingConeHPresentationList( semigroup_generator_list );
    if conversion <> fail then
      return TruncationFunctorToCones( graded_ring, conversion );
    fi;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( graded_ring ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if the subsemigroup is contained in the DegreeGroup
    rank := Rank( DegreeGroup( graded_ring ) );
    if EmbeddingDimension( semigroup_generator_list ) <> rank then

      Error( "The semigroup is not contained in the degree_group of the graded ring" );
      return;

    fi;

    # first compute the category under consideration
    if left = true then
      category := SfpgrmodLeft( graded_ring );
    else
      category := SfpgrmodRight( graded_ring );
    fi;

    # then initialise the functor
    functor := CapFunctor(
                      Concatenation( "Truncation functor for ", Name( category ), " to the semigroup generated by ", 
                      String( UnderlyingList( semigroup_generator_list ) ) ), 
                      category,
                      category
                      );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

        return Truncation( object, semigroup_generator_list );

    end );

    # now define the functor operation on the morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        local underlying_morphism;

        underlying_morphism := PreCompose( [
           EmbeddingOfTruncationOfProjectiveGradedModuleWithGivenTruncationObject(
                                 Range( UnderlyingMorphism( Source( morphism ) ) ), Range( UnderlyingMorphism( new_source ) ) ),
           UnderlyingMorphism( morphism ),
           ProjectionOntoTruncationOfProjectiveGradedModuleWithGivenTruncationObject(
                                   Range( UnderlyingMorphism( Range( morphism ) ) ), Range( UnderlyingMorphism( new_range ) ) )
           ] );

        return CAPPresentationCategoryMorphism( new_source, 
                                                underlying_morphism, 
                                                new_range,
                                                CapCategory( new_source )!.constructor_checks_wished
                                               );

    end );

    # finally return the functor
    return functor;

end );

# functor to compute the truncation of left presentations
InstallMethod( TruncationFunctorLeft,
               [ IsHomalgGradedRing, IsSemigroupGeneratorList ],
  function( graded_ring, semigroup_generator_list )
    local conversion;

    conversion := UnderlyingConeHPresentationList( semigroup_generator_list );

    if conversion = fail then
      return TruncationFunctorToSemigroups( graded_ring, semigroup_generator_list, true );
    else
      return TruncationFunctorToCones( graded_ring, conversion, true );

    fi;

end );

# functor to compute the truncation of right presentations
InstallMethod( TruncationFunctorRight,
               [ IsHomalgGradedRing, IsSemigroupGeneratorList ],
function( graded_ring, semigroup_generator_list )
  local conversion;

    conversion := UnderlyingConeHPresentationList( semigroup_generator_list );

    if conversion = fail then
      return TruncationFunctorToSemigroups( graded_ring, semigroup_generator_list, false );
    else
      return TruncationFunctorToCones( graded_ring, conversion, false );
    fi;

end );