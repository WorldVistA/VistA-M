IBDEI02V ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,897,1,3,0)
 ;;=3^Electroacoustic Eval for HA,Monaural
 ;;^UTILITY(U,$J,358.3,898,0)
 ;;=92595^^9^96^4^^^^1
 ;;^UTILITY(U,$J,358.3,898,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,898,1,2,0)
 ;;=2^92595
 ;;^UTILITY(U,$J,358.3,898,1,3,0)
 ;;=3^Electroacoustic Eval for HA,Binaural
 ;;^UTILITY(U,$J,358.3,899,0)
 ;;=92592^^9^96^9^^^^1
 ;;^UTILITY(U,$J,358.3,899,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,899,1,2,0)
 ;;=2^92592
 ;;^UTILITY(U,$J,358.3,899,1,3,0)
 ;;=3^HA Check,Monaural
 ;;^UTILITY(U,$J,358.3,900,0)
 ;;=92593^^9^96^8^^^^1
 ;;^UTILITY(U,$J,358.3,900,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,900,1,2,0)
 ;;=2^92593
 ;;^UTILITY(U,$J,358.3,900,1,3,0)
 ;;=3^HA Check,Binaural
 ;;^UTILITY(U,$J,358.3,901,0)
 ;;=V5014^^9^96^10^^^^1
 ;;^UTILITY(U,$J,358.3,901,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,901,1,2,0)
 ;;=2^V5014
 ;;^UTILITY(U,$J,358.3,901,1,3,0)
 ;;=3^HA Repair/Modification
 ;;^UTILITY(U,$J,358.3,902,0)
 ;;=V5020^^9^96^11^^^^1
 ;;^UTILITY(U,$J,358.3,902,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,902,1,2,0)
 ;;=2^V5020
 ;;^UTILITY(U,$J,358.3,902,1,3,0)
 ;;=3^Real-Ear(Probe Tube) Measurement
 ;;^UTILITY(U,$J,358.3,903,0)
 ;;=S0618^^9^96^1^^^^1
 ;;^UTILITY(U,$J,358.3,903,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,903,1,2,0)
 ;;=2^S0618
 ;;^UTILITY(U,$J,358.3,903,1,3,0)
 ;;=3^Audiometry For Hearing Aid
 ;;^UTILITY(U,$J,358.3,904,0)
 ;;=97762^^9^96^2^^^^1
 ;;^UTILITY(U,$J,358.3,904,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,904,1,2,0)
 ;;=2^97762
 ;;^UTILITY(U,$J,358.3,904,1,3,0)
 ;;=3^C/O for Orthotic/Prosth Use
 ;;^UTILITY(U,$J,358.3,905,0)
 ;;=69200^^9^97^1^^^^1
 ;;^UTILITY(U,$J,358.3,905,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,905,1,2,0)
 ;;=2^69200
 ;;^UTILITY(U,$J,358.3,905,1,3,0)
 ;;=3^Remove Foreign Body, External Canal
 ;;^UTILITY(U,$J,358.3,906,0)
 ;;=69210^^9^97^2^^^^1
 ;;^UTILITY(U,$J,358.3,906,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,906,1,2,0)
 ;;=2^69210
 ;;^UTILITY(U,$J,358.3,906,1,3,0)
 ;;=3^Remove Impacted Ear Wax 1 or 2 ears
 ;;^UTILITY(U,$J,358.3,907,0)
 ;;=92543^^9^98^2^^^^1
 ;;^UTILITY(U,$J,358.3,907,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,907,1,2,0)
 ;;=2^92543
 ;;^UTILITY(U,$J,358.3,907,1,3,0)
 ;;=3^Caloric Vestibular Test, W/Recording, Each
 ;;^UTILITY(U,$J,358.3,908,0)
 ;;=92548^^9^98^3^^^^1
 ;;^UTILITY(U,$J,358.3,908,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,908,1,2,0)
 ;;=2^92548
 ;;^UTILITY(U,$J,358.3,908,1,3,0)
 ;;=3^Computerized Dynamic Posturography
 ;;^UTILITY(U,$J,358.3,909,0)
 ;;=92544^^9^98^4^^^^1
 ;;^UTILITY(U,$J,358.3,909,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,909,1,2,0)
 ;;=2^92544
 ;;^UTILITY(U,$J,358.3,909,1,3,0)
 ;;=3^Optokinetic Nystagmus Test Bidirec,w/Recording
 ;;^UTILITY(U,$J,358.3,910,0)
 ;;=92545^^9^98^5^^^^1
 ;;^UTILITY(U,$J,358.3,910,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,910,1,2,0)
 ;;=2^92545
 ;;^UTILITY(U,$J,358.3,910,1,3,0)
 ;;=3^Oscillating Tracking Test W/Recording
 ;;^UTILITY(U,$J,358.3,911,0)
 ;;=92542^^9^98^6^^^^1
 ;;^UTILITY(U,$J,358.3,911,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,911,1,2,0)
 ;;=2^92542
 ;;^UTILITY(U,$J,358.3,911,1,3,0)
 ;;=3^Positional Nystagmus Test min 4 pos w/Recording
 ;;^UTILITY(U,$J,358.3,912,0)
 ;;=92546^^9^98^7^^^^1
 ;;^UTILITY(U,$J,358.3,912,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,912,1,2,0)
 ;;=2^92546
 ;;^UTILITY(U,$J,358.3,912,1,3,0)
 ;;=3^Sinusiodal Vertical Axis Rotation
 ;;^UTILITY(U,$J,358.3,913,0)
 ;;=92547^^9^98^9^^^^1
 ;;^UTILITY(U,$J,358.3,913,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,913,1,2,0)
 ;;=2^92547
 ;;^UTILITY(U,$J,358.3,913,1,3,0)
 ;;=3^Vertical Channel (Add On To Each Eng Code)
