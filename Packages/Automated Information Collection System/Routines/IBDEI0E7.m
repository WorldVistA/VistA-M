IBDEI0E7 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6079,1,2,0)
 ;;=2^93321
 ;;^UTILITY(U,$J,358.3,6079,1,3,0)
 ;;=3^Doppler ECHO,Heart,F/U or Limited
 ;;^UTILITY(U,$J,358.3,6080,0)
 ;;=93351^^52^394^22^^^^1
 ;;^UTILITY(U,$J,358.3,6080,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6080,1,2,0)
 ;;=2^93351
 ;;^UTILITY(U,$J,358.3,6080,1,3,0)
 ;;=3^Stress TTE Complete
 ;;^UTILITY(U,$J,358.3,6081,0)
 ;;=93352^^52^394^1^^^^1
 ;;^UTILITY(U,$J,358.3,6081,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6081,1,2,0)
 ;;=2^93352
 ;;^UTILITY(U,$J,358.3,6081,1,3,0)
 ;;=3^Admin ECHO Contrast Agent
 ;;^UTILITY(U,$J,358.3,6082,0)
 ;;=93312^^52^394^14^^^^1
 ;;^UTILITY(U,$J,358.3,6082,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6082,1,2,0)
 ;;=2^93312
 ;;^UTILITY(U,$J,358.3,6082,1,3,0)
 ;;=3^Echo Transesophageal w/wo M-mode record
 ;;^UTILITY(U,$J,358.3,6083,0)
 ;;=93313^^52^394^13^^^^1
 ;;^UTILITY(U,$J,358.3,6083,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6083,1,2,0)
 ;;=2^93313
 ;;^UTILITY(U,$J,358.3,6083,1,3,0)
 ;;=3^Echo Transesophageal w/ placement of probe
 ;;^UTILITY(U,$J,358.3,6084,0)
 ;;=93314^^52^394^12^^^^1
 ;;^UTILITY(U,$J,358.3,6084,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6084,1,2,0)
 ;;=2^93314
 ;;^UTILITY(U,$J,358.3,6084,1,3,0)
 ;;=3^Echo Transesophageal image interp and rpt
 ;;^UTILITY(U,$J,358.3,6085,0)
 ;;=93318^^52^394^9^^^^1
 ;;^UTILITY(U,$J,358.3,6085,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6085,1,2,0)
 ;;=2^93318
 ;;^UTILITY(U,$J,358.3,6085,1,3,0)
 ;;=3^Echo Transesophageal Intraop
 ;;^UTILITY(U,$J,358.3,6086,0)
 ;;=93315^^52^394^15^^^^1
 ;;^UTILITY(U,$J,358.3,6086,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6086,1,2,0)
 ;;=2^93315
 ;;^UTILITY(U,$J,358.3,6086,1,3,0)
 ;;=3^Echo Transesophageal,Complete
 ;;^UTILITY(U,$J,358.3,6087,0)
 ;;=93316^^52^394^11^^^^1
 ;;^UTILITY(U,$J,358.3,6087,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6087,1,2,0)
 ;;=2^93316
 ;;^UTILITY(U,$J,358.3,6087,1,3,0)
 ;;=3^Echo Transesophageal Placement Only
 ;;^UTILITY(U,$J,358.3,6088,0)
 ;;=93317^^52^394^7^^^^1
 ;;^UTILITY(U,$J,358.3,6088,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6088,1,2,0)
 ;;=2^93317
 ;;^UTILITY(U,$J,358.3,6088,1,3,0)
 ;;=3^Echo Image,Inerpretation and Report Only
 ;;^UTILITY(U,$J,358.3,6089,0)
 ;;=93303^^52^394^17^^^^1
 ;;^UTILITY(U,$J,358.3,6089,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6089,1,2,0)
 ;;=2^93303
 ;;^UTILITY(U,$J,358.3,6089,1,3,0)
 ;;=3^Echo Transthoracic,Complete,Congenital Anomalies
 ;;^UTILITY(U,$J,358.3,6090,0)
 ;;=93304^^52^394^19^^^^1
 ;;^UTILITY(U,$J,358.3,6090,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6090,1,2,0)
 ;;=2^93304
 ;;^UTILITY(U,$J,358.3,6090,1,3,0)
 ;;=3^Echo Transthroacic F/U,Congenital Anomalies
 ;;^UTILITY(U,$J,358.3,6091,0)
 ;;=93571^^52^394^5^^^^1
 ;;^UTILITY(U,$J,358.3,6091,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6091,1,2,0)
 ;;=2^93571
 ;;^UTILITY(U,$J,358.3,6091,1,3,0)
 ;;=3^Doppler Intravasc,During Coronary Angio,Intl Vessl
 ;;^UTILITY(U,$J,358.3,6092,0)
 ;;=93572^^52^394^6^^^^1
 ;;^UTILITY(U,$J,358.3,6092,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6092,1,2,0)
 ;;=2^93572
 ;;^UTILITY(U,$J,358.3,6092,1,3,0)
 ;;=3^Doppler Intravasc,During Coronary Angio,Ea Vessl
 ;;^UTILITY(U,$J,358.3,6093,0)
 ;;=93355^^52^394^8^^^^1
 ;;^UTILITY(U,$J,358.3,6093,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6093,1,2,0)
 ;;=2^93355
 ;;^UTILITY(U,$J,358.3,6093,1,3,0)
 ;;=3^Echo TEE Transcath/Intracardiac/GV Guidance
