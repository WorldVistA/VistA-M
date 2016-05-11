IBDEI1IE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25600,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,25600,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,25601,0)
 ;;=F43.9^^95^1174^13
 ;;^UTILITY(U,$J,358.3,25601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25601,1,3,0)
 ;;=3^Reaction to Severe Stress,Unspec
 ;;^UTILITY(U,$J,358.3,25601,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,25601,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,25602,0)
 ;;=F94.1^^95^1174^14
 ;;^UTILITY(U,$J,358.3,25602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25602,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,25602,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,25602,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,25603,0)
 ;;=F94.2^^95^1174^8
 ;;^UTILITY(U,$J,358.3,25603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25603,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,25603,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,25603,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,25604,0)
 ;;=F18.10^^95^1175^21
 ;;^UTILITY(U,$J,358.3,25604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25604,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25604,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,25604,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,25605,0)
 ;;=F18.20^^95^1175^22
 ;;^UTILITY(U,$J,358.3,25605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25605,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25605,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,25605,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,25606,0)
 ;;=F18.21^^95^1175^23
 ;;^UTILITY(U,$J,358.3,25606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25606,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,25606,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,25606,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,25607,0)
 ;;=F18.14^^95^1175^24
 ;;^UTILITY(U,$J,358.3,25607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25607,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25607,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,25607,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,25608,0)
 ;;=F18.24^^95^1175^25
 ;;^UTILITY(U,$J,358.3,25608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25608,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25608,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,25608,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,25609,0)
 ;;=F18.121^^95^1175^14
 ;;^UTILITY(U,$J,358.3,25609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25609,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25609,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,25609,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,25610,0)
 ;;=F18.221^^95^1175^15
 ;;^UTILITY(U,$J,358.3,25610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25610,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25610,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,25610,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,25611,0)
 ;;=F18.921^^95^1175^16
 ;;^UTILITY(U,$J,358.3,25611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25611,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25611,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,25611,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,25612,0)
 ;;=F18.129^^95^1175^17
 ;;^UTILITY(U,$J,358.3,25612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25612,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25612,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,25612,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,25613,0)
 ;;=F18.229^^95^1175^18
