IBDEI2YB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47099,1,3,0)
 ;;=3^Diverticulosis Lg Intest w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,47099,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,47099,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,47100,0)
 ;;=R42.^^181^2352^20
 ;;^UTILITY(U,$J,358.3,47100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47100,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,47100,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,47100,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,47101,0)
 ;;=R06.00^^181^2352^24
 ;;^UTILITY(U,$J,358.3,47101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47101,1,3,0)
 ;;=3^Dyspnea,Unspec
 ;;^UTILITY(U,$J,358.3,47101,1,4,0)
 ;;=4^R06.00
 ;;^UTILITY(U,$J,358.3,47101,2)
 ;;=^5019180
 ;;^UTILITY(U,$J,358.3,47102,0)
 ;;=R13.10^^181^2352^23
 ;;^UTILITY(U,$J,358.3,47102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47102,1,3,0)
 ;;=3^Dysphagia,Unspec
 ;;^UTILITY(U,$J,358.3,47102,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,47102,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,47103,0)
 ;;=R19.7^^181^2352^18
 ;;^UTILITY(U,$J,358.3,47103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47103,1,3,0)
 ;;=3^Diarrhea,Unspec
 ;;^UTILITY(U,$J,358.3,47103,1,4,0)
 ;;=4^R19.7
 ;;^UTILITY(U,$J,358.3,47103,2)
 ;;=^5019276
 ;;^UTILITY(U,$J,358.3,47104,0)
 ;;=L30.9^^181^2352^7
 ;;^UTILITY(U,$J,358.3,47104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47104,1,3,0)
 ;;=3^Dermatitis,Unspec
 ;;^UTILITY(U,$J,358.3,47104,1,4,0)
 ;;=4^L30.9
 ;;^UTILITY(U,$J,358.3,47104,2)
 ;;=^5009159
 ;;^UTILITY(U,$J,358.3,47105,0)
 ;;=F33.9^^181^2352^5
 ;;^UTILITY(U,$J,358.3,47105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47105,1,3,0)
 ;;=3^Depression Disorder,Major,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,47105,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,47105,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,47106,0)
 ;;=K44.9^^181^2352^17
 ;;^UTILITY(U,$J,358.3,47106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47106,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst/Gangr
 ;;^UTILITY(U,$J,358.3,47106,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,47106,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,47107,0)
 ;;=E10.42^^181^2352^10
 ;;^UTILITY(U,$J,358.3,47107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47107,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,47107,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,47107,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,47108,0)
 ;;=E11.42^^181^2352^13
 ;;^UTILITY(U,$J,358.3,47108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47108,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,47108,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,47108,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,47109,0)
 ;;=E13.42^^181^2352^9
 ;;^UTILITY(U,$J,358.3,47109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47109,1,3,0)
 ;;=3^Diabetes Other w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,47109,1,4,0)
 ;;=4^E13.42
 ;;^UTILITY(U,$J,358.3,47109,2)
 ;;=^5002686
 ;;^UTILITY(U,$J,358.3,47110,0)
 ;;=E08.42^^181^2352^16
 ;;^UTILITY(U,$J,358.3,47110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47110,1,3,0)
 ;;=3^Diabetes d/t Underlying Condition w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,47110,1,4,0)
 ;;=4^E08.42
 ;;^UTILITY(U,$J,358.3,47110,2)
 ;;=^5002524
 ;;^UTILITY(U,$J,358.3,47111,0)
 ;;=E09.42^^181^2352^8
 ;;^UTILITY(U,$J,358.3,47111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47111,1,3,0)
 ;;=3^Diabetes Drug-Induced w/ Neurological Compl w/ Diabetic Polyneuropathy
