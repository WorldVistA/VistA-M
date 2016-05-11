IBDEI0RP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12990,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,12990,1,4,0)
 ;;=4^I70.742
 ;;^UTILITY(U,$J,358.3,12990,2)
 ;;=^5133602
 ;;^UTILITY(U,$J,358.3,12991,0)
 ;;=I70.743^^53^582^75
 ;;^UTILITY(U,$J,358.3,12991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12991,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,12991,1,4,0)
 ;;=4^I70.743
 ;;^UTILITY(U,$J,358.3,12991,2)
 ;;=^5133603
 ;;^UTILITY(U,$J,358.3,12992,0)
 ;;=I70.744^^53^582^77
 ;;^UTILITY(U,$J,358.3,12992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12992,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,12992,1,4,0)
 ;;=4^I70.744
 ;;^UTILITY(U,$J,358.3,12992,2)
 ;;=^5133604
 ;;^UTILITY(U,$J,358.3,12993,0)
 ;;=I70.745^^53^582^78
 ;;^UTILITY(U,$J,358.3,12993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12993,1,3,0)
 ;;=3^Athscl of Bypass Graft of Left Leg w/ Oth Part Foot Ulcer
 ;;^UTILITY(U,$J,358.3,12993,1,4,0)
 ;;=4^I70.745
 ;;^UTILITY(U,$J,358.3,12993,2)
 ;;=^5133605
 ;;^UTILITY(U,$J,358.3,12994,0)
 ;;=I83.009^^53^582^287
 ;;^UTILITY(U,$J,358.3,12994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12994,1,3,0)
 ;;=3^Varicose Veins of Lower Extremity w/ Ulcer
 ;;^UTILITY(U,$J,358.3,12994,1,4,0)
 ;;=4^I83.009
 ;;^UTILITY(U,$J,358.3,12994,2)
 ;;=^5007972
 ;;^UTILITY(U,$J,358.3,12995,0)
 ;;=H65.03^^53^583^3
 ;;^UTILITY(U,$J,358.3,12995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12995,1,3,0)
 ;;=3^Acute Serous Otitis Media,Bilateral
 ;;^UTILITY(U,$J,358.3,12995,1,4,0)
 ;;=4^H65.03
 ;;^UTILITY(U,$J,358.3,12995,2)
 ;;=^5006572
 ;;^UTILITY(U,$J,358.3,12996,0)
 ;;=H65.01^^53^583^5
 ;;^UTILITY(U,$J,358.3,12996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12996,1,3,0)
 ;;=3^Acute Serous Otitis Media,Right Ear
 ;;^UTILITY(U,$J,358.3,12996,1,4,0)
 ;;=4^H65.01
 ;;^UTILITY(U,$J,358.3,12996,2)
 ;;=^5006570
 ;;^UTILITY(U,$J,358.3,12997,0)
 ;;=H65.23^^53^583^15
 ;;^UTILITY(U,$J,358.3,12997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12997,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Bilateral
 ;;^UTILITY(U,$J,358.3,12997,1,4,0)
 ;;=4^H65.23
 ;;^UTILITY(U,$J,358.3,12997,2)
 ;;=^5006596
 ;;^UTILITY(U,$J,358.3,12998,0)
 ;;=H65.22^^53^583^16
 ;;^UTILITY(U,$J,358.3,12998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12998,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Left Ear
 ;;^UTILITY(U,$J,358.3,12998,1,4,0)
 ;;=4^H65.22
 ;;^UTILITY(U,$J,358.3,12998,2)
 ;;=^5006595
 ;;^UTILITY(U,$J,358.3,12999,0)
 ;;=H65.21^^53^583^17
 ;;^UTILITY(U,$J,358.3,12999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12999,1,3,0)
 ;;=3^Chronic Serous Otitis Media,Right Ear
 ;;^UTILITY(U,$J,358.3,12999,1,4,0)
 ;;=4^H65.21
 ;;^UTILITY(U,$J,358.3,12999,2)
 ;;=^5006594
 ;;^UTILITY(U,$J,358.3,13000,0)
 ;;=H66.012^^53^583^6
 ;;^UTILITY(U,$J,358.3,13000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13000,1,3,0)
 ;;=3^Acute Suppr Otitis Media w/ Spon Rupt Ear Drum,Left Ear
 ;;^UTILITY(U,$J,358.3,13000,1,4,0)
 ;;=4^H66.012
 ;;^UTILITY(U,$J,358.3,13000,2)
 ;;=^5133534
 ;;^UTILITY(U,$J,358.3,13001,0)
 ;;=H66.011^^53^583^7
 ;;^UTILITY(U,$J,358.3,13001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13001,1,3,0)
 ;;=3^Acute Suppr Otitis Media w/ Spon Rupt Ear Drum,Right Ear
 ;;^UTILITY(U,$J,358.3,13001,1,4,0)
 ;;=4^H66.011
 ;;^UTILITY(U,$J,358.3,13001,2)
 ;;=^5006621
 ;;^UTILITY(U,$J,358.3,13002,0)
 ;;=H66.91^^53^583^36
 ;;^UTILITY(U,$J,358.3,13002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13002,1,3,0)
 ;;=3^Otitis Media,Unspec,Right Ear
