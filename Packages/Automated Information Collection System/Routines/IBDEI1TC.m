IBDEI1TC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30354,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,30354,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,30354,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,30355,0)
 ;;=K71.4^^135^1375^27
 ;;^UTILITY(U,$J,358.3,30355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30355,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,30355,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,30355,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,30356,0)
 ;;=K75.81^^135^1375^19
 ;;^UTILITY(U,$J,358.3,30356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30356,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,30356,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,30356,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,30357,0)
 ;;=K75.89^^135^1375^16
 ;;^UTILITY(U,$J,358.3,30357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30357,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,30357,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,30357,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,30358,0)
 ;;=K76.4^^135^1375^21
 ;;^UTILITY(U,$J,358.3,30358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30358,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,30358,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,30358,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,30359,0)
 ;;=K71.50^^135^1375^25
 ;;^UTILITY(U,$J,358.3,30359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30359,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,30359,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,30359,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,30360,0)
 ;;=K71.51^^135^1375^26
 ;;^UTILITY(U,$J,358.3,30360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30360,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,30360,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,30360,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,30361,0)
 ;;=K71.7^^135^1375^29
 ;;^UTILITY(U,$J,358.3,30361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30361,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,30361,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,30361,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,30362,0)
 ;;=K71.8^^135^1375^33
 ;;^UTILITY(U,$J,358.3,30362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30362,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,30362,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,30362,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,30363,0)
 ;;=K71.9^^135^1375^34
 ;;^UTILITY(U,$J,358.3,30363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30363,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,30363,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,30363,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,30364,0)
 ;;=K75.2^^135^1375^20
 ;;^UTILITY(U,$J,358.3,30364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30364,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,30364,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,30364,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,30365,0)
 ;;=K75.3^^135^1375^13
 ;;^UTILITY(U,$J,358.3,30365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30365,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,30365,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,30365,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,30366,0)
 ;;=K76.6^^135^1375^22
 ;;^UTILITY(U,$J,358.3,30366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30366,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,30366,1,4,0)
 ;;=4^K76.6
