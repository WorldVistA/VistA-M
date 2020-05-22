IBDEI2JP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40639,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Init Encntr
 ;;^UTILITY(U,$J,358.3,40639,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,40639,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,40640,0)
 ;;=S33.5XXA^^152^2013^8
 ;;^UTILITY(U,$J,358.3,40640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40640,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,40640,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,40640,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,40641,0)
 ;;=F10.20^^152^2014^5
 ;;^UTILITY(U,$J,358.3,40641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40641,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,40641,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,40641,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,40642,0)
 ;;=F11.29^^152^2014^50
 ;;^UTILITY(U,$J,358.3,40642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40642,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,40642,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,40642,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,40643,0)
 ;;=F11.288^^152^2014^49
 ;;^UTILITY(U,$J,358.3,40643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40643,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,40643,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,40643,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,40644,0)
 ;;=F11.282^^152^2014^48
 ;;^UTILITY(U,$J,358.3,40644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40644,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,40644,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,40644,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,40645,0)
 ;;=F11.281^^152^2014^47
 ;;^UTILITY(U,$J,358.3,40645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40645,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,40645,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,40645,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,40646,0)
 ;;=F11.259^^152^2014^46
 ;;^UTILITY(U,$J,358.3,40646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40646,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40646,1,4,0)
 ;;=4^F11.259
 ;;^UTILITY(U,$J,358.3,40646,2)
 ;;=^5003137
 ;;^UTILITY(U,$J,358.3,40647,0)
 ;;=F11.251^^152^2014^39
 ;;^UTILITY(U,$J,358.3,40647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40647,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,40647,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,40647,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,40648,0)
 ;;=F11.250^^152^2014^40
 ;;^UTILITY(U,$J,358.3,40648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40648,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,40648,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,40648,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,40649,0)
 ;;=F11.24^^152^2014^45
 ;;^UTILITY(U,$J,358.3,40649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40649,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,40649,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,40649,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,40650,0)
 ;;=F11.23^^152^2014^51
 ;;^UTILITY(U,$J,358.3,40650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40650,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,40650,1,4,0)
 ;;=4^F11.23
