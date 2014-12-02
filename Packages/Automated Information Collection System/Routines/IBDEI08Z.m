IBDEI08Z ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4110,1,2,0)
 ;;=2^Bx,Breast w/Device w/MRI,1st Lesion
 ;;^UTILITY(U,$J,358.3,4110,1,4,0)
 ;;=4^19085
 ;;^UTILITY(U,$J,358.3,4111,0)
 ;;=19086^^36^309^2^^^^1
 ;;^UTILITY(U,$J,358.3,4111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4111,1,2,0)
 ;;=2^Bx,Breast w/Device w/MRI,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,4111,1,4,0)
 ;;=4^19086
 ;;^UTILITY(U,$J,358.3,4112,0)
 ;;=10060^^36^310^15
 ;;^UTILITY(U,$J,358.3,4112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4112,1,2,0)
 ;;=2^I&D abscess,simple or single
 ;;^UTILITY(U,$J,358.3,4112,1,4,0)
 ;;=4^10060
 ;;^UTILITY(U,$J,358.3,4113,0)
 ;;=10061^^36^310^14
 ;;^UTILITY(U,$J,358.3,4113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4113,1,2,0)
 ;;=2^I&D abscess,complic or multip
 ;;^UTILITY(U,$J,358.3,4113,1,4,0)
 ;;=4^10061
 ;;^UTILITY(U,$J,358.3,4114,0)
 ;;=10160^^36^310^20
 ;;^UTILITY(U,$J,358.3,4114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4114,1,2,0)
 ;;=2^Needle asp absc/cyst/hematoma
 ;;^UTILITY(U,$J,358.3,4114,1,4,0)
 ;;=4^10160
 ;;^UTILITY(U,$J,358.3,4115,0)
 ;;=10140^^36^310^17
 ;;^UTILITY(U,$J,358.3,4115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4115,1,2,0)
 ;;=2^I&D hematoma/seroma,skin
 ;;^UTILITY(U,$J,358.3,4115,1,4,0)
 ;;=4^10140
 ;;^UTILITY(U,$J,358.3,4116,0)
 ;;=19000^^36^310^5
 ;;^UTILITY(U,$J,358.3,4116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4116,1,2,0)
 ;;=2^Aspirate breast cyst, first
 ;;^UTILITY(U,$J,358.3,4116,1,4,0)
 ;;=4^19000
 ;;^UTILITY(U,$J,358.3,4117,0)
 ;;=19001^^36^310^6
 ;;^UTILITY(U,$J,358.3,4117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4117,1,2,0)
 ;;=2^Aspirate each addit breast cyst
 ;;^UTILITY(U,$J,358.3,4117,1,4,0)
 ;;=4^19001
 ;;^UTILITY(U,$J,358.3,4118,0)
 ;;=26011^^36^310^7
 ;;^UTILITY(U,$J,358.3,4118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4118,1,2,0)
 ;;=2^Drain abscess finger,complic
 ;;^UTILITY(U,$J,358.3,4118,1,4,0)
 ;;=4^26011
 ;;^UTILITY(U,$J,358.3,4119,0)
 ;;=26020^^36^310^11
 ;;^UTILITY(U,$J,358.3,4119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4119,1,2,0)
 ;;=2^Drain tendon sheath,Ea Hand
 ;;^UTILITY(U,$J,358.3,4119,1,4,0)
 ;;=4^26020
 ;;^UTILITY(U,$J,358.3,4120,0)
 ;;=10120^^36^310^22
 ;;^UTILITY(U,$J,358.3,4120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4120,1,2,0)
 ;;=2^Removal,foreign body,simple
 ;;^UTILITY(U,$J,358.3,4120,1,4,0)
 ;;=4^10120
 ;;^UTILITY(U,$J,358.3,4121,0)
 ;;=10121^^36^310^21
 ;;^UTILITY(U,$J,358.3,4121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4121,1,2,0)
 ;;=2^Removal,foreign body,complex
 ;;^UTILITY(U,$J,358.3,4121,1,4,0)
 ;;=4^10121
 ;;^UTILITY(U,$J,358.3,4122,0)
 ;;=26010^^36^310^8^^^^1
 ;;^UTILITY(U,$J,358.3,4122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4122,1,2,0)
 ;;=2^Drain abscess finger,simple
 ;;^UTILITY(U,$J,358.3,4122,1,4,0)
 ;;=4^26010
 ;;^UTILITY(U,$J,358.3,4123,0)
 ;;=10180^^36^310^16^^^^1
 ;;^UTILITY(U,$J,358.3,4123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4123,1,2,0)
 ;;=2^I&D complex postop wound
 ;;^UTILITY(U,$J,358.3,4123,1,4,0)
 ;;=4^10180
 ;;^UTILITY(U,$J,358.3,4124,0)
 ;;=20600^^36^310^4^^^^1
 ;;^UTILITY(U,$J,358.3,4124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4124,1,2,0)
 ;;=2^Aspir/inject bursa/small joint
 ;;^UTILITY(U,$J,358.3,4124,1,4,0)
 ;;=4^20600
 ;;^UTILITY(U,$J,358.3,4125,0)
 ;;=20605^^36^310^2^^^^1
 ;;^UTILITY(U,$J,358.3,4125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4125,1,2,0)
 ;;=2^Aspir/inject bursa/intmed joint
 ;;^UTILITY(U,$J,358.3,4125,1,4,0)
 ;;=4^20605
 ;;^UTILITY(U,$J,358.3,4126,0)
 ;;=20610^^36^310^3^^^^1
 ;;^UTILITY(U,$J,358.3,4126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4126,1,2,0)
 ;;=2^Aspir/inject bursa/large joint
