IBDEI00I ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,601,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,601,1,1,0)
 ;;=1^J9214
 ;;^UTILITY(U,$J,358.3,601,1,3,0)
 ;;=3^Interferon alfa, 1 mil u
 ;;^UTILITY(U,$J,358.3,602,0)
 ;;=J9217^^10^72^19^^^^1
 ;;^UTILITY(U,$J,358.3,602,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,602,1,1,0)
 ;;=1^J9217
 ;;^UTILITY(U,$J,358.3,602,1,3,0)
 ;;=3^Lupron Depot 7.5mg
 ;;^UTILITY(U,$J,358.3,603,0)
 ;;=J9218^^10^72^20^^^^1
 ;;^UTILITY(U,$J,358.3,603,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,603,1,1,0)
 ;;=1^J9218
 ;;^UTILITY(U,$J,358.3,603,1,3,0)
 ;;=3^Lupron, per 1mg
 ;;^UTILITY(U,$J,358.3,604,0)
 ;;=J9250^^10^72^23^^^^1
 ;;^UTILITY(U,$J,358.3,604,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,604,1,1,0)
 ;;=1^J9250
 ;;^UTILITY(U,$J,358.3,604,1,3,0)
 ;;=3^Methotrexate Sodium 5mgs
 ;;^UTILITY(U,$J,358.3,605,0)
 ;;=J9260^^10^72^22^^^^1
 ;;^UTILITY(U,$J,358.3,605,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,605,1,1,0)
 ;;=1^J9260
 ;;^UTILITY(U,$J,358.3,605,1,3,0)
 ;;=3^Methotrexate Sodium 50mgs
 ;;^UTILITY(U,$J,358.3,606,0)
 ;;=J9293^^10^72^24^^^^1
 ;;^UTILITY(U,$J,358.3,606,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,606,1,1,0)
 ;;=1^J9293
 ;;^UTILITY(U,$J,358.3,606,1,3,0)
 ;;=3^Mitoxantrone HCl(Novan)5mgs
 ;;^UTILITY(U,$J,358.3,607,0)
 ;;=J9360^^10^72^29^^^^1
 ;;^UTILITY(U,$J,358.3,607,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,607,1,1,0)
 ;;=1^J9360
 ;;^UTILITY(U,$J,358.3,607,1,3,0)
 ;;=3^Vinblastine Sulfate (Velban) 1mg
 ;;^UTILITY(U,$J,358.3,608,0)
 ;;=J9370^^10^72^30^^^^1
 ;;^UTILITY(U,$J,358.3,608,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,608,1,1,0)
 ;;=1^J9370
 ;;^UTILITY(U,$J,358.3,608,1,3,0)
 ;;=3^Vincristine Sulfate(VCR) 1mg
 ;;^UTILITY(U,$J,358.3,609,0)
 ;;=J9390^^10^72^25^^^^1
 ;;^UTILITY(U,$J,358.3,609,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,609,1,1,0)
 ;;=1^J9390
 ;;^UTILITY(U,$J,358.3,609,1,3,0)
 ;;=3^Navelbine 10mgs
 ;;^UTILITY(U,$J,358.3,610,0)
 ;;=J9171^^10^72^8^^^^1
 ;;^UTILITY(U,$J,358.3,610,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,610,1,1,0)
 ;;=1^J9171
 ;;^UTILITY(U,$J,358.3,610,1,3,0)
 ;;=3^Docetaxel 1 mg
 ;;^UTILITY(U,$J,358.3,611,0)
 ;;=J9070^^10^72^6^^^^1
 ;;^UTILITY(U,$J,358.3,611,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,611,1,1,0)
 ;;=1^J9070
 ;;^UTILITY(U,$J,358.3,611,1,3,0)
 ;;=3^Cyclophosphamide 100mg Inj
 ;;^UTILITY(U,$J,358.3,612,0)
 ;;=J9351^^10^72^28^^^^1
 ;;^UTILITY(U,$J,358.3,612,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,612,1,1,0)
 ;;=1^J9351
 ;;^UTILITY(U,$J,358.3,612,1,3,0)
 ;;=3^Topotecan 0.1mg
 ;;^UTILITY(U,$J,358.3,613,0)
 ;;=Q2050^^10^72^10^^^^1
 ;;^UTILITY(U,$J,358.3,613,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,613,1,1,0)
 ;;=1^Q2050
 ;;^UTILITY(U,$J,358.3,613,1,3,0)
 ;;=3^Doxorubicin,Liposomal 10mg
 ;;^UTILITY(U,$J,358.3,614,0)
 ;;=J9267^^10^72^26^^^^1
 ;;^UTILITY(U,$J,358.3,614,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,614,1,1,0)
 ;;=1^J9267
 ;;^UTILITY(U,$J,358.3,614,1,3,0)
 ;;=3^Paclitaxel 1mg
 ;;^UTILITY(U,$J,358.3,615,0)
 ;;=J9311^^10^72^27^^^^1
 ;;^UTILITY(U,$J,358.3,615,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,615,1,1,0)
 ;;=1^J9311
 ;;^UTILITY(U,$J,358.3,615,1,3,0)
 ;;=3^Rituxan 10mg
 ;;^UTILITY(U,$J,358.3,616,0)
 ;;=J9030^^10^72^1^^^^1
 ;;^UTILITY(U,$J,358.3,616,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,616,1,1,0)
 ;;=1^J9030
 ;;^UTILITY(U,$J,358.3,616,1,3,0)
 ;;=3^BCG Live Intravesical 1mg
 ;;^UTILITY(U,$J,358.3,617,0)
 ;;=J2060^^10^73^15^^^^1
 ;;^UTILITY(U,$J,358.3,617,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,617,1,1,0)
 ;;=1^J2060
 ;;^UTILITY(U,$J,358.3,617,1,3,0)
 ;;=3^Lorazepam 2mg
 ;;^UTILITY(U,$J,358.3,618,0)
 ;;=J3420^^10^73^25^^^^1
 ;;^UTILITY(U,$J,358.3,618,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,618,1,1,0)
 ;;=1^J3420
 ;;^UTILITY(U,$J,358.3,618,1,3,0)
 ;;=3^Vitamin B12,up to 1000mcg
 ;;^UTILITY(U,$J,358.3,619,0)
 ;;=J1100^^10^73^3^^^^1
 ;;^UTILITY(U,$J,358.3,619,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,619,1,1,0)
 ;;=1^J1100
 ;;^UTILITY(U,$J,358.3,619,1,3,0)
 ;;=3^Dexamethasone Sodium Phos 1mg
 ;;^UTILITY(U,$J,358.3,620,0)
 ;;=J1200^^10^73^4^^^^1
 ;;^UTILITY(U,$J,358.3,620,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,620,1,1,0)
 ;;=1^J1200
 ;;^UTILITY(U,$J,358.3,620,1,3,0)
 ;;=3^Diphenhydramine HCl,50mg
 ;;^UTILITY(U,$J,358.3,621,0)
 ;;=J0780^^10^73^22^^^^1
 ;;^UTILITY(U,$J,358.3,621,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,621,1,1,0)
 ;;=1^J0780
 ;;^UTILITY(U,$J,358.3,621,1,3,0)
 ;;=3^Prochlorperazine HCL,up to 10mg
 ;;^UTILITY(U,$J,358.3,622,0)
 ;;=J7060^^10^73^2^^^^1
 ;;^UTILITY(U,$J,358.3,622,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,622,1,1,0)
 ;;=1^J7060
 ;;^UTILITY(U,$J,358.3,622,1,3,0)
 ;;=3^5% Dextrose/Water(500ml=1U)
 ;;^UTILITY(U,$J,358.3,623,0)
 ;;=J7042^^10^73^1^^^^1
 ;;^UTILITY(U,$J,358.3,623,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,623,1,1,0)
 ;;=1^J7042
 ;;^UTILITY(U,$J,358.3,623,1,3,0)
 ;;=3^5% Dextrose/NS(500ml=1U)
 ;;^UTILITY(U,$J,358.3,624,0)
 ;;=J7030^^10^73^13^^^^1
 ;;^UTILITY(U,$J,358.3,624,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,624,1,1,0)
 ;;=1^J7030
 ;;^UTILITY(U,$J,358.3,624,1,3,0)
 ;;=3^Infusion NS,1000cc
 ;;^UTILITY(U,$J,358.3,625,0)
 ;;=J2175^^10^73^16^^^^1
 ;;^UTILITY(U,$J,358.3,625,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,625,1,1,0)
 ;;=1^J2175
 ;;^UTILITY(U,$J,358.3,625,1,3,0)
 ;;=3^Meperidine HCl, 100mg
 ;;^UTILITY(U,$J,358.3,626,0)
 ;;=J7100^^10^73^11^^^^1
 ;;^UTILITY(U,$J,358.3,626,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,626,1,1,0)
 ;;=1^J7100
 ;;^UTILITY(U,$J,358.3,626,1,3,0)
 ;;=3^Infusion Dextran 40,500ml
 ;;^UTILITY(U,$J,358.3,627,0)
 ;;=J7110^^10^73^12^^^^1
 ;;^UTILITY(U,$J,358.3,627,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,627,1,1,0)
 ;;=1^J7110
 ;;^UTILITY(U,$J,358.3,627,1,3,0)
 ;;=3^Infusion Dextran 75,500ml
 ;;^UTILITY(U,$J,358.3,628,0)
 ;;=J3480^^10^73^21^^^^1
 ;;^UTILITY(U,$J,358.3,628,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,628,1,1,0)
 ;;=1^J3480
 ;;^UTILITY(U,$J,358.3,628,1,3,0)
 ;;=3^Potassium Chloride, 2meq
 ;;^UTILITY(U,$J,358.3,629,0)
 ;;=J1940^^10^73^8^^^^1
 ;;^UTILITY(U,$J,358.3,629,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,629,1,1,0)
 ;;=1^J1940
 ;;^UTILITY(U,$J,358.3,629,1,3,0)
 ;;=3^Furosemide, 20mg
 ;;^UTILITY(U,$J,358.3,630,0)
 ;;=J2270^^10^73^19^^^^1
 ;;^UTILITY(U,$J,358.3,630,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,630,1,1,0)
 ;;=1^J2270
 ;;^UTILITY(U,$J,358.3,630,1,3,0)
 ;;=3^Morphine Sulfate,up to 10mg
 ;;^UTILITY(U,$J,358.3,631,0)
 ;;=J2430^^10^73^20^^^^1
 ;;^UTILITY(U,$J,358.3,631,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,631,1,1,0)
 ;;=1^J2430
 ;;^UTILITY(U,$J,358.3,631,1,3,0)
 ;;=3^Pamidronate Disodium, 30mg
 ;;^UTILITY(U,$J,358.3,632,0)
 ;;=J2550^^10^73^23^^^^1
 ;;^UTILITY(U,$J,358.3,632,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,632,1,1,0)
 ;;=1^J2550
 ;;^UTILITY(U,$J,358.3,632,1,3,0)
 ;;=3^Promethzine HCL,up to 50mg
 ;;^UTILITY(U,$J,358.3,633,0)
 ;;=J0885^^10^73^6^^^^1
 ;;^UTILITY(U,$J,358.3,633,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,633,1,1,0)
 ;;=1^J0885
 ;;^UTILITY(U,$J,358.3,633,1,3,0)
 ;;=3^Epoetin Alfa (Non-ESRD)1000U
 ;;^UTILITY(U,$J,358.3,634,0)
 ;;=J2930^^10^73^17^^^^1
 ;;^UTILITY(U,$J,358.3,634,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,634,1,1,0)
 ;;=1^J2930
 ;;^UTILITY(U,$J,358.3,634,1,3,0)
 ;;=3^Methylprednisolone up to 125 mg
 ;;^UTILITY(U,$J,358.3,635,0)
 ;;=J2920^^10^73^18^^^^1
 ;;^UTILITY(U,$J,358.3,635,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,635,1,1,0)
 ;;=1^J2920
 ;;^UTILITY(U,$J,358.3,635,1,3,0)
 ;;=3^Methylprednisolone up to 40mg
 ;;^UTILITY(U,$J,358.3,636,0)
 ;;=J2792^^10^73^24^^^^1
 ;;^UTILITY(U,$J,358.3,636,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,636,1,1,0)
 ;;=1^J2792
 ;;^UTILITY(U,$J,358.3,636,1,3,0)
 ;;=3^Rho(D) Immune Globulin IV 100IU
 ;;^UTILITY(U,$J,358.3,637,0)
 ;;=J9202^^10^73^9^^^^1
 ;;^UTILITY(U,$J,358.3,637,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,637,1,1,0)
 ;;=1^J9202
 ;;^UTILITY(U,$J,358.3,637,1,3,0)
 ;;=3^Goserelin Acetate Implant 3.6mg
 ;;^UTILITY(U,$J,358.3,638,0)
 ;;=J1568^^10^73^10^^^^1
 ;;^UTILITY(U,$J,358.3,638,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,638,1,1,0)
 ;;=1^J1568
 ;;^UTILITY(U,$J,358.3,638,1,3,0)
 ;;=3^IV Immune Globulin-Liquid 500mg
 ;;^UTILITY(U,$J,358.3,639,0)
 ;;=J0640^^10^73^14^^^^1
 ;;^UTILITY(U,$J,358.3,639,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,639,1,1,0)
 ;;=1^J0640
 ;;^UTILITY(U,$J,358.3,639,1,3,0)
 ;;=3^Leucovorin calcium 50 mg
 ;;^UTILITY(U,$J,358.3,640,0)
 ;;=J1442^^10^73^7^^^^1
 ;;^UTILITY(U,$J,358.3,640,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,640,1,1,0)
 ;;=1^J1442
 ;;^UTILITY(U,$J,358.3,640,1,3,0)
 ;;=3^Filrastim G-CSF 1mcg
 ;;^UTILITY(U,$J,358.3,641,0)
 ;;=J3489^^10^73^26^^^^1
 ;;^UTILITY(U,$J,358.3,641,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,641,1,1,0)
 ;;=1^J3489
 ;;^UTILITY(U,$J,358.3,641,1,3,0)
 ;;=3^Zoledronic Acid 1mg
 ;;^UTILITY(U,$J,358.3,642,0)
 ;;=Q4081^^10^73^5^^^^1
 ;;^UTILITY(U,$J,358.3,642,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,642,1,1,0)
 ;;=1^Q4081
 ;;^UTILITY(U,$J,358.3,642,1,3,0)
 ;;=3^Epoetin Alfa (ESRD) 1000U
 ;;^UTILITY(U,$J,358.3,643,0)
 ;;=99201^^11^74^1
 ;;^UTILITY(U,$J,358.3,643,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,643,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,643,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,644,0)
 ;;=99202^^11^74^2
 ;;^UTILITY(U,$J,358.3,644,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,644,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,644,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,645,0)
 ;;=99203^^11^74^3
 ;;^UTILITY(U,$J,358.3,645,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,645,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,645,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,646,0)
 ;;=99204^^11^74^4
 ;;^UTILITY(U,$J,358.3,646,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,646,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,646,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,647,0)
 ;;=99205^^11^74^5
 ;;^UTILITY(U,$J,358.3,647,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,647,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,647,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,648,0)
 ;;=99211^^11^75^1
 ;;^UTILITY(U,$J,358.3,648,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,648,1,1,0)
 ;;=1^Nursing Visit (no MD seen)
 ;;^UTILITY(U,$J,358.3,648,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,649,0)
 ;;=99212^^11^75^2
 ;;^UTILITY(U,$J,358.3,649,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,649,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,649,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,650,0)
 ;;=99213^^11^75^3
 ;;^UTILITY(U,$J,358.3,650,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,650,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,650,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,651,0)
 ;;=99214^^11^75^4
 ;;^UTILITY(U,$J,358.3,651,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,651,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,651,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,652,0)
 ;;=99215^^11^75^5
 ;;^UTILITY(U,$J,358.3,652,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,652,1,1,0)
 ;;=1^Comprehensive
 ;;^UTILITY(U,$J,358.3,652,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,653,0)
 ;;=99241^^11^76^1
 ;;^UTILITY(U,$J,358.3,653,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,653,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,653,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,654,0)
 ;;=99242^^11^76^2
 ;;^UTILITY(U,$J,358.3,654,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,654,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,654,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,655,0)
 ;;=99243^^11^76^3
 ;;^UTILITY(U,$J,358.3,655,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,655,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,655,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,656,0)
 ;;=99244^^11^76^4
 ;;^UTILITY(U,$J,358.3,656,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,656,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,656,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,657,0)
 ;;=99245^^11^76^5
 ;;^UTILITY(U,$J,358.3,657,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,657,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,657,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,658,0)
 ;;=99024^^11^77^1
 ;;^UTILITY(U,$J,358.3,658,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,658,1,1,0)
 ;;=1^Post-Op Follow-up Visit
 ;;^UTILITY(U,$J,358.3,658,1,2,0)
 ;;=2^99024
 ;;^UTILITY(U,$J,358.3,659,0)
 ;;=D61.1^^12^78^7
 ;;^UTILITY(U,$J,358.3,659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,659,1,3,0)
 ;;=3^Anemia,Aplastic,Drug-Induced
 ;;^UTILITY(U,$J,358.3,659,1,4,0)
 ;;=4^D61.1
 ;;^UTILITY(U,$J,358.3,659,2)
 ;;=^5002336
 ;;^UTILITY(U,$J,358.3,660,0)
 ;;=D61.2^^12^78^6
 ;;^UTILITY(U,$J,358.3,660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,660,1,3,0)
 ;;=3^Anemia,Aplastic d/t External Agents
 ;;^UTILITY(U,$J,358.3,660,1,4,0)
 ;;=4^D61.2
 ;;^UTILITY(U,$J,358.3,660,2)
 ;;=^5002337
 ;;^UTILITY(U,$J,358.3,661,0)
 ;;=D61.89^^12^78^9
 ;;^UTILITY(U,$J,358.3,661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,661,1,3,0)
 ;;=3^Anemia,Aplastic/Bone Marrow Failure Syndromes
 ;;^UTILITY(U,$J,358.3,661,1,4,0)
 ;;=4^D61.89
 ;;^UTILITY(U,$J,358.3,661,2)
 ;;=^5002341
 ;;^UTILITY(U,$J,358.3,662,0)
 ;;=D61.9^^12^78^8
 ;;^UTILITY(U,$J,358.3,662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,662,1,3,0)
 ;;=3^Anemia,Aplastic,Unspec
 ;;^UTILITY(U,$J,358.3,662,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,662,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,663,0)
 ;;=D59.0^^12^78^10
 ;;^UTILITY(U,$J,358.3,663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,663,1,3,0)
 ;;=3^Anemia,Drug-Induced Autoimmune Hemolytic
 ;;^UTILITY(U,$J,358.3,663,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,663,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,664,0)
 ;;=D62.^^12^78^20
 ;;^UTILITY(U,$J,358.3,664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,664,1,3,0)
 ;;=3^Anemia,Posthemorrhagic,Acute
 ;;^UTILITY(U,$J,358.3,664,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,664,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,665,0)
 ;;=D64.81^^12^78^1
 ;;^UTILITY(U,$J,358.3,665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,665,1,3,0)
 ;;=3^Anemia d/t Antineoplastic Chemotherapy
 ;;^UTILITY(U,$J,358.3,665,1,4,0)
 ;;=4^D64.81
 ;;^UTILITY(U,$J,358.3,665,2)
 ;;=^5002349
 ;;^UTILITY(U,$J,358.3,666,0)
 ;;=D63.1^^12^78^4
 ;;^UTILITY(U,$J,358.3,666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,666,1,3,0)
 ;;=3^Anemia in Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,666,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,666,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,667,0)
 ;;=D63.0^^12^78^5
 ;;^UTILITY(U,$J,358.3,667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,667,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,667,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,667,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,668,0)
 ;;=D63.8^^12^78^3
 ;;^UTILITY(U,$J,358.3,668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,668,1,3,0)
 ;;=3^Anemia in Chr Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,668,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,668,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,669,0)
 ;;=D51.8^^12^78^32
 ;;^UTILITY(U,$J,358.3,669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,669,1,3,0)
 ;;=3^Anemia,Vitamin B12 Deficiency
 ;;^UTILITY(U,$J,358.3,669,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,669,2)
 ;;=^5002288
 ;;^UTILITY(U,$J,358.3,670,0)
 ;;=D51.1^^12^78^2
 ;;^UTILITY(U,$J,358.3,670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,670,1,3,0)
 ;;=3^Anemia d/t Selective Vit B12 Malabsorption w/ Proteinuria
 ;;^UTILITY(U,$J,358.3,670,1,4,0)
 ;;=4^D51.1
 ;;^UTILITY(U,$J,358.3,670,2)
 ;;=^5002285
 ;;^UTILITY(U,$J,358.3,671,0)
 ;;=D53.9^^12^78^19
 ;;^UTILITY(U,$J,358.3,671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,671,1,3,0)
 ;;=3^Anemia,Nutritional,Unspec
 ;;^UTILITY(U,$J,358.3,671,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,671,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,672,0)
 ;;=D52.9^^12^78^13
 ;;^UTILITY(U,$J,358.3,672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,672,1,3,0)
 ;;=3^Anemia,Folate Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,672,1,4,0)
 ;;=4^D52.9
 ;;^UTILITY(U,$J,358.3,672,2)
 ;;=^5002293
 ;;^UTILITY(U,$J,358.3,673,0)
 ;;=D52.0^^12^78^11
 ;;^UTILITY(U,$J,358.3,673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,673,1,3,0)
 ;;=3^Anemia,Folate Deficiency,Dietary
 ;;^UTILITY(U,$J,358.3,673,1,4,0)
 ;;=4^D52.0
 ;;^UTILITY(U,$J,358.3,673,2)
 ;;=^5002290
 ;;^UTILITY(U,$J,358.3,674,0)
 ;;=D52.1^^12^78^12
 ;;^UTILITY(U,$J,358.3,674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,674,1,3,0)
 ;;=3^Anemia,Folate Deficiency,Drug-Induced
 ;;^UTILITY(U,$J,358.3,674,1,4,0)
 ;;=4^D52.1
 ;;^UTILITY(U,$J,358.3,674,2)
 ;;=^5002291
 ;;^UTILITY(U,$J,358.3,675,0)
 ;;=D59.9^^12^78^14
 ;;^UTILITY(U,$J,358.3,675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,675,1,3,0)
 ;;=3^Anemia,Hemolytic,Acquired
 ;;^UTILITY(U,$J,358.3,675,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,675,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,676,0)
 ;;=D59.1^^12^78^15
 ;;^UTILITY(U,$J,358.3,676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,676,1,3,0)
 ;;=3^Anemia,Hemolytic,Autoimmune
 ;;^UTILITY(U,$J,358.3,676,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,676,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,677,0)
 ;;=D58.9^^12^78^16
 ;;^UTILITY(U,$J,358.3,677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,677,1,3,0)
 ;;=3^Anemia,Hemolytic,Hereditary,Unspec
 ;;^UTILITY(U,$J,358.3,677,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,677,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,678,0)
 ;;=D59.4^^12^78^17
 ;;^UTILITY(U,$J,358.3,678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,678,1,3,0)
 ;;=3^Anemia,Hemolytic,Nonautoimmune
 ;;^UTILITY(U,$J,358.3,678,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,678,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,679,0)
 ;;=D58.0^^12^78^40
 ;;^UTILITY(U,$J,358.3,679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,679,1,3,0)
 ;;=3^Spherocytosis,Hereditary
 ;;^UTILITY(U,$J,358.3,679,1,4,0)
 ;;=4^D58.0
 ;;^UTILITY(U,$J,358.3,679,2)
 ;;=^5002321
 ;;^UTILITY(U,$J,358.3,680,0)
 ;;=D50.9^^12^78^18
 ;;^UTILITY(U,$J,358.3,680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,680,1,3,0)
 ;;=3^Anemia,Iron Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,680,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,680,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,681,0)
 ;;=D61.82^^12^78^38
 ;;^UTILITY(U,$J,358.3,681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,681,1,3,0)
 ;;=3^Myelophthisis
 ;;^UTILITY(U,$J,358.3,681,1,4,0)
 ;;=4^D61.82
 ;;^UTILITY(U,$J,358.3,681,2)
 ;;=^334037
 ;;^UTILITY(U,$J,358.3,682,0)
 ;;=D53.2^^12^78^27
 ;;^UTILITY(U,$J,358.3,682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,682,1,3,0)
 ;;=3^Anemia,Scorbutic
 ;;^UTILITY(U,$J,358.3,682,1,4,0)
 ;;=4^D53.2
 ;;^UTILITY(U,$J,358.3,682,2)
 ;;=^5002296
 ;;^UTILITY(U,$J,358.3,683,0)
 ;;=D51.0^^12^78^31
 ;;^UTILITY(U,$J,358.3,683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,683,1,3,0)
 ;;=3^Anemia,Vit B12 Defic d/t Intrinsic Factor Deficiency
 ;;^UTILITY(U,$J,358.3,683,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,683,2)
 ;;=^5002284
