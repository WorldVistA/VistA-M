IBDEI1H1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24981,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,24981,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,24981,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,24982,0)
 ;;=F17.200^^93^1123^9
 ;;^UTILITY(U,$J,358.3,24982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24982,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24982,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,24982,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,24983,0)
 ;;=F17.201^^93^1123^10
 ;;^UTILITY(U,$J,358.3,24983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24983,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,24983,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,24983,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,24984,0)
 ;;=F17.203^^93^1123^11
 ;;^UTILITY(U,$J,358.3,24984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24984,1,3,0)
 ;;=3^Nicotine Withdrawal
 ;;^UTILITY(U,$J,358.3,24984,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,24984,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,24985,0)
 ;;=F17.210^^93^1123^4
 ;;^UTILITY(U,$J,358.3,24985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24985,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24985,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,24985,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,24986,0)
 ;;=F17.211^^93^1123^3
 ;;^UTILITY(U,$J,358.3,24986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24986,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,24986,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,24986,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,24987,0)
 ;;=F17.220^^93^1123^2
 ;;^UTILITY(U,$J,358.3,24987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24987,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24987,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,24987,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,24988,0)
 ;;=F17.221^^93^1123^1
 ;;^UTILITY(U,$J,358.3,24988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24988,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,24988,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,24988,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,24989,0)
 ;;=F17.290^^93^1123^5
 ;;^UTILITY(U,$J,358.3,24989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24989,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24989,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,24989,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,24990,0)
 ;;=F17.291^^93^1123^6
 ;;^UTILITY(U,$J,358.3,24990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24990,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,24990,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,24990,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,24991,0)
 ;;=F17.208^^93^1123^7
 ;;^UTILITY(U,$J,358.3,24991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24991,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24991,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,24991,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,24992,0)
 ;;=F17.209^^93^1123^8
 ;;^UTILITY(U,$J,358.3,24992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24992,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24992,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,24992,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,24993,0)
 ;;=F14.10^^93^1124^1
 ;;^UTILITY(U,$J,358.3,24993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24993,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24993,1,4,0)
 ;;=4^F14.10
