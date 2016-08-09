IBDEI02Q ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2286,1,2,0)
 ;;=2^33249
 ;;^UTILITY(U,$J,358.3,2286,1,3,0)
 ;;=3^Remove ICD Leads/Thoracotomy
 ;;^UTILITY(U,$J,358.3,2287,0)
 ;;=92992^^15^171^1^^^^1
 ;;^UTILITY(U,$J,358.3,2287,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2287,1,2,0)
 ;;=2^92992
 ;;^UTILITY(U,$J,358.3,2287,1,3,0)
 ;;=3^Atrial Septectomy Trans Balloon (Inc Cath)
 ;;^UTILITY(U,$J,358.3,2288,0)
 ;;=92993^^15^171^21^^^^1
 ;;^UTILITY(U,$J,358.3,2288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2288,1,2,0)
 ;;=2^92993
 ;;^UTILITY(U,$J,358.3,2288,1,3,0)
 ;;=3^Park Septostomy,Includes Cath
 ;;^UTILITY(U,$J,358.3,2289,0)
 ;;=92975^^15^171^27^^^^1
 ;;^UTILITY(U,$J,358.3,2289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2289,1,2,0)
 ;;=2^92975
 ;;^UTILITY(U,$J,358.3,2289,1,3,0)
 ;;=3^Thrombo Cor Includes Cor Angiog
 ;;^UTILITY(U,$J,358.3,2290,0)
 ;;=92977^^15^171^28^^^^1
 ;;^UTILITY(U,$J,358.3,2290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2290,1,2,0)
 ;;=2^92977
 ;;^UTILITY(U,$J,358.3,2290,1,3,0)
 ;;=3^Thrombo Cor,Inc Cor Angio Iv Inf
 ;;^UTILITY(U,$J,358.3,2291,0)
 ;;=92978^^15^171^6^^^^1
 ;;^UTILITY(U,$J,358.3,2291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2291,1,2,0)
 ;;=2^92978
 ;;^UTILITY(U,$J,358.3,2291,1,3,0)
 ;;=3^Intr Vasc U/S During Diag Eval
 ;;^UTILITY(U,$J,358.3,2292,0)
 ;;=92979^^15^171^7^^^^1
 ;;^UTILITY(U,$J,358.3,2292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2292,1,2,0)
 ;;=2^92979
 ;;^UTILITY(U,$J,358.3,2292,1,3,0)
 ;;=3^     Each Add'L Vessel (W/92978)
 ;;^UTILITY(U,$J,358.3,2293,0)
 ;;=36010^^15^171^4^^^^1
 ;;^UTILITY(U,$J,358.3,2293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2293,1,2,0)
 ;;=2^36010
 ;;^UTILITY(U,$J,358.3,2293,1,3,0)
 ;;=3^Cath Place Svc/Ivc (Sheath)
 ;;^UTILITY(U,$J,358.3,2294,0)
 ;;=36011^^15^171^5^^^^1
 ;;^UTILITY(U,$J,358.3,2294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2294,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,2294,1,3,0)
 ;;=3^Cath Place Vein 1St Order(Sheath
 ;;^UTILITY(U,$J,358.3,2295,0)
 ;;=76930^^15^171^29^^^^1
 ;;^UTILITY(U,$J,358.3,2295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2295,1,2,0)
 ;;=2^76930
 ;;^UTILITY(U,$J,358.3,2295,1,3,0)
 ;;=3^U/S Guide (W/33010)
 ;;^UTILITY(U,$J,358.3,2296,0)
 ;;=76000^^15^171^2^^^^1
 ;;^UTILITY(U,$J,358.3,2296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2296,1,2,0)
 ;;=2^76000
 ;;^UTILITY(U,$J,358.3,2296,1,3,0)
 ;;=3^Cardiac Fluoro<1Hr(No Cath Proc)
 ;;^UTILITY(U,$J,358.3,2297,0)
 ;;=92973^^15^171^22^^^^1
 ;;^UTILITY(U,$J,358.3,2297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2297,1,2,0)
 ;;=2^92973
 ;;^UTILITY(U,$J,358.3,2297,1,3,0)
 ;;=3^Perc Coronary Thrombectomy Mechanical
 ;;^UTILITY(U,$J,358.3,2298,0)
 ;;=92974^^15^171^3^^^^1
 ;;^UTILITY(U,$J,358.3,2298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2298,1,2,0)
 ;;=2^92974
 ;;^UTILITY(U,$J,358.3,2298,1,3,0)
 ;;=3^Cath Place Cardio Brachytx
 ;;^UTILITY(U,$J,358.3,2299,0)
 ;;=92920^^15^171^17^^^^1
 ;;^UTILITY(U,$J,358.3,2299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2299,1,2,0)
 ;;=2^92920
 ;;^UTILITY(U,$J,358.3,2299,1,3,0)
 ;;=3^PRQ Cardia Angioplast 1 Art
 ;;^UTILITY(U,$J,358.3,2300,0)
 ;;=92921^^15^171^18^^^^1
 ;;^UTILITY(U,$J,358.3,2300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2300,1,2,0)
 ;;=2^92921
 ;;^UTILITY(U,$J,358.3,2300,1,3,0)
 ;;=3^PRQ Cardiac Angio Addl Art
 ;;^UTILITY(U,$J,358.3,2301,0)
 ;;=92924^^15^171^8^^^^1
 ;;^UTILITY(U,$J,358.3,2301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2301,1,2,0)
 ;;=2^92924
 ;;^UTILITY(U,$J,358.3,2301,1,3,0)
 ;;=3^PRQ Card Angio/Athrect 1 Art
 ;;^UTILITY(U,$J,358.3,2302,0)
 ;;=92925^^15^171^9^^^^1
 ;;^UTILITY(U,$J,358.3,2302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2302,1,2,0)
 ;;=2^92925
 ;;^UTILITY(U,$J,358.3,2302,1,3,0)
 ;;=3^PRQ Card Angio/Athrect Addl Art
 ;;^UTILITY(U,$J,358.3,2303,0)
 ;;=92928^^15^171^15^^^^1
 ;;^UTILITY(U,$J,358.3,2303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2303,1,2,0)
 ;;=2^92928
 ;;^UTILITY(U,$J,358.3,2303,1,3,0)
 ;;=3^PRQ Card Stent w/ Angio 1 Vsl
 ;;^UTILITY(U,$J,358.3,2304,0)
 ;;=92929^^15^171^16^^^^1
 ;;^UTILITY(U,$J,358.3,2304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2304,1,2,0)
 ;;=2^92929
 ;;^UTILITY(U,$J,358.3,2304,1,3,0)
 ;;=3^PRQ Card Stent w/ Angio Addl Vsl
 ;;^UTILITY(U,$J,358.3,2305,0)
 ;;=92933^^15^171^13^^^^1
 ;;^UTILITY(U,$J,358.3,2305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2305,1,2,0)
 ;;=2^92933
 ;;^UTILITY(U,$J,358.3,2305,1,3,0)
 ;;=3^PRQ Card Stent Ath/Angio
 ;;^UTILITY(U,$J,358.3,2306,0)
 ;;=92934^^15^171^14^^^^1
 ;;^UTILITY(U,$J,358.3,2306,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2306,1,2,0)
 ;;=2^92934
 ;;^UTILITY(U,$J,358.3,2306,1,3,0)
 ;;=3^PRQ Card Stent Ath/Angio Ea Addl Branch
 ;;^UTILITY(U,$J,358.3,2307,0)
 ;;=92937^^15^171^19^^^^1
 ;;^UTILITY(U,$J,358.3,2307,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2307,1,2,0)
 ;;=2^92937
 ;;^UTILITY(U,$J,358.3,2307,1,3,0)
 ;;=3^PRQ Revasc Byp Graft 1 Vsl
 ;;^UTILITY(U,$J,358.3,2308,0)
 ;;=92938^^15^171^20^^^^1
 ;;^UTILITY(U,$J,358.3,2308,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2308,1,2,0)
 ;;=2^92938
 ;;^UTILITY(U,$J,358.3,2308,1,3,0)
 ;;=3^PRQ Revasc Byp Graft Addl Vsl
 ;;^UTILITY(U,$J,358.3,2309,0)
 ;;=92941^^15^171^12^^^^1
 ;;^UTILITY(U,$J,358.3,2309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2309,1,2,0)
 ;;=2^92941
 ;;^UTILITY(U,$J,358.3,2309,1,3,0)
 ;;=3^PRQ Card Revasc MI 1 Vsl
 ;;^UTILITY(U,$J,358.3,2310,0)
 ;;=92943^^15^171^10^^^^1
 ;;^UTILITY(U,$J,358.3,2310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2310,1,2,0)
 ;;=2^92943
 ;;^UTILITY(U,$J,358.3,2310,1,3,0)
 ;;=3^PRQ Card Revasc Chronic 1 Vsl
 ;;^UTILITY(U,$J,358.3,2311,0)
 ;;=92944^^15^171^11^^^^1
 ;;^UTILITY(U,$J,358.3,2311,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2311,1,2,0)
 ;;=2^92944
 ;;^UTILITY(U,$J,358.3,2311,1,3,0)
 ;;=3^PRQ Card Revasc Chronic Addl Vsl
 ;;^UTILITY(U,$J,358.3,2312,0)
 ;;=C1874^^15^171^23^^^^1
 ;;^UTILITY(U,$J,358.3,2312,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2312,1,2,0)
 ;;=2^C1874
 ;;^UTILITY(U,$J,358.3,2312,1,3,0)
 ;;=3^Stent,Coated/Cov w/ Del Syst
 ;;^UTILITY(U,$J,358.3,2313,0)
 ;;=C1875^^15^171^24^^^^1
 ;;^UTILITY(U,$J,358.3,2313,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2313,1,2,0)
 ;;=2^C1875
 ;;^UTILITY(U,$J,358.3,2313,1,3,0)
 ;;=3^Stent,Coated/Cov w/o Del Syst
 ;;^UTILITY(U,$J,358.3,2314,0)
 ;;=C1876^^15^171^25^^^^1
 ;;^UTILITY(U,$J,358.3,2314,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2314,1,2,0)
 ;;=2^C1876
 ;;^UTILITY(U,$J,358.3,2314,1,3,0)
 ;;=3^Stent,Non-Coated/Cov w/ Del Syst
 ;;^UTILITY(U,$J,358.3,2315,0)
 ;;=C1877^^15^171^26^^^^1
 ;;^UTILITY(U,$J,358.3,2315,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2315,1,2,0)
 ;;=2^C1877
 ;;^UTILITY(U,$J,358.3,2315,1,3,0)
 ;;=3^Stent,Non-Coated/Cov w/o Del Syst
 ;;^UTILITY(U,$J,358.3,2316,0)
 ;;=93600^^15^172^3^^^^1
 ;;^UTILITY(U,$J,358.3,2316,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2316,1,2,0)
 ;;=2^93600
 ;;^UTILITY(U,$J,358.3,2316,1,3,0)
 ;;=3^Bundle Of His Record
 ;;^UTILITY(U,$J,358.3,2317,0)
 ;;=93602^^15^172^21^^^^1
 ;;^UTILITY(U,$J,358.3,2317,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2317,1,2,0)
 ;;=2^93602
 ;;^UTILITY(U,$J,358.3,2317,1,3,0)
 ;;=3^Intra-Atrial Record
 ;;^UTILITY(U,$J,358.3,2318,0)
 ;;=93603^^15^172^26^^^^1
 ;;^UTILITY(U,$J,358.3,2318,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2318,1,2,0)
 ;;=2^93603
 ;;^UTILITY(U,$J,358.3,2318,1,3,0)
 ;;=3^R Vent Record
 ;;^UTILITY(U,$J,358.3,2319,0)
 ;;=93609^^15^172^24^^^^1
 ;;^UTILITY(U,$J,358.3,2319,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2319,1,2,0)
 ;;=2^93609
 ;;^UTILITY(U,$J,358.3,2319,1,3,0)
 ;;=3^Mapping Of Tachycardia
 ;;^UTILITY(U,$J,358.3,2320,0)
 ;;=93610^^15^172^20^^^^1
 ;;^UTILITY(U,$J,358.3,2320,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2320,1,2,0)
 ;;=2^93610
 ;;^UTILITY(U,$J,358.3,2320,1,3,0)
 ;;=3^Intra-Atrial Pacing
