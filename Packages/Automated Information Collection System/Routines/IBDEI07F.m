IBDEI07F ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3164,1,3,0)
 ;;=3^Fall Same Level w/ Strike Against Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,3164,1,4,0)
 ;;=4^W01.10XA
 ;;^UTILITY(U,$J,358.3,3164,2)
 ;;=^5059525
 ;;^UTILITY(U,$J,358.3,3165,0)
 ;;=W01.0XXA^^18^215^3
 ;;^UTILITY(U,$J,358.3,3165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3165,1,3,0)
 ;;=3^Fall Same Level w/o Strike Against Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,3165,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,3165,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,3166,0)
 ;;=W18.30XA^^18^215^18
 ;;^UTILITY(U,$J,358.3,3166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3166,1,3,0)
 ;;=3^Fall on Same Level,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,3166,1,4,0)
 ;;=4^W18.30XA
 ;;^UTILITY(U,$J,358.3,3166,2)
 ;;=^5059809
 ;;^UTILITY(U,$J,358.3,3167,0)
 ;;=W04.XXXA^^18^215^4
 ;;^UTILITY(U,$J,358.3,3167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3167,1,3,0)
 ;;=3^Fall While Being Carried by Oth Persons,Init Encntr
 ;;^UTILITY(U,$J,358.3,3167,1,4,0)
 ;;=4^W04.XXXA
 ;;^UTILITY(U,$J,358.3,3167,2)
 ;;=^5059547
 ;;^UTILITY(U,$J,358.3,3168,0)
 ;;=Z91.81^^18^215^23
 ;;^UTILITY(U,$J,358.3,3168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3168,1,3,0)
 ;;=3^Hx of Falling
 ;;^UTILITY(U,$J,358.3,3168,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,3168,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,3169,0)
 ;;=W17.89XA^^18^215^14
 ;;^UTILITY(U,$J,358.3,3169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3169,1,3,0)
 ;;=3^Fall from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,3169,1,4,0)
 ;;=4^W17.89XA
 ;;^UTILITY(U,$J,358.3,3169,2)
 ;;=^5059787
 ;;^UTILITY(U,$J,358.3,3170,0)
 ;;=W03.XXXA^^18^215^1
 ;;^UTILITY(U,$J,358.3,3170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3170,1,3,0)
 ;;=3^Fall Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,3170,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,3170,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,3171,0)
 ;;=W18.09XA^^18^215^6
 ;;^UTILITY(U,$J,358.3,3171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3171,1,3,0)
 ;;=3^Fall d/t Striking Against Other Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,3171,1,4,0)
 ;;=4^W18.09XA
 ;;^UTILITY(U,$J,358.3,3171,2)
 ;;=^5059799
 ;;^UTILITY(U,$J,358.3,3172,0)
 ;;=W00.9XXA^^18^215^5
 ;;^UTILITY(U,$J,358.3,3172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3172,1,3,0)
 ;;=3^Fall d/t Snow/Ice,Init Encntr
 ;;^UTILITY(U,$J,358.3,3172,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,3172,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,3173,0)
 ;;=R29.6^^18^215^24
 ;;^UTILITY(U,$J,358.3,3173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3173,1,3,0)
 ;;=3^Repeated Falls
 ;;^UTILITY(U,$J,358.3,3173,1,4,0)
 ;;=4^R29.6
 ;;^UTILITY(U,$J,358.3,3173,2)
 ;;=^5019317
 ;;^UTILITY(U,$J,358.3,3174,0)
 ;;=W18.40XA^^18^215^25
 ;;^UTILITY(U,$J,358.3,3174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3174,1,3,0)
 ;;=3^Slip/Trip/Stumble w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,3174,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,3174,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,3175,0)
 ;;=Z90.710^^18^216^2
 ;;^UTILITY(U,$J,358.3,3175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3175,1,3,0)
 ;;=3^Acquired Absence of Cervix & Uterus
 ;;^UTILITY(U,$J,358.3,3175,1,4,0)
 ;;=4^Z90.710
 ;;^UTILITY(U,$J,358.3,3175,2)
 ;;=^5063591
 ;;^UTILITY(U,$J,358.3,3176,0)
 ;;=Z90.712^^18^216^3
 ;;^UTILITY(U,$J,358.3,3176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3176,1,3,0)
 ;;=3^Acquired Absence of Cervix w/ Remaining Uterus
 ;;^UTILITY(U,$J,358.3,3176,1,4,0)
 ;;=4^Z90.712
 ;;^UTILITY(U,$J,358.3,3176,2)
 ;;=^5063593
 ;;^UTILITY(U,$J,358.3,3177,0)
 ;;=Z90.711^^18^216^4
