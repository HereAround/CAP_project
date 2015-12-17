#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter Functors for graded module presentations for CAP
##
#############################################################################



################################################
##
## Section Functor LessGenerators
##
################################################

# This method intends to simply this module presentation. To this end we look at the following diagram:
# module1 --- M ---> module2
#    |                   |
#    U                   T
#    |                   |
#    v                   v
# module1' --- M' ---> module2'
# U,T are ment to be invertible. Then the following method computes [ M', T, T^-1 ]

# FIXME: Why is T homogeneous?
InstallMethod( LessGradedGeneratorsTransformationTriple,
               [ IsHomalgMatrix ],
  function( matrix )
    local transformation, transformation_inverse, smaller_matrix;

    # initialise the transformation matrices T, T^{-1}
    transformation := HomalgVoidMatrix( HomalgRing( matrix ) );    
    transformation_inverse := HomalgVoidMatrix( HomalgRing( matrix ) );

    # compute M' and thereby set values for T and T^{-1}
    smaller_matrix := SimplerEquivalentMatrix( matrix, transformation, transformation_inverse, "", "" );

    # return the triple of desired information
    return [ smaller_matrix, transformation, transformation_inverse ];

end );

# compute a smaller presentation for a graded left or right module presentation for CAP
InstallMethod( LessGradedGenerators,
               [ IsGradedLeftOrRightModulePresentationForCAP ],
  function( module_presentation )
    local TI, range_prime, Mprime;

    # recall that we look at the following diagram
    # Source( object) --- MappingMatrix( object ) ---> Range( object )
    #     |                                                   |
    #     ?                                                   T
    #     |                                                   |
    #     v                                                   v
    # Source( object' ) -- MappingMatrix( object' ) ---> Range( object' )

    # now deduce the bottom line
    if IsGradedLeftModulePresentationForCAP( module_presentation ) then

      TI := LessGradedGeneratorsTransformationTriple( UnderlyingHomalgMatrix( UnderlyingMorphism( module_presentation ) ) )[ 3 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeLeft( TI, Range( UnderlyingMorphism( module_presentation ) ) ) );
      Mprime := ReducedSyzygiesOfRows( TI, UnderlyingHomalgMatrix( UnderlyingMorphism( module_presentation ) ) );
      return CAPPresentationCategoryObject( DeduceMapFromMatrixAndRangeLeft( Mprime, range_prime ) );

    else

      TI := LessGradedGeneratorsTransformationTriple( UnderlyingHomalgMatrix( UnderlyingMorphism( module_presentation ) ) )[ 2 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeRight( TI, Range( UnderlyingMorphism( module_presentation ) ) ) );
      Mprime := ReducedSyzygiesOfColumns( TI, UnderlyingHomalgMatrix( UnderlyingMorphism( module_presentation ) ) );
      return CAPPresentationCategoryObject( DeduceMapFromMatrixAndRangeRight( Mprime, range_prime ) );

    fi;

end );

# compute a smaller presentation for a graded left or right module presentation for CAP
InstallMethod( LessGradedGenerators,
               [ IsGradedLeftOrRightSubmoduleForCAP ],
  function( submodule )
    local new_presentation, embedding;
  
    # compute a new presentation
    new_presentation := LessGradedGenerators( PresentationForCAP( submodule ) );

    # compute the embedding
    embedding := EmbeddingInProjectiveObject( new_presentation );
    
    # and return the associated subobject
    if IsGradedLeftSubmoduleForCAP( submodule ) then
      return GradedLeftSubmoduleForCAP( UnderlyingMorphism( embedding ) );
    else
      return GradedRightSubmoduleForCAP( UnderlyingMorphism( embedding ) );
    fi;
    
end );

