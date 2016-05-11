IBDEI02C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,601,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,601,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,602,0)
 ;;=F18.129^^3^59^17
 ;;^UTILITY(U,$J,358.3,602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,602,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,602,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,602,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,603,0)
 ;;=F18.229^^3^59^18
 ;;^UTILITY(U,$J,358.3,603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,603,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,603,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,603,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,604,0)
 ;;=F18.929^^3^59^19
 ;;^UTILITY(U,$J,358.3,604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,604,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,604,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,604,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,605,0)
 ;;=F18.180^^3^59^1
 ;;^UTILITY(U,$J,358.3,605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,605,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,605,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,605,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,606,0)
 ;;=F18.280^^3^59^2
 ;;^UTILITY(U,$J,358.3,606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,606,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,606,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,606,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,607,0)
 ;;=F18.980^^3^59^3
 ;;^UTILITY(U,$J,358.3,607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,607,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,607,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,607,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,608,0)
 ;;=F18.94^^3^59^4
 ;;^UTILITY(U,$J,358.3,608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,608,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,608,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,608,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,609,0)
 ;;=F18.17^^3^59^5
 ;;^UTILITY(U,$J,358.3,609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,609,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,609,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,609,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,610,0)
 ;;=F18.27^^3^59^6
 ;;^UTILITY(U,$J,358.3,610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,610,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,610,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,610,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,611,0)
 ;;=F18.97^^3^59^7
 ;;^UTILITY(U,$J,358.3,611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,611,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,611,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,611,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,612,0)
 ;;=F18.188^^3^59^8
 ;;^UTILITY(U,$J,358.3,612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,612,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,612,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,612,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,613,0)
 ;;=F18.288^^3^59^9
 ;;^UTILITY(U,$J,358.3,613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,613,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,613,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,613,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,614,0)
 ;;=F18.988^^3^59^10
