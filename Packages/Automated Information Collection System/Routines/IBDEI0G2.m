IBDEI0G2 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7783,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,7783,1,1,0)
 ;;=1^Comprehensive Exam, New Pt
 ;;^UTILITY(U,$J,358.3,7783,1,2,0)
 ;;=2^92004
 ;;^UTILITY(U,$J,358.3,7784,0)
 ;;=92015^^57^595^1^^^^1
 ;;^UTILITY(U,$J,358.3,7784,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7784,1,2,0)
 ;;=2^Refraction
 ;;^UTILITY(U,$J,358.3,7784,1,3,0)
 ;;=3^92015
 ;;^UTILITY(U,$J,358.3,7785,0)
 ;;=92311^^57^596^3^^^^1
 ;;^UTILITY(U,$J,358.3,7785,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7785,1,2,0)
 ;;=2^Contact Lens-Aphakia OD/OS
 ;;^UTILITY(U,$J,358.3,7785,1,3,0)
 ;;=3^92311
 ;;^UTILITY(U,$J,358.3,7786,0)
 ;;=92312^^57^596^4^^^^1
 ;;^UTILITY(U,$J,358.3,7786,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7786,1,2,0)
 ;;=2^Contact Lens-Aphakia OU
 ;;^UTILITY(U,$J,358.3,7786,1,3,0)
 ;;=3^92312
 ;;^UTILITY(U,$J,358.3,7787,0)
 ;;=92340^^57^596^6^^^^1
 ;;^UTILITY(U,$J,358.3,7787,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7787,1,2,0)
 ;;=2^Glasses Fitting, Monofocal
 ;;^UTILITY(U,$J,358.3,7787,1,3,0)
 ;;=3^92340
 ;;^UTILITY(U,$J,358.3,7788,0)
 ;;=92341^^57^596^5^^^^1
 ;;^UTILITY(U,$J,358.3,7788,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7788,1,2,0)
 ;;=2^Glasses Fitting, Bifocal
 ;;^UTILITY(U,$J,358.3,7788,1,3,0)
 ;;=3^92341
 ;;^UTILITY(U,$J,358.3,7789,0)
 ;;=92342^^57^596^8^^^^1
 ;;^UTILITY(U,$J,358.3,7789,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7789,1,2,0)
 ;;=2^Glasses Fitting, Multifocal
 ;;^UTILITY(U,$J,358.3,7789,1,3,0)
 ;;=3^92342
 ;;^UTILITY(U,$J,358.3,7790,0)
 ;;=92352^^57^596^7^^^^1
 ;;^UTILITY(U,$J,358.3,7790,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7790,1,2,0)
 ;;=2^Glasses Fitting, Monofocal for Aphakia
 ;;^UTILITY(U,$J,358.3,7790,1,3,0)
 ;;=3^92352
 ;;^UTILITY(U,$J,358.3,7791,0)
 ;;=92353^^57^596^9^^^^1
 ;;^UTILITY(U,$J,358.3,7791,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7791,1,2,0)
 ;;=2^Glasses Fitting, Multifocal, for Aphakia
 ;;^UTILITY(U,$J,358.3,7791,1,3,0)
 ;;=3^92353
 ;;^UTILITY(U,$J,358.3,7792,0)
 ;;=92354^^57^596^10^^^^1
 ;;^UTILITY(U,$J,358.3,7792,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7792,1,2,0)
 ;;=2^Low Vision Aid Fitting, Single Element
 ;;^UTILITY(U,$J,358.3,7792,1,3,0)
 ;;=3^92354
 ;;^UTILITY(U,$J,358.3,7793,0)
 ;;=92355^^57^596^11^^^^1
 ;;^UTILITY(U,$J,358.3,7793,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7793,1,2,0)
 ;;=2^Low Vision Aid Fitting, Telescopic/Compound Lens
 ;;^UTILITY(U,$J,358.3,7793,1,3,0)
 ;;=3^92355
 ;;^UTILITY(U,$J,358.3,7794,0)
 ;;=92370^^57^596^12^^^^1
 ;;^UTILITY(U,$J,358.3,7794,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7794,1,2,0)
 ;;=2^Repair/Refit Glasses
 ;;^UTILITY(U,$J,358.3,7794,1,3,0)
 ;;=3^92370
 ;;^UTILITY(U,$J,358.3,7795,0)
 ;;=92371^^57^596^13^^^^1
 ;;^UTILITY(U,$J,358.3,7795,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7795,1,2,0)
 ;;=2^Repair/Refit Glasses for Aphakia
 ;;^UTILITY(U,$J,358.3,7795,1,3,0)
 ;;=3^92371
 ;;^UTILITY(U,$J,358.3,7796,0)
 ;;=92071^^57^596^2^^^^1
 ;;^UTILITY(U,$J,358.3,7796,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7796,1,2,0)
 ;;=2^Contact Lens Tx for Ocular Disease
 ;;^UTILITY(U,$J,358.3,7796,1,3,0)
 ;;=3^92071
 ;;^UTILITY(U,$J,358.3,7797,0)
 ;;=92072^^57^596^1^^^^1
 ;;^UTILITY(U,$J,358.3,7797,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7797,1,2,0)
 ;;=2^Contact Lens Mgmt Keratoconus,Init
 ;;^UTILITY(U,$J,358.3,7797,1,3,0)
 ;;=3^92072
 ;;^UTILITY(U,$J,358.3,7798,0)
 ;;=65430^^57^597^7^^^^1
 ;;^UTILITY(U,$J,358.3,7798,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7798,1,2,0)
 ;;=2^Corneal Scrape* (dx culture)
 ;;^UTILITY(U,$J,358.3,7798,1,3,0)
 ;;=3^65430
 ;;^UTILITY(U,$J,358.3,7799,0)
 ;;=92285^^57^597^11^^^^1
