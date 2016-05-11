IBDEI0OB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11356,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,11356,2)
 ;;=^5000555
 ;;^UTILITY(U,$J,358.3,11357,0)
 ;;=B82.9^^47^531^10
 ;;^UTILITY(U,$J,358.3,11357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11357,1,3,0)
 ;;=3^Infection,Intestinal Parasitism,Unspec
 ;;^UTILITY(U,$J,358.3,11357,1,4,0)
 ;;=4^B82.9
 ;;^UTILITY(U,$J,358.3,11357,2)
 ;;=^5000798
 ;;^UTILITY(U,$J,358.3,11358,0)
 ;;=A49.02^^47^531^11
 ;;^UTILITY(U,$J,358.3,11358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11358,1,3,0)
 ;;=3^Infection,MRSA,Unspec Site
 ;;^UTILITY(U,$J,358.3,11358,1,4,0)
 ;;=4^A49.02
 ;;^UTILITY(U,$J,358.3,11358,2)
 ;;=^5000236
 ;;^UTILITY(U,$J,358.3,11359,0)
 ;;=A49.3^^47^531^12
 ;;^UTILITY(U,$J,358.3,11359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11359,1,3,0)
 ;;=3^Infection,Mycoplasma,Unspec Site
 ;;^UTILITY(U,$J,358.3,11359,1,4,0)
 ;;=4^A49.3
 ;;^UTILITY(U,$J,358.3,11359,2)
 ;;=^5000239
 ;;^UTILITY(U,$J,358.3,11360,0)
 ;;=B49.^^47^531^13
 ;;^UTILITY(U,$J,358.3,11360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11360,1,3,0)
 ;;=3^Infection,Mycoses,Unspec
 ;;^UTILITY(U,$J,358.3,11360,1,4,0)
 ;;=4^B49.
 ;;^UTILITY(U,$J,358.3,11360,2)
 ;;=^5000690
 ;;^UTILITY(U,$J,358.3,11361,0)
 ;;=B89.^^47^531^14
 ;;^UTILITY(U,$J,358.3,11361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11361,1,3,0)
 ;;=3^Infection,Parasitic Disease,Unspec
 ;;^UTILITY(U,$J,358.3,11361,1,4,0)
 ;;=4^B89.
 ;;^UTILITY(U,$J,358.3,11361,2)
 ;;=^5000822
 ;;^UTILITY(U,$J,358.3,11362,0)
 ;;=B64.^^47^531^15
 ;;^UTILITY(U,$J,358.3,11362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11362,1,3,0)
 ;;=3^Infection,Protozoal Disease,Unspec
 ;;^UTILITY(U,$J,358.3,11362,1,4,0)
 ;;=4^B64.
 ;;^UTILITY(U,$J,358.3,11362,2)
 ;;=^5000742
 ;;^UTILITY(U,$J,358.3,11363,0)
 ;;=A77.9^^47^531^17
 ;;^UTILITY(U,$J,358.3,11363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11363,1,3,0)
 ;;=3^Infection,Spotted Fever,Unspec
 ;;^UTILITY(U,$J,358.3,11363,1,4,0)
 ;;=4^A77.9
 ;;^UTILITY(U,$J,358.3,11363,2)
 ;;=^5000399
 ;;^UTILITY(U,$J,358.3,11364,0)
 ;;=A64.^^47^531^16
 ;;^UTILITY(U,$J,358.3,11364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11364,1,3,0)
 ;;=3^Infection,Sexually Transmitted Disease,Unspec
 ;;^UTILITY(U,$J,358.3,11364,1,4,0)
 ;;=4^A64.
 ;;^UTILITY(U,$J,358.3,11364,2)
 ;;=^5000362
 ;;^UTILITY(U,$J,358.3,11365,0)
 ;;=A49.1^^47^531^18
 ;;^UTILITY(U,$J,358.3,11365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11365,1,3,0)
 ;;=3^Infection,Streptococcal,Unspec Site
 ;;^UTILITY(U,$J,358.3,11365,1,4,0)
 ;;=4^A49.1
 ;;^UTILITY(U,$J,358.3,11365,2)
 ;;=^5000237
 ;;^UTILITY(U,$J,358.3,11366,0)
 ;;=A15.9^^47^531^19
 ;;^UTILITY(U,$J,358.3,11366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11366,1,3,0)
 ;;=3^Infection,Tuberculosis,Respiratory,Unspec
 ;;^UTILITY(U,$J,358.3,11366,1,4,0)
 ;;=4^A15.9
 ;;^UTILITY(U,$J,358.3,11366,2)
 ;;=^5000066
 ;;^UTILITY(U,$J,358.3,11367,0)
 ;;=B01.9^^47^531^20
 ;;^UTILITY(U,$J,358.3,11367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11367,1,3,0)
 ;;=3^Infection,Varicella w/o Complication
 ;;^UTILITY(U,$J,358.3,11367,1,4,0)
 ;;=4^B01.9
 ;;^UTILITY(U,$J,358.3,11367,2)
 ;;=^5000487
 ;;^UTILITY(U,$J,358.3,11368,0)
 ;;=A86.^^47^531^21
 ;;^UTILITY(U,$J,358.3,11368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11368,1,3,0)
 ;;=3^Infection,Viral Encephalitis,Unspec
 ;;^UTILITY(U,$J,358.3,11368,1,4,0)
 ;;=4^A86.
 ;;^UTILITY(U,$J,358.3,11368,2)
 ;;=^5000431
 ;;^UTILITY(U,$J,358.3,11369,0)
 ;;=B19.9^^47^531^22
 ;;^UTILITY(U,$J,358.3,11369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11369,1,3,0)
 ;;=3^Infection,Viral Hepatitis w/o Hepatic Coma
