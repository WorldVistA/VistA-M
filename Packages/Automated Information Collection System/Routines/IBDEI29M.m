IBDEI29M ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38415,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38415,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,38415,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,38416,0)
 ;;=F18.129^^145^1864^17
 ;;^UTILITY(U,$J,358.3,38416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38416,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38416,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,38416,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,38417,0)
 ;;=F18.229^^145^1864^18
 ;;^UTILITY(U,$J,358.3,38417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38417,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38417,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,38417,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,38418,0)
 ;;=F18.929^^145^1864^19
 ;;^UTILITY(U,$J,358.3,38418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38418,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38418,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,38418,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,38419,0)
 ;;=F18.180^^145^1864^1
 ;;^UTILITY(U,$J,358.3,38419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38419,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38419,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,38419,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,38420,0)
 ;;=F18.280^^145^1864^2
 ;;^UTILITY(U,$J,358.3,38420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38420,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38420,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,38420,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,38421,0)
 ;;=F18.980^^145^1864^3
 ;;^UTILITY(U,$J,358.3,38421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38421,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38421,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,38421,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,38422,0)
 ;;=F18.94^^145^1864^4
 ;;^UTILITY(U,$J,358.3,38422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38422,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38422,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,38422,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,38423,0)
 ;;=F18.17^^145^1864^5
 ;;^UTILITY(U,$J,358.3,38423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38423,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38423,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,38423,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,38424,0)
 ;;=F18.27^^145^1864^6
 ;;^UTILITY(U,$J,358.3,38424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38424,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38424,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,38424,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,38425,0)
 ;;=F18.97^^145^1864^7
 ;;^UTILITY(U,$J,358.3,38425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38425,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38425,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,38425,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,38426,0)
 ;;=F18.188^^145^1864^8
 ;;^UTILITY(U,$J,358.3,38426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38426,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38426,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,38426,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,38427,0)
 ;;=F18.288^^145^1864^9
 ;;^UTILITY(U,$J,358.3,38427,1,0)
 ;;=^358.31IA^4^2
