IBDEI0DV ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6298,1,5,0)
 ;;=5^Parasthesia
 ;;^UTILITY(U,$J,358.3,6298,2)
 ;;=Parasthesia^35757
 ;;^UTILITY(U,$J,358.3,6299,0)
 ;;=435.9^^31^408^51
 ;;^UTILITY(U,$J,358.3,6299,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6299,1,4,0)
 ;;=4^435.9
 ;;^UTILITY(U,$J,358.3,6299,1,5,0)
 ;;=5^Transient Ischemic Attack
 ;;^UTILITY(U,$J,358.3,6299,2)
 ;;=^21635
 ;;^UTILITY(U,$J,358.3,6300,0)
 ;;=354.2^^31^408^53
 ;;^UTILITY(U,$J,358.3,6300,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6300,1,4,0)
 ;;=4^354.2
 ;;^UTILITY(U,$J,358.3,6300,1,5,0)
 ;;=5^Ulnar Nerve Entrapment
 ;;^UTILITY(U,$J,358.3,6300,2)
 ;;=^268506
 ;;^UTILITY(U,$J,358.3,6301,0)
 ;;=729.1^^31^408^23
 ;;^UTILITY(U,$J,358.3,6301,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6301,1,4,0)
 ;;=4^729.1
 ;;^UTILITY(U,$J,358.3,6301,1,5,0)
 ;;=5^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,6301,2)
 ;;=Fibromyalgia^80160
 ;;^UTILITY(U,$J,358.3,6302,0)
 ;;=438.20^^31^408^11
 ;;^UTILITY(U,$J,358.3,6302,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6302,1,4,0)
 ;;=4^438.20
 ;;^UTILITY(U,$J,358.3,6302,1,5,0)
 ;;=5^CVA with Hemiplegia (late effect)
 ;;^UTILITY(U,$J,358.3,6302,2)
 ;;=CVA w/Hemiplegia^317910
 ;;^UTILITY(U,$J,358.3,6303,0)
 ;;=438.12^^31^408^10
 ;;^UTILITY(U,$J,358.3,6303,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6303,1,4,0)
 ;;=4^438.12
 ;;^UTILITY(U,$J,358.3,6303,1,5,0)
 ;;=5^CVA with Dysphasia (late effect)
 ;;^UTILITY(U,$J,358.3,6303,2)
 ;;=Stroke w/Dysphasia^317908
 ;;^UTILITY(U,$J,358.3,6304,0)
 ;;=356.8^^31^408^39
 ;;^UTILITY(U,$J,358.3,6304,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6304,1,4,0)
 ;;=4^356.8
 ;;^UTILITY(U,$J,358.3,6304,1,5,0)
 ;;=5^Peripheral Neuropathy, Idiopathic
 ;;^UTILITY(U,$J,358.3,6304,2)
 ;;=Peripheral Neuropathy, Idio^268525
 ;;^UTILITY(U,$J,358.3,6305,0)
 ;;=337.20^^31^408^42
 ;;^UTILITY(U,$J,358.3,6305,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6305,1,4,0)
 ;;=4^337.20
 ;;^UTILITY(U,$J,358.3,6305,1,5,0)
 ;;=5^Reflexive Sympathetic Dystrophy
 ;;^UTILITY(U,$J,358.3,6305,2)
 ;;=Reflexive Sympathetic Dystrophy^295799
 ;;^UTILITY(U,$J,358.3,6306,0)
 ;;=294.8^^31^408^20
 ;;^UTILITY(U,$J,358.3,6306,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6306,1,4,0)
 ;;=4^294.8
 ;;^UTILITY(U,$J,358.3,6306,1,5,0)
 ;;=5^Dementia, Other
 ;;^UTILITY(U,$J,358.3,6306,2)
 ;;=^268044
 ;;^UTILITY(U,$J,358.3,6307,0)
 ;;=438.6^^31^408^7
 ;;^UTILITY(U,$J,358.3,6307,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6307,1,4,0)
 ;;=4^438.6
 ;;^UTILITY(U,$J,358.3,6307,1,5,0)
 ;;=5^CVA w/Dysesthesia (late effect)
 ;;^UTILITY(U,$J,358.3,6307,2)
 ;;=CVA w/Dysesthesia (late effect)^328503
 ;;^UTILITY(U,$J,358.3,6308,0)
 ;;=438.7^^31^408^9
 ;;^UTILITY(U,$J,358.3,6308,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6308,1,4,0)
 ;;=4^438.7
 ;;^UTILITY(U,$J,358.3,6308,1,5,0)
 ;;=5^CVA w/Vision Changes (late effect)
 ;;^UTILITY(U,$J,358.3,6308,2)
 ;;=CVA w/Vision Changes (late effect)^328504
 ;;^UTILITY(U,$J,358.3,6309,0)
 ;;=438.84^^31^408^6
 ;;^UTILITY(U,$J,358.3,6309,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6309,1,4,0)
 ;;=4^438.84
 ;;^UTILITY(U,$J,358.3,6309,1,5,0)
 ;;=5^CVA w/Ataxia (late effect)
 ;;^UTILITY(U,$J,358.3,6309,2)
 ;;=CVA w/Ataxia (late effect)^328507
 ;;^UTILITY(U,$J,358.3,6310,0)
 ;;=434.91^^31^408^12
 ;;^UTILITY(U,$J,358.3,6310,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6310,1,4,0)
 ;;=4^434.91
 ;;^UTILITY(U,$J,358.3,6310,1,5,0)
 ;;=5^CVA, Acute Onset
 ;;^UTILITY(U,$J,358.3,6310,2)
 ;;=^295738
 ;;^UTILITY(U,$J,358.3,6311,0)
 ;;=333.94^^31^408^43
 ;;^UTILITY(U,$J,358.3,6311,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6311,1,4,0)
 ;;=4^333.94
