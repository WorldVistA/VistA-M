IBDEI2LL ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41484,1,2,0)
 ;;=2^Muscle Test (EMG),4 Limbs
 ;;^UTILITY(U,$J,358.3,41484,1,3,0)
 ;;=3^95864
 ;;^UTILITY(U,$J,358.3,41485,0)
 ;;=95867^^154^2049^7^^^^1
 ;;^UTILITY(U,$J,358.3,41485,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41485,1,2,0)
 ;;=2^Muscle Test (EMG),Cran Ner Mus-Unilat
 ;;^UTILITY(U,$J,358.3,41485,1,3,0)
 ;;=3^95867
 ;;^UTILITY(U,$J,358.3,41486,0)
 ;;=95868^^154^2049^8^^^^1
 ;;^UTILITY(U,$J,358.3,41486,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41486,1,2,0)
 ;;=2^Muscle Test (EMG),Head or Neck
 ;;^UTILITY(U,$J,358.3,41486,1,3,0)
 ;;=3^95868
 ;;^UTILITY(U,$J,358.3,41487,0)
 ;;=95870^^154^2049^9^^^^1
 ;;^UTILITY(U,$J,358.3,41487,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41487,1,2,0)
 ;;=2^Needle EMG < 5 Muscles/Ext
 ;;^UTILITY(U,$J,358.3,41487,1,3,0)
 ;;=3^95870
 ;;^UTILITY(U,$J,358.3,41488,0)
 ;;=95861^^154^2049^4^^^^1
 ;;^UTILITY(U,$J,358.3,41488,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41488,1,2,0)
 ;;=2^Muscle Test (EMG),2 Limbs
 ;;^UTILITY(U,$J,358.3,41488,1,3,0)
 ;;=3^95861
 ;;^UTILITY(U,$J,358.3,41489,0)
 ;;=95885^^154^2049^10^^^^1
 ;;^UTILITY(U,$J,358.3,41489,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41489,1,2,0)
 ;;=2^Needle EMG < 5 Muscles/Ext,+NCS
 ;;^UTILITY(U,$J,358.3,41489,1,3,0)
 ;;=3^95885
 ;;^UTILITY(U,$J,358.3,41490,0)
 ;;=95886^^154^2049^11^^^^1
 ;;^UTILITY(U,$J,358.3,41490,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41490,1,2,0)
 ;;=2^Needle EMG >/= 5 Muscles/Ext,+NCS
 ;;^UTILITY(U,$J,358.3,41490,1,3,0)
 ;;=3^95886
 ;;^UTILITY(U,$J,358.3,41491,0)
 ;;=95887^^154^2049^12^^^^1
 ;;^UTILITY(U,$J,358.3,41491,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41491,1,2,0)
 ;;=2^Needle EMG CNs or Axial,+NCS
 ;;^UTILITY(U,$J,358.3,41491,1,3,0)
 ;;=3^95887
 ;;^UTILITY(U,$J,358.3,41492,0)
 ;;=95905^^154^2049^2^^^^1
 ;;^UTILITY(U,$J,358.3,41492,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41492,1,2,0)
 ;;=2^Motor/Sens Nerv Conduct-ea limb s/F-wv
 ;;^UTILITY(U,$J,358.3,41492,1,3,0)
 ;;=3^95905
 ;;^UTILITY(U,$J,358.3,41493,0)
 ;;=95907^^154^2049^14^^^^1
 ;;^UTILITY(U,$J,358.3,41493,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41493,1,2,0)
 ;;=2^Nerve conduction studies; 1-2 studies
 ;;^UTILITY(U,$J,358.3,41493,1,3,0)
 ;;=3^95907
 ;;^UTILITY(U,$J,358.3,41494,0)
 ;;=95908^^154^2049^16^^^^1
 ;;^UTILITY(U,$J,358.3,41494,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41494,1,2,0)
 ;;=2^Nerve conduction studies; 3-4 studies
 ;;^UTILITY(U,$J,358.3,41494,1,3,0)
 ;;=3^95908
 ;;^UTILITY(U,$J,358.3,41495,0)
 ;;=95909^^154^2049^17^^^^1
 ;;^UTILITY(U,$J,358.3,41495,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41495,1,2,0)
 ;;=2^Nerve conduction studies; 5-6 studies
 ;;^UTILITY(U,$J,358.3,41495,1,3,0)
 ;;=3^95909
 ;;^UTILITY(U,$J,358.3,41496,0)
 ;;=95910^^154^2049^18^^^^1
 ;;^UTILITY(U,$J,358.3,41496,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41496,1,2,0)
 ;;=2^Nerve conduction studies; 7-8 studies
 ;;^UTILITY(U,$J,358.3,41496,1,3,0)
 ;;=3^95910
 ;;^UTILITY(U,$J,358.3,41497,0)
 ;;=95911^^154^2049^19^^^^1
 ;;^UTILITY(U,$J,358.3,41497,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41497,1,2,0)
 ;;=2^Nerve conduction studies; 9-10 studies
 ;;^UTILITY(U,$J,358.3,41497,1,3,0)
 ;;=3^95911
 ;;^UTILITY(U,$J,358.3,41498,0)
 ;;=95912^^154^2049^15^^^^1
 ;;^UTILITY(U,$J,358.3,41498,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41498,1,2,0)
 ;;=2^Nerve conduction studies; 11-12 studies
