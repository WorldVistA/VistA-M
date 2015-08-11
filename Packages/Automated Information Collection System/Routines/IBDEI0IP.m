IBDEI0IP ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9076,1,4,0)
 ;;=4^Laceration, Jaw/Chin
 ;;^UTILITY(U,$J,358.3,9076,1,5,0)
 ;;=5^873.44
 ;;^UTILITY(U,$J,358.3,9076,2)
 ;;=Laceration, Jaw/Chin^274947
 ;;^UTILITY(U,$J,358.3,9077,0)
 ;;=872.8^^55^607^6
 ;;^UTILITY(U,$J,358.3,9077,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9077,1,4,0)
 ;;=4^Laceration, Ear
 ;;^UTILITY(U,$J,358.3,9077,1,5,0)
 ;;=5^872.8
 ;;^UTILITY(U,$J,358.3,9077,2)
 ;;=Laceration, Ear^274918
 ;;^UTILITY(U,$J,358.3,9078,0)
 ;;=873.40^^55^607^8
 ;;^UTILITY(U,$J,358.3,9078,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9078,1,4,0)
 ;;=4^Laceration, Face, Nos
 ;;^UTILITY(U,$J,358.3,9078,1,5,0)
 ;;=5^873.40
 ;;^UTILITY(U,$J,358.3,9078,2)
 ;;=Laceration, Face, NOS^274939
 ;;^UTILITY(U,$J,358.3,9079,0)
 ;;=874.8^^55^607^18
 ;;^UTILITY(U,$J,358.3,9079,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9079,1,4,0)
 ;;=4^Laceration, Neck
 ;;^UTILITY(U,$J,358.3,9079,1,5,0)
 ;;=5^874.8
 ;;^UTILITY(U,$J,358.3,9079,2)
 ;;=Laceration, Neck^274988
 ;;^UTILITY(U,$J,358.3,9080,0)
 ;;=873.20^^55^607^19
 ;;^UTILITY(U,$J,358.3,9080,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9080,1,4,0)
 ;;=4^Laceration, Nose
 ;;^UTILITY(U,$J,358.3,9080,1,5,0)
 ;;=5^873.20
 ;;^UTILITY(U,$J,358.3,9080,2)
 ;;=Laceration, Nose^274924
 ;;^UTILITY(U,$J,358.3,9081,0)
 ;;=873.0^^55^607^20
 ;;^UTILITY(U,$J,358.3,9081,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9081,1,4,0)
 ;;=4^Laceration, Scalp
 ;;^UTILITY(U,$J,358.3,9081,1,5,0)
 ;;=5^873.0
 ;;^UTILITY(U,$J,358.3,9081,2)
 ;;=Laceration, Scalp^274921
 ;;^UTILITY(U,$J,358.3,9082,0)
 ;;=880.02^^55^607^3
 ;;^UTILITY(U,$J,358.3,9082,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9082,1,4,0)
 ;;=4^Laceration, Axilla
 ;;^UTILITY(U,$J,358.3,9082,1,5,0)
 ;;=5^880.02
 ;;^UTILITY(U,$J,358.3,9082,2)
 ;;=Laceration, Axilla^275027
 ;;^UTILITY(U,$J,358.3,9083,0)
 ;;=877.0^^55^607^4
 ;;^UTILITY(U,$J,358.3,9083,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9083,1,4,0)
 ;;=4^Laceration, Buttock
 ;;^UTILITY(U,$J,358.3,9083,1,5,0)
 ;;=5^877.0
 ;;^UTILITY(U,$J,358.3,9083,2)
 ;;=Laceration, Buttock^274999
 ;;^UTILITY(U,$J,358.3,9084,0)
 ;;=879.4^^55^607^12
 ;;^UTILITY(U,$J,358.3,9084,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9084,1,4,0)
 ;;=4^Laceration, Groin/Inguinal
 ;;^UTILITY(U,$J,358.3,9084,1,5,0)
 ;;=5^879.4
 ;;^UTILITY(U,$J,358.3,9084,2)
 ;;=Laceration, Groin/Inguinal^275017
 ;;^UTILITY(U,$J,358.3,9085,0)
 ;;=884.0^^55^607^1
 ;;^UTILITY(U,$J,358.3,9085,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9085,1,4,0)
 ;;=4^Laceration, Arm Nos
 ;;^UTILITY(U,$J,358.3,9085,1,5,0)
 ;;=5^884.0
 ;;^UTILITY(U,$J,358.3,9085,2)
 ;;=Laceration, Arm NOS^275064
 ;;^UTILITY(U,$J,358.3,9086,0)
 ;;=883.0^^55^607^9
 ;;^UTILITY(U,$J,358.3,9086,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9086,1,4,0)
 ;;=4^Laceration, Finger
 ;;^UTILITY(U,$J,358.3,9086,1,5,0)
 ;;=5^883.0
 ;;^UTILITY(U,$J,358.3,9086,2)
 ;;=Laceration, Finger^275060
 ;;^UTILITY(U,$J,358.3,9087,0)
 ;;=881.01^^55^607^7
 ;;^UTILITY(U,$J,358.3,9087,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9087,1,4,0)
 ;;=4^Laceration, Elbow
 ;;^UTILITY(U,$J,358.3,9087,1,5,0)
 ;;=5^881.01
 ;;^UTILITY(U,$J,358.3,9087,2)
 ;;=Laceration, Elbow^275045
 ;;^UTILITY(U,$J,358.3,9088,0)
 ;;=882.0^^55^607^13
 ;;^UTILITY(U,$J,358.3,9088,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9088,1,4,0)
 ;;=4^Laceration, Hand
 ;;^UTILITY(U,$J,358.3,9088,1,5,0)
 ;;=5^882.0
 ;;^UTILITY(U,$J,358.3,9088,2)
 ;;=Laceration, Hand^275056
 ;;^UTILITY(U,$J,358.3,9089,0)
 ;;=881.02^^55^607^23
 ;;^UTILITY(U,$J,358.3,9089,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9089,1,4,0)
 ;;=4^Laceration, Wrist
