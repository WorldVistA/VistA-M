IBDEI02H ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,669,0)
 ;;=F88.^^3^67^10
 ;;^UTILITY(U,$J,358.3,669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,669,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,669,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,669,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,670,0)
 ;;=F89.^^3^67^11
 ;;^UTILITY(U,$J,358.3,670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,670,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,670,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,670,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,671,0)
 ;;=F95.1^^3^67^12
 ;;^UTILITY(U,$J,358.3,671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,671,1,3,0)
 ;;=3^Persistent Chronic Motor/Vocal Tic Disorder
 ;;^UTILITY(U,$J,358.3,671,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,671,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,672,0)
 ;;=F95.0^^3^67^13
 ;;^UTILITY(U,$J,358.3,672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,672,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,672,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,672,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,673,0)
 ;;=F80.89^^3^67^14
 ;;^UTILITY(U,$J,358.3,673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,673,1,3,0)
 ;;=3^Social Pragmatic Communication Disorder
 ;;^UTILITY(U,$J,358.3,673,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,673,2)
 ;;=^5003677
 ;;^UTILITY(U,$J,358.3,674,0)
 ;;=F80.0^^3^67^15
 ;;^UTILITY(U,$J,358.3,674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,674,1,3,0)
 ;;=3^Speech Sound Disorder
 ;;^UTILITY(U,$J,358.3,674,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,674,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,675,0)
 ;;=F98.4^^3^67^16
 ;;^UTILITY(U,$J,358.3,675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,675,1,3,0)
 ;;=3^Stereotypic Movement Disorder
 ;;^UTILITY(U,$J,358.3,675,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,675,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,676,0)
 ;;=F95.8^^3^67^17
 ;;^UTILITY(U,$J,358.3,676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,676,1,3,0)
 ;;=3^Tic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,676,1,4,0)
 ;;=4^F95.8
 ;;^UTILITY(U,$J,358.3,676,2)
 ;;=^5003709
 ;;^UTILITY(U,$J,358.3,677,0)
 ;;=F95.9^^3^67^18
 ;;^UTILITY(U,$J,358.3,677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,677,1,3,0)
 ;;=3^Tic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,677,1,4,0)
 ;;=4^F95.9
 ;;^UTILITY(U,$J,358.3,677,2)
 ;;=^5003710
 ;;^UTILITY(U,$J,358.3,678,0)
 ;;=F95.2^^3^67^19
 ;;^UTILITY(U,$J,358.3,678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,678,1,3,0)
 ;;=3^Tourette's Disorder
 ;;^UTILITY(U,$J,358.3,678,1,4,0)
 ;;=4^F95.2
 ;;^UTILITY(U,$J,358.3,678,2)
 ;;=^331942
 ;;^UTILITY(U,$J,358.3,679,0)
 ;;=F15.929^^3^68^7
 ;;^UTILITY(U,$J,358.3,679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,679,1,3,0)
 ;;=3^Caffeine Intoxication
 ;;^UTILITY(U,$J,358.3,679,1,4,0)
 ;;=4^F15.929
 ;;^UTILITY(U,$J,358.3,679,2)
 ;;=^5003314
 ;;^UTILITY(U,$J,358.3,680,0)
 ;;=F15.93^^3^68^8
 ;;^UTILITY(U,$J,358.3,680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,680,1,3,0)
 ;;=3^Caffeine Withdrawal
 ;;^UTILITY(U,$J,358.3,680,1,4,0)
 ;;=4^F15.93
 ;;^UTILITY(U,$J,358.3,680,2)
 ;;=^5003315
 ;;^UTILITY(U,$J,358.3,681,0)
 ;;=F15.180^^3^68^1
 ;;^UTILITY(U,$J,358.3,681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,681,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,681,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,681,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,682,0)
 ;;=F15.280^^3^68^2
 ;;^UTILITY(U,$J,358.3,682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,682,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,682,1,4,0)
 ;;=4^F15.280
