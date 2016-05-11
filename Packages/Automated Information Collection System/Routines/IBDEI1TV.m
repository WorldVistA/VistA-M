IBDEI1TV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31045,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,31046,0)
 ;;=F15.20^^123^1556^5
 ;;^UTILITY(U,$J,358.3,31046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31046,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31046,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,31046,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,31047,0)
 ;;=F15.21^^123^1556^6
 ;;^UTILITY(U,$J,358.3,31047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31047,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,31047,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,31047,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,31048,0)
 ;;=F15.23^^123^1556^1
 ;;^UTILITY(U,$J,358.3,31048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31048,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,31048,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,31048,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,31049,0)
 ;;=F12.10^^123^1557^16
 ;;^UTILITY(U,$J,358.3,31049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31049,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31049,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,31049,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,31050,0)
 ;;=F12.180^^123^1557^20
 ;;^UTILITY(U,$J,358.3,31050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31050,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,31050,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,31050,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,31051,0)
 ;;=F12.188^^123^1557^22
 ;;^UTILITY(U,$J,358.3,31051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31051,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31051,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,31051,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,31052,0)
 ;;=F12.20^^123^1557^17
 ;;^UTILITY(U,$J,358.3,31052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31052,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31052,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,31052,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,31053,0)
 ;;=F12.21^^123^1557^18
 ;;^UTILITY(U,$J,358.3,31053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31053,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,31053,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,31053,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,31054,0)
 ;;=F12.288^^123^1557^19
 ;;^UTILITY(U,$J,358.3,31054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31054,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,31054,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,31054,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,31055,0)
 ;;=F12.280^^123^1557^21
 ;;^UTILITY(U,$J,358.3,31055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31055,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31055,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,31055,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,31056,0)
 ;;=F12.121^^123^1557^6
 ;;^UTILITY(U,$J,358.3,31056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31056,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31056,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,31056,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,31057,0)
 ;;=F12.221^^123^1557^7
 ;;^UTILITY(U,$J,358.3,31057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31057,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31057,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,31057,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,31058,0)
 ;;=F12.921^^123^1557^8
