IBDEI0QD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12356,1,3,0)
 ;;=3^Ulcerative colitis, unspecified with fistula
 ;;^UTILITY(U,$J,358.3,12356,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,12356,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,12357,0)
 ;;=K51.912^^50^559^60
 ;;^UTILITY(U,$J,358.3,12357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12357,1,3,0)
 ;;=3^Ulcerative colitis, unspecified with intestinal obstruction
 ;;^UTILITY(U,$J,358.3,12357,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,12357,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,12358,0)
 ;;=K51.911^^50^559^62
 ;;^UTILITY(U,$J,358.3,12358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12358,1,3,0)
 ;;=3^Ulcerative colitis, unspecified with rectal bleeding
 ;;^UTILITY(U,$J,358.3,12358,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,12358,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,12359,0)
 ;;=K52.81^^50^559^33
 ;;^UTILITY(U,$J,358.3,12359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12359,1,3,0)
 ;;=3^Eosinophilic gastritis or gastroenteritis
 ;;^UTILITY(U,$J,358.3,12359,1,4,0)
 ;;=4^K52.81
 ;;^UTILITY(U,$J,358.3,12359,2)
 ;;=^5008702
 ;;^UTILITY(U,$J,358.3,12360,0)
 ;;=K57.90^^50^559^28
 ;;^UTILITY(U,$J,358.3,12360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12360,1,3,0)
 ;;=3^Dvrtclos of intest, part unsp, w/o perf or abscess w/o bleed
 ;;^UTILITY(U,$J,358.3,12360,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,12360,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,12361,0)
 ;;=K57.50^^50^559^27
 ;;^UTILITY(U,$J,358.3,12361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12361,1,3,0)
 ;;=3^Dvrtclos of both sm and lg int w/o perf or abscs w/o bleed
 ;;^UTILITY(U,$J,358.3,12361,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,12361,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,12362,0)
 ;;=K57.30^^50^559^29
 ;;^UTILITY(U,$J,358.3,12362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12362,1,3,0)
 ;;=3^Dvrtclos of lg int w/o perforation or abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,12362,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,12362,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,12363,0)
 ;;=K57.20^^50^559^31
 ;;^UTILITY(U,$J,358.3,12363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12363,1,3,0)
 ;;=3^Dvtrcli of lg int w perforation and abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,12363,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,12363,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,12364,0)
 ;;=K57.92^^50^559^30
 ;;^UTILITY(U,$J,358.3,12364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12364,1,3,0)
 ;;=3^Dvtrcli of intest, part unsp, w/o perf or abscess w/o bleed
 ;;^UTILITY(U,$J,358.3,12364,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,12364,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,12365,0)
 ;;=K57.32^^50^559^32
 ;;^UTILITY(U,$J,358.3,12365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12365,1,3,0)
 ;;=3^Dvtrcli of lg int w/o perforation or abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,12365,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,12365,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,12366,0)
 ;;=K59.00^^50^559^18
 ;;^UTILITY(U,$J,358.3,12366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12366,1,3,0)
 ;;=3^Constipation, unspecified
 ;;^UTILITY(U,$J,358.3,12366,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,12366,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,12367,0)
 ;;=K58.0^^50^559^40
 ;;^UTILITY(U,$J,358.3,12367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12367,1,3,0)
 ;;=3^Irritable bowel syndrome with diarrhea
 ;;^UTILITY(U,$J,358.3,12367,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,12367,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,12368,0)
 ;;=K58.9^^50^559^41
 ;;^UTILITY(U,$J,358.3,12368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12368,1,3,0)
 ;;=3^Irritable bowel syndrome without diarrhea
