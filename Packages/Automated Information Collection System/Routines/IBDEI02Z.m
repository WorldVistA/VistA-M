IBDEI02Z ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,849,0)
 ;;=L97.512^^3^32^112
 ;;^UTILITY(U,$J,358.3,849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,849,1,3,0)
 ;;=3^Non-prs chr ulcer oth prt right foot w fat layer exposed
 ;;^UTILITY(U,$J,358.3,849,1,4,0)
 ;;=4^L97.512
 ;;^UTILITY(U,$J,358.3,849,2)
 ;;=^5009546
 ;;^UTILITY(U,$J,358.3,850,0)
 ;;=L97.511^^3^32^111
 ;;^UTILITY(U,$J,358.3,850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,850,1,3,0)
 ;;=3^Non-prs chr ulcer oth prt r foot limited to brkdwn skin
 ;;^UTILITY(U,$J,358.3,850,1,4,0)
 ;;=4^L97.511
 ;;^UTILITY(U,$J,358.3,850,2)
 ;;=^5009545
 ;;^UTILITY(U,$J,358.3,851,0)
 ;;=L97.513^^3^32^113
 ;;^UTILITY(U,$J,358.3,851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,851,1,3,0)
 ;;=3^Non-prs chr ulcer oth prt right foot w necros muscle
 ;;^UTILITY(U,$J,358.3,851,1,4,0)
 ;;=4^L97.513
 ;;^UTILITY(U,$J,358.3,851,2)
 ;;=^5009547
 ;;^UTILITY(U,$J,358.3,852,0)
 ;;=L97.514^^3^32^114
 ;;^UTILITY(U,$J,358.3,852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,852,1,3,0)
 ;;=3^Non-prs chr ulcer oth prt right foot w necrosis of bone
 ;;^UTILITY(U,$J,358.3,852,1,4,0)
 ;;=4^L97.514
 ;;^UTILITY(U,$J,358.3,852,2)
 ;;=^5009548
 ;;^UTILITY(U,$J,358.3,853,0)
 ;;=L97.519^^3^32^115
 ;;^UTILITY(U,$J,358.3,853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,853,1,3,0)
 ;;=3^Non-prs chr ulcer oth prt right foot w unsp severity
 ;;^UTILITY(U,$J,358.3,853,1,4,0)
 ;;=4^L97.519
 ;;^UTILITY(U,$J,358.3,853,2)
 ;;=^5009549
 ;;^UTILITY(U,$J,358.3,854,0)
 ;;=L97.521^^3^32^106
 ;;^UTILITY(U,$J,358.3,854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,854,1,3,0)
 ;;=3^Non-prs chr ulcer oth prt l foot limited to brkdwn skin
 ;;^UTILITY(U,$J,358.3,854,1,4,0)
 ;;=4^L97.521
 ;;^UTILITY(U,$J,358.3,854,2)
 ;;=^5009550
 ;;^UTILITY(U,$J,358.3,855,0)
 ;;=L89.90^^3^32^125
 ;;^UTILITY(U,$J,358.3,855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,855,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, unspecified stage
 ;;^UTILITY(U,$J,358.3,855,1,4,0)
 ;;=4^L89.90
 ;;^UTILITY(U,$J,358.3,855,2)
 ;;=^5133666
 ;;^UTILITY(U,$J,358.3,856,0)
 ;;=L89.91^^3^32^121
 ;;^UTILITY(U,$J,358.3,856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,856,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, stage 1
 ;;^UTILITY(U,$J,358.3,856,1,4,0)
 ;;=4^L89.91
 ;;^UTILITY(U,$J,358.3,856,2)
 ;;=^5133664
 ;;^UTILITY(U,$J,358.3,857,0)
 ;;=L89.92^^3^32^122
 ;;^UTILITY(U,$J,358.3,857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,857,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, stage 2
 ;;^UTILITY(U,$J,358.3,857,1,4,0)
 ;;=4^L89.92
 ;;^UTILITY(U,$J,358.3,857,2)
 ;;=^5133667
 ;;^UTILITY(U,$J,358.3,858,0)
 ;;=L89.93^^3^32^123
 ;;^UTILITY(U,$J,358.3,858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,858,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, stage 3
 ;;^UTILITY(U,$J,358.3,858,1,4,0)
 ;;=4^L89.93
 ;;^UTILITY(U,$J,358.3,858,2)
 ;;=^5133668
 ;;^UTILITY(U,$J,358.3,859,0)
 ;;=L89.94^^3^32^124
 ;;^UTILITY(U,$J,358.3,859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,859,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, stage 4
 ;;^UTILITY(U,$J,358.3,859,1,4,0)
 ;;=4^L89.94
 ;;^UTILITY(U,$J,358.3,859,2)
 ;;=^5133669
 ;;^UTILITY(U,$J,358.3,860,0)
 ;;=L89.95^^3^32^126
 ;;^UTILITY(U,$J,358.3,860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,860,1,3,0)
 ;;=3^Pressure ulcer of unspecified site, unstageable
 ;;^UTILITY(U,$J,358.3,860,1,4,0)
 ;;=4^L89.95
 ;;^UTILITY(U,$J,358.3,860,2)
 ;;=^5133660
 ;;^UTILITY(U,$J,358.3,861,0)
 ;;=L50.9^^3^32^149
 ;;^UTILITY(U,$J,358.3,861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,861,1,3,0)
 ;;=3^Urticaria, unspecified
 ;;^UTILITY(U,$J,358.3,861,1,4,0)
 ;;=4^L50.9
