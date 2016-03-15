#! @Chapter Examples and tests of the presentation category over the category of projective graded modules

#! @Section Constructors of objects

LoadPackage( "CAPPresentationCategory" );;

#! We first construct objects of the presentation category over the category of projective graded left $S$-modules, where
#! $S$ is the Coxring of $\mathbb{P}^1 \times \mathbb{P}^1$.

#! @Example
Q := HomalgFieldOfRationalsInSingular();
#! Q
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: yet unset)
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );
#!
Q1 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
Q2 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,0],2] ], S );
#! <A projective graded left module of rank 2>
Q3 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,0],2] ], S );
#! <A projective graded left module of rank 2>
Q4 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2] ], S );
#! <A projective graded left module of rank 2>
m1 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q1, HomalgMatrix( [["x_1","x_2"]], S ) ,Q2 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
m2 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q2, HomalgMatrix( [[1,0],[0,1]], S ) ,Q3 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
m3 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q4, HomalgMatrix( [["x_1","x_2"], ["x_1","x_2"]], S ) ,Q3 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
left_category := CapCategory( Q1 ); 
#! CAP category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
presentation1l := CAPPresentationCategoryObject( m1 );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
presentation2l := CAPPresentationCategoryObject( m3 );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>

#! @EndExample

#! Next we repeat these steps for right modules instead.

#! @Example

P1 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],1] ], S );
#! <A projective graded right module of rank 1>
P2 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[0,0],2] ], S );
#! <A projective graded right module of rank 2>
P3 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[0,0],2] ], S );
#! <A projective graded right module of rank 2>
P4 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],2] ], S );
#! <A projective graded right module of rank 2>
n1 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P1, HomalgMatrix( [["x_1"],["x_2"]], S ) ,P2 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
n2 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P2, HomalgMatrix( [[1,0],[0,1]], S ) ,P3 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
n3 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P4, HomalgMatrix( [["x_1","x_1"], ["x_2","x_2"]], S ) ,P3 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
right_category := CapCategory( P1 ); 
#! CAP category of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
presentation1r := CAPPresentationCategoryObject( n1 );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
presentation2r := CAPPresentationCategoryObject( n3 );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>

#! @EndExample



#! @Section All information about an object

#! To see all the data that defines an object in the presentation category, the command $\text{FullInformation}$ 
#! can be used.

#! @Example

FullInformation( presentation1l );
#!
#! =================================================================================
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees:
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2
#! (over a graded ring)
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!  
#! =================================================================================
#!

#! @EndExample





#! @Section Morphisms in the presentation category

#! @Example

presentation_morphisml := CAPPresentationCategoryMorphism( 
                          presentation1l, m2, presentation2l );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefinedForMorphisms( presentation_morphisml );
#! true
FullInformation( presentation_morphisml );
#! 
#! ================================================================================= 
#!  
#! Source: 
#! ------- 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! A morphism in the category of projective graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2
#! (over a graded ring)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!
#! --------------------------------------------------------------------------------- 
#! 
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2,
#! x_1,x_2 
#! (over a graded ring)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!
#! ================================================================================= 
#!
Display( SourceLiftMorphism( presentation_morphisml ) );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1,0
#! (over a graded ring)
FullInformation( ColiftAlongEpimorphism( presentation_morphisml,
                                         presentation_morphisml ) );
#!
#! ================================================================================= 
#!
#! Source: 
#! ------- 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#!
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! x_1,x_2,
#! x_1,x_2 
#! (over a graded ring)
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
#!
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#!
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! x_1,x_2,
#! x_1,x_2 
#! (over a graded ring)
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!
#! ================================================================================= 
#!
presentation_morphismr := CAPPresentationCategoryMorphism( 
                          presentation1r, n2, presentation2r );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsWellDefinedForMorphisms( presentation_morphismr );
