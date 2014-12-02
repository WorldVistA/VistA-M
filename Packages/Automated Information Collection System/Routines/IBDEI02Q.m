IBDEI02Q ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,878,2)
 ;;=^295564
 ;;^UTILITY(U,$J,358.3,879,0)
 ;;=V67.00^^11^98^14
 ;;^UTILITY(U,$J,358.3,879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,879,1,3,0)
 ;;=3^V67.00
 ;;^UTILITY(U,$J,358.3,879,1,4,0)
 ;;=4^Surgical Follow-Up
 ;;^UTILITY(U,$J,358.3,879,2)
 ;;=^322077
 ;;^UTILITY(U,$J,358.3,880,0)
 ;;=V70.5^^11^98^9
 ;;^UTILITY(U,$J,358.3,880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,880,1,3,0)
 ;;=3^V70.5
 ;;^UTILITY(U,$J,358.3,880,1,4,0)
 ;;=4^Health Exam of Defined Subpopulations
 ;;^UTILITY(U,$J,358.3,880,2)
 ;;=^295595
 ;;^UTILITY(U,$J,358.3,881,0)
 ;;=V72.19^^11^98^4
 ;;^UTILITY(U,$J,358.3,881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,881,1,3,0)
 ;;=3^V72.19
 ;;^UTILITY(U,$J,358.3,881,1,4,0)
 ;;=4^Ear & Hearing Exam
 ;;^UTILITY(U,$J,358.3,881,2)
 ;;=^334219
 ;;^UTILITY(U,$J,358.3,882,0)
 ;;=V80.3^^11^98^12
 ;;^UTILITY(U,$J,358.3,882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,882,1,3,0)
 ;;=3^V80.3
 ;;^UTILITY(U,$J,358.3,882,1,4,0)
 ;;=4^Screen for Ear Diseases
 ;;^UTILITY(U,$J,358.3,882,2)
 ;;=^295686
 ;;^UTILITY(U,$J,358.3,883,0)
 ;;=92583^^12^99^31^^^^1
 ;;^UTILITY(U,$J,358.3,883,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,883,1,2,0)
 ;;=2^92583
 ;;^UTILITY(U,$J,358.3,883,1,3,0)
 ;;=3^Select Picture Audiometry
 ;;^UTILITY(U,$J,358.3,884,0)
 ;;=92555^^12^99^32^^^^1
 ;;^UTILITY(U,$J,358.3,884,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,884,1,2,0)
 ;;=2^92555
 ;;^UTILITY(U,$J,358.3,884,1,3,0)
 ;;=3^Speech Audiometry Threshold
 ;;^UTILITY(U,$J,358.3,885,0)
 ;;=92556^^12^99^33^^^^1
 ;;^UTILITY(U,$J,358.3,885,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,885,1,2,0)
 ;;=2^92556
 ;;^UTILITY(U,$J,358.3,885,1,3,0)
 ;;=3^Speech Audiometry, Complete
 ;;^UTILITY(U,$J,358.3,886,0)
 ;;=92564^^12^99^30^^^^1
 ;;^UTILITY(U,$J,358.3,886,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,886,1,2,0)
 ;;=2^92564
 ;;^UTILITY(U,$J,358.3,886,1,3,0)
 ;;=3^SISI Hearing Test
 ;;^UTILITY(U,$J,358.3,887,0)
 ;;=92572^^12^99^34^^^^1
 ;;^UTILITY(U,$J,358.3,887,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,887,1,2,0)
 ;;=2^92572
 ;;^UTILITY(U,$J,358.3,887,1,3,0)
 ;;=3^Staggered Spondaic Word Test
 ;;^UTILITY(U,$J,358.3,888,0)
 ;;=92565^^12^99^35^^^^1
 ;;^UTILITY(U,$J,358.3,888,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,888,1,2,0)
 ;;=2^92565
 ;;^UTILITY(U,$J,358.3,888,1,3,0)
 ;;=3^Stenger Test, Pure Tone
 ;;^UTILITY(U,$J,358.3,889,0)
 ;;=92577^^12^99^36^^^^1
 ;;^UTILITY(U,$J,358.3,889,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,889,1,2,0)
 ;;=2^92577
 ;;^UTILITY(U,$J,358.3,889,1,3,0)
 ;;=3^Stenger Test, Speech
 ;;^UTILITY(U,$J,358.3,890,0)
 ;;=92576^^12^99^37^^^^1
 ;;^UTILITY(U,$J,358.3,890,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,890,1,2,0)
 ;;=2^92576
 ;;^UTILITY(U,$J,358.3,890,1,3,0)
 ;;=3^Synthetic Sentence Test
 ;;^UTILITY(U,$J,358.3,891,0)
 ;;=92563^^12^99^39^^^^1
 ;;^UTILITY(U,$J,358.3,891,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,891,1,2,0)
 ;;=2^92563
 ;;^UTILITY(U,$J,358.3,891,1,3,0)
 ;;=3^Tone Decay Hearing Test
 ;;^UTILITY(U,$J,358.3,892,0)
 ;;=92567^^12^99^40^^^^1
 ;;^UTILITY(U,$J,358.3,892,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,892,1,2,0)
 ;;=2^92567
 ;;^UTILITY(U,$J,358.3,892,1,3,0)
 ;;=3^Tympanometry
 ;;^UTILITY(U,$J,358.3,893,0)
 ;;=92579^^12^99^41^^^^1
 ;;^UTILITY(U,$J,358.3,893,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,893,1,2,0)
 ;;=2^92579
 ;;^UTILITY(U,$J,358.3,893,1,3,0)
 ;;=3^Visual Audiometry (VRA)
 ;;^UTILITY(U,$J,358.3,894,0)
 ;;=92625^^12^99^38^^^^1
 ;;^UTILITY(U,$J,358.3,894,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,894,1,2,0)
 ;;=2^92625
 ;;^UTILITY(U,$J,358.3,894,1,3,0)
 ;;=3^Tinnitus Assessment
