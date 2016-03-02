#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Graded submodules of projective graded modules over a graded ring
##
#############################################################################



##############################################################################################
##
#! @Section GAP category of graded submodules for CAP
##
##############################################################################################

#! @Description
#! The GAP category of graded left submodules for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedLeftSubmoduleForCAP",
                 IsGradedLeftModulePresentationForCAP );

#! @Description
#! The GAP category of graded right submodules for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedRightSubmoduleForCAP",
                 IsGradedRightModulePresentationForCAP );

#! @Description
#! The GAP category of graded left or right submodules for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedLeftOrRightSubmoduleForCAP",
                 IsGradedLeftOrRightModulePresentationForCAP );

InstallTrueMethod( IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightSubmoduleForCAP );
InstallTrueMethod( IsGradedLeftOrRightSubmoduleForCAP, IsGradedLeftSubmoduleForCAP );
InstallTrueMethod( IsGradedLeftOrRightSubmoduleForCAP, IsGradedRightSubmoduleForCAP );



##############################################################################################
##
#! @Section GAP category of graded ideals for CAP
##
##############################################################################################

#! @Description
#! The GAP category of graded left ideals for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedLeftIdealForCAP",
                 IsGradedLeftSubmoduleForCAP  );

#! @Description
#! The GAP category of graded right ideals for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedRightIdealForCAP",
                 IsGradedRightSubmoduleForCAP );

#! @Description
#! The GAP category of graded left or right ideals for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedLeftOrRightIdealForCAP",
                 IsGradedLeftOrRightSubmoduleForCAP );

InstallTrueMethod( IsGradedLeftOrRightSubmoduleForCAP, IsGradedLeftOrRightIdealForCAP );
InstallTrueMethod( IsGradedLeftOrRightIdealForCAP, IsGradedLeftIdealForCAP );
InstallTrueMethod( IsGradedLeftOrRightIdealForCAP, IsGradedRightIdealForCAP );



##############################################################################################
##
#! @Section Constructors for graded submodules from a list list and a graded ring
##
##############################################################################################

# a function that computes a graded submodule from a listlist and a a graded ring
DeclareGlobalFunction( "GradedSubmoduleFromListListAndGradedRing" );

#! @Description
#! The arguments are a graded ring <A>R</A> and a list of lists <A>L</A> of homogeneous elements of <A>R</A> which 
#! generate the submodule. The method then returns the corresponding graded left submodule.
#! @Returns a graded left submodule for CAP
#! @Arguments L, R
DeclareOperation( "GradedLeftSubmoduleForCAP",
                  [ IsList, IsHomalgGradedRing ] );

#! @Description
#! The arguments are a graded ring <A>R</A> and a list of lists <A>L</A> of homogeneous elements of <A>R</A> which 
#! generate the submodule. The method then returns the corresponding graded right submodule.
#! @Returns a graded right submodule for CAP
#! @Arguments L, R
DeclareOperation( "GradedRightSubmoduleForCAP",
                  [ IsList, IsHomalgGradedRing ] );



###############################################################################################
##
#! @Section Constructors for graded submodules from a list of lists and a specified superobject
##
###############################################################################################

# a function that computes a graded submodule from a listlist and a given superobject
DeclareGlobalFunction( "GradedSubmoduleFromListListAndGivenRange" );

#! @Description
#! The arguments are a projective graded left module <A>M</A> defined over a graded ring <A>R</A>
#! and a list of lists <A>L</A> of homogeneous elements from <A>R</A> which 
#! generate the submodule. The method then returns the corresponding graded left submodule of <A>M</A>.
#! @Returns a graded left submodule for CAP
#! @Arguments L, M
DeclareOperation( "GradedLeftSubmoduleForCAP",
                  [ IsList, IsCAPCategoryOfProjectiveGradedLeftModulesObject ] );

