SetPackageInfo( rec(

PackageName := "GradedModulePresentationsForCAP",
Subtitle := "Graded module presentations for CAP over a graded ring",
Version := Maximum( [
           "2016.03.15", # Martin's version
           ##
           ] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Martin",
    LastName := "Bies",
    WWWHome := "TODO",
    Email := "bies@thphys.uni-heidelberg.de",
    PostalAddress := Concatenation( 
                 "Institut für theoretische Physik - Heidelberg \n",
                 "Philosophenweg 19 \n",
                 "69120 Heidelberg \n",
                 "Germany" ), 
    Place := "Heidelberg",
    Institution := "ITP Heidelberg",
  ),  
],

PackageWWWHome := "",

ArchiveURL     := Concatenation( ~.PackageWWWHome, "GradedModulePresentationsForCAP-", ~.Version ),
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
  BookName  := "GradedModulePresentationsForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Graded module presentations for CAP over a graded ring"
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "CAP", ">=2016.02.19" ],
                           [ "CAPCategoryOfProjectiveGradedModules", ">=2016.03.15" ],
                           [ "CAPPresentationCategory", ">=2016.03.15" ],
                           [ "ComplexesAndFilteredObjectsForCAP", ">=2015.10.20" ],
  ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));