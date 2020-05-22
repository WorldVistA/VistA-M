IBDEI0Z5 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15682,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,15682,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,15682,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,15683,0)
 ;;=I73.9^^88^867^32
 ;;^UTILITY(U,$J,358.3,15683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15683,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,15683,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,15683,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,15684,0)
 ;;=I82.891^^88^867^23
 ;;^UTILITY(U,$J,358.3,15684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15684,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,15684,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,15684,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,15685,0)
 ;;=I82.890^^88^867^22
 ;;^UTILITY(U,$J,358.3,15685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15685,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,15685,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,15685,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,15686,0)
 ;;=I25.729^^88^867^2
 ;;^UTILITY(U,$J,358.3,15686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15686,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,15686,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,15686,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,15687,0)
 ;;=I25.119^^88^867^3
 ;;^UTILITY(U,$J,358.3,15687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15687,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,15687,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,15687,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,15688,0)
 ;;=I25.10^^88^867^4
 ;;^UTILITY(U,$J,358.3,15688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15688,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,15688,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,15688,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,15689,0)
 ;;=I25.110^^88^867^5
 ;;^UTILITY(U,$J,358.3,15689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15689,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,15689,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,15689,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,15690,0)
 ;;=I25.810^^88^867^17
 ;;^UTILITY(U,$J,358.3,15690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15690,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,15690,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,15690,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,15691,0)
 ;;=I25.701^^88^867^18
 ;;^UTILITY(U,$J,358.3,15691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15691,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,15691,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,15691,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,15692,0)
 ;;=I25.708^^88^867^19
 ;;^UTILITY(U,$J,358.3,15692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15692,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,15692,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,15692,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,15693,0)
 ;;=I25.709^^88^867^20
 ;;^UTILITY(U,$J,358.3,15693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15693,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,15693,1,4,0)
 ;;=4^I25.709
