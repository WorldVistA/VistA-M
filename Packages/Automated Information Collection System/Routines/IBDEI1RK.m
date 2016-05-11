IBDEI1RK ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29980,0)
 ;;=D52.1^^118^1493^18
 ;;^UTILITY(U,$J,358.3,29980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29980,1,3,0)
 ;;=3^Drug-induced folate deficiency anemia
 ;;^UTILITY(U,$J,358.3,29980,1,4,0)
 ;;=4^D52.1
 ;;^UTILITY(U,$J,358.3,29980,2)
 ;;=^5002291
 ;;^UTILITY(U,$J,358.3,29981,0)
 ;;=D52.8^^118^1493^22
 ;;^UTILITY(U,$J,358.3,29981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29981,1,3,0)
 ;;=3^Folate deficiency anemias NEC
 ;;^UTILITY(U,$J,358.3,29981,1,4,0)
 ;;=4^D52.8
 ;;^UTILITY(U,$J,358.3,29981,2)
 ;;=^5002292
 ;;^UTILITY(U,$J,358.3,29982,0)
 ;;=D52.9^^118^1493^21
 ;;^UTILITY(U,$J,358.3,29982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29982,1,3,0)
 ;;=3^Folate deficiency anemia, unspecified
 ;;^UTILITY(U,$J,358.3,29982,1,4,0)
 ;;=4^D52.9
 ;;^UTILITY(U,$J,358.3,29982,2)
 ;;=^5002293
 ;;^UTILITY(U,$J,358.3,29983,0)
 ;;=D53.1^^118^1493^31
 ;;^UTILITY(U,$J,358.3,29983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29983,1,3,0)
 ;;=3^Megaloblastic Anemias NEC
 ;;^UTILITY(U,$J,358.3,29983,1,4,0)
 ;;=4^D53.1
 ;;^UTILITY(U,$J,358.3,29983,2)
 ;;=^5002295
 ;;^UTILITY(U,$J,358.3,29984,0)
 ;;=D53.0^^118^1493^38
 ;;^UTILITY(U,$J,358.3,29984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29984,1,3,0)
 ;;=3^Protein deficiency anemia
 ;;^UTILITY(U,$J,358.3,29984,1,4,0)
 ;;=4^D53.0
 ;;^UTILITY(U,$J,358.3,29984,2)
 ;;=^5002294
 ;;^UTILITY(U,$J,358.3,29985,0)
 ;;=D53.9^^118^1493^35
 ;;^UTILITY(U,$J,358.3,29985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29985,1,3,0)
 ;;=3^Nutritional anemia, unspecified
 ;;^UTILITY(U,$J,358.3,29985,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,29985,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,29986,0)
 ;;=D57.40^^118^1493^39
 ;;^UTILITY(U,$J,358.3,29986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29986,1,3,0)
 ;;=3^Sickle-cell thalassemia without crisis
 ;;^UTILITY(U,$J,358.3,29986,1,4,0)
 ;;=4^D57.40
 ;;^UTILITY(U,$J,358.3,29986,2)
 ;;=^329908
 ;;^UTILITY(U,$J,358.3,29987,0)
 ;;=D58.0^^118^1493^29
 ;;^UTILITY(U,$J,358.3,29987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29987,1,3,0)
 ;;=3^Hereditary spherocytosis
 ;;^UTILITY(U,$J,358.3,29987,1,4,0)
 ;;=4^D58.0
 ;;^UTILITY(U,$J,358.3,29987,2)
 ;;=^5002321
 ;;^UTILITY(U,$J,358.3,29988,0)
 ;;=D58.1^^118^1493^26
 ;;^UTILITY(U,$J,358.3,29988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29988,1,3,0)
 ;;=3^Hereditary elliptocytosis
 ;;^UTILITY(U,$J,358.3,29988,1,4,0)
 ;;=4^D58.1
 ;;^UTILITY(U,$J,358.3,29988,2)
 ;;=^39378
 ;;^UTILITY(U,$J,358.3,29989,0)
 ;;=D55.0^^118^1493^5
 ;;^UTILITY(U,$J,358.3,29989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29989,1,3,0)
 ;;=3^Anemia due to glucose-6-phosphate dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,29989,1,4,0)
 ;;=4^D55.0
 ;;^UTILITY(U,$J,358.3,29989,2)
 ;;=^5002299
 ;;^UTILITY(U,$J,358.3,29990,0)
 ;;=D55.1^^118^1493^6
 ;;^UTILITY(U,$J,358.3,29990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29990,1,3,0)
 ;;=3^Anemia due to other disorders of glutathione metabolism
 ;;^UTILITY(U,$J,358.3,29990,1,4,0)
 ;;=4^D55.1
 ;;^UTILITY(U,$J,358.3,29990,2)
 ;;=^5002300
 ;;^UTILITY(U,$J,358.3,29991,0)
 ;;=D55.8^^118^1493^12
 ;;^UTILITY(U,$J,358.3,29991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29991,1,3,0)
 ;;=3^Anemias due to enzyme disorders
 ;;^UTILITY(U,$J,358.3,29991,1,4,0)
 ;;=4^D55.8
 ;;^UTILITY(U,$J,358.3,29991,2)
 ;;=^5002303
 ;;^UTILITY(U,$J,358.3,29992,0)
 ;;=D58.9^^118^1493^27
 ;;^UTILITY(U,$J,358.3,29992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29992,1,3,0)
 ;;=3^Hereditary hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,29992,1,4,0)
 ;;=4^D58.9
