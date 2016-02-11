IBDEI05F ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1888,1,2,0)
 ;;=2^37233
 ;;^UTILITY(U,$J,358.3,1888,1,3,0)
 ;;=3^TIB/Per Revasc w/ Ather,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,1889,0)
 ;;=37234^^17^172^47^^^^1
 ;;^UTILITY(U,$J,358.3,1889,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1889,1,2,0)
 ;;=2^37234
 ;;^UTILITY(U,$J,358.3,1889,1,3,0)
 ;;=3^TIB/Per Revasc w/ Stent,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,1890,0)
 ;;=37235^^17^172^48^^^^1
 ;;^UTILITY(U,$J,358.3,1890,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1890,1,2,0)
 ;;=2^37235
 ;;^UTILITY(U,$J,358.3,1890,1,3,0)
 ;;=3^TIB/Per Revasc w/ Stnt&Ather,addl Vessel
 ;;^UTILITY(U,$J,358.3,1891,0)
 ;;=36251^^17^172^36^^^^1
 ;;^UTILITY(U,$J,358.3,1891,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1891,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,1891,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Access Art
 ;;^UTILITY(U,$J,358.3,1892,0)
 ;;=36252^^17^172^35^^^^1
 ;;^UTILITY(U,$J,358.3,1892,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1892,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,1892,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art,Bilat
 ;;^UTILITY(U,$J,358.3,1893,0)
 ;;=36254^^17^172^42^^^^1
 ;;^UTILITY(U,$J,358.3,1893,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1893,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,1893,1,3,0)
 ;;=3^Superselect Cath Ren Art&Access Art
 ;;^UTILITY(U,$J,358.3,1894,0)
 ;;=37191^^17^172^22^^^^1
 ;;^UTILITY(U,$J,358.3,1894,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1894,1,2,0)
 ;;=2^37191
 ;;^UTILITY(U,$J,358.3,1894,1,3,0)
 ;;=3^Insert Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,1895,0)
 ;;=37619^^17^172^25^^^^1
 ;;^UTILITY(U,$J,358.3,1895,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1895,1,2,0)
 ;;=2^37619
 ;;^UTILITY(U,$J,358.3,1895,1,3,0)
 ;;=3^Open Inferior Vena Cava Filter Placement
 ;;^UTILITY(U,$J,358.3,1896,0)
 ;;=75635^^17^172^11^^^^1
 ;;^UTILITY(U,$J,358.3,1896,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1896,1,2,0)
 ;;=2^75635
 ;;^UTILITY(U,$J,358.3,1896,1,3,0)
 ;;=3^CT Angio Abd Art w/ Contrast
 ;;^UTILITY(U,$J,358.3,1897,0)
 ;;=75658^^17^172^3^^^^1
 ;;^UTILITY(U,$J,358.3,1897,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1897,1,2,0)
 ;;=2^75658
 ;;^UTILITY(U,$J,358.3,1897,1,3,0)
 ;;=3^Angiography,Brachial,Retrograd,Rad S&I
 ;;^UTILITY(U,$J,358.3,1898,0)
 ;;=76506^^17^172^13^^^^1
 ;;^UTILITY(U,$J,358.3,1898,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1898,1,2,0)
 ;;=2^76506
 ;;^UTILITY(U,$J,358.3,1898,1,3,0)
 ;;=3^Echoencephalography,Real Time w/ Image Doc
 ;;^UTILITY(U,$J,358.3,1899,0)
 ;;=76000^^17^172^12^^^^1
 ;;^UTILITY(U,$J,358.3,1899,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1899,1,2,0)
 ;;=2^76000
 ;;^UTILITY(U,$J,358.3,1899,1,3,0)
 ;;=3^Cardiac Fluoro<1hr
 ;;^UTILITY(U,$J,358.3,1900,0)
 ;;=35472^^17^172^29^^^^1
 ;;^UTILITY(U,$J,358.3,1900,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1900,1,2,0)
 ;;=2^35472
 ;;^UTILITY(U,$J,358.3,1900,1,3,0)
 ;;=3^Perc Angioplasty,Aortic
 ;;^UTILITY(U,$J,358.3,1901,0)
 ;;=35476^^17^172^30^^^^1
 ;;^UTILITY(U,$J,358.3,1901,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1901,1,2,0)
 ;;=2^35476
 ;;^UTILITY(U,$J,358.3,1901,1,3,0)
 ;;=3^Perc Angioplasty,Venous
 ;;^UTILITY(U,$J,358.3,1902,0)
 ;;=37236^^17^172^57^^^^1
 ;;^UTILITY(U,$J,358.3,1902,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1902,1,2,0)
 ;;=2^37236
 ;;^UTILITY(U,$J,358.3,1902,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent,Init Art
 ;;^UTILITY(U,$J,358.3,1903,0)
 ;;=37237^^17^172^55^^^^1
 ;;^UTILITY(U,$J,358.3,1903,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1903,1,2,0)
 ;;=2^37237
 ;;^UTILITY(U,$J,358.3,1903,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Art
