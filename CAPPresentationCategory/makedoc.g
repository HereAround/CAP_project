#
# CAPPresentationCategory: PresentationCategory over a proj-category
#

LoadPackage( "AutoDoc" );

AutoDoc( "CAPPresentationCategory" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc", 
                         "gap/CAPPresentationCategory.gd",
                         "gap/CAPPresentationCategoryObject.gd",
                         "gap/CAPPresentationCategoryMorphism.gd",
                         "gap/CAPPresentationCategoryFunctors.gd",
                         "gap/Tools.gd",
                         "examples/Example.g"
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"CAP\" );",
                              "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"CAPCategoryOfProjectiveGradedModules\" );",
                              "LoadPackage( \"CAPPresentationCategory\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);


QUIT;