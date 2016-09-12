#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## Constructors
##
####################################
####################################
##
## Constructors
##
####################################

##
InstallMethod( LeftCoactionsCategory,
               [ IsCapCategoryObject ],
               
  function( coacting_object )
    local name;
      
      name := Concatenation( "Category of left coactions of <", String( coacting_object ), ">" );
      
      return LeftCoactionsCategory( coacting_object, name, IsObject );
      
end );


##
InstallMethod( LeftCoactionsCategory,
               [ IsCapCategoryObject, IsString, IsObject ],
               
  function( coacting_object, name, context_filter )
    local underlying_monoidal_category, preconditions, category_weight_list, i,
          structure_record, object_constructor, morphism_constructor, 
          left_coactions_category, identity_of_coacting_object;
    
    underlying_monoidal_category := CapCategory( coacting_object );
    
    if not IsFinalized( underlying_monoidal_category ) then
        
        Error( "the underlying category must be finalized" );
    
    elif not IsMonoidalCategory( underlying_monoidal_category ) then
      
      Error( "the underlying category has to be a monoidal category" );
      
    elif not IsAdditiveCategory( underlying_monoidal_category ) then
      
      ## TODO: support the general case
      Error( "only additive categories are supported yet" );
      
    fi;
    
    left_coactions_category := CreateCapCategory( name );
    
    SetFilterObj( left_coactions_category, context_filter );
    
    SetUnderlyingCoactingObject( left_coactions_category, coacting_object );
    
    structure_record := rec(
      underlying_category := underlying_monoidal_category,
      category_with_attributes := left_coactions_category
    );
    
    ## Constructors
    object_constructor := CreateObjectConstructorForCategoryWithAttributes(
                            underlying_monoidal_category, left_coactions_category, TheTypeOfLeftCoactionObjects );
    
    structure_record.ObjectConstructor := function( object, attributes )
        local return_object;
        
        return_object := object_constructor( object, attributes );
        
        SetStructureMorphism( return_object, attributes[1] );
        
        SetUnderlyingCoactingObject( return_object, coacting_object );
        
        SetCoactionDomain( return_object, Source( attributes[1] ) );
        
        SetFilterObj( return_object, context_filter );
        
        return return_object;
        
    end;
    
    morphism_constructor := CreateMorphismConstructorForCategoryWithAttributes(
                              underlying_monoidal_category, left_coactions_category, TheTypeOfLeftCoactionMorphisms );
    
    structure_record.MorphismConstructor := function( source, morphism, range )
        local return_morphism;
        
        return_morphism := morphism_constructor( source, morphism, range );
        
        SetUnderlyingCoactingObject( return_morphism, coacting_object );
        
        SetUnderlyingMorphism( return_morphism, morphism );
        
        SetFilterObj( return_morphism, context_filter );
        
        return return_morphism;
        
    end;
    
    ##
    category_weight_list := underlying_monoidal_category!.derivations_weight_list;
    
    ## Left coaction for ZeroObject
    preconditions := [ "UniversalMorphismIntoZeroObject",
                       "TensorProductOnObjects" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        structure_record.ZeroObject :=
          function( underlying_zero_object )
              
              return [ UniversalMorphismFromZeroObject( TensorProductOnObjects( coacting_object, underlying_zero_object ) ) ];
              
          end;
    fi;
    
    ## Left coaction for DirectSum
    preconditions := [ "LeftDistributivityFactoringWithGivenObjects",
                       "DirectSum", #belongs to LeftDistributivityFactoringWithGivenObjects
                       "DirectSumFunctorial",
                       "PreCompose" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        structure_record.DirectSum :=
          function( obj_list, underlying_direct_sum )
            local left_coaction_list, underlying_obj_list, structure_morphism;
            
            left_coaction_list := List( obj_list, obj -> ObjectAttributesAsList( obj )[1] );
            
            underlying_obj_list := List( obj_list, UnderlyingCell );
            
            structure_morphism := 
              PreCompose( DirectSumFunctorial( left_coaction_list ),
                          LeftDistributivityFactoring( coacting_object, underlying_obj_list ) );
            
            return [ structure_morphism ];
            
          end;
        
    fi;
    
    ## Lift left coaction along monomorphism
    preconditions := [ "IdentityMorphism",
                       "PreCompose",
                       "TensorProductOnMorphismsWithGivenTensorProducts",
                       "TensorProductOnObjects", #belongs to TensorProductOnMorphisms
                       "Lift" ]; #we can't use LiftAlongMonomorphism here because we don't know if the tensor product is left exact
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        identity_of_coacting_object := IdentityMorphism( coacting_object );
        
        structure_record.Lift :=
          function( mono, range )
            local action_range, to_be_lifted;
            
            action_range := ObjectAttributesAsList( range )[1];
            
            to_be_lifted := PreCompose( mono, action_range );
            
            return [ Lift( to_be_lifted, TensorProductOnMorphisms( identity_of_coacting_object, mono ) ) ];
            
          end;
        
    fi;
    
    ## Colift left coaction along epimorphism
    preconditions := [ "IdentityMorphism",
                       "PreCompose",
                       "TensorProductOnMorphismsWithGivenTensorProducts",
                       "TensorProductOnObjects", #belongs to TensorProductOnMorphisms
                       "ColiftAlongEpimorphism" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        identity_of_coacting_object := IdentityMorphism( coacting_object );
        
        structure_record.Colift :=
          function( epi, source )
            local action_source, to_be_colifted;
            
            action_source := ObjectAttributesAsList( source )[1];
            
            to_be_colifted := PreCompose( action_source, TensorProductOnMorphisms( identity_of_coacting_object, epi ) );
            
            return [ ColiftAlongEpimorphism( epi, to_be_colifted ) ];
            
          end;
        
    fi;
    
    EnhancementWithAttributes( structure_record );
    
    ##
    InstallMethod( LeftCoactionObject,
                   [ IsCapCategoryMorphism and MorphismFilter( underlying_monoidal_category ), 
                     IsCapCategory and CategoryFilter( left_coactions_category ) ],
                   
      function( structure_morphism, attribute_category )
        
        return structure_record.ObjectConstructor( Source( structure_morphism ), [ structure_morphism ] );
        
    end );
    
    ##
    InstallMethod( LeftCoactionMorphism,
                   [ IsLeftCoactionObject and ObjectFilter( left_coactions_category ),
                     IsCapCategoryMorphism and MorphismFilter( underlying_monoidal_category ),
                     IsLeftCoactionObject and ObjectFilter( left_coactions_category ) ],
                   
      function( source, underlying_morphism, range )
        
        return structure_record.MorphismConstructor( source, underlying_morphism, range );
        
    end );
    
    ## TODO: Set properties of left_coactions_category
    
    ADD_FUNCTIONS_FOR_LEFT_COACTIONS_CATEGORY( left_coactions_category );
    
    ## TODO: Logic for left_coactions_category
     
    Finalize( left_coactions_category );
    
    return left_coactions_category;
    
end );

##
InstallMethod( RightCoactionsCategory,
               [ IsCapCategoryObject ],
               
  function( coacting_object )
    local name;
      
      name := Concatenation( "Category of right coactions of <", String( coacting_object ), ">" );
      
      return RightCoactionsCategory( coacting_object, name, IsObject );
      
end );


##
InstallMethod( RightCoactionsCategory,
               [ IsCapCategoryObject, IsString, IsObject ],
               
  function( coacting_object, name, context_filter )
    local underlying_monoidal_category, preconditions, category_weight_list, i,
          structure_record, object_constructor, morphism_constructor, 
          right_coactions_category, identity_of_coacting_object;
    
    underlying_monoidal_category := CapCategory( coacting_object );
    
    if not IsFinalized( underlying_monoidal_category ) then
        
        Error( "the underlying category must be finalized" );
    
    elif not IsMonoidalCategory( underlying_monoidal_category ) then
      
      Error( "the underlying category has to be a monoidal category" );
      
    elif not IsAdditiveCategory( underlying_monoidal_category ) then
      
      ## TODO: support the general case
      Error( "only additive categories are supported yet" );
      
    fi;
    
    right_coactions_category := CreateCapCategory( name );
    
    SetFilterObj( right_coactions_category, context_filter );
    
    SetUnderlyingCoactingObject( right_coactions_category, coacting_object );
    
    structure_record := rec(
      underlying_category := underlying_monoidal_category,
      category_with_attributes := right_coactions_category
    );
    
    ## Constructors
    object_constructor := CreateObjectConstructorForCategoryWithAttributes(
                            underlying_monoidal_category, right_coactions_category, TheTypeOfRightCoactionObjects );
    
    structure_record.ObjectConstructor := function( object, attributes )
        local return_object;
        
        return_object := object_constructor( object, attributes );
        
        SetStructureMorphism( return_object, attributes[1] );
        
        SetUnderlyingCoactingObject( return_object, coacting_object );
        
        SetCoactionDomain( return_object, Source( attributes[1] ) );
        
        SetFilterObj( return_object, context_filter );
        
        return return_object;
        
    end;
    
    morphism_constructor := CreateMorphismConstructorForCategoryWithAttributes(
                              underlying_monoidal_category, right_coactions_category, TheTypeOfRightCoactionMorphisms );
    
    structure_record.MorphismConstructor := function( source, morphism, range )
        local return_morphism;
        
        return_morphism := morphism_constructor( source, morphism, range );
        
        SetUnderlyingCoactingObject( return_morphism, coacting_object );
        
        SetUnderlyingMorphism( return_morphism, morphism );
        
        SetFilterObj( return_morphism, context_filter );
        
        return return_morphism;
        
    end;
    
    ##
    category_weight_list := underlying_monoidal_category!.derivations_weight_list;
    
    ## Right coaction for ZeroObject
    preconditions := [ "UniversalMorphismIntoZeroObject",
                       "TensorProductOnObjects" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        structure_record.ZeroObject :=
          function( underlying_zero_object )
              
              return [ UniversalMorphismFromZeroObject( TensorProductOnObjects( underlying_zero_object, coacting_object ) ) ];
              
          end;
    fi;
    
    ## Right coaction for DirectSum
    preconditions := [ "RightDistributivityFactoringWithGivenObjects",
                       "DirectSum", #belongs to RightDistributivityFactoringWithGivenObjects
                       "DirectSumFunctorial",
                       "PreCompose" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        structure_record.DirectSum :=
          function( obj_list, underlying_direct_sum )
            local right_coaction_list, underlying_obj_list, structure_morphism;
            
            right_coaction_list := List( obj_list, obj -> ObjectAttributesAsList( obj )[1] );
            
            underlying_obj_list := List( obj_list, UnderlyingCell );
            
            structure_morphism := 
              PreCompose( DirectSumFunctorial( right_coaction_list ),
                          RightDistributivityFactoring( underlying_obj_list, coacting_object ) );
            
            return [ structure_morphism ];
            
          end;
        
    fi;
    
    ## Lift right coaction along monomorphism
    preconditions := [ "IdentityMorphism",
                       "PreCompose",
                       "TensorProductOnMorphismsWithGivenTensorProducts",
                       "TensorProductOnObjects", #belongs to TensorProductOnMorphisms
                       "Lift" ]; #we can't use LiftAlongMonomorphism here because we don't know if the tensor product is left exact
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        identity_of_coacting_object := IdentityMorphism( coacting_object );
        
        structure_record.Lift :=
          function( mono, range )
            local action_range, to_be_lifted;
            
            action_range := ObjectAttributesAsList( range )[1];
            
            to_be_lifted := PreCompose( mono, action_range );
            
            return [ Lift( to_be_lifted, TensorProductOnMorphisms( mono, identity_of_coacting_object ) ) ];
            
          end;
        
    fi;
    
    ## Colift right coaction along epimorphism
    preconditions := [ "IdentityMorphism",
                       "PreCompose",
                       "TensorProductOnMorphismsWithGivenTensorProducts",
                       "TensorProductOnObjects", #belongs to TensorProductOnMorphisms
                       "ColiftAlongEpimorphism" ];
    
    if ForAll( preconditions, c -> CurrentOperationWeight( category_weight_list, c ) < infinity ) then
        
        identity_of_coacting_object := IdentityMorphism( coacting_object );
        
        structure_record.Colift :=
          function( epi, source )
            local action_source, to_be_colifted;
            
            action_source := ObjectAttributesAsList( source )[1];
            
            to_be_colifted := PreCompose( action_source, TensorProductOnMorphisms( epi, identity_of_coacting_object ) );
            
            return [ ColiftAlongEpimorphism( epi, to_be_colifted ) ];
            
          end;
        
    fi;
    
    EnhancementWithAttributes( structure_record );
    
    ##
    InstallMethod( RightCoactionObject,
                   [ IsCapCategoryMorphism and MorphismFilter( underlying_monoidal_category ), 
                     IsCapCategory and CategoryFilter( right_coactions_category ) ],
                   
      function( structure_morphism, attribute_category )
        
        return structure_record.ObjectConstructor( Source( structure_morphism ), [ structure_morphism ] );
        
    end );
    
    ##
    InstallMethod( RightCoactionMorphism,
                   [ IsRightCoactionObject and ObjectFilter( right_coactions_category ),
                     IsCapCategoryMorphism and MorphismFilter( underlying_monoidal_category ),
                     IsRightCoactionObject and ObjectFilter( right_coactions_category ) ],
                   
      function( source, underlying_morphism, range )
        
        return structure_record.MorphismConstructor( source, underlying_morphism, range );
        
    end );
    
    ## TODO: Set properties of right_coactions_category
    
    ADD_FUNCTIONS_FOR_RIGHT_COACTIONS_CATEGORY( right_coactions_category );
    
    ## TODO: Logic for right_coactions_category
     
    Finalize( right_coactions_category );
    
    return right_coactions_category;
    
end );

####################################
##
## Basic operations
##
####################################

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_LEFT_COACTIONS_CATEGORY,
  
  function( left_coactions_category )
    
    ADD_FUNCTIONS_FOR_LEFT_AND_RIGHT_COACTIONS_CATEGORY( left_coactions_category );
    
    ADD_FUNCTIONS_FOR_ONLY_LEFT_COACTIONS_CATEGORY( left_coactions_category );
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_RIGHT_COACTIONS_CATEGORY,
  
  function( right_coactions_category )
    
    ADD_FUNCTIONS_FOR_LEFT_AND_RIGHT_COACTIONS_CATEGORY( right_coactions_category );
    
    ADD_FUNCTIONS_FOR_ONLY_RIGHT_COACTIONS_CATEGORY( right_coactions_category );
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_LEFT_AND_RIGHT_COACTIONS_CATEGORY,
  
  function( category )
    ##
    AddIsEqualForObjects( category,
      function( coaction_object_1, coaction_object_2 )
        
        return IsEqualForObjects( CoactionDomain( coaction_object_1 ), CoactionDomain( coaction_object_2 ) )
               and
               IsCongruentForMorphisms( StructureMorphism( coaction_object_1 ), StructureMorphism( coaction_object_2 ) );
        
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return IsEqualForMorphisms( UnderlyingCell( morphism_1 ), UnderlyingCell( morphism_2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return IsCongruentForMorphisms( UnderlyingCell( morphism_1 ), UnderlyingCell( morphism_2 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_ONLY_LEFT_COACTIONS_CATEGORY,
  
  function( left_coactions_category )
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_ONLY_RIGHT_COACTIONS_CATEGORY,
  
  function( right_coactions_category )
  
end );
