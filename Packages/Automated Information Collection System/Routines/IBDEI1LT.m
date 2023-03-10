IBDEI1LT ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25986,1,3,0)
 ;;=3^Underdosing of Antidepressants,Subs Encntr
 ;;^UTILITY(U,$J,358.3,25986,1,4,0)
 ;;=4^T43.206D
 ;;^UTILITY(U,$J,358.3,25986,2)
 ;;=^5050544
 ;;^UTILITY(U,$J,358.3,25987,0)
 ;;=T43.506A^^92^1189^12
 ;;^UTILITY(U,$J,358.3,25987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25987,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Init Encntr
 ;;^UTILITY(U,$J,358.3,25987,1,4,0)
 ;;=4^T43.506A
 ;;^UTILITY(U,$J,358.3,25987,2)
 ;;=^5050651
 ;;^UTILITY(U,$J,358.3,25988,0)
 ;;=T43.506S^^92^1189^13
 ;;^UTILITY(U,$J,358.3,25988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25988,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Sequela
 ;;^UTILITY(U,$J,358.3,25988,1,4,0)
 ;;=4^T43.506S
 ;;^UTILITY(U,$J,358.3,25988,2)
 ;;=^5050653
 ;;^UTILITY(U,$J,358.3,25989,0)
 ;;=T43.506D^^92^1189^14
 ;;^UTILITY(U,$J,358.3,25989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25989,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Subs Encntr
 ;;^UTILITY(U,$J,358.3,25989,1,4,0)
 ;;=4^T43.506D
 ;;^UTILITY(U,$J,358.3,25989,2)
 ;;=^5050652
 ;;^UTILITY(U,$J,358.3,25990,0)
 ;;=Z56.0^^92^1190^10
 ;;^UTILITY(U,$J,358.3,25990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25990,1,3,0)
 ;;=3^Unemployment,Unspecified
 ;;^UTILITY(U,$J,358.3,25990,1,4,0)
 ;;=4^Z56.0
 ;;^UTILITY(U,$J,358.3,25990,2)
 ;;=^5063107
 ;;^UTILITY(U,$J,358.3,25991,0)
 ;;=Z56.1^^92^1190^1
 ;;^UTILITY(U,$J,358.3,25991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25991,1,3,0)
 ;;=3^Change of Job
 ;;^UTILITY(U,$J,358.3,25991,1,4,0)
 ;;=4^Z56.1
 ;;^UTILITY(U,$J,358.3,25991,2)
 ;;=^5063108
 ;;^UTILITY(U,$J,358.3,25992,0)
 ;;=Z56.2^^92^1190^8
 ;;^UTILITY(U,$J,358.3,25992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25992,1,3,0)
 ;;=3^Threat of Job Loss
 ;;^UTILITY(U,$J,358.3,25992,1,4,0)
 ;;=4^Z56.2
 ;;^UTILITY(U,$J,358.3,25992,2)
 ;;=^5063109
 ;;^UTILITY(U,$J,358.3,25993,0)
 ;;=Z56.3^^92^1190^7
 ;;^UTILITY(U,$J,358.3,25993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25993,1,3,0)
 ;;=3^Stressful Work Schedule
 ;;^UTILITY(U,$J,358.3,25993,1,4,0)
 ;;=4^Z56.3
 ;;^UTILITY(U,$J,358.3,25993,2)
 ;;=^5063110
 ;;^UTILITY(U,$J,358.3,25994,0)
 ;;=Z56.4^^92^1190^2
 ;;^UTILITY(U,$J,358.3,25994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25994,1,3,0)
 ;;=3^Discord w/ Boss and Workmates
 ;;^UTILITY(U,$J,358.3,25994,1,4,0)
 ;;=4^Z56.4
 ;;^UTILITY(U,$J,358.3,25994,2)
 ;;=^5063111
 ;;^UTILITY(U,$J,358.3,25995,0)
 ;;=Z56.5^^92^1190^9
 ;;^UTILITY(U,$J,358.3,25995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25995,1,3,0)
 ;;=3^Uncongenial Work Environment
 ;;^UTILITY(U,$J,358.3,25995,1,4,0)
 ;;=4^Z56.5
 ;;^UTILITY(U,$J,358.3,25995,2)
 ;;=^5063112
 ;;^UTILITY(U,$J,358.3,25996,0)
 ;;=Z56.6^^92^1190^5
 ;;^UTILITY(U,$J,358.3,25996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25996,1,3,0)
 ;;=3^Physical & Mental Strain Related to Work,Other
 ;;^UTILITY(U,$J,358.3,25996,1,4,0)
 ;;=4^Z56.6
 ;;^UTILITY(U,$J,358.3,25996,2)
 ;;=^5063113
 ;;^UTILITY(U,$J,358.3,25997,0)
 ;;=Z56.81^^92^1190^6
 ;;^UTILITY(U,$J,358.3,25997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25997,1,3,0)
 ;;=3^Sexual Harassment on the Job
 ;;^UTILITY(U,$J,358.3,25997,1,4,0)
 ;;=4^Z56.81
 ;;^UTILITY(U,$J,358.3,25997,2)
 ;;=^5063114
 ;;^UTILITY(U,$J,358.3,25998,0)
 ;;=Z56.82^^92^1190^3
 ;;^UTILITY(U,$J,358.3,25998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25998,1,3,0)
 ;;=3^Military Deployment Status
