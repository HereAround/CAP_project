#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

## transformation_inverse * matrix * transformation = smaller_matrix
## the above is not correct, rather T = transformation and T^-1 = transformation_inverse as in the diagram below
##    S ------ matrix ---------> R
##                            |    ^
##                            |    |
##                            T  T^{-1}
##                            |    |
##                            v    | 
##    S' --- smaller_matrix ---> R'
InstallMethod( LessGeneratorsTransformationTriple,
               [ IsHomalgMatrix ],
               
  function( matrix )
    local transformation, transformation_inverse, smaller_matrix;
    
    transformation := HomalgVoidMatrix( HomalgRing( matrix ) );
    
    transformation_inverse := HomalgVoidMatrix( HomalgRing( matrix ) );
    
    smaller_matrix := SimplerEquivalentMatrix( matrix, transformation, transformation_inverse, "", "" );
    
    return [ smaller_matrix, transformation, transformation_inverse ];
    
end );
