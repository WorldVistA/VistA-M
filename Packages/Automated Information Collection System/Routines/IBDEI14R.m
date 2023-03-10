IBDEI14R ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18345,0)
 ;;=31645^^62^817^21^^^^1
 ;;^UTILITY(U,$J,358.3,18345,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18345,1,2,0)
 ;;=2^31645
 ;;^UTILITY(U,$J,358.3,18345,1,3,0)
 ;;=3^Bronch w/ Therap Aspiration,Init
 ;;^UTILITY(U,$J,358.3,18346,0)
 ;;=31646^^62^817^22^^^^1
 ;;^UTILITY(U,$J,358.3,18346,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18346,1,2,0)
 ;;=2^31646
 ;;^UTILITY(U,$J,358.3,18346,1,3,0)
 ;;=3^Bronch w/ Therap Aspiration,Subseq
 ;;^UTILITY(U,$J,358.3,18347,0)
 ;;=31231^^62^817^28^^^^1
 ;;^UTILITY(U,$J,358.3,18347,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18347,1,2,0)
 ;;=2^31231
 ;;^UTILITY(U,$J,358.3,18347,1,3,0)
 ;;=3^Nasal Endoscopy,Diag,Uni/Bilateral
 ;;^UTILITY(U,$J,358.3,18348,0)
 ;;=31627^^62^817^15^^^^1
 ;;^UTILITY(U,$J,358.3,18348,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18348,1,2,0)
 ;;=2^31627
 ;;^UTILITY(U,$J,358.3,18348,1,3,0)
 ;;=3^Bronch w/ Computer Assisted-Image,Add-On
 ;;^UTILITY(U,$J,358.3,18349,0)
 ;;=31652^^62^817^17^^^^1
 ;;^UTILITY(U,$J,358.3,18349,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18349,1,2,0)
 ;;=2^31652
 ;;^UTILITY(U,$J,358.3,18349,1,3,0)
 ;;=3^Bronch w/ EBUS Trntch/Bronch Sample 1-2 Med/Hilar LN
 ;;^UTILITY(U,$J,358.3,18350,0)
 ;;=31653^^62^817^18^^^^1
 ;;^UTILITY(U,$J,358.3,18350,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18350,1,2,0)
 ;;=2^31653
 ;;^UTILITY(U,$J,358.3,18350,1,3,0)
 ;;=3^Bronch w/ EBUS Trntch/Bronch Sample=>3 Med/Hil LN
 ;;^UTILITY(U,$J,358.3,18351,0)
 ;;=31654^^62^817^16^^^^1
 ;;^UTILITY(U,$J,358.3,18351,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18351,1,2,0)
 ;;=2^31654
 ;;^UTILITY(U,$J,358.3,18351,1,3,0)
 ;;=3^Bronch w/ EBUS During Bronch,Add-On
 ;;^UTILITY(U,$J,358.3,18352,0)
 ;;=93015^^62^818^3^^^^1
 ;;^UTILITY(U,$J,358.3,18352,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18352,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,18352,1,3,0)
 ;;=3^Cardiovascular Stress Test,Complete
 ;;^UTILITY(U,$J,358.3,18353,0)
 ;;=93017^^62^818^4^^^^1
 ;;^UTILITY(U,$J,358.3,18353,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18353,1,2,0)
 ;;=2^93017
 ;;^UTILITY(U,$J,358.3,18353,1,3,0)
 ;;=3^Cardiovascular Stress Test,Tracing Only
 ;;^UTILITY(U,$J,358.3,18354,0)
 ;;=94621^^62^818^1^^^^1
 ;;^UTILITY(U,$J,358.3,18354,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18354,1,2,0)
 ;;=2^94621
 ;;^UTILITY(U,$J,358.3,18354,1,3,0)
 ;;=3^Cardiopulmonary Exercise Tstng,Incl Measurement
 ;;^UTILITY(U,$J,358.3,18355,0)
 ;;=93016^^62^818^2^^^^1
 ;;^UTILITY(U,$J,358.3,18355,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18355,1,2,0)
 ;;=2^93016
 ;;^UTILITY(U,$J,358.3,18355,1,3,0)
 ;;=3^Cardiovascular Stress Test Only w/o Rpt
 ;;^UTILITY(U,$J,358.3,18356,0)
 ;;=94618^^62^818^5^^^^1
 ;;^UTILITY(U,$J,358.3,18356,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18356,1,2,0)
 ;;=2^94618
 ;;^UTILITY(U,$J,358.3,18356,1,3,0)
 ;;=3^Pulmonary Stess Test
 ;;^UTILITY(U,$J,358.3,18357,0)
 ;;=90471^^62^819^1^^^^1
 ;;^UTILITY(U,$J,358.3,18357,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18357,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,18357,1,3,0)
 ;;=3^Immunization Admin,1st Vaccine
 ;;^UTILITY(U,$J,358.3,18358,0)
 ;;=90472^^62^819^2^^^^1
 ;;^UTILITY(U,$J,358.3,18358,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18358,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,18358,1,3,0)
 ;;=3^Immunization Admin,Ea Addl Vaccine
 ;;^UTILITY(U,$J,358.3,18359,0)
 ;;=90673^^62^820^1^^^^1
