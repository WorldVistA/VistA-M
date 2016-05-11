IBDEI249 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35892,1,3,0)
 ;;=3^Rheumatoid Nodule Unspec Site
 ;;^UTILITY(U,$J,358.3,35892,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,35892,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,35893,0)
 ;;=M06.38^^134^1731^139
 ;;^UTILITY(U,$J,358.3,35893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35893,1,3,0)
 ;;=3^Rheumatoid Nodule Vertebrae
 ;;^UTILITY(U,$J,358.3,35893,1,4,0)
 ;;=4^M06.38
 ;;^UTILITY(U,$J,358.3,35893,2)
 ;;=^5010118
 ;;^UTILITY(U,$J,358.3,35894,0)
 ;;=M05.572^^134^1731^74
 ;;^UTILITY(U,$J,358.3,35894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35894,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Left Ankle/Foot
 ;;^UTILITY(U,$J,358.3,35894,1,4,0)
 ;;=4^M05.572
 ;;^UTILITY(U,$J,358.3,35894,2)
 ;;=^5009974
 ;;^UTILITY(U,$J,358.3,35895,0)
 ;;=M05.522^^134^1731^75
 ;;^UTILITY(U,$J,358.3,35895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35895,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Left Elbow
 ;;^UTILITY(U,$J,358.3,35895,1,4,0)
 ;;=4^M05.522
 ;;^UTILITY(U,$J,358.3,35895,2)
 ;;=^5009959
 ;;^UTILITY(U,$J,358.3,35896,0)
 ;;=M05.542^^134^1731^76
 ;;^UTILITY(U,$J,358.3,35896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35896,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Left Hand
 ;;^UTILITY(U,$J,358.3,35896,1,4,0)
 ;;=4^M05.542
 ;;^UTILITY(U,$J,358.3,35896,2)
 ;;=^5009965
 ;;^UTILITY(U,$J,358.3,35897,0)
 ;;=M05.552^^134^1731^77
 ;;^UTILITY(U,$J,358.3,35897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35897,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Left Hip
 ;;^UTILITY(U,$J,358.3,35897,1,4,0)
 ;;=4^M05.552
 ;;^UTILITY(U,$J,358.3,35897,2)
 ;;=^5009968
 ;;^UTILITY(U,$J,358.3,35898,0)
 ;;=M05.562^^134^1731^78
 ;;^UTILITY(U,$J,358.3,35898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35898,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Left Knee
 ;;^UTILITY(U,$J,358.3,35898,1,4,0)
 ;;=4^M05.562
 ;;^UTILITY(U,$J,358.3,35898,2)
 ;;=^5009971
 ;;^UTILITY(U,$J,358.3,35899,0)
 ;;=M05.512^^134^1731^79
 ;;^UTILITY(U,$J,358.3,35899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35899,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Left Shoulder
 ;;^UTILITY(U,$J,358.3,35899,1,4,0)
 ;;=4^M05.512
 ;;^UTILITY(U,$J,358.3,35899,2)
 ;;=^5009956
 ;;^UTILITY(U,$J,358.3,35900,0)
 ;;=M05.532^^134^1731^80
 ;;^UTILITY(U,$J,358.3,35900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35900,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Left Wrist
 ;;^UTILITY(U,$J,358.3,35900,1,4,0)
 ;;=4^M05.532
 ;;^UTILITY(U,$J,358.3,35900,2)
 ;;=^5009962
 ;;^UTILITY(U,$J,358.3,35901,0)
 ;;=M05.59^^134^1731^81
 ;;^UTILITY(U,$J,358.3,35901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35901,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Mult Sites
 ;;^UTILITY(U,$J,358.3,35901,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,35901,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,35902,0)
 ;;=M05.571^^134^1731^82
 ;;^UTILITY(U,$J,358.3,35902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35902,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Right Ankle/Foot
 ;;^UTILITY(U,$J,358.3,35902,1,4,0)
 ;;=4^M05.571
 ;;^UTILITY(U,$J,358.3,35902,2)
 ;;=^5009973
 ;;^UTILITY(U,$J,358.3,35903,0)
 ;;=M05.521^^134^1731^83
 ;;^UTILITY(U,$J,358.3,35903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35903,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Right Elbow
 ;;^UTILITY(U,$J,358.3,35903,1,4,0)
 ;;=4^M05.521
 ;;^UTILITY(U,$J,358.3,35903,2)
 ;;=^5009958
 ;;^UTILITY(U,$J,358.3,35904,0)
 ;;=M05.541^^134^1731^84
 ;;^UTILITY(U,$J,358.3,35904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35904,1,3,0)
 ;;=3^Rheum Polyneuropathy w/ Rheum Arth Right Hand