#! true
FullInformation( presentation_morphismr );
#! 
#! ================================================================================= 
#!  
#! Source: 
#! ------- 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights\
#!  [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! A morphism in the category of projective graded right modules over Q[x\
#! _1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ]\
#!  ]) with matrix: 
#! x_1,
#! x_2 
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights\
#!  [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!  
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded right modules over Q[x\
#! _1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ]\
#!  ]) with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#!  
#! Range: 
#! ------ 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights\
#!  [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#!  
#! A morphism in the category of projective graded right modules over Q[x\
#! _1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ]\
#!  ]) with matrix: 
#! x_1,x_1,
#! x_2,x_2 
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights\
#!  [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!  
#! ================================================================================= 
#! 
Display( SourceLiftMorphism( presentation_morphismr ) );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,
#! 0 
#! (over a graded ring)
FullInformation( ColiftAlongEpimorphism( presentation_morphismr,
                                         presentation_morphismr ) );
#!
#! ================================================================================= 
#!
#! Source: 
#! ------- 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#!
#! A morphism in the category of projective graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! x_1,x_1,
#! x_2,x_2 
#! (over a graded ring)
#!
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1,0,
#! 0,1
#! (over a graded ring)
#!
#! --------------------------------------------------------------------------------- 
#!
#! Range:
#! ------ 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#!
#! A morphism in the category of projective graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! x_1,x_1,
#! x_2,x_2
#! (over a graded ring)
#!
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!
#! ================================================================================= 
#!
#! @EndExample





#! @Section A few categorical constructions for the presentation category over the left modules

#! @Example
dSl := DirectSum( [ presentation1l, presentation2l ] );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IdentityMorphism( dSl );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
ZeroMorphism( ZeroObject( CapCategory( presentation1l ) ), dSl );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
p1l := ProjectionInFactorOfDirectSumWithGivenDirectSum( 
       [ presentation1l, presentation2l ], 1, dSl );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( p1l );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1,0,
#! 0,1,
#! 0,0,
#! 0,0 
#! (over a graded ring)
p2l := ProjectionInFactorOfDirectSumWithGivenDirectSum( 
       [ presentation1l, presentation2l ], 2, dSl );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( p2l );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 0,0,
#! 0,0,
#! 1,0,
#! 0,1 
#! (over a graded ring)
i1l := InjectionOfCofactorOfDirectSumWithGivenDirectSum( 
       [ presentation1l, presentation2l ], 1, dSl );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( i1l );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1,0,0,0,
#! 0,1,0,0 
#! (over a graded ring)
i2l := InjectionOfCofactorOfDirectSumWithGivenDirectSum( 
       [ presentation1l, presentation2l ], 2, dSl );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( i2l );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 0,0,1,0,
#! 0,0,0,1 
#! (over a graded ring)
source_l := CAPCategoryOfProjectiveGradedLeftModulesObject( 
            [ [[1,0], 3 ] ], S );
#! <A projective graded left module of rank 3>
Display( source_l );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 3 and degrees: 
#! [ [ ( 1, 0 ), 3 ] ]
range_l := CAPCategoryOfProjectiveGradedLeftModulesObject( 
           [ [[0,0], 2 ] ], S );
#! <A projective graded left module of rank 2>
Display( range_l );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
test_morphism_l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
    source_l, 
    HomalgMatrix( [[ "x_1", "x_2"], [ "x_1", "x_2"], [ "x_1", "x_2"]], S), 
    range_l );
#! <A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( test_morphism_l );
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) with matrix: 
#! x_1,x_2,
#! x_1,x_2,
#! x_1,x_2 
#! (over a graded ring)
test_object_l := CAPPresentationCategoryObject( test_morphism_l );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( test_object_l );
#! A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2,
#! x_1,x_2,
#! x_1,x_2 
#! (over a graded ring)
mor1_l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
          range_l, HomalgMatrix( [[1,0],[0,1]] , S ), Q3 );
#! <A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor1_l );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor1_l_presentation := CAPPresentationCategoryMorphism( 
                       test_object_l, mor1_l, presentation1l );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor1_l_presentation );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor2_l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
          range_l, HomalgMatrix( [[1,0],[0,1]] , S ), Q2 );
#! <A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor2_l );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor2_l_presentation := CAPPresentationCategoryMorphism( 
                       test_object_l, mor2_l, presentation2l );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor2_l_presentation );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
