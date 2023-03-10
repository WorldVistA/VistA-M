IBDEI0OH ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11001,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,11001,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,11001,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,11002,0)
 ;;=F18.921^^42^498^20
 ;;^UTILITY(U,$J,358.3,11002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11002,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,11002,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,11002,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,11003,0)
 ;;=F18.129^^42^498^21
 ;;^UTILITY(U,$J,358.3,11003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11003,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,11003,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,11003,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,11004,0)
 ;;=F18.229^^42^498^22
 ;;^UTILITY(U,$J,358.3,11004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11004,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,11004,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,11004,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,11005,0)
 ;;=F18.929^^42^498^23
 ;;^UTILITY(U,$J,358.3,11005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11005,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,11005,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,11005,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,11006,0)
 ;;=F18.180^^42^498^3
 ;;^UTILITY(U,$J,358.3,11006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11006,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,11006,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,11006,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,11007,0)
 ;;=F18.280^^42^498^4
 ;;^UTILITY(U,$J,358.3,11007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11007,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,11007,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,11007,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,11008,0)
 ;;=F18.980^^42^498^5
 ;;^UTILITY(U,$J,358.3,11008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11008,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,11008,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,11008,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,11009,0)
 ;;=F18.94^^42^498^8
 ;;^UTILITY(U,$J,358.3,11009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11009,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,11009,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,11009,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,11010,0)
 ;;=F18.17^^42^498^9
 ;;^UTILITY(U,$J,358.3,11010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11010,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,11010,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,11010,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,11011,0)
 ;;=F18.27^^42^498^10
 ;;^UTILITY(U,$J,358.3,11011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11011,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,11011,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,11011,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,11012,0)
 ;;=F18.97^^42^498^11
 ;;^UTILITY(U,$J,358.3,11012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11012,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,11012,1,4,0)
 ;;=4^F18.97
