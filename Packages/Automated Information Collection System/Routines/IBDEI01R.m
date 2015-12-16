IBDEI01R ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,265,1,3,0)
 ;;=3^Vitamin B12 defic anemia due to intrinsic factor deficiency
 ;;^UTILITY(U,$J,358.3,265,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,265,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,266,0)
 ;;=D53.8^^2^12^31
 ;;^UTILITY(U,$J,358.3,266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,266,1,3,0)
 ;;=3^Nutritional Anemias NEC
 ;;^UTILITY(U,$J,358.3,266,1,4,0)
 ;;=4^D53.8
 ;;^UTILITY(U,$J,358.3,266,2)
 ;;=^5002297
 ;;^UTILITY(U,$J,358.3,267,0)
 ;;=D52.0^^2^12^16
 ;;^UTILITY(U,$J,358.3,267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,267,1,3,0)
 ;;=3^Dietary folate deficiency anemia
 ;;^UTILITY(U,$J,358.3,267,1,4,0)
 ;;=4^D52.0
 ;;^UTILITY(U,$J,358.3,267,2)
 ;;=^5002290
 ;;^UTILITY(U,$J,358.3,268,0)
 ;;=D52.1^^2^12^18
 ;;^UTILITY(U,$J,358.3,268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,268,1,3,0)
 ;;=3^Drug-induced folate deficiency anemia
 ;;^UTILITY(U,$J,358.3,268,1,4,0)
 ;;=4^D52.1
 ;;^UTILITY(U,$J,358.3,268,2)
 ;;=^5002291
 ;;^UTILITY(U,$J,358.3,269,0)
 ;;=D52.8^^2^12^21
 ;;^UTILITY(U,$J,358.3,269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,269,1,3,0)
 ;;=3^Folate deficiency anemias NEC
 ;;^UTILITY(U,$J,358.3,269,1,4,0)
 ;;=4^D52.8
 ;;^UTILITY(U,$J,358.3,269,2)
 ;;=^5002292
 ;;^UTILITY(U,$J,358.3,270,0)
 ;;=D52.9^^2^12^20
 ;;^UTILITY(U,$J,358.3,270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,270,1,3,0)
 ;;=3^Folate deficiency anemia, unspecified
 ;;^UTILITY(U,$J,358.3,270,1,4,0)
 ;;=4^D52.9
 ;;^UTILITY(U,$J,358.3,270,2)
 ;;=^5002293
 ;;^UTILITY(U,$J,358.3,271,0)
 ;;=D53.1^^2^12^28
 ;;^UTILITY(U,$J,358.3,271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,271,1,3,0)
 ;;=3^Megaloblastic Anemias NEC
 ;;^UTILITY(U,$J,358.3,271,1,4,0)
 ;;=4^D53.1
 ;;^UTILITY(U,$J,358.3,271,2)
 ;;=^5002295
 ;;^UTILITY(U,$J,358.3,272,0)
 ;;=D53.0^^2^12^35
 ;;^UTILITY(U,$J,358.3,272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,272,1,3,0)
 ;;=3^Protein deficiency anemia
 ;;^UTILITY(U,$J,358.3,272,1,4,0)
 ;;=4^D53.0
 ;;^UTILITY(U,$J,358.3,272,2)
 ;;=^5002294
 ;;^UTILITY(U,$J,358.3,273,0)
 ;;=D53.9^^2^12^32
 ;;^UTILITY(U,$J,358.3,273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,273,1,3,0)
 ;;=3^Nutritional anemia, unspecified
 ;;^UTILITY(U,$J,358.3,273,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,273,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,274,0)
 ;;=D57.40^^2^12^36
 ;;^UTILITY(U,$J,358.3,274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,274,1,3,0)
 ;;=3^Sickle-cell thalassemia without crisis
 ;;^UTILITY(U,$J,358.3,274,1,4,0)
 ;;=4^D57.40
 ;;^UTILITY(U,$J,358.3,274,2)
 ;;=^329908
 ;;^UTILITY(U,$J,358.3,275,0)
 ;;=D58.0^^2^12^26
 ;;^UTILITY(U,$J,358.3,275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,275,1,3,0)
 ;;=3^Hereditary spherocytosis
 ;;^UTILITY(U,$J,358.3,275,1,4,0)
 ;;=4^D58.0
 ;;^UTILITY(U,$J,358.3,275,2)
 ;;=^5002321
 ;;^UTILITY(U,$J,358.3,276,0)
 ;;=D58.1^^2^12^24
 ;;^UTILITY(U,$J,358.3,276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,276,1,3,0)
 ;;=3^Hereditary elliptocytosis
 ;;^UTILITY(U,$J,358.3,276,1,4,0)
 ;;=4^D58.1
 ;;^UTILITY(U,$J,358.3,276,2)
 ;;=^39378
 ;;^UTILITY(U,$J,358.3,277,0)
 ;;=D55.0^^2^12^5
 ;;^UTILITY(U,$J,358.3,277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,277,1,3,0)
 ;;=3^Anemia due to glucose-6-phosphate dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,277,1,4,0)
 ;;=4^D55.0
 ;;^UTILITY(U,$J,358.3,277,2)
 ;;=^5002299
 ;;^UTILITY(U,$J,358.3,278,0)
 ;;=D55.1^^2^12^6
 ;;^UTILITY(U,$J,358.3,278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,278,1,3,0)
 ;;=3^Anemia due to other disorders of glutathione metabolism
 ;;^UTILITY(U,$J,358.3,278,1,4,0)
 ;;=4^D55.1
