IBDEI0HU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8250,0)
 ;;=Z02.71^^33^433^3
 ;;^UTILITY(U,$J,358.3,8250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8250,1,3,0)
 ;;=3^Disability determination
 ;;^UTILITY(U,$J,358.3,8250,1,4,0)
 ;;=4^Z02.71
 ;;^UTILITY(U,$J,358.3,8250,2)
 ;;=^5062640
 ;;^UTILITY(U,$J,358.3,8251,0)
 ;;=Z02.79^^33^433^7
 ;;^UTILITY(U,$J,358.3,8251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8251,1,3,0)
 ;;=3^Medical Certificate Issues NEC
 ;;^UTILITY(U,$J,358.3,8251,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,8251,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,8252,0)
 ;;=Z00.00^^33^433^6
 ;;^UTILITY(U,$J,358.3,8252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8252,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,8252,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,8252,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,8253,0)
 ;;=Z02.83^^33^433^2
 ;;^UTILITY(U,$J,358.3,8253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8253,1,3,0)
 ;;=3^Blood-alcohol and blood-drug test
 ;;^UTILITY(U,$J,358.3,8253,1,4,0)
 ;;=4^Z02.83
 ;;^UTILITY(U,$J,358.3,8253,2)
 ;;=^5062644
 ;;^UTILITY(U,$J,358.3,8254,0)
 ;;=Z02.81^^33^433^8
 ;;^UTILITY(U,$J,358.3,8254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8254,1,3,0)
 ;;=3^Paternity Testing
 ;;^UTILITY(U,$J,358.3,8254,1,4,0)
 ;;=4^Z02.81
 ;;^UTILITY(U,$J,358.3,8254,2)
 ;;=^5062642
 ;;^UTILITY(U,$J,358.3,8255,0)
 ;;=Z02.3^^33^433^10
 ;;^UTILITY(U,$J,358.3,8255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8255,1,3,0)
 ;;=3^Recruitment to Armed Forces Exam
 ;;^UTILITY(U,$J,358.3,8255,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,8255,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,8256,0)
 ;;=Z02.1^^33^433^9
 ;;^UTILITY(U,$J,358.3,8256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8256,1,3,0)
 ;;=3^Pre-Employment Exam
 ;;^UTILITY(U,$J,358.3,8256,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,8256,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,8257,0)
 ;;=Z02.89^^33^433^1
 ;;^UTILITY(U,$J,358.3,8257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8257,1,3,0)
 ;;=3^Administrative Exam NEC
 ;;^UTILITY(U,$J,358.3,8257,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,8257,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,8258,0)
 ;;=Z01.00^^33^433^5
 ;;^UTILITY(U,$J,358.3,8258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8258,1,3,0)
 ;;=3^Eyes/Vision Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,8258,1,4,0)
 ;;=4^Z01.00
 ;;^UTILITY(U,$J,358.3,8258,2)
 ;;=^5062612
 ;;^UTILITY(U,$J,358.3,8259,0)
 ;;=Z01.01^^33^433^4
 ;;^UTILITY(U,$J,358.3,8259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8259,1,3,0)
 ;;=3^Eyes/Vision Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,8259,1,4,0)
 ;;=4^Z01.01
 ;;^UTILITY(U,$J,358.3,8259,2)
 ;;=^5062613
 ;;^UTILITY(U,$J,358.3,8260,0)
 ;;=Z11.1^^33^433^11
 ;;^UTILITY(U,$J,358.3,8260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8260,1,3,0)
 ;;=3^Respiratory Tuberculosis Screen
 ;;^UTILITY(U,$J,358.3,8260,1,4,0)
 ;;=4^Z11.1
 ;;^UTILITY(U,$J,358.3,8260,2)
 ;;=^5062670
 ;;^UTILITY(U,$J,358.3,8261,0)
 ;;=Z09.^^33^434^1
 ;;^UTILITY(U,$J,358.3,8261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8261,1,3,0)
 ;;=3^F/U Exam after Trtmt for Conditions Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,8261,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,8261,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,8262,0)
 ;;=Z08.^^33^434^2
 ;;^UTILITY(U,$J,358.3,8262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8262,1,3,0)
 ;;=3^F/U Exam after Trtmt for Malig Neop
 ;;^UTILITY(U,$J,358.3,8262,1,4,0)
 ;;=4^Z08.
 ;;^UTILITY(U,$J,358.3,8262,2)
 ;;=^5062667
 ;;^UTILITY(U,$J,358.3,8263,0)
 ;;=Z23.^^33^435^1
 ;;^UTILITY(U,$J,358.3,8263,1,0)
 ;;=^358.31IA^4^2
