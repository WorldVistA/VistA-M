IBDEI15L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19267,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,19267,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,19267,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,19268,0)
 ;;=K71.51^^94^919^26
 ;;^UTILITY(U,$J,358.3,19268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19268,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,19268,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,19268,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,19269,0)
 ;;=K71.7^^94^919^29
 ;;^UTILITY(U,$J,358.3,19269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19269,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,19269,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,19269,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,19270,0)
 ;;=K71.8^^94^919^33
 ;;^UTILITY(U,$J,358.3,19270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19270,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,19270,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,19270,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,19271,0)
 ;;=K71.9^^94^919^34
 ;;^UTILITY(U,$J,358.3,19271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19271,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,19271,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,19271,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,19272,0)
 ;;=K75.2^^94^919^20
 ;;^UTILITY(U,$J,358.3,19272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19272,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,19272,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,19272,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,19273,0)
 ;;=K75.3^^94^919^13
 ;;^UTILITY(U,$J,358.3,19273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19273,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,19273,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,19273,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,19274,0)
 ;;=K76.6^^94^919^22
 ;;^UTILITY(U,$J,358.3,19274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19274,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,19274,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,19274,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,19275,0)
 ;;=F20.3^^94^920^25
 ;;^UTILITY(U,$J,358.3,19275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19275,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,19275,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,19275,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,19276,0)
 ;;=F20.9^^94^920^21
 ;;^UTILITY(U,$J,358.3,19276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19276,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,19276,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,19276,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,19277,0)
 ;;=F31.9^^94^920^6
 ;;^UTILITY(U,$J,358.3,19277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19277,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,19277,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,19277,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,19278,0)
 ;;=F31.72^^94^920^7
 ;;^UTILITY(U,$J,358.3,19278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19278,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,19278,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,19278,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,19279,0)
 ;;=F31.71^^94^920^5
 ;;^UTILITY(U,$J,358.3,19279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19279,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,19279,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,19279,2)
 ;;=^5003511
