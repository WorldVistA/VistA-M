IBDEI07N ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9656,1,3,0)
 ;;=3^Acute on Chronic Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,9656,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,9656,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,9657,0)
 ;;=I50.20^^37^529^28
 ;;^UTILITY(U,$J,358.3,9657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9657,1,3,0)
 ;;=3^Systolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,9657,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,9657,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,9658,0)
 ;;=I65.23^^37^529^23
 ;;^UTILITY(U,$J,358.3,9658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9658,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,9658,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,9658,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,9659,0)
 ;;=I65.22^^37^529^24
 ;;^UTILITY(U,$J,358.3,9659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9659,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,9659,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,9659,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,9660,0)
 ;;=I65.21^^37^529^26
 ;;^UTILITY(U,$J,358.3,9660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9660,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,9660,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,9660,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,9661,0)
 ;;=I65.8^^37^529^25
 ;;^UTILITY(U,$J,358.3,9661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9661,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,9661,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,9661,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,9662,0)
 ;;=I70.211^^37^529^11
 ;;^UTILITY(U,$J,358.3,9662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9662,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,9662,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,9662,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,9663,0)
 ;;=I70.212^^37^529^10
 ;;^UTILITY(U,$J,358.3,9663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9663,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,9663,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,9663,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,9664,0)
 ;;=I70.213^^37^529^9
 ;;^UTILITY(U,$J,358.3,9664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9664,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,9664,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,9664,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,9665,0)
 ;;=I71.2^^37^529^29
 ;;^UTILITY(U,$J,358.3,9665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9665,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,9665,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,9665,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,9666,0)
 ;;=I71.4^^37^529^1
 ;;^UTILITY(U,$J,358.3,9666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9666,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,9666,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,9666,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,9667,0)
 ;;=I73.9^^37^529^27
 ;;^UTILITY(U,$J,358.3,9667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9667,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,9667,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,9667,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,9668,0)
 ;;=I74.2^^37^529^21
 ;;^UTILITY(U,$J,358.3,9668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9668,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,9668,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,9668,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,9669,0)
 ;;=I74.3^^37^529^19
 ;;^UTILITY(U,$J,358.3,9669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9669,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,9669,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,9669,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,9670,0)
 ;;=I82.402^^37^529^18
 ;;^UTILITY(U,$J,358.3,9670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9670,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,9670,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,9670,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,9671,0)
 ;;=I82.401^^37^529^20
 ;;^UTILITY(U,$J,358.3,9671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9671,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,9671,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,9671,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,9672,0)
 ;;=I82.403^^37^529^17
 ;;^UTILITY(U,$J,358.3,9672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9672,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,9672,1,4,0)
 ;;=4^I82.403
 ;;^UTILITY(U,$J,358.3,9672,2)
 ;;=^5007856
 ;;^UTILITY(U,$J,358.3,9673,0)
 ;;=K70.30^^37^530^2
 ;;^UTILITY(U,$J,358.3,9673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9673,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,9673,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,9673,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,9674,0)
 ;;=K70.31^^37^530^1
 ;;^UTILITY(U,$J,358.3,9674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9674,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/ Ascites
 ;;^UTILITY(U,$J,358.3,9674,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,9674,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,9675,0)
 ;;=K74.60^^37^530^5
 ;;^UTILITY(U,$J,358.3,9675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9675,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,9675,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,9675,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,9676,0)
 ;;=K74.69^^37^530^4
 ;;^UTILITY(U,$J,358.3,9676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9676,1,3,0)
 ;;=3^Cirrhosis of Liver NEC
 ;;^UTILITY(U,$J,358.3,9676,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,9676,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,9677,0)
 ;;=K70.2^^37^530^3
 ;;^UTILITY(U,$J,358.3,9677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9677,1,3,0)
 ;;=3^Alcoholic Fibrosis/Sclerosis of Liver
 ;;^UTILITY(U,$J,358.3,9677,1,4,0)
 ;;=4^K70.2
 ;;^UTILITY(U,$J,358.3,9677,2)
 ;;=^5008787
 ;;^UTILITY(U,$J,358.3,9678,0)
 ;;=K74.0^^37^530^6
 ;;^UTILITY(U,$J,358.3,9678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9678,1,3,0)
 ;;=3^Hepatic Fibrosis
 ;;^UTILITY(U,$J,358.3,9678,1,4,0)
 ;;=4^K74.0
 ;;^UTILITY(U,$J,358.3,9678,2)
 ;;=^5008816
 ;;^UTILITY(U,$J,358.3,9679,0)
 ;;=K74.2^^37^530^7
 ;;^UTILITY(U,$J,358.3,9679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9679,1,3,0)
 ;;=3^Hepatic Fibrosis w/ Hepatic Sclerosis
 ;;^UTILITY(U,$J,358.3,9679,1,4,0)
 ;;=4^K74.2
 ;;^UTILITY(U,$J,358.3,9679,2)
 ;;=^5008818
 ;;^UTILITY(U,$J,358.3,9680,0)
 ;;=K74.1^^37^530^8
 ;;^UTILITY(U,$J,358.3,9680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9680,1,3,0)
 ;;=3^Hepatic Sclerosis
 ;;^UTILITY(U,$J,358.3,9680,1,4,0)
 ;;=4^K74.1
 ;;^UTILITY(U,$J,358.3,9680,2)
 ;;=^5008817
 ;;^UTILITY(U,$J,358.3,9681,0)
 ;;=K52.2^^37^531^1
 ;;^UTILITY(U,$J,358.3,9681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9681,1,3,0)
 ;;=3^Allergic/Dietetic Gastroenteritis/Colitis
 ;;^UTILITY(U,$J,358.3,9681,1,4,0)
 ;;=4^K52.2
 ;;^UTILITY(U,$J,358.3,9681,2)
 ;;=^5008701
 ;;^UTILITY(U,$J,358.3,9682,0)
 ;;=K52.89^^37^531^2
 ;;^UTILITY(U,$J,358.3,9682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9682,1,3,0)
 ;;=3^Noninfective Gastroenteritis/Colitis NEC
 ;;^UTILITY(U,$J,358.3,9682,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,9682,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,9683,0)
 ;;=K51.90^^37^531^9
 ;;^UTILITY(U,$J,358.3,9683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9683,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,9683,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,9683,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,9684,0)
 ;;=K51.919^^37^531^8
 ;;^UTILITY(U,$J,358.3,9684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9684,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,9684,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,9684,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,9685,0)
 ;;=K51.912^^37^531^5
 ;;^UTILITY(U,$J,358.3,9685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9685,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,9685,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,9685,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,9686,0)
 ;;=K51.913^^37^531^4
 ;;^UTILITY(U,$J,358.3,9686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9686,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,9686,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,9686,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,9687,0)
 ;;=K51.914^^37^531^3
 ;;^UTILITY(U,$J,358.3,9687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9687,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,9687,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,9687,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,9688,0)
 ;;=K51.918^^37^531^6
 ;;^UTILITY(U,$J,358.3,9688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9688,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complications,Unspec
 ;;^UTILITY(U,$J,358.3,9688,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,9688,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,9689,0)
 ;;=K51.911^^37^531^7
 ;;^UTILITY(U,$J,358.3,9689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9689,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,9689,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,9689,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,9690,0)
 ;;=K50.00^^37^532^11
 ;;^UTILITY(U,$J,358.3,9690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9690,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/o Complications
 ;;^UTILITY(U,$J,358.3,9690,1,4,0)
 ;;=4^K50.00
 ;;^UTILITY(U,$J,358.3,9690,2)
 ;;=^5008624
 ;;^UTILITY(U,$J,358.3,9691,0)
 ;;=K50.011^^37^532^9
 ;;^UTILITY(U,$J,358.3,9691,1,0)
 ;;=^358.31IA^4^2
