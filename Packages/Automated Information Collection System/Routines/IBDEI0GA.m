IBDEI0GA ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7853,0)
 ;;=92012^^50^567^1
 ;;^UTILITY(U,$J,358.3,7853,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,7853,1,1,0)
 ;;=1^Eye Exam, Established
 ;;^UTILITY(U,$J,358.3,7853,1,2,0)
 ;;=2^92012
 ;;^UTILITY(U,$J,358.3,7854,0)
 ;;=92014^^50^567^2
 ;;^UTILITY(U,$J,358.3,7854,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,7854,1,1,0)
 ;;=1^Comprehensive Exam, Estab
 ;;^UTILITY(U,$J,358.3,7854,1,2,0)
 ;;=2^92014
 ;;^UTILITY(U,$J,358.3,7855,0)
 ;;=92002^^50^567^3
 ;;^UTILITY(U,$J,358.3,7855,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,7855,1,1,0)
 ;;=1^Eye Exam, New Pt
 ;;^UTILITY(U,$J,358.3,7855,1,2,0)
 ;;=2^92002
 ;;^UTILITY(U,$J,358.3,7856,0)
 ;;=92004^^50^567^4
 ;;^UTILITY(U,$J,358.3,7856,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,7856,1,1,0)
 ;;=1^Comprehensive Exam, New Pt
 ;;^UTILITY(U,$J,358.3,7856,1,2,0)
 ;;=2^92004
 ;;^UTILITY(U,$J,358.3,7857,0)
 ;;=92015^^51^568^1^^^^1
 ;;^UTILITY(U,$J,358.3,7857,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7857,1,2,0)
 ;;=2^Refraction
 ;;^UTILITY(U,$J,358.3,7857,1,3,0)
 ;;=3^92015
 ;;^UTILITY(U,$J,358.3,7858,0)
 ;;=92311^^51^569^3^^^^1
 ;;^UTILITY(U,$J,358.3,7858,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7858,1,2,0)
 ;;=2^Contact Lens-Aphakia OD/OS
 ;;^UTILITY(U,$J,358.3,7858,1,3,0)
 ;;=3^92311
 ;;^UTILITY(U,$J,358.3,7859,0)
 ;;=92312^^51^569^4^^^^1
 ;;^UTILITY(U,$J,358.3,7859,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7859,1,2,0)
 ;;=2^Contact Lens-Aphakia OU
 ;;^UTILITY(U,$J,358.3,7859,1,3,0)
 ;;=3^92312
 ;;^UTILITY(U,$J,358.3,7860,0)
 ;;=92340^^51^569^6^^^^1
 ;;^UTILITY(U,$J,358.3,7860,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7860,1,2,0)
 ;;=2^Glasses Fitting, Monofocal
 ;;^UTILITY(U,$J,358.3,7860,1,3,0)
 ;;=3^92340
 ;;^UTILITY(U,$J,358.3,7861,0)
 ;;=92341^^51^569^5^^^^1
 ;;^UTILITY(U,$J,358.3,7861,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7861,1,2,0)
 ;;=2^Glasses Fitting, Bifocal
 ;;^UTILITY(U,$J,358.3,7861,1,3,0)
 ;;=3^92341
 ;;^UTILITY(U,$J,358.3,7862,0)
 ;;=92342^^51^569^8^^^^1
 ;;^UTILITY(U,$J,358.3,7862,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7862,1,2,0)
 ;;=2^Glasses Fitting, Multifocal
 ;;^UTILITY(U,$J,358.3,7862,1,3,0)
 ;;=3^92342
 ;;^UTILITY(U,$J,358.3,7863,0)
 ;;=92352^^51^569^7^^^^1
 ;;^UTILITY(U,$J,358.3,7863,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7863,1,2,0)
 ;;=2^Glasses Fitting, Monofocal for Aphakia
 ;;^UTILITY(U,$J,358.3,7863,1,3,0)
 ;;=3^92352
 ;;^UTILITY(U,$J,358.3,7864,0)
 ;;=92353^^51^569^9^^^^1
 ;;^UTILITY(U,$J,358.3,7864,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7864,1,2,0)
 ;;=2^Glasses Fitting, Multifocal, for Aphakia
 ;;^UTILITY(U,$J,358.3,7864,1,3,0)
 ;;=3^92353
 ;;^UTILITY(U,$J,358.3,7865,0)
 ;;=92354^^51^569^10^^^^1
 ;;^UTILITY(U,$J,358.3,7865,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7865,1,2,0)
 ;;=2^Low Vision Aid Fitting, Single Element
 ;;^UTILITY(U,$J,358.3,7865,1,3,0)
 ;;=3^92354
 ;;^UTILITY(U,$J,358.3,7866,0)
 ;;=92355^^51^569^11^^^^1
 ;;^UTILITY(U,$J,358.3,7866,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7866,1,2,0)
 ;;=2^Low Vision Aid Fitting, Telescopic/Compound Lens
 ;;^UTILITY(U,$J,358.3,7866,1,3,0)
 ;;=3^92355
 ;;^UTILITY(U,$J,358.3,7867,0)
 ;;=92370^^51^569^12^^^^1
 ;;^UTILITY(U,$J,358.3,7867,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7867,1,2,0)
 ;;=2^Repair/Refit Glasses
 ;;^UTILITY(U,$J,358.3,7867,1,3,0)
 ;;=3^92370
 ;;^UTILITY(U,$J,358.3,7868,0)
 ;;=92371^^51^569^13^^^^1
 ;;^UTILITY(U,$J,358.3,7868,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7868,1,2,0)
 ;;=2^Repair/Refit Glasses for Aphakia
 ;;^UTILITY(U,$J,358.3,7868,1,3,0)
 ;;=3^92371
 ;;^UTILITY(U,$J,358.3,7869,0)
 ;;=92071^^51^569^2^^^^1
