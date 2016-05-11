IBDEI0CK ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5754,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,5754,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,5754,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,5755,0)
 ;;=I25.700^^30^382^12
 ;;^UTILITY(U,$J,358.3,5755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5755,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,5755,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,5755,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,5756,0)
 ;;=I25.2^^30^382^13
 ;;^UTILITY(U,$J,358.3,5756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5756,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,5756,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,5756,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,5757,0)
 ;;=I20.8^^30^382^2
 ;;^UTILITY(U,$J,358.3,5757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5757,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,5757,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,5757,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,5758,0)
 ;;=I20.1^^30^382^1
 ;;^UTILITY(U,$J,358.3,5758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5758,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,5758,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,5758,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,5759,0)
 ;;=I25.119^^30^382^5
 ;;^UTILITY(U,$J,358.3,5759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5759,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,5759,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,5759,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,5760,0)
 ;;=I25.701^^30^382^9
 ;;^UTILITY(U,$J,358.3,5760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5760,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,5760,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,5760,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,5761,0)
 ;;=I25.708^^30^382^10
 ;;^UTILITY(U,$J,358.3,5761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5761,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,5761,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,5761,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,5762,0)
 ;;=I20.9^^30^382^3
 ;;^UTILITY(U,$J,358.3,5762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5762,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,5762,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,5762,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,5763,0)
 ;;=I25.729^^30^382^4
 ;;^UTILITY(U,$J,358.3,5763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5763,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,5763,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,5763,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,5764,0)
 ;;=I25.709^^30^382^11
 ;;^UTILITY(U,$J,358.3,5764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5764,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,5764,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,5764,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,5765,0)
 ;;=I25.10^^30^382^6
 ;;^UTILITY(U,$J,358.3,5765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5765,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,5765,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,5765,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,5766,0)
 ;;=I25.810^^30^382^8
 ;;^UTILITY(U,$J,358.3,5766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5766,1,3,0)
 ;;=3^Athscl of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,5766,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,5766,2)
 ;;=^5007141
