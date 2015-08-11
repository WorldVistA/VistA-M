IBDEI0IO ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9063,1,4,0)
 ;;=4^ Melanoma Of Eyelid
 ;;^UTILITY(U,$J,358.3,9063,1,5,0)
 ;;=5^172.1
 ;;^UTILITY(U,$J,358.3,9063,2)
 ;;=Malig Melanoma of Eyelid^267176
 ;;^UTILITY(U,$J,358.3,9064,0)
 ;;=172.2^^55^606^2
 ;;^UTILITY(U,$J,358.3,9064,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9064,1,4,0)
 ;;=4^ Melanoma Of Ear
 ;;^UTILITY(U,$J,358.3,9064,1,5,0)
 ;;=5^172.2
 ;;^UTILITY(U,$J,358.3,9064,2)
 ;;=Malig Melanoma of Ear^267177
 ;;^UTILITY(U,$J,358.3,9065,0)
 ;;=172.3^^55^606^4
 ;;^UTILITY(U,$J,358.3,9065,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9065,1,4,0)
 ;;=4^ Melanoma Of Face
 ;;^UTILITY(U,$J,358.3,9065,1,5,0)
 ;;=5^172.3
 ;;^UTILITY(U,$J,358.3,9065,2)
 ;;=Malig Melanoma of Face^267178
 ;;^UTILITY(U,$J,358.3,9066,0)
 ;;=172.4^^55^606^7
 ;;^UTILITY(U,$J,358.3,9066,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9066,1,4,0)
 ;;=4^ Melanoma Of Neck/Scalp
 ;;^UTILITY(U,$J,358.3,9066,1,5,0)
 ;;=5^172.4
 ;;^UTILITY(U,$J,358.3,9066,2)
 ;;=Malignant Melanoma of Neck^267179
 ;;^UTILITY(U,$J,358.3,9067,0)
 ;;=172.5^^55^606^9
 ;;^UTILITY(U,$J,358.3,9067,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9067,1,4,0)
 ;;=4^ Melanoma Of Trunk
 ;;^UTILITY(U,$J,358.3,9067,1,5,0)
 ;;=5^172.5
 ;;^UTILITY(U,$J,358.3,9067,2)
 ;;=Malignant Melanoma of Trunk^267180
 ;;^UTILITY(U,$J,358.3,9068,0)
 ;;=172.6^^55^606^1
 ;;^UTILITY(U,$J,358.3,9068,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9068,1,4,0)
 ;;=4^ Melanoma Of Arm/Shoulder
 ;;^UTILITY(U,$J,358.3,9068,1,5,0)
 ;;=5^172.6
 ;;^UTILITY(U,$J,358.3,9068,2)
 ;;=Malignant Melanoma of Arm^267181
 ;;^UTILITY(U,$J,358.3,9069,0)
 ;;=172.7^^55^606^5
 ;;^UTILITY(U,$J,358.3,9069,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9069,1,4,0)
 ;;=4^ Melanoma Of Leg/Hip
 ;;^UTILITY(U,$J,358.3,9069,1,5,0)
 ;;=5^172.7
 ;;^UTILITY(U,$J,358.3,9069,2)
 ;;=Malignant Melanoma of Leg^267182
 ;;^UTILITY(U,$J,358.3,9070,0)
 ;;=172.8^^55^606^8
 ;;^UTILITY(U,$J,358.3,9070,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9070,1,4,0)
 ;;=4^ Melanoma Of Skin
 ;;^UTILITY(U,$J,358.3,9070,1,5,0)
 ;;=5^172.8
 ;;^UTILITY(U,$J,358.3,9070,2)
 ;;=Malignant Melanoma of Skin^267183
 ;;^UTILITY(U,$J,358.3,9071,0)
 ;;=172.9^^55^606^10
 ;;^UTILITY(U,$J,358.3,9071,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9071,1,4,0)
 ;;=4^Malig Melanoma Skin NOS
 ;;^UTILITY(U,$J,358.3,9071,1,5,0)
 ;;=5^172.9
 ;;^UTILITY(U,$J,358.3,9071,2)
 ;;=^75462
 ;;^UTILITY(U,$J,358.3,9072,0)
 ;;=873.8^^55^607^14
 ;;^UTILITY(U,$J,358.3,9072,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9072,1,4,0)
 ;;=4^Laceration, Head, Nec
 ;;^UTILITY(U,$J,358.3,9072,1,5,0)
 ;;=5^873.8
 ;;^UTILITY(U,$J,358.3,9072,2)
 ;;=Laceration, Head, NEC^274970
 ;;^UTILITY(U,$J,358.3,9073,0)
 ;;=872.01^^55^607^2
 ;;^UTILITY(U,$J,358.3,9073,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9073,1,4,0)
 ;;=4^Laceration, Auricle
 ;;^UTILITY(U,$J,358.3,9073,1,5,0)
 ;;=5^872.01
 ;;^UTILITY(U,$J,358.3,9073,2)
 ;;=Laceration, Auricle^274898
 ;;^UTILITY(U,$J,358.3,9074,0)
 ;;=873.42^^55^607^11
 ;;^UTILITY(U,$J,358.3,9074,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9074,1,4,0)
 ;;=4^Laceration, Forehead
 ;;^UTILITY(U,$J,358.3,9074,1,5,0)
 ;;=5^873.42
 ;;^UTILITY(U,$J,358.3,9074,2)
 ;;=Laceration, Forehead^274943
 ;;^UTILITY(U,$J,358.3,9075,0)
 ;;=873.41^^55^607^5
 ;;^UTILITY(U,$J,358.3,9075,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9075,1,4,0)
 ;;=4^Laceration, Cheek
 ;;^UTILITY(U,$J,358.3,9075,1,5,0)
 ;;=5^873.41
 ;;^UTILITY(U,$J,358.3,9075,2)
 ;;=Laceration, Cheek^274940
 ;;^UTILITY(U,$J,358.3,9076,0)
 ;;=873.44^^55^607^16
 ;;^UTILITY(U,$J,358.3,9076,1,0)
 ;;=^358.31IA^5^2
