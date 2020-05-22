IBDEI2M3 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41708,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,41708,1,4,0)
 ;;=4^T84.83XA
 ;;^UTILITY(U,$J,358.3,41708,2)
 ;;=^5055460
 ;;^UTILITY(U,$J,358.3,41709,0)
 ;;=T84.83XD^^155^2063^11
 ;;^UTILITY(U,$J,358.3,41709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41709,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,41709,1,4,0)
 ;;=4^T84.83XD
 ;;^UTILITY(U,$J,358.3,41709,2)
 ;;=^5055461
 ;;^UTILITY(U,$J,358.3,41710,0)
 ;;=T84.83XS^^155^2063^12
 ;;^UTILITY(U,$J,358.3,41710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41710,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,41710,1,4,0)
 ;;=4^T84.83XS
 ;;^UTILITY(U,$J,358.3,41710,2)
 ;;=^5055462
 ;;^UTILITY(U,$J,358.3,41711,0)
 ;;=T84.89XA^^155^2063^1
 ;;^UTILITY(U,$J,358.3,41711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41711,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,41711,1,4,0)
 ;;=4^T84.89XA
 ;;^UTILITY(U,$J,358.3,41711,2)
 ;;=^5055472
 ;;^UTILITY(U,$J,358.3,41712,0)
 ;;=T84.89XD^^155^2063^2
 ;;^UTILITY(U,$J,358.3,41712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41712,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,41712,1,4,0)
 ;;=4^T84.89XD
 ;;^UTILITY(U,$J,358.3,41712,2)
 ;;=^5055473
 ;;^UTILITY(U,$J,358.3,41713,0)
 ;;=T84.89XS^^155^2063^3
 ;;^UTILITY(U,$J,358.3,41713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41713,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,41713,1,4,0)
 ;;=4^T84.89XS
 ;;^UTILITY(U,$J,358.3,41713,2)
 ;;=^5055474
 ;;^UTILITY(U,$J,358.3,41714,0)
 ;;=T84.84XA^^155^2063^13
 ;;^UTILITY(U,$J,358.3,41714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41714,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,41714,1,4,0)
 ;;=4^T84.84XA
 ;;^UTILITY(U,$J,358.3,41714,2)
 ;;=^5055463
 ;;^UTILITY(U,$J,358.3,41715,0)
 ;;=T84.84XD^^155^2063^14
 ;;^UTILITY(U,$J,358.3,41715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41715,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,41715,1,4,0)
 ;;=4^T84.84XD
 ;;^UTILITY(U,$J,358.3,41715,2)
 ;;=^5055464
 ;;^UTILITY(U,$J,358.3,41716,0)
 ;;=T84.84XS^^155^2063^15
 ;;^UTILITY(U,$J,358.3,41716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41716,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,41716,1,4,0)
 ;;=4^T84.84XS
 ;;^UTILITY(U,$J,358.3,41716,2)
 ;;=^5055465
 ;;^UTILITY(U,$J,358.3,41717,0)
 ;;=T84.85XA^^155^2063^16
 ;;^UTILITY(U,$J,358.3,41717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41717,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,41717,1,4,0)
 ;;=4^T84.85XA
 ;;^UTILITY(U,$J,358.3,41717,2)
 ;;=^5055466
 ;;^UTILITY(U,$J,358.3,41718,0)
 ;;=T84.85XD^^155^2063^17
 ;;^UTILITY(U,$J,358.3,41718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41718,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,41718,1,4,0)
 ;;=4^T84.85XD
 ;;^UTILITY(U,$J,358.3,41718,2)
 ;;=^5055467
 ;;^UTILITY(U,$J,358.3,41719,0)
 ;;=T84.85XS^^155^2063^18
 ;;^UTILITY(U,$J,358.3,41719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41719,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, sequela
