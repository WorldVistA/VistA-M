IBDEI192 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21240,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,21241,0)
 ;;=W00.2XXA^^84^948^53
 ;;^UTILITY(U,$J,358.3,21241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21241,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,21241,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,21241,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,21242,0)
 ;;=W00.2XXD^^84^948^54
 ;;^UTILITY(U,$J,358.3,21242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21242,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21242,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,21242,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,21243,0)
 ;;=W00.9XXA^^84^948^25
 ;;^UTILITY(U,$J,358.3,21243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21243,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,21243,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,21243,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,21244,0)
 ;;=W00.9XXD^^84^948^26
 ;;^UTILITY(U,$J,358.3,21244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21244,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21244,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,21244,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,21245,0)
 ;;=W01.0XXA^^84^948^87
 ;;^UTILITY(U,$J,358.3,21245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21245,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,21245,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,21245,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,21246,0)
 ;;=W01.0XXD^^84^948^88
 ;;^UTILITY(U,$J,358.3,21246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21246,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21246,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,21246,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,21247,0)
 ;;=W03.XXXA^^84^948^85
 ;;^UTILITY(U,$J,358.3,21247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21247,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,21247,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,21247,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,21248,0)
 ;;=W03.XXXD^^84^948^86
 ;;^UTILITY(U,$J,358.3,21248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21248,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21248,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,21248,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,21249,0)
 ;;=W05.0XXA^^84^948^51
 ;;^UTILITY(U,$J,358.3,21249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21249,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,21249,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,21249,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,21250,0)
 ;;=W05.0XXD^^84^948^52
 ;;^UTILITY(U,$J,358.3,21250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21250,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21250,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,21250,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,21251,0)
 ;;=W05.1XXA^^84^948^49
 ;;^UTILITY(U,$J,358.3,21251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21251,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,21251,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,21251,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,21252,0)
 ;;=W05.1XXD^^84^948^50
 ;;^UTILITY(U,$J,358.3,21252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21252,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,21252,1,4,0)
 ;;=4^W05.1XXD
