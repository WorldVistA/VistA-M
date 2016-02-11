IBDEI05O ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2031,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2031,1,2,0)
 ;;=2^93306
 ;;^UTILITY(U,$J,358.3,2031,1,3,0)
 ;;=3^Echo,TT,2D,M Mode w/ Color Doppler
 ;;^UTILITY(U,$J,358.3,2032,0)
 ;;=93321^^17^180^4^^^^1
 ;;^UTILITY(U,$J,358.3,2032,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2032,1,2,0)
 ;;=2^93321
 ;;^UTILITY(U,$J,358.3,2032,1,3,0)
 ;;=3^Doppler Echo, Heart
 ;;^UTILITY(U,$J,358.3,2033,0)
 ;;=93351^^17^180^20^^^^1
 ;;^UTILITY(U,$J,358.3,2033,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2033,1,2,0)
 ;;=2^93351
 ;;^UTILITY(U,$J,358.3,2033,1,3,0)
 ;;=3^Stress TTE Complete
 ;;^UTILITY(U,$J,358.3,2034,0)
 ;;=93352^^17^180^1^^^^1
 ;;^UTILITY(U,$J,358.3,2034,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2034,1,2,0)
 ;;=2^93352
 ;;^UTILITY(U,$J,358.3,2034,1,3,0)
 ;;=3^Admin ECG Contrast Agent
 ;;^UTILITY(U,$J,358.3,2035,0)
 ;;=93312^^17^180^11^^^^1
 ;;^UTILITY(U,$J,358.3,2035,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2035,1,2,0)
 ;;=2^93312
 ;;^UTILITY(U,$J,358.3,2035,1,3,0)
 ;;=3^Echo Transesophageal w/wo M-mode record
 ;;^UTILITY(U,$J,358.3,2036,0)
 ;;=93313^^17^180^10^^^^1
 ;;^UTILITY(U,$J,358.3,2036,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2036,1,2,0)
 ;;=2^93313
 ;;^UTILITY(U,$J,358.3,2036,1,3,0)
 ;;=3^Echo Transesophageal w/ placement of probe
 ;;^UTILITY(U,$J,358.3,2037,0)
 ;;=93314^^17^180^9^^^^1
 ;;^UTILITY(U,$J,358.3,2037,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2037,1,2,0)
 ;;=2^93314
 ;;^UTILITY(U,$J,358.3,2037,1,3,0)
 ;;=3^Echo Transesophageal image interp and rpt
 ;;^UTILITY(U,$J,358.3,2038,0)
 ;;=93318^^17^180^18^^^^1
 ;;^UTILITY(U,$J,358.3,2038,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2038,1,2,0)
 ;;=2^93318
 ;;^UTILITY(U,$J,358.3,2038,1,3,0)
 ;;=3^Echo,Transesophageal Intraop
 ;;^UTILITY(U,$J,358.3,2039,0)
 ;;=93315^^17^180^12^^^^1
 ;;^UTILITY(U,$J,358.3,2039,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2039,1,2,0)
 ;;=2^93315
 ;;^UTILITY(U,$J,358.3,2039,1,3,0)
 ;;=3^Echo Transesophageal,Complete
 ;;^UTILITY(U,$J,358.3,2040,0)
 ;;=93316^^17^180^7^^^^1
 ;;^UTILITY(U,$J,358.3,2040,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2040,1,2,0)
 ;;=2^93316
 ;;^UTILITY(U,$J,358.3,2040,1,3,0)
 ;;=3^Echo Tranesophageal Placement Only
 ;;^UTILITY(U,$J,358.3,2041,0)
 ;;=93317^^17^180^6^^^^1
 ;;^UTILITY(U,$J,358.3,2041,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2041,1,2,0)
 ;;=2^93317
 ;;^UTILITY(U,$J,358.3,2041,1,3,0)
 ;;=3^Echo Image,Inerpretation and Report Only
 ;;^UTILITY(U,$J,358.3,2042,0)
 ;;=93318^^17^180^8^^^^1
 ;;^UTILITY(U,$J,358.3,2042,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2042,1,2,0)
 ;;=2^93318
 ;;^UTILITY(U,$J,358.3,2042,1,3,0)
 ;;=3^Echo Transesophageal Intraop
 ;;^UTILITY(U,$J,358.3,2043,0)
 ;;=93303^^17^180^19^^^^1
 ;;^UTILITY(U,$J,358.3,2043,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2043,1,2,0)
 ;;=2^93303
 ;;^UTILITY(U,$J,358.3,2043,1,3,0)
 ;;=3^Ecoh Transthoracic,Complete
 ;;^UTILITY(U,$J,358.3,2044,0)
 ;;=93304^^17^180^15^^^^1
 ;;^UTILITY(U,$J,358.3,2044,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2044,1,2,0)
 ;;=2^93304
 ;;^UTILITY(U,$J,358.3,2044,1,3,0)
 ;;=3^Echo Transthroacic F/U
 ;;^UTILITY(U,$J,358.3,2045,0)
 ;;=93308^^17^180^13^^^^1
 ;;^UTILITY(U,$J,358.3,2045,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2045,1,2,0)
 ;;=2^93308
 ;;^UTILITY(U,$J,358.3,2045,1,3,0)
 ;;=3^Echo Transthoracic,2D Image,Limited
 ;;^UTILITY(U,$J,358.3,2046,0)
 ;;=93000^^17^181^9
 ;;^UTILITY(U,$J,358.3,2046,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2046,1,2,0)
 ;;=2^93000
 ;;^UTILITY(U,$J,358.3,2046,1,3,0)
 ;;=3^EKG 12 Lead W/ Interp & Report
