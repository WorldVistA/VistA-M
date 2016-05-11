IBDEI03L ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1251,1,3,0)
 ;;=3^Right Ear Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1251,1,4,0)
 ;;=4^H93.91
 ;;^UTILITY(U,$J,358.3,1251,2)
 ;;=^5006996
 ;;^UTILITY(U,$J,358.3,1252,0)
 ;;=H81.313^^8^128^1
 ;;^UTILITY(U,$J,358.3,1252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1252,1,3,0)
 ;;=3^Aural vertigo, bilateral
 ;;^UTILITY(U,$J,358.3,1252,1,4,0)
 ;;=4^H81.313
 ;;^UTILITY(U,$J,358.3,1252,2)
 ;;=^5006874
 ;;^UTILITY(U,$J,358.3,1253,0)
 ;;=H81.312^^8^128^2
 ;;^UTILITY(U,$J,358.3,1253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1253,1,3,0)
 ;;=3^Aural vertigo, left ear
 ;;^UTILITY(U,$J,358.3,1253,1,4,0)
 ;;=4^H81.312
 ;;^UTILITY(U,$J,358.3,1253,2)
 ;;=^5006873
 ;;^UTILITY(U,$J,358.3,1254,0)
 ;;=H81.311^^8^128^3
 ;;^UTILITY(U,$J,358.3,1254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1254,1,3,0)
 ;;=3^Aural vertigo, right ear
 ;;^UTILITY(U,$J,358.3,1254,1,4,0)
 ;;=4^H81.311
 ;;^UTILITY(U,$J,358.3,1254,2)
 ;;=^5006872
 ;;^UTILITY(U,$J,358.3,1255,0)
 ;;=H81.13^^8^128^4
 ;;^UTILITY(U,$J,358.3,1255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1255,1,3,0)
 ;;=3^Benign paroxysmal vertigo, bilateral
 ;;^UTILITY(U,$J,358.3,1255,1,4,0)
 ;;=4^H81.13
 ;;^UTILITY(U,$J,358.3,1255,2)
 ;;=^5006867
 ;;^UTILITY(U,$J,358.3,1256,0)
 ;;=H81.12^^8^128^5
 ;;^UTILITY(U,$J,358.3,1256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1256,1,3,0)
 ;;=3^Benign paroxysmal vertigo, left ear
 ;;^UTILITY(U,$J,358.3,1256,1,4,0)
 ;;=4^H81.12
 ;;^UTILITY(U,$J,358.3,1256,2)
 ;;=^5006866
 ;;^UTILITY(U,$J,358.3,1257,0)
 ;;=H81.11^^8^128^6
 ;;^UTILITY(U,$J,358.3,1257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1257,1,3,0)
 ;;=3^Benign paroxysmal vertigo, right ear
 ;;^UTILITY(U,$J,358.3,1257,1,4,0)
 ;;=4^H81.11
 ;;^UTILITY(U,$J,358.3,1257,2)
 ;;=^5006865
 ;;^UTILITY(U,$J,358.3,1258,0)
 ;;=R42.^^8^128^11
 ;;^UTILITY(U,$J,358.3,1258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1258,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,1258,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,1258,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,1259,0)
 ;;=H81.03^^8^128^12
 ;;^UTILITY(U,$J,358.3,1259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1259,1,3,0)
 ;;=3^Meniere's disease, bilateral
 ;;^UTILITY(U,$J,358.3,1259,1,4,0)
 ;;=4^H81.03
 ;;^UTILITY(U,$J,358.3,1259,2)
 ;;=^5006862
 ;;^UTILITY(U,$J,358.3,1260,0)
 ;;=H81.02^^8^128^13
 ;;^UTILITY(U,$J,358.3,1260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1260,1,3,0)
 ;;=3^Meniere's disease, left ear
 ;;^UTILITY(U,$J,358.3,1260,1,4,0)
 ;;=4^H81.02
 ;;^UTILITY(U,$J,358.3,1260,2)
 ;;=^5006861
 ;;^UTILITY(U,$J,358.3,1261,0)
 ;;=H81.01^^8^128^14
 ;;^UTILITY(U,$J,358.3,1261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1261,1,3,0)
 ;;=3^Meniere's disease, right ear
 ;;^UTILITY(U,$J,358.3,1261,1,4,0)
 ;;=4^H81.01
 ;;^UTILITY(U,$J,358.3,1261,2)
 ;;=^5006860
 ;;^UTILITY(U,$J,358.3,1262,0)
 ;;=H81.393^^8^128^15
 ;;^UTILITY(U,$J,358.3,1262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1262,1,3,0)
 ;;=3^Peripheral vertigo, bilateral NEC
 ;;^UTILITY(U,$J,358.3,1262,1,4,0)
 ;;=4^H81.393
 ;;^UTILITY(U,$J,358.3,1262,2)
 ;;=^5006878
 ;;^UTILITY(U,$J,358.3,1263,0)
 ;;=H81.392^^8^128^16
 ;;^UTILITY(U,$J,358.3,1263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1263,1,3,0)
 ;;=3^Peripheral vertigo, left ear NEC
 ;;^UTILITY(U,$J,358.3,1263,1,4,0)
 ;;=4^H81.392
 ;;^UTILITY(U,$J,358.3,1263,2)
 ;;=^5006877
 ;;^UTILITY(U,$J,358.3,1264,0)
 ;;=H81.391^^8^128^17
 ;;^UTILITY(U,$J,358.3,1264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1264,1,3,0)
 ;;=3^Peripheral vertigo, right ear NEC
