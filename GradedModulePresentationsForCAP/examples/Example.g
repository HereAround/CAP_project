#! @Chapter Examples and Tests

#! @Section The category SfpgrmodLeft

LoadPackage( "GradedModulePresentationsForCAP" );;

#! @Example

Q := HomalgFieldOfRationalsInSingular();
#! Q
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: yet unset)
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );
#!
category_left := SfpgrmodLeft( S );
#! Category of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
functor1_left := FunctorLessGradedGeneratorsLeft( S );
#! Less generators for Category of graded left module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
functor2_left := FunctorGradedStandardModuleLeft( S );
#! Graded standard module for Category of graded left module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
natural_transformation_left := 
NaturalIsomorphismFromIdentityToGradedStandardModuleLeft( S );
#! Natural isomorphism from Id to Graded standard module for Category of graded
#! left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])

#! @EndExample

#! @Section The category SfpgrmodRight

#! @Example
category_right := SfpgrmodRight( S );
#! Category of graded right module presentations over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
functor1_right := FunctorLessGradedGeneratorsRight( S );
#! Less generators for Category of graded right module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
functor2_right := FunctorGradedStandardModuleRight( S );
#! Graded standard module for Category of graded right module presentations over
#! Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
natural_transformation_right := 
NaturalIsomorphismFromIdentityToGradedStandardModuleRight( S );
#! Natural isomorphism from Id to Graded standard module for Category of graded
#! right module presentations over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])

#! @EndExample



#! @Section Graded left ideals

#! @Example
IdealLeft := GradedLeftSubmoduleForCAP( [ [ "x_1*x_3" ], 
             [ "x_1*x_4" ], [ "x_2*x_3" ] , [ "x_2*x_4" ] ], S );
#! <A graded left ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Generators( IdealLeft );
#! [ [ "x_1*x_3" ], [ "x_1*x_4" ], [ "x_2*x_3" ], [ "x_2*x_4" ] ]
HomalgGradedRing( IdealLeft );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])
FullInformation( SuperObjectForCAP( IdealLeft ) );
#! 
#! ================================================================================= 
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
#! with matrix: 
#! (an empty 0 x 1 matrix)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! ================================================================================= 
FullInformation( EmbeddingInSuperObjectForCAP( IdealLeft ) );
#! 
#! ================================================================================= 
#!  
#! Source: 
#! ------- 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 1, 2 ), 2 ], [ ( 2, 1 ), 2 ] ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! -x_4,x_3, 0,   0,  
#! 0,   0,   -x_4,x_3,
#! -x_2,0,   x_1, 0,  
#! 0,   -x_2,0,   x_1 
#! (over a graded ring)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 1, 1 ), 4 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1*x_3,
#! x_1*x_4,
#! x_2*x_3,
#! x_2*x_4 
#! (over a graded ring)
#!
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#!
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 0 x 1 matrix)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! ================================================================================= 
#!
IdealLeftToPower2 := IdealLeft * IdealLeft;
#! <A graded left ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( IdealLeftToPower2 );
#! A graded left ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) generated by 
#! [ [ x_1^2*x_3^2 ], [ x_1^2*x_3*x_4 ], [ x_1*x_2*x_3^2 ], [ x_1*x_2*x_3*x_4 ], 
#! [ x_1^2*x_3*x_4 ], [ x_1^2*x_4^2 ], [ x_1*x_2*x_3*x_4 ], [ x_1*x_2*x_4^2 ], 
#! [ x_1*x_2*x_3^2 ], [ x_1*x_2*x_3*x_4 ], [ x_2^2*x_3^2 ], [ x_2^2*x_3*x_4 ], 
#! [ x_1*x_2*x_3*x_4 ], [ x_1*x_2*x_4^2 ], [ x_2^2*x_3*x_4 ], [ x_2^2*x_4^2 ] ]
2ndFrobPowerIdealLeft := FrobeniusPower( IdealLeft, 2 );
#! <A graded left ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( 2ndFrobPowerIdealLeft );
#! A graded left ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) generated by 
#! [ [ x_1^2*x_3^2 ], [ x_1^2*x_4^2 ], [ x_2^2*x_3^2 ], [ x_2^2*x_4^2 ] ]

