IBDEI0CX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5609,1,4,0)
 ;;=4^S61.212A
 ;;^UTILITY(U,$J,358.3,5609,2)
 ;;=^5032777
 ;;^UTILITY(U,$J,358.3,5610,0)
 ;;=S61.314A^^40^371^59
 ;;^UTILITY(U,$J,358.3,5610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5610,1,3,0)
 ;;=3^Laceration w/o FB of Right Ring Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5610,1,4,0)
 ;;=4^S61.314A
 ;;^UTILITY(U,$J,358.3,5610,2)
 ;;=^5032918
 ;;^UTILITY(U,$J,358.3,5611,0)
 ;;=S61.214A^^40^371^60
 ;;^UTILITY(U,$J,358.3,5611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5611,1,3,0)
 ;;=3^Laceration w/o FB of Right Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5611,1,4,0)
 ;;=4^S61.214A
 ;;^UTILITY(U,$J,358.3,5611,2)
 ;;=^5032783
 ;;^UTILITY(U,$J,358.3,5612,0)
 ;;=S41.011A^^40^371^61
 ;;^UTILITY(U,$J,358.3,5612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5612,1,3,0)
 ;;=3^Laceration w/o FB of Right Shoulder,Init Encntr
 ;;^UTILITY(U,$J,358.3,5612,1,4,0)
 ;;=4^S41.011A
 ;;^UTILITY(U,$J,358.3,5612,2)
 ;;=^5026297
 ;;^UTILITY(U,$J,358.3,5613,0)
 ;;=S61.111A^^40^371^63
 ;;^UTILITY(U,$J,358.3,5613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5613,1,3,0)
 ;;=3^Laceration w/o FB of Right Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5613,1,4,0)
 ;;=4^S61.111A
 ;;^UTILITY(U,$J,358.3,5613,2)
 ;;=^5032726
 ;;^UTILITY(U,$J,358.3,5614,0)
 ;;=S61.011A^^40^371^64
 ;;^UTILITY(U,$J,358.3,5614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5614,1,3,0)
 ;;=3^Laceration w/o FB of Right Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5614,1,4,0)
 ;;=4^S61.011A
 ;;^UTILITY(U,$J,358.3,5614,2)
 ;;=^5032690
 ;;^UTILITY(U,$J,358.3,5615,0)
 ;;=S61.511A^^40^371^65
 ;;^UTILITY(U,$J,358.3,5615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5615,1,3,0)
 ;;=3^Laceration w/o FB of Right Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,5615,1,4,0)
 ;;=4^S61.511A
 ;;^UTILITY(U,$J,358.3,5615,2)
 ;;=^5033026
 ;;^UTILITY(U,$J,358.3,5616,0)
 ;;=S01.01XA^^40^371^66
 ;;^UTILITY(U,$J,358.3,5616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5616,1,3,0)
 ;;=3^Laceration w/o FB of Scalp,Init Encntr
 ;;^UTILITY(U,$J,358.3,5616,1,4,0)
 ;;=4^S01.01XA
 ;;^UTILITY(U,$J,358.3,5616,2)
 ;;=^5020036
 ;;^UTILITY(U,$J,358.3,5617,0)
 ;;=S01.91XA^^40^371^4
 ;;^UTILITY(U,$J,358.3,5617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5617,1,3,0)
 ;;=3^Laceration w/o FB of Head,Unspec Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,5617,1,4,0)
 ;;=4^S01.91XA
 ;;^UTILITY(U,$J,358.3,5617,2)
 ;;=^5020243
 ;;^UTILITY(U,$J,358.3,5618,0)
 ;;=S11.91XA^^40^371^35
 ;;^UTILITY(U,$J,358.3,5618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5618,1,3,0)
 ;;=3^Laceration w/o FB of Neck,Unspec Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,5618,1,4,0)
 ;;=4^S11.91XA
 ;;^UTILITY(U,$J,358.3,5618,2)
 ;;=^5021530
 ;;^UTILITY(U,$J,358.3,5619,0)
 ;;=S91.012A^^40^371^7
 ;;^UTILITY(U,$J,358.3,5619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5619,1,3,0)
 ;;=3^Laceration w/o FB of Left Ankle,Init Encntr
 ;;^UTILITY(U,$J,358.3,5619,1,4,0)
 ;;=4^S91.012A
 ;;^UTILITY(U,$J,358.3,5619,2)
 ;;=^5044138
 ;;^UTILITY(U,$J,358.3,5620,0)
 ;;=S91.312A^^40^371^12
 ;;^UTILITY(U,$J,358.3,5620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5620,1,3,0)
 ;;=3^Laceration w/o FB of Left Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,5620,1,4,0)
 ;;=4^S91.312A
 ;;^UTILITY(U,$J,358.3,5620,2)
 ;;=^5044323
 ;;^UTILITY(U,$J,358.3,5621,0)
 ;;=S71.012A^^40^371^16
 ;;^UTILITY(U,$J,358.3,5621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5621,1,3,0)
 ;;=3^Laceration w/o FB of Left Hip,Init Encntr
 ;;^UTILITY(U,$J,358.3,5621,1,4,0)
 ;;=4^S71.012A
 ;;^UTILITY(U,$J,358.3,5621,2)
 ;;=^5036978
