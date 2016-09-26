##################################################
##################################################
#! @Chapter Examples and Tests
##################################################
##################################################

LoadPackage( "TruncationsOfGradedModulePresentationsForCAP" );;



####################################################
#! @Section Cone and semigroup wrappers
####################################################

#! The following commands are used to handle generators of semigroups in $\mathbb{Z}^n$, generators of cones in $\mathbb{Z}^n$
#! as well as hyperplane constraints that define cones in $\mathbb{Z}^n$. Here are some examples:

#! @Example
semigroup1 := SemigroupGeneratorList( [[ 1,0 ], [ 1,1 ]] );
#! <A list of generators of a semigroup of Z^2>
IsSemigroupGeneratorList( semigroup1 );
#! true
UnderlyingList( semigroup1 );
#! [ [ 1, 0 ], [ 1, 1 ] ]
semigroup2 := SemigroupGeneratorList( [[ 2,0 ], [ 1,1 ]] );
#! <A list of generators of a semigroup of Z^2>
IsSemigroupGeneratorList( semigroup2 );
#! true
UnderlyingList( semigroup2 );
#! [ [ 2, 0 ], [ 1, 1 ] ]
cone1 := ConeVPresentationList( [[ 1,0 ], [ 0, 1 ]] );
#! <A list of vertex generators of a cone in Z^2>
cone2 := ConeHPresentationList( [[ 1,1 ], [ -1, 1 ]] );
#! <A list of hyperplane constraints of a cone in Z^2>
#! @EndExample

#! We can check if a semigroup in $\mathbb{Z}^n$ is the semigroup of a cone. In case it is, we can convert 
#! into an H-presentation or V-presentation.

#! @Example
IsSemigroupOfCone( semigroup1 );
#! true
TurnIntoConeHPresentationList( semigroup1 );
#! <A list of hyperplane constraints of a cone in Z^2>
Display( TurnIntoConeHPresentationList( semigroup1 ) );
#! A list of hyperplane constraints of a cone in Z^2 -
#! h-constraints are as follows: 
#! [ [   0,  1 ],
#!   [   1, -1 ] ]
TurnIntoConeVPresentationList( semigroup1 );
#! <A list of vertex generators of a cone in Z^2>
Display( TurnIntoConeVPresentationList( semigroup1 ) );
#! A list of vertex generators of a cone in Z^2 -
#! ray generators are as follows: 
#! [ [  1,  0 ],
#!   [  1,  1 ] ]
IsSemigroupOfCone( semigroup2 );
#! false
TurnIntoConeHPresentationList( semigroup2 );
#! fail
#! @EndExample

#! We can check membership of points in semigroups and cones.

#! @Example
PointContainedInCone( cone1, [ 1,1 ] );
#! true
PointContainedInCone( cone1, [ 1,-1 ] );
#! false
PointContainedInCone( cone2, [ 1,-1 ] );
#! false
PointContainedInCone( cone2, [ 1,1 ] ); 
#! true
cone3 := NmzCone( [ "integral_closure", [[ 2,1 ], [ 1,0 ]] ] );
#! <a Normaliz cone>
PointContainedInCone( cone3, [ 3,1 ] );
#! true
PointContainedInCone( cone3, [ 3,2 ] );
#! false
PointContainedInSemigroup( semigroup2, [ 1,0 ] );
#! false
PointContainedInSemigroup( semigroup2, [ 2,0 ] );
#! true
#! @EndExample

#! Given a semigroup $S \subseteq \mathbb{Z}^n$ and a point $p \in \mathbb{Z}^n$ we can consider
#! $$ H := p + S = \left\{ p + x \; , \; x \in S \right\}. $$
#! We term this an affine semigroup. Given that $S = C \cap \mathbb{Z}^n$ for a cone $C \subseteq \mathbb{Z}^n$, we term
#! this an affine cone_semigroup. The constructors are as follows:

#! @Example
affine_cone_semigroup1 := AffineConeSemigroup( cone1, [ 5,2 ] );
#! <An affine cone_semigroup in Z^2>
affine_cone_semigroup2 := AffineConeSemigroup( cone2, [ 3,0 ] );
#! <An affine cone_semigroup in Z^2>
affine_cone_semigroup3 := AffineConeSemigroup( cone3, [ -1,-1 ] );
#! <An affine cone_semigroup in Z^2>
affine_semigroup1 := AffineSemigroup( semigroup1, [ -1,-1 ] );
#! <An affine cone_semigroup in Z^2>
affine_semigroup2 := AffineSemigroup( semigroup2, [ 2,2 ] );
#! <An affine semigroup in Z^2>
#! @EndExample

