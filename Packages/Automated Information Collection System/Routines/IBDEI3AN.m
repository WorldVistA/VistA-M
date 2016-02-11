IBDEI3AN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,55351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55351,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,55351,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,55351,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,55352,0)
 ;;=K71.4^^256^2778^27
 ;;^UTILITY(U,$J,358.3,55352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55352,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,55352,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,55352,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,55353,0)
 ;;=K75.81^^256^2778^19
 ;;^UTILITY(U,$J,358.3,55353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55353,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,55353,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,55353,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,55354,0)
 ;;=K75.89^^256^2778^16
 ;;^UTILITY(U,$J,358.3,55354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55354,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,55354,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,55354,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,55355,0)
 ;;=K76.4^^256^2778^21
 ;;^UTILITY(U,$J,358.3,55355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55355,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,55355,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,55355,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,55356,0)
 ;;=K71.50^^256^2778^25
 ;;^UTILITY(U,$J,358.3,55356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55356,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,55356,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,55356,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,55357,0)
 ;;=K71.51^^256^2778^26
 ;;^UTILITY(U,$J,358.3,55357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55357,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,55357,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,55357,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,55358,0)
 ;;=K71.7^^256^2778^29
 ;;^UTILITY(U,$J,358.3,55358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55358,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,55358,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,55358,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,55359,0)
 ;;=K71.8^^256^2778^33
 ;;^UTILITY(U,$J,358.3,55359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55359,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,55359,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,55359,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,55360,0)
 ;;=K71.9^^256^2778^34
 ;;^UTILITY(U,$J,358.3,55360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55360,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,55360,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,55360,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,55361,0)
 ;;=K75.2^^256^2778^20
 ;;^UTILITY(U,$J,358.3,55361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55361,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,55361,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,55361,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,55362,0)
 ;;=K75.3^^256^2778^13
 ;;^UTILITY(U,$J,358.3,55362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55362,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,55362,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,55362,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,55363,0)
 ;;=K76.6^^256^2778^22
 ;;^UTILITY(U,$J,358.3,55363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55363,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,55363,1,4,0)
 ;;=4^K76.6
