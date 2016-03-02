#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
##  Chapter GAP categories supported in CAPPresentationCategory
##
#############################################################################


##################################################
##
##  Section The GAP Categories for generic objects
##
##################################################

DeclareRepresentation( "IsCAPPresentationCategoryObjectRep",
                       IsCAPPresentationCategoryObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPPresentationCategoryObjects",
            NewFamily( "TheFamilyOfCAPPresentationCategoryObjects" ) );

BindGlobal( "TheTypeOfCAPPresentationCategoryObject",
            NewType( TheFamilyOfCAPPresentationCategoryObjects,
                     IsCAPPresentationCategoryObjectRep ) );



##################################################
##
##  Section The GAP Categories for special objects
##
##################################################

##
DeclareRepresentation( "IsGradedLeftOrRightModulePresentationForCAPRep",
                       IsGradedLeftOrRightModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftOrRightModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedLeftOrRightModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftOrRightModulePresentationForCAP",
            NewType( TheFamilyOfGradedLeftOrRightModulePresentationsForCAP,
                     IsGradedLeftOrRightModulePresentationForCAPRep ) );

##
DeclareRepresentation( "IsGradedLeftModulePresentationForCAPRep",
                       IsGradedLeftModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedLeftModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftModulePresentationForCAP",
            NewType( TheFamilyOfGradedLeftModulePresentationsForCAP,
                     IsGradedLeftModulePresentationForCAPRep ) );

##
DeclareRepresentation( "IsGradedRightModulePresentationForCAPRep",
                       IsGradedRightModulePresentationForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightModulePresentationsForCAP",
            NewFamily( "TheFamilyOfGradedRightModulePresentationsForCAP" ) );

BindGlobal( "TheTypeOfGradedRightModulePresentationForCAP",
            NewType( TheFamilyOfGradedRightModulePresentationsForCAP,
                     IsGradedRightModulePresentationForCAPRep ) );



####################################################
##
##  Section The GAP Categories for generic morphisms
##
####################################################

##
DeclareRepresentation( "IsCAPPresentationCategoryMorphismRep",
                       IsCAPPresentationCategoryMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPPresentationCategoryMorphisms",
            NewFamily( "TheFamilyOfCAPPresentationCategoryMorphisms" ) );

BindGlobal( "TheTypeOfCAPPresentationCategoryMorphism",
            NewType( TheFamilyOfCAPPresentationCategoryMorphisms,
                     IsCAPPresentationCategoryMorphismRep ) );



####################################################
##
##  Section The GAP Categories for special morphisms
##
####################################################

##
DeclareRepresentation( "IsGradedLeftOrRightModulePresentationMorphismForCAPRep",
                       IsGradedLeftOrRightModulePresentationMorphismForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftOrRightModulePresentationMorphismsForCAP",
            NewFamily( "TheFamilyOfGradedLeftOrRightModulePresentationMorphismsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftOrRightModulePresentationMorphismForCAP",
            NewType( TheFamilyOfGradedLeftOrRightModulePresentationMorphismsForCAP,
                     IsGradedLeftOrRightModulePresentationMorphismForCAPRep ) );

##
DeclareRepresentation( "IsGradedLeftModulePresentationMorphismForCAPRep",
                       IsGradedLeftModulePresentationMorphismForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftModulePresentationMorphismsForCAP",
            NewFamily( "TheFamilyOfGradedLeftModulePresentationMorphismsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftModulePresentationMorphismForCAP",
            NewType( TheFamilyOfGradedLeftModulePresentationMorphismsForCAP,
                     IsGradedLeftModulePresentationMorphismForCAPRep ) );

##
DeclareRepresentation( "IsGradedRightModulePresentationMorphismForCAPRep",
                       IsGradedRightModulePresentationMorphismForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightModulePresentationMorphismsForCAP",
            NewFamily( "TheFamilyOfGradedRightModulePresentationMorphismsForCAP" ) );

BindGlobal( "TheTypeOfGradedRightModulePresentationMorphismForCAP",
            NewType( TheFamilyOfGradedRightModulePresentationMorphismsForCAP,
                     IsGradedRightModulePresentationMorphismForCAPRep ) );

