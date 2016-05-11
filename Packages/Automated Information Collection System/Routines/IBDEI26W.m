IBDEI26W ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37145,1,4,0)
 ;;=4^M48.38
 ;;^UTILITY(U,$J,358.3,37145,2)
 ;;=^5012122
 ;;^UTILITY(U,$J,358.3,37146,0)
 ;;=M48.9^^140^1787^255
 ;;^UTILITY(U,$J,358.3,37146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37146,1,3,0)
 ;;=3^Spondylopathy, unspec
 ;;^UTILITY(U,$J,358.3,37146,1,4,0)
 ;;=4^M48.9
 ;;^UTILITY(U,$J,358.3,37146,2)
 ;;=^5012204
 ;;^UTILITY(U,$J,358.3,37147,0)
 ;;=M47.819^^140^1787^244
 ;;^UTILITY(U,$J,358.3,37147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37147,1,3,0)
 ;;=3^Spndylsis w/o mylopthy or radclpthy, site unsp
 ;;^UTILITY(U,$J,358.3,37147,1,4,0)
 ;;=4^M47.819
 ;;^UTILITY(U,$J,358.3,37147,2)
 ;;=^5012076
 ;;^UTILITY(U,$J,358.3,37148,0)
 ;;=M47.10^^140^1787^241
 ;;^UTILITY(U,$J,358.3,37148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37148,1,3,0)
 ;;=3^Spndylsis w/ mylopthy, unspec site
 ;;^UTILITY(U,$J,358.3,37148,1,4,0)
 ;;=4^M47.10
 ;;^UTILITY(U,$J,358.3,37148,2)
 ;;=^5012050
 ;;^UTILITY(U,$J,358.3,37149,0)
 ;;=M75.01^^140^1787^36
 ;;^UTILITY(U,$J,358.3,37149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37149,1,3,0)
 ;;=3^Adhesive capsulitis, rt shoulder
 ;;^UTILITY(U,$J,358.3,37149,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,37149,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,37150,0)
 ;;=M75.02^^140^1787^35
 ;;^UTILITY(U,$J,358.3,37150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37150,1,3,0)
 ;;=3^Adhesive capsulitis, lft shoulder
 ;;^UTILITY(U,$J,358.3,37150,1,4,0)
 ;;=4^M75.02
 ;;^UTILITY(U,$J,358.3,37150,2)
 ;;=^5013240
 ;;^UTILITY(U,$J,358.3,37151,0)
 ;;=M75.101^^140^1787^217
 ;;^UTILITY(U,$J,358.3,37151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37151,1,3,0)
 ;;=3^Rotatr-cuff tear/rptr of rt shldr, not trauma, unsp
 ;;^UTILITY(U,$J,358.3,37151,1,4,0)
 ;;=4^M75.101
 ;;^UTILITY(U,$J,358.3,37151,2)
 ;;=^5013242
 ;;^UTILITY(U,$J,358.3,37152,0)
 ;;=M75.102^^140^1787^216
 ;;^UTILITY(U,$J,358.3,37152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37152,1,3,0)
 ;;=3^Rotatr-cuff tear/rptr of lft shldr, not trauma, unsp
 ;;^UTILITY(U,$J,358.3,37152,1,4,0)
 ;;=4^M75.102
 ;;^UTILITY(U,$J,358.3,37152,2)
 ;;=^5013243
 ;;^UTILITY(U,$J,358.3,37153,0)
 ;;=M75.51^^140^1787^70
 ;;^UTILITY(U,$J,358.3,37153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37153,1,3,0)
 ;;=3^Bursitis, rt shoulder
 ;;^UTILITY(U,$J,358.3,37153,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,37153,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,37154,0)
 ;;=M75.52^^140^1787^68
 ;;^UTILITY(U,$J,358.3,37154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37154,1,3,0)
 ;;=3^Bursitis, lft shoulder
 ;;^UTILITY(U,$J,358.3,37154,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,37154,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,37155,0)
 ;;=M75.31^^140^1787^91
 ;;^UTILITY(U,$J,358.3,37155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37155,1,3,0)
 ;;=3^Calcific tendinitis, rt shoulder
 ;;^UTILITY(U,$J,358.3,37155,1,4,0)
 ;;=4^M75.31
 ;;^UTILITY(U,$J,358.3,37155,2)
 ;;=^5013254
 ;;^UTILITY(U,$J,358.3,37156,0)
 ;;=M75.32^^140^1787^90
 ;;^UTILITY(U,$J,358.3,37156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37156,1,3,0)
 ;;=3^Calcific tendinitis, lft shoulder
 ;;^UTILITY(U,$J,358.3,37156,1,4,0)
 ;;=4^M75.32
 ;;^UTILITY(U,$J,358.3,37156,2)
 ;;=^5013255
 ;;^UTILITY(U,$J,358.3,37157,0)
 ;;=M75.21^^140^1787^64
 ;;^UTILITY(U,$J,358.3,37157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37157,1,3,0)
 ;;=3^Bicipital tendinitis, rt shoulder
 ;;^UTILITY(U,$J,358.3,37157,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,37157,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,37158,0)
 ;;=M75.22^^140^1787^63
 ;;^UTILITY(U,$J,358.3,37158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37158,1,3,0)
 ;;=3^Bicipital tendinitis, lft shoulder
