IBDEI08L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3466,1,3,0)
 ;;=3^Fall Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,3466,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,3466,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,3467,0)
 ;;=W18.09XA^^28^254^6
 ;;^UTILITY(U,$J,358.3,3467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3467,1,3,0)
 ;;=3^Fall d/t Striking Against Other Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,3467,1,4,0)
 ;;=4^W18.09XA
 ;;^UTILITY(U,$J,358.3,3467,2)
 ;;=^5059799
 ;;^UTILITY(U,$J,358.3,3468,0)
 ;;=W00.9XXA^^28^254^5
 ;;^UTILITY(U,$J,358.3,3468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3468,1,3,0)
 ;;=3^Fall d/t Snow/Ice,Init Encntr
 ;;^UTILITY(U,$J,358.3,3468,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,3468,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,3469,0)
 ;;=R29.6^^28^254^24
 ;;^UTILITY(U,$J,358.3,3469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3469,1,3,0)
 ;;=3^Repeated Falls
 ;;^UTILITY(U,$J,358.3,3469,1,4,0)
 ;;=4^R29.6
 ;;^UTILITY(U,$J,358.3,3469,2)
 ;;=^5019317
 ;;^UTILITY(U,$J,358.3,3470,0)
 ;;=W18.40XA^^28^254^25
 ;;^UTILITY(U,$J,358.3,3470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3470,1,3,0)
 ;;=3^Slip/Trip/Stumble w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,3470,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,3470,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,3471,0)
 ;;=Z90.710^^28^255^2
 ;;^UTILITY(U,$J,358.3,3471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3471,1,3,0)
 ;;=3^Acquired Absence of Cervix & Uterus
 ;;^UTILITY(U,$J,358.3,3471,1,4,0)
 ;;=4^Z90.710
 ;;^UTILITY(U,$J,358.3,3471,2)
 ;;=^5063591
 ;;^UTILITY(U,$J,358.3,3472,0)
 ;;=Z90.712^^28^255^3
 ;;^UTILITY(U,$J,358.3,3472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3472,1,3,0)
 ;;=3^Acquired Absence of Cervix w/ Remaining Uterus
 ;;^UTILITY(U,$J,358.3,3472,1,4,0)
 ;;=4^Z90.712
 ;;^UTILITY(U,$J,358.3,3472,2)
 ;;=^5063593
 ;;^UTILITY(U,$J,358.3,3473,0)
 ;;=Z90.711^^28^255^4
 ;;^UTILITY(U,$J,358.3,3473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3473,1,3,0)
 ;;=3^Acquired Absence of Uterus w/ Remaining Cervical Stump
 ;;^UTILITY(U,$J,358.3,3473,1,4,0)
 ;;=4^Z90.711
 ;;^UTILITY(U,$J,358.3,3473,2)
 ;;=^5063592
 ;;^UTILITY(U,$J,358.3,3474,0)
 ;;=R34.^^28^255^5
 ;;^UTILITY(U,$J,358.3,3474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3474,1,3,0)
 ;;=3^Anuria & Oliguria
 ;;^UTILITY(U,$J,358.3,3474,1,4,0)
 ;;=4^R34.
 ;;^UTILITY(U,$J,358.3,3474,2)
 ;;=^5019333
 ;;^UTILITY(U,$J,358.3,3475,0)
 ;;=Z93.50^^28^255^6
 ;;^UTILITY(U,$J,358.3,3475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3475,1,3,0)
 ;;=3^Artificial Opening,Cystostomy,Unspec
 ;;^UTILITY(U,$J,358.3,3475,1,4,0)
 ;;=4^Z93.50
 ;;^UTILITY(U,$J,358.3,3475,2)
 ;;=^5063647
 ;;^UTILITY(U,$J,358.3,3476,0)
 ;;=Z93.6^^28^255^7
 ;;^UTILITY(U,$J,358.3,3476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3476,1,3,0)
 ;;=3^Artificial Opening,Urinary Tract,Other
 ;;^UTILITY(U,$J,358.3,3476,1,4,0)
 ;;=4^Z93.6
 ;;^UTILITY(U,$J,358.3,3476,2)
 ;;=^5063651
 ;;^UTILITY(U,$J,358.3,3477,0)
 ;;=N32.9^^28^255^8
 ;;^UTILITY(U,$J,358.3,3477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3477,1,3,0)
 ;;=3^Baldder Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3477,1,4,0)
 ;;=4^N32.9
 ;;^UTILITY(U,$J,358.3,3477,2)
 ;;=^5015653
 ;;^UTILITY(U,$J,358.3,3478,0)
 ;;=R39.14^^28^255^10
 ;;^UTILITY(U,$J,358.3,3478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3478,1,3,0)
 ;;=3^Bladder Emptying,Imcomplete Feeling
 ;;^UTILITY(U,$J,358.3,3478,1,4,0)
 ;;=4^R39.14
 ;;^UTILITY(U,$J,358.3,3478,2)
 ;;=^5019344
 ;;^UTILITY(U,$J,358.3,3479,0)
 ;;=N31.9^^28^255^11
