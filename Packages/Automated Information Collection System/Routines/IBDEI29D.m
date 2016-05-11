IBDEI29D ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38305,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,38305,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,38306,0)
 ;;=F12.259^^145^1856^3
 ;;^UTILITY(U,$J,358.3,38306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38306,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38306,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,38306,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,38307,0)
 ;;=F12.959^^145^1856^4
 ;;^UTILITY(U,$J,358.3,38307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38307,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38307,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,38307,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,38308,0)
 ;;=F12.988^^145^1856^5
 ;;^UTILITY(U,$J,358.3,38308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38308,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38308,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,38308,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,38309,0)
 ;;=F12.929^^145^1856^13
 ;;^UTILITY(U,$J,358.3,38309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38309,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38309,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,38309,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,38310,0)
 ;;=F12.99^^145^1856^15
 ;;^UTILITY(U,$J,358.3,38310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38310,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38310,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,38310,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,38311,0)
 ;;=F16.10^^145^1857^17
 ;;^UTILITY(U,$J,358.3,38311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38311,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38311,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,38311,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,38312,0)
 ;;=F16.20^^145^1857^18
 ;;^UTILITY(U,$J,358.3,38312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38312,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38312,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,38312,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,38313,0)
 ;;=F16.21^^145^1857^19
 ;;^UTILITY(U,$J,358.3,38313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38313,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,38313,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,38313,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,38314,0)
 ;;=F16.983^^145^1857^16
 ;;^UTILITY(U,$J,358.3,38314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38314,1,3,0)
 ;;=3^Hallucinogen Persisting Perception Disorder
 ;;^UTILITY(U,$J,358.3,38314,1,4,0)
 ;;=4^F16.983
 ;;^UTILITY(U,$J,358.3,38314,2)
 ;;=^5003358
 ;;^UTILITY(U,$J,358.3,38315,0)
 ;;=F16.121^^145^1857^10
 ;;^UTILITY(U,$J,358.3,38315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38315,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38315,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,38315,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,38316,0)
 ;;=F16.221^^145^1857^11
 ;;^UTILITY(U,$J,358.3,38316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38316,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38316,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,38316,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,38317,0)
 ;;=F16.921^^145^1857^12
 ;;^UTILITY(U,$J,358.3,38317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38317,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38317,1,4,0)
 ;;=4^F16.921
