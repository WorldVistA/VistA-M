IBDEI02U ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,944,0)
 ;;=V5014^^12^104^11^^^^1
 ;;^UTILITY(U,$J,358.3,944,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,944,1,2,0)
 ;;=2^V5014
 ;;^UTILITY(U,$J,358.3,944,1,3,0)
 ;;=3^HA Repair/Modification
 ;;^UTILITY(U,$J,358.3,945,0)
 ;;=V5020^^12^104^12^^^^1
 ;;^UTILITY(U,$J,358.3,945,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,945,1,2,0)
 ;;=2^V5020
 ;;^UTILITY(U,$J,358.3,945,1,3,0)
 ;;=3^Real-Ear(Probe Tube) Measurement
 ;;^UTILITY(U,$J,358.3,946,0)
 ;;=L7510^^12^104^13^^^^1
 ;;^UTILITY(U,$J,358.3,946,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,946,1,2,0)
 ;;=2^L7510
 ;;^UTILITY(U,$J,358.3,946,1,3,0)
 ;;=3^Repair/Modify Prosthetic Device
 ;;^UTILITY(U,$J,358.3,947,0)
 ;;=L8499^^12^104^14^^^^1
 ;;^UTILITY(U,$J,358.3,947,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,947,1,2,0)
 ;;=2^L8499
 ;;^UTILITY(U,$J,358.3,947,1,3,0)
 ;;=3^Unlisted Misc Prosthetic Ser
 ;;^UTILITY(U,$J,358.3,948,0)
 ;;=S0618^^12^104^1^^^^1
 ;;^UTILITY(U,$J,358.3,948,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,948,1,2,0)
 ;;=2^S0618
 ;;^UTILITY(U,$J,358.3,948,1,3,0)
 ;;=3^Audiometry For Hearing Aid
 ;;^UTILITY(U,$J,358.3,949,0)
 ;;=97762^^12^104^2^^^^1
 ;;^UTILITY(U,$J,358.3,949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,949,1,2,0)
 ;;=2^97762
 ;;^UTILITY(U,$J,358.3,949,1,3,0)
 ;;=3^C/O for Orthotic/Prosth Use
 ;;^UTILITY(U,$J,358.3,950,0)
 ;;=V5110^^12^104^10^^^^1
 ;;^UTILITY(U,$J,358.3,950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,950,1,2,0)
 ;;=2^V5110
 ;;^UTILITY(U,$J,358.3,950,1,3,0)
 ;;=3^HA Dispensing,Bilateral
 ;;^UTILITY(U,$J,358.3,951,0)
 ;;=69200^^12^105^1^^^^1
 ;;^UTILITY(U,$J,358.3,951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,951,1,2,0)
 ;;=2^69200
 ;;^UTILITY(U,$J,358.3,951,1,3,0)
 ;;=3^Remove Foreign Body, External Canal
 ;;^UTILITY(U,$J,358.3,952,0)
 ;;=69210^^12^105^2^^^^1
 ;;^UTILITY(U,$J,358.3,952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,952,1,2,0)
 ;;=2^69210
 ;;^UTILITY(U,$J,358.3,952,1,3,0)
 ;;=3^Remove Impacted Ear Wax 1 or 2 ears
 ;;^UTILITY(U,$J,358.3,953,0)
 ;;=92543^^12^106^2^^^^1
 ;;^UTILITY(U,$J,358.3,953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,953,1,2,0)
 ;;=2^92543
 ;;^UTILITY(U,$J,358.3,953,1,3,0)
 ;;=3^Caloric Vestibular Test, W/Recording, Each
 ;;^UTILITY(U,$J,358.3,954,0)
 ;;=92548^^12^106^3^^^^1
 ;;^UTILITY(U,$J,358.3,954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,954,1,2,0)
 ;;=2^92548
 ;;^UTILITY(U,$J,358.3,954,1,3,0)
 ;;=3^Computerized Dynamic Posturography
 ;;^UTILITY(U,$J,358.3,955,0)
 ;;=92544^^12^106^4^^^^1
 ;;^UTILITY(U,$J,358.3,955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,955,1,2,0)
 ;;=2^92544
 ;;^UTILITY(U,$J,358.3,955,1,3,0)
 ;;=3^Optokinetic Nystagmus Test Bidirec,w/Recording
 ;;^UTILITY(U,$J,358.3,956,0)
 ;;=92545^^12^106^5^^^^1
 ;;^UTILITY(U,$J,358.3,956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,956,1,2,0)
 ;;=2^92545
 ;;^UTILITY(U,$J,358.3,956,1,3,0)
 ;;=3^Oscillating Tracking Test W/Recording
 ;;^UTILITY(U,$J,358.3,957,0)
 ;;=92542^^12^106^6^^^^1
 ;;^UTILITY(U,$J,358.3,957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,957,1,2,0)
 ;;=2^92542
 ;;^UTILITY(U,$J,358.3,957,1,3,0)
 ;;=3^Positional Nystagmus Test min 4 pos w/Recording
 ;;^UTILITY(U,$J,358.3,958,0)
 ;;=92546^^12^106^7^^^^1
 ;;^UTILITY(U,$J,358.3,958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,958,1,2,0)
 ;;=2^92546
 ;;^UTILITY(U,$J,358.3,958,1,3,0)
 ;;=3^Sinusiodal Vertical Axis Rotation
 ;;^UTILITY(U,$J,358.3,959,0)
 ;;=92547^^12^106^9^^^^1
 ;;^UTILITY(U,$J,358.3,959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,959,1,2,0)
 ;;=2^92547
 ;;^UTILITY(U,$J,358.3,959,1,3,0)
 ;;=3^Vertical Channel (Add On To Each Eng Code)
