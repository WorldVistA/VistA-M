IBDEI17D ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20450,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/ Coma
 ;;^UTILITY(U,$J,358.3,20450,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,20450,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,20451,0)
 ;;=K71.2^^84^932^23
 ;;^UTILITY(U,$J,358.3,20451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20451,1,3,0)
 ;;=3^Toxic Liver Disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,20451,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,20451,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,20452,0)
 ;;=K71.3^^84^932^28
 ;;^UTILITY(U,$J,358.3,20452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20452,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,20452,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,20452,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,20453,0)
 ;;=K71.4^^84^932^27
 ;;^UTILITY(U,$J,358.3,20453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20453,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,20453,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,20453,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,20454,0)
 ;;=K75.81^^84^932^19
 ;;^UTILITY(U,$J,358.3,20454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20454,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,20454,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,20454,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,20455,0)
 ;;=K75.89^^84^932^16
 ;;^UTILITY(U,$J,358.3,20455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20455,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,20455,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,20455,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,20456,0)
 ;;=K76.4^^84^932^21
 ;;^UTILITY(U,$J,358.3,20456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20456,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,20456,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,20456,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,20457,0)
 ;;=K71.50^^84^932^25
 ;;^UTILITY(U,$J,358.3,20457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20457,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,20457,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,20457,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,20458,0)
 ;;=K71.51^^84^932^26
 ;;^UTILITY(U,$J,358.3,20458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20458,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,20458,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,20458,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,20459,0)
 ;;=K71.7^^84^932^29
 ;;^UTILITY(U,$J,358.3,20459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20459,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,20459,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,20459,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,20460,0)
 ;;=K71.8^^84^932^33
 ;;^UTILITY(U,$J,358.3,20460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20460,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,20460,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,20460,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,20461,0)
 ;;=K71.9^^84^932^34
 ;;^UTILITY(U,$J,358.3,20461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20461,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,20461,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,20461,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,20462,0)
 ;;=K75.2^^84^932^20
 ;;^UTILITY(U,$J,358.3,20462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20462,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,20462,1,4,0)
 ;;=4^K75.2
