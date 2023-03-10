IBDEI00I ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,615,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,615,1,1,0)
 ;;=1^J1453
 ;;^UTILITY(U,$J,358.3,615,1,3,0)
 ;;=3^Fosaprepitant 1mg
 ;;^UTILITY(U,$J,358.3,616,0)
 ;;=J1710^^8^53^58^^^^1
 ;;^UTILITY(U,$J,358.3,616,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,616,1,1,0)
 ;;=1^J1710
 ;;^UTILITY(U,$J,358.3,616,1,3,0)
 ;;=3^Hydrocortisone Sodium Phos,up to 50mg
 ;;^UTILITY(U,$J,358.3,617,0)
 ;;=J2150^^8^53^73^^^^1
 ;;^UTILITY(U,$J,358.3,617,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,617,1,1,0)
 ;;=1^J2150
 ;;^UTILITY(U,$J,358.3,617,1,3,0)
 ;;=3^Mannitol 25% in 50 ml
 ;;^UTILITY(U,$J,358.3,618,0)
 ;;=J2354^^8^53^89^^^^1
 ;;^UTILITY(U,$J,358.3,618,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,618,1,1,0)
 ;;=1^J2354
 ;;^UTILITY(U,$J,358.3,618,1,3,0)
 ;;=3^Octreotide IV 1mg
 ;;^UTILITY(U,$J,358.3,619,0)
 ;;=J2997^^8^53^5^^^^1
 ;;^UTILITY(U,$J,358.3,619,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,619,1,1,0)
 ;;=1^J2997
 ;;^UTILITY(U,$J,358.3,619,1,3,0)
 ;;=3^Alteplase Recombinant 1mg
 ;;^UTILITY(U,$J,358.3,620,0)
 ;;=J3262^^8^53^109^^^^1
 ;;^UTILITY(U,$J,358.3,620,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,620,1,1,0)
 ;;=1^J3262
 ;;^UTILITY(U,$J,358.3,620,1,3,0)
 ;;=3^Tacilizumab 1mg
 ;;^UTILITY(U,$J,358.3,621,0)
 ;;=J9033^^8^53^13^^^^1
 ;;^UTILITY(U,$J,358.3,621,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,621,1,1,0)
 ;;=1^J9033
 ;;^UTILITY(U,$J,358.3,621,1,3,0)
 ;;=3^Bendamustine HC1 (Treanda) 1mg
 ;;^UTILITY(U,$J,358.3,622,0)
 ;;=J9178^^8^53^48^^^^1
 ;;^UTILITY(U,$J,358.3,622,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,622,1,1,0)
 ;;=1^J9178
 ;;^UTILITY(U,$J,358.3,622,1,3,0)
 ;;=3^Epirubicin HCl 2mg
 ;;^UTILITY(U,$J,358.3,623,0)
 ;;=J9305^^8^53^97^^^^1
 ;;^UTILITY(U,$J,358.3,623,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,623,1,1,0)
 ;;=1^J9305
 ;;^UTILITY(U,$J,358.3,623,1,3,0)
 ;;=3^Pemetrexed 10mg
 ;;^UTILITY(U,$J,358.3,624,0)
 ;;=J2270^^8^53^82^^^^1
 ;;^UTILITY(U,$J,358.3,624,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,624,1,1,0)
 ;;=1^J2270
 ;;^UTILITY(U,$J,358.3,624,1,3,0)
 ;;=3^Morphine Sulfate 10mg
 ;;^UTILITY(U,$J,358.3,625,0)
 ;;=J9267^^8^53^92^^^^1
 ;;^UTILITY(U,$J,358.3,625,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,625,1,1,0)
 ;;=1^J9267
 ;;^UTILITY(U,$J,358.3,625,1,3,0)
 ;;=3^Paclitaxel 1mg
 ;;^UTILITY(U,$J,358.3,626,0)
 ;;=J2274^^8^53^83^^^^1
 ;;^UTILITY(U,$J,358.3,626,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,626,1,1,0)
 ;;=1^J2274
 ;;^UTILITY(U,$J,358.3,626,1,3,0)
 ;;=3^Morphine Sulfate,Preservative-Free 10mg
 ;;^UTILITY(U,$J,358.3,627,0)
 ;;=J9025^^8^53^10^^^^1
 ;;^UTILITY(U,$J,358.3,627,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,627,1,1,0)
 ;;=1^J9025
 ;;^UTILITY(U,$J,358.3,627,1,3,0)
 ;;=3^Azacitidine 1mg
 ;;^UTILITY(U,$J,358.3,628,0)
 ;;=J9330^^8^53^111^^^^1
 ;;^UTILITY(U,$J,358.3,628,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,628,1,1,0)
 ;;=1^J9330
 ;;^UTILITY(U,$J,358.3,628,1,3,0)
 ;;=3^Temsirolimus 1mg
 ;;^UTILITY(U,$J,358.3,629,0)
 ;;=J9355^^8^53^113^^^^1
 ;;^UTILITY(U,$J,358.3,629,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,629,1,1,0)
 ;;=1^J9355
 ;;^UTILITY(U,$J,358.3,629,1,3,0)
 ;;=3^Trastuzumab 10mg
 ;;^UTILITY(U,$J,358.3,630,0)
 ;;=J9299^^8^53^86^^^^1
 ;;^UTILITY(U,$J,358.3,630,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,630,1,1,0)
 ;;=1^J9299
 ;;^UTILITY(U,$J,358.3,630,1,3,0)
 ;;=3^Nivolumab 1mg
 ;;^UTILITY(U,$J,358.3,631,0)
 ;;=J9263^^8^53^91^^^^1
 ;;^UTILITY(U,$J,358.3,631,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,631,1,1,0)
 ;;=1^J9263
 ;;^UTILITY(U,$J,358.3,631,1,3,0)
 ;;=3^Oxaliplatin 0.5mg
 ;;^UTILITY(U,$J,358.3,632,0)
 ;;=J7030^^8^53^87^^^^1
 ;;^UTILITY(U,$J,358.3,632,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,632,1,1,0)
 ;;=1^J7030
 ;;^UTILITY(U,$J,358.3,632,1,3,0)
 ;;=3^Normal Saline 1000cc
 ;;^UTILITY(U,$J,358.3,633,0)
 ;;=J9043^^8^53^19^^^^1
 ;;^UTILITY(U,$J,358.3,633,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,633,1,1,0)
 ;;=1^J9043
 ;;^UTILITY(U,$J,358.3,633,1,3,0)
 ;;=3^Cabazitaxel 1mg
 ;;^UTILITY(U,$J,358.3,634,0)
 ;;=J9047^^8^53^22^^^^1
 ;;^UTILITY(U,$J,358.3,634,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,634,1,1,0)
 ;;=1^J9047
 ;;^UTILITY(U,$J,358.3,634,1,3,0)
 ;;=3^Carfilzomib 1mg
 ;;^UTILITY(U,$J,358.3,635,0)
 ;;=J9271^^8^53^96^^^^1
 ;;^UTILITY(U,$J,358.3,635,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,635,1,1,0)
 ;;=1^J9271
 ;;^UTILITY(U,$J,358.3,635,1,3,0)
 ;;=3^Pembrolizumab 1mg
 ;;^UTILITY(U,$J,358.3,636,0)
 ;;=J9308^^8^53^101^^^^1
 ;;^UTILITY(U,$J,358.3,636,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,636,1,1,0)
 ;;=1^J9308
 ;;^UTILITY(U,$J,358.3,636,1,3,0)
 ;;=3^Ramucirumab 5mg
 ;;^UTILITY(U,$J,358.3,637,0)
 ;;=J0256^^8^53^4^^^^1
 ;;^UTILITY(U,$J,358.3,637,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,637,1,1,0)
 ;;=1^J0256
 ;;^UTILITY(U,$J,358.3,637,1,3,0)
 ;;=3^Alpha 1 Proteinase Inhibitor 10mg
 ;;^UTILITY(U,$J,358.3,638,0)
 ;;=J1650^^8^53^47^^^^1
 ;;^UTILITY(U,$J,358.3,638,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,638,1,1,0)
 ;;=1^J1650
 ;;^UTILITY(U,$J,358.3,638,1,3,0)
 ;;=3^Enoxaparin Sodium 10mg
 ;;^UTILITY(U,$J,358.3,639,0)
 ;;=J1580^^8^53^54^^^^1
 ;;^UTILITY(U,$J,358.3,639,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,639,1,1,0)
 ;;=1^J1580
 ;;^UTILITY(U,$J,358.3,639,1,3,0)
 ;;=3^Garamycin Gentamicin,up to 80mg
 ;;^UTILITY(U,$J,358.3,640,0)
 ;;=J7504^^8^53^72^^^^1
 ;;^UTILITY(U,$J,358.3,640,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,640,1,1,0)
 ;;=1^J7504
 ;;^UTILITY(U,$J,358.3,640,1,3,0)
 ;;=3^Lymphocyte Immune Globulin;Parenteral 250mg
 ;;^UTILITY(U,$J,358.3,641,0)
 ;;=Q0163^^8^53^40^^^^1
 ;;^UTILITY(U,$J,358.3,641,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,641,1,1,0)
 ;;=1^Q0163
 ;;^UTILITY(U,$J,358.3,641,1,3,0)
 ;;=3^Diphenhydramine HCL 50mg
 ;;^UTILITY(U,$J,358.3,642,0)
 ;;=J9311^^8^53^104^^^^1
 ;;^UTILITY(U,$J,358.3,642,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,642,1,1,0)
 ;;=1^J9311
 ;;^UTILITY(U,$J,358.3,642,1,3,0)
 ;;=3^Rituximab 10mg & Hyaluronidase
 ;;^UTILITY(U,$J,358.3,643,0)
 ;;=J9312^^8^53^103^^^^1
 ;;^UTILITY(U,$J,358.3,643,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,643,1,1,0)
 ;;=1^J9312
 ;;^UTILITY(U,$J,358.3,643,1,3,0)
 ;;=3^Rituximab 10mg
 ;;^UTILITY(U,$J,358.3,644,0)
 ;;=96549^^8^53^25^^^^1
 ;;^UTILITY(U,$J,358.3,644,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,644,1,1,0)
 ;;=1^96549
 ;;^UTILITY(U,$J,358.3,644,1,3,0)
 ;;=3^Chemotherapy Unspec
 ;;^UTILITY(U,$J,358.3,645,0)
 ;;=J9030^^8^53^11^^^^1
 ;;^UTILITY(U,$J,358.3,645,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,645,1,1,0)
 ;;=1^J9030
 ;;^UTILITY(U,$J,358.3,645,1,3,0)
 ;;=3^BCG Live Intravesical 1mg
 ;;^UTILITY(U,$J,358.3,646,0)
 ;;=J9061^^8^53^6^^^^1
 ;;^UTILITY(U,$J,358.3,646,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,646,1,1,0)
 ;;=1^J9061
 ;;^UTILITY(U,$J,358.3,646,1,3,0)
 ;;=3^Amivantamab-vmjw (Rybrevant) 2mg
 ;;^UTILITY(U,$J,358.3,647,0)
 ;;=J9021^^8^53^8^^^^1
 ;;^UTILITY(U,$J,358.3,647,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,647,1,1,0)
 ;;=1^J9021
 ;;^UTILITY(U,$J,358.3,647,1,3,0)
 ;;=3^Asparaginase,Recombinant (Rylaze) 0.1mg
 ;;^UTILITY(U,$J,358.3,648,0)
 ;;=J9037^^8^53^12^^^^1
 ;;^UTILITY(U,$J,358.3,648,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,648,1,1,0)
 ;;=1^J9037
 ;;^UTILITY(U,$J,358.3,648,1,3,0)
 ;;=3^Belantamab Mafodontin-blmf (Blenrep) 0.5mg
 ;;^UTILITY(U,$J,358.3,649,0)
 ;;=J9272^^8^53^42^^^^1
 ;;^UTILITY(U,$J,358.3,649,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,649,1,1,0)
 ;;=1^J9272
 ;;^UTILITY(U,$J,358.3,649,1,3,0)
 ;;=3^Dostarlimab-gxly (Jemperli) 10mg
 ;;^UTILITY(U,$J,358.3,650,0)
 ;;=J1554^^8^53^61^^^^1
 ;;^UTILITY(U,$J,358.3,650,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,650,1,1,0)
 ;;=1^J1554
 ;;^UTILITY(U,$J,358.3,650,1,3,0)
 ;;=3^Immune Globulin (Asceniv) 500mg
 ;;^UTILITY(U,$J,358.3,651,0)
 ;;=J1952^^8^53^67^^^^1
 ;;^UTILITY(U,$J,358.3,651,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,651,1,1,0)
 ;;=1^J1952
 ;;^UTILITY(U,$J,358.3,651,1,3,0)
 ;;=3^Leuprolide (Camcevi) 1mg
 ;;^UTILITY(U,$J,358.3,652,0)
 ;;=J9353^^8^53^74^^^^1
 ;;^UTILITY(U,$J,358.3,652,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,652,1,1,0)
 ;;=1^J9353
 ;;^UTILITY(U,$J,358.3,652,1,3,0)
 ;;=3^Margetuximab-cmkb 5mg
 ;;^UTILITY(U,$J,358.3,653,0)
 ;;=J9348^^8^53^85^^^^1
 ;;^UTILITY(U,$J,358.3,653,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,653,1,1,0)
 ;;=1^J9348
 ;;^UTILITY(U,$J,358.3,653,1,3,0)
 ;;=3^Naxitamab-gqgk 1mg
 ;;^UTILITY(U,$J,358.3,654,0)
 ;;=J2506^^8^53^95^^^^1
 ;;^UTILITY(U,$J,358.3,654,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,654,1,1,0)
 ;;=1^J2506
 ;;^UTILITY(U,$J,358.3,654,1,3,0)
 ;;=3^Pegfilgrastim,Excludes Biosimilar,0.5mg
 ;;^UTILITY(U,$J,358.3,655,0)
 ;;=J9349^^8^53^110^^^^1
 ;;^UTILITY(U,$J,358.3,655,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,655,1,1,0)
 ;;=1^J9349
 ;;^UTILITY(U,$J,358.3,655,1,3,0)
 ;;=3^Tafasitamab-cxix (Monjuvl) 2mg
 ;;^UTILITY(U,$J,358.3,656,0)
 ;;=J9034^^8^53^14^^^^1
 ;;^UTILITY(U,$J,358.3,656,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,656,1,1,0)
 ;;=1^J9034
 ;;^UTILITY(U,$J,358.3,656,1,3,0)
 ;;=3^Bendamustine HCl (Bendeka) 1mg
 ;;^UTILITY(U,$J,358.3,657,0)
 ;;=J9332^^8^53^46^^^^1
 ;;^UTILITY(U,$J,358.3,657,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,657,1,1,0)
 ;;=1^J9332
 ;;^UTILITY(U,$J,358.3,657,1,3,0)
 ;;=3^Efgartimimod Alfa-Fcab 2mg
 ;;^UTILITY(U,$J,358.3,658,0)
 ;;=J9318^^8^53^106^^^^1
 ;;^UTILITY(U,$J,358.3,658,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,658,1,1,0)
 ;;=1^J9318
 ;;^UTILITY(U,$J,358.3,658,1,3,0)
 ;;=3^Romidepsin,Non-Lyophilized 0.1mg
 ;;^UTILITY(U,$J,358.3,659,0)
 ;;=J9319^^8^53^105^^^^1
 ;;^UTILITY(U,$J,358.3,659,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,659,1,1,0)
 ;;=1^J9319
 ;;^UTILITY(U,$J,358.3,659,1,3,0)
 ;;=3^Romidepsin,Lyophilized 0.1mg
 ;;^UTILITY(U,$J,358.3,660,0)
 ;;=P9010^^8^54^22^^^^1
 ;;^UTILITY(U,$J,358.3,660,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,660,1,1,0)
 ;;=1^P9010
 ;;^UTILITY(U,$J,358.3,660,1,3,0)
 ;;=3^Whole Blood,Ea Unit
 ;;^UTILITY(U,$J,358.3,661,0)
 ;;=P9012^^8^54^4^^^^1
 ;;^UTILITY(U,$J,358.3,661,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,661,1,1,0)
 ;;=1^P9012
 ;;^UTILITY(U,$J,358.3,661,1,3,0)
 ;;=3^Cryoprecipitate,Ea Unit
 ;;^UTILITY(U,$J,358.3,662,0)
 ;;=P9016^^8^54^18^^^^1
 ;;^UTILITY(U,$J,358.3,662,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,662,1,1,0)
 ;;=1^P9016
 ;;^UTILITY(U,$J,358.3,662,1,3,0)
 ;;=3^RBC Leukocytes Reduced
 ;;^UTILITY(U,$J,358.3,663,0)
 ;;=P9017^^8^54^6^^^^1
 ;;^UTILITY(U,$J,358.3,663,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,663,1,1,0)
 ;;=1^P9017
 ;;^UTILITY(U,$J,358.3,663,1,3,0)
 ;;=3^Plasma 1 Donor Frz w/in 8hrs
 ;;^UTILITY(U,$J,358.3,664,0)
 ;;=P9019^^8^54^10^^^^1
 ;;^UTILITY(U,$J,358.3,664,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,664,1,1,0)
 ;;=1^P9019
 ;;^UTILITY(U,$J,358.3,664,1,3,0)
 ;;=3^Platelets,Ea Unit
 ;;^UTILITY(U,$J,358.3,665,0)
 ;;=P9021^^8^54^20^^^^1
 ;;^UTILITY(U,$J,358.3,665,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,665,1,1,0)
 ;;=1^P9021
 ;;^UTILITY(U,$J,358.3,665,1,3,0)
 ;;=3^Red Blood Cells,Ea Unit
 ;;^UTILITY(U,$J,358.3,666,0)
 ;;=P9022^^8^54^21^^^^1
 ;;^UTILITY(U,$J,358.3,666,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,666,1,1,0)
 ;;=1^P9022
 ;;^UTILITY(U,$J,358.3,666,1,3,0)
 ;;=3^Washed Red Blood Cells,Ea Unit
 ;;^UTILITY(U,$J,358.3,667,0)
 ;;=P9023^^8^54^5^^^^1
 ;;^UTILITY(U,$J,358.3,667,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,667,1,1,0)
 ;;=1^P9023
 ;;^UTILITY(U,$J,358.3,667,1,3,0)
 ;;=3^Frozen Plasma,Pooled,SD
 ;;^UTILITY(U,$J,358.3,668,0)
 ;;=P9034^^8^54^12^^^^1
 ;;^UTILITY(U,$J,358.3,668,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,668,1,1,0)
 ;;=1^P9034
 ;;^UTILITY(U,$J,358.3,668,1,3,0)
 ;;=3^Platelets,Pheresis
 ;;^UTILITY(U,$J,358.3,669,0)
 ;;=P9035^^8^54^8^^^^1
 ;;^UTILITY(U,$J,358.3,669,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,669,1,1,0)
 ;;=1^P9035
 ;;^UTILITY(U,$J,358.3,669,1,3,0)
 ;;=3^Platelet Pheres Leuko Reduced
 ;;^UTILITY(U,$J,358.3,670,0)
 ;;=P9036^^8^54^9^^^^1
 ;;^UTILITY(U,$J,358.3,670,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,670,1,1,0)
 ;;=1^P9036
 ;;^UTILITY(U,$J,358.3,670,1,3,0)
 ;;=3^Platelet Pheres Leukoredu Irrad
 ;;^UTILITY(U,$J,358.3,671,0)
 ;;=P9038^^8^54^16^^^^1
 ;;^UTILITY(U,$J,358.3,671,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,671,1,1,0)
 ;;=1^P9038
 ;;^UTILITY(U,$J,358.3,671,1,3,0)
 ;;=3^RBC Irradiated
 ;;^UTILITY(U,$J,358.3,672,0)
 ;;=P9039^^8^54^15^^^^1
 ;;^UTILITY(U,$J,358.3,672,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,672,1,1,0)
 ;;=1^P9039
 ;;^UTILITY(U,$J,358.3,672,1,3,0)
 ;;=3^RBC Deglycerolized
 ;;^UTILITY(U,$J,358.3,673,0)
 ;;=P9040^^8^54^17^^^^1
 ;;^UTILITY(U,$J,358.3,673,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,673,1,1,0)
 ;;=1^P9040
 ;;^UTILITY(U,$J,358.3,673,1,3,0)
 ;;=3^RBC Leuko Reduced Irradiated
 ;;^UTILITY(U,$J,358.3,674,0)
 ;;=P9044^^8^54^3^^^^1
 ;;^UTILITY(U,$J,358.3,674,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,674,1,1,0)
 ;;=1^P9044
 ;;^UTILITY(U,$J,358.3,674,1,3,0)
 ;;=3^Cryoprecip Reduced Plasma
 ;;^UTILITY(U,$J,358.3,675,0)
 ;;=P9051^^8^54^1^^^^1
 ;;^UTILITY(U,$J,358.3,675,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,675,1,1,0)
 ;;=1^P9051
 ;;^UTILITY(U,$J,358.3,675,1,3,0)
 ;;=3^Blood,L/R,CMV-Neg
 ;;^UTILITY(U,$J,358.3,676,0)
 ;;=P9052^^8^54^11^^^^1
 ;;^UTILITY(U,$J,358.3,676,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,676,1,1,0)
 ;;=1^P9052
 ;;^UTILITY(U,$J,358.3,676,1,3,0)
 ;;=3^Platelets,HLA-M,L/R,Ea Unit
 ;;^UTILITY(U,$J,358.3,677,0)
 ;;=P9053^^8^54^14^^^^1
 ;;^UTILITY(U,$J,358.3,677,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,677,1,1,0)
 ;;=1^P9053
 ;;^UTILITY(U,$J,358.3,677,1,3,0)
 ;;=3^Plt,Pher,L/R CMV-Neg,Irr
 ;;^UTILITY(U,$J,358.3,678,0)
 ;;=P9054^^8^54^2^^^^1
 ;;^UTILITY(U,$J,358.3,678,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,678,1,1,0)
 ;;=1^P9054
 ;;^UTILITY(U,$J,358.3,678,1,3,0)
 ;;=3^Blood,L/R,Froz/Degly/Wash
 ;;^UTILITY(U,$J,358.3,679,0)
 ;;=P9055^^8^54^13^^^^1
 ;;^UTILITY(U,$J,358.3,679,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,679,1,1,0)
 ;;=1^P9055
 ;;^UTILITY(U,$J,358.3,679,1,3,0)
 ;;=3^Plt,Aph/Pher,L/R,CMV-Neg
 ;;^UTILITY(U,$J,358.3,680,0)
 ;;=P9058^^8^54^19^^^^1
 ;;^UTILITY(U,$J,358.3,680,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,680,1,1,0)
 ;;=1^P9058
 ;;^UTILITY(U,$J,358.3,680,1,3,0)
 ;;=3^RBC,L/R,CMV-Neg,Irrad
 ;;^UTILITY(U,$J,358.3,681,0)
 ;;=P9059^^8^54^7^^^^1
 ;;^UTILITY(U,$J,358.3,681,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,681,1,1,0)
 ;;=1^P9059
 ;;^UTILITY(U,$J,358.3,681,1,3,0)
 ;;=3^Plasma,Frz Between 8-24hrs
 ;;^UTILITY(U,$J,358.3,682,0)
 ;;=38220^^8^55^6^^^^1
 ;;^UTILITY(U,$J,358.3,682,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,682,1,1,0)
 ;;=1^38220
 ;;^UTILITY(U,$J,358.3,682,1,3,0)
 ;;=3^Bone Marrow Aspiration
 ;;^UTILITY(U,$J,358.3,683,0)
 ;;=38221^^8^55^7^^^^1
 ;;^UTILITY(U,$J,358.3,683,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,683,1,1,0)
 ;;=1^38221
 ;;^UTILITY(U,$J,358.3,683,1,3,0)
 ;;=3^Bone Marrow Biopsy
 ;;^UTILITY(U,$J,358.3,684,0)
 ;;=19000^^8^55^8^^^^1
 ;;^UTILITY(U,$J,358.3,684,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,684,1,1,0)
 ;;=1^19000
 ;;^UTILITY(U,$J,358.3,684,1,3,0)
 ;;=3^Breast Cyst Aspiration
 ;;^UTILITY(U,$J,358.3,685,0)
 ;;=19100^^8^55^9^^^^1
 ;;^UTILITY(U,$J,358.3,685,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,685,1,1,0)
 ;;=1^19100
 ;;^UTILITY(U,$J,358.3,685,1,3,0)
 ;;=3^Breast Needle Biopsy
 ;;^UTILITY(U,$J,358.3,686,0)
 ;;=10021^^8^55^18^^^^1
 ;;^UTILITY(U,$J,358.3,686,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,686,1,1,0)
 ;;=1^10021
 ;;^UTILITY(U,$J,358.3,686,1,3,0)
 ;;=3^FNA w/o Image,1st Lesion
 ;;^UTILITY(U,$J,358.3,687,0)
 ;;=49082^^8^55^23^^^^1
 ;;^UTILITY(U,$J,358.3,687,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,687,1,1,0)
 ;;=1^49082
 ;;^UTILITY(U,$J,358.3,687,1,3,0)
 ;;=3^Paracentesis
 ;;^UTILITY(U,$J,358.3,688,0)
 ;;=99195^^8^55^25^^^^1
 ;;^UTILITY(U,$J,358.3,688,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,688,1,1,0)
 ;;=1^99195
 ;;^UTILITY(U,$J,358.3,688,1,3,0)
 ;;=3^Phlebotomy,Therapeutic
 ;;^UTILITY(U,$J,358.3,689,0)
 ;;=32554^^8^55^27^^^^1
 ;;^UTILITY(U,$J,358.3,689,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,689,1,1,0)
 ;;=1^32554
 ;;^UTILITY(U,$J,358.3,689,1,3,0)
 ;;=3^Thoracentesis
 ;;^UTILITY(U,$J,358.3,690,0)
 ;;=49083^^8^55^1^^^^1
 ;;^UTILITY(U,$J,358.3,690,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,690,1,1,0)
 ;;=1^49083
 ;;^UTILITY(U,$J,358.3,690,1,3,0)
 ;;=3^Abd Paracentesis w/ Image Guide
 ;;^UTILITY(U,$J,358.3,691,0)
 ;;=49082^^8^55^2^^^^1
 ;;^UTILITY(U,$J,358.3,691,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,691,1,1,0)
 ;;=1^49082
 ;;^UTILITY(U,$J,358.3,691,1,3,0)
 ;;=3^Abd Paracentesis w/o Image Guide
 ;;^UTILITY(U,$J,358.3,692,0)
 ;;=49180^^8^55^3^^^^1
 ;;^UTILITY(U,$J,358.3,692,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,692,1,1,0)
 ;;=1^49180
 ;;^UTILITY(U,$J,358.3,692,1,3,0)
 ;;=3^Abdominal Mass Biopsy
 ;;^UTILITY(U,$J,358.3,693,0)
 ;;=20245^^8^55^4^^^^1
 ;;^UTILITY(U,$J,358.3,693,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,693,1,1,0)
 ;;=1^20245
 ;;^UTILITY(U,$J,358.3,693,1,3,0)
 ;;=3^Bone Biopsy,Excisional
 ;;^UTILITY(U,$J,358.3,694,0)
 ;;=20220^^8^55^5^^^^1
 ;;^UTILITY(U,$J,358.3,694,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,694,1,1,0)
 ;;=1^20220
 ;;^UTILITY(U,$J,358.3,694,1,3,0)
 ;;=3^Bone Biopsy,Trocar/Needle
 ;;^UTILITY(U,$J,358.3,695,0)
 ;;=31575^^8^55^20^^^^1
 ;;^UTILITY(U,$J,358.3,695,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,695,1,1,0)
 ;;=1^31575
 ;;^UTILITY(U,$J,358.3,695,1,3,0)
 ;;=3^Laryngoscopy,Flex Fibroptic,Diag
 ;;^UTILITY(U,$J,358.3,696,0)
 ;;=62270^^8^55^21^^^^1
 ;;^UTILITY(U,$J,358.3,696,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,696,1,1,0)
 ;;=1^62270
 ;;^UTILITY(U,$J,358.3,696,1,3,0)
 ;;=3^Lumbar Puncture,Diagnostic
 ;;^UTILITY(U,$J,358.3,697,0)
 ;;=38505^^8^55^22^^^^1
 ;;^UTILITY(U,$J,358.3,697,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,697,1,1,0)
 ;;=1^38505
 ;;^UTILITY(U,$J,358.3,697,1,3,0)
 ;;=3^Needle Biopsy,Lymph Nodes
 ;;^UTILITY(U,$J,358.3,698,0)
 ;;=49084^^8^55^24^^^^1
 ;;^UTILITY(U,$J,358.3,698,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,698,1,1,0)
 ;;=1^49084
 ;;^UTILITY(U,$J,358.3,698,1,3,0)
 ;;=3^Peritoneal Lavage w/ Image Guide
 ;;^UTILITY(U,$J,358.3,699,0)
 ;;=45300^^8^55^26^^^^1
 ;;^UTILITY(U,$J,358.3,699,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,699,1,1,0)
 ;;=1^45300
 ;;^UTILITY(U,$J,358.3,699,1,3,0)
 ;;=3^Proctosigmoidoscopy
 ;;^UTILITY(U,$J,358.3,700,0)
 ;;=32555^^8^55^28^^^^1
 ;;^UTILITY(U,$J,358.3,700,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,700,1,1,0)
 ;;=1^32555
 ;;^UTILITY(U,$J,358.3,700,1,3,0)
 ;;=3^Thoracentesis w/ Imaging
 ;;^UTILITY(U,$J,358.3,701,0)
 ;;=10005^^8^55^16^^^^1
 ;;^UTILITY(U,$J,358.3,701,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,701,1,1,0)
 ;;=1^10005
 ;;^UTILITY(U,$J,358.3,701,1,3,0)
 ;;=3^FNA w/ US Guidance,1st Lesion
 ;;^UTILITY(U,$J,358.3,702,0)
 ;;=10006^^8^55^17^^^^1
 ;;^UTILITY(U,$J,358.3,702,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,702,1,1,0)
 ;;=1^10006
 ;;^UTILITY(U,$J,358.3,702,1,3,0)
 ;;=3^FNA w/ US Guidance,Ea Addl Lesion
