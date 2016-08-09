IBDEI02S ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2356,0)
 ;;=75741^^15^173^34^^^^1
 ;;^UTILITY(U,$J,358.3,2356,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2356,1,2,0)
 ;;=2^75741
 ;;^UTILITY(U,$J,358.3,2356,1,3,0)
 ;;=3^Pulmonary Unilat Selective
 ;;^UTILITY(U,$J,358.3,2357,0)
 ;;=75743^^15^173^32^^^^1
 ;;^UTILITY(U,$J,358.3,2357,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2357,1,2,0)
 ;;=2^75743
 ;;^UTILITY(U,$J,358.3,2357,1,3,0)
 ;;=3^Pulmonary Bilat Selective
 ;;^UTILITY(U,$J,358.3,2358,0)
 ;;=75746^^15^173^33^^^^1
 ;;^UTILITY(U,$J,358.3,2358,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2358,1,2,0)
 ;;=2^75746
 ;;^UTILITY(U,$J,358.3,2358,1,3,0)
 ;;=3^Pulmonary By Nonselective
 ;;^UTILITY(U,$J,358.3,2359,0)
 ;;=75756^^15^173^23^^^^1
 ;;^UTILITY(U,$J,358.3,2359,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2359,1,2,0)
 ;;=2^75756
 ;;^UTILITY(U,$J,358.3,2359,1,3,0)
 ;;=3^Internal Mammary
 ;;^UTILITY(U,$J,358.3,2360,0)
 ;;=35475^^15^173^28^^^^1
 ;;^UTILITY(U,$J,358.3,2360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2360,1,2,0)
 ;;=2^35475
 ;;^UTILITY(U,$J,358.3,2360,1,3,0)
 ;;=3^Perc Angioplasty, Brachioceph Trunk/Branch, Each
 ;;^UTILITY(U,$J,358.3,2361,0)
 ;;=35471^^15^173^29^^^^1
 ;;^UTILITY(U,$J,358.3,2361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2361,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,2361,1,3,0)
 ;;=3^Perc Angioplasty, Renal/Visc
 ;;^UTILITY(U,$J,358.3,2362,0)
 ;;=36215^^15^173^41^^^^1
 ;;^UTILITY(U,$J,358.3,2362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2362,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,2362,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,2363,0)
 ;;=36011^^15^173^42^^^^1
 ;;^UTILITY(U,$J,358.3,2363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2363,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,2363,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jugular)
 ;;^UTILITY(U,$J,358.3,2364,0)
 ;;=36245^^15^173^38^^^^1
 ;;^UTILITY(U,$J,358.3,2364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2364,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,2364,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,2365,0)
 ;;=36246^^15^173^39^^^^1
 ;;^UTILITY(U,$J,358.3,2365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2365,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,2365,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,2366,0)
 ;;=36247^^15^173^40^^^^1
 ;;^UTILITY(U,$J,358.3,2366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2366,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,2366,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,2367,0)
 ;;=75962^^15^173^52^^^^1
 ;;^UTILITY(U,$J,358.3,2367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2367,1,2,0)
 ;;=2^75962
 ;;^UTILITY(U,$J,358.3,2367,1,3,0)
 ;;=3^Tranlum Ball Angio,Periph Art,Rad S&I
 ;;^UTILITY(U,$J,358.3,2368,0)
 ;;=75964^^15^173^54^^^^1
 ;;^UTILITY(U,$J,358.3,2368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2368,1,2,0)
 ;;=2^75964
 ;;^UTILITY(U,$J,358.3,2368,1,3,0)
 ;;=3^Tranlum Ball Angio,Venous Art,Rad S&I,Ea Addl Artery
 ;;^UTILITY(U,$J,358.3,2369,0)
 ;;=75791^^15^173^9^^^^1
 ;;^UTILITY(U,$J,358.3,2369,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2369,1,2,0)
 ;;=2^75791
 ;;^UTILITY(U,$J,358.3,2369,1,3,0)
 ;;=3^Arteriovenous Shunt
 ;;^UTILITY(U,$J,358.3,2370,0)
 ;;=37220^^15^173^20^^^^1
 ;;^UTILITY(U,$J,358.3,2370,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2370,1,2,0)
 ;;=2^37220
 ;;^UTILITY(U,$J,358.3,2370,1,3,0)
 ;;=3^Iliac Revasc,Unilat,1st Vessel
 ;;^UTILITY(U,$J,358.3,2371,0)
 ;;=37221^^15^173^18^^^^1
 ;;^UTILITY(U,$J,358.3,2371,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2371,1,2,0)
 ;;=2^37221
 ;;^UTILITY(U,$J,358.3,2371,1,3,0)
 ;;=3^Iliac Revasc w/ Stent
 ;;^UTILITY(U,$J,358.3,2372,0)
 ;;=37222^^15^173^21^^^^1
 ;;^UTILITY(U,$J,358.3,2372,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2372,1,2,0)
 ;;=2^37222
 ;;^UTILITY(U,$J,358.3,2372,1,3,0)
 ;;=3^Iliac Revasc,ea add Vessel
 ;;^UTILITY(U,$J,358.3,2373,0)
 ;;=37223^^15^173^19^^^^1
 ;;^UTILITY(U,$J,358.3,2373,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2373,1,2,0)
 ;;=2^37223
 ;;^UTILITY(U,$J,358.3,2373,1,3,0)
 ;;=3^Iliac Revasc w/ Stent,Add-on
 ;;^UTILITY(U,$J,358.3,2374,0)
 ;;=37224^^15^173^15^^^^1
 ;;^UTILITY(U,$J,358.3,2374,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2374,1,2,0)
 ;;=2^37224
 ;;^UTILITY(U,$J,358.3,2374,1,3,0)
 ;;=3^Fem/Popl Revas w/ TLA 1st Vessel
 ;;^UTILITY(U,$J,358.3,2375,0)
 ;;=37225^^15^173^14^^^^1
 ;;^UTILITY(U,$J,358.3,2375,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2375,1,2,0)
 ;;=2^37225
 ;;^UTILITY(U,$J,358.3,2375,1,3,0)
 ;;=3^Fem/Popl Revas w/ Ather
 ;;^UTILITY(U,$J,358.3,2376,0)
 ;;=37226^^15^173^16^^^^1
 ;;^UTILITY(U,$J,358.3,2376,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2376,1,2,0)
 ;;=2^37226
 ;;^UTILITY(U,$J,358.3,2376,1,3,0)
 ;;=3^Fem/Popl Revasc w/ Stent
 ;;^UTILITY(U,$J,358.3,2377,0)
 ;;=37227^^15^173^17^^^^1
 ;;^UTILITY(U,$J,358.3,2377,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2377,1,2,0)
 ;;=2^37227
 ;;^UTILITY(U,$J,358.3,2377,1,3,0)
 ;;=3^Fem/Popl Revasc w/ Stent & Ather
 ;;^UTILITY(U,$J,358.3,2378,0)
 ;;=37228^^15^173^50^^^^1
 ;;^UTILITY(U,$J,358.3,2378,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2378,1,2,0)
 ;;=2^37228
 ;;^UTILITY(U,$J,358.3,2378,1,3,0)
 ;;=3^TIB/Per Revasc w/ TLA,1st Vessel
 ;;^UTILITY(U,$J,358.3,2379,0)
 ;;=37229^^15^173^45^^^^1
 ;;^UTILITY(U,$J,358.3,2379,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2379,1,2,0)
 ;;=2^37229
 ;;^UTILITY(U,$J,358.3,2379,1,3,0)
 ;;=3^TIB/Per Revasc w/ Ather
 ;;^UTILITY(U,$J,358.3,2380,0)
 ;;=37230^^15^173^47^^^^1
 ;;^UTILITY(U,$J,358.3,2380,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2380,1,2,0)
 ;;=2^37230
 ;;^UTILITY(U,$J,358.3,2380,1,3,0)
 ;;=3^TIB/Per Revasc w/ Stent
 ;;^UTILITY(U,$J,358.3,2381,0)
 ;;=37231^^15^173^44^^^^1
 ;;^UTILITY(U,$J,358.3,2381,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2381,1,2,0)
 ;;=2^37231
 ;;^UTILITY(U,$J,358.3,2381,1,3,0)
 ;;=3^TIB/Per Revasc Stent & Ather
 ;;^UTILITY(U,$J,358.3,2382,0)
 ;;=37232^^15^173^51^^^^1
 ;;^UTILITY(U,$J,358.3,2382,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2382,1,2,0)
 ;;=2^37232
 ;;^UTILITY(U,$J,358.3,2382,1,3,0)
 ;;=3^TIB/Per Revasc,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,2383,0)
 ;;=37233^^15^173^46^^^^1
 ;;^UTILITY(U,$J,358.3,2383,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2383,1,2,0)
 ;;=2^37233
 ;;^UTILITY(U,$J,358.3,2383,1,3,0)
 ;;=3^TIB/Per Revasc w/ Ather,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,2384,0)
 ;;=37234^^15^173^48^^^^1
 ;;^UTILITY(U,$J,358.3,2384,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2384,1,2,0)
 ;;=2^37234
 ;;^UTILITY(U,$J,358.3,2384,1,3,0)
 ;;=3^TIB/Per Revasc w/ Stent,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,2385,0)
 ;;=37235^^15^173^49^^^^1
 ;;^UTILITY(U,$J,358.3,2385,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2385,1,2,0)
 ;;=2^37235
 ;;^UTILITY(U,$J,358.3,2385,1,3,0)
 ;;=3^TIB/Per Revasc w/ Stnt&Ather,addl Vessel
 ;;^UTILITY(U,$J,358.3,2386,0)
 ;;=36251^^15^173^37^^^^1
 ;;^UTILITY(U,$J,358.3,2386,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2386,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,2386,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Access Art
 ;;^UTILITY(U,$J,358.3,2387,0)
 ;;=36252^^15^173^36^^^^1
 ;;^UTILITY(U,$J,358.3,2387,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2387,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,2387,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art,Bilat
 ;;^UTILITY(U,$J,358.3,2388,0)
 ;;=36254^^15^173^43^^^^1
 ;;^UTILITY(U,$J,358.3,2388,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2388,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,2388,1,3,0)
 ;;=3^Superselect Cath Ren Art&Access Art
 ;;^UTILITY(U,$J,358.3,2389,0)
 ;;=37191^^15^173^22^^^^1
 ;;^UTILITY(U,$J,358.3,2389,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2389,1,2,0)
 ;;=2^37191
