IBDEI08U ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3588,1,3,0)
 ;;=3^Infection,Dermatophytosis,Unspec
 ;;^UTILITY(U,$J,358.3,3588,1,4,0)
 ;;=4^B35.9
 ;;^UTILITY(U,$J,358.3,3588,2)
 ;;=^5000607
 ;;^UTILITY(U,$J,358.3,3589,0)
 ;;=A49.2^^28^256^8
 ;;^UTILITY(U,$J,358.3,3589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3589,1,3,0)
 ;;=3^Infection,Hemophilus Influenzae
 ;;^UTILITY(U,$J,358.3,3589,1,4,0)
 ;;=4^A49.2
 ;;^UTILITY(U,$J,358.3,3589,2)
 ;;=^5000238
 ;;^UTILITY(U,$J,358.3,3590,0)
 ;;=B00.9^^28^256^9
 ;;^UTILITY(U,$J,358.3,3590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3590,1,3,0)
 ;;=3^Infection,Herpesviral,Unspec
 ;;^UTILITY(U,$J,358.3,3590,1,4,0)
 ;;=4^B00.9
 ;;^UTILITY(U,$J,358.3,3590,2)
 ;;=^5000480
 ;;^UTILITY(U,$J,358.3,3591,0)
 ;;=B20.^^28^256^7
 ;;^UTILITY(U,$J,358.3,3591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3591,1,3,0)
 ;;=3^Infection,HIV
 ;;^UTILITY(U,$J,358.3,3591,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,3591,2)
 ;;=^5000555
 ;;^UTILITY(U,$J,358.3,3592,0)
 ;;=B82.9^^28^256^10
 ;;^UTILITY(U,$J,358.3,3592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3592,1,3,0)
 ;;=3^Infection,Intestinal Parasitism,Unspec
 ;;^UTILITY(U,$J,358.3,3592,1,4,0)
 ;;=4^B82.9
 ;;^UTILITY(U,$J,358.3,3592,2)
 ;;=^5000798
 ;;^UTILITY(U,$J,358.3,3593,0)
 ;;=A49.02^^28^256^11
 ;;^UTILITY(U,$J,358.3,3593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3593,1,3,0)
 ;;=3^Infection,MRSA,Unspec Site
 ;;^UTILITY(U,$J,358.3,3593,1,4,0)
 ;;=4^A49.02
 ;;^UTILITY(U,$J,358.3,3593,2)
 ;;=^5000236
 ;;^UTILITY(U,$J,358.3,3594,0)
 ;;=A49.3^^28^256^12
 ;;^UTILITY(U,$J,358.3,3594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3594,1,3,0)
 ;;=3^Infection,Mycoplasma,Unspec Site
 ;;^UTILITY(U,$J,358.3,3594,1,4,0)
 ;;=4^A49.3
 ;;^UTILITY(U,$J,358.3,3594,2)
 ;;=^5000239
 ;;^UTILITY(U,$J,358.3,3595,0)
 ;;=B49.^^28^256^13
 ;;^UTILITY(U,$J,358.3,3595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3595,1,3,0)
 ;;=3^Infection,Mycoses,Unspec
 ;;^UTILITY(U,$J,358.3,3595,1,4,0)
 ;;=4^B49.
 ;;^UTILITY(U,$J,358.3,3595,2)
 ;;=^5000690
 ;;^UTILITY(U,$J,358.3,3596,0)
 ;;=B89.^^28^256^14
 ;;^UTILITY(U,$J,358.3,3596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3596,1,3,0)
 ;;=3^Infection,Parasitic Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3596,1,4,0)
 ;;=4^B89.
 ;;^UTILITY(U,$J,358.3,3596,2)
 ;;=^5000822
 ;;^UTILITY(U,$J,358.3,3597,0)
 ;;=B64.^^28^256^15
 ;;^UTILITY(U,$J,358.3,3597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3597,1,3,0)
 ;;=3^Infection,Protozoal Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3597,1,4,0)
 ;;=4^B64.
 ;;^UTILITY(U,$J,358.3,3597,2)
 ;;=^5000742
 ;;^UTILITY(U,$J,358.3,3598,0)
 ;;=A77.9^^28^256^17
 ;;^UTILITY(U,$J,358.3,3598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3598,1,3,0)
 ;;=3^Infection,Spotted Fever,Unspec
 ;;^UTILITY(U,$J,358.3,3598,1,4,0)
 ;;=4^A77.9
 ;;^UTILITY(U,$J,358.3,3598,2)
 ;;=^5000399
 ;;^UTILITY(U,$J,358.3,3599,0)
 ;;=A64.^^28^256^16
 ;;^UTILITY(U,$J,358.3,3599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3599,1,3,0)
 ;;=3^Infection,Sexually Transmitted Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3599,1,4,0)
 ;;=4^A64.
 ;;^UTILITY(U,$J,358.3,3599,2)
 ;;=^5000362
 ;;^UTILITY(U,$J,358.3,3600,0)
 ;;=A49.1^^28^256^18
 ;;^UTILITY(U,$J,358.3,3600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3600,1,3,0)
 ;;=3^Infection,Streptococcal,Unspec Site
 ;;^UTILITY(U,$J,358.3,3600,1,4,0)
 ;;=4^A49.1
 ;;^UTILITY(U,$J,358.3,3600,2)
 ;;=^5000237
 ;;^UTILITY(U,$J,358.3,3601,0)
 ;;=A15.9^^28^256^19
 ;;^UTILITY(U,$J,358.3,3601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3601,1,3,0)
 ;;=3^Infection,Tuberculosis,Respiratory,Unspec
