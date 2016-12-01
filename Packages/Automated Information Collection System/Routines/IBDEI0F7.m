IBDEI0F7 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19216,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,19216,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,19216,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,19217,0)
 ;;=C82.19^^55^788^66
 ;;^UTILITY(U,$J,358.3,19217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19217,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,19217,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,19217,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,19218,0)
 ;;=C82.10^^55^788^67
 ;;^UTILITY(U,$J,358.3,19218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19218,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,19218,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,19218,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,19219,0)
 ;;=C82.29^^55^788^68
 ;;^UTILITY(U,$J,358.3,19219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19219,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,19219,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,19219,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,19220,0)
 ;;=C82.20^^55^788^69
 ;;^UTILITY(U,$J,358.3,19220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19220,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,19220,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,19220,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,19221,0)
 ;;=C82.39^^55^788^70
 ;;^UTILITY(U,$J,358.3,19221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19221,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,19221,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,19221,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,19222,0)
 ;;=C82.30^^55^788^71
 ;;^UTILITY(U,$J,358.3,19222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19222,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
 ;;^UTILITY(U,$J,358.3,19222,1,4,0)
 ;;=4^C82.30
 ;;^UTILITY(U,$J,358.3,19222,2)
 ;;=^5001491
 ;;^UTILITY(U,$J,358.3,19223,0)
 ;;=C82.49^^55^788^72
 ;;^UTILITY(U,$J,358.3,19223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19223,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,19223,1,4,0)
 ;;=4^C82.49
 ;;^UTILITY(U,$J,358.3,19223,2)
 ;;=^5001510
 ;;^UTILITY(U,$J,358.3,19224,0)
 ;;=C82.40^^55^788^73
 ;;^UTILITY(U,$J,358.3,19224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19224,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Unspec Site
 ;;^UTILITY(U,$J,358.3,19224,1,4,0)
 ;;=4^C82.40
 ;;^UTILITY(U,$J,358.3,19224,2)
 ;;=^5001501
 ;;^UTILITY(U,$J,358.3,19225,0)
 ;;=C82.99^^55^788^74
 ;;^UTILITY(U,$J,358.3,19225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19225,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,19225,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,19225,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,19226,0)
 ;;=C82.90^^55^788^75
 ;;^UTILITY(U,$J,358.3,19226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19226,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,19226,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,19226,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,19227,0)
 ;;=R59.1^^55^788^60
 ;;^UTILITY(U,$J,358.3,19227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19227,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Generalized
 ;;^UTILITY(U,$J,358.3,19227,1,4,0)
 ;;=4^R59.1
 ;;^UTILITY(U,$J,358.3,19227,2)
 ;;=^5019530
 ;;^UTILITY(U,$J,358.3,19228,0)
 ;;=C91.40^^55^788^79
 ;;^UTILITY(U,$J,358.3,19228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19228,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,19228,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,19228,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,19229,0)
 ;;=C91.42^^55^788^77
 ;;^UTILITY(U,$J,358.3,19229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19229,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,19229,1,4,0)
 ;;=4^C91.42
 ;;^UTILITY(U,$J,358.3,19229,2)
 ;;=^5001773
 ;;^UTILITY(U,$J,358.3,19230,0)
 ;;=C91.41^^55^788^78
 ;;^UTILITY(U,$J,358.3,19230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19230,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,19230,1,4,0)
 ;;=4^C91.41
 ;;^UTILITY(U,$J,358.3,19230,2)
 ;;=^5001772
 ;;^UTILITY(U,$J,358.3,19231,0)
 ;;=D57.01^^55^788^80
 ;;^UTILITY(U,$J,358.3,19231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19231,1,3,0)
 ;;=3^Hb-SS Disease w/ Acute Chest Syndrome
 ;;^UTILITY(U,$J,358.3,19231,1,4,0)
 ;;=4^D57.01
 ;;^UTILITY(U,$J,358.3,19231,2)
 ;;=^5002307
 ;;^UTILITY(U,$J,358.3,19232,0)
 ;;=D57.00^^55^788^81
 ;;^UTILITY(U,$J,358.3,19232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19232,1,3,0)
 ;;=3^Hb-SS Disease w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,19232,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,19232,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,19233,0)
 ;;=D57.02^^55^788^82
 ;;^UTILITY(U,$J,358.3,19233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19233,1,3,0)
 ;;=3^Hb-SS Disease w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,19233,1,4,0)
 ;;=4^D57.02
 ;;^UTILITY(U,$J,358.3,19233,2)
 ;;=^5002308
 ;;^UTILITY(U,$J,358.3,19234,0)
 ;;=D68.32^^55^788^84
 ;;^UTILITY(U,$J,358.3,19234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19234,1,3,0)
 ;;=3^Hemorrhagic Disorder d/t Extrinsic Circulating Anticoagulants
 ;;^UTILITY(U,$J,358.3,19234,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,19234,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,19235,0)
 ;;=C22.2^^55^788^85
 ;;^UTILITY(U,$J,358.3,19235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19235,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,19235,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,19235,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,19236,0)
 ;;=D58.9^^55^788^87
 ;;^UTILITY(U,$J,358.3,19236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19236,1,3,0)
 ;;=3^Hereditary Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,19236,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,19236,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,19237,0)
 ;;=C81.99^^55^788^88
 ;;^UTILITY(U,$J,358.3,19237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19237,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,19237,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,19237,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,19238,0)
 ;;=C81.90^^55^788^89
 ;;^UTILITY(U,$J,358.3,19238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19238,1,3,0)
 ;;=3^Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,19238,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,19238,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,19239,0)
 ;;=D89.2^^55^788^90
 ;;^UTILITY(U,$J,358.3,19239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19239,1,3,0)
 ;;=3^Hypergammaglobulenemia,Unspec
 ;;^UTILITY(U,$J,358.3,19239,1,4,0)
 ;;=4^D89.2
 ;;^UTILITY(U,$J,358.3,19239,2)
 ;;=^5002455
 ;;^UTILITY(U,$J,358.3,19240,0)
 ;;=D05.12^^55^788^91
 ;;^UTILITY(U,$J,358.3,19240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19240,1,3,0)
 ;;=3^Intraductal Carcinoma in Situ,Left Breast
 ;;^UTILITY(U,$J,358.3,19240,1,4,0)
 ;;=4^D05.12
 ;;^UTILITY(U,$J,358.3,19240,2)
 ;;=^5001931
 ;;^UTILITY(U,$J,358.3,19241,0)
 ;;=D05.11^^55^788^92
 ;;^UTILITY(U,$J,358.3,19241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19241,1,3,0)
 ;;=3^Intraductal Carcinoma in Situ,Right Breast
 ;;^UTILITY(U,$J,358.3,19241,1,4,0)
 ;;=4^D05.11
 ;;^UTILITY(U,$J,358.3,19241,2)
 ;;=^5001930
 ;;^UTILITY(U,$J,358.3,19242,0)
 ;;=D05.10^^55^788^93
 ;;^UTILITY(U,$J,358.3,19242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19242,1,3,0)
 ;;=3^Intraductal Carcinoma in Situ,Unspec Breast
 ;;^UTILITY(U,$J,358.3,19242,1,4,0)
 ;;=4^D05.10
 ;;^UTILITY(U,$J,358.3,19242,2)
 ;;=^5001929
 ;;^UTILITY(U,$J,358.3,19243,0)
 ;;=D50.0^^55^788^94
 ;;^UTILITY(U,$J,358.3,19243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19243,1,3,0)
 ;;=3^Iron Deficiency Anemia Secondary to Blood Loss
 ;;^UTILITY(U,$J,358.3,19243,1,4,0)
 ;;=4^D50.0
 ;;^UTILITY(U,$J,358.3,19243,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,19244,0)
 ;;=D50.9^^55^788^95
 ;;^UTILITY(U,$J,358.3,19244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19244,1,3,0)
 ;;=3^Iron Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,19244,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,19244,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,19245,0)
 ;;=C46.9^^55^788^96
 ;;^UTILITY(U,$J,358.3,19245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19245,1,3,0)
 ;;=3^Kaposi's Sarcoma,Unspec
 ;;^UTILITY(U,$J,358.3,19245,1,4,0)
 ;;=4^C46.9
 ;;^UTILITY(U,$J,358.3,19245,2)
 ;;=^5001108
 ;;^UTILITY(U,$J,358.3,19246,0)
 ;;=C22.0^^55^788^97
 ;;^UTILITY(U,$J,358.3,19246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19246,1,3,0)
 ;;=3^Liver Cell Carcinoma
 ;;^UTILITY(U,$J,358.3,19246,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,19246,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,19247,0)
 ;;=D05.02^^55^788^98
 ;;^UTILITY(U,$J,358.3,19247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19247,1,3,0)
 ;;=3^Lobular Carcinoma in Situ,Left Breast
 ;;^UTILITY(U,$J,358.3,19247,1,4,0)
 ;;=4^D05.02
 ;;^UTILITY(U,$J,358.3,19247,2)
 ;;=^5001928
 ;;^UTILITY(U,$J,358.3,19248,0)
 ;;=D05.01^^55^788^99
 ;;^UTILITY(U,$J,358.3,19248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19248,1,3,0)
 ;;=3^Lobular Carcinoma in Situ,Right Breast
 ;;^UTILITY(U,$J,358.3,19248,1,4,0)
 ;;=4^D05.01
 ;;^UTILITY(U,$J,358.3,19248,2)
 ;;=^5001927
 ;;^UTILITY(U,$J,358.3,19249,0)
 ;;=D05.00^^55^788^100
 ;;^UTILITY(U,$J,358.3,19249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19249,1,3,0)
 ;;=3^Lobular Carcinoma in Situ,Unspec Breast
 ;;^UTILITY(U,$J,358.3,19249,1,4,0)
 ;;=4^D05.00
 ;;^UTILITY(U,$J,358.3,19249,2)
 ;;=^5001926
 ;;^UTILITY(U,$J,358.3,19250,0)
 ;;=R59.0^^55^788^61
 ;;^UTILITY(U,$J,358.3,19250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19250,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Localized
 ;;^UTILITY(U,$J,358.3,19250,1,4,0)
 ;;=4^R59.0
 ;;^UTILITY(U,$J,358.3,19250,2)
 ;;=^5019529
 ;;^UTILITY(U,$J,358.3,19251,0)
 ;;=C83.59^^55^788^101
