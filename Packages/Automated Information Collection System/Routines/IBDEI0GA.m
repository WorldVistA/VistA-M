IBDEI0GA ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7050,1,3,0)
 ;;=3^Screening for Infectious/Parasitic Diseases
 ;;^UTILITY(U,$J,358.3,7050,1,4,0)
 ;;=4^Z11.9
 ;;^UTILITY(U,$J,358.3,7050,2)
 ;;=^5062678
 ;;^UTILITY(U,$J,358.3,7051,0)
 ;;=Z12.2^^58^460^13
 ;;^UTILITY(U,$J,358.3,7051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7051,1,3,0)
 ;;=3^Screening for Malig Neop Respiratory Organs
 ;;^UTILITY(U,$J,358.3,7051,1,4,0)
 ;;=4^Z12.2
 ;;^UTILITY(U,$J,358.3,7051,2)
 ;;=^5062684
 ;;^UTILITY(U,$J,358.3,7052,0)
 ;;=Z12.4^^58^460^9
 ;;^UTILITY(U,$J,358.3,7052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7052,1,3,0)
 ;;=3^Screening for Malig Neop Cervix
 ;;^UTILITY(U,$J,358.3,7052,1,4,0)
 ;;=4^Z12.4
 ;;^UTILITY(U,$J,358.3,7052,2)
 ;;=^5062687
 ;;^UTILITY(U,$J,358.3,7053,0)
 ;;=Z12.12^^58^460^12
 ;;^UTILITY(U,$J,358.3,7053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7053,1,3,0)
 ;;=3^Screening for Malig Neop Rectum
 ;;^UTILITY(U,$J,358.3,7053,1,4,0)
 ;;=4^Z12.12
 ;;^UTILITY(U,$J,358.3,7053,2)
 ;;=^5062682
 ;;^UTILITY(U,$J,358.3,7054,0)
 ;;=Z12.5^^58^460^11
 ;;^UTILITY(U,$J,358.3,7054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7054,1,3,0)
 ;;=3^Screening for Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,7054,1,4,0)
 ;;=4^Z12.5
 ;;^UTILITY(U,$J,358.3,7054,2)
 ;;=^5062688
 ;;^UTILITY(U,$J,358.3,7055,0)
 ;;=Z12.11^^58^460^10
 ;;^UTILITY(U,$J,358.3,7055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7055,1,3,0)
 ;;=3^Screening for Malig Neop Colon
 ;;^UTILITY(U,$J,358.3,7055,1,4,0)
 ;;=4^Z12.11
 ;;^UTILITY(U,$J,358.3,7055,2)
 ;;=^5062681
 ;;^UTILITY(U,$J,358.3,7056,0)
 ;;=Z13.1^^58^460^4
 ;;^UTILITY(U,$J,358.3,7056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7056,1,3,0)
 ;;=3^Screening for Diabetes Mellitus
 ;;^UTILITY(U,$J,358.3,7056,1,4,0)
 ;;=4^Z13.1
 ;;^UTILITY(U,$J,358.3,7056,2)
 ;;=^5062700
 ;;^UTILITY(U,$J,358.3,7057,0)
 ;;=Z13.0^^58^460^2
 ;;^UTILITY(U,$J,358.3,7057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7057,1,3,0)
 ;;=3^Screening for Blood/Blood-Forming Organs Diseases
 ;;^UTILITY(U,$J,358.3,7057,1,4,0)
 ;;=4^Z13.0
 ;;^UTILITY(U,$J,358.3,7057,2)
 ;;=^5062699
 ;;^UTILITY(U,$J,358.3,7058,0)
 ;;=Z13.850^^58^460^15
 ;;^UTILITY(U,$J,358.3,7058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7058,1,3,0)
 ;;=3^Screening for TBI
 ;;^UTILITY(U,$J,358.3,7058,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,7058,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,7059,0)
 ;;=Z13.6^^58^460^3
 ;;^UTILITY(U,$J,358.3,7059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7059,1,3,0)
 ;;=3^Screening for Cardiovascular Disorders
 ;;^UTILITY(U,$J,358.3,7059,1,4,0)
 ;;=4^Z13.6
 ;;^UTILITY(U,$J,358.3,7059,2)
 ;;=^5062707
 ;;^UTILITY(U,$J,358.3,7060,0)
 ;;=Z13.820^^58^460^14
 ;;^UTILITY(U,$J,358.3,7060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7060,1,3,0)
 ;;=3^Screening for Osteoporosis
 ;;^UTILITY(U,$J,358.3,7060,1,4,0)
 ;;=4^Z13.820
 ;;^UTILITY(U,$J,358.3,7060,2)
 ;;=^5062713
 ;;^UTILITY(U,$J,358.3,7061,0)
 ;;=I10.^^58^461^3
 ;;^UTILITY(U,$J,358.3,7061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7061,1,3,0)
 ;;=3^Hypertension,Essential,Primary
 ;;^UTILITY(U,$J,358.3,7061,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,7061,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,7062,0)
 ;;=I25.119^^58^461^1
 ;;^UTILITY(U,$J,358.3,7062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7062,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Angina Pectoris
