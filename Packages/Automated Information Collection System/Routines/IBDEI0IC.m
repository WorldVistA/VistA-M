IBDEI0IC ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8933,1,5,0)
 ;;=5^172.8
 ;;^UTILITY(U,$J,358.3,8933,2)
 ;;=Malignant Melanoma of Skin^267183
 ;;^UTILITY(U,$J,358.3,8934,0)
 ;;=172.9^^61^629^10
 ;;^UTILITY(U,$J,358.3,8934,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8934,1,4,0)
 ;;=4^Malig Melanoma Skin NOS
 ;;^UTILITY(U,$J,358.3,8934,1,5,0)
 ;;=5^172.9
 ;;^UTILITY(U,$J,358.3,8934,2)
 ;;=^75462
 ;;^UTILITY(U,$J,358.3,8935,0)
 ;;=873.8^^61^630^14
 ;;^UTILITY(U,$J,358.3,8935,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8935,1,4,0)
 ;;=4^Laceration, Head, Nec
 ;;^UTILITY(U,$J,358.3,8935,1,5,0)
 ;;=5^873.8
 ;;^UTILITY(U,$J,358.3,8935,2)
 ;;=Laceration, Head, NEC^274970
 ;;^UTILITY(U,$J,358.3,8936,0)
 ;;=872.01^^61^630^2
 ;;^UTILITY(U,$J,358.3,8936,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8936,1,4,0)
 ;;=4^Laceration, Auricle
 ;;^UTILITY(U,$J,358.3,8936,1,5,0)
 ;;=5^872.01
 ;;^UTILITY(U,$J,358.3,8936,2)
 ;;=Laceration, Auricle^274898
 ;;^UTILITY(U,$J,358.3,8937,0)
 ;;=873.42^^61^630^11
 ;;^UTILITY(U,$J,358.3,8937,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8937,1,4,0)
 ;;=4^Laceration, Forehead
 ;;^UTILITY(U,$J,358.3,8937,1,5,0)
 ;;=5^873.42
 ;;^UTILITY(U,$J,358.3,8937,2)
 ;;=Laceration, Forehead^274943
 ;;^UTILITY(U,$J,358.3,8938,0)
 ;;=873.41^^61^630^5
 ;;^UTILITY(U,$J,358.3,8938,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8938,1,4,0)
 ;;=4^Laceration, Cheek
 ;;^UTILITY(U,$J,358.3,8938,1,5,0)
 ;;=5^873.41
 ;;^UTILITY(U,$J,358.3,8938,2)
 ;;=Laceration, Cheek^274940
 ;;^UTILITY(U,$J,358.3,8939,0)
 ;;=873.44^^61^630^16
 ;;^UTILITY(U,$J,358.3,8939,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8939,1,4,0)
 ;;=4^Laceration, Jaw/Chin
 ;;^UTILITY(U,$J,358.3,8939,1,5,0)
 ;;=5^873.44
 ;;^UTILITY(U,$J,358.3,8939,2)
 ;;=Laceration, Jaw/Chin^274947
 ;;^UTILITY(U,$J,358.3,8940,0)
 ;;=872.8^^61^630^6
 ;;^UTILITY(U,$J,358.3,8940,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8940,1,4,0)
 ;;=4^Laceration, Ear
 ;;^UTILITY(U,$J,358.3,8940,1,5,0)
 ;;=5^872.8
 ;;^UTILITY(U,$J,358.3,8940,2)
 ;;=Laceration, Ear^274918
 ;;^UTILITY(U,$J,358.3,8941,0)
 ;;=873.40^^61^630^8
 ;;^UTILITY(U,$J,358.3,8941,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8941,1,4,0)
 ;;=4^Laceration, Face, Nos
 ;;^UTILITY(U,$J,358.3,8941,1,5,0)
 ;;=5^873.40
 ;;^UTILITY(U,$J,358.3,8941,2)
 ;;=Laceration, Face, NOS^274939
 ;;^UTILITY(U,$J,358.3,8942,0)
 ;;=874.8^^61^630^18
 ;;^UTILITY(U,$J,358.3,8942,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8942,1,4,0)
 ;;=4^Laceration, Neck
 ;;^UTILITY(U,$J,358.3,8942,1,5,0)
 ;;=5^874.8
 ;;^UTILITY(U,$J,358.3,8942,2)
 ;;=Laceration, Neck^274988
 ;;^UTILITY(U,$J,358.3,8943,0)
 ;;=873.20^^61^630^19
 ;;^UTILITY(U,$J,358.3,8943,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8943,1,4,0)
 ;;=4^Laceration, Nose
 ;;^UTILITY(U,$J,358.3,8943,1,5,0)
 ;;=5^873.20
 ;;^UTILITY(U,$J,358.3,8943,2)
 ;;=Laceration, Nose^274924
 ;;^UTILITY(U,$J,358.3,8944,0)
 ;;=873.0^^61^630^20
 ;;^UTILITY(U,$J,358.3,8944,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8944,1,4,0)
 ;;=4^Laceration, Scalp
 ;;^UTILITY(U,$J,358.3,8944,1,5,0)
 ;;=5^873.0
 ;;^UTILITY(U,$J,358.3,8944,2)
 ;;=Laceration, Scalp^274921
 ;;^UTILITY(U,$J,358.3,8945,0)
 ;;=880.02^^61^630^3
 ;;^UTILITY(U,$J,358.3,8945,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8945,1,4,0)
 ;;=4^Laceration, Axilla
 ;;^UTILITY(U,$J,358.3,8945,1,5,0)
 ;;=5^880.02
 ;;^UTILITY(U,$J,358.3,8945,2)
 ;;=Laceration, Axilla^275027
 ;;^UTILITY(U,$J,358.3,8946,0)
 ;;=877.0^^61^630^4
 ;;^UTILITY(U,$J,358.3,8946,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8946,1,4,0)
 ;;=4^Laceration, Buttock
 ;;^UTILITY(U,$J,358.3,8946,1,5,0)
 ;;=5^877.0
