#############################################################################
##
## CAPPresentationCategory package
##
## Copyright 2016, Martin Bies,       ITP Heidelberg
##
#! @Chapter Presentation Category
##
#############################################################################

##############################################
##
#! @Section Constructor
##
##############################################

#! @Description
#! The argument is a so-called proj-category $P$. That is an additive category with weak lifts, weak kernels and a
#! rigid, symmmetric, closed monoidal structure. The output is then the presentation category over this proj-category.
#! Given that $P$ is a strict monoidal category, or that direct sums with the zero object of $P$ lead to identical
#! objects, can simplify the structure of the presentation category (in that unitors become identities - not sure about
#! the associators yet!) This could in principle be used, but is not used as of now. FIX ME FIX ME FIX ME).
#! @Returns a category
#! @Arguments P
DeclareAttribute( "PresentationCategory",
                  IsCapCategory );

###################################################
##
## Install the methods of the presentation category
##
###################################################

DeclareGlobalFunction( "ADD_BASIC_FUNCTIONS_FOR_PRESENTATION_CATEGORY" );

DeclareGlobalFunction( "ADD_MONOIDAL_FUNCTIONS_FOR_PRESENTATION_CATEGORY" );
