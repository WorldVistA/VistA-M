IBDEI1DJ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23354,1,3,0)
 ;;=3^Sprain of Right Knee Collateral Ligament
 ;;^UTILITY(U,$J,358.3,23354,1,4,0)
 ;;=4^S83.401A
 ;;^UTILITY(U,$J,358.3,23354,2)
 ;;=^5043103
 ;;^UTILITY(U,$J,358.3,23355,0)
 ;;=S83.402A^^87^994^4
 ;;^UTILITY(U,$J,358.3,23355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23355,1,3,0)
 ;;=3^Sprain of Left Knee Collateral Ligament
 ;;^UTILITY(U,$J,358.3,23355,1,4,0)
 ;;=4^S83.402A
 ;;^UTILITY(U,$J,358.3,23355,2)
 ;;=^5043106
 ;;^UTILITY(U,$J,358.3,23356,0)
 ;;=S93.402A^^87^994^2
 ;;^UTILITY(U,$J,358.3,23356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23356,1,3,0)
 ;;=3^Sprain of Left Ankle Ligament
 ;;^UTILITY(U,$J,358.3,23356,1,4,0)
 ;;=4^S93.402A
 ;;^UTILITY(U,$J,358.3,23356,2)
 ;;=^5045777
 ;;^UTILITY(U,$J,358.3,23357,0)
 ;;=S93.401A^^87^994^13
 ;;^UTILITY(U,$J,358.3,23357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23357,1,3,0)
 ;;=3^Sprain of Right Ankle Ligament
 ;;^UTILITY(U,$J,358.3,23357,1,4,0)
 ;;=4^S93.401A
 ;;^UTILITY(U,$J,358.3,23357,2)
 ;;=^5045774
 ;;^UTILITY(U,$J,358.3,23358,0)
 ;;=S56.511A^^87^994^39
 ;;^UTILITY(U,$J,358.3,23358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23358,1,3,0)
 ;;=3^Strain of Right Forearm Extn Musc/Fasc/Tend
 ;;^UTILITY(U,$J,358.3,23358,1,4,0)
 ;;=4^S56.511A
 ;;^UTILITY(U,$J,358.3,23358,2)
 ;;=^5031838
 ;;^UTILITY(U,$J,358.3,23359,0)
 ;;=S56.512A^^87^994^19
 ;;^UTILITY(U,$J,358.3,23359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23359,1,3,0)
 ;;=3^Strain of Left Forearm Extn Musc/Fasc/Tend
 ;;^UTILITY(U,$J,358.3,23359,1,4,0)
 ;;=4^S56.512A
 ;;^UTILITY(U,$J,358.3,23359,2)
 ;;=^5031841
 ;;^UTILITY(U,$J,358.3,23360,0)
 ;;=S13.8XXA^^87^994^10
 ;;^UTILITY(U,$J,358.3,23360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23360,1,3,0)
 ;;=3^Sprain of Neck Joints/Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,23360,1,4,0)
 ;;=4^S13.8XXA
 ;;^UTILITY(U,$J,358.3,23360,2)
 ;;=^5022034
 ;;^UTILITY(U,$J,358.3,23361,0)
 ;;=S16.1XXA^^87^994^37
 ;;^UTILITY(U,$J,358.3,23361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23361,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Init Encntr
 ;;^UTILITY(U,$J,358.3,23361,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,23361,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,23362,0)
 ;;=S33.5XXA^^87^994^8
 ;;^UTILITY(U,$J,358.3,23362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23362,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,23362,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,23362,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,23363,0)
 ;;=F10.20^^87^995^4
 ;;^UTILITY(U,$J,358.3,23363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23363,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23363,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,23363,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,23364,0)
 ;;=F11.29^^87^995^46
 ;;^UTILITY(U,$J,358.3,23364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23364,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,23364,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,23364,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,23365,0)
 ;;=F11.288^^87^995^45
 ;;^UTILITY(U,$J,358.3,23365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23365,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,23365,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,23365,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,23366,0)
 ;;=F11.282^^87^995^44
 ;;^UTILITY(U,$J,358.3,23366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23366,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
