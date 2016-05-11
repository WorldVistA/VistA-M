IBDEI1GV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24909,1,3,0)
 ;;=3^Cannabis Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,24909,1,4,0)
 ;;=4^F12.129
 ;;^UTILITY(U,$J,358.3,24909,2)
 ;;=^5003159
 ;;^UTILITY(U,$J,358.3,24910,0)
 ;;=F12.922^^93^1118^11
 ;;^UTILITY(U,$J,358.3,24910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24910,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24910,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,24910,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,24911,0)
 ;;=F12.980^^93^1118^1
 ;;^UTILITY(U,$J,358.3,24911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24911,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24911,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,24911,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,24912,0)
 ;;=F12.159^^93^1118^2
 ;;^UTILITY(U,$J,358.3,24912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24912,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24912,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,24912,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,24913,0)
 ;;=F12.259^^93^1118^3
 ;;^UTILITY(U,$J,358.3,24913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24913,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24913,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,24913,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,24914,0)
 ;;=F12.959^^93^1118^4
 ;;^UTILITY(U,$J,358.3,24914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24914,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24914,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,24914,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,24915,0)
 ;;=F12.988^^93^1118^5
 ;;^UTILITY(U,$J,358.3,24915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24915,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24915,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,24915,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,24916,0)
 ;;=F12.929^^93^1118^13
 ;;^UTILITY(U,$J,358.3,24916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24916,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24916,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,24916,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,24917,0)
 ;;=F12.99^^93^1118^15
 ;;^UTILITY(U,$J,358.3,24917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24917,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24917,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,24917,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,24918,0)
 ;;=F16.10^^93^1119^17
 ;;^UTILITY(U,$J,358.3,24918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24918,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24918,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,24918,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,24919,0)
 ;;=F16.20^^93^1119^18
 ;;^UTILITY(U,$J,358.3,24919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24919,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24919,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,24919,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,24920,0)
 ;;=F16.21^^93^1119^19
 ;;^UTILITY(U,$J,358.3,24920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24920,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,24920,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,24920,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,24921,0)
 ;;=F16.983^^93^1119^16
 ;;^UTILITY(U,$J,358.3,24921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24921,1,3,0)
 ;;=3^Hallucinogen Persisting Perception Disorder
