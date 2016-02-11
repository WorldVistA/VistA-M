IBDEI0IF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8271,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,8271,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,8272,0)
 ;;=K40.20^^55^537^8
 ;;^UTILITY(U,$J,358.3,8272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8272,1,3,0)
 ;;=3^Bi inguinal hernia, w/o obst or gangrene, not spcf as recur
 ;;^UTILITY(U,$J,358.3,8272,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,8272,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,8273,0)
 ;;=N04.9^^55^537^44
 ;;^UTILITY(U,$J,358.3,8273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8273,1,3,0)
 ;;=3^Nephrotic syndrome with unspecified morphologic changes
 ;;^UTILITY(U,$J,358.3,8273,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,8273,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,8274,0)
 ;;=N17.9^^55^537^3
 ;;^UTILITY(U,$J,358.3,8274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8274,1,3,0)
 ;;=3^Acute kidney failure, unspecified
 ;;^UTILITY(U,$J,358.3,8274,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,8274,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,8275,0)
 ;;=N18.9^^55^537^11
 ;;^UTILITY(U,$J,358.3,8275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8275,1,3,0)
 ;;=3^Chronic kidney disease, unspecified
 ;;^UTILITY(U,$J,358.3,8275,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,8275,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,8276,0)
 ;;=N19.^^55^537^38
 ;;^UTILITY(U,$J,358.3,8276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8276,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,8276,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,8276,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,8277,0)
 ;;=N11.0^^55^537^48
 ;;^UTILITY(U,$J,358.3,8277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8277,1,3,0)
 ;;=3^Nonobstructive reflux-associated chronic pyelonephritis
 ;;^UTILITY(U,$J,358.3,8277,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,8277,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,8278,0)
 ;;=N10.^^55^537^5
 ;;^UTILITY(U,$J,358.3,8278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8278,1,3,0)
 ;;=3^Acute tubulo-interstitial nephritis
 ;;^UTILITY(U,$J,358.3,8278,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,8278,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,8279,0)
 ;;=N28.9^^55^537^12
 ;;^UTILITY(U,$J,358.3,8279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8279,1,3,0)
 ;;=3^Disorder of kidney and ureter, unspecified
 ;;^UTILITY(U,$J,358.3,8279,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,8279,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,8280,0)
 ;;=N30.00^^55^537^2
 ;;^UTILITY(U,$J,358.3,8280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8280,1,3,0)
 ;;=3^Acute cystitis without hematuria
 ;;^UTILITY(U,$J,358.3,8280,1,4,0)
 ;;=4^N30.00
 ;;^UTILITY(U,$J,358.3,8280,2)
 ;;=^5015632
 ;;^UTILITY(U,$J,358.3,8281,0)
 ;;=N30.01^^55^537^1
 ;;^UTILITY(U,$J,358.3,8281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8281,1,3,0)
 ;;=3^Acute cystitis with hematuria
 ;;^UTILITY(U,$J,358.3,8281,1,4,0)
 ;;=4^N30.01
 ;;^UTILITY(U,$J,358.3,8281,2)
 ;;=^5015633
 ;;^UTILITY(U,$J,358.3,8282,0)
 ;;=N30.40^^55^537^37
 ;;^UTILITY(U,$J,358.3,8282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8282,1,3,0)
 ;;=3^Irradiation cystitis without hematuria
 ;;^UTILITY(U,$J,358.3,8282,1,4,0)
 ;;=4^N30.40
 ;;^UTILITY(U,$J,358.3,8282,2)
 ;;=^5015639
 ;;^UTILITY(U,$J,358.3,8283,0)
 ;;=N30.41^^55^537^36
 ;;^UTILITY(U,$J,358.3,8283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8283,1,3,0)
 ;;=3^Irradiation cystitis with hematuria
 ;;^UTILITY(U,$J,358.3,8283,1,4,0)
 ;;=4^N30.41
 ;;^UTILITY(U,$J,358.3,8283,2)
 ;;=^5015640
 ;;^UTILITY(U,$J,358.3,8284,0)
 ;;=N32.0^^55^537^9
 ;;^UTILITY(U,$J,358.3,8284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8284,1,3,0)
 ;;=3^Bladder-neck obstruction
 ;;^UTILITY(U,$J,358.3,8284,1,4,0)
 ;;=4^N32.0
