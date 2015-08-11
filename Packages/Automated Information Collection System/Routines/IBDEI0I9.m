IBDEI0I9 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8845,0)
 ;;=19100^^54^591^1
 ;;^UTILITY(U,$J,358.3,8845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8845,1,2,0)
 ;;=2^Bx,Breast,needle,w/o imaging
 ;;^UTILITY(U,$J,358.3,8845,1,4,0)
 ;;=4^19100
 ;;^UTILITY(U,$J,358.3,8846,0)
 ;;=11100^^54^591^2
 ;;^UTILITY(U,$J,358.3,8846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8846,1,2,0)
 ;;=2^Bx,Skin,first lesion
 ;;^UTILITY(U,$J,358.3,8846,1,4,0)
 ;;=4^11100
 ;;^UTILITY(U,$J,358.3,8847,0)
 ;;=11101^^54^591^3
 ;;^UTILITY(U,$J,358.3,8847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8847,1,2,0)
 ;;=2^Bx,Skin,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,8847,1,4,0)
 ;;=4^11101
 ;;^UTILITY(U,$J,358.3,8848,0)
 ;;=11042^^54^591^4^^^^1
 ;;^UTILITY(U,$J,358.3,8848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8848,1,2,0)
 ;;=2^Debride skin/SQ 20sq cm or <
 ;;^UTILITY(U,$J,358.3,8848,1,4,0)
 ;;=4^11042
 ;;^UTILITY(U,$J,358.3,8849,0)
 ;;=11043^^54^591^6^^^^1
 ;;^UTILITY(U,$J,358.3,8849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8849,1,2,0)
 ;;=2^Debride skin-SQ/Muscle 20sq cm or <
 ;;^UTILITY(U,$J,358.3,8849,1,4,0)
 ;;=4^11043
 ;;^UTILITY(U,$J,358.3,8850,0)
 ;;=11045^^54^591^5^^^^1
 ;;^UTILITY(U,$J,358.3,8850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8850,1,2,0)
 ;;=2^Debride skin/SQ,ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,8850,1,4,0)
 ;;=4^11045
 ;;^UTILITY(U,$J,358.3,8851,0)
 ;;=11046^^54^591^7^^^^1
 ;;^UTILITY(U,$J,358.3,8851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8851,1,2,0)
 ;;=2^Deb skin-SQ/Musc,ea adl 20sq cm
 ;;^UTILITY(U,$J,358.3,8851,1,4,0)
 ;;=4^11046
 ;;^UTILITY(U,$J,358.3,8852,0)
 ;;=97597^^54^591^8^^^^1
 ;;^UTILITY(U,$J,358.3,8852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8852,1,2,0)
 ;;=2^Rmvl Devital Tis </= 20 Sq Cm
 ;;^UTILITY(U,$J,358.3,8852,1,4,0)
 ;;=4^97597
 ;;^UTILITY(U,$J,358.3,8853,0)
 ;;=97598^^54^591^9^^^^1
 ;;^UTILITY(U,$J,358.3,8853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8853,1,2,0)
 ;;=2^Rmvl Devital Tis > 20 Sq Cm
 ;;^UTILITY(U,$J,358.3,8853,1,4,0)
 ;;=4^97598
 ;;^UTILITY(U,$J,358.3,8854,0)
 ;;=10060^^54^592^9
 ;;^UTILITY(U,$J,358.3,8854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8854,1,2,0)
 ;;=2^I&D Abscess,simple or single
 ;;^UTILITY(U,$J,358.3,8854,1,4,0)
 ;;=4^10060
 ;;^UTILITY(U,$J,358.3,8855,0)
 ;;=10061^^54^592^8
 ;;^UTILITY(U,$J,358.3,8855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8855,1,2,0)
 ;;=2^I&D Abscess,complic or multip
 ;;^UTILITY(U,$J,358.3,8855,1,4,0)
 ;;=4^10061
 ;;^UTILITY(U,$J,358.3,8856,0)
 ;;=10160^^54^592^14
 ;;^UTILITY(U,$J,358.3,8856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8856,1,2,0)
 ;;=2^Needle asp absc/cyst/hematoma
 ;;^UTILITY(U,$J,358.3,8856,1,4,0)
 ;;=4^10160
 ;;^UTILITY(U,$J,358.3,8857,0)
 ;;=10140^^54^592^11
 ;;^UTILITY(U,$J,358.3,8857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8857,1,2,0)
 ;;=2^I&D hematoma/seroma,skin
 ;;^UTILITY(U,$J,358.3,8857,1,4,0)
 ;;=4^10140
 ;;^UTILITY(U,$J,358.3,8858,0)
 ;;=19000^^54^592^1
 ;;^UTILITY(U,$J,358.3,8858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8858,1,2,0)
 ;;=2^Aspirate breast cyst, first
 ;;^UTILITY(U,$J,358.3,8858,1,4,0)
 ;;=4^19000
 ;;^UTILITY(U,$J,358.3,8859,0)
 ;;=19001^^54^592^2
 ;;^UTILITY(U,$J,358.3,8859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8859,1,2,0)
 ;;=2^Aspirate Breast Cyst,Ea Addl Cyst
 ;;^UTILITY(U,$J,358.3,8859,1,4,0)
 ;;=4^19001
 ;;^UTILITY(U,$J,358.3,8860,0)
 ;;=26011^^54^592^4
 ;;^UTILITY(U,$J,358.3,8860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8860,1,2,0)
 ;;=2^Drain abscess finger,complic
 ;;^UTILITY(U,$J,358.3,8860,1,4,0)
 ;;=4^26011
 ;;^UTILITY(U,$J,358.3,8861,0)
 ;;=26020^^54^592^6
