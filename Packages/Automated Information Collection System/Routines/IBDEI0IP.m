IBDEI0IP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8402,1,3,0)
 ;;=3^Carcinoma in situ of bladder
 ;;^UTILITY(U,$J,358.3,8402,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,8402,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,8403,0)
 ;;=D45.^^55^538^93
 ;;^UTILITY(U,$J,358.3,8403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8403,1,3,0)
 ;;=3^Polycythemia vera
 ;;^UTILITY(U,$J,358.3,8403,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,8403,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,8404,0)
 ;;=C94.40^^55^538^7
 ;;^UTILITY(U,$J,358.3,8404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8404,1,3,0)
 ;;=3^Acute panmyelosis w myelofibrosis not achieve remission
 ;;^UTILITY(U,$J,358.3,8404,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,8404,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,8405,0)
 ;;=C94.41^^55^538^8
 ;;^UTILITY(U,$J,358.3,8405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8405,1,3,0)
 ;;=3^Acute panmyelosis w myelofibrosis, in remission
 ;;^UTILITY(U,$J,358.3,8405,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,8405,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,8406,0)
 ;;=C94.42^^55^538^9
 ;;^UTILITY(U,$J,358.3,8406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8406,1,3,0)
 ;;=3^Acute panmyelosis w myelofibrosis, in relapse
 ;;^UTILITY(U,$J,358.3,8406,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,8406,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,8407,0)
 ;;=D47.1^^55^538^27
 ;;^UTILITY(U,$J,358.3,8407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8407,1,3,0)
 ;;=3^Chronic myeloproliferative disease
 ;;^UTILITY(U,$J,358.3,8407,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,8407,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,8408,0)
 ;;=D47.9^^55^538^90
 ;;^UTILITY(U,$J,358.3,8408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8408,1,3,0)
 ;;=3^Neoplm of uncrt behav of lymphoid,hematpoetc & rel tiss,unsp
 ;;^UTILITY(U,$J,358.3,8408,1,4,0)
 ;;=4^D47.9
 ;;^UTILITY(U,$J,358.3,8408,2)
 ;;=^5002260
 ;;^UTILITY(U,$J,358.3,8409,0)
 ;;=C88.0^^55^538^134
 ;;^UTILITY(U,$J,358.3,8409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8409,1,3,0)
 ;;=3^Waldenstrom macroglobulinemia
 ;;^UTILITY(U,$J,358.3,8409,1,4,0)
 ;;=4^C88.0
 ;;^UTILITY(U,$J,358.3,8409,2)
 ;;=^5001748
 ;;^UTILITY(U,$J,358.3,8410,0)
 ;;=D50.0^^55^538^41
 ;;^UTILITY(U,$J,358.3,8410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8410,1,3,0)
 ;;=3^Iron deficiency anemia secondary to blood loss (chronic)
 ;;^UTILITY(U,$J,358.3,8410,1,4,0)
 ;;=4^D50.0
 ;;^UTILITY(U,$J,358.3,8410,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,8411,0)
 ;;=D50.9^^55^538^42
 ;;^UTILITY(U,$J,358.3,8411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8411,1,3,0)
 ;;=3^Iron deficiency anemia, unspecified
 ;;^UTILITY(U,$J,358.3,8411,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,8411,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,8412,0)
 ;;=D51.0^^55^538^131
 ;;^UTILITY(U,$J,358.3,8412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8412,1,3,0)
 ;;=3^Vit B12 defic anemia d/t intrinsic factor deficiency
 ;;^UTILITY(U,$J,358.3,8412,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,8412,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,8413,0)
 ;;=D51.1^^55^538^132
 ;;^UTILITY(U,$J,358.3,8413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8413,1,3,0)
 ;;=3^Vit B12 defic anemia d/t slctv vit B12 malabsorp w protein
 ;;^UTILITY(U,$J,358.3,8413,1,4,0)
 ;;=4^D51.1
 ;;^UTILITY(U,$J,358.3,8413,2)
 ;;=^5002285
 ;;^UTILITY(U,$J,358.3,8414,0)
 ;;=D53.9^^55^538^91
 ;;^UTILITY(U,$J,358.3,8414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8414,1,3,0)
 ;;=3^Nutritional anemia, unspecified
 ;;^UTILITY(U,$J,358.3,8414,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,8414,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,8415,0)
 ;;=D57.1^^55^538^128
