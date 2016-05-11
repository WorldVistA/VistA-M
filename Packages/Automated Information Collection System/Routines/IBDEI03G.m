IBDEI03G ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1181,1,2,0)
 ;;=2^69200
 ;;^UTILITY(U,$J,358.3,1181,1,3,0)
 ;;=3^Remove Foreign Body, External Canal
 ;;^UTILITY(U,$J,358.3,1182,0)
 ;;=69210^^7^120^3^^^^1
 ;;^UTILITY(U,$J,358.3,1182,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1182,1,2,0)
 ;;=2^69210
 ;;^UTILITY(U,$J,358.3,1182,1,3,0)
 ;;=3^Remove Impacted Cerumen,Req Instrument,Unilateral
 ;;^UTILITY(U,$J,358.3,1183,0)
 ;;=69209^^7^120^2^^^^1
 ;;^UTILITY(U,$J,358.3,1183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1183,1,2,0)
 ;;=2^69209
 ;;^UTILITY(U,$J,358.3,1183,1,3,0)
 ;;=3^Remove Impacted Cerumen,Lavage,Unilateral
 ;;^UTILITY(U,$J,358.3,1184,0)
 ;;=92548^^7^121^4^^^^1
 ;;^UTILITY(U,$J,358.3,1184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1184,1,2,0)
 ;;=2^92548
 ;;^UTILITY(U,$J,358.3,1184,1,3,0)
 ;;=3^Computerized Dynamic Posturography
 ;;^UTILITY(U,$J,358.3,1185,0)
 ;;=92544^^7^121^5^^^^1
 ;;^UTILITY(U,$J,358.3,1185,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1185,1,2,0)
 ;;=2^92544
 ;;^UTILITY(U,$J,358.3,1185,1,3,0)
 ;;=3^Optokinetic Nystagmus Test Bidirec,w/Recording
 ;;^UTILITY(U,$J,358.3,1186,0)
 ;;=92545^^7^121^6^^^^1
 ;;^UTILITY(U,$J,358.3,1186,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1186,1,2,0)
 ;;=2^92545
 ;;^UTILITY(U,$J,358.3,1186,1,3,0)
 ;;=3^Oscillating Tracking Test W/Recording
 ;;^UTILITY(U,$J,358.3,1187,0)
 ;;=92542^^7^121^7^^^^1
 ;;^UTILITY(U,$J,358.3,1187,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1187,1,2,0)
 ;;=2^92542
 ;;^UTILITY(U,$J,358.3,1187,1,3,0)
 ;;=3^Positional Nystagmus Test min 4 pos w/Recording
 ;;^UTILITY(U,$J,358.3,1188,0)
 ;;=92546^^7^121^8^^^^1
 ;;^UTILITY(U,$J,358.3,1188,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1188,1,2,0)
 ;;=2^92546
 ;;^UTILITY(U,$J,358.3,1188,1,3,0)
 ;;=3^Sinusiodal Vertical Axis Rotation
 ;;^UTILITY(U,$J,358.3,1189,0)
 ;;=92547^^7^121^10^^^^1
 ;;^UTILITY(U,$J,358.3,1189,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1189,1,2,0)
 ;;=2^92547
 ;;^UTILITY(U,$J,358.3,1189,1,3,0)
 ;;=3^Vertical Channel (Add On To Each Eng Code)
 ;;^UTILITY(U,$J,358.3,1190,0)
 ;;=92541^^7^121^9^^^^1
 ;;^UTILITY(U,$J,358.3,1190,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1190,1,2,0)
 ;;=2^92541
 ;;^UTILITY(U,$J,358.3,1190,1,3,0)
 ;;=3^Spontaneous Nystagmus Test W/Recording
 ;;^UTILITY(U,$J,358.3,1191,0)
 ;;=92540^^7^121^1^^^^1
 ;;^UTILITY(U,$J,358.3,1191,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1191,1,2,0)
 ;;=2^92540
 ;;^UTILITY(U,$J,358.3,1191,1,3,0)
 ;;=3^Basic Vestibular Eval w/Recordings
 ;;^UTILITY(U,$J,358.3,1192,0)
 ;;=92537^^7^121^2^^^^1
 ;;^UTILITY(U,$J,358.3,1192,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1192,1,2,0)
 ;;=2^92537
 ;;^UTILITY(U,$J,358.3,1192,1,3,0)
 ;;=3^Caloric Vstblr Test w/ Rec,Bilat;Bithermal
 ;;^UTILITY(U,$J,358.3,1193,0)
 ;;=92538^^7^121^3^^^^1
 ;;^UTILITY(U,$J,358.3,1193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1193,1,2,0)
 ;;=2^92538
 ;;^UTILITY(U,$J,358.3,1193,1,3,0)
 ;;=3^Caloric Vstblr Test w/ Rec,Bilat;Monothermal
 ;;^UTILITY(U,$J,358.3,1194,0)
 ;;=92531^^7^122^1^^^^1
 ;;^UTILITY(U,$J,358.3,1194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1194,1,2,0)
 ;;=2^92531
 ;;^UTILITY(U,$J,358.3,1194,1,3,0)
 ;;=3^Spontaneous Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,1195,0)
 ;;=92532^^7^122^2^^^^1
 ;;^UTILITY(U,$J,358.3,1195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1195,1,2,0)
 ;;=2^92532
 ;;^UTILITY(U,$J,358.3,1195,1,3,0)
 ;;=3^Positional Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,1196,0)
 ;;=92533^^7^122^3^^^^1
 ;;^UTILITY(U,$J,358.3,1196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1196,1,2,0)
 ;;=2^92533