# compute a smaller presentation for a graded left or right module presentation for CAP
InstallMethod( LessGradedGenerators,
               [ IsGradedLeftOrRightModulePresentationMorphismForCAP ],
  function( morphism )
    local source_transformation_triple, range_transformation_triple, TI, range_prime, Mprime, new_source, new_range, 
         new_morphism_matrix, new_morphism;

    # compute the transformation of source and range
    source_transformation_triple := LessGradedGeneratorsTransformationTriple(
                                                    UnderlyingHomalgMatrix( UnderlyingMorphism( Source( morphism ) ) ) );
    range_transformation_triple := LessGradedGeneratorsTransformationTriple(
                                                     UnderlyingHomalgMatrix( UnderlyingMorphism( Range( morphism ) ) ) );

    # and extract the underlying homalg matrix of the morphism
    new_morphism_matrix := UnderlyingHomalgMatrix( UnderlyingMorphism( morphism ) );

    if IsGradedLeftModulePresentationMorphismForCAP( morphism ) then

      # compute the new source
      TI := source_transformation_triple[ 3 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeLeft( TI, Range( UnderlyingMorphism( Source( morphism ) ) ) ) );
      Mprime := ReducedSyzygiesOfRows( TI, UnderlyingHomalgMatrix( UnderlyingMorphism( Source( morphism ) ) ) );
      new_source := CAPPresentationCategoryObject( DeduceMapFromMatrixAndRangeLeft( Mprime, range_prime ) );

      # and the new range
      TI := range_transformation_triple[ 3 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeLeft( TI, Range( UnderlyingMorphism( Range( morphism ) ) ) ) );
      Mprime := ReducedSyzygiesOfRows( TI, UnderlyingHomalgMatrix( UnderlyingMorphism( Range( morphism ) ) ) );
      new_range := CAPPresentationCategoryObject( DeduceMapFromMatrixAndRangeLeft( Mprime, range_prime ) );

      # compute the new mapping matrix
      new_morphism_matrix := source_transformation_triple[ 3 ] * new_morphism_matrix * range_transformation_triple[ 2 ];

    else

      # compute the new source
      TI := source_transformation_triple[ 2 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeRight( TI, Range( UnderlyingMorphism( Source( morphism ) ) ) ) );
      Mprime := ReducedSyzygiesOfColumns( TI, UnderlyingHomalgMatrix( UnderlyingMorphism( Source( morphism ) ) ) );
      new_range := CAPPresentationCategoryObject( DeduceMapFromMatrixAndRangeRight( Mprime, range_prime ) );

      # and the new range
      TI := range_transformation_triple[ 2 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeRight( TI, Range( UnderlyingMorphism( Range( morphism ) ) ) ) );
      Mprime := ReducedSyzygiesOfColumns( TI, UnderlyingHomalgMatrix( UnderlyingMorphism( Range( morphism ) ) ) );
      new_range := CAPPresentationCategoryObject( DeduceMapFromMatrixAndRangeRight( Mprime, range_prime ) );

      # compute the new mapping matrix
      new_morphism_matrix := range_transformation_triple[ 3 ] * new_morphism_matrix * source_transformation_triple[ 2 ];

    fi;

    # now wrap to form new_morphism
    new_morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism(
                                                 Range( UnderlyingMorphism( new_source ) ),
                                                 new_morphism_matrix,
                                                 Range( UnderlyingMorphism( new_range ) ),
                                                 CapCategory( UnderlyingMorphism( new_source ) )!.constructor_checks_wished
                                                );

    # and return the corresponding morphism
    return CAPPresentationCategoryMorphism( new_source,
                                            new_morphism,
                                            new_range,
                                            CapCategory( new_source )!.constructor_checks_wished 
                                           );

end );

# this function computes the functor 'lessGenerators' for both left and right presentations
InstallGlobalFunction( FunctorLessGradedGenerators,
  function( graded_ring, left )
    local category, functor;

    # first compute the category under consideration
    if left = true then
      category := SfpgrmodLeft( graded_ring );
    else
      category := SfpgrmodRight( graded_ring );
    fi;

    # then initialise the functor
    functor := CapFunctor( Concatenation( "Less generators for ", Name( category ) ), category, category );

    # and add the functor operation on objects
    AddObjectFunction( functor,
      function( object )

        return LessGradedGenerators( object );

    end );

    # and on morphism
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

        return LessGradedGenerators( morphism );

    end );

    # then return the functor
    return functor;

