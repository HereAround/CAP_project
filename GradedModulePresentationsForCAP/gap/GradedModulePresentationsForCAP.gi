#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter The CAP category of graded module presentations for CAP
##
#############################################################################

######################################
##
## Section CAP categories
##
######################################

# compute the category S-fpgrmod for a toric variety
InstallMethod( SfpgrmodLeft,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )

    return PresentationCategory( CAPCategoryOfProjectiveGradedLeftModules( graded_ring ) );

end );

# compute the category S-fpgrmod for a toric variety
InstallMethod( SfpgrmodRight,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )

    return PresentationCategory( CAPCategoryOfProjectiveGradedRightModules( graded_ring ) );

end );



##############################################
##
## HOM-Embedding for convenience
##
##############################################

##
#InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT,
#                           [ IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP ],
#    function( a, b )
#      local source, range, underlying_map, final_mapping;

      # (1) construct the map
#      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
#                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
#                                                      UnderlyingMorphism( b ) )
#                                                      );
#      range := CAPPresentationCategoryObject( TensorProductOnMorphisms( 
#                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ),
#                                                      UnderlyingMorphism( b ) )
#                                                      );
#      underlying_map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( a ) ), 
#                                                 IdentityMorphism( Range( UnderlyingMorphism( b ) ) )
#                                                );
#      final_mapping := CAPPresentationCategoryMorphism( source,
#                                                        underlying_map,
#                                                        range,
#                                                        CapCategory( a )!.constructor_checks_wished 
#                                                       );

      # (2) and return its kernel embedding
#      return KernelEmbedding( final_mapping );

#end );