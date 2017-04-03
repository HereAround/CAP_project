#
# TruncationsOfGradedModulePresentationsForCAP: Truncating a graded module presentation (for CAP) to an affine (cone) semigroup
#

LoadPackage( "AutoDoc" );

AutoDoc( "TruncationsOfGradedModulePresentationsForCAP" : scaffold := true, autodoc :=
         rec( files := [ "doc/Intros.autodoc",
                         "gap/SemigroupAndConeWrapper.gd",
                         "gap/CAPCategoryOfProjectiveGradedModulesFunctors.gd",
                         "gap/CAPCategoryOfProjectiveGradedModulesNaturalTransformations.gd",
                         "gap/GradedModulePresentationsForCAPFunctors.gd",
                         "examples/Example.g"
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"TruncationsOfGradedModulePresentationsForCAP\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;