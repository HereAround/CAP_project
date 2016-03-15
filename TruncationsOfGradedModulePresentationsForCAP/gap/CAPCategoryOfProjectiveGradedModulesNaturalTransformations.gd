#############################################################################
##
## TruncationsOfGradedModulePresentationsForCAP package
##
## Copyright 2016, Martin Bies,       ITP Heidelberg
##
#! @Chapter Natural transformations
##
#############################################################################


####################################################################################
##
#! @Section Natural transformations for projective graded modules
##
####################################################################################

# a function that computes the natural transformation |_C => id for both
# left and right presentations
DeclareGlobalFunction( "NaturalTransformationFromTruncationToIdentityForProjectiveGradedModules" );

#! @Description
#! The argument is a homalg graded ring $S$ and a cone $C$ in the degree group of $S$. 
#! The output is the natural transformation from the left truncation functor (to $C$) to the
#! identity functor.
#! @Returns a natural transformation $\left. \cdot \right|_C \Rightarrow \mathrm{id}$
#! @Arguments S
DeclareOperation( "NaturalTransformationFromTruncationToIdentityForProjectiveGradedLeftModules",
                  [ IsHomalgGradedRing, IsSemigroupGeneratorList ] );

#! @Description
#! The argument is a homalg graded ring $S$ and a cone $C$ in the degree group of $S$. 
#! The output is the natural transformation from the right truncation functor (to $C$) to the
#! identity functor.
#! @Returns a natural transformation $\left. \cdot \right|_C \Rightarrow \mathrm{id}$
#! @Arguments S
DeclareOperation( "NaturalTransformationFromTruncationToIdentityForProjectiveGradedRightModules",
                  [ IsHomalgGradedRing, IsSemigroupGeneratorList ] );
