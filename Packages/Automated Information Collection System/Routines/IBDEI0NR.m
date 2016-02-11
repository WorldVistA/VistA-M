IBDEI0NR ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10860,1,3,0)
 ;;=3^Solitary Plasmacytoma,Not in Remission
 ;;^UTILITY(U,$J,358.3,10860,1,4,0)
 ;;=4^C90.30
 ;;^UTILITY(U,$J,358.3,10860,2)
 ;;=^5001759
 ;;^UTILITY(U,$J,358.3,10861,0)
 ;;=D56.3^^68^675^180
 ;;^UTILITY(U,$J,358.3,10861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10861,1,3,0)
 ;;=3^Thalassemia Minor
 ;;^UTILITY(U,$J,358.3,10861,1,4,0)
 ;;=4^D56.3
 ;;^UTILITY(U,$J,358.3,10861,2)
 ;;=^340497
 ;;^UTILITY(U,$J,358.3,10862,0)
 ;;=D56.9^^68^675^181
 ;;^UTILITY(U,$J,358.3,10862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10862,1,3,0)
 ;;=3^Thalassemia,Unspec
 ;;^UTILITY(U,$J,358.3,10862,1,4,0)
 ;;=4^D56.9
 ;;^UTILITY(U,$J,358.3,10862,2)
 ;;=^340606
 ;;^UTILITY(U,$J,358.3,10863,0)
 ;;=M31.1^^68^675^183
 ;;^UTILITY(U,$J,358.3,10863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10863,1,3,0)
 ;;=3^Thrombotic Microangiopathy
 ;;^UTILITY(U,$J,358.3,10863,1,4,0)
 ;;=4^M31.1
 ;;^UTILITY(U,$J,358.3,10863,2)
 ;;=^119061
 ;;^UTILITY(U,$J,358.3,10864,0)
 ;;=D51.2^^68^675^184
 ;;^UTILITY(U,$J,358.3,10864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10864,1,3,0)
 ;;=3^Transcobalamin II Deficiency
 ;;^UTILITY(U,$J,358.3,10864,1,4,0)
 ;;=4^D51.2
 ;;^UTILITY(U,$J,358.3,10864,2)
 ;;=^5002286
 ;;^UTILITY(U,$J,358.3,10865,0)
 ;;=D05.92^^68^675^33
 ;;^UTILITY(U,$J,358.3,10865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10865,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,10865,1,4,0)
 ;;=4^D05.92
 ;;^UTILITY(U,$J,358.3,10865,2)
 ;;=^5001937
 ;;^UTILITY(U,$J,358.3,10866,0)
 ;;=D05.91^^68^675^35
 ;;^UTILITY(U,$J,358.3,10866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10866,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,10866,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,10866,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,10867,0)
 ;;=D05.90^^68^675^31
 ;;^UTILITY(U,$J,358.3,10867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10867,1,3,0)
 ;;=3^Carcinoma in Situ Breast Unspec,Unspec Type
 ;;^UTILITY(U,$J,358.3,10867,1,4,0)
 ;;=4^D05.90
 ;;^UTILITY(U,$J,358.3,10867,2)
 ;;=^5001935
 ;;^UTILITY(U,$J,358.3,10868,0)
 ;;=D51.0^^68^675^185
 ;;^UTILITY(U,$J,358.3,10868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10868,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Intrinsic Factor Deficiency
 ;;^UTILITY(U,$J,358.3,10868,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,10868,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,10869,0)
 ;;=D51.1^^68^675^186
 ;;^UTILITY(U,$J,358.3,10869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10869,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Selective Vit B12 Malabsorp w/ Proteinuria
 ;;^UTILITY(U,$J,358.3,10869,1,4,0)
 ;;=4^D51.1
 ;;^UTILITY(U,$J,358.3,10869,2)
 ;;=^5002285
 ;;^UTILITY(U,$J,358.3,10870,0)
 ;;=D51.9^^68^675^188
 ;;^UTILITY(U,$J,358.3,10870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10870,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,10870,1,4,0)
 ;;=4^D51.9
 ;;^UTILITY(U,$J,358.3,10870,2)
 ;;=^5002289
 ;;^UTILITY(U,$J,358.3,10871,0)
 ;;=D68.0^^68^675^190
 ;;^UTILITY(U,$J,358.3,10871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10871,1,3,0)
 ;;=3^Von Willebrand's Disease
 ;;^UTILITY(U,$J,358.3,10871,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,10871,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,10872,0)
 ;;=C88.0^^68^675^191
 ;;^UTILITY(U,$J,358.3,10872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10872,1,3,0)
 ;;=3^Waldenstrom Macroglobulinemia
 ;;^UTILITY(U,$J,358.3,10872,1,4,0)
 ;;=4^C88.0
 ;;^UTILITY(U,$J,358.3,10872,2)
 ;;=^5001748
