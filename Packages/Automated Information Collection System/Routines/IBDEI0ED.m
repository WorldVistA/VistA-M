IBDEI0ED ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6611,0)
 ;;=D59.1^^30^396^27
 ;;^UTILITY(U,$J,358.3,6611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6611,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Other
 ;;^UTILITY(U,$J,358.3,6611,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,6611,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,6612,0)
 ;;=D51.3^^30^396^187
 ;;^UTILITY(U,$J,358.3,6612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6612,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Other
 ;;^UTILITY(U,$J,358.3,6612,1,4,0)
 ;;=4^D51.3
 ;;^UTILITY(U,$J,358.3,6612,2)
 ;;=^5002287
 ;;^UTILITY(U,$J,358.3,6613,0)
 ;;=D77.^^30^396^55
 ;;^UTILITY(U,$J,358.3,6613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6613,1,3,0)
 ;;=3^Disorder of Blood/Blood-Forming Organs in Diseases Classified Elsewhere,Other
 ;;^UTILITY(U,$J,358.3,6613,1,4,0)
 ;;=4^D77.
 ;;^UTILITY(U,$J,358.3,6613,2)
 ;;=^5002396
 ;;^UTILITY(U,$J,358.3,6614,0)
 ;;=D58.2^^30^396^81
 ;;^UTILITY(U,$J,358.3,6614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6614,1,3,0)
 ;;=3^Hemoglobinopathies,Other
 ;;^UTILITY(U,$J,358.3,6614,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,6614,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,6615,0)
 ;;=C88.8^^30^396^101
 ;;^UTILITY(U,$J,358.3,6615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6615,1,3,0)
 ;;=3^Malig Immunoproliferative Diseases,Other
 ;;^UTILITY(U,$J,358.3,6615,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,6615,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,6616,0)
 ;;=D70.8^^30^396^170
 ;;^UTILITY(U,$J,358.3,6616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6616,1,3,0)
 ;;=3^Neutropenia,Other
 ;;^UTILITY(U,$J,358.3,6616,1,4,0)
 ;;=4^D70.8
 ;;^UTILITY(U,$J,358.3,6616,2)
 ;;=^334042
 ;;^UTILITY(U,$J,358.3,6617,0)
 ;;=D59.4^^30^396^171
 ;;^UTILITY(U,$J,358.3,6617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6617,1,3,0)
 ;;=3^Nonautoimmune Hemolytic Anemias,Other
 ;;^UTILITY(U,$J,358.3,6617,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,6617,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,6618,0)
 ;;=D69.59^^30^396^177
 ;;^UTILITY(U,$J,358.3,6618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6618,1,3,0)
 ;;=3^Secondary Thrombocytopenia,Other
 ;;^UTILITY(U,$J,358.3,6618,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,6618,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,6619,0)
 ;;=C22.7^^30^396^44
 ;;^UTILITY(U,$J,358.3,6619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6619,1,3,0)
 ;;=3^Carcinomas of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,6619,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,6619,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,6620,0)
 ;;=D75.89^^30^396^54
 ;;^UTILITY(U,$J,358.3,6620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6620,1,3,0)
 ;;=3^Diseases of Blood/Blood-Forming Organs,Other Spec
 ;;^UTILITY(U,$J,358.3,6620,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,6620,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,6621,0)
 ;;=D47.Z9^^30^396^169
 ;;^UTILITY(U,$J,358.3,6621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6621,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
 ;;^UTILITY(U,$J,358.3,6621,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,6621,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,6622,0)
 ;;=D05.82^^30^396^32
 ;;^UTILITY(U,$J,358.3,6622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6622,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Other Spec Type
 ;;^UTILITY(U,$J,358.3,6622,1,4,0)
 ;;=4^D05.82
 ;;^UTILITY(U,$J,358.3,6622,2)
 ;;=^5001934
 ;;^UTILITY(U,$J,358.3,6623,0)
 ;;=D05.81^^30^396^34
 ;;^UTILITY(U,$J,358.3,6623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6623,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,6623,1,4,0)
 ;;=4^D05.81
