IBDEI08V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3601,1,4,0)
 ;;=4^A15.9
 ;;^UTILITY(U,$J,358.3,3601,2)
 ;;=^5000066
 ;;^UTILITY(U,$J,358.3,3602,0)
 ;;=B01.9^^28^256^20
 ;;^UTILITY(U,$J,358.3,3602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3602,1,3,0)
 ;;=3^Infection,Varicella w/o Complication
 ;;^UTILITY(U,$J,358.3,3602,1,4,0)
 ;;=4^B01.9
 ;;^UTILITY(U,$J,358.3,3602,2)
 ;;=^5000487
 ;;^UTILITY(U,$J,358.3,3603,0)
 ;;=A86.^^28^256^21
 ;;^UTILITY(U,$J,358.3,3603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3603,1,3,0)
 ;;=3^Infection,Viral Encephalitis,Unspec
 ;;^UTILITY(U,$J,358.3,3603,1,4,0)
 ;;=4^A86.
 ;;^UTILITY(U,$J,358.3,3603,2)
 ;;=^5000431
 ;;^UTILITY(U,$J,358.3,3604,0)
 ;;=B19.9^^28^256^22
 ;;^UTILITY(U,$J,358.3,3604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3604,1,3,0)
 ;;=3^Infection,Viral Hepatitis w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,3604,1,4,0)
 ;;=4^B19.9
 ;;^UTILITY(U,$J,358.3,3604,2)
 ;;=^5000554
 ;;^UTILITY(U,$J,358.3,3605,0)
 ;;=A87.9^^28^256^23
 ;;^UTILITY(U,$J,358.3,3605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3605,1,3,0)
 ;;=3^Infection,Viral Meningitis,Unspec
 ;;^UTILITY(U,$J,358.3,3605,1,4,0)
 ;;=4^A87.9
 ;;^UTILITY(U,$J,358.3,3605,2)
 ;;=^5000435
 ;;^UTILITY(U,$J,358.3,3606,0)
 ;;=B34.9^^28^256^24
 ;;^UTILITY(U,$J,358.3,3606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3606,1,3,0)
 ;;=3^Infection,Viral,Unspec
 ;;^UTILITY(U,$J,358.3,3606,1,4,0)
 ;;=4^B34.9
 ;;^UTILITY(U,$J,358.3,3606,2)
 ;;=^5000603
 ;;^UTILITY(U,$J,358.3,3607,0)
 ;;=B02.9^^28^256^25
 ;;^UTILITY(U,$J,358.3,3607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3607,1,3,0)
 ;;=3^Infection,Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,3607,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,3607,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,3608,0)
 ;;=Z87.01^^28^256^26
 ;;^UTILITY(U,$J,358.3,3608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3608,1,3,0)
 ;;=3^Person Hx of Pneumonia
 ;;^UTILITY(U,$J,358.3,3608,1,4,0)
 ;;=4^Z87.01
 ;;^UTILITY(U,$J,358.3,3608,2)
 ;;=^5063480
 ;;^UTILITY(U,$J,358.3,3609,0)
 ;;=Z86.11^^28^256^29
 ;;^UTILITY(U,$J,358.3,3609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3609,1,3,0)
 ;;=3^Personal Hx of Tuberculosis
 ;;^UTILITY(U,$J,358.3,3609,1,4,0)
 ;;=4^Z86.11
 ;;^UTILITY(U,$J,358.3,3609,2)
 ;;=^5063461
 ;;^UTILITY(U,$J,358.3,3610,0)
 ;;=Z86.13^^28^256^28
 ;;^UTILITY(U,$J,358.3,3610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3610,1,3,0)
 ;;=3^Personal Hx of Malaria
 ;;^UTILITY(U,$J,358.3,3610,1,4,0)
 ;;=4^Z86.13
 ;;^UTILITY(U,$J,358.3,3610,2)
 ;;=^5063463
 ;;^UTILITY(U,$J,358.3,3611,0)
 ;;=Z86.14^^28^256^27
 ;;^UTILITY(U,$J,358.3,3611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3611,1,3,0)
 ;;=3^Personal Hx of MRSA
 ;;^UTILITY(U,$J,358.3,3611,1,4,0)
 ;;=4^Z86.14
 ;;^UTILITY(U,$J,358.3,3611,2)
 ;;=^5063464
 ;;^UTILITY(U,$J,358.3,3612,0)
 ;;=B94.9^^28^256^30
 ;;^UTILITY(U,$J,358.3,3612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3612,1,3,0)
 ;;=3^Sequelae of Infectious/Parasitic Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3612,1,4,0)
 ;;=4^B94.9
 ;;^UTILITY(U,$J,358.3,3612,2)
 ;;=^5000834
 ;;^UTILITY(U,$J,358.3,3613,0)
 ;;=B91.^^28^256^31
 ;;^UTILITY(U,$J,358.3,3613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3613,1,3,0)
 ;;=3^Sequelae of Poliomyelitis
 ;;^UTILITY(U,$J,358.3,3613,1,4,0)
 ;;=4^B91.
 ;;^UTILITY(U,$J,358.3,3613,2)
 ;;=^5000828
 ;;^UTILITY(U,$J,358.3,3614,0)
 ;;=B90.9^^28^256^32
 ;;^UTILITY(U,$J,358.3,3614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3614,1,3,0)
 ;;=3^Sequelae of Tuberculosis,Respiratory & Unspec
 ;;^UTILITY(U,$J,358.3,3614,1,4,0)
 ;;=4^B90.9
 ;;^UTILITY(U,$J,358.3,3614,2)
 ;;=^5000827
