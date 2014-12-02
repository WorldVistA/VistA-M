IBDEI09J ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4407,2)
 ;;=Malignant Melanoma of Arm^267181
 ;;^UTILITY(U,$J,358.3,4408,0)
 ;;=172.7^^37^338^5
 ;;^UTILITY(U,$J,358.3,4408,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4408,1,4,0)
 ;;=4^ Melanoma Of Leg/Hip
 ;;^UTILITY(U,$J,358.3,4408,1,5,0)
 ;;=5^172.7
 ;;^UTILITY(U,$J,358.3,4408,2)
 ;;=Malignant Melanoma of Leg^267182
 ;;^UTILITY(U,$J,358.3,4409,0)
 ;;=172.8^^37^338^8
 ;;^UTILITY(U,$J,358.3,4409,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4409,1,4,0)
 ;;=4^ Melanoma Of Skin
 ;;^UTILITY(U,$J,358.3,4409,1,5,0)
 ;;=5^172.8
 ;;^UTILITY(U,$J,358.3,4409,2)
 ;;=Malignant Melanoma of Skin^267183
 ;;^UTILITY(U,$J,358.3,4410,0)
 ;;=172.9^^37^338^10
 ;;^UTILITY(U,$J,358.3,4410,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4410,1,4,0)
 ;;=4^Malig Melanoma Skin NOS
 ;;^UTILITY(U,$J,358.3,4410,1,5,0)
 ;;=5^172.9
 ;;^UTILITY(U,$J,358.3,4410,2)
 ;;=^75462
 ;;^UTILITY(U,$J,358.3,4411,0)
 ;;=873.8^^37^339^14
 ;;^UTILITY(U,$J,358.3,4411,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4411,1,4,0)
 ;;=4^Laceration, Head, Nec
 ;;^UTILITY(U,$J,358.3,4411,1,5,0)
 ;;=5^873.8
 ;;^UTILITY(U,$J,358.3,4411,2)
 ;;=Laceration, Head, NEC^274970
 ;;^UTILITY(U,$J,358.3,4412,0)
 ;;=872.01^^37^339^2
 ;;^UTILITY(U,$J,358.3,4412,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4412,1,4,0)
 ;;=4^Laceration, Auricle
 ;;^UTILITY(U,$J,358.3,4412,1,5,0)
 ;;=5^872.01
 ;;^UTILITY(U,$J,358.3,4412,2)
 ;;=Laceration, Auricle^274898
 ;;^UTILITY(U,$J,358.3,4413,0)
 ;;=873.42^^37^339^11
 ;;^UTILITY(U,$J,358.3,4413,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4413,1,4,0)
 ;;=4^Laceration, Forehead
 ;;^UTILITY(U,$J,358.3,4413,1,5,0)
 ;;=5^873.42
 ;;^UTILITY(U,$J,358.3,4413,2)
 ;;=Laceration, Forehead^274943
 ;;^UTILITY(U,$J,358.3,4414,0)
 ;;=873.41^^37^339^5
 ;;^UTILITY(U,$J,358.3,4414,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4414,1,4,0)
 ;;=4^Laceration, Cheek
 ;;^UTILITY(U,$J,358.3,4414,1,5,0)
 ;;=5^873.41
 ;;^UTILITY(U,$J,358.3,4414,2)
 ;;=Laceration, Cheek^274940
 ;;^UTILITY(U,$J,358.3,4415,0)
 ;;=873.44^^37^339^16
 ;;^UTILITY(U,$J,358.3,4415,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4415,1,4,0)
 ;;=4^Laceration, Jaw/Chin
 ;;^UTILITY(U,$J,358.3,4415,1,5,0)
 ;;=5^873.44
 ;;^UTILITY(U,$J,358.3,4415,2)
 ;;=Laceration, Jaw/Chin^274947
 ;;^UTILITY(U,$J,358.3,4416,0)
 ;;=872.8^^37^339^6
 ;;^UTILITY(U,$J,358.3,4416,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4416,1,4,0)
 ;;=4^Laceration, Ear
 ;;^UTILITY(U,$J,358.3,4416,1,5,0)
 ;;=5^872.8
 ;;^UTILITY(U,$J,358.3,4416,2)
 ;;=Laceration, Ear^274918
 ;;^UTILITY(U,$J,358.3,4417,0)
 ;;=873.40^^37^339^8
 ;;^UTILITY(U,$J,358.3,4417,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4417,1,4,0)
 ;;=4^Laceration, Face, Nos
 ;;^UTILITY(U,$J,358.3,4417,1,5,0)
 ;;=5^873.40
 ;;^UTILITY(U,$J,358.3,4417,2)
 ;;=Laceration, Face, NOS^274939
 ;;^UTILITY(U,$J,358.3,4418,0)
 ;;=874.8^^37^339^18
 ;;^UTILITY(U,$J,358.3,4418,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4418,1,4,0)
 ;;=4^Laceration, Neck
 ;;^UTILITY(U,$J,358.3,4418,1,5,0)
 ;;=5^874.8
 ;;^UTILITY(U,$J,358.3,4418,2)
 ;;=Laceration, Neck^274988
 ;;^UTILITY(U,$J,358.3,4419,0)
 ;;=873.20^^37^339^19
 ;;^UTILITY(U,$J,358.3,4419,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4419,1,4,0)
 ;;=4^Laceration, Nose
 ;;^UTILITY(U,$J,358.3,4419,1,5,0)
 ;;=5^873.20
 ;;^UTILITY(U,$J,358.3,4419,2)
 ;;=Laceration, Nose^274924
 ;;^UTILITY(U,$J,358.3,4420,0)
 ;;=873.0^^37^339^20
 ;;^UTILITY(U,$J,358.3,4420,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4420,1,4,0)
 ;;=4^Laceration, Scalp
 ;;^UTILITY(U,$J,358.3,4420,1,5,0)
 ;;=5^873.0
 ;;^UTILITY(U,$J,358.3,4420,2)
 ;;=Laceration, Scalp^274921
