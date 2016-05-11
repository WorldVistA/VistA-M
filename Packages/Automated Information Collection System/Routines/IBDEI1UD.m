IBDEI1UD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31271,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,31272,0)
 ;;=99024^^124^1576^1
 ;;^UTILITY(U,$J,358.3,31272,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,31272,1,1,0)
 ;;=1^Post Op F/u in Global Per
 ;;^UTILITY(U,$J,358.3,31272,1,2,0)
 ;;=2^99024
 ;;^UTILITY(U,$J,358.3,31273,0)
 ;;=99241^^124^1577^1
 ;;^UTILITY(U,$J,358.3,31273,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,31273,1,1,0)
 ;;=1^Problems Focus
 ;;^UTILITY(U,$J,358.3,31273,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,31274,0)
 ;;=99242^^124^1577^2
 ;;^UTILITY(U,$J,358.3,31274,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,31274,1,1,0)
 ;;=1^Expand Prob Focus
 ;;^UTILITY(U,$J,358.3,31274,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,31275,0)
 ;;=99243^^124^1577^3
 ;;^UTILITY(U,$J,358.3,31275,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,31275,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,31275,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,31276,0)
 ;;=99244^^124^1577^4
 ;;^UTILITY(U,$J,358.3,31276,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,31276,1,1,0)
 ;;=1^Comprehensive,Mod Complex
 ;;^UTILITY(U,$J,358.3,31276,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,31277,0)
 ;;=99245^^124^1577^5
 ;;^UTILITY(U,$J,358.3,31277,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,31277,1,1,0)
 ;;=1^Comprehensive,High Complex
 ;;^UTILITY(U,$J,358.3,31277,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,31278,0)
 ;;=10060^^125^1578^1
 ;;^UTILITY(U,$J,358.3,31278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31278,1,2,0)
 ;;=2^Incision and Drainage of abscess, simple or single
 ;;^UTILITY(U,$J,358.3,31278,1,3,0)
 ;;=3^10060
 ;;^UTILITY(U,$J,358.3,31279,0)
 ;;=10061^^125^1578^2
 ;;^UTILITY(U,$J,358.3,31279,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31279,1,2,0)
 ;;=2^Incision and Drainage of abscess; complicated or multiple
 ;;^UTILITY(U,$J,358.3,31279,1,3,0)
 ;;=3^10061
 ;;^UTILITY(U,$J,358.3,31280,0)
 ;;=10120^^125^1578^3
 ;;^UTILITY(U,$J,358.3,31280,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31280,1,2,0)
 ;;=2^Incision & Removal FB,Subq Tissue;Simple
 ;;^UTILITY(U,$J,358.3,31280,1,3,0)
 ;;=3^10120
 ;;^UTILITY(U,$J,358.3,31281,0)
 ;;=10121^^125^1578^4
 ;;^UTILITY(U,$J,358.3,31281,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31281,1,2,0)
 ;;=2^Incision & Removal FB,Subq Tissue;Complicated
 ;;^UTILITY(U,$J,358.3,31281,1,3,0)
 ;;=3^10121
 ;;^UTILITY(U,$J,358.3,31282,0)
 ;;=10140^^125^1578^5
 ;;^UTILITY(U,$J,358.3,31282,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31282,1,2,0)
 ;;=2^Incision and Drainage of hematoma, seroma or fluid collection
 ;;^UTILITY(U,$J,358.3,31282,1,3,0)
 ;;=3^10140
 ;;^UTILITY(U,$J,358.3,31283,0)
 ;;=10160^^125^1578^6
 ;;^UTILITY(U,$J,358.3,31283,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31283,1,2,0)
 ;;=2^Puncture aspiration of abscess, hemtoma, bulla, or cyst
 ;;^UTILITY(U,$J,358.3,31283,1,3,0)
 ;;=3^10160
 ;;^UTILITY(U,$J,358.3,31284,0)
 ;;=10180^^125^1578^7
 ;;^UTILITY(U,$J,358.3,31284,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31284,1,2,0)
 ;;=2^Incision and Drainage, complex, postoperative wound infection
 ;;^UTILITY(U,$J,358.3,31284,1,3,0)
 ;;=3^10180
 ;;^UTILITY(U,$J,358.3,31285,0)
 ;;=11000^^125^1579^4
 ;;^UTILITY(U,$J,358.3,31285,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31285,1,2,0)
 ;;=2^Debr of extensive eczematous 10%
 ;;^UTILITY(U,$J,358.3,31285,1,3,0)
 ;;=3^11000
 ;;^UTILITY(U,$J,358.3,31286,0)
 ;;=11010^^125^1579^2
 ;;^UTILITY(U,$J,358.3,31286,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31286,1,2,0)
 ;;=2^Debr Rmvl Foreign Material;Skin,Subq Tissue
 ;;^UTILITY(U,$J,358.3,31286,1,3,0)
 ;;=3^11010
