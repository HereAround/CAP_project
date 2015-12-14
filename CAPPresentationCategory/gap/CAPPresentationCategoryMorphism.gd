#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
#! @Chapter Morphisms
##
#############################################################################

#############################
##
#! @Section Constructors
##
#############################

#! @Description
#! The arguments are an object $m_1$ in the presentation category, a morphism $a$ in the Underlying 
#! proj-category and a second object $m_2$ in the presentation category. The objects $m_1$ and $m_2$ are induced from
#! morphisms in the underlying proj-category. Let us therefore write $m_1 \colon A \to B$ and $m_2 \colon C \to D$. 
#! Then this data must be such that the source of $a$ equals $B$ and the range of $a$ equals $D$. Moreover there must 
#! exists a sourcelift, i.e. a morphism $b \colon A \to C$ such that the diagram formed from $m_1$, $m_2$, $a$
#! and $b$ is commutative. Given that all of this is satisfied, the output is the corresponding morphism in the 
#! presentation category.
#! @Returns a CAPCategoryMorphism
#! @Arguments m1, a, m2
DeclareOperation( "CAPPresentationCategoryMorphism",
                  [ IsCAPPresentationCategoryObject, IsCapCategoryMorphism, IsCAPPresentationCategoryObject ] );

#! @Description
#! The arguments are an object $m_1$ in the presentation category, a morphism $a$ in the Underlying
#! proj-category, a second object $m_2$ in the presentation category and a boolean <A>checks_wished</A>.
#! If <A>checks_wished = true</A>, this constructor behaves just like the one above, if <A>checks_wished = false</A>,
#! not consistency checks on the given input is performed. Therefore this latter option could be useful for
#! high-performance-applications.
#! @Returns a CAPCategoryMorphism
#! @Arguments m1, a, m2
DeclareOperation( "CAPPresentationCategoryMorphism",
                  [ IsCAPPresentationCategoryObject, IsCapCategoryMorphism, IsCAPPresentationCategoryObject, IsBool ] );



#############################
##
#! @Section Attributes
##
#############################

#! @Description
#! The argument is a morphism $m$ in the presentation category, and the output
#! the underlying morphism in the proj-category.
#! @Returns a CAPCategoryMorphism
#! @Arguments m
DeclareAttribute( "UnderlyingMorphism",
                  IsCAPPresentationCategoryMorphism );

#! @Description
#! The argument is a morphism $m$ in the presentation category. Then source and range of $m$ are objects in the
#! presentation category. In terms of the underlying proj-category we can therefore represent the source of $m$ as
#! $s \colon A \to B$ and its range as $t \colon C \to D$. Moreover $m$ is induced from a morphism
#! $\tilde{m} \colon B \to D$. That said, the output is a morphism $\mu \colon A \to C$ such that the diagram formed from
#! $s$, $\tilde{m}$, $\mu$ and $t$ is commutative.
#! @Returns a CAPCategoryMorphism
#! @Arguments m
DeclareAttribute( "SourceLiftMorphism",
                  IsCAPPresentationCategoryMorphism );

#####################################################
##
#! @Section Printing all information about a morphism
##
#####################################################

#! @Description
#! The argument is a morphism $m$ in the presentation category. For such a morphisms it can be tedious 
#! to work out the source and ranges in detail with the ordinary display and view methods. To encompass this
#! shortcoming, this method produces all this information with just a single command.
#! @Returns detailed information about the morphism
#! @Arguments m
DeclareOperation( "FullInformation",
                 [ IsCAPPresentationCategoryMorphism ] );

##############################################
##
## Non categorical methods
##
##############################################

# StandardGeneratorMorphism -> this is what? Do I need it here?