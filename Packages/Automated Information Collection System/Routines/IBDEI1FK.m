IBDEI1FK ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24309,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24309,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,24309,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,24310,0)
 ;;=F16.929^^90^1064^15
 ;;^UTILITY(U,$J,358.3,24310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24310,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24310,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,24310,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,24311,0)
 ;;=F16.180^^90^1064^1
 ;;^UTILITY(U,$J,358.3,24311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24311,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24311,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,24311,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,24312,0)
 ;;=F16.280^^90^1064^2
 ;;^UTILITY(U,$J,358.3,24312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24312,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24312,1,4,0)
 ;;=4^F16.280
 ;;^UTILITY(U,$J,358.3,24312,2)
 ;;=^5003345
 ;;^UTILITY(U,$J,358.3,24313,0)
 ;;=F16.980^^90^1064^3
 ;;^UTILITY(U,$J,358.3,24313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24313,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24313,1,4,0)
 ;;=4^F16.980
 ;;^UTILITY(U,$J,358.3,24313,2)
 ;;=^5003357
 ;;^UTILITY(U,$J,358.3,24314,0)
 ;;=F16.14^^90^1064^4
 ;;^UTILITY(U,$J,358.3,24314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24314,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24314,1,4,0)
 ;;=4^F16.14
 ;;^UTILITY(U,$J,358.3,24314,2)
 ;;=^5003328
 ;;^UTILITY(U,$J,358.3,24315,0)
 ;;=F16.24^^90^1064^5
 ;;^UTILITY(U,$J,358.3,24315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24315,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24315,1,4,0)
 ;;=4^F16.24
 ;;^UTILITY(U,$J,358.3,24315,2)
 ;;=^5003341
 ;;^UTILITY(U,$J,358.3,24316,0)
 ;;=F16.94^^90^1064^6
 ;;^UTILITY(U,$J,358.3,24316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24316,1,3,0)
 ;;=3^Hallucinogen Induced Bipolar Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24316,1,4,0)
 ;;=4^F16.94
 ;;^UTILITY(U,$J,358.3,24316,2)
 ;;=^5003353
 ;;^UTILITY(U,$J,358.3,24317,0)
 ;;=F16.159^^90^1064^7
 ;;^UTILITY(U,$J,358.3,24317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24317,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24317,1,4,0)
 ;;=4^F16.159
 ;;^UTILITY(U,$J,358.3,24317,2)
 ;;=^5003331
 ;;^UTILITY(U,$J,358.3,24318,0)
 ;;=F16.259^^90^1064^8
 ;;^UTILITY(U,$J,358.3,24318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24318,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24318,1,4,0)
 ;;=4^F16.259
 ;;^UTILITY(U,$J,358.3,24318,2)
 ;;=^5003344
 ;;^UTILITY(U,$J,358.3,24319,0)
 ;;=F16.959^^90^1064^9
 ;;^UTILITY(U,$J,358.3,24319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24319,1,3,0)
 ;;=3^Hallucinogen Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24319,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,24319,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,24320,0)
 ;;=F16.99^^90^1064^20
 ;;^UTILITY(U,$J,358.3,24320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24320,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24320,1,4,0)
 ;;=4^F16.99
 ;;^UTILITY(U,$J,358.3,24320,2)
 ;;=^5133359
 ;;^UTILITY(U,$J,358.3,24321,0)
 ;;=F11.10^^90^1065^23
 ;;^UTILITY(U,$J,358.3,24321,1,0)
 ;;=^358.31IA^4^2
