IBDEI1QD ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30988,1,3,0)
 ;;=3^Encounter for Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,30988,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,30988,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,30989,0)
 ;;=Z02.79^^190^1928^3
 ;;^UTILITY(U,$J,358.3,30989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30989,1,3,0)
 ;;=3^Encounter for Issue of other Medical Certificate
 ;;^UTILITY(U,$J,358.3,30989,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,30989,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,30990,0)
 ;;=Z76.0^^190^1928^2
 ;;^UTILITY(U,$J,358.3,30990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30990,1,3,0)
 ;;=3^Encounter for Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,30990,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,30990,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,30991,0)
 ;;=Z04.9^^190^1928^1
 ;;^UTILITY(U,$J,358.3,30991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30991,1,3,0)
 ;;=3^Encounter for Exam & Observation for Unsp Reason
 ;;^UTILITY(U,$J,358.3,30991,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,30991,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,30992,0)
 ;;=I20.0^^190^1929^14
 ;;^UTILITY(U,$J,358.3,30992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30992,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,30992,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,30992,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,30993,0)
 ;;=I25.110^^190^1929^7
 ;;^UTILITY(U,$J,358.3,30993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30993,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,30993,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,30993,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,30994,0)
 ;;=I25.700^^190^1929^12
 ;;^UTILITY(U,$J,358.3,30994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30994,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,30994,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,30994,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,30995,0)
 ;;=I25.2^^190^1929^13
 ;;^UTILITY(U,$J,358.3,30995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30995,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,30995,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,30995,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,30996,0)
 ;;=I20.8^^190^1929^2
 ;;^UTILITY(U,$J,358.3,30996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30996,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,30996,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,30996,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,30997,0)
 ;;=I20.1^^190^1929^1
 ;;^UTILITY(U,$J,358.3,30997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30997,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,30997,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,30997,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,30998,0)
 ;;=I25.119^^190^1929^5
 ;;^UTILITY(U,$J,358.3,30998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30998,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Unsp Ang Pctrs
 ;;^UTILITY(U,$J,358.3,30998,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,30998,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,30999,0)
 ;;=I25.701^^190^1929^9
 ;;^UTILITY(U,$J,358.3,30999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30999,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,30999,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,30999,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,31000,0)
 ;;=I25.708^^190^1929^10
 ;;^UTILITY(U,$J,358.3,31000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31000,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,31000,1,4,0)
 ;;=4^I25.708
