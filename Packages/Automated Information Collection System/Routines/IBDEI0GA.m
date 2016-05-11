IBDEI0GA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7528,1,4,0)
 ;;=4^S83.402A
 ;;^UTILITY(U,$J,358.3,7528,2)
 ;;=^5043106
 ;;^UTILITY(U,$J,358.3,7529,0)
 ;;=S93.402A^^30^409^3
 ;;^UTILITY(U,$J,358.3,7529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7529,1,3,0)
 ;;=3^Sprain of Left Ankle Ligament
 ;;^UTILITY(U,$J,358.3,7529,1,4,0)
 ;;=4^S93.402A
 ;;^UTILITY(U,$J,358.3,7529,2)
 ;;=^5045777
 ;;^UTILITY(U,$J,358.3,7530,0)
 ;;=S93.401A^^30^409^12
 ;;^UTILITY(U,$J,358.3,7530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7530,1,3,0)
 ;;=3^Sprain of Right Ankle Ligament
 ;;^UTILITY(U,$J,358.3,7530,1,4,0)
 ;;=4^S93.401A
 ;;^UTILITY(U,$J,358.3,7530,2)
 ;;=^5045774
 ;;^UTILITY(U,$J,358.3,7531,0)
 ;;=S56.511A^^30^409^37
 ;;^UTILITY(U,$J,358.3,7531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7531,1,3,0)
 ;;=3^Strain of Right Forearm Extn Musc/Fasc/Tend
 ;;^UTILITY(U,$J,358.3,7531,1,4,0)
 ;;=4^S56.511A
 ;;^UTILITY(U,$J,358.3,7531,2)
 ;;=^5031838
 ;;^UTILITY(U,$J,358.3,7532,0)
 ;;=S56.512A^^30^409^18
 ;;^UTILITY(U,$J,358.3,7532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7532,1,3,0)
 ;;=3^Strain of Left Forearm Extn Musc/Fasc/Tend
 ;;^UTILITY(U,$J,358.3,7532,1,4,0)
 ;;=4^S56.512A
 ;;^UTILITY(U,$J,358.3,7532,2)
 ;;=^5031841
 ;;^UTILITY(U,$J,358.3,7533,0)
 ;;=S13.8XXA^^30^409^10
 ;;^UTILITY(U,$J,358.3,7533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7533,1,3,0)
 ;;=3^Sprain of Neck Joints/Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,7533,1,4,0)
 ;;=4^S13.8XXA
 ;;^UTILITY(U,$J,358.3,7533,2)
 ;;=^5022034
 ;;^UTILITY(U,$J,358.3,7534,0)
 ;;=S16.1XXA^^30^409^36
 ;;^UTILITY(U,$J,358.3,7534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7534,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Init Encntr
 ;;^UTILITY(U,$J,358.3,7534,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,7534,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,7535,0)
 ;;=S33.5XXA^^30^409^9
 ;;^UTILITY(U,$J,358.3,7535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7535,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,7535,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,7535,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,7536,0)
 ;;=S13.4XXA^^30^409^1
 ;;^UTILITY(U,$J,358.3,7536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7536,1,3,0)
 ;;=3^Sprain of Cervical Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,7536,1,4,0)
 ;;=4^S13.4XXA
 ;;^UTILITY(U,$J,358.3,7536,2)
 ;;=^5022028
 ;;^UTILITY(U,$J,358.3,7537,0)
 ;;=F10.20^^30^410^4
 ;;^UTILITY(U,$J,358.3,7537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7537,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7537,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,7537,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,7538,0)
 ;;=F11.29^^30^410^46
 ;;^UTILITY(U,$J,358.3,7538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7538,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,7538,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,7538,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,7539,0)
 ;;=F11.288^^30^410^45
 ;;^UTILITY(U,$J,358.3,7539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7539,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,7539,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,7539,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,7540,0)
 ;;=F11.282^^30^410^44
 ;;^UTILITY(U,$J,358.3,7540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7540,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,7540,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,7540,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,7541,0)
 ;;=F11.281^^30^410^43
 ;;^UTILITY(U,$J,358.3,7541,1,0)
 ;;=^358.31IA^4^2
