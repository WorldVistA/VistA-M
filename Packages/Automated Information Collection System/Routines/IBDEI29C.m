IBDEI29C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38293,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,38293,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,38294,0)
 ;;=F12.288^^145^1856^19
 ;;^UTILITY(U,$J,358.3,38294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38294,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,38294,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,38294,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,38295,0)
 ;;=F12.280^^145^1856^21
 ;;^UTILITY(U,$J,358.3,38295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38295,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38295,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,38295,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,38296,0)
 ;;=F12.121^^145^1856^6
 ;;^UTILITY(U,$J,358.3,38296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38296,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38296,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,38296,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,38297,0)
 ;;=F12.221^^145^1856^7
 ;;^UTILITY(U,$J,358.3,38297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38297,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38297,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,38297,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,38298,0)
 ;;=F12.921^^145^1856^8
 ;;^UTILITY(U,$J,358.3,38298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38298,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38298,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,38298,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,38299,0)
 ;;=F12.229^^145^1856^12
 ;;^UTILITY(U,$J,358.3,38299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38299,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38299,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,38299,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,38300,0)
 ;;=F12.122^^145^1856^9
 ;;^UTILITY(U,$J,358.3,38300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38300,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38300,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,38300,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,38301,0)
 ;;=F12.222^^145^1856^10
 ;;^UTILITY(U,$J,358.3,38301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38301,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38301,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,38301,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,38302,0)
 ;;=F12.129^^145^1856^14
 ;;^UTILITY(U,$J,358.3,38302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38302,1,3,0)
 ;;=3^Cannabis Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,38302,1,4,0)
 ;;=4^F12.129
 ;;^UTILITY(U,$J,358.3,38302,2)
 ;;=^5003159
 ;;^UTILITY(U,$J,358.3,38303,0)
 ;;=F12.922^^145^1856^11
 ;;^UTILITY(U,$J,358.3,38303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38303,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38303,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,38303,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,38304,0)
 ;;=F12.980^^145^1856^1
 ;;^UTILITY(U,$J,358.3,38304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38304,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38304,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,38304,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,38305,0)
 ;;=F12.159^^145^1856^2
 ;;^UTILITY(U,$J,358.3,38305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38305,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
