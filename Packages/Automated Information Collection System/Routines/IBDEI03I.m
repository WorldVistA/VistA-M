IBDEI03I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1211,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, subsequent encounter
 ;;^UTILITY(U,$J,358.3,1211,1,4,0)
 ;;=4^S04.62XD
 ;;^UTILITY(U,$J,358.3,1211,2)
 ;;=^5020544
 ;;^UTILITY(U,$J,358.3,1212,0)
 ;;=S04.62XS^^8^126^2
 ;;^UTILITY(U,$J,358.3,1212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1212,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, sequela
 ;;^UTILITY(U,$J,358.3,1212,1,4,0)
 ;;=4^S04.62XS
 ;;^UTILITY(U,$J,358.3,1212,2)
 ;;=^5020545
 ;;^UTILITY(U,$J,358.3,1213,0)
 ;;=S04.9XXA^^8^126^7
 ;;^UTILITY(U,$J,358.3,1213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1213,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, initial encounter
 ;;^UTILITY(U,$J,358.3,1213,1,4,0)
 ;;=4^S04.9XXA
 ;;^UTILITY(U,$J,358.3,1213,2)
 ;;=^5020573
 ;;^UTILITY(U,$J,358.3,1214,0)
 ;;=S04.9XXD^^8^126^9
 ;;^UTILITY(U,$J,358.3,1214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1214,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, subsequent encounter
 ;;^UTILITY(U,$J,358.3,1214,1,4,0)
 ;;=4^S04.9XXD
 ;;^UTILITY(U,$J,358.3,1214,2)
 ;;=^5020574
 ;;^UTILITY(U,$J,358.3,1215,0)
 ;;=S04.9XXS^^8^126^8
 ;;^UTILITY(U,$J,358.3,1215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1215,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, sequela
 ;;^UTILITY(U,$J,358.3,1215,1,4,0)
 ;;=4^S04.9XXS
 ;;^UTILITY(U,$J,358.3,1215,2)
 ;;=^5020575
 ;;^UTILITY(U,$J,358.3,1216,0)
 ;;=H93.213^^8^127^5
 ;;^UTILITY(U,$J,358.3,1216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1216,1,3,0)
 ;;=3^Auditory recruitment, bilateral
 ;;^UTILITY(U,$J,358.3,1216,1,4,0)
 ;;=4^H93.213
 ;;^UTILITY(U,$J,358.3,1216,2)
 ;;=^5006970
 ;;^UTILITY(U,$J,358.3,1217,0)
 ;;=H93.212^^8^127^6
 ;;^UTILITY(U,$J,358.3,1217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1217,1,3,0)
 ;;=3^Auditory recruitment, left ear
 ;;^UTILITY(U,$J,358.3,1217,1,4,0)
 ;;=4^H93.212
 ;;^UTILITY(U,$J,358.3,1217,2)
 ;;=^5006969
 ;;^UTILITY(U,$J,358.3,1218,0)
 ;;=H93.211^^8^127^7
 ;;^UTILITY(U,$J,358.3,1218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1218,1,3,0)
 ;;=3^Auditory recruitment, right ear
 ;;^UTILITY(U,$J,358.3,1218,1,4,0)
 ;;=4^H93.211
 ;;^UTILITY(U,$J,358.3,1218,2)
 ;;=^5006968
 ;;^UTILITY(U,$J,358.3,1219,0)
 ;;=H93.25^^8^127^8
 ;;^UTILITY(U,$J,358.3,1219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1219,1,3,0)
 ;;=3^Central auditory processing disorder
 ;;^UTILITY(U,$J,358.3,1219,1,4,0)
 ;;=4^H93.25
 ;;^UTILITY(U,$J,358.3,1219,2)
 ;;=^5006984
 ;;^UTILITY(U,$J,358.3,1220,0)
 ;;=H93.223^^8^127^9
 ;;^UTILITY(U,$J,358.3,1220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1220,1,3,0)
 ;;=3^Diplacusis, bilateral
 ;;^UTILITY(U,$J,358.3,1220,1,4,0)
 ;;=4^H93.223
 ;;^UTILITY(U,$J,358.3,1220,2)
 ;;=^5006974
 ;;^UTILITY(U,$J,358.3,1221,0)
 ;;=H93.222^^8^127^10
 ;;^UTILITY(U,$J,358.3,1221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1221,1,3,0)
 ;;=3^Diplacusis, left ear
 ;;^UTILITY(U,$J,358.3,1221,1,4,0)
 ;;=4^H93.222
 ;;^UTILITY(U,$J,358.3,1221,2)
 ;;=^5006973
 ;;^UTILITY(U,$J,358.3,1222,0)
 ;;=H93.221^^8^127^11
 ;;^UTILITY(U,$J,358.3,1222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1222,1,3,0)
 ;;=3^Diplacusis, right ear
 ;;^UTILITY(U,$J,358.3,1222,1,4,0)
 ;;=4^H93.221
 ;;^UTILITY(U,$J,358.3,1222,2)
 ;;=^5006972
 ;;^UTILITY(U,$J,358.3,1223,0)
 ;;=R42.^^8^127^12
 ;;^UTILITY(U,$J,358.3,1223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1223,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,1223,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,1223,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,1224,0)
 ;;=Z45.49^^8^127^4
 ;;^UTILITY(U,$J,358.3,1224,1,0)
 ;;=^358.31IA^4^2
