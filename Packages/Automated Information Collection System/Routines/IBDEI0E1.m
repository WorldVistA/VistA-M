IBDEI0E1 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17723,1,4,0)
 ;;=4^T81.72XA
 ;;^UTILITY(U,$J,358.3,17723,2)
 ;;=^5054650
 ;;^UTILITY(U,$J,358.3,17724,0)
 ;;=J95.88^^53^747^98
 ;;^UTILITY(U,$J,358.3,17724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17724,1,3,0)
 ;;=3^Intraoperative Complications of Respiratory System NEC
 ;;^UTILITY(U,$J,358.3,17724,1,4,0)
 ;;=4^J95.88
 ;;^UTILITY(U,$J,358.3,17724,2)
 ;;=^5008345
 ;;^UTILITY(U,$J,358.3,17725,0)
 ;;=J95.89^^53^747^202
 ;;^UTILITY(U,$J,358.3,17725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17725,1,3,0)
 ;;=3^Postprocedure Complications/Disorders of Respiratory System NEC
 ;;^UTILITY(U,$J,358.3,17725,1,4,0)
 ;;=4^J95.89
 ;;^UTILITY(U,$J,358.3,17725,2)
 ;;=^5008346
 ;;^UTILITY(U,$J,358.3,17726,0)
 ;;=K91.3^^53^747^194
 ;;^UTILITY(U,$J,358.3,17726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17726,1,3,0)
 ;;=3^Postprocedural Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,17726,1,4,0)
 ;;=4^K91.3
 ;;^UTILITY(U,$J,358.3,17726,2)
 ;;=^5008902
 ;;^UTILITY(U,$J,358.3,17727,0)
 ;;=K91.81^^53^747^96
 ;;^UTILITY(U,$J,358.3,17727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17727,1,3,0)
 ;;=3^Intraoperative Complications of Digestive System
 ;;^UTILITY(U,$J,358.3,17727,1,4,0)
 ;;=4^K91.81
 ;;^UTILITY(U,$J,358.3,17727,2)
 ;;=^5008907
 ;;^UTILITY(U,$J,358.3,17728,0)
 ;;=K91.82^^53^747^192
 ;;^UTILITY(U,$J,358.3,17728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17728,1,3,0)
 ;;=3^Postprocedural Hepatic Failure
 ;;^UTILITY(U,$J,358.3,17728,1,4,0)
 ;;=4^K91.82
 ;;^UTILITY(U,$J,358.3,17728,2)
 ;;=^5008908
 ;;^UTILITY(U,$J,358.3,17729,0)
 ;;=K91.83^^53^747^193
 ;;^UTILITY(U,$J,358.3,17729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17729,1,3,0)
 ;;=3^Postprocedural Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,17729,1,4,0)
 ;;=4^K91.83
 ;;^UTILITY(U,$J,358.3,17729,2)
 ;;=^5008909
 ;;^UTILITY(U,$J,358.3,17730,0)
 ;;=K91.89^^53^747^164
 ;;^UTILITY(U,$J,358.3,17730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17730,1,3,0)
 ;;=3^Postprocedural Complications/Disorders of Digestive System
 ;;^UTILITY(U,$J,358.3,17730,1,4,0)
 ;;=4^K91.89
 ;;^UTILITY(U,$J,358.3,17730,2)
 ;;=^5008912
 ;;^UTILITY(U,$J,358.3,17731,0)
 ;;=N99.89^^53^747^165
 ;;^UTILITY(U,$J,358.3,17731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17731,1,3,0)
 ;;=3^Postprocedural Complications/Disorders of GU System
 ;;^UTILITY(U,$J,358.3,17731,1,4,0)
 ;;=4^N99.89
 ;;^UTILITY(U,$J,358.3,17731,2)
 ;;=^5015971
 ;;^UTILITY(U,$J,358.3,17732,0)
 ;;=N99.81^^53^747^97
 ;;^UTILITY(U,$J,358.3,17732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17732,1,3,0)
 ;;=3^Intraoperative Complications of GU System
 ;;^UTILITY(U,$J,358.3,17732,1,4,0)
 ;;=4^N99.81
 ;;^UTILITY(U,$J,358.3,17732,2)
 ;;=^5015967
 ;;^UTILITY(U,$J,358.3,17733,0)
 ;;=D78.01^^53^747^125
 ;;^UTILITY(U,$J,358.3,17733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17733,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Spleen Complicating Spleen Procedure
 ;;^UTILITY(U,$J,358.3,17733,1,4,0)
 ;;=4^D78.01
 ;;^UTILITY(U,$J,358.3,17733,2)
 ;;=^5002397
 ;;^UTILITY(U,$J,358.3,17734,0)
 ;;=D78.21^^53^747^190
 ;;^UTILITY(U,$J,358.3,17734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17734,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Spleen Following Spleen Procedure
 ;;^UTILITY(U,$J,358.3,17734,1,4,0)
 ;;=4^D78.21
 ;;^UTILITY(U,$J,358.3,17734,2)
 ;;=^5002401
 ;;^UTILITY(U,$J,358.3,17735,0)
 ;;=D78.22^^53^747^191
 ;;^UTILITY(U,$J,358.3,17735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17735,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Spleen Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17735,1,4,0)
 ;;=4^D78.22
 ;;^UTILITY(U,$J,358.3,17735,2)
 ;;=^5002402
 ;;^UTILITY(U,$J,358.3,17736,0)
 ;;=E36.01^^53^747^109
 ;;^UTILITY(U,$J,358.3,17736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17736,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Endo Sys Complicating Endo Sys Procedure
 ;;^UTILITY(U,$J,358.3,17736,1,4,0)
 ;;=4^E36.01
 ;;^UTILITY(U,$J,358.3,17736,2)
 ;;=^5002779
 ;;^UTILITY(U,$J,358.3,17737,0)
 ;;=E36.02^^53^747^110
 ;;^UTILITY(U,$J,358.3,17737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17737,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Endo Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,17737,1,4,0)
 ;;=4^E36.02
 ;;^UTILITY(U,$J,358.3,17737,2)
 ;;=^5002780
 ;;^UTILITY(U,$J,358.3,17738,0)
 ;;=G97.31^^53^747^117
 ;;^UTILITY(U,$J,358.3,17738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17738,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Nervous Sys Complicating Nervous Sys Procedure
 ;;^UTILITY(U,$J,358.3,17738,1,4,0)
 ;;=4^G97.31
 ;;^UTILITY(U,$J,358.3,17738,2)
 ;;=^5004204
 ;;^UTILITY(U,$J,358.3,17739,0)
 ;;=G97.32^^53^747^118
 ;;^UTILITY(U,$J,358.3,17739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17739,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Nervous Sys Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,17739,1,4,0)
 ;;=4^G97.32
 ;;^UTILITY(U,$J,358.3,17739,2)
 ;;=^5004205
 ;;^UTILITY(U,$J,358.3,17740,0)
 ;;=H59.111^^53^747^121
 ;;^UTILITY(U,$J,358.3,17740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17740,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Right Eye/Adnexa Complicating Ophth Procedure
 ;;^UTILITY(U,$J,358.3,17740,1,4,0)
 ;;=4^H59.111
 ;;^UTILITY(U,$J,358.3,17740,2)
 ;;=^5006401
 ;;^UTILITY(U,$J,358.3,17741,0)
 ;;=H59.112^^53^747^113
 ;;^UTILITY(U,$J,358.3,17741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17741,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Left Eye/Adnexa Complicating Ophth Procedure
 ;;^UTILITY(U,$J,358.3,17741,1,4,0)
 ;;=4^H59.112
 ;;^UTILITY(U,$J,358.3,17741,2)
 ;;=^5006402
 ;;^UTILITY(U,$J,358.3,17742,0)
 ;;=H59.113^^53^747^99
 ;;^UTILITY(U,$J,358.3,17742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17742,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Bilateral Eyes/Adnexa Complicating Ophth Procedure
 ;;^UTILITY(U,$J,358.3,17742,1,4,0)
 ;;=4^H59.113
 ;;^UTILITY(U,$J,358.3,17742,2)
 ;;=^5006403
 ;;^UTILITY(U,$J,358.3,17743,0)
 ;;=H59.121^^53^747^122
 ;;^UTILITY(U,$J,358.3,17743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17743,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Right Eye/Adnexa Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,17743,1,4,0)
 ;;=4^H59.121
 ;;^UTILITY(U,$J,358.3,17743,2)
 ;;=^5006405
 ;;^UTILITY(U,$J,358.3,17744,0)
 ;;=H59.122^^53^747^114
 ;;^UTILITY(U,$J,358.3,17744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17744,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Left Eye/Adnexa Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,17744,1,4,0)
 ;;=4^H59.122
 ;;^UTILITY(U,$J,358.3,17744,2)
 ;;=^5006406
 ;;^UTILITY(U,$J,358.3,17745,0)
 ;;=H59.123^^53^747^100
 ;;^UTILITY(U,$J,358.3,17745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17745,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Bilateral Eyes/Adnexa Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,17745,1,4,0)
 ;;=4^H59.123
 ;;^UTILITY(U,$J,358.3,17745,2)
 ;;=^5006407
 ;;^UTILITY(U,$J,358.3,17746,0)
 ;;=H95.21^^53^747^107
 ;;^UTILITY(U,$J,358.3,17746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17746,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Ear/Mastoid Complicating Ear/Mastoid Procedure
 ;;^UTILITY(U,$J,358.3,17746,1,4,0)
 ;;=4^H95.21
 ;;^UTILITY(U,$J,358.3,17746,2)
 ;;=^5007026
 ;;^UTILITY(U,$J,358.3,17747,0)
 ;;=H95.22^^53^747^108
 ;;^UTILITY(U,$J,358.3,17747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17747,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Ear/Mastoid Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,17747,1,4,0)
 ;;=4^H95.22
 ;;^UTILITY(U,$J,358.3,17747,2)
 ;;=^5007027
 ;;^UTILITY(U,$J,358.3,17748,0)
 ;;=I97.410^^53^747^101
 ;;^UTILITY(U,$J,358.3,17748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17748,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Circ Sys Complicating Card Catheterization
 ;;^UTILITY(U,$J,358.3,17748,1,4,0)
 ;;=4^I97.410
 ;;^UTILITY(U,$J,358.3,17748,2)
 ;;=^5008093
 ;;^UTILITY(U,$J,358.3,17749,0)
 ;;=I97.411^^53^747^102
 ;;^UTILITY(U,$J,358.3,17749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17749,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Circ Sys Complicating Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,17749,1,4,0)
 ;;=4^I97.411
 ;;^UTILITY(U,$J,358.3,17749,2)
 ;;=^5008094
 ;;^UTILITY(U,$J,358.3,17750,0)
 ;;=I97.418^^53^747^103
 ;;^UTILITY(U,$J,358.3,17750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17750,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Circ Sys Complicating Oth Circ Sys Procedure
 ;;^UTILITY(U,$J,358.3,17750,1,4,0)
 ;;=4^I97.418
 ;;^UTILITY(U,$J,358.3,17750,2)
 ;;=^5008095
 ;;^UTILITY(U,$J,358.3,17751,0)
 ;;=I97.42^^53^747^104
 ;;^UTILITY(U,$J,358.3,17751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17751,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Circ Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,17751,1,4,0)
 ;;=4^I97.42
 ;;^UTILITY(U,$J,358.3,17751,2)
 ;;=^5008096
 ;;^UTILITY(U,$J,358.3,17752,0)
 ;;=J95.61^^53^747^119
 ;;^UTILITY(U,$J,358.3,17752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17752,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Resp Sys Complicating Resp Sys Procedure
 ;;^UTILITY(U,$J,358.3,17752,1,4,0)
 ;;=4^J95.61
 ;;^UTILITY(U,$J,358.3,17752,2)
 ;;=^5008332
 ;;^UTILITY(U,$J,358.3,17753,0)
 ;;=J95.62^^53^747^120
 ;;^UTILITY(U,$J,358.3,17753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17753,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Resp Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,17753,1,4,0)
 ;;=4^J95.62
 ;;^UTILITY(U,$J,358.3,17753,2)
 ;;=^5008333
 ;;^UTILITY(U,$J,358.3,17754,0)
 ;;=K91.61^^53^747^105
 ;;^UTILITY(U,$J,358.3,17754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17754,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Digestive Sys Complicating Digestive Sys Procedure
 ;;^UTILITY(U,$J,358.3,17754,1,4,0)
 ;;=4^K91.61
 ;;^UTILITY(U,$J,358.3,17754,2)
 ;;=^5008903
 ;;^UTILITY(U,$J,358.3,17755,0)
 ;;=K91.62^^53^747^106
 ;;^UTILITY(U,$J,358.3,17755,1,0)
 ;;=^358.31IA^4^2
