IBDEI066 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7690,1,4,0)
 ;;=4^V00.891D
 ;;^UTILITY(U,$J,358.3,7690,2)
 ;;=^5055965
 ;;^UTILITY(U,$J,358.3,7691,0)
 ;;=V00.892A^^26^421^99
 ;;^UTILITY(U,$J,358.3,7691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7691,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,7691,1,4,0)
 ;;=4^V00.892A
 ;;^UTILITY(U,$J,358.3,7691,2)
 ;;=^5055967
 ;;^UTILITY(U,$J,358.3,7692,0)
 ;;=V00.892D^^26^421^100
 ;;^UTILITY(U,$J,358.3,7692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7692,1,3,0)
 ;;=3^Pedestrian Conveyance Colliding w/ Stationary Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7692,1,4,0)
 ;;=4^V00.892D
 ;;^UTILITY(U,$J,358.3,7692,2)
 ;;=^5055968
 ;;^UTILITY(U,$J,358.3,7693,0)
 ;;=V00.898A^^26^421^97
 ;;^UTILITY(U,$J,358.3,7693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7693,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,7693,1,4,0)
 ;;=4^V00.898A
 ;;^UTILITY(U,$J,358.3,7693,2)
 ;;=^5055970
 ;;^UTILITY(U,$J,358.3,7694,0)
 ;;=V00.898D^^26^421^98
 ;;^UTILITY(U,$J,358.3,7694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7694,1,3,0)
 ;;=3^Pedestrian Conveyance Accident NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7694,1,4,0)
 ;;=4^V00.898D
 ;;^UTILITY(U,$J,358.3,7694,2)
 ;;=^5055971
 ;;^UTILITY(U,$J,358.3,7695,0)
 ;;=W00.0XXA^^26^421^79
 ;;^UTILITY(U,$J,358.3,7695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7695,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,7695,1,4,0)
 ;;=4^W00.0XXA
 ;;^UTILITY(U,$J,358.3,7695,2)
 ;;=^5059510
 ;;^UTILITY(U,$J,358.3,7696,0)
 ;;=W00.0XXD^^26^421^80
 ;;^UTILITY(U,$J,358.3,7696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7696,1,3,0)
 ;;=3^Fall on Same Level d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7696,1,4,0)
 ;;=4^W00.0XXD
 ;;^UTILITY(U,$J,358.3,7696,2)
 ;;=^5059511
 ;;^UTILITY(U,$J,358.3,7697,0)
 ;;=W00.1XXA^^26^421^59
 ;;^UTILITY(U,$J,358.3,7697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7697,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,7697,1,4,0)
 ;;=4^W00.1XXA
 ;;^UTILITY(U,$J,358.3,7697,2)
 ;;=^5059513
 ;;^UTILITY(U,$J,358.3,7698,0)
 ;;=W00.1XXD^^26^421^60
 ;;^UTILITY(U,$J,358.3,7698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7698,1,3,0)
 ;;=3^Fall from Stairs/Steps d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7698,1,4,0)
 ;;=4^W00.1XXD
 ;;^UTILITY(U,$J,358.3,7698,2)
 ;;=^5059514
 ;;^UTILITY(U,$J,358.3,7699,0)
 ;;=W00.2XXA^^26^421^53
 ;;^UTILITY(U,$J,358.3,7699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7699,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Init Encntr
 ;;^UTILITY(U,$J,358.3,7699,1,4,0)
 ;;=4^W00.2XXA
 ;;^UTILITY(U,$J,358.3,7699,2)
 ;;=^5059516
 ;;^UTILITY(U,$J,358.3,7700,0)
 ;;=W00.2XXD^^26^421^54
 ;;^UTILITY(U,$J,358.3,7700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7700,1,3,0)
 ;;=3^Fall from One Level to Another d/t Ice/Snow,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7700,1,4,0)
 ;;=4^W00.2XXD
 ;;^UTILITY(U,$J,358.3,7700,2)
 ;;=^5059517
 ;;^UTILITY(U,$J,358.3,7701,0)
 ;;=W00.9XXA^^26^421^25
 ;;^UTILITY(U,$J,358.3,7701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7701,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,7701,1,4,0)
 ;;=4^W00.9XXA
 ;;^UTILITY(U,$J,358.3,7701,2)
 ;;=^5059519
 ;;^UTILITY(U,$J,358.3,7702,0)
 ;;=W00.9XXD^^26^421^26
 ;;^UTILITY(U,$J,358.3,7702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7702,1,3,0)
 ;;=3^Fall d/t Ice/Snow,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7702,1,4,0)
 ;;=4^W00.9XXD
 ;;^UTILITY(U,$J,358.3,7702,2)
 ;;=^5059520
 ;;^UTILITY(U,$J,358.3,7703,0)
 ;;=W01.0XXA^^26^421^87
 ;;^UTILITY(U,$J,358.3,7703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7703,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,7703,1,4,0)
 ;;=4^W01.0XXA
 ;;^UTILITY(U,$J,358.3,7703,2)
 ;;=^5059522
 ;;^UTILITY(U,$J,358.3,7704,0)
 ;;=W01.0XXD^^26^421^88
 ;;^UTILITY(U,$J,358.3,7704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7704,1,3,0)
 ;;=3^Fall,Same Level,From Slip/Trip w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7704,1,4,0)
 ;;=4^W01.0XXD
 ;;^UTILITY(U,$J,358.3,7704,2)
 ;;=^5059523
 ;;^UTILITY(U,$J,358.3,7705,0)
 ;;=W03.XXXA^^26^421^85
 ;;^UTILITY(U,$J,358.3,7705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7705,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Init Encntr
 ;;^UTILITY(U,$J,358.3,7705,1,4,0)
 ;;=4^W03.XXXA
 ;;^UTILITY(U,$J,358.3,7705,2)
 ;;=^5059544
 ;;^UTILITY(U,$J,358.3,7706,0)
 ;;=W03.XXXD^^26^421^86
 ;;^UTILITY(U,$J,358.3,7706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7706,1,3,0)
 ;;=3^Fall,Same Level d/t Collision w/ Another Person,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7706,1,4,0)
 ;;=4^W03.XXXD
 ;;^UTILITY(U,$J,358.3,7706,2)
 ;;=^5059545
 ;;^UTILITY(U,$J,358.3,7707,0)
 ;;=W05.0XXA^^26^421^51
 ;;^UTILITY(U,$J,358.3,7707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7707,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Init Encntr
 ;;^UTILITY(U,$J,358.3,7707,1,4,0)
 ;;=4^W05.0XXA
 ;;^UTILITY(U,$J,358.3,7707,2)
 ;;=^5059550
 ;;^UTILITY(U,$J,358.3,7708,0)
 ;;=W05.0XXD^^26^421^52
 ;;^UTILITY(U,$J,358.3,7708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7708,1,3,0)
 ;;=3^Fall from Non-Moving Wheelchair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7708,1,4,0)
 ;;=4^W05.0XXD
 ;;^UTILITY(U,$J,358.3,7708,2)
 ;;=^5059551
 ;;^UTILITY(U,$J,358.3,7709,0)
 ;;=W05.1XXA^^26^421^49
 ;;^UTILITY(U,$J,358.3,7709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7709,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,7709,1,4,0)
 ;;=4^W05.1XXA
 ;;^UTILITY(U,$J,358.3,7709,2)
 ;;=^5059553
 ;;^UTILITY(U,$J,358.3,7710,0)
 ;;=W05.1XXD^^26^421^50
 ;;^UTILITY(U,$J,358.3,7710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7710,1,3,0)
 ;;=3^Fall from Non-Moving Non-Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7710,1,4,0)
 ;;=4^W05.1XXD
 ;;^UTILITY(U,$J,358.3,7710,2)
 ;;=^5059554
 ;;^UTILITY(U,$J,358.3,7711,0)
 ;;=W05.2XXA^^26^421^47
 ;;^UTILITY(U,$J,358.3,7711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7711,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Init Encntr
 ;;^UTILITY(U,$J,358.3,7711,1,4,0)
 ;;=4^W05.2XXA
 ;;^UTILITY(U,$J,358.3,7711,2)
 ;;=^5059556
 ;;^UTILITY(U,$J,358.3,7712,0)
 ;;=W05.2XXD^^26^421^48
 ;;^UTILITY(U,$J,358.3,7712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7712,1,3,0)
 ;;=3^Fall from Non-Moving Motorized Scooter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7712,1,4,0)
 ;;=4^W05.2XXD
 ;;^UTILITY(U,$J,358.3,7712,2)
 ;;=^5059557
 ;;^UTILITY(U,$J,358.3,7713,0)
 ;;=W06.XXXA^^26^421^29
 ;;^UTILITY(U,$J,358.3,7713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7713,1,3,0)
 ;;=3^Fall from Bed,Init Encntr
 ;;^UTILITY(U,$J,358.3,7713,1,4,0)
 ;;=4^W06.XXXA
 ;;^UTILITY(U,$J,358.3,7713,2)
 ;;=^5059559
 ;;^UTILITY(U,$J,358.3,7714,0)
 ;;=W06.XXXD^^26^421^30
 ;;^UTILITY(U,$J,358.3,7714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7714,1,3,0)
 ;;=3^Fall from Bed,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7714,1,4,0)
 ;;=4^W06.XXXD
 ;;^UTILITY(U,$J,358.3,7714,2)
 ;;=^5059560
 ;;^UTILITY(U,$J,358.3,7715,0)
 ;;=W07.XXXA^^26^421^37
 ;;^UTILITY(U,$J,358.3,7715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7715,1,3,0)
 ;;=3^Fall from Chair,Init Encntr
 ;;^UTILITY(U,$J,358.3,7715,1,4,0)
 ;;=4^W07.XXXA
 ;;^UTILITY(U,$J,358.3,7715,2)
 ;;=^5059562
 ;;^UTILITY(U,$J,358.3,7716,0)
 ;;=W07.XXXD^^26^421^38
 ;;^UTILITY(U,$J,358.3,7716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7716,1,3,0)
 ;;=3^Fall from Chair,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7716,1,4,0)
 ;;=4^W07.XXXD
 ;;^UTILITY(U,$J,358.3,7716,2)
 ;;=^5059563
 ;;^UTILITY(U,$J,358.3,7717,0)
 ;;=W10.1XXA^^26^421^81
 ;;^UTILITY(U,$J,358.3,7717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7717,1,3,0)
 ;;=3^Fall on Sidewalk Curb,Init Encntr
 ;;^UTILITY(U,$J,358.3,7717,1,4,0)
 ;;=4^W10.1XXA
 ;;^UTILITY(U,$J,358.3,7717,2)
 ;;=^5059583
 ;;^UTILITY(U,$J,358.3,7718,0)
 ;;=W10.1XXD^^26^421^82
 ;;^UTILITY(U,$J,358.3,7718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7718,1,3,0)
 ;;=3^Fall on Sidewalk Curb,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7718,1,4,0)
 ;;=4^W10.1XXD
 ;;^UTILITY(U,$J,358.3,7718,2)
 ;;=^5059584
 ;;^UTILITY(U,$J,358.3,7719,0)
 ;;=W11.XXXA^^26^421^41
 ;;^UTILITY(U,$J,358.3,7719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7719,1,3,0)
 ;;=3^Fall from Ladder,Init Encntr
 ;;^UTILITY(U,$J,358.3,7719,1,4,0)
 ;;=4^W11.XXXA
 ;;^UTILITY(U,$J,358.3,7719,2)
 ;;=^5059595
 ;;^UTILITY(U,$J,358.3,7720,0)
 ;;=W11.XXXD^^26^421^42
 ;;^UTILITY(U,$J,358.3,7720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7720,1,3,0)
 ;;=3^Fall from Ladder,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7720,1,4,0)
 ;;=4^W11.XXXD
 ;;^UTILITY(U,$J,358.3,7720,2)
 ;;=^5059596
 ;;^UTILITY(U,$J,358.3,7721,0)
 ;;=W13.0XXA^^26^421^67
 ;;^UTILITY(U,$J,358.3,7721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7721,1,3,0)
 ;;=3^Fall from/through Balcony,Init Encntr
 ;;^UTILITY(U,$J,358.3,7721,1,4,0)
 ;;=4^W13.0XXA
 ;;^UTILITY(U,$J,358.3,7721,2)
 ;;=^5059601
 ;;^UTILITY(U,$J,358.3,7722,0)
 ;;=W13.0XXD^^26^421^68
 ;;^UTILITY(U,$J,358.3,7722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7722,1,3,0)
 ;;=3^Fall from/through Balcony,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7722,1,4,0)
 ;;=4^W13.0XXD
 ;;^UTILITY(U,$J,358.3,7722,2)
 ;;=^5059602
 ;;^UTILITY(U,$J,358.3,7723,0)
 ;;=W13.1XXA^^26^421^31
 ;;^UTILITY(U,$J,358.3,7723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7723,1,3,0)
 ;;=3^Fall from Bridge,Init Encntr
 ;;^UTILITY(U,$J,358.3,7723,1,4,0)
 ;;=4^W13.1XXA
 ;;^UTILITY(U,$J,358.3,7723,2)
 ;;=^5059604
 ;;^UTILITY(U,$J,358.3,7724,0)
 ;;=W13.1XXD^^26^421^32
 ;;^UTILITY(U,$J,358.3,7724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7724,1,3,0)
 ;;=3^Fall from Bridge,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7724,1,4,0)
 ;;=4^W13.1XXD
 ;;^UTILITY(U,$J,358.3,7724,2)
 ;;=^5059605
