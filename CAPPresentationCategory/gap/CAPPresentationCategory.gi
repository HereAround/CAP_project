#############################################################################
##
## CAPPresentationCategory package
##
## Copyright 2016, Martin Bies,       ITP Heidelberg
##
## Chapter Installation of methods
##
#############################################################################

#####################
##
## Constructor
##
#####################

InstallMethod( PresentationCategory,
               [ IsCapCategory ],
  function( projective_category )
    local category;

    # (1) check if the input is a proj-category
    if not IsProjCategory( projective_category ) then

      Error( "The input must be a Proj-category" );
      return;

    fi;

    # (2) set the name of the category
    category := CreateCapCategory( Concatenation( "Presentation category over ", Name( projective_category ) ) );

    # (3) set properties of the category
    category!.underlying_projective_category := projective_category; # <- underlying Proj-category
    category!.constructor_checks_wished := true; # <- false means that no consistency checks are performed in construtors
    SetIsAbelianCategory( category, true );

    # (4) add basic functionality for the category
    ADD_BASIC_FUNCTIONS_FOR_PRESENTATION_CATEGORY( category, category!.constructor_checks_wished );

    # (5) check if the Proj-category also has a monoidal structure
    if IsMonoidalStructurePresent( projective_category ) then

      # install more functionality and more properties
      ADD_MONOIDAL_FUNCTIONS_FOR_PRESENTATION_CATEGORY( category, category!.constructor_checks_wished );
      SetIsSymmetricClosedMonoidalCategory( category, true );

      # check for strict monoidal structure
      if IsStrictMonoidalCategory( projective_category ) then
        SetIsStrictMonoidalCategory( category, true );
      fi;

    fi;

    # (6) add logic (FIXME: add more stuff to these files)
    AddTheoremFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "CAPPresentationCategory", "Logic" ),
        "Propositions.tex" )
    );
    AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "CAPPresentationCategory", "Logic" ),
        "PredicateImplications.tex" )
    );
    AddEvalRuleFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "CAPPresentationCategory", "Logic" ),
        "Relations.tex" )
    );

    # (7) finalise and return
    Finalize( category );
    return category;

end );



##############################################
##
## Install the basic functionality
##
##############################################

