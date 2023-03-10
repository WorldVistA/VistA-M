IBDEI01C ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2736,1,3,0)
 ;;=3^Secondary Hypertension,Unspec
 ;;^UTILITY(U,$J,358.3,2736,1,4,0)
 ;;=4^I15.9
 ;;^UTILITY(U,$J,358.3,2736,2)
 ;;=^5007075
 ;;^UTILITY(U,$J,358.3,2737,0)
 ;;=I16.0^^20^174^14
 ;;^UTILITY(U,$J,358.3,2737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2737,1,3,0)
 ;;=3^Hypertensive Urgency
 ;;^UTILITY(U,$J,358.3,2737,1,4,0)
 ;;=4^I16.0
 ;;^UTILITY(U,$J,358.3,2737,2)
 ;;=^8133013
 ;;^UTILITY(U,$J,358.3,2738,0)
 ;;=I16.1^^20^174^7
 ;;^UTILITY(U,$J,358.3,2738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2738,1,3,0)
 ;;=3^Hypertensive Emergency
 ;;^UTILITY(U,$J,358.3,2738,1,4,0)
 ;;=4^I16.1
 ;;^UTILITY(U,$J,358.3,2738,2)
 ;;=^8204721
 ;;^UTILITY(U,$J,358.3,2739,0)
 ;;=I16.9^^20^174^6
 ;;^UTILITY(U,$J,358.3,2739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2739,1,3,0)
 ;;=3^Hypertensive Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,2739,1,4,0)
 ;;=4^I16.9
 ;;^UTILITY(U,$J,358.3,2739,2)
 ;;=^5138600
 ;;^UTILITY(U,$J,358.3,2740,0)
 ;;=33206^^21^175^37^^^^1
 ;;^UTILITY(U,$J,358.3,2740,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2740,1,2,0)
 ;;=2^33206
 ;;^UTILITY(U,$J,358.3,2740,1,3,0)
 ;;=3^Pace Implant, Atrial
 ;;^UTILITY(U,$J,358.3,2741,0)
 ;;=33207^^21^175^39^^^^1
 ;;^UTILITY(U,$J,358.3,2741,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2741,1,2,0)
 ;;=2^33207
 ;;^UTILITY(U,$J,358.3,2741,1,3,0)
 ;;=3^Pace Implant,Vent
 ;;^UTILITY(U,$J,358.3,2742,0)
 ;;=33208^^21^175^38^^^^1
 ;;^UTILITY(U,$J,358.3,2742,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2742,1,2,0)
 ;;=2^33208
 ;;^UTILITY(U,$J,358.3,2742,1,3,0)
 ;;=3^Pace Implant, Ddd
 ;;^UTILITY(U,$J,358.3,2743,0)
 ;;=33210^^21^175^64^^^^1
 ;;^UTILITY(U,$J,358.3,2743,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2743,1,2,0)
 ;;=2^33210
 ;;^UTILITY(U,$J,358.3,2743,1,3,0)
 ;;=3^Temp Pacer (Single)
 ;;^UTILITY(U,$J,358.3,2744,0)
 ;;=33211^^21^175^63^^^^1
 ;;^UTILITY(U,$J,358.3,2744,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2744,1,2,0)
 ;;=2^33211
 ;;^UTILITY(U,$J,358.3,2744,1,3,0)
 ;;=3^Temp Pacer (Dual)
 ;;^UTILITY(U,$J,358.3,2745,0)
 ;;=33212^^21^175^22^^^^1
 ;;^UTILITY(U,$J,358.3,2745,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2745,1,2,0)
 ;;=2^33212
 ;;^UTILITY(U,$J,358.3,2745,1,3,0)
 ;;=3^Insert Pacer, Pulse Gen (Sgl)
 ;;^UTILITY(U,$J,358.3,2746,0)
 ;;=33213^^21^175^21^^^^1
 ;;^UTILITY(U,$J,358.3,2746,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2746,1,2,0)
 ;;=2^33213
 ;;^UTILITY(U,$J,358.3,2746,1,3,0)
 ;;=3^Insert Pacer, Pulse Gen (Dual)
 ;;^UTILITY(U,$J,358.3,2747,0)
 ;;=33216^^21^175^24^^^^1
 ;;^UTILITY(U,$J,358.3,2747,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2747,1,2,0)
 ;;=2^33216
 ;;^UTILITY(U,$J,358.3,2747,1,3,0)
 ;;=3^Insert Transv Elec Pacemaker/Defib,Single
 ;;^UTILITY(U,$J,358.3,2748,0)
 ;;=33217^^21^175^23^^^^1
 ;;^UTILITY(U,$J,358.3,2748,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2748,1,2,0)
 ;;=2^33217
 ;;^UTILITY(U,$J,358.3,2748,1,3,0)
 ;;=3^Insert Transv Elec Pacemaker/Defib,Dual
 ;;^UTILITY(U,$J,358.3,2749,0)
 ;;=33218^^21^175^57^^^^1
 ;;^UTILITY(U,$J,358.3,2749,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2749,1,2,0)
 ;;=2^33218
 ;;^UTILITY(U,$J,358.3,2749,1,3,0)
 ;;=3^Repair Transv Elec (Single)
 ;;^UTILITY(U,$J,358.3,2750,0)
 ;;=33220^^21^175^56^^^^1
 ;;^UTILITY(U,$J,358.3,2750,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2750,1,2,0)
 ;;=2^33220
 ;;^UTILITY(U,$J,358.3,2750,1,3,0)
 ;;=3^Repair Transv Elec (Dual)
 ;;^UTILITY(U,$J,358.3,2751,0)
 ;;=33222^^21^175^59^^^^1
 ;;^UTILITY(U,$J,358.3,2751,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2751,1,2,0)
 ;;=2^33222
 ;;^UTILITY(U,$J,358.3,2751,1,3,0)
 ;;=3^Revis Or Reloc Skin Pckt
 ;;^UTILITY(U,$J,358.3,2752,0)
 ;;=33233^^21^175^52^^^^1
 ;;^UTILITY(U,$J,358.3,2752,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2752,1,2,0)
 ;;=2^33233
 ;;^UTILITY(U,$J,358.3,2752,1,3,0)
 ;;=3^Remove Pace Pulse Gen
 ;;^UTILITY(U,$J,358.3,2753,0)
 ;;=93650^^21^175^1^^^^1
 ;;^UTILITY(U,$J,358.3,2753,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2753,1,2,0)
 ;;=2^93650
 ;;^UTILITY(U,$J,358.3,2753,1,3,0)
 ;;=3^Abalation, Av Node
 ;;^UTILITY(U,$J,358.3,2754,0)
 ;;=93740^^21^175^62^^^^1
 ;;^UTILITY(U,$J,358.3,2754,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2754,1,2,0)
 ;;=2^93740
 ;;^UTILITY(U,$J,358.3,2754,1,3,0)
 ;;=3^Temp Gradient Studies
 ;;^UTILITY(U,$J,358.3,2755,0)
 ;;=33234^^21^175^45^^^^1
 ;;^UTILITY(U,$J,358.3,2755,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2755,1,2,0)
 ;;=2^33234
 ;;^UTILITY(U,$J,358.3,2755,1,3,0)
 ;;=3^Rem Transv Elec Atria/Vent(Sgl)
 ;;^UTILITY(U,$J,358.3,2756,0)
 ;;=33235^^21^175^44^^^^1
 ;;^UTILITY(U,$J,358.3,2756,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2756,1,2,0)
 ;;=2^33235
 ;;^UTILITY(U,$J,358.3,2756,1,3,0)
 ;;=3^Rem Transv Elec Atria/Vent(Dual)
 ;;^UTILITY(U,$J,358.3,2757,0)
 ;;=33240^^21^175^20^^^^1
 ;;^UTILITY(U,$J,358.3,2757,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2757,1,2,0)
 ;;=2^33240
 ;;^UTILITY(U,$J,358.3,2757,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Single
 ;;^UTILITY(U,$J,358.3,2758,0)
 ;;=33241^^21^175^61^^^^1
 ;;^UTILITY(U,$J,358.3,2758,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2758,1,2,0)
 ;;=2^33241
 ;;^UTILITY(U,$J,358.3,2758,1,3,0)
 ;;=3^Subq Remove Sgl/Dual Pulse Gen
 ;;^UTILITY(U,$J,358.3,2759,0)
 ;;=33244^^21^175^65^^^^1
 ;;^UTILITY(U,$J,358.3,2759,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2759,1,2,0)
 ;;=2^33244
 ;;^UTILITY(U,$J,358.3,2759,1,3,0)
 ;;=3^Transv Remove Sgl/Dual Elec
 ;;^UTILITY(U,$J,358.3,2760,0)
 ;;=33249^^21^175^25^^^^1
 ;;^UTILITY(U,$J,358.3,2760,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2760,1,2,0)
 ;;=2^33249
 ;;^UTILITY(U,$J,358.3,2760,1,3,0)
 ;;=3^Insert/Replace Implant Defib w/ Transv Lead
 ;;^UTILITY(U,$J,358.3,2761,0)
 ;;=93285^^21^175^12^^^^1
 ;;^UTILITY(U,$J,358.3,2761,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2761,1,2,0)
 ;;=2^93285
 ;;^UTILITY(U,$J,358.3,2761,1,3,0)
 ;;=3^ILR Device Eval Progr
 ;;^UTILITY(U,$J,358.3,2762,0)
 ;;=93291^^21^175^14^^^^1
 ;;^UTILITY(U,$J,358.3,2762,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2762,1,2,0)
 ;;=2^93291
 ;;^UTILITY(U,$J,358.3,2762,1,3,0)
 ;;=3^ILR Device Interrogate
 ;;^UTILITY(U,$J,358.3,2763,0)
 ;;=93294^^21^175^32^^^^1
 ;;^UTILITY(U,$J,358.3,2763,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2763,1,2,0)
 ;;=2^93294
 ;;^UTILITY(U,$J,358.3,2763,1,3,0)
 ;;=3^PM Device Interrogate Remote
 ;;^UTILITY(U,$J,358.3,2764,0)
 ;;=93280^^21^175^33^^^^1
 ;;^UTILITY(U,$J,358.3,2764,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2764,1,2,0)
 ;;=2^93280
 ;;^UTILITY(U,$J,358.3,2764,1,3,0)
 ;;=3^PM Device Progr Eval,Dual
 ;;^UTILITY(U,$J,358.3,2765,0)
 ;;=93288^^21^175^31^^^^1
 ;;^UTILITY(U,$J,358.3,2765,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2765,1,2,0)
 ;;=2^93288
 ;;^UTILITY(U,$J,358.3,2765,1,3,0)
 ;;=3^PM Device Eval in Person
 ;;^UTILITY(U,$J,358.3,2766,0)
 ;;=93279^^21^175^35^^^^1
 ;;^UTILITY(U,$J,358.3,2766,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2766,1,2,0)
 ;;=2^93279
 ;;^UTILITY(U,$J,358.3,2766,1,3,0)
 ;;=3^PM Device Progr Eval,Sngl
 ;;^UTILITY(U,$J,358.3,2767,0)
 ;;=93282^^21^175^7^^^^1
 ;;^UTILITY(U,$J,358.3,2767,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2767,1,2,0)
 ;;=2^93282
 ;;^UTILITY(U,$J,358.3,2767,1,3,0)
 ;;=3^ICD Device Prog Eval,1 Sngl
 ;;^UTILITY(U,$J,358.3,2768,0)
 ;;=93289^^21^175^5^^^^1
 ;;^UTILITY(U,$J,358.3,2768,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2768,1,2,0)
 ;;=2^93289
 ;;^UTILITY(U,$J,358.3,2768,1,3,0)
 ;;=3^ICD Device Interrogatate
 ;;^UTILITY(U,$J,358.3,2769,0)
 ;;=93292^^21^175^67^^^^1
 ;;^UTILITY(U,$J,358.3,2769,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2769,1,2,0)
 ;;=2^93292
 ;;^UTILITY(U,$J,358.3,2769,1,3,0)
 ;;=3^WCD Device Interrogate
 ;;^UTILITY(U,$J,358.3,2770,0)
 ;;=93295^^21^175^6^^^^1
 ;;^UTILITY(U,$J,358.3,2770,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2770,1,2,0)
 ;;=2^93295
 ;;^UTILITY(U,$J,358.3,2770,1,3,0)
 ;;=3^ICD Device Interrogate Remote
 ;;^UTILITY(U,$J,358.3,2771,0)
 ;;=93283^^21^175^8^^^^1
 ;;^UTILITY(U,$J,358.3,2771,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2771,1,2,0)
 ;;=2^93283
 ;;^UTILITY(U,$J,358.3,2771,1,3,0)
 ;;=3^ICD Device Progr Eval,Dual
 ;;^UTILITY(U,$J,358.3,2772,0)
 ;;=93284^^21^175^9^^^^1
 ;;^UTILITY(U,$J,358.3,2772,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2772,1,2,0)
 ;;=2^93284
 ;;^UTILITY(U,$J,358.3,2772,1,3,0)
 ;;=3^ICD Device Progr Eval,Multi
 ;;^UTILITY(U,$J,358.3,2773,0)
 ;;=93281^^21^175^34^^^^1
 ;;^UTILITY(U,$J,358.3,2773,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2773,1,2,0)
 ;;=2^93281
 ;;^UTILITY(U,$J,358.3,2773,1,3,0)
 ;;=3^PM Device Progr Eval,Multi
 ;;^UTILITY(U,$J,358.3,2774,0)
 ;;=33227^^21^175^51^^^^1
 ;;^UTILITY(U,$J,358.3,2774,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2774,1,2,0)
 ;;=2^33227
 ;;^UTILITY(U,$J,358.3,2774,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Single
 ;;^UTILITY(U,$J,358.3,2775,0)
 ;;=33228^^21^175^49^^^^1
 ;;^UTILITY(U,$J,358.3,2775,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2775,1,2,0)
 ;;=2^33228
 ;;^UTILITY(U,$J,358.3,2775,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Dual
 ;;^UTILITY(U,$J,358.3,2776,0)
 ;;=33229^^21^175^50^^^^1
 ;;^UTILITY(U,$J,358.3,2776,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2776,1,2,0)
 ;;=2^33229
 ;;^UTILITY(U,$J,358.3,2776,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Mult
 ;;^UTILITY(U,$J,358.3,2777,0)
 ;;=33230^^21^175^18^^^^1
 ;;^UTILITY(U,$J,358.3,2777,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2777,1,2,0)
 ;;=2^33230
 ;;^UTILITY(U,$J,358.3,2777,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Dual
 ;;^UTILITY(U,$J,358.3,2778,0)
 ;;=33231^^21^175^19^^^^1
 ;;^UTILITY(U,$J,358.3,2778,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2778,1,2,0)
 ;;=2^33231
 ;;^UTILITY(U,$J,358.3,2778,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Mult
 ;;^UTILITY(U,$J,358.3,2779,0)
 ;;=33233^^21^175^46^^^^1
 ;;^UTILITY(U,$J,358.3,2779,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2779,1,2,0)
 ;;=2^33233
 ;;^UTILITY(U,$J,358.3,2779,1,3,0)
 ;;=3^Removal of PM Generator Only
 ;;^UTILITY(U,$J,358.3,2780,0)
 ;;=33262^^21^175^55^^^^1
 ;;^UTILITY(U,$J,358.3,2780,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2780,1,2,0)
 ;;=2^33262
 ;;^UTILITY(U,$J,358.3,2780,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Single
 ;;^UTILITY(U,$J,358.3,2781,0)
 ;;=33263^^21^175^53^^^^1
 ;;^UTILITY(U,$J,358.3,2781,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2781,1,2,0)
 ;;=2^33263
 ;;^UTILITY(U,$J,358.3,2781,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Dual
 ;;^UTILITY(U,$J,358.3,2782,0)
 ;;=33264^^21^175^54^^^^1
 ;;^UTILITY(U,$J,358.3,2782,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2782,1,2,0)
 ;;=2^33264
 ;;^UTILITY(U,$J,358.3,2782,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Multiple
 ;;^UTILITY(U,$J,358.3,2783,0)
 ;;=93286^^21^175^41^^^^1
 ;;^UTILITY(U,$J,358.3,2783,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2783,1,2,0)
 ;;=2^93286
 ;;^UTILITY(U,$J,358.3,2783,1,3,0)
 ;;=3^Pre-Op PM Device Eval w/Review&Rpt
 ;;^UTILITY(U,$J,358.3,2784,0)
 ;;=93287^^21^175^40^^^^1
 ;;^UTILITY(U,$J,358.3,2784,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2784,1,2,0)
 ;;=2^93287
 ;;^UTILITY(U,$J,358.3,2784,1,3,0)
 ;;=3^Pre-Op ICD Device Eval
 ;;^UTILITY(U,$J,358.3,2785,0)
 ;;=93290^^21^175^10^^^^1
 ;;^UTILITY(U,$J,358.3,2785,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2785,1,2,0)
 ;;=2^93290
 ;;^UTILITY(U,$J,358.3,2785,1,3,0)
 ;;=3^ICM Device Eval
 ;;^UTILITY(U,$J,358.3,2786,0)
 ;;=93293^^21^175^36^^^^1
 ;;^UTILITY(U,$J,358.3,2786,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2786,1,2,0)
 ;;=2^93293
 ;;^UTILITY(U,$J,358.3,2786,1,3,0)
 ;;=3^PM Phone R-Strip Device Eval
 ;;^UTILITY(U,$J,358.3,2787,0)
 ;;=33223^^21^175^60^^^^1
 ;;^UTILITY(U,$J,358.3,2787,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2787,1,2,0)
 ;;=2^33223
 ;;^UTILITY(U,$J,358.3,2787,1,3,0)
 ;;=3^Revision Skin Pckt, ICD
 ;;^UTILITY(U,$J,358.3,2788,0)
 ;;=33224^^21^175^27^^^^1
 ;;^UTILITY(U,$J,358.3,2788,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2788,1,2,0)
 ;;=2^33224
 ;;^UTILITY(U,$J,358.3,2788,1,3,0)
 ;;=3^Insertion of Pacing Electrode
 ;;^UTILITY(U,$J,358.3,2789,0)
 ;;=33214^^21^175^66^^^^1
 ;;^UTILITY(U,$J,358.3,2789,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2789,1,2,0)
 ;;=2^33214
 ;;^UTILITY(U,$J,358.3,2789,1,3,0)
 ;;=3^Upgrade Sng to Dual PM System
 ;;^UTILITY(U,$J,358.3,2790,0)
 ;;=33215^^21^175^58^^^^1
 ;;^UTILITY(U,$J,358.3,2790,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2790,1,2,0)
 ;;=2^33215
 ;;^UTILITY(U,$J,358.3,2790,1,3,0)
 ;;=3^Reposition Transvenous PM/ICD Lead
 ;;^UTILITY(U,$J,358.3,2791,0)
 ;;=33221^^21^175^30^^^^1
 ;;^UTILITY(U,$J,358.3,2791,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2791,1,2,0)
 ;;=2^33221
 ;;^UTILITY(U,$J,358.3,2791,1,3,0)
 ;;=3^New Pacemaker Attached to Old Leads
 ;;^UTILITY(U,$J,358.3,2792,0)
 ;;=33225^^21^175^3^^^^1
 ;;^UTILITY(U,$J,358.3,2792,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2792,1,2,0)
 ;;=2^33225
 ;;^UTILITY(U,$J,358.3,2792,1,3,0)
 ;;=3^CS Lead Implt at time of New Implt/Upgd,Add-On
 ;;^UTILITY(U,$J,358.3,2793,0)
 ;;=33226^^21^175^4^^^^1
 ;;^UTILITY(U,$J,358.3,2793,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2793,1,2,0)
 ;;=2^33226
 ;;^UTILITY(U,$J,358.3,2793,1,3,0)
 ;;=3^CS Lead Revision
 ;;^UTILITY(U,$J,358.3,2794,0)
 ;;=93260^^21^175^42^^^^1
 ;;^UTILITY(U,$J,358.3,2794,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2794,1,2,0)
 ;;=2^93260
 ;;^UTILITY(U,$J,358.3,2794,1,3,0)
 ;;=3^Prgrmg Dev Eval Impltbl Sys
 ;;^UTILITY(U,$J,358.3,2795,0)
 ;;=93261^^21^175^29^^^^1
 ;;^UTILITY(U,$J,358.3,2795,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2795,1,2,0)
 ;;=2^93261
 ;;^UTILITY(U,$J,358.3,2795,1,3,0)
 ;;=3^Interrogate Subq Defib
 ;;^UTILITY(U,$J,358.3,2796,0)
 ;;=93298^^21^175^13^^^^1
 ;;^UTILITY(U,$J,358.3,2796,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2796,1,2,0)
 ;;=2^93298
 ;;^UTILITY(U,$J,358.3,2796,1,3,0)
 ;;=3^ILR Device Interrogat Remote
 ;;^UTILITY(U,$J,358.3,2797,0)
 ;;=93724^^21^175^2^^^^1
 ;;^UTILITY(U,$J,358.3,2797,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2797,1,2,0)
 ;;=2^93724
 ;;^UTILITY(U,$J,358.3,2797,1,3,0)
 ;;=3^Analyze Pacemaker System
 ;;^UTILITY(U,$J,358.3,2798,0)
 ;;=33967^^21^175^17^^^^1
 ;;^UTILITY(U,$J,358.3,2798,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2798,1,2,0)
 ;;=2^33967
 ;;^UTILITY(U,$J,358.3,2798,1,3,0)
 ;;=3^Insert IA Percut Device
 ;;^UTILITY(U,$J,358.3,2799,0)
 ;;=33236^^21^175^48^^^^1
 ;;^UTILITY(U,$J,358.3,2799,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2799,1,2,0)
 ;;=2^33236
 ;;^UTILITY(U,$J,358.3,2799,1,3,0)
 ;;=3^Remove Epi Electrode/Thoracotomy
 ;;^UTILITY(U,$J,358.3,2800,0)
 ;;=33237^^21^175^47^^^^1
 ;;^UTILITY(U,$J,358.3,2800,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2800,1,2,0)
 ;;=2^33237
 ;;^UTILITY(U,$J,358.3,2800,1,3,0)
 ;;=3^Remove Electrode/Thoracotomy Dual
 ;;^UTILITY(U,$J,358.3,2801,0)
 ;;=33249^^21^175^26^^^^1
 ;;^UTILITY(U,$J,358.3,2801,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2801,1,2,0)
 ;;=2^33249
 ;;^UTILITY(U,$J,358.3,2801,1,3,0)
 ;;=3^Insert/Rpl ICD,Sgl/Dual w/ Tranv Leads
 ;;^UTILITY(U,$J,358.3,2802,0)
 ;;=93297^^21^175^11^^^^1
 ;;^UTILITY(U,$J,358.3,2802,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2802,1,2,0)
 ;;=2^93297
 ;;^UTILITY(U,$J,358.3,2802,1,3,0)
 ;;=3^ICM Device Interrogat Remote
 ;;^UTILITY(U,$J,358.3,2803,0)
 ;;=33286^^21^175^15^^^^1
 ;;^UTILITY(U,$J,358.3,2803,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2803,1,2,0)
 ;;=2^33286
 ;;^UTILITY(U,$J,358.3,2803,1,3,0)
 ;;=3^IRL Explant
 ;;^UTILITY(U,$J,358.3,2804,0)
 ;;=33285^^21^175^16^^^^1
 ;;^UTILITY(U,$J,358.3,2804,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2804,1,2,0)
 ;;=2^33285
 ;;^UTILITY(U,$J,358.3,2804,1,3,0)
 ;;=3^IRL Implant
 ;;^UTILITY(U,$J,358.3,2805,0)
 ;;=93297^^21^175^43^^^^1
 ;;^UTILITY(U,$J,358.3,2805,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2805,1,2,0)
 ;;=2^93297
 ;;^UTILITY(U,$J,358.3,2805,1,3,0)
 ;;=3^Rem Interrog Icpms<30 D Phys/QHP
 ;;^UTILITY(U,$J,358.3,2806,0)
 ;;=G2066^^21^175^28^^^^1
 ;;^UTILITY(U,$J,358.3,2806,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2806,1,2,0)
 ;;=2^G2066
 ;;^UTILITY(U,$J,358.3,2806,1,3,0)
 ;;=3^Inter Device Eval,Remote up to 30D,Implantable Loop
 ;;^UTILITY(U,$J,358.3,2807,0)
 ;;=92975^^21^176^32^^^^1
 ;;^UTILITY(U,$J,358.3,2807,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2807,1,2,0)
 ;;=2^92975
 ;;^UTILITY(U,$J,358.3,2807,1,3,0)
 ;;=3^Thrombo Cor Inc Cor Angio
 ;;^UTILITY(U,$J,358.3,2808,0)
 ;;=92977^^21^176^33^^^^1
 ;;^UTILITY(U,$J,358.3,2808,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2808,1,2,0)
 ;;=2^92977
 ;;^UTILITY(U,$J,358.3,2808,1,3,0)
 ;;=3^Thrombo Cor,Inc Cor Angio Iv Inf
 ;;^UTILITY(U,$J,358.3,2809,0)
 ;;=92978^^21^176^5^^^^1
 ;;^UTILITY(U,$J,358.3,2809,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2809,1,2,0)
 ;;=2^92978
 ;;^UTILITY(U,$J,358.3,2809,1,3,0)
 ;;=3^Intr Vasc U/S During Diag Eval
 ;;^UTILITY(U,$J,358.3,2810,0)
 ;;=92979^^21^176^6^^^^1
 ;;^UTILITY(U,$J,358.3,2810,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2810,1,2,0)
 ;;=2^92979
 ;;^UTILITY(U,$J,358.3,2810,1,3,0)
 ;;=3^Intr Vasc U/S During Diag Eval Ea Addl Vessel
 ;;^UTILITY(U,$J,358.3,2811,0)
 ;;=36010^^21^176^3^^^^1
 ;;^UTILITY(U,$J,358.3,2811,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2811,1,2,0)
 ;;=2^36010
 ;;^UTILITY(U,$J,358.3,2811,1,3,0)
 ;;=3^Cath Place Svc/Ivc (Sheath)
 ;;^UTILITY(U,$J,358.3,2812,0)
 ;;=36011^^21^176^4^^^^1
 ;;^UTILITY(U,$J,358.3,2812,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2812,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,2812,1,3,0)
 ;;=3^Cath Place Vein 1st Order (Renal,Jugular)
 ;;^UTILITY(U,$J,358.3,2813,0)
 ;;=76000^^21^176^1^^^^1
 ;;^UTILITY(U,$J,358.3,2813,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2813,1,2,0)
 ;;=2^76000
 ;;^UTILITY(U,$J,358.3,2813,1,3,0)
 ;;=3^Cardiac Fluoro<1Hr(No Cath Proc)
 ;;^UTILITY(U,$J,358.3,2814,0)
 ;;=92973^^21^176^24^^^^1
 ;;^UTILITY(U,$J,358.3,2814,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2814,1,2,0)
 ;;=2^92973
 ;;^UTILITY(U,$J,358.3,2814,1,3,0)
 ;;=3^PRQ Coronary Thrombectomy Mechanical
 ;;^UTILITY(U,$J,358.3,2815,0)
 ;;=92974^^21^176^2^^^^1
 ;;^UTILITY(U,$J,358.3,2815,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2815,1,2,0)
 ;;=2^92974
 ;;^UTILITY(U,$J,358.3,2815,1,3,0)
 ;;=3^Cath Place Cardio Brachytx
 ;;^UTILITY(U,$J,358.3,2816,0)
 ;;=92920^^21^176^22^^^^1
 ;;^UTILITY(U,$J,358.3,2816,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2816,1,2,0)
 ;;=2^92920
 ;;^UTILITY(U,$J,358.3,2816,1,3,0)
 ;;=3^PRQ Cardia Angioplast 1 Art
 ;;^UTILITY(U,$J,358.3,2817,0)
 ;;=92921^^21^176^23^^^^1
 ;;^UTILITY(U,$J,358.3,2817,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2817,1,2,0)
 ;;=2^92921
 ;;^UTILITY(U,$J,358.3,2817,1,3,0)
 ;;=3^PRQ Cardiac Angio Addl Art
 ;;^UTILITY(U,$J,358.3,2818,0)
 ;;=92924^^21^176^13^^^^1
 ;;^UTILITY(U,$J,358.3,2818,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2818,1,2,0)
 ;;=2^92924
 ;;^UTILITY(U,$J,358.3,2818,1,3,0)
 ;;=3^PRQ Card Angio/Athrect 1 Art
 ;;^UTILITY(U,$J,358.3,2819,0)
 ;;=92925^^21^176^14^^^^1
 ;;^UTILITY(U,$J,358.3,2819,1,0)
 ;;=^358.31IA^3^2
