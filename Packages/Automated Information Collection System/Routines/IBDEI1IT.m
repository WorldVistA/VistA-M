IBDEI1IT ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24615,1,3,0)
 ;;=3^Dysphagia,Unspec
 ;;^UTILITY(U,$J,358.3,24615,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,24615,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,24616,0)
 ;;=R19.7^^85^1083^18
 ;;^UTILITY(U,$J,358.3,24616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24616,1,3,0)
 ;;=3^Diarrhea,Unspec
 ;;^UTILITY(U,$J,358.3,24616,1,4,0)
 ;;=4^R19.7
 ;;^UTILITY(U,$J,358.3,24616,2)
 ;;=^5019276
 ;;^UTILITY(U,$J,358.3,24617,0)
 ;;=L30.9^^85^1083^7
 ;;^UTILITY(U,$J,358.3,24617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24617,1,3,0)
 ;;=3^Dermatitis,Unspec
 ;;^UTILITY(U,$J,358.3,24617,1,4,0)
 ;;=4^L30.9
 ;;^UTILITY(U,$J,358.3,24617,2)
 ;;=^5009159
 ;;^UTILITY(U,$J,358.3,24618,0)
 ;;=F33.9^^85^1083^5
 ;;^UTILITY(U,$J,358.3,24618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24618,1,3,0)
 ;;=3^Depression Disorder,Major,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,24618,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,24618,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,24619,0)
 ;;=K44.9^^85^1083^17
 ;;^UTILITY(U,$J,358.3,24619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24619,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst/Gangr
 ;;^UTILITY(U,$J,358.3,24619,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,24619,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,24620,0)
 ;;=E10.42^^85^1083^10
 ;;^UTILITY(U,$J,358.3,24620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24620,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,24620,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,24620,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,24621,0)
 ;;=E11.42^^85^1083^13
 ;;^UTILITY(U,$J,358.3,24621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24621,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,24621,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,24621,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,24622,0)
 ;;=E13.42^^85^1083^9
 ;;^UTILITY(U,$J,358.3,24622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24622,1,3,0)
 ;;=3^Diabetes Other w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,24622,1,4,0)
 ;;=4^E13.42
 ;;^UTILITY(U,$J,358.3,24622,2)
 ;;=^5002686
 ;;^UTILITY(U,$J,358.3,24623,0)
 ;;=E08.42^^85^1083^16
 ;;^UTILITY(U,$J,358.3,24623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24623,1,3,0)
 ;;=3^Diabetes d/t Underlying Condition w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,24623,1,4,0)
 ;;=4^E08.42
 ;;^UTILITY(U,$J,358.3,24623,2)
 ;;=^5002524
 ;;^UTILITY(U,$J,358.3,24624,0)
 ;;=E09.42^^85^1083^8
 ;;^UTILITY(U,$J,358.3,24624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24624,1,3,0)
 ;;=3^Diabetes Drug-Induced w/ Neurological Compl w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,24624,1,4,0)
 ;;=4^E09.42
 ;;^UTILITY(U,$J,358.3,24624,2)
 ;;=^5002566
 ;;^UTILITY(U,$J,358.3,24625,0)
 ;;=M54.9^^85^1083^21
 ;;^UTILITY(U,$J,358.3,24625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24625,1,3,0)
 ;;=3^Dorsalgia,Unspec
 ;;^UTILITY(U,$J,358.3,24625,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,24625,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,24626,0)
 ;;=K26.9^^85^1083^22
 ;;^UTILITY(U,$J,358.3,24626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24626,1,3,0)
 ;;=3^Duodenal Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,24626,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,24626,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,24627,0)
 ;;=N40.0^^85^1084^4
 ;;^UTILITY(U,$J,358.3,24627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24627,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
