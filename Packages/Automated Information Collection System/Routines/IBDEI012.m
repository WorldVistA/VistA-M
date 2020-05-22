IBDEI012 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2063,1,2,0)
 ;;=2^69000
 ;;^UTILITY(U,$J,358.3,2063,1,3,0)
 ;;=3^Drain External Ear,Abscess/Hematoma,Simple
 ;;^UTILITY(U,$J,358.3,2064,0)
 ;;=69005^^19^164^3^^^^1
 ;;^UTILITY(U,$J,358.3,2064,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2064,1,2,0)
 ;;=2^69005
 ;;^UTILITY(U,$J,358.3,2064,1,3,0)
 ;;=3^Drain External Ear,Abscess/Hematoma,Compl
 ;;^UTILITY(U,$J,358.3,2065,0)
 ;;=69020^^19^164^1^^^^1
 ;;^UTILITY(U,$J,358.3,2065,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2065,1,2,0)
 ;;=2^69020
 ;;^UTILITY(U,$J,358.3,2065,1,3,0)
 ;;=3^Drain External Auditory Canal,Abscess
 ;;^UTILITY(U,$J,358.3,2066,0)
 ;;=S04.61XA^^20^165^4
 ;;^UTILITY(U,$J,358.3,2066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2066,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, initial encounter
 ;;^UTILITY(U,$J,358.3,2066,1,4,0)
 ;;=4^S04.61XA
 ;;^UTILITY(U,$J,358.3,2066,2)
 ;;=^5020540
 ;;^UTILITY(U,$J,358.3,2067,0)
 ;;=S04.61XD^^20^165^5
 ;;^UTILITY(U,$J,358.3,2067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2067,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2067,1,4,0)
 ;;=4^S04.61XD
 ;;^UTILITY(U,$J,358.3,2067,2)
 ;;=^5020541
 ;;^UTILITY(U,$J,358.3,2068,0)
 ;;=S04.61XS^^20^165^6
 ;;^UTILITY(U,$J,358.3,2068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2068,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, sequela
 ;;^UTILITY(U,$J,358.3,2068,1,4,0)
 ;;=4^S04.61XS
 ;;^UTILITY(U,$J,358.3,2068,2)
 ;;=^5020542
 ;;^UTILITY(U,$J,358.3,2069,0)
 ;;=S04.62XA^^20^165^1
 ;;^UTILITY(U,$J,358.3,2069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2069,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, initial encounter
 ;;^UTILITY(U,$J,358.3,2069,1,4,0)
 ;;=4^S04.62XA
 ;;^UTILITY(U,$J,358.3,2069,2)
 ;;=^5020543
 ;;^UTILITY(U,$J,358.3,2070,0)
 ;;=S04.62XD^^20^165^3
 ;;^UTILITY(U,$J,358.3,2070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2070,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2070,1,4,0)
 ;;=4^S04.62XD
 ;;^UTILITY(U,$J,358.3,2070,2)
 ;;=^5020544
 ;;^UTILITY(U,$J,358.3,2071,0)
 ;;=S04.62XS^^20^165^2
 ;;^UTILITY(U,$J,358.3,2071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2071,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, sequela
 ;;^UTILITY(U,$J,358.3,2071,1,4,0)
 ;;=4^S04.62XS
 ;;^UTILITY(U,$J,358.3,2071,2)
 ;;=^5020545
 ;;^UTILITY(U,$J,358.3,2072,0)
 ;;=S04.9XXA^^20^165^7
 ;;^UTILITY(U,$J,358.3,2072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2072,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, initial encounter
 ;;^UTILITY(U,$J,358.3,2072,1,4,0)
 ;;=4^S04.9XXA
 ;;^UTILITY(U,$J,358.3,2072,2)
 ;;=^5020573
 ;;^UTILITY(U,$J,358.3,2073,0)
 ;;=S04.9XXD^^20^165^9
 ;;^UTILITY(U,$J,358.3,2073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2073,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, subsequent encounter
 ;;^UTILITY(U,$J,358.3,2073,1,4,0)
 ;;=4^S04.9XXD
 ;;^UTILITY(U,$J,358.3,2073,2)
 ;;=^5020574
 ;;^UTILITY(U,$J,358.3,2074,0)
 ;;=S04.9XXS^^20^165^8
 ;;^UTILITY(U,$J,358.3,2074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2074,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, sequela
 ;;^UTILITY(U,$J,358.3,2074,1,4,0)
 ;;=4^S04.9XXS
 ;;^UTILITY(U,$J,358.3,2074,2)
 ;;=^5020575
 ;;^UTILITY(U,$J,358.3,2075,0)
 ;;=H93.213^^20^166^5
 ;;^UTILITY(U,$J,358.3,2075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2075,1,3,0)
 ;;=3^Auditory recruitment, bilateral
 ;;^UTILITY(U,$J,358.3,2075,1,4,0)
 ;;=4^H93.213
 ;;^UTILITY(U,$J,358.3,2075,2)
 ;;=^5006970
 ;;^UTILITY(U,$J,358.3,2076,0)
 ;;=H93.212^^20^166^6
 ;;^UTILITY(U,$J,358.3,2076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2076,1,3,0)
 ;;=3^Auditory recruitment, left ear
 ;;^UTILITY(U,$J,358.3,2076,1,4,0)
 ;;=4^H93.212
 ;;^UTILITY(U,$J,358.3,2076,2)
 ;;=^5006969
 ;;^UTILITY(U,$J,358.3,2077,0)
 ;;=H93.211^^20^166^7
 ;;^UTILITY(U,$J,358.3,2077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2077,1,3,0)
 ;;=3^Auditory recruitment, right ear
 ;;^UTILITY(U,$J,358.3,2077,1,4,0)
 ;;=4^H93.211
 ;;^UTILITY(U,$J,358.3,2077,2)
 ;;=^5006968
 ;;^UTILITY(U,$J,358.3,2078,0)
 ;;=H93.25^^20^166^8
 ;;^UTILITY(U,$J,358.3,2078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2078,1,3,0)
 ;;=3^Central auditory processing disorder
 ;;^UTILITY(U,$J,358.3,2078,1,4,0)
 ;;=4^H93.25
 ;;^UTILITY(U,$J,358.3,2078,2)
 ;;=^5006984
 ;;^UTILITY(U,$J,358.3,2079,0)
 ;;=H93.223^^20^166^9
 ;;^UTILITY(U,$J,358.3,2079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2079,1,3,0)
 ;;=3^Diplacusis, bilateral
 ;;^UTILITY(U,$J,358.3,2079,1,4,0)
 ;;=4^H93.223
 ;;^UTILITY(U,$J,358.3,2079,2)
 ;;=^5006974
 ;;^UTILITY(U,$J,358.3,2080,0)
 ;;=H93.222^^20^166^10
 ;;^UTILITY(U,$J,358.3,2080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2080,1,3,0)
 ;;=3^Diplacusis, left ear
 ;;^UTILITY(U,$J,358.3,2080,1,4,0)
 ;;=4^H93.222
 ;;^UTILITY(U,$J,358.3,2080,2)
 ;;=^5006973
 ;;^UTILITY(U,$J,358.3,2081,0)
 ;;=H93.221^^20^166^11
 ;;^UTILITY(U,$J,358.3,2081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2081,1,3,0)
 ;;=3^Diplacusis, right ear
 ;;^UTILITY(U,$J,358.3,2081,1,4,0)
 ;;=4^H93.221
 ;;^UTILITY(U,$J,358.3,2081,2)
 ;;=^5006972
 ;;^UTILITY(U,$J,358.3,2082,0)
 ;;=R42.^^20^166^12
 ;;^UTILITY(U,$J,358.3,2082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2082,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,2082,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,2082,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,2083,0)
 ;;=Z45.49^^20^166^4
 ;;^UTILITY(U,$J,358.3,2083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2083,1,3,0)
 ;;=3^Adjust/Mgmt of Implanted Nervous System Device
 ;;^UTILITY(U,$J,358.3,2083,1,4,0)
 ;;=4^Z45.49
 ;;^UTILITY(U,$J,358.3,2083,2)
 ;;=^5063006
 ;;^UTILITY(U,$J,358.3,2084,0)
 ;;=Z46.1^^20^166^20
 ;;^UTILITY(U,$J,358.3,2084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2084,1,3,0)
 ;;=3^Fit/Adjust of Hearing Aid
 ;;^UTILITY(U,$J,358.3,2084,1,4,0)
 ;;=4^Z46.1
 ;;^UTILITY(U,$J,358.3,2084,2)
 ;;=^5063014
 ;;^UTILITY(U,$J,358.3,2085,0)
 ;;=Z46.2^^20^166^18
 ;;^UTILITY(U,$J,358.3,2085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2085,1,3,0)
 ;;=3^Fit/Adjust Device Rel to Nervous System/Special Senses
 ;;^UTILITY(U,$J,358.3,2085,1,4,0)
 ;;=4^Z46.2
 ;;^UTILITY(U,$J,358.3,2085,2)
 ;;=^5063015
 ;;^UTILITY(U,$J,358.3,2086,0)
 ;;=Z44.8^^20^166^19
 ;;^UTILITY(U,$J,358.3,2086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2086,1,3,0)
 ;;=3^Fit/Adjust of External Prosthetic Devices
 ;;^UTILITY(U,$J,358.3,2086,1,4,0)
 ;;=4^Z44.8
 ;;^UTILITY(U,$J,358.3,2086,2)
 ;;=^5062992
 ;;^UTILITY(U,$J,358.3,2087,0)
 ;;=Z82.2^^20^166^16
 ;;^UTILITY(U,$J,358.3,2087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2087,1,3,0)
 ;;=3^Family history of deafness and hearing loss
 ;;^UTILITY(U,$J,358.3,2087,1,4,0)
 ;;=4^Z82.2
 ;;^UTILITY(U,$J,358.3,2087,2)
 ;;=^5063366
 ;;^UTILITY(U,$J,358.3,2088,0)
 ;;=Z83.52^^20^166^17
 ;;^UTILITY(U,$J,358.3,2088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2088,1,3,0)
 ;;=3^Family history of ear disorders
 ;;^UTILITY(U,$J,358.3,2088,1,4,0)
 ;;=4^Z83.52
 ;;^UTILITY(U,$J,358.3,2088,2)
 ;;=^5063384
 ;;^UTILITY(U,$J,358.3,2089,0)
 ;;=H93.233^^20^166^21
 ;;^UTILITY(U,$J,358.3,2089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2089,1,3,0)
 ;;=3^Hyperacusis, bilateral
 ;;^UTILITY(U,$J,358.3,2089,1,4,0)
 ;;=4^H93.233
 ;;^UTILITY(U,$J,358.3,2089,2)
 ;;=^5006978
 ;;^UTILITY(U,$J,358.3,2090,0)
 ;;=H93.232^^20^166^22
 ;;^UTILITY(U,$J,358.3,2090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2090,1,3,0)
 ;;=3^Hyperacusis, left ear
 ;;^UTILITY(U,$J,358.3,2090,1,4,0)
 ;;=4^H93.232
 ;;^UTILITY(U,$J,358.3,2090,2)
 ;;=^5006977
 ;;^UTILITY(U,$J,358.3,2091,0)
 ;;=H93.231^^20^166^23
 ;;^UTILITY(U,$J,358.3,2091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2091,1,3,0)
 ;;=3^Hyperacusis, right ear
 ;;^UTILITY(U,$J,358.3,2091,1,4,0)
 ;;=4^H93.231
 ;;^UTILITY(U,$J,358.3,2091,2)
 ;;=^5006976
 ;;^UTILITY(U,$J,358.3,2092,0)
 ;;=H92.03^^20^166^24
 ;;^UTILITY(U,$J,358.3,2092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2092,1,3,0)
 ;;=3^Otalgia, bilateral
 ;;^UTILITY(U,$J,358.3,2092,1,4,0)
 ;;=4^H92.03
 ;;^UTILITY(U,$J,358.3,2092,2)
 ;;=^5006947
 ;;^UTILITY(U,$J,358.3,2093,0)
 ;;=H92.02^^20^166^25
 ;;^UTILITY(U,$J,358.3,2093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2093,1,3,0)
 ;;=3^Otalgia, left ear
 ;;^UTILITY(U,$J,358.3,2093,1,4,0)
 ;;=4^H92.02
 ;;^UTILITY(U,$J,358.3,2093,2)
 ;;=^5006946
 ;;^UTILITY(U,$J,358.3,2094,0)
 ;;=H92.01^^20^166^26
 ;;^UTILITY(U,$J,358.3,2094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2094,1,3,0)
 ;;=3^Otalgia, right ear
 ;;^UTILITY(U,$J,358.3,2094,1,4,0)
 ;;=4^H92.01
 ;;^UTILITY(U,$J,358.3,2094,2)
 ;;=^5006945
 ;;^UTILITY(U,$J,358.3,2095,0)
 ;;=H93.293^^20^166^1
 ;;^UTILITY(U,$J,358.3,2095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2095,1,3,0)
 ;;=3^Abnormal auditory perceptions, bilateral NEC
 ;;^UTILITY(U,$J,358.3,2095,1,4,0)
 ;;=4^H93.293
 ;;^UTILITY(U,$J,358.3,2095,2)
 ;;=^5006987
 ;;^UTILITY(U,$J,358.3,2096,0)
 ;;=H93.292^^20^166^2
 ;;^UTILITY(U,$J,358.3,2096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2096,1,3,0)
 ;;=3^Abnormal auditory perceptions, left ear NEC
 ;;^UTILITY(U,$J,358.3,2096,1,4,0)
 ;;=4^H93.292
 ;;^UTILITY(U,$J,358.3,2096,2)
 ;;=^5006986
 ;;^UTILITY(U,$J,358.3,2097,0)
 ;;=H93.291^^20^166^3
 ;;^UTILITY(U,$J,358.3,2097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2097,1,3,0)
 ;;=3^Abnormal auditory perceptions, right ear NEC
 ;;^UTILITY(U,$J,358.3,2097,1,4,0)
 ;;=4^H93.291
 ;;^UTILITY(U,$J,358.3,2097,2)
 ;;=^5006985
 ;;^UTILITY(U,$J,358.3,2098,0)
 ;;=H92.13^^20^166^27
 ;;^UTILITY(U,$J,358.3,2098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2098,1,3,0)
 ;;=3^Otorrhea, bilateral
 ;;^UTILITY(U,$J,358.3,2098,1,4,0)
 ;;=4^H92.13
 ;;^UTILITY(U,$J,358.3,2098,2)
 ;;=^5006952
 ;;^UTILITY(U,$J,358.3,2099,0)
 ;;=H92.12^^20^166^28
 ;;^UTILITY(U,$J,358.3,2099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2099,1,3,0)
 ;;=3^Otorrhea, left ear
 ;;^UTILITY(U,$J,358.3,2099,1,4,0)
 ;;=4^H92.12
 ;;^UTILITY(U,$J,358.3,2099,2)
 ;;=^5006951
 ;;^UTILITY(U,$J,358.3,2100,0)
 ;;=H92.11^^20^166^29
 ;;^UTILITY(U,$J,358.3,2100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2100,1,3,0)
 ;;=3^Otorrhea, right ear
 ;;^UTILITY(U,$J,358.3,2100,1,4,0)
 ;;=4^H92.11
 ;;^UTILITY(U,$J,358.3,2100,2)
 ;;=^5006950
 ;;^UTILITY(U,$J,358.3,2101,0)
 ;;=Z97.4^^20^166^30
 ;;^UTILITY(U,$J,358.3,2101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2101,1,3,0)
 ;;=3^Presence of external hearing-aid
 ;;^UTILITY(U,$J,358.3,2101,1,4,0)
 ;;=4^Z97.4
 ;;^UTILITY(U,$J,358.3,2101,2)
 ;;=^5063730
 ;;^UTILITY(U,$J,358.3,2102,0)
 ;;=H93.243^^20^166^34
 ;;^UTILITY(U,$J,358.3,2102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2102,1,3,0)
 ;;=3^Temporary auditory threshold shift, bilateral
 ;;^UTILITY(U,$J,358.3,2102,1,4,0)
 ;;=4^H93.243
 ;;^UTILITY(U,$J,358.3,2102,2)
 ;;=^5006982
 ;;^UTILITY(U,$J,358.3,2103,0)
 ;;=H93.242^^20^166^35
 ;;^UTILITY(U,$J,358.3,2103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2103,1,3,0)
 ;;=3^Temporary auditory threshold shift, left ear
 ;;^UTILITY(U,$J,358.3,2103,1,4,0)
 ;;=4^H93.242
 ;;^UTILITY(U,$J,358.3,2103,2)
 ;;=^5006981
 ;;^UTILITY(U,$J,358.3,2104,0)
 ;;=H93.241^^20^166^36
 ;;^UTILITY(U,$J,358.3,2104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2104,1,3,0)
 ;;=3^Temporary auditory threshold shift, right ear
 ;;^UTILITY(U,$J,358.3,2104,1,4,0)
 ;;=4^H93.241
 ;;^UTILITY(U,$J,358.3,2104,2)
 ;;=^5006980
 ;;^UTILITY(U,$J,358.3,2105,0)
 ;;=H93.13^^20^166^37
 ;;^UTILITY(U,$J,358.3,2105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2105,1,3,0)
 ;;=3^Tinnitus, bilateral
 ;;^UTILITY(U,$J,358.3,2105,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,2105,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,2106,0)
 ;;=H93.12^^20^166^38
 ;;^UTILITY(U,$J,358.3,2106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2106,1,3,0)
 ;;=3^Tinnitus, left ear
 ;;^UTILITY(U,$J,358.3,2106,1,4,0)
 ;;=4^H93.12
 ;;^UTILITY(U,$J,358.3,2106,2)
 ;;=^5006965
 ;;^UTILITY(U,$J,358.3,2107,0)
 ;;=H93.11^^20^166^39
 ;;^UTILITY(U,$J,358.3,2107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2107,1,3,0)
 ;;=3^Tinnitus, right ear
 ;;^UTILITY(U,$J,358.3,2107,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,2107,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,2108,0)
 ;;=H93.92^^20^166^14
 ;;^UTILITY(U,$J,358.3,2108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2108,1,3,0)
 ;;=3^Ear Disorder,Unspec,Left Ear
 ;;^UTILITY(U,$J,358.3,2108,1,4,0)
 ;;=4^H93.92
 ;;^UTILITY(U,$J,358.3,2108,2)
 ;;=^5006997
 ;;^UTILITY(U,$J,358.3,2109,0)
 ;;=H93.91^^20^166^15
 ;;^UTILITY(U,$J,358.3,2109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2109,1,3,0)
 ;;=3^Ear Disorder,Unspec,Right
 ;;^UTILITY(U,$J,358.3,2109,1,4,0)
 ;;=4^H93.91
 ;;^UTILITY(U,$J,358.3,2109,2)
 ;;=^5006996
 ;;^UTILITY(U,$J,358.3,2110,0)
 ;;=H93.A1^^20^166^33
 ;;^UTILITY(U,$J,358.3,2110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2110,1,3,0)
 ;;=3^Pulsatile Tinnitus,Right Ear
 ;;^UTILITY(U,$J,358.3,2110,1,4,0)
 ;;=4^H93.A1
 ;;^UTILITY(U,$J,358.3,2110,2)
 ;;=^5138590
 ;;^UTILITY(U,$J,358.3,2111,0)
 ;;=H93.A2^^20^166^32
 ;;^UTILITY(U,$J,358.3,2111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2111,1,3,0)
 ;;=3^Pulsatile Tinnitus,Left Ear
 ;;^UTILITY(U,$J,358.3,2111,1,4,0)
 ;;=4^H93.A2
 ;;^UTILITY(U,$J,358.3,2111,2)
 ;;=^5138591
 ;;^UTILITY(U,$J,358.3,2112,0)
 ;;=H93.A3^^20^166^31
 ;;^UTILITY(U,$J,358.3,2112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2112,1,3,0)
 ;;=3^Pulsatile Tinnitus,Bilateral
 ;;^UTILITY(U,$J,358.3,2112,1,4,0)
 ;;=4^H93.A3
 ;;^UTILITY(U,$J,358.3,2112,2)
 ;;=^5138592
 ;;^UTILITY(U,$J,358.3,2113,0)
 ;;=H93.93^^20^166^13
 ;;^UTILITY(U,$J,358.3,2113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2113,1,3,0)
 ;;=3^Ear Disorder,Unspec,Bilateral
 ;;^UTILITY(U,$J,358.3,2113,1,4,0)
 ;;=4^H93.93
 ;;^UTILITY(U,$J,358.3,2113,2)
 ;;=^5006998
 ;;^UTILITY(U,$J,358.3,2114,0)
 ;;=H81.313^^20^167^1
 ;;^UTILITY(U,$J,358.3,2114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2114,1,3,0)
 ;;=3^Aural vertigo, bilateral
 ;;^UTILITY(U,$J,358.3,2114,1,4,0)
 ;;=4^H81.313
 ;;^UTILITY(U,$J,358.3,2114,2)
 ;;=^5006874
 ;;^UTILITY(U,$J,358.3,2115,0)
 ;;=H81.312^^20^167^2
 ;;^UTILITY(U,$J,358.3,2115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2115,1,3,0)
 ;;=3^Aural vertigo, left ear
 ;;^UTILITY(U,$J,358.3,2115,1,4,0)
 ;;=4^H81.312
 ;;^UTILITY(U,$J,358.3,2115,2)
 ;;=^5006873
 ;;^UTILITY(U,$J,358.3,2116,0)
 ;;=H81.311^^20^167^3
 ;;^UTILITY(U,$J,358.3,2116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2116,1,3,0)
 ;;=3^Aural vertigo, right ear
 ;;^UTILITY(U,$J,358.3,2116,1,4,0)
 ;;=4^H81.311
 ;;^UTILITY(U,$J,358.3,2116,2)
 ;;=^5006872
 ;;^UTILITY(U,$J,358.3,2117,0)
 ;;=H81.13^^20^167^4
 ;;^UTILITY(U,$J,358.3,2117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2117,1,3,0)
 ;;=3^Benign paroxysmal vertigo, bilateral
 ;;^UTILITY(U,$J,358.3,2117,1,4,0)
 ;;=4^H81.13
 ;;^UTILITY(U,$J,358.3,2117,2)
 ;;=^5006867
 ;;^UTILITY(U,$J,358.3,2118,0)
 ;;=H81.12^^20^167^5
 ;;^UTILITY(U,$J,358.3,2118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2118,1,3,0)
 ;;=3^Benign paroxysmal vertigo, left ear
 ;;^UTILITY(U,$J,358.3,2118,1,4,0)
 ;;=4^H81.12
 ;;^UTILITY(U,$J,358.3,2118,2)
 ;;=^5006866
 ;;^UTILITY(U,$J,358.3,2119,0)
 ;;=H81.11^^20^167^6
 ;;^UTILITY(U,$J,358.3,2119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2119,1,3,0)
 ;;=3^Benign paroxysmal vertigo, right ear
 ;;^UTILITY(U,$J,358.3,2119,1,4,0)
 ;;=4^H81.11
 ;;^UTILITY(U,$J,358.3,2119,2)
 ;;=^5006865
 ;;^UTILITY(U,$J,358.3,2120,0)
 ;;=R42.^^20^167^10
 ;;^UTILITY(U,$J,358.3,2120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2120,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,2120,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,2120,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,2121,0)
 ;;=H81.03^^20^167^11
 ;;^UTILITY(U,$J,358.3,2121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2121,1,3,0)
 ;;=3^Meniere's disease, bilateral
 ;;^UTILITY(U,$J,358.3,2121,1,4,0)
 ;;=4^H81.03
 ;;^UTILITY(U,$J,358.3,2121,2)
 ;;=^5006862
 ;;^UTILITY(U,$J,358.3,2122,0)
 ;;=H81.02^^20^167^12
 ;;^UTILITY(U,$J,358.3,2122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2122,1,3,0)
 ;;=3^Meniere's disease, left ear
 ;;^UTILITY(U,$J,358.3,2122,1,4,0)
 ;;=4^H81.02
 ;;^UTILITY(U,$J,358.3,2122,2)
 ;;=^5006861
 ;;^UTILITY(U,$J,358.3,2123,0)
 ;;=H81.01^^20^167^13
 ;;^UTILITY(U,$J,358.3,2123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2123,1,3,0)
 ;;=3^Meniere's disease, right ear
 ;;^UTILITY(U,$J,358.3,2123,1,4,0)
 ;;=4^H81.01
 ;;^UTILITY(U,$J,358.3,2123,2)
 ;;=^5006860
 ;;^UTILITY(U,$J,358.3,2124,0)
 ;;=H81.393^^20^167^14
 ;;^UTILITY(U,$J,358.3,2124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2124,1,3,0)
 ;;=3^Peripheral vertigo, bilateral NEC
 ;;^UTILITY(U,$J,358.3,2124,1,4,0)
 ;;=4^H81.393
 ;;^UTILITY(U,$J,358.3,2124,2)
 ;;=^5006878
 ;;^UTILITY(U,$J,358.3,2125,0)
 ;;=H81.392^^20^167^15
 ;;^UTILITY(U,$J,358.3,2125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2125,1,3,0)
 ;;=3^Peripheral vertigo, left ear NEC
 ;;^UTILITY(U,$J,358.3,2125,1,4,0)
 ;;=4^H81.392
 ;;^UTILITY(U,$J,358.3,2125,2)
 ;;=^5006877
 ;;^UTILITY(U,$J,358.3,2126,0)
 ;;=H81.391^^20^167^16
 ;;^UTILITY(U,$J,358.3,2126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2126,1,3,0)
 ;;=3^Peripheral vertigo, right ear NEC
 ;;^UTILITY(U,$J,358.3,2126,1,4,0)
 ;;=4^H81.391
 ;;^UTILITY(U,$J,358.3,2126,2)
 ;;=^5006876
 ;;^UTILITY(U,$J,358.3,2127,0)
 ;;=H71.93^^20^167^7
 ;;^UTILITY(U,$J,358.3,2127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2127,1,3,0)
 ;;=3^Cholesteatoma,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,2127,1,4,0)
 ;;=4^H71.93
 ;;^UTILITY(U,$J,358.3,2127,2)
 ;;=^5006741
 ;;^UTILITY(U,$J,358.3,2128,0)
 ;;=H81.23^^20^167^18
 ;;^UTILITY(U,$J,358.3,2128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2128,1,3,0)
 ;;=3^Vestibular Neuronitis,Bilateral
 ;;^UTILITY(U,$J,358.3,2128,1,4,0)
 ;;=4^H81.23
 ;;^UTILITY(U,$J,358.3,2128,2)
 ;;=^5006871
 ;;^UTILITY(U,$J,358.3,2129,0)
 ;;=H71.91^^20^167^9
 ;;^UTILITY(U,$J,358.3,2129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2129,1,3,0)
 ;;=3^Cholesteatoma,Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,2129,1,4,0)
 ;;=4^H71.91
 ;;^UTILITY(U,$J,358.3,2129,2)
 ;;=^5006739
 ;;^UTILITY(U,$J,358.3,2130,0)
 ;;=H71.92^^20^167^8
 ;;^UTILITY(U,$J,358.3,2130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2130,1,3,0)
 ;;=3^Cholesteatoma,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,2130,1,4,0)
 ;;=4^H71.92
 ;;^UTILITY(U,$J,358.3,2130,2)
 ;;=^5006740
 ;;^UTILITY(U,$J,358.3,2131,0)
 ;;=H81.21^^20^167^20
 ;;^UTILITY(U,$J,358.3,2131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2131,1,3,0)
 ;;=3^Vestibular Neuronitis,Right Ear
 ;;^UTILITY(U,$J,358.3,2131,1,4,0)
 ;;=4^H81.21
 ;;^UTILITY(U,$J,358.3,2131,2)
 ;;=^5006869
 ;;^UTILITY(U,$J,358.3,2132,0)
 ;;=H81.22^^20^167^19
 ;;^UTILITY(U,$J,358.3,2132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2132,1,3,0)
 ;;=3^Vestibular Neuronitis,Left Ear
 ;;^UTILITY(U,$J,358.3,2132,1,4,0)
 ;;=4^H81.22
 ;;^UTILITY(U,$J,358.3,2132,2)
 ;;=^5006870
 ;;^UTILITY(U,$J,358.3,2133,0)
 ;;=H81.4^^20^167^17
