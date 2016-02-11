IBDEI0NS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10873,0)
 ;;=C91.02^^68^675^3
 ;;^UTILITY(U,$J,358.3,10873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10873,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,10873,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,10873,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,10874,0)
 ;;=C92.02^^68^675^6
 ;;^UTILITY(U,$J,358.3,10874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10874,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,10874,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,10874,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,10875,0)
 ;;=D09.3^^68^675^43
 ;;^UTILITY(U,$J,358.3,10875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10875,1,3,0)
 ;;=3^Carcinoma in Situ of Thyroid/Oth Endocrine Glands
 ;;^UTILITY(U,$J,358.3,10875,1,4,0)
 ;;=4^D09.3
 ;;^UTILITY(U,$J,358.3,10875,2)
 ;;=^5001955
 ;;^UTILITY(U,$J,358.3,10876,0)
 ;;=C22.0^^68^675^84
 ;;^UTILITY(U,$J,358.3,10876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10876,1,3,0)
 ;;=3^Hepatocellular Carcinoma
 ;;^UTILITY(U,$J,358.3,10876,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,10876,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,10877,0)
 ;;=C24.9^^68^675^108
 ;;^UTILITY(U,$J,358.3,10877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10877,1,3,0)
 ;;=3^Malig Neop Biliary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,10877,1,4,0)
 ;;=4^C24.9
 ;;^UTILITY(U,$J,358.3,10877,2)
 ;;=^5000942
 ;;^UTILITY(U,$J,358.3,10878,0)
 ;;=C50.922^^68^675^132
 ;;^UTILITY(U,$J,358.3,10878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10878,1,3,0)
 ;;=3^Malig Neop Left Male Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,10878,1,4,0)
 ;;=4^C50.922
 ;;^UTILITY(U,$J,358.3,10878,2)
 ;;=^5133340
 ;;^UTILITY(U,$J,358.3,10879,0)
 ;;=C34.91^^68^675^150
 ;;^UTILITY(U,$J,358.3,10879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10879,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,10879,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,10879,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,10880,0)
 ;;=C50.921^^68^675^154
 ;;^UTILITY(U,$J,358.3,10880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10880,1,3,0)
 ;;=3^Malig Neop Right Male Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,10880,1,4,0)
 ;;=4^C50.921
 ;;^UTILITY(U,$J,358.3,10880,2)
 ;;=^5001198
 ;;^UTILITY(U,$J,358.3,10881,0)
 ;;=C90.02^^68^675^163
 ;;^UTILITY(U,$J,358.3,10881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10881,1,3,0)
 ;;=3^Multiple Myeloma,In Relapse
 ;;^UTILITY(U,$J,358.3,10881,1,4,0)
 ;;=4^C90.02
 ;;^UTILITY(U,$J,358.3,10881,2)
 ;;=^5001753
 ;;^UTILITY(U,$J,358.3,10882,0)
 ;;=Z85.818^^68^676^92
 ;;^UTILITY(U,$J,358.3,10882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10882,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Lip,Oral Cavity & Pharynx
 ;;^UTILITY(U,$J,358.3,10882,1,4,0)
 ;;=4^Z85.818
 ;;^UTILITY(U,$J,358.3,10882,2)
 ;;=^5063439
 ;;^UTILITY(U,$J,358.3,10883,0)
 ;;=Z85.819^^68^676^93
 ;;^UTILITY(U,$J,358.3,10883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10883,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Lip,Oral Cavity & Pharynx,Unspec
 ;;^UTILITY(U,$J,358.3,10883,1,4,0)
 ;;=4^Z85.819
 ;;^UTILITY(U,$J,358.3,10883,2)
 ;;=^5063440
 ;;^UTILITY(U,$J,358.3,10884,0)
 ;;=Z85.01^^68^676^88
 ;;^UTILITY(U,$J,358.3,10884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10884,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Esophagus
 ;;^UTILITY(U,$J,358.3,10884,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,10884,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,10885,0)
 ;;=Z85.028^^68^676^99
 ;;^UTILITY(U,$J,358.3,10885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10885,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Stomach
