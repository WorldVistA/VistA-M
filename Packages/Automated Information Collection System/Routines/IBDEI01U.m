IBDEI01U ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1880,1,3,0)
 ;;=3^TIB/Per Revasc w/ Ather,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,1881,0)
 ;;=37234^^9^135^48^^^^1
 ;;^UTILITY(U,$J,358.3,1881,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1881,1,2,0)
 ;;=2^37234
 ;;^UTILITY(U,$J,358.3,1881,1,3,0)
 ;;=3^TIB/Per Revasc w/ Stent,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,1882,0)
 ;;=37235^^9^135^49^^^^1
 ;;^UTILITY(U,$J,358.3,1882,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1882,1,2,0)
 ;;=2^37235
 ;;^UTILITY(U,$J,358.3,1882,1,3,0)
 ;;=3^TIB/Per Revasc w/ Stnt&Ather,addl Vessel
 ;;^UTILITY(U,$J,358.3,1883,0)
 ;;=36251^^9^135^37^^^^1
 ;;^UTILITY(U,$J,358.3,1883,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1883,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,1883,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Access Art
 ;;^UTILITY(U,$J,358.3,1884,0)
 ;;=36252^^9^135^36^^^^1
 ;;^UTILITY(U,$J,358.3,1884,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1884,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,1884,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art,Bilat
 ;;^UTILITY(U,$J,358.3,1885,0)
 ;;=36254^^9^135^43^^^^1
 ;;^UTILITY(U,$J,358.3,1885,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1885,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,1885,1,3,0)
 ;;=3^Superselect Cath Ren Art&Access Art
 ;;^UTILITY(U,$J,358.3,1886,0)
 ;;=37191^^9^135^22^^^^1
 ;;^UTILITY(U,$J,358.3,1886,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1886,1,2,0)
 ;;=2^37191
 ;;^UTILITY(U,$J,358.3,1886,1,3,0)
 ;;=3^Insert Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,1887,0)
 ;;=37619^^9^135^26^^^^1
 ;;^UTILITY(U,$J,358.3,1887,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1887,1,2,0)
 ;;=2^37619
 ;;^UTILITY(U,$J,358.3,1887,1,3,0)
 ;;=3^Open Inferior Vena Cava Filter Placement
 ;;^UTILITY(U,$J,358.3,1888,0)
 ;;=75635^^9^135^11^^^^1
 ;;^UTILITY(U,$J,358.3,1888,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1888,1,2,0)
 ;;=2^75635
 ;;^UTILITY(U,$J,358.3,1888,1,3,0)
 ;;=3^CT Angio Abd Art w/ Contrast
 ;;^UTILITY(U,$J,358.3,1889,0)
 ;;=75658^^9^135^3^^^^1
 ;;^UTILITY(U,$J,358.3,1889,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1889,1,2,0)
 ;;=2^75658
 ;;^UTILITY(U,$J,358.3,1889,1,3,0)
 ;;=3^Angiography,Brachial,Retrograd,Rad S&I
 ;;^UTILITY(U,$J,358.3,1890,0)
 ;;=76506^^9^135^13^^^^1
 ;;^UTILITY(U,$J,358.3,1890,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1890,1,2,0)
 ;;=2^76506
 ;;^UTILITY(U,$J,358.3,1890,1,3,0)
 ;;=3^Echoencephalography,Real Time w/ Image Doc
 ;;^UTILITY(U,$J,358.3,1891,0)
 ;;=76000^^9^135^12^^^^1
 ;;^UTILITY(U,$J,358.3,1891,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1891,1,2,0)
 ;;=2^76000
 ;;^UTILITY(U,$J,358.3,1891,1,3,0)
 ;;=3^Cardiac Fluoro<1hr
 ;;^UTILITY(U,$J,358.3,1892,0)
 ;;=35472^^9^135^30^^^^1
 ;;^UTILITY(U,$J,358.3,1892,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1892,1,2,0)
 ;;=2^35472
 ;;^UTILITY(U,$J,358.3,1892,1,3,0)
 ;;=3^Perc Angioplasty,Aortic
 ;;^UTILITY(U,$J,358.3,1893,0)
 ;;=35476^^9^135^31^^^^1
 ;;^UTILITY(U,$J,358.3,1893,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1893,1,2,0)
 ;;=2^35476
 ;;^UTILITY(U,$J,358.3,1893,1,3,0)
 ;;=3^Perc Angioplasty,Venous
 ;;^UTILITY(U,$J,358.3,1894,0)
 ;;=37236^^9^135^58^^^^1
 ;;^UTILITY(U,$J,358.3,1894,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1894,1,2,0)
 ;;=2^37236
 ;;^UTILITY(U,$J,358.3,1894,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent,Init Art
 ;;^UTILITY(U,$J,358.3,1895,0)
 ;;=37237^^9^135^56^^^^1
 ;;^UTILITY(U,$J,358.3,1895,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1895,1,2,0)
 ;;=2^37237
 ;;^UTILITY(U,$J,358.3,1895,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,1896,0)
 ;;=37238^^9^135^55^^^^1
 ;;^UTILITY(U,$J,358.3,1896,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1896,1,2,0)
 ;;=2^37238
 ;;^UTILITY(U,$J,358.3,1896,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stent,Init Vein
 ;;^UTILITY(U,$J,358.3,1897,0)
 ;;=37239^^9^135^57^^^^1
 ;;^UTILITY(U,$J,358.3,1897,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1897,1,2,0)
 ;;=2^37239
 ;;^UTILITY(U,$J,358.3,1897,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Vein
 ;;^UTILITY(U,$J,358.3,1898,0)
 ;;=75978^^9^135^35^^^^1
 ;;^UTILITY(U,$J,358.3,1898,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1898,1,2,0)
 ;;=2^75978
 ;;^UTILITY(U,$J,358.3,1898,1,3,0)
 ;;=3^Repair Venous Blockage
 ;;^UTILITY(U,$J,358.3,1899,0)
 ;;=75894^^9^135^59^^^^1
 ;;^UTILITY(U,$J,358.3,1899,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1899,1,2,0)
 ;;=2^75894
 ;;^UTILITY(U,$J,358.3,1899,1,3,0)
 ;;=3^Transcath Rpr Iliac Art Aneur,AV,Rad S&I
 ;;^UTILITY(U,$J,358.3,1900,0)
 ;;=75962^^9^135^53^^^^1
 ;;^UTILITY(U,$J,358.3,1900,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1900,1,2,0)
 ;;=2^75962
 ;;^UTILITY(U,$J,358.3,1900,1,3,0)
 ;;=3^Tranlum Ball Angio,Venous Art,Rad S&I
 ;;^UTILITY(U,$J,358.3,1901,0)
 ;;=0237T^^9^135^60^^^^1
 ;;^UTILITY(U,$J,358.3,1901,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1901,1,2,0)
 ;;=2^0237T
 ;;^UTILITY(U,$J,358.3,1901,1,3,0)
 ;;=3^Trluml Perip Athrc Brchiocph
 ;;^UTILITY(U,$J,358.3,1902,0)
 ;;=0238T^^9^135^61^^^^1
 ;;^UTILITY(U,$J,358.3,1902,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1902,1,2,0)
 ;;=2^0238T
 ;;^UTILITY(U,$J,358.3,1902,1,3,0)
 ;;=3^Trluml Perip Athrc Iliac Art
 ;;^UTILITY(U,$J,358.3,1903,0)
 ;;=75820^^9^135^63^^^^1
 ;;^UTILITY(U,$J,358.3,1903,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1903,1,2,0)
 ;;=2^75820
 ;;^UTILITY(U,$J,358.3,1903,1,3,0)
 ;;=3^Vein X-Ray,Arm/Leg,Unilat
 ;;^UTILITY(U,$J,358.3,1904,0)
 ;;=75822^^9^135^64^^^^1
 ;;^UTILITY(U,$J,358.3,1904,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1904,1,2,0)
 ;;=2^75822
 ;;^UTILITY(U,$J,358.3,1904,1,3,0)
 ;;=3^Vein X-Ray,Arms/Legs,Bilat
 ;;^UTILITY(U,$J,358.3,1905,0)
 ;;=75827^^9^135^65^^^^1
 ;;^UTILITY(U,$J,358.3,1905,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1905,1,2,0)
 ;;=2^75827
 ;;^UTILITY(U,$J,358.3,1905,1,3,0)
 ;;=3^Vein X-Ray,Chest
 ;;^UTILITY(U,$J,358.3,1906,0)
 ;;=37252^^9^135^24^^^^1
 ;;^UTILITY(U,$J,358.3,1906,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1906,1,2,0)
 ;;=2^37252
 ;;^UTILITY(U,$J,358.3,1906,1,3,0)
 ;;=3^Intravas US,Non/Cor Vsl,Diag/Thera Interv,1st Vsl
 ;;^UTILITY(U,$J,358.3,1907,0)
 ;;=37253^^9^135^25^^^^1
 ;;^UTILITY(U,$J,358.3,1907,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1907,1,2,0)
 ;;=2^37253
 ;;^UTILITY(U,$J,358.3,1907,1,3,0)
 ;;=3^Intravas US,Non/Cor Vsl,Dx/Ther Interv,Ea Addl Vsl
 ;;^UTILITY(U,$J,358.3,1908,0)
 ;;=36005^^9^136^1^^^^1
 ;;^UTILITY(U,$J,358.3,1908,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1908,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,1908,1,3,0)
 ;;=3^Contrast Venography
 ;;^UTILITY(U,$J,358.3,1909,0)
 ;;=92950^^9^137^1^^^^1
 ;;^UTILITY(U,$J,358.3,1909,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1909,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,1909,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,1910,0)
 ;;=33010^^9^137^4^^^^1
 ;;^UTILITY(U,$J,358.3,1910,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1910,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,1910,1,3,0)
 ;;=3^Pericardiocentesis
 ;;^UTILITY(U,$J,358.3,1911,0)
 ;;=92970^^9^137^2^^^^1
 ;;^UTILITY(U,$J,358.3,1911,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1911,1,2,0)
 ;;=2^92970
 ;;^UTILITY(U,$J,358.3,1911,1,3,0)
 ;;=3^Cardio Assist Dev Insert
 ;;^UTILITY(U,$J,358.3,1912,0)
 ;;=94760^^9^137^3^^^^1
 ;;^UTILITY(U,$J,358.3,1912,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1912,1,2,0)
 ;;=2^94760
 ;;^UTILITY(U,$J,358.3,1912,1,3,0)
 ;;=3^MEASURE BLOOD OXYGEN LEVEL
 ;;^UTILITY(U,$J,358.3,1913,0)
 ;;=93503^^9^138^23^^^^1
 ;;^UTILITY(U,$J,358.3,1913,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1913,1,2,0)
 ;;=2^93503
 ;;^UTILITY(U,$J,358.3,1913,1,3,0)
 ;;=3^Swan Ganz Placement
 ;;^UTILITY(U,$J,358.3,1914,0)
 ;;=93451^^9^138^20^^^^1
 ;;^UTILITY(U,$J,358.3,1914,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1914,1,2,0)
 ;;=2^93451
 ;;^UTILITY(U,$J,358.3,1914,1,3,0)
 ;;=3^Right Hrt Cath incl O2 & Cardiac Outpt
 ;;^UTILITY(U,$J,358.3,1915,0)
 ;;=93452^^9^138^12^^^^1
 ;;^UTILITY(U,$J,358.3,1915,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1915,1,2,0)
 ;;=2^93452
 ;;^UTILITY(U,$J,358.3,1915,1,3,0)
 ;;=3^LHC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,1916,0)
 ;;=93453^^9^138^18^^^^1
 ;;^UTILITY(U,$J,358.3,1916,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1916,1,2,0)
 ;;=2^93453
 ;;^UTILITY(U,$J,358.3,1916,1,3,0)
 ;;=3^R&L HC w/V-Gram, incl S&I
 ;;^UTILITY(U,$J,358.3,1917,0)
 ;;=93454^^9^138^5^^^^1
 ;;^UTILITY(U,$J,358.3,1917,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1917,1,2,0)
 ;;=2^93454
 ;;^UTILITY(U,$J,358.3,1917,1,3,0)
 ;;=3^Coronary Angiography, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1918,0)
 ;;=93455^^9^138^1^^^^1
 ;;^UTILITY(U,$J,358.3,1918,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1918,1,2,0)
 ;;=2^93455
 ;;^UTILITY(U,$J,358.3,1918,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and Bypass angio
 ;;^UTILITY(U,$J,358.3,1919,0)
 ;;=93456^^9^138^2^^^^1
 ;;^UTILITY(U,$J,358.3,1919,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1919,1,2,0)
 ;;=2^93456
 ;;^UTILITY(U,$J,358.3,1919,1,3,0)
 ;;=3^Cor Angio incl inj & S&I, and R Heart Cath
 ;;^UTILITY(U,$J,358.3,1920,0)
 ;;=93457^^9^138^21^^^^1
 ;;^UTILITY(U,$J,358.3,1920,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1920,1,2,0)
 ;;=2^93457
 ;;^UTILITY(U,$J,358.3,1920,1,3,0)
 ;;=3^Rt Hrt Angio,Bypass Grft,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1921,0)
 ;;=93458^^9^138^3^^^^1
 ;;^UTILITY(U,$J,358.3,1921,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1921,1,2,0)
 ;;=2^93458
 ;;^UTILITY(U,$J,358.3,1921,1,3,0)
 ;;=3^Cor Angio, LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1922,0)
 ;;=93459^^9^138^13^^^^1
 ;;^UTILITY(U,$J,358.3,1922,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1922,1,2,0)
 ;;=2^93459
 ;;^UTILITY(U,$J,358.3,1922,1,3,0)
 ;;=3^Lt Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1923,0)
 ;;=93460^^9^138^4^^^^1
 ;;^UTILITY(U,$J,358.3,1923,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1923,1,2,0)
 ;;=2^93460
