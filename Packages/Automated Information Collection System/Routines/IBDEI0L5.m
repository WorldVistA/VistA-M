IBDEI0L5 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9370,1,4,0)
 ;;=4^Z53.21
 ;;^UTILITY(U,$J,358.3,9370,2)
 ;;=^5063096
 ;;^UTILITY(U,$J,358.3,9371,0)
 ;;=Z59.0^^72^641^1
 ;;^UTILITY(U,$J,358.3,9371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9371,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,9371,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,9371,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,9372,0)
 ;;=Z11.1^^72^641^2
 ;;^UTILITY(U,$J,358.3,9372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9372,1,3,0)
 ;;=3^Screening/Reading TB Test
 ;;^UTILITY(U,$J,358.3,9372,1,4,0)
 ;;=4^Z11.1
 ;;^UTILITY(U,$J,358.3,9372,2)
 ;;=^5062670
 ;;^UTILITY(U,$J,358.3,9373,0)
 ;;=Z48.02^^72^641^4
 ;;^UTILITY(U,$J,358.3,9373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9373,1,3,0)
 ;;=3^Removal of Sutures/Staples
 ;;^UTILITY(U,$J,358.3,9373,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,9373,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,9374,0)
 ;;=Z46.6^^72^641^5
 ;;^UTILITY(U,$J,358.3,9374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9374,1,3,0)
 ;;=3^Fitting/Adjusting Urinary Device
 ;;^UTILITY(U,$J,358.3,9374,1,4,0)
 ;;=4^Z46.6
 ;;^UTILITY(U,$J,358.3,9374,2)
 ;;=^5063020
 ;;^UTILITY(U,$J,358.3,9375,0)
 ;;=Z09.^^72^641^6
 ;;^UTILITY(U,$J,358.3,9375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9375,1,3,0)
 ;;=3^F/U Exam after Completed Treatment
 ;;^UTILITY(U,$J,358.3,9375,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,9375,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,9376,0)
 ;;=Z04.6^^72^641^11
 ;;^UTILITY(U,$J,358.3,9376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9376,1,3,0)
 ;;=3^General Psych Exam,Requested Authority
 ;;^UTILITY(U,$J,358.3,9376,1,4,0)
 ;;=4^Z04.6
 ;;^UTILITY(U,$J,358.3,9376,2)
 ;;=^5062662
 ;;^UTILITY(U,$J,358.3,9377,0)
 ;;=Z91.14^^72^641^13
 ;;^UTILITY(U,$J,358.3,9377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9377,1,3,0)
 ;;=3^Patient's Noncompliance w/ Medical Treatment
 ;;^UTILITY(U,$J,358.3,9377,1,4,0)
 ;;=4^Z91.14
 ;;^UTILITY(U,$J,358.3,9377,2)
 ;;=^5063616
 ;;^UTILITY(U,$J,358.3,9378,0)
 ;;=Z76.5^^72^641^15
 ;;^UTILITY(U,$J,358.3,9378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9378,1,3,0)
 ;;=3^Malingerer
 ;;^UTILITY(U,$J,358.3,9378,1,4,0)
 ;;=4^Z76.5
 ;;^UTILITY(U,$J,358.3,9378,2)
 ;;=^5063302
 ;;^UTILITY(U,$J,358.3,9379,0)
 ;;=Z23.^^72^641^17
 ;;^UTILITY(U,$J,358.3,9379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9379,1,3,0)
 ;;=3^Immunization
 ;;^UTILITY(U,$J,358.3,9379,1,4,0)
 ;;=4^Z23.
 ;;^UTILITY(U,$J,358.3,9379,2)
 ;;=^5062795
 ;;^UTILITY(U,$J,358.3,9380,0)
 ;;=Z03.6^^72^641^14
 ;;^UTILITY(U,$J,358.3,9380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9380,1,3,0)
 ;;=3^Observation for Suspected Toxic Effect From Ingested Subs Ruled-Out
 ;;^UTILITY(U,$J,358.3,9380,1,4,0)
 ;;=4^Z03.6
 ;;^UTILITY(U,$J,358.3,9380,2)
 ;;=^5062647
 ;;^UTILITY(U,$J,358.3,9381,0)
 ;;=Z03.89^^72^641^18
 ;;^UTILITY(U,$J,358.3,9381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9381,1,3,0)
 ;;=3^Suspected Diseases and Conditions Ruled Out
 ;;^UTILITY(U,$J,358.3,9381,1,4,0)
 ;;=4^Z03.89
 ;;^UTILITY(U,$J,358.3,9381,2)
 ;;=^5062656
 ;;^UTILITY(U,$J,358.3,9382,0)
 ;;=Z71.89^^72^641^20
 ;;^UTILITY(U,$J,358.3,9382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9382,1,3,0)
 ;;=3^Counseling,Oth Specified
 ;;^UTILITY(U,$J,358.3,9382,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,9382,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,9383,0)
 ;;=I10.^^72^642^14
 ;;^UTILITY(U,$J,358.3,9383,1,0)
 ;;=^358.31IA^4^2
