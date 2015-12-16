IBDEI03E ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1052,0)
 ;;=K20.9^^3^37^45
 ;;^UTILITY(U,$J,358.3,1052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1052,1,3,0)
 ;;=3^Esophagitis, unspecified
 ;;^UTILITY(U,$J,358.3,1052,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,1052,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,1053,0)
 ;;=K21.0^^3^37^54
 ;;^UTILITY(U,$J,358.3,1053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1053,1,3,0)
 ;;=3^Gastro-esophageal reflux disease with esophagitis
 ;;^UTILITY(U,$J,358.3,1053,1,4,0)
 ;;=4^K21.0
 ;;^UTILITY(U,$J,358.3,1053,2)
 ;;=^5008504
 ;;^UTILITY(U,$J,358.3,1054,0)
 ;;=K22.10^^3^37^97
 ;;^UTILITY(U,$J,358.3,1054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1054,1,3,0)
 ;;=3^Ulcer of esophagus without bleeding
 ;;^UTILITY(U,$J,358.3,1054,1,4,0)
 ;;=4^K22.10
 ;;^UTILITY(U,$J,358.3,1054,2)
 ;;=^329929
 ;;^UTILITY(U,$J,358.3,1055,0)
 ;;=K22.11^^3^37^96
 ;;^UTILITY(U,$J,358.3,1055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1055,1,3,0)
 ;;=3^Ulcer of esophagus with bleeding
 ;;^UTILITY(U,$J,358.3,1055,1,4,0)
 ;;=4^K22.11
 ;;^UTILITY(U,$J,358.3,1055,2)
 ;;=^329930
 ;;^UTILITY(U,$J,358.3,1056,0)
 ;;=K21.9^^3^37^55
 ;;^UTILITY(U,$J,358.3,1056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1056,1,3,0)
 ;;=3^Gastro-esophageal reflux disease without esophagitis
 ;;^UTILITY(U,$J,358.3,1056,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,1056,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,1057,0)
 ;;=K22.70^^3^37^14
 ;;^UTILITY(U,$J,358.3,1057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1057,1,3,0)
 ;;=3^Barrett's esophagus without dysplasia
 ;;^UTILITY(U,$J,358.3,1057,1,4,0)
 ;;=4^K22.70
 ;;^UTILITY(U,$J,358.3,1057,2)
 ;;=^5008511
 ;;^UTILITY(U,$J,358.3,1058,0)
 ;;=K22.710^^3^37^13
 ;;^UTILITY(U,$J,358.3,1058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1058,1,3,0)
 ;;=3^Barrett's esophagus with low grade dysplasia
 ;;^UTILITY(U,$J,358.3,1058,1,4,0)
 ;;=4^K22.710
 ;;^UTILITY(U,$J,358.3,1058,2)
 ;;=^5008512
 ;;^UTILITY(U,$J,358.3,1059,0)
 ;;=K22.711^^3^37^12
 ;;^UTILITY(U,$J,358.3,1059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1059,1,3,0)
 ;;=3^Barrett's esophagus with high grade dysplasia
 ;;^UTILITY(U,$J,358.3,1059,1,4,0)
 ;;=4^K22.711
 ;;^UTILITY(U,$J,358.3,1059,2)
 ;;=^5008513
 ;;^UTILITY(U,$J,358.3,1060,0)
 ;;=K22.719^^3^37^11
 ;;^UTILITY(U,$J,358.3,1060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1060,1,3,0)
 ;;=3^Barrett's esophagus with dysplasia, unspecified
 ;;^UTILITY(U,$J,358.3,1060,1,4,0)
 ;;=4^K22.719
 ;;^UTILITY(U,$J,358.3,1060,2)
 ;;=^5008514
 ;;^UTILITY(U,$J,358.3,1061,0)
 ;;=K25.7^^3^37^22
 ;;^UTILITY(U,$J,358.3,1061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1061,1,3,0)
 ;;=3^Chronic gastric ulcer without hemorrhage or perforation
 ;;^UTILITY(U,$J,358.3,1061,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,1061,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,1062,0)
 ;;=K25.9^^3^37^52
 ;;^UTILITY(U,$J,358.3,1062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1062,1,3,0)
 ;;=3^Gastric ulcer, unsp as acute or chronic, w/o hemor or perf
 ;;^UTILITY(U,$J,358.3,1062,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,1062,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,1063,0)
 ;;=K26.9^^3^37^36
 ;;^UTILITY(U,$J,358.3,1063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1063,1,3,0)
 ;;=3^Duodenal ulcer, unsp as acute or chronic, w/o hemor or perf
 ;;^UTILITY(U,$J,358.3,1063,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,1063,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,1064,0)
 ;;=K27.9^^3^37^78
 ;;^UTILITY(U,$J,358.3,1064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1064,1,3,0)
 ;;=3^Peptic ulc, site unsp, unsp as ac or chr, w/o hemor or perf
 ;;^UTILITY(U,$J,358.3,1064,1,4,0)
 ;;=4^K27.9
