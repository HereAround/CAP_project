#############################################################################
##
## TruncationsOfGradedModulePresentationsForCAP package
##
## Copyright 2016, Martin Bies,       ITP Heidelberg
##
## Chapter Natural transformations
##
#############################################################################


####################################################################################
##
## Section Natural transformation from truncation functor to identity functor
##
####################################################################################

# a function that computes the natural isomorphism 1 => StandardModule for both
# left and right presentations
InstallGlobalFunction( NaturalTransformationFromTruncationToIdentityForProjectiveGradedModules,
  function( graded_ring, semigroup_for_CAP, left )
    local rank, i, category, truncation_functor, natural_transformation;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( graded_ring ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if the cone_h_list is valid
    rank := Rank( DegreeGroup( graded_ring ) );
    if EmbeddingDimension( semigroup_for_CAP ) <> rank then

        Error( "The semigroup is not contained in the degree_group of the graded ring" );
        return;

    fi;

    # now construct the category and the respective truncation_functor    
    if left = true then
      category := CAPCategoryOfProjectiveGradedLeftModules( graded_ring );
      truncation_functor := TruncationFunctorForProjectiveGradedLeftModules( graded_ring, semigroup_for_CAP );
    else
      category := CAPCategoryOfProjectiveGradedRightModules( graded_ring );
      truncation_functor := TruncationFunctorForProjectiveGradedRightModules( graded_ring, semigroup_for_CAP );
    fi;

    # initialise the natural_transformation
    natural_transformation := NaturalTransformation( 
                                     Concatenation( "Natural transformation from ", Name( truncation_functor ), " to id" ),
                                     truncation_functor,
                                     IdentityMorphism( AsCatObject( category ) )
                                     );

    # add component of natural_transformation over object
    AddNaturalTransformationFunction( natural_transformation,
      function( truncated_object, object, identical_object )

        return EmbeddingOfTruncationOfProjectiveGradedModuleWithGivenTruncationObject( identical_object, truncated_object );

    end );

    # and finally return this transformation
    return natural_transformation;

end );

# natural isomorphism 1 => Standard module for left presentations
InstallMethod( NaturalTransformationFromTruncationToIdentityForProjectiveGradedLeftModules,
               [ IsHomalgGradedRing, IsSemigroupForGradedModulePresentationsForCAP ],
  function( graded_ring, semigroup_for_CAP )

    return NaturalTransformationFromTruncationToIdentityForProjectiveGradedModules( graded_ring, 
                                                                                    semigroup_for_CAP, true );

end );

# natural isomorphism 1 => Standard module for right presentations
InstallMethod( NaturalTransformationFromTruncationToIdentityForProjectiveGradedRightModules,
               [ IsHomalgGradedRing, IsSemigroupForGradedModulePresentationsForCAP ],
  function( graded_ring, semigroup_for_CAP )

    return NaturalTransformationFromTruncationToIdentityForProjectiveGradedModules( graded_ring, 
                                                                                    semigroup_for_CAP, false );

end );