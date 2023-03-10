IBDEI0JY ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8977,0)
 ;;=K70.41^^39^404^5
 ;;^UTILITY(U,$J,358.3,8977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8977,1,3,0)
 ;;=3^Alcoholic Hepatic Failure w/ Coma
 ;;^UTILITY(U,$J,358.3,8977,1,4,0)
 ;;=4^K70.41
 ;;^UTILITY(U,$J,358.3,8977,2)
 ;;=^5008791
 ;;^UTILITY(U,$J,358.3,8978,0)
 ;;=K73.0^^39^404^17
 ;;^UTILITY(U,$J,358.3,8978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8978,1,3,0)
 ;;=3^Hepatitis, Chronic Persistent NEC
 ;;^UTILITY(U,$J,358.3,8978,1,4,0)
 ;;=4^K73.0
 ;;^UTILITY(U,$J,358.3,8978,2)
 ;;=^5008811
 ;;^UTILITY(U,$J,358.3,8979,0)
 ;;=K74.69^^39^404^10
 ;;^UTILITY(U,$J,358.3,8979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8979,1,3,0)
 ;;=3^Cirrhosis of Liver,Oth
 ;;^UTILITY(U,$J,358.3,8979,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,8979,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,8980,0)
 ;;=K74.60^^39^404^11
 ;;^UTILITY(U,$J,358.3,8980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8980,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,8980,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,8980,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,8981,0)
 ;;=K76.0^^39^404^12
 ;;^UTILITY(U,$J,358.3,8981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8981,1,3,0)
 ;;=3^Fatty Liver NEC
 ;;^UTILITY(U,$J,358.3,8981,1,4,0)
 ;;=4^K76.0
 ;;^UTILITY(U,$J,358.3,8981,2)
 ;;=^5008831
 ;;^UTILITY(U,$J,358.3,8982,0)
 ;;=K76.89^^39^404^20
 ;;^UTILITY(U,$J,358.3,8982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8982,1,3,0)
 ;;=3^Liver Disease NEC
 ;;^UTILITY(U,$J,358.3,8982,1,4,0)
 ;;=4^K76.89
 ;;^UTILITY(U,$J,358.3,8982,2)
 ;;=^5008835
 ;;^UTILITY(U,$J,358.3,8983,0)
 ;;=K71.6^^39^404^34
 ;;^UTILITY(U,$J,358.3,8983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8983,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,8983,1,4,0)
 ;;=4^K71.6
 ;;^UTILITY(U,$J,358.3,8983,2)
 ;;=^5008801
 ;;^UTILITY(U,$J,358.3,8984,0)
 ;;=K75.9^^39^404^19
 ;;^UTILITY(U,$J,358.3,8984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8984,1,3,0)
 ;;=3^Inflammatory Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8984,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,8984,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,8985,0)
 ;;=K71.0^^39^404^26
 ;;^UTILITY(U,$J,358.3,8985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8985,1,3,0)
 ;;=3^Toxic Liver Disease w/ Cholestasis
 ;;^UTILITY(U,$J,358.3,8985,1,4,0)
 ;;=4^K71.0
 ;;^UTILITY(U,$J,358.3,8985,2)
 ;;=^5008793
 ;;^UTILITY(U,$J,358.3,8986,0)
 ;;=K71.10^^39^404^32
 ;;^UTILITY(U,$J,358.3,8986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8986,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/o Coma
 ;;^UTILITY(U,$J,358.3,8986,1,4,0)
 ;;=4^K71.10
 ;;^UTILITY(U,$J,358.3,8986,2)
 ;;=^5008794
 ;;^UTILITY(U,$J,358.3,8987,0)
 ;;=K71.11^^39^404^33
 ;;^UTILITY(U,$J,358.3,8987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8987,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/ Coma
 ;;^UTILITY(U,$J,358.3,8987,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,8987,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,8988,0)
 ;;=K71.2^^39^404^25
 ;;^UTILITY(U,$J,358.3,8988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8988,1,3,0)
 ;;=3^Toxic Liver Disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,8988,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,8988,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,8989,0)
 ;;=K71.3^^39^404^30
 ;;^UTILITY(U,$J,358.3,8989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8989,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