end );

# functor to reduce the number of generators of a graded left-presentation
InstallMethod( FunctorLessGradedGeneratorsLeft,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorLessGradedGenerators( graded_ring, true );

end );


# functor to reduce the number of generators of a graded left-presentation
InstallMethod( FunctorLessGradedGeneratorsRight,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorLessGradedGenerators( graded_ring, false );

end );



#################################################
##
## Section Functor StandardModule for S-fpgrmod
##
#################################################

# compute a smaller presentation for a graded left or right module presentation for CAP
InstallMethod( GradedStandardModule,
               [ IsGradedLeftOrRightModulePresentationForCAP ],
  function( module_presentation )
    local matrix, new_underlying_morphism;

    # compute a new representation matrix
    if IsGradedLeftModulePresentationForCAP( module_presentation ) then

      matrix := ReducedBasisOfRowModule( UnderlyingHomalgMatrix( UnderlyingMorphism( module_presentation ) ) );
      new_underlying_morphism := DeduceMapFromMatrixAndRangeLeft( matrix, Range( UnderlyingMorphism( module_presentation ) ) );

    else

      matrix := ReducedBasisOfColumnModule( UnderlyingHomalgMatrix( UnderlyingMorphism( module_presentation ) ) );
      new_underlying_morphism := DeduceMapFromMatrixAndRangeRight( matrix, Range( UnderlyingMorphism( module_presentation ) ) );

    fi;

    # and return the new object
    return CAPPresentationCategoryObject( new_underlying_morphism );

end );

# compute a smaller presentation for a graded left or right module presentation for CAP
InstallMethod( GradedStandardModule,
               [ IsGradedLeftOrRightSubmoduleForCAP ],
  function( submodule )
    local new_presentation, embedding;
  
    # compute a new presentation
    new_presentation := GradedStandardModule( PresentationForCAP( submodule ) );

    # compute the embedding
    embedding := EmbeddingInProjectiveObject( new_presentation );
    
    # and return the associated subobject
    if IsGradedLeftSubmoduleForCAP( submodule ) then
      return GradedLeftSubmoduleForCAP( UnderlyingMorphism( embedding ) );
    else
      return GradedRightSubmoduleForCAP( UnderlyingMorphism( embedding ) );
    fi;

end );

# compute a smaller presentation for a graded left or right module presentation for CAP
InstallMethod( GradedStandardModule,
               [ IsGradedLeftOrRightModulePresentationMorphismForCAP ],
  function( morphism )
    local new_source, new_range, new_underlying_morphism;

    # compute the new underlying morphism
    new_source := GradedStandardModule( Source( morphism ) );
    new_range := GradedStandardModule( Range( morphism ) );
    new_underlying_morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism(
                                                      Range( UnderlyingMorphism( new_source ) ),
                                                      UnderlyingHomalgMatrix( UnderlyingMorphism( morphism ) ),
                                                      Range( UnderlyingMorphism( new_range ) ),
                                                      CapCategory( UnderlyingMorphism( new_source ) )!.constructor_checks_wished
                                                     );

    # and return the corresponding morphism
    return CAPPresentationCategoryMorphism( new_source,
                                            new_underlying_morphism,
                                            new_range,
                                            CapCategory( new_source )!.constructor_checks_wished
                                           );

end );

# this function computes the functor 'lessGenerators' for both left and right presentations
InstallGlobalFunction( FunctorGradedStandardModule,
  function( graded_ring, left )
    local category, functor;

    # first compute the category under consideration
    if left = true then    
      category := SfpgrmodLeft( graded_ring );
    else
      category := SfpgrmodRight( graded_ring );
    fi;

    # then initialise the functor
    functor := CapFunctor( Concatenation( "Graded standard module for ", Name( category ) ), category, category );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

        return GradedStandardModule( object );

    end );

    # now define the functor operation on the morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        local new_underlying_morphism;

        # compute the new underlying morphism
        new_underlying_morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism(
                                                      Range( UnderlyingMorphism( new_source ) ),
                                                      UnderlyingHomalgMatrix( UnderlyingMorphism( morphism ) ),
                                                      Range( UnderlyingMorphism( new_range ) ),
                                                      CapCategory( UnderlyingMorphism( new_source ) )!.constructor_checks_wished
                                                     );

        # and return the corresponding morphism
        return CAPPresentationCategoryMorphism( new_source,
                                                new_underlying_morphism,
                                                new_range,
                                                CapCategory( new_source )!.constructor_checks_wished
                                               );

    end );

    # finally return the functor
    return functor;

