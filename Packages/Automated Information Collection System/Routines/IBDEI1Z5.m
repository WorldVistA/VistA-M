IBDEI1Z5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33061,0)
 ;;=F10.24^^146^1607^9
 ;;^UTILITY(U,$J,358.3,33061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33061,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,33061,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,33061,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,33062,0)
 ;;=F10.29^^146^1607^11
 ;;^UTILITY(U,$J,358.3,33062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33062,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33062,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,33062,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,33063,0)
 ;;=F15.10^^146^1608^4
 ;;^UTILITY(U,$J,358.3,33063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33063,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33063,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,33063,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,33064,0)
 ;;=F15.14^^146^1608^2
 ;;^UTILITY(U,$J,358.3,33064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33064,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33064,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,33064,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,33065,0)
 ;;=F15.182^^146^1608^3
 ;;^UTILITY(U,$J,358.3,33065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33065,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33065,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,33065,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,33066,0)
 ;;=F15.20^^146^1608^5
 ;;^UTILITY(U,$J,358.3,33066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33066,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33066,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,33066,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,33067,0)
 ;;=F15.21^^146^1608^6
 ;;^UTILITY(U,$J,358.3,33067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33067,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,33067,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,33067,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,33068,0)
 ;;=F15.23^^146^1608^1
 ;;^UTILITY(U,$J,358.3,33068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33068,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,33068,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,33068,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,33069,0)
 ;;=F12.10^^146^1609^1
 ;;^UTILITY(U,$J,358.3,33069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33069,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,33069,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,33069,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,33070,0)
 ;;=F12.180^^146^1609^2
 ;;^UTILITY(U,$J,358.3,33070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33070,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,33070,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,33070,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,33071,0)
 ;;=F12.188^^146^1609^3
 ;;^UTILITY(U,$J,358.3,33071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33071,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,33071,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,33071,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,33072,0)
 ;;=F12.20^^146^1609^4
 ;;^UTILITY(U,$J,358.3,33072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33072,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33072,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,33072,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,33073,0)
 ;;=F12.21^^146^1609^5
