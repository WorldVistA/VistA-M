IBDEI168 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20971,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20971,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,20971,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Chronic
 ;;^UTILITY(U,$J,358.3,20971,2)
 ;;= Heart Failure, Systolic & Diastolic, Chronic^328501
 ;;^UTILITY(U,$J,358.3,20972,0)
 ;;=428.43^^133^1307^47
 ;;^UTILITY(U,$J,358.3,20972,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20972,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,20972,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute On Chronic
 ;;^UTILITY(U,$J,358.3,20972,2)
 ;;= Heart Failure, Systolic & Diastolic, Acute on Chronic^328502
 ;;^UTILITY(U,$J,358.3,20973,0)
 ;;=396.3^^133^1307^6
 ;;^UTILITY(U,$J,358.3,20973,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20973,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,20973,1,5,0)
 ;;=5^Aortic And Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,20973,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,20974,0)
 ;;=414.3^^133^1307^15
 ;;^UTILITY(U,$J,358.3,20974,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20974,1,4,0)
 ;;=4^414.3
 ;;^UTILITY(U,$J,358.3,20974,1,5,0)
 ;;=5^CAD d/t Lipid Rich Plaque
 ;;^UTILITY(U,$J,358.3,20974,2)
 ;;=^336601
 ;;^UTILITY(U,$J,358.3,20975,0)
 ;;=453.9^^133^1307^82
 ;;^UTILITY(U,$J,358.3,20975,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20975,1,4,0)
 ;;=4^453.9
 ;;^UTILITY(U,$J,358.3,20975,1,5,0)
 ;;=5^Venous Thrombosis NOS
 ;;^UTILITY(U,$J,358.3,20975,2)
 ;;=^39455
 ;;^UTILITY(U,$J,358.3,20976,0)
 ;;=453.89^^133^1307^79
 ;;^UTILITY(U,$J,358.3,20976,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20976,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,20976,1,5,0)
 ;;=5^Venous Embolism,Acute NEC
 ;;^UTILITY(U,$J,358.3,20976,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,20977,0)
 ;;=453.79^^133^1307^80
 ;;^UTILITY(U,$J,358.3,20977,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20977,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,20977,1,5,0)
 ;;=5^Venous Embolism,Chr NEC
 ;;^UTILITY(U,$J,358.3,20977,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,20978,0)
 ;;=425.11^^133^1307^57
 ;;^UTILITY(U,$J,358.3,20978,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20978,1,4,0)
 ;;=4^425.11
 ;;^UTILITY(U,$J,358.3,20978,1,5,0)
 ;;=5^Hypertrophic Subaortic Stenosis
 ;;^UTILITY(U,$J,358.3,20978,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,20979,0)
 ;;=425.18^^133^1307^22
 ;;^UTILITY(U,$J,358.3,20979,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20979,1,4,0)
 ;;=4^425.18
 ;;^UTILITY(U,$J,358.3,20979,1,5,0)
 ;;=5^Cardiomyopathy,Hypertrophic
 ;;^UTILITY(U,$J,358.3,20979,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,20980,0)
 ;;=V12.55^^133^1307^52
 ;;^UTILITY(U,$J,358.3,20980,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20980,1,4,0)
 ;;=4^V12.55
 ;;^UTILITY(U,$J,358.3,20980,1,5,0)
 ;;=5^Hx of Pulmonary Embolism
 ;;^UTILITY(U,$J,358.3,20980,2)
 ;;=^340615
 ;;^UTILITY(U,$J,358.3,20981,0)
 ;;=414.4^^133^1307^14
 ;;^UTILITY(U,$J,358.3,20981,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20981,1,4,0)
 ;;=4^414.4
 ;;^UTILITY(U,$J,358.3,20981,1,5,0)
 ;;=5^CAD d/t Calc Coronary Lesion
 ;;^UTILITY(U,$J,358.3,20981,2)
 ;;=^340518
 ;;^UTILITY(U,$J,358.3,20982,0)
 ;;=271.3^^133^1308^11
 ;;^UTILITY(U,$J,358.3,20982,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20982,1,4,0)
 ;;=4^271.3
 ;;^UTILITY(U,$J,358.3,20982,1,5,0)
 ;;=5^Glucose Intolerance
 ;;^UTILITY(U,$J,358.3,20982,2)
 ;;=^64790
 ;;^UTILITY(U,$J,358.3,20983,0)
 ;;=611.1^^133^1308^16
 ;;^UTILITY(U,$J,358.3,20983,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20983,1,4,0)
 ;;=4^611.1
 ;;^UTILITY(U,$J,358.3,20983,1,5,0)
 ;;=5^Gynecomastia
 ;;^UTILITY(U,$J,358.3,20983,2)
 ;;=^60454
