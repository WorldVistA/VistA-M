IBDEI26T ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37108,1,3,0)
 ;;=3^Inflmtry spndylopthies, thoracic regn, unspec
 ;;^UTILITY(U,$J,358.3,37108,1,4,0)
 ;;=4^M46.94
 ;;^UTILITY(U,$J,358.3,37108,2)
 ;;=^5012034
 ;;^UTILITY(U,$J,358.3,37109,0)
 ;;=M46.95^^140^1787^172
 ;;^UTILITY(U,$J,358.3,37109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37109,1,3,0)
 ;;=3^Inflmtry spndylopthies, thoracolmbr regn, unspec
 ;;^UTILITY(U,$J,358.3,37109,1,4,0)
 ;;=4^M46.95
 ;;^UTILITY(U,$J,358.3,37109,2)
 ;;=^5012035
 ;;^UTILITY(U,$J,358.3,37110,0)
 ;;=M46.96^^140^1787^168
 ;;^UTILITY(U,$J,358.3,37110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37110,1,3,0)
 ;;=3^Inflmtry spndylopthies, lmbr regn, unspec
 ;;^UTILITY(U,$J,358.3,37110,1,4,0)
 ;;=4^M46.96
 ;;^UTILITY(U,$J,358.3,37110,2)
 ;;=^5012036
 ;;^UTILITY(U,$J,358.3,37111,0)
 ;;=M46.97^^140^1787^167
 ;;^UTILITY(U,$J,358.3,37111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37111,1,3,0)
 ;;=3^Inflmtry spndylopthies, lmboscrl regn, unspec
 ;;^UTILITY(U,$J,358.3,37111,1,4,0)
 ;;=4^M46.97
 ;;^UTILITY(U,$J,358.3,37111,2)
 ;;=^5012037
 ;;^UTILITY(U,$J,358.3,37112,0)
 ;;=M46.98^^140^1787^170
 ;;^UTILITY(U,$J,358.3,37112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37112,1,3,0)
 ;;=3^Inflmtry spndylopthies, sacr/sacrocygle regn, unspec
 ;;^UTILITY(U,$J,358.3,37112,1,4,0)
 ;;=4^M46.98
 ;;^UTILITY(U,$J,358.3,37112,2)
 ;;=^5012038
 ;;^UTILITY(U,$J,358.3,37113,0)
 ;;=M47.812^^140^1787^242
 ;;^UTILITY(U,$J,358.3,37113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37113,1,3,0)
 ;;=3^Spndylsis w/o mylopthy or radclpthy, crvcl regn
 ;;^UTILITY(U,$J,358.3,37113,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,37113,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,37114,0)
 ;;=M47.12^^140^1787^238
 ;;^UTILITY(U,$J,358.3,37114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37114,1,3,0)
 ;;=3^Spndylsis w/ mylopthy, crvcl regn, oth
 ;;^UTILITY(U,$J,358.3,37114,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,37114,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,37115,0)
 ;;=M47.814^^140^1787^245
 ;;^UTILITY(U,$J,358.3,37115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37115,1,3,0)
 ;;=3^Spndylsis w/o mylopthy or radclpthy, thor regn
 ;;^UTILITY(U,$J,358.3,37115,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,37115,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,37116,0)
 ;;=M47.817^^140^1787^243
 ;;^UTILITY(U,$J,358.3,37116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37116,1,3,0)
 ;;=3^Spndylsis w/o mylopthy or radclpthy, lumbosacr regn
 ;;^UTILITY(U,$J,358.3,37116,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,37116,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,37117,0)
 ;;=M47.14^^140^1787^240
 ;;^UTILITY(U,$J,358.3,37117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37117,1,3,0)
 ;;=3^Spndylsis w/ mylopthy, thoracic regn, oth
 ;;^UTILITY(U,$J,358.3,37117,1,4,0)
 ;;=4^M47.14
 ;;^UTILITY(U,$J,358.3,37117,2)
 ;;=^5012054
 ;;^UTILITY(U,$J,358.3,37118,0)
 ;;=M47.16^^140^1787^239
 ;;^UTILITY(U,$J,358.3,37118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37118,1,3,0)
 ;;=3^Spndylsis w/ mylopthy, lumbar regn, oth
 ;;^UTILITY(U,$J,358.3,37118,1,4,0)
 ;;=4^M47.16
 ;;^UTILITY(U,$J,358.3,37118,2)
 ;;=^5012056
 ;;^UTILITY(U,$J,358.3,37119,0)
 ;;=M48.20^^140^1787^184
 ;;^UTILITY(U,$J,358.3,37119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37119,1,3,0)
 ;;=3^Kissing spine, site unspec
 ;;^UTILITY(U,$J,358.3,37119,1,4,0)
 ;;=4^M48.20
 ;;^UTILITY(U,$J,358.3,37119,2)
 ;;=^5012106
 ;;^UTILITY(U,$J,358.3,37120,0)
 ;;=M48.21^^140^1787^183
 ;;^UTILITY(U,$J,358.3,37120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37120,1,3,0)
 ;;=3^Kissing spine, occipito-atlanto-axial region
