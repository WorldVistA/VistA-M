IBDEI01E ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2902,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2902,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,2902,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Access Art
 ;;^UTILITY(U,$J,358.3,2903,0)
 ;;=36252^^21^178^35^^^^1
 ;;^UTILITY(U,$J,358.3,2903,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2903,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,2903,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art,Bilat
 ;;^UTILITY(U,$J,358.3,2904,0)
 ;;=36254^^21^178^42^^^^1
 ;;^UTILITY(U,$J,358.3,2904,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2904,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,2904,1,3,0)
 ;;=3^Superselect Cath Ren Art&Access Art
 ;;^UTILITY(U,$J,358.3,2905,0)
 ;;=37191^^21^178^22^^^^1
 ;;^UTILITY(U,$J,358.3,2905,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2905,1,2,0)
 ;;=2^37191
 ;;^UTILITY(U,$J,358.3,2905,1,3,0)
 ;;=3^Insert Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,2906,0)
 ;;=37619^^21^178^26^^^^1
 ;;^UTILITY(U,$J,358.3,2906,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2906,1,2,0)
 ;;=2^37619
 ;;^UTILITY(U,$J,358.3,2906,1,3,0)
 ;;=3^Open Inferior Vena Cava Filter Placement
 ;;^UTILITY(U,$J,358.3,2907,0)
 ;;=75635^^21^178^9^^^^1
 ;;^UTILITY(U,$J,358.3,2907,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2907,1,2,0)
 ;;=2^75635
 ;;^UTILITY(U,$J,358.3,2907,1,3,0)
 ;;=3^CT Angio Abd Art w/ Contrast
 ;;^UTILITY(U,$J,358.3,2908,0)
 ;;=76506^^21^178^13^^^^1
 ;;^UTILITY(U,$J,358.3,2908,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2908,1,2,0)
 ;;=2^76506
 ;;^UTILITY(U,$J,358.3,2908,1,3,0)
 ;;=3^Echoencephalography,Real Time w/ Image Doc
 ;;^UTILITY(U,$J,358.3,2909,0)
 ;;=76000^^21^178^10^^^^1
 ;;^UTILITY(U,$J,358.3,2909,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2909,1,2,0)
 ;;=2^76000
 ;;^UTILITY(U,$J,358.3,2909,1,3,0)
 ;;=3^Cardiac Fluoro<1hr
 ;;^UTILITY(U,$J,358.3,2910,0)
 ;;=37236^^21^178^54^^^^1
 ;;^UTILITY(U,$J,358.3,2910,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2910,1,2,0)
 ;;=2^37236
 ;;^UTILITY(U,$J,358.3,2910,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent,Init Art
 ;;^UTILITY(U,$J,358.3,2911,0)
 ;;=37237^^21^178^52^^^^1
 ;;^UTILITY(U,$J,358.3,2911,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2911,1,2,0)
 ;;=2^37237
 ;;^UTILITY(U,$J,358.3,2911,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,2912,0)
 ;;=37238^^21^178^51^^^^1
 ;;^UTILITY(U,$J,358.3,2912,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2912,1,2,0)
 ;;=2^37238
 ;;^UTILITY(U,$J,358.3,2912,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stent,Init Vein
 ;;^UTILITY(U,$J,358.3,2913,0)
 ;;=37239^^21^178^53^^^^1
 ;;^UTILITY(U,$J,358.3,2913,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2913,1,2,0)
 ;;=2^37239
 ;;^UTILITY(U,$J,358.3,2913,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Vein
 ;;^UTILITY(U,$J,358.3,2914,0)
 ;;=75894^^21^178^55^^^^1
 ;;^UTILITY(U,$J,358.3,2914,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2914,1,2,0)
 ;;=2^75894
 ;;^UTILITY(U,$J,358.3,2914,1,3,0)
 ;;=3^Transcath Rpr Iliac Art Aneur,AV,Rad S&I
 ;;^UTILITY(U,$J,358.3,2915,0)
 ;;=0237T^^21^178^57^^^^1
 ;;^UTILITY(U,$J,358.3,2915,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2915,1,2,0)
 ;;=2^0237T
 ;;^UTILITY(U,$J,358.3,2915,1,3,0)
 ;;=3^Trluml Perip Athrc Brchiocph
 ;;^UTILITY(U,$J,358.3,2916,0)
 ;;=0238T^^21^178^58^^^^1
 ;;^UTILITY(U,$J,358.3,2916,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2916,1,2,0)
 ;;=2^0238T
 ;;^UTILITY(U,$J,358.3,2916,1,3,0)
 ;;=3^Trluml Perip Athrc Iliac Art
 ;;^UTILITY(U,$J,358.3,2917,0)
 ;;=75820^^21^178^60^^^^1
 ;;^UTILITY(U,$J,358.3,2917,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2917,1,2,0)
 ;;=2^75820
 ;;^UTILITY(U,$J,358.3,2917,1,3,0)
 ;;=3^Vein X-Ray,Arm/Leg,Unilat
 ;;^UTILITY(U,$J,358.3,2918,0)
 ;;=75822^^21^178^61^^^^1
 ;;^UTILITY(U,$J,358.3,2918,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2918,1,2,0)
 ;;=2^75822
 ;;^UTILITY(U,$J,358.3,2918,1,3,0)
 ;;=3^Vein X-Ray,Arms/Legs,Bilat
 ;;^UTILITY(U,$J,358.3,2919,0)
 ;;=75827^^21^178^63^^^^1
 ;;^UTILITY(U,$J,358.3,2919,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2919,1,2,0)
 ;;=2^75827
 ;;^UTILITY(U,$J,358.3,2919,1,3,0)
 ;;=3^Vein X-Ray,Chest Superior
 ;;^UTILITY(U,$J,358.3,2920,0)
 ;;=37252^^21^178^24^^^^1
 ;;^UTILITY(U,$J,358.3,2920,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2920,1,2,0)
 ;;=2^37252
 ;;^UTILITY(U,$J,358.3,2920,1,3,0)
 ;;=3^Intravas US,Non/Cor Vsl,Diag/Thera Interv,1st Vsl
 ;;^UTILITY(U,$J,358.3,2921,0)
 ;;=37253^^21^178^25^^^^1
 ;;^UTILITY(U,$J,358.3,2921,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2921,1,2,0)
 ;;=2^37253
 ;;^UTILITY(U,$J,358.3,2921,1,3,0)
 ;;=3^Intravas US,Non/Cor Vsl,Dx/Ther Interv,Ea Addl Vsl
 ;;^UTILITY(U,$J,358.3,2922,0)
 ;;=36901^^21^178^8^^^^1
 ;;^UTILITY(U,$J,358.3,2922,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2922,1,2,0)
 ;;=2^36901
 ;;^UTILITY(U,$J,358.3,2922,1,3,0)
 ;;=3^Arteriovenous Shunt,Incl Rad S&I
 ;;^UTILITY(U,$J,358.3,2923,0)
 ;;=36222^^21^178^11^^^^1
 ;;^UTILITY(U,$J,358.3,2923,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2923,1,2,0)
 ;;=2^36222
 ;;^UTILITY(U,$J,358.3,2923,1,3,0)
 ;;=3^Cath Plcmnt Carotid,Extracranial,Unilat,Rad S&L
 ;;^UTILITY(U,$J,358.3,2924,0)
 ;;=36223^^21^178^12^^^^1
 ;;^UTILITY(U,$J,358.3,2924,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2924,1,2,0)
 ;;=2^36223
 ;;^UTILITY(U,$J,358.3,2924,1,3,0)
 ;;=3^Cath Plcmnt Carotid,Intracranial,Unilat,Rad S&L
 ;;^UTILITY(U,$J,358.3,2925,0)
 ;;=37246^^21^178^28^^^^1
 ;;^UTILITY(U,$J,358.3,2925,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2925,1,2,0)
 ;;=2^37246
 ;;^UTILITY(U,$J,358.3,2925,1,3,0)
 ;;=3^Perc Angioplasty,Intracran,Cor,Pulm,1st Artery
 ;;^UTILITY(U,$J,358.3,2926,0)
 ;;=37247^^21^178^29^^^^1
 ;;^UTILITY(U,$J,358.3,2926,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2926,1,2,0)
 ;;=2^37247
 ;;^UTILITY(U,$J,358.3,2926,1,3,0)
 ;;=3^Perc Angioplasty,Intracran,Cor,Pulm,Ea Addl Artery
 ;;^UTILITY(U,$J,358.3,2927,0)
 ;;=37248^^21^178^30^^^^1
 ;;^UTILITY(U,$J,358.3,2927,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2927,1,2,0)
 ;;=2^37248
 ;;^UTILITY(U,$J,358.3,2927,1,3,0)
 ;;=3^Perc Angioplasty,Venous,1st Vein
 ;;^UTILITY(U,$J,358.3,2928,0)
 ;;=37249^^21^178^31^^^^1
 ;;^UTILITY(U,$J,358.3,2928,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2928,1,2,0)
 ;;=2^37249
 ;;^UTILITY(U,$J,358.3,2928,1,3,0)
 ;;=3^Perc Angioplasty,Venous,Ea Addl Vein
 ;;^UTILITY(U,$J,358.3,2929,0)
 ;;=0236T^^21^178^56^^^^1
 ;;^UTILITY(U,$J,358.3,2929,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2929,1,2,0)
 ;;=2^0236T
 ;;^UTILITY(U,$J,358.3,2929,1,3,0)
 ;;=3^Trluml Perip Athrc Abd Aorta
 ;;^UTILITY(U,$J,358.3,2930,0)
 ;;=75825^^21^178^62^^^^1
 ;;^UTILITY(U,$J,358.3,2930,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2930,1,2,0)
 ;;=2^75825
 ;;^UTILITY(U,$J,358.3,2930,1,3,0)
 ;;=3^Vein X-Ray,Chest Inferior
 ;;^UTILITY(U,$J,358.3,2931,0)
 ;;=36005^^21^179^1^^^^1
 ;;^UTILITY(U,$J,358.3,2931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2931,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,2931,1,3,0)
 ;;=3^Contrast Venography
 ;;^UTILITY(U,$J,358.3,2932,0)
 ;;=92950^^21^180^1^^^^1
 ;;^UTILITY(U,$J,358.3,2932,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2932,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,2932,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,2933,0)
 ;;=92970^^21^180^2^^^^1
 ;;^UTILITY(U,$J,358.3,2933,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2933,1,2,0)
 ;;=2^92970
 ;;^UTILITY(U,$J,358.3,2933,1,3,0)
 ;;=3^Cardio Assist Dev Insert
 ;;^UTILITY(U,$J,358.3,2934,0)
 ;;=94760^^21^180^3^^^^1
 ;;^UTILITY(U,$J,358.3,2934,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2934,1,2,0)
 ;;=2^94760
 ;;^UTILITY(U,$J,358.3,2934,1,3,0)
 ;;=3^Measure Blood Oxygen Level,1 Time
 ;;^UTILITY(U,$J,358.3,2935,0)
 ;;=94761^^21^180^4^^^^1
 ;;^UTILITY(U,$J,358.3,2935,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2935,1,2,0)
 ;;=2^94761
 ;;^UTILITY(U,$J,358.3,2935,1,3,0)
 ;;=3^Measure Blood Oxygen Level,Mult Times
 ;;^UTILITY(U,$J,358.3,2936,0)
 ;;=33289^^21^180^5^^^^1
 ;;^UTILITY(U,$J,358.3,2936,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2936,1,2,0)
 ;;=2^33289
 ;;^UTILITY(U,$J,358.3,2936,1,3,0)
 ;;=3^Transcath Impl Wireless Pulm Art Sensor
 ;;^UTILITY(U,$J,358.3,2937,0)
 ;;=93503^^21^181^26^^^^1
 ;;^UTILITY(U,$J,358.3,2937,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2937,1,2,0)
 ;;=2^93503
 ;;^UTILITY(U,$J,358.3,2937,1,3,0)
 ;;=3^Swan Ganz Placement
 ;;^UTILITY(U,$J,358.3,2938,0)
 ;;=93451^^21^181^25^^^^1
 ;;^UTILITY(U,$J,358.3,2938,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2938,1,2,0)
 ;;=2^93451
 ;;^UTILITY(U,$J,358.3,2938,1,3,0)
 ;;=3^Rt Hrt Cath incl O2 & Cardiac Outpt
 ;;^UTILITY(U,$J,358.3,2939,0)
 ;;=93452^^21^181^14^^^^1
 ;;^UTILITY(U,$J,358.3,2939,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2939,1,2,0)
 ;;=2^93452
 ;;^UTILITY(U,$J,358.3,2939,1,3,0)
 ;;=3^LHC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,2940,0)
 ;;=93453^^21^181^20^^^^1
 ;;^UTILITY(U,$J,358.3,2940,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2940,1,2,0)
 ;;=2^93453
 ;;^UTILITY(U,$J,358.3,2940,1,3,0)
 ;;=3^R&L HC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,2941,0)
 ;;=93454^^21^181^8^^^^1
 ;;^UTILITY(U,$J,358.3,2941,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2941,1,2,0)
 ;;=2^93454
 ;;^UTILITY(U,$J,358.3,2941,1,3,0)
 ;;=3^Coronary Angiography, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2942,0)
 ;;=93455^^21^181^4^^^^1
 ;;^UTILITY(U,$J,358.3,2942,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2942,1,2,0)
 ;;=2^93455
 ;;^UTILITY(U,$J,358.3,2942,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and Bypass angio
 ;;^UTILITY(U,$J,358.3,2943,0)
 ;;=93456^^21^181^5^^^^1
 ;;^UTILITY(U,$J,358.3,2943,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2943,1,2,0)
 ;;=2^93456
 ;;^UTILITY(U,$J,358.3,2943,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and R Heart Cath
 ;;^UTILITY(U,$J,358.3,2944,0)
 ;;=93457^^21^181^24^^^^1
 ;;^UTILITY(U,$J,358.3,2944,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2944,1,2,0)
 ;;=2^93457
 ;;^UTILITY(U,$J,358.3,2944,1,3,0)
 ;;=3^Rt Hrt Angio,Bypass Grft,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2945,0)
 ;;=93458^^21^181^6^^^^1
 ;;^UTILITY(U,$J,358.3,2945,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2945,1,2,0)
 ;;=2^93458
 ;;^UTILITY(U,$J,358.3,2945,1,3,0)
 ;;=3^Cor Angio, LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2946,0)
 ;;=93459^^21^181^15^^^^1
 ;;^UTILITY(U,$J,358.3,2946,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2946,1,2,0)
 ;;=2^93459
 ;;^UTILITY(U,$J,358.3,2946,1,3,0)
 ;;=3^Lt Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2947,0)
 ;;=93460^^21^181^7^^^^1
 ;;^UTILITY(U,$J,358.3,2947,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2947,1,2,0)
 ;;=2^93460
 ;;^UTILITY(U,$J,358.3,2947,1,3,0)
 ;;=3^Cor Angio, RHC/LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2948,0)
 ;;=93461^^21^181^21^^^^1
 ;;^UTILITY(U,$J,358.3,2948,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2948,1,2,0)
 ;;=2^93461
 ;;^UTILITY(U,$J,358.3,2948,1,3,0)
 ;;=3^R&L Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2949,0)
 ;;=93462^^21^181^17^^^^1
 ;;^UTILITY(U,$J,358.3,2949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2949,1,2,0)
 ;;=2^93462
 ;;^UTILITY(U,$J,358.3,2949,1,3,0)
 ;;=3^Lt Hrt Cath Trnsptl Puncture
 ;;^UTILITY(U,$J,358.3,2950,0)
 ;;=93463^^21^181^18^^^^1
 ;;^UTILITY(U,$J,358.3,2950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2950,1,2,0)
 ;;=2^93463
 ;;^UTILITY(U,$J,358.3,2950,1,3,0)
 ;;=3^Pharm agent admin, when performed
 ;;^UTILITY(U,$J,358.3,2951,0)
 ;;=93505^^21^181^9^^^^1
 ;;^UTILITY(U,$J,358.3,2951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2951,1,2,0)
 ;;=2^93505
 ;;^UTILITY(U,$J,358.3,2951,1,3,0)
 ;;=3^Endomyocardial Biopsy
 ;;^UTILITY(U,$J,358.3,2952,0)
 ;;=93464^^21^181^19^^^^1
 ;;^UTILITY(U,$J,358.3,2952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2952,1,2,0)
 ;;=2^93464
 ;;^UTILITY(U,$J,358.3,2952,1,3,0)
 ;;=3^Phys Exercise Tst w/Hemodynamic Meas
 ;;^UTILITY(U,$J,358.3,2953,0)
 ;;=93564^^21^181^10^^^^1
 ;;^UTILITY(U,$J,358.3,2953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2953,1,2,0)
 ;;=2^93564
 ;;^UTILITY(U,$J,358.3,2953,1,3,0)
 ;;=3^Inject Hrt Cong Cath Art/Grft
 ;;^UTILITY(U,$J,358.3,2954,0)
 ;;=93568^^21^181^11^^^^1
 ;;^UTILITY(U,$J,358.3,2954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2954,1,2,0)
 ;;=2^93568
 ;;^UTILITY(U,$J,358.3,2954,1,3,0)
 ;;=3^Inject Pulm Art Hrt Cath
 ;;^UTILITY(U,$J,358.3,2955,0)
 ;;=93566^^21^181^12^^^^1
 ;;^UTILITY(U,$J,358.3,2955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2955,1,2,0)
 ;;=2^93566
 ;;^UTILITY(U,$J,358.3,2955,1,3,0)
 ;;=3^Inject R Ventr/Atrial Angio
 ;;^UTILITY(U,$J,358.3,2956,0)
 ;;=93567^^21^181^13^^^^1
 ;;^UTILITY(U,$J,358.3,2956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2956,1,2,0)
 ;;=2^93567
 ;;^UTILITY(U,$J,358.3,2956,1,3,0)
 ;;=3^Inject Suprvlv Aortography
 ;;^UTILITY(U,$J,358.3,2957,0)
 ;;=93580^^21^181^27^^^^1
 ;;^UTILITY(U,$J,358.3,2957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2957,1,2,0)
 ;;=2^93580
 ;;^UTILITY(U,$J,358.3,2957,1,3,0)
 ;;=3^Transcath Closure of ASD
 ;;^UTILITY(U,$J,358.3,2958,0)
 ;;=76937^^21^181^28^^^^1
 ;;^UTILITY(U,$J,358.3,2958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2958,1,2,0)
 ;;=2^76937
 ;;^UTILITY(U,$J,358.3,2958,1,3,0)
 ;;=3^US Vasc Access Sits Vsl Patency Ndl Entry
 ;;^UTILITY(U,$J,358.3,2959,0)
 ;;=93593^^21^181^3^^^^1
 ;;^UTILITY(U,$J,358.3,2959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2959,1,2,0)
 ;;=2^93593
 ;;^UTILITY(U,$J,358.3,2959,1,3,0)
 ;;=3^Cath Cong Hrt Defect w/ Image,Normal Native
 ;;^UTILITY(U,$J,358.3,2960,0)
 ;;=93594^^21^181^2^^^^1
 ;;^UTILITY(U,$J,358.3,2960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2960,1,2,0)
 ;;=2^93594
 ;;^UTILITY(U,$J,358.3,2960,1,3,0)
 ;;=3^Cath Cong Hrt Defect w/ Image,Abnormal Native
 ;;^UTILITY(U,$J,358.3,2961,0)
 ;;=93595^^21^181^16^^^^1
 ;;^UTILITY(U,$J,358.3,2961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2961,1,2,0)
 ;;=2^93595
 ;;^UTILITY(U,$J,358.3,2961,1,3,0)
 ;;=3^Lt Hrt Cath Cong Hrt Defect w/ Image
 ;;^UTILITY(U,$J,358.3,2962,0)
 ;;=93596^^21^181^23^^^^1
 ;;^UTILITY(U,$J,358.3,2962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2962,1,2,0)
 ;;=2^93596
 ;;^UTILITY(U,$J,358.3,2962,1,3,0)
 ;;=3^R&L Hrt Cath Cong Hrt Defect w/ Image,Normal
 ;;^UTILITY(U,$J,358.3,2963,0)
 ;;=93597^^21^181^22^^^^1
 ;;^UTILITY(U,$J,358.3,2963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2963,1,2,0)
 ;;=2^93597
 ;;^UTILITY(U,$J,358.3,2963,1,3,0)
 ;;=3^R&L Hrt Cath Cong Hrt Defect w/ Image,Abnormal
 ;;^UTILITY(U,$J,358.3,2964,0)
 ;;=93598^^21^181^1^^^^1
 ;;^UTILITY(U,$J,358.3,2964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2964,1,2,0)
 ;;=2^93598
 ;;^UTILITY(U,$J,358.3,2964,1,3,0)
 ;;=3^Cardiac Output Measure,Thermodilution or Oth,During Hrt Cath
 ;;^UTILITY(U,$J,358.3,2965,0)
 ;;=36100^^21^182^10^^^^1
 ;;^UTILITY(U,$J,358.3,2965,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2965,1,2,0)
 ;;=2^36100
 ;;^UTILITY(U,$J,358.3,2965,1,3,0)
 ;;=3^Intro Needle Or Cath Carotid Or Vert. Artery
 ;;^UTILITY(U,$J,358.3,2966,0)
 ;;=36140^^21^182^11^^^^1
 ;;^UTILITY(U,$J,358.3,2966,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2966,1,2,0)
 ;;=2^36140
 ;;^UTILITY(U,$J,358.3,2966,1,3,0)
 ;;=3^Intro Needle Or Cath Upper/Lower Ext Artery
 ;;^UTILITY(U,$J,358.3,2967,0)
 ;;=36011^^21^182^34^^^^1
 ;;^UTILITY(U,$J,358.3,2967,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2967,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,2967,1,3,0)
 ;;=3^Select Cath 1st Order Ren/Jugular Vein
 ;;^UTILITY(U,$J,358.3,2968,0)
 ;;=36245^^21^182^33^^^^1
 ;;^UTILITY(U,$J,358.3,2968,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2968,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,2968,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,2969,0)
 ;;=36246^^21^182^36^^^^1
 ;;^UTILITY(U,$J,358.3,2969,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2969,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,2969,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelvic/Le Artery,Init
 ;;^UTILITY(U,$J,358.3,2970,0)
 ;;=36247^^21^182^41^^^^1
 ;;^UTILITY(U,$J,358.3,2970,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2970,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,2970,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelvic/Le Artery,Init
 ;;^UTILITY(U,$J,358.3,2971,0)
 ;;=36216^^21^182^38^^^^1
 ;;^UTILITY(U,$J,358.3,2971,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2971,1,2,0)
 ;;=2^36216
 ;;^UTILITY(U,$J,358.3,2971,1,3,0)
 ;;=3^Select Cath 2nd Order Thor/Ue/Head,Init
 ;;^UTILITY(U,$J,358.3,2972,0)
 ;;=36217^^21^182^42^^^^1
 ;;^UTILITY(U,$J,358.3,2972,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2972,1,2,0)
 ;;=2^36217
 ;;^UTILITY(U,$J,358.3,2972,1,3,0)
 ;;=3^Select Cath 3rd Order Thor/Ue/Head,Init
 ;;^UTILITY(U,$J,358.3,2973,0)
 ;;=36248^^21^182^39^^^^1
 ;;^UTILITY(U,$J,358.3,2973,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2973,1,2,0)
 ;;=2^36248
 ;;^UTILITY(U,$J,358.3,2973,1,3,0)
 ;;=3^Select Cath 2nd/3rd Order Pelvic/Le,Ea Addl
 ;;^UTILITY(U,$J,358.3,2974,0)
 ;;=36200^^21^182^9^^^^1
 ;;^UTILITY(U,$J,358.3,2974,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2974,1,2,0)
 ;;=2^36200
 ;;^UTILITY(U,$J,358.3,2974,1,3,0)
 ;;=3^Intro Cath,Aorta
 ;;^UTILITY(U,$J,358.3,2975,0)
 ;;=36005^^21^182^5^^^^1
 ;;^UTILITY(U,$J,358.3,2975,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2975,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,2975,1,3,0)
 ;;=3^Injection Ext Venography
 ;;^UTILITY(U,$J,358.3,2976,0)
 ;;=36251^^21^182^32^^^^1
 ;;^UTILITY(U,$J,358.3,2976,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2976,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,2976,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Ren Art
 ;;^UTILITY(U,$J,358.3,2977,0)
 ;;=36252^^21^182^31^^^^1
 ;;^UTILITY(U,$J,358.3,2977,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2977,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,2977,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art Bilat
 ;;^UTILITY(U,$J,358.3,2978,0)
 ;;=36254^^21^182^6^^^^1
 ;;^UTILITY(U,$J,358.3,2978,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2978,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,2978,1,3,0)
 ;;=3^Ins Cath Ren Art 2nd+ Bilat
 ;;^UTILITY(U,$J,358.3,2979,0)
 ;;=36253^^21^182^7^^^^1
 ;;^UTILITY(U,$J,358.3,2979,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2979,1,2,0)
 ;;=2^36253
 ;;^UTILITY(U,$J,358.3,2979,1,3,0)
 ;;=3^Ins Cath Ren Art 2nd+ Unilat
 ;;^UTILITY(U,$J,358.3,2980,0)
 ;;=37191^^21^182^8^^^^1
 ;;^UTILITY(U,$J,358.3,2980,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2980,1,2,0)
 ;;=2^37191
 ;;^UTILITY(U,$J,358.3,2980,1,3,0)
 ;;=3^Ins Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,2981,0)
 ;;=36222^^21^182^17^^^^1
 ;;^UTILITY(U,$J,358.3,2981,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2981,1,2,0)
 ;;=2^36222
 ;;^UTILITY(U,$J,358.3,2981,1,3,0)
 ;;=3^Place Cath Carotid/Inom Art
 ;;^UTILITY(U,$J,358.3,2982,0)
 ;;=36223^^21^182^16^^^^1
 ;;^UTILITY(U,$J,358.3,2982,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2982,1,2,0)
 ;;=2^36223
 ;;^UTILITY(U,$J,358.3,2982,1,3,0)
 ;;=3^Place Cath Carotid Inc Extracranial
 ;;^UTILITY(U,$J,358.3,2983,0)
 ;;=36224^^21^182^15^^^^1
 ;;^UTILITY(U,$J,358.3,2983,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2983,1,2,0)
 ;;=2^36224
