IBDEI05G ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13174,2)
 ;;=^5008336
 ;;^UTILITY(U,$J,358.3,13175,0)
 ;;=T82.110A^^53^582^5
 ;;^UTILITY(U,$J,358.3,13175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13175,1,3,0)
 ;;=3^Breakdown,Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,13175,1,4,0)
 ;;=4^T82.110A
 ;;^UTILITY(U,$J,358.3,13175,2)
 ;;=^5054680
 ;;^UTILITY(U,$J,358.3,13176,0)
 ;;=T82.191A^^53^582^148
 ;;^UTILITY(U,$J,358.3,13176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13176,1,3,0)
 ;;=3^Mech Compl of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,13176,1,4,0)
 ;;=4^T82.191A
 ;;^UTILITY(U,$J,358.3,13176,2)
 ;;=^5054707
 ;;^UTILITY(U,$J,358.3,13177,0)
 ;;=T82.111A^^53^582^6
 ;;^UTILITY(U,$J,358.3,13177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13177,1,3,0)
 ;;=3^Breakdown,Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,13177,1,4,0)
 ;;=4^T82.111A
 ;;^UTILITY(U,$J,358.3,13177,2)
 ;;=^5054683
 ;;^UTILITY(U,$J,358.3,13178,0)
 ;;=T82.120A^^53^582^32
 ;;^UTILITY(U,$J,358.3,13178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13178,1,3,0)
 ;;=3^Dsplcmnt of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,13178,1,4,0)
 ;;=4^T82.120A
 ;;^UTILITY(U,$J,358.3,13178,2)
 ;;=^5054692
 ;;^UTILITY(U,$J,358.3,13179,0)
 ;;=T82.121A^^53^582^33
 ;;^UTILITY(U,$J,358.3,13179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13179,1,3,0)
 ;;=3^Dsplcmnt of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,13179,1,4,0)
 ;;=4^T82.121A
 ;;^UTILITY(U,$J,358.3,13179,2)
 ;;=^5054695
 ;;^UTILITY(U,$J,358.3,13180,0)
 ;;=T82.190A^^53^582^150
 ;;^UTILITY(U,$J,358.3,13180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13180,1,3,0)
 ;;=3^Mech Compl of Cardiact Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,13180,1,4,0)
 ;;=4^T82.190A
 ;;^UTILITY(U,$J,358.3,13180,2)
 ;;=^5054704
 ;;^UTILITY(U,$J,358.3,13181,0)
 ;;=T82.310A^^53^582^2
 ;;^UTILITY(U,$J,358.3,13181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13181,1,3,0)
 ;;=3^Breakdown,Aortic Grft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13181,1,4,0)
 ;;=4^T82.310A
 ;;^UTILITY(U,$J,358.3,13181,2)
 ;;=^5054740
 ;;^UTILITY(U,$J,358.3,13182,0)
 ;;=T82.311A^^53^582^7
 ;;^UTILITY(U,$J,358.3,13182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13182,1,3,0)
 ;;=3^Breakdown,Carotid Arterial Grft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13182,1,4,0)
 ;;=4^T82.311A
 ;;^UTILITY(U,$J,358.3,13182,2)
 ;;=^5054743
 ;;^UTILITY(U,$J,358.3,13183,0)
 ;;=T82.312A^^53^582^8
 ;;^UTILITY(U,$J,358.3,13183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13183,1,3,0)
 ;;=3^Breakdown,Femoral Arterial Grft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13183,1,4,0)
 ;;=4^T82.312A
 ;;^UTILITY(U,$J,358.3,13183,2)
 ;;=^5054746
 ;;^UTILITY(U,$J,358.3,13184,0)
 ;;=T82.318A^^53^582^17
 ;;^UTILITY(U,$J,358.3,13184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13184,1,3,0)
 ;;=3^Breakdown,Vasc Grfts,Init Encntr
 ;;^UTILITY(U,$J,358.3,13184,1,4,0)
 ;;=4^T82.318A
 ;;^UTILITY(U,$J,358.3,13184,2)
 ;;=^5054749
 ;;^UTILITY(U,$J,358.3,13185,0)
 ;;=T82.319A^^53^582^18
 ;;^UTILITY(U,$J,358.3,13185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13185,1,3,0)
 ;;=3^Breakdown,Vasc Grfts,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,13185,1,4,0)
 ;;=4^T82.319A
 ;;^UTILITY(U,$J,358.3,13185,2)
 ;;=^5054752
 ;;^UTILITY(U,$J,358.3,13186,0)
 ;;=T82.320A^^53^582^30
 ;;^UTILITY(U,$J,358.3,13186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13186,1,3,0)
 ;;=3^Dsplcmnt of Aortic Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13186,1,4,0)
 ;;=4^T82.320A
 ;;^UTILITY(U,$J,358.3,13186,2)
 ;;=^5054755
 ;;^UTILITY(U,$J,358.3,13187,0)
 ;;=T82.321A^^53^582^35
 ;;^UTILITY(U,$J,358.3,13187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13187,1,3,0)
 ;;=3^Dsplcmnt of Carotid Arterial Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13187,1,4,0)
 ;;=4^T82.321A
 ;;^UTILITY(U,$J,358.3,13187,2)
 ;;=^5054758
 ;;^UTILITY(U,$J,358.3,13188,0)
 ;;=T82.322A^^53^582^36
 ;;^UTILITY(U,$J,358.3,13188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13188,1,3,0)
 ;;=3^Dsplcmnt of Femoral Arterial Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13188,1,4,0)
 ;;=4^T82.322A
 ;;^UTILITY(U,$J,358.3,13188,2)
 ;;=^5054761
 ;;^UTILITY(U,$J,358.3,13189,0)
 ;;=T82.329A^^53^582^45
 ;;^UTILITY(U,$J,358.3,13189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13189,1,3,0)
 ;;=3^Dsplcmnt of Vascular Grafts,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,13189,1,4,0)
 ;;=4^T82.329A
 ;;^UTILITY(U,$J,358.3,13189,2)
 ;;=^5054767
 ;;^UTILITY(U,$J,358.3,13190,0)
 ;;=T82.330A^^53^582^135
 ;;^UTILITY(U,$J,358.3,13190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13190,1,3,0)
 ;;=3^Leakage of Aortic Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13190,1,4,0)
 ;;=4^T82.330A
 ;;^UTILITY(U,$J,358.3,13190,2)
 ;;=^5054770
 ;;^UTILITY(U,$J,358.3,13191,0)
 ;;=T82.331A^^53^582^138
 ;;^UTILITY(U,$J,358.3,13191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13191,1,3,0)
 ;;=3^Leakage of Carotid Arterial Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13191,1,4,0)
 ;;=4^T82.331A
 ;;^UTILITY(U,$J,358.3,13191,2)
 ;;=^5054773
 ;;^UTILITY(U,$J,358.3,13192,0)
 ;;=T82.332A^^53^582^139
 ;;^UTILITY(U,$J,358.3,13192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13192,1,3,0)
 ;;=3^Leakage of Femoral Arterial Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13192,1,4,0)
 ;;=4^T82.332A
 ;;^UTILITY(U,$J,358.3,13192,2)
 ;;=^5054776
 ;;^UTILITY(U,$J,358.3,13193,0)
 ;;=T82.339A^^53^582^144
 ;;^UTILITY(U,$J,358.3,13193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13193,1,3,0)
 ;;=3^Leakage of Vascular Graft,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,13193,1,4,0)
 ;;=4^T82.339A
 ;;^UTILITY(U,$J,358.3,13193,2)
 ;;=^5054782
 ;;^UTILITY(U,$J,358.3,13194,0)
 ;;=T82.390A^^53^582^146
 ;;^UTILITY(U,$J,358.3,13194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13194,1,3,0)
 ;;=3^Mech Compl of Aortic Graft,NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,13194,1,4,0)
 ;;=4^T82.390A
 ;;^UTILITY(U,$J,358.3,13194,2)
 ;;=^5054785
 ;;^UTILITY(U,$J,358.3,13195,0)
 ;;=T82.391A^^53^582^151
 ;;^UTILITY(U,$J,358.3,13195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13195,1,3,0)
 ;;=3^Mech Compl of Carotid Arterial Graft,NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,13195,1,4,0)
 ;;=4^T82.391A
 ;;^UTILITY(U,$J,358.3,13195,2)
 ;;=^5054788
 ;;^UTILITY(U,$J,358.3,13196,0)
 ;;=T82.392A^^53^582^152
 ;;^UTILITY(U,$J,358.3,13196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13196,1,3,0)
 ;;=3^Mech Compl of Femoral Arterial Graft,NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,13196,1,4,0)
 ;;=4^T82.392A
 ;;^UTILITY(U,$J,358.3,13196,2)
 ;;=^5054791
 ;;^UTILITY(U,$J,358.3,13197,0)
 ;;=T82.399A^^53^582^165
 ;;^UTILITY(U,$J,358.3,13197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13197,1,3,0)
 ;;=3^Mech Compl of Vascular Graft,Unspec,NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,13197,1,4,0)
 ;;=4^T82.399A
 ;;^UTILITY(U,$J,358.3,13197,2)
 ;;=^5054797
 ;;^UTILITY(U,$J,358.3,13198,0)
 ;;=T82.41XA^^53^582^16
 ;;^UTILITY(U,$J,358.3,13198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13198,1,3,0)
 ;;=3^Breakdown,Vasc Dialysis Cath,Init Encntr
 ;;^UTILITY(U,$J,358.3,13198,1,4,0)
 ;;=4^T82.41XA
 ;;^UTILITY(U,$J,358.3,13198,2)
 ;;=^5054800
 ;;^UTILITY(U,$J,358.3,13199,0)
 ;;=T82.42XA^^53^582^44
 ;;^UTILITY(U,$J,358.3,13199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13199,1,3,0)
 ;;=3^Dsplcmnt of Vascular Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,13199,1,4,0)
 ;;=4^T82.42XA
 ;;^UTILITY(U,$J,358.3,13199,2)
 ;;=^5054803
 ;;^UTILITY(U,$J,358.3,13200,0)
 ;;=T82.43XA^^53^582^143
 ;;^UTILITY(U,$J,358.3,13200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13200,1,3,0)
 ;;=3^Leakage of Vascular Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,13200,1,4,0)
 ;;=4^T82.43XA
 ;;^UTILITY(U,$J,358.3,13200,2)
 ;;=^5054806
 ;;^UTILITY(U,$J,358.3,13201,0)
 ;;=T82.49XA^^53^582^27
 ;;^UTILITY(U,$J,358.3,13201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13201,1,3,0)
 ;;=3^Complic,Vasc Dialysis Cath NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,13201,1,4,0)
 ;;=4^T82.49XA
 ;;^UTILITY(U,$J,358.3,13201,2)
 ;;=^5054809
 ;;^UTILITY(U,$J,358.3,13202,0)
 ;;=T82.510A^^53^582^13
 ;;^UTILITY(U,$J,358.3,13202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13202,1,3,0)
 ;;=3^Breakdown,Surg Created AV Fist,Init Encntr
 ;;^UTILITY(U,$J,358.3,13202,1,4,0)
 ;;=4^T82.510A
 ;;^UTILITY(U,$J,358.3,13202,2)
 ;;=^5054812
 ;;^UTILITY(U,$J,358.3,13203,0)
 ;;=T82.511A^^53^582^14
 ;;^UTILITY(U,$J,358.3,13203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13203,1,3,0)
 ;;=3^Breakdown,Surg Created AV Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,13203,1,4,0)
 ;;=4^T82.511A
 ;;^UTILITY(U,$J,358.3,13203,2)
 ;;=^5054815
 ;;^UTILITY(U,$J,358.3,13204,0)
 ;;=T82.513A^^53^582^3
 ;;^UTILITY(U,$J,358.3,13204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13204,1,3,0)
 ;;=3^Breakdown,Balloon Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,13204,1,4,0)
 ;;=4^T82.513A
 ;;^UTILITY(U,$J,358.3,13204,2)
 ;;=^5054821
 ;;^UTILITY(U,$J,358.3,13205,0)
 ;;=T82.515A^^53^582^15
 ;;^UTILITY(U,$J,358.3,13205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13205,1,3,0)
 ;;=3^Breakdown,Umbrella Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,13205,1,4,0)
 ;;=4^T82.515A
 ;;^UTILITY(U,$J,358.3,13205,2)
 ;;=^5054827
 ;;^UTILITY(U,$J,358.3,13206,0)
 ;;=T82.519A^^53^582^4
 ;;^UTILITY(U,$J,358.3,13206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13206,1,3,0)
 ;;=3^Breakdown,Card/Vasc Devices/Implants,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,13206,1,4,0)
 ;;=4^T82.519A
 ;;^UTILITY(U,$J,358.3,13206,2)
 ;;=^5054833
 ;;^UTILITY(U,$J,358.3,13207,0)
 ;;=T82.520A^^53^582^41
 ;;^UTILITY(U,$J,358.3,13207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13207,1,3,0)
 ;;=3^Dsplcmnt of Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,13207,1,4,0)
 ;;=4^T82.520A
 ;;^UTILITY(U,$J,358.3,13207,2)
 ;;=^5054836
 ;;^UTILITY(U,$J,358.3,13208,0)
 ;;=T82.521A^^53^582^42
 ;;^UTILITY(U,$J,358.3,13208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13208,1,3,0)
 ;;=3^Dsplcmnt of Surgically Created AV Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,13208,1,4,0)
 ;;=4^T82.521A
 ;;^UTILITY(U,$J,358.3,13208,2)
 ;;=^5054839
 ;;^UTILITY(U,$J,358.3,13209,0)
 ;;=T82.523A^^53^582^31
 ;;^UTILITY(U,$J,358.3,13209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13209,1,3,0)
 ;;=3^Dsplcmnt of Balloon Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,13209,1,4,0)
 ;;=4^T82.523A
 ;;^UTILITY(U,$J,358.3,13209,2)
 ;;=^5054845
 ;;^UTILITY(U,$J,358.3,13210,0)
 ;;=T82.525A^^53^582^43
 ;;^UTILITY(U,$J,358.3,13210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13210,1,3,0)
 ;;=3^Dsplcmnt of Umbrella Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,13210,1,4,0)
 ;;=4^T82.525A
 ;;^UTILITY(U,$J,358.3,13210,2)
 ;;=^5054851
 ;;^UTILITY(U,$J,358.3,13211,0)
 ;;=T82.529A^^53^582^34
 ;;^UTILITY(U,$J,358.3,13211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13211,1,3,0)
 ;;=3^Dsplcmnt of Cardiac/Vascular Devices/Implants Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,13211,1,4,0)
 ;;=4^T82.529A
 ;;^UTILITY(U,$J,358.3,13211,2)
 ;;=^5054857
 ;;^UTILITY(U,$J,358.3,13212,0)
 ;;=T82.530A^^53^582^140
 ;;^UTILITY(U,$J,358.3,13212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13212,1,3,0)
 ;;=3^Leakage of Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,13212,1,4,0)
 ;;=4^T82.530A
 ;;^UTILITY(U,$J,358.3,13212,2)
 ;;=^5054860
 ;;^UTILITY(U,$J,358.3,13213,0)
 ;;=T82.531A^^53^582^141
 ;;^UTILITY(U,$J,358.3,13213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13213,1,3,0)
 ;;=3^Leakage of Surgically Created AV Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,13213,1,4,0)
 ;;=4^T82.531A
 ;;^UTILITY(U,$J,358.3,13213,2)
 ;;=^5054863
 ;;^UTILITY(U,$J,358.3,13214,0)
 ;;=T82.533A^^53^582^136
 ;;^UTILITY(U,$J,358.3,13214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13214,1,3,0)
 ;;=3^Leakage of Balloon Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,13214,1,4,0)
 ;;=4^T82.533A
 ;;^UTILITY(U,$J,358.3,13214,2)
 ;;=^5054869
 ;;^UTILITY(U,$J,358.3,13215,0)
 ;;=T82.535A^^53^582^142
 ;;^UTILITY(U,$J,358.3,13215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13215,1,3,0)
 ;;=3^Leakage of Umbrella Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,13215,1,4,0)
 ;;=4^T82.535A
 ;;^UTILITY(U,$J,358.3,13215,2)
 ;;=^5054875
 ;;^UTILITY(U,$J,358.3,13216,0)
 ;;=T82.539A^^53^582^137
 ;;^UTILITY(U,$J,358.3,13216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13216,1,3,0)
 ;;=3^Leakage of Cardiac/Vascular Device/Implant Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,13216,1,4,0)
 ;;=4^T82.539A
 ;;^UTILITY(U,$J,358.3,13216,2)
 ;;=^5054881
 ;;^UTILITY(U,$J,358.3,13217,0)
 ;;=T82.590A^^53^582^162
 ;;^UTILITY(U,$J,358.3,13217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13217,1,3,0)
 ;;=3^Mech Compl of Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,13217,1,4,0)
 ;;=4^T82.590A
 ;;^UTILITY(U,$J,358.3,13217,2)
 ;;=^5054884
 ;;^UTILITY(U,$J,358.3,13218,0)
 ;;=T82.591A^^53^582^163
 ;;^UTILITY(U,$J,358.3,13218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13218,1,3,0)
 ;;=3^Mech Compl of Surgically Created AV Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,13218,1,4,0)
 ;;=4^T82.591A
 ;;^UTILITY(U,$J,358.3,13218,2)
 ;;=^5054887
 ;;^UTILITY(U,$J,358.3,13219,0)
 ;;=T82.593A^^53^582^147
 ;;^UTILITY(U,$J,358.3,13219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13219,1,3,0)
 ;;=3^Mech Compl of Balloon Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,13219,1,4,0)
 ;;=4^T82.593A
 ;;^UTILITY(U,$J,358.3,13219,2)
 ;;=^5054893
 ;;^UTILITY(U,$J,358.3,13220,0)
 ;;=T82.595A^^53^582^164
 ;;^UTILITY(U,$J,358.3,13220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13220,1,3,0)
 ;;=3^Mech Compl of Umbrella Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,13220,1,4,0)
 ;;=4^T82.595A
 ;;^UTILITY(U,$J,358.3,13220,2)
 ;;=^5054899
 ;;^UTILITY(U,$J,358.3,13221,0)
 ;;=T82.599A^^53^582^149
 ;;^UTILITY(U,$J,358.3,13221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13221,1,3,0)
 ;;=3^Mech Compl of Cardiac/Vascular Device/Implant Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,13221,1,4,0)
 ;;=4^T82.599A
 ;;^UTILITY(U,$J,358.3,13221,2)
 ;;=^5054905
 ;;^UTILITY(U,$J,358.3,13222,0)
 ;;=T85.01XA^^53^582^19
 ;;^UTILITY(U,$J,358.3,13222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13222,1,3,0)
 ;;=3^Breakdown,Ventricular Intracranial Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,13222,1,4,0)
 ;;=4^T85.01XA
 ;;^UTILITY(U,$J,358.3,13222,2)
 ;;=^5055478
 ;;^UTILITY(U,$J,358.3,13223,0)
 ;;=T85.02XA^^53^582^46
 ;;^UTILITY(U,$J,358.3,13223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13223,1,3,0)
 ;;=3^Dsplcmnt of Ventricular Intracranial Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,13223,1,4,0)
 ;;=4^T85.02XA
 ;;^UTILITY(U,$J,358.3,13223,2)
 ;;=^5055481
 ;;^UTILITY(U,$J,358.3,13224,0)
 ;;=T85.03XA^^53^582^145
 ;;^UTILITY(U,$J,358.3,13224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13224,1,3,0)
 ;;=3^Leakage of Ventricular Intracranial Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,13224,1,4,0)
 ;;=4^T85.03XA
 ;;^UTILITY(U,$J,358.3,13224,2)
 ;;=^5055484
 ;;^UTILITY(U,$J,358.3,13225,0)
 ;;=T85.09XA^^53^582^166
 ;;^UTILITY(U,$J,358.3,13225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13225,1,3,0)
 ;;=3^Mech Compl of Ventricular Intracranial Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,13225,1,4,0)
 ;;=4^T85.09XA
 ;;^UTILITY(U,$J,358.3,13225,2)
 ;;=^5055487
 ;;^UTILITY(U,$J,358.3,13226,0)
 ;;=T85.110A^^53^582^9
 ;;^UTILITY(U,$J,358.3,13226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13226,1,3,0)
 ;;=3^Breakdown,Implnt Elect Neurostim,Brain,Init Encntr
 ;;^UTILITY(U,$J,358.3,13226,1,4,0)
 ;;=4^T85.110A
 ;;^UTILITY(U,$J,358.3,13226,2)
 ;;=^5055490
 ;;^UTILITY(U,$J,358.3,13227,0)
 ;;=T85.111A^^53^582^11
 ;;^UTILITY(U,$J,358.3,13227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13227,1,3,0)
 ;;=3^Breakdown,Implnt Elect Neurostim,Periph Nrv,Init Encntr
 ;;^UTILITY(U,$J,358.3,13227,1,4,0)
 ;;=4^T85.111A
 ;;^UTILITY(U,$J,358.3,13227,2)
 ;;=^5055493
 ;;^UTILITY(U,$J,358.3,13228,0)
 ;;=T85.112A^^53^582^12
 ;;^UTILITY(U,$J,358.3,13228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13228,1,3,0)
 ;;=3^Breakdown,Implnt Elect Neurostim,Spinal Cord,Init Encntr
 ;;^UTILITY(U,$J,358.3,13228,1,4,0)
 ;;=4^T85.112A
 ;;^UTILITY(U,$J,358.3,13228,2)
 ;;=^5055496
 ;;^UTILITY(U,$J,358.3,13229,0)
 ;;=T85.118A^^53^582^10
 ;;^UTILITY(U,$J,358.3,13229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13229,1,3,0)
 ;;=3^Breakdown,Implnt Elect Neurostim,Nerv Sys,Init Encntr
 ;;^UTILITY(U,$J,358.3,13229,1,4,0)
 ;;=4^T85.118A
 ;;^UTILITY(U,$J,358.3,13229,2)
 ;;=^5055499
 ;;^UTILITY(U,$J,358.3,13230,0)
 ;;=T85.120A^^53^582^37
 ;;^UTILITY(U,$J,358.3,13230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13230,1,3,0)
 ;;=3^Dsplcmnt of Implnt Elect Neurostim,Brain,Init Encntr
 ;;^UTILITY(U,$J,358.3,13230,1,4,0)
 ;;=4^T85.120A
 ;;^UTILITY(U,$J,358.3,13230,2)
 ;;=^5055502
 ;;^UTILITY(U,$J,358.3,13231,0)
 ;;=T85.121A^^53^582^38
 ;;^UTILITY(U,$J,358.3,13231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13231,1,3,0)
 ;;=3^Dsplcmnt of Implnt Elect Neurostim,Periph Nrv,Init Encntr
 ;;^UTILITY(U,$J,358.3,13231,1,4,0)
 ;;=4^T85.121A
 ;;^UTILITY(U,$J,358.3,13231,2)
 ;;=^5055505
 ;;^UTILITY(U,$J,358.3,13232,0)
 ;;=T85.122A^^53^582^39
 ;;^UTILITY(U,$J,358.3,13232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13232,1,3,0)
 ;;=3^Dsplcmnt of Implnt Elect Neurostim,Spinal Cord,Init Encntr
 ;;^UTILITY(U,$J,358.3,13232,1,4,0)
 ;;=4^T85.122A
 ;;^UTILITY(U,$J,358.3,13232,2)
 ;;=^5055508
 ;;^UTILITY(U,$J,358.3,13233,0)
 ;;=T85.128A^^53^582^40
 ;;^UTILITY(U,$J,358.3,13233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13233,1,3,0)
 ;;=3^Dsplcmnt of Implnt Elect Stim,Nrv Sys,Init Encntr
 ;;^UTILITY(U,$J,358.3,13233,1,4,0)
 ;;=4^T85.128A
 ;;^UTILITY(U,$J,358.3,13233,2)
 ;;=^5055511
 ;;^UTILITY(U,$J,358.3,13234,0)
 ;;=T85.190A^^53^582^153
 ;;^UTILITY(U,$J,358.3,13234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13234,1,3,0)
 ;;=3^Mech Compl of Implanted Electronic Neurostim of Brain,Init Encntr
 ;;^UTILITY(U,$J,358.3,13234,1,4,0)
 ;;=4^T85.190A
 ;;^UTILITY(U,$J,358.3,13234,2)
 ;;=^5055514
 ;;^UTILITY(U,$J,358.3,13235,0)
 ;;=T85.191A^^53^582^154
 ;;^UTILITY(U,$J,358.3,13235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13235,1,3,0)
 ;;=3^Mech Compl of Implanted Electronic Neurostim of Periph Nrv,Init Encntr
 ;;^UTILITY(U,$J,358.3,13235,1,4,0)
 ;;=4^T85.191A
 ;;^UTILITY(U,$J,358.3,13235,2)
 ;;=^5055517
 ;;^UTILITY(U,$J,358.3,13236,0)
 ;;=T85.192A^^53^582^155
 ;;^UTILITY(U,$J,358.3,13236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13236,1,3,0)
 ;;=3^Mech Compl of Implanted Electronic Neurostim of Spinal Cord,Init Encntr
 ;;^UTILITY(U,$J,358.3,13236,1,4,0)
 ;;=4^T85.192A
 ;;^UTILITY(U,$J,358.3,13236,2)
 ;;=^5055520
 ;;^UTILITY(U,$J,358.3,13237,0)
 ;;=T85.199A^^53^582^156
 ;;^UTILITY(U,$J,358.3,13237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13237,1,3,0)
 ;;=3^Mech Compl of Implanted Electronic Stim of Nervous Sys,Init Encntr
 ;;^UTILITY(U,$J,358.3,13237,1,4,0)
 ;;=4^T85.199A
 ;;^UTILITY(U,$J,358.3,13237,2)
 ;;=^5055523
 ;;^UTILITY(U,$J,358.3,13238,0)
 ;;=T83.498A^^53^582^159
 ;;^UTILITY(U,$J,358.3,13238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13238,1,3,0)
 ;;=3^Mech Compl of Prosthetic Device/Implant/Graft of Genital Tract,Init Encntr
