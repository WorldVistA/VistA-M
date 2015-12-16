IBDEI0KD ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9631,0)
 ;;=G9389^^43^550^35^^^^1
 ;;^UTILITY(U,$J,358.3,9631,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9631,1,2,0)
 ;;=2^Unplan Rupture Post Caps Req Vitrectomy
 ;;^UTILITY(U,$J,358.3,9631,1,3,0)
 ;;=3^G9389
 ;;^UTILITY(U,$J,358.3,9632,0)
 ;;=G9390^^43^550^24^^^^1
 ;;^UTILITY(U,$J,358.3,9632,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9632,1,2,0)
 ;;=2^No Unplan Rupt Post Caps Req Vitrectomy
 ;;^UTILITY(U,$J,358.3,9632,1,3,0)
 ;;=3^G9390
 ;;^UTILITY(U,$J,358.3,9633,0)
 ;;=G9392^^43^550^2^^^^1
 ;;^UTILITY(U,$J,358.3,9633,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9633,1,2,0)
 ;;=2^Achives Refrac,s/p Cat Surg,F/U Visit
 ;;^UTILITY(U,$J,358.3,9633,1,3,0)
 ;;=3^G9392
 ;;^UTILITY(U,$J,358.3,9634,0)
 ;;=92145^^43^550^7^^^^1
 ;;^UTILITY(U,$J,358.3,9634,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9634,1,2,0)
 ;;=2^Corneal Hysteresis,Interp/Rpt
 ;;^UTILITY(U,$J,358.3,9634,1,3,0)
 ;;=3^92145
 ;;^UTILITY(U,$J,358.3,9635,0)
 ;;=0378T^^43^550^36^^^^1
 ;;^UTILITY(U,$J,358.3,9635,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9635,1,2,0)
 ;;=2^VF Assmnt,Remote,Rev/Rpt
 ;;^UTILITY(U,$J,358.3,9635,1,3,0)
 ;;=3^0378T
 ;;^UTILITY(U,$J,358.3,9636,0)
 ;;=0379T^^43^550^37^^^^1
 ;;^UTILITY(U,$J,358.3,9636,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9636,1,2,0)
 ;;=2^VF Assmnt,Tech Support
 ;;^UTILITY(U,$J,358.3,9636,1,3,0)
 ;;=3^0379T
 ;;^UTILITY(U,$J,358.3,9637,0)
 ;;=0380T^^43^550^28^^^^1
 ;;^UTILITY(U,$J,358.3,9637,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9637,1,2,0)
 ;;=2^PC Aided Retina Images,Interp/Rpt
 ;;^UTILITY(U,$J,358.3,9637,1,3,0)
 ;;=3^0380T
 ;;^UTILITY(U,$J,358.3,9638,0)
 ;;=G9392^^43^550^25^^^^1
 ;;^UTILITY(U,$J,358.3,9638,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9638,1,2,0)
 ;;=2^Not Achive +1D,s/p Cat Surg,F/U Visit
 ;;^UTILITY(U,$J,358.3,9638,1,3,0)
 ;;=3^G9392
 ;;^UTILITY(U,$J,358.3,9639,0)
 ;;=99075^^43^550^22^^^^1
 ;;^UTILITY(U,$J,358.3,9639,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9639,1,2,0)
 ;;=2^Medical Testimony
 ;;^UTILITY(U,$J,358.3,9639,1,3,0)
 ;;=3^99075
 ;;^UTILITY(U,$J,358.3,9640,0)
 ;;=67800^^43^551^5^^^^1
 ;;^UTILITY(U,$J,358.3,9640,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9640,1,2,0)
 ;;=2^Chalazion - excision - single
 ;;^UTILITY(U,$J,358.3,9640,1,3,0)
 ;;=3^67800
 ;;^UTILITY(U,$J,358.3,9641,0)
 ;;=65435^^43^551^8^^^^1
 ;;^UTILITY(U,$J,358.3,9641,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9641,1,2,0)
 ;;=2^Corneal debridement* (tx)
 ;;^UTILITY(U,$J,358.3,9641,1,3,0)
 ;;=3^65435
 ;;^UTILITY(U,$J,358.3,9642,0)
 ;;=67700^^43^551^10^^^^1
 ;;^UTILITY(U,$J,358.3,9642,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9642,1,2,0)
 ;;=2^Cyst-drainage* (eyelid)
 ;;^UTILITY(U,$J,358.3,9642,1,3,0)
 ;;=3^67700
 ;;^UTILITY(U,$J,358.3,9643,0)
 ;;=67825^^43^551^14^^^^1
 ;;^UTILITY(U,$J,358.3,9643,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9643,1,2,0)
 ;;=2^Epilation - Electro surgical*
 ;;^UTILITY(U,$J,358.3,9643,1,3,0)
 ;;=3^67825
 ;;^UTILITY(U,$J,358.3,9644,0)
 ;;=67820^^43^551^15^^^^1
 ;;^UTILITY(U,$J,358.3,9644,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9644,1,2,0)
 ;;=2^Epilation - Forceps*
 ;;^UTILITY(U,$J,358.3,9644,1,3,0)
 ;;=3^67820
 ;;^UTILITY(U,$J,358.3,9645,0)
 ;;=67810^^43^551^3^^^^1
 ;;^UTILITY(U,$J,358.3,9645,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9645,1,2,0)
 ;;=2^Biopsy of Eyelid
 ;;^UTILITY(U,$J,358.3,9645,1,3,0)
 ;;=3^67810
 ;;^UTILITY(U,$J,358.3,9646,0)
 ;;=67850^^43^551^16^^^^1
 ;;^UTILITY(U,$J,358.3,9646,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9646,1,2,0)
 ;;=2^Eyelid lesion,destruction, up to 1 cm
 ;;^UTILITY(U,$J,358.3,9646,1,3,0)
 ;;=3^67850
