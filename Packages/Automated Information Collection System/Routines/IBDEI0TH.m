IBDEI0TH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13824,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/ Coma
 ;;^UTILITY(U,$J,358.3,13824,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,13824,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,13825,0)
 ;;=K71.2^^53^596^23
 ;;^UTILITY(U,$J,358.3,13825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13825,1,3,0)
 ;;=3^Toxic Liver Disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,13825,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,13825,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,13826,0)
 ;;=K71.3^^53^596^28
 ;;^UTILITY(U,$J,358.3,13826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13826,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,13826,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,13826,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,13827,0)
 ;;=K71.4^^53^596^27
 ;;^UTILITY(U,$J,358.3,13827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13827,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,13827,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,13827,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,13828,0)
 ;;=K75.81^^53^596^19
 ;;^UTILITY(U,$J,358.3,13828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13828,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,13828,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,13828,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,13829,0)
 ;;=K75.89^^53^596^16
 ;;^UTILITY(U,$J,358.3,13829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13829,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,13829,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,13829,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,13830,0)
 ;;=K76.4^^53^596^21
 ;;^UTILITY(U,$J,358.3,13830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13830,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,13830,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,13830,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,13831,0)
 ;;=K71.50^^53^596^25
 ;;^UTILITY(U,$J,358.3,13831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13831,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,13831,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,13831,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,13832,0)
 ;;=K71.51^^53^596^26
 ;;^UTILITY(U,$J,358.3,13832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13832,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,13832,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,13832,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,13833,0)
 ;;=K71.7^^53^596^29
 ;;^UTILITY(U,$J,358.3,13833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13833,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,13833,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,13833,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,13834,0)
 ;;=K71.8^^53^596^33
 ;;^UTILITY(U,$J,358.3,13834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13834,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,13834,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,13834,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,13835,0)
 ;;=K71.9^^53^596^34
 ;;^UTILITY(U,$J,358.3,13835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13835,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,13835,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,13835,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,13836,0)
 ;;=K75.2^^53^596^20
 ;;^UTILITY(U,$J,358.3,13836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13836,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,13836,1,4,0)
 ;;=4^K75.2
