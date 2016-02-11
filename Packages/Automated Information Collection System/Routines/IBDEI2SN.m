IBDEI2SN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46901,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,46901,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,46902,0)
 ;;=G62.9^^206^2314^19
 ;;^UTILITY(U,$J,358.3,46902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46902,1,3,0)
 ;;=3^Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,46902,1,4,0)
 ;;=4^G62.9
 ;;^UTILITY(U,$J,358.3,46902,2)
 ;;=^5004079
 ;;^UTILITY(U,$J,358.3,46903,0)
 ;;=I63.9^^206^2314^13
 ;;^UTILITY(U,$J,358.3,46903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46903,1,3,0)
 ;;=3^Cerebral Infarction,Unspec
 ;;^UTILITY(U,$J,358.3,46903,1,4,0)
 ;;=4^I63.9
 ;;^UTILITY(U,$J,358.3,46903,2)
 ;;=^5007355
 ;;^UTILITY(U,$J,358.3,46904,0)
 ;;=I63.50^^206^2314^7
 ;;^UTILITY(U,$J,358.3,46904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46904,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenosis of Unspec Cerebral Artery
 ;;^UTILITY(U,$J,358.3,46904,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,46904,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,46905,0)
 ;;=I63.549^^206^2314^8
 ;;^UTILITY(U,$J,358.3,46905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46905,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenosis of Unspec Cerebellar Artery
 ;;^UTILITY(U,$J,358.3,46905,1,4,0)
 ;;=4^I63.549
 ;;^UTILITY(U,$J,358.3,46905,2)
 ;;=^5133571
 ;;^UTILITY(U,$J,358.3,46906,0)
 ;;=I63.8^^206^2314^2
 ;;^UTILITY(U,$J,358.3,46906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46906,1,3,0)
 ;;=3^Cerebral Infarction NEC
 ;;^UTILITY(U,$J,358.3,46906,1,4,0)
 ;;=4^I63.8
 ;;^UTILITY(U,$J,358.3,46906,2)
 ;;=^5007354
 ;;^UTILITY(U,$J,358.3,46907,0)
 ;;=I63.512^^206^2314^5
 ;;^UTILITY(U,$J,358.3,46907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46907,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Middle Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,46907,1,4,0)
 ;;=4^I63.512
 ;;^UTILITY(U,$J,358.3,46907,2)
 ;;=^5007345
 ;;^UTILITY(U,$J,358.3,46908,0)
 ;;=I63.522^^206^2314^3
 ;;^UTILITY(U,$J,358.3,46908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46908,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Anterior Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,46908,1,4,0)
 ;;=4^I63.522
 ;;^UTILITY(U,$J,358.3,46908,2)
 ;;=^5007347
 ;;^UTILITY(U,$J,358.3,46909,0)
 ;;=I63.532^^206^2314^6
 ;;^UTILITY(U,$J,358.3,46909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46909,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Posterior Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,46909,1,4,0)
 ;;=4^I63.532
 ;;^UTILITY(U,$J,358.3,46909,2)
 ;;=^5007349
 ;;^UTILITY(U,$J,358.3,46910,0)
 ;;=I63.542^^206^2314^4
 ;;^UTILITY(U,$J,358.3,46910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46910,1,3,0)
 ;;=3^Cerebral Infarction d/t Left Cerebellar Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,46910,1,4,0)
 ;;=4^I63.542
 ;;^UTILITY(U,$J,358.3,46910,2)
 ;;=^5007351
 ;;^UTILITY(U,$J,358.3,46911,0)
 ;;=I63.511^^206^2314^11
 ;;^UTILITY(U,$J,358.3,46911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46911,1,3,0)
 ;;=3^Cerebral Infarction d/t Right Middle Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,46911,1,4,0)
 ;;=4^I63.511
 ;;^UTILITY(U,$J,358.3,46911,2)
 ;;=^5007344
 ;;^UTILITY(U,$J,358.3,46912,0)
 ;;=I63.521^^206^2314^9
 ;;^UTILITY(U,$J,358.3,46912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46912,1,3,0)
 ;;=3^Cerebral Infarction d/t Right Anterior Cerebral Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,46912,1,4,0)
 ;;=4^I63.521
 ;;^UTILITY(U,$J,358.3,46912,2)
 ;;=^5007346
 ;;^UTILITY(U,$J,358.3,46913,0)
 ;;=I63.531^^206^2314^12
 ;;^UTILITY(U,$J,358.3,46913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46913,1,3,0)
 ;;=3^Cerebral Infarction d/t Right Posterior Cerebral Artery Occls/Stenosis
