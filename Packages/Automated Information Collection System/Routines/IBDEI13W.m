IBDEI13W ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17773,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,17773,1,4,0)
 ;;=4^W00.0XXA
 ;;^UTILITY(U,$J,358.3,17773,2)
 ;;=^5059510
 ;;^UTILITY(U,$J,358.3,17774,0)
 ;;=W00.0XXD^^88^898^85
 ;;^UTILITY(U,$J,358.3,17774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17774,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17774,1,4,0)
 ;;=4^W00.0XXD
 ;;^UTILITY(U,$J,358.3,17774,2)
 ;;=^5059511
 ;;^UTILITY(U,$J,358.3,17775,0)
 ;;=W00.1XXA^^88^898^64
 ;;^UTILITY(U,$J,358.3,17775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17775,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,17775,1,4,0)
 ;;=4^W00.1XXA
 ;;^UTILITY(U,$J,358.3,17775,2)
 ;;=^5059513
 ;;^UTILITY(U,$J,358.3,17776,0)
 ;;=W00.1XXD^^88^898^65
 ;;^UTILITY(U,$J,358.3,17776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17776,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17776,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,17776,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,17777,0)
 ;;=W00.2XXA^^88^898^58
 ;;^UTILITY(U,$J,358.3,17777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17777,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,17777,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,17777,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,17778,0)
 ;;=W00.2XXD^^88^898^59
 ;;^UTILITY(U,$J,358.3,17778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17778,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17778,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,17778,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,17779,0)
 ;;=W00.9XXA^^88^898^30
 ;;^UTILITY(U,$J,358.3,17779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17779,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,17779,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,17779,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,17780,0)
 ;;=W00.9XXD^^88^898^31
 ;;^UTILITY(U,$J,358.3,17780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17780,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17780,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,17780,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,17781,0)
 ;;=W01.0XXA^^88^898^92
 ;;^UTILITY(U,$J,358.3,17781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17781,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,17781,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,17781,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,17782,0)
 ;;=W01.0XXD^^88^898^93
 ;;^UTILITY(U,$J,358.3,17782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17782,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17782,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,17782,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,17783,0)
 ;;=W03.XXXA^^88^898^90
 ;;^UTILITY(U,$J,358.3,17783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17783,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,17783,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,17783,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,17784,0)
 ;;=W03.XXXD^^88^898^91
 ;;^UTILITY(U,$J,358.3,17784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17784,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
