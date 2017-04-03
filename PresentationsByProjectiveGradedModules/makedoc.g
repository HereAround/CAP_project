#
# Graded module presentations for CAP
#

LoadPackage( "AutoDoc" );

AutoDoc( "GradedModulePresentationsForCAP" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc",
                         "gap/GradedModulePresentationsForCAP.gd",
                         "gap/GradedSubmodules.gd",
                         "gap/GradedModulePresentationsForCAPFunctors.gd",
                         "gap/GradedModulePresentationsForCAPNaturalTransformations.gd",
                         "gap/Tools.gd",
                         "examples/Example.g"
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GradedModulePresentationsForCAP\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);


QUIT;
