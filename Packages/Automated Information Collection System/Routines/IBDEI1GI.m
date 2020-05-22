IBDEI1GI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23296,0)
 ;;=M79.2^^105^1171^15
 ;;^UTILITY(U,$J,358.3,23296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23296,1,3,0)
 ;;=3^Neuralgia and Neuritis,Unspec
 ;;^UTILITY(U,$J,358.3,23296,1,4,0)
 ;;=4^M79.2
 ;;^UTILITY(U,$J,358.3,23296,2)
 ;;=^5013322
 ;;^UTILITY(U,$J,358.3,23297,0)
 ;;=M79.89^^105^1171^70
 ;;^UTILITY(U,$J,358.3,23297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23297,1,3,0)
 ;;=3^Soft Tissue Disorders
 ;;^UTILITY(U,$J,358.3,23297,1,4,0)
 ;;=4^M79.89
 ;;^UTILITY(U,$J,358.3,23297,2)
 ;;=^5013357
 ;;^UTILITY(U,$J,358.3,23298,0)
 ;;=M88.9^^105^1171^16
 ;;^UTILITY(U,$J,358.3,23298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23298,1,3,0)
 ;;=3^Osteitis Deformans,Unspec Bone
 ;;^UTILITY(U,$J,358.3,23298,1,4,0)
 ;;=4^M88.9
 ;;^UTILITY(U,$J,358.3,23298,2)
 ;;=^5014899
 ;;^UTILITY(U,$J,358.3,23299,0)
 ;;=M81.0^^105^1171^19
 ;;^UTILITY(U,$J,358.3,23299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23299,1,3,0)
 ;;=3^Osteoporosis,Age-Related w/o Current Fx
 ;;^UTILITY(U,$J,358.3,23299,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,23299,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,23300,0)
 ;;=M84.40XA^^105^1171^21
 ;;^UTILITY(U,$J,358.3,23300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23300,1,3,0)
 ;;=3^Patholog Fx,Unspec Site,Init Encntr for Fx
 ;;^UTILITY(U,$J,358.3,23300,1,4,0)
 ;;=4^M84.40XA
 ;;^UTILITY(U,$J,358.3,23300,2)
 ;;=^5013794
 ;;^UTILITY(U,$J,358.3,23301,0)
 ;;=M84.40XD^^105^1171^22
 ;;^UTILITY(U,$J,358.3,23301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23301,1,3,0)
 ;;=3^Patholog Fx,Unspec Site,Subsq Encntr for Fx w/ Routine Healing
 ;;^UTILITY(U,$J,358.3,23301,1,4,0)
 ;;=4^M84.40XD
 ;;^UTILITY(U,$J,358.3,23301,2)
 ;;=^5013795
 ;;^UTILITY(U,$J,358.3,23302,0)
 ;;=M84.40XG^^105^1171^23
 ;;^UTILITY(U,$J,358.3,23302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23302,1,3,0)
 ;;=3^Patholog Fx,Unspec Site,Subsq Encntr for Fx w/ Delay Healing
 ;;^UTILITY(U,$J,358.3,23302,1,4,0)
 ;;=4^M84.40XG
 ;;^UTILITY(U,$J,358.3,23302,2)
 ;;=^5013796
 ;;^UTILITY(U,$J,358.3,23303,0)
 ;;=M84.40XK^^105^1171^24
 ;;^UTILITY(U,$J,358.3,23303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23303,1,3,0)
 ;;=3^Patholog Fx,Unspec Site,Subsq Encntr for Fx w/ Nonunion
 ;;^UTILITY(U,$J,358.3,23303,1,4,0)
 ;;=4^M84.40XK
 ;;^UTILITY(U,$J,358.3,23303,2)
 ;;=^5013797
 ;;^UTILITY(U,$J,358.3,23304,0)
 ;;=M84.40XP^^105^1171^25
 ;;^UTILITY(U,$J,358.3,23304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23304,1,3,0)
 ;;=3^Patholog Fx,Unspec Site,Subsq Encntr for Fx w/ Malunion
 ;;^UTILITY(U,$J,358.3,23304,1,4,0)
 ;;=4^M84.40XP
 ;;^UTILITY(U,$J,358.3,23304,2)
 ;;=^5013798
 ;;^UTILITY(U,$J,358.3,23305,0)
 ;;=M84.40XS^^105^1171^26
 ;;^UTILITY(U,$J,358.3,23305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23305,1,3,0)
 ;;=3^Patholog Fx,Unspec Site,Subsq Encntr for Fx w/ Sequela
 ;;^UTILITY(U,$J,358.3,23305,1,4,0)
 ;;=4^M84.40XS
 ;;^UTILITY(U,$J,358.3,23305,2)
 ;;=^5013799
 ;;^UTILITY(U,$J,358.3,23306,0)
 ;;=M85.80^^105^1171^3
 ;;^UTILITY(U,$J,358.3,23306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23306,1,3,0)
 ;;=3^Bone Density/Structure Disorders,Unspec Site
 ;;^UTILITY(U,$J,358.3,23306,1,4,0)
 ;;=4^M85.80
 ;;^UTILITY(U,$J,358.3,23306,2)
 ;;=^5014473
 ;;^UTILITY(U,$J,358.3,23307,0)
 ;;=G40.909^^105^1172^5
 ;;^UTILITY(U,$J,358.3,23307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23307,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus
