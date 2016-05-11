IBDEI2GI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41665,0)
 ;;=K75.9^^159^2007^17
 ;;^UTILITY(U,$J,358.3,41665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41665,1,3,0)
 ;;=3^Inflammatory Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,41665,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,41665,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,41666,0)
 ;;=K71.0^^159^2007^24
 ;;^UTILITY(U,$J,358.3,41666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41666,1,3,0)
 ;;=3^Toxic Liver Disease w/ Cholestasis
 ;;^UTILITY(U,$J,358.3,41666,1,4,0)
 ;;=4^K71.0
 ;;^UTILITY(U,$J,358.3,41666,2)
 ;;=^5008793
 ;;^UTILITY(U,$J,358.3,41667,0)
 ;;=K71.10^^159^2007^30
 ;;^UTILITY(U,$J,358.3,41667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41667,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/o Coma
 ;;^UTILITY(U,$J,358.3,41667,1,4,0)
 ;;=4^K71.10
 ;;^UTILITY(U,$J,358.3,41667,2)
 ;;=^5008794
 ;;^UTILITY(U,$J,358.3,41668,0)
 ;;=K71.11^^159^2007^31
 ;;^UTILITY(U,$J,358.3,41668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41668,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/ Coma
 ;;^UTILITY(U,$J,358.3,41668,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,41668,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,41669,0)
 ;;=K71.2^^159^2007^23
 ;;^UTILITY(U,$J,358.3,41669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41669,1,3,0)
 ;;=3^Toxic Liver Disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,41669,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,41669,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,41670,0)
 ;;=K71.3^^159^2007^28
 ;;^UTILITY(U,$J,358.3,41670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41670,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,41670,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,41670,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,41671,0)
 ;;=K71.4^^159^2007^27
 ;;^UTILITY(U,$J,358.3,41671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41671,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,41671,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,41671,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,41672,0)
 ;;=K75.81^^159^2007^19
 ;;^UTILITY(U,$J,358.3,41672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41672,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,41672,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,41672,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,41673,0)
 ;;=K75.89^^159^2007^16
 ;;^UTILITY(U,$J,358.3,41673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41673,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,41673,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,41673,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,41674,0)
 ;;=K76.4^^159^2007^21
 ;;^UTILITY(U,$J,358.3,41674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41674,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,41674,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,41674,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,41675,0)
 ;;=K71.50^^159^2007^25
 ;;^UTILITY(U,$J,358.3,41675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41675,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,41675,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,41675,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,41676,0)
 ;;=K71.51^^159^2007^26
 ;;^UTILITY(U,$J,358.3,41676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41676,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,41676,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,41676,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,41677,0)
 ;;=K71.7^^159^2007^29
 ;;^UTILITY(U,$J,358.3,41677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41677,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
