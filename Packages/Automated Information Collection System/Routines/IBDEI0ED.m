IBDEI0ED ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6170,1,2,0)
 ;;=2^78453
 ;;^UTILITY(U,$J,358.3,6170,1,3,0)
 ;;=3^HT Muscle Image,Planar,Single
 ;;^UTILITY(U,$J,358.3,6171,0)
 ;;=78454^^52^398^12^^^^1
 ;;^UTILITY(U,$J,358.3,6171,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6171,1,2,0)
 ;;=2^78454
 ;;^UTILITY(U,$J,358.3,6171,1,3,0)
 ;;=3^HT Muscle Image,Planar,Multi,Add-On
 ;;^UTILITY(U,$J,358.3,6172,0)
 ;;=93641^^52^398^8^^^^1
 ;;^UTILITY(U,$J,358.3,6172,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6172,1,2,0)
 ;;=2^93641
 ;;^UTILITY(U,$J,358.3,6172,1,3,0)
 ;;=3^Electrophysiology Eval,Pulse Generator
 ;;^UTILITY(U,$J,358.3,6173,0)
 ;;=93642^^52^398^9^^^^1
 ;;^UTILITY(U,$J,358.3,6173,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6173,1,2,0)
 ;;=2^93642
 ;;^UTILITY(U,$J,358.3,6173,1,3,0)
 ;;=3^Electrophysiology Eval,Sensing/Therapeutic Parameters
 ;;^UTILITY(U,$J,358.3,6174,0)
 ;;=93797^^52^398^6^^^^1
 ;;^UTILITY(U,$J,358.3,6174,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6174,1,2,0)
 ;;=2^93797
 ;;^UTILITY(U,$J,358.3,6174,1,3,0)
 ;;=3^Cardiac Rehab w/o ECG Monitoring
 ;;^UTILITY(U,$J,358.3,6175,0)
 ;;=93799^^52^398^17^^^^1
 ;;^UTILITY(U,$J,358.3,6175,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6175,1,2,0)
 ;;=2^93799
 ;;^UTILITY(U,$J,358.3,6175,1,3,0)
 ;;=3^Unlisted Cardiovascular Procedure
 ;;^UTILITY(U,$J,358.3,6176,0)
 ;;=93015^^52^399^1^^^^1
 ;;^UTILITY(U,$J,358.3,6176,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6176,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,6176,1,3,0)
 ;;=3^Cardiovascular Stress Test
 ;;^UTILITY(U,$J,358.3,6177,0)
 ;;=93016^^52^399^5^^^^1
 ;;^UTILITY(U,$J,358.3,6177,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6177,1,2,0)
 ;;=2^93016
 ;;^UTILITY(U,$J,358.3,6177,1,3,0)
 ;;=3^Stress Test, Phy Super Only No Report
 ;;^UTILITY(U,$J,358.3,6178,0)
 ;;=93017^^52^399^6^^^^1
 ;;^UTILITY(U,$J,358.3,6178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6178,1,2,0)
 ;;=2^93017
 ;;^UTILITY(U,$J,358.3,6178,1,3,0)
 ;;=3^Stress Test, Tracing Only
 ;;^UTILITY(U,$J,358.3,6179,0)
 ;;=93018^^52^399^4^^^^1
 ;;^UTILITY(U,$J,358.3,6179,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6179,1,2,0)
 ;;=2^93018
 ;;^UTILITY(U,$J,358.3,6179,1,3,0)
 ;;=3^Stress Test, Interr & Report Only
 ;;^UTILITY(U,$J,358.3,6180,0)
 ;;=78451^^52^399^2^^^^1
 ;;^UTILITY(U,$J,358.3,6180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6180,1,2,0)
 ;;=2^78451
 ;;^UTILITY(U,$J,358.3,6180,1,3,0)
 ;;=3^SPECT,Single Study
 ;;^UTILITY(U,$J,358.3,6181,0)
 ;;=93350^^52^399^3^^^^1
 ;;^UTILITY(U,$J,358.3,6181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6181,1,2,0)
 ;;=2^93350
 ;;^UTILITY(U,$J,358.3,6181,1,3,0)
 ;;=3^Stress TTE Only
 ;;^UTILITY(U,$J,358.3,6182,0)
 ;;=99401^^52^400^1^^^^1
 ;;^UTILITY(U,$J,358.3,6182,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6182,1,2,0)
 ;;=2^99401
 ;;^UTILITY(U,$J,358.3,6182,1,3,0)
 ;;=3^Preventive Counseling,15 min
 ;;^UTILITY(U,$J,358.3,6183,0)
 ;;=99402^^52^400^2^^^^1
 ;;^UTILITY(U,$J,358.3,6183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6183,1,2,0)
 ;;=2^99402
 ;;^UTILITY(U,$J,358.3,6183,1,3,0)
 ;;=3^Preventive Counseling,30 min
 ;;^UTILITY(U,$J,358.3,6184,0)
 ;;=99403^^52^400^3^^^^1
 ;;^UTILITY(U,$J,358.3,6184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6184,1,2,0)
 ;;=2^99403
 ;;^UTILITY(U,$J,358.3,6184,1,3,0)
 ;;=3^Preventive Counseling,45 min
 ;;^UTILITY(U,$J,358.3,6185,0)
 ;;=99404^^52^400^4^^^^1
 ;;^UTILITY(U,$J,358.3,6185,1,0)
 ;;=^358.31IA^3^2
