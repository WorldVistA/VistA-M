IBDEI08C ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3424,0)
 ;;=99341^^10^143^1
 ;;^UTILITY(U,$J,358.3,3424,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,3424,1,1,0)
 ;;=1^Problem Focus Hx & Exam;SF MDM
 ;;^UTILITY(U,$J,358.3,3424,1,2,0)
 ;;=2^99341
 ;;^UTILITY(U,$J,358.3,3425,0)
 ;;=99366^^10^144^1
 ;;^UTILITY(U,$J,358.3,3425,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,3425,1,1,0)
 ;;=1^Med Interdisc Tm Conf w/ Pt/Fam,30min+ by Nonphysician
 ;;^UTILITY(U,$J,358.3,3425,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,3426,0)
 ;;=99367^^10^144^2
 ;;^UTILITY(U,$J,358.3,3426,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,3426,1,1,0)
 ;;=1^Med Interdisc Tm Conf w/o Pt/Fam,30min+ by Physician
 ;;^UTILITY(U,$J,358.3,3426,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,3427,0)
 ;;=99368^^10^144^3
 ;;^UTILITY(U,$J,358.3,3427,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,3427,1,1,0)
 ;;=1^Med Interdisc Tm Conf w/o Pt/Fam,30min+ by Nonphysician
 ;;^UTILITY(U,$J,358.3,3427,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,3428,0)
 ;;=309.24^^11^145^1
 ;;^UTILITY(U,$J,358.3,3428,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3428,1,2,0)
 ;;=2^309.24
 ;;^UTILITY(U,$J,358.3,3428,1,5,0)
 ;;=5^Adj Reac w/ Anxiety
 ;;^UTILITY(U,$J,358.3,3428,2)
 ;;=^268308
 ;;^UTILITY(U,$J,358.3,3429,0)
 ;;=309.4^^11^145^4
 ;;^UTILITY(U,$J,358.3,3429,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3429,1,2,0)
 ;;=2^309.4
 ;;^UTILITY(U,$J,358.3,3429,1,5,0)
 ;;=5^Adj Reac w/ Mixed Disturbance of Emotion & Conduct
 ;;^UTILITY(U,$J,358.3,3429,2)
 ;;=^268312
 ;;^UTILITY(U,$J,358.3,3430,0)
 ;;=309.28^^11^145^2
 ;;^UTILITY(U,$J,358.3,3430,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3430,1,2,0)
 ;;=2^309.28
 ;;^UTILITY(U,$J,358.3,3430,1,5,0)
 ;;=5^Adj Reac w/ Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,3430,2)
 ;;=^268309
 ;;^UTILITY(U,$J,358.3,3431,0)
 ;;=309.9^^11^145^8
 ;;^UTILITY(U,$J,358.3,3431,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3431,1,2,0)
 ;;=2^309.9
 ;;^UTILITY(U,$J,358.3,3431,1,5,0)
 ;;=5^Adjustment Reaction NOS
 ;;^UTILITY(U,$J,358.3,3431,2)
 ;;=^123757
 ;;^UTILITY(U,$J,358.3,3432,0)
 ;;=309.0^^11^145^9
 ;;^UTILITY(U,$J,358.3,3432,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3432,1,2,0)
 ;;=2^309.0
 ;;^UTILITY(U,$J,358.3,3432,1,5,0)
 ;;=5^Depressive Reac-Brief
 ;;^UTILITY(U,$J,358.3,3432,2)
 ;;=^3308
 ;;^UTILITY(U,$J,358.3,3433,0)
 ;;=309.1^^11^145^10
 ;;^UTILITY(U,$J,358.3,3433,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3433,1,2,0)
 ;;=2^309.1
 ;;^UTILITY(U,$J,358.3,3433,1,5,0)
 ;;=5^Depressive Reac-Prolong
 ;;^UTILITY(U,$J,358.3,3433,2)
 ;;=^268304
 ;;^UTILITY(U,$J,358.3,3434,0)
 ;;=309.3^^11^145^3
 ;;^UTILITY(U,$J,358.3,3434,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3434,1,2,0)
 ;;=2^309.3
 ;;^UTILITY(U,$J,358.3,3434,1,5,0)
 ;;=5^Adj Reac w/ Conduct Disturbance
 ;;^UTILITY(U,$J,358.3,3434,2)
 ;;=^268311
 ;;^UTILITY(U,$J,358.3,3435,0)
 ;;=309.81^^11^145^11
 ;;^UTILITY(U,$J,358.3,3435,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3435,1,2,0)
 ;;=2^309.81
 ;;^UTILITY(U,$J,358.3,3435,1,5,0)
 ;;=5^PTSD, Chronic
 ;;^UTILITY(U,$J,358.3,3435,2)
 ;;=^114692
 ;;^UTILITY(U,$J,358.3,3436,0)
 ;;=309.82^^11^145^6
 ;;^UTILITY(U,$J,358.3,3436,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3436,1,2,0)
 ;;=2^309.82
 ;;^UTILITY(U,$J,358.3,3436,1,5,0)
 ;;=5^Adj React w/ Phys Symptom
 ;;^UTILITY(U,$J,358.3,3436,2)
 ;;=^268315
 ;;^UTILITY(U,$J,358.3,3437,0)
 ;;=309.83^^11^145^5
 ;;^UTILITY(U,$J,358.3,3437,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3437,1,2,0)
 ;;=2^309.83
 ;;^UTILITY(U,$J,358.3,3437,1,5,0)
 ;;=5^Adj Reac w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,3437,2)
 ;;=^268316
 ;;^UTILITY(U,$J,358.3,3438,0)
 ;;=309.89^^11^145^7
