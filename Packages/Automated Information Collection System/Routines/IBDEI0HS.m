IBDEI0HS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7967,1,3,0)
 ;;=3^Non-prs chr ulcer oth prt right foot w unsp severity
 ;;^UTILITY(U,$J,358.3,7967,1,4,0)
 ;;=4^L97.519
 ;;^UTILITY(U,$J,358.3,7967,2)
 ;;=^5009549
 ;;^UTILITY(U,$J,358.3,7968,0)
 ;;=L97.521^^55^531^106
 ;;^UTILITY(U,$J,358.3,7968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7968,1,3,0)
 ;;=3^Non-prs chr ulcer oth prt l foot limited to brkdwn skin
 ;;^UTILITY(U,$J,358.3,7968,1,4,0)
 ;;=4^L97.521
 ;;^UTILITY(U,$J,358.3,7968,2)
 ;;=^5009550
 ;;^UTILITY(U,$J,358.3,7969,0)
 ;;=L89.90^^55^531^125
 ;;^UTILITY(U,$J,358.3,7969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7969,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, unspecified stage
 ;;^UTILITY(U,$J,358.3,7969,1,4,0)
 ;;=4^L89.90
 ;;^UTILITY(U,$J,358.3,7969,2)
 ;;=^5133666
 ;;^UTILITY(U,$J,358.3,7970,0)
 ;;=L89.91^^55^531^121
 ;;^UTILITY(U,$J,358.3,7970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7970,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, stage 1
 ;;^UTILITY(U,$J,358.3,7970,1,4,0)
 ;;=4^L89.91
 ;;^UTILITY(U,$J,358.3,7970,2)
 ;;=^5133664
 ;;^UTILITY(U,$J,358.3,7971,0)
 ;;=L89.92^^55^531^122
 ;;^UTILITY(U,$J,358.3,7971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7971,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, stage 2
 ;;^UTILITY(U,$J,358.3,7971,1,4,0)
 ;;=4^L89.92
 ;;^UTILITY(U,$J,358.3,7971,2)
 ;;=^5133667
 ;;^UTILITY(U,$J,358.3,7972,0)
 ;;=L89.93^^55^531^123
 ;;^UTILITY(U,$J,358.3,7972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7972,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, stage 3
 ;;^UTILITY(U,$J,358.3,7972,1,4,0)
 ;;=4^L89.93
 ;;^UTILITY(U,$J,358.3,7972,2)
 ;;=^5133668
 ;;^UTILITY(U,$J,358.3,7973,0)
 ;;=L89.94^^55^531^124
 ;;^UTILITY(U,$J,358.3,7973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7973,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, stage 4
 ;;^UTILITY(U,$J,358.3,7973,1,4,0)
 ;;=4^L89.94
 ;;^UTILITY(U,$J,358.3,7973,2)
 ;;=^5133669
 ;;^UTILITY(U,$J,358.3,7974,0)
 ;;=L89.95^^55^531^126
 ;;^UTILITY(U,$J,358.3,7974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7974,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, unstageable
 ;;^UTILITY(U,$J,358.3,7974,1,4,0)
 ;;=4^L89.95
 ;;^UTILITY(U,$J,358.3,7974,2)
 ;;=^5133660
 ;;^UTILITY(U,$J,358.3,7975,0)
 ;;=L50.9^^55^531^149
 ;;^UTILITY(U,$J,358.3,7975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7975,1,3,0)
 ;;=3^Urticaria, unspecified
 ;;^UTILITY(U,$J,358.3,7975,1,4,0)
 ;;=4^L50.9
 ;;^UTILITY(U,$J,358.3,7975,2)
 ;;=^5009204
 ;;^UTILITY(U,$J,358.3,7976,0)
 ;;=L98.9^^55^531^31
 ;;^UTILITY(U,$J,358.3,7976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7976,1,3,0)
 ;;=3^Disorder of the skin and subcutaneous tissue, unspecified
 ;;^UTILITY(U,$J,358.3,7976,1,4,0)
 ;;=4^L98.9
 ;;^UTILITY(U,$J,358.3,7976,2)
 ;;=^5009595
 ;;^UTILITY(U,$J,358.3,7977,0)
 ;;=M34.9^^55^531^143
 ;;^UTILITY(U,$J,358.3,7977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7977,1,3,0)
 ;;=3^Systemic sclerosis, unspecified
 ;;^UTILITY(U,$J,358.3,7977,1,4,0)
 ;;=4^M34.9
 ;;^UTILITY(U,$J,358.3,7977,2)
 ;;=^5011785
 ;;^UTILITY(U,$J,358.3,7978,0)
 ;;=M34.0^^55^531^127
 ;;^UTILITY(U,$J,358.3,7978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7978,1,3,0)
 ;;=3^Progressive systemic sclerosis
 ;;^UTILITY(U,$J,358.3,7978,1,4,0)
 ;;=4^M34.0
 ;;^UTILITY(U,$J,358.3,7978,2)
 ;;=^5011778
 ;;^UTILITY(U,$J,358.3,7979,0)
 ;;=M34.1^^55^531^10
 ;;^UTILITY(U,$J,358.3,7979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7979,1,3,0)
 ;;=3^CR(E)ST syndrome
 ;;^UTILITY(U,$J,358.3,7979,1,4,0)
 ;;=4^M34.1
 ;;^UTILITY(U,$J,358.3,7979,2)
 ;;=^5011779
 ;;^UTILITY(U,$J,358.3,7980,0)
 ;;=R21.^^55^531^133
