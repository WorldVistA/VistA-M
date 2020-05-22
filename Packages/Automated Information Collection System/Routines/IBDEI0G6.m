IBDEI0G6 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6995,0)
 ;;=G0176^^57^451^1^^^^1
 ;;^UTILITY(U,$J,358.3,6995,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6995,1,2,0)
 ;;=2^G0176
 ;;^UTILITY(U,$J,358.3,6995,1,3,0)
 ;;=3^Activity Therapy,Not For Rec,Per Session,> 45 min
 ;;^UTILITY(U,$J,358.3,6996,0)
 ;;=S9451^^57^451^4^^^^1
 ;;^UTILITY(U,$J,358.3,6996,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6996,1,2,0)
 ;;=2^S9451
 ;;^UTILITY(U,$J,358.3,6996,1,3,0)
 ;;=3^Exercise Class
 ;;^UTILITY(U,$J,358.3,6997,0)
 ;;=S8940^^57^451^3^^^^1
 ;;^UTILITY(U,$J,358.3,6997,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6997,1,2,0)
 ;;=2^S8940
 ;;^UTILITY(U,$J,358.3,6997,1,3,0)
 ;;=3^Equestrian/Hippotherapy,per session
 ;;^UTILITY(U,$J,358.3,6998,0)
 ;;=H2032^^57^451^2^^^^1
 ;;^UTILITY(U,$J,358.3,6998,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6998,1,2,0)
 ;;=2^H2032
 ;;^UTILITY(U,$J,358.3,6998,1,3,0)
 ;;=3^Activity Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,6999,0)
 ;;=97810^^57^452^3^^^^1
 ;;^UTILITY(U,$J,358.3,6999,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6999,1,2,0)
 ;;=2^97810
 ;;^UTILITY(U,$J,358.3,6999,1,3,0)
 ;;=3^Acupuncture w/o Stimul,15 min
 ;;^UTILITY(U,$J,358.3,7000,0)
 ;;=97811^^57^452^4^^^^1
 ;;^UTILITY(U,$J,358.3,7000,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7000,1,2,0)
 ;;=2^97811
 ;;^UTILITY(U,$J,358.3,7000,1,3,0)
 ;;=3^Acupuncture w/o Stimul,Addl 15 min
 ;;^UTILITY(U,$J,358.3,7001,0)
 ;;=97813^^57^452^1^^^^1
 ;;^UTILITY(U,$J,358.3,7001,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7001,1,2,0)
 ;;=2^97813
 ;;^UTILITY(U,$J,358.3,7001,1,3,0)
 ;;=3^Acupuncture w/ Stimul,15 min
 ;;^UTILITY(U,$J,358.3,7002,0)
 ;;=97814^^57^452^2^^^^1
 ;;^UTILITY(U,$J,358.3,7002,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7002,1,2,0)
 ;;=2^97814
 ;;^UTILITY(U,$J,358.3,7002,1,3,0)
 ;;=3^Acupuncture w/ Stimul,Addl 15 min
 ;;^UTILITY(U,$J,358.3,7003,0)
 ;;=S8930^^57^452^5^^^^1
 ;;^UTILITY(U,$J,358.3,7003,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7003,1,2,0)
 ;;=2^S8930
 ;;^UTILITY(U,$J,358.3,7003,1,3,0)
 ;;=3^E-Stim Auricular Acup Pnts;Ea 15 min
 ;;^UTILITY(U,$J,358.3,7004,0)
 ;;=98925^^57^453^1^^^^1
 ;;^UTILITY(U,$J,358.3,7004,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7004,1,2,0)
 ;;=2^98925
 ;;^UTILITY(U,$J,358.3,7004,1,3,0)
 ;;=3^Osteopathic Manipulation;1-2 Body Regions
 ;;^UTILITY(U,$J,358.3,7005,0)
 ;;=98926^^57^453^2^^^^1
 ;;^UTILITY(U,$J,358.3,7005,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7005,1,2,0)
 ;;=2^98926
 ;;^UTILITY(U,$J,358.3,7005,1,3,0)
 ;;=3^Osteopathic Manipulation;3-4 Body Regions
 ;;^UTILITY(U,$J,358.3,7006,0)
 ;;=98927^^57^453^3^^^^1
 ;;^UTILITY(U,$J,358.3,7006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7006,1,2,0)
 ;;=2^98927
 ;;^UTILITY(U,$J,358.3,7006,1,3,0)
 ;;=3^Osteopathic Manipulation;5-6 Body Regions
 ;;^UTILITY(U,$J,358.3,7007,0)
 ;;=98929^^57^453^4^^^^1
 ;;^UTILITY(U,$J,358.3,7007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7007,1,2,0)
 ;;=2^98929
 ;;^UTILITY(U,$J,358.3,7007,1,3,0)
 ;;=3^Osteopathic Manipulation;9-10 Body Regions
 ;;^UTILITY(U,$J,358.3,7008,0)
 ;;=98940^^57^454^2^^^^1
 ;;^UTILITY(U,$J,358.3,7008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7008,1,2,0)
 ;;=2^98940
 ;;^UTILITY(U,$J,358.3,7008,1,3,0)
 ;;=3^Chiropractic Manipulation;Spinal 1-2 Regions
 ;;^UTILITY(U,$J,358.3,7009,0)
 ;;=98941^^57^454^3^^^^1
 ;;^UTILITY(U,$J,358.3,7009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7009,1,2,0)
 ;;=2^98941
