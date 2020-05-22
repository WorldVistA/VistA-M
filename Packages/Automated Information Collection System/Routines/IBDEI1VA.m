IBDEI1VA ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29825,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29825,1,2,0)
 ;;=2^99354
 ;;^UTILITY(U,$J,358.3,29825,1,3,0)
 ;;=3^Prolonged Svcs,Outpt,1st Hr
 ;;^UTILITY(U,$J,358.3,29826,0)
 ;;=99355^^119^1512^2^^^^1
 ;;^UTILITY(U,$J,358.3,29826,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29826,1,2,0)
 ;;=2^99355
 ;;^UTILITY(U,$J,358.3,29826,1,3,0)
 ;;=3^Prolonged Svcs,Outpt,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,29827,0)
 ;;=99356^^119^1512^3^^^^1
 ;;^UTILITY(U,$J,358.3,29827,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29827,1,2,0)
 ;;=2^99356
 ;;^UTILITY(U,$J,358.3,29827,1,3,0)
 ;;=3^Prolonged Svcs,Inpt/OBS,1st Hr
 ;;^UTILITY(U,$J,358.3,29828,0)
 ;;=99357^^119^1512^4^^^^1
 ;;^UTILITY(U,$J,358.3,29828,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29828,1,2,0)
 ;;=2^99357
 ;;^UTILITY(U,$J,358.3,29828,1,3,0)
 ;;=3^Prolonged Svcs,Inpt/OBS,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,29829,0)
 ;;=99406^^119^1513^2^^^^1
 ;;^UTILITY(U,$J,358.3,29829,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29829,1,2,0)
 ;;=2^99406
 ;;^UTILITY(U,$J,358.3,29829,1,3,0)
 ;;=3^Tob Use & Smoking Cess Intermed Counsel,3-10mins
 ;;^UTILITY(U,$J,358.3,29830,0)
 ;;=99407^^119^1513^3^^^^1
 ;;^UTILITY(U,$J,358.3,29830,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29830,1,2,0)
 ;;=2^99407
 ;;^UTILITY(U,$J,358.3,29830,1,3,0)
 ;;=3^Tob Use & Smoking Cess Intensive Counsel > 10mins
 ;;^UTILITY(U,$J,358.3,29831,0)
 ;;=S9453^^119^1513^1^^^^1
 ;;^UTILITY(U,$J,358.3,29831,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29831,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,29831,1,3,0)
 ;;=3^Smoking Cessation Class,Non-Phys,per session
 ;;^UTILITY(U,$J,358.3,29832,0)
 ;;=96116^^119^1514^1^^^^1
 ;;^UTILITY(U,$J,358.3,29832,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29832,1,2,0)
 ;;=2^96116
 ;;^UTILITY(U,$J,358.3,29832,1,3,0)
 ;;=3^Neurobehav Status Exam,F2F w/ Pt,Int&Prep,per hr
 ;;^UTILITY(U,$J,358.3,29833,0)
 ;;=96130^^119^1514^4^^^^1
 ;;^UTILITY(U,$J,358.3,29833,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29833,1,2,0)
 ;;=2^96130
 ;;^UTILITY(U,$J,358.3,29833,1,3,0)
 ;;=3^Psych Test Eval,1st Hr
 ;;^UTILITY(U,$J,358.3,29834,0)
 ;;=96131^^119^1514^5^^^^1
 ;;^UTILITY(U,$J,358.3,29834,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29834,1,2,0)
 ;;=2^96131
 ;;^UTILITY(U,$J,358.3,29834,1,3,0)
 ;;=3^Psych Test Eval,Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,29835,0)
 ;;=96132^^119^1514^2^^^^1
 ;;^UTILITY(U,$J,358.3,29835,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29835,1,2,0)
 ;;=2^96132
 ;;^UTILITY(U,$J,358.3,29835,1,3,0)
 ;;=3^Neuropsych Test Eval,1st hr
 ;;^UTILITY(U,$J,358.3,29836,0)
 ;;=96133^^119^1514^3^^^^1
 ;;^UTILITY(U,$J,358.3,29836,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29836,1,2,0)
 ;;=2^96133
 ;;^UTILITY(U,$J,358.3,29836,1,3,0)
 ;;=3^Neuropsych Test Eval,Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,29837,0)
 ;;=96136^^119^1514^6^^^^1
 ;;^UTILITY(U,$J,358.3,29837,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29837,1,2,0)
 ;;=2^96136
 ;;^UTILITY(U,$J,358.3,29837,1,3,0)
 ;;=3^Psych/Neuropsych,2+ Tests,Prov,1st 30 min
 ;;^UTILITY(U,$J,358.3,29838,0)
 ;;=96137^^119^1514^7^^^^1
 ;;^UTILITY(U,$J,358.3,29838,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29838,1,2,0)
 ;;=2^96137
 ;;^UTILITY(U,$J,358.3,29838,1,3,0)
 ;;=3^Psych/Neuropsych,2+ Tests,Prov,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,29839,0)
 ;;=96138^^119^1514^8^^^^1
 ;;^UTILITY(U,$J,358.3,29839,1,0)
 ;;=^358.31IA^3^2
