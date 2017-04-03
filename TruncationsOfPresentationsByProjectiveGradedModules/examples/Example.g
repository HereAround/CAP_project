##################################################
##################################################
#! @Chapter Examples and Tests
##################################################
##################################################

LoadPackage( "TruncationsOfPresentationsByProjectiveGradedModules" );;



####################################################
#! @Section Cone and semigroup wrappers
####################################################

#! The following commands are used to handle generators of semigroups in $\mathbb{Z}^n$, generators of cones in $\mathbb{Z}^n$
#! as well as hyperplane constraints that define cones in $\mathbb{Z}^n$. Here are some examples:

#! @Example
semigroup1 := SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 1,1 ]] );
#! <A cone-semigroup in Z^2 formed as the span of 2 generators>
IsSemigroupForPresentationsByProjectiveGradedModules( semigroup1 );
#! true
GeneratorList( semigroup1 );
#! [ [ 1, 0 ], [ 1, 1 ] ]
semigroup2 := SemigroupForPresentationsByProjectiveGradedModules( [[ 2,0 ], [ 1,1 ]] );
#! <A non-cone semigroup in Z^2 formed as the span of 2 generators>
IsSemigroupForPresentationsByProjectiveGradedModules( semigroup2 );
#! true
GeneratorList( semigroup2 );
#! [ [ 2, 0 ], [ 1, 1 ] ]
#! @EndExample

#! We can check if a semigroup in $\mathbb{Z}^n$ is the semigroup of a cone. In case we can look at an H-presentation
#! of this cone.

#! @Example
IsSemigroupOfCone( semigroup1 );
#! true
ConeHPresentationList( semigroup1 );
#! [ [ 0, 1 ], [ 1, -1 ] ]
Display( ConeHPresentationList( semigroup1 ) );
#! [ [   0,  1 ],
#!   [   1, -1 ] ]
IsSemigroupOfCone( semigroup2 );
#! false
HasConeHPresentationList( semigroup2 );
#! false
#! @EndExample

#! We can check membership of points in semigroups.

#! @Example
PointContainedInSemigroup( semigroup2, [ 1,0 ] );
#! false
PointContainedInSemigroup( semigroup2, [ 2,0 ] );
#! true
#! @EndExample

#! Given a semigroup $S \subseteq \mathbb{Z}^n$ and a point $p \in \mathbb{Z}^n$ we can consider
#! $$ H := p + S = \left\{ p + x \; , \; x \in S \right\}. $$
#! We term this an affine semigroup. Given that $S = C \cap \mathbb{Z}^n$ for a cone $C \subseteq \mathbb{Z}^n$, we use
#! the term affine cone_semigroup. The constructors are as follows:

#! @Example
affine_semigroup1 := AffineSemigroupForPresentationsByProjectiveGradedModules( semigroup1, [ -1, -1 ] );
#! <A non-trivial affine cone-semigroup in Z^2>
affine_semigroup2 := AffineSemigroupForPresentationsByProjectiveGradedModules( semigroup2, [ 2, 2 ] );
#! <A non-trivial affine non-cone semigroup in Z^2>
#! @EndExample

#! We can access the properties of these affine semigroups as follows.

#! @Example
IsAffineSemigroupOfCone( affine_semigroup2 );
#! false
UnderlyingSemigroup( affine_semigroup2 );
#! <A non-cone semigroup in Z^2 formed as the span of 2 generators>
Display( UnderlyingSemigroup( affine_semigroup2 ) );
#! A non-cone semigroup in Z^2 formed as the span of 2 generators - generators are as follows:
#! [ [  2,  0 ],
#!   [  1,  1 ] ]
IsAffineSemigroupOfCone( affine_semigroup1 );
#! true
Offset( affine_semigroup2 );
#! [ 2, 2 ]
ConeHPresentationList( UnderlyingSemigroup( affine_semigroup1 ) );
#! [ [ 0, 1 ], [ 1, -1 ] ]
#! @EndExample

#! Of course we can also decide membership in affine (cone_)semigroups.

