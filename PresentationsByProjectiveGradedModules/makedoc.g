#
# Graded module presentations for CAP
#

LoadPackage( "AutoDoc" );

AutoDoc( "PresentationsByProjectiveGradedModules" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc",
                         "gap/PresentationsByProjectiveGradedModules.gd",
                         "gap/GradedSubmodules.gd",
                         "gap/PresentationsByProjectiveGradedModulesFunctors.gd",
                         "gap/PresentationsByProjectiveGradedModulesNaturalTransformations.gd",
                         "gap/Tools.gd",
                         "examples/Example.g"
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"PresentationsByProjectiveGradedModules\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);


QUIT;
