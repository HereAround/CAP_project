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

# a homogeneous homalg_matrix M with entries from S corresponds to a graded S-module map 
# module1 --- M ---> module2
# This method intends to simply this module presentation. To this end we look at the following diagram:
# module1 --- M ---> module2
#    |                   |
#    U                   T
#    |                   |
#    v                   v
# module1' --- M' ---> module2'
# U,T are ment to be invertible. Then the following method computes [ M', T, T^-1 ]

# FIXME FIXME: Why is T homogeneous?
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
        local transformation, TI, range_prime, Mprime, underlying_map;
             #Mprime, range_prime, underlying_map;

        # compute the transformation
        transformation := LessGradedGeneratorsTransformationTriple( UnderlyingHomalgMatrix( UnderlyingMorphism( object ) ) );
        TI := transformation[ 3 ];
        #Mprime := transformation[ 1 ];

        # recall that we look at the following diagram
        # Source( object) --- MappingMatrix( object ) ---> Range( object )
        #     |                                                   |
        #     ?                                                   T
        #     |                                                   |
        #     v                                                   v
        # Source( object' ) -- MappingMatrix( object' ) ---> Range( object' )

        # now deduce the bottom line
        if left = true then
          range_prime := Source( DeduceMapFromMatrixAndRangeLeft( TI, Range( UnderlyingMorphism( object ) ) ) );
          Mprime := ReducedSyzygiesOfRows( TI, UnderlyingHomalgMatrix( UnderlyingMorphism( object ) ) );
          underlying_map := DeduceMapFromMatrixAndRangeLeft( Mprime, range_prime );           
          #range_prime := Range( DeduceMapFromMatrixAndSourceLeft( T, Range( UnderlyingMorphism( object ) ) ) );
          #underlying_map := DeduceMapFromMatrixAndRangeLeft( Mprime, range_prime );
        else
          range_prime := Source( DeduceMapFromMatrixAndRangeRight( TI, Range( UnderlyingMorphism( object ) ) ) );
          Mprime := ReducedSyzygiesOfColumns( TI, UnderlyingHomalgMatrix( UnderlyingMorphism( object ) ) );
          underlying_map := DeduceMapFromMatrixAndRangeRight( Mprime, range_prime ); 
          #range_prime := Range( DeduceMapFromMatrixAndSourceRight( T, Range( UnderlyingMorphism( object ) ) ) );
          #underlying_map := DeduceMapFromMatrixAndRangeRight( Mprime, range_prime );
        fi;

        # and return the new object
        return CAPPresentationCategoryObject( underlying_map );

    end );

    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        local source_transformation_triple, range_transformation_triple, new_morphism_matrix, new_morphism;

        # compute the transformation of source and range
        source_transformation_triple := LessGradedGeneratorsTransformationTriple( 
                                                    UnderlyingHomalgMatrix( UnderlyingMorphism( Source( morphism ) ) ) );        
        range_transformation_triple := LessGradedGeneratorsTransformationTriple( 
                                                     UnderlyingHomalgMatrix( UnderlyingMorphism( Range( morphism ) ) ) );

        # compute the new mapping matrix
        new_morphism_matrix := UnderlyingHomalgMatrix( UnderlyingMorphism( morphism ) );
        if left then
          new_morphism_matrix := source_transformation_triple[ 3 ] * new_morphism_matrix * range_transformation_triple[ 2 ];
        else
          new_morphism_matrix := range_transformation_triple[ 2 ] * new_morphism_matrix * source_transformation_triple[ 3 ];
        fi;

        # wrap to form new_morphism
        new_morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( UnderlyingMorphism( new_source ) ),
                                                                                 new_morphism_matrix, 
                                                                                 Range( UnderlyingMorphism( new_range ) ) 
                                                                                );

        # and return the corresponding morphism
        return CAPPresentationCategoryMorphism( new_source, new_morphism, new_range );

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
    functor := CapFunctor( Concatenation( "Standard module for ", Name( category ) ), category, category );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )
        local matrix, new_underlying_morphism;

          # compute a new representation matrix
          matrix := BasisOfRowModule( UnderlyingHomalgMatrix( UnderlyingMorphism( object ) ) );

          # deduce new underlying morphism
          if left = true then
            new_underlying_morphism := DeduceMapFromMatrixAndRangeLeft( matrix, Range( UnderlyingMorphism( object ) ) );
          else
            new_underlying_morphism := DeduceMapFromMatrixAndRangeRight( matrix, Range( UnderlyingMorphism( object ) ) );
          fi;

          # and return the new object
          return CAPPresentationCategoryObject( new_underlying_morphism );

    end );

    # now define the functor operation on the morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        local new_underlying_morphism;

          # compute the new underlying morphism
          new_underlying_morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism(
                                                             Range( UnderlyingMorphism( new_source ) ),
                                                             UnderlyingHomalgMatrix( UnderlyingMorphism( morphism ) ),
                                                             Range( UnderlyingMorphism( new_range ) )
                                                         );

          # and return the corresponding morphism
          return CAPPresentationCategoryMorphism( new_source, new_underlying_morphism, new_range );

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



