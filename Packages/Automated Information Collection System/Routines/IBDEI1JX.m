IBDEI1JX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26317,1,3,0)
 ;;=3^Reaction to Severe Stress,Unspec
 ;;^UTILITY(U,$J,358.3,26317,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,26317,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,26318,0)
 ;;=F94.1^^98^1244^14
 ;;^UTILITY(U,$J,358.3,26318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26318,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,26318,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,26318,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,26319,0)
 ;;=F94.2^^98^1244^8
 ;;^UTILITY(U,$J,358.3,26319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26319,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,26319,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,26319,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,26320,0)
 ;;=F18.10^^98^1245^21
 ;;^UTILITY(U,$J,358.3,26320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26320,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26320,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,26320,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,26321,0)
 ;;=F18.20^^98^1245^22
 ;;^UTILITY(U,$J,358.3,26321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26321,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,26321,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,26321,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,26322,0)
 ;;=F18.21^^98^1245^23
 ;;^UTILITY(U,$J,358.3,26322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26322,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,26322,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,26322,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,26323,0)
 ;;=F18.14^^98^1245^24
 ;;^UTILITY(U,$J,358.3,26323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26323,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26323,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,26323,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,26324,0)
 ;;=F18.24^^98^1245^25
 ;;^UTILITY(U,$J,358.3,26324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26324,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26324,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,26324,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,26325,0)
 ;;=F18.121^^98^1245^14
 ;;^UTILITY(U,$J,358.3,26325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26325,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26325,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,26325,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,26326,0)
 ;;=F18.221^^98^1245^15
 ;;^UTILITY(U,$J,358.3,26326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26326,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26326,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,26326,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,26327,0)
 ;;=F18.921^^98^1245^16
 ;;^UTILITY(U,$J,358.3,26327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26327,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26327,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,26327,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,26328,0)
 ;;=F18.129^^98^1245^17
 ;;^UTILITY(U,$J,358.3,26328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26328,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26328,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,26328,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,26329,0)
 ;;=F18.229^^98^1245^18
 ;;^UTILITY(U,$J,358.3,26329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26329,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
