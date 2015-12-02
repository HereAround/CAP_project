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
    local installed_ops;

    ## FIXME: Check method preconditions
    ## i.e. check if all method for "isadditive" are there and so on...
    ## -> so create a list of all methods that I use!
    
    if not HasIsFinalized( category ) or not IsFinalized( category ) then
        
        Error( "Proj-categories must be finalized" );
        return;

    fi;
    
    installed_ops := ListInstalledOperationsOfCategory( category );
    
    if not IsAdditiveCategory( category ) then
        
        return false;
        
    elif not IsRigidSymmetricClosedMonoidalCategory( category ) then
        
        return false;
        
    elif not "Lift" in installed_ops then
        
        return false;
        
    elif not "KernelEmbedding" in installed_ops then
      
      return false;
      
    fi;
    
    return true;
    
end );