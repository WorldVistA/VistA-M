IBDEI08K ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3453,1,3,0)
 ;;=3^Fall from Non-Moving Nonmotorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,3453,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,3453,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,3454,0)
 ;;=W05.0XXA^^28^254^13
 ;;^UTILITY(U,$J,358.3,3454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3454,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,3454,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,3454,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,3455,0)
 ;;=W18.12XA^^28^254^15
 ;;^UTILITY(U,$J,358.3,3455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3455,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,3455,1,4,0)
 ;;=4^W18.12XA
 ;;^UTILITY(U,$J,358.3,3455,2)
 ;;=^5059804
 ;;^UTILITY(U,$J,358.3,3456,0)
 ;;=W18.11XA^^28^254^16
 ;;^UTILITY(U,$J,358.3,3456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3456,1,3,0)
 ;;=3^Fall from Toilet,Init Encntr
 ;;^UTILITY(U,$J,358.3,3456,1,4,0)
 ;;=4^W18.11XA
 ;;^UTILITY(U,$J,358.3,3456,2)
 ;;=^5059801
 ;;^UTILITY(U,$J,358.3,3457,0)
 ;;=W08.XXXA^^28^254^9
 ;;^UTILITY(U,$J,358.3,3457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3457,1,3,0)
 ;;=3^Fall from Furniture,Init Encntr
 ;;^UTILITY(U,$J,358.3,3457,1,4,0)
 ;;=4^W08.XXXA
 ;;^UTILITY(U,$J,358.3,3457,2)
 ;;=^5059565
 ;;^UTILITY(U,$J,358.3,3458,0)
 ;;=W18.2XXA^^28^254^17
 ;;^UTILITY(U,$J,358.3,3458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3458,1,3,0)
 ;;=3^Fall in Shower/Bathtub,Init Encntr
 ;;^UTILITY(U,$J,358.3,3458,1,4,0)
 ;;=4^W18.2XXA
 ;;^UTILITY(U,$J,358.3,3458,2)
 ;;=^5059806
 ;;^UTILITY(U,$J,358.3,3459,0)
 ;;=W11.XXXA^^28^254^10
 ;;^UTILITY(U,$J,358.3,3459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3459,1,3,0)
 ;;=3^Fall from Ladder,Init Encntr
 ;;^UTILITY(U,$J,358.3,3459,1,4,0)
 ;;=4^W11.XXXA
 ;;^UTILITY(U,$J,358.3,3459,2)
 ;;=^5059595
 ;;^UTILITY(U,$J,358.3,3460,0)
 ;;=W01.10XA^^28^254^2
 ;;^UTILITY(U,$J,358.3,3460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3460,1,3,0)
 ;;=3^Fall Same Level w/ Strike Against Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,3460,1,4,0)
 ;;=4^W01.10XA
 ;;^UTILITY(U,$J,358.3,3460,2)
 ;;=^5059525
 ;;^UTILITY(U,$J,358.3,3461,0)
 ;;=W01.0XXA^^28^254^3
 ;;^UTILITY(U,$J,358.3,3461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3461,1,3,0)
 ;;=3^Fall Same Level w/o Strike Against Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,3461,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,3461,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,3462,0)
 ;;=W18.30XA^^28^254^18
 ;;^UTILITY(U,$J,358.3,3462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3462,1,3,0)
 ;;=3^Fall on Same Level,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,3462,1,4,0)
 ;;=4^W18.30XA
 ;;^UTILITY(U,$J,358.3,3462,2)
 ;;=^5059809
 ;;^UTILITY(U,$J,358.3,3463,0)
 ;;=W04.XXXA^^28^254^4
 ;;^UTILITY(U,$J,358.3,3463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3463,1,3,0)
 ;;=3^Fall While Being Carried by Oth Persons,Init Encntr
 ;;^UTILITY(U,$J,358.3,3463,1,4,0)
 ;;=4^W04.XXXA
 ;;^UTILITY(U,$J,358.3,3463,2)
 ;;=^5059547
 ;;^UTILITY(U,$J,358.3,3464,0)
 ;;=Z91.81^^28^254^23
 ;;^UTILITY(U,$J,358.3,3464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3464,1,3,0)
 ;;=3^Hx of Falling
 ;;^UTILITY(U,$J,358.3,3464,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,3464,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,3465,0)
 ;;=W17.89XA^^28^254^14
 ;;^UTILITY(U,$J,358.3,3465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3465,1,3,0)
 ;;=3^Fall from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,3465,1,4,0)
 ;;=4^W17.89XA
 ;;^UTILITY(U,$J,358.3,3465,2)
 ;;=^5059787
 ;;^UTILITY(U,$J,358.3,3466,0)
 ;;=W03.XXXA^^28^254^1
