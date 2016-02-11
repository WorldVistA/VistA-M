IBDEI0II ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8312,0)
 ;;=N39.41^^55^537^66
 ;;^UTILITY(U,$J,358.3,8312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8312,1,3,0)
 ;;=3^Urge incontinence
 ;;^UTILITY(U,$J,358.3,8312,1,4,0)
 ;;=4^N39.41
 ;;^UTILITY(U,$J,358.3,8312,2)
 ;;=^5015680
 ;;^UTILITY(U,$J,358.3,8313,0)
 ;;=R35.0^^55^537^20
 ;;^UTILITY(U,$J,358.3,8313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8313,1,3,0)
 ;;=3^Frequency of micturition
 ;;^UTILITY(U,$J,358.3,8313,1,4,0)
 ;;=4^R35.0
 ;;^UTILITY(U,$J,358.3,8313,2)
 ;;=^5019334
 ;;^UTILITY(U,$J,358.3,8314,0)
 ;;=R35.1^^55^537^46
 ;;^UTILITY(U,$J,358.3,8314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8314,1,3,0)
 ;;=3^Nocturia
 ;;^UTILITY(U,$J,358.3,8314,1,4,0)
 ;;=4^R35.1
 ;;^UTILITY(U,$J,358.3,8314,2)
 ;;=^5019335
 ;;^UTILITY(U,$J,358.3,8315,0)
 ;;=R39.15^^55^537^67
 ;;^UTILITY(U,$J,358.3,8315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8315,1,3,0)
 ;;=3^Urgency of urination
 ;;^UTILITY(U,$J,358.3,8315,1,4,0)
 ;;=4^R39.15
 ;;^UTILITY(U,$J,358.3,8315,2)
 ;;=^5019345
 ;;^UTILITY(U,$J,358.3,8316,0)
 ;;=R39.11^^55^537^24
 ;;^UTILITY(U,$J,358.3,8316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8316,1,3,0)
 ;;=3^Hesitancy of micturition
 ;;^UTILITY(U,$J,358.3,8316,1,4,0)
 ;;=4^R39.11
 ;;^UTILITY(U,$J,358.3,8316,2)
 ;;=^5019341
 ;;^UTILITY(U,$J,358.3,8317,0)
 ;;=R39.16^^55^537^59
 ;;^UTILITY(U,$J,358.3,8317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8317,1,3,0)
 ;;=3^Straining to void
 ;;^UTILITY(U,$J,358.3,8317,1,4,0)
 ;;=4^R39.16
 ;;^UTILITY(U,$J,358.3,8317,2)
 ;;=^5019346
 ;;^UTILITY(U,$J,358.3,8318,0)
 ;;=R36.0^^55^537^64
 ;;^UTILITY(U,$J,358.3,8318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8318,1,3,0)
 ;;=3^Urethral discharge without blood
 ;;^UTILITY(U,$J,358.3,8318,1,4,0)
 ;;=4^R36.0
 ;;^UTILITY(U,$J,358.3,8318,2)
 ;;=^5019337
 ;;^UTILITY(U,$J,358.3,8319,0)
 ;;=R36.9^^55^537^65
 ;;^UTILITY(U,$J,358.3,8319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8319,1,3,0)
 ;;=3^Urethral discharge, unspecified
 ;;^UTILITY(U,$J,358.3,8319,1,4,0)
 ;;=4^R36.9
 ;;^UTILITY(U,$J,358.3,8319,2)
 ;;=^5019338
 ;;^UTILITY(U,$J,358.3,8320,0)
 ;;=R97.2^^55^537^15
 ;;^UTILITY(U,$J,358.3,8320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8320,1,3,0)
 ;;=3^Elevated prostate specific antigen [PSA]
 ;;^UTILITY(U,$J,358.3,8320,1,4,0)
 ;;=4^R97.2
 ;;^UTILITY(U,$J,358.3,8320,2)
 ;;=^5019748
 ;;^UTILITY(U,$J,358.3,8321,0)
 ;;=R80.9^^55^537^56
 ;;^UTILITY(U,$J,358.3,8321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8321,1,3,0)
 ;;=3^Proteinuria, unspecified
 ;;^UTILITY(U,$J,358.3,8321,1,4,0)
 ;;=4^R80.9
 ;;^UTILITY(U,$J,358.3,8321,2)
 ;;=^5019599
 ;;^UTILITY(U,$J,358.3,8322,0)
 ;;=Z87.442^^55^537^52
 ;;^UTILITY(U,$J,358.3,8322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8322,1,3,0)
 ;;=3^Personal history of urinary calculi
 ;;^UTILITY(U,$J,358.3,8322,1,4,0)
 ;;=4^Z87.442
 ;;^UTILITY(U,$J,358.3,8322,2)
 ;;=^5063497
 ;;^UTILITY(U,$J,358.3,8323,0)
 ;;=C02.9^^55^538^80
 ;;^UTILITY(U,$J,358.3,8323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8323,1,3,0)
 ;;=3^Malignant neoplasm of tongue, unspecified
 ;;^UTILITY(U,$J,358.3,8323,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,8323,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,8324,0)
 ;;=C06.9^^55^538^67
 ;;^UTILITY(U,$J,358.3,8324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8324,1,3,0)
 ;;=3^Malignant neoplasm of mouth, unspecified
 ;;^UTILITY(U,$J,358.3,8324,1,4,0)
 ;;=4^C06.9
 ;;^UTILITY(U,$J,358.3,8324,2)
 ;;=^5000901
 ;;^UTILITY(U,$J,358.3,8325,0)
 ;;=C10.9^^55^538^69
 ;;^UTILITY(U,$J,358.3,8325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8325,1,3,0)
 ;;=3^Malignant neoplasm of oropharynx, unspecified
