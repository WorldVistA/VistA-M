IBDEI1FU ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23002,1,4,0)
 ;;=4^N99.61
 ;;^UTILITY(U,$J,358.3,23002,2)
 ;;=^5015963
 ;;^UTILITY(U,$J,358.3,23003,0)
 ;;=N99.62^^105^1166^121
 ;;^UTILITY(U,$J,358.3,23003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23003,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of GU Sys Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,23003,1,4,0)
 ;;=4^N99.62
 ;;^UTILITY(U,$J,358.3,23003,2)
 ;;=^5015964
 ;;^UTILITY(U,$J,358.3,23004,0)
 ;;=G97.51^^105^1166^200
 ;;^UTILITY(U,$J,358.3,23004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23004,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Nerv Sys After Nerv Sys Proc
 ;;^UTILITY(U,$J,358.3,23004,1,4,0)
 ;;=4^G97.51
 ;;^UTILITY(U,$J,358.3,23004,2)
 ;;=^5004209
 ;;^UTILITY(U,$J,358.3,23005,0)
 ;;=G97.52^^105^1166^201
 ;;^UTILITY(U,$J,358.3,23005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23005,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Nerv Sys After Oth Proc
 ;;^UTILITY(U,$J,358.3,23005,1,4,0)
 ;;=4^G97.52
 ;;^UTILITY(U,$J,358.3,23005,2)
 ;;=^5004210
 ;;^UTILITY(U,$J,358.3,23006,0)
 ;;=H59.311^^105^1166^204
 ;;^UTILITY(U,$J,358.3,23006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23006,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Rt Eye/Adnexa After Ophth Proc
 ;;^UTILITY(U,$J,358.3,23006,1,4,0)
 ;;=4^H59.311
 ;;^UTILITY(U,$J,358.3,23006,2)
 ;;=^5006417
 ;;^UTILITY(U,$J,358.3,23007,0)
 ;;=H59.312^^105^1166^196
 ;;^UTILITY(U,$J,358.3,23007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23007,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Lt Eye/Adnexa After Ophth Proc
 ;;^UTILITY(U,$J,358.3,23007,1,4,0)
 ;;=4^H59.312
 ;;^UTILITY(U,$J,358.3,23007,2)
 ;;=^5006418
 ;;^UTILITY(U,$J,358.3,23008,0)
 ;;=H59.313^^105^1166^186
 ;;^UTILITY(U,$J,358.3,23008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23008,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Bil Eyes/Adnexa After Ophth Proc
 ;;^UTILITY(U,$J,358.3,23008,1,4,0)
 ;;=4^H59.313
 ;;^UTILITY(U,$J,358.3,23008,2)
 ;;=^5006419
 ;;^UTILITY(U,$J,358.3,23009,0)
 ;;=H59.321^^105^1166^205
 ;;^UTILITY(U,$J,358.3,23009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23009,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Rt Eye/Adnexa After Oth Proc
 ;;^UTILITY(U,$J,358.3,23009,1,4,0)
 ;;=4^H59.321
 ;;^UTILITY(U,$J,358.3,23009,2)
 ;;=^5006421
 ;;^UTILITY(U,$J,358.3,23010,0)
 ;;=H59.322^^105^1166^197
 ;;^UTILITY(U,$J,358.3,23010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23010,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Lt Eye/Adnexa After Oth Proc
 ;;^UTILITY(U,$J,358.3,23010,1,4,0)
 ;;=4^H59.322
 ;;^UTILITY(U,$J,358.3,23010,2)
 ;;=^5006422
 ;;^UTILITY(U,$J,358.3,23011,0)
 ;;=H95.41^^105^1166^192
 ;;^UTILITY(U,$J,358.3,23011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23011,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Ear/Mastoid After Ear/Mastoid Proc
 ;;^UTILITY(U,$J,358.3,23011,1,4,0)
 ;;=4^H95.41
 ;;^UTILITY(U,$J,358.3,23011,2)
 ;;=^5007030
 ;;^UTILITY(U,$J,358.3,23012,0)
 ;;=H95.42^^105^1166^193
 ;;^UTILITY(U,$J,358.3,23012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23012,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Ear/Mastoid After Oth Proc
 ;;^UTILITY(U,$J,358.3,23012,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,23012,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,23013,0)
 ;;=I97.610^^105^1166^187
 ;;^UTILITY(U,$J,358.3,23013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23013,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Circ Sys After Cardiac Cath
 ;;^UTILITY(U,$J,358.3,23013,1,4,0)
 ;;=4^I97.610
 ;;^UTILITY(U,$J,358.3,23013,2)
 ;;=^5008099
