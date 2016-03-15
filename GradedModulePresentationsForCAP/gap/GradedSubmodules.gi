#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter Graded submodules of projective graded modules over a graded ring
##
#############################################################################



##############################################################################################
##
##  Section GAP category of graded submodules for CAP
##
##############################################################################################

# install graded left submodules for CAP
DeclareRepresentation( "IsGradedLeftSubmoduleForCAPRep",
                       IsGradedLeftSubmoduleForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftSubmodulesForCAP",
            NewFamily( "TheFamilyOfGradedLeftSubmodulesForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftSubmoduleForCAP",
            NewType( TheFamilyOfGradedLeftSubmodulesForCAP,
                     IsGradedLeftSubmoduleForCAPRep ) );

# install graded right submodules for CAP
DeclareRepresentation( "IsGradedRightSubmoduleForCAPRep",
                       IsGradedRightSubmoduleForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightSubmodulesForCAP",
            NewFamily( "TheFamilyOfGradedRightSubmodulesForCAP" ) );

BindGlobal( "TheTypeOfGradedRightSubmoduleForCAP",
            NewType( TheFamilyOfGradedRightSubmodulesForCAP,
                     IsGradedRightSubmoduleForCAPRep ) );

# install graded left or right submodules for CAP
DeclareRepresentation( "IsGradedLeftOrRightSubmoduleForCAPRep",
                       IsGradedLeftOrRightSubmoduleForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftOrRightSubmodulesForCAP",
            NewFamily( "TheFamilyOfGradedLeftOrRightSubmodulesForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftOrRightSubmoduleForCAP",
            NewType( TheFamilyOfGradedLeftOrRightSubmodulesForCAP,
                     IsGradedLeftOrRightSubmoduleForCAPRep ) );



##############################################################################################
##
## Section GAP category of graded ideals for CAP
##
##############################################################################################

# install graded left ideals for CAP
DeclareRepresentation( "IsGradedLeftIdealForCAPRep",
                       IsGradedLeftIdealForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftIdealsForCAP",
            NewFamily( "TheFamilyOfGradedLeftIdealsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftIdealForCAP",
            NewType( TheFamilyOfGradedLeftIdealsForCAP,
                     IsGradedLeftIdealForCAPRep ) );

# install graded right ideals for CAP
DeclareRepresentation( "IsGradedRightIdealForCAPRep",
                       IsGradedRightIdealForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightIdealsForCAP",
            NewFamily( "TheFamilyOfGradedRightIdealsForCAP" ) );

BindGlobal( "TheTypeOfGradedRightIdealForCAP",
            NewType( TheFamilyOfGradedRightIdealsForCAP,
                     IsGradedRightIdealForCAPRep ) );

# install graded left ideals for CAP
DeclareRepresentation( "IsGradedLeftOrRightIdealForCAPRep",
                       IsGradedLeftOrRightIdealForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftOrRightIdealsForCAP",
            NewFamily( "TheFamilyOfGradedLeftOrRightIdealsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftOrRightIdealForCAP",
            NewType( TheFamilyOfGradedLeftOrRightIdealsForCAP,
                     IsGradedLeftOrRightIdealForCAPRep ) );



##############################################################################################
##
#! @Section Constructors for graded submodules from a list list and a graded ring
##
##############################################################################################

# compute graded submodules from morphisms of projective modules
InstallGlobalFunction( GradedSubmoduleFromListListAndGradedRing,
  function( generator_list, homalg_graded_ring, left )
    local graded_submodule, matrix, range, alpha, pres, embedding, type;

    if not IsFree( DegreeGroup( homalg_graded_ring ) ) then

      Error( "Currently this operation is only defined for rings with a free degree_group" );
      return;

    fi;

    # construct the graded module morphism encoded by 'generator_list'
    matrix := HomalgMatrix( generator_list, homalg_graded_ring );

    # construct the range and alpha
    if left then
      range := CAPCategoryOfProjectiveGradedLeftModulesObject(
                         [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), NrColumns( matrix ) ] ],
                         homalg_graded_ring
                         );

      alpha := DeduceMapFromMatrixAndRangeLeft( matrix, range );

      if not IsWellDefined( alpha ) then
        Error( "Cannot deduce underlying morphism of projective graded modules from the given input." );
        return;
      fi;

    else
      range := CAPCategoryOfProjectiveGradedRightModulesObject(
                         [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), NrRows( matrix ) ] ],
                         homalg_graded_ring
                         );

      alpha := DeduceMapFromMatrixAndRangeRight( matrix, range );

      if not IsWellDefined( alpha ) then
        Error( "Cannot deduce underlying morphism of projective graded modules from the given input." );
        return;
      fi;

    fi;

    # we are thus looking at the following diagram
    #     ?                           0
    #     |                           |
    # ?-mapping (=pres)         zero_morphism
    #     |                           |
    #     v                           v
    #     ? -------- alpha -------> range
    #
    # We construct the two ? and the ?-mapping as the pullback of zero_morphism and alpha. This amounts to computing the
    # kernel embedding of alpha and identifying it with ?-mapping. This is therefore what we do.

    # now compute the presentation of the ideal
    pres := CAPPresentationCategoryObject( KernelEmbedding( alpha ) );

    # compute the embedding
    range := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
    embedding := CAPPresentationCategoryMorphism( pres,
                                                  alpha,
                                                  range,
                                                  CapCategory( pres )!.constructor_checks_wished
                                                 );

    # determine the type
    if left then
      if Rank( Range( UnderlyingMorphism( range ) ) ) = 1 then
        type := TheTypeOfGradedLeftIdealForCAP;
      else
        type := TheTypeOfGradedLeftSubmoduleForCAP;
      fi;
    else
      if Rank( Range( UnderlyingMorphism( range ) ) ) = 1 then
        type := TheTypeOfGradedRightIdealForCAP;
      else
        type := TheTypeOfGradedRightSubmoduleForCAP;
      fi;
    fi;
    
    # now define the graded_submodule
    graded_submodule := rec( );    
    ObjectifyWithAttributes( graded_submodule, type,
                             PresentationForCAP, pres,
                             Generators, generator_list,
                             HomalgGradedRing, homalg_graded_ring,
                             EmbeddingInSuperObjectForCAP, embedding,
                             SuperObjectForCAP, Range( embedding )
                            );

    # and finally return it
    return graded_submodule;

end );

