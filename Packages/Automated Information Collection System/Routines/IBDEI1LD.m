IBDEI1LD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26983,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26983,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,26983,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,26984,0)
 ;;=F18.221^^100^1301^15
 ;;^UTILITY(U,$J,358.3,26984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26984,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26984,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,26984,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,26985,0)
 ;;=F18.921^^100^1301^16
 ;;^UTILITY(U,$J,358.3,26985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26985,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26985,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,26985,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,26986,0)
 ;;=F18.129^^100^1301^17
 ;;^UTILITY(U,$J,358.3,26986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26986,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26986,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,26986,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,26987,0)
 ;;=F18.229^^100^1301^18
 ;;^UTILITY(U,$J,358.3,26987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26987,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26987,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,26987,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,26988,0)
 ;;=F18.929^^100^1301^19
 ;;^UTILITY(U,$J,358.3,26988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26988,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26988,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,26988,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,26989,0)
 ;;=F18.180^^100^1301^1
 ;;^UTILITY(U,$J,358.3,26989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26989,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26989,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,26989,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,26990,0)
 ;;=F18.280^^100^1301^2
 ;;^UTILITY(U,$J,358.3,26990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26990,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26990,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,26990,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,26991,0)
 ;;=F18.980^^100^1301^3
 ;;^UTILITY(U,$J,358.3,26991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26991,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26991,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,26991,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,26992,0)
 ;;=F18.94^^100^1301^4
 ;;^UTILITY(U,$J,358.3,26992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26992,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26992,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,26992,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,26993,0)
 ;;=F18.17^^100^1301^5
 ;;^UTILITY(U,$J,358.3,26993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26993,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26993,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,26993,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,26994,0)
 ;;=F18.27^^100^1301^6
 ;;^UTILITY(U,$J,358.3,26994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26994,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26994,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,26994,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,26995,0)
 ;;=F18.97^^100^1301^7
