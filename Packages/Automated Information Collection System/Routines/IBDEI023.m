IBDEI023 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,486,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,486,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,487,0)
 ;;=F12.222^^3^51^10
 ;;^UTILITY(U,$J,358.3,487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,487,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,487,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,487,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,488,0)
 ;;=F12.129^^3^51^14
 ;;^UTILITY(U,$J,358.3,488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,488,1,3,0)
 ;;=3^Cannabis Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,488,1,4,0)
 ;;=4^F12.129
 ;;^UTILITY(U,$J,358.3,488,2)
 ;;=^5003159
 ;;^UTILITY(U,$J,358.3,489,0)
 ;;=F12.922^^3^51^11
 ;;^UTILITY(U,$J,358.3,489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,489,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,489,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,489,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,490,0)
 ;;=F12.980^^3^51^1
 ;;^UTILITY(U,$J,358.3,490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,490,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,490,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,490,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,491,0)
 ;;=F12.159^^3^51^2
 ;;^UTILITY(U,$J,358.3,491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,491,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,491,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,491,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,492,0)
 ;;=F12.259^^3^51^3
 ;;^UTILITY(U,$J,358.3,492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,492,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,492,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,492,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,493,0)
 ;;=F12.959^^3^51^4
 ;;^UTILITY(U,$J,358.3,493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,493,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,493,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,493,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,494,0)
 ;;=F12.988^^3^51^5
 ;;^UTILITY(U,$J,358.3,494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,494,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,494,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,494,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,495,0)
 ;;=F12.929^^3^51^13
 ;;^UTILITY(U,$J,358.3,495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,495,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,495,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,495,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,496,0)
 ;;=F12.99^^3^51^15
 ;;^UTILITY(U,$J,358.3,496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,496,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,496,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,496,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,497,0)
 ;;=F16.10^^3^52^17
 ;;^UTILITY(U,$J,358.3,497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,497,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,497,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,497,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,498,0)
 ;;=F16.20^^3^52^18
 ;;^UTILITY(U,$J,358.3,498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,498,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,498,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,498,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,499,0)
 ;;=F16.21^^3^52^19
 ;;^UTILITY(U,$J,358.3,499,1,0)
 ;;=^358.31IA^4^2
