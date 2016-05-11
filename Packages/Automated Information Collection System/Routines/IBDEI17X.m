IBDEI17X ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20709,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,20709,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,20709,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,20710,0)
 ;;=G43.909^^84^936^27
 ;;^UTILITY(U,$J,358.3,20710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20710,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,20710,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,20710,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,20711,0)
 ;;=G43.919^^84^936^26
 ;;^UTILITY(U,$J,358.3,20711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20711,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,20711,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,20711,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,20712,0)
 ;;=G51.0^^84^936^5
 ;;^UTILITY(U,$J,358.3,20712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20712,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,20712,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,20712,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,20713,0)
 ;;=G57.10^^84^936^22
 ;;^UTILITY(U,$J,358.3,20713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20713,1,3,0)
 ;;=3^Meralgia Paresthetica Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,20713,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,20713,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,20714,0)
 ;;=G57.12^^84^936^23
 ;;^UTILITY(U,$J,358.3,20714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20714,1,3,0)
 ;;=3^Meralgia Paresthetica,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,20714,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,20714,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,20715,0)
 ;;=G57.11^^84^936^24
 ;;^UTILITY(U,$J,358.3,20715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20715,1,3,0)
 ;;=3^Meralgia Paresthetica,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,20715,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,20715,2)
 ;;=^5004042
 ;;^UTILITY(U,$J,358.3,20716,0)
 ;;=G60.8^^84^936^32
 ;;^UTILITY(U,$J,358.3,20716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20716,1,3,0)
 ;;=3^Neuropathies,Oth Hereditary and Idiopathic
 ;;^UTILITY(U,$J,358.3,20716,1,4,0)
 ;;=4^G60.8
 ;;^UTILITY(U,$J,358.3,20716,2)
 ;;=^5004070
 ;;^UTILITY(U,$J,358.3,20717,0)
 ;;=G60.9^^84^936^33
 ;;^UTILITY(U,$J,358.3,20717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20717,1,3,0)
 ;;=3^Neuropathy,Hereditary and Idiopathic Unspec
 ;;^UTILITY(U,$J,358.3,20717,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,20717,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,20718,0)
 ;;=I69.959^^84^936^18
 ;;^UTILITY(U,$J,358.3,20718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20718,1,3,0)
 ;;=3^Hemplg/Hemprs d/t Cerebvasc Diz Aff Unspec Side
 ;;^UTILITY(U,$J,358.3,20718,1,4,0)
 ;;=4^I69.959
 ;;^UTILITY(U,$J,358.3,20718,2)
 ;;=^5007563
 ;;^UTILITY(U,$J,358.3,20719,0)
 ;;=I69.359^^84^936^19
 ;;^UTILITY(U,$J,358.3,20719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20719,1,3,0)
 ;;=3^Hemplg/Hemprs d/t Cerebvasc Infrc Aff Unspec Side
 ;;^UTILITY(U,$J,358.3,20719,1,4,0)
 ;;=4^I69.359
 ;;^UTILITY(U,$J,358.3,20719,2)
 ;;=^5007508
 ;;^UTILITY(U,$J,358.3,20720,0)
 ;;=S14.109S^^84^936^39
 ;;^UTILITY(U,$J,358.3,20720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20720,1,3,0)
 ;;=3^Sequela of Unspec Injury to Cervical Spinal Cord
 ;;^UTILITY(U,$J,358.3,20720,1,4,0)
 ;;=4^S14.109S
 ;;^UTILITY(U,$J,358.3,20720,2)
 ;;=^5134243
 ;;^UTILITY(U,$J,358.3,20721,0)
 ;;=S34.109S^^84^936^40
 ;;^UTILITY(U,$J,358.3,20721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20721,1,3,0)
 ;;=3^Sequela of Unspec Injury to Lumbar Spinal Cord