sink_l := [ mor1_l_presentation, mor2_l_presentation ];
#! [ <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>, 
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])> ]
diagram_l := [ Range( UnderlyingMorphism( presentation1l ) ), 
               Range( UnderlyingMorphism( presentation2l ) ) ];
#! [ <A projective graded left module of rank 2>, 
#!   <A projective graded left module of rank 2> ]
uni_l := UniversalMorphismIntoDirectSumWithGivenDirectSum( diagram_l, 
                                                           sink_l, 
                                                           dSl );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( uni_l );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the
#! following morphism: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,1,0,
#! 0,1,0,1 
#! (over a graded ring)
mor21_l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
           Q3, HomalgMatrix( [[1,0],[0,1]] , S ), range_l );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor21_l );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor21_l_presentation := CAPPresentationCategoryMorphism( presentation1l, 
                                                         mor21_l, 
                                                         test_object_l );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor21_l_presentation );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor22_l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
           Q2, HomalgMatrix( [[1,0],[0,1]] , S ), range_l );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor22_l );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor22_l_presentation := CAPPresentationCategoryMorphism( 
                        presentation2l, mor22_l, test_object_l );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor22_l_presentation );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
sink2_l := [ mor21_l_presentation , mor22_l_presentation ];
#! [ <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>, 
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])> ]
inj_l := UniversalMorphismFromDirectSumWithGivenDirectSum( diagram_l, 
                                                           sink2_l, 
                                                           dSl );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( inj_l );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the
#! following morphism: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix:
#! 1,0,
#! 0,1,
#! 1,0,
#! 0,1 
#! (over a graded ring)
kernel_l := KernelEmbedding( presentation_morphisml );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( kernel_l );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2
#! (over a graded ring)
cokernel_l := CokernelProjection( presentation_morphisml );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( cokernel_l );
#! A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
IsMonomorphism( kernel_l );
#! true
IsEpimorphism( kernel_l );
#! false
IsIsomorphism( kernel_l );
#! false
IsMonomorphism( cokernel_l );
#! false
IsEpimorphism( cokernel_l );
#! true
IsIsomorphism( cokernel_l );
#! false
comparer_l := CAPPresentationCategoryMorphism( 
                   Source( i1l ), 
                   CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
                           Range( UnderlyingMorphism( Source( i1l ) ) ),
                           HomalgMatrix( [[ 0,1,0,0],[0,0,1,0]], S ),
                           Range( UnderlyingMorphism( Range( i1l ) ) )
                   )                                             
                   , Range( i1l )
              );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEqualForMorphisms( i1l, comparer_l );
#! false

#! @EndExample




#! @Section A few categorical constructions for the presentation category over the right modules

