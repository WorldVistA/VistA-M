IBDEI0BT ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15723,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15723,1,2,0)
 ;;=2^Excision of neuroma; digital nerve, each additional digit (list separately in addition to code for primary procedure)
 ;;^UTILITY(U,$J,358.3,15723,1,3,0)
 ;;=3^64778
 ;;^UTILITY(U,$J,358.3,15724,0)
 ;;=64782^^114^978^33^^^^1
 ;;^UTILITY(U,$J,358.3,15724,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15724,1,2,0)
 ;;=2^Excision of neuroma; hand or foot, except digital nerve
 ;;^UTILITY(U,$J,358.3,15724,1,3,0)
 ;;=3^64782
 ;;^UTILITY(U,$J,358.3,15725,0)
 ;;=64783^^114^978^34^^^^1
 ;;^UTILITY(U,$J,358.3,15725,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15725,1,2,0)
 ;;=2^Excision of neuroma; hand or foot, each additional nerve, except same digit
 ;;^UTILITY(U,$J,358.3,15725,1,3,0)
 ;;=3^64783
 ;;^UTILITY(U,$J,358.3,15726,0)
 ;;=29999^^114^979^11^^^^1
 ;;^UTILITY(U,$J,358.3,15726,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15726,1,2,0)
 ;;=2^Unlisted procedure, arthroscopy
 ;;^UTILITY(U,$J,358.3,15726,1,3,0)
 ;;=3^29999
 ;;^UTILITY(U,$J,358.3,15727,0)
 ;;=29893^^114^979^3^^^^1
 ;;^UTILITY(U,$J,358.3,15727,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15727,1,2,0)
 ;;=2^Endoscopic plantar fasciotomy
 ;;^UTILITY(U,$J,358.3,15727,1,3,0)
 ;;=3^29893
 ;;^UTILITY(U,$J,358.3,15728,0)
 ;;=29894^^114^979^4^^^^1
 ;;^UTILITY(U,$J,358.3,15728,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15728,1,2,0)
 ;;=2^Arthroscopy, ankle, surgical; w/removalof loose body or foreign body
 ;;^UTILITY(U,$J,358.3,15728,1,3,0)
 ;;=3^29894
 ;;^UTILITY(U,$J,358.3,15729,0)
 ;;=29897^^114^979^5^^^^1
 ;;^UTILITY(U,$J,358.3,15729,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15729,1,2,0)
 ;;=2^Arthroscopy, ankle, surgical; debridement, limited
 ;;^UTILITY(U,$J,358.3,15729,1,3,0)
 ;;=3^29897
 ;;^UTILITY(U,$J,358.3,15730,0)
 ;;=29898^^114^979^6^^^^1
 ;;^UTILITY(U,$J,358.3,15730,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15730,1,2,0)
 ;;=2^Arthroscopy, ankle, surgical; debridement, extensive
 ;;^UTILITY(U,$J,358.3,15730,1,3,0)
 ;;=3^29898
 ;;^UTILITY(U,$J,358.3,15731,0)
 ;;=20220^^114^979^1^^^^1
 ;;^UTILITY(U,$J,358.3,15731,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15731,1,2,0)
 ;;=2^Biopsy, bone, trocar, or needle; superficial
 ;;^UTILITY(U,$J,358.3,15731,1,3,0)
 ;;=3^20220
 ;;^UTILITY(U,$J,358.3,15732,0)
 ;;=20650^^114^979^2^^^^1
 ;;^UTILITY(U,$J,358.3,15732,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15732,1,2,0)
 ;;=2^Insertion of wire or pin with application of skeletal traction, including removal
 ;;^UTILITY(U,$J,358.3,15732,1,3,0)
 ;;=3^20650
 ;;^UTILITY(U,$J,358.3,15733,0)
 ;;=64726^^114^979^12^^^^1
 ;;^UTILITY(U,$J,358.3,15733,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15733,1,2,0)
 ;;=2^Decompression; plantar digital nerve
 ;;^UTILITY(U,$J,358.3,15733,1,3,0)
 ;;=3^64726
 ;;^UTILITY(U,$J,358.3,15734,0)
 ;;=64999^^114^979^13^^^^1
 ;;^UTILITY(U,$J,358.3,15734,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15734,1,2,0)
 ;;=2^Unlisted procedure, nervous system
 ;;^UTILITY(U,$J,358.3,15734,1,3,0)
 ;;=3^64999
 ;;^UTILITY(U,$J,358.3,15735,0)
 ;;=93922^^114^979^14^^^^1
 ;;^UTILITY(U,$J,358.3,15735,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15735,1,2,0)
 ;;=2^Non-invasive physiologic studies of upper or lower extremity arteries, single level, bilateral
 ;;^UTILITY(U,$J,358.3,15735,1,3,0)
 ;;=3^93922
 ;;^UTILITY(U,$J,358.3,15736,0)
 ;;=29904^^114^979^7^^^^1
 ;;^UTILITY(U,$J,358.3,15736,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15736,1,2,0)
 ;;=2^Arthroscopy,subtalar jt,w/rem of foreign body
 ;;^UTILITY(U,$J,358.3,15736,1,3,0)
 ;;=3^29904
 ;;^UTILITY(U,$J,358.3,15737,0)
 ;;=29905^^114^979^8^^^^1
 ;;^UTILITY(U,$J,358.3,15737,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15737,1,2,0)
 ;;=2^Arthroscopy,subtalar jt,w/ Synovectomy
 ;;^UTILITY(U,$J,358.3,15737,1,3,0)
 ;;=3^29905
 ;;^UTILITY(U,$J,358.3,15738,0)
 ;;=29906^^114^979^9^^^^1
 ;;^UTILITY(U,$J,358.3,15738,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15738,1,2,0)
 ;;=2^Arthroscopy, subtalar jt,w/ debridement
 ;;^UTILITY(U,$J,358.3,15738,1,3,0)
 ;;=3^29906
 ;;^UTILITY(U,$J,358.3,15739,0)
 ;;=29907^^114^979^10^^^^1
 ;;^UTILITY(U,$J,358.3,15739,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15739,1,2,0)
 ;;=2^Arthroscopy,subtalar w/ fusion
 ;;^UTILITY(U,$J,358.3,15739,1,3,0)
 ;;=3^29907
 ;;^UTILITY(U,$J,358.3,15740,0)
 ;;=28400^^114^980^1^^^^1
 ;;^UTILITY(U,$J,358.3,15740,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15740,1,2,0)
 ;;=2^Closed TX of calcaneal fracture; without manipulation
 ;;^UTILITY(U,$J,358.3,15740,1,3,0)
 ;;=3^28400
 ;;^UTILITY(U,$J,358.3,15741,0)
 ;;=28405^^114^980^2^^^^1
 ;;^UTILITY(U,$J,358.3,15741,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15741,1,2,0)
 ;;=2^Closed TX of calcaneal fracture; with manipulation
 ;;^UTILITY(U,$J,358.3,15741,1,3,0)
 ;;=3^28405
 ;;^UTILITY(U,$J,358.3,15742,0)
 ;;=28406^^114^980^3^^^^1
 ;;^UTILITY(U,$J,358.3,15742,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15742,1,2,0)
 ;;=2^Perc Fixation of Calcaneous Fx
 ;;^UTILITY(U,$J,358.3,15742,1,3,0)
 ;;=3^28406
 ;;^UTILITY(U,$J,358.3,15743,0)
 ;;=28415^^114^980^4^^^^1
 ;;^UTILITY(U,$J,358.3,15743,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15743,1,2,0)
 ;;=2^Open TX of calcaneal fracture, with or without internal or external fixation;
 ;;^UTILITY(U,$J,358.3,15743,1,3,0)
 ;;=3^28415
 ;;^UTILITY(U,$J,358.3,15744,0)
 ;;=28420^^114^980^5^^^^1
 ;;^UTILITY(U,$J,358.3,15744,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15744,1,2,0)
 ;;=2^Open TX of calcaneal fracture, with or without internal or external fixation; with primary iliac or other autogenous bone graft
 ;;^UTILITY(U,$J,358.3,15744,1,3,0)
 ;;=3^28420
 ;;^UTILITY(U,$J,358.3,15745,0)
 ;;=28430^^114^980^6^^^^1
 ;;^UTILITY(U,$J,358.3,15745,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15745,1,2,0)
 ;;=2^Closed TX of talus fracture; without manipulation 
 ;;^UTILITY(U,$J,358.3,15745,1,3,0)
 ;;=3^28430
 ;;^UTILITY(U,$J,358.3,15746,0)
 ;;=28435^^114^980^7^^^^1
 ;;^UTILITY(U,$J,358.3,15746,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15746,1,2,0)
 ;;=2^Closed TX of talus fracture; with manipulation 
 ;;^UTILITY(U,$J,358.3,15746,1,3,0)
 ;;=3^28435
 ;;^UTILITY(U,$J,358.3,15747,0)
 ;;=28436^^114^980^8^^^^1
 ;;^UTILITY(U,$J,358.3,15747,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15747,1,2,0)
 ;;=2^Perc Fixation Talus Fx
 ;;^UTILITY(U,$J,358.3,15747,1,3,0)
 ;;=3^28436
 ;;^UTILITY(U,$J,358.3,15748,0)
 ;;=28445^^114^980^9^^^^1
 ;;^UTILITY(U,$J,358.3,15748,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15748,1,2,0)
 ;;=2^Open/Closed TX of Talus FX,w/internal fixation
 ;;^UTILITY(U,$J,358.3,15748,1,3,0)
 ;;=3^28445
 ;;^UTILITY(U,$J,358.3,15749,0)
 ;;=28450^^114^980^10^^^^1
 ;;^UTILITY(U,$J,358.3,15749,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15749,1,2,0)
 ;;=2^TX of tarsal bone fracture; without manipulation, each 
 ;;^UTILITY(U,$J,358.3,15749,1,3,0)
 ;;=3^28450
 ;;^UTILITY(U,$J,358.3,15750,0)
 ;;=28455^^114^980^11^^^^1
 ;;^UTILITY(U,$J,358.3,15750,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15750,1,2,0)
 ;;=2^TX of tarsal bone fracture; with manipulation, each
 ;;^UTILITY(U,$J,358.3,15750,1,3,0)
 ;;=3^28455
 ;;^UTILITY(U,$J,358.3,15751,0)
 ;;=28456^^114^980^12^^^^1
 ;;^UTILITY(U,$J,358.3,15751,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15751,1,2,0)
 ;;=2^Perc Fixation Tarsal Fx
 ;;^UTILITY(U,$J,358.3,15751,1,3,0)
 ;;=3^28456
 ;;^UTILITY(U,$J,358.3,15752,0)
 ;;=28465^^114^980^13^^^^1
 ;;^UTILITY(U,$J,358.3,15752,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15752,1,2,0)
 ;;=2^Open/Closed TX of tarsal FX,w/ internal fixation
 ;;^UTILITY(U,$J,358.3,15752,1,3,0)
 ;;=3^28465
 ;;^UTILITY(U,$J,358.3,15753,0)
 ;;=28470^^114^980^14^^^^1
 ;;^UTILITY(U,$J,358.3,15753,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15753,1,2,0)
 ;;=2^Closed TX of metatarsal fracture; without manipulation, eachnt of me
 ;;^UTILITY(U,$J,358.3,15753,1,3,0)
 ;;=3^28470
 ;;^UTILITY(U,$J,358.3,15754,0)
 ;;=28475^^114^980^15^^^^1
 ;;^UTILITY(U,$J,358.3,15754,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15754,1,2,0)
 ;;=2^Closed TX of metatarsal fracture; with manipulation, each
 ;;^UTILITY(U,$J,358.3,15754,1,3,0)
 ;;=3^28475
 ;;^UTILITY(U,$J,358.3,15755,0)
 ;;=28476^^114^980^16^^^^1
 ;;^UTILITY(U,$J,358.3,15755,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15755,1,2,0)
 ;;=2^Perc Fixation Metatarsal Fx
 ;;^UTILITY(U,$J,358.3,15755,1,3,0)
 ;;=3^28476
 ;;^UTILITY(U,$J,358.3,15756,0)
 ;;=28485^^114^980^17^^^^1
 ;;^UTILITY(U,$J,358.3,15756,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15756,1,2,0)
 ;;=2^Open/Closed TX of Metatarsal FX,w/internal fixation
 ;;^UTILITY(U,$J,358.3,15756,1,3,0)
 ;;=3^28485
 ;;^UTILITY(U,$J,358.3,15757,0)
 ;;=28490^^114^980^18^^^^1
 ;;^UTILITY(U,$J,358.3,15757,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15757,1,2,0)
 ;;=2^Closed TX of fracture great toe, phalanx or phalanges; without manipulation
 ;;^UTILITY(U,$J,358.3,15757,1,3,0)
 ;;=3^28490
 ;;^UTILITY(U,$J,358.3,15758,0)
 ;;=28495^^114^980^19^^^^1
 ;;^UTILITY(U,$J,358.3,15758,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15758,1,2,0)
 ;;=2^Closed TX of fracture great toe, phalanx or phalanges; with manipulation
 ;;^UTILITY(U,$J,358.3,15758,1,3,0)
 ;;=3^28495
 ;;^UTILITY(U,$J,358.3,15759,0)
 ;;=28496^^114^980^20^^^^1
 ;;^UTILITY(U,$J,358.3,15759,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15759,1,2,0)
 ;;=2^Perc Fixation Great Toe Fx
 ;;^UTILITY(U,$J,358.3,15759,1,3,0)
 ;;=3^28496
 ;;^UTILITY(U,$J,358.3,15760,0)
 ;;=28505^^114^980^21^^^^1
 ;;^UTILITY(U,$J,358.3,15760,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15760,1,2,0)
 ;;=2^Open TX of fracture great toe, phalanx or phalanges, with or without internal or external fixation
 ;;^UTILITY(U,$J,358.3,15760,1,3,0)
 ;;=3^28505
 ;;^UTILITY(U,$J,358.3,15761,0)
 ;;=28510^^114^980^22^^^^1
 ;;^UTILITY(U,$J,358.3,15761,1,0)
 ;;=^358.31IA^3^2
