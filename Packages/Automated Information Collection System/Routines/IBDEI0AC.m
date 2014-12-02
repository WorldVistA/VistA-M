IBDEI0AC ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4813,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4813,1,2,0)
 ;;=2^V10.82
 ;;^UTILITY(U,$J,358.3,4813,1,5,0)
 ;;=5^Personal History of Malig Melanoma
 ;;^UTILITY(U,$J,358.3,4813,2)
 ;;=Personal History of Malig Melanoma^295240
 ;;^UTILITY(U,$J,358.3,4814,0)
 ;;=V15.82^^39^372^7
 ;;^UTILITY(U,$J,358.3,4814,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4814,1,2,0)
 ;;=2^V15.82
 ;;^UTILITY(U,$J,358.3,4814,1,5,0)
 ;;=5^History Of Tobacco Use
 ;;^UTILITY(U,$J,358.3,4814,2)
 ;;=^303405
 ;;^UTILITY(U,$J,358.3,4815,0)
 ;;=V13.3^^39^372^6
 ;;^UTILITY(U,$J,358.3,4815,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4815,1,2,0)
 ;;=2^V13.3
 ;;^UTILITY(U,$J,358.3,4815,1,5,0)
 ;;=5^History Of Other Skin Disorder
 ;;^UTILITY(U,$J,358.3,4815,2)
 ;;=^295266
 ;;^UTILITY(U,$J,358.3,4816,0)
 ;;=V10.83^^39^372^9
 ;;^UTILITY(U,$J,358.3,4816,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4816,1,2,0)
 ;;=2^V10.83
 ;;^UTILITY(U,$J,358.3,4816,1,5,0)
 ;;=5^Personal History of BCC/SCC
 ;;^UTILITY(U,$J,358.3,4816,2)
 ;;=Hx of Skin Cancer^295241
 ;;^UTILITY(U,$J,358.3,4817,0)
 ;;=V15.89^^39^372^2
 ;;^UTILITY(U,$J,358.3,4817,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4817,1,2,0)
 ;;=2^V15.89
 ;;^UTILITY(U,$J,358.3,4817,1,5,0)
 ;;=5^Exposure to Env Contaminants in Pers Gulf
 ;;^UTILITY(U,$J,358.3,4817,2)
 ;;=Exposure to Env Contaminante in Pers Gulf^295291
 ;;^UTILITY(U,$J,358.3,4818,0)
 ;;=V15.81^^39^372^8
 ;;^UTILITY(U,$J,358.3,4818,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4818,1,2,0)
 ;;=2^V15.81
 ;;^UTILITY(U,$J,358.3,4818,1,5,0)
 ;;=5^History of non-compliance
 ;;^UTILITY(U,$J,358.3,4818,2)
 ;;=^295290
 ;;^UTILITY(U,$J,358.3,4819,0)
 ;;=757.1^^39^373^2
 ;;^UTILITY(U,$J,358.3,4819,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4819,1,2,0)
 ;;=2^757.1
 ;;^UTILITY(U,$J,358.3,4819,1,5,0)
 ;;=5^Ichthyosis Congenital
 ;;^UTILITY(U,$J,358.3,4819,2)
 ;;=^61019
 ;;^UTILITY(U,$J,358.3,4820,0)
 ;;=911.4^^39^374^7
 ;;^UTILITY(U,$J,358.3,4820,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4820,1,2,0)
 ;;=2^911.4
 ;;^UTILITY(U,$J,358.3,4820,1,5,0)
 ;;=5^Insect Bite, Trunk, W/O Infection
 ;;^UTILITY(U,$J,358.3,4820,2)
 ;;=^275279
 ;;^UTILITY(U,$J,358.3,4821,0)
 ;;=913.4^^39^374^1
 ;;^UTILITY(U,$J,358.3,4821,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4821,1,2,0)
 ;;=2^913.4
 ;;^UTILITY(U,$J,358.3,4821,1,5,0)
 ;;=5^Insect Bite, Arm, W/O Infection
 ;;^UTILITY(U,$J,358.3,4821,2)
 ;;=^275301
 ;;^UTILITY(U,$J,358.3,4822,0)
 ;;=910.4^^39^374^2
 ;;^UTILITY(U,$J,358.3,4822,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4822,1,2,0)
 ;;=2^910.4
 ;;^UTILITY(U,$J,358.3,4822,1,5,0)
 ;;=5^Insect Bite, Face, W/O Infection
 ;;^UTILITY(U,$J,358.3,4822,2)
 ;;=^275267
 ;;^UTILITY(U,$J,358.3,4823,0)
 ;;=915.4^^39^374^3
 ;;^UTILITY(U,$J,358.3,4823,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4823,1,2,0)
 ;;=2^915.4
 ;;^UTILITY(U,$J,358.3,4823,1,5,0)
 ;;=5^Insect Bite, Finger, W/O Infection
 ;;^UTILITY(U,$J,358.3,4823,2)
 ;;=^275323
 ;;^UTILITY(U,$J,358.3,4824,0)
 ;;=917.4^^39^374^4
 ;;^UTILITY(U,$J,358.3,4824,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4824,1,2,0)
 ;;=2^917.4
 ;;^UTILITY(U,$J,358.3,4824,1,5,0)
 ;;=5^Insect Bite, Foot, W/O Infection 
 ;;^UTILITY(U,$J,358.3,4824,2)
 ;;=^275345
 ;;^UTILITY(U,$J,358.3,4825,0)
 ;;=914.4^^39^374^5
 ;;^UTILITY(U,$J,358.3,4825,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4825,1,2,0)
 ;;=2^914.4
 ;;^UTILITY(U,$J,358.3,4825,1,5,0)
 ;;=5^Insect Bite, Hand, W/O Infection
 ;;^UTILITY(U,$J,358.3,4825,2)
 ;;=^275312
 ;;^UTILITY(U,$J,358.3,4826,0)
 ;;=916.4^^39^374^6
 ;;^UTILITY(U,$J,358.3,4826,1,0)
 ;;=^358.31IA^5^2
