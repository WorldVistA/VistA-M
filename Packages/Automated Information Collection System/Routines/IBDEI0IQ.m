IBDEI0IQ ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9089,1,5,0)
 ;;=5^881.02
 ;;^UTILITY(U,$J,358.3,9089,2)
 ;;=Laceration, Wrist^275046
 ;;^UTILITY(U,$J,358.3,9090,0)
 ;;=880.00^^55^607^21
 ;;^UTILITY(U,$J,358.3,9090,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9090,1,4,0)
 ;;=4^Laceration, Shoulder
 ;;^UTILITY(U,$J,358.3,9090,1,5,0)
 ;;=5^880.00
 ;;^UTILITY(U,$J,358.3,9090,2)
 ;;=Laceration, Shoulder^275025
 ;;^UTILITY(U,$J,358.3,9091,0)
 ;;=890.0^^55^607^15
 ;;^UTILITY(U,$J,358.3,9091,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9091,1,4,0)
 ;;=4^Laceration, Hip/Thigh
 ;;^UTILITY(U,$J,358.3,9091,1,5,0)
 ;;=5^890.0
 ;;^UTILITY(U,$J,358.3,9091,2)
 ;;=Laceration, Hip/Thigh^275083
 ;;^UTILITY(U,$J,358.3,9092,0)
 ;;=891.0^^55^607^17
 ;;^UTILITY(U,$J,358.3,9092,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9092,1,4,0)
 ;;=4^Laceration, Knee/Leg/Ankle
 ;;^UTILITY(U,$J,358.3,9092,1,5,0)
 ;;=5^891.0
 ;;^UTILITY(U,$J,358.3,9092,2)
 ;;=Laceration, Knee/Leg/Ankle^275087
 ;;^UTILITY(U,$J,358.3,9093,0)
 ;;=893.0^^55^607^22
 ;;^UTILITY(U,$J,358.3,9093,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9093,1,4,0)
 ;;=4^Laceration, Toe
 ;;^UTILITY(U,$J,358.3,9093,1,5,0)
 ;;=5^893.0
 ;;^UTILITY(U,$J,358.3,9093,2)
 ;;=Laceration, Toe^275095
 ;;^UTILITY(U,$J,358.3,9094,0)
 ;;=892.0^^55^607^10
 ;;^UTILITY(U,$J,358.3,9094,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9094,1,4,0)
 ;;=4^Laceration, Foot
 ;;^UTILITY(U,$J,358.3,9094,1,5,0)
 ;;=5^892.0
 ;;^UTILITY(U,$J,358.3,9094,2)
 ;;=Laceration, Fott^275091
 ;;^UTILITY(U,$J,358.3,9095,0)
 ;;=209.31^^55^608^1
 ;;^UTILITY(U,$J,358.3,9095,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9095,1,4,0)
 ;;=4^Merkel Cell CA-Face
 ;;^UTILITY(U,$J,358.3,9095,1,5,0)
 ;;=5^209.31
 ;;^UTILITY(U,$J,358.3,9095,2)
 ;;=^338212
 ;;^UTILITY(U,$J,358.3,9096,0)
 ;;=209.32^^55^608^2
 ;;^UTILITY(U,$J,358.3,9096,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9096,1,4,0)
 ;;=4^Merkel Cell CA-Sclp/Neck
 ;;^UTILITY(U,$J,358.3,9096,1,5,0)
 ;;=5^209.32
 ;;^UTILITY(U,$J,358.3,9096,2)
 ;;=^338213
 ;;^UTILITY(U,$J,358.3,9097,0)
 ;;=209.33^^55^608^3
 ;;^UTILITY(U,$J,358.3,9097,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9097,1,4,0)
 ;;=4^Merkel Cell CA-Upper Limb
 ;;^UTILITY(U,$J,358.3,9097,1,5,0)
 ;;=5^209.33
 ;;^UTILITY(U,$J,358.3,9097,2)
 ;;=^338214
 ;;^UTILITY(U,$J,358.3,9098,0)
 ;;=209.34^^55^608^4
 ;;^UTILITY(U,$J,358.3,9098,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9098,1,4,0)
 ;;=4^Merkel Cell CA-Lower Limb
 ;;^UTILITY(U,$J,358.3,9098,1,5,0)
 ;;=5^209.34
 ;;^UTILITY(U,$J,358.3,9098,2)
 ;;=^338215
 ;;^UTILITY(U,$J,358.3,9099,0)
 ;;=209.35^^55^608^5
 ;;^UTILITY(U,$J,358.3,9099,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9099,1,4,0)
 ;;=4^Merkel Cell-Trunk
 ;;^UTILITY(U,$J,358.3,9099,1,5,0)
 ;;=5^209.35
 ;;^UTILITY(U,$J,358.3,9099,2)
 ;;=^338216
 ;;^UTILITY(U,$J,358.3,9100,0)
 ;;=209.36^^55^608^6
 ;;^UTILITY(U,$J,358.3,9100,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9100,1,4,0)
 ;;=4^Merkel Cell CA-Oth Sites
 ;;^UTILITY(U,$J,358.3,9100,1,5,0)
 ;;=5^209.36
 ;;^UTILITY(U,$J,358.3,9100,2)
 ;;=^338217
 ;;^UTILITY(U,$J,358.3,9101,0)
 ;;=V67.09^^55^609^11
 ;;^UTILITY(U,$J,358.3,9101,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9101,1,4,0)
 ;;=4^F/U exam, Following Surg
 ;;^UTILITY(U,$J,358.3,9101,1,5,0)
 ;;=5^V67.09
 ;;^UTILITY(U,$J,358.3,9101,2)
 ;;=F/U exam, completed treatment^322080
 ;;^UTILITY(U,$J,358.3,9102,0)
 ;;=V58.42^^55^609^1
 ;;^UTILITY(U,$J,358.3,9102,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9102,1,4,0)
 ;;=4^Aftercare after CA surgery
 ;;^UTILITY(U,$J,358.3,9102,1,5,0)
 ;;=5^V58.42
 ;;^UTILITY(U,$J,358.3,9102,2)
 ;;=Aftercare after CA surgery^295530