##
InstallGlobalFunction( ADD_BASIC_FUNCTIONS_FOR_PRESENTATION_CATEGORY,
  function( category, checks_wished )

  
  
    ######################################################################
    #
    # @Section Methods to check if objects and morphisms are well-defined
    #
    ######################################################################

    # @Description
    # Checks if the underlying morphism of <A>object</A> is well-defined in the Proj-category.
    # @Returns true or false
    # @Arguments object
    AddIsWellDefinedForObjects( category,
      function( object )
        
        return IsWellDefinedForMorphisms( UnderlyingMorphism( object ) );
        
    end );
    
    # @Description
    # This method first checks if the source and range of <A>morphism</A> are well-defined in the Proj-category.
    # Finally it is checked if also the underlying morphism of <A>morphism</A> is well-defined in the Proj-category.
    # @Returns true or false
    # @Arguments morphism
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        local lift;
        
        if not IsWellDefinedForMorphisms( UnderlyingMorphism( morphism ) ) then
        
          return false;
        
        fi;
        
        # check if a SourceLiftMorphism has been computed
        if not HasSourceLiftMorphism( morphism ) then
        
          # no SourceLiftMorphism has been computed thus far, so do it now 
          lift := SourceLiftMorphism( morphism );
          
          if lift = fail then
            
            # there is no such lift, thus the mapping is not well-defined and we should thus return fail
            return false;
        
          fi;
        
        elif SourceLiftMorphism( morphism ) = fail then
        
          # it has been tried to compute a SourceLiftMorphism, but this operation failed, so the morphism is 
          # not well-defined
          return false;
        
        fi;
        
        # otherwise all checks have been passed, so return true
        return true;
        
    end );
    
    

    ######################################################################
    #
    # @Section Implement the elementary operations for categories
    #
    ######################################################################

    # @Description
    # This method checks if the underlying morphisms of <A>object1</A> and <A>object2</A> are equal
    # in the underlying Proj-category.
    # @Returns true or false
    # @Arguments object1, object2
    AddIsEqualForObjects( category,

      function( object1, object2 )

        return IsEqualForMorphismsOnMor( UnderlyingMorphism( object1 ), UnderlyingMorphism( object2 ) );

    end );

    # @Description
    # This method checks if the underlying morphisms of <A>morphism1</A> and <A>morphism2</A> are equal
    # in the underlying Proj-category.
    # @Returns true or false
    # @Arguments morphism1, morphism2
    AddIsEqualForMorphisms( category,

      function( morphism1, morphism2 )

        return IsEqualForMorphismsOnMor( UnderlyingMorphism( morphism1 ), UnderlyingMorphism( morphism2 ) );        

    end );

    # @Description
    # This method implements congruence of two morphisms <A>morphism1</A> and <A>morphism2</A>. To decide congruence one looks at the
    # following diagram:
    # R_1 ------------> A
    #                   ^
    #                   |
    #          morphism1 - morphism2
    #                   |
    #                   |
    # R_2 ------------> B
    # We then look if we can find a lift $R_2 \to A$ (using methods of the underlying Proj-category).
    # If this is possible, then the morphisms are congruent and if not, they are not.
    # @Returns true or false
    # @Arguments morphism1, morphism2
    AddIsCongruentForMorphisms( category,

      function( morphism1, morphism2 )
        local lift, difference;

        difference := AdditionForMorphisms( AdditiveInverseForMorphisms( UnderlyingMorphism( morphism2 ) ),
                                                                                         UnderlyingMorphism( morphism1 ) );
        lift := Lift( difference, UnderlyingMorphism( Range( morphism1 ) ) );

        # if the lift exists, then the morphisms are congruent, so
        if lift = fail then

          return false;

        else

          return true;

        fi;

    end );

    # @Description
    # This method precomposes the morphims <A>left_morphism</A>: $s \to a$ and <A>right_morphism</A> $a \to r$ to a morphism $s \to r$.
    # To this end the precompose-method of the underlying Proj-category is used.
    # @Returns a morphism
    # @Arguments lef_morphism, right_morphism
    AddPreCompose( category,
      function( left_morphism, right_morphism )
        
        return CAPPresentationCategoryMorphism( 
                                     Source( left_morphism ),
                                     PreCompose( UnderlyingMorphism( left_morphism ), UnderlyingMorphism( right_morphism ) ),
                                     Range( right_morphism ),
                                     checks_wished
                                    );
        
    end );

    # @Description
    # This method installs the identity morphism of <A>object</A> by using the identity morphism operation of the underlying
    # Proj-category.
    # @Returns a morphism
    # @Arguments object
    AddIdentityMorphism( category,
      function( object )
        
        return CAPPresentationCategoryMorphism( object,
                                                IdentityMorphism( Range( UnderlyingMorphism( object ) ) ),
                                                object,
                                                checks_wished 
                                               );
        
    end );



    ######################################################################
    #
    # @Section Enrich the category with an additive structure
    #
    ######################################################################
    
    # @Description
    # This method adds the two morphisms <A>morphism1</A> and <A>morphism2</A> by using the addition of morphisms in the 
    # underlying Proj category.
    # @Returns a morphism
    # @Arguments morphism1, morphism2
    AddAdditionForMorphisms( category,
      function( morphism1, morphism2 )
        
        return CAPPresentationCategoryMorphism( 
                                    Source( morphism1 ),
                                    AdditionForMorphisms( UnderlyingMorphism( morphism1 ), UnderlyingMorphism( morphism2 ) ),
                                    Range( morphism2 ),
                                    checks_wished
                                   );

    end );

    # @Description
    # This method installs the additive inverse of a <A>morphism</A> by using the additive inverse of the underlying 
    #! morphism in the Proj-category.
    # @Returns a morphism
    # @Arguments morphism
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return CAPPresentationCategoryMorphism( 
                                           Source( morphism ),
                                           AdditiveInverseForMorphisms( UnderlyingMorphism( morphism ) ),
                                           Range( morphism ),
                                           checks_wished
                                          );
        
    end );
    
    # @Description
    # Given a <A>source</A> and a <A>range</A> object, this method constructs the zero morphism between these two objects.
    # To this end the zero morphism method of the underlying Proj-category is used.
    # @Returns a morphism
    # @Arguments source_object, range_object
    AddZeroMorphism( category,
      function( source_object, range_object )
        
        return CAPPresentationCategoryMorphism( source_object,
                      ZeroMorphism( Range( UnderlyingMorphism( source_object ) ), Range( UnderlyingMorphism( range_object ) ) ),
                      range_object,
                      checks_wished
                     );
        
    end );

    # @Description
    # This method installs the zero object of the presentation category by use of the zero object of the underlying
    # Proj-category.
    # @Returns an object
    # @Arguments 
    AddZeroObject( category,
      function( )
        local projective_category;

        projective_category := category!.underlying_projective_category;
        
        return CAPPresentationCategoryObject( IdentityMorphism( ZeroObject( projective_category ) ) );
        
    end );
    
    # @Description
    # This method installs the (unique) zero morphism from the object <A>object</A> to the zero object. The latter has to be 
    # given to this method for convenience (in the method installation called <A>terminal_object</A>). More convenient methods are 
    # derived from the CAP-kernel afterwards.
    # @Returns a morphism
    # @Arguments object, terminal_object
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
                                                                   
      function( object, terminal_object )

        return CAPPresentationCategoryMorphism( object,
                                                UniversalMorphismIntoZeroObject( Range( UnderlyingMorphism( object ) ) ),
                                                terminal_object,
                                                checks_wished 
                                               );
        
    end );

    # @Description
    # This method installs the (unique) zero morphism to the object <A>object</A> from the zero object. The latter has to be 
    # given to this method for convenience (in the method installation called <A>initial_object</A>). More convenient methods are 
    # derived from the CAP-kernel afterwards.
    # @Returns a morphism
    # @Arguments object, initial_object
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( object, initial_object )
        
        return CAPPresentationCategoryMorphism( initial_object,
                                                UniversalMorphismFromZeroObject( Range( UnderlyingMorphism( object ) ) ),
                                                object,
                                                checks_wished
                                               );
        
    end );

    # @Description
    # This method installs the direct sum of the list of objects <A>objects</A>. To this end the direct sum operation of the 
    # underlying Proj-category is used.
    # @Returns an object
    # @Arguments objects
    AddDirectSum( category,
                  
      function( objects )
        local source_objects, range_objects, directSum_of_range_objects, diagram, list_of_projections, morphism;

        # form lists of the sources and ranges, i.e. of objects in the underlying Proj-Category
        source_objects := List( [ 1 .. Length( objects ) ], k -> Source( UnderlyingMorphism( objects[ k ] ) ) );
        range_objects := List( [ 1 .. Length( objects ) ], k -> Range( UnderlyingMorphism( objects[ k ] ) ) );
        
        # take the direct sum of the source and range objects in the underlying Proj-Category
        directSum_of_range_objects := DirectSum( range_objects );
        
        # now construct the list of projections into the range_objects
        # (we will use these projections and the universal property of directSum2 to construct the map from
        # directSum1 -> directSum2 as the universal morphism into directSum2)
        list_of_projections := List( [ 1 .. Length( objects ) ], i ->  ProjectionInFactorOfDirectSum( source_objects, i ) );
        list_of_projections := List( [ 1 .. Length( objects ) ], 
                                         i -> PreCompose( list_of_projections[ i ], UnderlyingMorphism( objects[ i ] ) ) );        
        diagram := range_objects;
        morphism := UniversalMorphismIntoDirectSum( diagram, list_of_projections );

        # then return the corresponding object in the presentation category
        return CAPPresentationCategoryObject( morphism );
        
    end );

    # @Description
    # This methods adds the projection morphism from the direct sum object <A>direct_sum_object</A> formed from a list of objects
    # <A>objects</A> to its <A>component_number</A>-th factor. Again the methods of the underlying Proj-category are used.
    # @Returns a morphism
    # @Arguments objects, component_number, direct_sum_object   
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
                                                 
      function( objects, component_number, direct_sum_object )
        local range_objects, range_direct_sum_object, projection;
                
        # extract the range objects in the underlying projective category
        range_objects := List( [ 1 .. Length( objects ) ], i -> Range( UnderlyingMorphism( objects[ i ] ) ) );
        range_direct_sum_object := Range( UnderlyingMorphism( direct_sum_object ) );
        
        # now compute the projection of these objects in the underlying category
        projection := ProjectionInFactorOfDirectSum( range_objects, component_number );
        
        # and construct the projection the presentation category
        return CAPPresentationCategoryMorphism( direct_sum_object, 
                                                projection, 
                                                objects[ component_number ],
                                                checks_wished
                                               );
        
    end );

    # @Description
    # This method requires a list of objects <A>diagram</A> = (S_1,...,S_n), a list of morphisms <A>sink<A> (T -> S_i) and the 
    # direct sum object <A>direct_sum</A> $= \oplus S_i$. From this the universal morphism $T \to S$ is computed. Again this is based
    # on the corresponding methods of the underlying Proj-category.
    # @Returns a morphism
    # @Arguments diagram, sink, direct_sum
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local underlying_sink, diagram_ranges, underlying_morphism;
        
        # construct the morphism of the test_object_range into direct_sum_range via universal property
        underlying_sink := List( [ 1 .. Length( sink ) ], i -> UnderlyingMorphism( sink[ i ] ) );
        diagram_ranges := List( [ 1 .. Length( sink ) ], i -> Range( UnderlyingMorphism( sink[ i ] ) ) );
        underlying_morphism := UniversalMorphismIntoDirectSum( diagram_ranges, underlying_sink);

        # and construct the morphism in the presentation category
        return CAPPresentationCategoryMorphism( Source( sink[ 1 ] ),
                                                underlying_morphism,
                                                direct_sum,
                                                checks_wished
                                               );
        
    end );

    # @Description
    # This method adds the injection morphism from the <A>component_number<A>-th cofactor of the direct sum 
    # <A>coproduct_object</A> formed from the list of objects <A>objects</A>. It is based on the corresonding method of the 
    # Proj-category.
    # @Returns a morphism
    # @Arguments objects, component_number, coproduct_object
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( objects, component_number, coproduct_object )
        local range_objects, range_direct_sum_object, injection;

        # extract the range objects in the underlying projective category
        range_objects := List( [ 1 .. Length( objects ) ], i -> Range( UnderlyingMorphism( objects[ i ] ) ) );
        range_direct_sum_object := Range( UnderlyingMorphism( coproduct_object ) );
        
        # now compute the projection of these objects in the underlying category
        injection := InjectionOfCofactorOfDirectSum( range_objects, component_number );

        # and construct the projection the presentation category
        return CAPPresentationCategoryMorphism( objects[ component_number ],
                                                injection,
                                                coproduct_object,
                                                checks_wished
                                               );
        
    end );

    # @Description
    # This method requires a list of objects <A>diagram</A> = (S_1,...,S_n), a list of morphisms <A>sink<A> (S_i -> T) and the 
    # direct sum object <A>coproduct</A> $= \oplus S_i$. From this the universal morphism $S \to T$ is computed. Again this is based
    # on the corresponding methods of the underlying Proj-category.
    # @Returns a morphism
    # @Arguments diagram, sink, coproduct
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, coproduct )

        local underlying_sink, diagram_sources, underlying_morphism;

        # construct the morphism of the test_object_range into direct_sum_range via universal property
        underlying_sink := List( [ 1 .. Length( sink ) ], i -> UnderlyingMorphism( sink[ i ] ) );
        diagram_sources := List( [ 1 .. Length( sink ) ], i -> Source( UnderlyingMorphism( sink[ i ] ) ) );
        underlying_morphism := UniversalMorphismFromDirectSum( diagram_sources, underlying_sink );

        # and construct the morphism in the presentation category
         return CAPPresentationCategoryMorphism( coproduct,
                                                 underlying_morphism,
                                                 Range( sink[ 1 ] ),
                                                 checks_wished
                                                );

    end );



    ######################################################################
    #
    # @Section Add lift and colift
    #
    ######################################################################

    # @Description
    # This method requires a morphism <A>morphism1</A> $a \to c$ and a morphism <A>morphism2</A> $b \to c$. The result of 
    # Lift( morphism1, morphism2 ) is then the lift morphism $a \to b$.
    # @Returns a morphism
    # @Arguments morphism1, morphism2
    AddLift( category,
      function( morphism1, morphism2 )
        local A, R_C, psi, rho_C, psi_tilde, projection, lift;

        # look at the following diagram for morphism 2:
        # R_A                R_C
        #  |                  |
        #  |                  |rho_C
        #  v                  v
        #  A ----- psi -----> C
        #
        # from this we induce the following map
        #
        # R_A \oplus R_C                            R_C
        #       |                                    |
        #       |                                    |rho_C
        #       v                                    v
        #  A \oplus R_C ------- \tilde{\psi} ------> C
        #
        # then we compute the lift by use of \underlying_morphism( morphism1 ) and \tilde{psi}

        # (1) construction of \tilde{\psi}
        A := Range( UnderlyingMorphism( Source( morphism2 ) ) );
        R_C := Source( UnderlyingMorphism( Range( morphism2 ) ) );
        psi := UnderlyingMorphism( morphism2 );
        rho_C := UnderlyingMorphism( Range( morphism2 ) );
        psi_tilde := UniversalMorphismFromDirectSum( [ psi, rho_C ] );
        lift := Lift( UnderlyingMorphism( morphism1 ), psi_tilde );
        projection := ProjectionInFactorOfDirectSum( [ A, R_C ], 1 );

        # (2) construction of the lift
        return CAPPresentationCategoryMorphism( Source( morphism1 ),
                                                PreCompose( lift, projection ),
                                                Source( morphism2 ),
                                                checks_wished
                                               );

    end );

    # @Description
    # This method requires an epimorphism <A>morphism1</A> $a \to c$ and a morphism <A>morphism2</A> $a \to b$. The result of 
    # ColiftAlongEpimorphism( morphism1, morphism2 ) is then the colift morphism $c \to b$. Note that we do not use colift of 
    # the underlying Proj-category in this construction.
    # @Arguments morphism1, morphism2
    
    # FIX ME FIX ME FIX ME: What if the colift found by Proj does not allow for a source-lift? Does this imply that every colift that
    # Proj could come up with, cannot be lifted? I don't know yet.
    AddColiftAlongEpimorphism( category,
      function( morphism1, morphism2 )
        local A, R_C, C, psi, rho_C, rho_C_prime, sigma, projection, colift;
        
        # lookg at the following diagram (psi = morphism1 ) and recall that morphism1 is required epi
        # R_A            R_C         A \oplus R_C
        #  |              |               |
        #  |              |rho_C          |rho_C_prime
        #  v              v               v
        #  A ----psi----> C ---- id ----> C
        #
        # Since morphism1 is an epimorphism, there exists a section \sigma: C ---> A \oplus R_C such that 
        # \rho_C \circ \sigma = id_C. We can then use the projection onto A, to form a map
        # \mu: C ---> A \oplus R_C ----> A.
        # Now suppose that we have morphism2: ( R_A --> A ) --varphi--> ( R_B ---> B ). Then composing \mu and
        # \varphi gives the desired ColiftAlongEpimorphism( morphis1, morphism2 )
        
        # (1) collect the necessary information
        A := Range( UnderlyingMorphism( Source( morphism1 ) ) );
        R_C := Source( UnderlyingMorphism( Range( morphism1 ) ) );
        C := Range( UnderlyingMorphism( Range( morphism1 ) ) );
        psi := UnderlyingMorphism( morphism1 );
        rho_C := UnderlyingMorphism( Range( morphism1 ) );
        rho_C_prime := UniversalMorphismFromDirectSum( [ psi, rho_C ] );
        sigma := Lift( IdentityMorphism( C ), rho_C_prime );
        projection := ProjectionInFactorOfDirectSum( [ A, R_C ], 1 );
        
        # (2) construct the colift
        colift := PreCompose( [ sigma, projection, UnderlyingMorphism( morphism2 ) ] );
        return CAPPresentationCategoryMorphism( Range( morphism1 ),
                                                colift,
                                                Range( morphism2 ),
                                                checks_wished
                                               );

    end );



    ######################################################################
    #
    # @Section Add Abelian structure
    #
    ######################################################################

    # @Description
    # This method implements the kernel object of a morphism <A>morphism</A> in the presentation category.
    # Our strategy is as follows:
    # Look at the following diagram (which displays the morphism of which we want to compute the kernel)
    #
    # R_B --\beta---> B
    #                 ^
    #                 |
    #              \varphi
    #                 |
    # R_A --\alpha--> A
    #
    # Then take the pullback of \varphi and \beta. This gives us the following diagram
    #
    # R_B --\beta---> B
    #                 ^
    #                 |
    #              \varphi
    #                 |
    # R_A --\alpha--> A
    #                 ^
    #                 |
    #                \mu
    #                 |
    #                 |
    #          Pullback( \varphi, \beta )
    #
    # Finally take the pullback of \alpha and \mu to obtain the following diagram
    #
    # R_B ----------\beta-------------------> B
    #                                         ^
    #                                         |
    #                                      \varphi
    #                                         |
    # R_A -----------\alpha-----------------> A
    #                                         ^
    #                                         |
    #                                        \mu
    #                                         |
    #                                         |
    # Pullback( \mu, \alpha ) --x---> Pullback( \varphi, \beta )
    #
    # The last line defines the kernel object of \varphi and \mu is the kernel embedding. This method return the kernel embedding \mu.
    # @Returns a morphism
    # @Arguments morphism    
    AddKernelEmbedding( category,
      function( morphism )
        local kernel_embedding, underlying_morphism_of_kernel, kernel_object;

        kernel_embedding := ProjectionInFactorOfFiberProduct( [ UnderlyingMorphism( morphism ), 
                                                                UnderlyingMorphism( Range( morphism ) ) ], 1 );

        underlying_morphism_of_kernel := ProjectionInFactorOfFiberProduct( [ kernel_embedding, 
                                                                           UnderlyingMorphism( Source( morphism ) ) ], 1 );

        kernel_object := CAPPresentationCategoryObject( underlying_morphism_of_kernel );

        return CAPPresentationCategoryMorphism( kernel_object,
                                                kernel_embedding,
                                                Source( morphism ),
                                                checks_wished
                                               );

    end );

    # @Description
    # This method implements the cokernel projection of a morphism <A>morphism</A> in the presentation category.
    # Our strategy is as follows:
    # Look at the following diagram, which represents the morphism
    #
    # R_A ---\alpha---> A
    #                   ^
    #                   |
    #                  \mu
    #                   |
    #                   |
    # R_B ---\beta ---> B
    #
    # Next we look at the following diagram
    #
    # R_A \oplus B -x-> A
    #                   ^
    #                   |
    #                  id_A
    #                   |
    # R_A ---\alpha---> A
    #                   ^
    #                   |
    #                  \mu
    #                   |
    #                   |
    # R_B ---\beta ---> B
    #
    # The morphism x is induced as a universal morphism and the source-lift R_A -> R_A \oplus B is a canonical 
    # inclusion of the direct sum. The line R_A \oplus B -x-> A then defines the cokernel object of \mu and 
    # the corresponding morphism id_A is the cokernel projection. This method return the cokernel projection.
    # @Returns a morphism
    # @Arguments morphism
    AddCokernelProjection( category,
      function( morphism )
        local coproduct, sink, diagram, universal_morphism, cokernel_object;
        
        # compute coproduct
        coproduct := DirectSum( [ Range( UnderlyingMorphism( Source( morphism ) ) ), 
                                                                       Source( UnderlyingMorphism( Range( morphism ) ) ) ] );
        # fix sink and diagram
        sink := [ UnderlyingMorphism( morphism ), UnderlyingMorphism( Range( morphism ) ) ];
        diagram := [ Range( UnderlyingMorphism( Source( morphism ) ) ), 
                                                                       Source( UnderlyingMorphism( Range( morphism ) ) ) ]; 
        # and compute the universal morphism of the coproduct
        universal_morphism := UniversalMorphismFromDirectSum( diagram, sink );

        # and then  turn this morphism into an object of the presentation category - the cokernel
        cokernel_object := CAPPresentationCategoryObject( universal_morphism );

        # now return the cokernel projection
        return CAPPresentationCategoryMorphism( Range( morphism ),
                                                IdentityMorphism( Range( UnderlyingMorphism( Range( morphism ) ) ) ),
                                                cokernel_object,
                                                checks_wished
                                               );
    end );


