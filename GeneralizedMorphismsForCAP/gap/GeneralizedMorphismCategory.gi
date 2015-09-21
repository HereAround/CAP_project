#############################################################################
##
##                  GeneralizedMorphismsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Generalized morphism category
##
#############################################################################

## GAP-Hack in order to avoid the pre-installed GAP-method Domain
BindGlobal( "CAP_INTERNAL_DOMAIN_SAVE", Domain );

MakeReadWriteGlobal( "Domain" );

Domain := function( arg )
  
  if Length( arg ) = 1 and IsGeneralizedMorphism( arg[1] ) then
      
      return DomainOfGeneralizedMorphism( arg[ 1 ] );
      
  fi;
  
  return CallFuncList( CAP_INTERNAL_DOMAIN_SAVE, arg );
  
end;

InstallMethod( DomainOfGeneralizedMorphism,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    local domain;
    
    domain := DomainAssociatedMorphismCodomainTriple( generalized_morphism )[1];
    
    SetIsMonomorphism( domain, true );
    
    return domain;
    
end );

InstallMethod( AssociatedMorphism,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    
    return DomainAssociatedMorphismCodomainTriple( generalized_morphism )[2];
    
end );

InstallMethod( Codomain,
               [ IsGeneralizedMorphism ],
               
  function( generalized_morphism )
    local codomain;
    
    codomain := DomainAssociatedMorphismCodomainTriple( generalized_morphism )[3];
    
    SetIsEpimorphism( codomain, true );
    
    return codomain;
    
end );
