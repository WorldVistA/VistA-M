IBDEI1QB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28921,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,28921,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,28921,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,28922,0)
 ;;=Y36.300S^^132^1339^120
 ;;^UTILITY(U,$J,358.3,28922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28922,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,28922,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,28922,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,28923,0)
 ;;=Y36.230A^^132^1339^116
 ;;^UTILITY(U,$J,358.3,28923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28923,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,28923,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,28923,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,28924,0)
 ;;=Y36.230D^^132^1339^117
 ;;^UTILITY(U,$J,358.3,28924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28924,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28924,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,28924,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,28925,0)
 ;;=Y36.230S^^132^1339^118
 ;;^UTILITY(U,$J,358.3,28925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28925,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
 ;;^UTILITY(U,$J,358.3,28925,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,28925,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,28926,0)
 ;;=Y36.7X0S^^132^1339^130
 ;;^UTILITY(U,$J,358.3,28926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28926,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,28926,1,4,0)
 ;;=4^Y36.7X0S
 ;;^UTILITY(U,$J,358.3,28926,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,28927,0)
 ;;=F02.81^^132^1340^11
 ;;^UTILITY(U,$J,358.3,28927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28927,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28927,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,28927,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,28928,0)
 ;;=F02.80^^132^1340^12
 ;;^UTILITY(U,$J,358.3,28928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28928,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28928,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,28928,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,28929,0)
 ;;=F03.91^^132^1340^13
 ;;^UTILITY(U,$J,358.3,28929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28929,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,28929,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,28929,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,28930,0)
 ;;=G31.83^^132^1340^14
 ;;^UTILITY(U,$J,358.3,28930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28930,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,28930,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,28930,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,28931,0)
 ;;=F01.51^^132^1340^30
 ;;^UTILITY(U,$J,358.3,28931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28931,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28931,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,28931,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,28932,0)
 ;;=F01.50^^132^1340^31
 ;;^UTILITY(U,$J,358.3,28932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28932,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,28932,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,28932,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,28933,0)
 ;;=A81.9^^132^1340^6
 ;;^UTILITY(U,$J,358.3,28933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28933,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
