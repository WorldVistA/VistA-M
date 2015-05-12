IBDEI0F6 ; ; 19-NOV-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20385,0)
 ;;=435.2^^107^1184^6
 ;;^UTILITY(U,$J,358.3,20385,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20385,1,2,0)
 ;;=2^435.2
 ;;^UTILITY(U,$J,358.3,20385,1,3,0)
 ;;=3^Subclavian Stenosis
 ;;^UTILITY(U,$J,358.3,20385,2)
 ;;=Subclavian Stenosis^115012
 ;;^UTILITY(U,$J,358.3,20386,0)
 ;;=435.9^^107^1184^7
 ;;^UTILITY(U,$J,358.3,20386,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20386,1,2,0)
 ;;=2^435.9
 ;;^UTILITY(U,$J,358.3,20386,1,3,0)
 ;;=3^Trans Ischemic Attack
 ;;^UTILITY(U,$J,358.3,20386,2)
 ;;=Trans Ischemic Attack^21635
 ;;^UTILITY(U,$J,358.3,20387,0)
 ;;=435.3^^107^1184^8
 ;;^UTILITY(U,$J,358.3,20387,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20387,1,2,0)
 ;;=2^435.3
 ;;^UTILITY(U,$J,358.3,20387,1,3,0)
 ;;=3^Vertebral Basilar Insuff
 ;;^UTILITY(U,$J,358.3,20387,2)
 ;;=Vertebral Basilar Insuffiency^260000
 ;;^UTILITY(U,$J,358.3,20388,0)
 ;;=438.20^^107^1184^4
 ;;^UTILITY(U,$J,358.3,20388,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20388,1,2,0)
 ;;=2^438.20
 ;;^UTILITY(U,$J,358.3,20388,1,3,0)
 ;;=3^Stroke w/Hemiplegia
 ;;^UTILITY(U,$J,358.3,20388,2)
 ;;=Stroke w/Hemiplegia^317910
 ;;^UTILITY(U,$J,358.3,20389,0)
 ;;=438.11^^107^1184^3
 ;;^UTILITY(U,$J,358.3,20389,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20389,1,2,0)
 ;;=2^438.11
 ;;^UTILITY(U,$J,358.3,20389,1,3,0)
 ;;=3^Stroke w/Aphasia
 ;;^UTILITY(U,$J,358.3,20389,2)
 ;;=Stroke w/Aphasia^317907
 ;;^UTILITY(U,$J,358.3,20390,0)
 ;;=438.6^^107^1184^5.1
 ;;^UTILITY(U,$J,358.3,20390,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20390,1,2,0)
 ;;=2^438.6
 ;;^UTILITY(U,$J,358.3,20390,1,3,0)
 ;;=3^Stroke w/Sensory Loss
 ;;^UTILITY(U,$J,358.3,20390,2)
 ;;=Stroke w/Sensory Loss^328503
 ;;^UTILITY(U,$J,358.3,20391,0)
 ;;=438.7^^107^1184^5.2
 ;;^UTILITY(U,$J,358.3,20391,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20391,1,2,0)
 ;;=2^438.7
 ;;^UTILITY(U,$J,358.3,20391,1,3,0)
 ;;=3^Stroke w/Vision Loss
 ;;^UTILITY(U,$J,358.3,20391,2)
 ;;=Stroke w/Vision Loss^328504
 ;;^UTILITY(U,$J,358.3,20392,0)
 ;;=438.85^^107^1184^5.3
 ;;^UTILITY(U,$J,358.3,20392,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20392,1,2,0)
 ;;=2^438.85
 ;;^UTILITY(U,$J,358.3,20392,1,3,0)
 ;;=3^Stroke w/Vertigo
 ;;^UTILITY(U,$J,358.3,20392,2)
 ;;=^328508
 ;;^UTILITY(U,$J,358.3,20393,0)
 ;;=438.82^^107^1184^5.5
 ;;^UTILITY(U,$J,358.3,20393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20393,1,2,0)
 ;;=2^438.82
 ;;^UTILITY(U,$J,358.3,20393,1,3,0)
 ;;=3^Stroke w/dysphagia
 ;;^UTILITY(U,$J,358.3,20393,2)
 ;;=Stroke w/dysphagia^317923
 ;;^UTILITY(U,$J,358.3,20394,0)
 ;;=438.89^^107^1184^5
 ;;^UTILITY(U,$J,358.3,20394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20394,1,2,0)
 ;;=2^438.89
 ;;^UTILITY(U,$J,358.3,20394,1,3,0)
 ;;=3^Stroke with Other Deficits
 ;;^UTILITY(U,$J,358.3,20394,2)
 ;;=^317924
 ;;^UTILITY(U,$J,358.3,20395,0)
 ;;=V12.54^^107^1184^9
 ;;^UTILITY(U,$J,358.3,20395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20395,1,2,0)
 ;;=2^V12.54
 ;;^UTILITY(U,$J,358.3,20395,1,3,0)
 ;;=3^Stroke F/U, No Residuals
 ;;^UTILITY(U,$J,358.3,20395,2)
 ;;=^335309
 ;;^UTILITY(U,$J,358.3,20396,0)
 ;;=345.10^^107^1185^8
 ;;^UTILITY(U,$J,358.3,20396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20396,1,2,0)
 ;;=2^345.10
 ;;^UTILITY(U,$J,358.3,20396,1,3,0)
 ;;=3^Myoclonic Seizures
 ;;^UTILITY(U,$J,358.3,20396,2)
 ;;=Myoclonic Epilepsy^268463
 ;;^UTILITY(U,$J,358.3,20397,0)
 ;;=345.11^^107^1185^9
 ;;^UTILITY(U,$J,358.3,20397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20397,1,2,0)
 ;;=2^345.11
 ;;^UTILITY(U,$J,358.3,20397,1,3,0)
 ;;=3^Myoclonic Seizures, Intractible
 ;;^UTILITY(U,$J,358.3,20397,2)
 ;;=Myoclonic, Intractable Epilepsy^268464
 ;;^UTILITY(U,$J,358.3,20398,0)
 ;;=345.50^^107^1185^11
 ;;^UTILITY(U,$J,358.3,20398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20398,1,2,0)
 ;;=2^345.50
 ;;^UTILITY(U,$J,358.3,20398,1,3,0)
 ;;=3^Simple Partial Seizures
 ;;^UTILITY(U,$J,358.3,20398,2)
 ;;=Simple Partial Epilepsy^268470
 ;;^UTILITY(U,$J,358.3,20399,0)
 ;;=345.51^^107^1185^12
 ;;^UTILITY(U,$J,358.3,20399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20399,1,2,0)
 ;;=2^345.51
 ;;^UTILITY(U,$J,358.3,20399,1,3,0)
 ;;=3^Simple Partial Seizures, Intract
 ;;^UTILITY(U,$J,358.3,20399,2)
 ;;=Simple Epilepsy Partial, Intract^268467
 ;;^UTILITY(U,$J,358.3,20400,0)
 ;;=345.40^^107^1185^2
 ;;^UTILITY(U,$J,358.3,20400,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20400,1,2,0)
 ;;=2^345.40
 ;;^UTILITY(U,$J,358.3,20400,1,3,0)
 ;;=3^Complex Partial Seizures
 ;;^UTILITY(U,$J,358.3,20400,2)
 ;;=Cmplx Partial Epilepsy^268467
 ;;^UTILITY(U,$J,358.3,20401,0)
 ;;=345.41^^107^1185^3
 ;;^UTILITY(U,$J,358.3,20401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20401,1,2,0)
 ;;=2^345.41
 ;;^UTILITY(U,$J,358.3,20401,1,3,0)
 ;;=3^Complex Partial Seizures, Intractible
 ;;^UTILITY(U,$J,358.3,20401,2)
 ;;=Complex Partial Seizures, Intractible^268469
 ;;^UTILITY(U,$J,358.3,20402,0)
 ;;=345.90^^107^1185^6
 ;;^UTILITY(U,$J,358.3,20402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20402,1,2,0)
 ;;=2^345.90
 ;;^UTILITY(U,$J,358.3,20402,1,3,0)
 ;;=3^Epilepsy,Unspec
 ;;^UTILITY(U,$J,358.3,20402,2)
 ;;=Unspecified Epilepsy^268477
 ;;^UTILITY(U,$J,358.3,20403,0)
 ;;=345.91^^107^1185^5
 ;;^UTILITY(U,$J,358.3,20403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20403,1,2,0)
 ;;=2^345.91
 ;;^UTILITY(U,$J,358.3,20403,1,3,0)
 ;;=3^Epilepsy w/ Intractable Epilepsy,Unspec
 ;;^UTILITY(U,$J,358.3,20403,2)
 ;;=Unspecified, Intract Epilepsy^268478
 ;;^UTILITY(U,$J,358.3,20404,0)
 ;;=780.02^^107^1185^13
 ;;^UTILITY(U,$J,358.3,20404,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20404,1,2,0)
 ;;=2^780.02
 ;;^UTILITY(U,$J,358.3,20404,1,3,0)
 ;;=3^Trans Alt of Awareness
 ;;^UTILITY(U,$J,358.3,20404,2)
 ;;=Trans Alt of Awareness^293932
 ;;^UTILITY(U,$J,358.3,20405,0)
 ;;=780.09^^107^1185^14
 ;;^UTILITY(U,$J,358.3,20405,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20405,1,2,0)
 ;;=2^780.09
 ;;^UTILITY(U,$J,358.3,20405,1,3,0)
 ;;=3^Trans Alt of Conscious
 ;;^UTILITY(U,$J,358.3,20405,2)
 ;;=Trans Alt of Conscious^260077
 ;;^UTILITY(U,$J,358.3,20406,0)
 ;;=780.33^^107^1185^10
 ;;^UTILITY(U,$J,358.3,20406,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20406,1,2,0)
 ;;=2^780.33
 ;;^UTILITY(U,$J,358.3,20406,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,20406,2)
 ;;=^339635
 ;;^UTILITY(U,$J,358.3,20407,0)
 ;;=780.31^^107^1185^7
 ;;^UTILITY(U,$J,358.3,20407,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20407,1,2,0)
 ;;=2^780.31
 ;;^UTILITY(U,$J,358.3,20407,1,3,0)
 ;;=3^Febrile Convulsions NOS
 ;;^UTILITY(U,$J,358.3,20407,2)
 ;;=^334260
 ;;^UTILITY(U,$J,358.3,20408,0)
 ;;=780.32^^107^1185^1
 ;;^UTILITY(U,$J,358.3,20408,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20408,1,2,0)
 ;;=2^780.32
 ;;^UTILITY(U,$J,358.3,20408,1,3,0)
 ;;=3^Complex Febrile Convulsions
 ;;^UTILITY(U,$J,358.3,20408,2)
 ;;=^334162
 ;;^UTILITY(U,$J,358.3,20409,0)
 ;;=780.39^^107^1185^4
 ;;^UTILITY(U,$J,358.3,20409,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20409,1,2,0)
 ;;=2^780.39
 ;;^UTILITY(U,$J,358.3,20409,1,3,0)
 ;;=3^Covulsions NEC
 ;;^UTILITY(U,$J,358.3,20409,2)
 ;;=^28162
 ;;^UTILITY(U,$J,358.3,20410,0)
 ;;=346.20^^107^1186^5
 ;;^UTILITY(U,$J,358.3,20410,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20410,1,2,0)
 ;;=2^346.20
 ;;^UTILITY(U,$J,358.3,20410,1,3,0)
 ;;=3^Cluster Headache
 ;;^UTILITY(U,$J,358.3,20410,2)
 ;;=Cluster Headach^294062
 ;;^UTILITY(U,$J,358.3,20411,0)
 ;;=346.90^^107^1186^15
 ;;^UTILITY(U,$J,358.3,20411,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20411,1,2,0)
 ;;=2^346.90
 ;;^UTILITY(U,$J,358.3,20411,1,3,0)
 ;;=3^Migraine Headaches
 ;;^UTILITY(U,$J,358.3,20411,2)
 ;;=Migraine Headache^293880
 ;;^UTILITY(U,$J,358.3,20412,0)
 ;;=307.81^^107^1186^16
 ;;^UTILITY(U,$J,358.3,20412,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20412,1,2,0)
 ;;=2^307.81
 ;;^UTILITY(U,$J,358.3,20412,1,3,0)
 ;;=3^Tension Headache
 ;;^UTILITY(U,$J,358.3,20412,2)
 ;;=Tension Headache^100405
 ;;^UTILITY(U,$J,358.3,20413,0)
 ;;=784.0^^107^1186^6
 ;;^UTILITY(U,$J,358.3,20413,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20413,1,2,0)
 ;;=2^784.0
 ;;^UTILITY(U,$J,358.3,20413,1,3,0)
 ;;=3^Headache, Unspecified
 ;;^UTILITY(U,$J,358.3,20413,2)
 ;;=Headache, Unspecified^54133
 ;;^UTILITY(U,$J,358.3,20414,0)
 ;;=346.70^^107^1186^3
 ;;^UTILITY(U,$J,358.3,20414,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20414,1,2,0)
 ;;=2^346.70
 ;;^UTILITY(U,$J,358.3,20414,1,3,0)
 ;;=3^Chr Mgrn w/o Aura/Itract Mgrn
 ;;^UTILITY(U,$J,358.3,20414,2)
 ;;=^336748
 ;;^UTILITY(U,$J,358.3,20415,0)
 ;;=346.71^^107^1186^2
 ;;^UTILITY(U,$J,358.3,20415,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20415,1,2,0)
 ;;=2^346.71
 ;;^UTILITY(U,$J,358.3,20415,1,3,0)
 ;;=3^Chr Mgrn w/o Aura w/Intract Mgrn
 ;;^UTILITY(U,$J,358.3,20415,2)
 ;;=^336584
 ;;^UTILITY(U,$J,358.3,20416,0)
 ;;=346.72^^107^1186^4
 ;;^UTILITY(U,$J,358.3,20416,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20416,1,2,0)
 ;;=2^346.72
 ;;^UTILITY(U,$J,358.3,20416,1,3,0)
 ;;=3^Chr Mgrn w/o Intr Mgrn w/ St Migrainosus
 ;;^UTILITY(U,$J,358.3,20416,2)
 ;;=^336585
 ;;^UTILITY(U,$J,358.3,20417,0)
 ;;=346.73^^107^1186^1
 ;;^UTILITY(U,$J,358.3,20417,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20417,1,2,0)
 ;;=2^346.73
 ;;^UTILITY(U,$J,358.3,20417,1,3,0)
 ;;=3^Chr Mgrn w/ Intr Mgrn/St Migrainosus
 ;;^UTILITY(U,$J,358.3,20417,2)
 ;;=^336586
 ;;^UTILITY(U,$J,358.3,20418,0)
 ;;=346.10^^107^1186^13
 ;;^UTILITY(U,$J,358.3,20418,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20418,1,2,0)
 ;;=2^346.10
 ;;^UTILITY(U,$J,358.3,20418,1,3,0)
 ;;=3^Mgrn w/o Aura/Intr Mgrn
 ;;^UTILITY(U,$J,358.3,20418,2)
 ;;=^336876
 ;;^UTILITY(U,$J,358.3,20419,0)
 ;;=346.11^^107^1186^11
 ;;^UTILITY(U,$J,358.3,20419,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20419,1,2,0)
 ;;=2^346.11
 ;;^UTILITY(U,$J,358.3,20419,1,3,0)
 ;;=3^Mgrn w/o Aura w/ Intr Mgrn
 ;;^UTILITY(U,$J,358.3,20419,2)
 ;;=^336829
