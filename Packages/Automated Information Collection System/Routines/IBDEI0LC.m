IBDEI0LC ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9603,2)
 ;;=^5031838
 ;;^UTILITY(U,$J,358.3,9604,0)
 ;;=S56.512A^^39^414^21
 ;;^UTILITY(U,$J,358.3,9604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9604,1,3,0)
 ;;=3^Strain of Left Forearm Extn Musc/Fasc/Tend
 ;;^UTILITY(U,$J,358.3,9604,1,4,0)
 ;;=4^S56.512A
 ;;^UTILITY(U,$J,358.3,9604,2)
 ;;=^5031841
 ;;^UTILITY(U,$J,358.3,9605,0)
 ;;=S13.8XXA^^39^414^13
 ;;^UTILITY(U,$J,358.3,9605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9605,1,3,0)
 ;;=3^Sprain of Neck Joints/Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,9605,1,4,0)
 ;;=4^S13.8XXA
 ;;^UTILITY(U,$J,358.3,9605,2)
 ;;=^5022034
 ;;^UTILITY(U,$J,358.3,9606,0)
 ;;=S16.1XXA^^39^414^39
 ;;^UTILITY(U,$J,358.3,9606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9606,1,3,0)
 ;;=3^Strain of Neck Muscle/Fasc/Tendon,Init Encntr
 ;;^UTILITY(U,$J,358.3,9606,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,9606,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,9607,0)
 ;;=S33.5XXA^^39^414^12
 ;;^UTILITY(U,$J,358.3,9607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9607,1,3,0)
 ;;=3^Sprain of Lumbar Spine Ligaments,Init Encntr
 ;;^UTILITY(U,$J,358.3,9607,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,9607,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,9608,0)
 ;;=S20.221A^^39^414^4
 ;;^UTILITY(U,$J,358.3,9608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9608,1,3,0)
 ;;=3^Contusion,Rt Back Wall of Thorax
 ;;^UTILITY(U,$J,358.3,9608,1,4,0)
 ;;=4^S20.221A
 ;;^UTILITY(U,$J,358.3,9608,2)
 ;;=^5022484
 ;;^UTILITY(U,$J,358.3,9609,0)
 ;;=S20.222A^^39^414^2
 ;;^UTILITY(U,$J,358.3,9609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9609,1,3,0)
 ;;=3^Contusion,Lt Back Wall of Thorax
 ;;^UTILITY(U,$J,358.3,9609,1,4,0)
 ;;=4^S20.222A
 ;;^UTILITY(U,$J,358.3,9609,2)
 ;;=^5022487
 ;;^UTILITY(U,$J,358.3,9610,0)
 ;;=S20.223A^^39^414^1
 ;;^UTILITY(U,$J,358.3,9610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9610,1,3,0)
 ;;=3^Contusion,Bilateral Back Wall of Thorax
 ;;^UTILITY(U,$J,358.3,9610,1,4,0)
 ;;=4^S20.223A
 ;;^UTILITY(U,$J,358.3,9610,2)
 ;;=^5159315
 ;;^UTILITY(U,$J,358.3,9611,0)
 ;;=S20.224A^^39^414^3
 ;;^UTILITY(U,$J,358.3,9611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9611,1,3,0)
 ;;=3^Contusion,Middle Back Wall of Thorax
 ;;^UTILITY(U,$J,358.3,9611,1,4,0)
 ;;=4^S20.224A
 ;;^UTILITY(U,$J,358.3,9611,2)
 ;;=^5159318
 ;;^UTILITY(U,$J,358.3,9612,0)
 ;;=F10.20^^39^415^9
 ;;^UTILITY(U,$J,358.3,9612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9612,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9612,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,9612,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,9613,0)
 ;;=F11.29^^39^415^61
 ;;^UTILITY(U,$J,358.3,9613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9613,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,9613,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,9613,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,9614,0)
 ;;=F11.288^^39^415^60
 ;;^UTILITY(U,$J,358.3,9614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9614,1,3,0)
 ;;=3^Opioid Dependence w/ Other Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,9614,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,9614,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,9615,0)
 ;;=F11.282^^39^415^59
 ;;^UTILITY(U,$J,358.3,9615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9615,1,3,0)
 ;;=3^Opioid Dependence w/ Opioid-Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,9615,1,4,0)
 ;;=4^F11.282
