IBDEI26H ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36573,1,4,0)
 ;;=4^D53.0
 ;;^UTILITY(U,$J,358.3,36573,2)
 ;;=^5002294
 ;;^UTILITY(U,$J,358.3,36574,0)
 ;;=D53.9^^169^1850^35
 ;;^UTILITY(U,$J,358.3,36574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36574,1,3,0)
 ;;=3^Nutritional anemia, unspecified
 ;;^UTILITY(U,$J,358.3,36574,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,36574,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,36575,0)
 ;;=D57.40^^169^1850^39
 ;;^UTILITY(U,$J,358.3,36575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36575,1,3,0)
 ;;=3^Sickle-cell thalassemia without crisis
 ;;^UTILITY(U,$J,358.3,36575,1,4,0)
 ;;=4^D57.40
 ;;^UTILITY(U,$J,358.3,36575,2)
 ;;=^329908
 ;;^UTILITY(U,$J,358.3,36576,0)
 ;;=D58.0^^169^1850^29
 ;;^UTILITY(U,$J,358.3,36576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36576,1,3,0)
 ;;=3^Hereditary spherocytosis
 ;;^UTILITY(U,$J,358.3,36576,1,4,0)
 ;;=4^D58.0
 ;;^UTILITY(U,$J,358.3,36576,2)
 ;;=^5002321
 ;;^UTILITY(U,$J,358.3,36577,0)
 ;;=D58.1^^169^1850^26
 ;;^UTILITY(U,$J,358.3,36577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36577,1,3,0)
 ;;=3^Hereditary elliptocytosis
 ;;^UTILITY(U,$J,358.3,36577,1,4,0)
 ;;=4^D58.1
 ;;^UTILITY(U,$J,358.3,36577,2)
 ;;=^39378
 ;;^UTILITY(U,$J,358.3,36578,0)
 ;;=D55.0^^169^1850^5
 ;;^UTILITY(U,$J,358.3,36578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36578,1,3,0)
 ;;=3^Anemia due to glucose-6-phosphate dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,36578,1,4,0)
 ;;=4^D55.0
 ;;^UTILITY(U,$J,358.3,36578,2)
 ;;=^5002299
 ;;^UTILITY(U,$J,358.3,36579,0)
 ;;=D55.1^^169^1850^6
 ;;^UTILITY(U,$J,358.3,36579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36579,1,3,0)
 ;;=3^Anemia due to other disorders of glutathione metabolism
 ;;^UTILITY(U,$J,358.3,36579,1,4,0)
 ;;=4^D55.1
 ;;^UTILITY(U,$J,358.3,36579,2)
 ;;=^5002300
 ;;^UTILITY(U,$J,358.3,36580,0)
 ;;=D55.8^^169^1850^12
 ;;^UTILITY(U,$J,358.3,36580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36580,1,3,0)
 ;;=3^Anemias due to enzyme disorders
 ;;^UTILITY(U,$J,358.3,36580,1,4,0)
 ;;=4^D55.8
 ;;^UTILITY(U,$J,358.3,36580,2)
 ;;=^5002303
 ;;^UTILITY(U,$J,358.3,36581,0)
 ;;=D58.9^^169^1850^27
 ;;^UTILITY(U,$J,358.3,36581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36581,1,3,0)
 ;;=3^Hereditary hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,36581,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,36581,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,36582,0)
 ;;=D59.1^^169^1850^15
 ;;^UTILITY(U,$J,358.3,36582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36582,1,3,0)
 ;;=3^Autoimmune hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,36582,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,36582,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,36583,0)
 ;;=D59.0^^169^1850^17
 ;;^UTILITY(U,$J,358.3,36583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36583,1,3,0)
 ;;=3^Drug-induced autoimmune hemolytic anemia
 ;;^UTILITY(U,$J,358.3,36583,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,36583,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,36584,0)
 ;;=D59.3^^169^1850^25
 ;;^UTILITY(U,$J,358.3,36584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36584,1,3,0)
 ;;=3^Hemolytic-uremic syndrome
 ;;^UTILITY(U,$J,358.3,36584,1,4,0)
 ;;=4^D59.3
 ;;^UTILITY(U,$J,358.3,36584,2)
 ;;=^55823
 ;;^UTILITY(U,$J,358.3,36585,0)
 ;;=D59.4^^169^1850^33
 ;;^UTILITY(U,$J,358.3,36585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36585,1,3,0)
 ;;=3^Nonautoimmune hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,36585,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,36585,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,36586,0)
 ;;=D59.5^^169^1850^37
 ;;^UTILITY(U,$J,358.3,36586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36586,1,3,0)
 ;;=3^Paroxysmal nocturnal hemoglobinuria [Marchiafava-Micheli]