#! @Example
Display( affine_semigroup1 );
#! A non-trivial affine cone-semigroup in Z^2
#! Offset: [ -1, -1 ]
#! Hilbert basis: [ [ 1, 0 ], [ 1, 1 ] ]
PointContainedInAffineSemigroup( affine_semigroup1, [ -2,-2 ] );
#! false
PointContainedInAffineSemigroup( affine_semigroup1, [ 3,1 ] );
#! true
Display( affine_semigroup2 );
#! A non-trivial affine non-cone semigroup in Z^2
#! Offset: [ 2, 2 ]
#! Semigroup generators: [ [ 2, 0 ], [ 1, 1 ] ]
PointContainedInAffineSemigroup( affine_semigroup2, [ 3,2 ] );
#! false
PointContainedInAffineSemigroup( affine_semigroup2, [ 3,3 ] );
#! true
#! @EndExample



#########################################################
#! @Section Truncations of projective graded left modules
#########################################################

#! @Example
Q := HomalgFieldOfRationalsInSingular();
#! Q
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: yet unset)
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );
#!
D := DegreeGroup( S );
#! <A free left module of rank 2 on free generators>
IsFree( D );
#! true
NewObjectL := CAPCategoryOfProjectiveGradedLeftModulesObject( 
              [ [[1,0],1], [[-1,-1],2] ], S );
#! <A projective graded left module of rank 3>
tL := TruncationOfProjectiveGradedModule( NewObjectL, 
      SemigroupForPresentationsByProjectiveGradedModules( [[1,0],[0,1]] ) );
#! <A projective graded left module of rank 1>
Display( tL );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
tL2 := TruncationOfProjectiveGradedModule( NewObjectL, 
       SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,2 ]] ) );
#! <A projective graded left module of rank 1>
Display( tL2 );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
embL := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectL, 
        SemigroupForPresentationsByProjectiveGradedModules( [[1,0],[0,1]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embL ) );
#! 1, 0, 0
#! (over a graded ring)
embL2 := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectL, 
        SemigroupForPresentationsByProjectiveGradedModules( [[1,0],[0,2]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embL2 ) );
#! 1, 0, 0
#! (over a graded ring)
embL3 := EmbeddingOfTruncationOfProjectiveGradedModuleWithGivenTruncationObject(
         NewObjectL, tL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embL3 ) );
#! 1, 0, 0
#! (over a graded ring)
projL := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectL, 
         SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,1 ]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projL ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
projL2 := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectL, 
         SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,2 ]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projL2 ) );
#! 1,
#! 0,
#! 0 
#! (over a graded ring)
projL3 := ProjectionOntoTruncationOfProjectiveGradedModuleWithGivenTruncationObject( 
          NewObjectL, tL ); 
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projL3 ) );
#! 1,
#! 0,
#! 0 
#! (over a graded ring)
truncatorL := TruncationFunctorForProjectiveGradedLeftModules(
                        S, SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,2 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1, 0 ], [ 0, 2 ] ]
truncatorL2 := TruncationFunctorForProjectiveGradedLeftModules(
                        S, SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,1 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! to the semigroup generated by [ [ 1,0 ], [ 0, 1 ] ]
tL2 := ApplyFunctor( truncatorL, NewObjectL );
#! <A projective graded left module of rank 1>
Display( tL2 );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
sourceL := CAPCategoryOfProjectiveGradedLeftModulesObject( 
           [ [[1,0],1], [[0,1],1] ], S );
#! <A projective graded left module of rank 2>
rangeL := CAPCategoryOfProjectiveGradedLeftModulesObject( 
           [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
test_morphismL := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      sourceL, HomalgMatrix( [ [ 1 ],[ 0 ] ], S ) ,rangeL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
tr_test_morphismL := ApplyFunctor( truncatorL, test_morphismL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( tr_test_morphismL ) );
#! 1
#! (over a graded ring)
tr2_test_morphismL := ApplyFunctor( truncatorL2, test_morphismL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( tr2_test_morphismL ) );
#! 1,
#! 0
#! (over a graded ring)
nat_trans_l := NaturalTransformationFromTruncationToIdentityForProjectiveGradedLeftModules( 
                        S, SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,1 ]] ) );
