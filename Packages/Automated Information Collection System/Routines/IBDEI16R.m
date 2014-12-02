IBDEI16R ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21228,1,4,0)
 ;;=4^354.2
 ;;^UTILITY(U,$J,358.3,21228,1,5,0)
 ;;=5^Ulnar Nerve Entrapment
 ;;^UTILITY(U,$J,358.3,21228,2)
 ;;=^268506
 ;;^UTILITY(U,$J,358.3,21229,0)
 ;;=729.1^^133^1312^21
 ;;^UTILITY(U,$J,358.3,21229,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21229,1,4,0)
 ;;=4^729.1
 ;;^UTILITY(U,$J,358.3,21229,1,5,0)
 ;;=5^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,21229,2)
 ;;=Fibromyalgia^80160
 ;;^UTILITY(U,$J,358.3,21230,0)
 ;;=438.20^^133^1312^6
 ;;^UTILITY(U,$J,358.3,21230,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21230,1,4,0)
 ;;=4^438.20
 ;;^UTILITY(U,$J,358.3,21230,1,5,0)
 ;;=5^CVA w/ Hemiplegia (Late Effect)
 ;;^UTILITY(U,$J,358.3,21230,2)
 ;;=CVA w/Hemiplegia^317910
 ;;^UTILITY(U,$J,358.3,21231,0)
 ;;=438.12^^133^1312^5
 ;;^UTILITY(U,$J,358.3,21231,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21231,1,4,0)
 ;;=4^438.12
 ;;^UTILITY(U,$J,358.3,21231,1,5,0)
 ;;=5^CVA w/ Dysphasia (Late Effect)
 ;;^UTILITY(U,$J,358.3,21231,2)
 ;;=Stroke w/Dysphasia^317908
 ;;^UTILITY(U,$J,358.3,21232,0)
 ;;=356.8^^133^1312^51
 ;;^UTILITY(U,$J,358.3,21232,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21232,1,4,0)
 ;;=4^356.8
 ;;^UTILITY(U,$J,358.3,21232,1,5,0)
 ;;=5^Peripheral Neuropathy, Idiopathic
 ;;^UTILITY(U,$J,358.3,21232,2)
 ;;=Peripheral Neuropathy, Idio^268525
 ;;^UTILITY(U,$J,358.3,21233,0)
 ;;=337.20^^133^1312^58
 ;;^UTILITY(U,$J,358.3,21233,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21233,1,4,0)
 ;;=4^337.20
 ;;^UTILITY(U,$J,358.3,21233,1,5,0)
 ;;=5^Reflexive Sympathetic Dystrophy
 ;;^UTILITY(U,$J,358.3,21233,2)
 ;;=Reflexive Sympathetic Dystrophy^295799
 ;;^UTILITY(U,$J,358.3,21234,0)
 ;;=294.8^^133^1312^19
 ;;^UTILITY(U,$J,358.3,21234,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21234,1,4,0)
 ;;=4^294.8
 ;;^UTILITY(U,$J,358.3,21234,1,5,0)
 ;;=5^Dementia, Other
 ;;^UTILITY(U,$J,358.3,21234,2)
 ;;=^268044
 ;;^UTILITY(U,$J,358.3,21235,0)
 ;;=438.6^^133^1312^4
 ;;^UTILITY(U,$J,358.3,21235,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21235,1,4,0)
 ;;=4^438.6
 ;;^UTILITY(U,$J,358.3,21235,1,5,0)
 ;;=5^CVA w/ Dysesthesia (Late Effect)
 ;;^UTILITY(U,$J,358.3,21235,2)
 ;;=CVA w/Dysesthesia (late effect)^328503
 ;;^UTILITY(U,$J,358.3,21236,0)
 ;;=438.7^^133^1312^7
 ;;^UTILITY(U,$J,358.3,21236,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21236,1,4,0)
 ;;=4^438.7
 ;;^UTILITY(U,$J,358.3,21236,1,5,0)
 ;;=5^CVA w/ Vision Changes (Late Effect)
 ;;^UTILITY(U,$J,358.3,21236,2)
 ;;=CVA w/Vision Changes (late effect)^328504
 ;;^UTILITY(U,$J,358.3,21237,0)
 ;;=438.84^^133^1312^3
 ;;^UTILITY(U,$J,358.3,21237,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21237,1,4,0)
 ;;=4^438.84
 ;;^UTILITY(U,$J,358.3,21237,1,5,0)
 ;;=5^CVA w/ Ataxia (Late Effect)
 ;;^UTILITY(U,$J,358.3,21237,2)
 ;;=CVA w/Ataxia (late effect)^328507
 ;;^UTILITY(U,$J,358.3,21238,0)
 ;;=434.91^^133^1312^8
 ;;^UTILITY(U,$J,358.3,21238,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21238,1,4,0)
 ;;=4^434.91
 ;;^UTILITY(U,$J,358.3,21238,1,5,0)
 ;;=5^CVA,Acute Onset
 ;;^UTILITY(U,$J,358.3,21238,2)
 ;;=^295738
 ;;^UTILITY(U,$J,358.3,21239,0)
 ;;=V12.54^^133^1312^22
 ;;^UTILITY(U,$J,358.3,21239,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21239,1,4,0)
 ;;=4^V12.54
 ;;^UTILITY(U,$J,358.3,21239,1,5,0)
 ;;=5^HX Stroke w/o Residuals
 ;;^UTILITY(U,$J,358.3,21239,2)
 ;;=^335309
 ;;^UTILITY(U,$J,358.3,21240,0)
 ;;=333.94^^133^1312^59
 ;;^UTILITY(U,$J,358.3,21240,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21240,1,4,0)
 ;;=4^333.94
 ;;^UTILITY(U,$J,358.3,21240,1,5,0)
 ;;=5^Restless Leg Syndrome
 ;;^UTILITY(U,$J,358.3,21240,2)
 ;;=^105368
