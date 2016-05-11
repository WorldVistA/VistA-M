IBDEI03D ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1133,1,3,0)
 ;;=3^Electrocochleography
 ;;^UTILITY(U,$J,358.3,1134,0)
 ;;=92562^^7^115^25^^^^1
 ;;^UTILITY(U,$J,358.3,1134,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1134,1,2,0)
 ;;=2^92562
 ;;^UTILITY(U,$J,358.3,1134,1,3,0)
 ;;=3^Loudness Balance Test
 ;;^UTILITY(U,$J,358.3,1135,0)
 ;;=92588^^7^115^27^^^^1
 ;;^UTILITY(U,$J,358.3,1135,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1135,1,2,0)
 ;;=2^92588
 ;;^UTILITY(U,$J,358.3,1135,1,3,0)
 ;;=3^Otoacoustic Emissions,Diagnostic
 ;;^UTILITY(U,$J,358.3,1136,0)
 ;;=92587^^7^115^28^^^^1
 ;;^UTILITY(U,$J,358.3,1136,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1136,1,2,0)
 ;;=2^92587
 ;;^UTILITY(U,$J,358.3,1136,1,3,0)
 ;;=3^Otoacoustic Emissions,Limited
 ;;^UTILITY(U,$J,358.3,1137,0)
 ;;=92552^^7^115^29^^^^1
 ;;^UTILITY(U,$J,358.3,1137,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1137,1,2,0)
 ;;=2^92552
 ;;^UTILITY(U,$J,358.3,1137,1,3,0)
 ;;=3^Pure Tone Audiometry, Air
 ;;^UTILITY(U,$J,358.3,1138,0)
 ;;=92553^^7^115^30^^^^1
 ;;^UTILITY(U,$J,358.3,1138,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1138,1,2,0)
 ;;=2^92553
 ;;^UTILITY(U,$J,358.3,1138,1,3,0)
 ;;=3^Pure Tone Audiometry, Air & Bone
 ;;^UTILITY(U,$J,358.3,1139,0)
 ;;=92570^^7^115^1^^^^1
 ;;^UTILITY(U,$J,358.3,1139,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1139,1,2,0)
 ;;=2^92570
 ;;^UTILITY(U,$J,358.3,1139,1,3,0)
 ;;=3^Acoustic Immittance Testing
 ;;^UTILITY(U,$J,358.3,1140,0)
 ;;=92558^^7^115^16^^^^1
 ;;^UTILITY(U,$J,358.3,1140,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1140,1,2,0)
 ;;=2^92558
 ;;^UTILITY(U,$J,358.3,1140,1,3,0)
 ;;=3^Evoked Otoacoustic Emmissions,Scrn,Auto
 ;;^UTILITY(U,$J,358.3,1141,0)
 ;;=92611^^7^115^26^^^^1
 ;;^UTILITY(U,$J,358.3,1141,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1141,1,2,0)
 ;;=2^92611
 ;;^UTILITY(U,$J,358.3,1141,1,3,0)
 ;;=3^Motion Fluoroscopic Eval Swallowing
 ;;^UTILITY(U,$J,358.3,1142,0)
 ;;=92612^^7^115^22^^^^1
 ;;^UTILITY(U,$J,358.3,1142,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1142,1,2,0)
 ;;=2^92612
 ;;^UTILITY(U,$J,358.3,1142,1,3,0)
 ;;=3^Flexible Fiberoptic Eval Swallowing
 ;;^UTILITY(U,$J,358.3,1143,0)
 ;;=92626^^7^115^14^^^^1
 ;;^UTILITY(U,$J,358.3,1143,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1143,1,2,0)
 ;;=2^92626
 ;;^UTILITY(U,$J,358.3,1143,1,3,0)
 ;;=3^Eval Aud Rehab Status,1st hr
 ;;^UTILITY(U,$J,358.3,1144,0)
 ;;=92627^^7^115^15^^^^1
 ;;^UTILITY(U,$J,358.3,1144,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1144,1,2,0)
 ;;=2^92627
 ;;^UTILITY(U,$J,358.3,1144,1,3,0)
 ;;=3^Eval Aud Rehab Status,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,1145,0)
 ;;=92613^^7^115^21^^^^1
 ;;^UTILITY(U,$J,358.3,1145,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1145,1,2,0)
 ;;=2^92613
 ;;^UTILITY(U,$J,358.3,1145,1,3,0)
 ;;=3^Flex Fib Eval Swallow,Interp/Rpt Only
 ;;^UTILITY(U,$J,358.3,1146,0)
 ;;=92614^^7^115^23^^^^1
 ;;^UTILITY(U,$J,358.3,1146,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1146,1,2,0)
 ;;=2^92614
 ;;^UTILITY(U,$J,358.3,1146,1,3,0)
 ;;=3^Laryngoscopic Sensory Test,Video
 ;;^UTILITY(U,$J,358.3,1147,0)
 ;;=92615^^7^115^24^^^^1
 ;;^UTILITY(U,$J,358.3,1147,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1147,1,2,0)
 ;;=2^92615
 ;;^UTILITY(U,$J,358.3,1147,1,3,0)
 ;;=3^Laryngoscopic Sensory Tst,Interp&Rpt Only
 ;;^UTILITY(U,$J,358.3,1148,0)
 ;;=92560^^7^115^9^^^^1
 ;;^UTILITY(U,$J,358.3,1148,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1148,1,2,0)
 ;;=2^92560
 ;;^UTILITY(U,$J,358.3,1148,1,3,0)
 ;;=3^Bekesy Audiometry,Screening
 ;;^UTILITY(U,$J,358.3,1149,0)
 ;;=92561^^7^115^8^^^^1
 ;;^UTILITY(U,$J,358.3,1149,1,0)
 ;;=^358.31IA^3^2