#! Natural transformation from Truncation functor for CAP category 
#! of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1, 0 ], [ 0, 1 ] ] to id
component_l := ApplyNaturalTransformation( nat_trans_l, NewObjectL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( component_l ) );
#! 1, 0, 0
#! (over a graded ring)

#! @EndExample



##########################################################
#! @Section Truncations of projective graded right modules
##########################################################

#! @Example
NewObjectR := CAPCategoryOfProjectiveGradedRightModulesObject( 
              [ [[1,0],1], [[-1,-1],2] ], S );
#! <A projective graded right module of rank 3>
tR := TruncationOfProjectiveGradedModule( NewObjectR, 
      SemigroupForPresentationsByProjectiveGradedModules( [[1,0],[0,1]] ) );
#! <A projective graded right module of rank 1>
Display( tR );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
tR2 := TruncationOfProjectiveGradedModule( NewObjectR, 
       SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,2 ]] ) );
#! <A projective graded right module of rank 1>
Display( tR2 );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
embR := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectR, 
        SemigroupForPresentationsByProjectiveGradedModules( [[1,0],[0,1]] ) );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embR ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
embR2 := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectL, 
        SemigroupForPresentationsByProjectiveGradedModules( [[1,0],[0,2]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embR2 ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
embR3 := EmbeddingOfTruncationOfProjectiveGradedModuleWithGivenTruncationObject(
         NewObjectR, tR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embR3 ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
projR := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectR,
         SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,1 ]] ) );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projR ) );
#! 1, 0, 0
#! (over a graded ring)
projR2 := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectR, 
         SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,2 ]] ) );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projR2 ) );
#! 1, 0, 0
#! (over a graded ring)
projR3 := ProjectionOntoTruncationOfProjectiveGradedModuleWithGivenTruncationObject( 
          NewObjectR, tR ); 
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projR3 ) );
#! 1, 0, 0
#! (over a graded ring)
truncatorR := TruncationFunctorForProjectiveGradedRightModules( S, 
                             SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,2 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1, 0 ], [ 0, 2 ] ]
truncatorR2 := TruncationFunctorForProjectiveGradedRightModules(
                        S, SemigroupForPresentationsByProjectiveGradedModules( [[ 1,0 ], [ 0,1 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1, 0 ], [ 0, 1 ] ]
tR2 := ApplyFunctor( truncatorR, NewObjectR );
#! <A projective graded right module of rank 1>
Display( tR2 );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
sourceR := CAPCategoryOfProjectiveGradedRightModulesObject( 
           [ [[1,0],1], [[0,1],1] ], S );
#! <A projective graded right module of rank 2>
rangeR := CAPCategoryOfProjectiveGradedRightModulesObject( 
           [ [[1,0],1] ], S );
#! <A projective graded right module of rank 1>
test_morphismR := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      sourceR, HomalgMatrix( [ [ 1, 0 ] ], S ) ,rangeR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
tr_test_morphismR := ApplyFunctor( truncatorR, test_morphismR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( tr_test_morphismR ) );
#! 1
#! (over a graded ring)
tr2_test_morphismR := ApplyFunctor( truncatorR2, test_morphismR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( tr2_test_morphismR ) );
#! 1, 0
#! (over a graded ring)
nat_trans_r := NaturalTransformationFromTruncationToIdentityForProjectiveGradedRightModules
                               ( S, SemigroupForPresentationsByProjectiveGradedModules( [[1,0],[0,1]] ) );
#! Natural transformation from Truncation functor for CAP category 
#! of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1,0 ], [ 0, 1 ] ] to id
component_r := ApplyNaturalTransformation( nat_trans_r, NewObjectR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( component_r ) );
#! 1, 0, 0
#! (over a graded ring)

#! @EndExample



##########################################################
#! @Section Truncations in SfpgrmodLeft
##########################################################

#! @Example
Q1 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[2,0],1] ], S );
#! <A projective graded left module of rank 1>
Q2 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1], [[-1,0],1] ], S );
#! <A projective graded left module of rank 2>
Q3 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
Q4 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
m1l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q1, HomalgMatrix( [["x_1","x_2^3"]], S ) ,Q2 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
m2l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q2, HomalgMatrix( [[1],[0]], S ) ,Q3 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
m3l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q4, HomalgMatrix( [[1]], S ) ,Q3 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
left_category := CapCategory( Q1 ); 
#! CAP category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
left_presentation1 := CAPPresentationCategoryObject( m1l );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
left_presentation2 := CAPPresentationCategoryObject( m2l );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
left_presentation3 := CAPPresentationCategoryObject( m3l );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
truncation_functor_left := TruncationFunctorLeft( 
                           S, SemigroupForPresentationsByProjectiveGradedModules( [[1,0],[0,1]] ) );
