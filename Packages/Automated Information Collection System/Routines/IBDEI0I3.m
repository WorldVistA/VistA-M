IBDEI0I3 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8759,0)
 ;;=375.15^^52^586^19
 ;;^UTILITY(U,$J,358.3,8759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8759,1,3,0)
 ;;=3^Dry Eye Syndrome
 ;;^UTILITY(U,$J,358.3,8759,1,4,0)
 ;;=4^375.15
 ;;^UTILITY(U,$J,358.3,8759,2)
 ;;=Dry Eye Syndrome^37168
 ;;^UTILITY(U,$J,358.3,8760,0)
 ;;=368.40^^52^586^50
 ;;^UTILITY(U,$J,358.3,8760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8760,1,3,0)
 ;;=3^Visual Field Defect,Unspec
 ;;^UTILITY(U,$J,358.3,8760,1,4,0)
 ;;=4^368.40
 ;;^UTILITY(U,$J,358.3,8760,2)
 ;;=Visual Field Defect^126859
 ;;^UTILITY(U,$J,358.3,8761,0)
 ;;=366.53^^52^586^3
 ;;^UTILITY(U,$J,358.3,8761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8761,1,3,0)
 ;;=3^After Cataract Obscurring Vision
 ;;^UTILITY(U,$J,358.3,8761,1,4,0)
 ;;=4^366.53
 ;;^UTILITY(U,$J,358.3,8761,2)
 ;;=After Cataract Obscurring Vision^268823
 ;;^UTILITY(U,$J,358.3,8762,0)
 ;;=366.9^^52^586^10
 ;;^UTILITY(U,$J,358.3,8762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8762,1,3,0)
 ;;=3^Cataract, Unspecified
 ;;^UTILITY(U,$J,358.3,8762,1,4,0)
 ;;=4^366.9
 ;;^UTILITY(U,$J,358.3,8762,2)
 ;;=Cataract, Unspecified^20266
 ;;^UTILITY(U,$J,358.3,8763,0)
 ;;=362.83^^52^586^35
 ;;^UTILITY(U,$J,358.3,8763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8763,1,3,0)
 ;;=3^Macular Edema (CSME)
 ;;^UTILITY(U,$J,358.3,8763,1,4,0)
 ;;=4^362.83
 ;;^UTILITY(U,$J,358.3,8763,2)
 ;;=Macular Edema^89576
 ;;^UTILITY(U,$J,358.3,8764,0)
 ;;=362.52^^52^586^11
 ;;^UTILITY(U,$J,358.3,8764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8764,1,3,0)
 ;;=3^Cystoid Macular Degeneration
 ;;^UTILITY(U,$J,358.3,8764,1,4,0)
 ;;=4^362.52
 ;;^UTILITY(U,$J,358.3,8764,2)
 ;;=^268637
 ;;^UTILITY(U,$J,358.3,8765,0)
 ;;=367.22^^52^586^32
 ;;^UTILITY(U,$J,358.3,8765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8765,1,3,0)
 ;;=3^Irregular Astigmatism
 ;;^UTILITY(U,$J,358.3,8765,1,4,0)
 ;;=4^367.22
 ;;^UTILITY(U,$J,358.3,8765,2)
 ;;=^265373
 ;;^UTILITY(U,$J,358.3,8766,0)
 ;;=V45.69^^52^586^49
 ;;^UTILITY(U,$J,358.3,8766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8766,1,3,0)
 ;;=3^States Following Surg of Eye
 ;;^UTILITY(U,$J,358.3,8766,1,4,0)
 ;;=4^V45.69
 ;;^UTILITY(U,$J,358.3,8766,2)
 ;;=^317957
 ;;^UTILITY(U,$J,358.3,8767,0)
 ;;=V58.71^^52^586^4
 ;;^UTILITY(U,$J,358.3,8767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8767,1,3,0)
 ;;=3^Aftercare Following Surg of Sense Organ
 ;;^UTILITY(U,$J,358.3,8767,1,4,0)
 ;;=4
 ;;^UTILITY(U,$J,358.3,8767,2)
 ;;=^328689
 ;;^UTILITY(U,$J,358.3,8768,0)
 ;;=V45.61^^52^586^9
 ;;^UTILITY(U,$J,358.3,8768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8768,1,3,0)
 ;;=3^Cataract Extraction Status
 ;;^UTILITY(U,$J,358.3,8768,1,4,0)
 ;;=4^V45.61
 ;;^UTILITY(U,$J,358.3,8768,2)
 ;;=^295462
 ;;^UTILITY(U,$J,358.3,8769,0)
 ;;=V72.0^^52^586^21
 ;;^UTILITY(U,$J,358.3,8769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8769,1,3,0)
 ;;=3^Eye Exam
 ;;^UTILITY(U,$J,358.3,8769,1,4,0)
 ;;=4^V72.0
 ;;^UTILITY(U,$J,358.3,8769,2)
 ;;=^43432
 ;;^UTILITY(U,$J,358.3,8770,0)
 ;;=V71.89^^52^586^38
 ;;^UTILITY(U,$J,358.3,8770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8770,1,3,0)
 ;;=3^Observe SPEC Condition
 ;;^UTILITY(U,$J,358.3,8770,1,4,0)
 ;;=4^V71.89
 ;;^UTILITY(U,$J,358.3,8770,2)
 ;;=^322082
 ;;^UTILITY(U,$J,358.3,8771,0)
 ;;=V50.1^^52^586^39
 ;;^UTILITY(U,$J,358.3,8771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8771,1,3,0)
 ;;=3^Oth Plastic Surgery
 ;;^UTILITY(U,$J,358.3,8771,1,4,0)
 ;;=4^V50.1
 ;;^UTILITY(U,$J,358.3,8771,2)
 ;;=^87802
 ;;^UTILITY(U,$J,358.3,8772,0)
 ;;=368.8^^52^586^40
 ;;^UTILITY(U,$J,358.3,8772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8772,1,3,0)
 ;;=3^Oth Specific Visual Disturbances
