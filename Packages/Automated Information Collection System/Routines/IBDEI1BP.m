IBDEI1BP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22493,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,22494,0)
 ;;=D05.90^^87^981^33
 ;;^UTILITY(U,$J,358.3,22494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22494,1,3,0)
 ;;=3^Carcinoma in Situ Breast Unspec,Unspec Type
 ;;^UTILITY(U,$J,358.3,22494,1,4,0)
 ;;=4^D05.90
 ;;^UTILITY(U,$J,358.3,22494,2)
 ;;=^5001935
 ;;^UTILITY(U,$J,358.3,22495,0)
 ;;=D51.0^^87^981^189
 ;;^UTILITY(U,$J,358.3,22495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22495,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Intrinsic Factor Deficiency
 ;;^UTILITY(U,$J,358.3,22495,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,22495,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,22496,0)
 ;;=D51.1^^87^981^190
 ;;^UTILITY(U,$J,358.3,22496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22496,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Selective Vit B12 Malabsorp w/ Proteinuria
 ;;^UTILITY(U,$J,358.3,22496,1,4,0)
 ;;=4^D51.1
 ;;^UTILITY(U,$J,358.3,22496,2)
 ;;=^5002285
 ;;^UTILITY(U,$J,358.3,22497,0)
 ;;=D51.9^^87^981^192
 ;;^UTILITY(U,$J,358.3,22497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22497,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,22497,1,4,0)
 ;;=4^D51.9
 ;;^UTILITY(U,$J,358.3,22497,2)
 ;;=^5002289
 ;;^UTILITY(U,$J,358.3,22498,0)
 ;;=D68.0^^87^981^194
 ;;^UTILITY(U,$J,358.3,22498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22498,1,3,0)
 ;;=3^Von Willebrand's Disease
 ;;^UTILITY(U,$J,358.3,22498,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,22498,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,22499,0)
 ;;=C88.0^^87^981^195
 ;;^UTILITY(U,$J,358.3,22499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22499,1,3,0)
 ;;=3^Waldenstrom Macroglobulinemia
 ;;^UTILITY(U,$J,358.3,22499,1,4,0)
 ;;=4^C88.0
 ;;^UTILITY(U,$J,358.3,22499,2)
 ;;=^5001748
 ;;^UTILITY(U,$J,358.3,22500,0)
 ;;=C91.02^^87^981^3
 ;;^UTILITY(U,$J,358.3,22500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22500,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,22500,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,22500,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,22501,0)
 ;;=C92.02^^87^981^6
 ;;^UTILITY(U,$J,358.3,22501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22501,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,22501,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,22501,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,22502,0)
 ;;=D09.3^^87^981^45
 ;;^UTILITY(U,$J,358.3,22502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22502,1,3,0)
 ;;=3^Carcinoma in Situ of Thyroid/Oth Endocrine Glands
 ;;^UTILITY(U,$J,358.3,22502,1,4,0)
 ;;=4^D09.3
 ;;^UTILITY(U,$J,358.3,22502,2)
 ;;=^5001955
 ;;^UTILITY(U,$J,358.3,22503,0)
 ;;=C22.0^^87^981^86
 ;;^UTILITY(U,$J,358.3,22503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22503,1,3,0)
 ;;=3^Hepatocellular Carcinoma
 ;;^UTILITY(U,$J,358.3,22503,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,22503,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,22504,0)
 ;;=C24.9^^87^981^110
 ;;^UTILITY(U,$J,358.3,22504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22504,1,3,0)
 ;;=3^Malig Neop Biliary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,22504,1,4,0)
 ;;=4^C24.9
 ;;^UTILITY(U,$J,358.3,22504,2)
 ;;=^5000942
 ;;^UTILITY(U,$J,358.3,22505,0)
 ;;=C50.922^^87^981^134
 ;;^UTILITY(U,$J,358.3,22505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22505,1,3,0)
 ;;=3^Malig Neop Left Male Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,22505,1,4,0)
 ;;=4^C50.922
 ;;^UTILITY(U,$J,358.3,22505,2)
 ;;=^5133340
 ;;^UTILITY(U,$J,358.3,22506,0)
 ;;=C34.91^^87^981^152
 ;;^UTILITY(U,$J,358.3,22506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22506,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Unspec Part
