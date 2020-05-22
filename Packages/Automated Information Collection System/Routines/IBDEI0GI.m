IBDEI0GI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7150,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,7150,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,7151,0)
 ;;=F12.20^^58^470^10
 ;;^UTILITY(U,$J,358.3,7151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7151,1,3,0)
 ;;=3^Cannabis Dependence,Mod/Sev,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7151,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,7151,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,7152,0)
 ;;=F14.188^^58^470^11
 ;;^UTILITY(U,$J,358.3,7152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7152,1,3,0)
 ;;=3^Cocaine Abuse,Mild w/ Oth Cocaine-Induced D/O
 ;;^UTILITY(U,$J,358.3,7152,1,4,0)
 ;;=4^F14.188
 ;;^UTILITY(U,$J,358.3,7152,2)
 ;;=^5003251
 ;;^UTILITY(U,$J,358.3,7153,0)
 ;;=F14.20^^58^470^12
 ;;^UTILITY(U,$J,358.3,7153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7153,1,3,0)
 ;;=3^Cocaine Dependence,Mod/Sev,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7153,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,7153,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,7154,0)
 ;;=F15.10^^58^470^21
 ;;^UTILITY(U,$J,358.3,7154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7154,1,3,0)
 ;;=3^Stimulant Abuse,Mild,Uncomplicated,Oth
 ;;^UTILITY(U,$J,358.3,7154,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,7154,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,7155,0)
 ;;=F15.20^^58^470^22
 ;;^UTILITY(U,$J,358.3,7155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7155,1,3,0)
 ;;=3^Stimulant Depend,Mod/Sev,Uncomplicated,Oth
 ;;^UTILITY(U,$J,358.3,7155,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,7155,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,7156,0)
 ;;=F17.210^^58^470^15
 ;;^UTILITY(U,$J,358.3,7156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7156,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7156,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,7156,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,7157,0)
 ;;=F17.211^^58^470^14
 ;;^UTILITY(U,$J,358.3,7157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7157,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,7157,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,7157,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,7158,0)
 ;;=F17.293^^58^470^13
 ;;^UTILITY(U,$J,358.3,7158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7158,1,3,0)
 ;;=3^Nicotine Dependence w/ Withdrawal,Other Tobacco Product
 ;;^UTILITY(U,$J,358.3,7158,1,4,0)
 ;;=4^F17.293
 ;;^UTILITY(U,$J,358.3,7158,2)
 ;;=^5003377
 ;;^UTILITY(U,$J,358.3,7159,0)
 ;;=F19.10^^58^470^18
 ;;^UTILITY(U,$J,358.3,7159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7159,1,3,0)
 ;;=3^Psychoactive Subs Abuse,Mild,Uncomplicated,Oth
 ;;^UTILITY(U,$J,358.3,7159,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,7159,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,7160,0)
 ;;=F19.20^^58^470^19
 ;;^UTILITY(U,$J,358.3,7160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7160,1,3,0)
 ;;=3^Psychoactive Substance Dependence,Uncomplicated,Other
 ;;^UTILITY(U,$J,358.3,7160,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,7160,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,7161,0)
 ;;=F10.11^^58^470^1
 ;;^UTILITY(U,$J,358.3,7161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7161,1,3,0)
 ;;=3^Alcohol Abuse,Mild,In Remission
 ;;^UTILITY(U,$J,358.3,7161,1,4,0)
 ;;=4^F10.11
 ;;^UTILITY(U,$J,358.3,7161,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,7162,0)
 ;;=F19.11^^58^470^17
 ;;^UTILITY(U,$J,358.3,7162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7162,1,3,0)
 ;;=3^Psychoactive Subs Abuse,Mild,Oth,In Remission
