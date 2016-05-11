IBDEI0F2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6941,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,6941,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,6942,0)
 ;;=K71.51^^30^399^26
 ;;^UTILITY(U,$J,358.3,6942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6942,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,6942,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,6942,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,6943,0)
 ;;=K71.7^^30^399^29
 ;;^UTILITY(U,$J,358.3,6943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6943,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,6943,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,6943,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,6944,0)
 ;;=K71.8^^30^399^33
 ;;^UTILITY(U,$J,358.3,6944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6944,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,6944,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,6944,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,6945,0)
 ;;=K71.9^^30^399^34
 ;;^UTILITY(U,$J,358.3,6945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6945,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6945,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,6945,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,6946,0)
 ;;=K75.2^^30^399^20
 ;;^UTILITY(U,$J,358.3,6946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6946,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,6946,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,6946,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,6947,0)
 ;;=K75.3^^30^399^13
 ;;^UTILITY(U,$J,358.3,6947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6947,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,6947,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,6947,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,6948,0)
 ;;=K76.6^^30^399^22
 ;;^UTILITY(U,$J,358.3,6948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6948,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,6948,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,6948,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,6949,0)
 ;;=F20.3^^30^400^32
 ;;^UTILITY(U,$J,358.3,6949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6949,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,6949,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,6949,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,6950,0)
 ;;=F20.9^^30^400^27
 ;;^UTILITY(U,$J,358.3,6950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6950,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,6950,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,6950,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,6951,0)
 ;;=F31.9^^30^400^8
 ;;^UTILITY(U,$J,358.3,6951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6951,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,6951,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,6951,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,6952,0)
 ;;=F31.72^^30^400^9
 ;;^UTILITY(U,$J,358.3,6952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6952,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,6952,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,6952,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,6953,0)
 ;;=F31.71^^30^400^7
 ;;^UTILITY(U,$J,358.3,6953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6953,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,6953,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,6953,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,6954,0)
 ;;=F31.70^^30^400^6
 ;;^UTILITY(U,$J,358.3,6954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6954,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
