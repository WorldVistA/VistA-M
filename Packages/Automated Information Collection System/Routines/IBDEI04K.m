IBDEI04K ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1609,1,4,0)
 ;;=4^S22.009A
 ;;^UTILITY(U,$J,358.3,1609,2)
 ;;=^5022829
 ;;^UTILITY(U,$J,358.3,1610,0)
 ;;=S32.009A^^3^45^30
 ;;^UTILITY(U,$J,358.3,1610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1610,1,3,0)
 ;;=3^Fx of Lumbar Vertebra,Unspec,Init for Closed Fx
 ;;^UTILITY(U,$J,358.3,1610,1,4,0)
 ;;=4^S32.009A
 ;;^UTILITY(U,$J,358.3,1610,2)
 ;;=^5024365
 ;;^UTILITY(U,$J,358.3,1611,0)
 ;;=S32.10XA^^3^45^32
 ;;^UTILITY(U,$J,358.3,1611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1611,1,3,0)
 ;;=3^Fx of Sacrum,Init for Closed Fx
 ;;^UTILITY(U,$J,358.3,1611,1,4,0)
 ;;=4^S32.10XA
 ;;^UTILITY(U,$J,358.3,1611,2)
 ;;=^5024521
 ;;^UTILITY(U,$J,358.3,1612,0)
 ;;=S32.2XXA^^3^45^29
 ;;^UTILITY(U,$J,358.3,1612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1612,1,3,0)
 ;;=3^Fx of Coccyx,Init for Closed Fx
 ;;^UTILITY(U,$J,358.3,1612,1,4,0)
 ;;=4^S32.2XXA
 ;;^UTILITY(U,$J,358.3,1612,2)
 ;;=^5024629
 ;;^UTILITY(U,$J,358.3,1613,0)
 ;;=S83.201A^^3^45^11
 ;;^UTILITY(U,$J,358.3,1613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1613,1,3,0)
 ;;=3^Bucket-hndl tear of unsp mensc, current injury, l knee, init
 ;;^UTILITY(U,$J,358.3,1613,1,4,0)
 ;;=4^S83.201A
 ;;^UTILITY(U,$J,358.3,1613,2)
 ;;=^5043028
 ;;^UTILITY(U,$J,358.3,1614,0)
 ;;=S43.421A^^3^45^106
 ;;^UTILITY(U,$J,358.3,1614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1614,1,3,0)
 ;;=3^Sprain of right rotator cuff capsule, initial encounter
 ;;^UTILITY(U,$J,358.3,1614,1,4,0)
 ;;=4^S43.421A
 ;;^UTILITY(U,$J,358.3,1614,2)
 ;;=^5027879
 ;;^UTILITY(U,$J,358.3,1615,0)
 ;;=S43.422A^^3^45^102
 ;;^UTILITY(U,$J,358.3,1615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1615,1,3,0)
 ;;=3^Sprain of left rotator cuff capsule, initial encounter
 ;;^UTILITY(U,$J,358.3,1615,1,4,0)
 ;;=4^S43.422A
 ;;^UTILITY(U,$J,358.3,1615,2)
 ;;=^5027882
 ;;^UTILITY(U,$J,358.3,1616,0)
 ;;=S63.501A^^3^45^101
 ;;^UTILITY(U,$J,358.3,1616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1616,1,3,0)
 ;;=3^Sprain of Right Wrist,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,1616,1,4,0)
 ;;=4^S63.501A
 ;;^UTILITY(U,$J,358.3,1616,2)
 ;;=^5035583
 ;;^UTILITY(U,$J,358.3,1617,0)
 ;;=S63.502A^^3^45^100
 ;;^UTILITY(U,$J,358.3,1617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1617,1,3,0)
 ;;=3^Sprain of Left Wrist,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,1617,1,4,0)
 ;;=4^S63.502A
 ;;^UTILITY(U,$J,358.3,1617,2)
 ;;=^5035586
 ;;^UTILITY(U,$J,358.3,1618,0)
 ;;=S93.401A^^3^45^108
 ;;^UTILITY(U,$J,358.3,1618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1618,1,3,0)
 ;;=3^Sprain of unspecified ligament of right ankle, init encntr
 ;;^UTILITY(U,$J,358.3,1618,1,4,0)
 ;;=4^S93.401A
 ;;^UTILITY(U,$J,358.3,1618,2)
 ;;=^5045774
 ;;^UTILITY(U,$J,358.3,1619,0)
 ;;=S93.402A^^3^45^107
 ;;^UTILITY(U,$J,358.3,1619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1619,1,3,0)
 ;;=3^Sprain of unspecified ligament of left ankle, init encntr
 ;;^UTILITY(U,$J,358.3,1619,1,4,0)
 ;;=4^S93.402A
 ;;^UTILITY(U,$J,358.3,1619,2)
 ;;=^5045777
 ;;^UTILITY(U,$J,358.3,1620,0)
 ;;=S13.4XXA^^3^45^103
 ;;^UTILITY(U,$J,358.3,1620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1620,1,3,0)
 ;;=3^Sprain of ligaments of cervical spine, initial encounter
 ;;^UTILITY(U,$J,358.3,1620,1,4,0)
 ;;=4^S13.4XXA
 ;;^UTILITY(U,$J,358.3,1620,2)
 ;;=^5022028
 ;;^UTILITY(U,$J,358.3,1621,0)
 ;;=S23.3XXA^^3^45^105
 ;;^UTILITY(U,$J,358.3,1621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1621,1,3,0)
 ;;=3^Sprain of ligaments of thoracic spine, initial encounter
 ;;^UTILITY(U,$J,358.3,1621,1,4,0)
 ;;=4^S23.3XXA
 ;;^UTILITY(U,$J,358.3,1621,2)
 ;;=^5023246
