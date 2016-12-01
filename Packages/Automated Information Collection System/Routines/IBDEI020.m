IBDEI020 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2143,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2143,1,2,0)
 ;;=2^Electrical Stimulation,1+ Areas,Ea 15min
 ;;^UTILITY(U,$J,358.3,2143,1,3,0)
 ;;=3^97032
 ;;^UTILITY(U,$J,358.3,2144,0)
 ;;=97010^^11^153^6^^^^1
 ;;^UTILITY(U,$J,358.3,2144,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2144,1,2,0)
 ;;=2^Hot Or Cold Packs Therapy
 ;;^UTILITY(U,$J,358.3,2144,1,3,0)
 ;;=3^97010
 ;;^UTILITY(U,$J,358.3,2145,0)
 ;;=97036^^11^153^7^^^^1
 ;;^UTILITY(U,$J,358.3,2145,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2145,1,2,0)
 ;;=2^Hubbard Tank,Ea 15min
 ;;^UTILITY(U,$J,358.3,2145,1,3,0)
 ;;=3^97036
 ;;^UTILITY(U,$J,358.3,2146,0)
 ;;=97124^^11^153^10^^^^1
 ;;^UTILITY(U,$J,358.3,2146,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2146,1,2,0)
 ;;=2^Massage Therapy
 ;;^UTILITY(U,$J,358.3,2146,1,3,0)
 ;;=3^97124
 ;;^UTILITY(U,$J,358.3,2147,0)
 ;;=64550^^11^153^1^^^^1
 ;;^UTILITY(U,$J,358.3,2147,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2147,1,2,0)
 ;;=2^Apply Neurostimulator
 ;;^UTILITY(U,$J,358.3,2147,1,3,0)
 ;;=3^64550
 ;;^UTILITY(U,$J,358.3,2148,0)
 ;;=97012^^11^153^11^^^^1
 ;;^UTILITY(U,$J,358.3,2148,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2148,1,2,0)
 ;;=2^Mechanical Traction Therapy 
 ;;^UTILITY(U,$J,358.3,2148,1,3,0)
 ;;=3^97012
 ;;^UTILITY(U,$J,358.3,2149,0)
 ;;=97035^^11^153^21^^^^1
 ;;^UTILITY(U,$J,358.3,2149,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2149,1,2,0)
 ;;=2^Ultrasound Therapy,Ea 15min
 ;;^UTILITY(U,$J,358.3,2149,1,3,0)
 ;;=3^97035
 ;;^UTILITY(U,$J,358.3,2150,0)
 ;;=97028^^11^153^22^^^^1
 ;;^UTILITY(U,$J,358.3,2150,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2150,1,2,0)
 ;;=2^Ultraviolet Therapy
 ;;^UTILITY(U,$J,358.3,2150,1,3,0)
 ;;=3^97028
 ;;^UTILITY(U,$J,358.3,2151,0)
 ;;=97110^^11^153^20^^^^1
 ;;^UTILITY(U,$J,358.3,2151,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2151,1,2,0)
 ;;=2^Therapeutic Exercises,1 or more regions,Ea 15min
 ;;^UTILITY(U,$J,358.3,2151,1,3,0)
 ;;=3^97110
 ;;^UTILITY(U,$J,358.3,2152,0)
 ;;=97112^^11^153^12^^^^1
 ;;^UTILITY(U,$J,358.3,2152,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2152,1,2,0)
 ;;=2^Neuromuscular Re-Education
 ;;^UTILITY(U,$J,358.3,2152,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,2153,0)
 ;;=97140^^11^153^9^^^^1
 ;;^UTILITY(U,$J,358.3,2153,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2153,1,2,0)
 ;;=2^Manual Therapy,1 or more regions,Ea 15min
 ;;^UTILITY(U,$J,358.3,2153,1,3,0)
 ;;=3^97140
 ;;^UTILITY(U,$J,358.3,2154,0)
 ;;=97039^^11^153^2^^^^1
 ;;^UTILITY(U,$J,358.3,2154,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2154,1,2,0)
 ;;=2^Cold Laser Therapy
 ;;^UTILITY(U,$J,358.3,2154,1,3,0)
 ;;=3^97039
 ;;^UTILITY(U,$J,358.3,2155,0)
 ;;=97026^^11^153^8^^^^1
 ;;^UTILITY(U,$J,358.3,2155,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2155,1,2,0)
 ;;=2^Infrared Heat to 1 or more areas
 ;;^UTILITY(U,$J,358.3,2155,1,3,0)
 ;;=3^97026
 ;;^UTILITY(U,$J,358.3,2156,0)
 ;;=29540^^11^153^13^^^^1
 ;;^UTILITY(U,$J,358.3,2156,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2156,1,2,0)
 ;;=2^Strapping/Taping,Ankle and/or Foot
 ;;^UTILITY(U,$J,358.3,2156,1,3,0)
 ;;=3^29540
 ;;^UTILITY(U,$J,358.3,2157,0)
 ;;=29260^^11^153^14^^^^1
 ;;^UTILITY(U,$J,358.3,2157,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2157,1,2,0)
 ;;=2^Strapping/Taping,Elbow/Wrist
 ;;^UTILITY(U,$J,358.3,2157,1,3,0)
 ;;=3^29260
 ;;^UTILITY(U,$J,358.3,2158,0)
 ;;=29520^^11^153^16^^^^1
 ;;^UTILITY(U,$J,358.3,2158,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2158,1,2,0)
 ;;=2^Strapping/Taping,Hip
 ;;^UTILITY(U,$J,358.3,2158,1,3,0)
 ;;=3^29520
 ;;^UTILITY(U,$J,358.3,2159,0)
 ;;=29530^^11^153^17^^^^1
 ;;^UTILITY(U,$J,358.3,2159,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2159,1,2,0)
 ;;=2^Strapping/Taping,Knee
 ;;^UTILITY(U,$J,358.3,2159,1,3,0)
 ;;=3^29530
 ;;^UTILITY(U,$J,358.3,2160,0)
 ;;=29240^^11^153^18^^^^1
 ;;^UTILITY(U,$J,358.3,2160,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2160,1,2,0)
 ;;=2^Strapping/Taping,Shoulder
 ;;^UTILITY(U,$J,358.3,2160,1,3,0)
 ;;=3^29240
 ;;^UTILITY(U,$J,358.3,2161,0)
 ;;=29550^^11^153^19^^^^1
 ;;^UTILITY(U,$J,358.3,2161,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2161,1,2,0)
 ;;=2^Strapping/Taping,Toes
 ;;^UTILITY(U,$J,358.3,2161,1,3,0)
 ;;=3^29550
 ;;^UTILITY(U,$J,358.3,2162,0)
 ;;=29280^^11^153^15^^^^1
 ;;^UTILITY(U,$J,358.3,2162,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2162,1,2,0)
 ;;=2^Strapping/Taping,Hand or Finger
 ;;^UTILITY(U,$J,358.3,2162,1,3,0)
 ;;=3^29280
 ;;^UTILITY(U,$J,358.3,2163,0)
 ;;=20999^^11^153^3^^^^1
 ;;^UTILITY(U,$J,358.3,2163,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2163,1,2,0)
 ;;=2^Dry Needling
 ;;^UTILITY(U,$J,358.3,2163,1,3,0)
 ;;=3^20999
 ;;^UTILITY(U,$J,358.3,2164,0)
 ;;=98940^^11^154^1^^^^1
 ;;^UTILITY(U,$J,358.3,2164,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2164,1,2,0)
 ;;=2^CMT; Spinal, one to two regions
 ;;^UTILITY(U,$J,358.3,2164,1,3,0)
 ;;=3^98940
 ;;^UTILITY(U,$J,358.3,2165,0)
 ;;=98941^^11^154^2^^^^1
 ;;^UTILITY(U,$J,358.3,2165,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2165,1,2,0)
 ;;=2^CMT; Spinal, three to four regions
 ;;^UTILITY(U,$J,358.3,2165,1,3,0)
 ;;=3^98941
 ;;^UTILITY(U,$J,358.3,2166,0)
 ;;=98942^^11^154^3^^^^1
 ;;^UTILITY(U,$J,358.3,2166,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2166,1,2,0)
 ;;=2^CMT; Spinal, five regions
 ;;^UTILITY(U,$J,358.3,2166,1,3,0)
 ;;=3^98942
 ;;^UTILITY(U,$J,358.3,2167,0)
 ;;=98943^^11^154^4^^^^1
 ;;^UTILITY(U,$J,358.3,2167,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2167,1,2,0)
 ;;=2^CMT; Extraspinal, one or more regions
 ;;^UTILITY(U,$J,358.3,2167,1,3,0)
 ;;=3^98943
 ;;^UTILITY(U,$J,358.3,2168,0)
 ;;=98925^^11^155^1^^^^1
 ;;^UTILITY(U,$J,358.3,2168,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2168,1,2,0)
 ;;=2^OMT, 1-2 body regions involved
 ;;^UTILITY(U,$J,358.3,2168,1,3,0)
 ;;=3^98925
 ;;^UTILITY(U,$J,358.3,2169,0)
 ;;=98926^^11^155^2^^^^1
 ;;^UTILITY(U,$J,358.3,2169,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2169,1,2,0)
 ;;=2^OMT, 3-4 body regions involved
 ;;^UTILITY(U,$J,358.3,2169,1,3,0)
 ;;=3^98926
 ;;^UTILITY(U,$J,358.3,2170,0)
 ;;=98927^^11^155^3^^^^1
 ;;^UTILITY(U,$J,358.3,2170,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2170,1,2,0)
 ;;=2^OMT, 5-6 body regions involved
 ;;^UTILITY(U,$J,358.3,2170,1,3,0)
 ;;=3^98927
 ;;^UTILITY(U,$J,358.3,2171,0)
 ;;=98928^^11^155^4^^^^1
 ;;^UTILITY(U,$J,358.3,2171,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2171,1,2,0)
 ;;=2^OMT, 7-8 body regions involved
 ;;^UTILITY(U,$J,358.3,2171,1,3,0)
 ;;=3^98928
 ;;^UTILITY(U,$J,358.3,2172,0)
 ;;=98929^^11^155^5^^^^1
 ;;^UTILITY(U,$J,358.3,2172,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2172,1,2,0)
 ;;=2^OMT, 9-10 body regions involved
 ;;^UTILITY(U,$J,358.3,2172,1,3,0)
 ;;=3^98929
 ;;^UTILITY(U,$J,358.3,2173,0)
 ;;=97810^^11^156^3^^^^1
 ;;^UTILITY(U,$J,358.3,2173,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2173,1,2,0)
 ;;=2^Acupunct w/o Stimul,15min
 ;;^UTILITY(U,$J,358.3,2173,1,3,0)
 ;;=3^97810
 ;;^UTILITY(U,$J,358.3,2174,0)
 ;;=97811^^11^156^4^^^^1
 ;;^UTILITY(U,$J,358.3,2174,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2174,1,2,0)
 ;;=2^Acupunct w/o Stimul,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,2174,1,3,0)
 ;;=3^97811
 ;;^UTILITY(U,$J,358.3,2175,0)
 ;;=97813^^11^156^1^^^^1
 ;;^UTILITY(U,$J,358.3,2175,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2175,1,2,0)
 ;;=2^Acupunct w/ Stimul,15min
 ;;^UTILITY(U,$J,358.3,2175,1,3,0)
 ;;=3^97813
 ;;^UTILITY(U,$J,358.3,2176,0)
 ;;=97814^^11^156^2^^^^1
 ;;^UTILITY(U,$J,358.3,2176,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2176,1,2,0)
 ;;=2^Acupunct w/ Stimul,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,2176,1,3,0)
 ;;=3^97814
 ;;^UTILITY(U,$J,358.3,2177,0)
 ;;=S8930^^11^156^5^^^^1
 ;;^UTILITY(U,$J,358.3,2177,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2177,1,2,0)
 ;;=2^Acupuncture Electostim,Auricular,Ea 15min
 ;;^UTILITY(U,$J,358.3,2177,1,3,0)
 ;;=3^S8930
 ;;^UTILITY(U,$J,358.3,2178,0)
 ;;=98960^^11^157^1^^^^1
 ;;^UTILITY(U,$J,358.3,2178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2178,1,2,0)
 ;;=2^Education for Self Mgt,Ind,Ea 30min
 ;;^UTILITY(U,$J,358.3,2178,1,3,0)
 ;;=3^98960
 ;;^UTILITY(U,$J,358.3,2179,0)
 ;;=G43.C0^^12^158^79
 ;;^UTILITY(U,$J,358.3,2179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2179,1,3,0)
 ;;=3^Periodic headache syndr in chld/adlt, not intrctbl
 ;;^UTILITY(U,$J,358.3,2179,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,2179,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,2180,0)
 ;;=M19.011^^12^158^87
 ;;^UTILITY(U,$J,358.3,2180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2180,1,3,0)
 ;;=3^Primary osteoarthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,2180,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,2180,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,2181,0)
 ;;=M19.012^^12^158^84
 ;;^UTILITY(U,$J,358.3,2181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2181,1,3,0)
 ;;=3^Primary osteoarthritis, lft shldr
 ;;^UTILITY(U,$J,358.3,2181,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,2181,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,2182,0)
 ;;=M19.041^^12^158^86
 ;;^UTILITY(U,$J,358.3,2182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2182,1,3,0)
 ;;=3^Primary osteoarthritis, rt hand
 ;;^UTILITY(U,$J,358.3,2182,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,2182,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,2183,0)
 ;;=M19.042^^12^158^83
 ;;^UTILITY(U,$J,358.3,2183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2183,1,3,0)
 ;;=3^Primary osteoarthritis, lft hand
 ;;^UTILITY(U,$J,358.3,2183,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,2183,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,2184,0)
 ;;=M19.071^^12^158^85
 ;;^UTILITY(U,$J,358.3,2184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2184,1,3,0)
 ;;=3^Primary osteoarthritis, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,2184,1,4,0)
 ;;=4^M19.071
 ;;^UTILITY(U,$J,358.3,2184,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,2185,0)
 ;;=M19.072^^12^158^82
 ;;^UTILITY(U,$J,358.3,2185,1,0)
 ;;=^358.31IA^4^2
