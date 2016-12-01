IBDEI0HD ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22006,2)
 ;;=^5008835
 ;;^UTILITY(U,$J,358.3,22007,0)
 ;;=K71.6^^58^843^32
 ;;^UTILITY(U,$J,358.3,22007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22007,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,22007,1,4,0)
 ;;=4^K71.6
 ;;^UTILITY(U,$J,358.3,22007,2)
 ;;=^5008801
 ;;^UTILITY(U,$J,358.3,22008,0)
 ;;=K75.9^^58^843^17
 ;;^UTILITY(U,$J,358.3,22008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22008,1,3,0)
 ;;=3^Inflammatory Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22008,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,22008,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,22009,0)
 ;;=K71.0^^58^843^24
 ;;^UTILITY(U,$J,358.3,22009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22009,1,3,0)
 ;;=3^Toxic Liver Disease w/ Cholestasis
 ;;^UTILITY(U,$J,358.3,22009,1,4,0)
 ;;=4^K71.0
 ;;^UTILITY(U,$J,358.3,22009,2)
 ;;=^5008793
 ;;^UTILITY(U,$J,358.3,22010,0)
 ;;=K71.10^^58^843^30
 ;;^UTILITY(U,$J,358.3,22010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22010,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/o Coma
 ;;^UTILITY(U,$J,358.3,22010,1,4,0)
 ;;=4^K71.10
 ;;^UTILITY(U,$J,358.3,22010,2)
 ;;=^5008794
 ;;^UTILITY(U,$J,358.3,22011,0)
 ;;=K71.11^^58^843^31
 ;;^UTILITY(U,$J,358.3,22011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22011,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/ Coma
 ;;^UTILITY(U,$J,358.3,22011,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,22011,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,22012,0)
 ;;=K71.2^^58^843^23
 ;;^UTILITY(U,$J,358.3,22012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22012,1,3,0)
 ;;=3^Toxic Liver Disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,22012,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,22012,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,22013,0)
 ;;=K71.3^^58^843^28
 ;;^UTILITY(U,$J,358.3,22013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22013,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,22013,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,22013,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,22014,0)
 ;;=K71.4^^58^843^27
 ;;^UTILITY(U,$J,358.3,22014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22014,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,22014,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,22014,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,22015,0)
 ;;=K75.81^^58^843^19
 ;;^UTILITY(U,$J,358.3,22015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22015,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,22015,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,22015,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,22016,0)
 ;;=K75.89^^58^843^16
 ;;^UTILITY(U,$J,358.3,22016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22016,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,22016,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,22016,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,22017,0)
 ;;=K76.4^^58^843^21
 ;;^UTILITY(U,$J,358.3,22017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22017,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,22017,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,22017,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,22018,0)
 ;;=K71.50^^58^843^25
 ;;^UTILITY(U,$J,358.3,22018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22018,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,22018,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,22018,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,22019,0)
 ;;=K71.51^^58^843^26
 ;;^UTILITY(U,$J,358.3,22019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22019,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,22019,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,22019,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,22020,0)
 ;;=K71.7^^58^843^29
 ;;^UTILITY(U,$J,358.3,22020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22020,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,22020,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,22020,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,22021,0)
 ;;=K71.8^^58^843^33
 ;;^UTILITY(U,$J,358.3,22021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22021,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,22021,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,22021,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,22022,0)
 ;;=K71.9^^58^843^34
 ;;^UTILITY(U,$J,358.3,22022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22022,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22022,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,22022,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,22023,0)
 ;;=K75.2^^58^843^20
 ;;^UTILITY(U,$J,358.3,22023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22023,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,22023,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,22023,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,22024,0)
 ;;=K75.3^^58^843^13
 ;;^UTILITY(U,$J,358.3,22024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22024,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,22024,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,22024,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,22025,0)
 ;;=K76.6^^58^843^22
 ;;^UTILITY(U,$J,358.3,22025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22025,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,22025,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,22025,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,22026,0)
 ;;=F20.3^^58^844^25
 ;;^UTILITY(U,$J,358.3,22026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22026,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,22026,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,22026,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,22027,0)
 ;;=F20.9^^58^844^21
 ;;^UTILITY(U,$J,358.3,22027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22027,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,22027,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,22027,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,22028,0)
 ;;=F31.9^^58^844^6
 ;;^UTILITY(U,$J,358.3,22028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22028,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,22028,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,22028,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,22029,0)
 ;;=F31.72^^58^844^7
 ;;^UTILITY(U,$J,358.3,22029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22029,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,22029,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,22029,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,22030,0)
 ;;=F31.71^^58^844^5
 ;;^UTILITY(U,$J,358.3,22030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22030,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,22030,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,22030,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,22031,0)
 ;;=F31.70^^58^844^4
 ;;^UTILITY(U,$J,358.3,22031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22031,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,22031,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,22031,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,22032,0)
 ;;=F29.^^58^844^19
 ;;^UTILITY(U,$J,358.3,22032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22032,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,22032,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,22032,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,22033,0)
 ;;=F28.^^58^844^20
 ;;^UTILITY(U,$J,358.3,22033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22033,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
 ;;^UTILITY(U,$J,358.3,22033,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,22033,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,22034,0)
 ;;=F41.9^^58^844^3
 ;;^UTILITY(U,$J,358.3,22034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22034,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,22034,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,22034,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,22035,0)
 ;;=F42.^^58^844^13
 ;;^UTILITY(U,$J,358.3,22035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22035,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,22035,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,22035,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,22036,0)
 ;;=F45.0^^58^844^23
 ;;^UTILITY(U,$J,358.3,22036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22036,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,22036,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,22036,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,22037,0)
 ;;=F69.^^58^844^2
 ;;^UTILITY(U,$J,358.3,22037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22037,1,3,0)
 ;;=3^Adult Personality and Behavior Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,22037,1,4,0)
 ;;=4^F69.
 ;;^UTILITY(U,$J,358.3,22037,2)
 ;;=^5003667
 ;;^UTILITY(U,$J,358.3,22038,0)
 ;;=F60.9^^58^844^17
 ;;^UTILITY(U,$J,358.3,22038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22038,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,22038,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,22038,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,22039,0)
 ;;=F32.9^^58^844^12
 ;;^UTILITY(U,$J,358.3,22039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22039,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,22039,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,22039,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,22040,0)
 ;;=F40.231^^58^844^9
 ;;^UTILITY(U,$J,358.3,22040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22040,1,3,0)
 ;;=3^Fear of Injections/Transfusions
 ;;^UTILITY(U,$J,358.3,22040,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,22040,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,22041,0)
 ;;=F40.240^^58^844^8
 ;;^UTILITY(U,$J,358.3,22041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22041,1,3,0)
 ;;=3^Claustrophobia
 ;;^UTILITY(U,$J,358.3,22041,1,4,0)
 ;;=4^F40.240
 ;;^UTILITY(U,$J,358.3,22041,2)
 ;;=^5003554
