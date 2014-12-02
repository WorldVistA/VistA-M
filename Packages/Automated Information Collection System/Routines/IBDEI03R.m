IBDEI03R ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1430,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1430,1,2,0)
 ;;=2^37233
 ;;^UTILITY(U,$J,358.3,1430,1,3,0)
 ;;=3^TIB/Per Revasc w/Ather,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,1431,0)
 ;;=37234^^14^132^50^^^^1
 ;;^UTILITY(U,$J,358.3,1431,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1431,1,2,0)
 ;;=2^37234
 ;;^UTILITY(U,$J,358.3,1431,1,3,0)
 ;;=3^TIB/Per Revasc w/Stent,ea addl Vessel
 ;;^UTILITY(U,$J,358.3,1432,0)
 ;;=37235^^14^132^51^^^^1
 ;;^UTILITY(U,$J,358.3,1432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1432,1,2,0)
 ;;=2^37235
 ;;^UTILITY(U,$J,358.3,1432,1,3,0)
 ;;=3^TIB/Per Revasc w/Stnt&Ather,addl Vessel
 ;;^UTILITY(U,$J,358.3,1433,0)
 ;;=36251^^14^132^38^^^^1
 ;;^UTILITY(U,$J,358.3,1433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1433,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,1433,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Access Art
 ;;^UTILITY(U,$J,358.3,1434,0)
 ;;=36252^^14^132^37^^^^1
 ;;^UTILITY(U,$J,358.3,1434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1434,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,1434,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art,Bilat
 ;;^UTILITY(U,$J,358.3,1435,0)
 ;;=36254^^14^132^45^^^^1
 ;;^UTILITY(U,$J,358.3,1435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1435,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,1435,1,3,0)
 ;;=3^Superselect Cath Ren Art&Access Art
 ;;^UTILITY(U,$J,358.3,1436,0)
 ;;=37191^^14^132^25^^^^1
 ;;^UTILITY(U,$J,358.3,1436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1436,1,2,0)
 ;;=2^37191
 ;;^UTILITY(U,$J,358.3,1436,1,3,0)
 ;;=3^Insert Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,1437,0)
 ;;=37619^^14^132^28^^^^1
 ;;^UTILITY(U,$J,358.3,1437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1437,1,2,0)
 ;;=2^37619
 ;;^UTILITY(U,$J,358.3,1437,1,3,0)
 ;;=3^Open Inferior Vena Cava Filter Placement
 ;;^UTILITY(U,$J,358.3,1438,0)
 ;;=75635^^14^132^13^^^^1
 ;;^UTILITY(U,$J,358.3,1438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1438,1,2,0)
 ;;=2^75635
 ;;^UTILITY(U,$J,358.3,1438,1,3,0)
 ;;=3^CT Angio Abd Art w/Contrast
 ;;^UTILITY(U,$J,358.3,1439,0)
 ;;=75658^^14^132^5^^^^1
 ;;^UTILITY(U,$J,358.3,1439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1439,1,2,0)
 ;;=2^75658
 ;;^UTILITY(U,$J,358.3,1439,1,3,0)
 ;;=3^Angiography,Brachial,Retrograd,Rad S&I
 ;;^UTILITY(U,$J,358.3,1440,0)
 ;;=76506^^14^132^16^^^^1
 ;;^UTILITY(U,$J,358.3,1440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1440,1,2,0)
 ;;=2^76506
 ;;^UTILITY(U,$J,358.3,1440,1,3,0)
 ;;=3^Echoencephalography,Real Time w/Image Doc
 ;;^UTILITY(U,$J,358.3,1441,0)
 ;;=76000^^14^132^14^^^^1
 ;;^UTILITY(U,$J,358.3,1441,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1441,1,2,0)
 ;;=2^76000
 ;;^UTILITY(U,$J,358.3,1441,1,3,0)
 ;;=3^Cardiac Fluoro<1hr(No Cath Proc)
 ;;^UTILITY(U,$J,358.3,1442,0)
 ;;=35472^^14^132^32^^^^1
 ;;^UTILITY(U,$J,358.3,1442,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1442,1,2,0)
 ;;=2^35472
 ;;^UTILITY(U,$J,358.3,1442,1,3,0)
 ;;=3^Perc Angioplasty,Aortic
 ;;^UTILITY(U,$J,358.3,1443,0)
 ;;=35476^^14^132^33^^^^1
 ;;^UTILITY(U,$J,358.3,1443,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1443,1,2,0)
 ;;=2^35476
 ;;^UTILITY(U,$J,358.3,1443,1,3,0)
 ;;=3^Perc Angioplasty,Venous
 ;;^UTILITY(U,$J,358.3,1444,0)
 ;;=37236^^14^132^58^^^^1
 ;;^UTILITY(U,$J,358.3,1444,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1444,1,2,0)
 ;;=2^37236
 ;;^UTILITY(U,$J,358.3,1444,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent,Init Art
 ;;^UTILITY(U,$J,358.3,1445,0)
 ;;=37237^^14^132^56^^^^1
 ;;^UTILITY(U,$J,358.3,1445,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1445,1,2,0)
 ;;=2^37237
