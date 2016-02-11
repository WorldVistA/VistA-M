IBDEI07A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2832,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2832,1,1,0)
 ;;=1^E&M Annual NF Assessment
 ;;^UTILITY(U,$J,358.3,2832,1,2,0)
 ;;=2^99318
 ;;^UTILITY(U,$J,358.3,2833,0)
 ;;=99495^^26^237^2
 ;;^UTILITY(U,$J,358.3,2833,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2833,1,1,0)
 ;;=1^Trans Care,FTF w/in 14D of D/C
 ;;^UTILITY(U,$J,358.3,2833,1,2,0)
 ;;=2^99495
 ;;^UTILITY(U,$J,358.3,2834,0)
 ;;=99496^^26^237^1
 ;;^UTILITY(U,$J,358.3,2834,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2834,1,1,0)
 ;;=1^Trans Care,FTF w/in 7D of D/C
 ;;^UTILITY(U,$J,358.3,2834,1,2,0)
 ;;=2^99496
 ;;^UTILITY(U,$J,358.3,2835,0)
 ;;=94004^^27^238^1^^^^1
 ;;^UTILITY(U,$J,358.3,2835,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2835,1,2,0)
 ;;=2^Inpt Vent Mgmt NF per Day
 ;;^UTILITY(U,$J,358.3,2835,1,3,0)
 ;;=3^94004
 ;;^UTILITY(U,$J,358.3,2836,0)
 ;;=S0250^^27^239^1^^^^1
 ;;^UTILITY(U,$J,358.3,2836,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2836,1,2,0)
 ;;=2^Comp Geriatric Assess/Treat
 ;;^UTILITY(U,$J,358.3,2836,1,3,0)
 ;;=3^S0250
 ;;^UTILITY(U,$J,358.3,2837,0)
 ;;=99356^^27^240^1^^^^1
 ;;^UTILITY(U,$J,358.3,2837,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2837,1,2,0)
 ;;=2^Prolonged Svc,Inpt,1st Hr
 ;;^UTILITY(U,$J,358.3,2837,1,3,0)
 ;;=3^99356
 ;;^UTILITY(U,$J,358.3,2838,0)
 ;;=99357^^27^240^2^^^^1
 ;;^UTILITY(U,$J,358.3,2838,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2838,1,2,0)
 ;;=2^Prolonged Svc,Inpt,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,2838,1,3,0)
 ;;=3^99357
 ;;^UTILITY(U,$J,358.3,2839,0)
 ;;=99366^^27^241^5^^^^1
 ;;^UTILITY(U,$J,358.3,2839,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2839,1,2,0)
 ;;=2^Team Conf w/ Pat by HC Prof 30 Min
 ;;^UTILITY(U,$J,358.3,2839,1,3,0)
 ;;=3^99366
 ;;^UTILITY(U,$J,358.3,2840,0)
 ;;=99367^^27^241^6^^^^1
 ;;^UTILITY(U,$J,358.3,2840,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2840,1,2,0)
 ;;=2^Team Conf w/o Pat by Phys 30 Min
 ;;^UTILITY(U,$J,358.3,2840,1,3,0)
 ;;=3^99367
 ;;^UTILITY(U,$J,358.3,2841,0)
 ;;=99368^^27^241^7^^^^1
 ;;^UTILITY(U,$J,358.3,2841,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2841,1,2,0)
 ;;=2^Team Conf w/o Pat by HC Prof 30 Min
 ;;^UTILITY(U,$J,358.3,2841,1,3,0)
 ;;=3^99368
 ;;^UTILITY(U,$J,358.3,2842,0)
 ;;=99497^^27^242^1^^^^1
 ;;^UTILITY(U,$J,358.3,2842,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2842,1,2,0)
 ;;=2^Advance Care Planning;First 30 min
 ;;^UTILITY(U,$J,358.3,2842,1,3,0)
 ;;=3^99497
 ;;^UTILITY(U,$J,358.3,2843,0)
 ;;=99498^^27^242^2^^^^1
 ;;^UTILITY(U,$J,358.3,2843,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2843,1,2,0)
 ;;=2^Advance Care Planning;Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,2843,1,3,0)
 ;;=3^99498
 ;;^UTILITY(U,$J,358.3,2844,0)
 ;;=G30.9^^28^243^4
 ;;^UTILITY(U,$J,358.3,2844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2844,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2844,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,2844,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,2845,0)
 ;;=G30.0^^28^243^2
 ;;^UTILITY(U,$J,358.3,2845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2845,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,2845,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,2845,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,2846,0)
 ;;=G30.1^^28^243^3
 ;;^UTILITY(U,$J,358.3,2846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2846,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,2846,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,2846,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,2847,0)
 ;;=F05.^^28^243^16
 ;;^UTILITY(U,$J,358.3,2847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2847,1,3,0)
 ;;=3^Delirium d/t Physiological Condition
