IBDEI2NJ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44504,1,3,0)
 ;;=3^Carcinoma in Situ Breast Unspec,Unspec Type
 ;;^UTILITY(U,$J,358.3,44504,1,4,0)
 ;;=4^D05.90
 ;;^UTILITY(U,$J,358.3,44504,2)
 ;;=^5001935
 ;;^UTILITY(U,$J,358.3,44505,0)
 ;;=D51.0^^200^2228^185
 ;;^UTILITY(U,$J,358.3,44505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44505,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Intrinsic Factor Deficiency
 ;;^UTILITY(U,$J,358.3,44505,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,44505,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,44506,0)
 ;;=D51.1^^200^2228^186
 ;;^UTILITY(U,$J,358.3,44506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44506,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Selective Vit B12 Malabsorp w/ Proteinuria
 ;;^UTILITY(U,$J,358.3,44506,1,4,0)
 ;;=4^D51.1
 ;;^UTILITY(U,$J,358.3,44506,2)
 ;;=^5002285
 ;;^UTILITY(U,$J,358.3,44507,0)
 ;;=D51.9^^200^2228^188
 ;;^UTILITY(U,$J,358.3,44507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44507,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,44507,1,4,0)
 ;;=4^D51.9
 ;;^UTILITY(U,$J,358.3,44507,2)
 ;;=^5002289
 ;;^UTILITY(U,$J,358.3,44508,0)
 ;;=D68.0^^200^2228^190
 ;;^UTILITY(U,$J,358.3,44508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44508,1,3,0)
 ;;=3^Von Willebrand's Disease
 ;;^UTILITY(U,$J,358.3,44508,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,44508,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,44509,0)
 ;;=C88.0^^200^2228^191
 ;;^UTILITY(U,$J,358.3,44509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44509,1,3,0)
 ;;=3^Waldenstrom Macroglobulinemia
 ;;^UTILITY(U,$J,358.3,44509,1,4,0)
 ;;=4^C88.0
 ;;^UTILITY(U,$J,358.3,44509,2)
 ;;=^5001748
 ;;^UTILITY(U,$J,358.3,44510,0)
 ;;=C91.02^^200^2228^3
 ;;^UTILITY(U,$J,358.3,44510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44510,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,44510,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,44510,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,44511,0)
 ;;=C92.02^^200^2228^6
 ;;^UTILITY(U,$J,358.3,44511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44511,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,44511,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,44511,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,44512,0)
 ;;=D09.3^^200^2228^43
 ;;^UTILITY(U,$J,358.3,44512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44512,1,3,0)
 ;;=3^Carcinoma in Situ of Thyroid/Oth Endocrine Glands
 ;;^UTILITY(U,$J,358.3,44512,1,4,0)
 ;;=4^D09.3
 ;;^UTILITY(U,$J,358.3,44512,2)
 ;;=^5001955
 ;;^UTILITY(U,$J,358.3,44513,0)
 ;;=C22.0^^200^2228^84
 ;;^UTILITY(U,$J,358.3,44513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44513,1,3,0)
 ;;=3^Hepatocellular Carcinoma
 ;;^UTILITY(U,$J,358.3,44513,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,44513,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,44514,0)
 ;;=C24.9^^200^2228^108
 ;;^UTILITY(U,$J,358.3,44514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44514,1,3,0)
 ;;=3^Malig Neop Biliary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,44514,1,4,0)
 ;;=4^C24.9
 ;;^UTILITY(U,$J,358.3,44514,2)
 ;;=^5000942
 ;;^UTILITY(U,$J,358.3,44515,0)
 ;;=C50.922^^200^2228^132
 ;;^UTILITY(U,$J,358.3,44515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44515,1,3,0)
 ;;=3^Malig Neop Left Male Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,44515,1,4,0)
 ;;=4^C50.922
 ;;^UTILITY(U,$J,358.3,44515,2)
 ;;=^5133340
 ;;^UTILITY(U,$J,358.3,44516,0)
 ;;=C34.91^^200^2228^150
 ;;^UTILITY(U,$J,358.3,44516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44516,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,44516,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,44516,2)
 ;;=^5000967
