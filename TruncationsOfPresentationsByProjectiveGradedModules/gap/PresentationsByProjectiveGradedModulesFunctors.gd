#############################################################################
##
## TruncationsOfPresentationsByProjectiveGradedModules package
##
## Copyright 2016,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Functors for graded module presentations for CAP
##
#############################################################################



################################################
##
#! @Section The truncation functor to semigroups
##
################################################

#! @Description
#! The argument is a graded left or right module presentation $M$ for CAP and and a semigroup $H$ given as
#! SemigroupForPresentationsByProjectiveGradedModules. We then return the truncation of $M$ onto $H$.
#! @Returns a graded left or right module presentation for CAP
#! @Arguments M, H
DeclareOperation( "Truncation",
                  [ IsGradedLeftOrRightModulePresentationForCAP, IsSemigroupForPresentationsByProjectiveGradedModules ] );

#! @Description
#! The argument is a graded left or right module presentation morphism $a$ for CAP and a semigroup $H$ given as
#! IsSemigroupForPresentationsByProjectiveGradedModules. We then return the truncation of $a$ to $H$.
#! @Returns a graded left or right module presentation morphism for CAP
#! @Arguments a, H
DeclareOperation( "Truncation",
                  [ IsGradedLeftOrRightModulePresentationMorphismForCAP, IsSemigroupForPresentationsByProjectiveGradedModules ] );

# a function that computes the truncation functor for both left and right presentations
DeclareGlobalFunction( "TruncationFunctorToSemigroups" );

#! @Description
#! The argument is a homalg graded ring $R$ and a semigroup $H$ (given as SemigroupForPresentationsByProjectiveGradedModules)
#! in the degree group of the ring $R$. The output is the functor which truncates left-presentations over $R$ to
#! this subsemigroup.
#! @Returns a functor
#! @Arguments R, C
DeclareOperation( "TruncationFunctorLeft",
                  [ IsHomalgGradedRing, IsSemigroupForPresentationsByProjectiveGradedModules ] );

#! @Description
#! The argument is a homalg graded ring $R$ and a semigroup $H$ (given as SemigroupForPresentationsByProjectiveGradedModules)
#! in the degree group of the ring $R$. The output is the functor which truncates right-presentations over $R$ to
#! this subsemigroup.
#! @Returns a functor
#! @Arguments R, C
DeclareOperation( "TruncationFunctorRight",
                  [ IsHomalgGradedRing, IsSemigroupForPresentationsByProjectiveGradedModules ] );