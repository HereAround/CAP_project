#! @Chapter Examples and Tests

#! @Section Basic Commands

LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
Q := HomalgFieldOfRationalsInSingular( );
R := Q * "x,y";
F := AsLeftPresentation( HomalgMatrix( [ [ 0 ] ], R ) );
I1 := AsLeftPresentation( HomalgMatrix( [ [ "x" ] ], R ) );;
I2 := AsLeftPresentation( HomalgMatrix( [ [ "y" ] ], R ) );;
Display( I1 );
Display( I2 );
eps1 := PresentationMorphism( F, HomalgMatrix( [ [ 1 ] ], R ), I1 );
eps2 := PresentationMorphism( F, HomalgMatrix( [ [ 1 ] ], R ), I2 );
kernelemb1 := KernelEmbedding( eps1 );
kernelemb2 := KernelEmbedding( eps2 );
P := FiberProduct( kernelemb1, kernelemb2 );;
Display( P );
pi1 := ProjectionInFactor( P, 1 );
composite := PreCompose( pi1, kernelemb1 );
Display( composite );
#! @EndExample