end );

# functor to compute the standard module of left presentations
InstallMethod( FunctorGradedStandardModuleLeft,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorGradedStandardModule( graded_ring, true );

end );

# functor to compute the standard module of right presentations
InstallMethod( FunctorGradedStandardModuleRight,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorGradedStandardModule( graded_ring, false );

end );



#######################################################
##
## Section Functor ByASmallerPresentation for S-fpgrmod
##
#######################################################

# compute a smaller presentation for a graded left or right module presentation for CAP
InstallMethod( ByASmallerPresentation,
               [ IsGradedLeftOrRightModulePresentationForCAP ],
  function( module_presentation )

    return GradedStandardModule( LessGradedGenerators( module_presentation ) );

end );

# compute a smaller presentation for a graded left or right module presentation for CAP
InstallMethod( ByASmallerPresentation,
               [ IsGradedLeftOrRightSubmoduleForCAP ],
  function( submodule )
    local new_presentation, embedding;
  
    # compute a new presentation
    new_presentation := GradedStandardModule( LessGradedGenerators( PresentationForCAP( submodule ) ) );

    # compute the embedding
    embedding := EmbeddingInProjectiveObject( new_presentation );
    
    # and return the associated subobject
    if IsGradedLeftSubmoduleForCAP( submodule ) then
      return GradedLeftSubmoduleForCAP( UnderlyingMorphism( embedding ) );
    else
      return GradedRightSubmoduleForCAP( UnderlyingMorphism( embedding ) );
    fi;

end );

# compute a smaller presentation for a graded left or right module presentation for CAP
InstallMethod( ByASmallerPresentation,
               [ IsGradedLeftOrRightModulePresentationMorphismForCAP ],
  function( morphism )

    return GradedStandardModule( LessGradedGenerators( morphism ) );

end );

# this function computes the functor 'lessGenerators' for both left and right presentations
InstallGlobalFunction( FunctorByASmallerPresentation,
  function( graded_ring, left )
    local category, functor;

    # first compute the category under consideration
    if left = true then
      category := SfpgrmodLeft( graded_ring );
    else
      category := SfpgrmodRight( graded_ring );
    fi;

    # then initialise the functor
    functor := CapFunctor( Concatenation( "Functor 'ByASmallerPresentation' for ", Name( category ) ), category, category );

    # and add the functor operation on objects
    AddObjectFunction( functor,
      function( object )

        return ByASmallerPresentation( object );

    end );

    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

        return ByASmallerPresentation( morphism );

    end );

    # then return the functor
    return functor;

end );

# functor to reduce the number of generators of a graded left-presentation
InstallMethod( FunctorByASmallerPresentationLeft,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorByASmallerPresentation( graded_ring, true );

end );


# functor to reduce the number of generators of a graded left-presentation
InstallMethod( FunctorByASmallerPresentationRight,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorByASmallerPresentation( graded_ring, false );

end );



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
    conversion := TurnIntoConeHPresentationList( semigroup_generator_list );
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
    conversion := TurnIntoConeHPresentationList( semigroup_generator_list );
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
    conversion := TurnIntoConeHPresentationList( semigroup_generator_list );
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

    conversion := TurnIntoConeHPresentationList( semigroup_generator_list );

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

    conversion := TurnIntoConeHPresentationList( semigroup_generator_list );

    if conversion = fail then
      return TruncationFunctorToSemigroups( graded_ring, semigroup_generator_list, false );
    else
      return TruncationFunctorToCones( graded_ring, conversion, false );
    fi;

end );



###############################################
##
#! @Section The Frobenius-power functor
##
###############################################

