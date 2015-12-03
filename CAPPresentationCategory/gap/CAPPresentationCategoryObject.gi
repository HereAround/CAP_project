#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
##  Chapter Objects
##
#############################################################################

DeclareRepresentation( "IsCAPPresentationCategoryObjectRep",
                       IsCAPPresentationCategoryObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPPresentationCategoryObjects",
            NewFamily( "TheFamilyOfCAPPresentationCategoryObjects" ) );

BindGlobal( "TheTypeOfCAPPresentationCategoryObject",
            NewType( TheFamilyOfCAPPresentationCategoryObjects,
                     IsCAPPresentationCategoryObjectRep ) );


DeclareRepresentation( "IsGradedLeftModulePresentationForCAPRep",
                       IsGradedLeftModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedLeftModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftModulePresentationForCAP",
            NewType( TheFamilyOfGradedLeftModulePresentationsForCAP,
                     IsGradedLeftModulePresentationForCAPRep ) );


DeclareRepresentation( "IsGradedRightModulePresentationForCAPRep",
                       IsGradedRightModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedRightModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedRightModulePresentationForCAP",
            NewType( TheFamilyOfGradedRightModulePresentationsForCAP,
                     IsGradedRightModulePresentationForCAPRep ) );



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

    # capture the CapCategory of the presentation morphism
    projective_category := CapCategory( presentation_morphism );

    # check that the input is valid
    if not IsProjCategory( projective_category ) then

      Error( "The argument must be an object in a Proj-category" );
      return;

    fi;

    # then construct the object
    presentation_category_object := rec( );

    # set the type
    if IsCAPCategoryOfProjectiveGradedLeftModulesObject( ZeroObject( projective_category ) ) then
      type := TheTypeOfGradedLeftModulePresentationForCAP;
    elif IsCAPCategoryOfProjectiveGradedRightModulesObject( ZeroObject( projective_category ) ) then
      type := TheTypeOfGradedRightModulePresentationForCAP;
    else
      type := TheTypeOfCAPPresentationCategoryObject;
    fi;

    # objective the presentation_category_object
    ObjectifyWithAttributes( presentation_category_object, type,
                             UnderlyingMorphism, presentation_morphism
    );

    # add it to the presentation category
    category := PresentationCategory( projective_category );
    Add( category, presentation_category_object );
    
    # and return the result
    return presentation_category_object;    

end );    

####################################
##
## View
##
####################################

InstallMethod( String,
              [ IsCAPPresentationCategoryObject ], 999, # FIX ME FIX ME FIX ME

  function( presentation_category_object )
    
     return Concatenation( "An object of the presentation category over the ", 
                           Name( CapCategory( UnderlyingMorphism( presentation_category_object ) ) )
                           );

end );

InstallMethod( String,
              [ IsGradedLeftModulePresentationForCAP ], 999, # FIX ME FIX ME FIX ME

  function( graded_left_module_presentation )
    
     return Concatenation( "A graded left module presentation over the ring ", 
                           RingName( UnderlyingHomalgGradedRing( 
                                     ZeroObject( UnderlyingMorphism( graded_left_module_presentation ) ) ) )
                           );

end );

InstallMethod( String,
              [ IsGradedRightModulePresentationForCAP ], 999, # FIX ME FIX ME FIX ME

  function( graded_right_module_presentation )

     return Concatenation( "A graded right module presentation over the ring ", 
                           RingName( UnderlyingHomalgGradedRing( 
                                     ZeroObject( UnderlyingMorphism( graded_right_module_presentation ) ) ) )
                           );

end );

####################################
##
## Display
##
####################################

InstallMethod( Display,
               [ IsCAPPresentationCategoryObject ], 999, # FIX ME FIX ME FIX ME

  function( presentation_category_object )

     Print( Concatenation( "An object of the presentation category over the ", 
                            Name( CapCategory( UnderlyingMorphism( presentation_category_object ) ) ),
                            ". Presentation: \n"
                            ) );
  
     Display( UnderlyingMorphism( presentation_category_object ) );

end );

InstallMethod( Display,
               [ IsGradedLeftModulePresentationForCAP ], 999, # FIX ME FIX ME FIX ME

  function( graded_left_module_presentation )

     Print( Concatenation( String( graded_left_module_presentation ), " given by the following morphism: \n" ) );
  
     Display( UnderlyingMorphism( graded_left_module_presentation ) );

end );

InstallMethod( Display,
               [ IsGradedRightModulePresentationForCAP ], 999, # FIX ME FIX ME FIX ME

  function( graded_right_module_presentation )

     Print( Concatenation( String( graded_right_module_presentation ), " given by the following morphism: \n" ) );
  
     Display( UnderlyingMorphism( graded_right_module_presentation ) );

end );

####################################
##
## ViewObj
##
####################################

InstallMethod( ViewObj,
               [ IsCAPPresentationCategoryObject ], 999, # FIX ME FIX ME FIX ME

  function( presentation_category_object )

    Print( Concatenation( "<", String( presentation_category_object ), ">" ) );

end );

InstallMethod( ViewObj,
               [ IsGradedLeftModulePresentationForCAP ], 999, # FIX ME FIX ME FIX ME

  function( graded_left_module_presentation )

    Print( Concatenation( "<", String( graded_left_module_presentation ), ">" ) );

end );

InstallMethod( ViewObj,
               [ IsGradedRightModulePresentationForCAP ], 999, # FIX ME FIX ME FIX ME

  function( graded_right_module_presentation )

    Print( Concatenation( "<", String( graded_right_module_presentation ), ">" ) );

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
      local projective_category, adual_as_map_source, adual_as_map_range, adual_as_map, final_mapping;
    
      # (1) turn the underlying morphism of adual into a morphism in PresentationCategory
      projective_category := CapCategory( a )!.underlying_projective_category;
      
      adual_as_map_source := CAPPresentationCategoryObject( 
                     ZeroMorphism( ZeroObject( projective_category ), DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ) );
                                    
      adual_as_map_range := CAPPresentationCategoryObject( 
                    ZeroMorphism( ZeroObject( projective_category ), DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ) );

      adual_as_map := CAPPresentationCategoryMorphism( adual_as_map_source,
                                                       DualOnMorphisms( UnderlyingMorphism( a ) ),
                                                       adual_as_map_range
                                                      );
      
      # (2) tensor adual_as_map with the identity morphism of b
      final_mapping := TensorProductOnMorphisms( adual_as_map, IdentityMorphism( b ) );
      
      # (3) return the kernel embedding
      return KernelEmbedding( final_mapping );
          
end );