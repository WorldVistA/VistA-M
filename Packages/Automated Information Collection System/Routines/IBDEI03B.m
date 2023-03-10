IBDEI03B ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7880,1,3,0)
 ;;=3^Lymphoma,Mantle cell,Extranodal
 ;;^UTILITY(U,$J,358.3,7880,1,4,0)
 ;;=4^C83.19
 ;;^UTILITY(U,$J,358.3,7880,2)
 ;;=^5001570
 ;;^UTILITY(U,$J,358.3,7881,0)
 ;;=C78.6^^42^397^39
 ;;^UTILITY(U,$J,358.3,7881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7881,1,3,0)
 ;;=3^Peritoneal carinomatosis
 ;;^UTILITY(U,$J,358.3,7881,1,4,0)
 ;;=4^C78.6
 ;;^UTILITY(U,$J,358.3,7881,2)
 ;;=^108899
 ;;^UTILITY(U,$J,358.3,7882,0)
 ;;=E85.89^^42^397^3
 ;;^UTILITY(U,$J,358.3,7882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7882,1,3,0)
 ;;=3^Amyloidosis,Systemic
 ;;^UTILITY(U,$J,358.3,7882,1,4,0)
 ;;=4^E85.89
 ;;^UTILITY(U,$J,358.3,7882,2)
 ;;=^334034
 ;;^UTILITY(U,$J,358.3,7883,0)
 ;;=E85.81^^42^397^1
 ;;^UTILITY(U,$J,358.3,7883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7883,1,3,0)
 ;;=3^Amyloidosis,Light Chain (AL)
 ;;^UTILITY(U,$J,358.3,7883,1,4,0)
 ;;=4^E85.81
 ;;^UTILITY(U,$J,358.3,7883,2)
 ;;=^5151302
 ;;^UTILITY(U,$J,358.3,7884,0)
 ;;=E85.82^^42^397^4
 ;;^UTILITY(U,$J,358.3,7884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7884,1,3,0)
 ;;=3^Amyloidosis,Wild-type Transthyretin-related (ATTR)
 ;;^UTILITY(U,$J,358.3,7884,1,4,0)
 ;;=4^E85.82
 ;;^UTILITY(U,$J,358.3,7884,2)
 ;;=^5151303
 ;;^UTILITY(U,$J,358.3,7885,0)
 ;;=R45.851^^42^398^3
 ;;^UTILITY(U,$J,358.3,7885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7885,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,7885,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,7885,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,7886,0)
 ;;=T14.91XA^^42^398^4
 ;;^UTILITY(U,$J,358.3,7886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7886,1,3,0)
 ;;=3^Suicide Attempt,Initial Encntr
 ;;^UTILITY(U,$J,358.3,7886,1,4,0)
 ;;=4^T14.91XA
 ;;^UTILITY(U,$J,358.3,7886,2)
 ;;=^5151779
 ;;^UTILITY(U,$J,358.3,7887,0)
 ;;=T14.91XD^^42^398^6
 ;;^UTILITY(U,$J,358.3,7887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7887,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,7887,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,7887,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,7888,0)
 ;;=T14.91XS^^42^398^5
 ;;^UTILITY(U,$J,358.3,7888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7888,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,7888,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,7888,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,7889,0)
 ;;=Z91.51^^42^398^2
 ;;^UTILITY(U,$J,358.3,7889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7889,1,3,0)
 ;;=3^Personal Hx of Suicidal Behavior
 ;;^UTILITY(U,$J,358.3,7889,1,4,0)
 ;;=4^Z91.51
 ;;^UTILITY(U,$J,358.3,7889,2)
 ;;=^5161317
 ;;^UTILITY(U,$J,358.3,7890,0)
 ;;=Z91.52^^42^398^1
 ;;^UTILITY(U,$J,358.3,7890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7890,1,3,0)
 ;;=3^Personal Hx of Non-Suicidal Self-Harm
 ;;^UTILITY(U,$J,358.3,7890,1,4,0)
 ;;=4^Z91.52
 ;;^UTILITY(U,$J,358.3,7890,2)
 ;;=^5161318
 ;;^UTILITY(U,$J,358.3,7891,0)
 ;;=43235^^43^399^21^^^^1
 ;;^UTILITY(U,$J,358.3,7891,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7891,1,2,0)
 ;;=2^43235
 ;;^UTILITY(U,$J,358.3,7891,1,3,0)
 ;;=3^EGD,Diagnostic
 ;;^UTILITY(U,$J,358.3,7892,0)
 ;;=43239^^43^399^4^^^^1
 ;;^UTILITY(U,$J,358.3,7892,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7892,1,2,0)
 ;;=2^43239
 ;;^UTILITY(U,$J,358.3,7892,1,3,0)
 ;;=3^EGD w/ Biopsy
 ;;^UTILITY(U,$J,358.3,7893,0)
 ;;=43250^^43^399^13^^^^1
 ;;^UTILITY(U,$J,358.3,7893,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7893,1,2,0)
 ;;=2^43250
 ;;^UTILITY(U,$J,358.3,7893,1,3,0)
 ;;=3^EGD w/ Hot Forceps
 ;;^UTILITY(U,$J,358.3,7894,0)
 ;;=43251^^43^399^17^^^^1
 ;;^UTILITY(U,$J,358.3,7894,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7894,1,2,0)
 ;;=2^43251
 ;;^UTILITY(U,$J,358.3,7894,1,3,0)
 ;;=3^EGD w/ Snare
 ;;^UTILITY(U,$J,358.3,7895,0)
 ;;=43247^^43^399^12^^^^1
 ;;^UTILITY(U,$J,358.3,7895,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7895,1,2,0)
 ;;=2^43247
 ;;^UTILITY(U,$J,358.3,7895,1,3,0)
 ;;=3^EGD w/ Foreign Body Removal
 ;;^UTILITY(U,$J,358.3,7896,0)
 ;;=43255^^43^399^5^^^^1
 ;;^UTILITY(U,$J,358.3,7896,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7896,1,2,0)
 ;;=2^43255
 ;;^UTILITY(U,$J,358.3,7896,1,3,0)
 ;;=3^EGD w/ Control of Bleeding
 ;;^UTILITY(U,$J,358.3,7897,0)
 ;;=43245^^43^399^9^^^^1
 ;;^UTILITY(U,$J,358.3,7897,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7897,1,2,0)
 ;;=2^43245
 ;;^UTILITY(U,$J,358.3,7897,1,3,0)
 ;;=3^EGD w/ Dilation Stomach or Duodenum
 ;;^UTILITY(U,$J,358.3,7898,0)
 ;;=43248^^43^399^8^^^^1
 ;;^UTILITY(U,$J,358.3,7898,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7898,1,2,0)
 ;;=2^43248
 ;;^UTILITY(U,$J,358.3,7898,1,3,0)
 ;;=3^EGD w/ Dilation Esophagus Guidewire
 ;;^UTILITY(U,$J,358.3,7899,0)
 ;;=43249^^43^399^6^^^^1
 ;;^UTILITY(U,$J,358.3,7899,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7899,1,2,0)
 ;;=2^43249
 ;;^UTILITY(U,$J,358.3,7899,1,3,0)
 ;;=3^EGD w/ Dilation Esophagus Balloon <30mm
 ;;^UTILITY(U,$J,358.3,7900,0)
 ;;=43244^^43^399^3^^^^1
 ;;^UTILITY(U,$J,358.3,7900,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7900,1,2,0)
 ;;=2^43244
 ;;^UTILITY(U,$J,358.3,7900,1,3,0)
 ;;=3^EGD w/ Band Ligation
 ;;^UTILITY(U,$J,358.3,7901,0)
 ;;=43243^^43^399^16^^^^1
 ;;^UTILITY(U,$J,358.3,7901,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7901,1,2,0)
 ;;=2^43243
 ;;^UTILITY(U,$J,358.3,7901,1,3,0)
 ;;=3^EGD w/ Sclerosant Injection of Varices
 ;;^UTILITY(U,$J,358.3,7902,0)
 ;;=43236^^43^399^19^^^^1
 ;;^UTILITY(U,$J,358.3,7902,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7902,1,2,0)
 ;;=2^43236
 ;;^UTILITY(U,$J,358.3,7902,1,3,0)
 ;;=3^EGD w/ Submucosal Injection
 ;;^UTILITY(U,$J,358.3,7902,3,0)
 ;;=^357.33
 ;;^UTILITY(U,$J,358.3,7903,0)
 ;;=43257^^43^399^2^^^^1
 ;;^UTILITY(U,$J,358.3,7903,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7903,1,2,0)
 ;;=2^43257
 ;;^UTILITY(U,$J,358.3,7903,1,3,0)
 ;;=3^EGD w/ Ablation of Barrett's Esophagus
 ;;^UTILITY(U,$J,358.3,7904,0)
 ;;=43241^^43^399^14^^^^1
 ;;^UTILITY(U,$J,358.3,7904,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7904,1,2,0)
 ;;=2^43241
 ;;^UTILITY(U,$J,358.3,7904,1,3,0)
 ;;=3^EGD w/ Intraluminal Tube Placement
 ;;^UTILITY(U,$J,358.3,7905,0)
 ;;=43252^^43^399^11^^^^1
 ;;^UTILITY(U,$J,358.3,7905,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7905,1,2,0)
 ;;=2^43252
 ;;^UTILITY(U,$J,358.3,7905,1,3,0)
 ;;=3^EGD w/ Endomicroscopy/Optical Coherence Tomography
 ;;^UTILITY(U,$J,358.3,7906,0)
 ;;=43233^^43^399^7^^^^1
 ;;^UTILITY(U,$J,358.3,7906,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7906,1,2,0)
 ;;=2^43233
 ;;^UTILITY(U,$J,358.3,7906,1,3,0)
 ;;=3^EGD w/ Dilation Esophagus Balloon >30mm
 ;;^UTILITY(U,$J,358.3,7907,0)
 ;;=43266^^43^399^18^^^^1
 ;;^UTILITY(U,$J,358.3,7907,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7907,1,2,0)
 ;;=2^43266
 ;;^UTILITY(U,$J,358.3,7907,1,3,0)
 ;;=3^EGD w/ Stent
 ;;^UTILITY(U,$J,358.3,7908,0)
 ;;=43270^^43^399^1^^^^1
 ;;^UTILITY(U,$J,358.3,7908,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7908,1,2,0)
 ;;=2^43270
 ;;^UTILITY(U,$J,358.3,7908,1,3,0)
 ;;=3^EGD w/ Ablation
 ;;^UTILITY(U,$J,358.3,7909,0)
 ;;=43254^^43^399^10^^^^1
 ;;^UTILITY(U,$J,358.3,7909,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7909,1,2,0)
 ;;=2^43254
 ;;^UTILITY(U,$J,358.3,7909,1,3,0)
 ;;=3^EGD w/ EMR
 ;;^UTILITY(U,$J,358.3,7910,0)
 ;;=43246^^43^399^15^^^^1
 ;;^UTILITY(U,$J,358.3,7910,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7910,1,2,0)
 ;;=2^43246
 ;;^UTILITY(U,$J,358.3,7910,1,3,0)
 ;;=3^EGD w/ Percutaneous Gastrostomy Tube Placement
 ;;^UTILITY(U,$J,358.3,7911,0)
 ;;=91035^^43^399^20^^^^1
 ;;^UTILITY(U,$J,358.3,7911,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7911,1,2,0)
 ;;=2^91035
 ;;^UTILITY(U,$J,358.3,7911,1,3,0)
 ;;=3^EGD w/ Wireless pH Probe Placement & Study
 ;;^UTILITY(U,$J,358.3,7912,0)
 ;;=43200^^43^399^22^^^^1
 ;;^UTILITY(U,$J,358.3,7912,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7912,1,2,0)
 ;;=2^43200
 ;;^UTILITY(U,$J,358.3,7912,1,3,0)
 ;;=3^Esophagoscopy,Flexible,Transoral;Diagnostic
 ;;^UTILITY(U,$J,358.3,7913,0)
 ;;=43201^^43^399^25^^^^1
 ;;^UTILITY(U,$J,358.3,7913,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7913,1,2,0)
 ;;=2^43201
 ;;^UTILITY(U,$J,358.3,7913,1,3,0)
 ;;=3^Esophagoscopy,Flexible,Transoral;w/ Submucosal Inj
 ;;^UTILITY(U,$J,358.3,7914,0)
 ;;=43202^^43^399^23^^^^1
 ;;^UTILITY(U,$J,358.3,7914,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7914,1,2,0)
 ;;=2^43202
 ;;^UTILITY(U,$J,358.3,7914,1,3,0)
 ;;=3^Esophagoscopy,Flexible,Transoral;w/ Bx,1 or More
 ;;^UTILITY(U,$J,358.3,7915,0)
 ;;=43215^^43^399^24^^^^1
 ;;^UTILITY(U,$J,358.3,7915,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7915,1,2,0)
 ;;=2^43215
 ;;^UTILITY(U,$J,358.3,7915,1,3,0)
 ;;=3^Esophagoscopy,Flexible,Transoral;w/ FB Removal
 ;;^UTILITY(U,$J,358.3,7916,0)
 ;;=44360^^43^400^10^^^^1
 ;;^UTILITY(U,$J,358.3,7916,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7916,1,2,0)
 ;;=2^44360
 ;;^UTILITY(U,$J,358.3,7916,1,3,0)
 ;;=3^Enteroscopy,Diagnostic
 ;;^UTILITY(U,$J,358.3,7917,0)
 ;;=44361^^43^400^2^^^^1
 ;;^UTILITY(U,$J,358.3,7917,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7917,1,2,0)
 ;;=2^44361
 ;;^UTILITY(U,$J,358.3,7917,1,3,0)
 ;;=3^Enteroscopy w/ Biopsy
 ;;^UTILITY(U,$J,358.3,7918,0)
 ;;=44365^^43^400^6^^^^1
 ;;^UTILITY(U,$J,358.3,7918,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7918,1,2,0)
 ;;=2^44365
 ;;^UTILITY(U,$J,358.3,7918,1,3,0)
 ;;=3^Enteroscopy w/ Hot Forceps
 ;;^UTILITY(U,$J,358.3,7919,0)
 ;;=44364^^43^400^8^^^^1
 ;;^UTILITY(U,$J,358.3,7919,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7919,1,2,0)
 ;;=2^44364
 ;;^UTILITY(U,$J,358.3,7919,1,3,0)
 ;;=3^Enteroscopy w/ Snare
 ;;^UTILITY(U,$J,358.3,7920,0)
 ;;=44363^^43^400^5^^^^1
 ;;^UTILITY(U,$J,358.3,7920,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7920,1,2,0)
 ;;=2^44363
 ;;^UTILITY(U,$J,358.3,7920,1,3,0)
 ;;=3^Enteroscopy w/ Foreign Body Removal
 ;;^UTILITY(U,$J,358.3,7921,0)
 ;;=44369^^43^400^1^^^^1
 ;;^UTILITY(U,$J,358.3,7921,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7921,1,2,0)
 ;;=2^44369
 ;;^UTILITY(U,$J,358.3,7921,1,3,0)
 ;;=3^Enteroscopy w/ Ablation
 ;;^UTILITY(U,$J,358.3,7922,0)
 ;;=44366^^43^400^3^^^^1
 ;;^UTILITY(U,$J,358.3,7922,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7922,1,2,0)
 ;;=2^44366
 ;;^UTILITY(U,$J,358.3,7922,1,3,0)
 ;;=3^Enteroscopy w/ Control of Bleeding
 ;;^UTILITY(U,$J,358.3,7923,0)
 ;;=44370^^43^400^9^^^^1
 ;;^UTILITY(U,$J,358.3,7923,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7923,1,2,0)
 ;;=2^44370
 ;;^UTILITY(U,$J,358.3,7923,1,3,0)
 ;;=3^Enteroscopy w/ Stent Placement
 ;;^UTILITY(U,$J,358.3,7924,0)
 ;;=44372^^43^400^7^^^^1
 ;;^UTILITY(U,$J,358.3,7924,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7924,1,2,0)
 ;;=2^44372
 ;;^UTILITY(U,$J,358.3,7924,1,3,0)
 ;;=3^Enteroscopy w/ J-Tube Placement
 ;;^UTILITY(U,$J,358.3,7925,0)
 ;;=44373^^43^400^4^^^^1
 ;;^UTILITY(U,$J,358.3,7925,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7925,1,2,0)
 ;;=2^44373
 ;;^UTILITY(U,$J,358.3,7925,1,3,0)
 ;;=3^Enteroscopy w/ Conversion of G-Tube to J-Tube
 ;;^UTILITY(U,$J,358.3,7926,0)
 ;;=45330^^43^401^13^^^^1
 ;;^UTILITY(U,$J,358.3,7926,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7926,1,2,0)
 ;;=2^45330
 ;;^UTILITY(U,$J,358.3,7926,1,3,0)
 ;;=3^Flex Sig,Diagnostic
 ;;^UTILITY(U,$J,358.3,7927,0)
 ;;=45331^^43^401^3^^^^1
 ;;^UTILITY(U,$J,358.3,7927,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7927,1,2,0)
 ;;=2^45331
 ;;^UTILITY(U,$J,358.3,7927,1,3,0)
 ;;=3^Flex Sig w/ Biopsy
 ;;^UTILITY(U,$J,358.3,7928,0)
 ;;=45333^^43^401^9^^^^1
 ;;^UTILITY(U,$J,358.3,7928,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7928,1,2,0)
 ;;=2^45333
 ;;^UTILITY(U,$J,358.3,7928,1,3,0)
 ;;=3^Flex Sig w/ Hot Forceps
 ;;^UTILITY(U,$J,358.3,7929,0)
 ;;=45332^^43^401^8^^^^1
 ;;^UTILITY(U,$J,358.3,7929,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7929,1,2,0)
 ;;=2^45332
 ;;^UTILITY(U,$J,358.3,7929,1,3,0)
 ;;=3^Flex Sig w/ Foreign Body Removal
 ;;^UTILITY(U,$J,358.3,7930,0)
 ;;=45334^^43^401^4^^^^1
 ;;^UTILITY(U,$J,358.3,7930,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7930,1,2,0)
 ;;=2^45334
 ;;^UTILITY(U,$J,358.3,7930,1,3,0)
 ;;=3^Flex Sig w/ Control of Bleeding
 ;;^UTILITY(U,$J,358.3,7931,0)
 ;;=45335^^43^401^12^^^^1
 ;;^UTILITY(U,$J,358.3,7931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7931,1,2,0)
 ;;=2^45335
 ;;^UTILITY(U,$J,358.3,7931,1,3,0)
 ;;=3^Flex Sig w/ Submucosal Injection
 ;;^UTILITY(U,$J,358.3,7932,0)
 ;;=45337^^43^401^5^^^^1
 ;;^UTILITY(U,$J,358.3,7932,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7932,1,2,0)
 ;;=2^45337
 ;;^UTILITY(U,$J,358.3,7932,1,3,0)
 ;;=3^Flex Sig w/ Decompression 
 ;;^UTILITY(U,$J,358.3,7933,0)
 ;;=45346^^43^401^1^^^^1
 ;;^UTILITY(U,$J,358.3,7933,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7933,1,2,0)
 ;;=2^45346
 ;;^UTILITY(U,$J,358.3,7933,1,3,0)
 ;;=3^Flex Sig w/ Ablation
 ;;^UTILITY(U,$J,358.3,7934,0)
 ;;=45350^^43^401^2^^^^1
 ;;^UTILITY(U,$J,358.3,7934,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7934,1,2,0)
 ;;=2^45350
 ;;^UTILITY(U,$J,358.3,7934,1,3,0)
 ;;=3^Flex Sig w/ Band Ligation
 ;;^UTILITY(U,$J,358.3,7935,0)
 ;;=45340^^43^401^6^^^^1
 ;;^UTILITY(U,$J,358.3,7935,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7935,1,2,0)
 ;;=2^45340
 ;;^UTILITY(U,$J,358.3,7935,1,3,0)
 ;;=3^Flex Sig w/ Dilation
 ;;^UTILITY(U,$J,358.3,7936,0)
 ;;=45349^^43^401^7^^^^1
 ;;^UTILITY(U,$J,358.3,7936,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7936,1,2,0)
 ;;=2^45349
 ;;^UTILITY(U,$J,358.3,7936,1,3,0)
 ;;=3^Flex Sig w/ EMR
 ;;^UTILITY(U,$J,358.3,7937,0)
 ;;=45338^^43^401^10^^^^1
 ;;^UTILITY(U,$J,358.3,7937,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7937,1,2,0)
 ;;=2^45338
 ;;^UTILITY(U,$J,358.3,7937,1,3,0)
 ;;=3^Flex Sig w/ Snare
 ;;^UTILITY(U,$J,358.3,7938,0)
 ;;=45347^^43^401^11^^^^1
 ;;^UTILITY(U,$J,358.3,7938,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7938,1,2,0)
 ;;=2^45347
 ;;^UTILITY(U,$J,358.3,7938,1,3,0)
 ;;=3^Flex Sig w/ Stent Placement
 ;;^UTILITY(U,$J,358.3,7939,0)
 ;;=45378^^43^402^13^^^^1
 ;;^UTILITY(U,$J,358.3,7939,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7939,1,2,0)
 ;;=2^45378
 ;;^UTILITY(U,$J,358.3,7939,1,3,0)
 ;;=3^Colonoscopy,Diagnostic
 ;;^UTILITY(U,$J,358.3,7940,0)
 ;;=45380^^43^402^3^^^^1
 ;;^UTILITY(U,$J,358.3,7940,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7940,1,2,0)
 ;;=2^45380
 ;;^UTILITY(U,$J,358.3,7940,1,3,0)
 ;;=3^Colonoscopy w/ Biopsy
 ;;^UTILITY(U,$J,358.3,7941,0)
 ;;=45384^^43^402^9^^^^1
 ;;^UTILITY(U,$J,358.3,7941,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7941,1,2,0)
 ;;=2^45384
 ;;^UTILITY(U,$J,358.3,7941,1,3,0)
 ;;=3^Colonoscopy w/ Hot Forceps
 ;;^UTILITY(U,$J,358.3,7942,0)
 ;;=45385^^43^402^10^^^^1
 ;;^UTILITY(U,$J,358.3,7942,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7942,1,2,0)
 ;;=2^45385
 ;;^UTILITY(U,$J,358.3,7942,1,3,0)
 ;;=3^Colonoscopy w/ Snare
 ;;^UTILITY(U,$J,358.3,7943,0)
 ;;=45379^^43^402^8^^^^1
 ;;^UTILITY(U,$J,358.3,7943,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7943,1,2,0)
 ;;=2^45379
 ;;^UTILITY(U,$J,358.3,7943,1,3,0)
 ;;=3^Colonoscopy w/ Foreign Body Removal
 ;;^UTILITY(U,$J,358.3,7944,0)
 ;;=45382^^43^402^4^^^^1
 ;;^UTILITY(U,$J,358.3,7944,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7944,1,2,0)
 ;;=2^45382
 ;;^UTILITY(U,$J,358.3,7944,1,3,0)
 ;;=3^Colonoscopy w/ Control of Bleeding
 ;;^UTILITY(U,$J,358.3,7945,0)
 ;;=45386^^43^402^6^^^^1
 ;;^UTILITY(U,$J,358.3,7945,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7945,1,2,0)
 ;;=2^45386
 ;;^UTILITY(U,$J,358.3,7945,1,3,0)
 ;;=3^Colonoscopy w/ Dilation
 ;;^UTILITY(U,$J,358.3,7946,0)
 ;;=45381^^43^402^12^^^^1
 ;;^UTILITY(U,$J,358.3,7946,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7946,1,2,0)
 ;;=2^45381
 ;;^UTILITY(U,$J,358.3,7946,1,3,0)
 ;;=3^Colonoscopy w/ Submucosal Injection
 ;;^UTILITY(U,$J,358.3,7947,0)
 ;;=45389^^43^402^11^^^^1
 ;;^UTILITY(U,$J,358.3,7947,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7947,1,2,0)
 ;;=2^45389
 ;;^UTILITY(U,$J,358.3,7947,1,3,0)
 ;;=3^Colonoscopy w/ Stent
 ;;^UTILITY(U,$J,358.3,7948,0)
 ;;=45388^^43^402^2^^^^1
 ;;^UTILITY(U,$J,358.3,7948,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7948,1,2,0)
 ;;=2^45388
 ;;^UTILITY(U,$J,358.3,7948,1,3,0)
 ;;=3^Colonoscopy w/ Ablation
 ;;^UTILITY(U,$J,358.3,7949,0)
 ;;=45393^^43^402^5^^^^1
 ;;^UTILITY(U,$J,358.3,7949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7949,1,2,0)
 ;;=2^45393
 ;;^UTILITY(U,$J,358.3,7949,1,3,0)
 ;;=3^Colonoscopy w/ Decompression
 ;;^UTILITY(U,$J,358.3,7950,0)
 ;;=G0121^^43^402^14^^^^1
 ;;^UTILITY(U,$J,358.3,7950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7950,1,2,0)
 ;;=2^G0121
 ;;^UTILITY(U,$J,358.3,7950,1,3,0)
 ;;=3^Colonoscopy,Screening (Average Risk)
 ;;^UTILITY(U,$J,358.3,7951,0)
 ;;=G0105^^43^402^15^^^^1
 ;;^UTILITY(U,$J,358.3,7951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7951,1,2,0)
 ;;=2^G0105
 ;;^UTILITY(U,$J,358.3,7951,1,3,0)
 ;;=3^Colonoscopy,Screening (High Risk)
 ;;^UTILITY(U,$J,358.3,7952,0)
 ;;=45390^^43^402^7^^^^1
 ;;^UTILITY(U,$J,358.3,7952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7952,1,2,0)
 ;;=2^45390
 ;;^UTILITY(U,$J,358.3,7952,1,3,0)
 ;;=3^Colonoscopy w/ EMR
 ;;^UTILITY(U,$J,358.3,7953,0)
 ;;=44388^^43^402^1^^^^1
 ;;^UTILITY(U,$J,358.3,7953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7953,1,2,0)
 ;;=2^44388
 ;;^UTILITY(U,$J,358.3,7953,1,3,0)
 ;;=3^Colonoscopy via Stoma;Diagnostic
 ;;^UTILITY(U,$J,358.3,7954,0)
 ;;=43260^^43^403^13^^^^1
 ;;^UTILITY(U,$J,358.3,7954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7954,1,2,0)
 ;;=2^43260
 ;;^UTILITY(U,$J,358.3,7954,1,3,0)
 ;;=3^ERCP,Diagnostic
 ;;^UTILITY(U,$J,358.3,7955,0)
 ;;=43264^^43^403^5^^^^1
 ;;^UTILITY(U,$J,358.3,7955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7955,1,2,0)
 ;;=2^43264
 ;;^UTILITY(U,$J,358.3,7955,1,3,0)
 ;;=3^ERCP w/ Calculi or Debris Removal
 ;;^UTILITY(U,$J,358.3,7956,0)
 ;;=43262^^43^403^10^^^^1
 ;;^UTILITY(U,$J,358.3,7956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7956,1,2,0)
 ;;=2^43262
 ;;^UTILITY(U,$J,358.3,7956,1,3,0)
 ;;=3^ERCP w/ Sphincterotomy/Papillotomy
 ;;^UTILITY(U,$J,358.3,7957,0)
 ;;=43261^^43^403^3^^^^1
 ;;^UTILITY(U,$J,358.3,7957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7957,1,2,0)
 ;;=2^43261
 ;;^UTILITY(U,$J,358.3,7957,1,3,0)
 ;;=3^ERCP w/ Biopsy
 ;;^UTILITY(U,$J,358.3,7958,0)
 ;;=43263^^43^403^9^^^^1
 ;;^UTILITY(U,$J,358.3,7958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7958,1,2,0)
 ;;=2^43263
 ;;^UTILITY(U,$J,358.3,7958,1,3,0)
 ;;=3^ERCP w/ Pressure Measurement of Sphincter
 ;;^UTILITY(U,$J,358.3,7959,0)
 ;;=43265^^43^403^4^^^^1
 ;;^UTILITY(U,$J,358.3,7959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7959,1,2,0)
 ;;=2^43265
 ;;^UTILITY(U,$J,358.3,7959,1,3,0)
 ;;=3^ERCP w/ Calculi Destruction,Any Method
 ;;^UTILITY(U,$J,358.3,7960,0)
 ;;=43273^^43^403^7^^^^1
 ;;^UTILITY(U,$J,358.3,7960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7960,1,2,0)
 ;;=2^43273
 ;;^UTILITY(U,$J,358.3,7960,1,3,0)
 ;;=3^ERCP w/ Direct Visualization of Pancreatic/Common Bile Duct
 ;;^UTILITY(U,$J,358.3,7961,0)
 ;;=43274^^43^403^12^^^^1
 ;;^UTILITY(U,$J,358.3,7961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7961,1,2,0)
 ;;=2^43274