# constructor for graded left submodules
InstallMethod( GradedLeftSubmoduleForCAP,
               " a list of generators and a homalg graded ring",
               [ IsList, IsHomalgGradedRing ],
  function( generator_list, homalg_graded_ring )
  
    return GradedSubmoduleFromListListAndGradedRing( generator_list, homalg_graded_ring, true );

end );


# constructor for graded right-ideals
InstallMethod( GradedRightSubmoduleForCAP,
               " a list of generators and a homalg graded ring",
               [ IsList, IsHomalgGradedRing ],
  function( generator_list, homalg_graded_ring )               

    return GradedSubmoduleFromListListAndGradedRing( generator_list, homalg_graded_ring, false );

end );



###############################################################################################
##
#! @Section Constructors for graded submodules from a list of lists and a specified superobject
##
###############################################################################################

# a function that computes a graded submodule from a list of generators and a specified superobject
InstallGlobalFunction( GradedSubmoduleFromListListAndGivenRange,
  function( generator_list, range, left )
    local homalg_graded_ring, graded_submodule, matrix, alpha, pres, embedding, type;

    # extract the graded ring
    homalg_graded_ring := UnderlyingHomalgGradedRing( range );

    # construct the graded module morphism encoded by 'generator_list'
    matrix := HomalgMatrix( generator_list, homalg_graded_ring );

    # now define alpha
    if left then
      alpha := DeduceMapFromMatrixAndRangeLeft( matrix, range );
    else
      alpha := DeduceMapFromMatrixAndRangeRight( matrix, range );
    fi;

    # we are thus looking at the following diagram
    #     ?                           0
    #     |                           |
    # ?-mapping (=pres)         zero_morphism
    #     |                           |
    #     v                           v
    #     ? -------- alpha -------> range
    #
    # We construct the two ? and the ?-mapping as the pullback of zero_morphism and alpha. This amounts to computing the
    # kernel embedding of alpha and identifying it with ?-mapping. This is therefore what we do.

    # now compute the presentation of the ideal
    pres := CAPPresentationCategoryObject( KernelEmbedding( alpha ) );

    # compute the embedding
    range := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
    embedding := CAPPresentationCategoryMorphism( pres,
                                                  alpha,
                                                  range,
                                                  CapCategory( pres )!.constructor_checks_wished
                                                 );

    # determine the type
    if left then
      if Rank( Range( UnderlyingMorphism( range ) ) ) = 1 then
        type := TheTypeOfGradedLeftIdealForCAP;
      else
        type := TheTypeOfGradedLeftSubmoduleForCAP;
      fi;
    else
      if Rank( Range( UnderlyingMorphism( range ) ) ) = 1 then
        type := TheTypeOfGradedRightIdealForCAP;
      else
        type := TheTypeOfGradedRightSubmoduleForCAP;
      fi;
    fi;
    
    # now define the graded_submodule
    graded_submodule := rec( );
    ObjectifyWithAttributes( graded_submodule, type,
                             PresentationForCAP, pres,
                             Generators, generator_list,
                             HomalgGradedRing, homalg_graded_ring,
                             EmbeddingInSuperObjectForCAP, embedding,
                             SuperObjectForCAP, Range( embedding )
                            );

      # and finally return it
      return graded_submodule;  

end );