# Frobenius power of a matrix
InstallGlobalFunction( FrobeniusPowerOfMatrix,
  function( matrix, power )
    local new_mapping_matrix, i, j;

    # check the input
    if not IsHomalgMatrix( matrix ) then

      Error( "The first argument must be a homalg matrix" );
      return;

    elif not IsInt( power ) then

      Error( "The power must be a non-negative integer" );
      return;

    elif power < 0 then

      Error( "The power must be a non-negative integer" );
      return;

    fi;

    # now compute the Frobenius power
    new_mapping_matrix := EntriesOfHomalgMatrixAsListList( matrix );
    for i in [ 1 .. Length( new_mapping_matrix ) ] do
      for j in [ 1 .. Length( new_mapping_matrix[ i ] ) ] do
        new_mapping_matrix[ i ][ j ] := new_mapping_matrix[ i ][ j ]^power;
      od;
    od;

    # and return the result
    return HomalgMatrix( new_mapping_matrix, HomalgRing( matrix ) );

end );

# Frobenius power of a module presentation
InstallMethod( FrobeniusPower,
               "Frobenius powers of presentation",
               [ IsGradedLeftOrRightModulePresentationForCAP, IsInt ],
  function( presentation_object, power )
    local left, embedding, range, matrix, new_mapping_matrix, i, j, alpha;

    if power < 0 then

      Error( "The power must be non-negative" );
      return;

    elif power = 1 then

      return presentation_object;

    else

      # determine if we are dealing with left or right presentation
      left :=  IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( UnderlyingMorphism( presentation_object ) );

      # look at the following diagram
      # R_A                    0
      #  |                     |
      # alpha                  |
      #  |                     |
      #  v                     v
      #  A -- matrix --> projective_module
      #
      # alpha = presentation_object and we can compute the embedding into the projective module.

      # We compute the matrix from "EmbeddingInProjectiveModule". 
      # Then we power all entries of this matrix by power (<-> Frobenius power).
      # Then we deduce from this a mapping with range "projective_module" but in general new source.
      # Subsequently we compute the kernel embedding of this map.
      # Finally we turn this kernel embedding into a presentation_category_object and return it.

      # compute the matrix
      embedding := EmbeddingInProjectiveObject( presentation_object );
      range := Range( UnderlyingMorphism( embedding ) );
      matrix := UnderlyingHomalgMatrix( UnderlyingMorphism( embedding ) );

      # now compute the power of the mapping matrix
      new_mapping_matrix := FrobeniusPowerOfMatrix( matrix, power );

      # compute alpha
      if left then
        alpha := KernelEmbedding( DeduceMapFromMatrixAndRangeLeft( new_mapping_matrix, range ) );
      else
        alpha := KernelEmbedding( DeduceMapFromMatrixAndRangeRight( new_mapping_matrix, range ) );
      fi;

      # and return the corresponding object in the presentation category
      return CAPPresentationCategoryObject( alpha );

    fi;

end );

# Frobenius power of left or right submodules
InstallMethod( FrobeniusPower,
               "n-th Frobenius powers of ideals",
               [ IsGradedLeftOrRightSubmoduleForCAP, IsInt ],
  function( submodule, power )
    local generator_matrix;

    # extract the generators and take their individual powers via "FrobeniusPowerOfMatrix"
    generator_matrix := HomalgMatrix( Generators( submodule ), HomalgGradedRing( submodule ) );
    generator_matrix := FrobeniusPowerOfMatrix( generator_matrix, power );

    # then return the associated ideal
    if IsGradedLeftSubmoduleForCAP( submodule ) then
      return GradedLeftSubmoduleForCAP( 
                   EntriesOfHomalgMatrixAsListList( generator_matrix ), HomalgGradedRing( submodule ) );
    else
      return GradedRightSubmoduleForCAP(
                   EntriesOfHomalgMatrixAsListList( generator_matrix ), HomalgGradedRing( submodule ) );
    fi;

end );

