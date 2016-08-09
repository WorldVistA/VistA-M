IBDEI08S ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8732,1,4,0)
 ;;=4^W13.9XXD
 ;;^UTILITY(U,$J,358.3,8732,2)
 ;;=^5059620
 ;;^UTILITY(U,$J,358.3,8733,0)
 ;;=W14.XXXA^^42^517^65
 ;;^UTILITY(U,$J,358.3,8733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8733,1,3,0)
 ;;=3^Fall from Tree,Init Encntr
 ;;^UTILITY(U,$J,358.3,8733,1,4,0)
 ;;=4^W14.XXXA
 ;;^UTILITY(U,$J,358.3,8733,2)
 ;;=^5059622
 ;;^UTILITY(U,$J,358.3,8734,0)
 ;;=W14.XXXD^^42^517^66
 ;;^UTILITY(U,$J,358.3,8734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8734,1,3,0)
 ;;=3^Fall from Tree,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8734,1,4,0)
 ;;=4^W14.XXXD
 ;;^UTILITY(U,$J,358.3,8734,2)
 ;;=^5059623
 ;;^UTILITY(U,$J,358.3,8735,0)
 ;;=W17.2XXA^^42^517^77
 ;;^UTILITY(U,$J,358.3,8735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8735,1,3,0)
 ;;=3^Fall into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,8735,1,4,0)
 ;;=4^W17.2XXA
 ;;^UTILITY(U,$J,358.3,8735,2)
 ;;=^5059772
 ;;^UTILITY(U,$J,358.3,8736,0)
 ;;=W17.2XXD^^42^517^78
 ;;^UTILITY(U,$J,358.3,8736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8736,1,3,0)
 ;;=3^Fall into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8736,1,4,0)
 ;;=4^W17.2XXD
 ;;^UTILITY(U,$J,358.3,8736,2)
 ;;=^5059773
 ;;^UTILITY(U,$J,358.3,8737,0)
 ;;=W17.3XXA^^42^517^75
 ;;^UTILITY(U,$J,358.3,8737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8737,1,3,0)
 ;;=3^Fall into Empty Swimming Pool,Init Encntr
 ;;^UTILITY(U,$J,358.3,8737,1,4,0)
 ;;=4^W17.3XXA
 ;;^UTILITY(U,$J,358.3,8737,2)
 ;;=^5059775
 ;;^UTILITY(U,$J,358.3,8738,0)
 ;;=W17.3XXD^^42^517^76
 ;;^UTILITY(U,$J,358.3,8738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8738,1,3,0)
 ;;=3^Fall into Empty Swimming Pool,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8738,1,4,0)
 ;;=4^W17.3XXD
 ;;^UTILITY(U,$J,358.3,8738,2)
 ;;=^5059776
 ;;^UTILITY(U,$J,358.3,8739,0)
 ;;=W17.4XXA^^42^517^39
 ;;^UTILITY(U,$J,358.3,8739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8739,1,3,0)
 ;;=3^Fall from Dock,Init Encntr
 ;;^UTILITY(U,$J,358.3,8739,1,4,0)
 ;;=4^W17.4XXA
 ;;^UTILITY(U,$J,358.3,8739,2)
 ;;=^5059778
 ;;^UTILITY(U,$J,358.3,8740,0)
 ;;=W17.4XXD^^42^517^40
 ;;^UTILITY(U,$J,358.3,8740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8740,1,3,0)
 ;;=3^Fall from Dock,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8740,1,4,0)
 ;;=4^W17.4XXD
 ;;^UTILITY(U,$J,358.3,8740,2)
 ;;=^5059779
 ;;^UTILITY(U,$J,358.3,8741,0)
 ;;=W17.81XA^^42^517^27
 ;;^UTILITY(U,$J,358.3,8741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8741,1,3,0)
 ;;=3^Fall down Embankment,Init Encntr
 ;;^UTILITY(U,$J,358.3,8741,1,4,0)
 ;;=4^W17.81XA
 ;;^UTILITY(U,$J,358.3,8741,2)
 ;;=^5059781
 ;;^UTILITY(U,$J,358.3,8742,0)
 ;;=W17.81XD^^42^517^28
 ;;^UTILITY(U,$J,358.3,8742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8742,1,3,0)
 ;;=3^Fall down Embankment,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8742,1,4,0)
 ;;=4^W17.81XD
 ;;^UTILITY(U,$J,358.3,8742,2)
 ;;=^5059782
 ;;^UTILITY(U,$J,358.3,8743,0)
 ;;=W17.89XA^^42^517^55
 ;;^UTILITY(U,$J,358.3,8743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8743,1,3,0)
 ;;=3^Fall from One level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,8743,1,4,0)
 ;;=4^W17.89XA
 ;;^UTILITY(U,$J,358.3,8743,2)
 ;;=^5059787
 ;;^UTILITY(U,$J,358.3,8744,0)
 ;;=W17.89XD^^42^517^56
 ;;^UTILITY(U,$J,358.3,8744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8744,1,3,0)
 ;;=3^Fall from One level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8744,1,4,0)
 ;;=4^W17.89XD
 ;;^UTILITY(U,$J,358.3,8744,2)
 ;;=^5059788
 ;;^UTILITY(U,$J,358.3,8745,0)
 ;;=W18.11XA^^42^517^63
 ;;^UTILITY(U,$J,358.3,8745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8745,1,3,0)
 ;;=3^Fall from Toilet w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,8745,1,4,0)
 ;;=4^W18.11XA
 ;;^UTILITY(U,$J,358.3,8745,2)
 ;;=^5059801
 ;;^UTILITY(U,$J,358.3,8746,0)
 ;;=W18.11XD^^42^517^64
 ;;^UTILITY(U,$J,358.3,8746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8746,1,3,0)
 ;;=3^Fall from Toilet w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8746,1,4,0)
 ;;=4^W18.11XD
 ;;^UTILITY(U,$J,358.3,8746,2)
 ;;=^5059802
 ;;^UTILITY(U,$J,358.3,8747,0)
 ;;=W18.12XA^^42^517^61
 ;;^UTILITY(U,$J,358.3,8747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8747,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,8747,1,4,0)
 ;;=4^W18.12XA
 ;;^UTILITY(U,$J,358.3,8747,2)
 ;;=^5059804
 ;;^UTILITY(U,$J,358.3,8748,0)
 ;;=W18.12XD^^42^517^62
 ;;^UTILITY(U,$J,358.3,8748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8748,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8748,1,4,0)
 ;;=4^W18.12XD
 ;;^UTILITY(U,$J,358.3,8748,2)
 ;;=^5137984
 ;;^UTILITY(U,$J,358.3,8749,0)
 ;;=W18.2XXA^^42^517^73
 ;;^UTILITY(U,$J,358.3,8749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8749,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Init Encntr
 ;;^UTILITY(U,$J,358.3,8749,1,4,0)
 ;;=4^W18.2XXA
 ;;^UTILITY(U,$J,358.3,8749,2)
 ;;=^5059806
 ;;^UTILITY(U,$J,358.3,8750,0)
 ;;=W18.2XXD^^42^517^74
 ;;^UTILITY(U,$J,358.3,8750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8750,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8750,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,8750,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,8751,0)
 ;;=W18.40XA^^42^517^105
 ;;^UTILITY(U,$J,358.3,8751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8751,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,8751,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,8751,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,8752,0)
 ;;=W18.40XD^^42^517^106
 ;;^UTILITY(U,$J,358.3,8752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8752,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8752,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,8752,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,8753,0)
 ;;=W18.41XA^^42^517^107
 ;;^UTILITY(U,$J,358.3,8753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8753,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,8753,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,8753,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,8754,0)
 ;;=W18.41XD^^42^517^108
 ;;^UTILITY(U,$J,358.3,8754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8754,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8754,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,8754,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,8755,0)
 ;;=W18.42XA^^42^517^109
 ;;^UTILITY(U,$J,358.3,8755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8755,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,8755,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,8755,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,8756,0)
 ;;=W18.42XD^^42^517^110
 ;;^UTILITY(U,$J,358.3,8756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8756,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8756,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,8756,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,8757,0)
 ;;=W18.43XA^^42^517^103
 ;;^UTILITY(U,$J,358.3,8757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8757,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,8757,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,8757,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,8758,0)
 ;;=W18.43XD^^42^517^104
 ;;^UTILITY(U,$J,358.3,8758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8758,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8758,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,8758,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,8759,0)
 ;;=W18.49XA^^42^517^111
 ;;^UTILITY(U,$J,358.3,8759,1,0)
 ;;=^358.31IA^4^2
