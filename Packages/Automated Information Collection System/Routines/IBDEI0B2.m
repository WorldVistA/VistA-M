IBDEI0B2 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5221,1,5,0)
 ;;=5^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,5221,2)
 ;;=Parkinson's Disease^304847
 ;;^UTILITY(U,$J,358.3,5222,0)
 ;;=250.60^^41^483^89
 ;;^UTILITY(U,$J,358.3,5222,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5222,1,4,0)
 ;;=4^250.60
 ;;^UTILITY(U,$J,358.3,5222,1,5,0)
 ;;=5^Peripheral Neuropathy, Diabetic
 ;;^UTILITY(U,$J,358.3,5222,2)
 ;;=^267841^357.2
 ;;^UTILITY(U,$J,358.3,5223,0)
 ;;=356.9^^41^483^91
 ;;^UTILITY(U,$J,358.3,5223,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5223,1,4,0)
 ;;=4^356.9
 ;;^UTILITY(U,$J,358.3,5223,1,5,0)
 ;;=5^Peripheral Neuropathy, Unsp
 ;;^UTILITY(U,$J,358.3,5223,2)
 ;;=^123931
 ;;^UTILITY(U,$J,358.3,5224,0)
 ;;=780.2^^41^483^106
 ;;^UTILITY(U,$J,358.3,5224,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5224,1,4,0)
 ;;=4^780.2
 ;;^UTILITY(U,$J,358.3,5224,1,5,0)
 ;;=5^Syncope Or Presyncope
 ;;^UTILITY(U,$J,358.3,5224,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,5225,0)
 ;;=724.3^^41^483^102
 ;;^UTILITY(U,$J,358.3,5225,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5225,1,4,0)
 ;;=4^724.3
 ;;^UTILITY(U,$J,358.3,5225,1,5,0)
 ;;=5^Sciatica
 ;;^UTILITY(U,$J,358.3,5225,2)
 ;;=^108484
 ;;^UTILITY(U,$J,358.3,5226,0)
 ;;=780.39^^41^483^103
 ;;^UTILITY(U,$J,358.3,5226,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5226,1,4,0)
 ;;=4^780.39
 ;;^UTILITY(U,$J,358.3,5226,1,5,0)
 ;;=5^Seizure
 ;;^UTILITY(U,$J,358.3,5226,2)
 ;;=^28162
 ;;^UTILITY(U,$J,358.3,5227,0)
 ;;=782.0^^41^483^87
 ;;^UTILITY(U,$J,358.3,5227,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5227,1,4,0)
 ;;=4^782.0
 ;;^UTILITY(U,$J,358.3,5227,1,5,0)
 ;;=5^Parasthesia
 ;;^UTILITY(U,$J,358.3,5227,2)
 ;;=Parasthesia^35757
 ;;^UTILITY(U,$J,358.3,5228,0)
 ;;=435.9^^41^483^107
 ;;^UTILITY(U,$J,358.3,5228,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5228,1,4,0)
 ;;=4^435.9
 ;;^UTILITY(U,$J,358.3,5228,1,5,0)
 ;;=5^Transient Ischemic Attack
 ;;^UTILITY(U,$J,358.3,5228,2)
 ;;=^21635
 ;;^UTILITY(U,$J,358.3,5229,0)
 ;;=354.2^^41^483^109
 ;;^UTILITY(U,$J,358.3,5229,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5229,1,4,0)
 ;;=4^354.2
 ;;^UTILITY(U,$J,358.3,5229,1,5,0)
 ;;=5^Ulnar Nerve Entrapment
 ;;^UTILITY(U,$J,358.3,5229,2)
 ;;=^268506
 ;;^UTILITY(U,$J,358.3,5230,0)
 ;;=729.1^^41^483^35
 ;;^UTILITY(U,$J,358.3,5230,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5230,1,4,0)
 ;;=4^729.1
 ;;^UTILITY(U,$J,358.3,5230,1,5,0)
 ;;=5^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,5230,2)
 ;;=Fibromyalgia^80160
 ;;^UTILITY(U,$J,358.3,5231,0)
 ;;=438.20^^41^483^11
 ;;^UTILITY(U,$J,358.3,5231,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5231,1,4,0)
 ;;=4^438.20
 ;;^UTILITY(U,$J,358.3,5231,1,5,0)
 ;;=5^CVA w/Hemiplegia (late effect)
 ;;^UTILITY(U,$J,358.3,5231,2)
 ;;=CVA w/Hemiplegia^317910
 ;;^UTILITY(U,$J,358.3,5232,0)
 ;;=438.12^^41^483^8
 ;;^UTILITY(U,$J,358.3,5232,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5232,1,4,0)
 ;;=4^438.12
 ;;^UTILITY(U,$J,358.3,5232,1,5,0)
 ;;=5^CVA w/Dysphasia (late effect)
 ;;^UTILITY(U,$J,358.3,5232,2)
 ;;=Stroke w/Dysphasia^317908
 ;;^UTILITY(U,$J,358.3,5233,0)
 ;;=356.8^^41^483^90
 ;;^UTILITY(U,$J,358.3,5233,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5233,1,4,0)
 ;;=4^356.8
 ;;^UTILITY(U,$J,358.3,5233,1,5,0)
 ;;=5^Peripheral Neuropathy, Idiopathic
 ;;^UTILITY(U,$J,358.3,5233,2)
 ;;=Peripheral Neuropathy, Idio^268525
 ;;^UTILITY(U,$J,358.3,5234,0)
 ;;=337.20^^41^483^100
 ;;^UTILITY(U,$J,358.3,5234,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5234,1,4,0)
 ;;=4^337.20
 ;;^UTILITY(U,$J,358.3,5234,1,5,0)
 ;;=5^Reflexive Sympathetic Dystrophy
 ;;^UTILITY(U,$J,358.3,5234,2)
 ;;=Reflexive Sympathetic Dystrophy^295799
