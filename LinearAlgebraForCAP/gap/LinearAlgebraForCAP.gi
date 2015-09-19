#############################################################################
##
##                                LinearAlgebraForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## Constructors
##
####################################

InstallMethod( MatrixCategory,
               [ IsFieldForHomalg ],
               
  function( homalg_field )
    local category;
    
    category := CreateCapCategory( Concatenation( "Category of matrices over ", RingName( homalg_field ) ) );
    
    category!.field_for_matrix_category := homalg_field;
    
    SetIsAbelianCategory( category, true );
    
    SetIsRigidSymmetricClosedMonoidalCategory( category, true );
    
    SetIsStrictMonoidalCategory( category, true );
    
    INSTALL_FUNCTIONS_FOR_MATRIX_CATEGORY( category );
    
    ## TODO: Logic for MatrixCategory
    AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "LinearAlgebraForCAP", "LogicForMatrixCategory" ),
        "PredicateImplicationsForMatrixCategory.tex" )
    );
     
    Finalize( category );
    
    return category;
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_MATRIX_CATEGORY,
  
  function( category )
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
      
        return Dimension( object_1 ) = Dimension( object_2 );
      
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return UnderlyingHomalgMatrix( morphism_1 ) = UnderlyingHomalgMatrix( morphism_2 );
        
    end );
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      
      function( object )
        local homalg_field;
        
        homalg_field := UnderlyingFieldForHomalg( object );
        
        return VectorSpaceMorphism( object, HomalgIdentityMatrix( Dimension( object ), homalg_field ), object );
        
    end );
    
    ##
    AddPreCompose( category,

      function( morphism_1, morphism_2 )
        local composition;

        composition := UnderlyingHomalgMatrix( morphism_1 ) * UnderlyingHomalgMatrix( morphism_2 );

        return VectorSpaceMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );

    end );
    
    ## Basic Operations for an Additive Category
    ##
    AddIsZeroForMorphisms( category,
      function( morphism )
        
        return IsZero( UnderlyingHomalgMatrix( morphism ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return VectorSpaceMorphism( Source( morphism_1 ),
                                    UnderlyingHomalgMatrix( morphism_1 ) + UnderlyingHomalgMatrix( morphism_2 ),
                                    Range( morphism_2 ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return VectorSpaceMorphism( Source( morphism ),
                                    (-1) * UnderlyingHomalgMatrix( morphism ),
                                    Range( morphism ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local homalg_field;
        
        homalg_field := UnderlyingFieldForHomalg( source );
        
        return VectorSpaceMorphism( source,
                                    HomalgZeroMatrix( Dimension( source ), Dimension( range ), homalg_field ),
                                    range );
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return VectorSpaceObject( 0, category!.field_for_matrix_category );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local homalg_field, morphism;
        
        homalg_field := UnderlyingFieldForHomalg( zero_object );
        
        morphism := VectorSpaceMorphism( sink, HomalgZeroMatrix( Dimension( sink ), 0, homalg_field ), zero_object );
        
        return morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local homalg_field, morphism;
        
        homalg_field := UnderlyingFieldForHomalg( zero_object );
        
        morphism := VectorSpaceMorphism( zero_object, HomalgZeroMatrix( 0, Dimension( source ), homalg_field ), source );
        
        return morphism;
        
    end );
    
    ##
    AddDirectSum( category,
      function( object_list )
      local dimension, homalg_field;
      
      homalg_field := UnderlyingFieldForHomalg( object_list[1] );
      
      dimension := Sum( List( object_list, object -> Dimension( object ) ) );
      
      return VectorSpaceObject( dimension, homalg_field );
      
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, projection_number, direct_sum_object )
        local homalg_field, dim_pre, dim_post, dim_factor, number_of_objects, projection_in_factor;
        
        homalg_field := UnderlyingFieldForHomalg( direct_sum_object );
        
        number_of_objects := Length( object_list );
        
        dim_pre := Sum( object_list{ [ 1 .. projection_number - 1 ] }, c -> Dimension( c ) );
        
        dim_post := Sum( object_list{ [ projection_number + 1 .. number_of_objects ] }, c -> Dimension( c ) );
        
        dim_factor := Dimension( object_list[ projection_number ] );
        
        projection_in_factor := HomalgZeroMatrix( dim_pre, dim_factor, homalg_field );
        
        projection_in_factor := UnionOfRows( projection_in_factor, 
                                             HomalgIdentityMatrix( dim_factor, homalg_field ) );
        
        projection_in_factor := UnionOfRows( projection_in_factor, 
                                             HomalgZeroMatrix( dim_post, dim_factor, homalg_field ) );
        
        return VectorSpaceMorphism( direct_sum_object, projection_in_factor, object_list[ projection_number ] );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local underlying_matrix_of_universal_morphism, morphism;
        
        underlying_matrix_of_universal_morphism := UnderlyingHomalgMatrix( sink[1] );
        
        for morphism in sink{ [ 2 .. Length( sink ) ] } do
          
          underlying_matrix_of_universal_morphism := 
            UnionOfColumns( underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) );
          
        od;
        
        return VectorSpaceMorphism( Source( sink[1] ), underlying_matrix_of_universal_morphism, direct_sum );
      
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, injection_number, coproduct )
        local homalg_field, dim_pre, dim_post, dim_cofactor, number_of_objects, injection_of_cofactor;
        
        homalg_field := UnderlyingFieldForHomalg( coproduct );
        
        number_of_objects := Length( object_list );
        
        dim_pre := Sum( object_list{ [ 1 .. injection_number - 1 ] }, c -> Dimension( c ) );
        
        dim_post := Sum( object_list{ [ injection_number + 1 .. number_of_objects ] }, c -> Dimension( c ) );
        
        dim_cofactor := Dimension( object_list[ injection_number ] );
        
        injection_of_cofactor := HomalgZeroMatrix( dim_cofactor, dim_pre ,homalg_field );
        
        injection_of_cofactor := UnionOfColumns( injection_of_cofactor, 
                                             HomalgIdentityMatrix( dim_cofactor, homalg_field ) );
        
        injection_of_cofactor := UnionOfColumns( injection_of_cofactor, 
                                             HomalgZeroMatrix( dim_cofactor, dim_post, homalg_field ) );
        
        return VectorSpaceMorphism( object_list[ injection_number ], injection_of_cofactor, coproduct );

    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, coproduct )
        local underlying_matrix_of_universal_morphism, morphism;
        
        underlying_matrix_of_universal_morphism := UnderlyingHomalgMatrix( sink[1] );
        
        for morphism in sink{ [ 2 .. Length( sink ) ] } do
          
          underlying_matrix_of_universal_morphism := 
            UnionOfRows( underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) );
          
        od;
        
        return VectorSpaceMorphism( coproduct, underlying_matrix_of_universal_morphism, Range( sink[1] ) );
        
    end );
    
    ## Basic Operations for an Abelian category
    ##
    AddKernelObject( category,
      function( morphism )
        local homalg_field, homalg_matrix;
        
        homalg_field := UnderlyingFieldForHomalg( morphism );
        
        homalg_matrix := UnderlyingHomalgMatrix( morphism );
        
        return VectorSpaceObject( NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ), homalg_field );
        
    end );
    
    ##
    AddKernelEmb( category,
      function( morphism )
        local kernel_emb, homalg_field, kernel_object;
        
        kernel_emb := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );
        
        homalg_field := UnderlyingFieldForHomalg( morphism );
        
        kernel_object := VectorSpaceObject( NrRows( kernel_emb ), homalg_field );
        
        return VectorSpaceMorphism( kernel_object, kernel_emb, Source( morphism ) );
        
    end );
    
    ##
    AddKernelEmbWithGivenKernelObject( category,
      function( morphism, kernel )
        local kernel_emb;
        
        kernel_emb := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );
        
        return VectorSpaceMorphism( kernel, kernel_emb, Source( morphism ) );
        
    end );
    
    ##
    AddLiftAlongMonomorphism( category,
      function( monomorphism, test_morphism )
        local right_divide;
        
        right_divide := RightDivide( UnderlyingHomalgMatrix( test_morphism ), UnderlyingHomalgMatrix( monomorphism ) );
        
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        return VectorSpaceMorphism( Source( test_morphism ),
                                    right_divide,
                                    Source( monomorphism ) );
        
    end );
    
    ##
    AddCokernel( category,
      function( morphism )
        local homalg_field, homalg_matrix;
        
        homalg_field := UnderlyingFieldForHomalg( morphism );
        
        homalg_matrix := UnderlyingHomalgMatrix( morphism );
        
        return VectorSpaceObject( NrColumns( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ), homalg_field );
        
    end );
    
    ##
    AddCokernelProj( category,
      function( morphism )
        local cokernel_proj, homalg_field, cokernel_obj;
        
        cokernel_proj := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );
        
        homalg_field := UnderlyingFieldForHomalg( morphism );
        
        cokernel_obj := VectorSpaceObject( NrColumns( cokernel_proj ), homalg_field );
        
        return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel_obj );
        
    end );
    
    ##
    AddCokernelProjWithGivenCokernel( category,
      function( morphism, cokernel )
        local cokernel_proj;
        
        cokernel_proj := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );
        
        return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel );
        
    end );
    
    ##
    AddEpiAsCokernelColift( category,
      function( epimorphism, test_morphism )
        local left_divide;
        
        left_divide := LeftDivide( UnderlyingHomalgMatrix( epimorphism ), UnderlyingHomalgMatrix( test_morphism ) );
        
        if left_divide = fail then
          
          return fail;
          
        fi;
        
        return VectorSpaceMorphism( Range( epimorphism ),
                                    left_divide,
                                    Range( test_morphism ) );
        
    end );
    
    ## Basic Operation Properties
    ##
    AddIsZeroForObjects( category,
      function( object )
      
        return Dimension( object ) = 0;
      
      end );
    
    ##
    AddIsMonomorphism( category,
      function( morphism )
      
        return RowRankOfMatrix( UnderlyingHomalgMatrix( morphism ) ) = Dimension( Source( morphism ) );
      
    end );
    
    ##
    AddIsEpimorphism( category,
      function( morphism )
        
        return ColumnRankOfMatrix( UnderlyingHomalgMatrix( morphism ) ) = Dimension( Range( morphism ) );
        
    end );
    
    ##
    AddIsIsomorphism( category,
      function( morphism )
        
        return Dimension( Range( morphism ) ) = Dimension( Source( morphism ) )
               and ColumnRankOfMatrix( UnderlyingHomalgMatrix( morphism ) ) = Dimension( Range( morphism ) );
        
    end );
    
    ## Basic Operations for Monoidal Categories
    ##
    AddTensorProductOnObjects( category,
      [ 
        [ function( object_1, object_2 )
            local homalg_field;
            
            homalg_field := UnderlyingFieldForHomalg( object_1 );
            
            return VectorSpaceObject( Dimension( object_1 ) * Dimension( object_2 ), homalg_field );
            
          end,
          
          [ ] ],
        
        [ function( object_1, object_2 )
            
            return object_1;
            
          end,
          
          [ IsZero, ] ],
         
        [ function( object_1, object_2 )
            
            return object_2;
            
          end,
          
          [ , IsZero ] ]
      ]
    
    );
    
    ##
    AddTensorProductOnMorphisms( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        
        return VectorSpaceMorphism( new_source,
                                    KroneckerMat( UnderlyingHomalgMatrix( morphism_1 ), UnderlyingHomalgMatrix( morphism_2 ) ),
                                    new_range );
        
    end );
    
    ##
    AddTensorUnit( category,
      
      function( )
        local homalg_field;
        
        homalg_field := category!.field_for_matrix_category;
        
        return VectorSpaceObject( 1, homalg_field );
        
    end );
    
    ##
    AddBraiding( category,
      function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local homalg_field, permutation_matrix, dim, dim_1, dim_2;
        
        homalg_field := UnderlyingFieldForHomalg( object_1 );
        
        dim_1 := Dimension( object_1 );
        
        dim_2 := Dimension( object_2 );
        
        dim := Dimension( object_1_tensored_object_2 );
        
        permutation_matrix := PermutationMat( 
                                PermList( List( [ 1 .. dim ], i -> ( RemInt( i - 1, dim_2 ) * dim_1 + QuoInt( i - 1, dim_2 ) + 1 ) ) ),
                                dim 
                              );
        
        return VectorSpaceMorphism( object_1_tensored_object_2,
                                    HomalgMatrix( permutation_matrix, dim, dim, homalg_field ),
                                    object_2_tensored_object_1
                                  );
        
    end );
    
    ##
    AddDualOnObjects( category, space -> space );
    
    ##
    AddDualOnMorphisms( category,
      function( dual_source, morphism, dual_range )
        
        return VectorSpaceMorphism( dual_source,
                                    Involution( UnderlyingHomalgMatrix( morphism ) ),
                                    dual_range );
        
    end );
    
    ##
    AddEvaluationForDual( category,
      function( tensor_object, object, unit )
        local homalg_field, dimension, column, zero_column, i;
        
        homalg_field := UnderlyingFieldForHomalg( object );
        
        dimension := Dimension( object );
        
        column := [ ];
        
        zero_column := List( [ 1 .. dimension ], i -> 0 );
        
        for i in [ 1 .. dimension - 1 ] do
          
          Add( column, 1 );
          
          Append( column, zero_column );
          
        od;
        
        if dimension > 0 then 
          
          Add( column, 1 );
          
        fi;
        
        return VectorSpaceMorphism( tensor_object,
                                    HomalgMatrix( column, Dimension( tensor_object ), 1, homalg_field ),
                                    unit );
        
    end );
    
    ##
    AddCoevaluationForDual( category,
      
      function( unit, object, tensor_object )
        local homalg_field, dimension, row, zero_row, i;
        
        homalg_field := UnderlyingFieldForHomalg( object );
        
        dimension := Dimension( object );
        
        row := [ ];
        
        zero_row := List( [ 1 .. dimension ], i -> 0 );
        
        for i in [ 1 .. dimension - 1 ] do
          
          Add( row, 1 );
          
          Append( row, zero_row );
          
        od;
        
        if dimension > 0 then 
          
          Add( row, 1 );
          
        fi;
        
        return VectorSpaceMorphism( unit,
                                    HomalgMatrix( row, 1, Dimension( tensor_object ), homalg_field ),
                                    tensor_object );
        
    end );
    
    ##
    AddMorphismToBidual( category,
      function( object, bidual_of_object )
        local homalg_field;
        
        homalg_field := UnderlyingFieldForHomalg( object );
        
        return VectorSpaceMorphism( object,
                                    HomalgIdentityMatrix( Dimension( object ), homalg_field ),
                                    bidual_of_object
                                  );
        
    end );
    
end );




