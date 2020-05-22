IBDEI1M8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25815,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,25815,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,25815,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,25816,0)
 ;;=F10.20^^107^1225^5
 ;;^UTILITY(U,$J,358.3,25816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25816,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25816,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,25816,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,25817,0)
 ;;=F11.29^^107^1225^50
 ;;^UTILITY(U,$J,358.3,25817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25817,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,25817,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,25817,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,25818,0)
 ;;=F11.288^^107^1225^49
 ;;^UTILITY(U,$J,358.3,25818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25818,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,25818,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,25818,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,25819,0)
 ;;=F11.282^^107^1225^48
 ;;^UTILITY(U,$J,358.3,25819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25819,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,25819,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,25819,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,25820,0)
 ;;=F11.281^^107^1225^47
 ;;^UTILITY(U,$J,358.3,25820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25820,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,25820,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,25820,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,25821,0)
 ;;=F11.259^^107^1225^46
 ;;^UTILITY(U,$J,358.3,25821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25821,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25821,1,4,0)
 ;;=4^F11.259
 ;;^UTILITY(U,$J,358.3,25821,2)
 ;;=^5003137
 ;;^UTILITY(U,$J,358.3,25822,0)
 ;;=F11.251^^107^1225^39
 ;;^UTILITY(U,$J,358.3,25822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25822,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,25822,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,25822,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,25823,0)
 ;;=F11.250^^107^1225^40
 ;;^UTILITY(U,$J,358.3,25823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25823,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,25823,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,25823,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,25824,0)
 ;;=F11.24^^107^1225^45
 ;;^UTILITY(U,$J,358.3,25824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25824,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,25824,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,25824,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,25825,0)
 ;;=F11.23^^107^1225^51
 ;;^UTILITY(U,$J,358.3,25825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25825,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,25825,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,25825,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,25826,0)
 ;;=F11.20^^107^1225^52
 ;;^UTILITY(U,$J,358.3,25826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25826,1,3,0)
 ;;=3^Opioid Dependence,Uncomplicated
