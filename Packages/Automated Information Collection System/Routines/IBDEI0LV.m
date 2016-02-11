IBDEI0LV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9979,1,3,0)
 ;;=3^Lab Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,9979,1,4,0)
 ;;=4^Z01.812
 ;;^UTILITY(U,$J,358.3,9979,2)
 ;;=^5062627
 ;;^UTILITY(U,$J,358.3,9980,0)
 ;;=Z01.818^^68^660^15
 ;;^UTILITY(U,$J,358.3,9980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9980,1,3,0)
 ;;=3^Preprocedural Exam NEC
 ;;^UTILITY(U,$J,358.3,9980,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,9980,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,9981,0)
 ;;=Z71.0^^68^660^9
 ;;^UTILITY(U,$J,358.3,9981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9981,1,3,0)
 ;;=3^Hlth Service to Consult on Behalf of Another
 ;;^UTILITY(U,$J,358.3,9981,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,9981,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,9982,0)
 ;;=Z59.8^^68^660^10
 ;;^UTILITY(U,$J,358.3,9982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9982,1,3,0)
 ;;=3^Housing/Economic Circumstance Problems
 ;;^UTILITY(U,$J,358.3,9982,1,4,0)
 ;;=4^Z59.8
 ;;^UTILITY(U,$J,358.3,9982,2)
 ;;=^5063137
 ;;^UTILITY(U,$J,358.3,9983,0)
 ;;=I20.0^^68^661^14
 ;;^UTILITY(U,$J,358.3,9983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9983,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,9983,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,9983,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,9984,0)
 ;;=I25.110^^68^661^7
 ;;^UTILITY(U,$J,358.3,9984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9984,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,9984,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,9984,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,9985,0)
 ;;=I25.700^^68^661^12
 ;;^UTILITY(U,$J,358.3,9985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9985,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,9985,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,9985,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,9986,0)
 ;;=I25.2^^68^661^13
 ;;^UTILITY(U,$J,358.3,9986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9986,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,9986,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,9986,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,9987,0)
 ;;=I20.8^^68^661^2
 ;;^UTILITY(U,$J,358.3,9987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9987,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,9987,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,9987,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,9988,0)
 ;;=I20.1^^68^661^1
 ;;^UTILITY(U,$J,358.3,9988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9988,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,9988,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,9988,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,9989,0)
 ;;=I25.119^^68^661^5
 ;;^UTILITY(U,$J,358.3,9989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9989,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,9989,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,9989,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,9990,0)
 ;;=I25.701^^68^661^9
 ;;^UTILITY(U,$J,358.3,9990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9990,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,9990,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,9990,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,9991,0)
 ;;=I25.708^^68^661^10
 ;;^UTILITY(U,$J,358.3,9991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9991,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,9991,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,9991,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,9992,0)
 ;;=I20.9^^68^661^3
 ;;^UTILITY(U,$J,358.3,9992,1,0)
 ;;=^358.31IA^4^2
