IBDEI0MF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10240,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Unspec Stage
 ;;^UTILITY(U,$J,358.3,10240,1,4,0)
 ;;=4^L89.90
 ;;^UTILITY(U,$J,358.3,10240,2)
 ;;=^5133666
 ;;^UTILITY(U,$J,358.3,10241,0)
 ;;=L89.91^^68^664^243
 ;;^UTILITY(U,$J,358.3,10241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10241,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 1
 ;;^UTILITY(U,$J,358.3,10241,1,4,0)
 ;;=4^L89.91
 ;;^UTILITY(U,$J,358.3,10241,2)
 ;;=^5133664
 ;;^UTILITY(U,$J,358.3,10242,0)
 ;;=L89.92^^68^664^244
 ;;^UTILITY(U,$J,358.3,10242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10242,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 2
 ;;^UTILITY(U,$J,358.3,10242,1,4,0)
 ;;=4^L89.92
 ;;^UTILITY(U,$J,358.3,10242,2)
 ;;=^5133667
 ;;^UTILITY(U,$J,358.3,10243,0)
 ;;=L89.93^^68^664^245
 ;;^UTILITY(U,$J,358.3,10243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10243,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 3
 ;;^UTILITY(U,$J,358.3,10243,1,4,0)
 ;;=4^L89.93
 ;;^UTILITY(U,$J,358.3,10243,2)
 ;;=^5133668
 ;;^UTILITY(U,$J,358.3,10244,0)
 ;;=L89.94^^68^664^246
 ;;^UTILITY(U,$J,358.3,10244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10244,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 4
 ;;^UTILITY(U,$J,358.3,10244,1,4,0)
 ;;=4^L89.94
 ;;^UTILITY(U,$J,358.3,10244,2)
 ;;=^5133669
 ;;^UTILITY(U,$J,358.3,10245,0)
 ;;=L89.95^^68^664^248
 ;;^UTILITY(U,$J,358.3,10245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10245,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Unstageable
 ;;^UTILITY(U,$J,358.3,10245,1,4,0)
 ;;=4^L89.95
 ;;^UTILITY(U,$J,358.3,10245,2)
 ;;=^5133660
 ;;^UTILITY(U,$J,358.3,10246,0)
 ;;=L92.0^^68^664^156
 ;;^UTILITY(U,$J,358.3,10246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10246,1,3,0)
 ;;=3^Granuloma Annulare
 ;;^UTILITY(U,$J,358.3,10246,1,4,0)
 ;;=4^L92.0
 ;;^UTILITY(U,$J,358.3,10246,2)
 ;;=^184052
 ;;^UTILITY(U,$J,358.3,10247,0)
 ;;=L95.1^^68^664^143
 ;;^UTILITY(U,$J,358.3,10247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10247,1,3,0)
 ;;=3^Erythema Elevatum Diutinum
 ;;^UTILITY(U,$J,358.3,10247,1,4,0)
 ;;=4^L95.1
 ;;^UTILITY(U,$J,358.3,10247,2)
 ;;=^5009477
 ;;^UTILITY(U,$J,358.3,10248,0)
 ;;=L97.111^^68^664^226
 ;;^UTILITY(U,$J,358.3,10248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10248,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,10248,1,4,0)
 ;;=4^L97.111
 ;;^UTILITY(U,$J,358.3,10248,2)
 ;;=^5009485
 ;;^UTILITY(U,$J,358.3,10249,0)
 ;;=L97.112^^68^664^227
 ;;^UTILITY(U,$J,358.3,10249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10249,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,10249,1,4,0)
 ;;=4^L97.112
 ;;^UTILITY(U,$J,358.3,10249,2)
 ;;=^5009486
 ;;^UTILITY(U,$J,358.3,10250,0)
 ;;=L97.113^^68^664^228
 ;;^UTILITY(U,$J,358.3,10250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10250,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,10250,1,4,0)
 ;;=4^L97.113
 ;;^UTILITY(U,$J,358.3,10250,2)
 ;;=^5009487
 ;;^UTILITY(U,$J,358.3,10251,0)
 ;;=L97.114^^68^664^229
 ;;^UTILITY(U,$J,358.3,10251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10251,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,10251,1,4,0)
 ;;=4^L97.114
 ;;^UTILITY(U,$J,358.3,10251,2)
 ;;=^5009488
 ;;^UTILITY(U,$J,358.3,10252,0)
 ;;=L97.119^^68^664^230
 ;;^UTILITY(U,$J,358.3,10252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10252,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,10252,1,4,0)
 ;;=4^L97.119
