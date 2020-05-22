IBDEI028 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5018,0)
 ;;=R10.2^^34^305^17
 ;;^UTILITY(U,$J,358.3,5018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5018,1,3,0)
 ;;=3^Pelvic and perineal pain
 ;;^UTILITY(U,$J,358.3,5018,1,4,0)
 ;;=4^R10.2
 ;;^UTILITY(U,$J,358.3,5018,2)
 ;;=^5019209
 ;;^UTILITY(U,$J,358.3,5019,0)
 ;;=N50.811^^34^305^21
 ;;^UTILITY(U,$J,358.3,5019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5019,1,3,0)
 ;;=3^Testicular Pain,Right
 ;;^UTILITY(U,$J,358.3,5019,1,4,0)
 ;;=4^N50.811
 ;;^UTILITY(U,$J,358.3,5019,2)
 ;;=^5138927
 ;;^UTILITY(U,$J,358.3,5020,0)
 ;;=N50.812^^34^305^20
 ;;^UTILITY(U,$J,358.3,5020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5020,1,3,0)
 ;;=3^Testicular Pain,Left
 ;;^UTILITY(U,$J,358.3,5020,1,4,0)
 ;;=4^N50.812
 ;;^UTILITY(U,$J,358.3,5020,2)
 ;;=^5138928
 ;;^UTILITY(U,$J,358.3,5021,0)
 ;;=N50.82^^34^305^19
 ;;^UTILITY(U,$J,358.3,5021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5021,1,3,0)
 ;;=3^Scrotal Pain
 ;;^UTILITY(U,$J,358.3,5021,1,4,0)
 ;;=4^N50.82
 ;;^UTILITY(U,$J,358.3,5021,2)
 ;;=^5138930
 ;;^UTILITY(U,$J,358.3,5022,0)
 ;;=N50.89^^34^305^11
 ;;^UTILITY(U,$J,358.3,5022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5022,1,3,0)
 ;;=3^Male Genital Organ Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,5022,1,4,0)
 ;;=4^N50.89
 ;;^UTILITY(U,$J,358.3,5022,2)
 ;;=^5138931
 ;;^UTILITY(U,$J,358.3,5023,0)
 ;;=Z85.810^^34^306^21
 ;;^UTILITY(U,$J,358.3,5023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5023,1,3,0)
 ;;=3^Personal hx of malig neop of tongue
 ;;^UTILITY(U,$J,358.3,5023,1,4,0)
 ;;=4^Z85.810
 ;;^UTILITY(U,$J,358.3,5023,2)
 ;;=^5063438
 ;;^UTILITY(U,$J,358.3,5024,0)
 ;;=Z85.05^^34^306^12
 ;;^UTILITY(U,$J,358.3,5024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5024,1,3,0)
 ;;=3^Personal hx of malig neop of liver
 ;;^UTILITY(U,$J,358.3,5024,1,4,0)
 ;;=4^Z85.05
 ;;^UTILITY(U,$J,358.3,5024,2)
 ;;=^5063402
 ;;^UTILITY(U,$J,358.3,5025,0)
 ;;=Z85.068^^34^306^19
 ;;^UTILITY(U,$J,358.3,5025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5025,1,3,0)
 ;;=3^Personal hx of malig neop of small intestine
 ;;^UTILITY(U,$J,358.3,5025,1,4,0)
 ;;=4^Z85.068
 ;;^UTILITY(U,$J,358.3,5025,2)
 ;;=^5063404
 ;;^UTILITY(U,$J,358.3,5026,0)
 ;;=Z85.07^^34^306^17
 ;;^UTILITY(U,$J,358.3,5026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5026,1,3,0)
 ;;=3^Personal hx of malig neop of pancreas
 ;;^UTILITY(U,$J,358.3,5026,1,4,0)
 ;;=4^Z85.07
 ;;^UTILITY(U,$J,358.3,5026,2)
 ;;=^5063405
 ;;^UTILITY(U,$J,358.3,5027,0)
 ;;=Z85.09^^34^306^9
 ;;^UTILITY(U,$J,358.3,5027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5027,1,3,0)
 ;;=3^Personal hx of malig neop of digestive organs
 ;;^UTILITY(U,$J,358.3,5027,1,4,0)
 ;;=4^Z85.09
 ;;^UTILITY(U,$J,358.3,5027,2)
 ;;=^5063406
 ;;^UTILITY(U,$J,358.3,5028,0)
 ;;=Z85.12^^34^306^22
 ;;^UTILITY(U,$J,358.3,5028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5028,1,3,0)
 ;;=3^Personal hx of malig neop of trachea
 ;;^UTILITY(U,$J,358.3,5028,1,4,0)
 ;;=4^Z85.12
 ;;^UTILITY(U,$J,358.3,5028,2)
 ;;=^5063409
 ;;^UTILITY(U,$J,358.3,5029,0)
 ;;=Z85.22^^34^306^14
 ;;^UTILITY(U,$J,358.3,5029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5029,1,3,0)
 ;;=3^Personal hx of malig neop of nasl cav,med ear,acces
 ;;^UTILITY(U,$J,358.3,5029,1,4,0)
 ;;=4^Z85.22
 ;;^UTILITY(U,$J,358.3,5029,2)
 ;;=^5063412
 ;;^UTILITY(U,$J,358.3,5030,0)
 ;;=Z85.41^^34^306^8
 ;;^UTILITY(U,$J,358.3,5030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5030,1,3,0)
 ;;=3^Personal hx of malig neop of cervix uteri
 ;;^UTILITY(U,$J,358.3,5030,1,4,0)
 ;;=4^Z85.41
 ;;^UTILITY(U,$J,358.3,5030,2)
 ;;=^5063418
 ;;^UTILITY(U,$J,358.3,5031,0)
 ;;=Z85.42^^34^306^16
 ;;^UTILITY(U,$J,358.3,5031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5031,1,3,0)
 ;;=3^Personal hx of malig neop of oth prt uterus
 ;;^UTILITY(U,$J,358.3,5031,1,4,0)
 ;;=4^Z85.42
 ;;^UTILITY(U,$J,358.3,5031,2)
 ;;=^5063419
 ;;^UTILITY(U,$J,358.3,5032,0)
 ;;=Z85.48^^34^306^11
 ;;^UTILITY(U,$J,358.3,5032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5032,1,3,0)
 ;;=3^Personal hx of malig neop of epididymis
 ;;^UTILITY(U,$J,358.3,5032,1,4,0)
 ;;=4^Z85.48
 ;;^UTILITY(U,$J,358.3,5032,2)
 ;;=^5063425
 ;;^UTILITY(U,$J,358.3,5033,0)
 ;;=Z85.54^^34^306^23
 ;;^UTILITY(U,$J,358.3,5033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5033,1,3,0)
 ;;=3^Personal hx of malig neop of ureter
 ;;^UTILITY(U,$J,358.3,5033,1,4,0)
 ;;=4^Z85.54
 ;;^UTILITY(U,$J,358.3,5033,2)
 ;;=^5063432
 ;;^UTILITY(U,$J,358.3,5034,0)
 ;;=Z85.59^^34^306^24
 ;;^UTILITY(U,$J,358.3,5034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5034,1,3,0)
 ;;=3^Personal hx of malig neop of urinary tract organ
 ;;^UTILITY(U,$J,358.3,5034,1,4,0)
 ;;=4^Z85.59
 ;;^UTILITY(U,$J,358.3,5034,2)
 ;;=^5063433
 ;;^UTILITY(U,$J,358.3,5035,0)
 ;;=Z85.6^^34^306^5
 ;;^UTILITY(U,$J,358.3,5035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5035,1,3,0)
 ;;=3^Personal hx of leukemia
 ;;^UTILITY(U,$J,358.3,5035,1,4,0)
 ;;=4^Z85.6
 ;;^UTILITY(U,$J,358.3,5035,2)
 ;;=^5063434
 ;;^UTILITY(U,$J,358.3,5036,0)
 ;;=Z85.79^^34^306^13
 ;;^UTILITY(U,$J,358.3,5036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5036,1,3,0)
 ;;=3^Personal hx of malig neop of lymphoid,hematpoetc
 ;;^UTILITY(U,$J,358.3,5036,1,4,0)
 ;;=4^Z85.79
 ;;^UTILITY(U,$J,358.3,5036,2)
 ;;=^5063437
 ;;^UTILITY(U,$J,358.3,5037,0)
 ;;=Z85.71^^34^306^1
 ;;^UTILITY(U,$J,358.3,5037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5037,1,3,0)
 ;;=3^Personal hx of Hodgkin lymphoma
 ;;^UTILITY(U,$J,358.3,5037,1,4,0)
 ;;=4^Z85.71
 ;;^UTILITY(U,$J,358.3,5037,2)
 ;;=^5063435
 ;;^UTILITY(U,$J,358.3,5038,0)
 ;;=Z85.830^^34^306^6
 ;;^UTILITY(U,$J,358.3,5038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5038,1,3,0)
 ;;=3^Personal hx of malig neop of bone
 ;;^UTILITY(U,$J,358.3,5038,1,4,0)
 ;;=4^Z85.830
 ;;^UTILITY(U,$J,358.3,5038,2)
 ;;=^5063444
 ;;^UTILITY(U,$J,358.3,5039,0)
 ;;=Z85.828^^34^306^18
 ;;^UTILITY(U,$J,358.3,5039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5039,1,3,0)
 ;;=3^Personal hx of malig neop of skin NEC 
 ;;^UTILITY(U,$J,358.3,5039,1,4,0)
 ;;=4^Z85.828
 ;;^UTILITY(U,$J,358.3,5039,2)
 ;;=^5063443
 ;;^UTILITY(U,$J,358.3,5040,0)
 ;;=Z85.841^^34^306^7
 ;;^UTILITY(U,$J,358.3,5040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5040,1,3,0)
 ;;=3^Personal hx of malig neop of brain
 ;;^UTILITY(U,$J,358.3,5040,1,4,0)
 ;;=4^Z85.841
 ;;^UTILITY(U,$J,358.3,5040,2)
 ;;=^5063447
 ;;^UTILITY(U,$J,358.3,5041,0)
 ;;=Z85.848^^34^306^15
 ;;^UTILITY(U,$J,358.3,5041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5041,1,3,0)
 ;;=3^Personal hx of malig neop of nervous tissue
 ;;^UTILITY(U,$J,358.3,5041,1,4,0)
 ;;=4^Z85.848
 ;;^UTILITY(U,$J,358.3,5041,2)
 ;;=^5063448
 ;;^UTILITY(U,$J,358.3,5042,0)
 ;;=Z85.850^^34^306^20
 ;;^UTILITY(U,$J,358.3,5042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5042,1,3,0)
 ;;=3^Personal hx of malig neop of thyroid
 ;;^UTILITY(U,$J,358.3,5042,1,4,0)
 ;;=4^Z85.850
 ;;^UTILITY(U,$J,358.3,5042,2)
 ;;=^5063449
 ;;^UTILITY(U,$J,358.3,5043,0)
 ;;=Z85.858^^34^306^10
 ;;^UTILITY(U,$J,358.3,5043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5043,1,3,0)
 ;;=3^Personal hx of malig neop of endocrine glands
 ;;^UTILITY(U,$J,358.3,5043,1,4,0)
 ;;=4^Z85.858
 ;;^UTILITY(U,$J,358.3,5043,2)
 ;;=^5063450
 ;;^UTILITY(U,$J,358.3,5044,0)
 ;;=Z86.61^^34^306^2
 ;;^UTILITY(U,$J,358.3,5044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5044,1,3,0)
 ;;=3^Personal hx of central nervous system infections
 ;;^UTILITY(U,$J,358.3,5044,1,4,0)
 ;;=4^Z86.61
 ;;^UTILITY(U,$J,358.3,5044,2)
 ;;=^5063472
 ;;^UTILITY(U,$J,358.3,5045,0)
 ;;=Z87.09^^34^306^27
 ;;^UTILITY(U,$J,358.3,5045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5045,1,3,0)
 ;;=3^Personal hx of respiratory system diseases NEC
 ;;^UTILITY(U,$J,358.3,5045,1,4,0)
 ;;=4^Z87.09
 ;;^UTILITY(U,$J,358.3,5045,2)
 ;;=^5063481
 ;;^UTILITY(U,$J,358.3,5046,0)
 ;;=Z87.01^^34^306^26
 ;;^UTILITY(U,$J,358.3,5046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5046,1,3,0)
 ;;=3^Personal hx of pneumonia (recurrent)
 ;;^UTILITY(U,$J,358.3,5046,1,4,0)
 ;;=4^Z87.01
 ;;^UTILITY(U,$J,358.3,5046,2)
 ;;=^5063480
 ;;^UTILITY(U,$J,358.3,5047,0)
 ;;=Z86.010^^34^306^3
 ;;^UTILITY(U,$J,358.3,5047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5047,1,3,0)
 ;;=3^Personal hx of colonic polyps
 ;;^UTILITY(U,$J,358.3,5047,1,4,0)
 ;;=4^Z86.010
 ;;^UTILITY(U,$J,358.3,5047,2)
 ;;=^5063456
 ;;^UTILITY(U,$J,358.3,5048,0)
 ;;=Z87.440^^34^306^28
 ;;^UTILITY(U,$J,358.3,5048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5048,1,3,0)
 ;;=3^Personal hx of urinary tract infections
 ;;^UTILITY(U,$J,358.3,5048,1,4,0)
 ;;=4^Z87.440
 ;;^UTILITY(U,$J,358.3,5048,2)
 ;;=^5063495
 ;;^UTILITY(U,$J,358.3,5049,0)
 ;;=Z87.441^^34^306^25
 ;;^UTILITY(U,$J,358.3,5049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5049,1,3,0)
 ;;=3^Personal hx of nephrotic syndrome
 ;;^UTILITY(U,$J,358.3,5049,1,4,0)
 ;;=4^Z87.441
 ;;^UTILITY(U,$J,358.3,5049,2)
 ;;=^5063496
 ;;^UTILITY(U,$J,358.3,5050,0)
 ;;=Z91.81^^34^306^4
 ;;^UTILITY(U,$J,358.3,5050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5050,1,3,0)
 ;;=3^Personal hx of falling
 ;;^UTILITY(U,$J,358.3,5050,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,5050,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,5051,0)
 ;;=R09.1^^34^307^6
 ;;^UTILITY(U,$J,358.3,5051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5051,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,5051,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,5051,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,5052,0)
 ;;=J91.0^^34^307^3
 ;;^UTILITY(U,$J,358.3,5052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5052,1,3,0)
 ;;=3^Malignant pleural effusion
 ;;^UTILITY(U,$J,358.3,5052,1,4,0)
 ;;=4^J91.0
 ;;^UTILITY(U,$J,358.3,5052,2)
 ;;=^336603
 ;;^UTILITY(U,$J,358.3,5053,0)
 ;;=J90.^^34^307^5
 ;;^UTILITY(U,$J,358.3,5053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5053,1,3,0)
 ;;=3^Pleural effusion, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,5053,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,5053,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,5054,0)
 ;;=J91.8^^34^307^4
 ;;^UTILITY(U,$J,358.3,5054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5054,1,3,0)
 ;;=3^Pleural effusion in other conditions classified elsewhere
 ;;^UTILITY(U,$J,358.3,5054,1,4,0)
 ;;=4^J91.8
 ;;^UTILITY(U,$J,358.3,5054,2)
 ;;=^5008311
 ;;^UTILITY(U,$J,358.3,5055,0)
 ;;=J93.0^^34^307^10
 ;;^UTILITY(U,$J,358.3,5055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5055,1,3,0)
 ;;=3^Spontaneous tension pneumothorax
 ;;^UTILITY(U,$J,358.3,5055,1,4,0)
 ;;=4^J93.0
 ;;^UTILITY(U,$J,358.3,5055,2)
 ;;=^269987
 ;;^UTILITY(U,$J,358.3,5056,0)
 ;;=J93.11^^34^307^8
 ;;^UTILITY(U,$J,358.3,5056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5056,1,3,0)
 ;;=3^Primary spontaneous pneumothorax
 ;;^UTILITY(U,$J,358.3,5056,1,4,0)
 ;;=4^J93.11
 ;;^UTILITY(U,$J,358.3,5056,2)
 ;;=^340529
 ;;^UTILITY(U,$J,358.3,5057,0)
 ;;=J93.12^^34^307^9
 ;;^UTILITY(U,$J,358.3,5057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5057,1,3,0)
 ;;=3^Secondary spontaneous pneumothorax
 ;;^UTILITY(U,$J,358.3,5057,1,4,0)
 ;;=4^J93.12
 ;;^UTILITY(U,$J,358.3,5057,2)
 ;;=^340530
 ;;^UTILITY(U,$J,358.3,5058,0)
 ;;=J93.81^^34^307^2
 ;;^UTILITY(U,$J,358.3,5058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5058,1,3,0)
 ;;=3^Chronic pneumothorax
 ;;^UTILITY(U,$J,358.3,5058,1,4,0)
 ;;=4^J93.81
 ;;^UTILITY(U,$J,358.3,5058,2)
 ;;=^340531
 ;;^UTILITY(U,$J,358.3,5059,0)
 ;;=J93.82^^34^307^1
 ;;^UTILITY(U,$J,358.3,5059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5059,1,3,0)
 ;;=3^Air Leak NEC
 ;;^UTILITY(U,$J,358.3,5059,1,4,0)
 ;;=4^J93.82
 ;;^UTILITY(U,$J,358.3,5059,2)
 ;;=^5008314
 ;;^UTILITY(U,$J,358.3,5060,0)
 ;;=J93.9^^34^307^7
 ;;^UTILITY(U,$J,358.3,5060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5060,1,3,0)
 ;;=3^Pneumothorax, unspecified
 ;;^UTILITY(U,$J,358.3,5060,1,4,0)
 ;;=4^J93.9
 ;;^UTILITY(U,$J,358.3,5060,2)
 ;;=^5008315
 ;;^UTILITY(U,$J,358.3,5061,0)
 ;;=J12.9^^34^308^11
 ;;^UTILITY(U,$J,358.3,5061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5061,1,3,0)
 ;;=3^Viral pneumonia, unspecified
 ;;^UTILITY(U,$J,358.3,5061,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,5061,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,5062,0)
 ;;=J13.^^34^308^7
 ;;^UTILITY(U,$J,358.3,5062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5062,1,3,0)
 ;;=3^Pneumonia d/t Streptococcus pneumoniae
 ;;^UTILITY(U,$J,358.3,5062,1,4,0)
 ;;=4^J13.
 ;;^UTILITY(U,$J,358.3,5062,2)
 ;;=^5008170
 ;;^UTILITY(U,$J,358.3,5063,0)
 ;;=J15.4^^34^308^9
 ;;^UTILITY(U,$J,358.3,5063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5063,1,3,0)
 ;;=3^Pneumonia d/t other streptococci
 ;;^UTILITY(U,$J,358.3,5063,1,4,0)
 ;;=4^J15.4
 ;;^UTILITY(U,$J,358.3,5063,2)
 ;;=^5008174
 ;;^UTILITY(U,$J,358.3,5064,0)
 ;;=J15.211^^34^308^8
 ;;^UTILITY(U,$J,358.3,5064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5064,1,3,0)
 ;;=3^Pneumonia d/t methicillin suscep staph
 ;;^UTILITY(U,$J,358.3,5064,1,4,0)
 ;;=4^J15.211
 ;;^UTILITY(U,$J,358.3,5064,2)
 ;;=^336833
 ;;^UTILITY(U,$J,358.3,5065,0)
 ;;=J15.212^^34^308^6
 ;;^UTILITY(U,$J,358.3,5065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5065,1,3,0)
 ;;=3^Pneumonia d/t Methicillin resistant Staphylococcus aureus
 ;;^UTILITY(U,$J,358.3,5065,1,4,0)
 ;;=4^J15.212
 ;;^UTILITY(U,$J,358.3,5065,2)
 ;;=^336602
 ;;^UTILITY(U,$J,358.3,5066,0)
 ;;=J15.9^^34^308^1
 ;;^UTILITY(U,$J,358.3,5066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5066,1,3,0)
 ;;=3^Bacterial Pneumonia,Unspec
 ;;^UTILITY(U,$J,358.3,5066,1,4,0)
 ;;=4^J15.9
 ;;^UTILITY(U,$J,358.3,5066,2)
 ;;=^5008178
 ;;^UTILITY(U,$J,358.3,5067,0)
 ;;=J18.9^^34^308^10
 ;;^UTILITY(U,$J,358.3,5067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5067,1,3,0)
 ;;=3^Pneumonia, unspecified organism
 ;;^UTILITY(U,$J,358.3,5067,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,5067,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,5068,0)
 ;;=J09.X1^^34^308^2
 ;;^UTILITY(U,$J,358.3,5068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5068,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w pneumonia
 ;;^UTILITY(U,$J,358.3,5068,1,4,0)
 ;;=4^J09.X1
 ;;^UTILITY(U,$J,358.3,5068,2)
 ;;=^5008144
 ;;^UTILITY(U,$J,358.3,5069,0)
 ;;=J09.X2^^34^308^3
 ;;^UTILITY(U,$J,358.3,5069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5069,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w oth resp manifest
 ;;^UTILITY(U,$J,358.3,5069,1,4,0)
 ;;=4^J09.X2
 ;;^UTILITY(U,$J,358.3,5069,2)
 ;;=^5008145
 ;;^UTILITY(U,$J,358.3,5070,0)
 ;;=J09.X3^^34^308^4
 ;;^UTILITY(U,$J,358.3,5070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5070,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w GI manifest
 ;;^UTILITY(U,$J,358.3,5070,1,4,0)
 ;;=4^J09.X3
 ;;^UTILITY(U,$J,358.3,5070,2)
 ;;=^5008146
 ;;^UTILITY(U,$J,358.3,5071,0)
 ;;=J09.X9^^34^308^5
 ;;^UTILITY(U,$J,358.3,5071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5071,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w oth manifest
 ;;^UTILITY(U,$J,358.3,5071,1,4,0)
 ;;=4^J09.X9
 ;;^UTILITY(U,$J,358.3,5071,2)
 ;;=^5008147
 ;;^UTILITY(U,$J,358.3,5072,0)
 ;;=I26.92^^34^309^10
 ;;^UTILITY(U,$J,358.3,5072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5072,1,3,0)
 ;;=3^Saddle Embolus of Pulmonary Artery w/o Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,5072,1,4,0)
 ;;=4^I26.92
 ;;^UTILITY(U,$J,358.3,5072,2)
 ;;=^5007149
 ;;^UTILITY(U,$J,358.3,5073,0)
 ;;=I26.99^^34^309^5
 ;;^UTILITY(U,$J,358.3,5073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5073,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale NEC
 ;;^UTILITY(U,$J,358.3,5073,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,5073,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,5074,0)
 ;;=I27.0^^34^309^3
 ;;^UTILITY(U,$J,358.3,5074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5074,1,3,0)
 ;;=3^Primary pulmonary hypertension
 ;;^UTILITY(U,$J,358.3,5074,1,4,0)
 ;;=4^I27.0
 ;;^UTILITY(U,$J,358.3,5074,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,5075,0)
 ;;=I27.89^^34^309^7
 ;;^UTILITY(U,$J,358.3,5075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5075,1,3,0)
 ;;=3^Pulmonary Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,5075,1,4,0)
 ;;=4^I27.89
 ;;^UTILITY(U,$J,358.3,5075,2)
 ;;=^5007153
 ;;^UTILITY(U,$J,358.3,5076,0)
 ;;=I27.9^^34^309^6
 ;;^UTILITY(U,$J,358.3,5076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5076,1,3,0)
 ;;=3^Pulmonary Heart Disease,Unspec
 ;;^UTILITY(U,$J,358.3,5076,1,4,0)
 ;;=4^I27.9
 ;;^UTILITY(U,$J,358.3,5076,2)
 ;;=^5007154
 ;;^UTILITY(U,$J,358.3,5077,0)
 ;;=I27.81^^34^309^1
 ;;^UTILITY(U,$J,358.3,5077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5077,1,3,0)
 ;;=3^Cor Pulmonale (chronic)
 ;;^UTILITY(U,$J,358.3,5077,1,4,0)
 ;;=4^I27.81
 ;;^UTILITY(U,$J,358.3,5077,2)
 ;;=^5007152
 ;;^UTILITY(U,$J,358.3,5078,0)
 ;;=R04.2^^34^309^2
 ;;^UTILITY(U,$J,358.3,5078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5078,1,3,0)
 ;;=3^Hemoptysis
 ;;^UTILITY(U,$J,358.3,5078,1,4,0)
 ;;=4^R04.2
 ;;^UTILITY(U,$J,358.3,5078,2)
 ;;=^5019175
 ;;^UTILITY(U,$J,358.3,5079,0)
 ;;=I27.20^^34^309^9
 ;;^UTILITY(U,$J,358.3,5079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5079,1,3,0)
 ;;=3^Pulmonary Hypertension,Unspec
 ;;^UTILITY(U,$J,358.3,5079,1,4,0)
 ;;=4^I27.20
 ;;^UTILITY(U,$J,358.3,5079,2)
 ;;=^5151376
 ;;^UTILITY(U,$J,358.3,5080,0)
 ;;=I27.21^^34^309^4
 ;;^UTILITY(U,$J,358.3,5080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5080,1,3,0)
 ;;=3^Pulmonary Arterial Hypertension,Secondary
 ;;^UTILITY(U,$J,358.3,5080,1,4,0)
 ;;=4^I27.21
 ;;^UTILITY(U,$J,358.3,5080,2)
 ;;=^5151377
 ;;^UTILITY(U,$J,358.3,5081,0)
 ;;=I27.29^^34^309^8
 ;;^UTILITY(U,$J,358.3,5081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5081,1,3,0)
 ;;=3^Pulmonary Hypertension,Oth Secondary
 ;;^UTILITY(U,$J,358.3,5081,1,4,0)
 ;;=4^I27.29
 ;;^UTILITY(U,$J,358.3,5081,2)
 ;;=^5151381
 ;;^UTILITY(U,$J,358.3,5082,0)
 ;;=J41.0^^34^310^17
 ;;^UTILITY(U,$J,358.3,5082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5082,1,3,0)
 ;;=3^Simple chronic bronchitis
 ;;^UTILITY(U,$J,358.3,5082,1,4,0)
 ;;=4^J41.0
 ;;^UTILITY(U,$J,358.3,5082,2)
 ;;=^269946
 ;;^UTILITY(U,$J,358.3,5083,0)
 ;;=J70.5^^34^310^15
 ;;^UTILITY(U,$J,358.3,5083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5083,1,3,0)
 ;;=3^Respiratory conditions due to smoke inhalation
 ;;^UTILITY(U,$J,358.3,5083,1,4,0)
 ;;=4^J70.5
 ;;^UTILITY(U,$J,358.3,5083,2)
 ;;=^5008293
 ;;^UTILITY(U,$J,358.3,5084,0)
 ;;=J98.11^^34^310^6
 ;;^UTILITY(U,$J,358.3,5084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5084,1,3,0)
 ;;=3^Atelectasis
 ;;^UTILITY(U,$J,358.3,5084,1,4,0)
 ;;=4^J98.11
 ;;^UTILITY(U,$J,358.3,5084,2)
 ;;=^5008360
 ;;^UTILITY(U,$J,358.3,5085,0)
 ;;=J80.^^34^310^4
 ;;^UTILITY(U,$J,358.3,5085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5085,1,3,0)
 ;;=3^Acute respiratory distress syndrome
 ;;^UTILITY(U,$J,358.3,5085,1,4,0)
 ;;=4^J80.
 ;;^UTILITY(U,$J,358.3,5085,2)
 ;;=^5008294
 ;;^UTILITY(U,$J,358.3,5086,0)
 ;;=J98.01^^34^310^3
 ;;^UTILITY(U,$J,358.3,5086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5086,1,3,0)
 ;;=3^Acute bronchospasm
 ;;^UTILITY(U,$J,358.3,5086,1,4,0)
 ;;=4^J98.01
 ;;^UTILITY(U,$J,358.3,5086,2)
 ;;=^334092
 ;;^UTILITY(U,$J,358.3,5087,0)
 ;;=R06.02^^34^310^16
