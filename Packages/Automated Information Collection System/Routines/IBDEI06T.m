IBDEI06T ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2602,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2602,1,2,0)
 ;;=2^Dry Needling
 ;;^UTILITY(U,$J,358.3,2602,1,3,0)
 ;;=3^97799
 ;;^UTILITY(U,$J,358.3,2603,0)
 ;;=98940^^24^221^1^^^^1
 ;;^UTILITY(U,$J,358.3,2603,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2603,1,2,0)
 ;;=2^CMT; Spinal, one to two regions
 ;;^UTILITY(U,$J,358.3,2603,1,3,0)
 ;;=3^98940
 ;;^UTILITY(U,$J,358.3,2604,0)
 ;;=98941^^24^221^2^^^^1
 ;;^UTILITY(U,$J,358.3,2604,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2604,1,2,0)
 ;;=2^CMT; Spinal, three to four regions
 ;;^UTILITY(U,$J,358.3,2604,1,3,0)
 ;;=3^98941
 ;;^UTILITY(U,$J,358.3,2605,0)
 ;;=98942^^24^221^3^^^^1
 ;;^UTILITY(U,$J,358.3,2605,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2605,1,2,0)
 ;;=2^CMT; Spinal, five regions
 ;;^UTILITY(U,$J,358.3,2605,1,3,0)
 ;;=3^98942
 ;;^UTILITY(U,$J,358.3,2606,0)
 ;;=98943^^24^221^4^^^^1
 ;;^UTILITY(U,$J,358.3,2606,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2606,1,2,0)
 ;;=2^CMT; Extraspinal, one or more regions
 ;;^UTILITY(U,$J,358.3,2606,1,3,0)
 ;;=3^98943
 ;;^UTILITY(U,$J,358.3,2607,0)
 ;;=98925^^24^222^1^^^^1
 ;;^UTILITY(U,$J,358.3,2607,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2607,1,2,0)
 ;;=2^OMT, 1-2 body regions involved
 ;;^UTILITY(U,$J,358.3,2607,1,3,0)
 ;;=3^98925
 ;;^UTILITY(U,$J,358.3,2608,0)
 ;;=98926^^24^222^2^^^^1
 ;;^UTILITY(U,$J,358.3,2608,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2608,1,2,0)
 ;;=2^OMT, 3-4 body regions involved
 ;;^UTILITY(U,$J,358.3,2608,1,3,0)
 ;;=3^98926
 ;;^UTILITY(U,$J,358.3,2609,0)
 ;;=98927^^24^222^3^^^^1
 ;;^UTILITY(U,$J,358.3,2609,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2609,1,2,0)
 ;;=2^OMT, 5-6 body regions involved
 ;;^UTILITY(U,$J,358.3,2609,1,3,0)
 ;;=3^98927
 ;;^UTILITY(U,$J,358.3,2610,0)
 ;;=98928^^24^222^4^^^^1
 ;;^UTILITY(U,$J,358.3,2610,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2610,1,2,0)
 ;;=2^OMT, 7-8 body regions involved
 ;;^UTILITY(U,$J,358.3,2610,1,3,0)
 ;;=3^98928
 ;;^UTILITY(U,$J,358.3,2611,0)
 ;;=98929^^24^222^5^^^^1
 ;;^UTILITY(U,$J,358.3,2611,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2611,1,2,0)
 ;;=2^OMT, 9-10 body regions involved
 ;;^UTILITY(U,$J,358.3,2611,1,3,0)
 ;;=3^98929
 ;;^UTILITY(U,$J,358.3,2612,0)
 ;;=97810^^24^223^3^^^^1
 ;;^UTILITY(U,$J,358.3,2612,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2612,1,2,0)
 ;;=2^Acupunct w/o Stimul,15min
 ;;^UTILITY(U,$J,358.3,2612,1,3,0)
 ;;=3^97810
 ;;^UTILITY(U,$J,358.3,2613,0)
 ;;=97811^^24^223^4^^^^1
 ;;^UTILITY(U,$J,358.3,2613,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2613,1,2,0)
 ;;=2^Acupunct w/o Stimul,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,2613,1,3,0)
 ;;=3^97811
 ;;^UTILITY(U,$J,358.3,2614,0)
 ;;=97813^^24^223^1^^^^1
 ;;^UTILITY(U,$J,358.3,2614,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2614,1,2,0)
 ;;=2^Acupunct w/ Stimul,15min
 ;;^UTILITY(U,$J,358.3,2614,1,3,0)
 ;;=3^97813
 ;;^UTILITY(U,$J,358.3,2615,0)
 ;;=97814^^24^223^2^^^^1
 ;;^UTILITY(U,$J,358.3,2615,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2615,1,2,0)
 ;;=2^Acupunct w/ Stimul,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,2615,1,3,0)
 ;;=3^97814
 ;;^UTILITY(U,$J,358.3,2616,0)
 ;;=S8930^^24^223^5^^^^1
 ;;^UTILITY(U,$J,358.3,2616,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2616,1,2,0)
 ;;=2^Acupuncture Electostim,Auricular,Ea 15min
 ;;^UTILITY(U,$J,358.3,2616,1,3,0)
 ;;=3^S8930
 ;;^UTILITY(U,$J,358.3,2617,0)
 ;;=98960^^24^224^1^^^^1
 ;;^UTILITY(U,$J,358.3,2617,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2617,1,2,0)
 ;;=2^Education for Self Mgt,Ind 30min
 ;;^UTILITY(U,$J,358.3,2617,1,3,0)
 ;;=3^98960
 ;;^UTILITY(U,$J,358.3,2618,0)
 ;;=G43.C0^^25^225^79
