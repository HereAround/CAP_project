####################################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter Tools
##
####################################################################################



####################################################################################
##
#! @Section Saturation
##
####################################################################################

# Saturate the first object with respect to the second object (if the second can be viewed as ideal)
InstallMethod( Saturate,
               "Saturate the first object with respect to the second",
               [ IsGradedLeftModulePresentationForCAP, IsGradedLeftIdealForCAP ],
  function( module, ideal )
    local ideal_embedding, homalg_graded_ring, homalg_graded_ring_module, module_saturated, buffer_mapping;

    # first check that the second object is indeed an ideal
    ideal_embedding := EmbeddingInSuperObjectForCAP( ideal );
    homalg_graded_ring := HomalgGradedRing( ideal );
    if not IsIdenticalObj( UnderlyingHomalgGradedRing( UnderlyingMorphism( module ) ), homalg_graded_ring ) then

      Error( "The module and ideal must be defined over the same homalg_graded_ring" );
      return;

    fi;

    # save the image of the ideal_embedding
    homalg_graded_ring_module := Range( ideal_embedding );

    # now compute the saturation
    module_saturated := module;
    buffer_mapping := InternalHomOnMorphisms( ideal_embedding, IdentityMorphism( module_saturated ) );
    buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), buffer_mapping );

    while not IsIsomorphism( buffer_mapping ) do

      module_saturated := InternalHomOnObjects( homalg_graded_ring_module ,
                                                InternalHomOnObjects( PresentationForCAP( ideal ), module_saturated ) 
                                               );
      module_saturated := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), module_saturated );
      buffer_mapping := InternalHomOnMorphisms( ideal_embedding, IdentityMorphism( module_saturated ) );
      buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), buffer_mapping );
    
    od;
    
    # finally return the satured module
    return module_saturated;

end );

InstallMethod( Saturate,
               "Saturate the first object with respect to the second",
               [ IsGradedLeftSubmoduleForCAP, IsGradedLeftIdealForCAP ],
  function( submodule, ideal )

    return Saturate( PresentationForCAP( submodule ), ideal );

end );

# Saturate the first object with respect to the second object (if the second can be viewed as ideal)
InstallMethod( Saturate,
               "Saturate the first object with respect to the second",
               [ IsGradedRightModulePresentationForCAP, IsGradedRightIdealForCAP ],
  function( module, ideal )
    local ideal_embedding, homalg_graded_ring, homalg_graded_ring_module, module_saturated, buffer_mapping;

    # first check that the second object is indeed an ideal
    ideal_embedding := EmbeddingInSuperObjectForCAP( ideal );
    homalg_graded_ring := HomalgGradedRing( ideal );
    if not IsIdenticalObj( UnderlyingHomalgGradedRing( UnderlyingMorphism( module ) ), homalg_graded_ring ) then

      Error( "The module and ideal must be defined over the same homalg_graded_ring" );
      return;

    fi;

    # save the image of the ideal_embedding
    homalg_graded_ring_module := Range( ideal_embedding );

    # now compute the saturation
    module_saturated := module;
    buffer_mapping := InternalHomOnMorphisms( ideal_embedding, IdentityMorphism( module_saturated ) );
    buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsRight( homalg_graded_ring ), buffer_mapping );

    while not IsIsomorphism( buffer_mapping ) do

      module_saturated := InternalHomOnObjects( homalg_graded_ring_module ,
                                                InternalHomOnObjects( PresentationForCAP( ideal ), module_saturated ) 
                                               );
      module_saturated := ApplyFunctor( FunctorLessGradedGeneratorsRight( homalg_graded_ring ), module_saturated );
      buffer_mapping := InternalHomOnMorphisms( ideal_embedding, IdentityMorphism( module_saturated ) );
      buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsRight( homalg_graded_ring ), buffer_mapping );

    od;

    # finally return the satured module
    return module_saturated;

end );

InstallMethod( Saturate,
               "Saturate the first object with respect to the second",
               [ IsGradedRightSubmoduleForCAP, IsGradedRightIdealForCAP ],
  function( submodule, ideal )

    return Saturate( PresentationForCAP( submodule ), ideal );

end );

