IBDEI02Q ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,812,1,3,0)
 ;;=3^Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,812,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,812,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,813,0)
 ;;=F41.9^^6^97^16
 ;;^UTILITY(U,$J,358.3,813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,813,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,813,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,813,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,814,0)
 ;;=F10.20^^6^97^9
 ;;^UTILITY(U,$J,358.3,814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,814,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,814,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,814,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,815,0)
 ;;=G30.9^^6^97^12
 ;;^UTILITY(U,$J,358.3,815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,815,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,815,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,815,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,816,0)
 ;;=I20.9^^6^97^15
 ;;^UTILITY(U,$J,358.3,816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,816,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,816,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,816,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,817,0)
 ;;=I25.10^^6^97^19
 ;;^UTILITY(U,$J,358.3,817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,817,1,3,0)
 ;;=3^Athscl Hrt Disease w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,817,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,817,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,818,0)
 ;;=K46.9^^6^97^2
 ;;^UTILITY(U,$J,358.3,818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,818,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst/Gangr
 ;;^UTILITY(U,$J,358.3,818,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,818,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,819,0)
 ;;=I48.91^^6^97^20
 ;;^UTILITY(U,$J,358.3,819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,819,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,819,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,819,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,820,0)
 ;;=I48.92^^6^97^21
 ;;^UTILITY(U,$J,358.3,820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,820,1,3,0)
 ;;=3^Atrial Flutter,Unspec
 ;;^UTILITY(U,$J,358.3,820,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,820,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,821,0)
 ;;=I71.4^^6^97^1
 ;;^UTILITY(U,$J,358.3,821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,821,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,821,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,821,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,822,0)
 ;;=J30.9^^6^97^10
 ;;^UTILITY(U,$J,358.3,822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,822,1,3,0)
 ;;=3^Allergic Rhinitis,Unspec
 ;;^UTILITY(U,$J,358.3,822,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,822,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,823,0)
 ;;=J45.909^^6^97^18
 ;;^UTILITY(U,$J,358.3,823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,823,1,3,0)
 ;;=3^Asthma Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,823,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,823,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,824,0)
 ;;=M12.9^^6^97^17
 ;;^UTILITY(U,$J,358.3,824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,824,1,3,0)
 ;;=3^Arthropathy,Unspec
 ;;^UTILITY(U,$J,358.3,824,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,824,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,825,0)
 ;;=T78.40XA^^6^97^11
 ;;^UTILITY(U,$J,358.3,825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,825,1,3,0)
 ;;=3^Allergy,Unspec Initial Encounter
 ;;^UTILITY(U,$J,358.3,825,1,4,0)
 ;;=4^T78.40XA
 ;;^UTILITY(U,$J,358.3,825,2)
 ;;=^5054284
 ;;^UTILITY(U,$J,358.3,826,0)
 ;;=L40.2^^6^97^6
 ;;^UTILITY(U,$J,358.3,826,1,0)
 ;;=^358.31IA^4^2
