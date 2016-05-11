IBDEI1L5 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26885,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26885,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,26885,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,26886,0)
 ;;=F16.221^^100^1294^11
 ;;^UTILITY(U,$J,358.3,26886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26886,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26886,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,26886,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,26887,0)
 ;;=F16.921^^100^1294^12
 ;;^UTILITY(U,$J,358.3,26887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26887,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26887,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,26887,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,26888,0)
 ;;=F16.129^^100^1294^13
 ;;^UTILITY(U,$J,358.3,26888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26888,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26888,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,26888,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,26889,0)
 ;;=F16.229^^100^1294^14
 ;;^UTILITY(U,$J,358.3,26889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26889,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26889,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,26889,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,26890,0)
 ;;=F16.929^^100^1294^15
 ;;^UTILITY(U,$J,358.3,26890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26890,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26890,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,26890,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,26891,0)
 ;;=F16.180^^100^1294^1
 ;;^UTILITY(U,$J,358.3,26891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26891,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26891,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,26891,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,26892,0)
 ;;=F16.280^^100^1294^2
 ;;^UTILITY(U,$J,358.3,26892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26892,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26892,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,26892,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,26893,0)
 ;;=F16.980^^100^1294^3
 ;;^UTILITY(U,$J,358.3,26893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26893,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26893,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,26893,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,26894,0)
 ;;=F16.14^^100^1294^4
 ;;^UTILITY(U,$J,358.3,26894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26894,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26894,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,26894,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,26895,0)
 ;;=F16.24^^100^1294^5
 ;;^UTILITY(U,$J,358.3,26895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26895,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26895,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,26895,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,26896,0)
 ;;=F16.94^^100^1294^6
 ;;^UTILITY(U,$J,358.3,26896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26896,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26896,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,26896,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,26897,0)
 ;;=F16.159^^100^1294^7
