IBDEI06U ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3005,2)
 ;;=Laceration, Hand^275056
 ;;^UTILITY(U,$J,358.3,3006,0)
 ;;=881.02^^26^244^23
 ;;^UTILITY(U,$J,358.3,3006,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3006,1,4,0)
 ;;=4^Laceration, Wrist
 ;;^UTILITY(U,$J,358.3,3006,1,5,0)
 ;;=5^881.02
 ;;^UTILITY(U,$J,358.3,3006,2)
 ;;=Laceration, Wrist^275046
 ;;^UTILITY(U,$J,358.3,3007,0)
 ;;=880.00^^26^244^21
 ;;^UTILITY(U,$J,358.3,3007,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3007,1,4,0)
 ;;=4^Laceration, Shoulder
 ;;^UTILITY(U,$J,358.3,3007,1,5,0)
 ;;=5^880.00
 ;;^UTILITY(U,$J,358.3,3007,2)
 ;;=Laceration, Shoulder^275025
 ;;^UTILITY(U,$J,358.3,3008,0)
 ;;=890.0^^26^244^15
 ;;^UTILITY(U,$J,358.3,3008,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3008,1,4,0)
 ;;=4^Laceration, Hip/Thigh
 ;;^UTILITY(U,$J,358.3,3008,1,5,0)
 ;;=5^890.0
 ;;^UTILITY(U,$J,358.3,3008,2)
 ;;=Laceration, Hip/Thigh^275083
 ;;^UTILITY(U,$J,358.3,3009,0)
 ;;=891.0^^26^244^17
 ;;^UTILITY(U,$J,358.3,3009,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3009,1,4,0)
 ;;=4^Laceration, Knee/Leg/Ankle
 ;;^UTILITY(U,$J,358.3,3009,1,5,0)
 ;;=5^891.0
 ;;^UTILITY(U,$J,358.3,3009,2)
 ;;=Laceration, Knee/Leg/Ankle^275087
 ;;^UTILITY(U,$J,358.3,3010,0)
 ;;=893.0^^26^244^22
 ;;^UTILITY(U,$J,358.3,3010,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3010,1,4,0)
 ;;=4^Laceration, Toe
 ;;^UTILITY(U,$J,358.3,3010,1,5,0)
 ;;=5^893.0
 ;;^UTILITY(U,$J,358.3,3010,2)
 ;;=Laceration, Toe^275095
 ;;^UTILITY(U,$J,358.3,3011,0)
 ;;=892.0^^26^244^10
 ;;^UTILITY(U,$J,358.3,3011,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3011,1,4,0)
 ;;=4^Laceration, Foot
 ;;^UTILITY(U,$J,358.3,3011,1,5,0)
 ;;=5^892.0
 ;;^UTILITY(U,$J,358.3,3011,2)
 ;;=Laceration, Fott^275091
 ;;^UTILITY(U,$J,358.3,3012,0)
 ;;=209.31^^26^245^1
 ;;^UTILITY(U,$J,358.3,3012,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3012,1,4,0)
 ;;=4^Merkel Cell CA-Face
 ;;^UTILITY(U,$J,358.3,3012,1,5,0)
 ;;=5^209.31
 ;;^UTILITY(U,$J,358.3,3012,2)
 ;;=^338212
 ;;^UTILITY(U,$J,358.3,3013,0)
 ;;=209.32^^26^245^2
 ;;^UTILITY(U,$J,358.3,3013,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3013,1,4,0)
 ;;=4^Merkel Cell CA-Sclp/Neck
 ;;^UTILITY(U,$J,358.3,3013,1,5,0)
 ;;=5^209.32
 ;;^UTILITY(U,$J,358.3,3013,2)
 ;;=^338213
 ;;^UTILITY(U,$J,358.3,3014,0)
 ;;=209.33^^26^245^3
 ;;^UTILITY(U,$J,358.3,3014,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3014,1,4,0)
 ;;=4^Merkel Cell CA-Upper Limb
 ;;^UTILITY(U,$J,358.3,3014,1,5,0)
 ;;=5^209.33
 ;;^UTILITY(U,$J,358.3,3014,2)
 ;;=^338214
 ;;^UTILITY(U,$J,358.3,3015,0)
 ;;=209.34^^26^245^4
 ;;^UTILITY(U,$J,358.3,3015,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3015,1,4,0)
 ;;=4^Merkel Cell CA-Lower Limb
 ;;^UTILITY(U,$J,358.3,3015,1,5,0)
 ;;=5^209.34
 ;;^UTILITY(U,$J,358.3,3015,2)
 ;;=^338215
 ;;^UTILITY(U,$J,358.3,3016,0)
 ;;=209.35^^26^245^5
 ;;^UTILITY(U,$J,358.3,3016,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3016,1,4,0)
 ;;=4^Merkel Cell-Trunk
 ;;^UTILITY(U,$J,358.3,3016,1,5,0)
 ;;=5^209.35
 ;;^UTILITY(U,$J,358.3,3016,2)
 ;;=^338216
 ;;^UTILITY(U,$J,358.3,3017,0)
 ;;=209.36^^26^245^6
 ;;^UTILITY(U,$J,358.3,3017,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3017,1,4,0)
 ;;=4^Merkel Cell CA-Oth Sites
 ;;^UTILITY(U,$J,358.3,3017,1,5,0)
 ;;=5^209.36
 ;;^UTILITY(U,$J,358.3,3017,2)
 ;;=^338217
 ;;^UTILITY(U,$J,358.3,3018,0)
 ;;=V67.09^^26^246^11
 ;;^UTILITY(U,$J,358.3,3018,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3018,1,4,0)
 ;;=4^F/U exam, Following Surg
 ;;^UTILITY(U,$J,358.3,3018,1,5,0)
 ;;=5^V67.09
 ;;^UTILITY(U,$J,358.3,3018,2)
 ;;=F/U exam, completed treatment^322080
 ;;^UTILITY(U,$J,358.3,3019,0)
 ;;=V58.42^^26^246^1
