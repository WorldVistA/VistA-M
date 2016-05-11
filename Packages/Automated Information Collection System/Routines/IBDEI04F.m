IBDEI04F ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1644,0)
 ;;=I25.111^^11^146^4
 ;;^UTILITY(U,$J,358.3,1644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1644,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Ang Pctrs w/ Spasm
 ;;^UTILITY(U,$J,358.3,1644,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,1644,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,1645,0)
 ;;=I25.118^^11^146^5
 ;;^UTILITY(U,$J,358.3,1645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1645,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1645,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,1645,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,1646,0)
 ;;=I25.119^^11^146^6
 ;;^UTILITY(U,$J,358.3,1646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1646,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1646,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,1646,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,1647,0)
 ;;=I25.810^^11^146^1
 ;;^UTILITY(U,$J,358.3,1647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1647,1,3,0)
 ;;=3^Atherosclerosis of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,1647,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,1647,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,1648,0)
 ;;=I25.82^^11^146^10
 ;;^UTILITY(U,$J,358.3,1648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1648,1,3,0)
 ;;=3^Total Occlusion of Coronary Artery,Chronic
 ;;^UTILITY(U,$J,358.3,1648,1,4,0)
 ;;=4^I25.82
 ;;^UTILITY(U,$J,358.3,1648,2)
 ;;=^335262
 ;;^UTILITY(U,$J,358.3,1649,0)
 ;;=I25.83^^11^146^8
 ;;^UTILITY(U,$J,358.3,1649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1649,1,3,0)
 ;;=3^Coronary Atherosclerosis d/t Lipid Rich Plaque
 ;;^UTILITY(U,$J,358.3,1649,1,4,0)
 ;;=4^I25.83
 ;;^UTILITY(U,$J,358.3,1649,2)
 ;;=^336601
 ;;^UTILITY(U,$J,358.3,1650,0)
 ;;=I25.84^^11^146^7
 ;;^UTILITY(U,$J,358.3,1650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1650,1,3,0)
 ;;=3^Coronary Atherosclerosis d/t Calcified Coronary Lesion
 ;;^UTILITY(U,$J,358.3,1650,1,4,0)
 ;;=4^I25.84
 ;;^UTILITY(U,$J,358.3,1650,2)
 ;;=^340518
 ;;^UTILITY(U,$J,358.3,1651,0)
 ;;=I25.89^^11^146^9
 ;;^UTILITY(U,$J,358.3,1651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1651,1,3,0)
 ;;=3^Ischemic Heart Disease,Chronic NEC
 ;;^UTILITY(U,$J,358.3,1651,1,4,0)
 ;;=4^I25.89
 ;;^UTILITY(U,$J,358.3,1651,2)
 ;;=^269679
 ;;^UTILITY(U,$J,358.3,1652,0)
 ;;=E66.9^^11^147^17
 ;;^UTILITY(U,$J,358.3,1652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1652,1,3,0)
 ;;=3^Obesity,Unspec
 ;;^UTILITY(U,$J,358.3,1652,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,1652,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,1653,0)
 ;;=E66.01^^11^147^14
 ;;^UTILITY(U,$J,358.3,1653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1653,1,3,0)
 ;;=3^Morbid Obesity d/t Excess Calories
 ;;^UTILITY(U,$J,358.3,1653,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,1653,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,1654,0)
 ;;=F17.200^^11^147^16
 ;;^UTILITY(U,$J,358.3,1654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1654,1,3,0)
 ;;=3^Nicotine Dependence,Unspec
 ;;^UTILITY(U,$J,358.3,1654,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,1654,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,1655,0)
 ;;=F17.201^^11^147^15
 ;;^UTILITY(U,$J,358.3,1655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1655,1,3,0)
 ;;=3^Nicotine Dependence in Remission,Unspec
 ;;^UTILITY(U,$J,358.3,1655,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,1655,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,1656,0)
 ;;=G90.59^^11^147^8
 ;;^UTILITY(U,$J,358.3,1656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1656,1,3,0)
 ;;=3^Complex Regional Pain Syndrome I
 ;;^UTILITY(U,$J,358.3,1656,1,4,0)
 ;;=4^G90.59
