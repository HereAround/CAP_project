#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsSerreQuotientCategoryObjectRep",
                       IsCapCategoryObjectRep and IsSerreQuotientCategoryObject,
                       [ ] );

BindGlobal( "TheTypeOfSerreQuotientCategoryObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsSerreQuotientCategoryObjectRep ) );

DeclareRepresentation( "IsSerreQuotientCategoryMorphismRep",
                       IsCapCategoryMorphismRep and IsSerreQuotientCategoryMorphism,
                       [ ] );

BindGlobal( "TheTypeOfSerreQuotientCategoryMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                 IsSerreQuotientCategoryMorphismRep ) );

#############################################
##
## Installation method
##
#############################################

BindGlobal( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT",
  
  function( category )
    local membership_function;
    
    membership_function := SubcategoryMembershipTestFunctionForSerreQuotient( category );
    
    ## Equalities
    
    AddIsCongruentForMorphisms( category,
      
      function( morphism1, morphism2 )
        local underlying_general, new_morphism_aid, new_general, sum_general,
              sum_associated, sum_image;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism2 );
        
        new_morphism_aid := AdditiveInverse( MorphismAid( underlying_general ) );
        
        new_general := GeneralizedMorphism( SourceAid( underlying_general ), new_morphism_aid, RangeAid( underlying_general ) );
        
        sum_general := AdditionForMorphisms( UnderlyingGeneralizedMorphism( morphism1 ), new_general );
        
        sum_associated := AssociatedMorphism( sum_general );
        
        sum_image := ImageObject( sum_associated );
        
        return membership_function( sum_image );
        
    end );
    
    AddIsEqualForObjects( category,
      
      function( obj1, obj2 )
        
        return IsEqualForObjects( UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
    end );
    
    ## Is Zero
    
    AddIsZeroForObjects( category,
      
      function( obj )
        
        return membership_function( UnderlyingHonestObject( obj ) );
        
    end );
    
    ## PreCompose
    
    AddPreCompose( category,
      
      function( morphism1, morphism2 )
        local composition;
        
        composition := PreCompose( UnderlyingGeneralizedMorphism( morphism1 ),
                                   UnderlyingGeneralizedMorphism( morphism2 ) );
        
        return SerreQuotientCategoryMorphism( category, composition );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( morphism1, morphism2 )
        local sum;
        
        sum := AdditionForMorphisms( UnderlyingGeneralizedMorphism( morphism1 ),
                                     UnderlyingGeneralizedMorphism( morphism2 ) );
        
        return SerreQuotientCategoryMorphism( category, sum );
        
    end );
    
    ## IsZeroForMorphisms
    
    AddIsZeroForMorphisms( category,
      
      function( morphism )
        local associated, image;
        
        associated := AssociatedMorphism( UnderlyingGeneralizedMorphism( morphism ) );
        
        image := ImageObject( associated );
        
        return membership_function( image );
        
    end );
    
    ## Additive inverse for morphisms (works without normalization)
    
    AddAdditiveInverseForMorphisms( category,
      
      function( morphism )
        local underlying_general, new_morphism_aid, new_general;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        new_morphism_aid := AdditiveInverse( MorphismAid( underlying_general ) );
        
        new_general := GeneralizedMorphism( SourceAid( underlying_general ), new_morphism_aid, RangeAid( underlying_general ) );
        
        return SerreQuotientCategoryMorphism( category, new_general );
        
    end );
    
    ## Zero morphism
    
    AddZeroMorphism( category,
      
      function( source, range )
        local source_aid, range_aid, morphism_aid;
        
        source := UnderlyingHonestObject( source );
        
        range := UnderlyingHonestObject( range );
        
        source_aid := IdentityMorphism( source );
        
        range_aid := IdentityMorphism( range );
        
        morphism_aid := ZeroMorphism( source, range );
        
        return SerreQuotientCategoryMorphism( category, source_aid, morphism_aid, range_aid );
        
    end );
    
    ## Zero object
    
    AddZeroObject( category,
      
      function( )
        
        return AsSerreQuotientObject( category, ZeroObject( UnderlyingHonestCategory( category ) ) );
        
    end );
    
    ## direct sum
    
    AddDirectSum( category,
      
      function( obj_list )
        local honest_list;
        
        honest_list := List( obj_list, UnderlyingHonestObject );
        
        return CallFuncList( DirectSum, honest_list );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      
      function( product_object, component_number, direct_sum_object )
        local underlying_objects, underlying_direct_sum, honest_projection;
        
        underlying_objects := List( product_object, UnderlyingHonestObject );
        
        underlying_direct_sum := UnderlyingHonestObject( direct_sum_object );
        
        honest_projection := ProjectionInFactorOfDirectSumWithGivenDirectSum( underlying_objects, component_number, underlying_direct_sum );
        
        return AsSerreQuotientCategoryMorphism( category, honest_projection );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      
      function( object_product_list, injection_number, direct_sum_object )
        local underlying_objects, underlying_direct_sum, honest_injection;
        
        underlying_objects := List( object_product_list, UnderlyingHonestObject );
        
        underlying_direct_sum := UnderlyingHonestObject( direct_sum_object );
        
        honest_injection := AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( underlying_objects, injection_number, underlying_direct_sum );
        
        return AsSerreQuotientCategoryMorphism( category, honest_injection );
        
    end );
    
    ## Universal property of direct sum still missing.
    
    ## Kernel
    
    AddKernelEmb( category,
      
      function( morphism )
        local underlying_general, kernel_mor;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        kernel_mor := KernelEmb( AssociatedMorphism( underlying_general ) );
        
        kernel_mor := PreCompose( kernel_mor, Domain( underlying_general ) );
        
        return AsSerreQuotientCategoryMorphism( category, kernel_mor );
        
    end );
    
    AddMonoAsKernelLift( category,
      
      function( monomorphism, test_morphism )
        local inverse_of_mono, composition;
        
        inverse_of_mono := PseudoInverse( UnderlyingGeneralizedMorphism( monomorphism ) );
        
        composition := PreCompose( UnderlyingGeneralizedMorphism( test_morphism ), inverse_of_mono );
        
        return SerreQuotientCategoryMorphism( category, composition );
        
    end );
    
    ## Cokernel
    
    AddCokernelProj( category,
      
      function( morphism )
        local underlying_general, cokernel_mor;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        cokernel_mor := CokernelProj( AssociatedMorphism( underlying_general ) );
        
        cokernel_mor := PreCompose( Codomain( underlying_general ), cokernel_mor );
        
        return SerreQuotientCategoryMorphism( category, cokernel_mor );
        
    end );
    
    AddEpiAsCokernelColift( category,
      
      function( epimorphism, test_morphism )
        local inverse_of_epi, composition;
        
        inverse_of_epi := PseudoInverse( UnderlyingGeneralizedMorphism( epimorphism ) );
        
        composition := PreCompose( inverse_of_epi, UnderlyingGeneralizedMorphism( test_morphism ) );
        
        return SerreQuotientCategoryMorphism( category, composition );
        
    end );
    
end );

#############################################
##
## Constructor
##
#############################################

InstallMethod( SerreQuotientCategory,
               [ IsCapCategory, IsFunction ],
               
  function( category, test_function )
    local name;
    
    name := NameFunction( test_function );
    
    return SerreQuotientCategory( category, test_function, Concatenation( "test function with name: ", name ) );
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategory,
                                  [ IsCapCategory, IsFunction, IsString ],
                                  
  function( category, test_function, function_name )
    local serre_category, gen_category, name;
    
    name := Name( category );
    
    name := Concatenation( "The Serre quotient category of ", name, " by ", function_name );
    
    serre_category := CreateCapCategory( name );
    
    SetFilterObj( serre_category, WasCreatedAsSerreQuotientCategory );
    
    SetUnderlyingHonestCategory( serre_category, category );
    
    SetUnderlyingGeneralizedMorphismCategory( serre_category, GeneralizedMorphismCategory( category ) );
    
    SetSubcategoryMembershipTestFunctionForSerreQuotient( serre_category, test_function );
    
    return serre_category;
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientObject,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsCapCategoryObject ],
                                  
  function( serre_category, object )
    local honest_category, serre_object;
    
    honest_category := UnderlyingHonestCategory( serre_category );
    
    if not IsIdenticalObj( honest_category, CapCategory( object ) ) then
        
        Error( "object does not belong to underlying honest category of serre quotient" );
        
    fi;
    
    serre_object := rec( );
    
    ObjectifyWithAttributes( serre_object, TheTypeOfSerreQuotientCategoryObject );
    
    SetUnderlyingHonestObject( serre_object, object );
    
    SetUnderlyingGeneralizedObject( serre_object, GeneralizedMorphismObject( object ) );
    
    AddToToDoList( ToDoListEntryForEqualAttributes( serre_object, "IsWellDefined", object, "IsWellDefined" ) );
    
    return serre_object;
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsGeneralizedMorphism ],
                                  
  function( serre_category, gen_morphism )
    local honest_category, serre_morphism;
    
    if not IsIdenticalObj( UnderlyingGeneralizedMorphismCategory( serre_category ), CapCategory( gen_morphism ) ) then
        
        Error( "generalized morphism has wrong category" );
        
    fi;
    
    serre_morphism := rec( );
    
    ObjectifyWithAttributes( serre_morphism, TheTypeOfSerreQuotientCategoryMorphism,
                             Source, AsSerreQuotientObject( UnderlyingHonestObject( Source( gen_morphism ) ) ),
                             Range, AsSerreQuotientObject( UnderlyingHonestObject( Range( gen_morphism ) ) ) );
    
    SetUnderlyingGeneralizedMorphism( serre_morphism, gen_morphism );
    
    return serre_morphism;
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated, range_aid )
    
    return SerreQuotientCategoryMorphism( serre_category, GeneralizedMorphism( source_aid, associated, range_aid ) );
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryMorphismWithSourceAid,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated )
    
    return SerreQuotientCategoryMorphism( serre_category, GeneralizedMorphismWithSourceAid( source_aid, associated ) );
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryMorphismWithRangeAid,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, associated, range_aid )
    
    return SerreQuotientCategoryMorphism( serre_category, GeneralizedMorphismWithRangeAid( associated, range_aid ) );
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientCategoryMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategory, IsCapCategoryMorphism ],
                                  
  function( serre_category, associated )
    
    return SerreQuotientCategoryMorphism( serre_category, AsGeneralizedMorphism( associated ) );
    
end );
