IBDEI28B ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35594,1,3,0)
 ;;=3^Injury of unspec cranial nerve, sequela
 ;;^UTILITY(U,$J,358.3,35594,1,4,0)
 ;;=4^S04.9XXS
 ;;^UTILITY(U,$J,358.3,35594,2)
 ;;=^5020575
 ;;^UTILITY(U,$J,358.3,35595,0)
 ;;=S24.9XXS^^139^1817^12
 ;;^UTILITY(U,$J,358.3,35595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35595,1,3,0)
 ;;=3^Injury of unspec nerve of thorax, sequela
 ;;^UTILITY(U,$J,358.3,35595,1,4,0)
 ;;=4^S24.9XXS
 ;;^UTILITY(U,$J,358.3,35595,2)
 ;;=^5023359
 ;;^UTILITY(U,$J,358.3,35596,0)
 ;;=S34.9XXS^^139^1817^18
 ;;^UTILITY(U,$J,358.3,35596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35596,1,3,0)
 ;;=3^Injury to unspec nerves at abd/low back/pelvis level, sequela
 ;;^UTILITY(U,$J,358.3,35596,1,4,0)
 ;;=4^S34.9XXS
 ;;^UTILITY(U,$J,358.3,35596,2)
 ;;=^5025273
 ;;^UTILITY(U,$J,358.3,35597,0)
 ;;=S14.9XXS^^139^1817^13
 ;;^UTILITY(U,$J,358.3,35597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35597,1,3,0)
 ;;=3^Injury of unspec nerves of neck, sequela
 ;;^UTILITY(U,$J,358.3,35597,1,4,0)
 ;;=4^S14.9XXS
 ;;^UTILITY(U,$J,358.3,35597,2)
 ;;=^5022219
 ;;^UTILITY(U,$J,358.3,35598,0)
 ;;=S58.922S^^139^1817^20
 ;;^UTILITY(U,$J,358.3,35598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35598,1,3,0)
 ;;=3^Partial traumatic amp of l forearm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,35598,1,4,0)
 ;;=4^S58.922S
 ;;^UTILITY(U,$J,358.3,35598,2)
 ;;=^5031957
 ;;^UTILITY(U,$J,358.3,35599,0)
 ;;=S14.109S^^139^1817^15
 ;;^UTILITY(U,$J,358.3,35599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35599,1,3,0)
 ;;=3^Injury to unsp level of cervical spinal cord unspec, sequela
 ;;^UTILITY(U,$J,358.3,35599,1,4,0)
 ;;=4^S14.109S
 ;;^UTILITY(U,$J,358.3,35599,2)
 ;;=^5134243
 ;;^UTILITY(U,$J,358.3,35600,0)
 ;;=S24.109S^^139^1817^17
 ;;^UTILITY(U,$J,358.3,35600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35600,1,3,0)
 ;;=3^Injury to unsp level of thoracic spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,35600,1,4,0)
 ;;=4^S24.109S
 ;;^UTILITY(U,$J,358.3,35600,2)
 ;;=^5134384
 ;;^UTILITY(U,$J,358.3,35601,0)
 ;;=S34.139S^^139^1817^14
 ;;^UTILITY(U,$J,358.3,35601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35601,1,3,0)
 ;;=3^Injury to sacral spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,35601,1,4,0)
 ;;=4^S34.139S
 ;;^UTILITY(U,$J,358.3,35601,2)
 ;;=^5025249
 ;;^UTILITY(U,$J,358.3,35602,0)
 ;;=S34.109S^^139^1817^16
 ;;^UTILITY(U,$J,358.3,35602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35602,1,3,0)
 ;;=3^Injury to unsp level of lumbar spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,35602,1,4,0)
 ;;=4^S34.109S
 ;;^UTILITY(U,$J,358.3,35602,2)
 ;;=^5134570
 ;;^UTILITY(U,$J,358.3,35603,0)
 ;;=S06.9X9S^^139^1817^19
 ;;^UTILITY(U,$J,358.3,35603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35603,1,3,0)
 ;;=3^Intracranial injury w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,35603,1,4,0)
 ;;=4^S06.9X9S
 ;;^UTILITY(U,$J,358.3,35603,2)
 ;;=^5021235
 ;;^UTILITY(U,$J,358.3,35604,0)
 ;;=S15.002A^^139^1817^5
 ;;^UTILITY(U,$J,358.3,35604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35604,1,3,0)
 ;;=3^Injury of left carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,35604,1,4,0)
 ;;=4^S15.002A
 ;;^UTILITY(U,$J,358.3,35604,2)
 ;;=^5022223
 ;;^UTILITY(U,$J,358.3,35605,0)
 ;;=S15.001A^^139^1817^10
 ;;^UTILITY(U,$J,358.3,35605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35605,1,3,0)
 ;;=3^Injury of right carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,35605,1,4,0)
 ;;=4^S15.001A
