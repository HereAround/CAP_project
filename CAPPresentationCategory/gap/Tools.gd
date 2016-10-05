#############################################################################
##
## CAPPresentationCategory
##
## Copyright 2016,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Convenience methods
##
#############################################################################


####################################################################################
##
#! @Section Powers of objects and morphisms
##
####################################################################################

#!
DeclareOperation( "\*",
               [ IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ] );

#!
DeclareOperation( "\^",
               [ IsCAPPresentationCategoryObject, IsInt ] );

#!
DeclareOperation( "\*",
               [ IsCAPPresentationCategoryMorphism, IsCAPPresentationCategoryMorphism ] );

#!
DeclareOperation( "\^",
               [ IsCAPPresentationCategoryMorphism, IsInt ] );



####################################################################################
##
#! @Section Determine if a category is a Proj-category
##
####################################################################################

DeclareGlobalFunction( "IsProjCategory" );

DeclareGlobalFunction( "IsMonoidalStructurePresent" );