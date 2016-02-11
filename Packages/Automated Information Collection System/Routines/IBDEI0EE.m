IBDEI0EE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6284,1,3,0)
 ;;=3^Open Bite of Right Lower Leg,Init Encntr
 ;;^UTILITY(U,$J,358.3,6284,1,4,0)
 ;;=4^S81.851A
 ;;^UTILITY(U,$J,358.3,6284,2)
 ;;=^5040095
 ;;^UTILITY(U,$J,358.3,6285,0)
 ;;=S61.352A^^40^387^54
 ;;^UTILITY(U,$J,358.3,6285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6285,1,3,0)
 ;;=3^Open Bite of Right Middle Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6285,1,4,0)
 ;;=4^S61.352A
 ;;^UTILITY(U,$J,358.3,6285,2)
 ;;=^5032969
 ;;^UTILITY(U,$J,358.3,6286,0)
 ;;=S61.252A^^40^387^55
 ;;^UTILITY(U,$J,358.3,6286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6286,1,3,0)
 ;;=3^Open Bite of Right Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6286,1,4,0)
 ;;=4^S61.252A
 ;;^UTILITY(U,$J,358.3,6286,2)
 ;;=^5032867
 ;;^UTILITY(U,$J,358.3,6287,0)
 ;;=S61.354A^^40^387^56
 ;;^UTILITY(U,$J,358.3,6287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6287,1,3,0)
 ;;=3^Open Bite of Right Ring Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6287,1,4,0)
 ;;=4^S61.354A
 ;;^UTILITY(U,$J,358.3,6287,2)
 ;;=^5032972
 ;;^UTILITY(U,$J,358.3,6288,0)
 ;;=S61.254A^^40^387^57
 ;;^UTILITY(U,$J,358.3,6288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6288,1,3,0)
 ;;=3^Open Bite of Right Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6288,1,4,0)
 ;;=4^S61.254A
 ;;^UTILITY(U,$J,358.3,6288,2)
 ;;=^5032873
 ;;^UTILITY(U,$J,358.3,6289,0)
 ;;=S41.051A^^40^387^58
 ;;^UTILITY(U,$J,358.3,6289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6289,1,3,0)
 ;;=3^Open Bite of Right Shoulder,Init Encntr
 ;;^UTILITY(U,$J,358.3,6289,1,4,0)
 ;;=4^S41.051A
 ;;^UTILITY(U,$J,358.3,6289,2)
 ;;=^5026321
 ;;^UTILITY(U,$J,358.3,6290,0)
 ;;=S71.151A^^40^387^59
 ;;^UTILITY(U,$J,358.3,6290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6290,1,3,0)
 ;;=3^Open Bite of Right Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,6290,1,4,0)
 ;;=4^S71.151A
 ;;^UTILITY(U,$J,358.3,6290,2)
 ;;=^5037038
 ;;^UTILITY(U,$J,358.3,6291,0)
 ;;=S61.151A^^40^387^60
 ;;^UTILITY(U,$J,358.3,6291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6291,1,3,0)
 ;;=3^Open Bite of Right Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6291,1,4,0)
 ;;=4^S61.151A
 ;;^UTILITY(U,$J,358.3,6291,2)
 ;;=^5032738
 ;;^UTILITY(U,$J,358.3,6292,0)
 ;;=S61.051A^^40^387^61
 ;;^UTILITY(U,$J,358.3,6292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6292,1,3,0)
 ;;=3^Open Bite of Right Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6292,1,4,0)
 ;;=4^S61.051A
 ;;^UTILITY(U,$J,358.3,6292,2)
 ;;=^5032714
 ;;^UTILITY(U,$J,358.3,6293,0)
 ;;=S61.551A^^40^387^62
 ;;^UTILITY(U,$J,358.3,6293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6293,1,3,0)
 ;;=3^Open Bite of Right Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,6293,1,4,0)
 ;;=4^S61.551A
 ;;^UTILITY(U,$J,358.3,6293,2)
 ;;=^5033050
 ;;^UTILITY(U,$J,358.3,6294,0)
 ;;=S01.05XA^^40^387^63
 ;;^UTILITY(U,$J,358.3,6294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6294,1,3,0)
 ;;=3^Open Bite of Scalp,Init Encntr
 ;;^UTILITY(U,$J,358.3,6294,1,4,0)
 ;;=4^S01.05XA
 ;;^UTILITY(U,$J,358.3,6294,2)
 ;;=^5020048
 ;;^UTILITY(U,$J,358.3,6295,0)
 ;;=S01.95XA^^40^387^2
 ;;^UTILITY(U,$J,358.3,6295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6295,1,3,0)
 ;;=3^Open Bite of Head,Unspec Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,6295,1,4,0)
 ;;=4^S01.95XA
 ;;^UTILITY(U,$J,358.3,6295,2)
 ;;=^5020249
 ;;^UTILITY(U,$J,358.3,6296,0)
 ;;=S11.95XA^^40^387^33
 ;;^UTILITY(U,$J,358.3,6296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6296,1,3,0)
 ;;=3^Open Bite of Neck,Unspec Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,6296,1,4,0)
 ;;=4^S11.95XA
