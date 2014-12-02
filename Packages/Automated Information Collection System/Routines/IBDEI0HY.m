IBDEI0HY ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8730,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,8730,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,8730,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,8731,0)
 ;;=99244^^59^616^4
 ;;^UTILITY(U,$J,358.3,8731,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,8731,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,8731,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,8732,0)
 ;;=99245^^59^616^5
 ;;^UTILITY(U,$J,358.3,8732,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,8732,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,8732,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,8733,0)
 ;;=19100^^60^617^1
 ;;^UTILITY(U,$J,358.3,8733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8733,1,2,0)
 ;;=2^Bx,Breast,needle,w/o imaging
 ;;^UTILITY(U,$J,358.3,8733,1,4,0)
 ;;=4^19100
 ;;^UTILITY(U,$J,358.3,8734,0)
 ;;=11100^^60^617^2
 ;;^UTILITY(U,$J,358.3,8734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8734,1,2,0)
 ;;=2^Bx,Skin,first lesion
 ;;^UTILITY(U,$J,358.3,8734,1,4,0)
 ;;=4^11100
 ;;^UTILITY(U,$J,358.3,8735,0)
 ;;=11101^^60^617^3
 ;;^UTILITY(U,$J,358.3,8735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8735,1,2,0)
 ;;=2^Bx,Skin,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,8735,1,4,0)
 ;;=4^11101
 ;;^UTILITY(U,$J,358.3,8736,0)
 ;;=11042^^60^617^4^^^^1
 ;;^UTILITY(U,$J,358.3,8736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8736,1,2,0)
 ;;=2^Debride skin/SQ 20sq cm or <
 ;;^UTILITY(U,$J,358.3,8736,1,4,0)
 ;;=4^11042
 ;;^UTILITY(U,$J,358.3,8737,0)
 ;;=11043^^60^617^6^^^^1
 ;;^UTILITY(U,$J,358.3,8737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8737,1,2,0)
 ;;=2^Debride skin-SQ/Muscle 20sq cm or <
 ;;^UTILITY(U,$J,358.3,8737,1,4,0)
 ;;=4^11043
 ;;^UTILITY(U,$J,358.3,8738,0)
 ;;=11045^^60^617^5^^^^1
 ;;^UTILITY(U,$J,358.3,8738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8738,1,2,0)
 ;;=2^Debride skin/SQ,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,8738,1,4,0)
 ;;=4^11045
 ;;^UTILITY(U,$J,358.3,8739,0)
 ;;=11046^^60^617^7^^^^1
 ;;^UTILITY(U,$J,358.3,8739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8739,1,2,0)
 ;;=2^Deb skin-SQ/Musc,ea adl 20sq cm
 ;;^UTILITY(U,$J,358.3,8739,1,4,0)
 ;;=4^11046
 ;;^UTILITY(U,$J,358.3,8740,0)
 ;;=10060^^60^618^9
 ;;^UTILITY(U,$J,358.3,8740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8740,1,2,0)
 ;;=2^I&D Abscess,simple or single
 ;;^UTILITY(U,$J,358.3,8740,1,4,0)
 ;;=4^10060
 ;;^UTILITY(U,$J,358.3,8741,0)
 ;;=10061^^60^618^8
 ;;^UTILITY(U,$J,358.3,8741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8741,1,2,0)
 ;;=2^I&D Abscess,complic or multip
 ;;^UTILITY(U,$J,358.3,8741,1,4,0)
 ;;=4^10061
 ;;^UTILITY(U,$J,358.3,8742,0)
 ;;=10160^^60^618^14
 ;;^UTILITY(U,$J,358.3,8742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8742,1,2,0)
 ;;=2^Needle asp absc/cyst/hematoma
 ;;^UTILITY(U,$J,358.3,8742,1,4,0)
 ;;=4^10160
 ;;^UTILITY(U,$J,358.3,8743,0)
 ;;=10140^^60^618^11
 ;;^UTILITY(U,$J,358.3,8743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8743,1,2,0)
 ;;=2^I&D hematoma/seroma,skin
 ;;^UTILITY(U,$J,358.3,8743,1,4,0)
 ;;=4^10140
 ;;^UTILITY(U,$J,358.3,8744,0)
 ;;=19000^^60^618^1
 ;;^UTILITY(U,$J,358.3,8744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8744,1,2,0)
 ;;=2^Aspirate breast cyst, first
 ;;^UTILITY(U,$J,358.3,8744,1,4,0)
 ;;=4^19000
 ;;^UTILITY(U,$J,358.3,8745,0)
 ;;=19001^^60^618^2
 ;;^UTILITY(U,$J,358.3,8745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8745,1,2,0)
 ;;=2^Aspirate Breast Cyst,Ea Addl Cyst
 ;;^UTILITY(U,$J,358.3,8745,1,4,0)
 ;;=4^19001
 ;;^UTILITY(U,$J,358.3,8746,0)
 ;;=26011^^60^618^4
 ;;^UTILITY(U,$J,358.3,8746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8746,1,2,0)
 ;;=2^Drain abscess finger,complic
