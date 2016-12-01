IBDEI067 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7725,0)
 ;;=W13.2XXA^^26^421^69
 ;;^UTILITY(U,$J,358.3,7725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7725,1,3,0)
 ;;=3^Fall from/through Roof,Init Encntr
 ;;^UTILITY(U,$J,358.3,7725,1,4,0)
 ;;=4^W13.2XXA
 ;;^UTILITY(U,$J,358.3,7725,2)
 ;;=^5059607
 ;;^UTILITY(U,$J,358.3,7726,0)
 ;;=W13.2XXD^^26^421^70
 ;;^UTILITY(U,$J,358.3,7726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7726,1,3,0)
 ;;=3^Fall from/through Roof,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7726,1,4,0)
 ;;=4^W13.2XXD
 ;;^UTILITY(U,$J,358.3,7726,2)
 ;;=^5059608
 ;;^UTILITY(U,$J,358.3,7727,0)
 ;;=W13.3XXA^^26^421^83
 ;;^UTILITY(U,$J,358.3,7727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7727,1,3,0)
 ;;=3^Fall through Floor,Init Encntr
 ;;^UTILITY(U,$J,358.3,7727,1,4,0)
 ;;=4^W13.3XXA
 ;;^UTILITY(U,$J,358.3,7727,2)
 ;;=^5059610
 ;;^UTILITY(U,$J,358.3,7728,0)
 ;;=W13.3XXD^^26^421^84
 ;;^UTILITY(U,$J,358.3,7728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7728,1,3,0)
 ;;=3^Fall through Floor,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7728,1,4,0)
 ;;=4^W13.3XXD
 ;;^UTILITY(U,$J,358.3,7728,2)
 ;;=^5059611
 ;;^UTILITY(U,$J,358.3,7729,0)
 ;;=W13.4XXA^^26^421^71
 ;;^UTILITY(U,$J,358.3,7729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7729,1,3,0)
 ;;=3^Fall from/through Window,Init Encntr
 ;;^UTILITY(U,$J,358.3,7729,1,4,0)
 ;;=4^W13.4XXA
 ;;^UTILITY(U,$J,358.3,7729,2)
 ;;=^5059613
 ;;^UTILITY(U,$J,358.3,7730,0)
 ;;=W13.4XXD^^26^421^72
 ;;^UTILITY(U,$J,358.3,7730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7730,1,3,0)
 ;;=3^Fall from/through Window,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7730,1,4,0)
 ;;=4^W13.4XXD
 ;;^UTILITY(U,$J,358.3,7730,2)
 ;;=^5059614
 ;;^UTILITY(U,$J,358.3,7731,0)
 ;;=W13.8XXA^^26^421^35
 ;;^UTILITY(U,$J,358.3,7731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7731,1,3,0)
 ;;=3^Fall from Building/Structure,Init Encntr
 ;;^UTILITY(U,$J,358.3,7731,1,4,0)
 ;;=4^W13.8XXA
 ;;^UTILITY(U,$J,358.3,7731,2)
 ;;=^5059616
 ;;^UTILITY(U,$J,358.3,7732,0)
 ;;=W13.8XXD^^26^421^36
 ;;^UTILITY(U,$J,358.3,7732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7732,1,3,0)
 ;;=3^Fall from Building/Structure,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7732,1,4,0)
 ;;=4^W13.8XXD
 ;;^UTILITY(U,$J,358.3,7732,2)
 ;;=^5059617
 ;;^UTILITY(U,$J,358.3,7733,0)
 ;;=W13.9XXA^^26^421^33
 ;;^UTILITY(U,$J,358.3,7733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7733,1,3,0)
 ;;=3^Fall from Building NOS,Init Encntr
 ;;^UTILITY(U,$J,358.3,7733,1,4,0)
 ;;=4^W13.9XXA
 ;;^UTILITY(U,$J,358.3,7733,2)
 ;;=^5059619
 ;;^UTILITY(U,$J,358.3,7734,0)
 ;;=W13.9XXD^^26^421^34
 ;;^UTILITY(U,$J,358.3,7734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7734,1,3,0)
 ;;=3^Fall from Building NOS,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7734,1,4,0)
 ;;=4^W13.9XXD
 ;;^UTILITY(U,$J,358.3,7734,2)
 ;;=^5059620
 ;;^UTILITY(U,$J,358.3,7735,0)
 ;;=W14.XXXA^^26^421^65
 ;;^UTILITY(U,$J,358.3,7735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7735,1,3,0)
 ;;=3^Fall from Tree,Init Encntr
 ;;^UTILITY(U,$J,358.3,7735,1,4,0)
 ;;=4^W14.XXXA
 ;;^UTILITY(U,$J,358.3,7735,2)
 ;;=^5059622
 ;;^UTILITY(U,$J,358.3,7736,0)
 ;;=W14.XXXD^^26^421^66
 ;;^UTILITY(U,$J,358.3,7736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7736,1,3,0)
 ;;=3^Fall from Tree,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7736,1,4,0)
 ;;=4^W14.XXXD
 ;;^UTILITY(U,$J,358.3,7736,2)
 ;;=^5059623
 ;;^UTILITY(U,$J,358.3,7737,0)
 ;;=W17.2XXA^^26^421^77
 ;;^UTILITY(U,$J,358.3,7737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7737,1,3,0)
 ;;=3^Fall into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,7737,1,4,0)
 ;;=4^W17.2XXA
 ;;^UTILITY(U,$J,358.3,7737,2)
 ;;=^5059772
 ;;^UTILITY(U,$J,358.3,7738,0)
 ;;=W17.2XXD^^26^421^78
 ;;^UTILITY(U,$J,358.3,7738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7738,1,3,0)
 ;;=3^Fall into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7738,1,4,0)
 ;;=4^W17.2XXD
 ;;^UTILITY(U,$J,358.3,7738,2)
 ;;=^5059773
 ;;^UTILITY(U,$J,358.3,7739,0)
 ;;=W17.3XXA^^26^421^75
 ;;^UTILITY(U,$J,358.3,7739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7739,1,3,0)
 ;;=3^Fall into Empty Swimming Pool,Init Encntr
 ;;^UTILITY(U,$J,358.3,7739,1,4,0)
 ;;=4^W17.3XXA
 ;;^UTILITY(U,$J,358.3,7739,2)
 ;;=^5059775
 ;;^UTILITY(U,$J,358.3,7740,0)
 ;;=W17.3XXD^^26^421^76
 ;;^UTILITY(U,$J,358.3,7740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7740,1,3,0)
 ;;=3^Fall into Empty Swimming Pool,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7740,1,4,0)
 ;;=4^W17.3XXD
 ;;^UTILITY(U,$J,358.3,7740,2)
 ;;=^5059776
 ;;^UTILITY(U,$J,358.3,7741,0)
 ;;=W17.4XXA^^26^421^39
 ;;^UTILITY(U,$J,358.3,7741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7741,1,3,0)
 ;;=3^Fall from Dock,Init Encntr
 ;;^UTILITY(U,$J,358.3,7741,1,4,0)
 ;;=4^W17.4XXA
 ;;^UTILITY(U,$J,358.3,7741,2)
 ;;=^5059778
 ;;^UTILITY(U,$J,358.3,7742,0)
 ;;=W17.4XXD^^26^421^40
 ;;^UTILITY(U,$J,358.3,7742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7742,1,3,0)
 ;;=3^Fall from Dock,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7742,1,4,0)
 ;;=4^W17.4XXD
 ;;^UTILITY(U,$J,358.3,7742,2)
 ;;=^5059779
 ;;^UTILITY(U,$J,358.3,7743,0)
 ;;=W17.81XA^^26^421^27
 ;;^UTILITY(U,$J,358.3,7743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7743,1,3,0)
 ;;=3^Fall down Embankment,Init Encntr
 ;;^UTILITY(U,$J,358.3,7743,1,4,0)
 ;;=4^W17.81XA
 ;;^UTILITY(U,$J,358.3,7743,2)
 ;;=^5059781
 ;;^UTILITY(U,$J,358.3,7744,0)
 ;;=W17.81XD^^26^421^28
 ;;^UTILITY(U,$J,358.3,7744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7744,1,3,0)
 ;;=3^Fall down Embankment,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7744,1,4,0)
 ;;=4^W17.81XD
 ;;^UTILITY(U,$J,358.3,7744,2)
 ;;=^5059782
 ;;^UTILITY(U,$J,358.3,7745,0)
 ;;=W17.89XA^^26^421^55
 ;;^UTILITY(U,$J,358.3,7745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7745,1,3,0)
 ;;=3^Fall from One level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,7745,1,4,0)
 ;;=4^W17.89XA
 ;;^UTILITY(U,$J,358.3,7745,2)
 ;;=^5059787
 ;;^UTILITY(U,$J,358.3,7746,0)
 ;;=W17.89XD^^26^421^56
 ;;^UTILITY(U,$J,358.3,7746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7746,1,3,0)
 ;;=3^Fall from One level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7746,1,4,0)
 ;;=4^W17.89XD
 ;;^UTILITY(U,$J,358.3,7746,2)
 ;;=^5059788
 ;;^UTILITY(U,$J,358.3,7747,0)
 ;;=W18.11XA^^26^421^63
 ;;^UTILITY(U,$J,358.3,7747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7747,1,3,0)
 ;;=3^Fall from Toilet w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,7747,1,4,0)
 ;;=4^W18.11XA
 ;;^UTILITY(U,$J,358.3,7747,2)
 ;;=^5059801
 ;;^UTILITY(U,$J,358.3,7748,0)
 ;;=W18.11XD^^26^421^64
 ;;^UTILITY(U,$J,358.3,7748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7748,1,3,0)
 ;;=3^Fall from Toilet w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7748,1,4,0)
 ;;=4^W18.11XD
 ;;^UTILITY(U,$J,358.3,7748,2)
 ;;=^5059802
 ;;^UTILITY(U,$J,358.3,7749,0)
 ;;=W18.12XA^^26^421^61
 ;;^UTILITY(U,$J,358.3,7749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7749,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,7749,1,4,0)
 ;;=4^W18.12XA
 ;;^UTILITY(U,$J,358.3,7749,2)
 ;;=^5059804
 ;;^UTILITY(U,$J,358.3,7750,0)
 ;;=W18.12XD^^26^421^62
 ;;^UTILITY(U,$J,358.3,7750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7750,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7750,1,4,0)
 ;;=4^W18.12XD
 ;;^UTILITY(U,$J,358.3,7750,2)
 ;;=^5137984
 ;;^UTILITY(U,$J,358.3,7751,0)
 ;;=W18.2XXA^^26^421^73
 ;;^UTILITY(U,$J,358.3,7751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7751,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Init Encntr
 ;;^UTILITY(U,$J,358.3,7751,1,4,0)
 ;;=4^W18.2XXA
 ;;^UTILITY(U,$J,358.3,7751,2)
 ;;=^5059806
 ;;^UTILITY(U,$J,358.3,7752,0)
 ;;=W18.2XXD^^26^421^74
 ;;^UTILITY(U,$J,358.3,7752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7752,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7752,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,7752,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,7753,0)
 ;;=W18.40XA^^26^421^105
 ;;^UTILITY(U,$J,358.3,7753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7753,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,7753,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,7753,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,7754,0)
 ;;=W18.40XD^^26^421^106
 ;;^UTILITY(U,$J,358.3,7754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7754,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7754,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,7754,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,7755,0)
 ;;=W18.41XA^^26^421^107
 ;;^UTILITY(U,$J,358.3,7755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7755,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,7755,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,7755,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,7756,0)
 ;;=W18.41XD^^26^421^108
 ;;^UTILITY(U,$J,358.3,7756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7756,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7756,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,7756,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,7757,0)
 ;;=W18.42XA^^26^421^109
 ;;^UTILITY(U,$J,358.3,7757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7757,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,7757,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,7757,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,7758,0)
 ;;=W18.42XD^^26^421^110
 ;;^UTILITY(U,$J,358.3,7758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7758,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7758,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,7758,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,7759,0)
 ;;=W18.43XA^^26^421^103
 ;;^UTILITY(U,$J,358.3,7759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7759,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
