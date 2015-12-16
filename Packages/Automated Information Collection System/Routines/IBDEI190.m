IBDEI190 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22121,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,22121,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,22122,0)
 ;;=428.32^^125^1387^43
 ;;^UTILITY(U,$J,358.3,22122,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22122,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,22122,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,22122,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,22123,0)
 ;;=428.33^^125^1387^47
 ;;^UTILITY(U,$J,358.3,22123,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22123,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,22123,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,22123,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,22124,0)
 ;;=428.40^^125^1387^46
 ;;^UTILITY(U,$J,358.3,22124,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22124,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,22124,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,22124,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,22125,0)
 ;;=428.41^^125^1387^48
 ;;^UTILITY(U,$J,358.3,22125,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22125,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,22125,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,22125,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,22126,0)
 ;;=428.42^^125^1387^52
 ;;^UTILITY(U,$J,358.3,22126,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22126,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,22126,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,22126,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,22127,0)
 ;;=428.43^^125^1387^51
 ;;^UTILITY(U,$J,358.3,22127,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22127,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,22127,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,22127,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,22128,0)
 ;;=396.3^^125^1387^10
 ;;^UTILITY(U,$J,358.3,22128,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22128,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,22128,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,22128,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,22129,0)
 ;;=429.9^^125^1387^28
 ;;^UTILITY(U,$J,358.3,22129,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22129,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,22129,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,22129,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,22130,0)
 ;;=453.79^^125^1387^27
 ;;^UTILITY(U,$J,358.3,22130,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22130,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,22130,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,22130,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,22131,0)
 ;;=453.89^^125^1387^1
 ;;^UTILITY(U,$J,358.3,22131,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22131,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,22131,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,22131,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,22132,0)
 ;;=454.2^^125^1387^85
 ;;^UTILITY(U,$J,358.3,22132,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22132,1,4,0)
 ;;=4^454.2
 ;;^UTILITY(U,$J,358.3,22132,1,5,0)
 ;;=5^Varicose Veins w/Ulcer&Inflam
 ;;^UTILITY(U,$J,358.3,22132,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,22133,0)
 ;;=397.1^^125^1387^74
 ;;^UTILITY(U,$J,358.3,22133,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22133,1,4,0)
 ;;=4^397.1
 ;;^UTILITY(U,$J,358.3,22133,1,5,0)
 ;;=5^Rheumatic Disease Pulmonary Valve
