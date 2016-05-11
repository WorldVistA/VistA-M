IBDEI1FI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24285,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24285,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,24285,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,24286,0)
 ;;=F12.121^^90^1063^6
 ;;^UTILITY(U,$J,358.3,24286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24286,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24286,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,24286,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,24287,0)
 ;;=F12.221^^90^1063^7
 ;;^UTILITY(U,$J,358.3,24287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24287,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24287,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,24287,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,24288,0)
 ;;=F12.921^^90^1063^8
 ;;^UTILITY(U,$J,358.3,24288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24288,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24288,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,24288,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,24289,0)
 ;;=F12.229^^90^1063^12
 ;;^UTILITY(U,$J,358.3,24289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24289,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24289,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,24289,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,24290,0)
 ;;=F12.122^^90^1063^9
 ;;^UTILITY(U,$J,358.3,24290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24290,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24290,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,24290,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,24291,0)
 ;;=F12.222^^90^1063^10
 ;;^UTILITY(U,$J,358.3,24291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24291,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24291,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,24291,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,24292,0)
 ;;=F12.129^^90^1063^14
 ;;^UTILITY(U,$J,358.3,24292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24292,1,3,0)
 ;;=3^Cannabis Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,24292,1,4,0)
 ;;=4^F12.129
 ;;^UTILITY(U,$J,358.3,24292,2)
 ;;=^5003159
 ;;^UTILITY(U,$J,358.3,24293,0)
 ;;=F12.922^^90^1063^11
 ;;^UTILITY(U,$J,358.3,24293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24293,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24293,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,24293,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,24294,0)
 ;;=F12.980^^90^1063^1
 ;;^UTILITY(U,$J,358.3,24294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24294,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24294,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,24294,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,24295,0)
 ;;=F12.159^^90^1063^2
 ;;^UTILITY(U,$J,358.3,24295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24295,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24295,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,24295,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,24296,0)
 ;;=F12.259^^90^1063^3
 ;;^UTILITY(U,$J,358.3,24296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24296,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24296,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,24296,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,24297,0)
 ;;=F12.959^^90^1063^4
