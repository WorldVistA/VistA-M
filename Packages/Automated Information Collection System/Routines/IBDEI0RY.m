IBDEI0RY ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28105,1,3,0)
 ;;=3^Megaloblastic Anemias NEC
 ;;^UTILITY(U,$J,358.3,28105,1,4,0)
 ;;=4^D53.1
 ;;^UTILITY(U,$J,358.3,28105,2)
 ;;=^5002295
 ;;^UTILITY(U,$J,358.3,28106,0)
 ;;=D53.0^^105^1369^38
 ;;^UTILITY(U,$J,358.3,28106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28106,1,3,0)
 ;;=3^Protein deficiency anemia
 ;;^UTILITY(U,$J,358.3,28106,1,4,0)
 ;;=4^D53.0
 ;;^UTILITY(U,$J,358.3,28106,2)
 ;;=^5002294
 ;;^UTILITY(U,$J,358.3,28107,0)
 ;;=D53.9^^105^1369^35
 ;;^UTILITY(U,$J,358.3,28107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28107,1,3,0)
 ;;=3^Nutritional anemia, unspecified
 ;;^UTILITY(U,$J,358.3,28107,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,28107,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,28108,0)
 ;;=D57.40^^105^1369^39
 ;;^UTILITY(U,$J,358.3,28108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28108,1,3,0)
 ;;=3^Sickle-cell thalassemia without crisis
 ;;^UTILITY(U,$J,358.3,28108,1,4,0)
 ;;=4^D57.40
 ;;^UTILITY(U,$J,358.3,28108,2)
 ;;=^329908
 ;;^UTILITY(U,$J,358.3,28109,0)
 ;;=D58.0^^105^1369^29
 ;;^UTILITY(U,$J,358.3,28109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28109,1,3,0)
 ;;=3^Hereditary spherocytosis
 ;;^UTILITY(U,$J,358.3,28109,1,4,0)
 ;;=4^D58.0
 ;;^UTILITY(U,$J,358.3,28109,2)
 ;;=^5002321
 ;;^UTILITY(U,$J,358.3,28110,0)
 ;;=D58.1^^105^1369^26
 ;;^UTILITY(U,$J,358.3,28110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28110,1,3,0)
 ;;=3^Hereditary elliptocytosis
 ;;^UTILITY(U,$J,358.3,28110,1,4,0)
 ;;=4^D58.1
 ;;^UTILITY(U,$J,358.3,28110,2)
 ;;=^39378
 ;;^UTILITY(U,$J,358.3,28111,0)
 ;;=D55.0^^105^1369^5
 ;;^UTILITY(U,$J,358.3,28111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28111,1,3,0)
 ;;=3^Anemia due to glucose-6-phosphate dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,28111,1,4,0)
 ;;=4^D55.0
 ;;^UTILITY(U,$J,358.3,28111,2)
 ;;=^5002299
 ;;^UTILITY(U,$J,358.3,28112,0)
 ;;=D55.1^^105^1369^6
 ;;^UTILITY(U,$J,358.3,28112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28112,1,3,0)
 ;;=3^Anemia due to other disorders of glutathione metabolism
 ;;^UTILITY(U,$J,358.3,28112,1,4,0)
 ;;=4^D55.1
 ;;^UTILITY(U,$J,358.3,28112,2)
 ;;=^5002300
 ;;^UTILITY(U,$J,358.3,28113,0)
 ;;=D55.8^^105^1369^12
 ;;^UTILITY(U,$J,358.3,28113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28113,1,3,0)
 ;;=3^Anemias due to enzyme disorders
 ;;^UTILITY(U,$J,358.3,28113,1,4,0)
 ;;=4^D55.8
 ;;^UTILITY(U,$J,358.3,28113,2)
 ;;=^5002303
 ;;^UTILITY(U,$J,358.3,28114,0)
 ;;=D58.9^^105^1369^27
 ;;^UTILITY(U,$J,358.3,28114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28114,1,3,0)
 ;;=3^Hereditary hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,28114,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,28114,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,28115,0)
 ;;=D59.1^^105^1369^15
 ;;^UTILITY(U,$J,358.3,28115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28115,1,3,0)
 ;;=3^Autoimmune hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,28115,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,28115,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,28116,0)
 ;;=D59.0^^105^1369^17
 ;;^UTILITY(U,$J,358.3,28116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28116,1,3,0)
 ;;=3^Drug-induced autoimmune hemolytic anemia
 ;;^UTILITY(U,$J,358.3,28116,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,28116,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,28117,0)
 ;;=D59.3^^105^1369^25
 ;;^UTILITY(U,$J,358.3,28117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28117,1,3,0)
 ;;=3^Hemolytic-uremic syndrome
 ;;^UTILITY(U,$J,358.3,28117,1,4,0)
 ;;=4^D59.3
 ;;^UTILITY(U,$J,358.3,28117,2)
 ;;=^55823
 ;;^UTILITY(U,$J,358.3,28118,0)
 ;;=D59.4^^105^1369^33
 ;;^UTILITY(U,$J,358.3,28118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28118,1,3,0)
 ;;=3^Nonautoimmune hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,28118,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,28118,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,28119,0)
 ;;=D59.5^^105^1369^37
 ;;^UTILITY(U,$J,358.3,28119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28119,1,3,0)
 ;;=3^Paroxysmal nocturnal hemoglobinuria [Marchiafava-Micheli]
 ;;^UTILITY(U,$J,358.3,28119,1,4,0)
 ;;=4^D59.5
 ;;^UTILITY(U,$J,358.3,28119,2)
 ;;=^5002327
 ;;^UTILITY(U,$J,358.3,28120,0)
 ;;=D59.6^^105^1369^24
 ;;^UTILITY(U,$J,358.3,28120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28120,1,3,0)
 ;;=3^Hemoglobinuria due to hemolysis from other external causes
 ;;^UTILITY(U,$J,358.3,28120,1,4,0)
 ;;=4^D59.6
 ;;^UTILITY(U,$J,358.3,28120,2)
 ;;=^5002328
 ;;^UTILITY(U,$J,358.3,28121,0)
 ;;=D59.8^^105^1369^2
 ;;^UTILITY(U,$J,358.3,28121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28121,1,3,0)
 ;;=3^Acquired hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,28121,1,4,0)
 ;;=4^D59.8
 ;;^UTILITY(U,$J,358.3,28121,2)
 ;;=^5002329
 ;;^UTILITY(U,$J,358.3,28122,0)
 ;;=D59.9^^105^1369^1
 ;;^UTILITY(U,$J,358.3,28122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28122,1,3,0)
 ;;=3^Acquired hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,28122,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,28122,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,28123,0)
 ;;=D61.810^^105^1369^13
 ;;^UTILITY(U,$J,358.3,28123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28123,1,3,0)
 ;;=3^Antineoplastic chemotherapy induced pancytopenia
 ;;^UTILITY(U,$J,358.3,28123,1,4,0)
 ;;=4^D61.810
 ;;^UTILITY(U,$J,358.3,28123,2)
 ;;=^5002339
 ;;^UTILITY(U,$J,358.3,28124,0)
 ;;=D61.811^^105^1369^20
 ;;^UTILITY(U,$J,358.3,28124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28124,1,3,0)
 ;;=3^Drug-induced pancytopenia NEC
 ;;^UTILITY(U,$J,358.3,28124,1,4,0)
 ;;=4^D61.811
 ;;^UTILITY(U,$J,358.3,28124,2)
 ;;=^5002340
 ;;^UTILITY(U,$J,358.3,28125,0)
 ;;=D61.818^^105^1369^36
 ;;^UTILITY(U,$J,358.3,28125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28125,1,3,0)
 ;;=3^Pancytopenia NEC
 ;;^UTILITY(U,$J,358.3,28125,1,4,0)
 ;;=4^D61.818
 ;;^UTILITY(U,$J,358.3,28125,2)
 ;;=^340501
 ;;^UTILITY(U,$J,358.3,28126,0)
 ;;=D61.82^^105^1369^32
 ;;^UTILITY(U,$J,358.3,28126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28126,1,3,0)
 ;;=3^Myelophthisis
 ;;^UTILITY(U,$J,358.3,28126,1,4,0)
 ;;=4^D61.82
 ;;^UTILITY(U,$J,358.3,28126,2)
 ;;=^334037
 ;;^UTILITY(U,$J,358.3,28127,0)
 ;;=D61.9^^105^1369^14
 ;;^UTILITY(U,$J,358.3,28127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28127,1,3,0)
 ;;=3^Aplastic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,28127,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,28127,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,28128,0)
 ;;=D62.^^105^1369^3
 ;;^UTILITY(U,$J,358.3,28128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28128,1,3,0)
 ;;=3^Acute posthemorrhagic anemia
 ;;^UTILITY(U,$J,358.3,28128,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,28128,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,28129,0)
 ;;=D63.1^^105^1369^7
 ;;^UTILITY(U,$J,358.3,28129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28129,1,3,0)
 ;;=3^Anemia in chronic kidney disease
 ;;^UTILITY(U,$J,358.3,28129,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,28129,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,28130,0)
 ;;=D63.0^^105^1369^8
 ;;^UTILITY(U,$J,358.3,28130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28130,1,3,0)
 ;;=3^Anemia in neoplastic disease
 ;;^UTILITY(U,$J,358.3,28130,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,28130,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,28131,0)
 ;;=D63.8^^105^1369^9
 ;;^UTILITY(U,$J,358.3,28131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28131,1,3,0)
 ;;=3^Anemia in other chronic diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,28131,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,28131,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,28132,0)
 ;;=D64.81^^105^1369^4
 ;;^UTILITY(U,$J,358.3,28132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28132,1,3,0)
 ;;=3^Anemia due to antineoplastic chemotherapy
 ;;^UTILITY(U,$J,358.3,28132,1,4,0)
 ;;=4^D64.81
 ;;^UTILITY(U,$J,358.3,28132,2)
 ;;=^5002349
