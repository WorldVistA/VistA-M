IBDEI1CB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22780,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,22780,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,22780,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,22781,0)
 ;;=K71.50^^87^984^25
 ;;^UTILITY(U,$J,358.3,22781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22781,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,22781,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,22781,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,22782,0)
 ;;=K71.51^^87^984^26
 ;;^UTILITY(U,$J,358.3,22782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22782,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,22782,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,22782,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,22783,0)
 ;;=K71.7^^87^984^29
 ;;^UTILITY(U,$J,358.3,22783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22783,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,22783,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,22783,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,22784,0)
 ;;=K71.8^^87^984^33
 ;;^UTILITY(U,$J,358.3,22784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22784,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,22784,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,22784,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,22785,0)
 ;;=K71.9^^87^984^34
 ;;^UTILITY(U,$J,358.3,22785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22785,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22785,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,22785,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,22786,0)
 ;;=K75.2^^87^984^20
 ;;^UTILITY(U,$J,358.3,22786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22786,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,22786,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,22786,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,22787,0)
 ;;=K75.3^^87^984^13
 ;;^UTILITY(U,$J,358.3,22787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22787,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,22787,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,22787,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,22788,0)
 ;;=K76.6^^87^984^22
 ;;^UTILITY(U,$J,358.3,22788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22788,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,22788,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,22788,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,22789,0)
 ;;=F20.3^^87^985^25
 ;;^UTILITY(U,$J,358.3,22789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22789,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,22789,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,22789,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,22790,0)
 ;;=F20.9^^87^985^21
 ;;^UTILITY(U,$J,358.3,22790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22790,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,22790,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,22790,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,22791,0)
 ;;=F31.9^^87^985^6
 ;;^UTILITY(U,$J,358.3,22791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22791,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,22791,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,22791,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,22792,0)
 ;;=F31.72^^87^985^7
 ;;^UTILITY(U,$J,358.3,22792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22792,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,22792,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,22792,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,22793,0)
 ;;=F31.71^^87^985^5