# Frobenius power of a module presentation morphism
InstallMethod( FrobeniusPower,
               "Frobenius powers of presentation morphism",
               [ IsGradedLeftOrRightModulePresentationMorphismForCAP, IsInt ],
  function( presentation_morphism, power )
    local left, i1, i1_matrix, i1_matrix_frob_power, frob_power_i1, i2, i2_matrix ,i2_matrix_frob_power, frob_power_i2,
         mu_prime, mu_prime_prime, new_source, new_range;

    # look at the following diagram:
    # R_A                              R_B
    #  |                    		|
    # alpha                	       beta
    #  |                    		|
    #  v                    		v
    #  A -------------- mu -----------> B
    #  |                    		|
    #  i1                   	        i2
    #  |                    		|
    #  V                    		v
    # X_A ------------ mu' ----------> X_B
    #  ^                    		^
    #  |                    		|
    # FrobPower( i1 )     	   FrobPower( i2 )
    #  |                    		|
    #  A'------------  mu'' ----------> B'
    #  ^                    		^
    #  |                    		|
    # Ker( FrobPower( i1 )) 	Ker( FrobPower( i2 ) )
    #  |                    		|
    # R_A'                 		R_B'
    #
    # The presentation morphism mu is the input and has alpha, beta as source and range respectively.
    #
    # In this diagram i1 and i2 are the respective 'EmbeddingInProjectiveModule', which happen to be the cokernel mappings
    # of alpha and beta. Therefore we can compute the induced mapping mu' between the cokernel modules.
    #
    # The lower half of the diagram then describes the Frobenius powers of source and range of mu. We then compute mu''
    # from FrobPower( i1), mu' and FrobPower( i2 ) via a (co)lift.

    # are we working with left or right presentations?
    left := IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( UnderlyingMorphism( presentation_morphism ) );

    # compute i1, FrobPower( i1 ), i2, FrobPower( i2 )
    i1 := CokernelProjection( UnderlyingMorphism( Source( presentation_morphism ) ) );
    i1_matrix := UnderlyingHomalgMatrix( i1 );
    i1_matrix_frob_power := FrobeniusPowerOfMatrix( i1_matrix, power );

    if left then
      frob_power_i1 := DeduceMapFromMatrixAndRangeLeft( i1_matrix_frob_power, Range( i1 ) );
    else
      frob_power_i1 := DeduceMapFromMatrixAndRangeRight( i1_matrix_frob_power, Range( i1 ) );
    fi;

    i2 := CokernelProjection( UnderlyingMorphism( Range( presentation_morphism ) ) );
    i2_matrix := UnderlyingHomalgMatrix( i2 );
    i2_matrix_frob_power := FrobeniusPowerOfMatrix( i2_matrix, power );

    if left then
      frob_power_i2 := DeduceMapFromMatrixAndRangeLeft( i2_matrix_frob_power, Range( i2 ) );
    else
      frob_power_i2 := DeduceMapFromMatrixAndRangeRight( i2_matrix_frob_power, Range( i2 ) );
    fi;

    # compute mu' and mu''
    mu_prime := Colift( i1, PreCompose( UnderlyingMorphism( presentation_morphism ), i2 ) );
    mu_prime_prime := Lift( PreCompose( frob_power_i1, mu_prime ), frob_power_i2 );

    # compute kernel embeddings and corresponding objects
    new_source := CAPPresentationCategoryObject( KernelEmbedding( frob_power_i1 ) );
    new_range := CAPPresentationCategoryObject( KernelEmbedding( frob_power_i2 ) );

    # and return the final morphism
    return CAPPresentationCategoryMorphism( new_source, 
                                            mu_prime_prime, 
                                            new_range,
                                            CapCategory( new_source )!.constructor_checks_wished
                                           );

end );

