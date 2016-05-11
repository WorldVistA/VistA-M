IBDEI0U1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14083,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,14083,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,14083,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,14084,0)
 ;;=G43.909^^53^600^27
 ;;^UTILITY(U,$J,358.3,14084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14084,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,14084,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,14084,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,14085,0)
 ;;=G43.919^^53^600^26
 ;;^UTILITY(U,$J,358.3,14085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14085,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,14085,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,14085,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,14086,0)
 ;;=G51.0^^53^600^5
 ;;^UTILITY(U,$J,358.3,14086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14086,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,14086,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,14086,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,14087,0)
 ;;=G57.10^^53^600^22
 ;;^UTILITY(U,$J,358.3,14087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14087,1,3,0)
 ;;=3^Meralgia Paresthetica Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,14087,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,14087,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,14088,0)
 ;;=G57.12^^53^600^23
 ;;^UTILITY(U,$J,358.3,14088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14088,1,3,0)
 ;;=3^Meralgia Paresthetica,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,14088,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,14088,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,14089,0)
 ;;=G57.11^^53^600^24
 ;;^UTILITY(U,$J,358.3,14089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14089,1,3,0)
 ;;=3^Meralgia Paresthetica,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,14089,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,14089,2)
 ;;=^5004042
 ;;^UTILITY(U,$J,358.3,14090,0)
 ;;=G60.8^^53^600^32
 ;;^UTILITY(U,$J,358.3,14090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14090,1,3,0)
 ;;=3^Neuropathies,Oth Hereditary and Idiopathic
 ;;^UTILITY(U,$J,358.3,14090,1,4,0)
 ;;=4^G60.8
 ;;^UTILITY(U,$J,358.3,14090,2)
 ;;=^5004070
 ;;^UTILITY(U,$J,358.3,14091,0)
 ;;=G60.9^^53^600^33
 ;;^UTILITY(U,$J,358.3,14091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14091,1,3,0)
 ;;=3^Neuropathy,Hereditary and Idiopathic Unspec
 ;;^UTILITY(U,$J,358.3,14091,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,14091,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,14092,0)
 ;;=I69.959^^53^600^18
 ;;^UTILITY(U,$J,358.3,14092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14092,1,3,0)
 ;;=3^Hemplg/Hemprs d/t Cerebvasc Diz Aff Unspec Side
 ;;^UTILITY(U,$J,358.3,14092,1,4,0)
 ;;=4^I69.959
 ;;^UTILITY(U,$J,358.3,14092,2)
 ;;=^5007563
 ;;^UTILITY(U,$J,358.3,14093,0)
 ;;=I69.359^^53^600^19
 ;;^UTILITY(U,$J,358.3,14093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14093,1,3,0)
 ;;=3^Hemplg/Hemprs d/t Cerebvasc Infrc Aff Unspec Side
 ;;^UTILITY(U,$J,358.3,14093,1,4,0)
 ;;=4^I69.359
 ;;^UTILITY(U,$J,358.3,14093,2)
 ;;=^5007508
 ;;^UTILITY(U,$J,358.3,14094,0)
 ;;=S14.109S^^53^600^39
 ;;^UTILITY(U,$J,358.3,14094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14094,1,3,0)
 ;;=3^Sequela of Unspec Injury to Cervical Spinal Cord
 ;;^UTILITY(U,$J,358.3,14094,1,4,0)
 ;;=4^S14.109S
 ;;^UTILITY(U,$J,358.3,14094,2)
 ;;=^5134243
 ;;^UTILITY(U,$J,358.3,14095,0)
 ;;=S34.109S^^53^600^40
 ;;^UTILITY(U,$J,358.3,14095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14095,1,3,0)
 ;;=3^Sequela of Unspec Injury to Lumbar Spinal Cord
