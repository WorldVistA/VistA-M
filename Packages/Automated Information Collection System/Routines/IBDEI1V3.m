IBDEI1V3 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32768,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Other
 ;;^UTILITY(U,$J,358.3,32768,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,32768,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,32769,0)
 ;;=D51.3^^182^1992^180
 ;;^UTILITY(U,$J,358.3,32769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32769,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Other
 ;;^UTILITY(U,$J,358.3,32769,1,4,0)
 ;;=4^D51.3
 ;;^UTILITY(U,$J,358.3,32769,2)
 ;;=^5002287
 ;;^UTILITY(U,$J,358.3,32770,0)
 ;;=D77.^^182^1992^52
 ;;^UTILITY(U,$J,358.3,32770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32770,1,3,0)
 ;;=3^Disorder of Blood/Blood-Forming Organs in Diseases Classified Elsewhere,Other
 ;;^UTILITY(U,$J,358.3,32770,1,4,0)
 ;;=4^D77.
 ;;^UTILITY(U,$J,358.3,32770,2)
 ;;=^5002396
 ;;^UTILITY(U,$J,358.3,32771,0)
 ;;=D58.2^^182^1992^78
 ;;^UTILITY(U,$J,358.3,32771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32771,1,3,0)
 ;;=3^Hemoglobinopathies,Other
 ;;^UTILITY(U,$J,358.3,32771,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,32771,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,32772,0)
 ;;=C88.8^^182^1992^98
 ;;^UTILITY(U,$J,358.3,32772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32772,1,3,0)
 ;;=3^Malig Immunoproliferative Diseases,Other
 ;;^UTILITY(U,$J,358.3,32772,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,32772,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,32773,0)
 ;;=D70.8^^182^1992^163
 ;;^UTILITY(U,$J,358.3,32773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32773,1,3,0)
 ;;=3^Neutropenia,Other
 ;;^UTILITY(U,$J,358.3,32773,1,4,0)
 ;;=4^D70.8
 ;;^UTILITY(U,$J,358.3,32773,2)
 ;;=^334042
 ;;^UTILITY(U,$J,358.3,32774,0)
 ;;=D59.4^^182^1992^164
 ;;^UTILITY(U,$J,358.3,32774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32774,1,3,0)
 ;;=3^Nonautoimmune Hemolytic Anemias,Other
 ;;^UTILITY(U,$J,358.3,32774,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,32774,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,32775,0)
 ;;=D69.59^^182^1992^170
 ;;^UTILITY(U,$J,358.3,32775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32775,1,3,0)
 ;;=3^Secondary Thrombocytopenia,Other
 ;;^UTILITY(U,$J,358.3,32775,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,32775,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,32776,0)
 ;;=C22.7^^182^1992^41
 ;;^UTILITY(U,$J,358.3,32776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32776,1,3,0)
 ;;=3^Carcinomas of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,32776,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,32776,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,32777,0)
 ;;=D75.89^^182^1992^51
 ;;^UTILITY(U,$J,358.3,32777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32777,1,3,0)
 ;;=3^Diseases of Blood/Blood-Forming Organs,Other Spec
 ;;^UTILITY(U,$J,358.3,32777,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,32777,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,32778,0)
 ;;=D47.Z9^^182^1992^162
 ;;^UTILITY(U,$J,358.3,32778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32778,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
 ;;^UTILITY(U,$J,358.3,32778,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,32778,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,32779,0)
 ;;=D05.82^^182^1992^30
 ;;^UTILITY(U,$J,358.3,32779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32779,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Other Spec Type
 ;;^UTILITY(U,$J,358.3,32779,1,4,0)
 ;;=4^D05.82
 ;;^UTILITY(U,$J,358.3,32779,2)
 ;;=^5001934
 ;;^UTILITY(U,$J,358.3,32780,0)
 ;;=D05.81^^182^1992^32
 ;;^UTILITY(U,$J,358.3,32780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32780,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,32780,1,4,0)
 ;;=4^D05.81
 ;;^UTILITY(U,$J,358.3,32780,2)
 ;;=^5001933
