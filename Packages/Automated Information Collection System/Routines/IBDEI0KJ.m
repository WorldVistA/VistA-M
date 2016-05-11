IBDEI0KJ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9552,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9552,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,9552,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,9553,0)
 ;;=99242^^42^483^2
 ;;^UTILITY(U,$J,358.3,9553,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9553,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,9553,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,9554,0)
 ;;=99243^^42^483^3
 ;;^UTILITY(U,$J,358.3,9554,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9554,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,9554,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,9555,0)
 ;;=99244^^42^483^4
 ;;^UTILITY(U,$J,358.3,9555,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9555,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,9555,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,9556,0)
 ;;=99245^^42^483^5
 ;;^UTILITY(U,$J,358.3,9556,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9556,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,9556,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,9557,0)
 ;;=92012^^42^484^1
 ;;^UTILITY(U,$J,358.3,9557,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9557,1,1,0)
 ;;=1^Eye Exam, Established
 ;;^UTILITY(U,$J,358.3,9557,1,2,0)
 ;;=2^92012
 ;;^UTILITY(U,$J,358.3,9558,0)
 ;;=92014^^42^484^2
 ;;^UTILITY(U,$J,358.3,9558,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9558,1,1,0)
 ;;=1^Comprehensive Exam, Estab
 ;;^UTILITY(U,$J,358.3,9558,1,2,0)
 ;;=2^92014
 ;;^UTILITY(U,$J,358.3,9559,0)
 ;;=92002^^42^484^3
 ;;^UTILITY(U,$J,358.3,9559,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9559,1,1,0)
 ;;=1^Eye Exam, New Pt
 ;;^UTILITY(U,$J,358.3,9559,1,2,0)
 ;;=2^92002
 ;;^UTILITY(U,$J,358.3,9560,0)
 ;;=92004^^42^484^4
 ;;^UTILITY(U,$J,358.3,9560,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9560,1,1,0)
 ;;=1^Comprehensive Exam, New Pt
 ;;^UTILITY(U,$J,358.3,9560,1,2,0)
 ;;=2^92004
 ;;^UTILITY(U,$J,358.3,9561,0)
 ;;=92015^^43^485^1^^^^1
 ;;^UTILITY(U,$J,358.3,9561,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9561,1,2,0)
 ;;=2^Refraction
 ;;^UTILITY(U,$J,358.3,9561,1,3,0)
 ;;=3^92015
 ;;^UTILITY(U,$J,358.3,9562,0)
 ;;=92311^^43^486^3^^^^1
 ;;^UTILITY(U,$J,358.3,9562,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9562,1,2,0)
 ;;=2^Contact Lens-Aphakia OD/OS
 ;;^UTILITY(U,$J,358.3,9562,1,3,0)
 ;;=3^92311
 ;;^UTILITY(U,$J,358.3,9563,0)
 ;;=92312^^43^486^4^^^^1
 ;;^UTILITY(U,$J,358.3,9563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9563,1,2,0)
 ;;=2^Contact Lens-Aphakia OU
 ;;^UTILITY(U,$J,358.3,9563,1,3,0)
 ;;=3^92312
 ;;^UTILITY(U,$J,358.3,9564,0)
 ;;=92340^^43^486^6^^^^1
 ;;^UTILITY(U,$J,358.3,9564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9564,1,2,0)
 ;;=2^Glasses Fitting, Monofocal
 ;;^UTILITY(U,$J,358.3,9564,1,3,0)
 ;;=3^92340
 ;;^UTILITY(U,$J,358.3,9565,0)
 ;;=92341^^43^486^5^^^^1
 ;;^UTILITY(U,$J,358.3,9565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9565,1,2,0)
 ;;=2^Glasses Fitting, Bifocal
 ;;^UTILITY(U,$J,358.3,9565,1,3,0)
 ;;=3^92341
 ;;^UTILITY(U,$J,358.3,9566,0)
 ;;=92342^^43^486^8^^^^1
 ;;^UTILITY(U,$J,358.3,9566,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9566,1,2,0)
 ;;=2^Glasses Fitting, Multifocal
 ;;^UTILITY(U,$J,358.3,9566,1,3,0)
 ;;=3^92342
 ;;^UTILITY(U,$J,358.3,9567,0)
 ;;=92352^^43^486^7^^^^1
 ;;^UTILITY(U,$J,358.3,9567,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9567,1,2,0)
 ;;=2^Glasses Fitting, Monofocal for Aphakia
 ;;^UTILITY(U,$J,358.3,9567,1,3,0)
 ;;=3^92352
 ;;^UTILITY(U,$J,358.3,9568,0)
 ;;=92353^^43^486^9^^^^1
 ;;^UTILITY(U,$J,358.3,9568,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9568,1,2,0)
 ;;=2^Glasses Fitting, Multifocal, for Aphakia
