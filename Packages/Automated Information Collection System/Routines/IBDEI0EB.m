IBDEI0EB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6247,1,3,0)
 ;;=3^Open Bite of Left Hip,Init Encntr
 ;;^UTILITY(U,$J,358.3,6247,1,4,0)
 ;;=4^S71.052A
 ;;^UTILITY(U,$J,358.3,6247,2)
 ;;=^5037002
 ;;^UTILITY(U,$J,358.3,6248,0)
 ;;=S61.351A^^40^387^16
 ;;^UTILITY(U,$J,358.3,6248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6248,1,3,0)
 ;;=3^Open Bite of Left Index finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6248,1,4,0)
 ;;=4^S61.351A
 ;;^UTILITY(U,$J,358.3,6248,2)
 ;;=^5135828
 ;;^UTILITY(U,$J,358.3,6249,0)
 ;;=S61.251A^^40^387^15
 ;;^UTILITY(U,$J,358.3,6249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6249,1,3,0)
 ;;=3^Open Bite of Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6249,1,4,0)
 ;;=4^S61.251A
 ;;^UTILITY(U,$J,358.3,6249,2)
 ;;=^5032864
 ;;^UTILITY(U,$J,358.3,6250,0)
 ;;=S81.052A^^40^387^17
 ;;^UTILITY(U,$J,358.3,6250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6250,1,3,0)
 ;;=3^Open Bite of Left Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,6250,1,4,0)
 ;;=4^S81.052A
 ;;^UTILITY(U,$J,358.3,6250,2)
 ;;=^5040059
 ;;^UTILITY(U,$J,358.3,6251,0)
 ;;=S91.255A^^40^387^18
 ;;^UTILITY(U,$J,358.3,6251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6251,1,3,0)
 ;;=3^Open Bite of Left Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6251,1,4,0)
 ;;=4^S91.255A
 ;;^UTILITY(U,$J,358.3,6251,2)
 ;;=^5137514
 ;;^UTILITY(U,$J,358.3,6252,0)
 ;;=S91.155A^^40^387^19
 ;;^UTILITY(U,$J,358.3,6252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6252,1,3,0)
 ;;=3^Open Bite of Left Lesser Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6252,1,4,0)
 ;;=4^S91.155A
 ;;^UTILITY(U,$J,358.3,6252,2)
 ;;=^5044255
 ;;^UTILITY(U,$J,358.3,6253,0)
 ;;=S61.357A^^40^387^20
 ;;^UTILITY(U,$J,358.3,6253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6253,1,3,0)
 ;;=3^Open Bite of Left Little Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6253,1,4,0)
 ;;=4^S61.357A
 ;;^UTILITY(U,$J,358.3,6253,2)
 ;;=^5135837
 ;;^UTILITY(U,$J,358.3,6254,0)
 ;;=S61.257A^^40^387^21
 ;;^UTILITY(U,$J,358.3,6254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6254,1,3,0)
 ;;=3^Open Bite of Left Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6254,1,4,0)
 ;;=4^S61.257A
 ;;^UTILITY(U,$J,358.3,6254,2)
 ;;=^5032882
 ;;^UTILITY(U,$J,358.3,6255,0)
 ;;=S81.852A^^40^387^22
 ;;^UTILITY(U,$J,358.3,6255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6255,1,3,0)
 ;;=3^Open Bite of Left Lower Leg,Init Encntr
 ;;^UTILITY(U,$J,358.3,6255,1,4,0)
 ;;=4^S81.852A
 ;;^UTILITY(U,$J,358.3,6255,2)
 ;;=^5040098
 ;;^UTILITY(U,$J,358.3,6256,0)
 ;;=S61.353A^^40^387^23
 ;;^UTILITY(U,$J,358.3,6256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6256,1,3,0)
 ;;=3^Open Bite of Left Middle Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6256,1,4,0)
 ;;=4^S61.353A
 ;;^UTILITY(U,$J,358.3,6256,2)
 ;;=^5135831
 ;;^UTILITY(U,$J,358.3,6257,0)
 ;;=S61.253A^^40^387^24
 ;;^UTILITY(U,$J,358.3,6257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6257,1,3,0)
 ;;=3^Open Bite of Left Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6257,1,4,0)
 ;;=4^S61.253A
 ;;^UTILITY(U,$J,358.3,6257,2)
 ;;=^5032870
 ;;^UTILITY(U,$J,358.3,6258,0)
 ;;=S61.355A^^40^387^25
 ;;^UTILITY(U,$J,358.3,6258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6258,1,3,0)
 ;;=3^Open Bite of Left Ring Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6258,1,4,0)
 ;;=4^S61.355A
 ;;^UTILITY(U,$J,358.3,6258,2)
 ;;=^5135834
 ;;^UTILITY(U,$J,358.3,6259,0)
 ;;=S61.255A^^40^387^26
 ;;^UTILITY(U,$J,358.3,6259,1,0)
 ;;=^358.31IA^4^2
