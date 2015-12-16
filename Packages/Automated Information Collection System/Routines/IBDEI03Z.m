IBDEI03Z ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1329,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of bronchus/lung
 ;;^UTILITY(U,$J,358.3,1329,1,4,0)
 ;;=4^Z85.118
 ;;^UTILITY(U,$J,358.3,1329,2)
 ;;=^5063408
 ;;^UTILITY(U,$J,358.3,1330,0)
 ;;=Z85.21^^3^39^103
 ;;^UTILITY(U,$J,358.3,1330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1330,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of larynx
 ;;^UTILITY(U,$J,358.3,1330,1,4,0)
 ;;=4^Z85.21
 ;;^UTILITY(U,$J,358.3,1330,2)
 ;;=^5063411
 ;;^UTILITY(U,$J,358.3,1331,0)
 ;;=Z85.3^^3^39^97
 ;;^UTILITY(U,$J,358.3,1331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1331,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of breast
 ;;^UTILITY(U,$J,358.3,1331,1,4,0)
 ;;=4^Z85.3
 ;;^UTILITY(U,$J,358.3,1331,2)
 ;;=^5063416
 ;;^UTILITY(U,$J,358.3,1332,0)
 ;;=Z85.41^^3^39^99
 ;;^UTILITY(U,$J,358.3,1332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1332,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of cervix uteri
 ;;^UTILITY(U,$J,358.3,1332,1,4,0)
 ;;=4^Z85.41
 ;;^UTILITY(U,$J,358.3,1332,2)
 ;;=^5063418
 ;;^UTILITY(U,$J,358.3,1333,0)
 ;;=Z85.43^^3^39^105
 ;;^UTILITY(U,$J,358.3,1333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1333,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of ovary
 ;;^UTILITY(U,$J,358.3,1333,1,4,0)
 ;;=4^Z85.43
 ;;^UTILITY(U,$J,358.3,1333,2)
 ;;=^5063420
 ;;^UTILITY(U,$J,358.3,1334,0)
 ;;=Z85.46^^3^39^106
 ;;^UTILITY(U,$J,358.3,1334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1334,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of prostate
 ;;^UTILITY(U,$J,358.3,1334,1,4,0)
 ;;=4^Z85.46
 ;;^UTILITY(U,$J,358.3,1334,2)
 ;;=^5063423
 ;;^UTILITY(U,$J,358.3,1335,0)
 ;;=Z85.47^^3^39^111
 ;;^UTILITY(U,$J,358.3,1335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1335,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of testis
 ;;^UTILITY(U,$J,358.3,1335,1,4,0)
 ;;=4^Z85.47
 ;;^UTILITY(U,$J,358.3,1335,2)
 ;;=^5063424
 ;;^UTILITY(U,$J,358.3,1336,0)
 ;;=Z85.51^^3^39^96
 ;;^UTILITY(U,$J,358.3,1336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1336,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of bladder
 ;;^UTILITY(U,$J,358.3,1336,1,4,0)
 ;;=4^Z85.51
 ;;^UTILITY(U,$J,358.3,1336,2)
 ;;=^5063428
 ;;^UTILITY(U,$J,358.3,1337,0)
 ;;=Z85.528^^3^39^101
 ;;^UTILITY(U,$J,358.3,1337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1337,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of kidney
 ;;^UTILITY(U,$J,358.3,1337,1,4,0)
 ;;=4^Z85.528
 ;;^UTILITY(U,$J,358.3,1337,2)
 ;;=^5063430
 ;;^UTILITY(U,$J,358.3,1338,0)
 ;;=Z85.6^^3^39^94
 ;;^UTILITY(U,$J,358.3,1338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1338,1,3,0)
 ;;=3^Prsnl hx of leukemia
 ;;^UTILITY(U,$J,358.3,1338,1,4,0)
 ;;=4^Z85.6
 ;;^UTILITY(U,$J,358.3,1338,2)
 ;;=^5063434
 ;;^UTILITY(U,$J,358.3,1339,0)
 ;;=Z85.79^^3^39^104
 ;;^UTILITY(U,$J,358.3,1339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1339,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of lymphoid, hematpoetc & rel tiss
 ;;^UTILITY(U,$J,358.3,1339,1,4,0)
 ;;=4^Z85.79
 ;;^UTILITY(U,$J,358.3,1339,2)
 ;;=^5063437
 ;;^UTILITY(U,$J,358.3,1340,0)
 ;;=Z85.820^^3^39^95
 ;;^UTILITY(U,$J,358.3,1340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1340,1,3,0)
 ;;=3^Prsnl hx of malig melanoma of skin
 ;;^UTILITY(U,$J,358.3,1340,1,4,0)
 ;;=4^Z85.820
 ;;^UTILITY(U,$J,358.3,1340,2)
 ;;=^5063441
 ;;^UTILITY(U,$J,358.3,1341,0)
 ;;=Z85.828^^3^39^109
 ;;^UTILITY(U,$J,358.3,1341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1341,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of skin NEC
 ;;^UTILITY(U,$J,358.3,1341,1,4,0)
 ;;=4^Z85.828
 ;;^UTILITY(U,$J,358.3,1341,2)
 ;;=^5063443
 ;;^UTILITY(U,$J,358.3,1342,0)
 ;;=Z79.01^^3^39^45
 ;;^UTILITY(U,$J,358.3,1342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1342,1,3,0)
 ;;=3^Long term (current) use of anticoagulants
