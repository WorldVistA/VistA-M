IBDEI1SN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30032,0)
 ;;=D47.4^^135^1372^173
 ;;^UTILITY(U,$J,358.3,30032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30032,1,3,0)
 ;;=3^Osteomyelofibrosis
 ;;^UTILITY(U,$J,358.3,30032,1,4,0)
 ;;=4^D47.4
 ;;^UTILITY(U,$J,358.3,30032,2)
 ;;=^5002259
 ;;^UTILITY(U,$J,358.3,30033,0)
 ;;=D59.1^^135^1372^27
 ;;^UTILITY(U,$J,358.3,30033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30033,1,3,0)
 ;;=3^Autoimmune Hemolytic Anemia,Other
 ;;^UTILITY(U,$J,358.3,30033,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,30033,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,30034,0)
 ;;=D51.3^^135^1372^187
 ;;^UTILITY(U,$J,358.3,30034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30034,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Other
 ;;^UTILITY(U,$J,358.3,30034,1,4,0)
 ;;=4^D51.3
 ;;^UTILITY(U,$J,358.3,30034,2)
 ;;=^5002287
 ;;^UTILITY(U,$J,358.3,30035,0)
 ;;=D77.^^135^1372^55
 ;;^UTILITY(U,$J,358.3,30035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30035,1,3,0)
 ;;=3^Disorder of Blood/Blood-Forming Organs in Diseases Classified Elsewhere,Other
 ;;^UTILITY(U,$J,358.3,30035,1,4,0)
 ;;=4^D77.
 ;;^UTILITY(U,$J,358.3,30035,2)
 ;;=^5002396
 ;;^UTILITY(U,$J,358.3,30036,0)
 ;;=D58.2^^135^1372^81
 ;;^UTILITY(U,$J,358.3,30036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30036,1,3,0)
 ;;=3^Hemoglobinopathies,Other
 ;;^UTILITY(U,$J,358.3,30036,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,30036,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,30037,0)
 ;;=C88.8^^135^1372^101
 ;;^UTILITY(U,$J,358.3,30037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30037,1,3,0)
 ;;=3^Malig Immunoproliferative Diseases,Other
 ;;^UTILITY(U,$J,358.3,30037,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,30037,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,30038,0)
 ;;=D70.8^^135^1372^170
 ;;^UTILITY(U,$J,358.3,30038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30038,1,3,0)
 ;;=3^Neutropenia,Other
 ;;^UTILITY(U,$J,358.3,30038,1,4,0)
 ;;=4^D70.8
 ;;^UTILITY(U,$J,358.3,30038,2)
 ;;=^334042
 ;;^UTILITY(U,$J,358.3,30039,0)
 ;;=D59.4^^135^1372^171
 ;;^UTILITY(U,$J,358.3,30039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30039,1,3,0)
 ;;=3^Nonautoimmune Hemolytic Anemias,Other
 ;;^UTILITY(U,$J,358.3,30039,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,30039,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,30040,0)
 ;;=D69.59^^135^1372^177
 ;;^UTILITY(U,$J,358.3,30040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30040,1,3,0)
 ;;=3^Secondary Thrombocytopenia,Other
 ;;^UTILITY(U,$J,358.3,30040,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,30040,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,30041,0)
 ;;=C22.7^^135^1372^44
 ;;^UTILITY(U,$J,358.3,30041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30041,1,3,0)
 ;;=3^Carcinomas of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,30041,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,30041,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,30042,0)
 ;;=D75.89^^135^1372^54
 ;;^UTILITY(U,$J,358.3,30042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30042,1,3,0)
 ;;=3^Diseases of Blood/Blood-Forming Organs,Other Spec
 ;;^UTILITY(U,$J,358.3,30042,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,30042,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,30043,0)
 ;;=D47.Z9^^135^1372^169
 ;;^UTILITY(U,$J,358.3,30043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30043,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
 ;;^UTILITY(U,$J,358.3,30043,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,30043,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,30044,0)
 ;;=D05.82^^135^1372^32
 ;;^UTILITY(U,$J,358.3,30044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30044,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Other Spec Type
