IBDEI13H ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19625,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19625,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,19625,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,19625,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,19626,0)
 ;;=428.31^^131^1276^41
 ;;^UTILITY(U,$J,358.3,19626,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19626,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,19626,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,19626,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,19627,0)
 ;;=428.32^^131^1276^43
 ;;^UTILITY(U,$J,358.3,19627,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19627,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,19627,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,19627,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,19628,0)
 ;;=428.33^^131^1276^47
 ;;^UTILITY(U,$J,358.3,19628,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19628,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,19628,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,19628,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,19629,0)
 ;;=428.40^^131^1276^46
 ;;^UTILITY(U,$J,358.3,19629,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19629,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,19629,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,19629,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,19630,0)
 ;;=428.41^^131^1276^48
 ;;^UTILITY(U,$J,358.3,19630,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19630,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,19630,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,19630,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,19631,0)
 ;;=428.42^^131^1276^52
 ;;^UTILITY(U,$J,358.3,19631,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19631,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,19631,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,19631,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,19632,0)
 ;;=428.43^^131^1276^51
 ;;^UTILITY(U,$J,358.3,19632,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19632,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,19632,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,19632,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,19633,0)
 ;;=396.3^^131^1276^10
 ;;^UTILITY(U,$J,358.3,19633,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19633,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,19633,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,19633,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,19634,0)
 ;;=429.9^^131^1276^28
 ;;^UTILITY(U,$J,358.3,19634,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19634,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,19634,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,19634,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,19635,0)
 ;;=453.79^^131^1276^27
 ;;^UTILITY(U,$J,358.3,19635,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19635,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,19635,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,19635,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,19636,0)
 ;;=453.89^^131^1276^1
 ;;^UTILITY(U,$J,358.3,19636,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19636,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,19636,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,19636,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,19637,0)
 ;;=454.2^^131^1276^85
 ;;^UTILITY(U,$J,358.3,19637,1,0)
 ;;=^358.31IA^5^2
