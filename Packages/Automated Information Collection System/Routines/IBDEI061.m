IBDEI061 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2295,1,3,0)
 ;;=3^Pain in Joint,Unspec
 ;;^UTILITY(U,$J,358.3,2295,1,4,0)
 ;;=4^M25.50
 ;;^UTILITY(U,$J,358.3,2295,2)
 ;;=^5011601
 ;;^UTILITY(U,$J,358.3,2296,0)
 ;;=Z02.71^^4^64^3
 ;;^UTILITY(U,$J,358.3,2296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2296,1,3,0)
 ;;=3^Disability determination
 ;;^UTILITY(U,$J,358.3,2296,1,4,0)
 ;;=4^Z02.71
 ;;^UTILITY(U,$J,358.3,2296,2)
 ;;=^5062640
 ;;^UTILITY(U,$J,358.3,2297,0)
 ;;=Z02.79^^4^64^7
 ;;^UTILITY(U,$J,358.3,2297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2297,1,3,0)
 ;;=3^Medical Certificate Issues NEC
 ;;^UTILITY(U,$J,358.3,2297,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,2297,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,2298,0)
 ;;=Z00.00^^4^64^6
 ;;^UTILITY(U,$J,358.3,2298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2298,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,2298,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,2298,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,2299,0)
 ;;=Z02.83^^4^64^2
 ;;^UTILITY(U,$J,358.3,2299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2299,1,3,0)
 ;;=3^Blood-alcohol and blood-drug test
 ;;^UTILITY(U,$J,358.3,2299,1,4,0)
 ;;=4^Z02.83
 ;;^UTILITY(U,$J,358.3,2299,2)
 ;;=^5062644
 ;;^UTILITY(U,$J,358.3,2300,0)
 ;;=Z02.81^^4^64^8
 ;;^UTILITY(U,$J,358.3,2300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2300,1,3,0)
 ;;=3^Paternity Testing
 ;;^UTILITY(U,$J,358.3,2300,1,4,0)
 ;;=4^Z02.81
 ;;^UTILITY(U,$J,358.3,2300,2)
 ;;=^5062642
 ;;^UTILITY(U,$J,358.3,2301,0)
 ;;=Z02.3^^4^64^10
 ;;^UTILITY(U,$J,358.3,2301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2301,1,3,0)
 ;;=3^Recruitment to Armed Forces Exam
 ;;^UTILITY(U,$J,358.3,2301,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,2301,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,2302,0)
 ;;=Z02.1^^4^64^9
 ;;^UTILITY(U,$J,358.3,2302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2302,1,3,0)
 ;;=3^Pre-Employment Exam
 ;;^UTILITY(U,$J,358.3,2302,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,2302,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,2303,0)
 ;;=Z02.89^^4^64^1
 ;;^UTILITY(U,$J,358.3,2303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2303,1,3,0)
 ;;=3^Administrative Exam NEC
 ;;^UTILITY(U,$J,358.3,2303,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,2303,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,2304,0)
 ;;=Z01.00^^4^64^5
 ;;^UTILITY(U,$J,358.3,2304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2304,1,3,0)
 ;;=3^Eyes/Vision Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,2304,1,4,0)
 ;;=4^Z01.00
 ;;^UTILITY(U,$J,358.3,2304,2)
 ;;=^5062612
 ;;^UTILITY(U,$J,358.3,2305,0)
 ;;=Z01.01^^4^64^4
 ;;^UTILITY(U,$J,358.3,2305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2305,1,3,0)
 ;;=3^Eyes/Vision Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,2305,1,4,0)
 ;;=4^Z01.01
 ;;^UTILITY(U,$J,358.3,2305,2)
 ;;=^5062613
 ;;^UTILITY(U,$J,358.3,2306,0)
 ;;=Z11.1^^4^64^11
 ;;^UTILITY(U,$J,358.3,2306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2306,1,3,0)
 ;;=3^Respiratory Tuberculosis Screen
 ;;^UTILITY(U,$J,358.3,2306,1,4,0)
 ;;=4^Z11.1
 ;;^UTILITY(U,$J,358.3,2306,2)
 ;;=^5062670
 ;;^UTILITY(U,$J,358.3,2307,0)
 ;;=Z09.^^4^65^1
 ;;^UTILITY(U,$J,358.3,2307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2307,1,3,0)
 ;;=3^F/U Exam after Trtmt for Conditions Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,2307,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,2307,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,2308,0)
 ;;=Z08.^^4^65^2
 ;;^UTILITY(U,$J,358.3,2308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2308,1,3,0)
 ;;=3^F/U Exam after Trtmt for Malig Neop