# Frobenius power of a module presentation morphism with given source and range powers
InstallMethod( FrobeniusPowerWithGivenSourceAndRangePowers,
               "Frobenius powers of presentation morphism",
               [ IsGradedLeftOrRightModulePresentationMorphismForCAP, IsInt,
                 IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP ],
  function( presentation_morphism, power, source_power, range_power )
    local left, i1, frob_power_i1, i2, frob_power_i2, mu_prime, mu_prime_prime;

    # look at the following diagram:
    # R_A                              R_B
    #  |                    		|
    # alpha                	       beta
    #  |                    		|
    #  v                    		v
    #  A -------------- mu -----------> B
    #  |                    		|
    #  i1                   	        i2
    #  |                    		|
    #  V                    		v
    # X_A ------------ mu' ----------> X_B
    #  ^                    		^
    #  |                    		|
    # FrobPower( i1 )     	   FrobPower( i2 )
    #  |                    		|
    #  A'------------  mu'' ----------> B'
    #  ^                    		^
    #  |                    		|
    # Ker( FrobPower( i1 )) 	Ker( FrobPower( i2 ) )
    #  |                    		|
    # R_A'                 		R_B'
    #
    # The presentation morphism mu is the input and has alpha, beta as source and range respectively.
    #
    # In this diagram i1 and i2 are the respective 'EmbeddingInProjectiveModule', which happen to be the cokernel mappings
    # of alpha and beta. Therefore we can compute the induced mapping mu' between the cokernel modules.
    #
    # The lower half of the diagram then describes the Frobenius powers of source and range of mu. We then compute mu''
    # from FrobPower( i1), mu' and FrobPower( i2 ) via a (co)lift.

    # are we working with left or right presentations?
    left := IsGradedLeftModulePresentationMorphismForCAP( presentation_morphism );

    # check for valid input
    if left <> IsGradedLeftModulePresentationForCAP( source_power ) then
      Error( "Source power, range power and the given presentation morphism must all be left or all be right" );
      return;
    elif left <> IsGradedLeftModulePresentationForCAP( range_power ) then
      Error( "Source power, range power and the given presentation morphism must all be left or all be right" );
      return;
    fi;

    # compute i1, FrobPower( i1 ), i2, FrobPower( i2 )
    i1 := CokernelProjection( UnderlyingMorphism( Source( presentation_morphism ) ) );
    frob_power_i1 := CokernelProjection( UnderlyingMorphism( source_power ) );

    i2 := CokernelProjection( UnderlyingMorphism( Range( presentation_morphism ) ) );
    frob_power_i2 := CokernelProjection( UnderlyingMorphism( range_power ) );

    # compute mu' and mu''
    mu_prime := Colift( i1, PreCompose( UnderlyingMorphism( presentation_morphism ), i2 ) );
    mu_prime_prime := Lift( PreCompose( frob_power_i1, mu_prime ), frob_power_i2 );

    # and return the final morphism
    return CAPPresentationCategoryMorphism( source_power,
                                            mu_prime_prime,
                                            range_power,
                                            CapCategory( source_power )!.constructor_checks_wished
                                           );

end );

# a function that computes the Frobenius power functor for both left and right presentations
InstallGlobalFunction( FrobeniusPowerFunctor,
  function( graded_ring, power, left )
    local rank, i, category, functor;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if power < 0  then

      Error( "Power must be non-negative" );
      return;

    fi;

    # next compute the category under consideration
    if left = true then    
      category := SfpgrmodLeft( graded_ring );
    else
      category := SfpgrmodRight( graded_ring );
    fi;

    # then initialise the functor
    functor := CapFunctor(
                      Concatenation( "Frobenius functor for ", Name( category ), " to the power ", String( power ) ), 
                      category,
                      category
                      );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

        return FrobeniusPower( object, power );

    end );

    # and on morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

        return FrobeniusPowerWithGivenSourceAndRangePowers( morphism, power, new_source, new_range );

    end );

    # finally return the functor
    return functor;

end );

# functor to compute the p-th Frobenius power of left presentations
InstallMethod( FrobeniusPowerFunctorLeft,
               [ IsHomalgGradedRing, IsInt ],
      function( graded_ring, power )

        return FrobeniusPowerFunctor( graded_ring, power, true );

end );

# functor to compute the p-th Frobenius power of right presentations
InstallMethod( FrobeniusPowerFunctorRight,
               [ IsHomalgGradedRing, IsInt ],
      function( graded_ring, power )

        return FrobeniusPowerFunctor( graded_ring, power, false );

end );