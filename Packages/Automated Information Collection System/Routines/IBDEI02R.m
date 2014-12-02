IBDEI02R ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,895,0)
 ;;=92568^^12^99^2^^^^1
 ;;^UTILITY(U,$J,358.3,895,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,895,1,2,0)
 ;;=2^92568
 ;;^UTILITY(U,$J,358.3,895,1,3,0)
 ;;=3^Acoustic Reflex Testing
 ;;^UTILITY(U,$J,358.3,896,0)
 ;;=92559^^12^99^3^^^^1
 ;;^UTILITY(U,$J,358.3,896,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,896,1,2,0)
 ;;=2^92559
 ;;^UTILITY(U,$J,358.3,896,1,3,0)
 ;;=3^Audiometric Testing,Group
 ;;^UTILITY(U,$J,358.3,897,0)
 ;;=92585^^12^99^4^^^^1
 ;;^UTILITY(U,$J,358.3,897,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,897,1,2,0)
 ;;=2^92585
 ;;^UTILITY(U,$J,358.3,897,1,3,0)
 ;;=3^Auditor Evoke Potent, Compre
 ;;^UTILITY(U,$J,358.3,898,0)
 ;;=92586^^12^99^5^^^^1
 ;;^UTILITY(U,$J,358.3,898,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,898,1,2,0)
 ;;=2^92586
 ;;^UTILITY(U,$J,358.3,898,1,3,0)
 ;;=3^Auditor Evoke Potent, Limit
 ;;^UTILITY(U,$J,358.3,899,0)
 ;;=92620^^12^99^7^^^^1
 ;;^UTILITY(U,$J,358.3,899,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,899,1,2,0)
 ;;=2^92620
 ;;^UTILITY(U,$J,358.3,899,1,3,0)
 ;;=3^Auditory Function, 60 Min
 ;;^UTILITY(U,$J,358.3,900,0)
 ;;=92621^^12^99^6^^^^1
 ;;^UTILITY(U,$J,358.3,900,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,900,1,2,0)
 ;;=2^92621
 ;;^UTILITY(U,$J,358.3,900,1,3,0)
 ;;=3^Auditory Function, + 15 Min
 ;;^UTILITY(U,$J,358.3,901,0)
 ;;=92557^^12^99^10^^^^1
 ;;^UTILITY(U,$J,358.3,901,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,901,1,2,0)
 ;;=2^92557
 ;;^UTILITY(U,$J,358.3,901,1,3,0)
 ;;=3^Comprehensive Audiometric Exam
 ;;^UTILITY(U,$J,358.3,902,0)
 ;;=92582^^12^99^11^^^^1
 ;;^UTILITY(U,$J,358.3,902,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,902,1,2,0)
 ;;=2^92582
 ;;^UTILITY(U,$J,358.3,902,1,3,0)
 ;;=3^Conditioning Play Audiometry
 ;;^UTILITY(U,$J,358.3,903,0)
 ;;=92571^^12^99^12^^^^1
 ;;^UTILITY(U,$J,358.3,903,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,903,1,2,0)
 ;;=2^92571
 ;;^UTILITY(U,$J,358.3,903,1,3,0)
 ;;=3^Disorted Speech Test
 ;;^UTILITY(U,$J,358.3,904,0)
 ;;=92596^^12^99^13^^^^1
 ;;^UTILITY(U,$J,358.3,904,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,904,1,2,0)
 ;;=2^92596
 ;;^UTILITY(U,$J,358.3,904,1,3,0)
 ;;=3^Ear Protector Attenuation
 ;;^UTILITY(U,$J,358.3,905,0)
 ;;=92584^^12^99^14^^^^1
 ;;^UTILITY(U,$J,358.3,905,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,905,1,2,0)
 ;;=2^92584
 ;;^UTILITY(U,$J,358.3,905,1,3,0)
 ;;=3^Electrocochleography
 ;;^UTILITY(U,$J,358.3,906,0)
 ;;=92562^^12^99^24^^^^1
 ;;^UTILITY(U,$J,358.3,906,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,906,1,2,0)
 ;;=2^92562
 ;;^UTILITY(U,$J,358.3,906,1,3,0)
 ;;=3^Loudness Balance Test
 ;;^UTILITY(U,$J,358.3,907,0)
 ;;=92588^^12^99^26^^^^1
 ;;^UTILITY(U,$J,358.3,907,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,907,1,2,0)
 ;;=2^92588
 ;;^UTILITY(U,$J,358.3,907,1,3,0)
 ;;=3^Otoacoustic Emissions,Diagnostic
 ;;^UTILITY(U,$J,358.3,908,0)
 ;;=92587^^12^99^27^^^^1
 ;;^UTILITY(U,$J,358.3,908,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,908,1,2,0)
 ;;=2^92587
 ;;^UTILITY(U,$J,358.3,908,1,3,0)
 ;;=3^Otoacoustic Emissions,Limited
 ;;^UTILITY(U,$J,358.3,909,0)
 ;;=92552^^12^99^28^^^^1
 ;;^UTILITY(U,$J,358.3,909,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,909,1,2,0)
 ;;=2^92552
 ;;^UTILITY(U,$J,358.3,909,1,3,0)
 ;;=3^Pure Tone Audiometry, Air
 ;;^UTILITY(U,$J,358.3,910,0)
 ;;=92553^^12^99^29^^^^1
 ;;^UTILITY(U,$J,358.3,910,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,910,1,2,0)
 ;;=2^92553
 ;;^UTILITY(U,$J,358.3,910,1,3,0)
 ;;=3^Pure Tone Audiometry, Air & Bone
 ;;^UTILITY(U,$J,358.3,911,0)
 ;;=92570^^12^99^1^^^^1
 ;;^UTILITY(U,$J,358.3,911,1,0)
 ;;=^358.31IA^3^2
