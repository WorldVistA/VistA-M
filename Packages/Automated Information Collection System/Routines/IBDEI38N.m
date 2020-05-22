IBDEI38N ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51699,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Init Encntr
 ;;^UTILITY(U,$J,358.3,51699,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,51699,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,51700,0)
 ;;=S33.5XXA^^193^2510^8
 ;;^UTILITY(U,$J,358.3,51700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51700,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,51700,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,51700,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,51701,0)
 ;;=F10.20^^193^2511^5
 ;;^UTILITY(U,$J,358.3,51701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51701,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,51701,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,51701,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,51702,0)
 ;;=F11.29^^193^2511^50
 ;;^UTILITY(U,$J,358.3,51702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51702,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,51702,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,51702,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,51703,0)
 ;;=F11.288^^193^2511^49
 ;;^UTILITY(U,$J,358.3,51703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51703,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,51703,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,51703,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,51704,0)
 ;;=F11.282^^193^2511^48
 ;;^UTILITY(U,$J,358.3,51704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51704,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,51704,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,51704,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,51705,0)
 ;;=F11.281^^193^2511^47
 ;;^UTILITY(U,$J,358.3,51705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51705,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,51705,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,51705,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,51706,0)
 ;;=F11.259^^193^2511^46
 ;;^UTILITY(U,$J,358.3,51706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51706,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,51706,1,4,0)
 ;;=4^F11.259
 ;;^UTILITY(U,$J,358.3,51706,2)
 ;;=^5003137
 ;;^UTILITY(U,$J,358.3,51707,0)
 ;;=F11.251^^193^2511^39
 ;;^UTILITY(U,$J,358.3,51707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51707,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,51707,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,51707,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,51708,0)
 ;;=F11.250^^193^2511^40
 ;;^UTILITY(U,$J,358.3,51708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51708,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,51708,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,51708,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,51709,0)
 ;;=F11.24^^193^2511^45
 ;;^UTILITY(U,$J,358.3,51709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51709,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,51709,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,51709,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,51710,0)
 ;;=F11.23^^193^2511^51
 ;;^UTILITY(U,$J,358.3,51710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51710,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,51710,1,4,0)
 ;;=4^F11.23
