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

##############################################
##
## HOM-Embedding for convenience
##
##############################################

##
InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT,
                           [ IsGradedLeftModulePresentationForCAP, IsGradedLeftModulePresentationForCAP ],
    function( a, b )
      local range_kernel_embedding, M1, M2, emb_matrix, emb_map, source_matrix, source_kernel_embedding;

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
      # the idea is to compute the morphism on the left and the matrices M_1 = alpha^v \otimes id_B and
      # M2 = id_{R_A^v} \otimes beta, but not the tensor products on the right.
      # Then compute SyzygiesOfRows( M1, M2 ). This matrix encodes how the generators are embedded into A^v \otimes B.
      # -> Deduce map from this matrix.
      # Then take the pullback of that matrix and id_{A^v} \otimes beta, which defines the source of the embedding.

      # to simplify matters further we use "ReducedSyzygiesOfRows - this means that we apply the "StandardModule" functor
      # at the same time

      # compute all the necessary ingredients
      range_kernel_embedding := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      M1 := KroneckerMat( Involution( UnderlyingHomalgMatrix( UnderlyingMorphism( a ) ) ),
                              HomalgIdentityMatrix( Rank( Range( UnderlyingMorphism( b ) ) ),
                                                    UnderlyingHomalgGradedRing( UnderlyingMorphism( b ) ) ) 
                             );
      M2 := KroneckerMat( HomalgIdentityMatrix( Rank( Source( UnderlyingMorphism( a ) ) ),
                                                    UnderlyingHomalgGradedRing( UnderlyingMorphism( a ) ) ),
                              UnderlyingHomalgMatrix( UnderlyingMorphism( b ) )
                             );
      emb_matrix := ReducedSyzygiesOfRows( M1, M2 );
      emb_map := DeduceMapFromMatrixAndRangeLeft( emb_matrix, Range( UnderlyingMorphism( range_kernel_embedding ) ) );
      source_matrix := ReducedSyzygiesOfRows( emb_matrix, 
                                              UnderlyingHomalgMatrix( UnderlyingMorphism( range_kernel_embedding ) ) );
      source_kernel_embedding := CAPPresentationCategoryObject(
                                                   DeduceMapFromMatrixAndRangeLeft( source_matrix, Source( emb_map ) ) );

      # and finally return the map
      return CAPPresentationCategoryMorphism( source_kernel_embedding,
                                              emb_map,
                                              range_kernel_embedding,
                                              CapCategory( range_kernel_embedding )!.constructor_checks_wished
                                             );

end );

##
InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT,
                           [ IsGradedRightModulePresentationForCAP, IsGradedRightModulePresentationForCAP ],
    function( a, b )
      local range_kernel_embedding, M1, M2, emb_matrix, emb_map, source_matrix, source_kernel_embedding;

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
      # the idea is to compute the morphism on the left and the matrices M_1 = alpha^v \otimes id_B and
      # M2 = id_{R_A^v} \otimes beta, but not the tensor products on the right.
      # Then compute SyzygiesOfRows( M1, M2 ). This matrix encodes how the generators are embedded into A^v \otimes B.
      # -> Deduce map from this matrix.
      # Then take the pullback of that matrix and id_{A^v} \otimes beta, which defines the source of the embedding.

      # to simplify matters further we use "ReducedSyzygiesOfColumns - this means that we apply the "StandardModule" functor
      # at the same time
      
      # compute all the necessary ingredients
      range_kernel_embedding := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      M1 := KroneckerMat( Involution( UnderlyingHomalgMatrix( UnderlyingMorphism( a ) ) ),
                              HomalgIdentityMatrix( Rank( Range( UnderlyingMorphism( b ) ) ),
                                                    UnderlyingHomalgGradedRing( UnderlyingMorphism( b ) ) ) 
                             );
      M2 := KroneckerMat( HomalgIdentityMatrix( Rank( Source( UnderlyingMorphism( a ) ) ),
                                                    UnderlyingHomalgGradedRing( UnderlyingMorphism( a ) ) ),
                              UnderlyingHomalgMatrix( UnderlyingMorphism( b ) )
                             );
      emb_matrix := ReducedSyzygiesOfColumns( M1, M2 );
      emb_map := DeduceMapFromMatrixAndRangeRight( emb_matrix, Range( UnderlyingMorphism( range_kernel_embedding ) ) );
      source_matrix := ReducedSyzygiesOfColumns( emb_matrix, 
                                                 UnderlyingHomalgMatrix( UnderlyingMorphism( range_kernel_embedding ) ) );
      source_kernel_embedding := CAPPresentationCategoryObject(
                                                   DeduceMapFromMatrixAndRangeRight( source_matrix, Source( emb_map ) ) );

      # and finally return the map
      return CAPPresentationCategoryMorphism( source_kernel_embedding,
                                              emb_map,
                                              range_kernel_embedding,
                                              CapCategory( range_kernel_embedding )!.constructor_checks_wished
                                             );

end );