IBDEI056 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2027,1,3,0)
 ;;=3^Perc Angioplasty,Venous
 ;;^UTILITY(U,$J,358.3,2028,0)
 ;;=37236^^12^163^58^^^^1
 ;;^UTILITY(U,$J,358.3,2028,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2028,1,2,0)
 ;;=2^37236
 ;;^UTILITY(U,$J,358.3,2028,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent,Init Art
 ;;^UTILITY(U,$J,358.3,2029,0)
 ;;=37237^^12^163^56^^^^1
 ;;^UTILITY(U,$J,358.3,2029,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2029,1,2,0)
 ;;=2^37237
 ;;^UTILITY(U,$J,358.3,2029,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,2030,0)
 ;;=37238^^12^163^55^^^^1
 ;;^UTILITY(U,$J,358.3,2030,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2030,1,2,0)
 ;;=2^37238
 ;;^UTILITY(U,$J,358.3,2030,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stent,Init Vein
 ;;^UTILITY(U,$J,358.3,2031,0)
 ;;=37239^^12^163^57^^^^1
 ;;^UTILITY(U,$J,358.3,2031,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2031,1,2,0)
 ;;=2^37239
 ;;^UTILITY(U,$J,358.3,2031,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Vein
 ;;^UTILITY(U,$J,358.3,2032,0)
 ;;=75978^^12^163^35^^^^1
 ;;^UTILITY(U,$J,358.3,2032,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2032,1,2,0)
 ;;=2^75978
 ;;^UTILITY(U,$J,358.3,2032,1,3,0)
 ;;=3^Repair Venous Blockage
 ;;^UTILITY(U,$J,358.3,2033,0)
 ;;=75894^^12^163^59^^^^1
 ;;^UTILITY(U,$J,358.3,2033,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2033,1,2,0)
 ;;=2^75894
 ;;^UTILITY(U,$J,358.3,2033,1,3,0)
 ;;=3^Transcath Rpr Iliac Art Aneur,AV,Rad S&I
 ;;^UTILITY(U,$J,358.3,2034,0)
 ;;=75962^^12^163^53^^^^1
 ;;^UTILITY(U,$J,358.3,2034,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2034,1,2,0)
 ;;=2^75962
 ;;^UTILITY(U,$J,358.3,2034,1,3,0)
 ;;=3^Tranlum Ball Angio,Venous Art,Rad S&I
 ;;^UTILITY(U,$J,358.3,2035,0)
 ;;=0237T^^12^163^60^^^^1
 ;;^UTILITY(U,$J,358.3,2035,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2035,1,2,0)
 ;;=2^0237T
 ;;^UTILITY(U,$J,358.3,2035,1,3,0)
 ;;=3^Trluml Perip Athrc Brchiocph
 ;;^UTILITY(U,$J,358.3,2036,0)
 ;;=0238T^^12^163^61^^^^1
 ;;^UTILITY(U,$J,358.3,2036,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2036,1,2,0)
 ;;=2^0238T
 ;;^UTILITY(U,$J,358.3,2036,1,3,0)
 ;;=3^Trluml Perip Athrc Iliac Art
 ;;^UTILITY(U,$J,358.3,2037,0)
 ;;=75820^^12^163^63^^^^1
 ;;^UTILITY(U,$J,358.3,2037,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2037,1,2,0)
 ;;=2^75820
 ;;^UTILITY(U,$J,358.3,2037,1,3,0)
 ;;=3^Vein X-Ray,Arm/Leg,Unilat
 ;;^UTILITY(U,$J,358.3,2038,0)
 ;;=75822^^12^163^64^^^^1
 ;;^UTILITY(U,$J,358.3,2038,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2038,1,2,0)
 ;;=2^75822
 ;;^UTILITY(U,$J,358.3,2038,1,3,0)
 ;;=3^Vein X-Ray,Arms/Legs,Bilat
 ;;^UTILITY(U,$J,358.3,2039,0)
 ;;=75827^^12^163^65^^^^1
 ;;^UTILITY(U,$J,358.3,2039,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2039,1,2,0)
 ;;=2^75827
 ;;^UTILITY(U,$J,358.3,2039,1,3,0)
 ;;=3^Vein X-Ray,Chest
 ;;^UTILITY(U,$J,358.3,2040,0)
 ;;=37252^^12^163^24^^^^1
 ;;^UTILITY(U,$J,358.3,2040,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2040,1,2,0)
 ;;=2^37252
 ;;^UTILITY(U,$J,358.3,2040,1,3,0)
 ;;=3^Intravas US,Non/Cor Vsl,Diag/Thera Interv,1st Vsl
 ;;^UTILITY(U,$J,358.3,2041,0)
 ;;=37253^^12^163^25^^^^1
 ;;^UTILITY(U,$J,358.3,2041,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2041,1,2,0)
 ;;=2^37253
 ;;^UTILITY(U,$J,358.3,2041,1,3,0)
 ;;=3^Intravas US,Non/Cor Vsl,Dx/Ther Interv,Ea Addl Vsl
 ;;^UTILITY(U,$J,358.3,2042,0)
 ;;=36005^^12^164^1^^^^1
 ;;^UTILITY(U,$J,358.3,2042,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2042,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,2042,1,3,0)
 ;;=3^Contrast Venography
 ;;^UTILITY(U,$J,358.3,2043,0)
 ;;=92950^^12^165^1^^^^1
