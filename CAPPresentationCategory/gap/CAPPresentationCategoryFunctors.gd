#############################################################################
##
## CAPPresentationCategory package
##
## Copyright 2016, Martin Bies,       ITP Heidelberg
##
#! @Chapter Presentation Category Functors
##
#############################################################################


#######################################
##
#! @Section Functors
##
#######################################

#! @Description
#! The argument is a Proj-category <A>category</A>. The output is the functor that embeds <A>category</A>
#! into its presentation category.
#! @Returns a functor
#! @Arguments category
DeclareAttribute( "EmbeddingOfProjCategory",
                  IsCapCategory );
