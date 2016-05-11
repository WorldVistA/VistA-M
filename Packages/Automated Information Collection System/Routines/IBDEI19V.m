IBDEI19V ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21639,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,21639,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,21639,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,21640,0)
 ;;=I82.890^^87^968^13
 ;;^UTILITY(U,$J,358.3,21640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21640,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,21640,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,21640,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,21641,0)
 ;;=E78.0^^87^969^12
 ;;^UTILITY(U,$J,358.3,21641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21641,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,21641,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,21641,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,21642,0)
 ;;=E78.1^^87^969^13
 ;;^UTILITY(U,$J,358.3,21642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21642,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,21642,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,21642,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,21643,0)
 ;;=E78.2^^87^969^11
 ;;^UTILITY(U,$J,358.3,21643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21643,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,21643,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,21643,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,21644,0)
 ;;=I10.^^87^969^3
 ;;^UTILITY(U,$J,358.3,21644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21644,1,3,0)
 ;;=3^Essential Primary Hypertension
 ;;^UTILITY(U,$J,358.3,21644,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,21644,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,21645,0)
 ;;=I11.9^^87^969^10
 ;;^UTILITY(U,$J,358.3,21645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21645,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,21645,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,21645,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,21646,0)
 ;;=I11.0^^87^969^9
 ;;^UTILITY(U,$J,358.3,21646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21646,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure
 ;;^UTILITY(U,$J,358.3,21646,1,4,0)
 ;;=4^I11.0
 ;;^UTILITY(U,$J,358.3,21646,2)
 ;;=^5007063
 ;;^UTILITY(U,$J,358.3,21647,0)
 ;;=I12.0^^87^969^8
 ;;^UTILITY(U,$J,358.3,21647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21647,1,3,0)
 ;;=3^Hypertensive Chr Kidney Disease w/ ESRD
 ;;^UTILITY(U,$J,358.3,21647,1,4,0)
 ;;=4^I12.0
 ;;^UTILITY(U,$J,358.3,21647,2)
 ;;=^5007065
 ;;^UTILITY(U,$J,358.3,21648,0)
 ;;=I13.10^^87^969^6
 ;;^UTILITY(U,$J,358.3,21648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21648,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/o Hrt Fail w/ Stg 1-4 Chr Kdny
 ;;^UTILITY(U,$J,358.3,21648,1,4,0)
 ;;=4^I13.10
 ;;^UTILITY(U,$J,358.3,21648,2)
 ;;=^5007068
 ;;^UTILITY(U,$J,358.3,21649,0)
 ;;=I13.0^^87^969^4
 ;;^UTILITY(U,$J,358.3,21649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21649,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/ Hrt Fail w/ Stg 1-4 Chr Kdny
 ;;^UTILITY(U,$J,358.3,21649,1,4,0)
 ;;=4^I13.0
 ;;^UTILITY(U,$J,358.3,21649,2)
 ;;=^5007067
 ;;^UTILITY(U,$J,358.3,21650,0)
 ;;=I13.11^^87^969^7
 ;;^UTILITY(U,$J,358.3,21650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21650,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/o Hrt Fail w/ Stg 5 Chr Kdny
 ;;^UTILITY(U,$J,358.3,21650,1,4,0)
 ;;=4^I13.11
 ;;^UTILITY(U,$J,358.3,21650,2)
 ;;=^5007069
 ;;^UTILITY(U,$J,358.3,21651,0)
 ;;=I13.2^^87^969^5
 ;;^UTILITY(U,$J,358.3,21651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21651,1,3,0)
 ;;=3^HTN Hrt & Chr Kdny Dis w/ Hrt Fail w/ Stg 5 Chr Kdny
 ;;^UTILITY(U,$J,358.3,21651,1,4,0)
 ;;=4^I13.2
 ;;^UTILITY(U,$J,358.3,21651,2)
 ;;=^5007070
 ;;^UTILITY(U,$J,358.3,21652,0)
 ;;=I48.91^^87^969^1
