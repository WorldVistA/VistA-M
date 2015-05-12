IBDEI00S ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,700,2)
 ;;=^5133409
 ;;^UTILITY(U,$J,358.3,701,0)
 ;;=H02.401^^2^15^38
 ;;^UTILITY(U,$J,358.3,701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,701,1,3,0)
 ;;=3^Ptosis,Right Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,701,1,4,0)
 ;;=4^H02.401
 ;;^UTILITY(U,$J,358.3,701,2)
 ;;=^5004353
 ;;^UTILITY(U,$J,358.3,702,0)
 ;;=H02.402^^2^15^37
 ;;^UTILITY(U,$J,358.3,702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,702,1,3,0)
 ;;=3^Ptosis,Left Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,702,1,4,0)
 ;;=4^H02.402
 ;;^UTILITY(U,$J,358.3,702,2)
 ;;=^5004354
 ;;^UTILITY(U,$J,358.3,703,0)
 ;;=H02.403^^2^15^36
 ;;^UTILITY(U,$J,358.3,703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,703,1,3,0)
 ;;=3^Ptosis,Bilateral Eyelids,Unspec
 ;;^UTILITY(U,$J,358.3,703,1,4,0)
 ;;=4^H02.403
 ;;^UTILITY(U,$J,358.3,703,2)
 ;;=^5004355
 ;;^UTILITY(U,$J,358.3,704,0)
 ;;=H02.31^^2^15^8
 ;;^UTILITY(U,$J,358.3,704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,704,1,3,0)
 ;;=3^Blepharochalasis,Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,704,1,4,0)
 ;;=4^H02.31
 ;;^UTILITY(U,$J,358.3,704,2)
 ;;=^5004348
 ;;^UTILITY(U,$J,358.3,705,0)
 ;;=H02.32^^2^15^7
 ;;^UTILITY(U,$J,358.3,705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,705,1,3,0)
 ;;=3^Blepharochalasis,Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,705,1,4,0)
 ;;=4^H02.32
 ;;^UTILITY(U,$J,358.3,705,2)
 ;;=^5004349
 ;;^UTILITY(U,$J,358.3,706,0)
 ;;=H02.34^^2^15^6
 ;;^UTILITY(U,$J,358.3,706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,706,1,3,0)
 ;;=3^Blepharochalasis,Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,706,1,4,0)
 ;;=4^H02.34
 ;;^UTILITY(U,$J,358.3,706,2)
 ;;=^5004351
 ;;^UTILITY(U,$J,358.3,707,0)
 ;;=H02.35^^2^15^5
 ;;^UTILITY(U,$J,358.3,707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,707,1,3,0)
 ;;=3^Blepharochalasis,Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,707,1,4,0)
 ;;=4^H02.35
 ;;^UTILITY(U,$J,358.3,707,2)
 ;;=^5133426
 ;;^UTILITY(U,$J,358.3,708,0)
 ;;=H02.61^^2^15^47
 ;;^UTILITY(U,$J,358.3,708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,708,1,3,0)
 ;;=3^Xanthelasma,Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,708,1,4,0)
 ;;=4^H02.61
 ;;^UTILITY(U,$J,358.3,708,2)
 ;;=^5004386
 ;;^UTILITY(U,$J,358.3,709,0)
 ;;=H02.62^^2^15^46
 ;;^UTILITY(U,$J,358.3,709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,709,1,3,0)
 ;;=3^Xanthelasma,Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,709,1,4,0)
 ;;=4^H02.62
 ;;^UTILITY(U,$J,358.3,709,2)
 ;;=^5004387
 ;;^UTILITY(U,$J,358.3,710,0)
 ;;=H02.64^^2^15^45
 ;;^UTILITY(U,$J,358.3,710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,710,1,3,0)
 ;;=3^Xanthelasma,Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,710,1,4,0)
 ;;=4^H02.64
 ;;^UTILITY(U,$J,358.3,710,2)
 ;;=^5004389
 ;;^UTILITY(U,$J,358.3,711,0)
 ;;=H02.65^^2^15^44
 ;;^UTILITY(U,$J,358.3,711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,711,1,3,0)
 ;;=3^Xanthelasma,Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,711,1,4,0)
 ;;=4^H02.65
 ;;^UTILITY(U,$J,358.3,711,2)
 ;;=^5133432
 ;;^UTILITY(U,$J,358.3,712,0)
 ;;=H02.831^^2^15^16
 ;;^UTILITY(U,$J,358.3,712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,712,1,3,0)
 ;;=3^Dermatochalasis,Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,712,1,4,0)
 ;;=4^H02.831
 ;;^UTILITY(U,$J,358.3,712,2)
 ;;=^5004418
 ;;^UTILITY(U,$J,358.3,713,0)
 ;;=H02.832^^2^15^15
 ;;^UTILITY(U,$J,358.3,713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,713,1,3,0)
 ;;=3^Dermatochalasis,Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,713,1,4,0)
 ;;=4^H02.832
 ;;^UTILITY(U,$J,358.3,713,2)
 ;;=^5004419
 ;;^UTILITY(U,$J,358.3,714,0)
 ;;=H02.834^^2^15^14
 ;;^UTILITY(U,$J,358.3,714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,714,1,3,0)
 ;;=3^Dermatochalasis,Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,714,1,4,0)
 ;;=4^H02.834
 ;;^UTILITY(U,$J,358.3,714,2)
 ;;=^5004421
 ;;^UTILITY(U,$J,358.3,715,0)
 ;;=H02.835^^2^15^13
 ;;^UTILITY(U,$J,358.3,715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,715,1,3,0)
 ;;=3^Dermatochalasis,Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,715,1,4,0)
 ;;=4^H02.835
 ;;^UTILITY(U,$J,358.3,715,2)
 ;;=^5133443
 ;;^UTILITY(U,$J,358.3,716,0)
 ;;=H04.201^^2^15^28
 ;;^UTILITY(U,$J,358.3,716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,716,1,3,0)
 ;;=3^Epiphora,Right Lacrimal Gland,Unspec
 ;;^UTILITY(U,$J,358.3,716,1,4,0)
 ;;=4^H04.201
 ;;^UTILITY(U,$J,358.3,716,2)
 ;;=^5004484
 ;;^UTILITY(U,$J,358.3,717,0)
 ;;=H04.203^^2^15^26
 ;;^UTILITY(U,$J,358.3,717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,717,1,3,0)
 ;;=3^Epiphora,Bilateral Lacrimal Glands,Unspec
 ;;^UTILITY(U,$J,358.3,717,1,4,0)
 ;;=4^H04.203
 ;;^UTILITY(U,$J,358.3,717,2)
 ;;=^5004486
 ;;^UTILITY(U,$J,358.3,718,0)
 ;;=H04.202^^2^15^27
 ;;^UTILITY(U,$J,358.3,718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,718,1,3,0)
 ;;=3^Epiphora,Left Lacrimal Gland,Unspec
 ;;^UTILITY(U,$J,358.3,718,1,4,0)
 ;;=4^H04.202
 ;;^UTILITY(U,$J,358.3,718,2)
 ;;=^5004485
 ;;^UTILITY(U,$J,358.3,719,0)
 ;;=L72.0^^2^15^25
 ;;^UTILITY(U,$J,358.3,719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,719,1,3,0)
 ;;=3^Epidermal Cyst
 ;;^UTILITY(U,$J,358.3,719,1,4,0)
 ;;=4^L72.0
 ;;^UTILITY(U,$J,358.3,719,2)
 ;;=^5009277
 ;;^UTILITY(U,$J,358.3,720,0)
 ;;=L72.11^^2^15^35
 ;;^UTILITY(U,$J,358.3,720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,720,1,3,0)
 ;;=3^Pilar Cyst
 ;;^UTILITY(U,$J,358.3,720,1,4,0)
 ;;=4^L72.11
 ;;^UTILITY(U,$J,358.3,720,2)
 ;;=^5009278
 ;;^UTILITY(U,$J,358.3,721,0)
 ;;=L72.12^^2^15^43
 ;;^UTILITY(U,$J,358.3,721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,721,1,3,0)
 ;;=3^Trichodermal Cyst
 ;;^UTILITY(U,$J,358.3,721,1,4,0)
 ;;=4^L72.12
 ;;^UTILITY(U,$J,358.3,721,2)
 ;;=^5009279
 ;;^UTILITY(U,$J,358.3,722,0)
 ;;=L72.8^^2^15^29
 ;;^UTILITY(U,$J,358.3,722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,722,1,3,0)
 ;;=3^Follicular Cysts of Skin/Subcutaneous Tissue NEC
 ;;^UTILITY(U,$J,358.3,722,1,4,0)
 ;;=4^L72.8
 ;;^UTILITY(U,$J,358.3,722,2)
 ;;=^5009282
 ;;^UTILITY(U,$J,358.3,723,0)
 ;;=H35.31^^2^16^19
 ;;^UTILITY(U,$J,358.3,723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,723,1,3,0)
 ;;=3^Nonexudative Age-Related Macular Degeneration
 ;;^UTILITY(U,$J,358.3,723,1,4,0)
 ;;=4^H35.31
 ;;^UTILITY(U,$J,358.3,723,2)
 ;;=^5005647
 ;;^UTILITY(U,$J,358.3,724,0)
 ;;=H35.32^^2^16^10
 ;;^UTILITY(U,$J,358.3,724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,724,1,3,0)
 ;;=3^Exudative Age-Related Macular Degeneration
 ;;^UTILITY(U,$J,358.3,724,1,4,0)
 ;;=4^H35.32
 ;;^UTILITY(U,$J,358.3,724,2)
 ;;=^5005648
 ;;^UTILITY(U,$J,358.3,725,0)
 ;;=H35.352^^2^16^2
 ;;^UTILITY(U,$J,358.3,725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,725,1,3,0)
 ;;=3^Cystoid Macular Degeneration,Left Eye
 ;;^UTILITY(U,$J,358.3,725,1,4,0)
 ;;=4^H35.352
 ;;^UTILITY(U,$J,358.3,725,2)
 ;;=^5005655
 ;;^UTILITY(U,$J,358.3,726,0)
 ;;=H35.351^^2^16^3
 ;;^UTILITY(U,$J,358.3,726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,726,1,3,0)
 ;;=3^Cystoid Macular Degeneration,Right Eye
 ;;^UTILITY(U,$J,358.3,726,1,4,0)
 ;;=4^H35.351
 ;;^UTILITY(U,$J,358.3,726,2)
 ;;=^5005654
 ;;^UTILITY(U,$J,358.3,727,0)
 ;;=H35.353^^2^16^1
 ;;^UTILITY(U,$J,358.3,727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,727,1,3,0)
 ;;=3^Cystoid Macular Degeneration,Bilateral
 ;;^UTILITY(U,$J,358.3,727,1,4,0)
 ;;=4^H35.353
 ;;^UTILITY(U,$J,358.3,727,2)
 ;;=^5005656
 ;;^UTILITY(U,$J,358.3,728,0)
 ;;=H35.342^^2^16^17
 ;;^UTILITY(U,$J,358.3,728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,728,1,3,0)
 ;;=3^Macular Cyst/Hole/Pseudohole,Left Eye
 ;;^UTILITY(U,$J,358.3,728,1,4,0)
 ;;=4^H35.342
 ;;^UTILITY(U,$J,358.3,728,2)
 ;;=^5005651
 ;;^UTILITY(U,$J,358.3,729,0)
 ;;=H35.341^^2^16^18
 ;;^UTILITY(U,$J,358.3,729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,729,1,3,0)
 ;;=3^Macular Cyst/Hole/Pseudohole,Right Eye
 ;;^UTILITY(U,$J,358.3,729,1,4,0)
 ;;=4^H35.341
 ;;^UTILITY(U,$J,358.3,729,2)
 ;;=^5005650
 ;;^UTILITY(U,$J,358.3,730,0)
 ;;=H35.371^^2^16^27
 ;;^UTILITY(U,$J,358.3,730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,730,1,3,0)
 ;;=3^Puckering of Macula,Right Eye
 ;;^UTILITY(U,$J,358.3,730,1,4,0)
 ;;=4^H35.371
 ;;^UTILITY(U,$J,358.3,730,2)
 ;;=^5005662
 ;;^UTILITY(U,$J,358.3,731,0)
 ;;=H35.372^^2^16^26
 ;;^UTILITY(U,$J,358.3,731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,731,1,3,0)
 ;;=3^Puckering of Macula,Left Eye
 ;;^UTILITY(U,$J,358.3,731,1,4,0)
 ;;=4^H35.372
 ;;^UTILITY(U,$J,358.3,731,2)
 ;;=^5005663
 ;;^UTILITY(U,$J,358.3,732,0)
 ;;=H35.362^^2^16^5
 ;;^UTILITY(U,$J,358.3,732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,732,1,3,0)
 ;;=3^Drusen of Macula,Left Eye
 ;;^UTILITY(U,$J,358.3,732,1,4,0)
 ;;=4^H35.362
 ;;^UTILITY(U,$J,358.3,732,2)
 ;;=^5005659
 ;;^UTILITY(U,$J,358.3,733,0)
 ;;=H35.361^^2^16^6
 ;;^UTILITY(U,$J,358.3,733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,733,1,3,0)
 ;;=3^Drusen of Macula,Right Eye
 ;;^UTILITY(U,$J,358.3,733,1,4,0)
 ;;=4^H35.361
 ;;^UTILITY(U,$J,358.3,733,2)
 ;;=^5005658
 ;;^UTILITY(U,$J,358.3,734,0)
 ;;=H35.363^^2^16^4
 ;;^UTILITY(U,$J,358.3,734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,734,1,3,0)
 ;;=3^Drusen of Macula,Bilateral
 ;;^UTILITY(U,$J,358.3,734,1,4,0)
 ;;=4^H35.363
 ;;^UTILITY(U,$J,358.3,734,2)
 ;;=^5005660
 ;;^UTILITY(U,$J,358.3,735,0)
 ;;=H47.10^^2^16^25
 ;;^UTILITY(U,$J,358.3,735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,735,1,3,0)
 ;;=3^Papilledema,Unspec
 ;;^UTILITY(U,$J,358.3,735,1,4,0)
 ;;=4^H47.10
 ;;^UTILITY(U,$J,358.3,735,2)
 ;;=^5006121
 ;;^UTILITY(U,$J,358.3,736,0)
 ;;=H47.20^^2^16^20
 ;;^UTILITY(U,$J,358.3,736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,736,1,3,0)
 ;;=3^Optic Atrophy,Unspec
 ;;^UTILITY(U,$J,358.3,736,1,4,0)
 ;;=4^H47.20
 ;;^UTILITY(U,$J,358.3,736,2)
 ;;=^5006126
 ;;^UTILITY(U,$J,358.3,737,0)
 ;;=H47.231^^2^16^13
 ;;^UTILITY(U,$J,358.3,737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,737,1,3,0)
 ;;=3^Glaucomatous Optic Atrophy,Right Eye
 ;;^UTILITY(U,$J,358.3,737,1,4,0)
 ;;=4^H47.231
 ;;^UTILITY(U,$J,358.3,737,2)
 ;;=^5006131
 ;;^UTILITY(U,$J,358.3,738,0)
 ;;=H47.232^^2^16^12
