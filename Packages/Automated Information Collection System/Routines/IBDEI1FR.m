IBDEI1FR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24395,1,3,0)
 ;;=3^Reaction to Severe Stress,Unspec
 ;;^UTILITY(U,$J,358.3,24395,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,24395,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,24396,0)
 ;;=F94.1^^90^1070^14
 ;;^UTILITY(U,$J,358.3,24396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24396,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,24396,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,24396,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,24397,0)
 ;;=F94.2^^90^1070^8
 ;;^UTILITY(U,$J,358.3,24397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24397,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,24397,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,24397,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,24398,0)
 ;;=F18.10^^90^1071^21
 ;;^UTILITY(U,$J,358.3,24398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24398,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24398,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,24398,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,24399,0)
 ;;=F18.20^^90^1071^22
 ;;^UTILITY(U,$J,358.3,24399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24399,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24399,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,24399,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,24400,0)
 ;;=F18.21^^90^1071^23
 ;;^UTILITY(U,$J,358.3,24400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24400,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,24400,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,24400,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,24401,0)
 ;;=F18.14^^90^1071^24
 ;;^UTILITY(U,$J,358.3,24401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24401,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24401,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,24401,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,24402,0)
 ;;=F18.24^^90^1071^25
 ;;^UTILITY(U,$J,358.3,24402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24402,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24402,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,24402,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,24403,0)
 ;;=F18.121^^90^1071^14
 ;;^UTILITY(U,$J,358.3,24403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24403,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24403,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,24403,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,24404,0)
 ;;=F18.221^^90^1071^15
 ;;^UTILITY(U,$J,358.3,24404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24404,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24404,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,24404,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,24405,0)
 ;;=F18.921^^90^1071^16
 ;;^UTILITY(U,$J,358.3,24405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24405,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24405,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,24405,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,24406,0)
 ;;=F18.129^^90^1071^17
 ;;^UTILITY(U,$J,358.3,24406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24406,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24406,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,24406,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,24407,0)
 ;;=F18.229^^90^1071^18
 ;;^UTILITY(U,$J,358.3,24407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24407,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
