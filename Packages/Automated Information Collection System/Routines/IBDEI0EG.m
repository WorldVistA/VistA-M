IBDEI0EG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6650,0)
 ;;=M31.1^^30^396^183
 ;;^UTILITY(U,$J,358.3,6650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6650,1,3,0)
 ;;=3^Thrombotic Microangiopathy
 ;;^UTILITY(U,$J,358.3,6650,1,4,0)
 ;;=4^M31.1
 ;;^UTILITY(U,$J,358.3,6650,2)
 ;;=^119061
 ;;^UTILITY(U,$J,358.3,6651,0)
 ;;=D51.2^^30^396^184
 ;;^UTILITY(U,$J,358.3,6651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6651,1,3,0)
 ;;=3^Transcobalamin II Deficiency
 ;;^UTILITY(U,$J,358.3,6651,1,4,0)
 ;;=4^D51.2
 ;;^UTILITY(U,$J,358.3,6651,2)
 ;;=^5002286
 ;;^UTILITY(U,$J,358.3,6652,0)
 ;;=D05.92^^30^396^33
 ;;^UTILITY(U,$J,358.3,6652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6652,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,6652,1,4,0)
 ;;=4^D05.92
 ;;^UTILITY(U,$J,358.3,6652,2)
 ;;=^5001937
 ;;^UTILITY(U,$J,358.3,6653,0)
 ;;=D05.91^^30^396^35
 ;;^UTILITY(U,$J,358.3,6653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6653,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,6653,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,6653,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,6654,0)
 ;;=D05.90^^30^396^31
 ;;^UTILITY(U,$J,358.3,6654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6654,1,3,0)
 ;;=3^Carcinoma in Situ Breast Unspec,Unspec Type
 ;;^UTILITY(U,$J,358.3,6654,1,4,0)
 ;;=4^D05.90
 ;;^UTILITY(U,$J,358.3,6654,2)
 ;;=^5001935
 ;;^UTILITY(U,$J,358.3,6655,0)
 ;;=D51.0^^30^396^185
 ;;^UTILITY(U,$J,358.3,6655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6655,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Intrinsic Factor Deficiency
 ;;^UTILITY(U,$J,358.3,6655,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,6655,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,6656,0)
 ;;=D51.1^^30^396^186
 ;;^UTILITY(U,$J,358.3,6656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6656,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Selective Vit B12 Malabsorp w/ Proteinuria
 ;;^UTILITY(U,$J,358.3,6656,1,4,0)
 ;;=4^D51.1
 ;;^UTILITY(U,$J,358.3,6656,2)
 ;;=^5002285
 ;;^UTILITY(U,$J,358.3,6657,0)
 ;;=D51.9^^30^396^188
 ;;^UTILITY(U,$J,358.3,6657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6657,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,6657,1,4,0)
 ;;=4^D51.9
 ;;^UTILITY(U,$J,358.3,6657,2)
 ;;=^5002289
 ;;^UTILITY(U,$J,358.3,6658,0)
 ;;=D68.0^^30^396^190
 ;;^UTILITY(U,$J,358.3,6658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6658,1,3,0)
 ;;=3^Von Willebrand's Disease
 ;;^UTILITY(U,$J,358.3,6658,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,6658,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,6659,0)
 ;;=C88.0^^30^396^191
 ;;^UTILITY(U,$J,358.3,6659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6659,1,3,0)
 ;;=3^Waldenstrom Macroglobulinemia
 ;;^UTILITY(U,$J,358.3,6659,1,4,0)
 ;;=4^C88.0
 ;;^UTILITY(U,$J,358.3,6659,2)
 ;;=^5001748
 ;;^UTILITY(U,$J,358.3,6660,0)
 ;;=C91.02^^30^396^3
 ;;^UTILITY(U,$J,358.3,6660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6660,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,6660,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,6660,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,6661,0)
 ;;=C92.02^^30^396^6
 ;;^UTILITY(U,$J,358.3,6661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6661,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,6661,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,6661,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,6662,0)
 ;;=D09.3^^30^396^43
 ;;^UTILITY(U,$J,358.3,6662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6662,1,3,0)
 ;;=3^Carcinoma in Situ of Thyroid/Oth Endocrine Glands
 ;;^UTILITY(U,$J,358.3,6662,1,4,0)
 ;;=4^D09.3
