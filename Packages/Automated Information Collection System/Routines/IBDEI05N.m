IBDEI05N ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2300,1,2,0)
 ;;=2^CMT; Spinal, three to four regions
 ;;^UTILITY(U,$J,358.3,2300,1,3,0)
 ;;=3^98941
 ;;^UTILITY(U,$J,358.3,2301,0)
 ;;=98942^^14^182^3^^^^1
 ;;^UTILITY(U,$J,358.3,2301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2301,1,2,0)
 ;;=2^CMT; Spinal, five regions
 ;;^UTILITY(U,$J,358.3,2301,1,3,0)
 ;;=3^98942
 ;;^UTILITY(U,$J,358.3,2302,0)
 ;;=98943^^14^182^4^^^^1
 ;;^UTILITY(U,$J,358.3,2302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2302,1,2,0)
 ;;=2^CMT; Extraspinal, one or more regions
 ;;^UTILITY(U,$J,358.3,2302,1,3,0)
 ;;=3^98943
 ;;^UTILITY(U,$J,358.3,2303,0)
 ;;=98925^^14^183^1^^^^1
 ;;^UTILITY(U,$J,358.3,2303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2303,1,2,0)
 ;;=2^OMT, 1-2 body regions involved
 ;;^UTILITY(U,$J,358.3,2303,1,3,0)
 ;;=3^98925
 ;;^UTILITY(U,$J,358.3,2304,0)
 ;;=98926^^14^183^2^^^^1
 ;;^UTILITY(U,$J,358.3,2304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2304,1,2,0)
 ;;=2^OMT, 3-4 body regions involved
 ;;^UTILITY(U,$J,358.3,2304,1,3,0)
 ;;=3^98926
 ;;^UTILITY(U,$J,358.3,2305,0)
 ;;=98927^^14^183^3^^^^1
 ;;^UTILITY(U,$J,358.3,2305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2305,1,2,0)
 ;;=2^OMT, 5-6 body regions involved
 ;;^UTILITY(U,$J,358.3,2305,1,3,0)
 ;;=3^98927
 ;;^UTILITY(U,$J,358.3,2306,0)
 ;;=98928^^14^183^4^^^^1
 ;;^UTILITY(U,$J,358.3,2306,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2306,1,2,0)
 ;;=2^OMT, 7-8 body regions involved
 ;;^UTILITY(U,$J,358.3,2306,1,3,0)
 ;;=3^98928
 ;;^UTILITY(U,$J,358.3,2307,0)
 ;;=98929^^14^183^5^^^^1
 ;;^UTILITY(U,$J,358.3,2307,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2307,1,2,0)
 ;;=2^OMT, 9-10 body regions involved
 ;;^UTILITY(U,$J,358.3,2307,1,3,0)
 ;;=3^98929
 ;;^UTILITY(U,$J,358.3,2308,0)
 ;;=97810^^14^184^3^^^^1
 ;;^UTILITY(U,$J,358.3,2308,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2308,1,2,0)
 ;;=2^Acupunct w/o Stimul,15min
 ;;^UTILITY(U,$J,358.3,2308,1,3,0)
 ;;=3^97810
 ;;^UTILITY(U,$J,358.3,2309,0)
 ;;=97811^^14^184^4^^^^1
 ;;^UTILITY(U,$J,358.3,2309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2309,1,2,0)
 ;;=2^Acupunct w/o Stimul,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,2309,1,3,0)
 ;;=3^97811
 ;;^UTILITY(U,$J,358.3,2310,0)
 ;;=97813^^14^184^1^^^^1
 ;;^UTILITY(U,$J,358.3,2310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2310,1,2,0)
 ;;=2^Acupunct w/ Stimul,15min
 ;;^UTILITY(U,$J,358.3,2310,1,3,0)
 ;;=3^97813
 ;;^UTILITY(U,$J,358.3,2311,0)
 ;;=97814^^14^184^2^^^^1
 ;;^UTILITY(U,$J,358.3,2311,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2311,1,2,0)
 ;;=2^Acupunct w/ Stimul,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,2311,1,3,0)
 ;;=3^97814
 ;;^UTILITY(U,$J,358.3,2312,0)
 ;;=S8930^^14^184^5^^^^1
 ;;^UTILITY(U,$J,358.3,2312,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2312,1,2,0)
 ;;=2^Acupuncture Electostim,Auricular,Ea 15min
 ;;^UTILITY(U,$J,358.3,2312,1,3,0)
 ;;=3^S8930
 ;;^UTILITY(U,$J,358.3,2313,0)
 ;;=98960^^14^185^1^^^^1
 ;;^UTILITY(U,$J,358.3,2313,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2313,1,2,0)
 ;;=2^Education for Self Mgt,Ind 30min
 ;;^UTILITY(U,$J,358.3,2313,1,3,0)
 ;;=3^98960
 ;;^UTILITY(U,$J,358.3,2314,0)
 ;;=G43.C0^^15^186^79
 ;;^UTILITY(U,$J,358.3,2314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2314,1,3,0)
 ;;=3^Periodic headache syndr in chld/adlt, not intrctbl
 ;;^UTILITY(U,$J,358.3,2314,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,2314,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,2315,0)
 ;;=M19.011^^15^186^87
 ;;^UTILITY(U,$J,358.3,2315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2315,1,3,0)
 ;;=3^Primary osteoarthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,2315,1,4,0)
 ;;=4^M19.011
