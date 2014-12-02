IBDEI0FA ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7389,1,4,0)
 ;;=4^V16.41
 ;;^UTILITY(U,$J,358.3,7389,1,5,0)
 ;;=5^Family h/o Cancer of Ovary
 ;;^UTILITY(U,$J,358.3,7389,2)
 ;;=^317951
 ;;^UTILITY(U,$J,358.3,7390,0)
 ;;=V16.42^^55^580^10
 ;;^UTILITY(U,$J,358.3,7390,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7390,1,4,0)
 ;;=4^V16.42
 ;;^UTILITY(U,$J,358.3,7390,1,5,0)
 ;;=5^Family h/o Cancer of Prostate
 ;;^UTILITY(U,$J,358.3,7390,2)
 ;;=^317952
 ;;^UTILITY(U,$J,358.3,7391,0)
 ;;=V16.43^^55^580^11
 ;;^UTILITY(U,$J,358.3,7391,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7391,1,4,0)
 ;;=4^V16.43
 ;;^UTILITY(U,$J,358.3,7391,1,5,0)
 ;;=5^Family h/o Cancer of Testis
 ;;^UTILITY(U,$J,358.3,7391,2)
 ;;=^317953
 ;;^UTILITY(U,$J,358.3,7392,0)
 ;;=V19.5^^55^580^13
 ;;^UTILITY(U,$J,358.3,7392,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7392,1,4,0)
 ;;=4^V19.5
 ;;^UTILITY(U,$J,358.3,7392,1,5,0)
 ;;=5^Family h/o Congenital Anomalies
 ;;^UTILITY(U,$J,358.3,7392,2)
 ;;=^295325
 ;;^UTILITY(U,$J,358.3,7393,0)
 ;;=V19.2^^55^580^14
 ;;^UTILITY(U,$J,358.3,7393,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7393,1,4,0)
 ;;=4^V19.2
 ;;^UTILITY(U,$J,358.3,7393,1,5,0)
 ;;=5^Family h/o Deafness Or Hearing Loss
 ;;^UTILITY(U,$J,358.3,7393,2)
 ;;=^295322
 ;;^UTILITY(U,$J,358.3,7394,0)
 ;;=V17.3^^55^580^16
 ;;^UTILITY(U,$J,358.3,7394,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7394,1,4,0)
 ;;=4^V17.3
 ;;^UTILITY(U,$J,358.3,7394,1,5,0)
 ;;=5^Family h/o Ischemic Heart Dis
 ;;^UTILITY(U,$J,358.3,7394,2)
 ;;=^295305
 ;;^UTILITY(U,$J,358.3,7395,0)
 ;;=V16.6^^55^580^17
 ;;^UTILITY(U,$J,358.3,7395,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7395,1,4,0)
 ;;=4^V16.6
 ;;^UTILITY(U,$J,358.3,7395,1,5,0)
 ;;=5^Family h/o Leukemia
 ;;^UTILITY(U,$J,358.3,7395,2)
 ;;=^295298
 ;;^UTILITY(U,$J,358.3,7396,0)
 ;;=V18.61^^55^580^19
 ;;^UTILITY(U,$J,358.3,7396,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7396,1,4,0)
 ;;=4^V18.61
 ;;^UTILITY(U,$J,358.3,7396,1,5,0)
 ;;=5^Family h/o Polycystic Kidney
 ;;^UTILITY(U,$J,358.3,7396,2)
 ;;=^321531
 ;;^UTILITY(U,$J,358.3,7397,0)
 ;;=V17.0^^55^580^20
 ;;^UTILITY(U,$J,358.3,7397,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7397,1,4,0)
 ;;=4^V17.0
 ;;^UTILITY(U,$J,358.3,7397,1,5,0)
 ;;=5^Family h/o Psychiatric Condition
 ;;^UTILITY(U,$J,358.3,7397,2)
 ;;=^295302
 ;;^UTILITY(U,$J,358.3,7398,0)
 ;;=V19.4^^55^580^21
 ;;^UTILITY(U,$J,358.3,7398,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7398,1,4,0)
 ;;=4^V19.4
 ;;^UTILITY(U,$J,358.3,7398,1,5,0)
 ;;=5^Family h/o Skin Condition
 ;;^UTILITY(U,$J,358.3,7398,2)
 ;;=^295324
 ;;^UTILITY(U,$J,358.3,7399,0)
 ;;=V17.1^^55^580^22
 ;;^UTILITY(U,$J,358.3,7399,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7399,1,4,0)
 ;;=4^V17.1
 ;;^UTILITY(U,$J,358.3,7399,1,5,0)
 ;;=5^Family h/o Stroke (CVA)
 ;;^UTILITY(U,$J,358.3,7399,2)
 ;;=^295303
 ;;^UTILITY(U,$J,358.3,7400,0)
 ;;=V16.8^^55^580^12
 ;;^UTILITY(U,$J,358.3,7400,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7400,1,4,0)
 ;;=4^V16.8
 ;;^UTILITY(U,$J,358.3,7400,1,5,0)
 ;;=5^Family h/o Cancer,Other Specified
 ;;^UTILITY(U,$J,358.3,7400,2)
 ;;=^295300
 ;;^UTILITY(U,$J,358.3,7401,0)
 ;;=V11.1^^55^580^24
 ;;^UTILITY(U,$J,358.3,7401,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7401,1,4,0)
 ;;=4^V11.1
 ;;^UTILITY(U,$J,358.3,7401,1,5,0)
 ;;=5^Hx of Affective Disorder
 ;;^UTILITY(U,$J,358.3,7401,2)
 ;;=^295250
 ;;^UTILITY(U,$J,358.3,7402,0)
 ;;=V15.89^^55^580^46
 ;;^UTILITY(U,$J,358.3,7402,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7402,1,4,0)
 ;;=4^V15.89
 ;;^UTILITY(U,$J,358.3,7402,1,5,0)
 ;;=5^Hx of Persian Gulf Region Exposure
 ;;^UTILITY(U,$J,358.3,7402,2)
 ;;=^295291
