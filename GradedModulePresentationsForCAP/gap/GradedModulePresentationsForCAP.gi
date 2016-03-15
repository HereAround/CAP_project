#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter The CAP category of graded module presentations for CAP
##
#############################################################################



######################################################################
##
##  Section The GAP Categories for graded module presentations for CAP
##
######################################################################

##
DeclareRepresentation( "IsGradedLeftOrRightModulePresentationForCAPRep",
                       IsGradedLeftOrRightModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftOrRightModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedLeftOrRightModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftOrRightModulePresentationForCAP",
            NewType( TheFamilyOfGradedLeftOrRightModulePresentationsForCAP,
                     IsGradedLeftOrRightModulePresentationForCAPRep ) );

##
DeclareRepresentation( "IsGradedLeftModulePresentationForCAPRep",
                       IsGradedLeftModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedLeftModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftModulePresentationForCAP",
            NewType( TheFamilyOfGradedLeftModulePresentationsForCAP,
                     IsGradedLeftModulePresentationForCAPRep ) );

##
DeclareRepresentation( "IsGradedRightModulePresentationForCAPRep",
                       IsGradedRightModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedRightModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedRightModulePresentationForCAP",
            NewType( TheFamilyOfGradedRightModulePresentationsForCAP,
                     IsGradedRightModulePresentationForCAPRep ) );



######################################################################
##
##  Section The GAP Categories for graded module presentation morphism
##
######################################################################

