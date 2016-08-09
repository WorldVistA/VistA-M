IBDEI0S3 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28244,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right bronchus or lung
 ;;^UTILITY(U,$J,358.3,28244,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,28244,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,28245,0)
 ;;=C34.92^^105^1376^20
 ;;^UTILITY(U,$J,358.3,28245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28245,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of left bronchus or lung
 ;;^UTILITY(U,$J,358.3,28245,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,28245,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,28246,0)
 ;;=C38.4^^105^1376^14
 ;;^UTILITY(U,$J,358.3,28246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28246,1,3,0)
 ;;=3^Malignant neoplasm of pleura
 ;;^UTILITY(U,$J,358.3,28246,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,28246,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,28247,0)
 ;;=C45.0^^105^1376^22
 ;;^UTILITY(U,$J,358.3,28247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28247,1,3,0)
 ;;=3^Mesothelioma of pleura
 ;;^UTILITY(U,$J,358.3,28247,1,4,0)
 ;;=4^C45.0
 ;;^UTILITY(U,$J,358.3,28247,2)
 ;;=^5001095
 ;;^UTILITY(U,$J,358.3,28248,0)
 ;;=C73.^^105^1376^16
 ;;^UTILITY(U,$J,358.3,28248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28248,1,3,0)
 ;;=3^Malignant neoplasm of thyroid gland
 ;;^UTILITY(U,$J,358.3,28248,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,28248,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,28249,0)
 ;;=C76.0^^105^1376^4
 ;;^UTILITY(U,$J,358.3,28249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28249,1,3,0)
 ;;=3^Malignant neoplasm of head, face and neck
 ;;^UTILITY(U,$J,358.3,28249,1,4,0)
 ;;=4^C76.0
 ;;^UTILITY(U,$J,358.3,28249,2)
 ;;=^5001324
 ;;^UTILITY(U,$J,358.3,28250,0)
 ;;=C05.9^^105^1376^11
 ;;^UTILITY(U,$J,358.3,28250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28250,1,3,0)
 ;;=3^Malignant neoplasm of palate,unspec
 ;;^UTILITY(U,$J,358.3,28250,1,4,0)
 ;;=4^C05.9
 ;;^UTILITY(U,$J,358.3,28250,2)
 ;;=^5000898
 ;;^UTILITY(U,$J,358.3,28251,0)
 ;;=C07.^^105^1376^12
 ;;^UTILITY(U,$J,358.3,28251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28251,1,3,0)
 ;;=3^Malignant neoplasm of parotid gland
 ;;^UTILITY(U,$J,358.3,28251,1,4,0)
 ;;=4^C07.
 ;;^UTILITY(U,$J,358.3,28251,2)
 ;;=^267005
 ;;^UTILITY(U,$J,358.3,28252,0)
 ;;=C08.9^^105^1376^7
 ;;^UTILITY(U,$J,358.3,28252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28252,1,3,0)
 ;;=3^Malignant neoplasm of major salivary gland,unspec
 ;;^UTILITY(U,$J,358.3,28252,1,4,0)
 ;;=4^C08.9
 ;;^UTILITY(U,$J,358.3,28252,2)
 ;;=^5000902
 ;;^UTILITY(U,$J,358.3,28253,0)
 ;;=C09.9^^105^1376^18
 ;;^UTILITY(U,$J,358.3,28253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28253,1,3,0)
 ;;=3^Malignant neoplasm of tonsil,unspec
 ;;^UTILITY(U,$J,358.3,28253,1,4,0)
 ;;=4^C09.9
 ;;^UTILITY(U,$J,358.3,28253,2)
 ;;=^5000905
 ;;^UTILITY(U,$J,358.3,28254,0)
 ;;=C12.^^105^1376^15
 ;;^UTILITY(U,$J,358.3,28254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28254,1,3,0)
 ;;=3^Malignant neoplasm of pyriform sinus
 ;;^UTILITY(U,$J,358.3,28254,1,4,0)
 ;;=4^C12.
 ;;^UTILITY(U,$J,358.3,28254,2)
 ;;=^267046
 ;;^UTILITY(U,$J,358.3,28255,0)
 ;;=C13.9^^105^1376^5
 ;;^UTILITY(U,$J,358.3,28255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28255,1,3,0)
 ;;=3^Malignant neoplasm of hypopharynx,unspec
 ;;^UTILITY(U,$J,358.3,28255,1,4,0)
 ;;=4^C13.9
 ;;^UTILITY(U,$J,358.3,28255,2)
 ;;=^5000915
 ;;^UTILITY(U,$J,358.3,28256,0)
 ;;=C14.0^^105^1376^13
 ;;^UTILITY(U,$J,358.3,28256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28256,1,3,0)
 ;;=3^Malignant neoplasm of pharynx,unspec
 ;;^UTILITY(U,$J,358.3,28256,1,4,0)
 ;;=4^C14.0
 ;;^UTILITY(U,$J,358.3,28256,2)
 ;;=^5000916
 ;;^UTILITY(U,$J,358.3,28257,0)
 ;;=D57.40^^105^1377^15
 ;;^UTILITY(U,$J,358.3,28257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28257,1,3,0)
 ;;=3^Sickle-cell thalassemia without crisis
 ;;^UTILITY(U,$J,358.3,28257,1,4,0)
 ;;=4^D57.40
 ;;^UTILITY(U,$J,358.3,28257,2)
 ;;=^329908
 ;;^UTILITY(U,$J,358.3,28258,0)
 ;;=D57.419^^105^1377^14
 ;;^UTILITY(U,$J,358.3,28258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28258,1,3,0)
 ;;=3^Sickle-cell thalassemia with crisis, unspecified
 ;;^UTILITY(U,$J,358.3,28258,1,4,0)
 ;;=4^D57.419
 ;;^UTILITY(U,$J,358.3,28258,2)
 ;;=^5002316
 ;;^UTILITY(U,$J,358.3,28259,0)
 ;;=D56.0^^105^1377^1
 ;;^UTILITY(U,$J,358.3,28259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28259,1,3,0)
 ;;=3^Alpha thalassemia
 ;;^UTILITY(U,$J,358.3,28259,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,28259,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,28260,0)
 ;;=D56.1^^105^1377^2
 ;;^UTILITY(U,$J,358.3,28260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28260,1,3,0)
 ;;=3^Beta thalassemia
 ;;^UTILITY(U,$J,358.3,28260,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,28260,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,28261,0)
 ;;=D56.2^^105^1377^3
 ;;^UTILITY(U,$J,358.3,28261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28261,1,3,0)
 ;;=3^Delta-beta thalassemia
 ;;^UTILITY(U,$J,358.3,28261,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,28261,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,28262,0)
 ;;=D56.3^^105^1377^18
 ;;^UTILITY(U,$J,358.3,28262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28262,1,3,0)
 ;;=3^Thalassemia minor
 ;;^UTILITY(U,$J,358.3,28262,1,4,0)
 ;;=4^D56.3
 ;;^UTILITY(U,$J,358.3,28262,2)
 ;;=^340497
 ;;^UTILITY(U,$J,358.3,28263,0)
 ;;=D56.5^^105^1377^7
 ;;^UTILITY(U,$J,358.3,28263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28263,1,3,0)
 ;;=3^Hemoglobin E-beta thalassemia
 ;;^UTILITY(U,$J,358.3,28263,1,4,0)
 ;;=4^D56.5
 ;;^UTILITY(U,$J,358.3,28263,2)
 ;;=^340498
 ;;^UTILITY(U,$J,358.3,28264,0)
 ;;=D56.8^^105^1377^19
 ;;^UTILITY(U,$J,358.3,28264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28264,1,3,0)
 ;;=3^Thalassemias NEC
 ;;^UTILITY(U,$J,358.3,28264,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,28264,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,28265,0)
 ;;=D57.3^^105^1377^16
 ;;^UTILITY(U,$J,358.3,28265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28265,1,3,0)
 ;;=3^Sickle-cell trait
 ;;^UTILITY(U,$J,358.3,28265,1,4,0)
 ;;=4^D57.3
 ;;^UTILITY(U,$J,358.3,28265,2)
 ;;=^5002313
 ;;^UTILITY(U,$J,358.3,28266,0)
 ;;=D57.1^^105^1377^13
 ;;^UTILITY(U,$J,358.3,28266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28266,1,3,0)
 ;;=3^Sickle-cell disease without crisis
 ;;^UTILITY(U,$J,358.3,28266,1,4,0)
 ;;=4^D57.1
 ;;^UTILITY(U,$J,358.3,28266,2)
 ;;=^5002309
 ;;^UTILITY(U,$J,358.3,28267,0)
 ;;=D57.02^^105^1377^6
 ;;^UTILITY(U,$J,358.3,28267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28267,1,3,0)
 ;;=3^Hb-SS disease with splenic sequestration
 ;;^UTILITY(U,$J,358.3,28267,1,4,0)
 ;;=4^D57.02
 ;;^UTILITY(U,$J,358.3,28267,2)
 ;;=^5002308
 ;;^UTILITY(U,$J,358.3,28268,0)
 ;;=D57.01^^105^1377^4
 ;;^UTILITY(U,$J,358.3,28268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28268,1,3,0)
 ;;=3^Hb-SS disease with acute chest syndrome
 ;;^UTILITY(U,$J,358.3,28268,1,4,0)
 ;;=4^D57.01
 ;;^UTILITY(U,$J,358.3,28268,2)
 ;;=^5002307
 ;;^UTILITY(U,$J,358.3,28269,0)
 ;;=D57.00^^105^1377^5
 ;;^UTILITY(U,$J,358.3,28269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28269,1,3,0)
 ;;=3^Hb-SS disease with crisis, unspecified
 ;;^UTILITY(U,$J,358.3,28269,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,28269,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,28270,0)
 ;;=D57.20^^105^1377^17
 ;;^UTILITY(U,$J,358.3,28270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28270,1,3,0)
 ;;=3^Sickle-cell/Hb-C disease without crisis
 ;;^UTILITY(U,$J,358.3,28270,1,4,0)
 ;;=4^D57.20
 ;;^UTILITY(U,$J,358.3,28270,2)
 ;;=^330080
 ;;^UTILITY(U,$J,358.3,28271,0)
 ;;=D57.811^^105^1377^10
 ;;^UTILITY(U,$J,358.3,28271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28271,1,3,0)
 ;;=3^Sickle-Cell Disorders w/ Acute Chest Syndrome NEC
 ;;^UTILITY(U,$J,358.3,28271,1,4,0)
 ;;=4^D57.811
 ;;^UTILITY(U,$J,358.3,28271,2)
 ;;=^5002318
 ;;^UTILITY(U,$J,358.3,28272,0)
 ;;=D57.812^^105^1377^11
