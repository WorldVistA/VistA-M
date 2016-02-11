IBDEI0AD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4322,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,4323,0)
 ;;=W11.XXXD^^28^265^14
 ;;^UTILITY(U,$J,358.3,4323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4323,1,3,0)
 ;;=3^Fall from Ladder,Subsequent
 ;;^UTILITY(U,$J,358.3,4323,1,4,0)
 ;;=4^W11.XXXD
 ;;^UTILITY(U,$J,358.3,4323,2)
 ;;=^5059596
 ;;^UTILITY(U,$J,358.3,4324,0)
 ;;=W01.10XD^^28^265^2
 ;;^UTILITY(U,$J,358.3,4324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4324,1,3,0)
 ;;=3^Fall Same Level w/ Strike Against Object,Subsequent
 ;;^UTILITY(U,$J,358.3,4324,1,4,0)
 ;;=4^W01.10XD
 ;;^UTILITY(U,$J,358.3,4324,2)
 ;;=^5059526
 ;;^UTILITY(U,$J,358.3,4325,0)
 ;;=W01.0XXD^^28^265^3
 ;;^UTILITY(U,$J,358.3,4325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4325,1,3,0)
 ;;=3^Fall Same Level w/o Strike Against Object,Subsequent
 ;;^UTILITY(U,$J,358.3,4325,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,4325,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,4326,0)
 ;;=W18.30XD^^28^265^4
 ;;^UTILITY(U,$J,358.3,4326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4326,1,3,0)
 ;;=3^Fall Same Level,Unspec,Subsequent
 ;;^UTILITY(U,$J,358.3,4326,1,4,0)
 ;;=4^W18.30XD
 ;;^UTILITY(U,$J,358.3,4326,2)
 ;;=^5059810
 ;;^UTILITY(U,$J,358.3,4327,0)
 ;;=W04.XXXD^^28^265^6
 ;;^UTILITY(U,$J,358.3,4327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4327,1,3,0)
 ;;=3^Fall While Being Carried by Oth Persons,Subsequent
 ;;^UTILITY(U,$J,358.3,4327,1,4,0)
 ;;=4^W04.XXXD
 ;;^UTILITY(U,$J,358.3,4327,2)
 ;;=^5059548
 ;;^UTILITY(U,$J,358.3,4328,0)
 ;;=W17.89XD^^28^265^18
 ;;^UTILITY(U,$J,358.3,4328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4328,1,3,0)
 ;;=3^Fall from One Level to Another,Subsequent
 ;;^UTILITY(U,$J,358.3,4328,1,4,0)
 ;;=4^W17.89XD
 ;;^UTILITY(U,$J,358.3,4328,2)
 ;;=^5059788
 ;;^UTILITY(U,$J,358.3,4329,0)
 ;;=W03.XXXD^^28^265^1
 ;;^UTILITY(U,$J,358.3,4329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4329,1,3,0)
 ;;=3^Fall Same Level d/t Collision w/ Another Person,Subsequent
 ;;^UTILITY(U,$J,358.3,4329,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,4329,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,4330,0)
 ;;=W18.00XD^^28^265^8
 ;;^UTILITY(U,$J,358.3,4330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4330,1,3,0)
 ;;=3^Fall d/t Striking Unspec Object,Subsequent
 ;;^UTILITY(U,$J,358.3,4330,1,4,0)
 ;;=4^W18.00XD
 ;;^UTILITY(U,$J,358.3,4330,2)
 ;;=^5059791
 ;;^UTILITY(U,$J,358.3,4331,0)
 ;;=W00.9XXD^^28^265^7
 ;;^UTILITY(U,$J,358.3,4331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4331,1,3,0)
 ;;=3^Fall d/t Snow/Ice,Subsequent
 ;;^UTILITY(U,$J,358.3,4331,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,4331,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,4332,0)
 ;;=W19.XXXD^^28^265^5
 ;;^UTILITY(U,$J,358.3,4332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4332,1,3,0)
 ;;=3^Fall Unspec,Subsequent
 ;;^UTILITY(U,$J,358.3,4332,1,4,0)
 ;;=4^W19.XXXD
 ;;^UTILITY(U,$J,358.3,4332,2)
 ;;=^5059834
 ;;^UTILITY(U,$J,358.3,4333,0)
 ;;=W18.40XD^^28^265^24
 ;;^UTILITY(U,$J,358.3,4333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4333,1,3,0)
 ;;=3^Slip/Trip/Stumble w/o Falling,Subsequent
 ;;^UTILITY(U,$J,358.3,4333,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,4333,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,4334,0)
 ;;=R27.0^^28^266^2
 ;;^UTILITY(U,$J,358.3,4334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4334,1,3,0)
 ;;=3^Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,4334,1,4,0)
 ;;=4^R27.0
 ;;^UTILITY(U,$J,358.3,4334,2)
 ;;=^5019310
 ;;^UTILITY(U,$J,358.3,4335,0)
 ;;=Z74.1^^28^266^1
 ;;^UTILITY(U,$J,358.3,4335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4335,1,3,0)
 ;;=3^Assistance Needed for Personal Care
