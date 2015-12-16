IBDEI12G ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18818,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,18818,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,18819,0)
 ;;=428.31^^105^1222^41
 ;;^UTILITY(U,$J,358.3,18819,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18819,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,18819,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,18819,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,18820,0)
 ;;=428.32^^105^1222^43
 ;;^UTILITY(U,$J,358.3,18820,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18820,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,18820,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,18820,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,18821,0)
 ;;=428.33^^105^1222^47
 ;;^UTILITY(U,$J,358.3,18821,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18821,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,18821,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,18821,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,18822,0)
 ;;=428.40^^105^1222^46
 ;;^UTILITY(U,$J,358.3,18822,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18822,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,18822,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,18822,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,18823,0)
 ;;=428.41^^105^1222^48
 ;;^UTILITY(U,$J,358.3,18823,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18823,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,18823,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,18823,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,18824,0)
 ;;=428.42^^105^1222^52
 ;;^UTILITY(U,$J,358.3,18824,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18824,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,18824,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,18824,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,18825,0)
 ;;=428.43^^105^1222^51
 ;;^UTILITY(U,$J,358.3,18825,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18825,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,18825,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,18825,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,18826,0)
 ;;=396.3^^105^1222^10
 ;;^UTILITY(U,$J,358.3,18826,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18826,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,18826,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,18826,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,18827,0)
 ;;=429.9^^105^1222^28
 ;;^UTILITY(U,$J,358.3,18827,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18827,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,18827,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,18827,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,18828,0)
 ;;=453.79^^105^1222^27
 ;;^UTILITY(U,$J,358.3,18828,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18828,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,18828,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,18828,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,18829,0)
 ;;=453.89^^105^1222^1
 ;;^UTILITY(U,$J,358.3,18829,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18829,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,18829,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,18829,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,18830,0)
 ;;=454.2^^105^1222^85
 ;;^UTILITY(U,$J,358.3,18830,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18830,1,4,0)
 ;;=4^454.2
 ;;^UTILITY(U,$J,358.3,18830,1,5,0)
 ;;=5^Varicose Veins w/Ulcer&Inflam