# Compute the embedding of the first object into its saturation with respect to the given ideal
InstallMethod( EmbeddingInSaturationOfGradedModulePresentation,
               "Compute embedding of first object into its saturation with respect to the second object",
               [ IsGradedLeftModulePresentationForCAP, IsGradedLeftIdealForCAP ],
  function( module, ideal )

    local ideal_embedding, homalg_graded_ring, homalg_graded_ring_module, module_saturated, embedding, buffer_mapping;

    # first check that the second object is indeed an ideal
    ideal_embedding := EmbeddingInSuperObjectForCAP( ideal );
    homalg_graded_ring := HomalgGradedRing( ideal );
    if not IsIdenticalObj( UnderlyingHomalgGradedRing( UnderlyingMorphism( module ) ), homalg_graded_ring ) then

      Error( "The module and ideal need to be defined over the same homalg_graded_ring" );
      return;

    fi;

    # save the image of the ideal_embedding
    homalg_graded_ring_module := Range( ideal_embedding );

    # now compute the saturation    
    embedding := IdentityMorphism( module );
    module_saturated := Range( embedding );

    buffer_mapping := InternalHomOnMorphisms( ideal_embedding, IdentityMorphism( module_saturated ) );
    #buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), buffer_mapping );
    buffer_mapping := ApplyFunctor( FunctorGradedStandardModuleLeft( homalg_graded_ring ), buffer_mapping );

    while not IsIsomorphism( buffer_mapping ) do

      embedding := PreCompose( embedding, 
                               InternalHomOnMorphisms( IdentityMorphism( homalg_graded_ring_module ), buffer_mapping ) );

      module_saturated := Range( embedding );

      buffer_mapping := InternalHomOnMorphisms( ideal_embedding, IdentityMorphism( module_saturated ) );
      #buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), buffer_mapping );
      buffer_mapping := ApplyFunctor( FunctorGradedStandardModuleLeft( homalg_graded_ring ), buffer_mapping );        

    od;

    # finally return the satured module
    return embedding;

end );

InstallMethod( EmbeddingInSaturationOfGradedModulePresentation,
               "Compute embedding of first object into its saturation with respect to the second object",
               [ IsGradedLeftSubmoduleForCAP, IsGradedLeftIdealForCAP ],
  function( submodule, ideal )

    return EmbeddingInSaturationOfGradedModulePresentation( PresentationForCAP( submodule ), ideal );

end );

# Compute the embedding of the first object into its saturation with respect to the given ideal
InstallMethod( EmbeddingInSaturationOfGradedModulePresentation,
               "Compute embedding of first object into its saturation with respect to the second object",
               [ IsGradedRightModulePresentationForCAP, IsGradedRightIdealForCAP ],
  function( module, ideal )

    local ideal_embedding, homalg_graded_ring, homalg_graded_ring_module, module_saturated, embedding, buffer_mapping;

    # check that the module and the ideal are defined over the same ring
    ideal_embedding := EmbeddingInSuperObjectForCAP( ideal );
    homalg_graded_ring := UnderlyingHomalgGradedRing( UnderlyingMorphism( ideal ) );
    if not IsIdenticalObj( UnderlyingHomalgGradedRing( UnderlyingMorphism( module ) ), homalg_graded_ring ) then

      Error( "The module and ideal need to be defined over the same homalg_graded_ring" );
      return;

    fi;

    # save the image of the ideal_embedding
    homalg_graded_ring_module := Range( ideal_embedding );

    # now compute the saturation    
    embedding := IdentityMorphism( module );
    module_saturated := Range( embedding );
    
    buffer_mapping := InternalHomOnMorphisms( ideal_embedding, IdentityMorphism( module_saturated ) );
    #buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), buffer_mapping );
    buffer_mapping := ApplyFunctor( FunctorGradedStandardModuleLeft( homalg_graded_ring ), buffer_mapping );

    while not IsIsomorphism( buffer_mapping ) do

      embedding := PreCompose( embedding, 
                               InternalHomOnMorphisms( IdentityMorphism( homalg_graded_ring_module ), buffer_mapping ) );

      module_saturated := Range( embedding );

      buffer_mapping := InternalHomOnMorphisms( ideal_embedding, IdentityMorphism( module_saturated ) );
      #buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), buffer_mapping );
      buffer_mapping := ApplyFunctor( FunctorGradedStandardModuleLeft( homalg_graded_ring ), buffer_mapping );        

    od;

    # finally return the satured module
    return embedding;

end );

InstallMethod( EmbeddingInSaturationOfGradedModulePresentation,
               "Compute embedding of first object into its saturation with respect to the second object",
               [ IsGradedRightSubmoduleForCAP, IsGradedRightIdealForCAP ],
  function( submodule, ideal )

    return EmbeddingInSaturationOfGradedModulePresentation( PresentationForCAP( submodule ), ideal );

end );



