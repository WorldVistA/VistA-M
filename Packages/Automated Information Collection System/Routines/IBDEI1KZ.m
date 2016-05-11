IBDEI1KZ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26813,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,26813,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,26813,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,26814,0)
 ;;=G47.34^^100^1290^26
 ;;^UTILITY(U,$J,358.3,26814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26814,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic Hypoventilation
 ;;^UTILITY(U,$J,358.3,26814,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,26814,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,26815,0)
 ;;=G47.9^^100^1290^28
 ;;^UTILITY(U,$J,358.3,26815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26815,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26815,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,26815,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,26816,0)
 ;;=F10.10^^100^1291^27
 ;;^UTILITY(U,$J,358.3,26816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26816,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26816,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,26816,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,26817,0)
 ;;=F10.14^^100^1291^34
 ;;^UTILITY(U,$J,358.3,26817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26817,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26817,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,26817,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,26818,0)
 ;;=F10.182^^100^1291^36
 ;;^UTILITY(U,$J,358.3,26818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26818,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26818,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,26818,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,26819,0)
 ;;=F10.20^^100^1291^28
 ;;^UTILITY(U,$J,358.3,26819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26819,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,26819,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,26819,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,26820,0)
 ;;=F10.21^^100^1291^29
 ;;^UTILITY(U,$J,358.3,26820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26820,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,26820,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,26820,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,26821,0)
 ;;=F10.230^^100^1291^30
 ;;^UTILITY(U,$J,358.3,26821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26821,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,26821,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,26821,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,26822,0)
 ;;=F10.231^^100^1291^31
 ;;^UTILITY(U,$J,358.3,26822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26822,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,26822,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,26822,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,26823,0)
 ;;=F10.232^^100^1291^32
 ;;^UTILITY(U,$J,358.3,26823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26823,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,26823,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,26823,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,26824,0)
 ;;=F10.239^^100^1291^33
 ;;^UTILITY(U,$J,358.3,26824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26824,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,26824,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,26824,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,26825,0)
 ;;=F10.24^^100^1291^35
 ;;^UTILITY(U,$J,358.3,26825,1,0)
 ;;=^358.31IA^4^2
