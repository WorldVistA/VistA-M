IBDEI0KG ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9978,1,3,0)
 ;;=3^Esophagoscopy with FB Removal
 ;;^UTILITY(U,$J,358.3,9979,0)
 ;;=43227^^59^651^32^^^^1
 ;;^UTILITY(U,$J,358.3,9979,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9979,1,2,0)
 ;;=2^43227
 ;;^UTILITY(U,$J,358.3,9979,1,3,0)
 ;;=3^Esophagoscopy w/Control of Hemorrhage
 ;;^UTILITY(U,$J,358.3,9980,0)
 ;;=43226^^59^651^33^^^^1
 ;;^UTILITY(U,$J,358.3,9980,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9980,1,2,0)
 ;;=2^43226
 ;;^UTILITY(U,$J,358.3,9980,1,3,0)
 ;;=3^Esophagoscopy w/Dilation over wire
 ;;^UTILITY(U,$J,358.3,9981,0)
 ;;=43220^^59^651^30^^^^1
 ;;^UTILITY(U,$J,358.3,9981,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9981,1,2,0)
 ;;=2^43220
 ;;^UTILITY(U,$J,358.3,9981,1,3,0)
 ;;=3^Esophagoscopy w/Ballon Dilation <30mm
 ;;^UTILITY(U,$J,358.3,9982,0)
 ;;=43235^^59^651^19^^^^1
 ;;^UTILITY(U,$J,358.3,9982,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9982,1,2,0)
 ;;=2^43235
 ;;^UTILITY(U,$J,358.3,9982,1,3,0)
 ;;=3^EGD, Diagnostic
 ;;^UTILITY(U,$J,358.3,9983,0)
 ;;=43239^^59^651^3^^^^1
 ;;^UTILITY(U,$J,358.3,9983,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9983,1,2,0)
 ;;=2^43239
 ;;^UTILITY(U,$J,358.3,9983,1,3,0)
 ;;=3^EGD w/Biopsy
 ;;^UTILITY(U,$J,358.3,9984,0)
 ;;=43250^^59^651^21^^^^1
 ;;^UTILITY(U,$J,358.3,9984,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9984,1,2,0)
 ;;=2^43250
 ;;^UTILITY(U,$J,358.3,9984,1,3,0)
 ;;=3^EGD, w/Tumor Removal by Hot Forceps
 ;;^UTILITY(U,$J,358.3,9985,0)
 ;;=43251^^59^651^17^^^^1
 ;;^UTILITY(U,$J,358.3,9985,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9985,1,2,0)
 ;;=2^43251
 ;;^UTILITY(U,$J,358.3,9985,1,3,0)
 ;;=3^EGD w/Tumor Removal By Snare
 ;;^UTILITY(U,$J,358.3,9986,0)
 ;;=43247^^59^651^11^^^^1
 ;;^UTILITY(U,$J,358.3,9986,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9986,1,2,0)
 ;;=2^43247
 ;;^UTILITY(U,$J,358.3,9986,1,3,0)
 ;;=3^EGD w/FB Removal
 ;;^UTILITY(U,$J,358.3,9987,0)
 ;;=43255^^59^651^5^^^^1
 ;;^UTILITY(U,$J,358.3,9987,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9987,1,2,0)
 ;;=2^43255
 ;;^UTILITY(U,$J,358.3,9987,1,3,0)
 ;;=3^EGD w/Control of Hemorrhage
 ;;^UTILITY(U,$J,358.3,9988,0)
 ;;=43245^^59^651^6^^^^1
 ;;^UTILITY(U,$J,358.3,9988,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9988,1,2,0)
 ;;=2^43245
 ;;^UTILITY(U,$J,358.3,9988,1,3,0)
 ;;=3^EGD w/Dilation of Gatric Outlet Obstr
 ;;^UTILITY(U,$J,358.3,9989,0)
 ;;=43248^^59^651^10^^^^1
 ;;^UTILITY(U,$J,358.3,9989,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9989,1,2,0)
 ;;=2^43248
 ;;^UTILITY(U,$J,358.3,9989,1,3,0)
 ;;=3^EGD w/Esoph Dilation over wire
 ;;^UTILITY(U,$J,358.3,9990,0)
 ;;=43249^^59^651^8^^^^1
 ;;^UTILITY(U,$J,358.3,9990,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9990,1,2,0)
 ;;=2^43249
 ;;^UTILITY(U,$J,358.3,9990,1,3,0)
 ;;=3^EGD w/Esoph Dilation Balloon <30mm
 ;;^UTILITY(U,$J,358.3,9991,0)
 ;;=43244^^59^651^2^^^^1
 ;;^UTILITY(U,$J,358.3,9991,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9991,1,2,0)
 ;;=2^43244
 ;;^UTILITY(U,$J,358.3,9991,1,3,0)
 ;;=3^EGD w/Band Ligation
 ;;^UTILITY(U,$J,358.3,9992,0)
 ;;=43243^^59^651^13^^^^1
 ;;^UTILITY(U,$J,358.3,9992,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9992,1,2,0)
 ;;=2^43243
 ;;^UTILITY(U,$J,358.3,9992,1,3,0)
 ;;=3^EGD w/Sclerosis Injection
 ;;^UTILITY(U,$J,358.3,9993,0)
 ;;=43205^^59^651^34^^^^1
 ;;^UTILITY(U,$J,358.3,9993,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9993,1,2,0)
 ;;=2^43205
 ;;^UTILITY(U,$J,358.3,9993,1,3,0)
 ;;=3^Esophagoscopy w/Ligation of Varices
 ;;^UTILITY(U,$J,358.3,9994,0)
 ;;=43201^^59^651^37^^^^1
 ;;^UTILITY(U,$J,358.3,9994,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9994,1,2,0)
 ;;=2^43201
