#############################################################################
##
##                  CAPPresentationCategory
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter Convenience methods
##
#############################################################################



####################################################################################
##
##  Section Powers of objects and morphisms
##
####################################################################################

# for convenience allow "*" to indicate the tensor product on objects
InstallMethod( \*,
               "powers of presentations",
               [ IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ],
  function( presentation_object1, presentation_object2 )

    return TensorProductOnObjects( presentation_object1, presentation_object2 );
  
end );

# for convenience allow "*" to indicate the tensor product on morphisms
InstallMethod( \*,
               "powers of presentations",
               [ IsCAPPresentationCategoryMorphism, IsCAPPresentationCategoryMorphism ],
  function( presentation_morphism1, presentation_morphism2 )

    return TensorProductOnMorphisms( presentation_morphism1, presentation_morphism2 );
  
end );

# allow "^p" to indicate the p-th power, i.e. p-times tensor product of an object with itself
InstallMethod( \^,
               "powers of presentations",
               [ IsCAPPresentationCategoryObject, IsInt ],
  function( presentation_object, power )
    local res, i;
    
      if power < 0 then
      
        return Error( "The power must be non-negative! \n" );
            
      elif power = 0 then
      
        return ZeroObject( CapCategory( presentation_object ) );
      
      elif power = 1 then
      
        return presentation_object;
        
      else
      
        res := presentation_object;
        
        for i in [ 1 .. power ] do
          res := res * presentation_object;
        od;
      
        return res;
      
      fi;

end );

# allow "^p" to indicate the p-th power, i.e. p-times tensor product of a morphism with itself
InstallMethod( \^,
               "powers of presentations",
               [ IsCAPPresentationCategoryMorphism, IsInt ],
  function( presentation_morphism, power )
    local res, i;

      if power < 0 then

        return Error( "The power must be non-negative! \n" );

      elif power = 0 then

        return ZeroObject( CapCategory( presentation_morphism ) );
      
      elif power = 1 then
      
        return presentation_morphism;
        
      else
      
        res := presentation_morphism;
        
        for i in [ 1 .. power ] do
          res := res * presentation_morphism;
        od;
      
        return res;
      
      fi;

end );



####################################################################################
##
##  Section Determine if a category is a Proj-category
##
####################################################################################

InstallGlobalFunction( IsProjCategory,
  function( category )
    local installed_ops, required_ops, i;

    # first check if the category has been finalized (i.e. no methods are to be added...)
    if not HasIsFinalized( category ) or not IsFinalized( category ) then

        Error( "Proj-categories must be finalized" );
        return;

    fi;

    # the following are required for a Proj-category
    required_ops := [ "IsWellDefinedForMorphisms",
                      "IsEqualForMorphismsOnMor",
                      "PreCompose",
                      "IdentityMorphism",
                      "AdditionForMorphisms",
                      "AdditiveInverseForMorphisms",
                      "AdditionForMorphisms",
                      "ZeroMorphism",
                      "ZeroObject",
                      "UniversalMorphismIntoZeroObject",
                      "UniversalMorphismFromZeroObject",
                      "DirectSum",
                      "ProjectionInFactorOfDirectSum",
                      "UniversalMorphismIntoDirectSum",
                      "InjectionOfCofactorOfDirectSum",
                      "UniversalMorphismFromDirectSum",
                      "Lift",
                      "ProjectionInFactorOfFiberProduct" ];

    # whilst the following methods are installed
    installed_ops := ListInstalledOperationsOfCategory( category );

    # check that all required methods are indeed installed
    for i in required_ops do

      if not i in installed_ops then

        Error( Concatenation( i, " is not installed, but needed for a Proj-category" ) );
        return false;

      fi;

    od;

    # if all required methods are installed, check if the category also has the right properties set
    if not IsAdditiveCategory( category ) then

      Error( "a Proj-category must be additive, but the attribute is not set for the category in question" );
      return false;

    fi;

    # if all tests have been passed, return true
    return true;

end );

InstallGlobalFunction( IsMonoidalStructurePresent,
  function( category )
    local installed_ops, required_ops, i;

    # first check if the category has been finalized (i.e. no methods are to be added...)
    if not HasIsFinalized( category ) or not IsFinalized( category ) then

        Error( "Monoidal categories must be finalized" );
        return;

    fi;

    # the following are required for a Proj-category
    required_ops := [ "TensorProductOnObjects",
                      "TensorProductOnMorphismsWithGivenTensorProducts",
                      "TensorUnit",
                      "AssociatorLeftToRightWithGivenTensorProducts",
                      "AssociatorRightToLeftWithGivenTensorProducts",
                      "LeftUnitorWithGivenTensorProduct",
                      "LeftUnitorInverseWithGivenTensorProduct",
                      "RightUnitorWithGivenTensorProduct",
                      "RightUnitorInverseWithGivenTensorProduct",
                      "BraidingWithGivenTensorProducts",
                      "DualOnObjects",
                      "DualOnMorphismsWithGivenDuals",
                      "EvaluationForDualWithGivenTensorProduct",
                      "CoevaluationForDualWithGivenTensorProduct" ];

    # whilst the following methods are installed
    installed_ops := ListInstalledOperationsOfCategory( category );

    # check that all required methods are indeed installed
    for i in required_ops do

      if not i in installed_ops then

        Error( Concatenation( i, " is not installed, but needed for a monoidal category" ) );
        return false;

      fi;

    od;

    # if all required methods are installed, check if the category also has the right properties set
    if not IsRigidSymmetricClosedMonoidalCategory( category ) then

      Error( Concatenation( "a monoidal category must be a rigid symmetric and closed monoidal category, ",
                            "but the attribute is not set for the category in question" ) );
      return false;

    fi;

    # if all tests have been passed, return true
    return true;

end );