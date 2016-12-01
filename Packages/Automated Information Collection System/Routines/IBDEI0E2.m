IBDEI0E2 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17755,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Digestive Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,17755,1,4,0)
 ;;=4^K91.62
 ;;^UTILITY(U,$J,358.3,17755,2)
 ;;=^5008904
 ;;^UTILITY(U,$J,358.3,17756,0)
 ;;=L76.01^^53^747^123
 ;;^UTILITY(U,$J,358.3,17756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17756,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Skin Complicating Derm Procedure
 ;;^UTILITY(U,$J,358.3,17756,1,4,0)
 ;;=4^L76.01
 ;;^UTILITY(U,$J,358.3,17756,2)
 ;;=^5009302
 ;;^UTILITY(U,$J,358.3,17757,0)
 ;;=L76.02^^53^747^124
 ;;^UTILITY(U,$J,358.3,17757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17757,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Skin Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,17757,1,4,0)
 ;;=4^L76.02
 ;;^UTILITY(U,$J,358.3,17757,2)
 ;;=^5009303
 ;;^UTILITY(U,$J,358.3,17758,0)
 ;;=M96.810^^53^747^115
 ;;^UTILITY(U,$J,358.3,17758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17758,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of MS Structure Complication MS Sys Procedure
 ;;^UTILITY(U,$J,358.3,17758,1,4,0)
 ;;=4^M96.810
 ;;^UTILITY(U,$J,358.3,17758,2)
 ;;=^5015393
 ;;^UTILITY(U,$J,358.3,17759,0)
 ;;=M96.811^^53^747^116
 ;;^UTILITY(U,$J,358.3,17759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17759,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of MS Structure Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,17759,1,4,0)
 ;;=4^M96.811
 ;;^UTILITY(U,$J,358.3,17759,2)
 ;;=^5015394
 ;;^UTILITY(U,$J,358.3,17760,0)
 ;;=N99.61^^53^747^111
 ;;^UTILITY(U,$J,358.3,17760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17760,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of GU Sys Complicating a GU Sys Procedure
 ;;^UTILITY(U,$J,358.3,17760,1,4,0)
 ;;=4^N99.61
 ;;^UTILITY(U,$J,358.3,17760,2)
 ;;=^5015963
 ;;^UTILITY(U,$J,358.3,17761,0)
 ;;=N99.62^^53^747^112
 ;;^UTILITY(U,$J,358.3,17761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17761,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of GU Sys Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,17761,1,4,0)
 ;;=4^N99.62
 ;;^UTILITY(U,$J,358.3,17761,2)
 ;;=^5015964
 ;;^UTILITY(U,$J,358.3,17762,0)
 ;;=G97.51^^53^747^182
 ;;^UTILITY(U,$J,358.3,17762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17762,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Nervous Sys Following a Nervous Sys Procedure
 ;;^UTILITY(U,$J,358.3,17762,1,4,0)
 ;;=4^G97.51
 ;;^UTILITY(U,$J,358.3,17762,2)
 ;;=^5004209
 ;;^UTILITY(U,$J,358.3,17763,0)
 ;;=G97.52^^53^747^183
 ;;^UTILITY(U,$J,358.3,17763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17763,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Nervous Sys Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17763,1,4,0)
 ;;=4^G97.52
 ;;^UTILITY(U,$J,358.3,17763,2)
 ;;=^5004210
 ;;^UTILITY(U,$J,358.3,17764,0)
 ;;=H59.311^^53^747^186
 ;;^UTILITY(U,$J,358.3,17764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17764,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Right Eye/Adnexa Following Ophth Procedure
 ;;^UTILITY(U,$J,358.3,17764,1,4,0)
 ;;=4^H59.311
 ;;^UTILITY(U,$J,358.3,17764,2)
 ;;=^5006417
 ;;^UTILITY(U,$J,358.3,17765,0)
 ;;=H59.312^^53^747^178
 ;;^UTILITY(U,$J,358.3,17765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17765,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Left Eye/Adnexa Following Ophth Procedure
 ;;^UTILITY(U,$J,358.3,17765,1,4,0)
 ;;=4^H59.312
 ;;^UTILITY(U,$J,358.3,17765,2)
 ;;=^5006418
 ;;^UTILITY(U,$J,358.3,17766,0)
 ;;=H59.313^^53^747^166
 ;;^UTILITY(U,$J,358.3,17766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17766,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Bilateral Eyes/Adnexa Following Ophth Procedure
 ;;^UTILITY(U,$J,358.3,17766,1,4,0)
 ;;=4^H59.313
 ;;^UTILITY(U,$J,358.3,17766,2)
 ;;=^5006419
 ;;^UTILITY(U,$J,358.3,17767,0)
 ;;=H59.321^^53^747^187
 ;;^UTILITY(U,$J,358.3,17767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17767,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Right Eye/Adnexa Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17767,1,4,0)
 ;;=4^H59.321
 ;;^UTILITY(U,$J,358.3,17767,2)
 ;;=^5006421
 ;;^UTILITY(U,$J,358.3,17768,0)
 ;;=H59.322^^53^747^179
 ;;^UTILITY(U,$J,358.3,17768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17768,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Left Eye/Adnexa Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17768,1,4,0)
 ;;=4^H59.322
 ;;^UTILITY(U,$J,358.3,17768,2)
 ;;=^5006422
 ;;^UTILITY(U,$J,358.3,17769,0)
 ;;=H59.323^^53^747^167
 ;;^UTILITY(U,$J,358.3,17769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17769,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Bilateral Eye/Adnexa Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17769,1,4,0)
 ;;=4^H59.323
 ;;^UTILITY(U,$J,358.3,17769,2)
 ;;=^5006423
 ;;^UTILITY(U,$J,358.3,17770,0)
 ;;=H95.41^^53^747^174
 ;;^UTILITY(U,$J,358.3,17770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17770,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Ear/Mastoid Following Ear/Mastoid Procedure
 ;;^UTILITY(U,$J,358.3,17770,1,4,0)
 ;;=4^H95.41
 ;;^UTILITY(U,$J,358.3,17770,2)
 ;;=^5007030
 ;;^UTILITY(U,$J,358.3,17771,0)
 ;;=H95.42^^53^747^175
 ;;^UTILITY(U,$J,358.3,17771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17771,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Ear/Mastoid Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17771,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,17771,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,17772,0)
 ;;=I97.610^^53^747^168
 ;;^UTILITY(U,$J,358.3,17772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17772,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Circ Sys Following a Cardiac Cath
 ;;^UTILITY(U,$J,358.3,17772,1,4,0)
 ;;=4^I97.610
 ;;^UTILITY(U,$J,358.3,17772,2)
 ;;=^5008099
 ;;^UTILITY(U,$J,358.3,17773,0)
 ;;=I97.611^^53^747^169
 ;;^UTILITY(U,$J,358.3,17773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17773,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Circ Sys Following Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,17773,1,4,0)
 ;;=4^I97.611
 ;;^UTILITY(U,$J,358.3,17773,2)
 ;;=^5008100
 ;;^UTILITY(U,$J,358.3,17774,0)
 ;;=I97.618^^53^747^170
 ;;^UTILITY(U,$J,358.3,17774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17774,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Circ Sys Following Oth Circ Sys Procedure
 ;;^UTILITY(U,$J,358.3,17774,1,4,0)
 ;;=4^I97.618
 ;;^UTILITY(U,$J,358.3,17774,2)
 ;;=^5008101
 ;;^UTILITY(U,$J,358.3,17775,0)
 ;;=I97.62^^53^747^171
 ;;^UTILITY(U,$J,358.3,17775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17775,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Circ Sys Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17775,1,4,0)
 ;;=4^I97.62
 ;;^UTILITY(U,$J,358.3,17775,2)
 ;;=^5008102
 ;;^UTILITY(U,$J,358.3,17776,0)
 ;;=J95.830^^53^747^184
 ;;^UTILITY(U,$J,358.3,17776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17776,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Resp Sys Following Resp Sys Procedure
 ;;^UTILITY(U,$J,358.3,17776,1,4,0)
 ;;=4^J95.830
 ;;^UTILITY(U,$J,358.3,17776,2)
 ;;=^5008340
 ;;^UTILITY(U,$J,358.3,17777,0)
 ;;=J95.831^^53^747^185
 ;;^UTILITY(U,$J,358.3,17777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17777,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Resp Sys Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17777,1,4,0)
 ;;=4^J95.831
 ;;^UTILITY(U,$J,358.3,17777,2)
 ;;=^5008341
 ;;^UTILITY(U,$J,358.3,17778,0)
 ;;=K91.840^^53^747^172
 ;;^UTILITY(U,$J,358.3,17778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17778,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Digestive Sys Following Digestive Sys Procedure
 ;;^UTILITY(U,$J,358.3,17778,1,4,0)
 ;;=4^K91.840
 ;;^UTILITY(U,$J,358.3,17778,2)
 ;;=^5008910
 ;;^UTILITY(U,$J,358.3,17779,0)
 ;;=K91.841^^53^747^173
 ;;^UTILITY(U,$J,358.3,17779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17779,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Digestive Sys Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17779,1,4,0)
 ;;=4^K91.841
 ;;^UTILITY(U,$J,358.3,17779,2)
 ;;=^5008911
 ;;^UTILITY(U,$J,358.3,17780,0)
 ;;=L76.21^^53^747^188
 ;;^UTILITY(U,$J,358.3,17780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17780,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Skin Following Derm Procedure
 ;;^UTILITY(U,$J,358.3,17780,1,4,0)
 ;;=4^L76.21
 ;;^UTILITY(U,$J,358.3,17780,2)
 ;;=^5009306
 ;;^UTILITY(U,$J,358.3,17781,0)
 ;;=L76.22^^53^747^189
 ;;^UTILITY(U,$J,358.3,17781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17781,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Skin Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17781,1,4,0)
 ;;=4^L76.22
 ;;^UTILITY(U,$J,358.3,17781,2)
 ;;=^5009307
 ;;^UTILITY(U,$J,358.3,17782,0)
 ;;=M96.830^^53^747^180
 ;;^UTILITY(U,$J,358.3,17782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17782,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of MS Structutre Following MS Sys Procedure
 ;;^UTILITY(U,$J,358.3,17782,1,4,0)
 ;;=4^M96.830
 ;;^UTILITY(U,$J,358.3,17782,2)
 ;;=^5015397
 ;;^UTILITY(U,$J,358.3,17783,0)
 ;;=M96.831^^53^747^181
 ;;^UTILITY(U,$J,358.3,17783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17783,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of MS Structure Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17783,1,4,0)
 ;;=4^M96.831
 ;;^UTILITY(U,$J,358.3,17783,2)
 ;;=^5015398
 ;;^UTILITY(U,$J,358.3,17784,0)
 ;;=N99.820^^53^747^176
 ;;^UTILITY(U,$J,358.3,17784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17784,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of GU Sys Following a GU Sys Procedure
 ;;^UTILITY(U,$J,358.3,17784,1,4,0)
 ;;=4^N99.820
 ;;^UTILITY(U,$J,358.3,17784,2)
 ;;=^5015968
 ;;^UTILITY(U,$J,358.3,17785,0)
 ;;=N99.821^^53^747^177
 ;;^UTILITY(U,$J,358.3,17785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17785,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of GU Sys Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,17785,1,4,0)
 ;;=4^N99.821
 ;;^UTILITY(U,$J,358.3,17785,2)
 ;;=^5015969
 ;;^UTILITY(U,$J,358.3,17786,0)
 ;;=T88.8XXA^^53^747^31
 ;;^UTILITY(U,$J,358.3,17786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17786,1,3,0)
 ;;=3^Complications of Surgical/Medical Care NEC,Init Encntr
