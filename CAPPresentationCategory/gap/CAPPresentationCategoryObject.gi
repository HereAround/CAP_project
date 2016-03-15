#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
##  Chapter Objects
##
#############################################################################



#######################################################
##
## The GAP Categories for presentation category objects
##
#######################################################

DeclareRepresentation( "IsCAPPresentationCategoryObjectRep",
                       IsCAPPresentationCategoryObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPPresentationCategoryObjects",
            NewFamily( "TheFamilyOfCAPPresentationCategoryObjects" ) );

BindGlobal( "TheTypeOfCAPPresentationCategoryObject",
            NewType( TheFamilyOfCAPPresentationCategoryObjects,
                     IsCAPPresentationCategoryObjectRep ) );



#############################
##
## Constructors
##
#############################

##
InstallMethod( CAPPresentationCategoryObject,
               [ IsCapCategoryMorphism ],
  function( presentation_morphism )
    local projective_category, category, presentation_category_object, type;

    # "try" to compute its presentation category
    # should the given category not be a proj-category, then this command will cause an error
    category := PresentationCategory( CapCategory( presentation_morphism ) );

    # set its type
    type := TheTypeOfCAPPresentationCategoryObject;

    # objective the presentation_category_object
    presentation_category_object := rec( );
    ObjectifyWithAttributes( presentation_category_object, type,
                             UnderlyingMorphism, presentation_morphism
    );

    # add it to the presentation category
    Add( category, presentation_category_object );

    # and return it
    return presentation_category_object;    

end );



####################################
##
## View
##
####################################

InstallMethod( String,
              [ IsCAPPresentationCategoryObject ],
  function( presentation_category_object )

     return Concatenation( "An object of the presentation category over the ", 
                           Name( CapCategory( UnderlyingMorphism( presentation_category_object ) ) )
                           );

end );



####################################
##
## Display
##
####################################

InstallMethod( Display,
               [ IsCAPPresentationCategoryObject ],
  function( presentation_category_object )

     Print( Concatenation( "An object of the presentation category over the ", 
                            Name( CapCategory( UnderlyingMorphism( presentation_category_object ) ) ),
                            ". Presentation: \n"
                            ) );
  
     Display( UnderlyingMorphism( presentation_category_object ) );

end );



####################################
##
## ViewObj
##
####################################

InstallMethod( ViewObj,
               [ IsCAPPresentationCategoryObject ],
  function( presentation_category_object )

    Print( Concatenation( "<", String( presentation_category_object ), ">" ) );

end );



#######################################
##
## FullInformationMethod about object
##
#######################################

InstallMethod( FullInformation,
               [ IsCAPPresentationCategoryObject ],
  function( presentation_category_object )

    Print( "\n" );
    Print( "================================================================================= \n \n" );

    Display( Source( UnderlyingMorphism( presentation_category_object ) ) );
    Print( "\n" );
    Display( UnderlyingMorphism( presentation_category_object ) );
    Print( "\n" );
    Display( Range( UnderlyingMorphism( presentation_category_object ) ) ); 
    Print( "\n" );
    
    Print( "================================================================================= \n \n" );
    
end );



##############################################
##
## HOM-Embedding for convenience
##
##############################################

##
InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT,
                           [ IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ],
    function( a, b )
      local source, range, underlying_map, final_mapping;

      # (1) construct the map
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms( 
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      underlying_map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( a ) ), 
                                                 IdentityMorphism( Range( UnderlyingMorphism( b ) ) )
                                                );
      final_mapping := CAPPresentationCategoryMorphism( source, 
                                                        underlying_map, 
                                                        range, 
                                                        CapCategory( a )!.constructor_checks_wished 
                                                       );

      # (2) and return its kernel embedding
      return KernelEmbedding( final_mapping );

end );