IBDEI1SH ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28577,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,28577,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,28577,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,28578,0)
 ;;=F16.221^^115^1408^11
 ;;^UTILITY(U,$J,358.3,28578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28578,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,28578,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,28578,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,28579,0)
 ;;=F16.921^^115^1408^12
 ;;^UTILITY(U,$J,358.3,28579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28579,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,28579,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,28579,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,28580,0)
 ;;=F16.129^^115^1408^13
 ;;^UTILITY(U,$J,358.3,28580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28580,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,28580,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,28580,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,28581,0)
 ;;=F16.229^^115^1408^14
 ;;^UTILITY(U,$J,358.3,28581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28581,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,28581,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,28581,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,28582,0)
 ;;=F16.929^^115^1408^15
 ;;^UTILITY(U,$J,358.3,28582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28582,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use D/O
 ;;^UTILITY(U,$J,358.3,28582,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,28582,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,28583,0)
 ;;=F16.180^^115^1408^1
 ;;^UTILITY(U,$J,358.3,28583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28583,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,28583,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,28583,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,28584,0)
 ;;=F16.280^^115^1408^2
 ;;^UTILITY(U,$J,358.3,28584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28584,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,28584,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,28584,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,28585,0)
 ;;=F16.980^^115^1408^3
 ;;^UTILITY(U,$J,358.3,28585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28585,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,28585,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,28585,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,28586,0)
 ;;=F16.14^^115^1408^4
 ;;^UTILITY(U,$J,358.3,28586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28586,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,28586,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,28586,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,28587,0)
 ;;=F16.24^^115^1408^5
 ;;^UTILITY(U,$J,358.3,28587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28587,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,28587,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,28587,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,28588,0)
 ;;=F16.94^^115^1408^6
 ;;^UTILITY(U,$J,358.3,28588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28588,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,28588,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,28588,2)
 ;;=^5003353