# constructor for graded right submodules with given range
InstallMethod( GradedLeftSubmoduleForCAP,
               " a list of generators and a projective graded left module",
               [ IsList, IsCAPCategoryOfProjectiveGradedLeftModulesObject ],
  function( generator_list, range )

    return GradedSubmoduleFromListListAndGivenRange( generator_list, range, true );

end );

# constructor for graded right submodules with given range
InstallMethod( GradedRightSubmoduleForCAP,
               " a list of generators and a projective graded right module",
               [ IsList, IsCAPCategoryOfProjectiveGradedRightModulesObject ],
  function( generator_list, range )               

    return GradedSubmoduleFromListListAndGivenRange( generator_list, range, false );

end );



##############################################################################################
##
#! @Section Constructors for graded submodules from a morphism
##
##############################################################################################

# compute graded submodules from morphisms of projective modules
InstallGlobalFunction( GradedSubmoduleFromMorphism,
  function( alpha, left )
    local pres, range, embedding, graded_submodule, type;

    # we are thus looking at the following diagram
    #     ?                           0
    #     |                           |
    # ?-mapping (=pres)         zero_morphism
    #     |                           |
    #     v                           v
    #     ? -------- alpha -------> range
    #
    # We construct the two ? and the ?-mapping as the pullback of zero_morphism and alpha. This amounts to computing the
    # kernel embedding of alpha and identifying it with ?-mapping. This is therefore what we do.
    
    # now compute the presentation of the ideal
    pres := CAPPresentationCategoryObject( KernelEmbedding( alpha ) );
    
    # compute the embedding
    range := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( alpha ) ), Range( alpha ) ) );
    embedding := CAPPresentationCategoryMorphism( pres,
                                                  alpha,
                                                  range,
                                                  CapCategory( pres )!.constructor_checks_wished
                                                 );

    # determine the type
    if left then
      if Rank( Range( UnderlyingMorphism( range ) ) ) = 1 then
        type := TheTypeOfGradedLeftIdealForCAP;
      else
        type := TheTypeOfGradedLeftSubmoduleForCAP;
      fi;
    else
      if Rank( Range( UnderlyingMorphism( range ) ) ) = 1 then
        type := TheTypeOfGradedRightIdealForCAP;
      else
        type := TheTypeOfGradedRightSubmoduleForCAP;
      fi;
    fi;
        
    # now define the graded_submodule
    graded_submodule := rec( );
    ObjectifyWithAttributes( graded_submodule, type,
                             PresentationForCAP, pres,
                             Generators, EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( alpha ) ),
                             HomalgGradedRing, UnderlyingHomalgGradedRing( alpha ),
                             EmbeddingInSuperObjectForCAP, embedding,
                             SuperObjectForCAP, Range( embedding )
                             );

    # and finally return it
    return graded_submodule;  

end );

InstallMethod( GradedLeftSubmoduleForCAP,
               " a morphism of projective graded right modules ",
               [ IsCAPCategoryOfProjectiveGradedLeftModulesMorphism ],
  function( alpha )

    return GradedSubmoduleFromMorphism( alpha, true );

end );

InstallMethod( GradedRightSubmoduleForCAP,
               " a morphism of projective graded right modules ",
               [ IsCAPCategoryOfProjectiveGradedRightModulesMorphism ],
  function( alpha )

    return GradedSubmoduleFromMorphism( alpha, false );

end );



################################################
##
## Section String methods for the new categories
##
################################################

InstallMethod( String,
              [ IsGradedLeftSubmoduleForCAP and IsGradedLeftModulePresentationForCAP ],
  function( graded_left_submodule )
    
     return Concatenation( "A graded left submodule over ", RingName( HomalgGradedRing( graded_left_submodule ) ) );

end );

