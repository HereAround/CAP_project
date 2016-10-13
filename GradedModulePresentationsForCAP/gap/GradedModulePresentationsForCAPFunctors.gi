#############################################################################
##
## GradedModulePresentationsForCAP
##
## Copyright 2016,  Martin Bies,       ITP Heidelberg
##
## Chapter Functors for graded module presentations for CAP
##
#############################################################################



################################################
##
## Section Functor LessGenerators
##
################################################

# Here we make use of the function 'SimplerEquivalentMatrix' from MatricesForHomalg, Basic.gi
# This function accepts a matrix M and produces a simpler matrix M2 from it. Optionally it can compute matrices
# U, UI, V and VI such that the following holds true:
# M * V = UI * M2 and U * M = M2 * VI
# For left-modules (R -M-> G and R2 -M2-> G2) this corresponds to having the following commutative diagrams:

# R --- UI ---> R2               R <--- U ---- R2
# |             |                |             |
# M             M2               M             M2
# |             |                |             |
# v             v                v             v
# G --- V ----> G2               G <--- VI --- G2

# and for right-modules to the diagram

# R --- VI ---> R2               R <--- V ---- R2
# |             |                |             |
# M             M2               M             M2
# |             |                |             |
# v             v                v             v
# G --- U ----> G2               G <--- UI --- G2

# So if we want to describe the transformation from the origional module into a simpler module we wish to compute
# left-modules: V (and VI)
# right-modules: U ( and UI)

# This is achieved from the following code (initialise V, VI, U and UI as HomalgVoidMatrices first)
# left-modules: SimplerEquivalentMatrix( M, V, VI, "", "" );
# right-modules: SimplerEquivalentMatrix( M, U, UI, "", "", "" );
# Note the different number of empty strings in this function - this is crucial!

# That said, we have the following methods

# FIXME: Why are U,UI,V and VI homogeneous?
InstallMethod( LessGradedGeneratorsTransformationTripleLeft,
               [ IsHomalgMatrix ],
  function( matrix )
    local V, VI, smaller_matrix;

    # initialise the transformation matrices
    V := HomalgVoidMatrix( HomalgRing( matrix ) );
    VI := HomalgVoidMatrix( HomalgRing( matrix ) );

    # compute M' and thereby set values for T and T^{-1}
    smaller_matrix := SimplerEquivalentMatrix( matrix, V, VI, "", "" );

    # return the triple of desired information
    return [ smaller_matrix, V, VI ];

end );

##
InstallMethod( LessGradedGeneratorsTransformationTripleRight,
               [ IsHomalgMatrix ],
  function( matrix )
    local U, UI, smaller_matrix;

    # initialise the transformation matrices
    U := HomalgVoidMatrix( HomalgRing( matrix ) );
    UI := HomalgVoidMatrix( HomalgRing( matrix ) );

    # compute M' and thereby set values for T and T^{-1}
    smaller_matrix := SimplerEquivalentMatrix( matrix, U, UI, "", "", "" );

    # return the triple of desired information
    return [ smaller_matrix, U, UI ];

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

      TI := LessGradedGeneratorsTransformationTripleLeft(
                UnderlyingHomalgMatrix( UnderlyingMorphism( module_presentation ) ) )[ 3 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeLeft(
                                 TI, Range( UnderlyingMorphism( module_presentation ) ) ) );
      Mprime := ReducedSyzygiesOfRows( TI, UnderlyingHomalgMatrix( UnderlyingMorphism( module_presentation ) ) );
      return CAPPresentationCategoryObject( DeduceMapFromMatrixAndRangeLeft( Mprime, range_prime ) );

    else

      TI := LessGradedGeneratorsTransformationTripleRight(
                UnderlyingHomalgMatrix( UnderlyingMorphism( module_presentation ) ) )[ 3 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeRight( 
                                 TI, Range( UnderlyingMorphism( module_presentation ) ) ) );
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
    if IsGradedLeftModulePresentationMorphismForCAP( morphism ) then
      source_transformation_triple := LessGradedGeneratorsTransformationTripleLeft(
                                        UnderlyingHomalgMatrix( UnderlyingMorphism( Source( morphism ) ) ) );
      range_transformation_triple := LessGradedGeneratorsTransformationTripleLeft(
                                        UnderlyingHomalgMatrix( UnderlyingMorphism( Range( morphism ) ) ) );
    else
      source_transformation_triple := LessGradedGeneratorsTransformationTripleRight(
                                        UnderlyingHomalgMatrix( UnderlyingMorphism( Source( morphism ) ) ) );
      range_transformation_triple := LessGradedGeneratorsTransformationTripleRight(
                                        UnderlyingHomalgMatrix( UnderlyingMorphism( Range( morphism ) ) ) );
    fi;

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
    local category, functor;

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



############################################################################################################
##
#! @Section Overwrite the preinstalled version of EmbeddingOfProjCategory defined by CAPPresentationCategory
##
############################################################################################################

# FIXME
# this is a hack thus far, would need to give the CAPCategoryOfProjectiveGradedLeftOrRightModulesObjects an atttribute, so that
# I can use this attribute as additional filter...
InstallMethod( EmbeddingOfProjCategory,
               [ IsCapCategory ], 999,
  function( projective_category )
    local pres_category, functor;

        # check for valid input
        if not IsProjCategory( projective_category ) then

          Error( "The input must be a Proj-category" );
          return;

        fi;

        # define the presentation category
        if IsCAPCategoryOfProjectiveGradedLeftModulesObject( ZeroObject( projective_category ) ) then
          pres_category := SfpgrmodLeft( UnderlyingHomalgGradedRing( ZeroObject( projective_category ) ) );
        elif IsCAPCategoryOfProjectiveGradedRightModulesObject( ZeroObject( projective_category ) ) then
          pres_category := SfpgrmodRight( UnderlyingHomalgGradedRing( ZeroObject( projective_category ) ) );
        else
          pres_category := PresentationCategory( projective_category );
        fi;

        # and set up the basics of this functor
        functor := CapFunctor( Concatenation( "Embedding of the projective category ", Name( projective_category ), 
                               " into its presentation category" ), 
                               projective_category, 
                               pres_category
                               );

        # now define the operation on the objects
        AddObjectFunction( functor,

          function( object )

            return CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( projective_category ),  object ) );

        end );

        # and the operation on the morphisms
        AddMorphismFunction( functor,

          function( new_source, morphism, new_range )

            return CAPPresentationCategoryMorphism( new_source, morphism, new_range, pres_category!.constructor_checks_wished );

        end );

        # and finally return this functor
        return functor;

end );