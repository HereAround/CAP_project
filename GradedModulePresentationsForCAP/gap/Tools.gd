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
                  [ IsCAPPresentationCategoryObject, IsInt ] );

#! @Description
#! The arguments are a CAPPresentationCategoryMorphism $M$ and a non-negative integer $p$. This method
#! then computes the $p$-th Frobenius power of $M$.
#! @Returns a presentation category morphism
#! @Arguments M, p
DeclareOperation( "FrobeniusPower",
                  [ IsCAPPresentationCategoryMorphism, IsInt ] );


####################################################################################
##
#! @Section Saturation
##
####################################################################################

#! @Description
#! The arguments are two CAPPresentationCategoryObject $M$ and $I$. We check that the letter can be embedded into 
#! the underlying graded ring $S$, i.e. can be viewed as an ideal in $S$. We then compute the 
#! saturation of $M$ with respect to $I$.
#! @Returns a presentation category object
#! @Arguments M, I
DeclareOperation( "Saturate",
                  [ IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ] );

#! @Description
#! The arguments are two CAPPresentationCategoryObject $M$ and $I$. We check that the letter can be embedded into 
#! the underlying graded ring $S$, i.e. can be viewed as an ideal in $S$. We then compute the embedding of $M$ into its 
#! saturation with respect to $I$.
#! @Returns a presentation category morphism
#! @Arguments M, I
DeclareOperation( "EmbeddingInSaturatedGradedModulePresentation",
                  [ IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ] );



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
                  [ IsCAPPresentationCategoryObject ] );
                  