InstallMethod( String,
              [ IsGradedLeftIdealForCAP and IsGradedLeftSubmoduleForCAP and IsGradedLeftModulePresentationForCAP ],
  function( graded_left_ideal )
    
     return Concatenation( "A graded left ideal of ", RingName( HomalgGradedRing( graded_left_ideal ) ) );

end );

InstallMethod( String,
              [ IsGradedRightSubmoduleForCAP and IsGradedRightModulePresentationForCAP ],
  function( graded_right_submodule )
    
     return Concatenation( "A graded right submodule over ", RingName( HomalgGradedRing( graded_right_submodule ) ) );

end );

InstallMethod( String,
              [ IsGradedRightIdealForCAP and IsGradedRightSubmoduleForCAP and IsGradedRightModulePresentationForCAP ],
  function( graded_right_ideal )
    
     return Concatenation( "A graded right ideal of ", RingName( HomalgGradedRing( graded_right_ideal ) ) );

end );



#################################################
##
## Section Display methods for the new categories
##
#################################################

InstallMethod( Display,
              [ IsGradedLeftSubmoduleForCAP and IsGradedLeftModulePresentationForCAP ],
  function( graded_left_submodule )
    
     Print( Concatenation( "A graded left submodule over ", 
                           RingName( HomalgGradedRing( graded_left_submodule ) ),
                           " generated by ",
                           String( Generators( graded_left_submodule ) )
                          ) 
                        );

end );

InstallMethod( Display,
              [ IsGradedLeftIdealForCAP and IsGradedLeftSubmoduleForCAP and IsGradedLeftModulePresentationForCAP ],
  function( graded_left_ideal )
    
     Print( Concatenation( "A graded left ideal of ", 
                           RingName( HomalgGradedRing( graded_left_ideal ) ),
                           " generated by ",
                           String( Generators( graded_left_ideal ) )
                          ) 
                        );

end );

InstallMethod( Display,
              [ IsGradedRightSubmoduleForCAP and IsGradedRightModulePresentationForCAP ],
  function( graded_right_submodule )
    
     Print( Concatenation( "A graded right submodule over ", 
                           RingName( HomalgGradedRing( graded_right_submodule ) ),
                           " generated by ",
                           String( Generators( graded_right_submodule ) )
                          ) 
                        );

end );

InstallMethod( Display,
              [ IsGradedRightIdealForCAP and IsGradedRightSubmoduleForCAP and IsGradedRightModulePresentationForCAP ],
  function( graded_right_ideal )
    
     Print( Concatenation( "A graded right ideal of ", 
                           RingName( HomalgGradedRing( graded_right_ideal ) ),
                           " generated by ",
                           String( Generators( graded_right_ideal ) )
                          ) 
                        );

end );



#################################################
##
## Section ViewObj methods for the new categories
##
#################################################

