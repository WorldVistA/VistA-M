IBDEI0KM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9601,0)
 ;;=0333T^^43^487^32^^^^1
 ;;^UTILITY(U,$J,358.3,9601,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9601,1,2,0)
 ;;=2^Visual EP Acuity Scrn Auto
 ;;^UTILITY(U,$J,358.3,9601,1,3,0)
 ;;=3^0333T
 ;;^UTILITY(U,$J,358.3,9602,0)
 ;;=92136^^43^487^23^^^^1
 ;;^UTILITY(U,$J,358.3,9602,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9602,1,2,0)
 ;;=2^Ophthalmic Biometry
 ;;^UTILITY(U,$J,358.3,9602,1,3,0)
 ;;=3^92136
 ;;^UTILITY(U,$J,358.3,9603,0)
 ;;=92025^^43^487^9^^^^1
 ;;^UTILITY(U,$J,358.3,9603,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9603,1,2,0)
 ;;=2^Corneal Topography
 ;;^UTILITY(U,$J,358.3,9603,1,3,0)
 ;;=3^92025
 ;;^UTILITY(U,$J,358.3,9604,0)
 ;;=G9389^^43^487^29^^^^1
 ;;^UTILITY(U,$J,358.3,9604,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9604,1,2,0)
 ;;=2^Unplan Rupture Post Caps Req Vitrectomy
 ;;^UTILITY(U,$J,358.3,9604,1,3,0)
 ;;=3^G9389
 ;;^UTILITY(U,$J,358.3,9605,0)
 ;;=G9390^^43^487^22^^^^1
 ;;^UTILITY(U,$J,358.3,9605,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9605,1,2,0)
 ;;=2^No Unplan Rupt Post Caps Req Vitrectomy
 ;;^UTILITY(U,$J,358.3,9605,1,3,0)
 ;;=3^G9390
 ;;^UTILITY(U,$J,358.3,9606,0)
 ;;=92145^^43^487^6^^^^1
 ;;^UTILITY(U,$J,358.3,9606,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9606,1,2,0)
 ;;=2^Corneal Hysteresis,Interp/Rpt
 ;;^UTILITY(U,$J,358.3,9606,1,3,0)
 ;;=3^92145
 ;;^UTILITY(U,$J,358.3,9607,0)
 ;;=0378T^^43^487^30^^^^1
 ;;^UTILITY(U,$J,358.3,9607,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9607,1,2,0)
 ;;=2^VF Assmnt,Remote,Rev/Rpt
 ;;^UTILITY(U,$J,358.3,9607,1,3,0)
 ;;=3^0378T
 ;;^UTILITY(U,$J,358.3,9608,0)
 ;;=0379T^^43^487^31^^^^1
 ;;^UTILITY(U,$J,358.3,9608,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9608,1,2,0)
 ;;=2^VF Assmnt,Tech Support
 ;;^UTILITY(U,$J,358.3,9608,1,3,0)
 ;;=3^0379T
 ;;^UTILITY(U,$J,358.3,9609,0)
 ;;=0380T^^43^487^25^^^^1
 ;;^UTILITY(U,$J,358.3,9609,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9609,1,2,0)
 ;;=2^PC Aided Retina Images,Interp/Rpt
 ;;^UTILITY(U,$J,358.3,9609,1,3,0)
 ;;=3^0380T
 ;;^UTILITY(U,$J,358.3,9610,0)
 ;;=99075^^43^487^20^^^^1
 ;;^UTILITY(U,$J,358.3,9610,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9610,1,2,0)
 ;;=2^Medical Testimony
 ;;^UTILITY(U,$J,358.3,9610,1,3,0)
 ;;=3^99075
 ;;^UTILITY(U,$J,358.3,9611,0)
 ;;=67800^^43^488^5^^^^1
 ;;^UTILITY(U,$J,358.3,9611,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9611,1,2,0)
 ;;=2^Chalazion - excision - single
 ;;^UTILITY(U,$J,358.3,9611,1,3,0)
 ;;=3^67800
 ;;^UTILITY(U,$J,358.3,9612,0)
 ;;=65435^^43^488^8^^^^1
 ;;^UTILITY(U,$J,358.3,9612,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9612,1,2,0)
 ;;=2^Corneal debridement* (tx)
 ;;^UTILITY(U,$J,358.3,9612,1,3,0)
 ;;=3^65435
 ;;^UTILITY(U,$J,358.3,9613,0)
 ;;=67700^^43^488^10^^^^1
 ;;^UTILITY(U,$J,358.3,9613,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9613,1,2,0)
 ;;=2^Cyst-drainage* (eyelid)
 ;;^UTILITY(U,$J,358.3,9613,1,3,0)
 ;;=3^67700
 ;;^UTILITY(U,$J,358.3,9614,0)
 ;;=67825^^43^488^14^^^^1
 ;;^UTILITY(U,$J,358.3,9614,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9614,1,2,0)
 ;;=2^Epilation - Electro surgical*
 ;;^UTILITY(U,$J,358.3,9614,1,3,0)
 ;;=3^67825
 ;;^UTILITY(U,$J,358.3,9615,0)
 ;;=67820^^43^488^15^^^^1
 ;;^UTILITY(U,$J,358.3,9615,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9615,1,2,0)
 ;;=2^Epilation - Forceps*
 ;;^UTILITY(U,$J,358.3,9615,1,3,0)
 ;;=3^67820
 ;;^UTILITY(U,$J,358.3,9616,0)
 ;;=67810^^43^488^3^^^^1
 ;;^UTILITY(U,$J,358.3,9616,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9616,1,2,0)
 ;;=2^Biopsy of Eyelid
 ;;^UTILITY(U,$J,358.3,9616,1,3,0)
 ;;=3^67810
 ;;^UTILITY(U,$J,358.3,9617,0)
 ;;=67850^^43^488^16^^^^1
