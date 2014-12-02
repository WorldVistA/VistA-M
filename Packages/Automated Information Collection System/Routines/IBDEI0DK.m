IBDEI0DK ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6524,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,6525,0)
 ;;=428.33^^55^567^47
 ;;^UTILITY(U,$J,358.3,6525,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6525,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,6525,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6525,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,6526,0)
 ;;=428.40^^55^567^46
 ;;^UTILITY(U,$J,358.3,6526,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6526,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,6526,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,6526,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,6527,0)
 ;;=428.41^^55^567^48
 ;;^UTILITY(U,$J,358.3,6527,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6527,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,6527,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,6527,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,6528,0)
 ;;=428.42^^55^567^52
 ;;^UTILITY(U,$J,358.3,6528,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6528,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,6528,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,6528,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,6529,0)
 ;;=428.43^^55^567^51
 ;;^UTILITY(U,$J,358.3,6529,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6529,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,6529,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,6529,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,6530,0)
 ;;=396.3^^55^567^10
 ;;^UTILITY(U,$J,358.3,6530,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6530,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,6530,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,6530,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,6531,0)
 ;;=429.9^^55^567^28
 ;;^UTILITY(U,$J,358.3,6531,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6531,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,6531,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,6531,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,6532,0)
 ;;=453.79^^55^567^27
 ;;^UTILITY(U,$J,358.3,6532,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6532,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,6532,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,6532,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,6533,0)
 ;;=453.89^^55^567^1
 ;;^UTILITY(U,$J,358.3,6533,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6533,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,6533,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,6533,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,6534,0)
 ;;=454.2^^55^567^85
 ;;^UTILITY(U,$J,358.3,6534,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6534,1,4,0)
 ;;=4^454.2
 ;;^UTILITY(U,$J,358.3,6534,1,5,0)
 ;;=5^Varicose Veins w/Ulcer&Inflam
 ;;^UTILITY(U,$J,358.3,6534,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,6535,0)
 ;;=397.1^^55^567^74
 ;;^UTILITY(U,$J,358.3,6535,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6535,1,4,0)
 ;;=4^397.1
 ;;^UTILITY(U,$J,358.3,6535,1,5,0)
 ;;=5^Rheumatic Disease Pulmonary Valve
 ;;^UTILITY(U,$J,358.3,6535,2)
 ;;=^269587
 ;;^UTILITY(U,$J,358.3,6536,0)
 ;;=397.0^^55^567^75
 ;;^UTILITY(U,$J,358.3,6536,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6536,1,4,0)
 ;;=4^397.0
 ;;^UTILITY(U,$J,358.3,6536,1,5,0)
 ;;=5^Rheumatic Disease Tricuspid Valve
 ;;^UTILITY(U,$J,358.3,6536,2)
 ;;=^35528
 ;;^UTILITY(U,$J,358.3,6537,0)
 ;;=414.3^^55^567^17
 ;;^UTILITY(U,$J,358.3,6537,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6537,1,4,0)
 ;;=4^414.3