#! @Description
#! The arguments are a projective graded right module <A>M</A> defined over a graded ring <A>R</A>
#! and a list of lists <A>L</A> of homogeneous elements from <A>R</A> which 
#! generate the submodule. The method then returns the corresponding graded right submodule of <A>M</A>.
#! @Returns a graded right submodule for CAP
#! @Arguments L, M
DeclareOperation( "GradedRightSubmoduleForCAP",
                  [ IsList, IsCAPCategoryOfProjectiveGradedRightModulesObject ] );



##############################################################################################
##
#! @Section Constructors for graded submodules from a morphism
##
##############################################################################################

# a function that computes a graded submodule from a morphism
DeclareGlobalFunction( "GradedSubmoduleFromMorphism" );

#! @Description
#! The argument is a morphism of projective graded left modules <A>a</A>. The kernel embedding of $a$ is then
#! used to define a left presentation that we embed into the projective module $\text{Range} \left( a \right)$. 
#! Thereby we constructed a graded left submodule.
#! @Returns a graded left submodule for CAP
#! @Arguments a
DeclareOperation( "GradedLeftSubmoduleForCAP",
                  [ IsCAPCategoryOfProjectiveGradedLeftModulesMorphism ] );

#! @Description
#! The argument is a morphism of projective graded right modules <A>a</A>. The kernel embedding of $a$ is then
#! used to define a right presentation that we embed into the projective module $\text{Range} \left( a \right)$. 
#! Thereby we constructed a graded left submodule.
#! @Returns a graded right submodule for CAP
#! @Arguments a
DeclareOperation( "GradedRightSubmoduleForCAP",
                  [ IsCAPCategoryOfProjectiveGradedRightModulesMorphism ] );



##############################################################################################
##
#! @Section Attributes for graded submodules
##
##############################################################################################

#! @Description
#! The argument is a graded left or right submodule <A>M</A> over a graded ring. 
#! We then return a left or right presentation of this submodule, respectively.
#! @Returns a graded left presentation for CAP
#! @Arguments M
DeclareAttribute( "PresentationForCAP",
                  IsGradedLeftOrRightSubmoduleForCAP );

#! @Description
#! The argument is a graded left or right submodule <A>M</A> over a graded ring. 
#! We then return the list of generators of this submodule.
#! @Returns a list
#! @Arguments M
DeclareAttribute( "Generators",
                  IsGradedLeftOrRightSubmoduleForCAP );

#! @Description
#! The argument is a graded left or right submodule <A>M</A> over a graded ring. 
#! We then return this graded ring.
#! @Returns a graded homalg ring
#! @Arguments M
DeclareAttribute( "HomalgGradedRing",
                  IsGradedLeftOrRightSubmoduleForCAP );

#! @Description
#! The argument is a graded left or right submodule <A>M</A> over a graded ring. 
#! We return the embedding of this module into the corresponding projective graded module.
#! @Returns a CAP presentation category morphism
#! @Arguments I
DeclareAttribute( "EmbeddingInSuperObjectForCAP",
                  IsGradedLeftOrRightSubmoduleForCAP );

#! @Description
#! The argument is a graded left or right submodule <A>M</A> in a graded ring. We return the superobject.
#! @Returns a CAP presentation category object
#! @Arguments I
DeclareAttribute( "SuperObjectForCAP",
                  IsGradedLeftOrRightSubmoduleForCAP );



##############################################################################################
##
#! @Section Full information of a submodule
##
##############################################################################################

#! The method 'FullInformation' is also avaiable to display all information about a graded 
#! submodule.



##############################################################################################
##
#! @Section Submodule powers
##
##############################################################################################

#!
DeclareOperation( "\*",
                  [ IsGradedLeftSubmoduleForCAP, IsGradedLeftSubmoduleForCAP ] );

#!
DeclareOperation( "\*",
                  [ IsGradedRightSubmoduleForCAP, IsGradedRightSubmoduleForCAP ] );

#!
DeclareOperation( "\^",
                  [ IsGradedLeftSubmoduleForCAP, IsInt ] );

#!
DeclareOperation( "\^",
                  [ IsGradedRightSubmoduleForCAP, IsInt ] );