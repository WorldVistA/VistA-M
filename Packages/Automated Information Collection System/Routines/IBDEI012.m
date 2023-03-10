IBDEI012 ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2047,0)
 ;;=G91.2^^16^133^22
 ;;^UTILITY(U,$J,358.3,2047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2047,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,2047,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,2047,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,2048,0)
 ;;=G91.2^^16^133^23
 ;;^UTILITY(U,$J,358.3,2048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2048,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,2048,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,2048,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,2049,0)
 ;;=G30.8^^16^133^5
 ;;^UTILITY(U,$J,358.3,2049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2049,1,3,0)
 ;;=3^Alzheimer's Diseases,Other
 ;;^UTILITY(U,$J,358.3,2049,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,2049,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,2050,0)
 ;;=G31.09^^16^133^16
 ;;^UTILITY(U,$J,358.3,2050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2050,1,3,0)
 ;;=3^Frontotemporal Dementia,Other
 ;;^UTILITY(U,$J,358.3,2050,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,2050,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,2051,0)
 ;;=G20.^^16^133^24
 ;;^UTILITY(U,$J,358.3,2051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2051,1,3,0)
 ;;=3^Parkinson's Dis w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,2051,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,2051,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,2052,0)
 ;;=G20.^^16^133^25
 ;;^UTILITY(U,$J,358.3,2052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2052,1,3,0)
 ;;=3^Parkinson's Dis w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,2052,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,2052,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,2053,0)
 ;;=G31.01^^16^133^26
 ;;^UTILITY(U,$J,358.3,2053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2053,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,2053,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,2053,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,2054,0)
 ;;=G23.1^^16^133^28
 ;;^UTILITY(U,$J,358.3,2054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2054,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,2054,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,2054,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,2055,0)
 ;;=R45.851^^16^134^3
 ;;^UTILITY(U,$J,358.3,2055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2055,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,2055,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,2055,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,2056,0)
 ;;=T14.91XA^^16^134^4
 ;;^UTILITY(U,$J,358.3,2056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2056,1,3,0)
 ;;=3^Suicide Attempt,Initial Encntr
 ;;^UTILITY(U,$J,358.3,2056,1,4,0)
 ;;=4^T14.91XA
 ;;^UTILITY(U,$J,358.3,2056,2)
 ;;=^5151779
 ;;^UTILITY(U,$J,358.3,2057,0)
 ;;=T14.91XD^^16^134^6
 ;;^UTILITY(U,$J,358.3,2057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2057,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,2057,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,2057,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,2058,0)
 ;;=T14.91XS^^16^134^5
 ;;^UTILITY(U,$J,358.3,2058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2058,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,2058,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,2058,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,2059,0)
 ;;=Z91.52^^16^134^1
 ;;^UTILITY(U,$J,358.3,2059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2059,1,3,0)
 ;;=3^Personal Hx of Non-Suicidal Self-Harm
 ;;^UTILITY(U,$J,358.3,2059,1,4,0)
 ;;=4^Z91.52
 ;;^UTILITY(U,$J,358.3,2059,2)
 ;;=^5161318
 ;;^UTILITY(U,$J,358.3,2060,0)
 ;;=Z91.51^^16^134^2
 ;;^UTILITY(U,$J,358.3,2060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2060,1,3,0)
 ;;=3^Personal Hx of Suicidal Behavior     
 ;;^UTILITY(U,$J,358.3,2060,1,4,0)
 ;;=4^Z91.51
 ;;^UTILITY(U,$J,358.3,2060,2)
 ;;=^5161317
 ;;^UTILITY(U,$J,358.3,2061,0)
 ;;=97755^^17^135^1^^^^1
 ;;^UTILITY(U,$J,358.3,2061,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2061,1,2,0)
 ;;=2^97755
 ;;^UTILITY(U,$J,358.3,2061,1,3,0)
 ;;=3^Assistive Technology Assess,Ea 15min
 ;;^UTILITY(U,$J,358.3,2062,0)
 ;;=T1016^^17^135^2^^^^1
 ;;^UTILITY(U,$J,358.3,2062,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2062,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,2062,1,3,0)
 ;;=3^Case Management,Ea 15 Min
 ;;^UTILITY(U,$J,358.3,2063,0)
 ;;=97750^^17^135^6^^^^1
 ;;^UTILITY(U,$J,358.3,2063,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2063,1,2,0)
 ;;=2^97750
 ;;^UTILITY(U,$J,358.3,2063,1,3,0)
 ;;=3^Physical Performance Test,Ea 15 min
 ;;^UTILITY(U,$J,358.3,2064,0)
 ;;=96158^^17^135^4^^^^1
 ;;^UTILITY(U,$J,358.3,2064,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2064,1,2,0)
 ;;=2^96158
 ;;^UTILITY(U,$J,358.3,2064,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Ind,1st 30 min
 ;;^UTILITY(U,$J,358.3,2065,0)
 ;;=96159^^17^135^5^^^^1
 ;;^UTILITY(U,$J,358.3,2065,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2065,1,2,0)
 ;;=2^96159
 ;;^UTILITY(U,$J,358.3,2065,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Ind,Ea 15 min
 ;;^UTILITY(U,$J,358.3,2066,0)
 ;;=96156^^17^135^3^^^^1
 ;;^UTILITY(U,$J,358.3,2066,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2066,1,2,0)
 ;;=2^96156
 ;;^UTILITY(U,$J,358.3,2066,1,3,0)
 ;;=3^Hlth/Behav Assmt/Re-Assmt
 ;;^UTILITY(U,$J,358.3,2067,0)
 ;;=97110^^17^136^7^^^^1
 ;;^UTILITY(U,$J,358.3,2067,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2067,1,2,0)
 ;;=2^97110
 ;;^UTILITY(U,$J,358.3,2067,1,3,0)
 ;;=3^Therapeutic Exercise,1>areas,Ea 15 min
 ;;^UTILITY(U,$J,358.3,2068,0)
 ;;=97116^^17^136^1^^^^1
 ;;^UTILITY(U,$J,358.3,2068,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2068,1,2,0)
 ;;=2^97116
 ;;^UTILITY(U,$J,358.3,2068,1,3,0)
 ;;=3^Basic Mobility/Gait Training,Init Visit,Ea 15 Min
 ;;^UTILITY(U,$J,358.3,2069,0)
 ;;=97533^^17^136^6^^^^1
 ;;^UTILITY(U,$J,358.3,2069,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2069,1,2,0)
 ;;=2^97533
 ;;^UTILITY(U,$J,358.3,2069,1,3,0)
 ;;=3^Sensory Integration Techniques,Ea 15 Min
 ;;^UTILITY(U,$J,358.3,2070,0)
 ;;=97535^^17^136^5^^^^1
 ;;^UTILITY(U,$J,358.3,2070,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2070,1,2,0)
 ;;=2^97535
 ;;^UTILITY(U,$J,358.3,2070,1,3,0)
 ;;=3^Self Care Mgmt/ADL,Ea 15 Min
 ;;^UTILITY(U,$J,358.3,2071,0)
 ;;=97537^^17^136^2^^^^1
 ;;^UTILITY(U,$J,358.3,2071,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2071,1,2,0)
 ;;=2^97537
 ;;^UTILITY(U,$J,358.3,2071,1,3,0)
 ;;=3^Community/Occupation Trng,Ea 15 Min
 ;;^UTILITY(U,$J,358.3,2072,0)
 ;;=98960^^17^136^3^^^^1
 ;;^UTILITY(U,$J,358.3,2072,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2072,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,2072,1,3,0)
 ;;=3^Ed/Training,Self-Mgmnt,Ea 15 min
 ;;^UTILITY(U,$J,358.3,2073,0)
 ;;=97763^^17^136^4^^^^1
 ;;^UTILITY(U,$J,358.3,2073,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2073,1,2,0)
 ;;=2^97763
 ;;^UTILITY(U,$J,358.3,2073,1,3,0)
 ;;=3^Orthotic/Prosthetic Mgmt,Ea 15 min
 ;;^UTILITY(U,$J,358.3,2074,0)
 ;;=97129^^17^136^8^^^^1
 ;;^UTILITY(U,$J,358.3,2074,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2074,1,2,0)
 ;;=2^97129
 ;;^UTILITY(U,$J,358.3,2074,1,3,0)
 ;;=3^Therapeutic Intrvn,Cogn,1st 30 min
 ;;^UTILITY(U,$J,358.3,2075,0)
 ;;=97130^^17^136^9^^^^1
 ;;^UTILITY(U,$J,358.3,2075,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2075,1,2,0)
 ;;=2^97130
 ;;^UTILITY(U,$J,358.3,2075,1,3,0)
 ;;=3^Therapeutic Intrvn,Cogn,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,2076,0)
 ;;=98960^^17^137^1^^^^1
 ;;^UTILITY(U,$J,358.3,2076,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2076,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,2076,1,3,0)
 ;;=3^Ed/Training,Self-Mgmt,1 Pt,Ea 30 min
 ;;^UTILITY(U,$J,358.3,2077,0)
 ;;=96164^^17^137^8^^^^1
 ;;^UTILITY(U,$J,358.3,2077,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2077,1,2,0)
 ;;=2^96164
 ;;^UTILITY(U,$J,358.3,2077,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Grp,1st 30 min
 ;;^UTILITY(U,$J,358.3,2078,0)
 ;;=96165^^17^137^9^^^^1
 ;;^UTILITY(U,$J,358.3,2078,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2078,1,2,0)
 ;;=2^96165
 ;;^UTILITY(U,$J,358.3,2078,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Grp,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,2079,0)
 ;;=96167^^17^137^4^^^^1
 ;;^UTILITY(U,$J,358.3,2079,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2079,1,2,0)
 ;;=2^96167
 ;;^UTILITY(U,$J,358.3,2079,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,2080,0)
 ;;=96168^^17^137^5^^^^1
 ;;^UTILITY(U,$J,358.3,2080,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2080,1,2,0)
 ;;=2^96168
 ;;^UTILITY(U,$J,358.3,2080,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,2081,0)
 ;;=96170^^17^137^6^^^^1
 ;;^UTILITY(U,$J,358.3,2081,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2081,1,2,0)
 ;;=2^96170
 ;;^UTILITY(U,$J,358.3,2081,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,2082,0)
 ;;=96171^^17^137^7^^^^1
 ;;^UTILITY(U,$J,358.3,2082,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2082,1,2,0)
 ;;=2^96171
 ;;^UTILITY(U,$J,358.3,2082,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,2083,0)
 ;;=98962^^17^137^3^^^^1
 ;;^UTILITY(U,$J,358.3,2083,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2083,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,2083,1,3,0)
 ;;=3^Ed/Training,Self-Mgmt,5-8 Pts,Ea 30 min
 ;;^UTILITY(U,$J,358.3,2084,0)
 ;;=98961^^17^137^2^^^^1
 ;;^UTILITY(U,$J,358.3,2084,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2084,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,2084,1,3,0)
 ;;=3^Ed/Training,Self-Mgmt,2-4 Pts,Ea 30 min
 ;;^UTILITY(U,$J,358.3,2085,0)
 ;;=99366^^17^138^1^^^^1
 ;;^UTILITY(U,$J,358.3,2085,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2085,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,2085,1,3,0)
 ;;=3^Interdisc. Team Mtg. w/Pt w/o Physician
 ;;^UTILITY(U,$J,358.3,2086,0)
 ;;=99368^^17^138^3^^^^1
 ;;^UTILITY(U,$J,358.3,2086,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2086,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,2086,1,3,0)
 ;;=3^Interdisc. Team Mtg. w/o Pt w/o Physician
 ;;^UTILITY(U,$J,358.3,2087,0)
 ;;=99367^^17^138^2^^^^1
 ;;^UTILITY(U,$J,358.3,2087,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2087,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,2087,1,3,0)
 ;;=3^Interdisc. Mtg w/o Pt w/ Physician
 ;;^UTILITY(U,$J,358.3,2088,0)
 ;;=99600^^17^139^1^^^^1
 ;;^UTILITY(U,$J,358.3,2088,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2088,1,2,0)
 ;;=2^99600
 ;;^UTILITY(U,$J,358.3,2088,1,3,0)
 ;;=3^Home Visit by Nonphysician
 ;;^UTILITY(U,$J,358.3,2089,0)
 ;;=H52.521^^18^140^58
 ;;^UTILITY(U,$J,358.3,2089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2089,1,3,0)
 ;;=3^Paresis of Accommodation,Right Eye
 ;;^UTILITY(U,$J,358.3,2089,1,4,0)
 ;;=4^H52.521
 ;;^UTILITY(U,$J,358.3,2089,2)
 ;;=^5006282
 ;;^UTILITY(U,$J,358.3,2090,0)
 ;;=H52.522^^18^140^57
 ;;^UTILITY(U,$J,358.3,2090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2090,1,3,0)
 ;;=3^Paresis of Accommodation,Left Eye
 ;;^UTILITY(U,$J,358.3,2090,1,4,0)
 ;;=4^H52.522
 ;;^UTILITY(U,$J,358.3,2090,2)
 ;;=^5006283
 ;;^UTILITY(U,$J,358.3,2091,0)
 ;;=H52.523^^18^140^56
 ;;^UTILITY(U,$J,358.3,2091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2091,1,3,0)
 ;;=3^Paresis of Accommodation,Bilateral
 ;;^UTILITY(U,$J,358.3,2091,1,4,0)
 ;;=4^H52.523
 ;;^UTILITY(U,$J,358.3,2091,2)
 ;;=^5006284
 ;;^UTILITY(U,$J,358.3,2092,0)
 ;;=H53.141^^18^140^67
 ;;^UTILITY(U,$J,358.3,2092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2092,1,3,0)
 ;;=3^Visual Discomfort,Right Eye
 ;;^UTILITY(U,$J,358.3,2092,1,4,0)
 ;;=4^H53.141
 ;;^UTILITY(U,$J,358.3,2092,2)
 ;;=^5006317
 ;;^UTILITY(U,$J,358.3,2093,0)
 ;;=H53.142^^18^140^66
 ;;^UTILITY(U,$J,358.3,2093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2093,1,3,0)
 ;;=3^Visual Discomfort,Left Eye
 ;;^UTILITY(U,$J,358.3,2093,1,4,0)
 ;;=4^H53.142
 ;;^UTILITY(U,$J,358.3,2093,2)
 ;;=^5006318
 ;;^UTILITY(U,$J,358.3,2094,0)
 ;;=H53.143^^18^140^65
 ;;^UTILITY(U,$J,358.3,2094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2094,1,3,0)
 ;;=3^Visual Discomfort,Bilateral
 ;;^UTILITY(U,$J,358.3,2094,1,4,0)
 ;;=4^H53.143
 ;;^UTILITY(U,$J,358.3,2094,2)
 ;;=^5006319
 ;;^UTILITY(U,$J,358.3,2095,0)
 ;;=H53.19^^18^140^69
 ;;^UTILITY(U,$J,358.3,2095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2095,1,3,0)
 ;;=3^Visual Disturbances,Subjective
 ;;^UTILITY(U,$J,358.3,2095,1,4,0)
 ;;=4^H53.19
 ;;^UTILITY(U,$J,358.3,2095,2)
 ;;=^5006321
 ;;^UTILITY(U,$J,358.3,2096,0)
 ;;=H53.2^^18^140^30
 ;;^UTILITY(U,$J,358.3,2096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2096,1,3,0)
 ;;=3^Diplopia
 ;;^UTILITY(U,$J,358.3,2096,1,4,0)
 ;;=4^H53.2
 ;;^UTILITY(U,$J,358.3,2096,2)
 ;;=^35208
 ;;^UTILITY(U,$J,358.3,2097,0)
 ;;=H53.30^^18^140^3
 ;;^UTILITY(U,$J,358.3,2097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2097,1,3,0)
 ;;=3^Binocular Vision Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2097,1,4,0)
 ;;=4^H53.30
 ;;^UTILITY(U,$J,358.3,2097,2)
 ;;=^5006322
 ;;^UTILITY(U,$J,358.3,2098,0)
 ;;=H53.34^^18^140^4
 ;;^UTILITY(U,$J,358.3,2098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2098,1,3,0)
 ;;=3^Binocular Vision,Suppression
 ;;^UTILITY(U,$J,358.3,2098,1,4,0)
 ;;=4^H53.34
 ;;^UTILITY(U,$J,358.3,2098,2)
 ;;=^5006323
 ;;^UTILITY(U,$J,358.3,2099,0)
 ;;=H53.33^^18^140^61
 ;;^UTILITY(U,$J,358.3,2099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2099,1,3,0)
 ;;=3^Simultaneous Visual Perception w/o Fusion
 ;;^UTILITY(U,$J,358.3,2099,1,4,0)
 ;;=4^H53.33
 ;;^UTILITY(U,$J,358.3,2099,2)
 ;;=^268841
 ;;^UTILITY(U,$J,358.3,2100,0)
 ;;=H53.31^^18^140^59
 ;;^UTILITY(U,$J,358.3,2100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2100,1,3,0)
 ;;=3^Retinal Correspondence,Abnormal
 ;;^UTILITY(U,$J,358.3,2100,1,4,0)
 ;;=4^H53.31
 ;;^UTILITY(U,$J,358.3,2100,2)
 ;;=^268844
 ;;^UTILITY(U,$J,358.3,2101,0)
 ;;=H53.40^^18^140^76
 ;;^UTILITY(U,$J,358.3,2101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2101,1,3,0)
 ;;=3^Visual Field Defects,Unspec
 ;;^UTILITY(U,$J,358.3,2101,1,4,0)
 ;;=4^H53.40
 ;;^UTILITY(U,$J,358.3,2101,2)
 ;;=^5006324
 ;;^UTILITY(U,$J,358.3,2102,0)
 ;;=H53.411^^18^140^26
 ;;^UTILITY(U,$J,358.3,2102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2102,1,3,0)
 ;;=3^Central Area Scotoma,Right Eye
 ;;^UTILITY(U,$J,358.3,2102,1,4,0)
 ;;=4^H53.411
 ;;^UTILITY(U,$J,358.3,2102,2)
 ;;=^5006325
 ;;^UTILITY(U,$J,358.3,2103,0)
 ;;=H53.412^^18^140^25
 ;;^UTILITY(U,$J,358.3,2103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2103,1,3,0)
 ;;=3^Central Area Scotoma,Left Eye
 ;;^UTILITY(U,$J,358.3,2103,1,4,0)
 ;;=4^H53.412
 ;;^UTILITY(U,$J,358.3,2103,2)
 ;;=^5006326
 ;;^UTILITY(U,$J,358.3,2104,0)
 ;;=H53.413^^18^140^24
 ;;^UTILITY(U,$J,358.3,2104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2104,1,3,0)
 ;;=3^Central Area Scotoma,Bilateral
 ;;^UTILITY(U,$J,358.3,2104,1,4,0)
 ;;=4^H53.413
 ;;^UTILITY(U,$J,358.3,2104,2)
 ;;=^5006327
 ;;^UTILITY(U,$J,358.3,2105,0)
 ;;=H53.451^^18^140^75
 ;;^UTILITY(U,$J,358.3,2105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2105,1,3,0)
 ;;=3^Visual Field Defect,Localized,Right Eye
 ;;^UTILITY(U,$J,358.3,2105,1,4,0)
 ;;=4^H53.451
 ;;^UTILITY(U,$J,358.3,2105,2)
 ;;=^5006337
 ;;^UTILITY(U,$J,358.3,2106,0)
 ;;=H53.452^^18^140^74
 ;;^UTILITY(U,$J,358.3,2106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2106,1,3,0)
 ;;=3^Visual Field Defect,Localized,Left Eye
 ;;^UTILITY(U,$J,358.3,2106,1,4,0)
 ;;=4^H53.452
 ;;^UTILITY(U,$J,358.3,2106,2)
 ;;=^5006338
 ;;^UTILITY(U,$J,358.3,2107,0)
 ;;=H53.453^^18^140^73
 ;;^UTILITY(U,$J,358.3,2107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2107,1,3,0)
 ;;=3^Visual Field Defect,Localized,Bilateral
 ;;^UTILITY(U,$J,358.3,2107,1,4,0)
 ;;=4^H53.453
 ;;^UTILITY(U,$J,358.3,2107,2)
 ;;=^5006339
 ;;^UTILITY(U,$J,358.3,2108,0)
 ;;=H53.481^^18^140^72
 ;;^UTILITY(U,$J,358.3,2108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2108,1,3,0)
 ;;=3^Visual Field Contraction,Right Eye
 ;;^UTILITY(U,$J,358.3,2108,1,4,0)
 ;;=4^H53.481
 ;;^UTILITY(U,$J,358.3,2108,2)
 ;;=^5006344
 ;;^UTILITY(U,$J,358.3,2109,0)
 ;;=H53.482^^18^140^71
 ;;^UTILITY(U,$J,358.3,2109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2109,1,3,0)
 ;;=3^Visual Field Contraction,Left Eye
 ;;^UTILITY(U,$J,358.3,2109,1,4,0)
 ;;=4^H53.482
 ;;^UTILITY(U,$J,358.3,2109,2)
 ;;=^5006345
 ;;^UTILITY(U,$J,358.3,2110,0)
 ;;=H53.483^^18^140^70
 ;;^UTILITY(U,$J,358.3,2110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2110,1,3,0)
 ;;=3^Visual Field Contraction,Bilateral
 ;;^UTILITY(U,$J,358.3,2110,1,4,0)
 ;;=4^H53.483
 ;;^UTILITY(U,$J,358.3,2110,2)
 ;;=^5006346
 ;;^UTILITY(U,$J,358.3,2111,0)
 ;;=H53.461^^18^140^35
 ;;^UTILITY(U,$J,358.3,2111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2111,1,3,0)
 ;;=3^Homonymous Bilateral Field Defects,Right Side
 ;;^UTILITY(U,$J,358.3,2111,1,4,0)
 ;;=4^H53.461
 ;;^UTILITY(U,$J,358.3,2111,2)
 ;;=^5006341
 ;;^UTILITY(U,$J,358.3,2112,0)
 ;;=H53.462^^18^140^34
 ;;^UTILITY(U,$J,358.3,2112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2112,1,3,0)
 ;;=3^Homonymous Bilateral Field Defects,Left Side
 ;;^UTILITY(U,$J,358.3,2112,1,4,0)
 ;;=4^H53.462
 ;;^UTILITY(U,$J,358.3,2112,2)
 ;;=^5006342
 ;;^UTILITY(U,$J,358.3,2113,0)
 ;;=H53.47^^18^140^33
 ;;^UTILITY(U,$J,358.3,2113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2113,1,3,0)
 ;;=3^Heteronymous Bilateral Field Defects
 ;;^UTILITY(U,$J,358.3,2113,1,4,0)
 ;;=4^H53.47
 ;;^UTILITY(U,$J,358.3,2113,2)
 ;;=^268847
 ;;^UTILITY(U,$J,358.3,2114,0)
 ;;=H53.60^^18^140^55
 ;;^UTILITY(U,$J,358.3,2114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2114,1,3,0)
 ;;=3^Night Blindness,Unspec
 ;;^UTILITY(U,$J,358.3,2114,1,4,0)
 ;;=4^H53.60
 ;;^UTILITY(U,$J,358.3,2114,2)
 ;;=^5006353
 ;;^UTILITY(U,$J,358.3,2115,0)
 ;;=H53.62^^18^140^54
 ;;^UTILITY(U,$J,358.3,2115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2115,1,3,0)
 ;;=3^Night Blindness,Acquired
 ;;^UTILITY(U,$J,358.3,2115,1,4,0)
 ;;=4^H53.62
 ;;^UTILITY(U,$J,358.3,2115,2)
 ;;=^265401
 ;;^UTILITY(U,$J,358.3,2116,0)
 ;;=H53.61^^18^140^29
 ;;^UTILITY(U,$J,358.3,2116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2116,1,3,0)
 ;;=3^Dark Adaptation Curve,Abnormal
 ;;^UTILITY(U,$J,358.3,2116,1,4,0)
 ;;=4^H53.61
 ;;^UTILITY(U,$J,358.3,2116,2)
 ;;=^268858
 ;;^UTILITY(U,$J,358.3,2117,0)
 ;;=H53.9^^18^140^68
 ;;^UTILITY(U,$J,358.3,2117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2117,1,3,0)
 ;;=3^Visual Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,2117,1,4,0)
 ;;=4^H53.9
 ;;^UTILITY(U,$J,358.3,2117,2)
 ;;=^124001
 ;;^UTILITY(U,$J,358.3,2118,0)
 ;;=H54.40^^18^140^23
 ;;^UTILITY(U,$J,358.3,2118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2118,1,3,0)
 ;;=3^Blindness,One Eye,Unspec Eye
 ;;^UTILITY(U,$J,358.3,2118,1,4,0)
 ;;=4^H54.40
 ;;^UTILITY(U,$J,358.3,2118,2)
 ;;=^5006362
 ;;^UTILITY(U,$J,358.3,2119,0)
 ;;=H54.61^^18^140^63
 ;;^UTILITY(U,$J,358.3,2119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2119,1,3,0)
 ;;=3^Unqualified Visual Loss Rt Eye,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,2119,1,4,0)
 ;;=4^H54.61
 ;;^UTILITY(U,$J,358.3,2119,2)
 ;;=^5006367
 ;;^UTILITY(U,$J,358.3,2120,0)
 ;;=H54.62^^18^140^62
 ;;^UTILITY(U,$J,358.3,2120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2120,1,3,0)
 ;;=3^Unqualified Visual Loss Lt Eye,Normal Vision Rt Eye
