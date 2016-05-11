IBDEI05E ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2154,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2154,1,2,0)
 ;;=2^93307
 ;;^UTILITY(U,$J,358.3,2154,1,3,0)
 ;;=3^Echo,TT,2D,M Mode
 ;;^UTILITY(U,$J,358.3,2155,0)
 ;;=93308^^12^171^5^^^^1
 ;;^UTILITY(U,$J,358.3,2155,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2155,1,2,0)
 ;;=2^93308
 ;;^UTILITY(U,$J,358.3,2155,1,3,0)
 ;;=3^Echo F/U Or Limited Study
 ;;^UTILITY(U,$J,358.3,2156,0)
 ;;=93320^^12^171^3^^^^1
 ;;^UTILITY(U,$J,358.3,2156,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2156,1,2,0)
 ;;=2^93320
 ;;^UTILITY(U,$J,358.3,2156,1,3,0)
 ;;=3^Doppler Echo pulse wave
 ;;^UTILITY(U,$J,358.3,2157,0)
 ;;=93325^^12^171^2^^^^1
 ;;^UTILITY(U,$J,358.3,2157,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2157,1,2,0)
 ;;=2^93325
 ;;^UTILITY(U,$J,358.3,2157,1,3,0)
 ;;=3^Doppler ECHO color flow velocity mapping
 ;;^UTILITY(U,$J,358.3,2158,0)
 ;;=93350^^12^171^15^^^^1
 ;;^UTILITY(U,$J,358.3,2158,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2158,1,2,0)
 ;;=2^93350
 ;;^UTILITY(U,$J,358.3,2158,1,3,0)
 ;;=3^Echo Transthoracic,Rest/Stress Test
 ;;^UTILITY(U,$J,358.3,2159,0)
 ;;=93306^^12^171^18^^^^1
 ;;^UTILITY(U,$J,358.3,2159,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2159,1,2,0)
 ;;=2^93306
 ;;^UTILITY(U,$J,358.3,2159,1,3,0)
 ;;=3^Echo,TT,2D,M Mode w/ Color Doppler
 ;;^UTILITY(U,$J,358.3,2160,0)
 ;;=93321^^12^171^4^^^^1
 ;;^UTILITY(U,$J,358.3,2160,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2160,1,2,0)
 ;;=2^93321
 ;;^UTILITY(U,$J,358.3,2160,1,3,0)
 ;;=3^Doppler Echo, Heart
 ;;^UTILITY(U,$J,358.3,2161,0)
 ;;=93351^^12^171^20^^^^1
 ;;^UTILITY(U,$J,358.3,2161,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2161,1,2,0)
 ;;=2^93351
 ;;^UTILITY(U,$J,358.3,2161,1,3,0)
 ;;=3^Stress TTE Complete
 ;;^UTILITY(U,$J,358.3,2162,0)
 ;;=93352^^12^171^1^^^^1
 ;;^UTILITY(U,$J,358.3,2162,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2162,1,2,0)
 ;;=2^93352
 ;;^UTILITY(U,$J,358.3,2162,1,3,0)
 ;;=3^Admin ECHO Contrast Agent
 ;;^UTILITY(U,$J,358.3,2163,0)
 ;;=93312^^12^171^11^^^^1
 ;;^UTILITY(U,$J,358.3,2163,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2163,1,2,0)
 ;;=2^93312
 ;;^UTILITY(U,$J,358.3,2163,1,3,0)
 ;;=3^Echo Transesophageal w/wo M-mode record
 ;;^UTILITY(U,$J,358.3,2164,0)
 ;;=93313^^12^171^10^^^^1
 ;;^UTILITY(U,$J,358.3,2164,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2164,1,2,0)
 ;;=2^93313
 ;;^UTILITY(U,$J,358.3,2164,1,3,0)
 ;;=3^Echo Transesophageal w/ placement of probe
 ;;^UTILITY(U,$J,358.3,2165,0)
 ;;=93314^^12^171^9^^^^1
 ;;^UTILITY(U,$J,358.3,2165,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2165,1,2,0)
 ;;=2^93314
 ;;^UTILITY(U,$J,358.3,2165,1,3,0)
 ;;=3^Echo Transesophageal image interp and rpt
 ;;^UTILITY(U,$J,358.3,2166,0)
 ;;=93318^^12^171^19^^^^1
 ;;^UTILITY(U,$J,358.3,2166,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2166,1,2,0)
 ;;=2^93318
 ;;^UTILITY(U,$J,358.3,2166,1,3,0)
 ;;=3^Echo,Transesophageal Intraop
 ;;^UTILITY(U,$J,358.3,2167,0)
 ;;=93315^^12^171^12^^^^1
 ;;^UTILITY(U,$J,358.3,2167,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2167,1,2,0)
 ;;=2^93315
 ;;^UTILITY(U,$J,358.3,2167,1,3,0)
 ;;=3^Echo Transesophageal,Complete
 ;;^UTILITY(U,$J,358.3,2168,0)
 ;;=93316^^12^171^7^^^^1
 ;;^UTILITY(U,$J,358.3,2168,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2168,1,2,0)
 ;;=2^93316
 ;;^UTILITY(U,$J,358.3,2168,1,3,0)
 ;;=3^Echo Tranesophageal Placement Only
 ;;^UTILITY(U,$J,358.3,2169,0)
 ;;=93317^^12^171^6^^^^1
 ;;^UTILITY(U,$J,358.3,2169,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2169,1,2,0)
 ;;=2^93317
 ;;^UTILITY(U,$J,358.3,2169,1,3,0)
 ;;=3^Echo Image,Inerpretation and Report Only
