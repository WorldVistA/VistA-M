IBDEI0SS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13499,1,3,0)
 ;;=3^Nutritional Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,13499,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,13499,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,13500,0)
 ;;=D47.4^^53^593^177
 ;;^UTILITY(U,$J,358.3,13500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13500,1,3,0)
 ;;=3^Osteomyelofibrosis
 ;;^UTILITY(U,$J,358.3,13500,1,4,0)
 ;;=4^D47.4
 ;;^UTILITY(U,$J,358.3,13500,2)
 ;;=^5002259
 ;;^UTILITY(U,$J,358.3,13501,0)
 ;;=D59.1^^53^593^28
 ;;^UTILITY(U,$J,358.3,13501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13501,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Other
 ;;^UTILITY(U,$J,358.3,13501,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,13501,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,13502,0)
 ;;=D51.3^^53^593^191
 ;;^UTILITY(U,$J,358.3,13502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13502,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Other
 ;;^UTILITY(U,$J,358.3,13502,1,4,0)
 ;;=4^D51.3
 ;;^UTILITY(U,$J,358.3,13502,2)
 ;;=^5002287
 ;;^UTILITY(U,$J,358.3,13503,0)
 ;;=D77.^^53^593^57
 ;;^UTILITY(U,$J,358.3,13503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13503,1,3,0)
 ;;=3^Disorder of Blood/Blood-Forming Organs in Diseases Classified Elsewhere,Other
 ;;^UTILITY(U,$J,358.3,13503,1,4,0)
 ;;=4^D77.
 ;;^UTILITY(U,$J,358.3,13503,2)
 ;;=^5002396
 ;;^UTILITY(U,$J,358.3,13504,0)
 ;;=D58.2^^53^593^83
 ;;^UTILITY(U,$J,358.3,13504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13504,1,3,0)
 ;;=3^Hemoglobinopathies,Other
 ;;^UTILITY(U,$J,358.3,13504,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,13504,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,13505,0)
 ;;=C88.8^^53^593^103
 ;;^UTILITY(U,$J,358.3,13505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13505,1,3,0)
 ;;=3^Malig Immunoproliferative Diseases,Other
 ;;^UTILITY(U,$J,358.3,13505,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,13505,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,13506,0)
 ;;=D70.8^^53^593^174
 ;;^UTILITY(U,$J,358.3,13506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13506,1,3,0)
 ;;=3^Neutropenia,Other
 ;;^UTILITY(U,$J,358.3,13506,1,4,0)
 ;;=4^D70.8
 ;;^UTILITY(U,$J,358.3,13506,2)
 ;;=^334042
 ;;^UTILITY(U,$J,358.3,13507,0)
 ;;=D59.4^^53^593^175
 ;;^UTILITY(U,$J,358.3,13507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13507,1,3,0)
 ;;=3^Nonautoimmune Hemolytic Anemias,Other
 ;;^UTILITY(U,$J,358.3,13507,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,13507,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,13508,0)
 ;;=D69.59^^53^593^181
 ;;^UTILITY(U,$J,358.3,13508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13508,1,3,0)
 ;;=3^Secondary Thrombocytopenia,Other
 ;;^UTILITY(U,$J,358.3,13508,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,13508,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,13509,0)
 ;;=C22.7^^53^593^46
 ;;^UTILITY(U,$J,358.3,13509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13509,1,3,0)
 ;;=3^Carcinomas of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,13509,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,13509,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,13510,0)
 ;;=D75.89^^53^593^56
 ;;^UTILITY(U,$J,358.3,13510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13510,1,3,0)
 ;;=3^Diseases of Blood/Blood-Forming Organs,Other Spec
 ;;^UTILITY(U,$J,358.3,13510,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,13510,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,13511,0)
 ;;=D47.Z9^^53^593^173
 ;;^UTILITY(U,$J,358.3,13511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13511,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
 ;;^UTILITY(U,$J,358.3,13511,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,13511,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,13512,0)
 ;;=D05.82^^53^593^34
