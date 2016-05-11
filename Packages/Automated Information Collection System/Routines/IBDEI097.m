IBDEI097 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4020,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Subsequent
 ;;^UTILITY(U,$J,358.3,4020,1,4,0)
 ;;=4^W05.2XXD
 ;;^UTILITY(U,$J,358.3,4020,2)
 ;;=^5059557
 ;;^UTILITY(U,$J,358.3,4021,0)
 ;;=W05.1XXD^^18^226^16
 ;;^UTILITY(U,$J,358.3,4021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4021,1,3,0)
 ;;=3^Fall from Non-Moving Nonmotorized Scooter,Subsequent
 ;;^UTILITY(U,$J,358.3,4021,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,4021,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,4022,0)
 ;;=W05.0XXD^^18^226^17
 ;;^UTILITY(U,$J,358.3,4022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4022,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subsequent
 ;;^UTILITY(U,$J,358.3,4022,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,4022,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,4023,0)
 ;;=W18.12XD^^18^226^21
 ;;^UTILITY(U,$J,358.3,4023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4023,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Object,Subsequent
 ;;^UTILITY(U,$J,358.3,4023,1,4,0)
 ;;=4^W18.12XD
 ;;^UTILITY(U,$J,358.3,4023,2)
 ;;=^5137984
 ;;^UTILITY(U,$J,358.3,4024,0)
 ;;=W18.11XD^^18^226^22
 ;;^UTILITY(U,$J,358.3,4024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4024,1,3,0)
 ;;=3^Fall from Toilet,Subsequent
 ;;^UTILITY(U,$J,358.3,4024,1,4,0)
 ;;=4^W18.11XD
 ;;^UTILITY(U,$J,358.3,4024,2)
 ;;=^5059802
 ;;^UTILITY(U,$J,358.3,4025,0)
 ;;=W08.XXXD^^18^226^12
 ;;^UTILITY(U,$J,358.3,4025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4025,1,3,0)
 ;;=3^Fall from Furniture,Subsequent
 ;;^UTILITY(U,$J,358.3,4025,1,4,0)
 ;;=4^W08.XXXD
 ;;^UTILITY(U,$J,358.3,4025,2)
 ;;=^5059566
 ;;^UTILITY(U,$J,358.3,4026,0)
 ;;=W18.2XXD^^18^226^23
 ;;^UTILITY(U,$J,358.3,4026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4026,1,3,0)
 ;;=3^Fall in Shower/Bathtub,Subsequent
 ;;^UTILITY(U,$J,358.3,4026,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,4026,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,4027,0)
 ;;=W11.XXXD^^18^226^14
 ;;^UTILITY(U,$J,358.3,4027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4027,1,3,0)
 ;;=3^Fall from Ladder,Subsequent
 ;;^UTILITY(U,$J,358.3,4027,1,4,0)
 ;;=4^W11.XXXD
 ;;^UTILITY(U,$J,358.3,4027,2)
 ;;=^5059596
 ;;^UTILITY(U,$J,358.3,4028,0)
 ;;=W01.10XD^^18^226^2
 ;;^UTILITY(U,$J,358.3,4028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4028,1,3,0)
 ;;=3^Fall Same Level w/ Strike Against Object,Subsequent
 ;;^UTILITY(U,$J,358.3,4028,1,4,0)
 ;;=4^W01.10XD
 ;;^UTILITY(U,$J,358.3,4028,2)
 ;;=^5059526
 ;;^UTILITY(U,$J,358.3,4029,0)
 ;;=W01.0XXD^^18^226^3
 ;;^UTILITY(U,$J,358.3,4029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4029,1,3,0)
 ;;=3^Fall Same Level w/o Strike Against Object,Subsequent
 ;;^UTILITY(U,$J,358.3,4029,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,4029,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,4030,0)
 ;;=W18.30XD^^18^226^4
 ;;^UTILITY(U,$J,358.3,4030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4030,1,3,0)
 ;;=3^Fall Same Level,Unspec,Subsequent
 ;;^UTILITY(U,$J,358.3,4030,1,4,0)
 ;;=4^W18.30XD
 ;;^UTILITY(U,$J,358.3,4030,2)
 ;;=^5059810
 ;;^UTILITY(U,$J,358.3,4031,0)
 ;;=W04.XXXD^^18^226^6
 ;;^UTILITY(U,$J,358.3,4031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4031,1,3,0)
 ;;=3^Fall While Being Carried by Oth Persons,Subsequent
 ;;^UTILITY(U,$J,358.3,4031,1,4,0)
 ;;=4^W04.XXXD
 ;;^UTILITY(U,$J,358.3,4031,2)
 ;;=^5059548
 ;;^UTILITY(U,$J,358.3,4032,0)
 ;;=W17.89XD^^18^226^18
 ;;^UTILITY(U,$J,358.3,4032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4032,1,3,0)
 ;;=3^Fall from One Level to Another,Subsequent
 ;;^UTILITY(U,$J,358.3,4032,1,4,0)
 ;;=4^W17.89XD
