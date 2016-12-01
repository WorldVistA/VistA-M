IBDEI0DX ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17596,1,4,0)
 ;;=4^T82.322A
 ;;^UTILITY(U,$J,358.3,17596,2)
 ;;=^5054761
 ;;^UTILITY(U,$J,358.3,17597,0)
 ;;=T82.329A^^53^747^47
 ;;^UTILITY(U,$J,358.3,17597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17597,1,3,0)
 ;;=3^Displacement of Vascular Grafts,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,17597,1,4,0)
 ;;=4^T82.329A
 ;;^UTILITY(U,$J,358.3,17597,2)
 ;;=^5054767
 ;;^UTILITY(U,$J,358.3,17598,0)
 ;;=T82.330A^^53^747^126
 ;;^UTILITY(U,$J,358.3,17598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17598,1,3,0)
 ;;=3^Leakage of Aortic Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,17598,1,4,0)
 ;;=4^T82.330A
 ;;^UTILITY(U,$J,358.3,17598,2)
 ;;=^5054770
 ;;^UTILITY(U,$J,358.3,17599,0)
 ;;=T82.331A^^53^747^129
 ;;^UTILITY(U,$J,358.3,17599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17599,1,3,0)
 ;;=3^Leakage of Carotid Arterial Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,17599,1,4,0)
 ;;=4^T82.331A
 ;;^UTILITY(U,$J,358.3,17599,2)
 ;;=^5054773
 ;;^UTILITY(U,$J,358.3,17600,0)
 ;;=T82.332A^^53^747^130
 ;;^UTILITY(U,$J,358.3,17600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17600,1,3,0)
 ;;=3^Leakage of Femoral Arterial Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,17600,1,4,0)
 ;;=4^T82.332A
 ;;^UTILITY(U,$J,358.3,17600,2)
 ;;=^5054776
 ;;^UTILITY(U,$J,358.3,17601,0)
 ;;=T82.339A^^53^747^135
 ;;^UTILITY(U,$J,358.3,17601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17601,1,3,0)
 ;;=3^Leakage of Vascular Graft,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,17601,1,4,0)
 ;;=4^T82.339A
 ;;^UTILITY(U,$J,358.3,17601,2)
 ;;=^5054782
 ;;^UTILITY(U,$J,358.3,17602,0)
 ;;=T82.390A^^53^747^137
 ;;^UTILITY(U,$J,358.3,17602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17602,1,3,0)
 ;;=3^Mechanical Compl of Aortic Graft,NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,17602,1,4,0)
 ;;=4^T82.390A
 ;;^UTILITY(U,$J,358.3,17602,2)
 ;;=^5054785
 ;;^UTILITY(U,$J,358.3,17603,0)
 ;;=T82.391A^^53^747^142
 ;;^UTILITY(U,$J,358.3,17603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17603,1,3,0)
 ;;=3^Mechanical Compl of Carotid Arterial Graft,NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,17603,1,4,0)
 ;;=4^T82.391A
 ;;^UTILITY(U,$J,358.3,17603,2)
 ;;=^5054788
 ;;^UTILITY(U,$J,358.3,17604,0)
 ;;=T82.392A^^53^747^143
 ;;^UTILITY(U,$J,358.3,17604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17604,1,3,0)
 ;;=3^Mechanical Compl of Femoral Arterial Graft,NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,17604,1,4,0)
 ;;=4^T82.392A
 ;;^UTILITY(U,$J,358.3,17604,2)
 ;;=^5054791
 ;;^UTILITY(U,$J,358.3,17605,0)
 ;;=T82.399A^^53^747^156
 ;;^UTILITY(U,$J,358.3,17605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17605,1,3,0)
 ;;=3^Mechanical Compl of Vascular Graft,Unspec,NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,17605,1,4,0)
 ;;=4^T82.399A
 ;;^UTILITY(U,$J,358.3,17605,2)
 ;;=^5054797
 ;;^UTILITY(U,$J,358.3,17606,0)
 ;;=T82.41XA^^53^747^16
 ;;^UTILITY(U,$J,358.3,17606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17606,1,3,0)
 ;;=3^Breakdown of Vascular Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,17606,1,4,0)
 ;;=4^T82.41XA
 ;;^UTILITY(U,$J,358.3,17606,2)
 ;;=^5054800
 ;;^UTILITY(U,$J,358.3,17607,0)
 ;;=T82.42XA^^53^747^46
 ;;^UTILITY(U,$J,358.3,17607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17607,1,3,0)
 ;;=3^Displacement of Vascular Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,17607,1,4,0)
 ;;=4^T82.42XA
 ;;^UTILITY(U,$J,358.3,17607,2)
 ;;=^5054803
 ;;^UTILITY(U,$J,358.3,17608,0)
 ;;=T82.43XA^^53^747^134
 ;;^UTILITY(U,$J,358.3,17608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17608,1,3,0)
 ;;=3^Leakage of Vascular Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,17608,1,4,0)
 ;;=4^T82.43XA
 ;;^UTILITY(U,$J,358.3,17608,2)
 ;;=^5054806
 ;;^UTILITY(U,$J,358.3,17609,0)
 ;;=T82.49XA^^53^747^22
 ;;^UTILITY(U,$J,358.3,17609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17609,1,3,0)
 ;;=3^Complication of Vascular Dialysis Catheter NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,17609,1,4,0)
 ;;=4^T82.49XA
 ;;^UTILITY(U,$J,358.3,17609,2)
 ;;=^5054809
 ;;^UTILITY(U,$J,358.3,17610,0)
 ;;=T82.510A^^53^747^13
 ;;^UTILITY(U,$J,358.3,17610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17610,1,3,0)
 ;;=3^Breakdown of Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,17610,1,4,0)
 ;;=4^T82.510A
 ;;^UTILITY(U,$J,358.3,17610,2)
 ;;=^5054812
 ;;^UTILITY(U,$J,358.3,17611,0)
 ;;=T82.511A^^53^747^14
 ;;^UTILITY(U,$J,358.3,17611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17611,1,3,0)
 ;;=3^Breakdown of Surgically Created AV Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,17611,1,4,0)
 ;;=4^T82.511A
 ;;^UTILITY(U,$J,358.3,17611,2)
 ;;=^5054815
 ;;^UTILITY(U,$J,358.3,17612,0)
 ;;=T82.513A^^53^747^3
 ;;^UTILITY(U,$J,358.3,17612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17612,1,3,0)
 ;;=3^Breakdown of Balloon Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,17612,1,4,0)
 ;;=4^T82.513A
 ;;^UTILITY(U,$J,358.3,17612,2)
 ;;=^5054821
 ;;^UTILITY(U,$J,358.3,17613,0)
 ;;=T82.515A^^53^747^15
 ;;^UTILITY(U,$J,358.3,17613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17613,1,3,0)
 ;;=3^Breakdown of Umbrella Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,17613,1,4,0)
 ;;=4^T82.515A
 ;;^UTILITY(U,$J,358.3,17613,2)
 ;;=^5054827
 ;;^UTILITY(U,$J,358.3,17614,0)
 ;;=T82.519A^^53^747^6
 ;;^UTILITY(U,$J,358.3,17614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17614,1,3,0)
 ;;=3^Breakdown of Cardiac/Vascular Devices/Implants,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,17614,1,4,0)
 ;;=4^T82.519A
 ;;^UTILITY(U,$J,358.3,17614,2)
 ;;=^5054833
 ;;^UTILITY(U,$J,358.3,17615,0)
 ;;=T82.520A^^53^747^43
 ;;^UTILITY(U,$J,358.3,17615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17615,1,3,0)
 ;;=3^Displacement of Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,17615,1,4,0)
 ;;=4^T82.520A
 ;;^UTILITY(U,$J,358.3,17615,2)
 ;;=^5054836
 ;;^UTILITY(U,$J,358.3,17616,0)
 ;;=T82.521A^^53^747^44
 ;;^UTILITY(U,$J,358.3,17616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17616,1,3,0)
 ;;=3^Displacement of Surgically Created AV Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,17616,1,4,0)
 ;;=4^T82.521A
 ;;^UTILITY(U,$J,358.3,17616,2)
 ;;=^5054839
 ;;^UTILITY(U,$J,358.3,17617,0)
 ;;=T82.523A^^53^747^33
 ;;^UTILITY(U,$J,358.3,17617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17617,1,3,0)
 ;;=3^Displacement of Balloon Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,17617,1,4,0)
 ;;=4^T82.523A
 ;;^UTILITY(U,$J,358.3,17617,2)
 ;;=^5054845
 ;;^UTILITY(U,$J,358.3,17618,0)
 ;;=T82.525A^^53^747^45
 ;;^UTILITY(U,$J,358.3,17618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17618,1,3,0)
 ;;=3^Displacement of Umbrella Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,17618,1,4,0)
 ;;=4^T82.525A
 ;;^UTILITY(U,$J,358.3,17618,2)
 ;;=^5054851
 ;;^UTILITY(U,$J,358.3,17619,0)
 ;;=T82.529A^^53^747^36
 ;;^UTILITY(U,$J,358.3,17619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17619,1,3,0)
 ;;=3^Displacement of Cardiac/Vascular Devices/Implants Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,17619,1,4,0)
 ;;=4^T82.529A
 ;;^UTILITY(U,$J,358.3,17619,2)
 ;;=^5054857
 ;;^UTILITY(U,$J,358.3,17620,0)
 ;;=T82.530A^^53^747^131
 ;;^UTILITY(U,$J,358.3,17620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17620,1,3,0)
 ;;=3^Leakage of Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,17620,1,4,0)
 ;;=4^T82.530A
 ;;^UTILITY(U,$J,358.3,17620,2)
 ;;=^5054860
 ;;^UTILITY(U,$J,358.3,17621,0)
 ;;=T82.531A^^53^747^132
 ;;^UTILITY(U,$J,358.3,17621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17621,1,3,0)
 ;;=3^Leakage of Surgically Created AV Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,17621,1,4,0)
 ;;=4^T82.531A
 ;;^UTILITY(U,$J,358.3,17621,2)
 ;;=^5054863
 ;;^UTILITY(U,$J,358.3,17622,0)
 ;;=T82.533A^^53^747^127
 ;;^UTILITY(U,$J,358.3,17622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17622,1,3,0)
 ;;=3^Leakage of Balloon Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,17622,1,4,0)
 ;;=4^T82.533A
 ;;^UTILITY(U,$J,358.3,17622,2)
 ;;=^5054869
 ;;^UTILITY(U,$J,358.3,17623,0)
 ;;=T82.535A^^53^747^133
 ;;^UTILITY(U,$J,358.3,17623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17623,1,3,0)
 ;;=3^Leakage of Umbrella Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,17623,1,4,0)
 ;;=4^T82.535A
 ;;^UTILITY(U,$J,358.3,17623,2)
 ;;=^5054875
 ;;^UTILITY(U,$J,358.3,17624,0)
 ;;=T82.539A^^53^747^128
 ;;^UTILITY(U,$J,358.3,17624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17624,1,3,0)
 ;;=3^Leakage of Cardiac/Vascular Device/Implant Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,17624,1,4,0)
 ;;=4^T82.539A
 ;;^UTILITY(U,$J,358.3,17624,2)
 ;;=^5054881
 ;;^UTILITY(U,$J,358.3,17625,0)
 ;;=T82.590A^^53^747^153
 ;;^UTILITY(U,$J,358.3,17625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17625,1,3,0)
 ;;=3^Mechanical Compl of Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,17625,1,4,0)
 ;;=4^T82.590A
 ;;^UTILITY(U,$J,358.3,17625,2)
 ;;=^5054884
 ;;^UTILITY(U,$J,358.3,17626,0)
 ;;=T82.591A^^53^747^154
 ;;^UTILITY(U,$J,358.3,17626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17626,1,3,0)
 ;;=3^Mechanical Compl of Surgically Created AV Shunt,Init Encntr
 ;;^UTILITY(U,$J,358.3,17626,1,4,0)
 ;;=4^T82.591A
 ;;^UTILITY(U,$J,358.3,17626,2)
 ;;=^5054887
 ;;^UTILITY(U,$J,358.3,17627,0)
 ;;=T82.593A^^53^747^138
 ;;^UTILITY(U,$J,358.3,17627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17627,1,3,0)
 ;;=3^Mechanical Compl of Balloon Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,17627,1,4,0)
 ;;=4^T82.593A
 ;;^UTILITY(U,$J,358.3,17627,2)
 ;;=^5054893
 ;;^UTILITY(U,$J,358.3,17628,0)
 ;;=T82.595A^^53^747^155
 ;;^UTILITY(U,$J,358.3,17628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17628,1,3,0)
 ;;=3^Mechanical Compl of Umbrella Device,Init Encntr
 ;;^UTILITY(U,$J,358.3,17628,1,4,0)
 ;;=4^T82.595A
 ;;^UTILITY(U,$J,358.3,17628,2)
 ;;=^5054899
 ;;^UTILITY(U,$J,358.3,17629,0)
 ;;=T82.599A^^53^747^140
 ;;^UTILITY(U,$J,358.3,17629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17629,1,3,0)
 ;;=3^Mechanical Compl of Cardiac/Vascular Device/Implant Unspec,Init Encntr
