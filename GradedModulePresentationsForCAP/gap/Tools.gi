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
##  Section Frobenius powers of graded module presentations
##
####################################################################################

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

# install Frobenius power of a module presentation
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

# install Frobenius power of a module presentation morphism
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
    return CAPPresentationCategoryMorphism( new_source, mu_prime_prime, new_range );

end );

# install Frobenius power of a module presentation morphism
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
    return CAPPresentationCategoryMorphism( source_power, mu_prime_prime, range_power );

end );



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
    #buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), buffer_mapping );
    buffer_mapping := ApplyFunctor( FunctorGradedStandardModuleLeft( homalg_graded_ring ), buffer_mapping );
    while not IsIsomorphism( buffer_mapping ) do
    
      module_saturated := InternalHomOnObjects( homalg_graded_ring_module , 
                                                InternalHomOnObjects( PresentationForCAP( ideal ), module_saturated ) 
                                               );
      buffer_mapping := InternalHomOnMorphisms( ideal_embedding, IdentityMorphism( module_saturated ) );
      #buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), buffer_mapping );
      buffer_mapping := ApplyFunctor( FunctorGradedStandardModuleLeft( homalg_graded_ring ), buffer_mapping );        
    
    od;
    
    # finally return the satured module
    return module_saturated;

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
    #buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), buffer_mapping );
    buffer_mapping := ApplyFunctor( FunctorGradedStandardModuleLeft( homalg_graded_ring ), buffer_mapping );
    while not IsIsomorphism( buffer_mapping ) do
    
      module_saturated := InternalHomOnObjects( homalg_graded_ring_module , 
                                                InternalHomOnObjects( PresentationForCAP( ideal ), module_saturated ) 
                                               );
      buffer_mapping := InternalHomOnMorphisms( ideal_embedding, IdentityMorphism( module_saturated ) );
      #buffer_mapping := ApplyFunctor( FunctorLessGradedGeneratorsLeft( homalg_graded_ring ), buffer_mapping );
      buffer_mapping := ApplyFunctor( FunctorGradedStandardModuleLeft( homalg_graded_ring ), buffer_mapping );        
    
    od;
    
    # finally return the satured module
    return module_saturated;

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

# Compute the embedding of the first object into its saturation with respect to the given ideal
InstallMethod( EmbeddingInSaturationOfGradedModulePresentation,
               "Compute embedding of first object into its saturation with respect to the second object",
               [ IsGradedRightModulePresentationForCAP, IsGradedRightIdealForCAP ],
  function( module, ideal )

    local ideal_embedding, homalg_graded_ring, homalg_graded_ring_module, module_saturated, embedding, buffer_mapping;

    # first check that the second object is indeed an ideal
    ideal_embedding := EmbeddingInProjectiveObject( ideal );
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

    return CAPPresentationCategoryMorphism( presentation_object, cokernel_projection, range_object );

end );



####################################################################################
##
#! @Section Minimal free resolutions
##
####################################################################################

# compute a minimal free resolution of a graded module presentation
InstallMethod( MinimalFreeResolution,
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

    # and return the collection of morphisms
    # FIX ME: Complex or cocomplex?
    # return ComplexFromMorphismList( morphisms );
    return CocomplexFromMorphismList( morphisms );

end );

# compute a minimal free resolution of a graded module presentation
InstallMethod( MinimalFreeResolution,
               "for a CAPPresentationCategoryObject",
               [ IsGradedLeftOrRightSubmoduleForCAP and IsGradedLeftOrRightModulePresentationForCAP ],
  function( submodule_for_CAP )

    return MinimalFreeResolution( PresentationForCAP( submodule_for_CAP ) );

end );



####################################################################################
##
#! @Section Full information about (co)complex
##
####################################################################################

# compute a minimal free resolution of a graded module presentation
#InstallMethod( FullInformation,
#               "for a complex",
#               [ IsCapCocomplex ],
#  function( cocomplex )
#    local differential_function, test_object, pos;
#    
#    # extract the differentials
#    differential_function := UnderlyingZFunctorCell( cocomplex )!.differential_func;
#
    # start to print information
#    pos := 0;
    #test_object := Source( differential_function( pos ) );
    
#    while not IsZeroForObjects( Source( differential_function( pos ) ) ) do
    
      # print information
#      Print( String( DegreeList( Source( differential_function( pos ) ) ) ) );
#      Print( "\n \n" );
#      Display( UnderlyingHomalgMatrix( differential_function( pos ) ) );
#      Print( "\n" );
      
      # increment
#      pos := pos + 1;
      #test_object := Source( differential_function( pos ) );
    
#    od;
    
#    Print( String( DegreeList( Range( differential_function( pos ) ) ) ) );
#    Print( "\n \n" );
    
#end );