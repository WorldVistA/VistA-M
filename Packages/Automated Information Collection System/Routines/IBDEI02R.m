IBDEI02R ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,832,2)
 ;;=^338565
 ;;^UTILITY(U,$J,358.3,833,0)
 ;;=V68.2^^8^90^5
 ;;^UTILITY(U,$J,358.3,833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,833,1,3,0)
 ;;=3^V68.2
 ;;^UTILITY(U,$J,358.3,833,1,4,0)
 ;;=4^Expert Evidence Request
 ;;^UTILITY(U,$J,358.3,833,2)
 ;;=^295586
 ;;^UTILITY(U,$J,358.3,834,0)
 ;;=V65.5^^8^90^6
 ;;^UTILITY(U,$J,358.3,834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,834,1,3,0)
 ;;=3^V65.5
 ;;^UTILITY(U,$J,358.3,834,1,4,0)
 ;;=4^Feared Complaint w/ No Diagnosis
 ;;^UTILITY(U,$J,358.3,834,2)
 ;;=^295564
 ;;^UTILITY(U,$J,358.3,835,0)
 ;;=V67.00^^8^90^15
 ;;^UTILITY(U,$J,358.3,835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,835,1,3,0)
 ;;=3^V67.00
 ;;^UTILITY(U,$J,358.3,835,1,4,0)
 ;;=4^Surgical Follow-Up
 ;;^UTILITY(U,$J,358.3,835,2)
 ;;=^322077
 ;;^UTILITY(U,$J,358.3,836,0)
 ;;=V70.5^^8^90^9
 ;;^UTILITY(U,$J,358.3,836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,836,1,3,0)
 ;;=3^V70.5
 ;;^UTILITY(U,$J,358.3,836,1,4,0)
 ;;=4^Health Exam of Defined Subpopulations
 ;;^UTILITY(U,$J,358.3,836,2)
 ;;=^295595
 ;;^UTILITY(U,$J,358.3,837,0)
 ;;=V72.19^^8^90^4
 ;;^UTILITY(U,$J,358.3,837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,837,1,3,0)
 ;;=3^V72.19
 ;;^UTILITY(U,$J,358.3,837,1,4,0)
 ;;=4^Ear & Hearing Exam
 ;;^UTILITY(U,$J,358.3,837,2)
 ;;=^334219
 ;;^UTILITY(U,$J,358.3,838,0)
 ;;=V80.3^^8^90^13
 ;;^UTILITY(U,$J,358.3,838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,838,1,3,0)
 ;;=3^V80.3
 ;;^UTILITY(U,$J,358.3,838,1,4,0)
 ;;=4^Screen for Ear Diseases
 ;;^UTILITY(U,$J,358.3,838,2)
 ;;=^295686
 ;;^UTILITY(U,$J,358.3,839,0)
 ;;=V72.12^^8^90^11
 ;;^UTILITY(U,$J,358.3,839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,839,1,3,0)
 ;;=3^V72.12
 ;;^UTILITY(U,$J,358.3,839,1,4,0)
 ;;=4^Hearing Conservation/Treatment
 ;;^UTILITY(U,$J,358.3,839,2)
 ;;=^335322
 ;;^UTILITY(U,$J,358.3,840,0)
 ;;=92583^^9^91^32^^^^1
 ;;^UTILITY(U,$J,358.3,840,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,840,1,2,0)
 ;;=2^92583
 ;;^UTILITY(U,$J,358.3,840,1,3,0)
 ;;=3^Select Picture Audiometry
 ;;^UTILITY(U,$J,358.3,841,0)
 ;;=92555^^9^91^33^^^^1
 ;;^UTILITY(U,$J,358.3,841,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,841,1,2,0)
 ;;=2^92555
 ;;^UTILITY(U,$J,358.3,841,1,3,0)
 ;;=3^Speech Audiometry Threshold
 ;;^UTILITY(U,$J,358.3,842,0)
 ;;=92556^^9^91^34^^^^1
 ;;^UTILITY(U,$J,358.3,842,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,842,1,2,0)
 ;;=2^92556
 ;;^UTILITY(U,$J,358.3,842,1,3,0)
 ;;=3^Speech Audiometry, Complete
 ;;^UTILITY(U,$J,358.3,843,0)
 ;;=92564^^9^91^31^^^^1
 ;;^UTILITY(U,$J,358.3,843,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,843,1,2,0)
 ;;=2^92564
 ;;^UTILITY(U,$J,358.3,843,1,3,0)
 ;;=3^SISI Hearing Test
 ;;^UTILITY(U,$J,358.3,844,0)
 ;;=92572^^9^91^35^^^^1
 ;;^UTILITY(U,$J,358.3,844,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,844,1,2,0)
 ;;=2^92572
 ;;^UTILITY(U,$J,358.3,844,1,3,0)
 ;;=3^Staggered Spondaic Word Test
 ;;^UTILITY(U,$J,358.3,845,0)
 ;;=92565^^9^91^36^^^^1
 ;;^UTILITY(U,$J,358.3,845,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,845,1,2,0)
 ;;=2^92565
 ;;^UTILITY(U,$J,358.3,845,1,3,0)
 ;;=3^Stenger Test, Pure Tone
 ;;^UTILITY(U,$J,358.3,846,0)
 ;;=92577^^9^91^37^^^^1
 ;;^UTILITY(U,$J,358.3,846,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,846,1,2,0)
 ;;=2^92577
 ;;^UTILITY(U,$J,358.3,846,1,3,0)
 ;;=3^Stenger Test, Speech
 ;;^UTILITY(U,$J,358.3,847,0)
 ;;=92576^^9^91^38^^^^1
 ;;^UTILITY(U,$J,358.3,847,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,847,1,2,0)
 ;;=2^92576
 ;;^UTILITY(U,$J,358.3,847,1,3,0)
 ;;=3^Synthetic Sentence Test
 ;;^UTILITY(U,$J,358.3,848,0)
 ;;=92563^^9^91^40^^^^1
