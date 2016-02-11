IBDEI12H ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17797,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,17798,0)
 ;;=K51.913^^91^882^59
 ;;^UTILITY(U,$J,358.3,17798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17798,1,3,0)
 ;;=3^Ulcerative colitis, unspecified with fistula
 ;;^UTILITY(U,$J,358.3,17798,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,17798,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,17799,0)
 ;;=K51.912^^91^882^60
 ;;^UTILITY(U,$J,358.3,17799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17799,1,3,0)
 ;;=3^Ulcerative colitis, unspecified with intestinal obstruction
 ;;^UTILITY(U,$J,358.3,17799,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,17799,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,17800,0)
 ;;=K51.911^^91^882^62
 ;;^UTILITY(U,$J,358.3,17800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17800,1,3,0)
 ;;=3^Ulcerative colitis, unspecified with rectal bleeding
 ;;^UTILITY(U,$J,358.3,17800,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,17800,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,17801,0)
 ;;=K52.81^^91^882^33
 ;;^UTILITY(U,$J,358.3,17801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17801,1,3,0)
 ;;=3^Eosinophilic gastritis or gastroenteritis
 ;;^UTILITY(U,$J,358.3,17801,1,4,0)
 ;;=4^K52.81
 ;;^UTILITY(U,$J,358.3,17801,2)
 ;;=^5008702
 ;;^UTILITY(U,$J,358.3,17802,0)
 ;;=K57.90^^91^882^28
 ;;^UTILITY(U,$J,358.3,17802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17802,1,3,0)
 ;;=3^Dvrtclos of intest, part unsp, w/o perf or abscess w/o bleed
 ;;^UTILITY(U,$J,358.3,17802,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,17802,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,17803,0)
 ;;=K57.50^^91^882^27
 ;;^UTILITY(U,$J,358.3,17803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17803,1,3,0)
 ;;=3^Dvrtclos of both sm and lg int w/o perf or abscs w/o bleed
 ;;^UTILITY(U,$J,358.3,17803,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,17803,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,17804,0)
 ;;=K57.30^^91^882^29
 ;;^UTILITY(U,$J,358.3,17804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17804,1,3,0)
 ;;=3^Dvrtclos of lg int w/o perforation or abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,17804,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,17804,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,17805,0)
 ;;=K57.20^^91^882^31
 ;;^UTILITY(U,$J,358.3,17805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17805,1,3,0)
 ;;=3^Dvtrcli of lg int w perforation and abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,17805,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,17805,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,17806,0)
 ;;=K57.92^^91^882^30
 ;;^UTILITY(U,$J,358.3,17806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17806,1,3,0)
 ;;=3^Dvtrcli of intest, part unsp, w/o perf or abscess w/o bleed
 ;;^UTILITY(U,$J,358.3,17806,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,17806,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,17807,0)
 ;;=K57.32^^91^882^32
 ;;^UTILITY(U,$J,358.3,17807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17807,1,3,0)
 ;;=3^Dvtrcli of lg int w/o perforation or abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,17807,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,17807,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,17808,0)
 ;;=K59.00^^91^882^18
 ;;^UTILITY(U,$J,358.3,17808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17808,1,3,0)
 ;;=3^Constipation, unspecified
 ;;^UTILITY(U,$J,358.3,17808,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,17808,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,17809,0)
 ;;=K58.0^^91^882^40
 ;;^UTILITY(U,$J,358.3,17809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17809,1,3,0)
 ;;=3^Irritable bowel syndrome with diarrhea
 ;;^UTILITY(U,$J,358.3,17809,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,17809,2)
 ;;=^5008739