#! @Example
dSr := DirectSum( [ presentation1r, presentation2r ] );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IdentityMorphism( dSr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
ZeroMorphism( ZeroObject( CapCategory( presentation1r ) ), dSr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
p1r := ProjectionInFactorOfDirectSumWithGivenDirectSum( 
                       [ presentation1r, presentation2r ], 1, dSr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( p1r );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix:
#! 1,0,0,0,
#! 0,1,0,0
#! (over a graded ring)
p2r := ProjectionInFactorOfDirectSumWithGivenDirectSum( 
                       [ presentation1r, presentation2r ], 2, dSr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( p2r );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix:
#! 0,0,1,0,
#! 0,0,0,1
#! (over a graded ring)
i1r := InjectionOfCofactorOfDirectSumWithGivenDirectSum( 
                       [ presentation1r, presentation2r ], 1, dSr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( i1r );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix:
#! 1,0,
#! 0,1,
#! 0,0,
#! 0,0
#! (over a graded ring)
i2r := InjectionOfCofactorOfDirectSumWithGivenDirectSum( 
                       [ presentation1r, presentation2r ], 2, dSr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( i2r );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix:
#! 0,0,
#! 0,0,
#! 1,0,
#! 0,1
#! (over a graded ring)
source_r := CAPCategoryOfProjectiveGradedRightModulesObject( 
                                               [ [[1,0], 3 ] ], S );
#! <A projective graded right module of rank 3>
Display( source_r );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 3 and degrees:
#! [ [ ( 1, 0 ), 3 ] ]
range_r := CAPCategoryOfProjectiveGradedRightModulesObject( 
                                               [ [[0,0], 2 ] ], S );
#! <A projective graded right module of rank 2>
Display( range_r );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
test_morphism_r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
          source_r, 
          HomalgMatrix( [[ "x_1", "x_1", "x_1"], [ "x_2", "x_2", "x_2"]], S), 
          range_r );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( test_morphism_r );
#! A morphism in the category of projective graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,x_1,x_1,
#! x_2,x_2,x_2
#! (over a graded ring)
test_object_r := CAPPresentationCategoryObject( test_morphism_r );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( test_object_r );
#! A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1,x_1,x_1,
#! x_2,x_2,x_2 
#! (over a graded ring)
mor1_r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
          range_r, HomalgMatrix( [[1,0],[0,1]] , S ), P3 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor1_r );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor1_r_presentation := CAPPresentationCategoryMorphism( 
                       test_object_r, mor1_r, presentation1r );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor1_r_presentation );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor2_r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
          range_r, HomalgMatrix( [[1,0],[0,1]] , S ), P2 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor2_r );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor2_r_presentation := CAPPresentationCategoryMorphism( 
                       test_object_r, mor2_r, presentation2r );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor2_r_presentation );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
sink_r := [ mor1_r_presentation, mor2_r_presentation ];
#! [ <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>, 
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])> ]
diagram_r := [ Range( UnderlyingMorphism( presentation1r ) ), 
               Range( UnderlyingMorphism( presentation2r ) ) ];
#! [ <A projective graded right module of rank 2>, 
#!   <A projective graded right module of rank 2> ]
uni_r := UniversalMorphismIntoDirectSumWithGivenDirectSum( 
                                                           diagram_r, 
                                                           sink_r, 
                                                           dSr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( uni_r );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1,
#! 1,0,
#! 0,1
#! (over a graded ring)
mor21_r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
           P3, HomalgMatrix( [[1,0],[0,1]] , S ), range_r );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor21_r );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor21_r_presentation := CAPPresentationCategoryMorphism( 
                                                      presentation1r, 
                                                      mor21_r, 
                                                      test_object_r );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor21_r_presentation );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor22_r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
           P2, HomalgMatrix( [[1,0],[0,1]] , S ), range_r );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor22_r );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
mor22_r_presentation := CAPPresentationCategoryMorphism( 
                        presentation2r, mor22_r, test_object_r );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( mor22_r_presentation );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
sink2_r := [ mor21_r_presentation , mor22_r_presentation ];
#! [ <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>, 
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])> ]
inj_r := UniversalMorphismFromDirectSumWithGivenDirectSum( diagram_r, 
                                                           sink2_r, 
                                                           dSr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( inj_r );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism:
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,1,0,
#! 0,1,0,1
#! (over a graded ring)
kernel_r := KernelEmbedding( presentation_morphismr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( kernel_r );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2
#! (over a graded ring)
cokernel_r := CokernelProjection( presentation_morphismr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( cokernel_r );
#! A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given by the 
#! following morphism: 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
IsMonomorphism( kernel_r );
#! true
IsEpimorphism( kernel_r );
#! false
IsIsomorphism( kernel_r );
#! false
IsMonomorphism( cokernel_r );
#! false
IsEpimorphism( cokernel_r );
#! true
IsIsomorphism( cokernel_r );
#! false
comparer_r := CAPPresentationCategoryMorphism( 
                      Source( i1r ), 
                      CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
                                Range( UnderlyingMorphism( Source( i1r ) ) ),
                                HomalgMatrix( [[ 0,0],[0,1],[1,0],[0,0]], S ),
                                Range( UnderlyingMorphism( Range( i1r ) ) )
                      ),
                      Range( i1r ) 
                   );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
IsEqualForMorphisms( i1r, comparer_r );
#! false

#! @EndExample