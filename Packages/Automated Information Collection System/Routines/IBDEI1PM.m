IBDEI1PM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28609,1,4,0)
 ;;=4^S56.512A
 ;;^UTILITY(U,$J,358.3,28609,2)
 ;;=^5031841
 ;;^UTILITY(U,$J,358.3,28610,0)
 ;;=S13.8XXA^^132^1333^10
 ;;^UTILITY(U,$J,358.3,28610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28610,1,3,0)
 ;;=3^Sprain of Neck Joints/Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,28610,1,4,0)
 ;;=4^S13.8XXA
 ;;^UTILITY(U,$J,358.3,28610,2)
 ;;=^5022034
 ;;^UTILITY(U,$J,358.3,28611,0)
 ;;=S16.1XXA^^132^1333^37
 ;;^UTILITY(U,$J,358.3,28611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28611,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Init Encntr
 ;;^UTILITY(U,$J,358.3,28611,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,28611,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,28612,0)
 ;;=S33.5XXA^^132^1333^8
 ;;^UTILITY(U,$J,358.3,28612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28612,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,28612,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,28612,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,28613,0)
 ;;=F10.20^^132^1334^4
 ;;^UTILITY(U,$J,358.3,28613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28613,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,28613,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,28613,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,28614,0)
 ;;=F11.29^^132^1334^46
 ;;^UTILITY(U,$J,358.3,28614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28614,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,28614,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,28614,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,28615,0)
 ;;=F11.288^^132^1334^45
 ;;^UTILITY(U,$J,358.3,28615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28615,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,28615,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,28615,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,28616,0)
 ;;=F11.282^^132^1334^44
 ;;^UTILITY(U,$J,358.3,28616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28616,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,28616,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,28616,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,28617,0)
 ;;=F11.281^^132^1334^43
 ;;^UTILITY(U,$J,358.3,28617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28617,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sexual Dysfunction
 ;;^UTILITY(U,$J,358.3,28617,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,28617,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,28618,0)
 ;;=F11.259^^132^1334^42
 ;;^UTILITY(U,$J,358.3,28618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28618,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,28618,1,4,0)
 ;;=4^F11.259
 ;;^UTILITY(U,$J,358.3,28618,2)
 ;;=^5003137
 ;;^UTILITY(U,$J,358.3,28619,0)
 ;;=F11.251^^132^1334^35
 ;;^UTILITY(U,$J,358.3,28619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28619,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Hallucin
 ;;^UTILITY(U,$J,358.3,28619,1,4,0)
 ;;=4^F11.251
 ;;^UTILITY(U,$J,358.3,28619,2)
 ;;=^5003136
 ;;^UTILITY(U,$J,358.3,28620,0)
 ;;=F11.250^^132^1334^36
 ;;^UTILITY(U,$J,358.3,28620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28620,1,3,0)
 ;;=3^Opioid Depend w/ Opioid-Induc Psychotic Disorder w/ Delusions
 ;;^UTILITY(U,$J,358.3,28620,1,4,0)
 ;;=4^F11.250
 ;;^UTILITY(U,$J,358.3,28620,2)
 ;;=^5003135
 ;;^UTILITY(U,$J,358.3,28621,0)
 ;;=F11.24^^132^1334^41
 ;;^UTILITY(U,$J,358.3,28621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28621,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Mood Disorder
