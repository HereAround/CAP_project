#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
##  Chapter Objects
##
#############################################################################



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

    # and "try" to compute its presentation category
    # should the given category not be a proj-category, then this command will cause an error
    category := PresentationCategory( projective_category );

    # now initialise the object
    presentation_category_object := rec( );

    # set its type (differing special cases, as defined in SpecialGAPCategories.gd)
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
              #999, # FIXME FIXME
  function( presentation_category_object )

     return Concatenation( "An object of the presentation category over the ", 
                           Name( CapCategory( UnderlyingMorphism( presentation_category_object ) ) )
                           );

end );

InstallMethod( String,
              [ IsGradedLeftModulePresentationForCAP and IsCAPPresentationCategoryObject ],
              #999, # FIXME FIXME
  function( graded_left_module_presentation )

     return Concatenation( "A graded left module presentation over the ring ", 
                           RingName( UnderlyingHomalgGradedRing( 
                                     ZeroObject( UnderlyingMorphism( graded_left_module_presentation ) ) ) )
                           );

end );

InstallMethod( String,
              [ IsGradedRightModulePresentationForCAP and IsCAPPresentationCategoryObject ],
              #999, # FIXME FIXME
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
               [ IsCAPPresentationCategoryObject ],
               #999, # FIXME FIXME
  function( presentation_category_object )

     Print( Concatenation( "An object of the presentation category over the ", 
                            Name( CapCategory( UnderlyingMorphism( presentation_category_object ) ) ),
                            ". Presentation: \n"
                            ) );
  
     Display( UnderlyingMorphism( presentation_category_object ) );

end );

InstallMethod( Display,
               [ IsGradedLeftModulePresentationForCAP and IsCAPPresentationCategoryObject ],
               #999, # FIXME FIXME
  function( graded_left_module_presentation )

     Print( Concatenation( String( graded_left_module_presentation ), " given by the following morphism: \n" ) );
  
     Display( UnderlyingMorphism( graded_left_module_presentation ) );

end );

InstallMethod( Display,
               [ IsGradedRightModulePresentationForCAP and IsCAPPresentationCategoryObject ],
               #999, # FIXME FIXME
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
               [ IsCAPPresentationCategoryObject ],
               #999, # FIXME FIXME
  function( presentation_category_object )

    Print( Concatenation( "<", String( presentation_category_object ), ">" ) );

end );

InstallMethod( ViewObj,
               [ IsGradedLeftModulePresentationForCAP and IsCAPPresentationCategoryObject ],
               #999, # FIXME FIXME
  function( graded_left_module_presentation )

    Print( Concatenation( "<", String( graded_left_module_presentation ), ">" ) );

end );

InstallMethod( ViewObj,
               [ IsGradedRightModulePresentationForCAP and IsCAPPresentationCategoryObject ],
               #999, # FIXME FIXME
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