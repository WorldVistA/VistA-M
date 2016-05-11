IBDEI1L4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26873,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26873,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,26873,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,26874,0)
 ;;=F12.980^^100^1293^1
 ;;^UTILITY(U,$J,358.3,26874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26874,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26874,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,26874,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,26875,0)
 ;;=F12.159^^100^1293^2
 ;;^UTILITY(U,$J,358.3,26875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26875,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26875,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,26875,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,26876,0)
 ;;=F12.259^^100^1293^3
 ;;^UTILITY(U,$J,358.3,26876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26876,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26876,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,26876,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,26877,0)
 ;;=F12.959^^100^1293^4
 ;;^UTILITY(U,$J,358.3,26877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26877,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26877,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,26877,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,26878,0)
 ;;=F12.988^^100^1293^5
 ;;^UTILITY(U,$J,358.3,26878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26878,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26878,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,26878,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,26879,0)
 ;;=F12.929^^100^1293^13
 ;;^UTILITY(U,$J,358.3,26879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26879,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26879,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,26879,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,26880,0)
 ;;=F12.99^^100^1293^15
 ;;^UTILITY(U,$J,358.3,26880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26880,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26880,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,26880,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,26881,0)
 ;;=F16.10^^100^1294^17
 ;;^UTILITY(U,$J,358.3,26881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26881,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26881,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,26881,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,26882,0)
 ;;=F16.20^^100^1294^18
 ;;^UTILITY(U,$J,358.3,26882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26882,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,26882,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,26882,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,26883,0)
 ;;=F16.21^^100^1294^19
 ;;^UTILITY(U,$J,358.3,26883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26883,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,26883,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,26883,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,26884,0)
 ;;=F16.983^^100^1294^16
 ;;^UTILITY(U,$J,358.3,26884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26884,1,3,0)
 ;;=3^Hallucinogen Persisting Perception Disorder
 ;;^UTILITY(U,$J,358.3,26884,1,4,0)
 ;;=4^F16.983
 ;;^UTILITY(U,$J,358.3,26884,2)
 ;;=^5003358
 ;;^UTILITY(U,$J,358.3,26885,0)
 ;;=F16.121^^100^1294^10
 ;;^UTILITY(U,$J,358.3,26885,1,0)
 ;;=^358.31IA^4^2
