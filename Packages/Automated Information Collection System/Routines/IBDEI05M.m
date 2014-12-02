IBDEI05M ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2392,1,2,0)
 ;;=2^Electrical Stimulation
 ;;^UTILITY(U,$J,358.3,2392,1,3,0)
 ;;=3^97032
 ;;^UTILITY(U,$J,358.3,2393,0)
 ;;=97010^^24^223^4^^^^1
 ;;^UTILITY(U,$J,358.3,2393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2393,1,2,0)
 ;;=2^Hot Or Cold Packs Therapy
 ;;^UTILITY(U,$J,358.3,2393,1,3,0)
 ;;=3^97010
 ;;^UTILITY(U,$J,358.3,2394,0)
 ;;=97036^^24^223^5^^^^1
 ;;^UTILITY(U,$J,358.3,2394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2394,1,2,0)
 ;;=2^Hydrotherapy
 ;;^UTILITY(U,$J,358.3,2394,1,3,0)
 ;;=3^97036
 ;;^UTILITY(U,$J,358.3,2395,0)
 ;;=97124^^24^223^7^^^^1
 ;;^UTILITY(U,$J,358.3,2395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2395,1,2,0)
 ;;=2^Massage Therapy
 ;;^UTILITY(U,$J,358.3,2395,1,3,0)
 ;;=3^97124
 ;;^UTILITY(U,$J,358.3,2396,0)
 ;;=64550^^24^223^1^^^^1
 ;;^UTILITY(U,$J,358.3,2396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2396,1,2,0)
 ;;=2^Apply Neurostimulator
 ;;^UTILITY(U,$J,358.3,2396,1,3,0)
 ;;=3^64550
 ;;^UTILITY(U,$J,358.3,2397,0)
 ;;=97012^^24^223^8^^^^1
 ;;^UTILITY(U,$J,358.3,2397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2397,1,2,0)
 ;;=2^Mechanical Traction Therapy 
 ;;^UTILITY(U,$J,358.3,2397,1,3,0)
 ;;=3^97012
 ;;^UTILITY(U,$J,358.3,2398,0)
 ;;=97035^^24^223^11^^^^1
 ;;^UTILITY(U,$J,358.3,2398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2398,1,2,0)
 ;;=2^Ultrasound Therapy
 ;;^UTILITY(U,$J,358.3,2398,1,3,0)
 ;;=3^97035
 ;;^UTILITY(U,$J,358.3,2399,0)
 ;;=97028^^24^223^12^^^^1
 ;;^UTILITY(U,$J,358.3,2399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2399,1,2,0)
 ;;=2^Ultraviolet Therapy
 ;;^UTILITY(U,$J,358.3,2399,1,3,0)
 ;;=3^97028
 ;;^UTILITY(U,$J,358.3,2400,0)
 ;;=97110^^24^223^10^^^^1
 ;;^UTILITY(U,$J,358.3,2400,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2400,1,2,0)
 ;;=2^Therapeutic Exercises,Ea 15min
 ;;^UTILITY(U,$J,358.3,2400,1,3,0)
 ;;=3^97110
 ;;^UTILITY(U,$J,358.3,2401,0)
 ;;=97112^^24^223^9^^^^1
 ;;^UTILITY(U,$J,358.3,2401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2401,1,2,0)
 ;;=2^Neuromuscular Re-Education
 ;;^UTILITY(U,$J,358.3,2401,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,2402,0)
 ;;=97140^^24^223^6^^^^1
 ;;^UTILITY(U,$J,358.3,2402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2402,1,2,0)
 ;;=2^Manual Therapy,Ea 15min
 ;;^UTILITY(U,$J,358.3,2402,1,3,0)
 ;;=3^97140
 ;;^UTILITY(U,$J,358.3,2403,0)
 ;;=98940^^24^224^1^^^^1
 ;;^UTILITY(U,$J,358.3,2403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2403,1,2,0)
 ;;=2^CMT; Spinal, one to two regions
 ;;^UTILITY(U,$J,358.3,2403,1,3,0)
 ;;=3^98940
 ;;^UTILITY(U,$J,358.3,2404,0)
 ;;=98941^^24^224^2^^^^1
 ;;^UTILITY(U,$J,358.3,2404,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2404,1,2,0)
 ;;=2^CMT; Spinal, three to four regions
 ;;^UTILITY(U,$J,358.3,2404,1,3,0)
 ;;=3^98941
 ;;^UTILITY(U,$J,358.3,2405,0)
 ;;=98942^^24^224^3^^^^1
 ;;^UTILITY(U,$J,358.3,2405,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2405,1,2,0)
 ;;=2^CMT; Spinal, five regions
 ;;^UTILITY(U,$J,358.3,2405,1,3,0)
 ;;=3^98942
 ;;^UTILITY(U,$J,358.3,2406,0)
 ;;=98943^^24^224^4^^^^1
 ;;^UTILITY(U,$J,358.3,2406,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2406,1,2,0)
 ;;=2^CMT; Extraspinal, one or more regions
 ;;^UTILITY(U,$J,358.3,2406,1,3,0)
 ;;=3^98943
 ;;^UTILITY(U,$J,358.3,2407,0)
 ;;=98925^^24^225^1^^^^1
 ;;^UTILITY(U,$J,358.3,2407,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2407,1,2,0)
 ;;=2^OMT, 1-2 body regions involved
 ;;^UTILITY(U,$J,358.3,2407,1,3,0)
 ;;=3^98925
 ;;^UTILITY(U,$J,358.3,2408,0)
 ;;=98926^^24^225^2^^^^1
 ;;^UTILITY(U,$J,358.3,2408,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2408,1,2,0)
 ;;=2^OMT, 3-4 body regions involved
