IBDEI0ED ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6272,0)
 ;;=S51.051A^^40^387^41
 ;;^UTILITY(U,$J,358.3,6272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6272,1,3,0)
 ;;=3^Open Bite of Right Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,6272,1,4,0)
 ;;=4^S51.051A
 ;;^UTILITY(U,$J,358.3,6272,2)
 ;;=^5028650
 ;;^UTILITY(U,$J,358.3,6273,0)
 ;;=S91.351A^^40^387^42
 ;;^UTILITY(U,$J,358.3,6273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6273,1,3,0)
 ;;=3^Open Bite of Right Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,6273,1,4,0)
 ;;=4^S91.351A
 ;;^UTILITY(U,$J,358.3,6273,2)
 ;;=^5044344
 ;;^UTILITY(U,$J,358.3,6274,0)
 ;;=S91.251A^^40^387^43
 ;;^UTILITY(U,$J,358.3,6274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6274,1,3,0)
 ;;=3^Open Bite of Right Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6274,1,4,0)
 ;;=4^S91.251A
 ;;^UTILITY(U,$J,358.3,6274,2)
 ;;=^5044305
 ;;^UTILITY(U,$J,358.3,6275,0)
 ;;=S61.451A^^40^387^44
 ;;^UTILITY(U,$J,358.3,6275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6275,1,3,0)
 ;;=3^Open Bite of Right Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,6275,1,4,0)
 ;;=4^S61.451A
 ;;^UTILITY(U,$J,358.3,6275,2)
 ;;=^5033011
 ;;^UTILITY(U,$J,358.3,6276,0)
 ;;=S71.051A^^40^387^45
 ;;^UTILITY(U,$J,358.3,6276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6276,1,3,0)
 ;;=3^Open Bite of Right Hip,Init Encntr
 ;;^UTILITY(U,$J,358.3,6276,1,4,0)
 ;;=4^S71.051A
 ;;^UTILITY(U,$J,358.3,6276,2)
 ;;=^5036999
 ;;^UTILITY(U,$J,358.3,6277,0)
 ;;=S61.350A^^40^387^46
 ;;^UTILITY(U,$J,358.3,6277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6277,1,3,0)
 ;;=3^Open Bite of Right Index Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6277,1,4,0)
 ;;=4^S61.350A
 ;;^UTILITY(U,$J,358.3,6277,2)
 ;;=^5032966
 ;;^UTILITY(U,$J,358.3,6278,0)
 ;;=S61.250A^^40^387^47
 ;;^UTILITY(U,$J,358.3,6278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6278,1,3,0)
 ;;=3^Open Bite of Right Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6278,1,4,0)
 ;;=4^S61.250A
 ;;^UTILITY(U,$J,358.3,6278,2)
 ;;=^5032861
 ;;^UTILITY(U,$J,358.3,6279,0)
 ;;=S81.051A^^40^387^48
 ;;^UTILITY(U,$J,358.3,6279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6279,1,3,0)
 ;;=3^Open Bite of Right Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,6279,1,4,0)
 ;;=4^S81.051A
 ;;^UTILITY(U,$J,358.3,6279,2)
 ;;=^5040056
 ;;^UTILITY(U,$J,358.3,6280,0)
 ;;=S91.254A^^40^387^49
 ;;^UTILITY(U,$J,358.3,6280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6280,1,3,0)
 ;;=3^Open Bite of Right Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6280,1,4,0)
 ;;=4^S91.254A
 ;;^UTILITY(U,$J,358.3,6280,2)
 ;;=^5044308
 ;;^UTILITY(U,$J,358.3,6281,0)
 ;;=S91.154A^^40^387^50
 ;;^UTILITY(U,$J,358.3,6281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6281,1,3,0)
 ;;=3^Open Bite of Right Lesser Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6281,1,4,0)
 ;;=4^S91.154A
 ;;^UTILITY(U,$J,358.3,6281,2)
 ;;=^5044252
 ;;^UTILITY(U,$J,358.3,6282,0)
 ;;=S61.356A^^40^387^51
 ;;^UTILITY(U,$J,358.3,6282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6282,1,3,0)
 ;;=3^Open Bite of Right Little Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6282,1,4,0)
 ;;=4^S61.356A
 ;;^UTILITY(U,$J,358.3,6282,2)
 ;;=^5032975
 ;;^UTILITY(U,$J,358.3,6283,0)
 ;;=S61.256A^^40^387^52
 ;;^UTILITY(U,$J,358.3,6283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6283,1,3,0)
 ;;=3^Open Bite of Right Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,6283,1,4,0)
 ;;=4^S61.256A
 ;;^UTILITY(U,$J,358.3,6283,2)
 ;;=^5032879
 ;;^UTILITY(U,$J,358.3,6284,0)
 ;;=S81.851A^^40^387^53
 ;;^UTILITY(U,$J,358.3,6284,1,0)
 ;;=^358.31IA^4^2
