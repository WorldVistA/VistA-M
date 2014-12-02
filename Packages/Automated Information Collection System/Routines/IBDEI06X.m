IBDEI06X ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3062,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,3062,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,3063,0)
 ;;=428.33^^33^271^49
 ;;^UTILITY(U,$J,358.3,3063,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3063,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,3063,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,3063,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,3064,0)
 ;;=428.40^^33^271^48
 ;;^UTILITY(U,$J,358.3,3064,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3064,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,3064,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,3064,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,3065,0)
 ;;=428.41^^33^271^50
 ;;^UTILITY(U,$J,358.3,3065,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3065,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,3065,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,3065,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,3066,0)
 ;;=428.42^^33^271^54
 ;;^UTILITY(U,$J,358.3,3066,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3066,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,3066,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,3066,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,3067,0)
 ;;=428.43^^33^271^53
 ;;^UTILITY(U,$J,358.3,3067,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3067,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,3067,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,3067,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,3068,0)
 ;;=396.3^^33^271^12
 ;;^UTILITY(U,$J,358.3,3068,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3068,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,3068,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,3068,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,3069,0)
 ;;=429.9^^33^271^30
 ;;^UTILITY(U,$J,358.3,3069,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3069,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,3069,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,3069,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,3070,0)
 ;;=453.79^^33^271^29
 ;;^UTILITY(U,$J,358.3,3070,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3070,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,3070,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,3070,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,3071,0)
 ;;=453.89^^33^271^1
 ;;^UTILITY(U,$J,358.3,3071,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3071,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,3071,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,3071,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,3072,0)
 ;;=454.0^^33^271^84
 ;;^UTILITY(U,$J,358.3,3072,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3072,1,4,0)
 ;;=4^454.0
 ;;^UTILITY(U,$J,358.3,3072,1,5,0)
 ;;=5^Varicose Veins
 ;;^UTILITY(U,$J,358.3,3072,2)
 ;;=^125410
 ;;^UTILITY(U,$J,358.3,3073,0)
 ;;=454.2^^33^271^85
 ;;^UTILITY(U,$J,358.3,3073,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3073,1,4,0)
 ;;=4^454.2
 ;;^UTILITY(U,$J,358.3,3073,1,5,0)
 ;;=5^Varicose Veins w/Ulcer&Inflam
 ;;^UTILITY(U,$J,358.3,3073,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,3074,0)
 ;;=426.10^^33^271^3
 ;;^UTILITY(U,$J,358.3,3074,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3074,1,4,0)
 ;;=4^426.10
 ;;^UTILITY(U,$J,358.3,3074,1,5,0)
 ;;=5^AV CONDUCTION ABNORMAL
 ;;^UTILITY(U,$J,358.3,3074,2)
 ;;=^11396
 ;;^UTILITY(U,$J,358.3,3075,0)
 ;;=396.8^^33^271^2
 ;;^UTILITY(U,$J,358.3,3075,1,0)
 ;;=^358.31IA^5^2
