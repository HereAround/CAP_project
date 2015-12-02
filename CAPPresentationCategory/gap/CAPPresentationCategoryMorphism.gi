#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
##  Chapter Morphisms
##
#############################################################################

DeclareRepresentation( "IsCAPPresentationCategoryMorphismRep",
                       IsCAPPresentationCategoryMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPPresentationCategoryMorphisms",
            NewFamily( "TheFamilyOfCAPPresentationCategoryMorphisms" ) );

BindGlobal( "TheTypeOfCAPPresentationCategoryMorphism",
            NewType( TheFamilyOfCAPPresentationCategoryMorphisms,
                     IsCAPPresentationCategoryMorphismRep ) );

#############################
##
## Constructors
##
#############################

##
InstallMethod( CAPPresentationCategoryMorphism,
               [ IsCAPPresentationCategoryObject, IsCapCategoryMorphism, IsCAPPresentationCategoryObject ],
               
  function( source, morphism, range )
    #local category, presentation_morphism;
    local presentation_morphism, category; 
    
    # check fi the input data is valid
    if not IsIdenticalObj( CapCategory( UnderlyingMorphism( source ) ), CapCategory( morphism ) ) then
    
      Error( "The morphism and the source do not belong to the same category" );
      return;
    
    elif not IsIdenticalObj( CapCategory( UnderlyingMorphism( range ) ), CapCategory( morphism ) ) then
    
      Error( "The morphism and the range do not belong to the same category" );
      return;
    
    elif not IsEqualForObjects( Range( UnderlyingMorphism( source ) ), Source( morphism ) ) then
    
      Error( "The source of the morphism and the range of the presentation morphism of the source do not match" );
      return;
    
    elif not IsEqualForObjects( Range( UnderlyingMorphism( range ) ), Range( morphism ) ) then
    
      Error( "The range of the morphism and the range of the presentation morphism of the range do not match" );
      return;
    
    fi;
    
    # we found that the input is valid - although we have not yet checked that it is well-defined as well, i.e.
    # that there is a morphism of the sources that makes the following diagram commute
    # source: A --> B
    #               ^
    # mapping:      morphism
    #               |
    # range:  C --> D
    
    # this is to be checked in the IsWellDefined methods
    
    # that said, let us construct the morphism
    presentation_morphism := rec( );       
    ObjectifyWithAttributes( presentation_morphism, TheTypeOfCAPPresentationCategoryMorphism,
                             Source, source,
                             Range, range,
                             UnderlyingMorphism, morphism );

    # then add it to the corresponding category
    category := CapCategory( source );
    Add( category, presentation_morphism );
    
    # and return the object
    return presentation_morphism;
    
end );


####################################
##
## View
##
####################################

InstallMethod( String,
              [ IsCAPPresentationCategoryMorphism ], 999, # FIX ME FIX ME FIX ME
              
  function( presentation_category_morphism )
    
     return Concatenation( "A morphism of the presentation category over the ", 
                           Name( CapCategory( UnderlyingMorphism( presentation_category_morphism ) ) )
                           );
                    
end );


####################################
##
## Display
##
####################################

InstallMethod( Display,
               [ IsCAPPresentationCategoryMorphism ], 999, # FIX ME FIX ME FIX ME
               
  function( presentation_category_morphism )

     Print( Concatenation( "A morphism of the presentation category over the ", 
                            Name( CapCategory( UnderlyingMorphism( presentation_category_morphism ) ) ),
                            ". Presentation: \n"
                            ) );
  
     Display( UnderlyingMorphism( presentation_category_morphism ) );
     
end );


####################################
##
## ViewObj
##
####################################

InstallMethod( ViewObj,
               [ IsCAPPresentationCategoryMorphism ], 999, # FIX ME FIX ME FIX ME
  function( presentation_category_morphism )

    Print( Concatenation( "<", String( presentation_category_morphism ), ">" ) );

end );


#######################################
##
## FullInformationMethod about morphism
##
#######################################

InstallMethod( FullInformation,
               [ IsCAPPresentationCategoryMorphism ],
  function( presentation_category_morphism )

    Print( "\n" );
    Print( "================================================================================= \n \n" );
    
    # Display Source
    Print( "Source: \n" );
    Print( "------- \n" );
    Display( Source( UnderlyingMorphism( Source( presentation_category_morphism ) ) ) );
    Print( "\n" );
    Display( UnderlyingMorphism( Source( presentation_category_morphism ) ) );
    Print( "\n" );
    Display( Range( UnderlyingMorphism( Source( presentation_category_morphism ) ) ) );
    Print( "\n" );
    Print( "--------------------------------------------------------------------------------- \n \n" );
    
    # Display the mapping matrix
    Print( "Mapping matrix: \n" );
    Print( "--------------- \n" );
    Display( UnderlyingMorphism( presentation_category_morphism ) );
    Print( "\n" );
    
    Print( "--------------------------------------------------------------------------------- \n \n" );
    
    # Display the range"
    Print( "Range: \n" );
    Print( "------ \n" );
    Display( Source( UnderlyingMorphism( Range( presentation_category_morphism ) ) ) );
    Print( "\n" );
    Display( UnderlyingMorphism( Range( presentation_category_morphism ) ) );
    Print( "\n" );
    Display( Range( UnderlyingMorphism( Range( presentation_category_morphism ) ) ) );
    Print( "\n" );
    Print( "================================================================================= \n \n" );
    
end );


#######################################################################################################
##
## Install the source-lift as attribute, which is set whenever we check if the morphism is well-defined
##
#######################################################################################################

InstallMethod( SourceLiftMorphism,
                " for morphisms in the presentation category ",
                [ IsCAPPresentationCategoryMorphism ],
  function( morphism )

    # this returns fail if no such lift exists, and we explicitely allow for this return value
    return Lift( PreCompose( UnderlyingMorphism( Source( morphism ) ), UnderlyingMorphism( morphism ) ),
                 UnderlyingMorphism( Range( morphism ) ) );

end );