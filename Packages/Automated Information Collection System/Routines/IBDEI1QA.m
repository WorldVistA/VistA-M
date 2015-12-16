IBDEI1QA ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30580,1,3,0)
 ;;=3^Suprvsn of normal pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,30580,1,4,0)
 ;;=4^Z34.83
 ;;^UTILITY(U,$J,358.3,30580,2)
 ;;=^5062862
 ;;^UTILITY(U,$J,358.3,30581,0)
 ;;=Z33.1^^178^1923^9
 ;;^UTILITY(U,$J,358.3,30581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30581,1,3,0)
 ;;=3^Pregnant state, incidental
 ;;^UTILITY(U,$J,358.3,30581,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,30581,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,30582,0)
 ;;=O09.01^^178^1923^32
 ;;^UTILITY(U,$J,358.3,30582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30582,1,3,0)
 ;;=3^Suprvsn of preg w history of infertility, first trimester
 ;;^UTILITY(U,$J,358.3,30582,1,4,0)
 ;;=4^O09.01
 ;;^UTILITY(U,$J,358.3,30582,2)
 ;;=^5016049
 ;;^UTILITY(U,$J,358.3,30583,0)
 ;;=O09.02^^178^1923^33
 ;;^UTILITY(U,$J,358.3,30583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30583,1,3,0)
 ;;=3^Suprvsn of preg w history of infertility, second trimester
 ;;^UTILITY(U,$J,358.3,30583,1,4,0)
 ;;=4^O09.02
 ;;^UTILITY(U,$J,358.3,30583,2)
 ;;=^5016050
 ;;^UTILITY(U,$J,358.3,30584,0)
 ;;=O09.03^^178^1923^34
 ;;^UTILITY(U,$J,358.3,30584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30584,1,3,0)
 ;;=3^Suprvsn of preg w history of infertility, third trimester
 ;;^UTILITY(U,$J,358.3,30584,1,4,0)
 ;;=4^O09.03
 ;;^UTILITY(U,$J,358.3,30584,2)
 ;;=^5016051
 ;;^UTILITY(U,$J,358.3,30585,0)
 ;;=O09.11^^178^1923^29
 ;;^UTILITY(U,$J,358.3,30585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30585,1,3,0)
 ;;=3^Suprvsn of preg w history of ect or molar preg, first tri
 ;;^UTILITY(U,$J,358.3,30585,1,4,0)
 ;;=4^O09.11
 ;;^UTILITY(U,$J,358.3,30585,2)
 ;;=^5016053
 ;;^UTILITY(U,$J,358.3,30586,0)
 ;;=O09.12^^178^1923^30
 ;;^UTILITY(U,$J,358.3,30586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30586,1,3,0)
 ;;=3^Suprvsn of preg w history of ect or molar preg, second tri
 ;;^UTILITY(U,$J,358.3,30586,1,4,0)
 ;;=4^O09.12
 ;;^UTILITY(U,$J,358.3,30586,2)
 ;;=^5016054
 ;;^UTILITY(U,$J,358.3,30587,0)
 ;;=O09.13^^178^1923^31
 ;;^UTILITY(U,$J,358.3,30587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30587,1,3,0)
 ;;=3^Suprvsn of preg w history of ect or molar preg, third tri
 ;;^UTILITY(U,$J,358.3,30587,1,4,0)
 ;;=4^O09.13
 ;;^UTILITY(U,$J,358.3,30587,2)
 ;;=^5016055
 ;;^UTILITY(U,$J,358.3,30588,0)
 ;;=O09.291^^178^1923^41
 ;;^UTILITY(U,$J,358.3,30588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30588,1,3,0)
 ;;=3^Suprvsn of preg w poor reprodctv or obstet hx, first tri
 ;;^UTILITY(U,$J,358.3,30588,1,4,0)
 ;;=4^O09.291
 ;;^UTILITY(U,$J,358.3,30588,2)
 ;;=^5016060
 ;;^UTILITY(U,$J,358.3,30589,0)
 ;;=O09.292^^178^1923^42
 ;;^UTILITY(U,$J,358.3,30589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30589,1,3,0)
 ;;=3^Suprvsn of preg w poor reprodctv or obstet hx, second tri
 ;;^UTILITY(U,$J,358.3,30589,1,4,0)
 ;;=4^O09.292
 ;;^UTILITY(U,$J,358.3,30589,2)
 ;;=^5016061
 ;;^UTILITY(U,$J,358.3,30590,0)
 ;;=O09.293^^178^1923^43
 ;;^UTILITY(U,$J,358.3,30590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30590,1,3,0)
 ;;=3^Suprvsn of preg w poor reprodctv or obstet hx, third tri
 ;;^UTILITY(U,$J,358.3,30590,1,4,0)
 ;;=4^O09.293
 ;;^UTILITY(U,$J,358.3,30590,2)
 ;;=^5016062
 ;;^UTILITY(U,$J,358.3,30591,0)
 ;;=O09.41^^178^1923^26
 ;;^UTILITY(U,$J,358.3,30591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30591,1,3,0)
 ;;=3^Suprvsn of preg w grand multiparity, first trimester
 ;;^UTILITY(U,$J,358.3,30591,1,4,0)
 ;;=4^O09.41
 ;;^UTILITY(U,$J,358.3,30591,2)
 ;;=^5016069
 ;;^UTILITY(U,$J,358.3,30592,0)
 ;;=O09.42^^178^1923^27
 ;;^UTILITY(U,$J,358.3,30592,1,0)
 ;;=^358.31IA^4^2
