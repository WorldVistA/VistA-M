IBDEI24G ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35984,1,3,0)
 ;;=3^Hereditary/Idiopathic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,35984,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,35984,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,35985,0)
 ;;=G62.9^^134^1739^19
 ;;^UTILITY(U,$J,358.3,35985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35985,1,3,0)
 ;;=3^Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,35985,1,4,0)
 ;;=4^G62.9
 ;;^UTILITY(U,$J,358.3,35985,2)
 ;;=^5004079
 ;;^UTILITY(U,$J,358.3,35986,0)
 ;;=I63.9^^134^1739^13
 ;;^UTILITY(U,$J,358.3,35986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35986,1,3,0)
 ;;=3^Cerebral Infarction,Unspec
 ;;^UTILITY(U,$J,358.3,35986,1,4,0)
 ;;=4^I63.9
 ;;^UTILITY(U,$J,358.3,35986,2)
 ;;=^5007355
 ;;^UTILITY(U,$J,358.3,35987,0)
 ;;=I63.50^^134^1739^7
 ;;^UTILITY(U,$J,358.3,35987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35987,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenosis of Unspec Cerebral Artery
 ;;^UTILITY(U,$J,358.3,35987,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,35987,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,35988,0)
 ;;=I63.549^^134^1739^8
 ;;^UTILITY(U,$J,358.3,35988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35988,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenosis of Unspec Cerebellar Artery
 ;;^UTILITY(U,$J,358.3,35988,1,4,0)
 ;;=4^I63.549
 ;;^UTILITY(U,$J,358.3,35988,2)
 ;;=^5133571
 ;;^UTILITY(U,$J,358.3,35989,0)
 ;;=I63.8^^134^1739^2
 ;;^UTILITY(U,$J,358.3,35989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35989,1,3,0)
 ;;=3^Cerebral Infarction NEC
 ;;^UTILITY(U,$J,358.3,35989,1,4,0)
 ;;=4^I63.8
 ;;^UTILITY(U,$J,358.3,35989,2)
 ;;=^5007354
 ;;^UTILITY(U,$J,358.3,35990,0)
 ;;=I63.512^^134^1739^5
 ;;^UTILITY(U,$J,358.3,35990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35990,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Middle Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,35990,1,4,0)
 ;;=4^I63.512
 ;;^UTILITY(U,$J,358.3,35990,2)
 ;;=^5007345
 ;;^UTILITY(U,$J,358.3,35991,0)
 ;;=I63.522^^134^1739^3
 ;;^UTILITY(U,$J,358.3,35991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35991,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Anterior Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,35991,1,4,0)
 ;;=4^I63.522
 ;;^UTILITY(U,$J,358.3,35991,2)
 ;;=^5007347
 ;;^UTILITY(U,$J,358.3,35992,0)
 ;;=I63.532^^134^1739^6
 ;;^UTILITY(U,$J,358.3,35992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35992,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Posterior Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,35992,1,4,0)
 ;;=4^I63.532
 ;;^UTILITY(U,$J,358.3,35992,2)
 ;;=^5007349
 ;;^UTILITY(U,$J,358.3,35993,0)
 ;;=I63.542^^134^1739^4
 ;;^UTILITY(U,$J,358.3,35993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35993,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Cerebellar Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,35993,1,4,0)
 ;;=4^I63.542
 ;;^UTILITY(U,$J,358.3,35993,2)
 ;;=^5007351
 ;;^UTILITY(U,$J,358.3,35994,0)
 ;;=I63.511^^134^1739^11
 ;;^UTILITY(U,$J,358.3,35994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35994,1,3,0)
 ;;=3^Cerebral Infarction d/t Right Middle Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,35994,1,4,0)
 ;;=4^I63.511
 ;;^UTILITY(U,$J,358.3,35994,2)
 ;;=^5007344
 ;;^UTILITY(U,$J,358.3,35995,0)
 ;;=I63.521^^134^1739^9
 ;;^UTILITY(U,$J,358.3,35995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35995,1,3,0)
 ;;=3^Cerebral Infarction d/t Right Anterior Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,35995,1,4,0)
 ;;=4^I63.521
 ;;^UTILITY(U,$J,358.3,35995,2)
 ;;=^5007346
 ;;^UTILITY(U,$J,358.3,35996,0)
 ;;=I63.531^^134^1739^12
