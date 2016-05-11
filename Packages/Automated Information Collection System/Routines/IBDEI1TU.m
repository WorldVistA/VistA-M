IBDEI1TU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31033,1,4,0)
 ;;=4^F10.281
 ;;^UTILITY(U,$J,358.3,31033,2)
 ;;=^5003097
 ;;^UTILITY(U,$J,358.3,31034,0)
 ;;=F10.981^^123^1555^16
 ;;^UTILITY(U,$J,358.3,31034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31034,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31034,1,4,0)
 ;;=4^F10.981
 ;;^UTILITY(U,$J,358.3,31034,2)
 ;;=^5003111
 ;;^UTILITY(U,$J,358.3,31035,0)
 ;;=F10.182^^123^1555^17
 ;;^UTILITY(U,$J,358.3,31035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31035,1,3,0)
 ;;=3^Alcohol Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31035,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,31035,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,31036,0)
 ;;=F10.121^^123^1555^20
 ;;^UTILITY(U,$J,358.3,31036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31036,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31036,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,31036,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,31037,0)
 ;;=F10.221^^123^1555^21
 ;;^UTILITY(U,$J,358.3,31037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31037,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31037,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,31037,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,31038,0)
 ;;=F10.921^^123^1555^22
 ;;^UTILITY(U,$J,358.3,31038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31038,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31038,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,31038,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,31039,0)
 ;;=F10.129^^123^1555^23
 ;;^UTILITY(U,$J,358.3,31039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31039,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31039,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,31039,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,31040,0)
 ;;=F10.229^^123^1555^24
 ;;^UTILITY(U,$J,358.3,31040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31040,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31040,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,31040,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,31041,0)
 ;;=F10.929^^123^1555^25
 ;;^UTILITY(U,$J,358.3,31041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31041,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31041,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,31041,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,31042,0)
 ;;=F10.99^^123^1555^26
 ;;^UTILITY(U,$J,358.3,31042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31042,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31042,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,31042,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,31043,0)
 ;;=F15.10^^123^1556^4
 ;;^UTILITY(U,$J,358.3,31043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31043,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31043,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,31043,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,31044,0)
 ;;=F15.14^^123^1556^2
 ;;^UTILITY(U,$J,358.3,31044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31044,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31044,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,31044,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,31045,0)
 ;;=F15.182^^123^1556^3
 ;;^UTILITY(U,$J,358.3,31045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31045,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31045,1,4,0)
 ;;=4^F15.182
