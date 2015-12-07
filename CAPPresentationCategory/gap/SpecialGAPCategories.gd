#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
#! @Chapter GAP categories supported in CAPPresentationCategory
##
#############################################################################


##################################################
##
#! @Section The GAP Categories for generic objects
##
##################################################

#! @Description
#! The GAP category of objects in the presentation category over a proj-category $P$.
#! @Arguments object
DeclareCategory( "IsCAPPresentationCategoryObject",
                 IsCapCategoryObject );



##################################################
##
#! @Section The GAP Categories for special objects
##
##################################################

#! @Description
#! The GAP category of graded left and right module presentations.
#! @Arguments object
DeclareCategory( "IsGradedLeftOrRightModulePresentationForCAP",
                 IsCAPPresentationCategoryObject );

#! @Description
#! The GAP category of objects in the presentation category over the category of projective graded left modules.
#! @Arguments object
DeclareCategory( "IsGradedLeftModulePresentationForCAP",
                 IsGradedLeftOrRightModulePresentationForCAP );

#! @Description
#! The GAP category of objects in the presentation category over the category of projective graded right modules.
#! @Arguments object
DeclareCategory( "IsGradedRightModulePresentationForCAP",
                 IsGradedLeftOrRightModulePresentationForCAP );



##################################################
##
#! @Section The GAP Category for generic morphisms
##
##################################################

#! @Description
#! The GAP category of morphisms in the presentation category over a proj-category $P$.
#! @Arguments object
DeclareCategory( "IsCAPPresentationCategoryMorphism",
                 IsCapCategoryMorphism );



##################################################
##
#! @Section The GAP Category for special morphisms
##
##################################################

#! @Description
#! The GAP category of left or right module presentation morphisms
#! @Arguments object
DeclareCategory( "IsGradedLeftOrRightModulePresentationMorphismForCAP",
                 IsCAPPresentationCategoryMorphism );

#! @Description
#! The GAP category of morphisms in the presentation category over the category of projective graded left modules.
#! @Arguments object
DeclareCategory( "IsGradedLeftModulePresentationMorphismForCAP",
                 IsGradedLeftOrRightModulePresentationMorphismForCAP );

#! @Description
#! The GAP category of morphisms in the presentation category over the category of projective graded right modules.
#! @Arguments object
DeclareCategory( "IsGradedRightModulePresentationMorphismForCAP",
                 IsGradedLeftOrRightModulePresentationMorphismForCAP );