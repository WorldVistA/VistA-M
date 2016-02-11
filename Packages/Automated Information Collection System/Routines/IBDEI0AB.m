IBDEI0AB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4297,0)
 ;;=W18.11XS^^28^264^20
 ;;^UTILITY(U,$J,358.3,4297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4297,1,3,0)
 ;;=3^Fall from Toilet,Sequela
 ;;^UTILITY(U,$J,358.3,4297,1,4,0)
 ;;=4^W18.11XS
 ;;^UTILITY(U,$J,358.3,4297,2)
 ;;=^5059803
 ;;^UTILITY(U,$J,358.3,4298,0)
 ;;=W08.XXXS^^28^264^10
 ;;^UTILITY(U,$J,358.3,4298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4298,1,3,0)
 ;;=3^Fall from Furniture,Sequela
 ;;^UTILITY(U,$J,358.3,4298,1,4,0)
 ;;=4^W08.XXXS
 ;;^UTILITY(U,$J,358.3,4298,2)
 ;;=^5059567
 ;;^UTILITY(U,$J,358.3,4299,0)
 ;;=W18.2XXS^^28^264^21
 ;;^UTILITY(U,$J,358.3,4299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4299,1,3,0)
 ;;=3^Fall in Shower/Bathtub,Sequela
 ;;^UTILITY(U,$J,358.3,4299,1,4,0)
 ;;=4^W18.2XXS
 ;;^UTILITY(U,$J,358.3,4299,2)
 ;;=^5059808
 ;;^UTILITY(U,$J,358.3,4300,0)
 ;;=W11.XXXS^^28^264^12
 ;;^UTILITY(U,$J,358.3,4300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4300,1,3,0)
 ;;=3^Fall from Ladder,Sequela
 ;;^UTILITY(U,$J,358.3,4300,1,4,0)
 ;;=4^W11.XXXS
 ;;^UTILITY(U,$J,358.3,4300,2)
 ;;=^5059597
 ;;^UTILITY(U,$J,358.3,4301,0)
 ;;=W01.10XS^^28^264^2
 ;;^UTILITY(U,$J,358.3,4301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4301,1,3,0)
 ;;=3^Fall Same Level w/ Strike Against Object,Sequela
 ;;^UTILITY(U,$J,358.3,4301,1,4,0)
 ;;=4^W01.10XS
 ;;^UTILITY(U,$J,358.3,4301,2)
 ;;=^5059527
 ;;^UTILITY(U,$J,358.3,4302,0)
 ;;=W01.0XXS^^28^264^3
 ;;^UTILITY(U,$J,358.3,4302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4302,1,3,0)
 ;;=3^Fall Same Level w/o Strike Against Object,Sequela
 ;;^UTILITY(U,$J,358.3,4302,1,4,0)
 ;;=4^W01.0XXS
 ;;^UTILITY(U,$J,358.3,4302,2)
 ;;=^5059524
 ;;^UTILITY(U,$J,358.3,4303,0)
 ;;=W18.30XS^^28^264^22
 ;;^UTILITY(U,$J,358.3,4303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4303,1,3,0)
 ;;=3^Fall on Same Level,Unspec,Sequela
 ;;^UTILITY(U,$J,358.3,4303,1,4,0)
 ;;=4^W18.30XS
 ;;^UTILITY(U,$J,358.3,4303,2)
 ;;=^5059811
 ;;^UTILITY(U,$J,358.3,4304,0)
 ;;=W04.XXXS^^28^264^4
 ;;^UTILITY(U,$J,358.3,4304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4304,1,3,0)
 ;;=3^Fall While Being Carried by Oth Persons,Sequela
 ;;^UTILITY(U,$J,358.3,4304,1,4,0)
 ;;=4^W04.XXXS
 ;;^UTILITY(U,$J,358.3,4304,2)
 ;;=^5059549
 ;;^UTILITY(U,$J,358.3,4305,0)
 ;;=W17.89XS^^28^264^16
 ;;^UTILITY(U,$J,358.3,4305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4305,1,3,0)
 ;;=3^Fall from One Level to Another,Sequela
 ;;^UTILITY(U,$J,358.3,4305,1,4,0)
 ;;=4^W17.89XS
 ;;^UTILITY(U,$J,358.3,4305,2)
 ;;=^5059789
 ;;^UTILITY(U,$J,358.3,4306,0)
 ;;=W03.XXXS^^28^264^1
 ;;^UTILITY(U,$J,358.3,4306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4306,1,3,0)
 ;;=3^Fall Same Level d/t Collision w/ Another Person,Sequela
 ;;^UTILITY(U,$J,358.3,4306,1,4,0)
 ;;=4^W03.XXXS
 ;;^UTILITY(U,$J,358.3,4306,2)
 ;;=^5059546
 ;;^UTILITY(U,$J,358.3,4307,0)
 ;;=W18.00XS^^28^264^6
 ;;^UTILITY(U,$J,358.3,4307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4307,1,3,0)
 ;;=3^Fall d/t Striking Unspec Object,Sequela
 ;;^UTILITY(U,$J,358.3,4307,1,4,0)
 ;;=4^W18.00XS
 ;;^UTILITY(U,$J,358.3,4307,2)
 ;;=^5059792
 ;;^UTILITY(U,$J,358.3,4308,0)
 ;;=W00.9XXS^^28^264^5
 ;;^UTILITY(U,$J,358.3,4308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4308,1,3,0)
 ;;=3^Fall d/t Snow/Ice,Sequela
 ;;^UTILITY(U,$J,358.3,4308,1,4,0)
 ;;=4^W00.9XXS
 ;;^UTILITY(U,$J,358.3,4308,2)
 ;;=^5059521
 ;;^UTILITY(U,$J,358.3,4309,0)
 ;;=W18.40XS^^28^264^23
 ;;^UTILITY(U,$J,358.3,4309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4309,1,3,0)
 ;;=3^Slip/Trip/Stumble w/o Falling,Sequela
 ;;^UTILITY(U,$J,358.3,4309,1,4,0)
 ;;=4^W18.40XS
