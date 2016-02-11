IBDEI048 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1287,1,2,0)
 ;;=2^92601
 ;;^UTILITY(U,$J,358.3,1287,1,3,0)
 ;;=3^Diagnostic Analysis Of Cochlear Implant<7Y
 ;;^UTILITY(U,$J,358.3,1288,0)
 ;;=92602^^13^139^3^^^^1
 ;;^UTILITY(U,$J,358.3,1288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1288,1,2,0)
 ;;=2^92602
 ;;^UTILITY(U,$J,358.3,1288,1,3,0)
 ;;=3^Reprogram Cochlear Implt < 7
 ;;^UTILITY(U,$J,358.3,1289,0)
 ;;=92603^^13^139^4^^^^1
 ;;^UTILITY(U,$J,358.3,1289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1289,1,2,0)
 ;;=2^92603
 ;;^UTILITY(U,$J,358.3,1289,1,3,0)
 ;;=3^Diagnostic Analysis Of Cochlear Implant 7+Y
 ;;^UTILITY(U,$J,358.3,1290,0)
 ;;=92604^^13^139^5^^^^1
 ;;^UTILITY(U,$J,358.3,1290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1290,1,2,0)
 ;;=2^92604
 ;;^UTILITY(U,$J,358.3,1290,1,3,0)
 ;;=3^Subsequent Re-Programming 7+Y
 ;;^UTILITY(U,$J,358.3,1291,0)
 ;;=92508^^13^140^2^^^^1
 ;;^UTILITY(U,$J,358.3,1291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1291,1,2,0)
 ;;=2^92508
 ;;^UTILITY(U,$J,358.3,1291,1,3,0)
 ;;=3^Group Treatment
 ;;^UTILITY(U,$J,358.3,1292,0)
 ;;=95992^^13^140^1^^^^1
 ;;^UTILITY(U,$J,358.3,1292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1292,1,2,0)
 ;;=2^95992
 ;;^UTILITY(U,$J,358.3,1292,1,3,0)
 ;;=3^Canalith Repositioning
 ;;^UTILITY(U,$J,358.3,1293,0)
 ;;=92700^^13^140^3^^^^1
 ;;^UTILITY(U,$J,358.3,1293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1293,1,2,0)
 ;;=2^92700
 ;;^UTILITY(U,$J,358.3,1293,1,3,0)
 ;;=3^Unlisted Otorhinolaryngological Service
 ;;^UTILITY(U,$J,358.3,1294,0)
 ;;=V5275^^13^141^3^^^^1
 ;;^UTILITY(U,$J,358.3,1294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1294,1,2,0)
 ;;=2^V5275
 ;;^UTILITY(U,$J,358.3,1294,1,3,0)
 ;;=3^Ear Impression, Each
 ;;^UTILITY(U,$J,358.3,1295,0)
 ;;=92590^^13^141^10^^^^1
 ;;^UTILITY(U,$J,358.3,1295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1295,1,2,0)
 ;;=2^92590
 ;;^UTILITY(U,$J,358.3,1295,1,3,0)
 ;;=3^HA Assessment,Monaural
 ;;^UTILITY(U,$J,358.3,1296,0)
 ;;=92591^^13^141^9^^^^1
 ;;^UTILITY(U,$J,358.3,1296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1296,1,2,0)
 ;;=2^92591
 ;;^UTILITY(U,$J,358.3,1296,1,3,0)
 ;;=3^HA Assessment,Binaural
 ;;^UTILITY(U,$J,358.3,1297,0)
 ;;=92594^^13^141^8^^^^1
 ;;^UTILITY(U,$J,358.3,1297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1297,1,2,0)
 ;;=2^92594
 ;;^UTILITY(U,$J,358.3,1297,1,3,0)
 ;;=3^Electroacoustic Eval for HA,Monaural
 ;;^UTILITY(U,$J,358.3,1298,0)
 ;;=92595^^13^141^7^^^^1
 ;;^UTILITY(U,$J,358.3,1298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1298,1,2,0)
 ;;=2^92595
 ;;^UTILITY(U,$J,358.3,1298,1,3,0)
 ;;=3^Electroacoustic Eval for HA,Binaural
 ;;^UTILITY(U,$J,358.3,1299,0)
 ;;=92592^^13^141^12^^^^1
 ;;^UTILITY(U,$J,358.3,1299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1299,1,2,0)
 ;;=2^92592
 ;;^UTILITY(U,$J,358.3,1299,1,3,0)
 ;;=3^HA Check,Monaural
 ;;^UTILITY(U,$J,358.3,1300,0)
 ;;=92593^^13^141^11^^^^1
 ;;^UTILITY(U,$J,358.3,1300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1300,1,2,0)
 ;;=2^92593
 ;;^UTILITY(U,$J,358.3,1300,1,3,0)
 ;;=3^HA Check,Binaural
 ;;^UTILITY(U,$J,358.3,1301,0)
 ;;=V5014^^13^141^13^^^^1
 ;;^UTILITY(U,$J,358.3,1301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1301,1,2,0)
 ;;=2^V5014
 ;;^UTILITY(U,$J,358.3,1301,1,3,0)
 ;;=3^HA Repair/Modification
 ;;^UTILITY(U,$J,358.3,1302,0)
 ;;=V5020^^13^141^16^^^^1
 ;;^UTILITY(U,$J,358.3,1302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1302,1,2,0)
 ;;=2^V5020
 ;;^UTILITY(U,$J,358.3,1302,1,3,0)
 ;;=3^Real-Ear(Probe Tube) Measurement
 ;;^UTILITY(U,$J,358.3,1303,0)
 ;;=S0618^^13^141^1^^^^1
 ;;^UTILITY(U,$J,358.3,1303,1,0)
 ;;=^358.31IA^3^2
