IBDEI0BK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4934,0)
 ;;=11001^^39^329^17^^^^1
 ;;^UTILITY(U,$J,358.3,4934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4934,1,2,0)
 ;;=2^Debride infect skin Ea Addl 10%
 ;;^UTILITY(U,$J,358.3,4934,1,4,0)
 ;;=4^11001
 ;;^UTILITY(U,$J,358.3,4935,0)
 ;;=11045^^39^329^21^^^^1
 ;;^UTILITY(U,$J,358.3,4935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4935,1,2,0)
 ;;=2^Debride skin/SQ,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,4935,1,4,0)
 ;;=4^11045
 ;;^UTILITY(U,$J,358.3,4936,0)
 ;;=11046^^39^329^19^^^^1
 ;;^UTILITY(U,$J,358.3,4936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4936,1,2,0)
 ;;=2^Debride muscle,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,4936,1,4,0)
 ;;=4^11046
 ;;^UTILITY(U,$J,358.3,4937,0)
 ;;=11047^^39^329^13^^^^1
 ;;^UTILITY(U,$J,358.3,4937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4937,1,2,0)
 ;;=2^Debride Bone,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,4937,1,4,0)
 ;;=4^11047
 ;;^UTILITY(U,$J,358.3,4938,0)
 ;;=19081^^39^329^3^^^^1
 ;;^UTILITY(U,$J,358.3,4938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4938,1,2,0)
 ;;=2^Bx,Breast w/Device w/Stereotactic Guide,1st Lesion
 ;;^UTILITY(U,$J,358.3,4938,1,4,0)
 ;;=4^19081
 ;;^UTILITY(U,$J,358.3,4939,0)
 ;;=19082^^39^329^4^^^^1
 ;;^UTILITY(U,$J,358.3,4939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4939,1,2,0)
 ;;=2^Bx,Breast w/Device w/Stereotactic Guide,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,4939,1,4,0)
 ;;=4^19082
 ;;^UTILITY(U,$J,358.3,4940,0)
 ;;=19083^^39^329^5^^^^1
 ;;^UTILITY(U,$J,358.3,4940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4940,1,2,0)
 ;;=2^Bx,Breast w/Device w/US,1st Lesion
 ;;^UTILITY(U,$J,358.3,4940,1,4,0)
 ;;=4^19083
 ;;^UTILITY(U,$J,358.3,4941,0)
 ;;=19084^^39^329^6^^^^1
 ;;^UTILITY(U,$J,358.3,4941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4941,1,2,0)
 ;;=2^Bx,Breast w/Device w/US,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,4941,1,4,0)
 ;;=4^19084
 ;;^UTILITY(U,$J,358.3,4942,0)
 ;;=19085^^39^329^1^^^^1
 ;;^UTILITY(U,$J,358.3,4942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4942,1,2,0)
 ;;=2^Bx,Breast w/Device w/MRI,1st Lesion
 ;;^UTILITY(U,$J,358.3,4942,1,4,0)
 ;;=4^19085
 ;;^UTILITY(U,$J,358.3,4943,0)
 ;;=19086^^39^329^2^^^^1
 ;;^UTILITY(U,$J,358.3,4943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4943,1,2,0)
 ;;=2^Bx,Breast w/Device w/MRI,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,4943,1,4,0)
 ;;=4^19086
 ;;^UTILITY(U,$J,358.3,4944,0)
 ;;=10060^^39^330^17
 ;;^UTILITY(U,$J,358.3,4944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4944,1,2,0)
 ;;=2^I&D abscess,simple or single
 ;;^UTILITY(U,$J,358.3,4944,1,4,0)
 ;;=4^10060
 ;;^UTILITY(U,$J,358.3,4945,0)
 ;;=10061^^39^330^16
 ;;^UTILITY(U,$J,358.3,4945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4945,1,2,0)
 ;;=2^I&D abscess,complic or multip
 ;;^UTILITY(U,$J,358.3,4945,1,4,0)
 ;;=4^10061
 ;;^UTILITY(U,$J,358.3,4946,0)
 ;;=10160^^39^330^22
 ;;^UTILITY(U,$J,358.3,4946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4946,1,2,0)
 ;;=2^Needle asp absc/cyst/hematoma
 ;;^UTILITY(U,$J,358.3,4946,1,4,0)
 ;;=4^10160
 ;;^UTILITY(U,$J,358.3,4947,0)
 ;;=10140^^39^330^19
 ;;^UTILITY(U,$J,358.3,4947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4947,1,2,0)
 ;;=2^I&D hematoma/seroma,skin
 ;;^UTILITY(U,$J,358.3,4947,1,4,0)
 ;;=4^10140
 ;;^UTILITY(U,$J,358.3,4948,0)
 ;;=19000^^39^330^7
 ;;^UTILITY(U,$J,358.3,4948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4948,1,2,0)
 ;;=2^Aspirate breast cyst, first
 ;;^UTILITY(U,$J,358.3,4948,1,4,0)
 ;;=4^19000
 ;;^UTILITY(U,$J,358.3,4949,0)
 ;;=19001^^39^330^8
 ;;^UTILITY(U,$J,358.3,4949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4949,1,2,0)
 ;;=2^Aspirate each addit breast cyst
