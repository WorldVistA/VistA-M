IBDEI02P ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6271,1,2,0)
 ;;=2^Refraction
 ;;^UTILITY(U,$J,358.3,6271,1,3,0)
 ;;=3^92015
 ;;^UTILITY(U,$J,358.3,6272,0)
 ;;=99174^^39^365^2^^^^1
 ;;^UTILITY(U,$J,358.3,6272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6272,1,2,0)
 ;;=2^Autorefraction,Bilateral
 ;;^UTILITY(U,$J,358.3,6272,1,3,0)
 ;;=3^99174
 ;;^UTILITY(U,$J,358.3,6273,0)
 ;;=92370^^39^365^3^^^^1
 ;;^UTILITY(U,$J,358.3,6273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6273,1,2,0)
 ;;=2^Repair/Refit Glasses
 ;;^UTILITY(U,$J,358.3,6273,1,3,0)
 ;;=3^92370
 ;;^UTILITY(U,$J,358.3,6274,0)
 ;;=92371^^39^365^4^^^^1
 ;;^UTILITY(U,$J,358.3,6274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6274,1,2,0)
 ;;=2^Repair/Refit Glasses for Aphakia
 ;;^UTILITY(U,$J,358.3,6274,1,3,0)
 ;;=3^92371
 ;;^UTILITY(U,$J,358.3,6275,0)
 ;;=92341^^39^365^5^^^^1
 ;;^UTILITY(U,$J,358.3,6275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6275,1,2,0)
 ;;=2^Glasses Fitting,Bifocal
 ;;^UTILITY(U,$J,358.3,6275,1,3,0)
 ;;=3^92341
 ;;^UTILITY(U,$J,358.3,6276,0)
 ;;=92340^^39^365^6^^^^1
 ;;^UTILITY(U,$J,358.3,6276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6276,1,2,0)
 ;;=2^Glasses Fitting,Monofocal
 ;;^UTILITY(U,$J,358.3,6276,1,3,0)
 ;;=3^92340
 ;;^UTILITY(U,$J,358.3,6277,0)
 ;;=92352^^39^365^7^^^^1
 ;;^UTILITY(U,$J,358.3,6277,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6277,1,2,0)
 ;;=2^Glasses Fitting,Monofocal for Aphakia
 ;;^UTILITY(U,$J,358.3,6277,1,3,0)
 ;;=3^92352
 ;;^UTILITY(U,$J,358.3,6278,0)
 ;;=92342^^39^365^8^^^^1
 ;;^UTILITY(U,$J,358.3,6278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6278,1,2,0)
 ;;=2^Glasses Fitting,Multifocal
 ;;^UTILITY(U,$J,358.3,6278,1,3,0)
 ;;=3^92342
 ;;^UTILITY(U,$J,358.3,6279,0)
 ;;=92353^^39^365^9^^^^1
 ;;^UTILITY(U,$J,358.3,6279,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6279,1,2,0)
 ;;=2^Glasses Fitting,Multifocal for Aphakia
 ;;^UTILITY(U,$J,358.3,6279,1,3,0)
 ;;=3^92353
 ;;^UTILITY(U,$J,358.3,6280,0)
 ;;=92072^^39^365^10^^^^1
 ;;^UTILITY(U,$J,358.3,6280,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6280,1,2,0)
 ;;=2^Contact Lens Mgmt Keratoconus,Init
 ;;^UTILITY(U,$J,358.3,6280,1,3,0)
 ;;=3^92072
 ;;^UTILITY(U,$J,358.3,6281,0)
 ;;=92071^^39^365^11^^^^1
 ;;^UTILITY(U,$J,358.3,6281,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6281,1,2,0)
 ;;=2^Contact Lens Tx for Ocular Disease
 ;;^UTILITY(U,$J,358.3,6281,1,3,0)
 ;;=3^92071
 ;;^UTILITY(U,$J,358.3,6282,0)
 ;;=92311^^39^365^12^^^^1
 ;;^UTILITY(U,$J,358.3,6282,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6282,1,2,0)
 ;;=2^Contact Lens-Aphakia Od/Os
 ;;^UTILITY(U,$J,358.3,6282,1,3,0)
 ;;=3^92311
 ;;^UTILITY(U,$J,358.3,6283,0)
 ;;=92312^^39^365^13^^^^1
 ;;^UTILITY(U,$J,358.3,6283,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6283,1,2,0)
 ;;=2^Contact Lens-Aphakia OU
 ;;^UTILITY(U,$J,358.3,6283,1,3,0)
 ;;=3^92312
 ;;^UTILITY(U,$J,358.3,6284,0)
 ;;=92354^^39^365^14^^^^1
 ;;^UTILITY(U,$J,358.3,6284,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6284,1,2,0)
 ;;=2^Low Vision Aid Fitting,Single Element
 ;;^UTILITY(U,$J,358.3,6284,1,3,0)
 ;;=3^92354
 ;;^UTILITY(U,$J,358.3,6285,0)
 ;;=92355^^39^365^15^^^^1
 ;;^UTILITY(U,$J,358.3,6285,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6285,1,2,0)
 ;;=2^Low Vision Aid Fitng,Telescopic/Compound Lens
 ;;^UTILITY(U,$J,358.3,6285,1,3,0)
 ;;=3^92355
 ;;^UTILITY(U,$J,358.3,6286,0)
 ;;=H54.3^^40^367^14
 ;;^UTILITY(U,$J,358.3,6286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6286,1,3,0)
 ;;=3^Visual Loss,Both Eyes,Unqualified
 ;;^UTILITY(U,$J,358.3,6286,1,4,0)
 ;;=4^H54.3
 ;;^UTILITY(U,$J,358.3,6286,2)
 ;;=^268886
 ;;^UTILITY(U,$J,358.3,6287,0)
 ;;=H54.7^^40^367^13
 ;;^UTILITY(U,$J,358.3,6287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6287,1,3,0)
 ;;=3^Visual Loss
 ;;^UTILITY(U,$J,358.3,6287,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,6287,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,6288,0)
 ;;=H54.8^^40^367^1
 ;;^UTILITY(U,$J,358.3,6288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6288,1,3,0)
 ;;=3^Legal Blindness,as Defined in USA
 ;;^UTILITY(U,$J,358.3,6288,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,6288,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,6289,0)
 ;;=H54.40^^40^367^2
 ;;^UTILITY(U,$J,358.3,6289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6289,1,3,0)
 ;;=3^Monocular,Blindness in One Eye
 ;;^UTILITY(U,$J,358.3,6289,1,4,0)
 ;;=4^H54.40
 ;;^UTILITY(U,$J,358.3,6289,2)
 ;;=^5006362
 ;;^UTILITY(U,$J,358.3,6290,0)
 ;;=H53.71^^40^367^15
 ;;^UTILITY(U,$J,358.3,6290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6290,1,3,0)
 ;;=3^Glare Sensitivity
 ;;^UTILITY(U,$J,358.3,6290,1,4,0)
 ;;=4^H53.71
 ;;^UTILITY(U,$J,358.3,6290,2)
 ;;=^5006354
 ;;^UTILITY(U,$J,358.3,6291,0)
 ;;=H53.72^^40^367^16
 ;;^UTILITY(U,$J,358.3,6291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6291,1,3,0)
 ;;=3^Impaired Contrast Sensitivity
 ;;^UTILITY(U,$J,358.3,6291,1,4,0)
 ;;=4^H53.72
 ;;^UTILITY(U,$J,358.3,6291,2)
 ;;=^5006355
 ;;^UTILITY(U,$J,358.3,6292,0)
 ;;=H54.52A1^^40^367^12
 ;;^UTILITY(U,$J,358.3,6292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6292,1,3,0)
 ;;=3^Normal Vision Right Eye,Low Vision Left Eye Cat 1
 ;;^UTILITY(U,$J,358.3,6292,1,4,0)
 ;;=4^H54.52A1
 ;;^UTILITY(U,$J,358.3,6292,2)
 ;;=^5151371
 ;;^UTILITY(U,$J,358.3,6293,0)
 ;;=H54.511A^^40^367^9
 ;;^UTILITY(U,$J,358.3,6293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6293,1,3,0)
 ;;=3^Low Vision Right Eye Cat 1,Normal Vision Left Eye
 ;;^UTILITY(U,$J,358.3,6293,1,4,0)
 ;;=4^H54.511A
 ;;^UTILITY(U,$J,358.3,6293,2)
 ;;=^5151369
 ;;^UTILITY(U,$J,358.3,6294,0)
 ;;=H54.415A^^40^367^5
 ;;^UTILITY(U,$J,358.3,6294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6294,1,3,0)
 ;;=3^Blindness Right Eye Cat 5,Normal Vision Left Eye
 ;;^UTILITY(U,$J,358.3,6294,1,4,0)
 ;;=4^H54.415A
 ;;^UTILITY(U,$J,358.3,6294,2)
 ;;=^5151365
 ;;^UTILITY(U,$J,358.3,6295,0)
 ;;=H54.1151^^40^367^4
 ;;^UTILITY(U,$J,358.3,6295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6295,1,3,0)
 ;;=3^Blindness Right Eye Cat 5,Low Vision Left Eye Cat 1
 ;;^UTILITY(U,$J,358.3,6295,1,4,0)
 ;;=4^H54.1151
 ;;^UTILITY(U,$J,358.3,6295,2)
 ;;=^5151351
 ;;^UTILITY(U,$J,358.3,6296,0)
 ;;=H54.0X55^^40^367^3
 ;;^UTILITY(U,$J,358.3,6296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6296,1,3,0)
 ;;=3^Blindness Right Eye Cat 5,Blindness Left Eye Cat 5
 ;;^UTILITY(U,$J,358.3,6296,1,4,0)
 ;;=4^H54.0X55
 ;;^UTILITY(U,$J,358.3,6296,2)
 ;;=^5151346
 ;;^UTILITY(U,$J,358.3,6297,0)
 ;;=H54.0X33^^40^367^6
 ;;^UTILITY(U,$J,358.3,6297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6297,1,3,0)
 ;;=3^Blindness Right Eye Cat 3,Blindness Left Eye Cat 3
 ;;^UTILITY(U,$J,358.3,6297,1,4,0)
 ;;=4^H54.0X33
 ;;^UTILITY(U,$J,358.3,6297,2)
 ;;=^5151338
 ;;^UTILITY(U,$J,358.3,6298,0)
 ;;=H54.0X34^^40^367^7
 ;;^UTILITY(U,$J,358.3,6298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6298,1,3,0)
 ;;=3^Blindness Right Eye Cat 4,Blindness Left Eye Cat 3
 ;;^UTILITY(U,$J,358.3,6298,1,4,0)
 ;;=4^H54.0X34
 ;;^UTILITY(U,$J,358.3,6298,2)
 ;;=^5151339
 ;;^UTILITY(U,$J,358.3,6299,0)
 ;;=H54.0X53^^40^367^8
 ;;^UTILITY(U,$J,358.3,6299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6299,1,3,0)
 ;;=3^Blindness Right Eye Cat 5,Blindness Left Eye Cat 3
 ;;^UTILITY(U,$J,358.3,6299,1,4,0)
 ;;=4^H54.0X53
 ;;^UTILITY(U,$J,358.3,6299,2)
 ;;=^5151344
 ;;^UTILITY(U,$J,358.3,6300,0)
 ;;=H54.2X22^^40^367^10
 ;;^UTILITY(U,$J,358.3,6300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6300,1,3,0)
 ;;=3^Low Vision Right Eye Cat 2,Low Vision Left Eye Cat 2
 ;;^UTILITY(U,$J,358.3,6300,1,4,0)
 ;;=4^H54.2X22
 ;;^UTILITY(U,$J,358.3,6300,2)
 ;;=^5151362
 ;;^UTILITY(U,$J,358.3,6301,0)
 ;;=H54.512A^^40^367^11
 ;;^UTILITY(U,$J,358.3,6301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6301,1,3,0)
 ;;=3^Low Vision Right Eye Cat 2,Normal Vision Left Eye
 ;;^UTILITY(U,$J,358.3,6301,1,4,0)
 ;;=4^H54.512A
 ;;^UTILITY(U,$J,358.3,6301,2)
 ;;=^5151370
 ;;^UTILITY(U,$J,358.3,6302,0)
 ;;=Z82.1^^40^367^17
 ;;^UTILITY(U,$J,358.3,6302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6302,1,3,0)
 ;;=3^Family Hx Blindness/Visual Loss
 ;;^UTILITY(U,$J,358.3,6302,1,4,0)
 ;;=4^Z82.1
 ;;^UTILITY(U,$J,358.3,6302,2)
 ;;=^5063365
 ;;^UTILITY(U,$J,358.3,6303,0)
 ;;=H35.81^^40^368^20
 ;;^UTILITY(U,$J,358.3,6303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6303,1,3,0)
 ;;=3^Retinal Edema/CME Other Etiology
 ;;^UTILITY(U,$J,358.3,6303,1,4,0)
 ;;=4^H35.81
 ;;^UTILITY(U,$J,358.3,6303,2)
 ;;=^5005715
 ;;^UTILITY(U,$J,358.3,6304,0)
 ;;=H34.11^^40^368^9
 ;;^UTILITY(U,$J,358.3,6304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6304,1,3,0)
 ;;=3^Central Retinal Artery Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,6304,1,4,0)
 ;;=4^H34.11
 ;;^UTILITY(U,$J,358.3,6304,2)
 ;;=^5005557
 ;;^UTILITY(U,$J,358.3,6305,0)
 ;;=H34.12^^40^368^10
 ;;^UTILITY(U,$J,358.3,6305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6305,1,3,0)
 ;;=3^Central Retinal Artery Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,6305,1,4,0)
 ;;=4^H34.12
 ;;^UTILITY(U,$J,358.3,6305,2)
 ;;=^5005558
 ;;^UTILITY(U,$J,358.3,6306,0)
 ;;=H34.231^^40^368^1
 ;;^UTILITY(U,$J,358.3,6306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6306,1,3,0)
 ;;=3^Branch Retinal Artery Occlusion,Right Eye
 ;;^UTILITY(U,$J,358.3,6306,1,4,0)
 ;;=4^H34.231
 ;;^UTILITY(U,$J,358.3,6306,2)
 ;;=^5005564
 ;;^UTILITY(U,$J,358.3,6307,0)
 ;;=H34.232^^40^368^2
 ;;^UTILITY(U,$J,358.3,6307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6307,1,3,0)
 ;;=3^Branch Retinal Artery Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,6307,1,4,0)
 ;;=4^H34.232
 ;;^UTILITY(U,$J,358.3,6307,2)
 ;;=^5005565
 ;;^UTILITY(U,$J,358.3,6308,0)
 ;;=H35.031^^40^368^17
 ;;^UTILITY(U,$J,358.3,6308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6308,1,3,0)
 ;;=3^Hypertensive Retinopathy,Right Eye
 ;;^UTILITY(U,$J,358.3,6308,1,4,0)
 ;;=4^H35.031
 ;;^UTILITY(U,$J,358.3,6308,2)
 ;;=^5005590
 ;;^UTILITY(U,$J,358.3,6309,0)
 ;;=H35.032^^40^368^18
 ;;^UTILITY(U,$J,358.3,6309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6309,1,3,0)
 ;;=3^Hypertensive Retinopathy,Left Eye
 ;;^UTILITY(U,$J,358.3,6309,1,4,0)
 ;;=4^H35.032
 ;;^UTILITY(U,$J,358.3,6309,2)
 ;;=^5005591
 ;;^UTILITY(U,$J,358.3,6310,0)
 ;;=H35.033^^40^368^19
 ;;^UTILITY(U,$J,358.3,6310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6310,1,3,0)
 ;;=3^Hypertensive Retinopathy,Bilateral
 ;;^UTILITY(U,$J,358.3,6310,1,4,0)
 ;;=4^H35.033
 ;;^UTILITY(U,$J,358.3,6310,2)
 ;;=^5005592
 ;;^UTILITY(U,$J,358.3,6311,0)
 ;;=H35.82^^40^368^23
 ;;^UTILITY(U,$J,358.3,6311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6311,1,3,0)
 ;;=3^Retinal Ischemia/Cotton Wool Spot
 ;;^UTILITY(U,$J,358.3,6311,1,4,0)
 ;;=4^H35.82
 ;;^UTILITY(U,$J,358.3,6311,2)
 ;;=^5005716
 ;;^UTILITY(U,$J,358.3,6312,0)
 ;;=H35.61^^40^368^21
 ;;^UTILITY(U,$J,358.3,6312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6312,1,3,0)
 ;;=3^Retinal Hemorrhage,Right Eye
 ;;^UTILITY(U,$J,358.3,6312,1,4,0)
 ;;=4^H35.61
 ;;^UTILITY(U,$J,358.3,6312,2)
 ;;=^5005699
 ;;^UTILITY(U,$J,358.3,6313,0)
 ;;=H35.62^^40^368^22
 ;;^UTILITY(U,$J,358.3,6313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6313,1,3,0)
 ;;=3^Retinal Hemorrhage,Left Eye
 ;;^UTILITY(U,$J,358.3,6313,1,4,0)
 ;;=4^H35.62
 ;;^UTILITY(U,$J,358.3,6313,2)
 ;;=^5005700
 ;;^UTILITY(U,$J,358.3,6314,0)
 ;;=H35.051^^40^368^24
 ;;^UTILITY(U,$J,358.3,6314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6314,1,3,0)
 ;;=3^Retinal Neovascularization,Right Eye
 ;;^UTILITY(U,$J,358.3,6314,1,4,0)
 ;;=4^H35.051
 ;;^UTILITY(U,$J,358.3,6314,2)
 ;;=^5005598
 ;;^UTILITY(U,$J,358.3,6315,0)
 ;;=H35.052^^40^368^25
 ;;^UTILITY(U,$J,358.3,6315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6315,1,3,0)
 ;;=3^Retinal Neovascularization,Left Eye
 ;;^UTILITY(U,$J,358.3,6315,1,4,0)
 ;;=4^H35.052
 ;;^UTILITY(U,$J,358.3,6315,2)
 ;;=^5005599
 ;;^UTILITY(U,$J,358.3,6316,0)
 ;;=H35.071^^40^368^26
 ;;^UTILITY(U,$J,358.3,6316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6316,1,3,0)
 ;;=3^Retinal Telangiectasis,Right Eye
 ;;^UTILITY(U,$J,358.3,6316,1,4,0)
 ;;=4^H35.071
 ;;^UTILITY(U,$J,358.3,6316,2)
 ;;=^5005606
 ;;^UTILITY(U,$J,358.3,6317,0)
 ;;=H35.072^^40^368^27
 ;;^UTILITY(U,$J,358.3,6317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6317,1,3,0)
 ;;=3^Retinal Telangiectasis,Left Eye
 ;;^UTILITY(U,$J,358.3,6317,1,4,0)
 ;;=4^H35.072
 ;;^UTILITY(U,$J,358.3,6317,2)
 ;;=^5005607
 ;;^UTILITY(U,$J,358.3,6318,0)
 ;;=H35.061^^40^368^28
 ;;^UTILITY(U,$J,358.3,6318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6318,1,3,0)
 ;;=3^Retinal Vasculitis,Right Eye
 ;;^UTILITY(U,$J,358.3,6318,1,4,0)
 ;;=4^H35.061
 ;;^UTILITY(U,$J,358.3,6318,2)
 ;;=^5005602
 ;;^UTILITY(U,$J,358.3,6319,0)
 ;;=H35.062^^40^368^29
 ;;^UTILITY(U,$J,358.3,6319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6319,1,3,0)
 ;;=3^Retinal Vasculitis,Left Eye
 ;;^UTILITY(U,$J,358.3,6319,1,4,0)
 ;;=4^H35.062
 ;;^UTILITY(U,$J,358.3,6319,2)
 ;;=^5005603
 ;;^UTILITY(U,$J,358.3,6320,0)
 ;;=H34.8110^^40^368^11
 ;;^UTILITY(U,$J,358.3,6320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6320,1,3,0)
 ;;=3^Central Retinal Vein Occls,Right Eye w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,6320,1,4,0)
 ;;=4^H34.8110
 ;;^UTILITY(U,$J,358.3,6320,2)
 ;;=^5138476
 ;;^UTILITY(U,$J,358.3,6321,0)
 ;;=H34.8111^^40^368^12
 ;;^UTILITY(U,$J,358.3,6321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6321,1,3,0)
 ;;=3^Central Retinal Vein Occls,Right Eye w/ NV
 ;;^UTILITY(U,$J,358.3,6321,1,4,0)
 ;;=4^H34.8111
 ;;^UTILITY(U,$J,358.3,6321,2)
 ;;=^5138477
 ;;^UTILITY(U,$J,358.3,6322,0)
 ;;=H34.8112^^40^368^13
 ;;^UTILITY(U,$J,358.3,6322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6322,1,3,0)
 ;;=3^Central Retinal Vein Occls,Right Eye,Stable
 ;;^UTILITY(U,$J,358.3,6322,1,4,0)
 ;;=4^H34.8112
 ;;^UTILITY(U,$J,358.3,6322,2)
 ;;=^5138478
 ;;^UTILITY(U,$J,358.3,6323,0)
 ;;=H34.8120^^40^368^14
 ;;^UTILITY(U,$J,358.3,6323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6323,1,3,0)
 ;;=3^Central Retinal Vein Occls,Left Eye w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,6323,1,4,0)
 ;;=4^H34.8120
 ;;^UTILITY(U,$J,358.3,6323,2)
 ;;=^5138479
 ;;^UTILITY(U,$J,358.3,6324,0)
 ;;=H34.8121^^40^368^15
 ;;^UTILITY(U,$J,358.3,6324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6324,1,3,0)
 ;;=3^Central Retinal Vein Occls,Left Eye w/ NV
 ;;^UTILITY(U,$J,358.3,6324,1,4,0)
 ;;=4^H34.8121
 ;;^UTILITY(U,$J,358.3,6324,2)
 ;;=^5138480
 ;;^UTILITY(U,$J,358.3,6325,0)
 ;;=H34.8122^^40^368^16
 ;;^UTILITY(U,$J,358.3,6325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6325,1,3,0)
 ;;=3^Central Retinal Vein Occls,Left Eye,Stable
 ;;^UTILITY(U,$J,358.3,6325,1,4,0)
 ;;=4^H34.8122
 ;;^UTILITY(U,$J,358.3,6325,2)
 ;;=^5138481
 ;;^UTILITY(U,$J,358.3,6326,0)
 ;;=H34.8310^^40^368^3
 ;;^UTILITY(U,$J,358.3,6326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6326,1,3,0)
 ;;=3^Branch Retinal Vein Occls,Right Eye w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,6326,1,4,0)
 ;;=4^H34.8310
 ;;^UTILITY(U,$J,358.3,6326,2)
 ;;=^5138488
 ;;^UTILITY(U,$J,358.3,6327,0)
 ;;=H34.8311^^40^368^4
 ;;^UTILITY(U,$J,358.3,6327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6327,1,3,0)
 ;;=3^Branch Retinal Vein Occls,Right Eye w/ NV
 ;;^UTILITY(U,$J,358.3,6327,1,4,0)
 ;;=4^H34.8311
 ;;^UTILITY(U,$J,358.3,6327,2)
 ;;=^5138489
 ;;^UTILITY(U,$J,358.3,6328,0)
 ;;=H34.8312^^40^368^5
 ;;^UTILITY(U,$J,358.3,6328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6328,1,3,0)
 ;;=3^Branch Retinal Vein Occls,Right Eye,Stable
 ;;^UTILITY(U,$J,358.3,6328,1,4,0)
 ;;=4^H34.8312
 ;;^UTILITY(U,$J,358.3,6328,2)
 ;;=^5138490
 ;;^UTILITY(U,$J,358.3,6329,0)
 ;;=H34.8320^^40^368^6
 ;;^UTILITY(U,$J,358.3,6329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6329,1,3,0)
 ;;=3^Branch Retinal Vein Occls,Left Eye w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,6329,1,4,0)
 ;;=4^H34.8320
 ;;^UTILITY(U,$J,358.3,6329,2)
 ;;=^5138491
 ;;^UTILITY(U,$J,358.3,6330,0)
 ;;=H34.8321^^40^368^7
 ;;^UTILITY(U,$J,358.3,6330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6330,1,3,0)
 ;;=3^Branch Retinal Vein Occls,Left Eye w/ NV
 ;;^UTILITY(U,$J,358.3,6330,1,4,0)
 ;;=4^H34.8321
 ;;^UTILITY(U,$J,358.3,6330,2)
 ;;=^5138492
 ;;^UTILITY(U,$J,358.3,6331,0)
 ;;=H34.8322^^40^368^8
 ;;^UTILITY(U,$J,358.3,6331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6331,1,3,0)
 ;;=3^Branch Retinal Vein Occls,Left Eye,Stable
 ;;^UTILITY(U,$J,358.3,6331,1,4,0)
 ;;=4^H34.8322
 ;;^UTILITY(U,$J,358.3,6331,2)
 ;;=^5138493
 ;;^UTILITY(U,$J,358.3,6332,0)
 ;;=H00.11^^40^369^1
 ;;^UTILITY(U,$J,358.3,6332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6332,1,3,0)
 ;;=3^Chalazion Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,6332,1,4,0)
 ;;=4^H00.11
 ;;^UTILITY(U,$J,358.3,6332,2)
 ;;=^5004233
 ;;^UTILITY(U,$J,358.3,6333,0)
 ;;=H00.12^^40^369^2
 ;;^UTILITY(U,$J,358.3,6333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6333,1,3,0)
 ;;=3^Chalazion Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,6333,1,4,0)
 ;;=4^H00.12
 ;;^UTILITY(U,$J,358.3,6333,2)
 ;;=^5004234
 ;;^UTILITY(U,$J,358.3,6334,0)
 ;;=H00.14^^40^369^3
 ;;^UTILITY(U,$J,358.3,6334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6334,1,3,0)
 ;;=3^Chalazion Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,6334,1,4,0)
 ;;=4^H00.14
 ;;^UTILITY(U,$J,358.3,6334,2)
 ;;=^5004236
 ;;^UTILITY(U,$J,358.3,6335,0)
 ;;=H00.15^^40^369^4
 ;;^UTILITY(U,$J,358.3,6335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6335,1,3,0)
 ;;=3^Chalazion Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,6335,1,4,0)
 ;;=4^H00.15
 ;;^UTILITY(U,$J,358.3,6335,2)
 ;;=^5133378
 ;;^UTILITY(U,$J,358.3,6336,0)
 ;;=H00.011^^40^369^5
 ;;^UTILITY(U,$J,358.3,6336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6336,1,3,0)
 ;;=3^Hordeolum Externum Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,6336,1,4,0)
 ;;=4^H00.011
 ;;^UTILITY(U,$J,358.3,6336,2)
 ;;=^5004218
 ;;^UTILITY(U,$J,358.3,6337,0)
 ;;=H00.014^^40^369^6
 ;;^UTILITY(U,$J,358.3,6337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6337,1,3,0)
 ;;=3^Hordeolum Externum Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,6337,1,4,0)
 ;;=4^H00.014
 ;;^UTILITY(U,$J,358.3,6337,2)
 ;;=^5004221
 ;;^UTILITY(U,$J,358.3,6338,0)
 ;;=H02.052^^40^369^7
 ;;^UTILITY(U,$J,358.3,6338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6338,1,3,0)
 ;;=3^Trichiasis w/o Entropion,Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,6338,1,4,0)
 ;;=4^H02.052
 ;;^UTILITY(U,$J,358.3,6338,2)
 ;;=^5004299
 ;;^UTILITY(U,$J,358.3,6339,0)
 ;;=H02.055^^40^369^9
 ;;^UTILITY(U,$J,358.3,6339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6339,1,3,0)
 ;;=3^Trichiasis w/o Entropion,Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,6339,1,4,0)
 ;;=4^H02.055
 ;;^UTILITY(U,$J,358.3,6339,2)
 ;;=^5133405
 ;;^UTILITY(U,$J,358.3,6340,0)
 ;;=H02.032^^40^369^11
 ;;^UTILITY(U,$J,358.3,6340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6340,1,3,0)
 ;;=3^Entropion,Senile,Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,6340,1,4,0)
 ;;=4^H02.032
 ;;^UTILITY(U,$J,358.3,6340,2)
 ;;=^5004289
 ;;^UTILITY(U,$J,358.3,6341,0)
 ;;=H02.035^^40^369^12
 ;;^UTILITY(U,$J,358.3,6341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6341,1,3,0)
 ;;=3^Entropion,Senile,Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,6341,1,4,0)
 ;;=4^H02.035
