IBDEI26C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36882,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,36882,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,36882,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,36883,0)
 ;;=F06.8^^137^1777^17
 ;;^UTILITY(U,$J,358.3,36883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36883,1,3,0)
 ;;=3^Mental Disorders d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,36883,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,36883,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,36884,0)
 ;;=F06.1^^137^1777^1
 ;;^UTILITY(U,$J,358.3,36884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36884,1,3,0)
 ;;=3^Catatonic Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,36884,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,36884,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,36885,0)
 ;;=G35.^^137^1777^18
 ;;^UTILITY(U,$J,358.3,36885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36885,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,36885,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,36885,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,36886,0)
 ;;=G60.9^^137^1777^15
 ;;^UTILITY(U,$J,358.3,36886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36886,1,3,0)
 ;;=3^Hereditary/Idiopathic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,36886,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,36886,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,36887,0)
 ;;=G62.9^^137^1777^19
 ;;^UTILITY(U,$J,358.3,36887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36887,1,3,0)
 ;;=3^Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,36887,1,4,0)
 ;;=4^G62.9
 ;;^UTILITY(U,$J,358.3,36887,2)
 ;;=^5004079
 ;;^UTILITY(U,$J,358.3,36888,0)
 ;;=I63.9^^137^1777^13
 ;;^UTILITY(U,$J,358.3,36888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36888,1,3,0)
 ;;=3^Cerebral Infarction,Unspec
 ;;^UTILITY(U,$J,358.3,36888,1,4,0)
 ;;=4^I63.9
 ;;^UTILITY(U,$J,358.3,36888,2)
 ;;=^5007355
 ;;^UTILITY(U,$J,358.3,36889,0)
 ;;=I63.50^^137^1777^7
 ;;^UTILITY(U,$J,358.3,36889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36889,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenosis of Unspec Cerebral Artery
 ;;^UTILITY(U,$J,358.3,36889,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,36889,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,36890,0)
 ;;=I63.549^^137^1777^8
 ;;^UTILITY(U,$J,358.3,36890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36890,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenosis of Unspec Cerebellar Artery
 ;;^UTILITY(U,$J,358.3,36890,1,4,0)
 ;;=4^I63.549
 ;;^UTILITY(U,$J,358.3,36890,2)
 ;;=^5133571
 ;;^UTILITY(U,$J,358.3,36891,0)
 ;;=I63.8^^137^1777^2
 ;;^UTILITY(U,$J,358.3,36891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36891,1,3,0)
 ;;=3^Cerebral Infarction NEC
 ;;^UTILITY(U,$J,358.3,36891,1,4,0)
 ;;=4^I63.8
 ;;^UTILITY(U,$J,358.3,36891,2)
 ;;=^5007354
 ;;^UTILITY(U,$J,358.3,36892,0)
 ;;=I63.512^^137^1777^5
 ;;^UTILITY(U,$J,358.3,36892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36892,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Middle Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,36892,1,4,0)
 ;;=4^I63.512
 ;;^UTILITY(U,$J,358.3,36892,2)
 ;;=^5007345
 ;;^UTILITY(U,$J,358.3,36893,0)
 ;;=I63.522^^137^1777^3
 ;;^UTILITY(U,$J,358.3,36893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36893,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Anterior Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,36893,1,4,0)
 ;;=4^I63.522
 ;;^UTILITY(U,$J,358.3,36893,2)
 ;;=^5007347
 ;;^UTILITY(U,$J,358.3,36894,0)
 ;;=I63.532^^137^1777^6
 ;;^UTILITY(U,$J,358.3,36894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36894,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Posterior Cerebral Artery Occls/Stenosis
