IBDEI30N ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50562,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,50562,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,50562,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,50563,0)
 ;;=F06.8^^219^2456^17
 ;;^UTILITY(U,$J,358.3,50563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50563,1,3,0)
 ;;=3^Mental Disorders d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,50563,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,50563,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,50564,0)
 ;;=F06.1^^219^2456^1
 ;;^UTILITY(U,$J,358.3,50564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50564,1,3,0)
 ;;=3^Catatonic Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,50564,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,50564,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,50565,0)
 ;;=G35.^^219^2456^18
 ;;^UTILITY(U,$J,358.3,50565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50565,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,50565,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,50565,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,50566,0)
 ;;=G60.9^^219^2456^15
 ;;^UTILITY(U,$J,358.3,50566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50566,1,3,0)
 ;;=3^Hereditary/Idiopathic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,50566,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,50566,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,50567,0)
 ;;=G62.9^^219^2456^19
 ;;^UTILITY(U,$J,358.3,50567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50567,1,3,0)
 ;;=3^Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,50567,1,4,0)
 ;;=4^G62.9
 ;;^UTILITY(U,$J,358.3,50567,2)
 ;;=^5004079
 ;;^UTILITY(U,$J,358.3,50568,0)
 ;;=I63.9^^219^2456^13
 ;;^UTILITY(U,$J,358.3,50568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50568,1,3,0)
 ;;=3^Cerebral Infarction,Unspec
 ;;^UTILITY(U,$J,358.3,50568,1,4,0)
 ;;=4^I63.9
 ;;^UTILITY(U,$J,358.3,50568,2)
 ;;=^5007355
 ;;^UTILITY(U,$J,358.3,50569,0)
 ;;=I63.50^^219^2456^7
 ;;^UTILITY(U,$J,358.3,50569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50569,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenosis of Unspec Cerebral Artery
 ;;^UTILITY(U,$J,358.3,50569,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,50569,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,50570,0)
 ;;=I63.549^^219^2456^8
 ;;^UTILITY(U,$J,358.3,50570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50570,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenosis of Unspec Cerebellar Artery
 ;;^UTILITY(U,$J,358.3,50570,1,4,0)
 ;;=4^I63.549
 ;;^UTILITY(U,$J,358.3,50570,2)
 ;;=^5133571
 ;;^UTILITY(U,$J,358.3,50571,0)
 ;;=I63.8^^219^2456^2
 ;;^UTILITY(U,$J,358.3,50571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50571,1,3,0)
 ;;=3^Cerebral Infarction NEC
 ;;^UTILITY(U,$J,358.3,50571,1,4,0)
 ;;=4^I63.8
 ;;^UTILITY(U,$J,358.3,50571,2)
 ;;=^5007354
 ;;^UTILITY(U,$J,358.3,50572,0)
 ;;=I63.512^^219^2456^5
 ;;^UTILITY(U,$J,358.3,50572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50572,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Middle Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,50572,1,4,0)
 ;;=4^I63.512
 ;;^UTILITY(U,$J,358.3,50572,2)
 ;;=^5007345
 ;;^UTILITY(U,$J,358.3,50573,0)
 ;;=I63.522^^219^2456^3
 ;;^UTILITY(U,$J,358.3,50573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50573,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Anterior Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,50573,1,4,0)
 ;;=4^I63.522
 ;;^UTILITY(U,$J,358.3,50573,2)
 ;;=^5007347
 ;;^UTILITY(U,$J,358.3,50574,0)
 ;;=I63.532^^219^2456^6
 ;;^UTILITY(U,$J,358.3,50574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50574,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Posterior Cerebral Artery Occls/Stenosis
