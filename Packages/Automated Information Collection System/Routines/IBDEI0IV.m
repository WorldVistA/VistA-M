IBDEI0IV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8481,1,3,0)
 ;;=3^Gonococcal infection of lower genitourinary tract, unsp
 ;;^UTILITY(U,$J,358.3,8481,1,4,0)
 ;;=4^A54.00
 ;;^UTILITY(U,$J,358.3,8481,2)
 ;;=^5000311
 ;;^UTILITY(U,$J,358.3,8482,0)
 ;;=B35.1^^55^540^99
 ;;^UTILITY(U,$J,358.3,8482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8482,1,3,0)
 ;;=3^Tinea unguium
 ;;^UTILITY(U,$J,358.3,8482,1,4,0)
 ;;=4^B35.1
 ;;^UTILITY(U,$J,358.3,8482,2)
 ;;=^119748
 ;;^UTILITY(U,$J,358.3,8483,0)
 ;;=B37.3^^55^540^28
 ;;^UTILITY(U,$J,358.3,8483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8483,1,3,0)
 ;;=3^Candidiasis of vulva and vagina
 ;;^UTILITY(U,$J,358.3,8483,1,4,0)
 ;;=4^B37.3
 ;;^UTILITY(U,$J,358.3,8483,2)
 ;;=^5000615
 ;;^UTILITY(U,$J,358.3,8484,0)
 ;;=B58.9^^55^540^100
 ;;^UTILITY(U,$J,358.3,8484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8484,1,3,0)
 ;;=3^Toxoplasmosis, unspecified
 ;;^UTILITY(U,$J,358.3,8484,1,4,0)
 ;;=4^B58.9
 ;;^UTILITY(U,$J,358.3,8484,2)
 ;;=^5000733
 ;;^UTILITY(U,$J,358.3,8485,0)
 ;;=A59.01^^55^540^102
 ;;^UTILITY(U,$J,358.3,8485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8485,1,3,0)
 ;;=3^Trichomonal vulvovaginitis
 ;;^UTILITY(U,$J,358.3,8485,1,4,0)
 ;;=4^A59.01
 ;;^UTILITY(U,$J,358.3,8485,2)
 ;;=^121763
 ;;^UTILITY(U,$J,358.3,8486,0)
 ;;=A59.03^^55^540^101
 ;;^UTILITY(U,$J,358.3,8486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8486,1,3,0)
 ;;=3^Trichomonal cystitis and urethritis
 ;;^UTILITY(U,$J,358.3,8486,1,4,0)
 ;;=4^A59.03
 ;;^UTILITY(U,$J,358.3,8486,2)
 ;;=^5000349
 ;;^UTILITY(U,$J,358.3,8487,0)
 ;;=B59.^^55^540^89
 ;;^UTILITY(U,$J,358.3,8487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8487,1,3,0)
 ;;=3^Pneumocystosis
 ;;^UTILITY(U,$J,358.3,8487,1,4,0)
 ;;=4^B59.
 ;;^UTILITY(U,$J,358.3,8487,2)
 ;;=^5000734
 ;;^UTILITY(U,$J,358.3,8488,0)
 ;;=H05.011^^55^540^41
 ;;^UTILITY(U,$J,358.3,8488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8488,1,3,0)
 ;;=3^Cellulitis of right orbit
 ;;^UTILITY(U,$J,358.3,8488,1,4,0)
 ;;=4^H05.011
 ;;^UTILITY(U,$J,358.3,8488,2)
 ;;=^5004560
 ;;^UTILITY(U,$J,358.3,8489,0)
 ;;=H05.012^^55^540^34
 ;;^UTILITY(U,$J,358.3,8489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8489,1,3,0)
 ;;=3^Cellulitis of left orbit
 ;;^UTILITY(U,$J,358.3,8489,1,4,0)
 ;;=4^H05.012
 ;;^UTILITY(U,$J,358.3,8489,2)
 ;;=^5004561
 ;;^UTILITY(U,$J,358.3,8490,0)
 ;;=H60.01^^55^540^3
 ;;^UTILITY(U,$J,358.3,8490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8490,1,3,0)
 ;;=3^Abscess of right external ear
 ;;^UTILITY(U,$J,358.3,8490,1,4,0)
 ;;=4^H60.01
 ;;^UTILITY(U,$J,358.3,8490,2)
 ;;=^5006436
 ;;^UTILITY(U,$J,358.3,8491,0)
 ;;=H60.02^^55^540^2
 ;;^UTILITY(U,$J,358.3,8491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8491,1,3,0)
 ;;=3^Abscess of left external ear
 ;;^UTILITY(U,$J,358.3,8491,1,4,0)
 ;;=4^H60.02
 ;;^UTILITY(U,$J,358.3,8491,2)
 ;;=^5006437
 ;;^UTILITY(U,$J,358.3,8492,0)
 ;;=H60.03^^55^540^1
 ;;^UTILITY(U,$J,358.3,8492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8492,1,3,0)
 ;;=3^Abscess of external ear, bilateral
 ;;^UTILITY(U,$J,358.3,8492,1,4,0)
 ;;=4^H60.03
 ;;^UTILITY(U,$J,358.3,8492,2)
 ;;=^5006438
 ;;^UTILITY(U,$J,358.3,8493,0)
 ;;=H60.11^^55^540^38
 ;;^UTILITY(U,$J,358.3,8493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8493,1,3,0)
 ;;=3^Cellulitis of right external ear
 ;;^UTILITY(U,$J,358.3,8493,1,4,0)
 ;;=4^H60.11
 ;;^UTILITY(U,$J,358.3,8493,2)
 ;;=^5006440
 ;;^UTILITY(U,$J,358.3,8494,0)
 ;;=H60.12^^55^540^31
 ;;^UTILITY(U,$J,358.3,8494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8494,1,3,0)
 ;;=3^Cellulitis of left external ear
 ;;^UTILITY(U,$J,358.3,8494,1,4,0)
 ;;=4^H60.12
