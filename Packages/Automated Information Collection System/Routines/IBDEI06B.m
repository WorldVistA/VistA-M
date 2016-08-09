IBDEI06B ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6151,0)
 ;;=K52.9^^39^437^2
 ;;^UTILITY(U,$J,358.3,6151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6151,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective,Unspec
 ;;^UTILITY(U,$J,358.3,6151,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,6151,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,6152,0)
 ;;=N12.^^39^437^7
 ;;^UTILITY(U,$J,358.3,6152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6152,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,6152,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,6152,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,6153,0)
 ;;=L97.509^^39^437^4
 ;;^UTILITY(U,$J,358.3,6153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6153,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Unspec Foot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,6153,1,4,0)
 ;;=4^L97.509
 ;;^UTILITY(U,$J,358.3,6153,2)
 ;;=^5009544
 ;;^UTILITY(U,$J,358.3,6154,0)
 ;;=M86.10^^39^437^5
 ;;^UTILITY(U,$J,358.3,6154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6154,1,3,0)
 ;;=3^Osteomylitis,Acute,Unspec Site
 ;;^UTILITY(U,$J,358.3,6154,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,6154,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,6155,0)
 ;;=E85.9^^39^438^1
 ;;^UTILITY(U,$J,358.3,6155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6155,1,3,0)
 ;;=3^Amyloidosis,Unspec
 ;;^UTILITY(U,$J,358.3,6155,1,4,0)
 ;;=4^E85.9
 ;;^UTILITY(U,$J,358.3,6155,2)
 ;;=^334185
 ;;^UTILITY(U,$J,358.3,6156,0)
 ;;=N00.9^^39^438^3
 ;;^UTILITY(U,$J,358.3,6156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6156,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Acute
 ;;^UTILITY(U,$J,358.3,6156,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,6156,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,6157,0)
 ;;=N08.^^39^438^2
 ;;^UTILITY(U,$J,358.3,6157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6157,1,3,0)
 ;;=3^Glomerular Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,6157,1,4,0)
 ;;=4^N08.
 ;;^UTILITY(U,$J,358.3,6157,2)
 ;;=^5015569
 ;;^UTILITY(U,$J,358.3,6158,0)
 ;;=N03.9^^39^438^4
 ;;^UTILITY(U,$J,358.3,6158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6158,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Chronic
 ;;^UTILITY(U,$J,358.3,6158,1,4,0)
 ;;=4^N03.9
 ;;^UTILITY(U,$J,358.3,6158,2)
 ;;=^5015530
 ;;^UTILITY(U,$J,358.3,6159,0)
 ;;=N05.8^^39^439^1
 ;;^UTILITY(U,$J,358.3,6159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6159,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Unspec
 ;;^UTILITY(U,$J,358.3,6159,1,4,0)
 ;;=4^N05.8
 ;;^UTILITY(U,$J,358.3,6159,2)
 ;;=^5134085
 ;;^UTILITY(U,$J,358.3,6160,0)
 ;;=M30.0^^39^440^2
 ;;^UTILITY(U,$J,358.3,6160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6160,1,3,0)
 ;;=3^Polyarteritis Nodosa
 ;;^UTILITY(U,$J,358.3,6160,1,4,0)
 ;;=4^M30.0
 ;;^UTILITY(U,$J,358.3,6160,2)
 ;;=^5011738
 ;;^UTILITY(U,$J,358.3,6161,0)
 ;;=N04.9^^39^440^1
 ;;^UTILITY(U,$J,358.3,6161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6161,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Morphologic Changes
 ;;^UTILITY(U,$J,358.3,6161,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,6161,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,6162,0)
 ;;=N13.30^^39^441^2
 ;;^UTILITY(U,$J,358.3,6162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6162,1,3,0)
 ;;=3^Hydronephrosis,Unspec
 ;;^UTILITY(U,$J,358.3,6162,1,4,0)
 ;;=4^N13.30
 ;;^UTILITY(U,$J,358.3,6162,2)
 ;;=^5015578
 ;;^UTILITY(U,$J,358.3,6163,0)
 ;;=N13.9^^39^441^12
 ;;^UTILITY(U,$J,358.3,6163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6163,1,3,0)
 ;;=3^Uropathy,Obstructive & Reflux,Unspec
 ;;^UTILITY(U,$J,358.3,6163,1,4,0)
 ;;=4^N13.9
 ;;^UTILITY(U,$J,358.3,6163,2)
 ;;=^5015589
 ;;^UTILITY(U,$J,358.3,6164,0)
 ;;=N40.1^^39^441^1
 ;;^UTILITY(U,$J,358.3,6164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6164,1,3,0)
 ;;=3^Enlarged Prostate w/ LUTS
 ;;^UTILITY(U,$J,358.3,6164,1,4,0)
 ;;=4^N40.1
 ;;^UTILITY(U,$J,358.3,6164,2)
 ;;=^5015690
 ;;^UTILITY(U,$J,358.3,6165,0)
 ;;=R39.14^^39^441^3
 ;;^UTILITY(U,$J,358.3,6165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6165,1,3,0)
 ;;=3^Incomplete Bladder Emptying
 ;;^UTILITY(U,$J,358.3,6165,1,4,0)
 ;;=4^R39.14
 ;;^UTILITY(U,$J,358.3,6165,2)
 ;;=^5019344
 ;;^UTILITY(U,$J,358.3,6166,0)
 ;;=R35.1^^39^441^4
 ;;^UTILITY(U,$J,358.3,6166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6166,1,3,0)
 ;;=3^Nocturia
 ;;^UTILITY(U,$J,358.3,6166,1,4,0)
 ;;=4^R35.1
 ;;^UTILITY(U,$J,358.3,6166,2)
 ;;=^5019335
 ;;^UTILITY(U,$J,358.3,6167,0)
 ;;=R39.16^^39^441^5
 ;;^UTILITY(U,$J,358.3,6167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6167,1,3,0)
 ;;=3^Straining on Urinartion
 ;;^UTILITY(U,$J,358.3,6167,1,4,0)
 ;;=4^R39.16
 ;;^UTILITY(U,$J,358.3,6167,2)
 ;;=^5019346
 ;;^UTILITY(U,$J,358.3,6168,0)
 ;;=R35.0^^39^441^6
 ;;^UTILITY(U,$J,358.3,6168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6168,1,3,0)
 ;;=3^Urinary Frequency
 ;;^UTILITY(U,$J,358.3,6168,1,4,0)
 ;;=4^R35.0
 ;;^UTILITY(U,$J,358.3,6168,2)
 ;;=^5019334
 ;;^UTILITY(U,$J,358.3,6169,0)
 ;;=R39.11^^39^441^7
 ;;^UTILITY(U,$J,358.3,6169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6169,1,3,0)
 ;;=3^Urinary Hesitancy
 ;;^UTILITY(U,$J,358.3,6169,1,4,0)
 ;;=4^R39.11
 ;;^UTILITY(U,$J,358.3,6169,2)
 ;;=^5019341
 ;;^UTILITY(U,$J,358.3,6170,0)
 ;;=N39.41^^39^441^10
 ;;^UTILITY(U,$J,358.3,6170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6170,1,3,0)
 ;;=3^Urinary Urge Incontinence
 ;;^UTILITY(U,$J,358.3,6170,1,4,0)
 ;;=4^N39.41
 ;;^UTILITY(U,$J,358.3,6170,2)
 ;;=^5015680
 ;;^UTILITY(U,$J,358.3,6171,0)
 ;;=N13.8^^39^441^8
 ;;^UTILITY(U,$J,358.3,6171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6171,1,3,0)
 ;;=3^Urinary Obstruction
 ;;^UTILITY(U,$J,358.3,6171,1,4,0)
 ;;=4^N13.8
 ;;^UTILITY(U,$J,358.3,6171,2)
 ;;=^5015588
 ;;^UTILITY(U,$J,358.3,6172,0)
 ;;=R33.8^^39^441^9
 ;;^UTILITY(U,$J,358.3,6172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6172,1,3,0)
 ;;=3^Urinary Retention,Unspec
 ;;^UTILITY(U,$J,358.3,6172,1,4,0)
 ;;=4^R33.8
 ;;^UTILITY(U,$J,358.3,6172,2)
 ;;=^5019331
 ;;^UTILITY(U,$J,358.3,6173,0)
 ;;=R39.15^^39^441^11
 ;;^UTILITY(U,$J,358.3,6173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6173,1,3,0)
 ;;=3^Urinary Urgency
 ;;^UTILITY(U,$J,358.3,6173,1,4,0)
 ;;=4^R39.15
 ;;^UTILITY(U,$J,358.3,6173,2)
 ;;=^5019345
 ;;^UTILITY(U,$J,358.3,6174,0)
 ;;=R39.12^^39^441^13
 ;;^UTILITY(U,$J,358.3,6174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6174,1,3,0)
 ;;=3^Weak Urinary Stream
 ;;^UTILITY(U,$J,358.3,6174,1,4,0)
 ;;=4^R39.12
 ;;^UTILITY(U,$J,358.3,6174,2)
 ;;=^5019342
 ;;^UTILITY(U,$J,358.3,6175,0)
 ;;=T86.10^^39^442^3
 ;;^UTILITY(U,$J,358.3,6175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6175,1,3,0)
 ;;=3^Kidney Transplant Complication,Unspec
 ;;^UTILITY(U,$J,358.3,6175,1,4,0)
 ;;=4^T86.10
 ;;^UTILITY(U,$J,358.3,6175,2)
 ;;=^5055708
 ;;^UTILITY(U,$J,358.3,6176,0)
 ;;=T86.11^^39^442^7
 ;;^UTILITY(U,$J,358.3,6176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6176,1,3,0)
 ;;=3^Kidney Transplant Rejection
 ;;^UTILITY(U,$J,358.3,6176,1,4,0)
 ;;=4^T86.11
 ;;^UTILITY(U,$J,358.3,6176,2)
 ;;=^5055709
 ;;^UTILITY(U,$J,358.3,6177,0)
 ;;=T86.12^^39^442^5
 ;;^UTILITY(U,$J,358.3,6177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6177,1,3,0)
 ;;=3^Kidney Transplant Failure
 ;;^UTILITY(U,$J,358.3,6177,1,4,0)
 ;;=4^T86.12
 ;;^UTILITY(U,$J,358.3,6177,2)
 ;;=^5055710
 ;;^UTILITY(U,$J,358.3,6178,0)
 ;;=T86.13^^39^442^6
 ;;^UTILITY(U,$J,358.3,6178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6178,1,3,0)
 ;;=3^Kidney Transplant Infection
 ;;^UTILITY(U,$J,358.3,6178,1,4,0)
 ;;=4^T86.13
 ;;^UTILITY(U,$J,358.3,6178,2)
 ;;=^5055711
 ;;^UTILITY(U,$J,358.3,6179,0)
 ;;=Z94.0^^39^442^8
 ;;^UTILITY(U,$J,358.3,6179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6179,1,3,0)
 ;;=3^Kidney Transplant Status
 ;;^UTILITY(U,$J,358.3,6179,1,4,0)
 ;;=4^Z94.0
 ;;^UTILITY(U,$J,358.3,6179,2)
 ;;=^5063654
 ;;^UTILITY(U,$J,358.3,6180,0)
 ;;=Z48.22^^39^442^1