##
DeclareRepresentation( "IsGradedLeftOrRightModulePresentationMorphismForCAPRep",
                       IsGradedLeftOrRightModulePresentationMorphismForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftOrRightModulePresentationMorphismsForCAP",
            NewFamily( "TheFamilyOfGradedLeftOrRightModulePresentationMorphismsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftOrRightModulePresentationMorphismForCAP",
            NewType( TheFamilyOfGradedLeftOrRightModulePresentationMorphismsForCAP,
                     IsGradedLeftOrRightModulePresentationMorphismForCAPRep ) );

##
DeclareRepresentation( "IsGradedLeftModulePresentationMorphismForCAPRep",
                       IsGradedLeftModulePresentationMorphismForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftModulePresentationMorphismsForCAP",
            NewFamily( "TheFamilyOfGradedLeftModulePresentationMorphismsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftModulePresentationMorphismForCAP",
            NewType( TheFamilyOfGradedLeftModulePresentationMorphismsForCAP,
                     IsGradedLeftModulePresentationMorphismForCAPRep ) );

##
DeclareRepresentation( "IsGradedRightModulePresentationMorphismForCAPRep",
                       IsGradedRightModulePresentationMorphismForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightModulePresentationMorphismsForCAP",
            NewFamily( "TheFamilyOfGradedRightModulePresentationMorphismsForCAP" ) );

BindGlobal( "TheTypeOfGradedRightModulePresentationMorphismForCAP",
            NewType( TheFamilyOfGradedRightModulePresentationMorphismsForCAP,
                     IsGradedRightModulePresentationMorphismForCAPRep ) );



######################################
##
## Section Specialised constructors
##
######################################

##
InstallMethod( CAPPresentationCategoryObject,
               [ IsCapCategoryMorphism and IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism ],
  function( presentation_morphism )
    local category, presentation_category_object, type;

    # compute the category
    if IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( presentation_morphism ) then
      category := SfpgrmodLeft( UnderlyingHomalgGradedRing( presentation_morphism ) );
    else
      category := SfpgrmodRight( UnderlyingHomalgGradedRing( presentation_morphism ) );
    fi;

    # set its type (differing special cases, as defined in SpecialGAPCategories.gd)
    if IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( presentation_morphism ) then
      type := TheTypeOfGradedLeftModulePresentationForCAP;
    else
      type := TheTypeOfGradedRightModulePresentationForCAP;
    fi;

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

##
InstallMethod( CAPPresentationCategoryMorphism,
               [ IsCAPPresentationCategoryObject and IsGradedLeftOrRightModulePresentationForCAP,
                 IsCapCategoryMorphism and IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism,
                 IsCAPPresentationCategoryObject and IsGradedLeftOrRightModulePresentationForCAP ],
  function( source, morphism, range )
    local projective_category, presentation_morphism, category, type;

    # extract the underlying projecitve category
    projective_category := CapCategory( UnderlyingMorphism( source ) );

    # check if the input data is valid
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

    # this is to be checked in the IsWellDefined methods, but will not be performed here (for performance reasons mainly)

    # set the type
    if IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( morphism ) then
      type := TheTypeOfGradedLeftModulePresentationMorphismForCAP;
    else
      type := TheTypeOfGradedRightModulePresentationMorphismForCAP;
    fi;

    # objectify the presentation_morphism
    presentation_morphism := rec( );
    ObjectifyWithAttributes( presentation_morphism, type,
                             Source, source,
                             Range, range,
                             UnderlyingMorphism, morphism );

    # then add it to the corresponding category
    Add( CapCategory( source ), presentation_morphism );

    # and return the object
    return presentation_morphism;

end );

InstallMethod( CAPPresentationCategoryMorphism,
               [ IsCAPPresentationCategoryObject and IsGradedLeftOrRightModulePresentationForCAP ,
                 IsCapCategoryMorphism and IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism,
                 IsCAPPresentationCategoryObject and IsGradedLeftOrRightModulePresentationForCAP,
                 IsBool ],
  function( source, morphism, range, checks_wished )
    local morphism_of_presentations, bool;

    # first construct the object without performing checks
    morphism_of_presentations := CAPPresentationCategoryMorphism( source, morphism, range );

    # now perform the checks, if wished for
    if checks_wished then
      bool := IsWellDefinedForMorphisms( morphism_of_presentations );

      if bool then
        return morphism_of_presentations;
      else
        Error( "The given data does not specify a morphism of graded module presentations" );
        return;
      fi;

    else
      return morphism_of_presentations;
    fi;

end );



######################################
##
## Section Specialised view methods
##
######################################

InstallMethod( String,
              [ IsGradedLeftModulePresentationForCAP and IsCAPPresentationCategoryObject ],
  function( graded_left_module_presentation )

     return Concatenation( "A graded left module presentation over the ring ", 
                           RingName( UnderlyingHomalgGradedRing( 
                                     ZeroObject( UnderlyingMorphism( graded_left_module_presentation ) ) ) )
                           );

end );

InstallMethod( String,
              [ IsGradedRightModulePresentationForCAP and IsCAPPresentationCategoryObject ],
  function( graded_right_module_presentation )

     return Concatenation( "A graded right module presentation over the ring ", 
                           RingName( UnderlyingHomalgGradedRing( 
                                     ZeroObject( UnderlyingMorphism( graded_right_module_presentation ) ) ) )
                           );

end );

InstallMethod( String,
              [ IsGradedLeftModulePresentationMorphismForCAP and IsCAPPresentationCategoryMorphism ], 
  function( graded_left_module_presentation_morphism )

     return Concatenation( "A morphism of graded left module presentations over ",
                            RingName( UnderlyingHomalgGradedRing( 
                                     ZeroObject( UnderlyingMorphism( graded_left_module_presentation_morphism ) ) ) )
                           );

end );

InstallMethod( String,
              [ IsGradedRightModulePresentationMorphismForCAP and IsCAPPresentationCategoryMorphism ], 
  function( graded_right_module_presentation_morphism )

     return Concatenation( "A morphism of graded right module presentations over ", 
                            RingName( UnderlyingHomalgGradedRing( 
                                     ZeroObject( UnderlyingMorphism( graded_right_module_presentation_morphism ) ) ) )
                           );

end );



######################################
##
## Section Specialised display methods
##
######################################

InstallMethod( Display,
               [ IsGradedLeftModulePresentationForCAP and IsCAPPresentationCategoryObject ],
  function( graded_left_module_presentation )

     Print( Concatenation( String( graded_left_module_presentation ), " given by the following morphism: \n" ) );

     Display( UnderlyingMorphism( graded_left_module_presentation ) );

end );

InstallMethod( Display,
               [ IsGradedRightModulePresentationForCAP and IsCAPPresentationCategoryObject ],
  function( graded_right_module_presentation )

     Print( Concatenation( String( graded_right_module_presentation ), " given by the following morphism: \n" ) );

     Display( UnderlyingMorphism( graded_right_module_presentation ) );

end );

InstallMethod( Display,
               [ IsGradedLeftModulePresentationMorphismForCAP and IsCAPPresentationCategoryMorphism ], 
  function( graded_left_module_presentation_morphism )

     Print( Concatenation( "A morphism of graded left module presentations over ",
                            RingName( UnderlyingHomalgGradedRing( 
                                     ZeroObject( UnderlyingMorphism( graded_left_module_presentation_morphism ) ) ) ),
                            " given by the following morphism: \n"
                            ) );

     Display( UnderlyingMorphism( graded_left_module_presentation_morphism ) );

end );

InstallMethod( Display,
               [ IsGradedRightModulePresentationMorphismForCAP and IsCAPPresentationCategoryMorphism ], 
  function( graded_right_module_presentation_morphism )

     Print( Concatenation( "A morphism of graded right module presentations over ",
                            RingName( UnderlyingHomalgGradedRing( 
                                     ZeroObject( UnderlyingMorphism( graded_right_module_presentation_morphism ) ) ) ),
                            " given by the following morphism: \n"
                            ) );

     Display( UnderlyingMorphism( graded_right_module_presentation_morphism ) );

end );



######################################
##
## Section Specialised ViewObj methods
##
######################################

InstallMethod( ViewObj,
               [ IsGradedLeftModulePresentationForCAP and IsCAPPresentationCategoryObject ],
  function( graded_left_module_presentation )

    Print( Concatenation( "<", String( graded_left_module_presentation ), ">" ) );

end );

InstallMethod( ViewObj,
               [ IsGradedRightModulePresentationForCAP and IsCAPPresentationCategoryObject ],
  function( graded_right_module_presentation )

    Print( Concatenation( "<", String( graded_right_module_presentation ), ">" ) );

end );

InstallMethod( ViewObj,
               [ IsGradedLeftModulePresentationMorphismForCAP and IsCAPPresentationCategoryMorphism ], 
  function( graded_left_module_presentation_morphism )

    Print( Concatenation( "<", String( graded_left_module_presentation_morphism ), ">" ) );

end );

InstallMethod( ViewObj,
               [ IsGradedRightModulePresentationMorphismForCAP and IsCAPPresentationCategoryMorphism ], 
  function( graded_right_module_presentation_morphism )

    Print( Concatenation( "<", String( graded_right_module_presentation_morphism ), ">" ) );

end );



######################################
##
## Section CAP categories
##
######################################

# compute the category S-fpgrmod for a toric variety
InstallMethod( SfpgrmodLeft,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )
    local projective_category, category;

      # identify the underlying proj category
      projective_category := CAPCategoryOfProjectiveGradedLeftModules( graded_ring );

      # set the category
      category := CreateCapCategory( Concatenation( "Category of graded left module presentations over ",
                                                    RingName( graded_ring ) ) );

      # set properties of the category
      category!.underlying_projective_category := projective_category; # <- underlying Proj-category
      category!.constructor_checks_wished := true; # <- false means that no consistency checks are performed in construtors
      SetIsAbelianCategory( category, true );

      # add basic functionality for the category
      ADD_BASIC_FUNCTIONS_FOR_PRESENTATION_CATEGORY( category, category!.constructor_checks_wished );

      # install more functionality and more properties
      ADD_MONOIDAL_FUNCTIONS_FOR_PRESENTATION_CATEGORY( category, category!.constructor_checks_wished );
      SetIsSymmetricClosedMonoidalCategory( category, true );
      SetIsStrictMonoidalCategory( category, true );

      # (6) add logic
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

      # finalise and return
      Finalize( category );
      return category;

end );

# compute the category S-fpgrmod for a toric variety
InstallMethod( SfpgrmodRight,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )
    local projective_category, category;

      # identify the underlying proj category
      projective_category := CAPCategoryOfProjectiveGradedRightModules( graded_ring );

      # set the category
      category := CreateCapCategory( Concatenation( "Category of graded right module presentations over ",
                                                    RingName( graded_ring ) ) );

      # set properties of the category
      category!.underlying_projective_category := projective_category; # <- underlying Proj-category
      category!.constructor_checks_wished := true; # <- false means that no consistency checks are performed in construtors
      SetIsAbelianCategory( category, true );

      # add basic functionality for the category
      ADD_BASIC_FUNCTIONS_FOR_PRESENTATION_CATEGORY( category, category!.constructor_checks_wished );

      # install more functionality and more properties
      ADD_MONOIDAL_FUNCTIONS_FOR_PRESENTATION_CATEGORY( category, category!.constructor_checks_wished );
      SetIsSymmetricClosedMonoidalCategory( category, true );
      SetIsStrictMonoidalCategory( category, true );

      # (6) add logic
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

      # finalise and return
      Finalize( category );
      return category;

end );



##############################################
##
## HOM-Embedding for convenience
##
##############################################

#
InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT,
                           [ IsGradedLeftModulePresentationForCAP, IsGradedLeftModulePresentationForCAP ],
    function( a, b )
      local range, source, map, emb_matrix, emb_map, kernel_relations, kernel;

      # Let a = ( R_A --- alpha ---> A ) and b = (R_B --- beta ---> B ). Then we have to compute the kernel embedding of the
      # following map:
      #
      # A^v \otimes R_B -----------alpha^v \otimes id_{R_B} --------------> R_A^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{A^v} \otimes beta                                            id_{R_A^v} \otimes beta
      #       |                                                                      |
      #       v                                                                      v
      # A^v \otimes B -------------- alpha^v \otimes id_B -------------------> R_A^v \otimes B
      #

      # compute this map
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( a ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( b ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );

      # take a smaller presentation (if possible)
      map := ByASmallerPresentation( map );

      # and return its kernel embedding
      return KernelEmbedding( map );

end );

#
InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT,
                           [ IsGradedRightModulePresentationForCAP, IsGradedRightModulePresentationForCAP ],
    function( a, b )
      local range, source, map;

      # Let a = ( R_A --- alpha ---> A ) and b = (R_B --- beta ---> B ). Then we have to compute the kernel embedding of the
      # following map:
      #
      # A^v \otimes R_B -----------alpha^v \otimes id_{R_B} --------------> R_A^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{A^v} \otimes beta                                            id_{R_A^v} \otimes beta
      #       |                                                                      |
      #       v                                                                      v
      # A^v \otimes B -------------- alpha^v \otimes id_B -------------------> R_A^v \otimes B
      #

      # compute this map
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( a ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( b ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );

      # take a smaller presentation (if possible)
      map := ByASmallerPresentation( map );

      # and return its kernel embedding
      return KernelEmbedding( map );

end );