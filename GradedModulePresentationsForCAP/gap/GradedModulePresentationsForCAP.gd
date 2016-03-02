#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
#! @Chapter The CAP category of graded module presentations for CAP
##
#############################################################################

######################################
##
#! @Section CAP categories
##
######################################

#! @Description
#! Given a graded ring <A>S</A>, one can consider the category of f.p. graded left $S$-modules, which is 
#! captured by this attribute.
#! @Returns a CapCategory
#! @Arguments S
DeclareAttribute( "SfpgrmodLeft",
                 IsHomalgGradedRing );

#! @Description
#! Given a graded ring <A>S</A>, one can consider the category of f.p. graded right $S$-modules, which is 
#! captured by this attribute.
#! @Returns a CapCategory
#! @Arguments S
DeclareAttribute( "SfpgrmodRight",
                 IsHomalgGradedRing ); 



##############################################
##
## @Section Hom-Embedding
##
##############################################

# A method specialised to graded module presentation is installed to compute Hom-embeddings in this context. They perform faster
# than the method installed by the presentation category.