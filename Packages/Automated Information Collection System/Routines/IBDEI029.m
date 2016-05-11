IBDEI029 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,562,0)
 ;;=F17.201^^3^56^10
 ;;^UTILITY(U,$J,358.3,562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,562,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,562,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,562,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,563,0)
 ;;=F17.203^^3^56^11
 ;;^UTILITY(U,$J,358.3,563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,563,1,3,0)
 ;;=3^Nicotine Withdrawal
 ;;^UTILITY(U,$J,358.3,563,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,563,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,564,0)
 ;;=F17.210^^3^56^4
 ;;^UTILITY(U,$J,358.3,564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,564,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,564,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,564,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,565,0)
 ;;=F17.211^^3^56^3
 ;;^UTILITY(U,$J,358.3,565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,565,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,565,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,565,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,566,0)
 ;;=F17.220^^3^56^2
 ;;^UTILITY(U,$J,358.3,566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,566,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,566,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,566,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,567,0)
 ;;=F17.221^^3^56^1
 ;;^UTILITY(U,$J,358.3,567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,567,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,567,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,567,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,568,0)
 ;;=F17.290^^3^56^5
 ;;^UTILITY(U,$J,358.3,568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,568,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,568,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,568,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,569,0)
 ;;=F17.291^^3^56^6
 ;;^UTILITY(U,$J,358.3,569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,569,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,569,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,569,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,570,0)
 ;;=F17.208^^3^56^7
 ;;^UTILITY(U,$J,358.3,570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,570,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,570,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,570,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,571,0)
 ;;=F17.209^^3^56^8
 ;;^UTILITY(U,$J,358.3,571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,571,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,571,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,571,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,572,0)
 ;;=F14.10^^3^57^1
 ;;^UTILITY(U,$J,358.3,572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,572,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,572,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,572,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,573,0)
 ;;=F14.14^^3^57^5
 ;;^UTILITY(U,$J,358.3,573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,573,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,573,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,573,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,574,0)
 ;;=F14.182^^3^57^6
 ;;^UTILITY(U,$J,358.3,574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,574,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,574,1,4,0)
 ;;=4^F14.182