#! Truncation functor for Category of graded left module presentations 
#! over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1, 0 ], [ 0, 1 ] ]
truncation1l := ApplyFunctor( truncation_functor_left, left_presentation1 );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( truncation1l );
#! ================================================================================= 
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 2, 0 ), 1 ] ]
#!
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! x_1
#! (over a graded ring)
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! ================================================================================= 
truncation2l := ApplyFunctor( truncation_functor_left, left_presentation2 );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( truncation2l );
#! ================================================================================= 
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and 
#! degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix:
#! 1
#! (over a graded ring)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! ================================================================================= 
morl := CAPPresentationCategoryMorphism( left_presentation1, m2l, left_presentation3 );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
trmorl := ApplyFunctor( truncation_functor_left, morl );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( trmorl );
#!
#! =================================================================================
#!
#! Source:
#! ------- 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 2, 0 ), 1 ] ]
#!
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! x_1
#! (over a graded ring)
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix:
#! ---------------
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! with matrix: 
#! 1
#! (over a graded ring)
#!
#! --------------------------------------------------------------------------------- 
#!
#! Range:
#! ------
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) with matrix: 
#! 1
#! (over a graded ring)
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! ================================================================================= 
#!
#! @EndExample



#################################################################
#! @Section Truncations for graded module presentations (for CAP)
#################################################################

#! @Example
P1 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[2,0],1] ], S );
#! <A projective graded right module of rank 1>
P2 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],1], [[-1,0],1] ], S );
#! <A projective graded right module of rank 2>
P3 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],1] ], S );
#! <A projective graded right module of rank 1>
P4 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],1] ], S );
#! <A projective graded right module of rank 1>
m1r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P1, HomalgMatrix( [["x_1"],["x_2^3"]], S ) ,P2 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
m2r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P2, HomalgMatrix( [[1,0]], S ) ,P3 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
m3r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P4, HomalgMatrix( [[1]], S ) ,P3 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
right_category := CapCategory( P1 ); 
#! CAP category of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
right_presentation1 := CAPPresentationCategoryObject( m1r );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
right_presentation2 := CAPPresentationCategoryObject( m2r );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
right_presentation3 := CAPPresentationCategoryObject( m3r );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
truncation_functor_right := TruncationFunctorRight( 
                            S, SemigroupForPresentationsByProjectiveGradedModules( [[1,0],[0,1]] ) );
#! Truncation functor for Category of graded right module presentations 
#! over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1, 0 ], [ 0, 1 ] ]
truncation1r := ApplyFunctor( truncation_functor_right, right_presentation1 );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( truncation1r );
#! ================================================================================= 
#!
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 2, 0 ), 1 ] ]
#!
#! A morphism in the category of projective graded right modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ]])
#! with matrix:
#! x_1
#! (over a graded ring)
#!
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees:
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! =================================================================================
truncation2r := ApplyFunctor( truncation_functor_right, right_presentation2 );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( truncation2r );
#! ================================================================================= 
#!
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and 
#! degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix:
#! 1
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! =================================================================================
morr := CAPPresentationCategoryMorphism( right_presentation1, m2r, right_presentation3 );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
trmorr := ApplyFunctor( truncation_functor_right, morr );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( trmorr );
#!
#! ================================================================================= 
#!
#! Source: 
#! ------- 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 2, 0 ), 1 ] ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1
#! (over a graded ring)
#!
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1
#! (over a graded ring)
#!
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! ================================================================================= 
#! 
#! @EndExample