IBDEI1H4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25019,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,25019,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,25020,0)
 ;;=F18.121^^93^1126^14
 ;;^UTILITY(U,$J,358.3,25020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25020,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25020,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,25020,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,25021,0)
 ;;=F18.221^^93^1126^15
 ;;^UTILITY(U,$J,358.3,25021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25021,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25021,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,25021,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,25022,0)
 ;;=F18.921^^93^1126^16
 ;;^UTILITY(U,$J,358.3,25022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25022,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25022,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,25022,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,25023,0)
 ;;=F18.129^^93^1126^17
 ;;^UTILITY(U,$J,358.3,25023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25023,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25023,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,25023,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,25024,0)
 ;;=F18.229^^93^1126^18
 ;;^UTILITY(U,$J,358.3,25024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25024,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25024,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,25024,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,25025,0)
 ;;=F18.929^^93^1126^19
 ;;^UTILITY(U,$J,358.3,25025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25025,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25025,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,25025,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,25026,0)
 ;;=F18.180^^93^1126^1
 ;;^UTILITY(U,$J,358.3,25026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25026,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25026,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,25026,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,25027,0)
 ;;=F18.280^^93^1126^2
 ;;^UTILITY(U,$J,358.3,25027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25027,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25027,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,25027,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,25028,0)
 ;;=F18.980^^93^1126^3
 ;;^UTILITY(U,$J,358.3,25028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25028,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25028,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,25028,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,25029,0)
 ;;=F18.94^^93^1126^4
 ;;^UTILITY(U,$J,358.3,25029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25029,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25029,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,25029,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,25030,0)
 ;;=F18.17^^93^1126^5
 ;;^UTILITY(U,$J,358.3,25030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25030,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25030,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,25030,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,25031,0)
 ;;=F18.27^^93^1126^6
 ;;^UTILITY(U,$J,358.3,25031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25031,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
