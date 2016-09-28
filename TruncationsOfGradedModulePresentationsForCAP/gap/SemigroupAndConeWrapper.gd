####################################################################################
##
## TruncationsOfGradedModulePresentationsForCAP package
##
##  Copyright 2016, Martin Bies,       ITP Heidelberg
##
#! @Chapter Wrapper for generators of semigroups and hyperplane constraints of cones
##
####################################################################################

############################################
##
#! @Section GAP Categories
##
############################################

#! @Description
#! The GAP category of lists of integer-valued lists, which encode the generators of subsemigroups of $Z^n$.
#! @Arguments object
DeclareCategory( "IsSemigroupGeneratorList",
                 IsObject );

#! @Description
#! The GAP category of lists of integer-valued lists, which encode H-presentations of cones in $Z^n$.
#! @Arguments object
DeclareCategory( "IsConeHPresentationList",
                 IsObject );

#! @Description
#! The GAP category of lists of integer-valued lists, which encode V-presentations of cones in $Z^n$.
#! @Arguments object
DeclareCategory( "IsConeVPresentationList",
                 IsObject );

#! @Description
#! The GAP category of affine semigroups $H$ in $\mathbb{Z}^n$. That means that there is a semigroup 
#! $G \subseteq \mathbb{Z}^n$ and $p \in \mathbb{Z}^n$ such that $H = p + G$.
#! @Arguments object
DeclareCategory( "IsAffineSemigroup",
                 IsObject );

#! @Description
#! The GAP category of affine semigroups $H$ associated to affine cones in $\mathbb{Z}^n$. This means that there is a cone
#! $C subseteq \mathbb{R}^n$ and $p \in \mathbb{Z}^n$ such that $H = p + \left( C \cap \mathbb{Z}^n \right)$.
#! @Arguments object
DeclareCategory( "IsAffineConeSemigroup",
                 IsAffineSemigroup );

# affine cone semigroup always implies affine semigroup
InstallTrueMethod( IsAffineSemigroup, IsAffineConeSemigroup );


############################################
##
#! @Section Constructors
##
############################################

#! @Description
#! The argument is a list $L$ and a non-negative integer $d$. We then check if this list could be the list of generators
#! of a subsemigroup of $Z^d$. If so, we create the corresponding SemigroupGeneratorList.
#! @Returns a SemigroupGeneratorList
#! @Arguments L
DeclareOperation( "SemigroupGeneratorList",
                  [ IsList, IsInt ] );
DeclareOperation( "SemigroupGeneratorList",
                  [ IsList ] );

#! @Description
#! The argument is a list $L$ and a non-negative integer $d$. We then check if this list could be the list of hyperplane
#! constraints of a cone in $Z^d$. If so, we create the corresponding ConeHPresentationList.
#! @Returns a ConeHPresentationList
#! @Arguments L
DeclareOperation( "ConeHPresentationList",
                  [ IsList, IsInt ] );
DeclareOperation( "ConeHPresentationList",
                  [ IsList ] );

#! @Description
#! The argument is an NmzCone $C$. We then try to compute an H-presentation of $C$. In case this was successfully 
#! done, we construct the corresponding ConeHPresentationList.
#! @Returns a ConeHPresentationList
#! @Arguments C
DeclareOperation( "ConeHPresentationList",
                  [ IsNormalizCone ] );

#! @Description
#! The argument is a list $L$ and a non-negative integer $d$. We then check if this list could be the list of (ray) 
#! generators of a cone in $Z^d$. If so, we create the corresponding ConeVPresentationList.
#! @Returns a ConeVPresentationList
#! @Arguments L
DeclareOperation( "ConeVPresentationList",
                  [ IsList, IsInt ] );
DeclareOperation( "ConeVPresentationList",
                  [ IsList ] );

#! @Description
#! The argument is an NmzCone $C$. We then try to compute a V-presentation of $C$. In case this was done successfully,
#! we construct the corresponding ConeVPresentationList.
#! @Returns a ConeVPresentationList
#! @Arguments C
DeclareOperation( "ConeVPresentationList",
                  [ IsNormalizCone ] );

#! @Description
#! The argument is an NmzCone $C$ and a point $p \in \mathbb{Z}^n$ encoded as list of integers. 
#! We then compute the semigroup of the affine cone $p + C$.
#! @Returns an AffineConeSemigroup
#! @Arguments C, p
DeclareOperation( "AffineConeSemigroup",
                  [ IsNormalizCone, IsList ] );

#! @Description
#! The argument is a ConeVPresentationList $L$ and a point $p \in \mathbb{Z}^n$ encoded as list of integers. 
#! We then compute the semigroup of the affine cone $p + C$, where $C$ is the cone encoded by $L$.
#! @Returns an AffineConeSemigroup
#! @Arguments C, p
DeclareOperation( "AffineConeSemigroup",
                  [ IsConeVPresentationList, IsList ] );

