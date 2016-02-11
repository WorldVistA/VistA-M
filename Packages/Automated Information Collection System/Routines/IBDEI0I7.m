IBDEI0I7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8166,1,3,0)
 ;;=3^Esophagitis, unspecified
 ;;^UTILITY(U,$J,358.3,8166,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,8166,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,8167,0)
 ;;=K21.0^^55^536^54
 ;;^UTILITY(U,$J,358.3,8167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8167,1,3,0)
 ;;=3^Gastro-esophageal reflux disease with esophagitis
 ;;^UTILITY(U,$J,358.3,8167,1,4,0)
 ;;=4^K21.0
 ;;^UTILITY(U,$J,358.3,8167,2)
 ;;=^5008504
 ;;^UTILITY(U,$J,358.3,8168,0)
 ;;=K22.10^^55^536^97
 ;;^UTILITY(U,$J,358.3,8168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8168,1,3,0)
 ;;=3^Ulcer of esophagus without bleeding
 ;;^UTILITY(U,$J,358.3,8168,1,4,0)
 ;;=4^K22.10
 ;;^UTILITY(U,$J,358.3,8168,2)
 ;;=^329929
 ;;^UTILITY(U,$J,358.3,8169,0)
 ;;=K22.11^^55^536^96
 ;;^UTILITY(U,$J,358.3,8169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8169,1,3,0)
 ;;=3^Ulcer of esophagus with bleeding
 ;;^UTILITY(U,$J,358.3,8169,1,4,0)
 ;;=4^K22.11
 ;;^UTILITY(U,$J,358.3,8169,2)
 ;;=^329930
 ;;^UTILITY(U,$J,358.3,8170,0)
 ;;=K21.9^^55^536^55
 ;;^UTILITY(U,$J,358.3,8170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8170,1,3,0)
 ;;=3^Gastro-esophageal reflux disease without esophagitis
 ;;^UTILITY(U,$J,358.3,8170,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,8170,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,8171,0)
 ;;=K22.70^^55^536^14
 ;;^UTILITY(U,$J,358.3,8171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8171,1,3,0)
 ;;=3^Barrett's esophagus without dysplasia
 ;;^UTILITY(U,$J,358.3,8171,1,4,0)
 ;;=4^K22.70
 ;;^UTILITY(U,$J,358.3,8171,2)
 ;;=^5008511
 ;;^UTILITY(U,$J,358.3,8172,0)
 ;;=K22.710^^55^536^13
 ;;^UTILITY(U,$J,358.3,8172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8172,1,3,0)
 ;;=3^Barrett's esophagus with low grade dysplasia
 ;;^UTILITY(U,$J,358.3,8172,1,4,0)
 ;;=4^K22.710
 ;;^UTILITY(U,$J,358.3,8172,2)
 ;;=^5008512
 ;;^UTILITY(U,$J,358.3,8173,0)
 ;;=K22.711^^55^536^12
 ;;^UTILITY(U,$J,358.3,8173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8173,1,3,0)
 ;;=3^Barrett's esophagus with high grade dysplasia
 ;;^UTILITY(U,$J,358.3,8173,1,4,0)
 ;;=4^K22.711
 ;;^UTILITY(U,$J,358.3,8173,2)
 ;;=^5008513
 ;;^UTILITY(U,$J,358.3,8174,0)
 ;;=K22.719^^55^536^11
 ;;^UTILITY(U,$J,358.3,8174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8174,1,3,0)
 ;;=3^Barrett's esophagus with dysplasia, unspecified
 ;;^UTILITY(U,$J,358.3,8174,1,4,0)
 ;;=4^K22.719
 ;;^UTILITY(U,$J,358.3,8174,2)
 ;;=^5008514
 ;;^UTILITY(U,$J,358.3,8175,0)
 ;;=K25.7^^55^536^22
 ;;^UTILITY(U,$J,358.3,8175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8175,1,3,0)
 ;;=3^Chronic gastric ulcer without hemorrhage or perforation
 ;;^UTILITY(U,$J,358.3,8175,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,8175,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,8176,0)
 ;;=K25.9^^55^536^52
 ;;^UTILITY(U,$J,358.3,8176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8176,1,3,0)
 ;;=3^Gastric ulcer, unsp as acute or chronic, w/o hemor or perf
 ;;^UTILITY(U,$J,358.3,8176,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,8176,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,8177,0)
 ;;=K26.9^^55^536^36
 ;;^UTILITY(U,$J,358.3,8177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8177,1,3,0)
 ;;=3^Duodenal ulcer, unsp as acute or chronic, w/o hemor or perf
 ;;^UTILITY(U,$J,358.3,8177,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,8177,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,8178,0)
 ;;=K27.9^^55^536^78
 ;;^UTILITY(U,$J,358.3,8178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8178,1,3,0)
 ;;=3^Peptic ulc, site unsp, unsp as ac or chr, w/o hemor or perf
 ;;^UTILITY(U,$J,358.3,8178,1,4,0)
 ;;=4^K27.9
