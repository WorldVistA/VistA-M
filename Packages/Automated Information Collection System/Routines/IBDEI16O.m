IBDEI16O ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20125,1,3,0)
 ;;=3^Nutritional Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,20125,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,20125,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,20126,0)
 ;;=D47.4^^84^929^177
 ;;^UTILITY(U,$J,358.3,20126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20126,1,3,0)
 ;;=3^Osteomyelofibrosis
 ;;^UTILITY(U,$J,358.3,20126,1,4,0)
 ;;=4^D47.4
 ;;^UTILITY(U,$J,358.3,20126,2)
 ;;=^5002259
 ;;^UTILITY(U,$J,358.3,20127,0)
 ;;=D59.1^^84^929^28
 ;;^UTILITY(U,$J,358.3,20127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20127,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Other
 ;;^UTILITY(U,$J,358.3,20127,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,20127,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,20128,0)
 ;;=D51.3^^84^929^191
 ;;^UTILITY(U,$J,358.3,20128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20128,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Other
 ;;^UTILITY(U,$J,358.3,20128,1,4,0)
 ;;=4^D51.3
 ;;^UTILITY(U,$J,358.3,20128,2)
 ;;=^5002287
 ;;^UTILITY(U,$J,358.3,20129,0)
 ;;=D77.^^84^929^57
 ;;^UTILITY(U,$J,358.3,20129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20129,1,3,0)
 ;;=3^Disorder of Blood/Blood-Forming Organs in Diseases Classified Elsewhere,Other
 ;;^UTILITY(U,$J,358.3,20129,1,4,0)
 ;;=4^D77.
 ;;^UTILITY(U,$J,358.3,20129,2)
 ;;=^5002396
 ;;^UTILITY(U,$J,358.3,20130,0)
 ;;=D58.2^^84^929^83
 ;;^UTILITY(U,$J,358.3,20130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20130,1,3,0)
 ;;=3^Hemoglobinopathies,Other
 ;;^UTILITY(U,$J,358.3,20130,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,20130,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,20131,0)
 ;;=C88.8^^84^929^103
 ;;^UTILITY(U,$J,358.3,20131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20131,1,3,0)
 ;;=3^Malig Immunoproliferative Diseases,Other
 ;;^UTILITY(U,$J,358.3,20131,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,20131,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,20132,0)
 ;;=D70.8^^84^929^174
 ;;^UTILITY(U,$J,358.3,20132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20132,1,3,0)
 ;;=3^Neutropenia,Other
 ;;^UTILITY(U,$J,358.3,20132,1,4,0)
 ;;=4^D70.8
 ;;^UTILITY(U,$J,358.3,20132,2)
 ;;=^334042
 ;;^UTILITY(U,$J,358.3,20133,0)
 ;;=D59.4^^84^929^175
 ;;^UTILITY(U,$J,358.3,20133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20133,1,3,0)
 ;;=3^Nonautoimmune Hemolytic Anemias,Other
 ;;^UTILITY(U,$J,358.3,20133,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,20133,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,20134,0)
 ;;=D69.59^^84^929^181
 ;;^UTILITY(U,$J,358.3,20134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20134,1,3,0)
 ;;=3^Secondary Thrombocytopenia,Other
 ;;^UTILITY(U,$J,358.3,20134,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,20134,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,20135,0)
 ;;=C22.7^^84^929^46
 ;;^UTILITY(U,$J,358.3,20135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20135,1,3,0)
 ;;=3^Carcinomas of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,20135,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,20135,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,20136,0)
 ;;=D75.89^^84^929^56
 ;;^UTILITY(U,$J,358.3,20136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20136,1,3,0)
 ;;=3^Diseases of Blood/Blood-Forming Organs,Other Spec
 ;;^UTILITY(U,$J,358.3,20136,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,20136,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,20137,0)
 ;;=D47.Z9^^84^929^173
 ;;^UTILITY(U,$J,358.3,20137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20137,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
 ;;^UTILITY(U,$J,358.3,20137,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,20137,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,20138,0)
 ;;=D05.82^^84^929^34
