IBDEI1L2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26848,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,26849,0)
 ;;=F10.129^^100^1291^23
 ;;^UTILITY(U,$J,358.3,26849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26849,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26849,1,4,0)
 ;;=4^F10.129
 ;;^UTILITY(U,$J,358.3,26849,2)
 ;;=^5003071
 ;;^UTILITY(U,$J,358.3,26850,0)
 ;;=F10.229^^100^1291^24
 ;;^UTILITY(U,$J,358.3,26850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26850,1,3,0)
 ;;=3^Alcohol Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26850,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,26850,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,26851,0)
 ;;=F10.929^^100^1291^25
 ;;^UTILITY(U,$J,358.3,26851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26851,1,3,0)
 ;;=3^Alcohol Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26851,1,4,0)
 ;;=4^F10.929
 ;;^UTILITY(U,$J,358.3,26851,2)
 ;;=^5003103
 ;;^UTILITY(U,$J,358.3,26852,0)
 ;;=F10.99^^100^1291^26
 ;;^UTILITY(U,$J,358.3,26852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26852,1,3,0)
 ;;=3^Alcohol Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26852,1,4,0)
 ;;=4^F10.99
 ;;^UTILITY(U,$J,358.3,26852,2)
 ;;=^5133351
 ;;^UTILITY(U,$J,358.3,26853,0)
 ;;=F15.10^^100^1292^4
 ;;^UTILITY(U,$J,358.3,26853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26853,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26853,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,26853,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,26854,0)
 ;;=F15.14^^100^1292^2
 ;;^UTILITY(U,$J,358.3,26854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26854,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26854,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,26854,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,26855,0)
 ;;=F15.182^^100^1292^3
 ;;^UTILITY(U,$J,358.3,26855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26855,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26855,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,26855,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,26856,0)
 ;;=F15.20^^100^1292^5
 ;;^UTILITY(U,$J,358.3,26856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26856,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,26856,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,26856,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,26857,0)
 ;;=F15.21^^100^1292^6
 ;;^UTILITY(U,$J,358.3,26857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26857,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,26857,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,26857,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,26858,0)
 ;;=F15.23^^100^1292^1
 ;;^UTILITY(U,$J,358.3,26858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26858,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,26858,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,26858,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,26859,0)
 ;;=F12.10^^100^1293^16
 ;;^UTILITY(U,$J,358.3,26859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26859,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26859,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,26859,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,26860,0)
 ;;=F12.180^^100^1293^20
 ;;^UTILITY(U,$J,358.3,26860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26860,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,26860,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,26860,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,26861,0)
 ;;=F12.188^^100^1293^22
