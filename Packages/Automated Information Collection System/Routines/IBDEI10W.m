IBDEI10W ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16634,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Intrinsic Factor Deficiency
 ;;^UTILITY(U,$J,358.3,16634,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,16634,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,16635,0)
 ;;=D51.1^^61^775^209
 ;;^UTILITY(U,$J,358.3,16635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16635,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia d/t Selective Vit B12 Malabsorp w/ Proteinuria
 ;;^UTILITY(U,$J,358.3,16635,1,4,0)
 ;;=4^D51.1
 ;;^UTILITY(U,$J,358.3,16635,2)
 ;;=^5002285
 ;;^UTILITY(U,$J,358.3,16636,0)
 ;;=D51.9^^61^775^211
 ;;^UTILITY(U,$J,358.3,16636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16636,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,16636,1,4,0)
 ;;=4^D51.9
 ;;^UTILITY(U,$J,358.3,16636,2)
 ;;=^5002289
 ;;^UTILITY(U,$J,358.3,16637,0)
 ;;=D68.0^^61^775^213
 ;;^UTILITY(U,$J,358.3,16637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16637,1,3,0)
 ;;=3^Von Willebrand's Disease
 ;;^UTILITY(U,$J,358.3,16637,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,16637,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,16638,0)
 ;;=C88.0^^61^775^214
 ;;^UTILITY(U,$J,358.3,16638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16638,1,3,0)
 ;;=3^Waldenstrom Macroglobulinemia
 ;;^UTILITY(U,$J,358.3,16638,1,4,0)
 ;;=4^C88.0
 ;;^UTILITY(U,$J,358.3,16638,2)
 ;;=^5001748
 ;;^UTILITY(U,$J,358.3,16639,0)
 ;;=C91.02^^61^775^3
 ;;^UTILITY(U,$J,358.3,16639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16639,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,16639,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,16639,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,16640,0)
 ;;=C92.02^^61^775^6
 ;;^UTILITY(U,$J,358.3,16640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16640,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,16640,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,16640,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,16641,0)
 ;;=D09.3^^61^775^50
 ;;^UTILITY(U,$J,358.3,16641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16641,1,3,0)
 ;;=3^Carcinoma in Situ of Thyroid/Oth Endocrine Glands
 ;;^UTILITY(U,$J,358.3,16641,1,4,0)
 ;;=4^D09.3
 ;;^UTILITY(U,$J,358.3,16641,2)
 ;;=^5001955
 ;;^UTILITY(U,$J,358.3,16642,0)
 ;;=C22.0^^61^775^91
 ;;^UTILITY(U,$J,358.3,16642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16642,1,3,0)
 ;;=3^Hepatocellular Carcinoma
 ;;^UTILITY(U,$J,358.3,16642,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,16642,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,16643,0)
 ;;=C24.9^^61^775^118
 ;;^UTILITY(U,$J,358.3,16643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16643,1,3,0)
 ;;=3^Malig Neop Biliary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,16643,1,4,0)
 ;;=4^C24.9
 ;;^UTILITY(U,$J,358.3,16643,2)
 ;;=^5000942
 ;;^UTILITY(U,$J,358.3,16644,0)
 ;;=C50.922^^61^775^142
 ;;^UTILITY(U,$J,358.3,16644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16644,1,3,0)
 ;;=3^Malig Neop Left Male Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,16644,1,4,0)
 ;;=4^C50.922
 ;;^UTILITY(U,$J,358.3,16644,2)
 ;;=^5133340
 ;;^UTILITY(U,$J,358.3,16645,0)
 ;;=C34.91^^61^775^160
 ;;^UTILITY(U,$J,358.3,16645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16645,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,16645,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,16645,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,16646,0)
 ;;=C50.921^^61^775^164
