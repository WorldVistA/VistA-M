IBDEI03T ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3506,1,2,0)
 ;;=2^Bx,Skin/Sub,1st lesion
 ;;^UTILITY(U,$J,358.3,3506,1,4,0)
 ;;=4^11100
 ;;^UTILITY(U,$J,358.3,3507,0)
 ;;=11101^^29^266^10^^^^1
 ;;^UTILITY(U,$J,358.3,3507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3507,1,2,0)
 ;;=2^Bx,Skin/Sub,Ea Addl lesion
 ;;^UTILITY(U,$J,358.3,3507,1,4,0)
 ;;=4^11101
 ;;^UTILITY(U,$J,358.3,3508,0)
 ;;=11004^^29^266^16^^^^1
 ;;^UTILITY(U,$J,358.3,3508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3508,1,2,0)
 ;;=2^Debride Genital/Perineum/Mus/Fascia
 ;;^UTILITY(U,$J,358.3,3508,1,4,0)
 ;;=4^11004
 ;;^UTILITY(U,$J,358.3,3509,0)
 ;;=11000^^29^266^17^^^^1
 ;;^UTILITY(U,$J,358.3,3509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3509,1,2,0)
 ;;=2^Debride infect skin 10% or less
 ;;^UTILITY(U,$J,358.3,3509,1,4,0)
 ;;=4^11000
 ;;^UTILITY(U,$J,358.3,3510,0)
 ;;=11042^^29^266^21^^^^1
 ;;^UTILITY(U,$J,358.3,3510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3510,1,2,0)
 ;;=2^Debride skin/SQ,20sq cm or <
 ;;^UTILITY(U,$J,358.3,3510,1,4,0)
 ;;=4^11042
 ;;^UTILITY(U,$J,358.3,3511,0)
 ;;=11043^^29^266^19^^^^1
 ;;^UTILITY(U,$J,358.3,3511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3511,1,2,0)
 ;;=2^Debride muscle,20sq cm or <
 ;;^UTILITY(U,$J,358.3,3511,1,4,0)
 ;;=4^11043
 ;;^UTILITY(U,$J,358.3,3512,0)
 ;;=11044^^29^266^13^^^^1
 ;;^UTILITY(U,$J,358.3,3512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3512,1,2,0)
 ;;=2^Debride Bone,20sq cm or <
 ;;^UTILITY(U,$J,358.3,3512,1,4,0)
 ;;=4^11044
 ;;^UTILITY(U,$J,358.3,3513,0)
 ;;=11001^^29^266^18^^^^1
 ;;^UTILITY(U,$J,358.3,3513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3513,1,2,0)
 ;;=2^Debride infect skin Ea Addl 10%
 ;;^UTILITY(U,$J,358.3,3513,1,4,0)
 ;;=4^11001
 ;;^UTILITY(U,$J,358.3,3514,0)
 ;;=11045^^29^266^22^^^^1
 ;;^UTILITY(U,$J,358.3,3514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3514,1,2,0)
 ;;=2^Debride skin/SQ,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,3514,1,4,0)
 ;;=4^11045
 ;;^UTILITY(U,$J,358.3,3515,0)
 ;;=11046^^29^266^20^^^^1
 ;;^UTILITY(U,$J,358.3,3515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3515,1,2,0)
 ;;=2^Debride muscle,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,3515,1,4,0)
 ;;=4^11046
 ;;^UTILITY(U,$J,358.3,3516,0)
 ;;=11047^^29^266^14^^^^1
 ;;^UTILITY(U,$J,358.3,3516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3516,1,2,0)
 ;;=2^Debride Bone,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,3516,1,4,0)
 ;;=4^11047
 ;;^UTILITY(U,$J,358.3,3517,0)
 ;;=19081^^29^266^3^^^^1
 ;;^UTILITY(U,$J,358.3,3517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3517,1,2,0)
 ;;=2^Bx,Breast w/Device w/Stereotactic Guide,1st Lesion
 ;;^UTILITY(U,$J,358.3,3517,1,4,0)
 ;;=4^19081
 ;;^UTILITY(U,$J,358.3,3518,0)
 ;;=19082^^29^266^4^^^^1
 ;;^UTILITY(U,$J,358.3,3518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3518,1,2,0)
 ;;=2^Bx,Breast w/Device w/Stereotactic Guide,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,3518,1,4,0)
 ;;=4^19082
 ;;^UTILITY(U,$J,358.3,3519,0)
 ;;=19083^^29^266^5^^^^1
 ;;^UTILITY(U,$J,358.3,3519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3519,1,2,0)
 ;;=2^Bx,Breast w/Device w/US,1st Lesion
 ;;^UTILITY(U,$J,358.3,3519,1,4,0)
 ;;=4^19083
 ;;^UTILITY(U,$J,358.3,3520,0)
 ;;=19084^^29^266^6^^^^1
 ;;^UTILITY(U,$J,358.3,3520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3520,1,2,0)
 ;;=2^Bx,Breast w/Device w/US,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,3520,1,4,0)
 ;;=4^19084
 ;;^UTILITY(U,$J,358.3,3521,0)
 ;;=19085^^29^266^1^^^^1
 ;;^UTILITY(U,$J,358.3,3521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3521,1,2,0)
 ;;=2^Bx,Breast w/Device w/MRI,1st Lesion
 ;;^UTILITY(U,$J,358.3,3521,1,4,0)
 ;;=4^19085
 ;;^UTILITY(U,$J,358.3,3522,0)
 ;;=19086^^29^266^2^^^^1
 ;;^UTILITY(U,$J,358.3,3522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3522,1,2,0)
 ;;=2^Bx,Breast w/Device w/MRI,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,3522,1,4,0)
 ;;=4^19086
 ;;^UTILITY(U,$J,358.3,3523,0)
 ;;=97602^^29^266^11^^^^1
 ;;^UTILITY(U,$J,358.3,3523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3523,1,2,0)
 ;;=2^Deb Non-Selective w/ Collagenase
 ;;^UTILITY(U,$J,358.3,3523,1,4,0)
 ;;=4^97602
 ;;^UTILITY(U,$J,358.3,3524,0)
 ;;=10060^^29^267^17
 ;;^UTILITY(U,$J,358.3,3524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3524,1,2,0)
 ;;=2^I&D abscess,simple or single
 ;;^UTILITY(U,$J,358.3,3524,1,4,0)
 ;;=4^10060
 ;;^UTILITY(U,$J,358.3,3525,0)
 ;;=10061^^29^267^16
 ;;^UTILITY(U,$J,358.3,3525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3525,1,2,0)
 ;;=2^I&D abscess,complic or multip
 ;;^UTILITY(U,$J,358.3,3525,1,4,0)
 ;;=4^10061
 ;;^UTILITY(U,$J,358.3,3526,0)
 ;;=10160^^29^267^22
 ;;^UTILITY(U,$J,358.3,3526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3526,1,2,0)
 ;;=2^Needle asp absc/cyst/hematoma
 ;;^UTILITY(U,$J,358.3,3526,1,4,0)
 ;;=4^10160
 ;;^UTILITY(U,$J,358.3,3527,0)
 ;;=10140^^29^267^19
 ;;^UTILITY(U,$J,358.3,3527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3527,1,2,0)
 ;;=2^I&D hematoma/seroma,skin
 ;;^UTILITY(U,$J,358.3,3527,1,4,0)
 ;;=4^10140
 ;;^UTILITY(U,$J,358.3,3528,0)
 ;;=19000^^29^267^7
 ;;^UTILITY(U,$J,358.3,3528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3528,1,2,0)
 ;;=2^Aspirate breast cyst, first
 ;;^UTILITY(U,$J,358.3,3528,1,4,0)
 ;;=4^19000
 ;;^UTILITY(U,$J,358.3,3529,0)
 ;;=19001^^29^267^8
 ;;^UTILITY(U,$J,358.3,3529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3529,1,2,0)
 ;;=2^Aspirate each addit breast cyst
 ;;^UTILITY(U,$J,358.3,3529,1,4,0)
 ;;=4^19001
 ;;^UTILITY(U,$J,358.3,3530,0)
 ;;=26011^^29^267^9
 ;;^UTILITY(U,$J,358.3,3530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3530,1,2,0)
 ;;=2^Drain abscess finger,complic
 ;;^UTILITY(U,$J,358.3,3530,1,4,0)
 ;;=4^26011
 ;;^UTILITY(U,$J,358.3,3531,0)
 ;;=26020^^29^267^13
 ;;^UTILITY(U,$J,358.3,3531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3531,1,2,0)
 ;;=2^Drain tendon sheath,Ea Hand
 ;;^UTILITY(U,$J,358.3,3531,1,4,0)
 ;;=4^26020
 ;;^UTILITY(U,$J,358.3,3532,0)
 ;;=10120^^29^267^24
 ;;^UTILITY(U,$J,358.3,3532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3532,1,2,0)
 ;;=2^Removal,foreign body,simple
 ;;^UTILITY(U,$J,358.3,3532,1,4,0)
 ;;=4^10120
 ;;^UTILITY(U,$J,358.3,3533,0)
 ;;=10121^^29^267^23
 ;;^UTILITY(U,$J,358.3,3533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3533,1,2,0)
 ;;=2^Removal,foreign body,complex
 ;;^UTILITY(U,$J,358.3,3533,1,4,0)
 ;;=4^10121
 ;;^UTILITY(U,$J,358.3,3534,0)
 ;;=26010^^29^267^10^^^^1
 ;;^UTILITY(U,$J,358.3,3534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3534,1,2,0)
 ;;=2^Drain abscess finger,simple
 ;;^UTILITY(U,$J,358.3,3534,1,4,0)
 ;;=4^26010
 ;;^UTILITY(U,$J,358.3,3535,0)
 ;;=10180^^29^267^18^^^^1
 ;;^UTILITY(U,$J,358.3,3535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3535,1,2,0)
 ;;=2^I&D complex postop wound
 ;;^UTILITY(U,$J,358.3,3535,1,4,0)
 ;;=4^10180
 ;;^UTILITY(U,$J,358.3,3536,0)
 ;;=20600^^29^267^6^^^^1
 ;;^UTILITY(U,$J,358.3,3536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3536,1,2,0)
 ;;=2^Aspir/inject bursa/small joint w/o US
 ;;^UTILITY(U,$J,358.3,3536,1,4,0)
 ;;=4^20600
 ;;^UTILITY(U,$J,358.3,3537,0)
 ;;=20605^^29^267^2^^^^1
 ;;^UTILITY(U,$J,358.3,3537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3537,1,2,0)
 ;;=2^Aspir/inject bursa/intmed joint w/o US
 ;;^UTILITY(U,$J,358.3,3537,1,4,0)
 ;;=4^20605
 ;;^UTILITY(U,$J,358.3,3538,0)
 ;;=20610^^29^267^4^^^^1
 ;;^UTILITY(U,$J,358.3,3538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3538,1,2,0)
 ;;=2^Aspir/inject bursa/large joint w/o US
 ;;^UTILITY(U,$J,358.3,3538,1,4,0)
 ;;=4^20610
 ;;^UTILITY(U,$J,358.3,3539,0)
 ;;=10080^^29^267^11^^^^1
 ;;^UTILITY(U,$J,358.3,3539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3539,1,2,0)
 ;;=2^Drain pilonidal cyst, simple
 ;;^UTILITY(U,$J,358.3,3539,1,4,0)
 ;;=4^10080
 ;;^UTILITY(U,$J,358.3,3540,0)
 ;;=10081^^29^267^12^^^^1
 ;;^UTILITY(U,$J,358.3,3540,1,0)
 ;;=^358.31IA^4^2
