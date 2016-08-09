IBDEI0BN ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11668,0)
 ;;=I73.9^^56^630^27
 ;;^UTILITY(U,$J,358.3,11668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11668,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,11668,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,11668,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,11669,0)
 ;;=I74.2^^56^630^21
 ;;^UTILITY(U,$J,358.3,11669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11669,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,11669,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,11669,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,11670,0)
 ;;=I74.3^^56^630^19
 ;;^UTILITY(U,$J,358.3,11670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11670,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,11670,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,11670,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,11671,0)
 ;;=I82.402^^56^630^18
 ;;^UTILITY(U,$J,358.3,11671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11671,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,11671,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,11671,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,11672,0)
 ;;=I82.401^^56^630^20
 ;;^UTILITY(U,$J,358.3,11672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11672,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,11672,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,11672,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,11673,0)
 ;;=I82.403^^56^630^17
 ;;^UTILITY(U,$J,358.3,11673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11673,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,11673,1,4,0)
 ;;=4^I82.403
 ;;^UTILITY(U,$J,358.3,11673,2)
 ;;=^5007856
 ;;^UTILITY(U,$J,358.3,11674,0)
 ;;=K70.30^^56^631^2
 ;;^UTILITY(U,$J,358.3,11674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11674,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,11674,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,11674,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,11675,0)
 ;;=K70.31^^56^631^1
 ;;^UTILITY(U,$J,358.3,11675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11675,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/ Ascites
 ;;^UTILITY(U,$J,358.3,11675,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,11675,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,11676,0)
 ;;=K74.60^^56^631^5
 ;;^UTILITY(U,$J,358.3,11676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11676,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,11676,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,11676,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,11677,0)
 ;;=K74.69^^56^631^4
 ;;^UTILITY(U,$J,358.3,11677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11677,1,3,0)
 ;;=3^Cirrhosis of Liver NEC
 ;;^UTILITY(U,$J,358.3,11677,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,11677,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,11678,0)
 ;;=K70.2^^56^631^3
 ;;^UTILITY(U,$J,358.3,11678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11678,1,3,0)
 ;;=3^Alcoholic Fibrosis/Sclerosis of Liver
 ;;^UTILITY(U,$J,358.3,11678,1,4,0)
 ;;=4^K70.2
 ;;^UTILITY(U,$J,358.3,11678,2)
 ;;=^5008787
 ;;^UTILITY(U,$J,358.3,11679,0)
 ;;=K74.0^^56^631^6
 ;;^UTILITY(U,$J,358.3,11679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11679,1,3,0)
 ;;=3^Hepatic Fibrosis
 ;;^UTILITY(U,$J,358.3,11679,1,4,0)
 ;;=4^K74.0
 ;;^UTILITY(U,$J,358.3,11679,2)
 ;;=^5008816
 ;;^UTILITY(U,$J,358.3,11680,0)
 ;;=K74.2^^56^631^7
 ;;^UTILITY(U,$J,358.3,11680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11680,1,3,0)
 ;;=3^Hepatic Fibrosis w/ Hepatic Sclerosis
 ;;^UTILITY(U,$J,358.3,11680,1,4,0)
 ;;=4^K74.2
 ;;^UTILITY(U,$J,358.3,11680,2)
 ;;=^5008818
 ;;^UTILITY(U,$J,358.3,11681,0)
 ;;=K74.1^^56^631^8
 ;;^UTILITY(U,$J,358.3,11681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11681,1,3,0)
 ;;=3^Hepatic Sclerosis
 ;;^UTILITY(U,$J,358.3,11681,1,4,0)
 ;;=4^K74.1
 ;;^UTILITY(U,$J,358.3,11681,2)
 ;;=^5008817
 ;;^UTILITY(U,$J,358.3,11682,0)
 ;;=K52.2^^56^632^1
 ;;^UTILITY(U,$J,358.3,11682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11682,1,3,0)
 ;;=3^Allergic/Dietetic Gastroenteritis/Colitis
 ;;^UTILITY(U,$J,358.3,11682,1,4,0)
 ;;=4^K52.2
 ;;^UTILITY(U,$J,358.3,11682,2)
 ;;=^5008701
 ;;^UTILITY(U,$J,358.3,11683,0)
 ;;=K52.89^^56^632^2
 ;;^UTILITY(U,$J,358.3,11683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11683,1,3,0)
 ;;=3^Noninfective Gastroenteritis/Colitis NEC
 ;;^UTILITY(U,$J,358.3,11683,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,11683,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,11684,0)
 ;;=K51.90^^56^632^9
 ;;^UTILITY(U,$J,358.3,11684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11684,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,11684,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,11684,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,11685,0)
 ;;=K51.919^^56^632^8
 ;;^UTILITY(U,$J,358.3,11685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11685,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,11685,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,11685,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,11686,0)
 ;;=K51.912^^56^632^5
 ;;^UTILITY(U,$J,358.3,11686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11686,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,11686,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,11686,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,11687,0)
 ;;=K51.913^^56^632^4
 ;;^UTILITY(U,$J,358.3,11687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11687,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,11687,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,11687,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,11688,0)
 ;;=K51.914^^56^632^3
 ;;^UTILITY(U,$J,358.3,11688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11688,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,11688,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,11688,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,11689,0)
 ;;=K51.918^^56^632^6
 ;;^UTILITY(U,$J,358.3,11689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11689,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complications,Unspec
 ;;^UTILITY(U,$J,358.3,11689,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,11689,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,11690,0)
 ;;=K51.911^^56^632^7
 ;;^UTILITY(U,$J,358.3,11690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11690,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,11690,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,11690,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,11691,0)
 ;;=K50.00^^56^633^11
 ;;^UTILITY(U,$J,358.3,11691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11691,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/o Complications
 ;;^UTILITY(U,$J,358.3,11691,1,4,0)
 ;;=4^K50.00
 ;;^UTILITY(U,$J,358.3,11691,2)
 ;;=^5008624
 ;;^UTILITY(U,$J,358.3,11692,0)
 ;;=K50.011^^56^633^9
 ;;^UTILITY(U,$J,358.3,11692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11692,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Rectal Bleeding
 ;;^UTILITY(U,$J,358.3,11692,1,4,0)
 ;;=4^K50.011
 ;;^UTILITY(U,$J,358.3,11692,2)
 ;;=^5008625
 ;;^UTILITY(U,$J,358.3,11693,0)
 ;;=K50.012^^56^633^7
 ;;^UTILITY(U,$J,358.3,11693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11693,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,11693,1,4,0)
 ;;=4^K50.012
 ;;^UTILITY(U,$J,358.3,11693,2)
 ;;=^5008626
 ;;^UTILITY(U,$J,358.3,11694,0)
 ;;=K50.013^^56^633^6
 ;;^UTILITY(U,$J,358.3,11694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11694,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Fistula
 ;;^UTILITY(U,$J,358.3,11694,1,4,0)
 ;;=4^K50.013
 ;;^UTILITY(U,$J,358.3,11694,2)
 ;;=^5008627
 ;;^UTILITY(U,$J,358.3,11695,0)
 ;;=K50.014^^56^633^5
