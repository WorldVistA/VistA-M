IBDEI1JS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26256,1,3,0)
 ;;=3^Opioid Induced Delirium
 ;;^UTILITY(U,$J,358.3,26256,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,26256,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,26257,0)
 ;;=F11.94^^98^1239^7
 ;;^UTILITY(U,$J,358.3,26257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26257,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26257,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,26257,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,26258,0)
 ;;=F11.181^^98^1239^8
 ;;^UTILITY(U,$J,358.3,26258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26258,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26258,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,26258,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,26259,0)
 ;;=F11.281^^98^1239^9
 ;;^UTILITY(U,$J,358.3,26259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26259,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26259,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,26259,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,26260,0)
 ;;=F11.981^^98^1239^10
 ;;^UTILITY(U,$J,358.3,26260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26260,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26260,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,26260,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,26261,0)
 ;;=F11.282^^98^1239^11
 ;;^UTILITY(U,$J,358.3,26261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26261,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26261,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,26261,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,26262,0)
 ;;=F11.982^^98^1239^12
 ;;^UTILITY(U,$J,358.3,26262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26262,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26262,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,26262,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,26263,0)
 ;;=F11.121^^98^1239^13
 ;;^UTILITY(U,$J,358.3,26263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26263,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26263,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,26263,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,26264,0)
 ;;=F11.221^^98^1239^14
 ;;^UTILITY(U,$J,358.3,26264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26264,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26264,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,26264,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,26265,0)
 ;;=F11.921^^98^1239^15
 ;;^UTILITY(U,$J,358.3,26265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26265,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26265,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,26265,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,26266,0)
 ;;=F11.229^^98^1239^20
 ;;^UTILITY(U,$J,358.3,26266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26266,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26266,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,26266,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,26267,0)
 ;;=F11.929^^98^1239^21
 ;;^UTILITY(U,$J,358.3,26267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26267,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26267,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,26267,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,26268,0)
 ;;=F11.122^^98^1239^16
