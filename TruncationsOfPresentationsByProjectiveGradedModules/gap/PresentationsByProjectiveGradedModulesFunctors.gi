#############################################################################
##
## TruncationsOfPresentationsByProjectiveGradedModules package
##
## Copyright 2016,  Martin Bies,       ITP Heidelberg
##
## Chapter Functors for graded module presentations for CAP
##
#############################################################################



###############################################
##
## Section The truncation functor to semigroups
##
###############################################

InstallMethod( Truncation,
               [ IsGradedLeftOrRightModulePresentationForCAP, IsSemigroupForPresentationsByProjectiveGradedModules ],
  function( module_presentation, semigroup_for_CAP )
    local underlying_morphism;

    underlying_morphism := PreCompose( [
                            EmbeddingOfTruncationOfProjectiveGradedModule(
                                                 Source( UnderlyingMorphism( module_presentation ) ), semigroup_for_CAP ),
                            UnderlyingMorphism( module_presentation ),
                            ProjectionOntoTruncationOfProjectiveGradedModule(
                                                 Range( UnderlyingMorphism( module_presentation ) ), semigroup_for_CAP )
                           ] );

    return CAPPresentationCategoryObject( underlying_morphism );

end );

InstallMethod( Truncation,
               [ IsGradedLeftOrRightSubmoduleForCAP, IsSemigroupForPresentationsByProjectiveGradedModules ],
  function( submodule, semigroup_for_CAP )
    local new_presentation, embedding;

    # compute a new presentation
    new_presentation := Truncation( PresentationForCAP( submodule ), semigroup_for_CAP );

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
               [ IsGradedLeftOrRightModulePresentationMorphismForCAP, IsSemigroupForPresentationsByProjectiveGradedModules ],
  function( module_presentation_morphism, semigroup_for_CAP )
    local embedding, projection, underlying_morphism, underlying_morphism_source, new_source,
         underlying_morphism_range, new_range;

    # compute the new mapping 'prescription'
    embedding := EmbeddingOfTruncationOfProjectiveGradedModule(
                        Range( UnderlyingMorphism( Source( module_presentation_morphism ) ) ), semigroup_for_CAP );
    projection := ProjectionOntoTruncationOfProjectiveGradedModule(
                        Range( UnderlyingMorphism( Range( module_presentation_morphism ) ) ), semigroup_for_CAP );
    underlying_morphism := PreCompose( [ embedding, UnderlyingMorphism( module_presentation_morphism ), projection ] );

    # compute the new source
    underlying_morphism_source := PreCompose( [
                           EmbeddingOfTruncationOfProjectiveGradedModule(
                                                   Source( UnderlyingMorphism( Source( module_presentation_morphism ) ) ),
                                                   semigroup_for_CAP
                                                   ),
                           UnderlyingMorphism( Source( module_presentation_morphism ) ),
                           ProjectionOntoTruncationOfProjectiveGradedModule(
                                                   Range( UnderlyingMorphism( Source( module_presentation_morphism ) ) ),
                                                   semigroup_for_CAP
                                                   )
                           ] );
    new_source := CAPPresentationCategoryObject( underlying_morphism_source );

    # compute the new range
    underlying_morphism_range := PreCompose( [
                           EmbeddingOfTruncationOfProjectiveGradedModule(
                                                   Source( UnderlyingMorphism( Range( module_presentation_morphism ) ) ),
                                                   semigroup_for_CAP
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
  function( graded_ring, semigroup_for_CAP, left )
    local conversion, rank, i, category, functor;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( graded_ring ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if the subsemigroup is contained in the DegreeGroup
    rank := Rank( DegreeGroup( graded_ring ) );
    if EmbeddingDimension( semigroup_for_CAP ) <> rank then

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
                      String( GeneratorList( semigroup_for_CAP ) ) ), 
                      category,
                      category
                      );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

        return Truncation( object, semigroup_for_CAP );

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
               [ IsHomalgGradedRing, IsSemigroupForPresentationsByProjectiveGradedModules ],
  function( graded_ring, semigroup_for_CAP )

    return TruncationFunctorToSemigroups( graded_ring, semigroup_for_CAP, true );

end );

# functor to compute the truncation of right presentations
InstallMethod( TruncationFunctorRight,
               [ IsHomalgGradedRing, IsSemigroupForPresentationsByProjectiveGradedModules ],
function( graded_ring, semigroup_for_CAP )

    return TruncationFunctorToSemigroups( graded_ring, semigroup_for_CAP, false );

end );