####################################################################################
##
##  Section Embeddings in projective modules
##
####################################################################################

# represent ideal of graded ring as graded left-presentation
InstallMethod( EmbeddingInProjectiveObject,
               "for a graded module presentation",
               [ IsGradedLeftOrRightModulePresentationForCAP ],
  function( presentation_object )
    local cokernel_projection, range_object;

    # compute the cokernel projection of the presentation_object
    cokernel_projection := CokernelProjection( UnderlyingMorphism( presentation_object ) );

    # we are thus looking at the following diagram:
    #
    # presentation_object_source ----- zero_morphism -------------- 0
    #            |                                                  |
    # underlying_morphism                                    zero_morphism
    #            |                                                  |
    #            v                                                  v
    # presentation_object_range ---- cokernel_projection ----> cokernel_object
    #
    # the right column is the projective_module that we embed the left column into

    range_object := CAPPresentationCategoryObject( 
                         ZeroMorphism( ZeroObject( CapCategory( cokernel_projection ) ), Range( cokernel_projection ) ) );

    return CAPPresentationCategoryMorphism( presentation_object,
                                            cokernel_projection,
                                            range_object,
                                            CapCategory( presentation_object )!.constructor_checks_wished
                                           );

end );



####################################################################################
##
#! @Section Minimal free resolutions
##
####################################################################################

