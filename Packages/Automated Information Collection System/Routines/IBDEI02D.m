IBDEI02D ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5481,0)
 ;;=92273^^36^303^5^^^^1
 ;;^UTILITY(U,$J,358.3,5481,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5481,1,2,0)
 ;;=2^ERG w/ Int & Rpt;Full Field
 ;;^UTILITY(U,$J,358.3,5481,1,3,0)
 ;;=3^92273
 ;;^UTILITY(U,$J,358.3,5482,0)
 ;;=92274^^36^303^6^^^^1
 ;;^UTILITY(U,$J,358.3,5482,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5482,1,2,0)
 ;;=2^ERG w/ Int & Rpt;Multifocal
 ;;^UTILITY(U,$J,358.3,5482,1,3,0)
 ;;=3^92274
 ;;^UTILITY(U,$J,358.3,5483,0)
 ;;=0333T^^36^303^15^^^^1
 ;;^UTILITY(U,$J,358.3,5483,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5483,1,2,0)
 ;;=2^VEP,Scr Acuity,Automated w/ Rpt
 ;;^UTILITY(U,$J,358.3,5483,1,3,0)
 ;;=3^0333T
 ;;^UTILITY(U,$J,358.3,5484,0)
 ;;=92015^^36^304^1^^^^1
 ;;^UTILITY(U,$J,358.3,5484,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5484,1,2,0)
 ;;=2^Refraction
 ;;^UTILITY(U,$J,358.3,5484,1,3,0)
 ;;=3^92015
 ;;^UTILITY(U,$J,358.3,5485,0)
 ;;=99174^^36^304^2^^^^1
 ;;^UTILITY(U,$J,358.3,5485,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5485,1,2,0)
 ;;=2^Autorefraction,Bilateral
 ;;^UTILITY(U,$J,358.3,5485,1,3,0)
 ;;=3^99174
 ;;^UTILITY(U,$J,358.3,5486,0)
 ;;=92370^^36^304^3^^^^1
 ;;^UTILITY(U,$J,358.3,5486,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5486,1,2,0)
 ;;=2^Repair/Refit Glasses
 ;;^UTILITY(U,$J,358.3,5486,1,3,0)
 ;;=3^92370
 ;;^UTILITY(U,$J,358.3,5487,0)
 ;;=92371^^36^304^4^^^^1
 ;;^UTILITY(U,$J,358.3,5487,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5487,1,2,0)
 ;;=2^Repair/Refit Glasses for Aphakia
 ;;^UTILITY(U,$J,358.3,5487,1,3,0)
 ;;=3^92371
 ;;^UTILITY(U,$J,358.3,5488,0)
 ;;=92341^^36^304^5^^^^1
 ;;^UTILITY(U,$J,358.3,5488,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5488,1,2,0)
 ;;=2^Glasses Fitting,Bifocal
 ;;^UTILITY(U,$J,358.3,5488,1,3,0)
 ;;=3^92341
 ;;^UTILITY(U,$J,358.3,5489,0)
 ;;=92340^^36^304^6^^^^1
 ;;^UTILITY(U,$J,358.3,5489,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5489,1,2,0)
 ;;=2^Glasses Fitting,Monofocal
 ;;^UTILITY(U,$J,358.3,5489,1,3,0)
 ;;=3^92340
 ;;^UTILITY(U,$J,358.3,5490,0)
 ;;=92352^^36^304^7^^^^1
 ;;^UTILITY(U,$J,358.3,5490,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5490,1,2,0)
 ;;=2^Glasses Fitting,Monofocal for Aphakia
 ;;^UTILITY(U,$J,358.3,5490,1,3,0)
 ;;=3^92352
 ;;^UTILITY(U,$J,358.3,5491,0)
 ;;=92342^^36^304^8^^^^1
 ;;^UTILITY(U,$J,358.3,5491,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5491,1,2,0)
 ;;=2^Glasses Fitting,Multifocal
 ;;^UTILITY(U,$J,358.3,5491,1,3,0)
 ;;=3^92342
 ;;^UTILITY(U,$J,358.3,5492,0)
 ;;=92353^^36^304^9^^^^1
 ;;^UTILITY(U,$J,358.3,5492,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5492,1,2,0)
 ;;=2^Glasses Fitting,Multifocal for Aphakia
 ;;^UTILITY(U,$J,358.3,5492,1,3,0)
 ;;=3^92353
 ;;^UTILITY(U,$J,358.3,5493,0)
 ;;=92072^^36^304^10^^^^1
 ;;^UTILITY(U,$J,358.3,5493,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5493,1,2,0)
 ;;=2^Contact Lens Mgmt Keratoconus,Init
 ;;^UTILITY(U,$J,358.3,5493,1,3,0)
 ;;=3^92072
 ;;^UTILITY(U,$J,358.3,5494,0)
 ;;=92071^^36^304^11^^^^1
 ;;^UTILITY(U,$J,358.3,5494,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5494,1,2,0)
 ;;=2^Contact Lens Tx for Ocular Disease
 ;;^UTILITY(U,$J,358.3,5494,1,3,0)
 ;;=3^92071
 ;;^UTILITY(U,$J,358.3,5495,0)
 ;;=92311^^36^304^12^^^^1
 ;;^UTILITY(U,$J,358.3,5495,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5495,1,2,0)
 ;;=2^Contact Lens-Aphakia Od/Os
 ;;^UTILITY(U,$J,358.3,5495,1,3,0)
 ;;=3^92311
 ;;^UTILITY(U,$J,358.3,5496,0)
 ;;=92312^^36^304^13^^^^1
 ;;^UTILITY(U,$J,358.3,5496,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5496,1,2,0)
 ;;=2^Contact Lens-Aphakia OU
 ;;^UTILITY(U,$J,358.3,5496,1,3,0)
 ;;=3^92312
 ;;^UTILITY(U,$J,358.3,5497,0)
 ;;=92354^^36^304^14^^^^1
 ;;^UTILITY(U,$J,358.3,5497,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5497,1,2,0)
 ;;=2^Low Vision Aid Fitting,Single Element
 ;;^UTILITY(U,$J,358.3,5497,1,3,0)
 ;;=3^92354
 ;;^UTILITY(U,$J,358.3,5498,0)
 ;;=92355^^36^304^15^^^^1
 ;;^UTILITY(U,$J,358.3,5498,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5498,1,2,0)
 ;;=2^Low Vision Aid Fitng,Telescopic/Compound Lens
 ;;^UTILITY(U,$J,358.3,5498,1,3,0)
 ;;=3^92355
 ;;^UTILITY(U,$J,358.3,5499,0)
 ;;=H54.3^^37^306^2
 ;;^UTILITY(U,$J,358.3,5499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5499,1,3,0)
 ;;=3^Visual Loss,Both Eyes,Unqualified
 ;;^UTILITY(U,$J,358.3,5499,1,4,0)
 ;;=4^H54.3
 ;;^UTILITY(U,$J,358.3,5499,2)
 ;;=^268886
 ;;^UTILITY(U,$J,358.3,5500,0)
 ;;=H54.7^^37^306^1
 ;;^UTILITY(U,$J,358.3,5500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5500,1,3,0)
 ;;=3^Visual Loss
 ;;^UTILITY(U,$J,358.3,5500,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,5500,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,5501,0)
 ;;=H54.8^^37^306^44
 ;;^UTILITY(U,$J,358.3,5501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5501,1,3,0)
 ;;=3^Legal Blindness,as Defined in USA
 ;;^UTILITY(U,$J,358.3,5501,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,5501,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,5502,0)
 ;;=H54.40^^37^306^6
 ;;^UTILITY(U,$J,358.3,5502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5502,1,3,0)
 ;;=3^Monocular,Blindness in One Eye
 ;;^UTILITY(U,$J,358.3,5502,1,4,0)
 ;;=4^H54.40
 ;;^UTILITY(U,$J,358.3,5502,2)
 ;;=^5006362
 ;;^UTILITY(U,$J,358.3,5503,0)
 ;;=H53.71^^37^306^3
 ;;^UTILITY(U,$J,358.3,5503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5503,1,3,0)
 ;;=3^Glare Sensitivity
 ;;^UTILITY(U,$J,358.3,5503,1,4,0)
 ;;=4^H53.71
 ;;^UTILITY(U,$J,358.3,5503,2)
 ;;=^5006354
 ;;^UTILITY(U,$J,358.3,5504,0)
 ;;=H53.72^^37^306^4
 ;;^UTILITY(U,$J,358.3,5504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5504,1,3,0)
 ;;=3^Impaired Contrast Sensitivity
 ;;^UTILITY(U,$J,358.3,5504,1,4,0)
 ;;=4^H53.72
 ;;^UTILITY(U,$J,358.3,5504,2)
 ;;=^5006355
 ;;^UTILITY(U,$J,358.3,5505,0)
 ;;=Z82.1^^37^306^5
 ;;^UTILITY(U,$J,358.3,5505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5505,1,3,0)
 ;;=3^Family Hx Blindness/Visual Loss
 ;;^UTILITY(U,$J,358.3,5505,1,4,0)
 ;;=4^Z82.1
 ;;^UTILITY(U,$J,358.3,5505,2)
 ;;=^5063365
 ;;^UTILITY(U,$J,358.3,5506,0)
 ;;=H54.7^^37^306^43
 ;;^UTILITY(U,$J,358.3,5506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5506,1,3,0)
 ;;=3^Visual Loss,Unspec
 ;;^UTILITY(U,$J,358.3,5506,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,5506,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,5507,0)
 ;;=H54.1213^^37^306^7
 ;;^UTILITY(U,$J,358.3,5507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5507,1,3,0)
 ;;=3^Low Vision Rt Eye Category 1,Blindness Lt Eye Category 3
 ;;^UTILITY(U,$J,358.3,5507,1,4,0)
 ;;=4^H54.1213
 ;;^UTILITY(U,$J,358.3,5507,2)
 ;;=^5151353
 ;;^UTILITY(U,$J,358.3,5508,0)
 ;;=H54.1214^^37^306^8
 ;;^UTILITY(U,$J,358.3,5508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5508,1,3,0)
 ;;=3^Low Vision Rt Eye Category 1,Blindness Lt Eye Category 4
 ;;^UTILITY(U,$J,358.3,5508,1,4,0)
 ;;=4^H54.1214
 ;;^UTILITY(U,$J,358.3,5508,2)
 ;;=^5151354
 ;;^UTILITY(U,$J,358.3,5509,0)
 ;;=H54.1215^^37^306^9
 ;;^UTILITY(U,$J,358.3,5509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5509,1,3,0)
 ;;=3^Low Vision Rt Eye Category 1,Blindness Lt Eye Category 5
 ;;^UTILITY(U,$J,358.3,5509,1,4,0)
 ;;=4^H54.1215
 ;;^UTILITY(U,$J,358.3,5509,2)
 ;;=^5151355
 ;;^UTILITY(U,$J,358.3,5510,0)
 ;;=H54.1223^^37^306^10
 ;;^UTILITY(U,$J,358.3,5510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5510,1,3,0)
 ;;=3^Low Vision Rt Eye Category 2,Blindness Lt Eye Category 3
 ;;^UTILITY(U,$J,358.3,5510,1,4,0)
 ;;=4^H54.1223
 ;;^UTILITY(U,$J,358.3,5510,2)
 ;;=^5151356
 ;;^UTILITY(U,$J,358.3,5511,0)
 ;;=H54.1224^^37^306^11
 ;;^UTILITY(U,$J,358.3,5511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5511,1,3,0)
 ;;=3^Low Vision Rt Eye Category 2,Blindness Lt Eye Category 4
 ;;^UTILITY(U,$J,358.3,5511,1,4,0)
 ;;=4^H54.1224
 ;;^UTILITY(U,$J,358.3,5511,2)
 ;;=^5151357
 ;;^UTILITY(U,$J,358.3,5512,0)
 ;;=H54.1225^^37^306^12
 ;;^UTILITY(U,$J,358.3,5512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5512,1,3,0)
 ;;=3^Low Vision Rt Eye Category 2,Blindness Lt Eye Category 5
 ;;^UTILITY(U,$J,358.3,5512,1,4,0)
 ;;=4^H54.1225
 ;;^UTILITY(U,$J,358.3,5512,2)
 ;;=^5151358
 ;;^UTILITY(U,$J,358.3,5513,0)
 ;;=H54.2X12^^37^306^13
 ;;^UTILITY(U,$J,358.3,5513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5513,1,3,0)
 ;;=3^Low Vision Rt Eye Category 1,Low Vision Lt Eye Category 2
 ;;^UTILITY(U,$J,358.3,5513,1,4,0)
 ;;=4^H54.2X12
 ;;^UTILITY(U,$J,358.3,5513,2)
 ;;=^5151360
 ;;^UTILITY(U,$J,358.3,5514,0)
 ;;=H54.2X21^^37^306^14
 ;;^UTILITY(U,$J,358.3,5514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5514,1,3,0)
 ;;=3^Low Vision Rt Eye Category 2,Low Vision Lt Eye Category 1
 ;;^UTILITY(U,$J,358.3,5514,1,4,0)
 ;;=4^H54.2X21
 ;;^UTILITY(U,$J,358.3,5514,2)
 ;;=^5151361
 ;;^UTILITY(U,$J,358.3,5515,0)
 ;;=H54.2X22^^37^306^15
 ;;^UTILITY(U,$J,358.3,5515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5515,1,3,0)
 ;;=3^Low Vision Rt Eye Category 2,Low Vision Lt Eye Category 2
 ;;^UTILITY(U,$J,358.3,5515,1,4,0)
 ;;=4^H54.2X22
 ;;^UTILITY(U,$J,358.3,5515,2)
 ;;=^5151362
 ;;^UTILITY(U,$J,358.3,5516,0)
 ;;=H54.511A^^37^306^16
 ;;^UTILITY(U,$J,358.3,5516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5516,1,3,0)
 ;;=3^Low Vision Rt Eye Category 1,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,5516,1,4,0)
 ;;=4^H54.511A
 ;;^UTILITY(U,$J,358.3,5516,2)
 ;;=^5151369
 ;;^UTILITY(U,$J,358.3,5517,0)
 ;;=H54.512A^^37^306^17
 ;;^UTILITY(U,$J,358.3,5517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5517,1,3,0)
 ;;=3^Low Vision Rt Eye Category 2,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,5517,1,4,0)
 ;;=4^H54.512A
 ;;^UTILITY(U,$J,358.3,5517,2)
 ;;=^5151370
 ;;^UTILITY(U,$J,358.3,5518,0)
 ;;=H54.52A1^^37^306^18
 ;;^UTILITY(U,$J,358.3,5518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5518,1,3,0)
 ;;=3^Low Vision Lt Eye Category 1,Normal Vision Rt Eye
 ;;^UTILITY(U,$J,358.3,5518,1,4,0)
 ;;=4^H54.52A1
 ;;^UTILITY(U,$J,358.3,5518,2)
 ;;=^5151371
 ;;^UTILITY(U,$J,358.3,5519,0)
 ;;=H54.52A2^^37^306^19
 ;;^UTILITY(U,$J,358.3,5519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5519,1,3,0)
 ;;=3^Low Vision Lt Eye Category 2,Normal Vision Rt Eye
 ;;^UTILITY(U,$J,358.3,5519,1,4,0)
 ;;=4^H54.52A2
 ;;^UTILITY(U,$J,358.3,5519,2)
 ;;=^5151372
 ;;^UTILITY(U,$J,358.3,5520,0)
 ;;=H54.0X33^^37^306^20
 ;;^UTILITY(U,$J,358.3,5520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5520,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Blindness Lt Eye Category 3
 ;;^UTILITY(U,$J,358.3,5520,1,4,0)
 ;;=4^H54.0X33
 ;;^UTILITY(U,$J,358.3,5520,2)
 ;;=^5151338
 ;;^UTILITY(U,$J,358.3,5521,0)
 ;;=H54.0X34^^37^306^21
 ;;^UTILITY(U,$J,358.3,5521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5521,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Blindness Lt Eye Category 4
 ;;^UTILITY(U,$J,358.3,5521,1,4,0)
 ;;=4^H54.0X34
 ;;^UTILITY(U,$J,358.3,5521,2)
 ;;=^5151339
 ;;^UTILITY(U,$J,358.3,5522,0)
 ;;=H54.0X35^^37^306^22
 ;;^UTILITY(U,$J,358.3,5522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5522,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Blindness Lt Eye Category 5
 ;;^UTILITY(U,$J,358.3,5522,1,4,0)
 ;;=4^H54.0X35
 ;;^UTILITY(U,$J,358.3,5522,2)
 ;;=^5151340
 ;;^UTILITY(U,$J,358.3,5523,0)
 ;;=H54.0X43^^37^306^23
 ;;^UTILITY(U,$J,358.3,5523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5523,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Blindness Lt Eye Category 3
 ;;^UTILITY(U,$J,358.3,5523,1,4,0)
 ;;=4^H54.0X43
 ;;^UTILITY(U,$J,358.3,5523,2)
 ;;=^5151341
 ;;^UTILITY(U,$J,358.3,5524,0)
 ;;=H54.0X44^^37^306^24
 ;;^UTILITY(U,$J,358.3,5524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5524,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Blindness Lt Eye Category 4
 ;;^UTILITY(U,$J,358.3,5524,1,4,0)
 ;;=4^H54.0X44
 ;;^UTILITY(U,$J,358.3,5524,2)
 ;;=^5151342
 ;;^UTILITY(U,$J,358.3,5525,0)
 ;;=H54.0X45^^37^306^25
 ;;^UTILITY(U,$J,358.3,5525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5525,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Blindness Lt Eye Category 5
 ;;^UTILITY(U,$J,358.3,5525,1,4,0)
 ;;=4^H54.0X45
 ;;^UTILITY(U,$J,358.3,5525,2)
 ;;=^5151343
 ;;^UTILITY(U,$J,358.3,5526,0)
 ;;=H54.0X53^^37^306^26
 ;;^UTILITY(U,$J,358.3,5526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5526,1,3,0)
 ;;=3^Blindness Rt Eye Category 5,Blindness Lt Eye Category 3
 ;;^UTILITY(U,$J,358.3,5526,1,4,0)
 ;;=4^H54.0X53
 ;;^UTILITY(U,$J,358.3,5526,2)
 ;;=^5151344
 ;;^UTILITY(U,$J,358.3,5527,0)
 ;;=H54.0X54^^37^306^27
 ;;^UTILITY(U,$J,358.3,5527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5527,1,3,0)
 ;;=3^Blindness Rt Eye Category 5,Blindness Lt Eye Category 4
 ;;^UTILITY(U,$J,358.3,5527,1,4,0)
 ;;=4^H54.0X54
 ;;^UTILITY(U,$J,358.3,5527,2)
 ;;=^5151345
 ;;^UTILITY(U,$J,358.3,5528,0)
 ;;=H54.0X55^^37^306^28
 ;;^UTILITY(U,$J,358.3,5528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5528,1,3,0)
 ;;=3^Blindness Rt Eye Category 5,Blindness Lt Eye Category 5
 ;;^UTILITY(U,$J,358.3,5528,1,4,0)
 ;;=4^H54.0X55
 ;;^UTILITY(U,$J,358.3,5528,2)
 ;;=^5151346
 ;;^UTILITY(U,$J,358.3,5529,0)
 ;;=H54.10^^37^306^29
 ;;^UTILITY(U,$J,358.3,5529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5529,1,3,0)
 ;;=3^Blindness,One Eye,Low Vision Other Eye,Unspec Eyes
 ;;^UTILITY(U,$J,358.3,5529,1,4,0)
 ;;=4^H54.10
 ;;^UTILITY(U,$J,358.3,5529,2)
 ;;=^5006358
 ;;^UTILITY(U,$J,358.3,5530,0)
 ;;=H54.1131^^37^306^30
 ;;^UTILITY(U,$J,358.3,5530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5530,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Low Vision Lt Eye Category 1
 ;;^UTILITY(U,$J,358.3,5530,1,4,0)
 ;;=4^H54.1131
 ;;^UTILITY(U,$J,358.3,5530,2)
 ;;=^5151347
 ;;^UTILITY(U,$J,358.3,5531,0)
 ;;=H54.1132^^37^306^31
 ;;^UTILITY(U,$J,358.3,5531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5531,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Low Vision Lt Eye Category 2
 ;;^UTILITY(U,$J,358.3,5531,1,4,0)
 ;;=4^H54.1132
 ;;^UTILITY(U,$J,358.3,5531,2)
 ;;=^5151348
 ;;^UTILITY(U,$J,358.3,5532,0)
 ;;=H54.1141^^37^306^32
 ;;^UTILITY(U,$J,358.3,5532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5532,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Low Vision Lt Eye Category 1
 ;;^UTILITY(U,$J,358.3,5532,1,4,0)
 ;;=4^H54.1141
 ;;^UTILITY(U,$J,358.3,5532,2)
 ;;=^5151349
 ;;^UTILITY(U,$J,358.3,5533,0)
 ;;=H54.1142^^37^306^33
 ;;^UTILITY(U,$J,358.3,5533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5533,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Low Vision Lt Eye Category 2
 ;;^UTILITY(U,$J,358.3,5533,1,4,0)
 ;;=4^H54.1142
 ;;^UTILITY(U,$J,358.3,5533,2)
 ;;=^5151350
 ;;^UTILITY(U,$J,358.3,5534,0)
 ;;=H54.1151^^37^306^34
 ;;^UTILITY(U,$J,358.3,5534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5534,1,3,0)
 ;;=3^Blindness Rt Eye Category 5,Low Vision Lt Eye Category 1
 ;;^UTILITY(U,$J,358.3,5534,1,4,0)
 ;;=4^H54.1151
 ;;^UTILITY(U,$J,358.3,5534,2)
 ;;=^5151351
 ;;^UTILITY(U,$J,358.3,5535,0)
 ;;=H54.1152^^37^306^35
 ;;^UTILITY(U,$J,358.3,5535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5535,1,3,0)
 ;;=3^Blindness Rt Eye Category 5,Low Vision Lt Eye Category 2
 ;;^UTILITY(U,$J,358.3,5535,1,4,0)
 ;;=4^H54.1152
 ;;^UTILITY(U,$J,358.3,5535,2)
 ;;=^5151352
 ;;^UTILITY(U,$J,358.3,5536,0)
 ;;=H54.40^^37^306^36
 ;;^UTILITY(U,$J,358.3,5536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5536,1,3,0)
 ;;=3^Blindness,One Eye,Unspec Eye
 ;;^UTILITY(U,$J,358.3,5536,1,4,0)
 ;;=4^H54.40
 ;;^UTILITY(U,$J,358.3,5536,2)
 ;;=^5006362
 ;;^UTILITY(U,$J,358.3,5537,0)
 ;;=H54.413A^^37^306^37
 ;;^UTILITY(U,$J,358.3,5537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5537,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,5537,1,4,0)
 ;;=4^H54.413A
 ;;^UTILITY(U,$J,358.3,5537,2)
 ;;=^5151363
 ;;^UTILITY(U,$J,358.3,5538,0)
 ;;=H54.414A^^37^306^38
 ;;^UTILITY(U,$J,358.3,5538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5538,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,5538,1,4,0)
 ;;=4^H54.414A
 ;;^UTILITY(U,$J,358.3,5538,2)
 ;;=^5151364
 ;;^UTILITY(U,$J,358.3,5539,0)
 ;;=H54.415A^^37^306^39
 ;;^UTILITY(U,$J,358.3,5539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5539,1,3,0)
 ;;=3^Blindness Rt Eye Category 5,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,5539,1,4,0)
 ;;=4^H54.415A
 ;;^UTILITY(U,$J,358.3,5539,2)
 ;;=^5151365
 ;;^UTILITY(U,$J,358.3,5540,0)
 ;;=H54.42A3^^37^306^40
 ;;^UTILITY(U,$J,358.3,5540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5540,1,3,0)
 ;;=3^Blindness Lt Eye Category 3,Normal Vision Rt Eye
 ;;^UTILITY(U,$J,358.3,5540,1,4,0)
 ;;=4^H54.42A3
 ;;^UTILITY(U,$J,358.3,5540,2)
 ;;=^5151366
 ;;^UTILITY(U,$J,358.3,5541,0)
 ;;=H54.42A4^^37^306^41
 ;;^UTILITY(U,$J,358.3,5541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5541,1,3,0)
 ;;=3^Blindness Lt Eye Category 4,Normal Vision Rt Eye
 ;;^UTILITY(U,$J,358.3,5541,1,4,0)
 ;;=4^H54.42A4
 ;;^UTILITY(U,$J,358.3,5541,2)
 ;;=^5151367
 ;;^UTILITY(U,$J,358.3,5542,0)
 ;;=H54.42A5^^37^306^42
 ;;^UTILITY(U,$J,358.3,5542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5542,1,3,0)
 ;;=3^Blindness Lt Eye Category 5,Normal Vision Rt Eye
 ;;^UTILITY(U,$J,358.3,5542,1,4,0)
 ;;=4^H54.42A5
 ;;^UTILITY(U,$J,358.3,5542,2)
 ;;=^5151368
 ;;^UTILITY(U,$J,358.3,5543,0)
 ;;=H35.81^^37^307^20
 ;;^UTILITY(U,$J,358.3,5543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5543,1,3,0)
 ;;=3^Retinal Edema/CME Other Etiology
 ;;^UTILITY(U,$J,358.3,5543,1,4,0)
 ;;=4^H35.81
 ;;^UTILITY(U,$J,358.3,5543,2)
 ;;=^5005715
 ;;^UTILITY(U,$J,358.3,5544,0)
 ;;=H34.11^^37^307^9
 ;;^UTILITY(U,$J,358.3,5544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5544,1,3,0)
 ;;=3^Central Retinal Artery Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,5544,1,4,0)
 ;;=4^H34.11
 ;;^UTILITY(U,$J,358.3,5544,2)
 ;;=^5005557
 ;;^UTILITY(U,$J,358.3,5545,0)
 ;;=H34.12^^37^307^10
 ;;^UTILITY(U,$J,358.3,5545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5545,1,3,0)
 ;;=3^Central Retinal Artery Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,5545,1,4,0)
 ;;=4^H34.12
 ;;^UTILITY(U,$J,358.3,5545,2)
 ;;=^5005558
 ;;^UTILITY(U,$J,358.3,5546,0)
 ;;=H34.231^^37^307^1
 ;;^UTILITY(U,$J,358.3,5546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5546,1,3,0)
 ;;=3^Branch Retinal Artery Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,5546,1,4,0)
 ;;=4^H34.231
 ;;^UTILITY(U,$J,358.3,5546,2)
 ;;=^5005564
 ;;^UTILITY(U,$J,358.3,5547,0)
 ;;=H34.232^^37^307^2
 ;;^UTILITY(U,$J,358.3,5547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5547,1,3,0)
 ;;=3^Branch Retinal Artery Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,5547,1,4,0)
 ;;=4^H34.232
 ;;^UTILITY(U,$J,358.3,5547,2)
 ;;=^5005565
 ;;^UTILITY(U,$J,358.3,5548,0)
 ;;=H35.031^^37^307^17
 ;;^UTILITY(U,$J,358.3,5548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5548,1,3,0)
 ;;=3^Hypertensive Retinopathy,Right Eye
 ;;^UTILITY(U,$J,358.3,5548,1,4,0)
 ;;=4^H35.031
 ;;^UTILITY(U,$J,358.3,5548,2)
 ;;=^5005590
 ;;^UTILITY(U,$J,358.3,5549,0)
 ;;=H35.032^^37^307^18
 ;;^UTILITY(U,$J,358.3,5549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5549,1,3,0)
 ;;=3^Hypertensive Retinopathy,Left Eye
 ;;^UTILITY(U,$J,358.3,5549,1,4,0)
 ;;=4^H35.032
 ;;^UTILITY(U,$J,358.3,5549,2)
 ;;=^5005591
 ;;^UTILITY(U,$J,358.3,5550,0)
 ;;=H35.033^^37^307^19
 ;;^UTILITY(U,$J,358.3,5550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5550,1,3,0)
 ;;=3^Hypertensive Retinopathy,Bilateral
