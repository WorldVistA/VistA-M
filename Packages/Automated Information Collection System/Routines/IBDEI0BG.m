IBDEI0BG ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5031,2)
 ;;=^266557
 ;;^UTILITY(U,$J,358.3,5032,0)
 ;;=V16.8^^25^270^5
 ;;^UTILITY(U,$J,358.3,5032,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5032,1,2,0)
 ;;=2^V16.8
 ;;^UTILITY(U,$J,358.3,5032,1,5,0)
 ;;=5^Family History of SCC/BCC
 ;;^UTILITY(U,$J,358.3,5032,2)
 ;;=Family Hx of Skin Cancer^295300
 ;;^UTILITY(U,$J,358.3,5033,0)
 ;;=V10.82^^25^270^10
 ;;^UTILITY(U,$J,358.3,5033,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5033,1,2,0)
 ;;=2^V10.82
 ;;^UTILITY(U,$J,358.3,5033,1,5,0)
 ;;=5^Personal History of Malig Melanoma
 ;;^UTILITY(U,$J,358.3,5033,2)
 ;;=Personal History of Malig Melanoma^295240
 ;;^UTILITY(U,$J,358.3,5034,0)
 ;;=V15.82^^25^270^7
 ;;^UTILITY(U,$J,358.3,5034,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5034,1,2,0)
 ;;=2^V15.82
 ;;^UTILITY(U,$J,358.3,5034,1,5,0)
 ;;=5^History Of Tobacco Use
 ;;^UTILITY(U,$J,358.3,5034,2)
 ;;=^303405
 ;;^UTILITY(U,$J,358.3,5035,0)
 ;;=V13.3^^25^270^6
 ;;^UTILITY(U,$J,358.3,5035,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5035,1,2,0)
 ;;=2^V13.3
 ;;^UTILITY(U,$J,358.3,5035,1,5,0)
 ;;=5^History Of Other Skin Disorder
 ;;^UTILITY(U,$J,358.3,5035,2)
 ;;=^295266
 ;;^UTILITY(U,$J,358.3,5036,0)
 ;;=V10.83^^25^270^9
 ;;^UTILITY(U,$J,358.3,5036,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5036,1,2,0)
 ;;=2^V10.83
 ;;^UTILITY(U,$J,358.3,5036,1,5,0)
 ;;=5^Personal History of BCC/SCC
 ;;^UTILITY(U,$J,358.3,5036,2)
 ;;=Hx of Skin Cancer^295241
 ;;^UTILITY(U,$J,358.3,5037,0)
 ;;=V15.89^^25^270^2
 ;;^UTILITY(U,$J,358.3,5037,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5037,1,2,0)
 ;;=2^V15.89
 ;;^UTILITY(U,$J,358.3,5037,1,5,0)
 ;;=5^Exposure to Env Contaminants in Pers Gulf
 ;;^UTILITY(U,$J,358.3,5037,2)
 ;;=Exposure to Env Contaminante in Pers Gulf^295291
 ;;^UTILITY(U,$J,358.3,5038,0)
 ;;=V15.81^^25^270^8
 ;;^UTILITY(U,$J,358.3,5038,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5038,1,2,0)
 ;;=2^V15.81
 ;;^UTILITY(U,$J,358.3,5038,1,5,0)
 ;;=5^History of non-compliance
 ;;^UTILITY(U,$J,358.3,5038,2)
 ;;=^295290
 ;;^UTILITY(U,$J,358.3,5039,0)
 ;;=757.1^^25^271^2
 ;;^UTILITY(U,$J,358.3,5039,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5039,1,2,0)
 ;;=2^757.1
 ;;^UTILITY(U,$J,358.3,5039,1,5,0)
 ;;=5^Ichthyosis Congenital
 ;;^UTILITY(U,$J,358.3,5039,2)
 ;;=^61019
 ;;^UTILITY(U,$J,358.3,5040,0)
 ;;=911.4^^25^272^7
 ;;^UTILITY(U,$J,358.3,5040,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5040,1,2,0)
 ;;=2^911.4
 ;;^UTILITY(U,$J,358.3,5040,1,5,0)
 ;;=5^Insect Bite, Trunk, W/O Infection
 ;;^UTILITY(U,$J,358.3,5040,2)
 ;;=^275279
 ;;^UTILITY(U,$J,358.3,5041,0)
 ;;=913.4^^25^272^1
 ;;^UTILITY(U,$J,358.3,5041,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5041,1,2,0)
 ;;=2^913.4
 ;;^UTILITY(U,$J,358.3,5041,1,5,0)
 ;;=5^Insect Bite, Arm, W/O Infection
 ;;^UTILITY(U,$J,358.3,5041,2)
 ;;=^275301
 ;;^UTILITY(U,$J,358.3,5042,0)
 ;;=910.4^^25^272^2
 ;;^UTILITY(U,$J,358.3,5042,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5042,1,2,0)
 ;;=2^910.4
 ;;^UTILITY(U,$J,358.3,5042,1,5,0)
 ;;=5^Insect Bite, Face, W/O Infection
 ;;^UTILITY(U,$J,358.3,5042,2)
 ;;=^275267
 ;;^UTILITY(U,$J,358.3,5043,0)
 ;;=915.4^^25^272^3
 ;;^UTILITY(U,$J,358.3,5043,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5043,1,2,0)
 ;;=2^915.4
 ;;^UTILITY(U,$J,358.3,5043,1,5,0)
 ;;=5^Insect Bite, Finger, W/O Infection
 ;;^UTILITY(U,$J,358.3,5043,2)
 ;;=^275323
 ;;^UTILITY(U,$J,358.3,5044,0)
 ;;=917.4^^25^272^4
 ;;^UTILITY(U,$J,358.3,5044,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5044,1,2,0)
 ;;=2^917.4
 ;;^UTILITY(U,$J,358.3,5044,1,5,0)
 ;;=5^Insect Bite, Foot, W/O Infection 
 ;;^UTILITY(U,$J,358.3,5044,2)
 ;;=^275345
