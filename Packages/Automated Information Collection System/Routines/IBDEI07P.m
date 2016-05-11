IBDEI07P ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3299,1,3,0)
 ;;=3^Infection,Mycoses,Unspec
 ;;^UTILITY(U,$J,358.3,3299,1,4,0)
 ;;=4^B49.
 ;;^UTILITY(U,$J,358.3,3299,2)
 ;;=^5000690
 ;;^UTILITY(U,$J,358.3,3300,0)
 ;;=B89.^^18^217^14
 ;;^UTILITY(U,$J,358.3,3300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3300,1,3,0)
 ;;=3^Infection,Parasitic Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3300,1,4,0)
 ;;=4^B89.
 ;;^UTILITY(U,$J,358.3,3300,2)
 ;;=^5000822
 ;;^UTILITY(U,$J,358.3,3301,0)
 ;;=B64.^^18^217^15
 ;;^UTILITY(U,$J,358.3,3301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3301,1,3,0)
 ;;=3^Infection,Protozoal Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3301,1,4,0)
 ;;=4^B64.
 ;;^UTILITY(U,$J,358.3,3301,2)
 ;;=^5000742
 ;;^UTILITY(U,$J,358.3,3302,0)
 ;;=A77.9^^18^217^17
 ;;^UTILITY(U,$J,358.3,3302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3302,1,3,0)
 ;;=3^Infection,Spotted Fever,Unspec
 ;;^UTILITY(U,$J,358.3,3302,1,4,0)
 ;;=4^A77.9
 ;;^UTILITY(U,$J,358.3,3302,2)
 ;;=^5000399
 ;;^UTILITY(U,$J,358.3,3303,0)
 ;;=A64.^^18^217^16
 ;;^UTILITY(U,$J,358.3,3303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3303,1,3,0)
 ;;=3^Infection,Sexually Transmitted Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3303,1,4,0)
 ;;=4^A64.
 ;;^UTILITY(U,$J,358.3,3303,2)
 ;;=^5000362
 ;;^UTILITY(U,$J,358.3,3304,0)
 ;;=A49.1^^18^217^18
 ;;^UTILITY(U,$J,358.3,3304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3304,1,3,0)
 ;;=3^Infection,Streptococcal,Unspec Site
 ;;^UTILITY(U,$J,358.3,3304,1,4,0)
 ;;=4^A49.1
 ;;^UTILITY(U,$J,358.3,3304,2)
 ;;=^5000237
 ;;^UTILITY(U,$J,358.3,3305,0)
 ;;=A15.9^^18^217^19
 ;;^UTILITY(U,$J,358.3,3305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3305,1,3,0)
 ;;=3^Infection,Tuberculosis,Respiratory,Unspec
 ;;^UTILITY(U,$J,358.3,3305,1,4,0)
 ;;=4^A15.9
 ;;^UTILITY(U,$J,358.3,3305,2)
 ;;=^5000066
 ;;^UTILITY(U,$J,358.3,3306,0)
 ;;=B01.9^^18^217^20
 ;;^UTILITY(U,$J,358.3,3306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3306,1,3,0)
 ;;=3^Infection,Varicella w/o Complication
 ;;^UTILITY(U,$J,358.3,3306,1,4,0)
 ;;=4^B01.9
 ;;^UTILITY(U,$J,358.3,3306,2)
 ;;=^5000487
 ;;^UTILITY(U,$J,358.3,3307,0)
 ;;=A86.^^18^217^21
 ;;^UTILITY(U,$J,358.3,3307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3307,1,3,0)
 ;;=3^Infection,Viral Encephalitis,Unspec
 ;;^UTILITY(U,$J,358.3,3307,1,4,0)
 ;;=4^A86.
 ;;^UTILITY(U,$J,358.3,3307,2)
 ;;=^5000431
 ;;^UTILITY(U,$J,358.3,3308,0)
 ;;=B19.9^^18^217^22
 ;;^UTILITY(U,$J,358.3,3308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3308,1,3,0)
 ;;=3^Infection,Viral Hepatitis w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,3308,1,4,0)
 ;;=4^B19.9
 ;;^UTILITY(U,$J,358.3,3308,2)
 ;;=^5000554
 ;;^UTILITY(U,$J,358.3,3309,0)
 ;;=A87.9^^18^217^23
 ;;^UTILITY(U,$J,358.3,3309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3309,1,3,0)
 ;;=3^Infection,Viral Meningitis,Unspec
 ;;^UTILITY(U,$J,358.3,3309,1,4,0)
 ;;=4^A87.9
 ;;^UTILITY(U,$J,358.3,3309,2)
 ;;=^5000435
 ;;^UTILITY(U,$J,358.3,3310,0)
 ;;=B34.9^^18^217^24
 ;;^UTILITY(U,$J,358.3,3310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3310,1,3,0)
 ;;=3^Infection,Viral,Unspec
 ;;^UTILITY(U,$J,358.3,3310,1,4,0)
 ;;=4^B34.9
 ;;^UTILITY(U,$J,358.3,3310,2)
 ;;=^5000603
 ;;^UTILITY(U,$J,358.3,3311,0)
 ;;=B02.9^^18^217^25
 ;;^UTILITY(U,$J,358.3,3311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3311,1,3,0)
 ;;=3^Infection,Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,3311,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,3311,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,3312,0)
 ;;=Z87.01^^18^217^26
 ;;^UTILITY(U,$J,358.3,3312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3312,1,3,0)
 ;;=3^Person Hx of Pneumonia
