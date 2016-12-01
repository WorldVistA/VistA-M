IBDEI01W ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1966,1,3,0)
 ;;=3^Place Cath Xtrnl Carotid
 ;;^UTILITY(U,$J,358.3,1967,0)
 ;;=36228^^9^139^19^^^^1
 ;;^UTILITY(U,$J,358.3,1967,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1967,1,2,0)
 ;;=2^36228
 ;;^UTILITY(U,$J,358.3,1967,1,3,0)
 ;;=3^Place Cath Intracranial Art
 ;;^UTILITY(U,$J,358.3,1968,0)
 ;;=36221^^9^139^21^^^^1
 ;;^UTILITY(U,$J,358.3,1968,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1968,1,2,0)
 ;;=2^36221
 ;;^UTILITY(U,$J,358.3,1968,1,3,0)
 ;;=3^Place Cath Thoracic Aorta
 ;;^UTILITY(U,$J,358.3,1969,0)
 ;;=37197^^9^139^30^^^^1
 ;;^UTILITY(U,$J,358.3,1969,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1969,1,2,0)
 ;;=2^37197
 ;;^UTILITY(U,$J,358.3,1969,1,3,0)
 ;;=3^Remove Intrvas Foreign Body,Broken Cath
 ;;^UTILITY(U,$J,358.3,1970,0)
 ;;=36000^^9^139^25^^^^1
 ;;^UTILITY(U,$J,358.3,1970,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1970,1,2,0)
 ;;=2^36000
 ;;^UTILITY(U,$J,358.3,1970,1,3,0)
 ;;=3^Placement of Needle in Vein
 ;;^UTILITY(U,$J,358.3,1971,0)
 ;;=36010^^9^139^24^^^^1
 ;;^UTILITY(U,$J,358.3,1971,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1971,1,2,0)
 ;;=2^36010
 ;;^UTILITY(U,$J,358.3,1971,1,3,0)
 ;;=3^Placement of Cath in Vein
 ;;^UTILITY(U,$J,358.3,1972,0)
 ;;=37187^^9^139^14^^^^1
 ;;^UTILITY(U,$J,358.3,1972,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1972,1,2,0)
 ;;=2^37187
 ;;^UTILITY(U,$J,358.3,1972,1,3,0)
 ;;=3^PTCA Thrombectomy,Vein(s)
 ;;^UTILITY(U,$J,358.3,1973,0)
 ;;=37236^^9^139^52^^^^1
 ;;^UTILITY(U,$J,358.3,1973,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1973,1,2,0)
 ;;=2^37236
 ;;^UTILITY(U,$J,358.3,1973,1,3,0)
 ;;=3^Transcath Plcmt of Intravas Stent,Init Art
 ;;^UTILITY(U,$J,358.3,1974,0)
 ;;=37237^^9^139^51^^^^1
 ;;^UTILITY(U,$J,358.3,1974,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1974,1,2,0)
 ;;=2^37237
 ;;^UTILITY(U,$J,358.3,1974,1,3,0)
 ;;=3^Transcath Plcmt Intravas Stnt,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,1975,0)
 ;;=37214^^9^139^3^^^^1
 ;;^UTILITY(U,$J,358.3,1975,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1975,1,2,0)
 ;;=2^37214
 ;;^UTILITY(U,$J,358.3,1975,1,3,0)
 ;;=3^Cessj Therapy Cath Removal
 ;;^UTILITY(U,$J,358.3,1976,0)
 ;;=37184^^9^139^26^^^^1
 ;;^UTILITY(U,$J,358.3,1976,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1976,1,2,0)
 ;;=2^37184
 ;;^UTILITY(U,$J,358.3,1976,1,3,0)
 ;;=3^Prim Art Mech Thrombectomy
 ;;^UTILITY(U,$J,358.3,1977,0)
 ;;=37185^^9^139^27^^^^1
 ;;^UTILITY(U,$J,358.3,1977,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1977,1,2,0)
 ;;=2^37185
 ;;^UTILITY(U,$J,358.3,1977,1,3,0)
 ;;=3^Prim Art Mech Thrombectomy,Add-On
 ;;^UTILITY(U,$J,358.3,1978,0)
 ;;=36002^^9^139^28^^^^1
 ;;^UTILITY(U,$J,358.3,1978,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1978,1,2,0)
 ;;=2^36002
 ;;^UTILITY(U,$J,358.3,1978,1,3,0)
 ;;=3^Pseudoaneurysm Injection Trt
 ;;^UTILITY(U,$J,358.3,1979,0)
 ;;=33011^^9^139^32^^^^1
 ;;^UTILITY(U,$J,358.3,1979,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1979,1,2,0)
 ;;=2^33011
 ;;^UTILITY(U,$J,358.3,1979,1,3,0)
 ;;=3^Repeat Drainage of Heart Sac
 ;;^UTILITY(U,$J,358.3,1980,0)
 ;;=37193^^9^139^29^^^^1
 ;;^UTILITY(U,$J,358.3,1980,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1980,1,2,0)
 ;;=2^37193
 ;;^UTILITY(U,$J,358.3,1980,1,3,0)
 ;;=3^Remove Endovas Vena Cava Filter
 ;;^UTILITY(U,$J,358.3,1981,0)
 ;;=37212^^9^139^43^^^^1
 ;;^UTILITY(U,$J,358.3,1981,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1981,1,2,0)
 ;;=2^37212
 ;;^UTILITY(U,$J,358.3,1981,1,3,0)
 ;;=3^Thrombolytic Venous Therapy
 ;;^UTILITY(U,$J,358.3,1982,0)
 ;;=37213^^9^139^42^^^^1
 ;;^UTILITY(U,$J,358.3,1982,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1982,1,2,0)
 ;;=2^37213
 ;;^UTILITY(U,$J,358.3,1982,1,3,0)
 ;;=3^Thrombolytic Art/Ven Therapy
 ;;^UTILITY(U,$J,358.3,1983,0)
 ;;=37229^^9^139^44^^^^1
 ;;^UTILITY(U,$J,358.3,1983,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1983,1,2,0)
 ;;=2^37229
 ;;^UTILITY(U,$J,358.3,1983,1,3,0)
 ;;=3^Tib/Per Revasc w/ Ather
 ;;^UTILITY(U,$J,358.3,1984,0)
 ;;=37230^^9^139^46^^^^1
 ;;^UTILITY(U,$J,358.3,1984,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1984,1,2,0)
 ;;=2^37230
 ;;^UTILITY(U,$J,358.3,1984,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent
 ;;^UTILITY(U,$J,358.3,1985,0)
 ;;=37231^^9^139^47^^^^1
 ;;^UTILITY(U,$J,358.3,1985,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1985,1,2,0)
 ;;=2^37231
 ;;^UTILITY(U,$J,358.3,1985,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent & Ather
 ;;^UTILITY(U,$J,358.3,1986,0)
 ;;=37232^^9^139^50^^^^1
 ;;^UTILITY(U,$J,358.3,1986,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1986,1,2,0)
 ;;=2^37232
 ;;^UTILITY(U,$J,358.3,1986,1,3,0)
 ;;=3^Tib/Per Revasc,Add-on
 ;;^UTILITY(U,$J,358.3,1987,0)
 ;;=37233^^9^139^45^^^^1
 ;;^UTILITY(U,$J,358.3,1987,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1987,1,2,0)
 ;;=2^37233
 ;;^UTILITY(U,$J,358.3,1987,1,3,0)
 ;;=3^Tib/Per Revasc w/ Ather,Add-On
 ;;^UTILITY(U,$J,358.3,1988,0)
 ;;=37234^^9^139^49^^^^1
 ;;^UTILITY(U,$J,358.3,1988,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1988,1,2,0)
 ;;=2^37234
 ;;^UTILITY(U,$J,358.3,1988,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent,Add-On
 ;;^UTILITY(U,$J,358.3,1989,0)
 ;;=37235^^9^139^48^^^^1
 ;;^UTILITY(U,$J,358.3,1989,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1989,1,2,0)
 ;;=2^37235
 ;;^UTILITY(U,$J,358.3,1989,1,3,0)
 ;;=3^Tib/Per Revasc w/ Stent & Ather,Add-On
 ;;^UTILITY(U,$J,358.3,1990,0)
 ;;=37215^^9^139^53^^^^1
 ;;^UTILITY(U,$J,358.3,1990,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1990,1,2,0)
 ;;=2^37215
 ;;^UTILITY(U,$J,358.3,1990,1,3,0)
 ;;=3^Transcath Stent CCA w/ EPS
 ;;^UTILITY(U,$J,358.3,1991,0)
 ;;=37216^^9^139^54^^^^1
 ;;^UTILITY(U,$J,358.3,1991,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1991,1,2,0)
 ;;=2^37216
 ;;^UTILITY(U,$J,358.3,1991,1,3,0)
 ;;=3^Transcath Stent CCA w/o EPS
 ;;^UTILITY(U,$J,358.3,1992,0)
 ;;=37188^^9^139^55^^^^1
 ;;^UTILITY(U,$J,358.3,1992,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1992,1,2,0)
 ;;=2^37188
 ;;^UTILITY(U,$J,358.3,1992,1,3,0)
 ;;=3^Venous Mech Thrombectomy,Add-On
 ;;^UTILITY(U,$J,358.3,1993,0)
 ;;=93561^^9^140^15^^^^1
 ;;^UTILITY(U,$J,358.3,1993,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1993,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,1993,1,3,0)
 ;;=3^Thermal Dilution Study W/Cardiac Output
 ;;^UTILITY(U,$J,358.3,1994,0)
 ;;=93571^^9^140^10^^^^1
 ;;^UTILITY(U,$J,358.3,1994,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1994,1,2,0)
 ;;=2^93571
 ;;^UTILITY(U,$J,358.3,1994,1,3,0)
 ;;=3^Intravascular Dopplar Add-On, First Vessel
 ;;^UTILITY(U,$J,358.3,1995,0)
 ;;=93572^^9^140^11^^^^1
 ;;^UTILITY(U,$J,358.3,1995,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1995,1,2,0)
 ;;=2^93572
 ;;^UTILITY(U,$J,358.3,1995,1,3,0)
 ;;=3^Intravascular Dopplar, Each Addl Vessel
 ;;^UTILITY(U,$J,358.3,1996,0)
 ;;=93740^^9^140^14^^^^1
 ;;^UTILITY(U,$J,358.3,1996,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1996,1,2,0)
 ;;=2^93740
 ;;^UTILITY(U,$J,358.3,1996,1,3,0)
 ;;=3^Temperature Gradient Studies
 ;;^UTILITY(U,$J,358.3,1997,0)
 ;;=93784^^9^140^2^^^^1
 ;;^UTILITY(U,$J,358.3,1997,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1997,1,2,0)
 ;;=2^93784
 ;;^UTILITY(U,$J,358.3,1997,1,3,0)
 ;;=3^Amb BP Monitor 24+ hrs,Int&Rpt
 ;;^UTILITY(U,$J,358.3,1998,0)
 ;;=93786^^9^140^3^^^^1
 ;;^UTILITY(U,$J,358.3,1998,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1998,1,2,0)
 ;;=2^93786
 ;;^UTILITY(U,$J,358.3,1998,1,3,0)
 ;;=3^Amb BP Monitor 24+ hrs,Record Only
 ;;^UTILITY(U,$J,358.3,1999,0)
 ;;=93788^^9^140^1^^^^1
 ;;^UTILITY(U,$J,358.3,1999,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1999,1,2,0)
 ;;=2^93788
 ;;^UTILITY(U,$J,358.3,1999,1,3,0)
 ;;=3^Amb BP Analysis & Rpt
 ;;^UTILITY(U,$J,358.3,2000,0)
 ;;=93790^^9^140^4^^^^1
 ;;^UTILITY(U,$J,358.3,2000,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2000,1,2,0)
 ;;=2^93790
 ;;^UTILITY(U,$J,358.3,2000,1,3,0)
 ;;=3^Amb BP Review w/ Int&Rpt
 ;;^UTILITY(U,$J,358.3,2001,0)
 ;;=34800^^9^141^1^^^^1
 ;;^UTILITY(U,$J,358.3,2001,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2001,1,2,0)
 ;;=2^34800
 ;;^UTILITY(U,$J,358.3,2001,1,3,0)
 ;;=3^Endovasc Abd Repair,Infrarenal AAA w/Tube
 ;;^UTILITY(U,$J,358.3,2002,0)
 ;;=34802^^9^141^2^^^^1
 ;;^UTILITY(U,$J,358.3,2002,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2002,1,2,0)
 ;;=2^34802
 ;;^UTILITY(U,$J,358.3,2002,1,3,0)
 ;;=3^Endovasc Abd Repr,Infrarenal AAA w/Bifurc,1 Dock Limb
 ;;^UTILITY(U,$J,358.3,2003,0)
 ;;=34803^^9^141^3^^^^1
 ;;^UTILITY(U,$J,358.3,2003,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2003,1,2,0)
 ;;=2^34803
 ;;^UTILITY(U,$J,358.3,2003,1,3,0)
 ;;=3^Endovasc Abd Repr,Infrarenal AAA w/Bifurc,2 Dock Limbs
 ;;^UTILITY(U,$J,358.3,2004,0)
 ;;=93279^^9^142^10^^^^1
 ;;^UTILITY(U,$J,358.3,2004,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2004,1,2,0)
 ;;=2^93279
 ;;^UTILITY(U,$J,358.3,2004,1,3,0)
 ;;=3^PM DEVICE PROGR EVAL W/ ADJSMT,SNGL
 ;;^UTILITY(U,$J,358.3,2005,0)
 ;;=93280^^9^142^8^^^^1
 ;;^UTILITY(U,$J,358.3,2005,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2005,1,2,0)
 ;;=2^93280
 ;;^UTILITY(U,$J,358.3,2005,1,3,0)
 ;;=3^PM DEVICE PROGR EVAL W/ ADJSMT,DUAL
 ;;^UTILITY(U,$J,358.3,2006,0)
 ;;=93281^^9^142^9^^^^1
 ;;^UTILITY(U,$J,358.3,2006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2006,1,2,0)
 ;;=2^93281
 ;;^UTILITY(U,$J,358.3,2006,1,3,0)
 ;;=3^PM DEVICE PROGR EVAL W/ ADJSMT,MULTI
 ;;^UTILITY(U,$J,358.3,2007,0)
 ;;=93282^^9^142^3^^^^1
 ;;^UTILITY(U,$J,358.3,2007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2007,1,2,0)
 ;;=2^93282
 ;;^UTILITY(U,$J,358.3,2007,1,3,0)
 ;;=3^ICD DEVICE PROGR EVAL W/ ADJSMT,1 SNGL
 ;;^UTILITY(U,$J,358.3,2008,0)
 ;;=93283^^9^142^4^^^^1
 ;;^UTILITY(U,$J,358.3,2008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2008,1,2,0)
 ;;=2^93283
 ;;^UTILITY(U,$J,358.3,2008,1,3,0)
 ;;=3^ICD DEVICE PROGR EVAL W/ ADJSMT,DUAL
 ;;^UTILITY(U,$J,358.3,2009,0)
 ;;=93284^^9^142^5^^^^1
 ;;^UTILITY(U,$J,358.3,2009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2009,1,2,0)
 ;;=2^93284
