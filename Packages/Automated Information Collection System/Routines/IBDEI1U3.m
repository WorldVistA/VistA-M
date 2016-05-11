IBDEI1U3 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31142,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31142,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,31142,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,31143,0)
 ;;=F17.291^^123^1562^6
 ;;^UTILITY(U,$J,358.3,31143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31143,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,31143,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,31143,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,31144,0)
 ;;=F17.208^^123^1562^7
 ;;^UTILITY(U,$J,358.3,31144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31144,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31144,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,31144,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,31145,0)
 ;;=F17.209^^123^1562^8
 ;;^UTILITY(U,$J,358.3,31145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31145,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31145,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,31145,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,31146,0)
 ;;=F14.10^^123^1563^1
 ;;^UTILITY(U,$J,358.3,31146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31146,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31146,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,31146,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,31147,0)
 ;;=F14.14^^123^1563^5
 ;;^UTILITY(U,$J,358.3,31147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31147,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31147,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,31147,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,31148,0)
 ;;=F14.182^^123^1563^6
 ;;^UTILITY(U,$J,358.3,31148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31148,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31148,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,31148,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,31149,0)
 ;;=F14.20^^123^1563^3
 ;;^UTILITY(U,$J,358.3,31149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31149,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31149,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,31149,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,31150,0)
 ;;=F14.21^^123^1563^2
 ;;^UTILITY(U,$J,358.3,31150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31150,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,31150,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,31150,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,31151,0)
 ;;=F14.23^^123^1563^4
 ;;^UTILITY(U,$J,358.3,31151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31151,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,31151,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,31151,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,31152,0)
 ;;=F43.0^^123^1564^1
 ;;^UTILITY(U,$J,358.3,31152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31152,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,31152,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,31152,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,31153,0)
 ;;=F43.21^^123^1564^3
 ;;^UTILITY(U,$J,358.3,31153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31153,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,31153,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,31153,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,31154,0)
 ;;=F43.22^^123^1564^2
 ;;^UTILITY(U,$J,358.3,31154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31154,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
