IBDEI02L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,445,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,445,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,445,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,446,0)
 ;;=F17.221^^3^56^7
 ;;^UTILITY(U,$J,358.3,446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,446,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,446,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,446,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,447,0)
 ;;=F17.290^^3^56^8
 ;;^UTILITY(U,$J,358.3,447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,447,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,447,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,447,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,448,0)
 ;;=F17.291^^3^56^9
 ;;^UTILITY(U,$J,358.3,448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,448,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,448,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,448,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,449,0)
 ;;=F14.10^^3^57^1
 ;;^UTILITY(U,$J,358.3,449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,449,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,449,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,449,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,450,0)
 ;;=F14.14^^3^57^5
 ;;^UTILITY(U,$J,358.3,450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,450,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,450,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,450,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,451,0)
 ;;=F14.182^^3^57^6
 ;;^UTILITY(U,$J,358.3,451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,451,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,451,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,451,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,452,0)
 ;;=F14.20^^3^57^3
 ;;^UTILITY(U,$J,358.3,452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,452,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,452,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,452,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,453,0)
 ;;=F14.21^^3^57^2
 ;;^UTILITY(U,$J,358.3,453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,453,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,453,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,453,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,454,0)
 ;;=F14.23^^3^57^4
 ;;^UTILITY(U,$J,358.3,454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,454,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,454,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,454,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,455,0)
 ;;=F43.0^^3^58^1
 ;;^UTILITY(U,$J,358.3,455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,455,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,455,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,455,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,456,0)
 ;;=F43.21^^3^58^3
 ;;^UTILITY(U,$J,358.3,456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,456,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,456,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,456,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,457,0)
 ;;=F43.22^^3^58^2
 ;;^UTILITY(U,$J,358.3,457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,457,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,457,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,457,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,458,0)
 ;;=F43.23^^3^58^5
 ;;^UTILITY(U,$J,358.3,458,1,0)
 ;;=^358.31IA^4^2
