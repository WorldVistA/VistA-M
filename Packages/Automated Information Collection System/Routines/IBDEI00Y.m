IBDEI00Y ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,802,1,4,0)
 ;;=4^402.01
 ;;^UTILITY(U,$J,358.3,802,1,5,0)
 ;;=5^Malignant HTN HRT W/CHF
 ;;^UTILITY(U,$J,358.3,802,2)
 ;;=^269595
 ;;^UTILITY(U,$J,358.3,803,0)
 ;;=402.10^^10^64^1.5
 ;;^UTILITY(U,$J,358.3,803,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,803,1,4,0)
 ;;=4^402.10
 ;;^UTILITY(U,$J,358.3,803,1,5,0)
 ;;=5^Benign HTN HRT Disease
 ;;^UTILITY(U,$J,358.3,803,2)
 ;;=^269598
 ;;^UTILITY(U,$J,358.3,804,0)
 ;;=402.11^^10^64^1.7
 ;;^UTILITY(U,$J,358.3,804,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,804,1,4,0)
 ;;=4^402.11
 ;;^UTILITY(U,$J,358.3,804,1,5,0)
 ;;=5^Benign HTN HRT W/CHF
 ;;^UTILITY(U,$J,358.3,804,2)
 ;;=^269599
 ;;^UTILITY(U,$J,358.3,805,0)
 ;;=402.90^^10^64^7
 ;;^UTILITY(U,$J,358.3,805,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,805,1,4,0)
 ;;=4^402.90
 ;;^UTILITY(U,$J,358.3,805,1,5,0)
 ;;=5^HTN HRT Dis W/O CHF NOS
 ;;^UTILITY(U,$J,358.3,805,2)
 ;;=^269601
 ;;^UTILITY(U,$J,358.3,806,0)
 ;;=402.91^^10^64^6
 ;;^UTILITY(U,$J,358.3,806,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,806,1,4,0)
 ;;=4^402.91
 ;;^UTILITY(U,$J,358.3,806,1,5,0)
 ;;=5^HTN HRT Dis W/CHF
 ;;^UTILITY(U,$J,358.3,806,2)
 ;;=^269602
 ;;^UTILITY(U,$J,358.3,807,0)
 ;;=403.00^^10^64^16
 ;;^UTILITY(U,$J,358.3,807,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,807,1,4,0)
 ;;=4^403.00
 ;;^UTILITY(U,$J,358.3,807,1,5,0)
 ;;=5^Malignant HTN Ren W/O Renal Failure
 ;;^UTILITY(U,$J,358.3,807,2)
 ;;=^269604
 ;;^UTILITY(U,$J,358.3,808,0)
 ;;=403.01^^10^64^15
 ;;^UTILITY(U,$J,358.3,808,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,808,1,4,0)
 ;;=4^403.01
 ;;^UTILITY(U,$J,358.3,808,1,5,0)
 ;;=5^Malignant HTN Ren W/Ren Failure
 ;;^UTILITY(U,$J,358.3,808,2)
 ;;=^269605
 ;;^UTILITY(U,$J,358.3,809,0)
 ;;=403.10^^10^64^3
 ;;^UTILITY(U,$J,358.3,809,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,809,1,4,0)
 ;;=4^403.10
 ;;^UTILITY(U,$J,358.3,809,1,5,0)
 ;;=5^Benign HTN Ren W/O Renal Failure
 ;;^UTILITY(U,$J,358.3,809,2)
 ;;=^269607
 ;;^UTILITY(U,$J,358.3,810,0)
 ;;=403.11^^10^64^2
 ;;^UTILITY(U,$J,358.3,810,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,810,1,4,0)
 ;;=4^403.11
 ;;^UTILITY(U,$J,358.3,810,1,5,0)
 ;;=5^Benign HTN Ren W/Renal Failure
 ;;^UTILITY(U,$J,358.3,810,2)
 ;;=^269608
 ;;^UTILITY(U,$J,358.3,811,0)
 ;;=403.90^^10^64^9
 ;;^UTILITY(U,$J,358.3,811,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,811,1,4,0)
 ;;=4^403.90
 ;;^UTILITY(U,$J,358.3,811,1,5,0)
 ;;=5^HTN REN W/O Ren Fail
 ;;^UTILITY(U,$J,358.3,811,2)
 ;;=^269609
 ;;^UTILITY(U,$J,358.3,812,0)
 ;;=403.91^^10^64^8
 ;;^UTILITY(U,$J,358.3,812,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,812,1,4,0)
 ;;=4^403.91
 ;;^UTILITY(U,$J,358.3,812,1,5,0)
 ;;=5^HTN REN W Ren Fail
 ;;^UTILITY(U,$J,358.3,812,2)
 ;;=^269610
 ;;^UTILITY(U,$J,358.3,813,0)
 ;;=401.1^^10^64^1
 ;;^UTILITY(U,$J,358.3,813,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,813,1,4,0)
 ;;=4^401.1
 ;;^UTILITY(U,$J,358.3,813,1,5,0)
 ;;=5^Benign Hypertension
 ;;^UTILITY(U,$J,358.3,813,2)
 ;;=^269591
 ;;^UTILITY(U,$J,358.3,814,0)
 ;;=405.19^^10^64^3.5
 ;;^UTILITY(U,$J,358.3,814,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,814,1,4,0)
 ;;=4^405.19
 ;;^UTILITY(U,$J,358.3,814,1,5,0)
 ;;=5^Benign Ren HTN 2nd Ren Art Stenosis
 ;;^UTILITY(U,$J,358.3,814,2)
 ;;=^269632
 ;;^UTILITY(U,$J,358.3,815,0)
 ;;=405.99^^10^64^9.5
 ;;^UTILITY(U,$J,358.3,815,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,815,1,4,0)
 ;;=4^405.99
 ;;^UTILITY(U,$J,358.3,815,1,5,0)
 ;;=5^HTN Ren 2nd To Ren Art Stenosis
 ;;^UTILITY(U,$J,358.3,815,2)
 ;;=^269635^440.1
 ;;^UTILITY(U,$J,358.3,816,0)
 ;;=405.09^^10^64^17
 ;;^UTILITY(U,$J,358.3,816,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,816,1,4,0)
 ;;=4^405.09
 ;;^UTILITY(U,$J,358.3,816,1,5,0)
 ;;=5^Malig Ren HTN 2nd To Ren Art Stenosis
 ;;^UTILITY(U,$J,358.3,816,2)
 ;;=^269629
 ;;^UTILITY(U,$J,358.3,817,0)
 ;;=440.1^^10^64^10
 ;;^UTILITY(U,$J,358.3,817,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,817,1,4,0)
 ;;=4^440.1
 ;;^UTILITY(U,$J,358.3,817,1,5,0)
 ;;=5^      Renal Artery Stenosis (W/405.99)
 ;;^UTILITY(U,$J,358.3,817,2)
 ;;=^269760
 ;;^UTILITY(U,$J,358.3,818,0)
 ;;=424.1^^10^65^1
 ;;^UTILITY(U,$J,358.3,818,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,818,1,4,0)
 ;;=4^424.1
 ;;^UTILITY(U,$J,358.3,818,1,5,0)
 ;;=5^Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,818,2)
 ;;=^9330
 ;;^UTILITY(U,$J,358.3,819,0)
 ;;=424.0^^10^65^1.2
 ;;^UTILITY(U,$J,358.3,819,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,819,1,4,0)
 ;;=4^424.0
 ;;^UTILITY(U,$J,358.3,819,1,5,0)
 ;;=5^Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,819,2)
 ;;=^78367
 ;;^UTILITY(U,$J,358.3,820,0)
 ;;=424.3^^10^65^3
 ;;^UTILITY(U,$J,358.3,820,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,820,1,4,0)
 ;;=4^424.3
 ;;^UTILITY(U,$J,358.3,820,1,5,0)
 ;;=5^Non-Rheumatic Pulm Insuff/Stenosis
 ;;^UTILITY(U,$J,358.3,820,2)
 ;;=Non-Rheumatic Pulm Insuff/Stenosis^101164
 ;;^UTILITY(U,$J,358.3,821,0)
 ;;=424.2^^10^65^4
 ;;^UTILITY(U,$J,358.3,821,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,821,1,4,0)
 ;;=4^424.2
 ;;^UTILITY(U,$J,358.3,821,1,5,0)
 ;;=5^Non-Rheumatic Tricuspid Insuff
 ;;^UTILITY(U,$J,358.3,821,2)
 ;;=^269715
 ;;^UTILITY(U,$J,358.3,822,0)
 ;;=396.0^^10^65^5
 ;;^UTILITY(U,$J,358.3,822,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,822,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,822,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,822,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,823,0)
 ;;=396.3^^10^65^6
 ;;^UTILITY(U,$J,358.3,823,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,823,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,823,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,823,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,824,0)
 ;;=396.8^^10^65^7
 ;;^UTILITY(U,$J,358.3,824,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,824,1,4,0)
 ;;=4^396.8
 ;;^UTILITY(U,$J,358.3,824,1,5,0)
 ;;=5^Aortic and Mitral Insuff/Stenosis Combined
 ;;^UTILITY(U,$J,358.3,824,2)
 ;;=Aortic and Mitral Insuff/Stenosis Combined^269584
 ;;^UTILITY(U,$J,358.3,825,0)
 ;;=396.8^^10^66^1
 ;;^UTILITY(U,$J,358.3,825,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,825,1,4,0)
 ;;=4^396.8
 ;;^UTILITY(U,$J,358.3,825,1,5,0)
 ;;=5^Rhem Aortic & Mitral Stenosis/Insuff
 ;;^UTILITY(U,$J,358.3,825,2)
 ;;=^269584
 ;;^UTILITY(U,$J,358.3,826,0)
 ;;=395.2^^10^66^2
 ;;^UTILITY(U,$J,358.3,826,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,826,1,4,0)
 ;;=4^395.2
 ;;^UTILITY(U,$J,358.3,826,1,5,0)
 ;;=5^Rhem Aortic Stenosis W/Insuff
 ;;^UTILITY(U,$J,358.3,826,2)
 ;;=^269577
 ;;^UTILITY(U,$J,358.3,827,0)
 ;;=395.9^^10^66^3
 ;;^UTILITY(U,$J,358.3,827,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,827,1,4,0)
 ;;=4^395.9
 ;;^UTILITY(U,$J,358.3,827,1,5,0)
 ;;=5^Rhem Aortic Disease
 ;;^UTILITY(U,$J,358.3,827,2)
 ;;=^269578
 ;;^UTILITY(U,$J,358.3,828,0)
 ;;=395.1^^10^66^4
 ;;^UTILITY(U,$J,358.3,828,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,828,1,4,0)
 ;;=4^395.1
 ;;^UTILITY(U,$J,358.3,828,1,5,0)
 ;;=5^Rhem Aortic Insuff
 ;;^UTILITY(U,$J,358.3,828,2)
 ;;=^269575
 ;;^UTILITY(U,$J,358.3,829,0)
 ;;=394.1^^10^66^5
 ;;^UTILITY(U,$J,358.3,829,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,829,1,4,0)
 ;;=4^394.1
 ;;^UTILITY(U,$J,358.3,829,1,5,0)
 ;;=5^Rhem Mitral Insuff
 ;;^UTILITY(U,$J,358.3,829,2)
 ;;=^269568
 ;;^UTILITY(U,$J,358.3,830,0)
 ;;=395.0^^10^66^6
 ;;^UTILITY(U,$J,358.3,830,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,830,1,4,0)
 ;;=4^395.0
 ;;^UTILITY(U,$J,358.3,830,1,5,0)
 ;;=5^Rhem Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,830,2)
 ;;=^269573
 ;;^UTILITY(U,$J,358.3,831,0)
 ;;=396.3^^10^66^7
 ;;^UTILITY(U,$J,358.3,831,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,831,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,831,1,5,0)
 ;;=5^Rhem Mitral/Aortic Insufficiency
 ;;^UTILITY(U,$J,358.3,831,2)
 ;;=^269583
 ;;^UTILITY(U,$J,358.3,832,0)
 ;;=396.2^^10^66^8
 ;;^UTILITY(U,$J,358.3,832,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,832,1,4,0)
 ;;=4^396.2
 ;;^UTILITY(U,$J,358.3,832,1,5,0)
 ;;=5^Rhem Mitral Insuff & Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,832,2)
 ;;=^269582
 ;;^UTILITY(U,$J,358.3,833,0)
 ;;=394.0^^10^66^9
 ;;^UTILITY(U,$J,358.3,833,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,833,1,4,0)
 ;;=4^394.0
 ;;^UTILITY(U,$J,358.3,833,1,5,0)
 ;;=5^Rhem Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,833,2)
 ;;=^78404
 ;;^UTILITY(U,$J,358.3,834,0)
 ;;=396.1^^10^66^10
 ;;^UTILITY(U,$J,358.3,834,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,834,1,4,0)
 ;;=4^396.1
 ;;^UTILITY(U,$J,358.3,834,1,5,0)
 ;;=5^Rhem Mitral Stenosis & Aortic Insuff
 ;;^UTILITY(U,$J,358.3,834,2)
 ;;=^269581
 ;;^UTILITY(U,$J,358.3,835,0)
 ;;=396.0^^10^66^11
 ;;^UTILITY(U,$J,358.3,835,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,835,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,835,1,5,0)
 ;;=5^Rhem Mitral & Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,835,2)
 ;;=^269580
 ;;^UTILITY(U,$J,358.3,836,0)
 ;;=394.2^^10^66^12
 ;;^UTILITY(U,$J,358.3,836,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,836,1,4,0)
 ;;=4^394.2
 ;;^UTILITY(U,$J,358.3,836,1,5,0)
 ;;=5^Rhem Mitral Stenosis W/Insuff
 ;;^UTILITY(U,$J,358.3,836,2)
 ;;=^269570
 ;;^UTILITY(U,$J,358.3,837,0)
 ;;=394.9^^10^66^13
 ;;^UTILITY(U,$J,358.3,837,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,837,1,4,0)
 ;;=4^394.9
 ;;^UTILITY(U,$J,358.3,837,1,5,0)
 ;;=5^Rhem Mitral Valve Dis
 ;;^UTILITY(U,$J,358.3,837,2)
 ;;=^269571
 ;;^UTILITY(U,$J,358.3,838,0)
 ;;=397.1^^10^66^14
 ;;^UTILITY(U,$J,358.3,838,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,838,1,4,0)
 ;;=4^397.1
 ;;^UTILITY(U,$J,358.3,838,1,5,0)
 ;;=5^Rhem Pulm Valve Disease
 ;;^UTILITY(U,$J,358.3,838,2)
 ;;=^269587
 ;;^UTILITY(U,$J,358.3,839,0)
 ;;=397.0^^10^66^15
 ;;^UTILITY(U,$J,358.3,839,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,839,1,4,0)
 ;;=4^397.0
 ;;^UTILITY(U,$J,358.3,839,1,5,0)
 ;;=5^Rhem Tricuspid Valve Disease
 ;;^UTILITY(U,$J,358.3,839,2)
 ;;=^35528
 ;;^UTILITY(U,$J,358.3,840,0)
 ;;=424.90^^10^67^1