end );



##
InstallGlobalFunction( ADD_MONOIDAL_FUNCTIONS_FOR_PRESENTATION_CATEGORY,
  function( category, checks_wished )



    ######################################################################
    #
    # @Section Add Basic Monoidal Structure
    #
    ######################################################################

    # @Description
    # This method requires and object <A>object1</A> and an object <A>object2</A> as input. Then it computes the tensor 
    # product of these two objects. Our strategy is as follows:
    #
    # The objects be given as follows:
    # 
    # R_A --- \alpha ---> A,    R_B --- \beta ---> B
    # 
    # Then we consider the following diagram
    # 
    # R_A \otimes B <<----- ( R_A \otimes B ) \oplus ( A \otimes R_B ) -------> A \otimes R_B
    #       |                                                                           |
    #       |                                                                           |
    #       |---- \alpha \otimes 1_B -----> A \otimes B <------- 1_A \otimes \beta -----|
    # 
    # This induces a universal morphism ( R_A \otimes B ) \oplus ( A \otimes R_B ) ---> A \otimes B. This morphism we consider as the
    # tensor product of the original two starting objects. The method below returns it. Note that the tensor product A \otimes B,
    # \alpha \otimes 1_B etc. are performed in the underlying Proj-category.
    # @Returns a object
    # @Arguments object1, object2
    AddTensorProductOnObjects( category,
      function( object1, object2 )
        local factor1, factor2, range, diagram, mor1, mor2, sink, uni;

        # construct the objects needed in the computation of the tensor product
        factor1 := TensorProductOnObjects( Source( UnderlyingMorphism( object1 ) ), Range( UnderlyingMorphism( object2 ) ) );
        factor2 := TensorProductOnObjects( Range( UnderlyingMorphism( object1 ) ), Source( UnderlyingMorphism( object2 ) ) );
        range := TensorProductOnObjects( Range( UnderlyingMorphism( object1 ) ), Range( UnderlyingMorphism( object2 ) ) );

        # construct the diagram
        diagram := [ factor1, factor2 ];

        # construct the sink
        mor1 := TensorProductOnMorphisms( UnderlyingMorphism( object1 ), IdentityMorphism( Range( UnderlyingMorphism( object2 ) ) ) );
        mor2 := TensorProductOnMorphisms( IdentityMorphism( Range( UnderlyingMorphism( object1 ) ) ), UnderlyingMorphism( object2 ) );
        sink := [ mor1, mor2 ];

        # construct the information necessary to product the universal morphism
        uni := UniversalMorphismFromDirectSum( diagram, sink );

        # now return the object corresponding to this universal morphism
        return CAPPresentationCategoryObject( uni );

    end );

    # @Description
    # This method requires two morphisms in the presentation category. Let us denote them as follows:
    #
    # \alpha: S_1 --- x ---> R_1,      \beta: S_2 --- y ---> R_2
    #
    # Then we compute S = S_1 \otimes S_2, R = R_1 \otimes R_2 in the presentation category and x \otimes y in the Proj-category.
    # The method return the morphism S --- x \otimes y ---> R.
    # @Returns a morphism
    # @Arguments morphism1, morphism2
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      function( source, morphism1, morphism2, range )

        return CAPPresentationCategoryMorphism(
                                    source,
                                    TensorProductOnMorphisms( UnderlyingMorphism( morphism1 ), UnderlyingMorphism( morphism2 ) ),
                                    range,
                                    checks_wished
                                   );

    end );

    # @Description
    # The tensor unit is 0 ---> 1 where 0 is the zero object in the Proj-category, 1 the tensor unit in the Proj-category and the
    # morphism is the universal morphism from the zero object.
    # @Returns an object
    # @Arguments
    AddTensorUnit( category,
      function( )
        local proj_category;

        # identity the proj_category
        proj_category := category!.underlying_projective_category;

        # and return the universal morphism 0 -> 1 from the zero object in the tensor unit
        return CAPPresentationCategoryObject( UniversalMorphismFromZeroObject( TensorUnit( proj_category ) ) );

    end );

    # @Description
    # Given three objects a, b, c in the presentation category we consider source = ( a \otimes b ) \otimes c and 
    # range = a \otimes ( b \otimes c ). The result is the associator source -> range, which we derive from the associator in the 
    # underlying Proj-category.
    # Note that even if the Proj-category is a strict monoidal category (i.e. the associators and unitors are identities), this 
    # need not be true in the presentation category.
    # @Returns a morphism
    # @Arguments source, a, b, c, range
    AddAssociatorLeftToRightWithGivenTensorProducts( category,
      function( source, a, b, c, range )

        # return the morphism as derived from the Proj-category
        return CAPPresentationCategoryMorphism( source,
                                                AssociatorLeftToRight( Range( UnderlyingMorphism( a ) ),
                                                                       Range( UnderlyingMorphism( b ) ),
                                                                       Range( UnderlyingMorphism( c ) ) 
                                                                      ),
                                                range,
                                                checks_wished
                                               );

        # FIXME
        # always well-defined?

    end );

    # @Description
    # Given three objects a, b, c in the presentation category we consider range = ( a \otimes b ) \otimes c and 
    # source = a \otimes ( b \otimes c ). The result is the associator source -> range, which we derive from the associator in the 
    # underlying Proj-category.
    # Note that even if the Proj-category is a strict monoidal category (i.e. the associators and unitors are identities), this 
    # need not be true in the presentation category.
    # @Returns a morphism
    # @Arguments source, a, b, c, range
    AddAssociatorRightToLeftWithGivenTensorProducts( category,
      function( source, a, b, c, range )

        # return the morphism as derived from the Proj-category
        return CAPPresentationCategoryMorphism( source,
                                                AssociatorRightToLeft( Range( UnderlyingMorphism( a ) ),
                                                                       Range( UnderlyingMorphism( b ) ),
                                                                       Range( UnderlyingMorphism( c ) ) 
                                                                      ),
                                                range,
                                                checks_wished
                                               );
        # FIXME
        # well-defined?

    end );

    # @Description
    # Given an object a, this method returns the left unitor 1 \otimes a -> a. We derive this from the unitors of the 
    # underlying proj-category.
    # @Returns a morphism
    # @Arguments a, s (= 1 \otimes a)
    AddLeftUnitorWithGivenTensorProduct( category,
      function( a, s )

        return CAPPresentationCategoryMorphism( s,
                                                LeftUnitor( Range( UnderlyingMorphism( a ) ) ),
                                                a,
                                                checks_wished
                                               );

    end );

    # @Description
    # Given an object a, this method returns the left unitor inverse, i.e. a -> 1 \otimes a, which we derive from the
    # underlying proj-category.
    # @Returns a morphism
    # @Arguments a, r (= 1 \otimes a)
    AddLeftUnitorInverseWithGivenTensorProduct( category,
      function( a, r )

        return CAPPresentationCategoryMorphism( a,
                                                LeftUnitorInverse( Range( UnderlyingMorphism( a ) ) ),
                                                r,
                                                checks_wished
                                               );

    end );

    # @Description
    # Given an object a, this method returns the left unitor inverse, i.e. a \otimes 1 -> a, which we derive from the
    # underlying proj-category.
    # @Returns a morphism
    # @Arguments a, s (= 1 \otimes a)
    AddRightUnitorWithGivenTensorProduct( category,
      function( a, s )
    
        return CAPPresentationCategoryMorphism( s,
                                                RightUnitor( Range( UnderlyingMorphism( a ) ) ),
                                                a,
                                                checks_wished
                                               );

    end );
    
    # @Description
    # Given an object a, this method returns the left unitor inverse, i.e. a -> a \otimes 1, which we derive from the 
    # underlying proj-category.
    # @Returns a morphism
    # @Arguments a, r (= a \otimes 1 )
    AddRightUnitorInverseWithGivenTensorProduct( category,
      function( a, r )
        
        return CAPPresentationCategoryMorphism( a,
                                                RightUnitorInverse( Range( UnderlyingMorphism( a ) ) ),
                                                r,
                                                checks_wished
                                               );

    end );



    ######################################################################
    #
    # @Section Add Symmetric Monoidal Structure 
    # (i.e. braiding and the inverse is given by B_a,b^{-1} = B_{b,a}
    #
    ######################################################################
    
    # @Description
    # Given two objects a and b this method derives a braiding morphism a \otimes b -> b \otimes a from the braiding in the
    # underlying Proj-category.
    # @Returns a morphism
    # @Arguments s = a \otimes b, a, b, r = b \otimes a
    AddBraidingWithGivenTensorProducts( category,
    function( s, a, b, r)

      return CAPPresentationCategoryMorphism( s,
                                              Braiding( Range( UnderlyingMorphism( a ) ), Range( UnderlyingMorphism( b ) ) ),
                                              r,
                                              checks_wished
                                             );

    end );

    ######################################################################
    #
    # @Section Add Symmetric Closed Monoidal Structure
    #
    ######################################################################

    # @Description
    # Given two objects a and b this method derives the internal hom, i.e. Hom( a, b). Let a be represented as
    # a: R_1 --- \alpha ---> A. Then we first use that the following is an exact sequence:
    #
    # 0 -> Hom( a,b ) -> Hom( A, b ) -> Hom( R_1, b )
    #
    # Now since A, R_1 are projective objects in the presentation category, even the following sequence is exact
    #
    # 0 -> Hom( a,b ) -> A^\vee \otimes b --- \alpha^\vee \otimes 1_b ---> R_1^\vee \otimes b
    #
    # By computing the kernel object of \alpha^\vee \otimes 1_b, we thus succeed in computing Hom( a,b ).
    # @Returns an object
    # @Arguments a, b
    AddInternalHomOnObjects( category,
    function( a, b )

      return Source( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT( a,b ) );

    end );

    # @Description
    # Given two morphisms \alpha and \beta, this method derives the internal hom, i.e. Hom( \alpha, \beta). Given that
    # \alpha: A^\prime -> A and \beta: B -> B^\prime, the latter is a morphism
    # Hom( A, B ) -> Hom( A^\prime, B^\prime )    
    # We construct this morphism by repeating the strategy for the computation of the internal hom on objects. This gives us the 
    # following diagram:
    #   
    # 0 -> Hom( a', b' ) --kernel2--> A'^\vee \otimes b' --- \alpha'^\vee \otimes 1_b' ---> R_1'^\vee \otimes b'
    #                                       ^
    #                                       |
    #                          \alpha^\vee \otimes \beta (bridge_mapping)
    #                                       |
    # 0 -> Hom( a , b  ) --kernel1--> A^\vee  \otimes b  --- \alpha^\vee \otimes 1_b   ---> R_1^\vee \otimes b
    #
    # We compute the left square, i.e. the two kernel embeddings and the vertical map. Finally we compute the lift
    # Hom( a,b ) ---> Hom( a', b' ) and return this morphism.
    # @Returns a morphism
    # @Arguments s = source, alpha, beta, r = range
    AddInternalHomOnMorphismsWithGivenInternalHoms( category,
    function( s, alpha, beta, r )
      local kernel1, kernel2, bridge_mapping;

      # (1) extract the Hom-embeddings
      kernel1 := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT( Range( alpha ), Source( beta ) );
      kernel2 := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT( Source( alpha ), Range( beta ) );

      # (2) construct the bridge_mapping A^vee \otimes B -> A'^\vee \otimes b'
      bridge_mapping := CAPPresentationCategoryMorphism(
                                 Range( kernel1 ),
                                 TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( alpha ) ),
                                                           UnderlyingMorphism( beta ) ),
                                 Range( kernel2 ),
                                 checks_wished
                                );

      # (3) finally return the lift of the corresponding diagram
      return Lift( PreCompose( kernel1, bridge_mapping ), kernel2 );

    end );



    ######################################################################
    #
    # @Section Add (Co-)evaluation
    #
    ######################################################################

    # @Description
    # Given objects a,b we can construct the evaluation morphism Hom( a, b ) \otimes a -> b.
    # To end let us assume that a: R_A --alpha--> A and b: R_B --beta--> B. Then consider the following diagram:
    #                                             b \otimes 1 \equiv b
    #                                                        ^
    #                                                        |
    #                                                   'evaluation'
    #                                                        |
    #                                             b \otimes ( A^\vee \otimes a )
    #                                                        ^
    #                                                        |
    #                                                   associator
    #                                                        |
    #                                             ( b \otimes A^\vee ) \otimes a
    #                                                        ^
    #                                                        |
    #                                                     braiding
    #                                                        |
    # Hom( a, b ) \otimes a --------------------> ( A^\vee \otimes b ) \otimes a
    # The composition of all these morphisms produces the evaluation morphism.
    # @Returns a morphism
    # @Arguments a, b, s = Hom( a, b ) \otimes a
    AddEvaluationMorphismWithGivenSource( category,
      function( a, b, s )
        local projective_category, Hom_embedding, Hom_embedding_tensored, Adual, braiding, associator, evaluation;

        # (0) extract the underlying proj-category
        projective_category := category!.underlying_projective_category;

        # (1) the hom-embedding
        Hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT( a, b );
        Hom_embedding_tensored := TensorProductOnMorphisms( Hom_embedding, IdentityMorphism( a ) );

        # (2) the braiding
        Adual := CAPPresentationCategoryObject(
                    ZeroMorphism( ZeroObject( projective_category ), DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ) );
        braiding := Braiding( Adual, b );
        braiding := TensorProductOnMorphisms( braiding, IdentityMorphism( a ) );

        # (3) associator_left_to_right
        associator := AssociatorLeftToRight( b, Adual, a );

        # (4) evaluation
        evaluation := CAPPresentationCategoryMorphism( TensorProductOnObjects( Adual, a ),
                                                       EvaluationForDual( Range( UnderlyingMorphism( a ) ) ),
                                                       TensorUnit( category ),
                                                       checks_wished
                                                      );
        evaluation := TensorProductOnMorphisms( IdentityMorphism( b ), evaluation );

        # (5) now compute the evaluation morphism by a lift
        return PreCompose( [ Hom_embedding_tensored, braiding, associator, evaluation ] );

    end );

    # @Description
    # Given objects a,b we can construct the coevaluation morphism a -> Hom( b, a \otimes b ).
    # To end let us assume that a: R_A --alpha--> A and b: R_B --beta--> B. Then consider the following diagram:
    # a \otimes 1 ---- 'coevaluation' ------> a \otimes ( b \otimes B^\vee )
    #                                                        ^
    #                                                        |
    #                                                   associator
    #                                                        |
    #                                             ( a \otimes b ) \otimes B^\vee
    #                                                        ^
    #                                                        |
    #                                                     braiding
    #                                                        |
    # Hom( b, a \otimes b ) --------------------> B^\vee \otimes ( a \otimes b )
    # The corresponding lift produces the desired morphism.
    # @Returns a morphism
    # @Arguments a, b, r = Hom( b, a \otimes b )
    AddCoevaluationMorphismWithGivenRange( category,
      function( a, b, r )
        local projective_category, Hom_embedding, Bdual, braiding, associator, coevaluation;
        
        # (0) extract the underlying proj-category
        projective_category := category!.underlying_projective_category;
        
        # (1) the hom-embedding
        Hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT( b, TensorProductOnObjects( a, b ) );

        # (2) the braiding
        Bdual := CAPPresentationCategoryObject( 
                   ZeroMorphism( ZeroObject( projective_category ), DualOnObjects( Range( UnderlyingMorphism( b ) ) ) ) );

        braiding := Braiding( Bdual, TensorProductOnObjects( a,b ) );

        # (3) associator_left_to_right
        associator := AssociatorLeftToRight( a, b, Bdual );

        # (4) coevaluation
        coevaluation := CAPPresentationCategoryMorphism(
                                TensorUnit( category ),
                                CoevaluationForDual( Range( UnderlyingMorphism( b ) ) ),
                                TensorProductOnObjects( b, Bdual ),
                                checks_wished
                        );
        coevaluation := TensorProductOnMorphisms( IdentityMorphism( a ), coevaluation );

        # (5) now compute the coevaluation morphism by a lift
        return Lift( coevaluation, PreCompose( Hom_embedding, braiding, associator ) );

    end );

end );