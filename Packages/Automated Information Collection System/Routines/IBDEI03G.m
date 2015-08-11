IBDEI03G ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1233,1,3,0)
 ;;=3^Echo,TT,2D,M Mode
 ;;^UTILITY(U,$J,358.3,1234,0)
 ;;=93308^^10^114^5^^^^1
 ;;^UTILITY(U,$J,358.3,1234,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1234,1,2,0)
 ;;=2^93308
 ;;^UTILITY(U,$J,358.3,1234,1,3,0)
 ;;=3^Echo F/U Or Limited Study
 ;;^UTILITY(U,$J,358.3,1235,0)
 ;;=93320^^10^114^3^^^^1
 ;;^UTILITY(U,$J,358.3,1235,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1235,1,2,0)
 ;;=2^93320
 ;;^UTILITY(U,$J,358.3,1235,1,3,0)
 ;;=3^Doppler Echo pulse wave
 ;;^UTILITY(U,$J,358.3,1236,0)
 ;;=93325^^10^114^2^^^^1
 ;;^UTILITY(U,$J,358.3,1236,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1236,1,2,0)
 ;;=2^93325
 ;;^UTILITY(U,$J,358.3,1236,1,3,0)
 ;;=3^Doppler ECHO color flow velocity mapping
 ;;^UTILITY(U,$J,358.3,1237,0)
 ;;=93350^^10^114^14^^^^1
 ;;^UTILITY(U,$J,358.3,1237,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1237,1,2,0)
 ;;=2^93350
 ;;^UTILITY(U,$J,358.3,1237,1,3,0)
 ;;=3^Echo Transthoracic,Rest/Stress Test
 ;;^UTILITY(U,$J,358.3,1238,0)
 ;;=93306^^10^114^17^^^^1
 ;;^UTILITY(U,$J,358.3,1238,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1238,1,2,0)
 ;;=2^93306
 ;;^UTILITY(U,$J,358.3,1238,1,3,0)
 ;;=3^Echo,TT,2D,M Mode w/ Color Doppler
 ;;^UTILITY(U,$J,358.3,1239,0)
 ;;=93321^^10^114^4^^^^1
 ;;^UTILITY(U,$J,358.3,1239,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1239,1,2,0)
 ;;=2^93321
 ;;^UTILITY(U,$J,358.3,1239,1,3,0)
 ;;=3^Doppler Echo, Heart
 ;;^UTILITY(U,$J,358.3,1240,0)
 ;;=93351^^10^114^20^^^^1
 ;;^UTILITY(U,$J,358.3,1240,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1240,1,2,0)
 ;;=2^93351
 ;;^UTILITY(U,$J,358.3,1240,1,3,0)
 ;;=3^Stress TTE Complete
 ;;^UTILITY(U,$J,358.3,1241,0)
 ;;=93352^^10^114^1^^^^1
 ;;^UTILITY(U,$J,358.3,1241,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1241,1,2,0)
 ;;=2^93352
 ;;^UTILITY(U,$J,358.3,1241,1,3,0)
 ;;=3^Admin ECG Contrast Agent
 ;;^UTILITY(U,$J,358.3,1242,0)
 ;;=93312^^10^114^11^^^^1
 ;;^UTILITY(U,$J,358.3,1242,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1242,1,2,0)
 ;;=2^93312
 ;;^UTILITY(U,$J,358.3,1242,1,3,0)
 ;;=3^Echo Transesophageal w/wo M-mode record
 ;;^UTILITY(U,$J,358.3,1243,0)
 ;;=93313^^10^114^10^^^^1
 ;;^UTILITY(U,$J,358.3,1243,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1243,1,2,0)
 ;;=2^93313
 ;;^UTILITY(U,$J,358.3,1243,1,3,0)
 ;;=3^Echo Transesophageal w/ placement of probe
 ;;^UTILITY(U,$J,358.3,1244,0)
 ;;=93314^^10^114^9^^^^1
 ;;^UTILITY(U,$J,358.3,1244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1244,1,2,0)
 ;;=2^93314
 ;;^UTILITY(U,$J,358.3,1244,1,3,0)
 ;;=3^Echo Transesophageal image interp and rpt
 ;;^UTILITY(U,$J,358.3,1245,0)
 ;;=93318^^10^114^18^^^^1
 ;;^UTILITY(U,$J,358.3,1245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1245,1,2,0)
 ;;=2^93318
 ;;^UTILITY(U,$J,358.3,1245,1,3,0)
 ;;=3^Echo,Transesophageal Intraop
 ;;^UTILITY(U,$J,358.3,1246,0)
 ;;=93315^^10^114^12^^^^1
 ;;^UTILITY(U,$J,358.3,1246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1246,1,2,0)
 ;;=2^93315
 ;;^UTILITY(U,$J,358.3,1246,1,3,0)
 ;;=3^Echo Transesophageal,Complete
 ;;^UTILITY(U,$J,358.3,1247,0)
 ;;=93316^^10^114^7^^^^1
 ;;^UTILITY(U,$J,358.3,1247,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1247,1,2,0)
 ;;=2^93316
 ;;^UTILITY(U,$J,358.3,1247,1,3,0)
 ;;=3^Echo Tranesophageal Placement Only
 ;;^UTILITY(U,$J,358.3,1248,0)
 ;;=93317^^10^114^6^^^^1
 ;;^UTILITY(U,$J,358.3,1248,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1248,1,2,0)
 ;;=2^93317
 ;;^UTILITY(U,$J,358.3,1248,1,3,0)
 ;;=3^Echo Image,Inerpretation and Report Only
 ;;^UTILITY(U,$J,358.3,1249,0)
 ;;=93318^^10^114^8^^^^1
 ;;^UTILITY(U,$J,358.3,1249,1,0)
 ;;=^358.31IA^3^2
