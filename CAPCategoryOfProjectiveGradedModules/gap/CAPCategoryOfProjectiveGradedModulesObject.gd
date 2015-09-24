# TODO:


# when zero object is entered in fancy fashion, I should immediately reduce the input


# convenience constructer: Z -> homalgRing( ClassGroup( homalg_graded_ring ) );


# add hard checks to verify that an object/morphism really belongs to this category


# two graded module morphism are NOT identical when the have the same mapping matrix, for this does not fix the degrees of the
# source or range respectively
# -> thus is AddIsCongruentForMorphism the correct commmand?
# or should I use AddIsIdenticalForMorphism in addition to a check that the source/ range objects are identical as objects???


# go through the implementation of the right modules in detail and verify each row <-> column and transpoed swap and try to
# right more efficient algorithms

#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################


DeclareCategory( "IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject",
                 IsCapCategoryObject );

DeclareCategory( "IsCAPCategoryOfProjectiveGradedLeftModulesObject",
                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject );

DeclareCategory( "IsCAPCategoryOfProjectiveGradedRightModulesObject",
                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject );


####################################
##
## Constructors
##
####################################

DeclareGlobalFunction( "CAPCategoryOfProjectiveGradedLeftOrRightModulesObject" );

DeclareOperation( "CAPCategoryOfProjectiveGradedLeftModulesObject",
                  [ IsList, IsHomalgGradedRing ] );

DeclareOperation( "CAPCategoryOfProjectiveGradedRightModulesObject",
                  [ IsList, IsHomalgGradedRing ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject );

DeclareAttribute( "DegreeList",
                  IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject );
                  
DeclareAttribute( "RankOfObject",
                  IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject );
                  
########################################################
##
## Operation to sort degree_lists when we construct them
##
########################################################
                
DeclareOperation( "CAP_CATEGORY_OF_PROJECTIVE_GRADED_MODULES_INTERNAL_SIMPLIFY_DATA_STRUCTURE",
                  [ IsList ] );