InstallMethod( ViewObj,
              [ IsGradedLeftSubmoduleForCAP and IsGradedLeftModulePresentationForCAP ],
  function( graded_left_submdule )

    Print( Concatenation( "<", String( graded_left_submdule ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsGradedLeftIdealForCAP and IsGradedLeftSubmoduleForCAP and IsGradedLeftModulePresentationForCAP ],
  function( graded_left_ideal )

    Print( Concatenation( "<", String( graded_left_ideal ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsGradedRightSubmoduleForCAP and IsGradedRightModulePresentationForCAP ],
  function( graded_right_submodule )

    Print( Concatenation( "<", String( graded_right_submodule ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsGradedRightIdealForCAP and IsGradedRightSubmoduleForCAP and IsGradedRightModulePresentationForCAP ],
  function( graded_right_ideal )

    Print( Concatenation( "<", String( graded_right_ideal ), ">" ) );

end );



##############################################################################################
##
#! @Section Full information of a submodule
##
##############################################################################################

InstallMethod( FullInformation,
               " for a submodule ",
               [ IsGradedLeftOrRightSubmoduleForCAP and IsGradedLeftOrRightModulePresentationForCAP ],
  function( submodule )

    FullInformation( PresentationForCAP( submodule ) );

end );



##############################################################################################
##
#! @Section Submodule powers
##
##############################################################################################


# for convenience allow "*" to indicate the (tensor) product on left submodules
InstallMethod( \*,
               "powers of submodules",
               [ IsGradedLeftOrRightSubmoduleForCAP and IsGradedLeftOrRightModulePresentationForCAP, 
                 IsGradedLeftOrRightSubmoduleForCAP and IsGradedLeftOrRightModulePresentationForCAP ],
  function( submodule1, submodule2 )
    local left1, left2, new_presentation, new_embedding, generators, range, new_graded_submodule, type;

    # check that the homalg_graded_rings are identical
    left1 := IsGradedLeftSubmoduleForCAP( submodule1 );
    left2 := IsGradedLeftSubmoduleForCAP( submodule2 );
    if not IsIdenticalObj( HomalgGradedRing( submodule1 ), HomalgGradedRing( submodule2 ) ) then

      Error( "The submodules have to be defined over the same graded ring" );
      return;

    elif left1 <> left2 then

      Error( "The submodule must both be left submodules or both be right submodules " );
      return;

    fi;

    # compute the new_presentation and the new_embedding
    new_presentation := TensorProductOnObjects( PresentationForCAP( submodule1 ), 
                                                PresentationForCAP( submodule2 ) 
                                               );
    new_embedding := CokernelProjection( UnderlyingMorphism( new_presentation ) );

    # extract the entries of the embedding matrix to identify the generators
    generators := EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( new_embedding ) );

    # compute the range and thereby compute the embedding properly
    range := CAPPresentationCategoryObject(
                         ZeroMorphism( ZeroObject( CapCategory( Range( new_embedding ) ) ), Range( new_embedding ) ) );
    new_embedding := CAPPresentationCategoryMorphism( new_presentation,
                                                      new_embedding,
                                                      range,
                                                      CapCategory( new_presentation )!.constructor_checks_wished
                                                     );

    # identify the type
    if left1 then
      if Rank( Range( UnderlyingMorphism( range ) ) ) = 1 then
        type := TheTypeOfGradedLeftIdealForCAP;
      else
        type := TheTypeOfGradedLeftSubmoduleForCAP;
      fi;
    else
      if Rank( Range( UnderlyingMorphism( range ) ) ) = 1 then
        type := TheTypeOfGradedRightIdealForCAP;
      else
        type := TheTypeOfGradedRightSubmoduleForCAP;
      fi;
    fi;

    # now compute the new submodule
    new_graded_submodule := rec( );
    ObjectifyWithAttributes( new_graded_submodule, type,
                             PresentationForCAP, new_presentation,
                             Generators, generators,
                             HomalgGradedRing, HomalgGradedRing( submodule1 ),
                             EmbeddingInSuperObjectForCAP, new_embedding 
                             );

    # finally return this object
    return new_graded_submodule;

end );

# for convenience allow "^" to indicate the n-th (tensor) power of left ideals
InstallMethod( \^,
               "powers of submodules",
               [ IsGradedLeftOrRightSubmoduleForCAP and IsGradedLeftOrRightModulePresentationForCAP, IsInt ],
  function( submodule, power )
    local submodule_power, presentation, generators, range, range_presentation, embedding, left, type, i;

    if not ( power > 0 ) then

      Error( "The power must be non-negative" );
      return;

    elif power = 0 then

      # construct identity_submodule attributes
      range := Range( UnderlyingMorphism( Range( EmbeddingInSuperObjectForCAP( submodule ) ) ) );
      presentation := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
      generators := EntriesOfHomalgMatrixAsListList( 
                                     HomalgIdentityMatrix( Rank( range ), HomalgGradedRing( submodule ) ) );
      embedding := CAPPresentationCategoryMorphism( presentation,
                                                    IdentityMorphism( range ),
                                                    presentation,
                                                    CapCategory( presentation )!.constructor_checks_wished
                                                   );

      # identify the type
      left := IsGradedLeftSubmoduleForCAP( submodule );
      if left then
        if Rank( range ) = 1 then
          type := TheTypeOfGradedLeftIdealForCAP;
        else
          type := TheTypeOfGradedLeftSubmoduleForCAP;
        fi;
      else
        if Rank( range ) = 1 then
          type := TheTypeOfGradedRightIdealForCAP;
        else
          type := TheTypeOfGradedRightSubmoduleForCAP;
        fi;
      fi;

      # objectify the submodule_power
      submodule_power := rec();
      ObjectifyWithAttributes( submodule_power, type,
                               PresentationForCAP, presentation,
                               Generators, generators,
                               HomalgGradedRing, HomalgGradedRing( submodule ),
                               EmbeddingInSuperObjectForCAP, embedding 
                             );

      # and return it
      return submodule_power;

    else

      submodule_power := submodule;
      for i in [ 2 .. power ] do

        submodule_power := submodule_power * submodule;

      od;

      return submodule_power;

    fi;

end );