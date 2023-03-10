IBDEI0WE ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14607,1,3,0)
 ;;=3^Injury of nerve root of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,14607,1,4,0)
 ;;=4^S34.21XS
 ;;^UTILITY(U,$J,358.3,14607,2)
 ;;=^5025252
 ;;^UTILITY(U,$J,358.3,14608,0)
 ;;=S34.22XS^^58^702^8
 ;;^UTILITY(U,$J,358.3,14608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14608,1,3,0)
 ;;=3^Injury of nerve root of sacral spine, sequela
 ;;^UTILITY(U,$J,358.3,14608,1,4,0)
 ;;=4^S34.22XS
 ;;^UTILITY(U,$J,358.3,14608,2)
 ;;=^5025255
 ;;^UTILITY(U,$J,358.3,14609,0)
 ;;=S24.2XXS^^58^702^9
 ;;^UTILITY(U,$J,358.3,14609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14609,1,3,0)
 ;;=3^Injury of nerve root of thoracic spine, sequela
 ;;^UTILITY(U,$J,358.3,14609,1,4,0)
 ;;=4^S24.2XXS
 ;;^UTILITY(U,$J,358.3,14609,2)
 ;;=^5023347
 ;;^UTILITY(U,$J,358.3,14610,0)
 ;;=S04.9XXS^^58^702^11
 ;;^UTILITY(U,$J,358.3,14610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14610,1,3,0)
 ;;=3^Injury of unspec cranial nerve, sequela
 ;;^UTILITY(U,$J,358.3,14610,1,4,0)
 ;;=4^S04.9XXS
 ;;^UTILITY(U,$J,358.3,14610,2)
 ;;=^5020575
 ;;^UTILITY(U,$J,358.3,14611,0)
 ;;=S24.9XXS^^58^702^12
 ;;^UTILITY(U,$J,358.3,14611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14611,1,3,0)
 ;;=3^Injury of unspec nerve of thorax, sequela
 ;;^UTILITY(U,$J,358.3,14611,1,4,0)
 ;;=4^S24.9XXS
 ;;^UTILITY(U,$J,358.3,14611,2)
 ;;=^5023359
 ;;^UTILITY(U,$J,358.3,14612,0)
 ;;=S34.9XXS^^58^702^18
 ;;^UTILITY(U,$J,358.3,14612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14612,1,3,0)
 ;;=3^Injury to unspec nerves at abd/low back/pelvis level, sequela
 ;;^UTILITY(U,$J,358.3,14612,1,4,0)
 ;;=4^S34.9XXS
 ;;^UTILITY(U,$J,358.3,14612,2)
 ;;=^5025273
 ;;^UTILITY(U,$J,358.3,14613,0)
 ;;=S14.9XXS^^58^702^13
 ;;^UTILITY(U,$J,358.3,14613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14613,1,3,0)
 ;;=3^Injury of unspec nerves of neck, sequela
 ;;^UTILITY(U,$J,358.3,14613,1,4,0)
 ;;=4^S14.9XXS
 ;;^UTILITY(U,$J,358.3,14613,2)
 ;;=^5022219
 ;;^UTILITY(U,$J,358.3,14614,0)
 ;;=S58.922S^^58^702^20
 ;;^UTILITY(U,$J,358.3,14614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14614,1,3,0)
 ;;=3^Partial traumatic amp of l forearm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,14614,1,4,0)
 ;;=4^S58.922S
 ;;^UTILITY(U,$J,358.3,14614,2)
 ;;=^5031957
 ;;^UTILITY(U,$J,358.3,14615,0)
 ;;=S14.109S^^58^702^15
 ;;^UTILITY(U,$J,358.3,14615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14615,1,3,0)
 ;;=3^Injury to unsp level of cervical spinal cord unspec, sequela
 ;;^UTILITY(U,$J,358.3,14615,1,4,0)
 ;;=4^S14.109S
 ;;^UTILITY(U,$J,358.3,14615,2)
 ;;=^5134243
 ;;^UTILITY(U,$J,358.3,14616,0)
 ;;=S24.109S^^58^702^17
 ;;^UTILITY(U,$J,358.3,14616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14616,1,3,0)
 ;;=3^Injury to unsp level of thoracic spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,14616,1,4,0)
 ;;=4^S24.109S
 ;;^UTILITY(U,$J,358.3,14616,2)
 ;;=^5134384
 ;;^UTILITY(U,$J,358.3,14617,0)
 ;;=S34.139S^^58^702^14
 ;;^UTILITY(U,$J,358.3,14617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14617,1,3,0)
 ;;=3^Injury to sacral spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,14617,1,4,0)
 ;;=4^S34.139S
 ;;^UTILITY(U,$J,358.3,14617,2)
 ;;=^5025249
 ;;^UTILITY(U,$J,358.3,14618,0)
 ;;=S34.109S^^58^702^16
 ;;^UTILITY(U,$J,358.3,14618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14618,1,3,0)
 ;;=3^Injury to unsp level of lumbar spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,14618,1,4,0)
 ;;=4^S34.109S
