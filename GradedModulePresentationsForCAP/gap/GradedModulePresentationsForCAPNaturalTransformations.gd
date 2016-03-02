#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Natural transformations for graded module presentations for CAP
##
#############################################################################


####################################################################################
##
#! @Section Natural isomorphism from identity functor to the standard module functor
##
####################################################################################

# a function that computes the natural isomorphism 1 => StandardModule for both
# left and right presentations
DeclareGlobalFunction( "NaturalIsomorphismFromIdentityToGradedStandardModule" );

#! @Description
#! The argument is a homalg graded ring $S$. The output is the natural morphism from the identity functor
#! to the left standard module functor.
#! @Returns a natural transformation $\mathrm{Id} \Rightarrow \mathrm{StandardModuleLeft}$
#! @Arguments S
DeclareAttribute( "NaturalIsomorphismFromIdentityToGradedStandardModuleLeft",
                  IsHomalgGradedRing );

#! @Description
#! The argument is a homalg ring $S$. The output is the natural morphism from the identity functor
#! to the right standard module functor.
#! @Returns a natural transformation $\mathrm{Id} \Rightarrow \mathrm{StandardModuleRight}$
#! @Arguments S
DeclareAttribute( "NaturalIsomorphismFromIdentityToGradedStandardModuleRight",
                  IsHomalgGradedRing );
