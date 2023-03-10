IBDEI015 ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2254,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2254,1,1,0)
 ;;=1^Low Complex MDM or 30-44 min
 ;;^UTILITY(U,$J,358.3,2254,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,2255,0)
 ;;=99204^^19^145^3
 ;;^UTILITY(U,$J,358.3,2255,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2255,1,1,0)
 ;;=1^Mod Complex MDM or 45-59 min
 ;;^UTILITY(U,$J,358.3,2255,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,2256,0)
 ;;=99205^^19^145^5
 ;;^UTILITY(U,$J,358.3,2256,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2256,1,1,0)
 ;;=1^High Complex MDM or 60-74 min
 ;;^UTILITY(U,$J,358.3,2256,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,2257,0)
 ;;=99211^^19^146^1
 ;;^UTILITY(U,$J,358.3,2257,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2257,1,1,0)
 ;;=1^Brief (no MD seen)
 ;;^UTILITY(U,$J,358.3,2257,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,2258,0)
 ;;=99212^^19^146^2
 ;;^UTILITY(U,$J,358.3,2258,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2258,1,1,0)
 ;;=1^SF MDM or 10-19 min
 ;;^UTILITY(U,$J,358.3,2258,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,2259,0)
 ;;=99213^^19^146^3
 ;;^UTILITY(U,$J,358.3,2259,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2259,1,1,0)
 ;;=1^Low Complex MDM or 20-29 min
 ;;^UTILITY(U,$J,358.3,2259,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,2260,0)
 ;;=99214^^19^146^4
 ;;^UTILITY(U,$J,358.3,2260,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2260,1,1,0)
 ;;=1^Mod Complex MDM or 30-39 min
 ;;^UTILITY(U,$J,358.3,2260,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,2261,0)
 ;;=99215^^19^146^5
 ;;^UTILITY(U,$J,358.3,2261,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2261,1,1,0)
 ;;=1^High Complex MDM or 40-54 min
 ;;^UTILITY(U,$J,358.3,2261,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,2262,0)
 ;;=99241^^19^147^1
 ;;^UTILITY(U,$J,358.3,2262,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2262,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,2262,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,2263,0)
 ;;=99242^^19^147^2
 ;;^UTILITY(U,$J,358.3,2263,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2263,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,2263,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,2264,0)
 ;;=99243^^19^147^3
 ;;^UTILITY(U,$J,358.3,2264,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2264,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,2264,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,2265,0)
 ;;=99244^^19^147^4
 ;;^UTILITY(U,$J,358.3,2265,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2265,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,2265,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,2266,0)
 ;;=99245^^19^147^5
 ;;^UTILITY(U,$J,358.3,2266,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,2266,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,2266,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,2267,0)
 ;;=I44.2^^20^148^3
 ;;^UTILITY(U,$J,358.3,2267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2267,1,3,0)
 ;;=3^AV Block,Complete
 ;;^UTILITY(U,$J,358.3,2267,1,4,0)
 ;;=4^I44.2
 ;;^UTILITY(U,$J,358.3,2267,2)
 ;;=^259621
 ;;^UTILITY(U,$J,358.3,2268,0)
 ;;=I44.30^^20^148^4
 ;;^UTILITY(U,$J,358.3,2268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2268,1,3,0)
 ;;=3^AV Block,Unspec
 ;;^UTILITY(U,$J,358.3,2268,1,4,0)
 ;;=4^I44.30
 ;;^UTILITY(U,$J,358.3,2268,2)
 ;;=^5007204
 ;;^UTILITY(U,$J,358.3,2269,0)
 ;;=I44.0^^20^148^1
 ;;^UTILITY(U,$J,358.3,2269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2269,1,3,0)
 ;;=3^AV Block,1st Degree
 ;;^UTILITY(U,$J,358.3,2269,1,4,0)
 ;;=4^I44.0
 ;;^UTILITY(U,$J,358.3,2269,2)
 ;;=^5007202
 ;;^UTILITY(U,$J,358.3,2270,0)
 ;;=I44.1^^20^148^2
 ;;^UTILITY(U,$J,358.3,2270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2270,1,3,0)
 ;;=3^AV Block,2nd Degree
 ;;^UTILITY(U,$J,358.3,2270,1,4,0)
 ;;=4^I44.1
 ;;^UTILITY(U,$J,358.3,2270,2)
 ;;=^5007203
 ;;^UTILITY(U,$J,358.3,2271,0)
 ;;=I44.5^^20^148^32
 ;;^UTILITY(U,$J,358.3,2271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2271,1,3,0)
 ;;=3^Left Posterior Fascicular Block
 ;;^UTILITY(U,$J,358.3,2271,1,4,0)
 ;;=4^I44.5
 ;;^UTILITY(U,$J,358.3,2271,2)
 ;;=^5007207
 ;;^UTILITY(U,$J,358.3,2272,0)
 ;;=I44.60^^20^148^28
 ;;^UTILITY(U,$J,358.3,2272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2272,1,3,0)
 ;;=3^Fascicular Block,Unspec
 ;;^UTILITY(U,$J,358.3,2272,1,4,0)
 ;;=4^I44.60
 ;;^UTILITY(U,$J,358.3,2272,2)
 ;;=^5007208
 ;;^UTILITY(U,$J,358.3,2273,0)
 ;;=I44.69^^20^148^27
 ;;^UTILITY(U,$J,358.3,2273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2273,1,3,0)
 ;;=3^Fascicular Block NEC
 ;;^UTILITY(U,$J,358.3,2273,1,4,0)
 ;;=4^I44.69
 ;;^UTILITY(U,$J,358.3,2273,2)
 ;;=^5007209
 ;;^UTILITY(U,$J,358.3,2274,0)
 ;;=I44.4^^20^148^30
 ;;^UTILITY(U,$J,358.3,2274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2274,1,3,0)
 ;;=3^Left Anterior Fascicular Block
 ;;^UTILITY(U,$J,358.3,2274,1,4,0)
 ;;=4^I44.4
 ;;^UTILITY(U,$J,358.3,2274,2)
 ;;=^5007206
 ;;^UTILITY(U,$J,358.3,2275,0)
 ;;=I44.7^^20^148^31
 ;;^UTILITY(U,$J,358.3,2275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2275,1,3,0)
 ;;=3^Left Bundle-Branch Block,Unspec
 ;;^UTILITY(U,$J,358.3,2275,1,4,0)
 ;;=4^I44.7
 ;;^UTILITY(U,$J,358.3,2275,2)
 ;;=^5007210
 ;;^UTILITY(U,$J,358.3,2276,0)
 ;;=I45.0^^20^148^46
 ;;^UTILITY(U,$J,358.3,2276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2276,1,3,0)
 ;;=3^Right Fascicular Block
 ;;^UTILITY(U,$J,358.3,2276,1,4,0)
 ;;=4^I45.0
 ;;^UTILITY(U,$J,358.3,2276,2)
 ;;=^5007211
 ;;^UTILITY(U,$J,358.3,2277,0)
 ;;=I45.19^^20^148^44
 ;;^UTILITY(U,$J,358.3,2277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2277,1,3,0)
 ;;=3^Right Bundle-Branch Block NEC
 ;;^UTILITY(U,$J,358.3,2277,1,4,0)
 ;;=4^I45.19
 ;;^UTILITY(U,$J,358.3,2277,2)
 ;;=^5007213
 ;;^UTILITY(U,$J,358.3,2278,0)
 ;;=I45.10^^20^148^45
 ;;^UTILITY(U,$J,358.3,2278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2278,1,3,0)
 ;;=3^Right Bundle-Branch Block,Unspec
 ;;^UTILITY(U,$J,358.3,2278,1,4,0)
 ;;=4^I45.10
 ;;^UTILITY(U,$J,358.3,2278,2)
 ;;=^5007212
 ;;^UTILITY(U,$J,358.3,2279,0)
 ;;=I45.2^^20^148^14
 ;;^UTILITY(U,$J,358.3,2279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2279,1,3,0)
 ;;=3^Bifascicular Block
 ;;^UTILITY(U,$J,358.3,2279,1,4,0)
 ;;=4^I45.2
 ;;^UTILITY(U,$J,358.3,2279,2)
 ;;=^5007214
 ;;^UTILITY(U,$J,358.3,2280,0)
 ;;=I45.3^^20^148^49
 ;;^UTILITY(U,$J,358.3,2280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2280,1,3,0)
 ;;=3^Trifascicular Block
 ;;^UTILITY(U,$J,358.3,2280,1,4,0)
 ;;=4^I45.3
 ;;^UTILITY(U,$J,358.3,2280,2)
 ;;=^269726
 ;;^UTILITY(U,$J,358.3,2281,0)
 ;;=I45.5^^20^148^29
 ;;^UTILITY(U,$J,358.3,2281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2281,1,3,0)
 ;;=3^Heart Block,Oth Specified
 ;;^UTILITY(U,$J,358.3,2281,1,4,0)
 ;;=4^I45.5
 ;;^UTILITY(U,$J,358.3,2281,2)
 ;;=^5007216
 ;;^UTILITY(U,$J,358.3,2282,0)
 ;;=I45.6^^20^148^38
 ;;^UTILITY(U,$J,358.3,2282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2282,1,3,0)
 ;;=3^Pre-Excitation Syndrome
 ;;^UTILITY(U,$J,358.3,2282,1,4,0)
 ;;=4^I45.6
 ;;^UTILITY(U,$J,358.3,2282,2)
 ;;=^5007217
 ;;^UTILITY(U,$J,358.3,2283,0)
 ;;=I45.81^^20^148^33
 ;;^UTILITY(U,$J,358.3,2283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2283,1,3,0)
 ;;=3^Long QT Syndrome
 ;;^UTILITY(U,$J,358.3,2283,1,4,0)
 ;;=4^I45.81
 ;;^UTILITY(U,$J,358.3,2283,2)
 ;;=^71760
 ;;^UTILITY(U,$J,358.3,2284,0)
 ;;=I45.9^^20^148^24
 ;;^UTILITY(U,$J,358.3,2284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2284,1,3,0)
 ;;=3^Conduction Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2284,1,4,0)
 ;;=4^I45.9
 ;;^UTILITY(U,$J,358.3,2284,2)
 ;;=^5007218
 ;;^UTILITY(U,$J,358.3,2285,0)
 ;;=I47.1^^20^148^48
 ;;^UTILITY(U,$J,358.3,2285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2285,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,2285,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,2285,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,2286,0)
 ;;=I49.3^^20^148^52
 ;;^UTILITY(U,$J,358.3,2286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2286,1,3,0)
 ;;=3^Ventricular Premature Depolarization
 ;;^UTILITY(U,$J,358.3,2286,1,4,0)
 ;;=4^I49.3
 ;;^UTILITY(U,$J,358.3,2286,2)
 ;;=^5007233
 ;;^UTILITY(U,$J,358.3,2287,0)
 ;;=I47.0^^20^148^43
 ;;^UTILITY(U,$J,358.3,2287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2287,1,3,0)
 ;;=3^Re-entry Ventricular Arrhythmia
 ;;^UTILITY(U,$J,358.3,2287,1,4,0)
 ;;=4^I47.0
 ;;^UTILITY(U,$J,358.3,2287,2)
 ;;=^5007222
 ;;^UTILITY(U,$J,358.3,2288,0)
 ;;=I47.2^^20^148^53
 ;;^UTILITY(U,$J,358.3,2288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2288,1,3,0)
 ;;=3^Ventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,2288,1,4,0)
 ;;=4^I47.2
 ;;^UTILITY(U,$J,358.3,2288,2)
 ;;=^125976
 ;;^UTILITY(U,$J,358.3,2289,0)
 ;;=I47.9^^20^148^37
 ;;^UTILITY(U,$J,358.3,2289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2289,1,3,0)
 ;;=3^Paroxysmal Tachycardia,Unspec
 ;;^UTILITY(U,$J,358.3,2289,1,4,0)
 ;;=4^I47.9
 ;;^UTILITY(U,$J,358.3,2289,2)
 ;;=^5007224
 ;;^UTILITY(U,$J,358.3,2290,0)
 ;;=I48.0^^20^148^36
 ;;^UTILITY(U,$J,358.3,2290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2290,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,2290,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,2290,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,2291,0)
 ;;=I49.01^^20^148^50
 ;;^UTILITY(U,$J,358.3,2291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2291,1,3,0)
 ;;=3^Ventricular Fibrillation
 ;;^UTILITY(U,$J,358.3,2291,1,4,0)
 ;;=4^I49.01
 ;;^UTILITY(U,$J,358.3,2291,2)
 ;;=^125951
 ;;^UTILITY(U,$J,358.3,2292,0)
 ;;=I49.02^^20^148^51
 ;;^UTILITY(U,$J,358.3,2292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2292,1,3,0)
 ;;=3^Ventricular Flutter
 ;;^UTILITY(U,$J,358.3,2292,1,4,0)
 ;;=4^I49.02
 ;;^UTILITY(U,$J,358.3,2292,2)
 ;;=^265315
 ;;^UTILITY(U,$J,358.3,2293,0)
 ;;=I46.9^^20^148^20
 ;;^UTILITY(U,$J,358.3,2293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2293,1,3,0)
 ;;=3^Cardiac Arrest,Cause Unspec
 ;;^UTILITY(U,$J,358.3,2293,1,4,0)
 ;;=4^I46.9
 ;;^UTILITY(U,$J,358.3,2293,2)
 ;;=^5007221
 ;;^UTILITY(U,$J,358.3,2294,0)
 ;;=I46.8^^20^148^19
 ;;^UTILITY(U,$J,358.3,2294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2294,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Condition
 ;;^UTILITY(U,$J,358.3,2294,1,4,0)
 ;;=4^I46.8
 ;;^UTILITY(U,$J,358.3,2294,2)
 ;;=^5007220
 ;;^UTILITY(U,$J,358.3,2295,0)
 ;;=I46.2^^20^148^18
 ;;^UTILITY(U,$J,358.3,2295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2295,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Cardiac Condition
 ;;^UTILITY(U,$J,358.3,2295,1,4,0)
 ;;=4^I46.2
 ;;^UTILITY(U,$J,358.3,2295,2)
 ;;=^5007219
 ;;^UTILITY(U,$J,358.3,2296,0)
 ;;=I49.40^^20^148^40
 ;;^UTILITY(U,$J,358.3,2296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2296,1,3,0)
 ;;=3^Premature Depolarization,Unspec
 ;;^UTILITY(U,$J,358.3,2296,1,4,0)
 ;;=4^I49.40
 ;;^UTILITY(U,$J,358.3,2296,2)
 ;;=^5007234
 ;;^UTILITY(U,$J,358.3,2297,0)
 ;;=I49.1^^20^148^13
 ;;^UTILITY(U,$J,358.3,2297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2297,1,3,0)
 ;;=3^Atrial Premature Depolarization
 ;;^UTILITY(U,$J,358.3,2297,1,4,0)
 ;;=4^I49.1
 ;;^UTILITY(U,$J,358.3,2297,2)
 ;;=^5007231
 ;;^UTILITY(U,$J,358.3,2298,0)
 ;;=I49.49^^20^148^39
 ;;^UTILITY(U,$J,358.3,2298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2298,1,3,0)
 ;;=3^Premature Depolarization NEC
 ;;^UTILITY(U,$J,358.3,2298,1,4,0)
 ;;=4^I49.49
 ;;^UTILITY(U,$J,358.3,2298,2)
 ;;=^5007235
 ;;^UTILITY(U,$J,358.3,2299,0)
 ;;=I49.5^^20^148^47
 ;;^UTILITY(U,$J,358.3,2299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2299,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,2299,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,2299,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,2300,0)
 ;;=R00.1^^20^148^15
 ;;^UTILITY(U,$J,358.3,2300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2300,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,2300,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,2300,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,2301,0)
 ;;=T82.110A^^20^148^16
 ;;^UTILITY(U,$J,358.3,2301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2301,1,3,0)
 ;;=3^Breakdown of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,2301,1,4,0)
 ;;=4^T82.110A
 ;;^UTILITY(U,$J,358.3,2301,2)
 ;;=^5054680
 ;;^UTILITY(U,$J,358.3,2302,0)
 ;;=T82.111A^^20^148^17
 ;;^UTILITY(U,$J,358.3,2302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2302,1,3,0)
 ;;=3^Breakdown of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,2302,1,4,0)
 ;;=4^T82.111A
 ;;^UTILITY(U,$J,358.3,2302,2)
 ;;=^5054683
 ;;^UTILITY(U,$J,358.3,2303,0)
 ;;=T82.120A^^20^148^25
 ;;^UTILITY(U,$J,358.3,2303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2303,1,3,0)
 ;;=3^Displacement of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,2303,1,4,0)
 ;;=4^T82.120A
 ;;^UTILITY(U,$J,358.3,2303,2)
 ;;=^5054692
 ;;^UTILITY(U,$J,358.3,2304,0)
 ;;=T82.121A^^20^148^26
 ;;^UTILITY(U,$J,358.3,2304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2304,1,3,0)
 ;;=3^Displacement of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,2304,1,4,0)
 ;;=4^T82.121A
 ;;^UTILITY(U,$J,358.3,2304,2)
 ;;=^5054695
 ;;^UTILITY(U,$J,358.3,2305,0)
 ;;=T82.190A^^20^148^34
 ;;^UTILITY(U,$J,358.3,2305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2305,1,3,0)
 ;;=3^Mech Compl of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,2305,1,4,0)
 ;;=4^T82.190A
 ;;^UTILITY(U,$J,358.3,2305,2)
 ;;=^5054704
 ;;^UTILITY(U,$J,358.3,2306,0)
 ;;=T82.191A^^20^148^35
 ;;^UTILITY(U,$J,358.3,2306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2306,1,3,0)
 ;;=3^Mech Compl of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,2306,1,4,0)
 ;;=4^T82.191A
 ;;^UTILITY(U,$J,358.3,2306,2)
 ;;=^5054707
 ;;^UTILITY(U,$J,358.3,2307,0)
 ;;=Z95.0^^20^148^42
 ;;^UTILITY(U,$J,358.3,2307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2307,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,2307,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,2307,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,2308,0)
 ;;=Z95.810^^20^148^41
 ;;^UTILITY(U,$J,358.3,2308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2308,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,2308,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,2308,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,2309,0)
 ;;=Z45.010^^20^148^23
 ;;^UTILITY(U,$J,358.3,2309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2309,1,3,0)
 ;;=3^Check/Test Cardiac Pacemaker Pulse Generator
 ;;^UTILITY(U,$J,358.3,2309,1,4,0)
 ;;=4^Z45.010
 ;;^UTILITY(U,$J,358.3,2309,2)
 ;;=^5062994
 ;;^UTILITY(U,$J,358.3,2310,0)
 ;;=Z45.018^^20^148^6
 ;;^UTILITY(U,$J,358.3,2310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2310,1,3,0)
 ;;=3^Adjust/Manage Cardiac Pacemaker Parts
 ;;^UTILITY(U,$J,358.3,2310,1,4,0)
 ;;=4^Z45.018
 ;;^UTILITY(U,$J,358.3,2310,2)
 ;;=^5062995
 ;;^UTILITY(U,$J,358.3,2311,0)
 ;;=Z45.02^^20^148^5
 ;;^UTILITY(U,$J,358.3,2311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2311,1,3,0)
 ;;=3^Adjust/Manage Automatic Implantable Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,2311,1,4,0)
 ;;=4^Z45.02
 ;;^UTILITY(U,$J,358.3,2311,2)
 ;;=^5062996
 ;;^UTILITY(U,$J,358.3,2312,0)
 ;;=I48.3^^20^148^12
 ;;^UTILITY(U,$J,358.3,2312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2312,1,3,0)
 ;;=3^Atrial Flutter,Typical
 ;;^UTILITY(U,$J,358.3,2312,1,4,0)
 ;;=4^I48.3
 ;;^UTILITY(U,$J,358.3,2312,2)
 ;;=^5007227
 ;;^UTILITY(U,$J,358.3,2313,0)
 ;;=I48.4^^20^148^11
 ;;^UTILITY(U,$J,358.3,2313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2313,1,3,0)
 ;;=3^Atrial Flutter,Atypical
 ;;^UTILITY(U,$J,358.3,2313,1,4,0)
 ;;=4^I48.4
 ;;^UTILITY(U,$J,358.3,2313,2)
 ;;=^5007228
 ;;^UTILITY(U,$J,358.3,2314,0)
 ;;=I25.5^^20^148^22
 ;;^UTILITY(U,$J,358.3,2314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2314,1,3,0)
 ;;=3^Cardiomyopathy,Ischemic
 ;;^UTILITY(U,$J,358.3,2314,1,4,0)
 ;;=4^I25.5
 ;;^UTILITY(U,$J,358.3,2314,2)
 ;;=^5007115
 ;;^UTILITY(U,$J,358.3,2315,0)
 ;;=I42.0^^20^148^21
 ;;^UTILITY(U,$J,358.3,2315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2315,1,3,0)
 ;;=3^Cardiomyopathy,Dilated
 ;;^UTILITY(U,$J,358.3,2315,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,2315,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,2316,0)
 ;;=I48.20^^20^148^7
 ;;^UTILITY(U,$J,358.3,2316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2316,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,2316,1,4,0)
 ;;=4^I48.20
 ;;^UTILITY(U,$J,358.3,2316,2)
 ;;=^5158048
 ;;^UTILITY(U,$J,358.3,2317,0)
 ;;=I48.11^^20^148^8
 ;;^UTILITY(U,$J,358.3,2317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2317,1,3,0)
 ;;=3^Atrial Fibrillation,Longstanding Persistent
 ;;^UTILITY(U,$J,358.3,2317,1,4,0)
 ;;=4^I48.11
 ;;^UTILITY(U,$J,358.3,2317,2)
 ;;=^5158046
 ;;^UTILITY(U,$J,358.3,2318,0)
 ;;=I48.19^^20^148^9
 ;;^UTILITY(U,$J,358.3,2318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2318,1,3,0)
 ;;=3^Atrial Fibrillation,Other Persistent
 ;;^UTILITY(U,$J,358.3,2318,1,4,0)
 ;;=4^I48.19
 ;;^UTILITY(U,$J,358.3,2318,2)
 ;;=^5158047
 ;;^UTILITY(U,$J,358.3,2319,0)
 ;;=I48.21^^20^148^10
 ;;^UTILITY(U,$J,358.3,2319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2319,1,3,0)
 ;;=3^Atrial Fibrillation,Permanent
 ;;^UTILITY(U,$J,358.3,2319,1,4,0)
 ;;=4^I48.21
 ;;^UTILITY(U,$J,358.3,2319,2)
 ;;=^304710
 ;;^UTILITY(U,$J,358.3,2320,0)
 ;;=I25.110^^20^149^15
 ;;^UTILITY(U,$J,358.3,2320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2320,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2320,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,2320,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,2321,0)
 ;;=I25.700^^20^149^34
 ;;^UTILITY(U,$J,358.3,2321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2321,1,3,0)
 ;;=3^Athscl of CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2321,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,2321,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,2322,0)
 ;;=I25.710^^20^149^10
 ;;^UTILITY(U,$J,358.3,2322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2322,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2322,1,4,0)
 ;;=4^I25.710
 ;;^UTILITY(U,$J,358.3,2322,2)
 ;;=^5007121
 ;;^UTILITY(U,$J,358.3,2323,0)
 ;;=I25.720^^20^149^6
 ;;^UTILITY(U,$J,358.3,2323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2323,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2323,1,4,0)
 ;;=4^I25.720
 ;;^UTILITY(U,$J,358.3,2323,2)
 ;;=^5007125
 ;;^UTILITY(U,$J,358.3,2324,0)
 ;;=I25.730^^20^149^24
 ;;^UTILITY(U,$J,358.3,2324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2324,1,3,0)
 ;;=3^Athscl Nonautologous Biological CABG w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,2324,1,4,0)
 ;;=4^I25.730
 ;;^UTILITY(U,$J,358.3,2324,2)
 ;;=^5007127
 ;;^UTILITY(U,$J,358.3,2325,0)
 ;;=I25.750^^20^149^19
 ;;^UTILITY(U,$J,358.3,2325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2325,1,3,0)
 ;;=3^Athscl Native Cor Art of Transplanted Hrt w/ Unstable Angina
 ;;^UTILITY(U,$J,358.3,2325,1,4,0)
 ;;=4^I25.750
 ;;^UTILITY(U,$J,358.3,2325,2)
 ;;=^5007131
 ;;^UTILITY(U,$J,358.3,2326,0)
 ;;=I25.760^^20^149^11
 ;;^UTILITY(U,$J,358.3,2326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2326,1,3,0)
 ;;=3^Athscl Bypass of Cor Art of Transplanted Hrt w/ Unstable Angina