#! @Description
#! The argument is a ConeHPresentationList $L$ and a point $p \in \mathbb{Z}^n$ encoded as list of integers. 
#! We then compute the semigroup of the affine cone $p + C$, where $C$ is the cone encoded by $L$.
#! @Returns an AffineConeSemigroup
#! @Arguments L, p
DeclareOperation( "AffineConeSemigroup",
                  [ IsConeHPresentationList, IsList ] );

#! @Description
#! The argument is a ConeHPresentationList $L$ and a point $p \in \mathbb{Z}^n$ encoded as list of integers. 
#! We then compute the semigroup of the affine cone $p + C$, where $C$ is the cone encoded by $L$.
#! @Returns an AffineConeSemigroup
#! @Arguments L, p
DeclareOperation( "AffineSemigroup",
                  [ IsSemigroupGeneratorList, IsList ] );



############################################
##
#! @Section Attributes
##
############################################

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We then return the underlying list.
#! @Returns a list
#! @Arguments L
DeclareAttribute( "UnderlyingList",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We then return the embedding dimension of this semigroup.
#! @Returns a non-negative integer
#! @Arguments L
DeclareAttribute( "EmbeddingDimension",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is a SemigroupGeneratorList $L$. If the associated semigroup is a cone semigroup, then 
#! we return an HPresentation of this cone. Otherwise the method returns fail.
#! @Returns a ConeHPresentationList or fail
#! @Arguments L
DeclareAttribute( "UnderlyingConeHPresentationList",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is a SemigroupGeneratorList $L$. If the associated semigroup is a cone semigroup, then 
#! we return a VPresentation of this cone. Otherwise the method returns fail.
#! @Returns a ConeVPresentationList or fail
#! @Arguments L
DeclareAttribute( "UnderlyingConeVPresentationList",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is a ConeHPresentationList $L$. We then return the underlying list.
#! @Returns a list
#! @Arguments L
DeclareAttribute( "UnderlyingList",
                  IsConeHPresentationList );

#! @Description
#! The argument is a ConeHPresentationList $L$. We then return the embedding dimension of this cone.
#! @Returns a non-negative integer
#! @Arguments L
DeclareAttribute( "EmbeddingDimension",
                  IsConeHPresentationList );

#! @Description
#! The argument is a ConeVPresentationList $L$. We then return the underlying list.
#! @Returns a list
#! @Arguments L
DeclareAttribute( "UnderlyingList",
                  IsConeVPresentationList );

#! @Description
#! The argument is a ConeVPresentationList $L$. We then return the embedding dimension of this cone.
#! @Returns a non-negative integer
#! @Arguments L
DeclareAttribute( "EmbeddingDimension",
                  IsConeVPresentationList );

#! @Description
#! The argument is an AffineConeSemigroup $S$. This one is given as $S = p + \left( C \cap \mathbb{Z}^n \right)$ for a 
#! point $p \in \mathbb{Z}^n$ and a cone $C \subseteq \mathbb{Z}^n$. We then return the offset $p$.
#! @Returns a list of integers
#! @Arguments S
DeclareAttribute( "Offset",
                  IsAffineConeSemigroup );

#! @Description
#! The argument is an AffineConeSemigroup $S$. We then return the ConeHPresentationList of the underlying cone.
#! @Returns a ConeHPresentationList
#! @Arguments S
DeclareAttribute( "UnderlyingConeHPresentationList",
                  IsAffineConeSemigroup );

#! @Description
#! The argument is an AffineConeSemigroup $S$. We then return the ConeVPresentationList of the underlying cone.
#! @Returns a ConeVPresentationList
#! @Arguments S
DeclareAttribute( "UnderlyingConeVPresentationList",
                  IsAffineConeSemigroup );

#! @Description
#! The argument is an AffineConeSemigroup $S$. We then return the embedding dimension of this affine cone semigroup.
#! @Returns an NmzCone
#! @Arguments S
DeclareAttribute( "EmbeddingDimension",
                  IsAffineConeSemigroup );


#! @Description
#! The argument is an AffineSemigroup $S$. This one is given as $S = p + H$ for a 
#! point $p \in \mathbb{Z}^n$ and a semigroup $H \subseteq \mathbb{Z}^n$. We then return the offset $p$.
#! @Returns a list of integers
#! @Arguments S
DeclareAttribute( "Offset",
                  IsAffineSemigroup );

#! @Description
#! The argument is an AffineSemigroup $S$. This one is given as $S = p + H$ for a 
#! point $p \in \mathbb{Z}^n$ and a semigroup $H \subseteq \mathbb{Z}^n$. We then return the SemigroupGeneratorList of $H$.
#! @Returns a SemigroupGeneratorList
#! @Arguments S
DeclareAttribute( "UnderlyingSemigroupGeneratorList",
                  IsAffineConeSemigroup );

#! @Description
#! The argument is an AffineSemigroup $S$. We then return the embedding dimension of this affine semigroup.
#! @Returns an NmzCone
#! @Arguments S
DeclareAttribute( "EmbeddingDimension",
                  IsAffineSemigroup );



############################################
##
#! @Section Property
##
############################################

#! @Description
#! The argument is a SemigroupGeneratorList $L$. This property returns 'true' if this list is empty and 'false' otherwise.
#! @Returns true or false
#! @Arguments L
DeclareProperty( "IsEmpty",
                 IsSemigroupGeneratorList );

#! @Description
#! The argument is a ConeHPresentationList $L$. This property returns 'true' if this list is empty and 'false' otherwise.
#! @Returns true or false
#! @Arguments L
DeclareProperty( "IsEmpty",
                 IsConeHPresentationList );

#! @Description
#! The argument is a ConeVPresentationList $L$. This property returns 'true' if this list is empty and 'false' otherwise.
#! @Returns true or false
#! @Arguments L
DeclareProperty( "IsEmpty",
                 IsConeVPresentationList );

#! @Description
#! The argument is an affine semigroup. This property returns 'true' if this semigroup consists only of the offset point
#! and otherwise returns 'false'.
#! @Returns true or false
#! @Arguments L
DeclareProperty( "IsTrivial",
                 IsAffineSemigroup );

#! @Description
#! The argument is an affine cone semigroup. This property returns 'true' if this semigroup consists only of the offset point
#! and otherwise returns 'false'.
#! @Returns true or false
#! @Arguments L
DeclareProperty( "IsTrivial",
                 IsAffineConeSemigroup );

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We return if this is a ConeSemigroupGeneratorList. If Normaliz cannot decide
#! this, we return 'fail'.
#! @Returns true, false or fail
#! @Arguments L
DeclareProperty( "IsSemigroupOfConeGeneratorList",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is a AffineSemigroup $H$. We return if this is an AffineConeSemigroup. If Normaliz cannot decide this 'fail'
#! is returned.
#! @Returns true, false or fail
#! @Arguments H
DeclareProperty( "IsAffineSemigroupOfCone",
                  IsAffineSemigroup );



############################################
##
#! @Section Operations
##
############################################

#! @Description
#! The argument is a list $L$ of generators of a semigroup in $\mathbb{Z}^n$. We then check if this 
#! is the semigroup of a cone. In this case we return 'true', otherwise 'false'. If the operation fails due to 
#! shortcommings in Normaliz we return 'fail'.
#! @Returns true, false or fail
#! @Arguments L
DeclareOperation( "DecideIfIsConeSemigroupGeneratorList",
                  [ IsList ] );

#! @Description
#! The argument is a AffineSemigroup $H$. We then check if this is the semigroup of a cone, i.e. if $H$ is an
#! affine cone semigroup. In this case we return 'true', otherwise 'false'. if the operation fails due to 
#! shortcommings in Normaliz we return 'fail'.
#! @Returns true, false or fail
#! @Arguments H
DeclareOperation( "DecideIfIsAffineConeSemigroup",
                  [ IsAffineSemigroup ] );


###############################################################################
##
#! @Section Check if point is contained in (affine) cone or (affine ) semigroup
##
###############################################################################

#! @Description
#! The arguments are a cone $C$ and an integral point $p$. This operation then checks if the point $p$ is contained in $C$.
#! The cone $C$ can be specified either as ConeHPresentationList, as ConeVPresentationList or a NormalizCone.
#! @Returns true or false
#! @Arguments C, p
DeclareOperation( "PointContainedInCone",
                  [ IsConeHPresentationList, IsList ] );

DeclareOperation( "PointContainedInCone",
                  [ IsConeVPresentationList, IsList ] );

DeclareOperation( "PointContainedInCone",
                  [ IsNormalizCone, IsList ] );

#! @Description
#! The argument is a subsemigroup $S$ of $\mathbb{Z}^n$ given by a list of generators and an integral point $p$.
#! This operation then verifies if the point $p$ is contained in $S$ or not.
#! @Returns true or false
#! @Arguments S, p
DeclareOperation( "PointContainedInSemigroup",
                  [ IsSemigroupGeneratorList, IsList ] );

#! @Description
#! The first argument is an affine cone semigroup $H$, i.e. $H = p + \left( C \cap \mathbb{Z}^n \right)$ for a cone $C$ and a 
#! point $p$. The second argument is a point $Q$. This method then checks if $Q$ lies in $H$.
#! @Returns true or false
#! @Arguments H, Q
DeclareOperation( "PointContainedInAffineConeSemigroup",
                  [ IsAffineConeSemigroup, IsList ] );

#! @Description
#! The first argument is an affine semigroup $H$, i.e. $H = p + S $ for a semigroup $S \subseteq \mathbb{Z}^n$ and a 
#! point $p$. The second argument is a point $Q$. This method then checks if $Q$ lies in $H$.
#! @Returns true or false
#! @Arguments H, Q
DeclareOperation( "PointContainedInAffineSemigroup",
                  [ IsAffineSemigroup, IsList ] );