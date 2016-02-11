IBDEI32C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51352,0)
 ;;=M75.01^^222^2476^4
 ;;^UTILITY(U,$J,358.3,51352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51352,1,3,0)
 ;;=3^Adhesive capsulitis of rt shoulder
 ;;^UTILITY(U,$J,358.3,51352,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,51352,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,51353,0)
 ;;=M75.02^^222^2476^3
 ;;^UTILITY(U,$J,358.3,51353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51353,1,3,0)
 ;;=3^Adhesive capsulitis of lft shoulder
 ;;^UTILITY(U,$J,358.3,51353,1,4,0)
 ;;=4^M75.02
 ;;^UTILITY(U,$J,358.3,51353,2)
 ;;=^5013240
 ;;^UTILITY(U,$J,358.3,51354,0)
 ;;=M75.51^^222^2476^12
 ;;^UTILITY(U,$J,358.3,51354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51354,1,3,0)
 ;;=3^Bursitis of rt shoulder
 ;;^UTILITY(U,$J,358.3,51354,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,51354,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,51355,0)
 ;;=M75.52^^222^2476^11
 ;;^UTILITY(U,$J,358.3,51355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51355,1,3,0)
 ;;=3^Bursitis of lft shoulder
 ;;^UTILITY(U,$J,358.3,51355,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,51355,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,51356,0)
 ;;=M75.101^^222^2476^42
 ;;^UTILITY(U,$J,358.3,51356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51356,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of rt shldr, not trauma, unspec
 ;;^UTILITY(U,$J,358.3,51356,1,4,0)
 ;;=4^M75.101
 ;;^UTILITY(U,$J,358.3,51356,2)
 ;;=^5013242
 ;;^UTILITY(U,$J,358.3,51357,0)
 ;;=M75.102^^222^2476^41
 ;;^UTILITY(U,$J,358.3,51357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51357,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of lft shldr, not trauma, unspec
 ;;^UTILITY(U,$J,358.3,51357,1,4,0)
 ;;=4^M75.102
 ;;^UTILITY(U,$J,358.3,51357,2)
 ;;=^5013243
 ;;^UTILITY(U,$J,358.3,51358,0)
 ;;=M75.31^^222^2476^15
 ;;^UTILITY(U,$J,358.3,51358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51358,1,3,0)
 ;;=3^Calcific tendinitis of rt shoulder
 ;;^UTILITY(U,$J,358.3,51358,1,4,0)
 ;;=4^M75.31
 ;;^UTILITY(U,$J,358.3,51358,2)
 ;;=^5013254
 ;;^UTILITY(U,$J,358.3,51359,0)
 ;;=M75.32^^222^2476^14
 ;;^UTILITY(U,$J,358.3,51359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51359,1,3,0)
 ;;=3^Calcific tendinitis of lft shoulder
 ;;^UTILITY(U,$J,358.3,51359,1,4,0)
 ;;=4^M75.32
 ;;^UTILITY(U,$J,358.3,51359,2)
 ;;=^5013255
 ;;^UTILITY(U,$J,358.3,51360,0)
 ;;=M75.21^^222^2476^6
 ;;^UTILITY(U,$J,358.3,51360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51360,1,3,0)
 ;;=3^Bicipital tendinitis, rt shoulder
 ;;^UTILITY(U,$J,358.3,51360,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,51360,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,51361,0)
 ;;=M75.22^^222^2476^5
 ;;^UTILITY(U,$J,358.3,51361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51361,1,3,0)
 ;;=3^Bicipital tendinitis, lft shoulder
 ;;^UTILITY(U,$J,358.3,51361,1,4,0)
 ;;=4^M75.22
 ;;^UTILITY(U,$J,358.3,51361,2)
 ;;=^5013252
 ;;^UTILITY(U,$J,358.3,51362,0)
 ;;=M75.81^^222^2476^44
 ;;^UTILITY(U,$J,358.3,51362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51362,1,3,0)
 ;;=3^Shoulder lesions, rt shoulder
 ;;^UTILITY(U,$J,358.3,51362,1,4,0)
 ;;=4^M75.81
 ;;^UTILITY(U,$J,358.3,51362,2)
 ;;=^5013261
 ;;^UTILITY(U,$J,358.3,51363,0)
 ;;=M75.82^^222^2476^43
 ;;^UTILITY(U,$J,358.3,51363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51363,1,3,0)
 ;;=3^Shoulder lesions, lft shoulder
 ;;^UTILITY(U,$J,358.3,51363,1,4,0)
 ;;=4^M75.82
 ;;^UTILITY(U,$J,358.3,51363,2)
 ;;=^5013262
 ;;^UTILITY(U,$J,358.3,51364,0)
 ;;=M77.01^^222^2476^27
 ;;^UTILITY(U,$J,358.3,51364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51364,1,3,0)
 ;;=3^Medial epicondylitis, rt elbow
 ;;^UTILITY(U,$J,358.3,51364,1,4,0)
 ;;=4^M77.01
