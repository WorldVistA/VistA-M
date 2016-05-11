IBDEI0EH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6662,2)
 ;;=^5001955
 ;;^UTILITY(U,$J,358.3,6663,0)
 ;;=C22.0^^30^396^84
 ;;^UTILITY(U,$J,358.3,6663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6663,1,3,0)
 ;;=3^Hepatocellular Carcinoma
 ;;^UTILITY(U,$J,358.3,6663,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,6663,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,6664,0)
 ;;=C24.9^^30^396^108
 ;;^UTILITY(U,$J,358.3,6664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6664,1,3,0)
 ;;=3^Malig Neop Biliary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,6664,1,4,0)
 ;;=4^C24.9
 ;;^UTILITY(U,$J,358.3,6664,2)
 ;;=^5000942
 ;;^UTILITY(U,$J,358.3,6665,0)
 ;;=C50.922^^30^396^132
 ;;^UTILITY(U,$J,358.3,6665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6665,1,3,0)
 ;;=3^Malig Neop Left Male Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,6665,1,4,0)
 ;;=4^C50.922
 ;;^UTILITY(U,$J,358.3,6665,2)
 ;;=^5133340
 ;;^UTILITY(U,$J,358.3,6666,0)
 ;;=C34.91^^30^396^150
 ;;^UTILITY(U,$J,358.3,6666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6666,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,6666,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,6666,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,6667,0)
 ;;=C50.921^^30^396^154
 ;;^UTILITY(U,$J,358.3,6667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6667,1,3,0)
 ;;=3^Malig Neop Right Male Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,6667,1,4,0)
 ;;=4^C50.921
 ;;^UTILITY(U,$J,358.3,6667,2)
 ;;=^5001198
 ;;^UTILITY(U,$J,358.3,6668,0)
 ;;=C90.02^^30^396^163
 ;;^UTILITY(U,$J,358.3,6668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6668,1,3,0)
 ;;=3^Multiple Myeloma,In Relapse
 ;;^UTILITY(U,$J,358.3,6668,1,4,0)
 ;;=4^C90.02
 ;;^UTILITY(U,$J,358.3,6668,2)
 ;;=^5001753
 ;;^UTILITY(U,$J,358.3,6669,0)
 ;;=Z85.818^^30^397^92
 ;;^UTILITY(U,$J,358.3,6669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6669,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Lip,Oral Cavity & Pharynx
 ;;^UTILITY(U,$J,358.3,6669,1,4,0)
 ;;=4^Z85.818
 ;;^UTILITY(U,$J,358.3,6669,2)
 ;;=^5063439
 ;;^UTILITY(U,$J,358.3,6670,0)
 ;;=Z85.819^^30^397^93
 ;;^UTILITY(U,$J,358.3,6670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6670,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Lip,Oral Cavity & Pharynx,Unspec
 ;;^UTILITY(U,$J,358.3,6670,1,4,0)
 ;;=4^Z85.819
 ;;^UTILITY(U,$J,358.3,6670,2)
 ;;=^5063440
 ;;^UTILITY(U,$J,358.3,6671,0)
 ;;=Z85.01^^30^397^88
 ;;^UTILITY(U,$J,358.3,6671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6671,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Esophagus
 ;;^UTILITY(U,$J,358.3,6671,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,6671,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,6672,0)
 ;;=Z85.028^^30^397^99
 ;;^UTILITY(U,$J,358.3,6672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6672,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Stomach
 ;;^UTILITY(U,$J,358.3,6672,1,4,0)
 ;;=4^Z85.028
 ;;^UTILITY(U,$J,358.3,6672,2)
 ;;=^5063397
 ;;^UTILITY(U,$J,358.3,6673,0)
 ;;=Z85.038^^30^397^90
 ;;^UTILITY(U,$J,358.3,6673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6673,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Large Intestine
 ;;^UTILITY(U,$J,358.3,6673,1,4,0)
 ;;=4^Z85.038
 ;;^UTILITY(U,$J,358.3,6673,2)
 ;;=^5063399
 ;;^UTILITY(U,$J,358.3,6674,0)
 ;;=Z85.048^^30^397^97
 ;;^UTILITY(U,$J,358.3,6674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6674,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Rectum,Rectosig Junct & Anus
 ;;^UTILITY(U,$J,358.3,6674,1,4,0)
 ;;=4^Z85.048
 ;;^UTILITY(U,$J,358.3,6674,2)
 ;;=^5063401
 ;;^UTILITY(U,$J,358.3,6675,0)
 ;;=Z85.118^^30^397^86
 ;;^UTILITY(U,$J,358.3,6675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6675,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Bronchus & Lung
