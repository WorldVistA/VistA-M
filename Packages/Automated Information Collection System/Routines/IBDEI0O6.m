IBDEI0O6 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10874,0)
 ;;=F10.14^^42^491^1
 ;;^UTILITY(U,$J,358.3,10874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10874,1,3,0)
 ;;=3^Alcohol Abuse w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,10874,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,10874,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,10875,0)
 ;;=F10.24^^42^491^4
 ;;^UTILITY(U,$J,358.3,10875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10875,1,3,0)
 ;;=3^Alcohol Dependence w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,10875,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,10875,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,10876,0)
 ;;=F10.94^^42^491^31
 ;;^UTILITY(U,$J,358.3,10876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10876,1,3,0)
 ;;=3^Alcohol Use w/ Induced Mood Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10876,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,10876,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,10877,0)
 ;;=F10.231^^42^491^32
 ;;^UTILITY(U,$J,358.3,10877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10877,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,10877,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,10877,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,10878,0)
 ;;=F10.232^^42^491^33
 ;;^UTILITY(U,$J,358.3,10878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10878,1,3,0)
 ;;=3^Alcohol Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,10878,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,10878,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,10879,0)
 ;;=F10.11^^42^491^2
 ;;^UTILITY(U,$J,358.3,10879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10879,1,3,0)
 ;;=3^Alcohol Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,10879,1,4,0)
 ;;=4^F10.11
 ;;^UTILITY(U,$J,358.3,10879,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,10880,0)
 ;;=F12.10^^42^492^21
 ;;^UTILITY(U,$J,358.3,10880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10880,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,10880,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,10880,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,10881,0)
 ;;=F12.20^^42^492^2
 ;;^UTILITY(U,$J,358.3,10881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10881,1,3,0)
 ;;=3^Cannabis Dependence
 ;;^UTILITY(U,$J,358.3,10881,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,10881,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,10882,0)
 ;;=F12.121^^42^492^12
 ;;^UTILITY(U,$J,358.3,10882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10882,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,10882,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,10882,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,10883,0)
 ;;=F12.221^^42^492^13
 ;;^UTILITY(U,$J,358.3,10883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10883,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,10883,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,10883,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,10884,0)
 ;;=F12.921^^42^492^14
 ;;^UTILITY(U,$J,358.3,10884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10884,1,3,0)
 ;;=3^Cannabis Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,10884,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,10884,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,10885,0)
 ;;=F12.229^^42^492^18
 ;;^UTILITY(U,$J,358.3,10885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10885,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,10885,1,4,0)
 ;;=4^F12.229
