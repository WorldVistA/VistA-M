IBDEI2O5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44788,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,44788,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,44788,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,44789,0)
 ;;=K71.7^^200^2231^29
 ;;^UTILITY(U,$J,358.3,44789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44789,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,44789,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,44789,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,44790,0)
 ;;=K71.8^^200^2231^33
 ;;^UTILITY(U,$J,358.3,44790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44790,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,44790,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,44790,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,44791,0)
 ;;=K71.9^^200^2231^34
 ;;^UTILITY(U,$J,358.3,44791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44791,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,44791,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,44791,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,44792,0)
 ;;=K75.2^^200^2231^20
 ;;^UTILITY(U,$J,358.3,44792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44792,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,44792,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,44792,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,44793,0)
 ;;=K75.3^^200^2231^13
 ;;^UTILITY(U,$J,358.3,44793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44793,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,44793,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,44793,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,44794,0)
 ;;=K76.6^^200^2231^22
 ;;^UTILITY(U,$J,358.3,44794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44794,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,44794,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,44794,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,44795,0)
 ;;=F20.3^^200^2232^25
 ;;^UTILITY(U,$J,358.3,44795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44795,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,44795,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,44795,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,44796,0)
 ;;=F20.9^^200^2232^21
 ;;^UTILITY(U,$J,358.3,44796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44796,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,44796,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,44796,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,44797,0)
 ;;=F31.9^^200^2232^6
 ;;^UTILITY(U,$J,358.3,44797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44797,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,44797,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,44797,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,44798,0)
 ;;=F31.72^^200^2232^7
 ;;^UTILITY(U,$J,358.3,44798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44798,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,44798,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,44798,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,44799,0)
 ;;=F31.71^^200^2232^5
 ;;^UTILITY(U,$J,358.3,44799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44799,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,44799,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,44799,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,44800,0)
 ;;=F31.70^^200^2232^4
 ;;^UTILITY(U,$J,358.3,44800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44800,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,44800,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,44800,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,44801,0)
 ;;=F29.^^200^2232^19
