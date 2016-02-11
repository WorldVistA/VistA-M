IBDEI04H ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1413,0)
 ;;=H61.21^^14^151^22
 ;;^UTILITY(U,$J,358.3,1413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1413,1,3,0)
 ;;=3^Impacted cerumen, right ear
 ;;^UTILITY(U,$J,358.3,1413,1,4,0)
 ;;=4^H61.21
 ;;^UTILITY(U,$J,358.3,1413,2)
 ;;=^5006531
 ;;^UTILITY(U,$J,358.3,1414,0)
 ;;=H72.813^^14^151^26
 ;;^UTILITY(U,$J,358.3,1414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1414,1,3,0)
 ;;=3^Multiple perforations of tympanic membrane, bilateral
 ;;^UTILITY(U,$J,358.3,1414,1,4,0)
 ;;=4^H72.813
 ;;^UTILITY(U,$J,358.3,1414,2)
 ;;=^5006756
 ;;^UTILITY(U,$J,358.3,1415,0)
 ;;=H72.812^^14^151^27
 ;;^UTILITY(U,$J,358.3,1415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1415,1,3,0)
 ;;=3^Multiple perforations of tympanic membrane, left ear
 ;;^UTILITY(U,$J,358.3,1415,1,4,0)
 ;;=4^H72.812
 ;;^UTILITY(U,$J,358.3,1415,2)
 ;;=^5006755
 ;;^UTILITY(U,$J,358.3,1416,0)
 ;;=H72.811^^14^151^28
 ;;^UTILITY(U,$J,358.3,1416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1416,1,3,0)
 ;;=3^Multiple perforations of tympanic membrane, right ear
 ;;^UTILITY(U,$J,358.3,1416,1,4,0)
 ;;=4^H72.811
 ;;^UTILITY(U,$J,358.3,1416,2)
 ;;=^5006754
 ;;^UTILITY(U,$J,358.3,1417,0)
 ;;=H72.2X3^^14^151^23
 ;;^UTILITY(U,$J,358.3,1417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1417,1,3,0)
 ;;=3^Marginal perforations of tympanic membrane, bilateral NEC
 ;;^UTILITY(U,$J,358.3,1417,1,4,0)
 ;;=4^H72.2X3
 ;;^UTILITY(U,$J,358.3,1417,2)
 ;;=^5006752
 ;;^UTILITY(U,$J,358.3,1418,0)
 ;;=H72.2X2^^14^151^24
 ;;^UTILITY(U,$J,358.3,1418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1418,1,3,0)
 ;;=3^Marginal perforations of tympanic membrane, left ear NEC
 ;;^UTILITY(U,$J,358.3,1418,1,4,0)
 ;;=4^H72.2X2
 ;;^UTILITY(U,$J,358.3,1418,2)
 ;;=^5006751
 ;;^UTILITY(U,$J,358.3,1419,0)
 ;;=H72.2X1^^14^151^25
 ;;^UTILITY(U,$J,358.3,1419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1419,1,3,0)
 ;;=3^Marginal perforations of tympanic membrane, right ear NEC
 ;;^UTILITY(U,$J,358.3,1419,1,4,0)
 ;;=4^H72.2X1
 ;;^UTILITY(U,$J,358.3,1419,2)
 ;;=^5006750
 ;;^UTILITY(U,$J,358.3,1420,0)
 ;;=H69.83^^14^151^14
 ;;^UTILITY(U,$J,358.3,1420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1420,1,3,0)
 ;;=3^Eustachian Tube Disorders,Bilateral NEC
 ;;^UTILITY(U,$J,358.3,1420,1,4,0)
 ;;=4^H69.83
 ;;^UTILITY(U,$J,358.3,1420,2)
 ;;=^5006680
 ;;^UTILITY(U,$J,358.3,1421,0)
 ;;=H69.82^^14^151^16
 ;;^UTILITY(U,$J,358.3,1421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1421,1,3,0)
 ;;=3^Eustachian Tube Disorders,Left Ear NEC
 ;;^UTILITY(U,$J,358.3,1421,1,4,0)
 ;;=4^H69.82
 ;;^UTILITY(U,$J,358.3,1421,2)
 ;;=^5006679
 ;;^UTILITY(U,$J,358.3,1422,0)
 ;;=H69.81^^14^151^18
 ;;^UTILITY(U,$J,358.3,1422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1422,1,3,0)
 ;;=3^Eustachian Tube Disorders,Right Ear NEC
 ;;^UTILITY(U,$J,358.3,1422,1,4,0)
 ;;=4^H69.81
 ;;^UTILITY(U,$J,358.3,1422,2)
 ;;=^5006678
 ;;^UTILITY(U,$J,358.3,1423,0)
 ;;=H69.03^^14^151^29
 ;;^UTILITY(U,$J,358.3,1423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1423,1,3,0)
 ;;=3^Patulous Eustachian tube, bilateral
 ;;^UTILITY(U,$J,358.3,1423,1,4,0)
 ;;=4^H69.03
 ;;^UTILITY(U,$J,358.3,1423,2)
 ;;=^5006676
 ;;^UTILITY(U,$J,358.3,1424,0)
 ;;=H69.02^^14^151^30
 ;;^UTILITY(U,$J,358.3,1424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1424,1,3,0)
 ;;=3^Patulous Eustachian tube, left ear
 ;;^UTILITY(U,$J,358.3,1424,1,4,0)
 ;;=4^H69.02
 ;;^UTILITY(U,$J,358.3,1424,2)
 ;;=^5006675
 ;;^UTILITY(U,$J,358.3,1425,0)
 ;;=H69.01^^14^151^31
 ;;^UTILITY(U,$J,358.3,1425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1425,1,3,0)
 ;;=3^Patulous Eustachian tube, right ear
