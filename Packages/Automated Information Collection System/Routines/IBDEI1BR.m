IBDEI1BR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21168,0)
 ;;=F18.221^^95^1050^19
 ;;^UTILITY(U,$J,358.3,21168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21168,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21168,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,21168,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,21169,0)
 ;;=F18.921^^95^1050^20
 ;;^UTILITY(U,$J,358.3,21169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21169,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21169,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,21169,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,21170,0)
 ;;=F18.129^^95^1050^21
 ;;^UTILITY(U,$J,358.3,21170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21170,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21170,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,21170,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,21171,0)
 ;;=F18.229^^95^1050^22
 ;;^UTILITY(U,$J,358.3,21171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21171,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21171,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,21171,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,21172,0)
 ;;=F18.929^^95^1050^23
 ;;^UTILITY(U,$J,358.3,21172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21172,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21172,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,21172,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,21173,0)
 ;;=F18.180^^95^1050^3
 ;;^UTILITY(U,$J,358.3,21173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21173,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21173,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,21173,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,21174,0)
 ;;=F18.280^^95^1050^4
 ;;^UTILITY(U,$J,358.3,21174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21174,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21174,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,21174,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,21175,0)
 ;;=F18.980^^95^1050^5
 ;;^UTILITY(U,$J,358.3,21175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21175,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21175,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,21175,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,21176,0)
 ;;=F18.94^^95^1050^8
 ;;^UTILITY(U,$J,358.3,21176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21176,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21176,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,21176,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,21177,0)
 ;;=F18.17^^95^1050^9
 ;;^UTILITY(U,$J,358.3,21177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21177,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21177,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,21177,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,21178,0)
 ;;=F18.27^^95^1050^10
 ;;^UTILITY(U,$J,358.3,21178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21178,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21178,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,21178,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,21179,0)
 ;;=F18.97^^95^1050^11
 ;;^UTILITY(U,$J,358.3,21179,1,0)
 ;;=^358.31IA^4^2
