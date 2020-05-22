IBDEI13A ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17506,1,3,0)
 ;;=3^Sprain of Left Knee Collateral Ligament
 ;;^UTILITY(U,$J,358.3,17506,1,4,0)
 ;;=4^S83.402A
 ;;^UTILITY(U,$J,358.3,17506,2)
 ;;=^5043106
 ;;^UTILITY(U,$J,358.3,17507,0)
 ;;=S93.402A^^88^892^2
 ;;^UTILITY(U,$J,358.3,17507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17507,1,3,0)
 ;;=3^Sprain of Left Ankle Ligament
 ;;^UTILITY(U,$J,358.3,17507,1,4,0)
 ;;=4^S93.402A
 ;;^UTILITY(U,$J,358.3,17507,2)
 ;;=^5045777
 ;;^UTILITY(U,$J,358.3,17508,0)
 ;;=S93.401A^^88^892^13
 ;;^UTILITY(U,$J,358.3,17508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17508,1,3,0)
 ;;=3^Sprain of Right Ankle Ligament
 ;;^UTILITY(U,$J,358.3,17508,1,4,0)
 ;;=4^S93.401A
 ;;^UTILITY(U,$J,358.3,17508,2)
 ;;=^5045774
 ;;^UTILITY(U,$J,358.3,17509,0)
 ;;=S56.511A^^88^892^39
 ;;^UTILITY(U,$J,358.3,17509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17509,1,3,0)
 ;;=3^Strain of Right Forearm Extn Musc/Fasc/Tend
 ;;^UTILITY(U,$J,358.3,17509,1,4,0)
 ;;=4^S56.511A
 ;;^UTILITY(U,$J,358.3,17509,2)
 ;;=^5031838
 ;;^UTILITY(U,$J,358.3,17510,0)
 ;;=S56.512A^^88^892^19
 ;;^UTILITY(U,$J,358.3,17510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17510,1,3,0)
 ;;=3^Strain of Left Forearm Extn Musc/Fasc/Tend
 ;;^UTILITY(U,$J,358.3,17510,1,4,0)
 ;;=4^S56.512A
 ;;^UTILITY(U,$J,358.3,17510,2)
 ;;=^5031841
 ;;^UTILITY(U,$J,358.3,17511,0)
 ;;=S13.8XXA^^88^892^10
 ;;^UTILITY(U,$J,358.3,17511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17511,1,3,0)
 ;;=3^Sprain of Neck Joints/Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,17511,1,4,0)
 ;;=4^S13.8XXA
 ;;^UTILITY(U,$J,358.3,17511,2)
 ;;=^5022034
 ;;^UTILITY(U,$J,358.3,17512,0)
 ;;=S16.1XXA^^88^892^37
 ;;^UTILITY(U,$J,358.3,17512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17512,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Init Encntr
 ;;^UTILITY(U,$J,358.3,17512,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,17512,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,17513,0)
 ;;=S33.5XXA^^88^892^8
 ;;^UTILITY(U,$J,358.3,17513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17513,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,17513,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,17513,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,17514,0)
 ;;=F10.20^^88^893^5
 ;;^UTILITY(U,$J,358.3,17514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17514,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,17514,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,17514,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,17515,0)
 ;;=F11.29^^88^893^50
 ;;^UTILITY(U,$J,358.3,17515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17515,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,17515,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,17515,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,17516,0)
 ;;=F11.288^^88^893^49
 ;;^UTILITY(U,$J,358.3,17516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17516,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,17516,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,17516,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,17517,0)
 ;;=F11.282^^88^893^48
 ;;^UTILITY(U,$J,358.3,17517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17517,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,17517,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,17517,2)
 ;;=^5003139
