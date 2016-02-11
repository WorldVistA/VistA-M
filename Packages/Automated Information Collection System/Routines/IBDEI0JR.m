IBDEI0JR ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8903,1,3,0)
 ;;=3^Saddle embolus of pulmonary artery w/o acute cor pulmonale
 ;;^UTILITY(U,$J,358.3,8903,1,4,0)
 ;;=4^I26.92
 ;;^UTILITY(U,$J,358.3,8903,2)
 ;;=^5007149
 ;;^UTILITY(U,$J,358.3,8904,0)
 ;;=I26.99^^55^553^4
 ;;^UTILITY(U,$J,358.3,8904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8904,1,3,0)
 ;;=3^Pulmonary embolism without acute cor pulmonale NEC
 ;;^UTILITY(U,$J,358.3,8904,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,8904,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,8905,0)
 ;;=I27.0^^55^553^3
 ;;^UTILITY(U,$J,358.3,8905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8905,1,3,0)
 ;;=3^Primary pulmonary hypertension
 ;;^UTILITY(U,$J,358.3,8905,1,4,0)
 ;;=4^I27.0
 ;;^UTILITY(U,$J,358.3,8905,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,8906,0)
 ;;=I27.2^^55^553^8
 ;;^UTILITY(U,$J,358.3,8906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8906,1,3,0)
 ;;=3^Secondary pulmonary hypertension NEC
 ;;^UTILITY(U,$J,358.3,8906,1,4,0)
 ;;=4^I27.2
 ;;^UTILITY(U,$J,358.3,8906,2)
 ;;=^5007151
 ;;^UTILITY(U,$J,358.3,8907,0)
 ;;=I27.89^^55^553^6
 ;;^UTILITY(U,$J,358.3,8907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8907,1,3,0)
 ;;=3^Pulmonary heart diseases NEC
 ;;^UTILITY(U,$J,358.3,8907,1,4,0)
 ;;=4^I27.89
 ;;^UTILITY(U,$J,358.3,8907,2)
 ;;=^5007153
 ;;^UTILITY(U,$J,358.3,8908,0)
 ;;=I27.9^^55^553^5
 ;;^UTILITY(U,$J,358.3,8908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8908,1,3,0)
 ;;=3^Pulmonary heart disease, unspecified
 ;;^UTILITY(U,$J,358.3,8908,1,4,0)
 ;;=4^I27.9
 ;;^UTILITY(U,$J,358.3,8908,2)
 ;;=^5007154
 ;;^UTILITY(U,$J,358.3,8909,0)
 ;;=I27.81^^55^553^1
 ;;^UTILITY(U,$J,358.3,8909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8909,1,3,0)
 ;;=3^Cor pulmonale (chronic)
 ;;^UTILITY(U,$J,358.3,8909,1,4,0)
 ;;=4^I27.81
 ;;^UTILITY(U,$J,358.3,8909,2)
 ;;=^5007152
 ;;^UTILITY(U,$J,358.3,8910,0)
 ;;=R04.2^^55^553^2
 ;;^UTILITY(U,$J,358.3,8910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8910,1,3,0)
 ;;=3^Hemoptysis
 ;;^UTILITY(U,$J,358.3,8910,1,4,0)
 ;;=4^R04.2
 ;;^UTILITY(U,$J,358.3,8910,2)
 ;;=^5019175
 ;;^UTILITY(U,$J,358.3,8911,0)
 ;;=J41.0^^55^554^16
 ;;^UTILITY(U,$J,358.3,8911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8911,1,3,0)
 ;;=3^Simple chronic bronchitis
 ;;^UTILITY(U,$J,358.3,8911,1,4,0)
 ;;=4^J41.0
 ;;^UTILITY(U,$J,358.3,8911,2)
 ;;=^269946
 ;;^UTILITY(U,$J,358.3,8912,0)
 ;;=J70.5^^55^554^14
 ;;^UTILITY(U,$J,358.3,8912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8912,1,3,0)
 ;;=3^Respiratory conditions due to smoke inhalation
 ;;^UTILITY(U,$J,358.3,8912,1,4,0)
 ;;=4^J70.5
 ;;^UTILITY(U,$J,358.3,8912,2)
 ;;=^5008293
 ;;^UTILITY(U,$J,358.3,8913,0)
 ;;=J98.11^^55^554^6
 ;;^UTILITY(U,$J,358.3,8913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8913,1,3,0)
 ;;=3^Atelectasis
 ;;^UTILITY(U,$J,358.3,8913,1,4,0)
 ;;=4^J98.11
 ;;^UTILITY(U,$J,358.3,8913,2)
 ;;=^5008360
 ;;^UTILITY(U,$J,358.3,8914,0)
 ;;=J80.^^55^554^4
 ;;^UTILITY(U,$J,358.3,8914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8914,1,3,0)
 ;;=3^Acute respiratory distress syndrome
 ;;^UTILITY(U,$J,358.3,8914,1,4,0)
 ;;=4^J80.
 ;;^UTILITY(U,$J,358.3,8914,2)
 ;;=^5008294
 ;;^UTILITY(U,$J,358.3,8915,0)
 ;;=J98.01^^55^554^3
 ;;^UTILITY(U,$J,358.3,8915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8915,1,3,0)
 ;;=3^Acute bronchospasm
 ;;^UTILITY(U,$J,358.3,8915,1,4,0)
 ;;=4^J98.01
 ;;^UTILITY(U,$J,358.3,8915,2)
 ;;=^334092
 ;;^UTILITY(U,$J,358.3,8916,0)
 ;;=R06.02^^55^554^15
 ;;^UTILITY(U,$J,358.3,8916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8916,1,3,0)
 ;;=3^Shortness of breath
 ;;^UTILITY(U,$J,358.3,8916,1,4,0)
 ;;=4^R06.02
