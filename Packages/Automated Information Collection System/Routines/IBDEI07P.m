IBDEI07P ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3102,1,3,0)
 ;;=3^Dissociative Disorder NEC
 ;;^UTILITY(U,$J,358.3,3102,1,4,0)
 ;;=4^F44.89
 ;;^UTILITY(U,$J,358.3,3102,2)
 ;;=^5003583
 ;;^UTILITY(U,$J,358.3,3103,0)
 ;;=F50.02^^8^92^1
 ;;^UTILITY(U,$J,358.3,3103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3103,1,3,0)
 ;;=3^Anorexia Nervosa,Binge-Eating/Purging Type
 ;;^UTILITY(U,$J,358.3,3103,1,4,0)
 ;;=4^F50.02
 ;;^UTILITY(U,$J,358.3,3103,2)
 ;;=^5003599
 ;;^UTILITY(U,$J,358.3,3104,0)
 ;;=F50.01^^8^92^2
 ;;^UTILITY(U,$J,358.3,3104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3104,1,3,0)
 ;;=3^Anorexia Nervosa,Restricting Type
 ;;^UTILITY(U,$J,358.3,3104,1,4,0)
 ;;=4^F50.01
 ;;^UTILITY(U,$J,358.3,3104,2)
 ;;=^5003598
 ;;^UTILITY(U,$J,358.3,3105,0)
 ;;=F50.9^^8^92^7
 ;;^UTILITY(U,$J,358.3,3105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3105,1,3,0)
 ;;=3^Feeding/Eating Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3105,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,3105,2)
 ;;=^5003602
 ;;^UTILITY(U,$J,358.3,3106,0)
 ;;=F50.8^^8^92^6
 ;;^UTILITY(U,$J,358.3,3106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3106,1,3,0)
 ;;=3^Feeding/Eating Disorder NEC
 ;;^UTILITY(U,$J,358.3,3106,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,3106,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,3107,0)
 ;;=F50.8^^8^92^3
 ;;^UTILITY(U,$J,358.3,3107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3107,1,3,0)
 ;;=3^Avoidant/Restrictive Food Intake Disorder
 ;;^UTILITY(U,$J,358.3,3107,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,3107,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,3108,0)
 ;;=F50.8^^8^92^4
 ;;^UTILITY(U,$J,358.3,3108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3108,1,3,0)
 ;;=3^Binge-Eating Disorder
 ;;^UTILITY(U,$J,358.3,3108,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,3108,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,3109,0)
 ;;=F50.2^^8^92^5
 ;;^UTILITY(U,$J,358.3,3109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3109,1,3,0)
 ;;=3^Bulimia Nervosa
 ;;^UTILITY(U,$J,358.3,3109,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,3109,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,3110,0)
 ;;=Z55.9^^8^93^1
 ;;^UTILITY(U,$J,358.3,3110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3110,1,3,0)
 ;;=3^Acedemic/Educational Problem
 ;;^UTILITY(U,$J,358.3,3110,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,3110,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,3111,0)
 ;;=Z56.81^^8^93^4
 ;;^UTILITY(U,$J,358.3,3111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3111,1,3,0)
 ;;=3^Sexual Harassment on the Job
 ;;^UTILITY(U,$J,358.3,3111,1,4,0)
 ;;=4^Z56.81
 ;;^UTILITY(U,$J,358.3,3111,2)
 ;;=^5063114
 ;;^UTILITY(U,$J,358.3,3112,0)
 ;;=Z56.9^^8^93^3
 ;;^UTILITY(U,$J,358.3,3112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3112,1,3,0)
 ;;=3^Problems Related to Employment NEC
 ;;^UTILITY(U,$J,358.3,3112,1,4,0)
 ;;=4^Z56.9
 ;;^UTILITY(U,$J,358.3,3112,2)
 ;;=^5063117
 ;;^UTILITY(U,$J,358.3,3113,0)
 ;;=Z56.82^^8^93^2
 ;;^UTILITY(U,$J,358.3,3113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3113,1,3,0)
 ;;=3^Problems Related to Current Military Deployment Status
 ;;^UTILITY(U,$J,358.3,3113,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,3113,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,3114,0)
 ;;=F64.1^^8^94^2
 ;;^UTILITY(U,$J,358.3,3114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3114,1,3,0)
 ;;=3^Gender Dysphoria in Adolescents & Adults
 ;;^UTILITY(U,$J,358.3,3114,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,3114,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,3115,0)
 ;;=F64.8^^8^94^1
 ;;^UTILITY(U,$J,358.3,3115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3115,1,3,0)
 ;;=3^Gender Dysphoria NEC
 ;;^UTILITY(U,$J,358.3,3115,1,4,0)
 ;;=4^F64.8
 ;;^UTILITY(U,$J,358.3,3115,2)
 ;;=^5003649
