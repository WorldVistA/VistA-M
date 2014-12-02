IBDEI08Y ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4094,1,4,0)
 ;;=4^11006
 ;;^UTILITY(U,$J,358.3,4095,0)
 ;;=11100^^36^309^9^^^^1
 ;;^UTILITY(U,$J,358.3,4095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4095,1,2,0)
 ;;=2^Bx,Skin/Sub,1st lesion
 ;;^UTILITY(U,$J,358.3,4095,1,4,0)
 ;;=4^11100
 ;;^UTILITY(U,$J,358.3,4096,0)
 ;;=11101^^36^309^10^^^^1
 ;;^UTILITY(U,$J,358.3,4096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4096,1,2,0)
 ;;=2^Bx,Skin/Sub,Ea Addl lesion
 ;;^UTILITY(U,$J,358.3,4096,1,4,0)
 ;;=4^11101
 ;;^UTILITY(U,$J,358.3,4097,0)
 ;;=11004^^36^309^15^^^^1
 ;;^UTILITY(U,$J,358.3,4097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4097,1,2,0)
 ;;=2^Debride Genital/Perineum/Mus/Fascia
 ;;^UTILITY(U,$J,358.3,4097,1,4,0)
 ;;=4^11004
 ;;^UTILITY(U,$J,358.3,4098,0)
 ;;=11000^^36^309^16^^^^1
 ;;^UTILITY(U,$J,358.3,4098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4098,1,2,0)
 ;;=2^Debride infect skin 10% or less
 ;;^UTILITY(U,$J,358.3,4098,1,4,0)
 ;;=4^11000
 ;;^UTILITY(U,$J,358.3,4099,0)
 ;;=11042^^36^309^20^^^^1
 ;;^UTILITY(U,$J,358.3,4099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4099,1,2,0)
 ;;=2^Debride skin/SQ,20sq cm or <
 ;;^UTILITY(U,$J,358.3,4099,1,4,0)
 ;;=4^11042
 ;;^UTILITY(U,$J,358.3,4100,0)
 ;;=11043^^36^309^18^^^^1
 ;;^UTILITY(U,$J,358.3,4100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4100,1,2,0)
 ;;=2^Debride muscle,20sq cm or <
 ;;^UTILITY(U,$J,358.3,4100,1,4,0)
 ;;=4^11043
 ;;^UTILITY(U,$J,358.3,4101,0)
 ;;=11044^^36^309^12^^^^1
 ;;^UTILITY(U,$J,358.3,4101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4101,1,2,0)
 ;;=2^Debride Bone,20sq cm or <
 ;;^UTILITY(U,$J,358.3,4101,1,4,0)
 ;;=4^11044
 ;;^UTILITY(U,$J,358.3,4102,0)
 ;;=11001^^36^309^17^^^^1
 ;;^UTILITY(U,$J,358.3,4102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4102,1,2,0)
 ;;=2^Debride infect skin Ea Addl 10%
 ;;^UTILITY(U,$J,358.3,4102,1,4,0)
 ;;=4^11001
 ;;^UTILITY(U,$J,358.3,4103,0)
 ;;=11045^^36^309^21^^^^1
 ;;^UTILITY(U,$J,358.3,4103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4103,1,2,0)
 ;;=2^Debride skin/SQ,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,4103,1,4,0)
 ;;=4^11045
 ;;^UTILITY(U,$J,358.3,4104,0)
 ;;=11046^^36^309^19^^^^1
 ;;^UTILITY(U,$J,358.3,4104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4104,1,2,0)
 ;;=2^Debride muscle,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,4104,1,4,0)
 ;;=4^11046
 ;;^UTILITY(U,$J,358.3,4105,0)
 ;;=11047^^36^309^13^^^^1
 ;;^UTILITY(U,$J,358.3,4105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4105,1,2,0)
 ;;=2^Debride Bone,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,4105,1,4,0)
 ;;=4^11047
 ;;^UTILITY(U,$J,358.3,4106,0)
 ;;=19081^^36^309^3^^^^1
 ;;^UTILITY(U,$J,358.3,4106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4106,1,2,0)
 ;;=2^Bx,Breast w/Device w/Stereotactic Guide,1st Lesion
 ;;^UTILITY(U,$J,358.3,4106,1,4,0)
 ;;=4^19081
 ;;^UTILITY(U,$J,358.3,4107,0)
 ;;=19082^^36^309^4^^^^1
 ;;^UTILITY(U,$J,358.3,4107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4107,1,2,0)
 ;;=2^Bx,Breast w/Device w/Stereotactic Guide,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,4107,1,4,0)
 ;;=4^19082
 ;;^UTILITY(U,$J,358.3,4108,0)
 ;;=19083^^36^309^5^^^^1
 ;;^UTILITY(U,$J,358.3,4108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4108,1,2,0)
 ;;=2^Bx,Breast w/Device w/US,1st Lesion
 ;;^UTILITY(U,$J,358.3,4108,1,4,0)
 ;;=4^19083
 ;;^UTILITY(U,$J,358.3,4109,0)
 ;;=19084^^36^309^6^^^^1
 ;;^UTILITY(U,$J,358.3,4109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4109,1,2,0)
 ;;=2^Bx,Breast w/Device w/US,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,4109,1,4,0)
 ;;=4^19084
 ;;^UTILITY(U,$J,358.3,4110,0)
 ;;=19085^^36^309^1^^^^1
 ;;^UTILITY(U,$J,358.3,4110,1,0)
 ;;=^358.31IA^4^2