###############################################
##
## Section The truncation functor
##
###############################################

# this function computes the truncation functor for both left and right presentations
InstallGlobalFunction( TruncationFunctorToSemigroups,
  function( graded_ring, semigroup_generator_list, left )
    local rank, i, category, functor;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( graded_ring ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if the subsemigroup is contained in the DegreeGroup
    rank := Rank( DegreeGroup( graded_ring ) );
    if Length( UnderlyingList( semigroup_generator_list )[ 1 ] ) <> rank then

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
        local underlying_morphism;

        underlying_morphism := ProjectionInFactorOfFiberProduct( [ 
                                       EmbeddingOfTruncationOfProjectiveGradedModule( Range( UnderlyingMorphism( object ) ), 
                                                                                      semigroup_generator_list 
                                                                                     ),
                                       UnderlyingMorphism( object )
                                       ],
                                       1 
                                     );

          return CAPPresentationCategoryObject( underlying_morphism );

    end );

    # now define the functor operation on the morphisms
    # FIXME:
    # why is the returned morhpism always well-defined
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

        return CAPPresentationCategoryMorphism( new_source, underlying_morphism, new_range );

    end );

    # finally return the functor
    return functor;

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
    if Length( UnderlyingList( cone_hpresentation_list )[ 1 ] ) <> rank then

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
        local underlying_morphism;

        underlying_morphism := ProjectionInFactorOfFiberProduct( [ 
                                       EmbeddingOfTruncationOfProjectiveGradedModule( Range( UnderlyingMorphism( object ) ), 
                                                                                      cone_hpresentation_list 
                                                                                     ),
                                       UnderlyingMorphism( object )
                                       ],
                                       1 
                                     );

          return CAPPresentationCategoryObject( underlying_morphism );

    end );

    # now define the functor operation on the morphisms
    # FIXME:
    # why is the returned morphism always well-defined
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

        return CAPPresentationCategoryMorphism( new_source, underlying_morphism, new_range );

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

# functor to compute the truncation of left presentations
InstallMethod( TruncationFunctorLeft,
               [ IsHomalgGradedRing, IsConeHPresentationList ],
  function( graded_ring, cone_hpresentation_list )

    return TruncationFunctorToCones( graded_ring, cone_hpresentation_list, true );

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

# functor to compute the truncation of left presentations
InstallMethod( TruncationFunctorRight,
               [ IsHomalgGradedRing, IsConeHPresentationList ],
  function( graded_ring, cone_hpresentation_list )

    return TruncationFunctorToCones( graded_ring, cone_hpresentation_list, false );

end );


###############################################
##
#! @Section The Frobenius-power functor
##
###############################################

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
