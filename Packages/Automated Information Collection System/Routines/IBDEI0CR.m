IBDEI0CR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5844,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,5844,1,4,0)
 ;;=4^I70.535
 ;;^UTILITY(U,$J,358.3,5844,2)
 ;;=^5007706
 ;;^UTILITY(U,$J,358.3,5845,0)
 ;;=I70.541^^30^385^55
 ;;^UTILITY(U,$J,358.3,5845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5845,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,5845,1,4,0)
 ;;=4^I70.541
 ;;^UTILITY(U,$J,358.3,5845,2)
 ;;=^5007709
 ;;^UTILITY(U,$J,358.3,5846,0)
 ;;=I70.542^^30^385^56
 ;;^UTILITY(U,$J,358.3,5846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5846,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,5846,1,4,0)
 ;;=4^I70.542
 ;;^UTILITY(U,$J,358.3,5846,2)
 ;;=^5007710
 ;;^UTILITY(U,$J,358.3,5847,0)
 ;;=I70.543^^30^385^57
 ;;^UTILITY(U,$J,358.3,5847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5847,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,5847,1,4,0)
 ;;=4^I70.543
 ;;^UTILITY(U,$J,358.3,5847,2)
 ;;=^5007711
 ;;^UTILITY(U,$J,358.3,5848,0)
 ;;=I70.544^^30^385^58
 ;;^UTILITY(U,$J,358.3,5848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5848,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,5848,1,4,0)
 ;;=4^I70.544
 ;;^UTILITY(U,$J,358.3,5848,2)
 ;;=^5007712
 ;;^UTILITY(U,$J,358.3,5849,0)
 ;;=I70.545^^30^385^59
 ;;^UTILITY(U,$J,358.3,5849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5849,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,5849,1,4,0)
 ;;=4^I70.545
 ;;^UTILITY(U,$J,358.3,5849,2)
 ;;=^5007713
 ;;^UTILITY(U,$J,358.3,5850,0)
 ;;=I70.631^^30^385^70
 ;;^UTILITY(U,$J,358.3,5850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5850,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,5850,1,4,0)
 ;;=4^I70.631
 ;;^UTILITY(U,$J,358.3,5850,2)
 ;;=^5007740
 ;;^UTILITY(U,$J,358.3,5851,0)
 ;;=I70.632^^30^385^71
 ;;^UTILITY(U,$J,358.3,5851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5851,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,5851,1,4,0)
 ;;=4^I70.632
 ;;^UTILITY(U,$J,358.3,5851,2)
 ;;=^5007741
 ;;^UTILITY(U,$J,358.3,5852,0)
 ;;=I70.633^^30^385^72
 ;;^UTILITY(U,$J,358.3,5852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5852,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,5852,1,4,0)
 ;;=4^I70.633
 ;;^UTILITY(U,$J,358.3,5852,2)
 ;;=^5007742
 ;;^UTILITY(U,$J,358.3,5853,0)
 ;;=I70.634^^30^385^73
 ;;^UTILITY(U,$J,358.3,5853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5853,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,5853,1,4,0)
 ;;=4^I70.634
 ;;^UTILITY(U,$J,358.3,5853,2)
 ;;=^5007743
 ;;^UTILITY(U,$J,358.3,5854,0)
 ;;=I70.635^^30^385^74
 ;;^UTILITY(U,$J,358.3,5854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5854,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,5854,1,4,0)
 ;;=4^I70.635
 ;;^UTILITY(U,$J,358.3,5854,2)
 ;;=^5007744
 ;;^UTILITY(U,$J,358.3,5855,0)
 ;;=I70.641^^30^385^65
 ;;^UTILITY(U,$J,358.3,5855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5855,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,5855,1,4,0)
 ;;=4^I70.641
 ;;^UTILITY(U,$J,358.3,5855,2)
 ;;=^5007747
 ;;^UTILITY(U,$J,358.3,5856,0)
 ;;=I70.642^^30^385^66
