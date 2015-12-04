#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Tools
##
#############################################################################


####################################################################################
##
#! @Section Frobenius powers of presentations
##
####################################################################################

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


####################################################################################
##
#! @Section Saturation
##
####################################################################################

#! @Description
#! The arguments are two CAPPresentationCategoryObject $M$ and a graded left ideal $I$. 
#! We then compute the saturation of $M$ with respect to $I$.
#! @Returns a presentation category object
#! @Arguments M, I
DeclareOperation( "Saturate",
                  [ IsGradedLeftModulePresentationForCAP, IsGradedLeftIdealForCAP ] );

#! @Description
#! The arguments are two CAPPresentationCategoryObject $M$ and a graded right ideal $I$. 
#! We then compute the saturation of $M$ with respect to $I$.
#! @Returns a presentation category object
#! @Arguments M, I
DeclareOperation( "Saturate",
                  [ IsGradedRightModulePresentationForCAP, IsGradedRightIdealForCAP ] );

#! @Description
#! The arguments are two CAPPresentationCategoryObject $M$ and a graded left idea l$I$. 
#! We then compute the embedding of $M$ into its saturation with respect to $I$.
#! @Returns a presentation category morphism
#! @Arguments M, I
DeclareOperation( "EmbeddingInSaturationOfGradedModulePresentation",
                  [ IsGradedLeftModulePresentationForCAP, IsGradedLeftIdealForCAP ] );

#! @Description
#! The arguments are two CAPPresentationCategoryObject $M$ and a graded right ideal $I$. 
#! We then compute the embedding of $M$ into its saturation with respect to $I$.
#! @Returns a presentation category morphism
#! @Arguments M, I
DeclareOperation( "EmbeddingInSaturationOfGradedModulePresentation",
                  [ IsGradedRightModulePresentationForCAP, IsGradedRightIdealForCAP ] );



####################################################################################
##
#! @Section Embeddings in projective modules
##
####################################################################################
                  
#! @Description
#! The argument is a CAPPresentationCategoryObject <A>M</A>, which is represented by a morphism $m$ in the underlying
#! category of projective modules. In this category we can compute the cokernel projection $m$ (although this need not be
#! possible in more general proj-categories). The range of this morphism is a projective module. The zero morphism into 
#! this very projective module defines an object of the presentation category, which allows us to embed <A>M</A> 
#! into a projective module presentation. The corresponding presentation category morphism is returned.
#! @Returns a presentation category morphism
#! @Arguments M
DeclareOperation( "EmbeddingInProjectiveObject",
                  [ IsGradedLeftOrRightModulePresentationForCAP ] );



####################################################################################
##
#! @Section Minimal free resolutions
##
####################################################################################

#! @Description
#! The argument is a graded left or right module presentation <A>M</A>. We then compute a minimal
#! free resolution of <A>M</A>.
#! @Returns a list of CAPPresentationCategoryMorphisms
#! @Arguments M
DeclareOperation( "MinimalFreeResolution",
                  [ IsGradedLeftOrRightModulePresentationForCAP ] );

## for my convenience a method that displays all information about a (co)complex
DeclareOperation( "FullInformation",
                  [ IsCapComplex ] );

DeclareOperation( "FullInformation",
                  [ IsCapCocomplex ] );