#! @EndExample








#! @Section Graded right ideals

#! @Example
IdealRight := GradedRightSubmoduleForCAP( [ [ "x_1*x_3", 
             "x_1*x_4", "x_2*x_3", "x_2*x_4" ] ], S );
#! <A graded right ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Generators( IdealRight );
#! [ [ "x_1*x_3", "x_1*x_4", "x_2*x_3", "x_2*x_4" ] ]
HomalgGradedRing( IdealRight );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])
FullInformation( SuperObjectForCAP( IdealRight ) );
#! 
#! ================================================================================= 
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
#! with matrix: 
#! (an empty 1 x 0 matrix)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! ================================================================================= 
#!
FullInformation( EmbeddingInSuperObjectForCAP( IdealRight ) );
#! 
#! ================================================================================= 
#!  
#! Source: 
#! ------- 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 1, 2 ), 2 ], [ ( 2, 1 ), 2 ] ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! -x_4,0,   -x_2,0,   
#! x_3, 0,   0,   -x_2,
#! 0,   -x_4,x_1, 0,   
#! 0,   x_3, 0,   x_1  
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 1, 1 ), 4 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix:
#! x_1*x_3, x_1*x_4, x_2*x_3, x_2*x_4 
#! (over a graded ring)
#!
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#!
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 1 x 0 matrix)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! ================================================================================= 
#!
IdealRightToPower2 := IdealRight * IdealRight;
#! <A graded right ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( IdealRightToPower2 );
#! A graded right ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) generated by 
#! [ [ x_1^2*x_3^2, x_1^2*x_3*x_4, x_1*x_2*x_3^2, x_1*x_2*x_3*x_4, x_1^2*x_3*x_4, 
#! x_1^2*x_4^2, x_1*x_2*x_3*x_4, x_1*x_2*x_4^2, x_1*x_2*x_3^2, x_1*x_2*x_3*x_4, 
#! x_2^2*x_3^2, x_2^2*x_3*x_4, x_1*x_2*x_3*x_4, x_1*x_2*x_4^2, x_2^2*x_3*x_4, 
#! x_2^2*x_4^2 ] ]
2ndFrobPowerIdealRight := FrobeniusPower( IdealRight, 2 );
#! <A graded right ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( 2ndFrobPowerIdealRight );
#! A graded right ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) generated by 
#! [ [ x_1^2*x_3^2, x_1^2*x_4^2, x_2^2*x_3^2, x_2^2*x_4^2 ] ]

#! @EndExample











#! @Section Graded left submodules

#! @Example
SubmoduleLeft := GradedLeftSubmoduleForCAP( [ [ "x_1*x_3" ], 
             [ "x_1*x_4" ], [ "x_2*x_3" ], [ "x_2*x_4" ] ], S );
#! <A graded left ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Generators( SubmoduleLeft );
#! [ [ "x_1*x_3" ], [ "x_1*x_4" ], [ "x_2*x_3" ], [ "x_2*x_4"]  ]
HomalgGradedRing( SubmoduleLeft );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])
SubmoduleLeft2 := GradedLeftSubmoduleForCAP( [ [ "x_1*x_3", 1 ],
             [ "x_1*x_4", 1 ], [ "x_2*x_3", 1 ], [ "x_2*x_4", 1 ] ], S );
#! <A graded left submodule over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( EmbeddingInSuperObjectForCAP( SubmoduleLeft2 ) );
#! 
#! ================================================================================= 
#!
#! Source: 
#! ------- 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees: 
#! [ [ ( 1, 2 ), 1 ], [ ( 2, 1 ), 1 ], [ ( 2, 2 ), 1 ] ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_4,             -x_3,            -x_4,           x_3,
#! x_2,             -x_2,            -x_1,           x_1,
#! -x_2*x_3+x_1*x_4,-x_1*x_3+x_2*x_3,x_1*x_3-x_1*x_4,0   
#! (over a graded ring)

