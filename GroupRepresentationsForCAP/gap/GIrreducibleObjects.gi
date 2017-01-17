#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#! @Chapter Irreducible Objects
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsGIrreducibleObjectRep",
                       IsGIrreducibleObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGIrreducibleObjects",
        NewFamily( "TheFamilyOfGIrreducibleObjects" ) );

BindGlobal( "TheTypeOfGIrreducibleObjects",
        NewType( TheFamilyOfGIrreducibleObjects,
                IsGIrreducibleObjectRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( GIrreducibleObject,
               [ IsCharacter ],
               
  function( character )
    local irreducible_object, number, underlying_character_table, underlying_irreducible_characters;
    
    irreducible_object := rec( );
    
    underlying_character_table := UnderlyingCharacterTable( character );
    
    underlying_irreducible_characters := Irr( underlying_character_table );
    
    number := PositionProperty( underlying_irreducible_characters, chi -> chi = character );
    
    ObjectifyWithAttributes( irreducible_object, TheTypeOfGIrreducibleObjects,
                             UnderlyingCharacter, character,
                             UnderlyingCharacterNumber, number,
                             UnderlyingGroup, UnderlyingGroup( character ),
                             UnderlyingCharacterTable, underlying_character_table,
                             UnderlyingIrreducibleCharacters, underlying_irreducible_characters
    );
    
    return irreducible_object;
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( ExteriorPower,
               [ IsGIrreducibleObject ],
               
  function( object )
    local character, ct, irr, exterior_power, chi, scalar_product, result_list;
    
    result_list := [ ];
    
    character := UnderlyingCharacter( object );
    
    ct := UnderlyingCharacterTable( object );
    
    irr := UnderlyingIrreducibleCharacters( object );
    
    exterior_power :=
      AntiSymmetricParts( ct, [ character ], 2 );
    
    exterior_power := exterior_power[1];
    
    for chi in irr do
        
        scalar_product := ScalarProduct( chi, exterior_power );
        
        if scalar_product > 0 then
            
            Add( result_list, [ scalar_product, GIrreducibleObject( chi ) ] );
            
        fi;
        
    od;
    
    return result_list;
    
end );

##
InstallMethod( Dimension,
               [ IsGIrreducibleObject ],
               
  function( object )
    
    return Degree( UnderlyingCharacter( object ) );
    
end );

##
InstallMethod( Dual,
               [ IsGIrreducibleObject ],
               
  function( object )
    
    return GIrreducibleObject( ComplexConjugate( UnderlyingCharacter( object ) ) );
    
end );

####################################
##
## Operations
##
####################################

##
InstallMethod( \=,
               [ IsGIrreducibleObject, IsGIrreducibleObject ],
               
  function( object_1, object_2 )
    
    return UnderlyingCharacterNumber( object_1 ) = UnderlyingCharacterNumber( object_2 );
    
end );

# ##
# InstallMethod( LT,
#                [ IsGIrreducibleObject, IsGIrreducibleObject ],
#                
#   function( object_1, object_2 )
#     
#     return UnderlyingCharacterNumber( object_1 ) < UnderlyingCharacterNumber( object_2 );
#     
# end );

##
InstallMethod( Multiplicity,
               [ IsGIrreducibleObject, IsGIrreducibleObject, IsGIrreducibleObject ],
               
  function( object_1, object_2, object_3 )
    local tensor_product;
    
    tensor_product := UnderlyingCharacter( object_2 ) * UnderlyingCharacter( object_3 );
    
    return ScalarProduct( UnderlyingCharacter( object_1 ), tensor_product );
    
end );

##
InstallMethod( \*,
               [ IsGIrreducibleObject, IsGIrreducibleObject ],
               
  function( object_1, object_2 )
    local tensor_product, result_list, irr, chi, scalar_product;
    
    tensor_product := UnderlyingCharacter( object_1 ) * UnderlyingCharacter( object_2 );
    
    result_list := [ ];
    
    irr := UnderlyingIrreducibleCharacters( object_1 );
    
    for chi in irr do
        
        scalar_product := ScalarProduct( chi, tensor_product );
        
        if scalar_product > 0 then
            
            Add( result_list, [ scalar_product, GIrreducibleObject( chi ) ] );
            
        fi;
        
    od;
    
    return result_list;
    
end );

##
InstallMethod( AssociatorFromData,
               [ IsGIrreducibleObject, IsGIrreducibleObject, IsGIrreducibleObject, IsList, IsFieldForHomalg, IsList ],
               
  function( irr_1, irr_2, irr_3, associator_data, field, tensor_decomposition_list )
    local data, morphism_list, elem, pos, string, homalg_matrix, vector_space;
    
    data :=
        associator_data[UnderlyingCharacterNumber( irr_1 )][UnderlyingCharacterNumber( irr_2 )][UnderlyingCharacterNumber( irr_3 )];
    
    morphism_list := [ ];
    
    for elem in tensor_decomposition_list do
        
        pos := UnderlyingCharacterNumber( elem[2] );
        
        string := Concatenation( "[", data[pos], "]" );
        
        homalg_matrix := HomalgMatrix( string, elem[1], elem[1], field );
        
        vector_space := VectorSpaceObject( elem[1], field );
        
        Add( morphism_list, [ VectorSpaceMorphism( vector_space, homalg_matrix, vector_space ), elem[2] ] );
        
    od;
    
    return morphism_list;
    
end );

####################################
##
## Properties
##
####################################

InstallMethod( IsOne,
               [ IsGIrreducibleObject ],
               
  function( object )
    
    return IsOne( UnderlyingCharacter( object ) );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( String,
              [ IsGIrreducibleObject ],
              
  function( object )
    
    return String( UnderlyingCharacterNumber( object ) );
    
end );

##
InstallMethod( ViewObj,
               [ IsGIrreducibleObject ],

  function( object )

    Print( Concatenation( "<χ_", String( object ), ">" ) );

end );
