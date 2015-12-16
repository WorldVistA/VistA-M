IBDEI03M ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1158,1,3,0)
 ;;=3^Bi inguinal hernia, w/o obst or gangrene, not spcf as recur
 ;;^UTILITY(U,$J,358.3,1158,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,1158,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,1159,0)
 ;;=N04.9^^3^38^44
 ;;^UTILITY(U,$J,358.3,1159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1159,1,3,0)
 ;;=3^Nephrotic syndrome with unspecified morphologic changes
 ;;^UTILITY(U,$J,358.3,1159,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,1159,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,1160,0)
 ;;=N17.9^^3^38^3
 ;;^UTILITY(U,$J,358.3,1160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1160,1,3,0)
 ;;=3^Acute kidney failure, unspecified
 ;;^UTILITY(U,$J,358.3,1160,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,1160,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,1161,0)
 ;;=N18.9^^3^38^11
 ;;^UTILITY(U,$J,358.3,1161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1161,1,3,0)
 ;;=3^Chronic kidney disease, unspecified
 ;;^UTILITY(U,$J,358.3,1161,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,1161,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,1162,0)
 ;;=N19.^^3^38^38
 ;;^UTILITY(U,$J,358.3,1162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1162,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1162,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,1162,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,1163,0)
 ;;=N11.0^^3^38^48
 ;;^UTILITY(U,$J,358.3,1163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1163,1,3,0)
 ;;=3^Nonobstructive reflux-associated chronic pyelonephritis
 ;;^UTILITY(U,$J,358.3,1163,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,1163,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,1164,0)
 ;;=N10.^^3^38^5
 ;;^UTILITY(U,$J,358.3,1164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1164,1,3,0)
 ;;=3^Acute tubulo-interstitial nephritis
 ;;^UTILITY(U,$J,358.3,1164,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,1164,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,1165,0)
 ;;=N28.9^^3^38^12
 ;;^UTILITY(U,$J,358.3,1165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1165,1,3,0)
 ;;=3^Disorder of kidney and ureter, unspecified
 ;;^UTILITY(U,$J,358.3,1165,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,1165,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,1166,0)
 ;;=N30.00^^3^38^2
 ;;^UTILITY(U,$J,358.3,1166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1166,1,3,0)
 ;;=3^Acute cystitis without hematuria
 ;;^UTILITY(U,$J,358.3,1166,1,4,0)
 ;;=4^N30.00
 ;;^UTILITY(U,$J,358.3,1166,2)
 ;;=^5015632
 ;;^UTILITY(U,$J,358.3,1167,0)
 ;;=N30.01^^3^38^1
 ;;^UTILITY(U,$J,358.3,1167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1167,1,3,0)
 ;;=3^Acute cystitis with hematuria
 ;;^UTILITY(U,$J,358.3,1167,1,4,0)
 ;;=4^N30.01
 ;;^UTILITY(U,$J,358.3,1167,2)
 ;;=^5015633
 ;;^UTILITY(U,$J,358.3,1168,0)
 ;;=N30.40^^3^38^37
 ;;^UTILITY(U,$J,358.3,1168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1168,1,3,0)
 ;;=3^Irradiation cystitis without hematuria
 ;;^UTILITY(U,$J,358.3,1168,1,4,0)
 ;;=4^N30.40
 ;;^UTILITY(U,$J,358.3,1168,2)
 ;;=^5015639
 ;;^UTILITY(U,$J,358.3,1169,0)
 ;;=N30.41^^3^38^36
 ;;^UTILITY(U,$J,358.3,1169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1169,1,3,0)
 ;;=3^Irradiation cystitis with hematuria
 ;;^UTILITY(U,$J,358.3,1169,1,4,0)
 ;;=4^N30.41
 ;;^UTILITY(U,$J,358.3,1169,2)
 ;;=^5015640
 ;;^UTILITY(U,$J,358.3,1170,0)
 ;;=N32.0^^3^38^9
 ;;^UTILITY(U,$J,358.3,1170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1170,1,3,0)
 ;;=3^Bladder-neck obstruction
 ;;^UTILITY(U,$J,358.3,1170,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,1170,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,1171,0)
 ;;=N31.9^^3^38^45
 ;;^UTILITY(U,$J,358.3,1171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1171,1,3,0)
 ;;=3^Neuromuscular dysfunction of bladder, unspecified
