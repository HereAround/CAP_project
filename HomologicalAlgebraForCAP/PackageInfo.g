SetPackageInfo( rec(

PackageName := "HomologicalAlgebraForCAP",
Subtitle := "Homological algebra algorithms for CAP",

Version := Maximum( [
  "2015.05.08", ## Sebas' version
## this line prevents merge conflicts
   "2015.04.15", ## Sepp's version
## this line prevents merge conflicts
    ] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),
License := "GPL-2.0-or-later",


Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Posur",
    WWWHome := "https://sebastianpos.github.io",
    Email := "sposur@momo.math.rwth-aachen.de",
    PostalAddress := Concatenation(
               "Sebastian Posur\n",
               "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
               "Templergraben 64\n",
               "52062 Aachen\n",
               "Germany" ),
    Place := "Aachen",
    Institution := "RWTH Aachen University",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    Email := "gutsche@momo.math.rwth-aachen.de",
    PostalAddress := Concatenation(
               "Department of Mathematics\n",
               "University of Kaiserslautern\n",
               "67653 Kaiserslautern\n",
               "Germany" ),
    Place := "Kaiserslautern",
    Institution := "TU Kaiserslautern",
  ),
],

PackageWWWHome := "http://TODO/",

ArchiveURL     := Concatenation( ~.PackageWWWHome, "HomologicalAlgebraForCAP-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "HomologicalAlgebraForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Homological algebra algorithms for CAP",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "GeneralizedMorphismsForCAP", ">=2015.05.08" ],
                           [ "ComplexesAndFilteredObjectsForCAP", ">=2015.05.08" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


