IBDEI07Y ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7880,1,3,0)
 ;;=3^Toxic Liver Disease w/ Cholestasis
 ;;^UTILITY(U,$J,358.3,7880,1,4,0)
 ;;=4^K71.0
 ;;^UTILITY(U,$J,358.3,7880,2)
 ;;=^5008793
 ;;^UTILITY(U,$J,358.3,7881,0)
 ;;=K71.10^^42^501^30
 ;;^UTILITY(U,$J,358.3,7881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7881,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/o Coma
 ;;^UTILITY(U,$J,358.3,7881,1,4,0)
 ;;=4^K71.10
 ;;^UTILITY(U,$J,358.3,7881,2)
 ;;=^5008794
 ;;^UTILITY(U,$J,358.3,7882,0)
 ;;=K71.11^^42^501^31
 ;;^UTILITY(U,$J,358.3,7882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7882,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/ Coma
 ;;^UTILITY(U,$J,358.3,7882,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,7882,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,7883,0)
 ;;=K71.2^^42^501^23
 ;;^UTILITY(U,$J,358.3,7883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7883,1,3,0)
 ;;=3^Toxic Liver Disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,7883,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,7883,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,7884,0)
 ;;=K71.3^^42^501^28
 ;;^UTILITY(U,$J,358.3,7884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7884,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,7884,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,7884,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,7885,0)
 ;;=K71.4^^42^501^27
 ;;^UTILITY(U,$J,358.3,7885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7885,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,7885,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,7885,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,7886,0)
 ;;=K75.81^^42^501^19
 ;;^UTILITY(U,$J,358.3,7886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7886,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,7886,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,7886,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,7887,0)
 ;;=K75.89^^42^501^16
 ;;^UTILITY(U,$J,358.3,7887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7887,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,7887,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,7887,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,7888,0)
 ;;=K76.4^^42^501^21
 ;;^UTILITY(U,$J,358.3,7888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7888,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,7888,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,7888,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,7889,0)
 ;;=K71.50^^42^501^25
 ;;^UTILITY(U,$J,358.3,7889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7889,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,7889,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,7889,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,7890,0)
 ;;=K71.51^^42^501^26
 ;;^UTILITY(U,$J,358.3,7890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7890,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,7890,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,7890,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,7891,0)
 ;;=K71.7^^42^501^29
 ;;^UTILITY(U,$J,358.3,7891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7891,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,7891,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,7891,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,7892,0)
 ;;=K71.8^^42^501^33
 ;;^UTILITY(U,$J,358.3,7892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7892,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,7892,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,7892,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,7893,0)
 ;;=K71.9^^42^501^34
 ;;^UTILITY(U,$J,358.3,7893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7893,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7893,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,7893,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,7894,0)
 ;;=K75.2^^42^501^20
 ;;^UTILITY(U,$J,358.3,7894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7894,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,7894,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,7894,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,7895,0)
 ;;=K75.3^^42^501^13
 ;;^UTILITY(U,$J,358.3,7895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7895,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,7895,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,7895,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,7896,0)
 ;;=K76.6^^42^501^22
 ;;^UTILITY(U,$J,358.3,7896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7896,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,7896,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,7896,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,7897,0)
 ;;=F20.3^^42^502^32
 ;;^UTILITY(U,$J,358.3,7897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7897,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,7897,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,7897,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,7898,0)
 ;;=F20.9^^42^502^27
 ;;^UTILITY(U,$J,358.3,7898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7898,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,7898,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,7898,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,7899,0)
 ;;=F31.9^^42^502^8
 ;;^UTILITY(U,$J,358.3,7899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7899,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,7899,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,7899,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,7900,0)
 ;;=F31.72^^42^502^9
 ;;^UTILITY(U,$J,358.3,7900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7900,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,7900,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,7900,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,7901,0)
 ;;=F31.71^^42^502^7
 ;;^UTILITY(U,$J,358.3,7901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7901,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,7901,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,7901,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,7902,0)
 ;;=F31.70^^42^502^6
 ;;^UTILITY(U,$J,358.3,7902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7902,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,7902,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,7902,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,7903,0)
 ;;=F29.^^42^502^25
 ;;^UTILITY(U,$J,358.3,7903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7903,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,7903,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,7903,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,7904,0)
 ;;=F28.^^42^502^26
 ;;^UTILITY(U,$J,358.3,7904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7904,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
 ;;^UTILITY(U,$J,358.3,7904,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,7904,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,7905,0)
 ;;=F41.9^^42^502^5
 ;;^UTILITY(U,$J,358.3,7905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7905,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,7905,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,7905,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,7906,0)
 ;;=F42.^^42^502^19
 ;;^UTILITY(U,$J,358.3,7906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7906,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,7906,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,7906,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,7907,0)
 ;;=F45.0^^42^502^29
 ;;^UTILITY(U,$J,358.3,7907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7907,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,7907,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,7907,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,7908,0)
 ;;=F69.^^42^502^2
 ;;^UTILITY(U,$J,358.3,7908,1,0)
 ;;=^358.31IA^4^2