#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 1, 1 ), 4 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1*x_3,1,
#! x_1*x_4,1,
#! x_2*x_3,1,
#! x_2*x_4,1 
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 0 x 2 matrix)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#! 
#! ================================================================================= 
#! 
IsGradedLeftSubmoduleForCAP( SubmoduleLeft2 );
#! true
SubmoduleLeft3 := GradedLeftSubmoduleForCAP( [[ "x_1", 1 ], [ "x_2", 1 ]], 
                  CAPCategoryOfProjectiveGradedLeftModulesObject( 
                                                        [[[-1,0],1],[[0,0],1]], S ) 
                                                                                    );
#! <A graded left submodule over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( EmbeddingInSuperObjectForCAP( SubmoduleLeft3 ) );
#! 
#! ================================================================================= 
#!
#! Source:
#! ------- 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 0 x 2 matrix)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,1,
#! x_2,1 
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 0 x 2 matrix)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( -1, 0 ), 1 ], [ 0, 1 ] ]
#! 
#! ================================================================================= 

#! @EndExample



















#! @Section Graded right submodules

#! @Example
SubmoduleRight := GradedRightSubmoduleForCAP( [ [ "x_1*x_3", 
                  "x_1*x_4", "x_2*x_3", "x_2*x_4" ] ], S );
#! <A graded right ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Generators( SubmoduleRight );
#! [ [ "x_1*x_3", "x_1*x_4", "x_2*x_3", "x_2*x_4"] ]
HomalgGradedRing( SubmoduleRight );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])
SubmoduleRight2 := GradedRightSubmoduleForCAP( [ [ "x_1*x_3",
                  "x_1*x_4", "x_2*x_3", "x_2*x_4" ], [ 1, 1, 1, 1 ] ], S );
#! <A graded right submodule over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( EmbeddingInSuperObjectForCAP( SubmoduleRight2 ) );
#!
#! ================================================================================= 
#!
#! Source: 
#! ------- 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees: 
#! [ [ ( 1, 2 ), 1 ], [ ( 2, 1 ), 1 ], [ ( 2, 2 ), 1 ] ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix:
#! x_4, x_2, -x_2*x_3+x_1*x_4,
#! -x_3,-x_2,-x_1*x_3+x_2*x_3,
#! -x_4,-x_1,x_1*x_3-x_1*x_4, 
#! x_3, x_1, 0                
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 1, 1 ), 4 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1*x_3,x_1*x_4,x_2*x_3,x_2*x_4,
#! 1,      1,      1,      1 
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 2 x 0 matrix)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#! 
#! ================================================================================= 
#! 
IsGradedRightSubmoduleForCAP( SubmoduleRight2 );
#! true
SubmoduleRight3 := GradedRightSubmoduleForCAP( [[ "x_1", "x_2" ], [ 1, 1 ]], 
                  CAPCategoryOfProjectiveGradedRightModulesObject( 
                                                        [[[-1,0],1],[[0,0],1]], S ) 
                                                                                    );
#! <A graded right submodule over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( EmbeddingInSuperObjectForCAP( SubmoduleRight3 ) );
#! 
#! ================================================================================= 
#!
#! Source: 
#! ------- 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 2 x 0 matrix)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2,
#! 1,1 
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 2 x 0 matrix)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( -1, 0 ), 1 ], [ 0, 1 ] ]
#! 
#! =================================================================================

#! @EndExample








#! @Section The Frobenius functor

#! @Example
frob_functor_left := FrobeniusPowerFunctorLeft( S, 2 );
#! Frobenius functor for Category of graded left module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the power 2
FullInformation( ApplyFunctor( frob_functor_left, 
                               EmbeddingInSuperObjectForCAP( IdealLeft ) ) );
