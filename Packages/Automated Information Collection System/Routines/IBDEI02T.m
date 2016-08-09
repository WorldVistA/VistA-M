IBDEI02T ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2389,1,3,0)
 ;;=3^Insert Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,2390,0)
 ;;=37619^^15^173^26^^^^1
 ;;^UTILITY(U,$J,358.3,2390,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2390,1,2,0)
 ;;=2^37619
 ;;^UTILITY(U,$J,358.3,2390,1,3,0)
 ;;=3^Open Inferior Vena Cava Filter Placement
 ;;^UTILITY(U,$J,358.3,2391,0)
 ;;=75635^^15^173^11^^^^1
 ;;^UTILITY(U,$J,358.3,2391,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2391,1,2,0)
 ;;=2^75635
 ;;^UTILITY(U,$J,358.3,2391,1,3,0)
 ;;=3^CT Angio Abd Art w/ Contrast
 ;;^UTILITY(U,$J,358.3,2392,0)
 ;;=75658^^15^173^3^^^^1
 ;;^UTILITY(U,$J,358.3,2392,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2392,1,2,0)
 ;;=2^75658
 ;;^UTILITY(U,$J,358.3,2392,1,3,0)
 ;;=3^Angiography,Brachial,Retrograd,Rad S&I
 ;;^UTILITY(U,$J,358.3,2393,0)
 ;;=76506^^15^173^13^^^^1
 ;;^UTILITY(U,$J,358.3,2393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2393,1,2,0)
 ;;=2^76506
 ;;^UTILITY(U,$J,358.3,2393,1,3,0)
 ;;=3^Echoencephalography,Real Time w/ Image Doc
 ;;^UTILITY(U,$J,358.3,2394,0)
 ;;=76000^^15^173^12^^^^1
 ;;^UTILITY(U,$J,358.3,2394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2394,1,2,0)
 ;;=2^76000
 ;;^UTILITY(U,$J,358.3,2394,1,3,0)
 ;;=3^Cardiac Fluoro<1hr
 ;;^UTILITY(U,$J,358.3,2395,0)
 ;;=35472^^15^173^30^^^^1
 ;;^UTILITY(U,$J,358.3,2395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2395,1,2,0)
 ;;=2^35472
 ;;^UTILITY(U,$J,358.3,2395,1,3,0)
 ;;=3^Perc Angioplasty,Aortic
 ;;^UTILITY(U,$J,358.3,2396,0)
 ;;=35476^^15^173^31^^^^1
 ;;^UTILITY(U,$J,358.3,2396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2396,1,2,0)
 ;;=2^35476
 ;;^UTILITY(U,$J,358.3,2396,1,3,0)
 ;;=3^Perc Angioplasty,Venous
 ;;^UTILITY(U,$J,358.3,2397,0)
 ;;=37236^^15^173^58^^^^1
 ;;^UTILITY(U,$J,358.3,2397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2397,1,2,0)
 ;;=2^37236
 ;;^UTILITY(U,$J,358.3,2397,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent,Init Art
 ;;^UTILITY(U,$J,358.3,2398,0)
 ;;=37237^^15^173^56^^^^1
 ;;^UTILITY(U,$J,358.3,2398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2398,1,2,0)
 ;;=2^37237
 ;;^UTILITY(U,$J,358.3,2398,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,2399,0)
 ;;=37238^^15^173^55^^^^1
 ;;^UTILITY(U,$J,358.3,2399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2399,1,2,0)
 ;;=2^37238
 ;;^UTILITY(U,$J,358.3,2399,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stent,Init Vein
 ;;^UTILITY(U,$J,358.3,2400,0)
 ;;=37239^^15^173^57^^^^1
 ;;^UTILITY(U,$J,358.3,2400,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2400,1,2,0)
 ;;=2^37239
 ;;^UTILITY(U,$J,358.3,2400,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Vein
 ;;^UTILITY(U,$J,358.3,2401,0)
 ;;=75978^^15^173^35^^^^1
 ;;^UTILITY(U,$J,358.3,2401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2401,1,2,0)
 ;;=2^75978
 ;;^UTILITY(U,$J,358.3,2401,1,3,0)
 ;;=3^Repair Venous Blockage
 ;;^UTILITY(U,$J,358.3,2402,0)
 ;;=75894^^15^173^59^^^^1
 ;;^UTILITY(U,$J,358.3,2402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2402,1,2,0)
 ;;=2^75894
 ;;^UTILITY(U,$J,358.3,2402,1,3,0)
 ;;=3^Transcath Rpr Iliac Art Aneur,AV,Rad S&I
 ;;^UTILITY(U,$J,358.3,2403,0)
 ;;=75962^^15^173^53^^^^1
 ;;^UTILITY(U,$J,358.3,2403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2403,1,2,0)
 ;;=2^75962
 ;;^UTILITY(U,$J,358.3,2403,1,3,0)
 ;;=3^Tranlum Ball Angio,Venous Art,Rad S&I
 ;;^UTILITY(U,$J,358.3,2404,0)
 ;;=0237T^^15^173^60^^^^1
 ;;^UTILITY(U,$J,358.3,2404,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2404,1,2,0)
 ;;=2^0237T
 ;;^UTILITY(U,$J,358.3,2404,1,3,0)
 ;;=3^Trluml Perip Athrc Brchiocph
 ;;^UTILITY(U,$J,358.3,2405,0)
 ;;=0238T^^15^173^61^^^^1
 ;;^UTILITY(U,$J,358.3,2405,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2405,1,2,0)
 ;;=2^0238T
 ;;^UTILITY(U,$J,358.3,2405,1,3,0)
 ;;=3^Trluml Perip Athrc Iliac Art
 ;;^UTILITY(U,$J,358.3,2406,0)
 ;;=75820^^15^173^63^^^^1
 ;;^UTILITY(U,$J,358.3,2406,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2406,1,2,0)
 ;;=2^75820
 ;;^UTILITY(U,$J,358.3,2406,1,3,0)
 ;;=3^Vein X-Ray,Arm/Leg,Unilat
 ;;^UTILITY(U,$J,358.3,2407,0)
 ;;=75822^^15^173^64^^^^1
 ;;^UTILITY(U,$J,358.3,2407,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2407,1,2,0)
 ;;=2^75822
 ;;^UTILITY(U,$J,358.3,2407,1,3,0)
 ;;=3^Vein X-Ray,Arms/Legs,Bilat
 ;;^UTILITY(U,$J,358.3,2408,0)
 ;;=75827^^15^173^65^^^^1
 ;;^UTILITY(U,$J,358.3,2408,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2408,1,2,0)
 ;;=2^75827
 ;;^UTILITY(U,$J,358.3,2408,1,3,0)
 ;;=3^Vein X-Ray,Chest
 ;;^UTILITY(U,$J,358.3,2409,0)
 ;;=37252^^15^173^24^^^^1
 ;;^UTILITY(U,$J,358.3,2409,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2409,1,2,0)
 ;;=2^37252
 ;;^UTILITY(U,$J,358.3,2409,1,3,0)
 ;;=3^Intravas US,Non/Cor Vsl,Diag/Thera Interv,1st Vsl
 ;;^UTILITY(U,$J,358.3,2410,0)
 ;;=37253^^15^173^25^^^^1
 ;;^UTILITY(U,$J,358.3,2410,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2410,1,2,0)
 ;;=2^37253
 ;;^UTILITY(U,$J,358.3,2410,1,3,0)
 ;;=3^Intravas US,Non/Cor Vsl,Dx/Ther Interv,Ea Addl Vsl
 ;;^UTILITY(U,$J,358.3,2411,0)
 ;;=36005^^15^174^1^^^^1
 ;;^UTILITY(U,$J,358.3,2411,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2411,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,2411,1,3,0)
 ;;=3^Contrast Venography
 ;;^UTILITY(U,$J,358.3,2412,0)
 ;;=92950^^15^175^1^^^^1
 ;;^UTILITY(U,$J,358.3,2412,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2412,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,2412,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,2413,0)
 ;;=33010^^15^175^4^^^^1
 ;;^UTILITY(U,$J,358.3,2413,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2413,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,2413,1,3,0)
 ;;=3^Pericardiocentesis
 ;;^UTILITY(U,$J,358.3,2414,0)
 ;;=92970^^15^175^2^^^^1
 ;;^UTILITY(U,$J,358.3,2414,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2414,1,2,0)
 ;;=2^92970
 ;;^UTILITY(U,$J,358.3,2414,1,3,0)
 ;;=3^Cardio Assist Dev Insert
 ;;^UTILITY(U,$J,358.3,2415,0)
 ;;=94760^^15^175^3^^^^1
 ;;^UTILITY(U,$J,358.3,2415,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2415,1,2,0)
 ;;=2^94760
 ;;^UTILITY(U,$J,358.3,2415,1,3,0)
 ;;=3^MEASURE BLOOD OXYGEN LEVEL
 ;;^UTILITY(U,$J,358.3,2416,0)
 ;;=93503^^15^176^23^^^^1
 ;;^UTILITY(U,$J,358.3,2416,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2416,1,2,0)
 ;;=2^93503
 ;;^UTILITY(U,$J,358.3,2416,1,3,0)
 ;;=3^Swan Ganz Placement
 ;;^UTILITY(U,$J,358.3,2417,0)
 ;;=93451^^15^176^20^^^^1
 ;;^UTILITY(U,$J,358.3,2417,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2417,1,2,0)
 ;;=2^93451
 ;;^UTILITY(U,$J,358.3,2417,1,3,0)
 ;;=3^Right Hrt Cath incl O2 & Cardiac Outpt
 ;;^UTILITY(U,$J,358.3,2418,0)
 ;;=93452^^15^176^12^^^^1
 ;;^UTILITY(U,$J,358.3,2418,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2418,1,2,0)
 ;;=2^93452
 ;;^UTILITY(U,$J,358.3,2418,1,3,0)
 ;;=3^LHC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,2419,0)
 ;;=93453^^15^176^18^^^^1
 ;;^UTILITY(U,$J,358.3,2419,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2419,1,2,0)
 ;;=2^93453
 ;;^UTILITY(U,$J,358.3,2419,1,3,0)
 ;;=3^R&L HC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,2420,0)
 ;;=93454^^15^176^5^^^^1
 ;;^UTILITY(U,$J,358.3,2420,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2420,1,2,0)
 ;;=2^93454
 ;;^UTILITY(U,$J,358.3,2420,1,3,0)
 ;;=3^Coronary Angiography, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,2421,0)
 ;;=93455^^15^176^1^^^^1
 ;;^UTILITY(U,$J,358.3,2421,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2421,1,2,0)
 ;;=2^93455
 ;;^UTILITY(U,$J,358.3,2421,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and Bypass angio
 ;;^UTILITY(U,$J,358.3,2422,0)
 ;;=93456^^15^176^2^^^^1
 ;;^UTILITY(U,$J,358.3,2422,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2422,1,2,0)
 ;;=2^93456
 ;;^UTILITY(U,$J,358.3,2422,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and R Heart Cath
 ;;^UTILITY(U,$J,358.3,2423,0)
 ;;=93457^^15^176^21^^^^1
 ;;^UTILITY(U,$J,358.3,2423,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2423,1,2,0)
 ;;=2^93457
