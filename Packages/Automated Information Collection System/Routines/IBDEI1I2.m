IBDEI1I2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23990,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,23990,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,23990,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,23991,0)
 ;;=I25.110^^107^1199^5
 ;;^UTILITY(U,$J,358.3,23991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23991,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,23991,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,23991,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,23992,0)
 ;;=I25.810^^107^1199^17
 ;;^UTILITY(U,$J,358.3,23992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23992,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,23992,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,23992,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,23993,0)
 ;;=I25.701^^107^1199^18
 ;;^UTILITY(U,$J,358.3,23993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23993,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,23993,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,23993,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,23994,0)
 ;;=I25.708^^107^1199^19
 ;;^UTILITY(U,$J,358.3,23994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23994,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,23994,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,23994,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,23995,0)
 ;;=I25.709^^107^1199^20
 ;;^UTILITY(U,$J,358.3,23995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23995,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,23995,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,23995,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,23996,0)
 ;;=I25.700^^107^1199^21
 ;;^UTILITY(U,$J,358.3,23996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23996,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,23996,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,23996,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,23997,0)
 ;;=I82.469^^107^1199^24
 ;;^UTILITY(U,$J,358.3,23997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23997,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Acute
 ;;^UTILITY(U,$J,358.3,23997,1,4,0)
 ;;=4^I82.469
 ;;^UTILITY(U,$J,358.3,23997,2)
 ;;=^5158066
 ;;^UTILITY(U,$J,358.3,23998,0)
 ;;=I82.569^^107^1199^25
 ;;^UTILITY(U,$J,358.3,23998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23998,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Chronic
 ;;^UTILITY(U,$J,358.3,23998,1,4,0)
 ;;=4^I82.569
 ;;^UTILITY(U,$J,358.3,23998,2)
 ;;=^5158074
 ;;^UTILITY(U,$J,358.3,23999,0)
 ;;=I80.259^^107^1199^33
 ;;^UTILITY(U,$J,358.3,23999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23999,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis,Unspec Calf Muscle Vein
 ;;^UTILITY(U,$J,358.3,23999,1,4,0)
 ;;=4^I80.259
 ;;^UTILITY(U,$J,358.3,23999,2)
 ;;=^5158058
 ;;^UTILITY(U,$J,358.3,24000,0)
 ;;=I82.409^^107^1199^26
 ;;^UTILITY(U,$J,358.3,24000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24000,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Deep Vein,LE Unspec Acute
 ;;^UTILITY(U,$J,358.3,24000,1,4,0)
 ;;=4^I82.409
 ;;^UTILITY(U,$J,358.3,24000,2)
 ;;=^5133625
 ;;^UTILITY(U,$J,358.3,24001,0)
 ;;=I82.509^^107^1199^27
 ;;^UTILITY(U,$J,358.3,24001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24001,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Deep Vein,LE Unspec Chronic
 ;;^UTILITY(U,$J,358.3,24001,1,4,0)
 ;;=4^I82.509
