IBDEI0NO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10821,1,4,0)
 ;;=4^D47.9
 ;;^UTILITY(U,$J,358.3,10821,2)
 ;;=^5002260
 ;;^UTILITY(U,$J,358.3,10822,0)
 ;;=D53.9^^68^675^172
 ;;^UTILITY(U,$J,358.3,10822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10822,1,3,0)
 ;;=3^Nutritional Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,10822,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,10822,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,10823,0)
 ;;=D47.4^^68^675^173
 ;;^UTILITY(U,$J,358.3,10823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10823,1,3,0)
 ;;=3^Osteomyelofibrosis
 ;;^UTILITY(U,$J,358.3,10823,1,4,0)
 ;;=4^D47.4
 ;;^UTILITY(U,$J,358.3,10823,2)
 ;;=^5002259
 ;;^UTILITY(U,$J,358.3,10824,0)
 ;;=D59.1^^68^675^27
 ;;^UTILITY(U,$J,358.3,10824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10824,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Other
 ;;^UTILITY(U,$J,358.3,10824,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,10824,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,10825,0)
 ;;=D51.3^^68^675^187
 ;;^UTILITY(U,$J,358.3,10825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10825,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Other
 ;;^UTILITY(U,$J,358.3,10825,1,4,0)
 ;;=4^D51.3
 ;;^UTILITY(U,$J,358.3,10825,2)
 ;;=^5002287
 ;;^UTILITY(U,$J,358.3,10826,0)
 ;;=D77.^^68^675^55
 ;;^UTILITY(U,$J,358.3,10826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10826,1,3,0)
 ;;=3^Disorder of Blood/Blood-Forming Organs in Diseases Classified Elsewhere,Other
 ;;^UTILITY(U,$J,358.3,10826,1,4,0)
 ;;=4^D77.
 ;;^UTILITY(U,$J,358.3,10826,2)
 ;;=^5002396
 ;;^UTILITY(U,$J,358.3,10827,0)
 ;;=D58.2^^68^675^81
 ;;^UTILITY(U,$J,358.3,10827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10827,1,3,0)
 ;;=3^Hemoglobinopathies,Other
 ;;^UTILITY(U,$J,358.3,10827,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,10827,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,10828,0)
 ;;=C88.8^^68^675^101
 ;;^UTILITY(U,$J,358.3,10828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10828,1,3,0)
 ;;=3^Malig Immunoproliferative Diseases,Other
 ;;^UTILITY(U,$J,358.3,10828,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,10828,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,10829,0)
 ;;=D70.8^^68^675^170
 ;;^UTILITY(U,$J,358.3,10829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10829,1,3,0)
 ;;=3^Neutropenia,Other
 ;;^UTILITY(U,$J,358.3,10829,1,4,0)
 ;;=4^D70.8
 ;;^UTILITY(U,$J,358.3,10829,2)
 ;;=^334042
 ;;^UTILITY(U,$J,358.3,10830,0)
 ;;=D59.4^^68^675^171
 ;;^UTILITY(U,$J,358.3,10830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10830,1,3,0)
 ;;=3^Nonautoimmune Hemolytic Anemias,Other
 ;;^UTILITY(U,$J,358.3,10830,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,10830,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,10831,0)
 ;;=D69.59^^68^675^177
 ;;^UTILITY(U,$J,358.3,10831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10831,1,3,0)
 ;;=3^Secondary Thrombocytopenia,Other
 ;;^UTILITY(U,$J,358.3,10831,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,10831,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,10832,0)
 ;;=C22.7^^68^675^44
 ;;^UTILITY(U,$J,358.3,10832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10832,1,3,0)
 ;;=3^Carcinomas of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,10832,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,10832,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,10833,0)
 ;;=D75.89^^68^675^54
 ;;^UTILITY(U,$J,358.3,10833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10833,1,3,0)
 ;;=3^Diseases of Blood/Blood-Forming Organs,Other Spec
 ;;^UTILITY(U,$J,358.3,10833,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,10833,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,10834,0)
 ;;=D47.Z9^^68^675^169
 ;;^UTILITY(U,$J,358.3,10834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10834,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