# compute a minimal free resolution of a graded module presentation
InstallMethod( MinimalFreeResolutionForCAP,
               "for a CAPPresentationCategoryObject",
               [ IsGradedLeftOrRightModulePresentationForCAP ],
  function( presentation_object )
    local proj_category, left, morphisms, new_mapping_matrix, buffer_mapping, kernel_matrix, i, pos;

    # gather necessary information
    proj_category := CapCategory( UnderlyingMorphism( presentation_object ) );
    left := IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( UnderlyingMorphism( presentation_object ) );

    # initialise morphisms
    morphisms := [];

    # use a presentation that does not contain units -> minimal (!) resolution
    if left then
      new_mapping_matrix := ReducedBasisOfRowModule( UnderlyingHomalgMatrix( 
                                                                          UnderlyingMorphism( presentation_object ) ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeLeft( new_mapping_matrix, 
                                                                    Range( UnderlyingMorphism( presentation_object ) ) );
    else
      new_mapping_matrix := ReducedBasisOfColumnModule( UnderlyingHomalgMatrix(
                                                                           UnderlyingMorphism( presentation_object ) ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeRight( new_mapping_matrix, 
                                                                    Range( UnderlyingMorphism( presentation_object ) ) );
    fi;

    # and use this mapping as the first morphisms is the minimal free resolution
    Add( morphisms, buffer_mapping );

    # now compute "reduced" kernels
    if left then
      kernel_matrix := ReducedSyzygiesOfRows( UnderlyingHomalgMatrix( morphisms[ 1 ] ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeLeft( kernel_matrix, Source( morphisms[ 1 ] ) );      
    else
      kernel_matrix := ReducedSyzygiesOfColumns( UnderlyingHomalgMatrix( morphisms[ 1 ] ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeRight( kernel_matrix, Source( morphisms[ 1 ] ) );
    fi;

    # as long as the kernel is non-zero
    while not IsZeroForMorphisms( buffer_mapping ) do

      # add the corresponding kernel embedding
      Add( morphisms, buffer_mapping );

      # and compute the next kernel_embedding
      if left then
        kernel_matrix := ReducedSyzygiesOfRows( UnderlyingHomalgMatrix( buffer_mapping ) );
        buffer_mapping := DeduceMapFromMatrixAndRangeLeft( kernel_matrix, Source( buffer_mapping ) );
      else
        kernel_matrix := ReducedSyzygiesOfColumns( UnderlyingHomalgMatrix( buffer_mapping ) );
        buffer_mapping := DeduceMapFromMatrixAndRangeRight( kernel_matrix, Source( buffer_mapping ) );
      fi;

    od;

    # and return the corresponding complex
    return ComplexFromMorphismList( morphisms );

end );

# compute a minimal free resolution of a graded module presentation
InstallMethod( MinimalFreeResolutionForCAP,
               "for a CAPPresentationCategoryObject",
               [ IsGradedLeftOrRightSubmoduleForCAP and IsGradedLeftOrRightModulePresentationForCAP ],
  function( submodule_for_CAP )

    return MinimalFreeResolutionForCAP( PresentationForCAP( submodule_for_CAP ) );

end );



####################################################################################
##
#! @Section Full information about complex
##
####################################################################################

# compute a minimal free resolution of a graded module presentation
InstallMethod( FullInformation,
               "for a complex",
               [ IsCapComplex ],
  function( cocomplex )
    local differential_function, pos;

    # extract the differentials
    differential_function := UnderlyingZFunctorCell( cocomplex )!.differential_func;

    # start to print information
    pos := -1;
    
    while not IsZeroForObjects( Source( differential_function( pos ) ) ) do
    
      # print information
      Print( String( DegreeList( Range( differential_function( pos ) ) ) ) );
      Print( "\n" );
      Print( " ^ \n" );
      Print( " | \n" );
      Display( UnderlyingHomalgMatrix( differential_function( pos ) ) );
      Print( " | \n" );
      
      # increment
      pos := pos - 1;
    
    od;
    
    Print( String( DegreeList( Range( differential_function( pos ) ) ) ) );
    Print( "\n \n" );

end );



####################################################################################
##
#! @Section Betti tables
##
####################################################################################

# compute a minimal free resolution of a graded module presentation
InstallMethod( BettiTableForCAP,
               "for a CAPPresentationCategoryObject",
               [ IsGradedLeftOrRightModulePresentationForCAP ],
  function( presentation_object )
    local proj_category, left, betti_table, new_mapping_matrix, buffer_mapping, kernel_matrix, i, pos;

    # gather necessary information
    proj_category := CapCategory( UnderlyingMorphism( presentation_object ) );
    left := IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( UnderlyingMorphism( presentation_object ) );

    # initialise morphisms
    betti_table := [];

    # use a presentation that does not contain units -> minimal (!) resolution          

    if left then
      new_mapping_matrix := ReducedBasisOfRowModule( UnderlyingHomalgMatrix( 
                                                                          UnderlyingMorphism( presentation_object ) ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeLeft( new_mapping_matrix, 
                                                                    Range( UnderlyingMorphism( presentation_object ) ) );
    else
      new_mapping_matrix := ReducedBasisOfColumnModule( UnderlyingHomalgMatrix( 
                                                                           UnderlyingMorphism( presentation_object ) ) );      
      buffer_mapping := DeduceMapFromMatrixAndRangeRight( new_mapping_matrix, 
                                                                    Range( UnderlyingMorphism( presentation_object ) ) );
    fi;

    # and use this mapping as the first morphisms is the minimal free resolution
    Add( betti_table, - UnzipDegreeList( Range( buffer_mapping ) ) );
    
    # check if we are already done
    if IsZeroForObjects( Source( buffer_mapping ) ) then
      return betti_table;
    fi;
    
    # otherwise add the source and compute the next mapping
    Add( betti_table, - UnzipDegreeList( Source( buffer_mapping ) ) );

    # now compute "reduced" kernels
    if left then
      kernel_matrix := ReducedSyzygiesOfRows( UnderlyingHomalgMatrix( buffer_mapping ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeLeft( kernel_matrix, Source( buffer_mapping ) );
    else
      kernel_matrix := ReducedSyzygiesOfColumns( UnderlyingHomalgMatrix( buffer_mapping ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeRight( kernel_matrix, Source( buffer_mapping ) );
    fi;

    # as long as the kernel is non-zero
    while not IsZeroForObjects( Source( buffer_mapping ) ) do

      # add the corresponding kernel embedding
      Add( betti_table, - UnzipDegreeList( Source( buffer_mapping ) ) );

      # and compute the next kernel_embedding
      if left then
        kernel_matrix := ReducedSyzygiesOfRows( UnderlyingHomalgMatrix( buffer_mapping ) );
        buffer_mapping := DeduceMapFromMatrixAndRangeLeft( kernel_matrix, Source( buffer_mapping ) );
      else
        kernel_matrix := ReducedSyzygiesOfColumns( UnderlyingHomalgMatrix( buffer_mapping ) );
        buffer_mapping := DeduceMapFromMatrixAndRangeRight( kernel_matrix, Source( buffer_mapping ) );
      fi;

    od;

    # and return the Betti table
    return betti_table;

end );

InstallMethod( BettiTableForCAP,
               "for a graded submodule",
               [ IsGradedLeftOrRightSubmoduleForCAP ],
  function( submodule )
  
    return BettiTableForCAP( PresentationForCAP( submodule ) );

end );