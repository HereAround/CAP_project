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
#! @Returns a complex of projective graded module morphisms
#! @Arguments M
DeclareAttribute( "MinimalFreeResolutionForCAP",
                  IsGradedLeftOrRightModulePresentationForCAP );

## for my convenience a method that displays all information about a (co)complex
DeclareOperation( "FullInformation",
                  [ IsCapComplex ] );

DeclareOperation( "FullInformation",
                  [ IsCapCocomplex ] );



####################################################################################
##
#! @Section Betti tables
##
####################################################################################

#! @Description
#! The argument is a graded left or right module presentation <A>M</A>. We then compute the Betti table 
#! of <A>M</A>.
#! @Returns a list of lists
#! @Arguments M
DeclareAttribute( "BettiTableForCAP",
                  IsGradedLeftOrRightModulePresentationForCAP );



####################################################################################
##
#! @Section Extension modules
##
####################################################################################

#! @Description
#! The arguments are an integer <A>i<A> and two f.p. graded modules <A>M_1<A> and <A>M_2<A>. Then this method
#! computes <A>\text{Ext}^i \left( M_1, M_2 \right) </A>.
#! @Returns a f.p. graded module
#! @Arguments e, M1, M2
DeclareOperation( "GradedExtForCAP",
                  [ IsInt, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP ] );