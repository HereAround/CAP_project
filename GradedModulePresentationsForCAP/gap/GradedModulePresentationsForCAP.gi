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

#
InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT,
                           [ IsGradedLeftModulePresentationForCAP, IsGradedLeftModulePresentationForCAP ],
    function( a, b )
      local range, source, map, emb_matrix, emb_map, kernel_relations, kernel;

      # Let a = ( R_A --- alpha ---> A ) and b = (R_B --- beta ---> B ). Then we have to compute the kernel embedding of the
      # following map:
      #
      # A^v \otimes R_B -----------alpha^v \otimes id_{R_B} --------------> R_A^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{A^v} \otimes beta                                            id_{R_A^v} \otimes beta
      #       |                                                                      |
      #       v                                                                      v
      # A^v \otimes B -------------- alpha^v \otimes id_B -------------------> R_A^v \otimes B
      #

      # compute this map
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( a ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( b ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );

      # take a smaller presentation (if possible)
      map := ByASmallerPresentation( map );

      # and return its kernel embedding
      return KernelEmbedding( map );

end );

#
InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT,
                           [ IsGradedRightModulePresentationForCAP, IsGradedRightModulePresentationForCAP ],
    function( a, b )
      local range, source, map;

      # Let a = ( R_A --- alpha ---> A ) and b = (R_B --- beta ---> B ). Then we have to compute the kernel embedding of the
      # following map:
      #
      # A^v \otimes R_B -----------alpha^v \otimes id_{R_B} --------------> R_A^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{A^v} \otimes beta                                            id_{R_A^v} \otimes beta
      #       |                                                                      |
      #       v                                                                      v
      # A^v \otimes B -------------- alpha^v \otimes id_B -------------------> R_A^v \otimes B
      #

      # compute this map
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( a ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( b ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );

      # take a smaller presentation (if possible)
      map := ByASmallerPresentation( map );

      # and return its kernel embedding
      return KernelEmbedding( map );

end );