#! We can access the properties of these affine semigroups as follows.

#! @Example
IsAffineConeSemigroup( affine_semigroup2 );
#! false
UnderlyingSemigroupGeneratorList( affine_semigroup2 );
#! <A list of generators of a semigroup of Z^2>
Display( UnderlyingSemigroupGeneratorList( affine_semigroup2 ) );
#! A list of generators of a semigroup of Z^2 - generators are as follows: 
#! [ [  2,  0 ],
#!   [  1,  1 ] ]
IsAffineConeSemigroup( affine_semigroup1 );
#! true
Offset( affine_cone_semigroup2 );
#! [ 3, 0 ]
UnderlyingConeHPresentationList( affine_cone_semigroup1 );
#! <A list of hyperplane constraints of a cone in Z^2>
#! @EndExample

#! Of course we can also decide membership in affine (cone_)semigroups.

#! @Example
Display( affine_cone_semigroup1 );
#! An affine cone_semigroup in Z^2
#! Offset: [ 5, 2 ]
#! Cone generators: [ [ 1, 0 ], [ 0, 1 ] ]
PointContainedInAffineConeSemigroup( affine_cone_semigroup1, [ 1,1 ] );
#! false
PointContainedInAffineConeSemigroup( affine_cone_semigroup1, [ 5,4 ] );
#! true
Display( affine_semigroup2 );
#! An affine semigroup in Z^2
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
      SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! <A projective graded left module of rank 1>
Display( tL );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
tL2 := TruncationOfProjectiveGradedModule( NewObjectL, 
       SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
#! <A projective graded left module of rank 1>
Display( tL2 );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
embL := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectL, 
        SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embL ) );
#! 1, 0, 0
#! (over a graded ring)
embL2 := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectL, 
        SemigroupGeneratorList( [[1,0],[0,2]] ) );
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
         SemigroupGeneratorList( [[ 1,0 ], [ 0,1 ]] ) );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projL ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
projL2 := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectL, 
         SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
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
                        S, SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1, 0 ], [ 0, 2 ] ]
truncatorL2 := TruncationFunctorForProjectiveGradedLeftModules(
                        S, SemigroupGeneratorList( [[ 1,0 ], [ 0,1 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! to the cone given by the h-constraints [ [ 0, 1 ], [ 1, 0 ] ]
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
                        S, SemigroupGeneratorList( [[ 1,0 ], [ 0,1 ]] ) );
#! Natural transformation from Truncation functor for CAP category 
#! of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone given by the h-constraints [ [ 0, 1 ], [ 1, 0 ] ] to id
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
      SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! <A projective graded right module of rank 1>
Display( tR );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
tR2 := TruncationOfProjectiveGradedModule( NewObjectR, 
       SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
#! <A projective graded right module of rank 1>
Display( tR2 );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: [ [ ( 1, 0 ), 1 ] ]
embR := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectR, 
        SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( UnderlyingHomalgMatrix( embR ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
embR2 := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectL, 
        SemigroupGeneratorList( [[1,0],[0,2]] ) );
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
         SemigroupGeneratorList( [[ 1,0 ], [ 0,1 ]] ) );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( projR ) );
#! 1, 0, 0
#! (over a graded ring)
projR2 := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectR, 
         SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
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
                             SemigroupGeneratorList( [[ 1,0 ], [ 0,2 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the semigroup generated by [ [ 1, 0 ], [ 0, 2 ] ]
truncatorR2 := TruncationFunctorForProjectiveGradedRightModules(
                        S, SemigroupGeneratorList( [[ 1,0 ], [ 0,1 ]] ) );
#! Truncation functor for CAP category of projective graded 
#! right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone given by the h-constraints [ [ 0, 1 ], [ 1, 0 ] ]
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
                               ( S, SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! Natural transformation from Truncation functor for CAP category 
#! of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone given by the h-constraints [ [ 0, 1 ], [ 1, 0 ] ] to id
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
                           S, SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! Truncation functor for Category of graded left module presentations 
#! over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone given by the h-constraints [ [ 0, 1 ], [ 1, 0 ] ]
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
                            S, SemigroupGeneratorList( [[1,0],[0,1]] ) );
#! Truncation functor for Category of graded right module presentations 
#! over Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone given by the h-constraints [ [ 0, 1 ], [ 1, 0 ] ]
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