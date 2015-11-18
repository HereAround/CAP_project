#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Functors for graded module presentations for CAP
##
#############################################################################

#################################################
##
#! @Section Functor less_generators for S-fpgrmod
##
#################################################

# an attribute for homalg_matrices, that allows to represent that matrix 'smaller'
DeclareAttribute( "LessGradedGeneratorsTransformationTriple",
                  IsHomalgMatrix );

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


###############################################
##
#! @Section The truncation functor
##
###############################################

# a function that computes the truncation functor for both left and right presentations
DeclareGlobalFunction( "TruncationFunctor" );

#! @Description
#! The argument is a homalg graded ring $R$ and a cone $C$ (given by an H-presentation) in the
#! degree group of the ring $R$. The output is the functor which truncates left-presentations
#! over $R$ to the cone $C$.
#! @Returns a functor
#! @Arguments R, C
DeclareOperation( "TruncationFunctorLeft",
                  [ IsHomalgGradedRing, IsList ] );

#! @Description
#! The argument is a homalg graded ring $R$ and a cone $C$ (given by an H-presentation) in the
#! degree group of the ring $R$. The output is the functor which truncates right-presentations
#! over $R$ to the cone $C$.
#! @Returns a functor
#! @Arguments R, C
DeclareOperation( "TruncationFunctorRight",
                  [ IsHomalgGradedRing, IsList ] );
                  
###############################################
##
#! @Section The Frobenius-power functor
##
###############################################

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