#############################################################################
##
## PresentationsByProjectiveGradedModules
##
## Copyright 2016,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Functors for graded module presentations for CAP
##
#############################################################################


# an attribute for homalg_matrices, that allows to represent that matrix 'smaller'
DeclareAttribute( "LessGradedGeneratorsTransformationTripleLeft",
                  IsHomalgMatrix );
DeclareAttribute( "LessGradedGeneratorsTransformationTripleRight",
                  IsHomalgMatrix );


#################################################
##
#! @Section Functor less_generators for S-fpgrmod
##
#################################################

#! @Description
#! The argument is a graded left or right module presentation $M$ for CAP. We then return a presentation of this
#! module which uses less generators.
#! @Returns a graded left or right module presentation for CAP
#! @Arguments M
DeclareOperation( "LessGradedGenerators",
                  [ IsGradedLeftOrRightModulePresentationForCAP ] );

#! @Description
#! The argument is a graded left or right module presentation morphism $a$ for CAP. We then return a presentation of this
#! morphism which uses less generators.
#! @Returns a graded left or right module presentation morphism for CAP
#! @Arguments a
DeclareOperation( "LessGradedGenerators",
                  [ IsGradedLeftOrRightModulePresentationMorphismForCAP ] );

# a function that computes the functor 'LessGenerators' for both left and right presentations
DeclareGlobalFunction( "FunctorLessGradedGenerators" );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a left 
#! presentation in S-fpgrmodL as input and computes a presentation having less generators.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorLessGradedGeneratorsLeft",
                  IsHomalgGradedRing );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a right 
#! presentation in S-fpgrmodR as input and computes a presentation having less generators.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorLessGradedGeneratorsRight",
                  IsHomalgGradedRing );




#################################################
##
#! @Section Functor StandardModule for S-fpgrmod
##
#################################################

#! @Description
#! The argument is a graded left or right module presentation $M$ for CAP. We then try to reduce the relations and
#! thereby return a new presentation - the Standard module.
#! @Returns a graded left or right module presentation for CAP
#! @Arguments M
DeclareOperation( "GradedStandardModule",
                  [ IsGradedLeftOrRightModulePresentationForCAP ] );

#! @Description
#! The argument is a graded left or right module presentation morphism $a$ for CAP. We then try to reduce the relations
#! and thereby return a new presentation, which we term the Standard module morphism.
#! @Returns a graded left or right module presentation morphism for CAP
#! @Arguments a
DeclareOperation( "GradedStandardModule",
                  [ IsGradedLeftOrRightModulePresentationMorphismForCAP ] );

# a function that computes the functor 'StandardModule' for both left and right presentations
DeclareGlobalFunction( "FunctorGradedStandardModule" );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a left 
#! presentation in S-fpgrmodL as input and computes its standard presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorGradedStandardModuleLeft",
                  IsHomalgGradedRing );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a right
#! presentation in S-fpgrmodR as input and computes its standard presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorGradedStandardModuleRight",
                  IsHomalgGradedRing );



########################################################
##
#! @Section Functor ByASmallerPresentation for S-fpgrmod
##
########################################################

#! @Description
#! The argument is a graded left or right module presentation $M$ for CAP. We then return a smaller presentation of this
#! module. This is obtained by first applying 'LessGenerators' and then 'StandardModule'.
#! @Returns a graded left or right module presentation for CAP
#! @Arguments M
DeclareOperation( "ByASmallerPresentation",
                  [ IsGradedLeftOrRightModulePresentationForCAP ] );

#! @Description
#! The argument is a graded left or right module presentation morphism $a$ for CAP. We then return a smaller presentation of this
#! morphism. This is obtained by first applying 'LessGenerators' and then 'StandardModule'.
#! @Returns a graded left or right module presentation morphism for CAP
#! @Arguments a
DeclareOperation( "ByASmallerPresentation",
                  [ IsGradedLeftOrRightModulePresentationMorphismForCAP ] );

# a function that computes the functor 'LessGenerators' for both left and right presentations
DeclareGlobalFunction( "FunctorByASmallerPresentation" );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a left 
#! presentation in S-fpgrmodL as input and computes a smaller presentation. The latter is achieved by
#! first applying 'LessGenerators' and then acting with 'StandardModule'.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorByASmallerPresentationLeft",
                  IsHomalgGradedRing );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a right
#! presentation in S-fpgrmodR as input and computes a smaller presentation. The latter is achieved by
#! first applying 'LessGenerators' and then acting with 'StandardModule'.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorByASmallerPresentationRight",
                  IsHomalgGradedRing );



###############################################
##
#! @Section The Frobenius-power functor
##
###############################################

# Frobenius power of matrix
DeclareGlobalFunction( "FrobeniusPowerOfMatrix" );

#! @Description
#! The arguments are a CAPPresentationCategoryObject $M$ and a non-negative integer $p$. This method
#! then computes the $p$-th Frobenius power of $M$.
#! @Returns a presentation category object
#! @Arguments M, p
DeclareOperation( "FrobeniusPower",
                  [ IsGradedLeftOrRightModulePresentationForCAP, IsInt ] );

#! @Description
#! The arguments are a CAPPresentationCategoryMorphism $M$ and a non-negative integer $p$. This method
#! then computes the $p$-th Frobenius power of $M$.
#! @Returns a presentation category morphism
#! @Arguments M, p
DeclareOperation( "FrobeniusPower",
                  [ IsGradedLeftOrRightModulePresentationMorphismForCAP, IsInt ] );

#! @Description
#! The arguments are a CAPPresentationCategoryMorphism $m$, a non-negative integer $p$, the p-th Frobenius power of
#! the source of $m$, $s^\prime$, and the p-th Frobenius power of the range of $m$, $r^\prime$. This method
#! then computes the $p$-th Frobenius power of $m$ by use of $s^\prime$ and $r^\prime$.
#! @Returns a presentation category morphism
#! @Arguments m, p, s', r'
DeclareOperation( "FrobeniusPowerWithGivenSourceAndRangePowers",
                  [ IsGradedLeftOrRightModulePresentationMorphismForCAP, IsInt,
                    IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP ] );

# a function that computes the truncation functor for both left and right presentations
DeclareGlobalFunction( "FrobeniusPowerFunctor" );

#! @Description
#! The argument is a homalg graded ring $R$ and a non-negative integers $p$. The output is the 
#! functor which takes graded left-presentations and -morphisms to their p-th Frobenius power.
#! @Returns a functor
#! @Arguments R, p
DeclareOperation( "FrobeniusPowerFunctorLeft",
                  [ IsHomalgGradedRing, IsInt ] );

#! @Description
#! The argument is a homalg graded ring $R$ and a non-negative integers $p$. The output is the 
#! functor which takes graded right-presentations and -morphisms to their p-th Frobenius power.
#! @Returns a functor
#! @Arguments R, p
DeclareOperation( "FrobeniusPowerFunctorRight",
                  [ IsHomalgGradedRing, IsInt ] );