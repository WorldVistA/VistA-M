IBDEI1PP ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30693,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Ankle,Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30693,1,4,0)
 ;;=4^L97.321
 ;;^UTILITY(U,$J,358.3,30693,2)
 ;;=^5009520
 ;;^UTILITY(U,$J,358.3,30694,0)
 ;;=L97.322^^189^1921^88
 ;;^UTILITY(U,$J,358.3,30694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30694,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Ankle,Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30694,1,4,0)
 ;;=4^L97.322
 ;;^UTILITY(U,$J,358.3,30694,2)
 ;;=^5009521
 ;;^UTILITY(U,$J,358.3,30695,0)
 ;;=L97.323^^189^1921^89
 ;;^UTILITY(U,$J,358.3,30695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30695,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Ankle,Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30695,1,4,0)
 ;;=4^L97.323
 ;;^UTILITY(U,$J,358.3,30695,2)
 ;;=^5009522
 ;;^UTILITY(U,$J,358.3,30696,0)
 ;;=L97.324^^189^1921^90
 ;;^UTILITY(U,$J,358.3,30696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30696,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Ankle,Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30696,1,4,0)
 ;;=4^L97.324
 ;;^UTILITY(U,$J,358.3,30696,2)
 ;;=^5009523
 ;;^UTILITY(U,$J,358.3,30697,0)
 ;;=L97.329^^189^1921^91
 ;;^UTILITY(U,$J,358.3,30697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30697,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Ankle,Unspec Severity
 ;;^UTILITY(U,$J,358.3,30697,1,4,0)
 ;;=4^L97.329
 ;;^UTILITY(U,$J,358.3,30697,2)
 ;;=^5009524
 ;;^UTILITY(U,$J,358.3,30698,0)
 ;;=L97.421^^189^1921^102
 ;;^UTILITY(U,$J,358.3,30698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30698,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Heel/Midfoot,Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30698,1,4,0)
 ;;=4^L97.421
 ;;^UTILITY(U,$J,358.3,30698,2)
 ;;=^5009535
 ;;^UTILITY(U,$J,358.3,30699,0)
 ;;=L97.422^^189^1921^103
 ;;^UTILITY(U,$J,358.3,30699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30699,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Heel/Midfoot,Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30699,1,4,0)
 ;;=4^L97.422
 ;;^UTILITY(U,$J,358.3,30699,2)
 ;;=^5009536
 ;;^UTILITY(U,$J,358.3,30700,0)
 ;;=L97.423^^189^1921^104
 ;;^UTILITY(U,$J,358.3,30700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30700,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Heel/Midfoot,Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30700,1,4,0)
 ;;=4^L97.423
 ;;^UTILITY(U,$J,358.3,30700,2)
 ;;=^5009537
 ;;^UTILITY(U,$J,358.3,30701,0)
 ;;=L97.424^^189^1921^105
 ;;^UTILITY(U,$J,358.3,30701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30701,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Heel/Midfoot,Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30701,1,4,0)
 ;;=4^L97.424
 ;;^UTILITY(U,$J,358.3,30701,2)
 ;;=^5009538
 ;;^UTILITY(U,$J,358.3,30702,0)
 ;;=L97.429^^189^1921^106
 ;;^UTILITY(U,$J,358.3,30702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30702,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Heel/Midfoot,Unspec Severity
 ;;^UTILITY(U,$J,358.3,30702,1,4,0)
 ;;=4^L97.429
 ;;^UTILITY(U,$J,358.3,30702,2)
 ;;=^5009539
 ;;^UTILITY(U,$J,358.3,30703,0)
 ;;=L97.521^^189^1921^97
 ;;^UTILITY(U,$J,358.3,30703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30703,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Foot NEC,Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30703,1,4,0)
 ;;=4^L97.521
 ;;^UTILITY(U,$J,358.3,30703,2)
 ;;=^5009550
 ;;^UTILITY(U,$J,358.3,30704,0)
 ;;=L97.522^^189^1921^98
 ;;^UTILITY(U,$J,358.3,30704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30704,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Foot NEC,Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30704,1,4,0)
 ;;=4^L97.522
 ;;^UTILITY(U,$J,358.3,30704,2)
 ;;=^5009551
 ;;^UTILITY(U,$J,358.3,30705,0)
 ;;=L97.523^^189^1921^99
