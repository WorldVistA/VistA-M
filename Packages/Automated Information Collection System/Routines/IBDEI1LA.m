IBDEI1LA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26945,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,26945,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,26945,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,26946,0)
 ;;=F17.201^^100^1298^10
 ;;^UTILITY(U,$J,358.3,26946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26946,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,26946,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,26946,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,26947,0)
 ;;=F17.203^^100^1298^11
 ;;^UTILITY(U,$J,358.3,26947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26947,1,3,0)
 ;;=3^Nicotine Withdrawal
 ;;^UTILITY(U,$J,358.3,26947,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,26947,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,26948,0)
 ;;=F17.210^^100^1298^4
 ;;^UTILITY(U,$J,358.3,26948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26948,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,26948,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,26948,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,26949,0)
 ;;=F17.211^^100^1298^3
 ;;^UTILITY(U,$J,358.3,26949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26949,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,26949,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,26949,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,26950,0)
 ;;=F17.220^^100^1298^2
 ;;^UTILITY(U,$J,358.3,26950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26950,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,26950,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,26950,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,26951,0)
 ;;=F17.221^^100^1298^1
 ;;^UTILITY(U,$J,358.3,26951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26951,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,26951,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,26951,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,26952,0)
 ;;=F17.290^^100^1298^5
 ;;^UTILITY(U,$J,358.3,26952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26952,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,26952,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,26952,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,26953,0)
 ;;=F17.291^^100^1298^6
 ;;^UTILITY(U,$J,358.3,26953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26953,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,26953,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,26953,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,26954,0)
 ;;=F17.208^^100^1298^7
 ;;^UTILITY(U,$J,358.3,26954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26954,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26954,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,26954,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,26955,0)
 ;;=F17.209^^100^1298^8
 ;;^UTILITY(U,$J,358.3,26955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26955,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26955,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,26955,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,26956,0)
 ;;=F14.10^^100^1299^1
 ;;^UTILITY(U,$J,358.3,26956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26956,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26956,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,26956,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,26957,0)
 ;;=F14.14^^100^1299^5
 ;;^UTILITY(U,$J,358.3,26957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26957,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
