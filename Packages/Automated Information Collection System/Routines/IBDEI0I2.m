IBDEI0I2 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22893,0)
 ;;=W13.4XXD^^58^859^72
 ;;^UTILITY(U,$J,358.3,22893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22893,1,3,0)
 ;;=3^Fall from/through Window,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22893,1,4,0)
 ;;=4^W13.4XXD
 ;;^UTILITY(U,$J,358.3,22893,2)
 ;;=^5059614
 ;;^UTILITY(U,$J,358.3,22894,0)
 ;;=W13.8XXA^^58^859^35
 ;;^UTILITY(U,$J,358.3,22894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22894,1,3,0)
 ;;=3^Fall from Building/Structure,Init Encntr
 ;;^UTILITY(U,$J,358.3,22894,1,4,0)
 ;;=4^W13.8XXA
 ;;^UTILITY(U,$J,358.3,22894,2)
 ;;=^5059616
 ;;^UTILITY(U,$J,358.3,22895,0)
 ;;=W13.8XXD^^58^859^36
 ;;^UTILITY(U,$J,358.3,22895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22895,1,3,0)
 ;;=3^Fall from Building/Structure,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22895,1,4,0)
 ;;=4^W13.8XXD
 ;;^UTILITY(U,$J,358.3,22895,2)
 ;;=^5059617
 ;;^UTILITY(U,$J,358.3,22896,0)
 ;;=W13.9XXA^^58^859^33
 ;;^UTILITY(U,$J,358.3,22896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22896,1,3,0)
 ;;=3^Fall from Building NOS,Init Encntr
 ;;^UTILITY(U,$J,358.3,22896,1,4,0)
 ;;=4^W13.9XXA
 ;;^UTILITY(U,$J,358.3,22896,2)
 ;;=^5059619
 ;;^UTILITY(U,$J,358.3,22897,0)
 ;;=W13.9XXD^^58^859^34
 ;;^UTILITY(U,$J,358.3,22897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22897,1,3,0)
 ;;=3^Fall from Building NOS,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22897,1,4,0)
 ;;=4^W13.9XXD
 ;;^UTILITY(U,$J,358.3,22897,2)
 ;;=^5059620
 ;;^UTILITY(U,$J,358.3,22898,0)
 ;;=W14.XXXA^^58^859^65
 ;;^UTILITY(U,$J,358.3,22898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22898,1,3,0)
 ;;=3^Fall from Tree,Init Encntr
 ;;^UTILITY(U,$J,358.3,22898,1,4,0)
 ;;=4^W14.XXXA
 ;;^UTILITY(U,$J,358.3,22898,2)
 ;;=^5059622
 ;;^UTILITY(U,$J,358.3,22899,0)
 ;;=W14.XXXD^^58^859^66
 ;;^UTILITY(U,$J,358.3,22899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22899,1,3,0)
 ;;=3^Fall from Tree,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22899,1,4,0)
 ;;=4^W14.XXXD
 ;;^UTILITY(U,$J,358.3,22899,2)
 ;;=^5059623
 ;;^UTILITY(U,$J,358.3,22900,0)
 ;;=W17.2XXA^^58^859^77
 ;;^UTILITY(U,$J,358.3,22900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22900,1,3,0)
 ;;=3^Fall into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,22900,1,4,0)
 ;;=4^W17.2XXA
 ;;^UTILITY(U,$J,358.3,22900,2)
 ;;=^5059772
 ;;^UTILITY(U,$J,358.3,22901,0)
 ;;=W17.2XXD^^58^859^78
 ;;^UTILITY(U,$J,358.3,22901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22901,1,3,0)
 ;;=3^Fall into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22901,1,4,0)
 ;;=4^W17.2XXD
 ;;^UTILITY(U,$J,358.3,22901,2)
 ;;=^5059773
 ;;^UTILITY(U,$J,358.3,22902,0)
 ;;=W17.3XXA^^58^859^75
 ;;^UTILITY(U,$J,358.3,22902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22902,1,3,0)
 ;;=3^Fall into Empty Swimming Pool,Init Encntr
 ;;^UTILITY(U,$J,358.3,22902,1,4,0)
 ;;=4^W17.3XXA
 ;;^UTILITY(U,$J,358.3,22902,2)
 ;;=^5059775
 ;;^UTILITY(U,$J,358.3,22903,0)
 ;;=W17.3XXD^^58^859^76
 ;;^UTILITY(U,$J,358.3,22903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22903,1,3,0)
 ;;=3^Fall into Empty Swimming Pool,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22903,1,4,0)
 ;;=4^W17.3XXD
 ;;^UTILITY(U,$J,358.3,22903,2)
 ;;=^5059776
 ;;^UTILITY(U,$J,358.3,22904,0)
 ;;=W17.4XXA^^58^859^39
 ;;^UTILITY(U,$J,358.3,22904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22904,1,3,0)
 ;;=3^Fall from Dock,Init Encntr
 ;;^UTILITY(U,$J,358.3,22904,1,4,0)
 ;;=4^W17.4XXA
 ;;^UTILITY(U,$J,358.3,22904,2)
 ;;=^5059778
 ;;^UTILITY(U,$J,358.3,22905,0)
 ;;=W17.4XXD^^58^859^40
 ;;^UTILITY(U,$J,358.3,22905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22905,1,3,0)
 ;;=3^Fall from Dock,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22905,1,4,0)
 ;;=4^W17.4XXD
 ;;^UTILITY(U,$J,358.3,22905,2)
 ;;=^5059779
 ;;^UTILITY(U,$J,358.3,22906,0)
 ;;=W17.81XA^^58^859^27
 ;;^UTILITY(U,$J,358.3,22906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22906,1,3,0)
 ;;=3^Fall down Embankment,Init Encntr
 ;;^UTILITY(U,$J,358.3,22906,1,4,0)
 ;;=4^W17.81XA
 ;;^UTILITY(U,$J,358.3,22906,2)
 ;;=^5059781
 ;;^UTILITY(U,$J,358.3,22907,0)
 ;;=W17.81XD^^58^859^28
 ;;^UTILITY(U,$J,358.3,22907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22907,1,3,0)
 ;;=3^Fall down Embankment,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22907,1,4,0)
 ;;=4^W17.81XD
 ;;^UTILITY(U,$J,358.3,22907,2)
 ;;=^5059782
 ;;^UTILITY(U,$J,358.3,22908,0)
 ;;=W17.89XA^^58^859^55
 ;;^UTILITY(U,$J,358.3,22908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22908,1,3,0)
 ;;=3^Fall from One level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,22908,1,4,0)
 ;;=4^W17.89XA
 ;;^UTILITY(U,$J,358.3,22908,2)
 ;;=^5059787
 ;;^UTILITY(U,$J,358.3,22909,0)
 ;;=W17.89XD^^58^859^56
 ;;^UTILITY(U,$J,358.3,22909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22909,1,3,0)
 ;;=3^Fall from One level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22909,1,4,0)
 ;;=4^W17.89XD
 ;;^UTILITY(U,$J,358.3,22909,2)
 ;;=^5059788
 ;;^UTILITY(U,$J,358.3,22910,0)
 ;;=W18.11XA^^58^859^63
 ;;^UTILITY(U,$J,358.3,22910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22910,1,3,0)
 ;;=3^Fall from Toilet w/o Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,22910,1,4,0)
 ;;=4^W18.11XA
 ;;^UTILITY(U,$J,358.3,22910,2)
 ;;=^5059801
 ;;^UTILITY(U,$J,358.3,22911,0)
 ;;=W18.11XD^^58^859^64
 ;;^UTILITY(U,$J,358.3,22911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22911,1,3,0)
 ;;=3^Fall from Toilet w/o Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22911,1,4,0)
 ;;=4^W18.11XD
 ;;^UTILITY(U,$J,358.3,22911,2)
 ;;=^5059802
 ;;^UTILITY(U,$J,358.3,22912,0)
 ;;=W18.12XA^^58^859^61
 ;;^UTILITY(U,$J,358.3,22912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22912,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,22912,1,4,0)
 ;;=4^W18.12XA
 ;;^UTILITY(U,$J,358.3,22912,2)
 ;;=^5059804
 ;;^UTILITY(U,$J,358.3,22913,0)
 ;;=W18.12XD^^58^859^62
 ;;^UTILITY(U,$J,358.3,22913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22913,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22913,1,4,0)
 ;;=4^W18.12XD
 ;;^UTILITY(U,$J,358.3,22913,2)
 ;;=^5137984
 ;;^UTILITY(U,$J,358.3,22914,0)
 ;;=W18.2XXA^^58^859^73
 ;;^UTILITY(U,$J,358.3,22914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22914,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Init Encntr
 ;;^UTILITY(U,$J,358.3,22914,1,4,0)
 ;;=4^W18.2XXA
 ;;^UTILITY(U,$J,358.3,22914,2)
 ;;=^5059806
 ;;^UTILITY(U,$J,358.3,22915,0)
 ;;=W18.2XXD^^58^859^74
 ;;^UTILITY(U,$J,358.3,22915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22915,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22915,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,22915,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,22916,0)
 ;;=W18.40XA^^58^859^105
 ;;^UTILITY(U,$J,358.3,22916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22916,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,22916,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,22916,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,22917,0)
 ;;=W18.40XD^^58^859^106
 ;;^UTILITY(U,$J,358.3,22917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22917,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22917,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,22917,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,22918,0)
 ;;=W18.41XA^^58^859^107
 ;;^UTILITY(U,$J,358.3,22918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22918,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,22918,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,22918,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,22919,0)
 ;;=W18.41XD^^58^859^108
 ;;^UTILITY(U,$J,358.3,22919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22919,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22919,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,22919,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,22920,0)
 ;;=W18.42XA^^58^859^109
 ;;^UTILITY(U,$J,358.3,22920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22920,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,22920,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,22920,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,22921,0)
 ;;=W18.42XD^^58^859^110
 ;;^UTILITY(U,$J,358.3,22921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22921,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22921,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,22921,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,22922,0)
 ;;=W18.43XA^^58^859^103
 ;;^UTILITY(U,$J,358.3,22922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22922,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,22922,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,22922,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,22923,0)
 ;;=W18.43XD^^58^859^104
 ;;^UTILITY(U,$J,358.3,22923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22923,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22923,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,22923,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,22924,0)
 ;;=W18.49XA^^58^859^111
 ;;^UTILITY(U,$J,358.3,22924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22924,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,22924,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,22924,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,22925,0)
 ;;=W18.49XD^^58^859^112
 ;;^UTILITY(U,$J,358.3,22925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22925,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22925,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,22925,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,22926,0)
 ;;=W19.XXXA^^58^859^89
 ;;^UTILITY(U,$J,358.3,22926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22926,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
