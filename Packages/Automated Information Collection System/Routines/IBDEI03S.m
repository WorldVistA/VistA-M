IBDEI03S ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4606,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites Left Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4606,1,4,0)
 ;;=4^C34.82
 ;;^UTILITY(U,$J,358.3,4606,2)
 ;;=^5000965
 ;;^UTILITY(U,$J,358.3,4607,0)
 ;;=C34.00^^22^215^5
 ;;^UTILITY(U,$J,358.3,4607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4607,1,3,0)
 ;;=3^Malig Neop of Main Bronchus,Unspec
 ;;^UTILITY(U,$J,358.3,4607,1,4,0)
 ;;=4^C34.00
 ;;^UTILITY(U,$J,358.3,4607,2)
 ;;=^5000957
 ;;^UTILITY(U,$J,358.3,4608,0)
 ;;=C34.91^^22^215^9
 ;;^UTILITY(U,$J,358.3,4608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4608,1,3,0)
 ;;=3^Malig Neop of Right Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,4608,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,4608,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,4609,0)
 ;;=C34.92^^22^215^1
 ;;^UTILITY(U,$J,358.3,4609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4609,1,3,0)
 ;;=3^Malig Neop of Left Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,4609,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,4609,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,4610,0)
 ;;=C37.^^22^215^13
 ;;^UTILITY(U,$J,358.3,4610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4610,1,3,0)
 ;;=3^Malig Neop of Thymus
 ;;^UTILITY(U,$J,358.3,4610,1,4,0)
 ;;=4^C37.
 ;;^UTILITY(U,$J,358.3,4610,2)
 ;;=^267145
 ;;^UTILITY(U,$J,358.3,4611,0)
 ;;=C81.00^^22^216^372
 ;;^UTILITY(U,$J,358.3,4611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4611,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,4611,1,4,0)
 ;;=4^C81.00
 ;;^UTILITY(U,$J,358.3,4611,2)
 ;;=^5001391
 ;;^UTILITY(U,$J,358.3,4612,0)
 ;;=C81.01^^22^216^373
 ;;^UTILITY(U,$J,358.3,4612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4612,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Head/Face/Neck
 ;;^UTILITY(U,$J,358.3,4612,1,4,0)
 ;;=4^C81.01
 ;;^UTILITY(U,$J,358.3,4612,2)
 ;;=^5001392
 ;;^UTILITY(U,$J,358.3,4613,0)
 ;;=C81.02^^22^216^374
 ;;^UTILITY(U,$J,358.3,4613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4613,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4613,1,4,0)
 ;;=4^C81.02
 ;;^UTILITY(U,$J,358.3,4613,2)
 ;;=^5001393
 ;;^UTILITY(U,$J,358.3,4614,0)
 ;;=C81.03^^22^216^375
 ;;^UTILITY(U,$J,358.3,4614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4614,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4614,1,4,0)
 ;;=4^C81.03
 ;;^UTILITY(U,$J,358.3,4614,2)
 ;;=^5001394
 ;;^UTILITY(U,$J,358.3,4615,0)
 ;;=C81.04^^22^216^376
 ;;^UTILITY(U,$J,358.3,4615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4615,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4615,1,4,0)
 ;;=4^C81.04
 ;;^UTILITY(U,$J,358.3,4615,2)
 ;;=^5001395
 ;;^UTILITY(U,$J,358.3,4616,0)
 ;;=C81.05^^22^216^377
 ;;^UTILITY(U,$J,358.3,4616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4616,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4616,1,4,0)
 ;;=4^C81.05
 ;;^UTILITY(U,$J,358.3,4616,2)
 ;;=^5001396
 ;;^UTILITY(U,$J,358.3,4617,0)
 ;;=C81.06^^22^216^378
 ;;^UTILITY(U,$J,358.3,4617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4617,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,4617,1,4,0)
 ;;=4^C81.06
 ;;^UTILITY(U,$J,358.3,4617,2)
 ;;=^5001397
 ;;^UTILITY(U,$J,358.3,4618,0)
 ;;=C81.07^^22^216^379
 ;;^UTILITY(U,$J,358.3,4618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4618,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Spleen
 ;;^UTILITY(U,$J,358.3,4618,1,4,0)
 ;;=4^C81.07
 ;;^UTILITY(U,$J,358.3,4618,2)
 ;;=^5001398
 ;;^UTILITY(U,$J,358.3,4619,0)
 ;;=C81.08^^22^216^380
 ;;^UTILITY(U,$J,358.3,4619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4619,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,4619,1,4,0)
 ;;=4^C81.08
 ;;^UTILITY(U,$J,358.3,4619,2)
 ;;=^5001399
 ;;^UTILITY(U,$J,358.3,4620,0)
 ;;=C81.09^^22^216^381
 ;;^UTILITY(U,$J,358.3,4620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4620,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4620,1,4,0)
 ;;=4^C81.09
 ;;^UTILITY(U,$J,358.3,4620,2)
 ;;=^5001400
 ;;^UTILITY(U,$J,358.3,4621,0)
 ;;=C81.10^^22^216^382
 ;;^UTILITY(U,$J,358.3,4621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4621,1,3,0)
 ;;=3^Nodular Sclerosis Classical Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,4621,1,4,0)
 ;;=4^C81.10
 ;;^UTILITY(U,$J,358.3,4621,2)
 ;;=^5001401
 ;;^UTILITY(U,$J,358.3,4622,0)
 ;;=C81.11^^22^216^383
 ;;^UTILITY(U,$J,358.3,4622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4622,1,3,0)
 ;;=3^Nodular Sclerosis Classical Hodgkin Lymphoma,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,4622,1,4,0)
 ;;=4^C81.11
 ;;^UTILITY(U,$J,358.3,4622,2)
 ;;=^5001402
 ;;^UTILITY(U,$J,358.3,4623,0)
 ;;=C81.12^^22^216^384
 ;;^UTILITY(U,$J,358.3,4623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4623,1,3,0)
 ;;=3^Nodular Sclerosis Classical Hodgkin Lymphoma,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4623,1,4,0)
 ;;=4^C81.12
 ;;^UTILITY(U,$J,358.3,4623,2)
 ;;=^5001403
 ;;^UTILITY(U,$J,358.3,4624,0)
 ;;=C81.13^^22^216^385
 ;;^UTILITY(U,$J,358.3,4624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4624,1,3,0)
 ;;=3^Nodular Sclerosis Classical Hodgkin Lymphoma,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4624,1,4,0)
 ;;=4^C81.13
 ;;^UTILITY(U,$J,358.3,4624,2)
 ;;=^5001404
 ;;^UTILITY(U,$J,358.3,4625,0)
 ;;=C81.14^^22^216^386
 ;;^UTILITY(U,$J,358.3,4625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4625,1,3,0)
 ;;=3^Nodular Sclerosis Classical Hodgkin Lymphoma,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4625,1,4,0)
 ;;=4^C81.14
 ;;^UTILITY(U,$J,358.3,4625,2)
 ;;=^5001405
 ;;^UTILITY(U,$J,358.3,4626,0)
 ;;=C81.15^^22^216^387
 ;;^UTILITY(U,$J,358.3,4626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4626,1,3,0)
 ;;=3^Nodular Sclerosis Classical Hodgkin Lymphoma,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4626,1,4,0)
 ;;=4^C81.15
 ;;^UTILITY(U,$J,358.3,4626,2)
 ;;=^5001406
 ;;^UTILITY(U,$J,358.3,4627,0)
 ;;=C81.16^^22^216^388
 ;;^UTILITY(U,$J,358.3,4627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4627,1,3,0)
 ;;=3^Nodular Sclerosis Classical Hodgkin Lymphoma,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4627,1,4,0)
 ;;=4^C81.16
 ;;^UTILITY(U,$J,358.3,4627,2)
 ;;=^5001407
 ;;^UTILITY(U,$J,358.3,4628,0)
 ;;=C81.17^^22^216^389
 ;;^UTILITY(U,$J,358.3,4628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4628,1,3,0)
 ;;=3^Nodular Sclerosis Classical Hodgkin Lymphoma,Spleen
 ;;^UTILITY(U,$J,358.3,4628,1,4,0)
 ;;=4^C81.17
 ;;^UTILITY(U,$J,358.3,4628,2)
 ;;=^5001408
 ;;^UTILITY(U,$J,358.3,4629,0)
 ;;=C81.18^^22^216^390
 ;;^UTILITY(U,$J,358.3,4629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4629,1,3,0)
 ;;=3^Nodular Sclerosis Classical Hodgkin Lymphoma,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,4629,1,4,0)
 ;;=4^C81.18
 ;;^UTILITY(U,$J,358.3,4629,2)
 ;;=^5001409
 ;;^UTILITY(U,$J,358.3,4630,0)
 ;;=C81.19^^22^216^391
 ;;^UTILITY(U,$J,358.3,4630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4630,1,3,0)
 ;;=3^Nodular Sclerosis Classical Hodgkin Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4630,1,4,0)
 ;;=4^C81.19
 ;;^UTILITY(U,$J,358.3,4630,2)
 ;;=^5001410
 ;;^UTILITY(U,$J,358.3,4631,0)
 ;;=C81.20^^22^216^331
 ;;^UTILITY(U,$J,358.3,4631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4631,1,3,0)
 ;;=3^Mixed Cellularity Classical Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,4631,1,4,0)
 ;;=4^C81.20
 ;;^UTILITY(U,$J,358.3,4631,2)
 ;;=^5001411
 ;;^UTILITY(U,$J,358.3,4632,0)
 ;;=C81.21^^22^216^332
 ;;^UTILITY(U,$J,358.3,4632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4632,1,3,0)
 ;;=3^Mixed Cellularity Classical Hodgkin Lymphoma,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,4632,1,4,0)
 ;;=4^C81.21
 ;;^UTILITY(U,$J,358.3,4632,2)
 ;;=^5001412
 ;;^UTILITY(U,$J,358.3,4633,0)
 ;;=C81.22^^22^216^333
 ;;^UTILITY(U,$J,358.3,4633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4633,1,3,0)
 ;;=3^Mixed Cellularity Classical Hodgkin Lymphoma,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,4633,1,4,0)
 ;;=4^C81.22
 ;;^UTILITY(U,$J,358.3,4633,2)
 ;;=^5001413
 ;;^UTILITY(U,$J,358.3,4634,0)
 ;;=C81.23^^22^216^334
 ;;^UTILITY(U,$J,358.3,4634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4634,1,3,0)
 ;;=3^Mixed Cellularity Classical Hodgkin Lymphoma,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,4634,1,4,0)
 ;;=4^C81.23
 ;;^UTILITY(U,$J,358.3,4634,2)
 ;;=^5001414
 ;;^UTILITY(U,$J,358.3,4635,0)
 ;;=C81.24^^22^216^335
 ;;^UTILITY(U,$J,358.3,4635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4635,1,3,0)
 ;;=3^Mixed Cellularity Classical Hodgkin Lymphoma,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,4635,1,4,0)
 ;;=4^C81.24
 ;;^UTILITY(U,$J,358.3,4635,2)
 ;;=^5001415
 ;;^UTILITY(U,$J,358.3,4636,0)
 ;;=C81.25^^22^216^336
 ;;^UTILITY(U,$J,358.3,4636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4636,1,3,0)
 ;;=3^Mixed Cellularity Classical Hodgkin Lymphoma,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,4636,1,4,0)
 ;;=4^C81.25
 ;;^UTILITY(U,$J,358.3,4636,2)
 ;;=^5001416
 ;;^UTILITY(U,$J,358.3,4637,0)
 ;;=C81.26^^22^216^337
 ;;^UTILITY(U,$J,358.3,4637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4637,1,3,0)
 ;;=3^Mixed Cellularity Classical Hodgkin Lymphoma,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,4637,1,4,0)
 ;;=4^C81.26
 ;;^UTILITY(U,$J,358.3,4637,2)
 ;;=^5001417
 ;;^UTILITY(U,$J,358.3,4638,0)
 ;;=C81.27^^22^216^338
 ;;^UTILITY(U,$J,358.3,4638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4638,1,3,0)
 ;;=3^Mixed Cellularity Classical Hodgkin Lymphoma,Spleen
 ;;^UTILITY(U,$J,358.3,4638,1,4,0)
 ;;=4^C81.27
 ;;^UTILITY(U,$J,358.3,4638,2)
 ;;=^5001418