#!
#! ================================================================================= 
#! 
#! Source: 
#! ------- 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 2, 4 ), 2 ], [ ( 4, 2 ), 2 ] ]
#! 
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) with matrix: 
#! -x_4^2,x_3^2, 0,     0,    
#! 0,     0,     -x_4^2,x_3^2,
#! -x_2^2,0,     x_1^2, 0,    
#! 0,     -x_2^2,0,     x_1^2 
#! (over a graded ring)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 2, 2 ), 4 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!  
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1^2*x_3^2,
#! x_1^2*x_4^2,
#! x_2^2*x_3^2,
#! x_2^2*x_4^2 
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#!
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 0 x 1 matrix)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#!
#! ================================================================================= 
frob_functor_right := FrobeniusPowerFunctorRight( S, 2 );
#! Frobenius functor for Category of graded right module presentations over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the power 2
FullInformation( ApplyFunctor( frob_functor_right, 
                               EmbeddingInSuperObjectForCAP( IdealRight ) ) );
#! 
#! ================================================================================= 
#!  
#! Source: 
#! ------- 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 2, 4 ), 2 ], [ ( 4, 2 ), 2 ] ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! -x_4^2,0,     -x_2^2,0,     
#! x_3^2, 0,     0,     -x_2^2,
#! 0,     -x_4^2,x_1^2, 0,     
#! 0,     x_3^2, 0,     x_1^2  
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 2, 2 ), 4 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#! 
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1^2*x_3^2,x_1^2*x_4^2,x_2^2*x_3^2,x_2^2*x_4^2
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#!  
#! Range: 
#! ------ 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! (an empty 1 x 0 matrix)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ 0, 1 ] ]
#! 
#! =================================================================================

#! @EndExample




#! @Section Minimal free resolutions and Betti tables

#! @Example
res1 := MinimalFreeResolutionForCAP( IdealLeft );
#! <An object in Complex category of CAP category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( res1 );
#! [ [ [ 1, 1 ], 4 ] ]
#!  ^ 
#!  | 
#! -x_4,x_3, 0,   0,  
#! 0,   0,   -x_4,x_3,
#! -x_2,0,   x_1, 0,  
#! 0,   -x_2,0,   x_1 
#! (over a graded ring)
#!  | 
#! [ [ [ 1, 2 ], 2 ], [ [ 2, 1 ], 2 ] ]
#!  ^ 
#!  | 
#! -x_2,x_1,x_4,-x_3
#! (over a graded ring)
#!  | 
#! [ [ [ 2, 2 ], 1 ] ]
#! 
betti1 := BettiTableForCAP( IdealLeft );
#! [ [ ( -1, -1 ), ( -1, -1 ), ( -1, -1 ), ( -1, -1 ) ], [ ( -1, -2 ), ( -1, -2 ), 
#! ( -2, -1 ), ( -2, -1 ) ], [ ( -2, -2 ) ] ]
res2 := MinimalFreeResolutionForCAP( IdealRight );
#! <An object in Complex category of CAP category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( res2 );
#! [ [ [ 1, 1 ], 4 ] ]
#!  ^ 
#!  | 
#! -x_4,0,   -x_2,0,   
#! x_3, 0,   0,   -x_2,
#! 0,   -x_4,x_1, 0,   
#! 0,   x_3, 0,   x_1  
#! (over a graded ring)
#!  | 
#! [ [ [ 1, 2 ], 2 ], [ [ 2, 1 ], 2 ] ]
#!  ^ 
#!  | 
#! -x_2,
#! x_1, 
#! x_4, 
#! -x_3 
#! (over a graded ring)
#!  | 
#! [ [ [ 2, 2 ], 1 ] ]
#! 
betti2 := BettiTableForCAP( IdealRight );
#! [ [ ( -1, -1 ), ( -1, -1 ), ( -1, -1 ), ( -1, -1 ) ], [ ( -1, -2 ), ( -1, -2 ), 
#! ( -2, -1 ), ( -2, -1 ) ], [ ( -2, -2 ) ] ]

#! @EndExample