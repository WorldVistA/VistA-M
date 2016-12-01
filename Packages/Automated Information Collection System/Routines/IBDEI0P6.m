IBDEI0P6 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31913,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,31913,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,31913,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,31914,0)
 ;;=Z82.49^^94^1406^8
 ;;^UTILITY(U,$J,358.3,31914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31914,1,3,0)
 ;;=3^Family hx of ischem heart dis and oth dis of the circ sys
 ;;^UTILITY(U,$J,358.3,31914,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,31914,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,31915,0)
 ;;=I50.9^^94^1406^9
 ;;^UTILITY(U,$J,358.3,31915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31915,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,31915,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,31915,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,31916,0)
 ;;=I25.2^^94^1406^10
 ;;^UTILITY(U,$J,358.3,31916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31916,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,31916,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,31916,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,31917,0)
 ;;=I42.8^^94^1406^5
 ;;^UTILITY(U,$J,358.3,31917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31917,1,3,0)
 ;;=3^Cardiomyopathies NEC
 ;;^UTILITY(U,$J,358.3,31917,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,31917,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,31918,0)
 ;;=I42.5^^94^1406^14
 ;;^UTILITY(U,$J,358.3,31918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31918,1,3,0)
 ;;=3^Restrictive Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,31918,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,31918,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,31919,0)
 ;;=Z95.1^^94^1406^11
 ;;^UTILITY(U,$J,358.3,31919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31919,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,31919,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,31919,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,31920,0)
 ;;=Z95.0^^94^1406^12
 ;;^UTILITY(U,$J,358.3,31920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31920,1,3,0)
 ;;=3^Presence of cardiac pacemaker
 ;;^UTILITY(U,$J,358.3,31920,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,31920,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,31921,0)
 ;;=J98.9^^94^1406^13
 ;;^UTILITY(U,$J,358.3,31921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31921,1,3,0)
 ;;=3^Respiratory disorder, unspecified
 ;;^UTILITY(U,$J,358.3,31921,1,4,0)
 ;;=4^J98.9
 ;;^UTILITY(U,$J,358.3,31921,2)
 ;;=^5008366
 ;;^UTILITY(U,$J,358.3,31922,0)
 ;;=I22.9^^94^1406^15
 ;;^UTILITY(U,$J,358.3,31922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31922,1,3,0)
 ;;=3^Subsequent STEMI of unsp site
 ;;^UTILITY(U,$J,358.3,31922,1,4,0)
 ;;=4^I22.9
 ;;^UTILITY(U,$J,358.3,31922,2)
 ;;=^5007093
 ;;^UTILITY(U,$J,358.3,31923,0)
 ;;=I48.91^^94^1406^2
 ;;^UTILITY(U,$J,358.3,31923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31923,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,31923,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,31923,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,31924,0)
 ;;=F81.81^^94^1407^3
 ;;^UTILITY(U,$J,358.3,31924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31924,1,3,0)
 ;;=3^Disorder of written expression
 ;;^UTILITY(U,$J,358.3,31924,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,31924,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,31925,0)
 ;;=R41.3^^94^1407^1
 ;;^UTILITY(U,$J,358.3,31925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31925,1,3,0)
 ;;=3^Amnesia NEC
 ;;^UTILITY(U,$J,358.3,31925,1,4,0)
 ;;=4^R41.3
 ;;^UTILITY(U,$J,358.3,31925,2)
 ;;=^5019439
 ;;^UTILITY(U,$J,358.3,31926,0)
 ;;=F81.89^^94^1407^2
 ;;^UTILITY(U,$J,358.3,31926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31926,1,3,0)
 ;;=3^Developmental disorders of scholastic skills NEC
 ;;^UTILITY(U,$J,358.3,31926,1,4,0)
 ;;=4^F81.89
 ;;^UTILITY(U,$J,358.3,31926,2)
 ;;=^5003681
 ;;^UTILITY(U,$J,358.3,31927,0)
 ;;=F07.81^^94^1407^4
 ;;^UTILITY(U,$J,358.3,31927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31927,1,3,0)
 ;;=3^Postconcussional syndrome
 ;;^UTILITY(U,$J,358.3,31927,1,4,0)
 ;;=4^F07.81
 ;;^UTILITY(U,$J,358.3,31927,2)
 ;;=^5003064
 ;;^UTILITY(U,$J,358.3,31928,0)
 ;;=R41.2^^94^1407^5
 ;;^UTILITY(U,$J,358.3,31928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31928,1,3,0)
 ;;=3^Retrograde amnesia
 ;;^UTILITY(U,$J,358.3,31928,1,4,0)
 ;;=4^R41.2
 ;;^UTILITY(U,$J,358.3,31928,2)
 ;;=^5019438
 ;;^UTILITY(U,$J,358.3,31929,0)
 ;;=T84.81XA^^94^1408^2
 ;;^UTILITY(U,$J,358.3,31929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31929,1,3,0)
 ;;=3^Embolism d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31929,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,31929,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,31930,0)
 ;;=T84.82XA^^94^1408^3
 ;;^UTILITY(U,$J,358.3,31930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31930,1,3,0)
 ;;=3^Fibrosis d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31930,1,4,0)
 ;;=4^T84.82XA
 ;;^UTILITY(U,$J,358.3,31930,2)
 ;;=^5055457
 ;;^UTILITY(U,$J,358.3,31931,0)
 ;;=T84.83XA^^94^1408^4
 ;;^UTILITY(U,$J,358.3,31931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31931,1,3,0)
 ;;=3^Hemorrhage d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31931,1,4,0)
 ;;=4^T84.83XA
 ;;^UTILITY(U,$J,358.3,31931,2)
 ;;=^5055460
 ;;^UTILITY(U,$J,358.3,31932,0)
 ;;=T84.84XA^^94^1408^5
 ;;^UTILITY(U,$J,358.3,31932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31932,1,3,0)
 ;;=3^Pain d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31932,1,4,0)
 ;;=4^T84.84XA
 ;;^UTILITY(U,$J,358.3,31932,2)
 ;;=^5055463
 ;;^UTILITY(U,$J,358.3,31933,0)
 ;;=T84.85XA^^94^1408^6
 ;;^UTILITY(U,$J,358.3,31933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31933,1,3,0)
 ;;=3^Stenosis d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31933,1,4,0)
 ;;=4^T84.85XA
 ;;^UTILITY(U,$J,358.3,31933,2)
 ;;=^5055466
 ;;^UTILITY(U,$J,358.3,31934,0)
 ;;=T84.86XA^^94^1408^7
 ;;^UTILITY(U,$J,358.3,31934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31934,1,3,0)
 ;;=3^Thrombosis d/t internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,31934,1,4,0)
 ;;=4^T84.86XA
 ;;^UTILITY(U,$J,358.3,31934,2)
 ;;=^5055469
 ;;^UTILITY(U,$J,358.3,31935,0)
 ;;=T88.9XXS^^94^1408^1
 ;;^UTILITY(U,$J,358.3,31935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31935,1,3,0)
 ;;=3^Complication of surgical and medical care, unsp, sequela
 ;;^UTILITY(U,$J,358.3,31935,1,4,0)
 ;;=4^T88.9XXS
 ;;^UTILITY(U,$J,358.3,31935,2)
 ;;=^5055819
 ;;^UTILITY(U,$J,358.3,31936,0)
 ;;=M86.672^^94^1409^2
 ;;^UTILITY(U,$J,358.3,31936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31936,1,3,0)
 ;;=3^Chronic osteomyelitis, left ankle and foot NEC
 ;;^UTILITY(U,$J,358.3,31936,1,4,0)
 ;;=4^M86.672
 ;;^UTILITY(U,$J,358.3,31936,2)
 ;;=^5014642
 ;;^UTILITY(U,$J,358.3,31937,0)
 ;;=M86.642^^94^1409^3
 ;;^UTILITY(U,$J,358.3,31937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31937,1,3,0)
 ;;=3^Chronic osteomyelitis, left hand NEC
 ;;^UTILITY(U,$J,358.3,31937,1,4,0)
 ;;=4^M86.642
 ;;^UTILITY(U,$J,358.3,31937,2)
 ;;=^5134074
 ;;^UTILITY(U,$J,358.3,31938,0)
 ;;=M86.622^^94^1409^4
 ;;^UTILITY(U,$J,358.3,31938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31938,1,3,0)
 ;;=3^Chronic osteomyelitis, left humerus NEC
 ;;^UTILITY(U,$J,358.3,31938,1,4,0)
 ;;=4^M86.622
 ;;^UTILITY(U,$J,358.3,31938,2)
 ;;=^5134070
 ;;^UTILITY(U,$J,358.3,31939,0)
 ;;=M86.632^^94^1409^5
 ;;^UTILITY(U,$J,358.3,31939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31939,1,3,0)
 ;;=3^Chronic osteomyelitis, left radius and ulna NEC
 ;;^UTILITY(U,$J,358.3,31939,1,4,0)
 ;;=4^M86.632
 ;;^UTILITY(U,$J,358.3,31939,2)
 ;;=^5134072
 ;;^UTILITY(U,$J,358.3,31940,0)
 ;;=M86.612^^94^1409^6
 ;;^UTILITY(U,$J,358.3,31940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31940,1,3,0)
 ;;=3^Chronic osteomyelitis, left shoulder NEC
 ;;^UTILITY(U,$J,358.3,31940,1,4,0)
 ;;=4^M86.612
 ;;^UTILITY(U,$J,358.3,31940,2)
 ;;=^5014632
 ;;^UTILITY(U,$J,358.3,31941,0)
 ;;=M86.652^^94^1409^7
 ;;^UTILITY(U,$J,358.3,31941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31941,1,3,0)
 ;;=3^Chronic osteomyelitis, left thigh NEC
 ;;^UTILITY(U,$J,358.3,31941,1,4,0)
 ;;=4^M86.652
 ;;^UTILITY(U,$J,358.3,31941,2)
 ;;=^5014638
 ;;^UTILITY(U,$J,358.3,31942,0)
 ;;=M86.662^^94^1409^8
 ;;^UTILITY(U,$J,358.3,31942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31942,1,3,0)
 ;;=3^Chronic osteomyelitis, left tibia and Fibula NEC
 ;;^UTILITY(U,$J,358.3,31942,1,4,0)
 ;;=4^M86.662
 ;;^UTILITY(U,$J,358.3,31942,2)
 ;;=^5134076
 ;;^UTILITY(U,$J,358.3,31943,0)
 ;;=M86.671^^94^1409^9
 ;;^UTILITY(U,$J,358.3,31943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31943,1,3,0)
 ;;=3^Chronic osteomyelitis, right ankle and foot NEC
 ;;^UTILITY(U,$J,358.3,31943,1,4,0)
 ;;=4^M86.671
 ;;^UTILITY(U,$J,358.3,31943,2)
 ;;=^5014641
 ;;^UTILITY(U,$J,358.3,31944,0)
 ;;=M86.641^^94^1409^10
 ;;^UTILITY(U,$J,358.3,31944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31944,1,3,0)
 ;;=3^Chronic osteomyelitis, right hand
 ;;^UTILITY(U,$J,358.3,31944,1,4,0)
 ;;=4^M86.641
 ;;^UTILITY(U,$J,358.3,31944,2)
 ;;=^5014636
 ;;^UTILITY(U,$J,358.3,31945,0)
 ;;=M86.621^^94^1409^11
 ;;^UTILITY(U,$J,358.3,31945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31945,1,3,0)
 ;;=3^Chronic osteomyelitis, right humerus NEC
 ;;^UTILITY(U,$J,358.3,31945,1,4,0)
 ;;=4^M86.621
 ;;^UTILITY(U,$J,358.3,31945,2)
 ;;=^5014634
 ;;^UTILITY(U,$J,358.3,31946,0)
 ;;=M86.631^^94^1409^12
 ;;^UTILITY(U,$J,358.3,31946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31946,1,3,0)
 ;;=3^Chronic osteomyelitis, right radius and ulna
 ;;^UTILITY(U,$J,358.3,31946,1,4,0)
 ;;=4^M86.631
 ;;^UTILITY(U,$J,358.3,31946,2)
 ;;=^5014635
 ;;^UTILITY(U,$J,358.3,31947,0)
 ;;=M86.611^^94^1409^13
 ;;^UTILITY(U,$J,358.3,31947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31947,1,3,0)
 ;;=3^Chronic osteomyelitis, right shoulder NEC
 ;;^UTILITY(U,$J,358.3,31947,1,4,0)
 ;;=4^M86.611
 ;;^UTILITY(U,$J,358.3,31947,2)
 ;;=^5014631
