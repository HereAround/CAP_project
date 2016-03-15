#############################################################################
##
## TruncationsOfGradedModulePresentationsForCAP package
##
## Copyright 2016,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Functors for graded module presentations for CAP
##
#############################################################################



################################################
##
#! @Section The truncation functor to cones
##
################################################

#! @Description
#! The argument is a graded left or right module presentation $M$ for CAP and an H-presentation of a cone $C$.
#! We then truncate $M$ to this cone $C$ and return the resulting module presentation.
#! @Returns a graded left or right module presentation for CAP
#! @Arguments M, C
DeclareOperation( "Truncation",
                  [ IsGradedLeftOrRightModulePresentationForCAP, IsConeHPresentationList ] );

#! @Description
#! The argument is a graded left or right module presentation morphism $a$ for CAP and an H-presentation of a cone $C$.
#! We then return the truncation of $a$ to $C$.
#! @Returns a graded left or right module presentation morphism for CAP
#! @Arguments a, C
DeclareOperation( "Truncation",
                  [ IsGradedLeftOrRightModulePresentationMorphismForCAP, IsConeHPresentationList ] );

# a function that computes the truncation functor for both left and right presentations
DeclareGlobalFunction( "TruncationFunctorToCones" );

#! @Description
#! The argument is a homalg graded ring $R$ and a semigroup $H$ of a cone (given by a list of generators) in the
#! degree group of the ring $R$. The output is the functor which truncates left-presentations
#! over $R$ to this subsemigroup.
#! @Returns a functor
#! @Arguments R, C
DeclareOperation( "TruncationFunctorLeft",
                  [ IsHomalgGradedRing, IsConeHPresentationList ] );

#! @Description
#! The argument is a homalg graded ring $R$ and a semigroup $H$ of a cone (given by a list of generators) in the
#! degree group of the ring $R$. The output is the functor which truncates right-presentations
#! over $R$ to this subsemigroup.
#! @Returns a functor
#! @Arguments R, C
DeclareOperation( "TruncationFunctorRight",
                  [ IsHomalgGradedRing, IsConeHPresentationList ] );


################################################
##
#! @Section The truncation functor to semigroups
##
################################################

#! @Description
#! The argument is a graded left or right module presentation $M$ for CAP and and a semigroup $H$ given by
#! a SemigroupGeneratorList. We then return the truncation of $M$ onto $H$.
#! @Returns a graded left or right module presentation for CAP
#! @Arguments M, H
DeclareOperation( "Truncation",
                  [ IsGradedLeftOrRightModulePresentationForCAP, IsSemigroupGeneratorList ] );

#! @Description
#! The argument is a graded left or right module presentation morphism $a$ for CAP and a semigroup $H$ given by 
#! a SemigroupGeneratorList. We then return the truncation of $a$ to $H$.
#! @Returns a graded left or right module presentation morphism for CAP
#! @Arguments a, H
DeclareOperation( "Truncation",
                  [ IsGradedLeftOrRightModulePresentationMorphismForCAP, IsSemigroupGeneratorList ] );

# a function that computes the truncation functor for both left and right presentations
DeclareGlobalFunction( "TruncationFunctorToSemigroups" );

#! @Description
#! The argument is a homalg graded ring $R$ and a semigroup $H$ (given by a list of generators) in the
#! degree group of the ring $R$. The output is the functor which truncates left-presentations
#! over $R$ to this subsemigroup.
#! @Returns a functor
#! @Arguments R, C
DeclareOperation( "TruncationFunctorLeft",
                  [ IsHomalgGradedRing, IsSemigroupGeneratorList ] );

#! @Description
#! The argument is a homalg graded ring $R$ and a semigroup $H$ (given by a list of generators) in the
#! degree group of the ring $R$. The output is the functor which truncates right-presentations
#! over $R$ to this subsemigroup.
#! @Returns a functor
#! @Arguments R, C
DeclareOperation( "TruncationFunctorRight",
                  [ IsHomalgGradedRing, IsSemigroupGeneratorList ] );