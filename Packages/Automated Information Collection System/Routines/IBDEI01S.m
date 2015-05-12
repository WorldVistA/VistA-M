IBDEI01S ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2001,1,3,0)
 ;;=3^Amputation,Partial Traumatic Right MCP Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2001,1,4,0)
 ;;=4^S68.124A
 ;;^UTILITY(U,$J,358.3,2001,2)
 ;;=^5036681
 ;;^UTILITY(U,$J,358.3,2002,0)
 ;;=S68.021A^^8^91^36
 ;;^UTILITY(U,$J,358.3,2002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2002,1,3,0)
 ;;=3^Amputation,Partial Traumatic Right MCP Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,2002,1,4,0)
 ;;=4^S68.021A
 ;;^UTILITY(U,$J,358.3,2002,2)
 ;;=^5036630
 ;;^UTILITY(U,$J,358.3,2003,0)
 ;;=S68.620A^^8^91^39
 ;;^UTILITY(U,$J,358.3,2003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2003,1,3,0)
 ;;=3^Amputation,Partial Traumatic Right Trnsphal Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2003,1,4,0)
 ;;=4^S68.620A
 ;;^UTILITY(U,$J,358.3,2003,2)
 ;;=^5036765
 ;;^UTILITY(U,$J,358.3,2004,0)
 ;;=S68.626A^^8^91^40
 ;;^UTILITY(U,$J,358.3,2004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2004,1,3,0)
 ;;=3^Amputation,Partial Traumatic Right Trnsphal Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2004,1,4,0)
 ;;=4^S68.626A
 ;;^UTILITY(U,$J,358.3,2004,2)
 ;;=^5036783
 ;;^UTILITY(U,$J,358.3,2005,0)
 ;;=S68.622A^^8^91^41
 ;;^UTILITY(U,$J,358.3,2005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2005,1,3,0)
 ;;=3^Amputation,Partial Traumatic Right Trnsphal Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2005,1,4,0)
 ;;=4^S68.622A
 ;;^UTILITY(U,$J,358.3,2005,2)
 ;;=^5036771
 ;;^UTILITY(U,$J,358.3,2006,0)
 ;;=S68.624A^^8^91^42
 ;;^UTILITY(U,$J,358.3,2006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2006,1,3,0)
 ;;=3^Amputation,Partial Traumatic Right Trnsphal Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2006,1,4,0)
 ;;=4^S68.624A
 ;;^UTILITY(U,$J,358.3,2006,2)
 ;;=^5036777
 ;;^UTILITY(U,$J,358.3,2007,0)
 ;;=S68.521A^^8^91^43
 ;;^UTILITY(U,$J,358.3,2007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2007,1,3,0)
 ;;=3^Amputation,Partial Traumatic Right Trnsphal Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,2007,1,4,0)
 ;;=4^S68.521A
 ;;^UTILITY(U,$J,358.3,2007,2)
 ;;=^5036726
 ;;^UTILITY(U,$J,358.3,2008,0)
 ;;=Q17.5^^8^91^319
 ;;^UTILITY(U,$J,358.3,2008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2008,1,3,0)
 ;;=3^Prominent Ear
 ;;^UTILITY(U,$J,358.3,2008,1,4,0)
 ;;=4^Q17.5
 ;;^UTILITY(U,$J,358.3,2008,2)
 ;;=^5018514
 ;;^UTILITY(U,$J,358.3,2009,0)
 ;;=S68.121A^^8^91^14
 ;;^UTILITY(U,$J,358.3,2009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2009,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left MCP Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2009,1,4,0)
 ;;=4^S68.121A
 ;;^UTILITY(U,$J,358.3,2009,2)
 ;;=^5036672
 ;;^UTILITY(U,$J,358.3,2010,0)
 ;;=S68.127A^^8^91^15
 ;;^UTILITY(U,$J,358.3,2010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2010,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left MCP Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2010,1,4,0)
 ;;=4^S68.127A
 ;;^UTILITY(U,$J,358.3,2010,2)
 ;;=^5036690
 ;;^UTILITY(U,$J,358.3,2011,0)
 ;;=S68.123A^^8^91^16
 ;;^UTILITY(U,$J,358.3,2011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2011,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left MCP Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2011,1,4,0)
 ;;=4^S68.123A
 ;;^UTILITY(U,$J,358.3,2011,2)
 ;;=^5036678
 ;;^UTILITY(U,$J,358.3,2012,0)
 ;;=S68.125A^^8^91^17
 ;;^UTILITY(U,$J,358.3,2012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2012,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left MCP Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2012,1,4,0)
 ;;=4^S68.125A
 ;;^UTILITY(U,$J,358.3,2012,2)
 ;;=^5036684
 ;;^UTILITY(U,$J,358.3,2013,0)
 ;;=S68.022A^^8^91^18
 ;;^UTILITY(U,$J,358.3,2013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2013,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left MCP Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,2013,1,4,0)
 ;;=4^S68.022A
 ;;^UTILITY(U,$J,358.3,2013,2)
 ;;=^5036633
 ;;^UTILITY(U,$J,358.3,2014,0)
 ;;=S68.621A^^8^91^21
 ;;^UTILITY(U,$J,358.3,2014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2014,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left Trnsphal Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2014,1,4,0)
 ;;=4^S68.621A
 ;;^UTILITY(U,$J,358.3,2014,2)
 ;;=^5036768
 ;;^UTILITY(U,$J,358.3,2015,0)
 ;;=S68.627A^^8^91^22
 ;;^UTILITY(U,$J,358.3,2015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2015,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left Trnsphal Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2015,1,4,0)
 ;;=4^S68.627A
 ;;^UTILITY(U,$J,358.3,2015,2)
 ;;=^5036786
 ;;^UTILITY(U,$J,358.3,2016,0)
 ;;=S68.623A^^8^91^23
 ;;^UTILITY(U,$J,358.3,2016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2016,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left Trnsphal Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2016,1,4,0)
 ;;=4^S68.623A
 ;;^UTILITY(U,$J,358.3,2016,2)
 ;;=^5036774
 ;;^UTILITY(U,$J,358.3,2017,0)
 ;;=S68.625A^^8^91^24
 ;;^UTILITY(U,$J,358.3,2017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2017,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left Trnsphal Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2017,1,4,0)
 ;;=4^S68.625A
 ;;^UTILITY(U,$J,358.3,2017,2)
 ;;=^5036780
 ;;^UTILITY(U,$J,358.3,2018,0)
 ;;=S68.522A^^8^91^25
 ;;^UTILITY(U,$J,358.3,2018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2018,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left Trnsphal Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,2018,1,4,0)
 ;;=4^S68.522A
 ;;^UTILITY(U,$J,358.3,2018,2)
 ;;=^5036729
 ;;^UTILITY(U,$J,358.3,2019,0)
 ;;=S98.222A^^8^91^9
 ;;^UTILITY(U,$J,358.3,2019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2019,1,3,0)
 ;;=3^Amputation,Partial Traumatic Left 2 or More Lesser Toes,Init Encntr
 ;;^UTILITY(U,$J,358.3,2019,1,4,0)
 ;;=4^S98.222A
 ;;^UTILITY(U,$J,358.3,2019,2)
 ;;=^5046311
 ;;^UTILITY(U,$J,358.3,2020,0)
 ;;=M65.4^^8^91^323
 ;;^UTILITY(U,$J,358.3,2020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2020,1,3,0)
 ;;=3^Radial Styloid Tenosynovitis
 ;;^UTILITY(U,$J,358.3,2020,1,4,0)
 ;;=4^M65.4
 ;;^UTILITY(U,$J,358.3,2020,2)
 ;;=^5012792
 ;;^UTILITY(U,$J,358.3,2021,0)
 ;;=I73.00^^8^91^324
 ;;^UTILITY(U,$J,358.3,2021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2021,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,2021,1,4,0)
 ;;=4^I73.00
 ;;^UTILITY(U,$J,358.3,2021,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,2022,0)
 ;;=C44.129^^8^91^326
 ;;^UTILITY(U,$J,358.3,2022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2022,1,3,0)
 ;;=3^SCC Skin Left Eyelid
 ;;^UTILITY(U,$J,358.3,2022,1,4,0)
 ;;=4^C44.129
 ;;^UTILITY(U,$J,358.3,2022,2)
 ;;=^5001024
 ;;^UTILITY(U,$J,358.3,2023,0)
 ;;=C44.122^^8^91^328
 ;;^UTILITY(U,$J,358.3,2023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2023,1,3,0)
 ;;=3^SCC Skin Right Eyelid
 ;;^UTILITY(U,$J,358.3,2023,1,4,0)
 ;;=4^C44.122
 ;;^UTILITY(U,$J,358.3,2023,2)
 ;;=^5001023
 ;;^UTILITY(U,$J,358.3,2024,0)
 ;;=C44.42^^8^91^329
 ;;^UTILITY(U,$J,358.3,2024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2024,1,3,0)
 ;;=3^SCC Skin Scalp/Neck
 ;;^UTILITY(U,$J,358.3,2024,1,4,0)
 ;;=4^C44.42
 ;;^UTILITY(U,$J,358.3,2024,2)
 ;;=^340477
 ;;^UTILITY(U,$J,358.3,2025,0)
 ;;=C44.229^^8^91^325
 ;;^UTILITY(U,$J,358.3,2025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2025,1,3,0)
 ;;=3^SCC Skin Left Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,2025,1,4,0)
 ;;=4^C44.229
 ;;^UTILITY(U,$J,358.3,2025,2)
 ;;=^5001036
 ;;^UTILITY(U,$J,358.3,2026,0)
 ;;=C44.222^^8^91^327
 ;;^UTILITY(U,$J,358.3,2026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2026,1,3,0)
 ;;=3^SCC Skin Right Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,2026,1,4,0)
 ;;=4^C44.222
 ;;^UTILITY(U,$J,358.3,2026,2)
 ;;=^5001035
 ;;^UTILITY(U,$J,358.3,2027,0)
 ;;=L90.5^^8^91^331
 ;;^UTILITY(U,$J,358.3,2027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2027,1,3,0)
 ;;=3^Scar Conditions/Fibrosis of Skin
 ;;^UTILITY(U,$J,358.3,2027,1,4,0)
 ;;=4^L90.5
 ;;^UTILITY(U,$J,358.3,2027,2)
 ;;=^5009455
 ;;^UTILITY(U,$J,358.3,2028,0)
 ;;=L72.3^^8^91^332
 ;;^UTILITY(U,$J,358.3,2028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2028,1,3,0)
 ;;=3^Sebaceous Cyst
 ;;^UTILITY(U,$J,358.3,2028,1,4,0)
 ;;=4^L72.3
 ;;^UTILITY(U,$J,358.3,2028,2)
 ;;=^5009281
 ;;^UTILITY(U,$J,358.3,2029,0)
 ;;=M66.242^^8^91^334
 ;;^UTILITY(U,$J,358.3,2029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2029,1,3,0)
 ;;=3^Spontaneous Rupture Extensor Tendons,Left Hand
 ;;^UTILITY(U,$J,358.3,2029,1,4,0)
 ;;=4^M66.242
 ;;^UTILITY(U,$J,358.3,2029,2)
 ;;=^5012858
 ;;^UTILITY(U,$J,358.3,2030,0)
 ;;=M66.241^^8^91^335
 ;;^UTILITY(U,$J,358.3,2030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2030,1,3,0)
 ;;=3^Spontaneous Rupture Extensor Tendons,Right Hand
 ;;^UTILITY(U,$J,358.3,2030,1,4,0)
 ;;=4^M66.241
 ;;^UTILITY(U,$J,358.3,2030,2)
 ;;=^5012857
 ;;^UTILITY(U,$J,358.3,2031,0)
 ;;=M66.342^^8^91^336
 ;;^UTILITY(U,$J,358.3,2031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2031,1,3,0)
 ;;=3^Spontaneous Rupture Flexor Tendons,Left Hand
 ;;^UTILITY(U,$J,358.3,2031,1,4,0)
 ;;=4^M66.342
 ;;^UTILITY(U,$J,358.3,2031,2)
 ;;=^5012882
 ;;^UTILITY(U,$J,358.3,2032,0)
 ;;=M66.341^^8^91^337
 ;;^UTILITY(U,$J,358.3,2032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2032,1,3,0)
 ;;=3^Spontaneous Rupture Flexor Tendons,Right Hand
 ;;^UTILITY(U,$J,358.3,2032,1,4,0)
 ;;=4^M66.341
 ;;^UTILITY(U,$J,358.3,2032,2)
 ;;=^5012881
 ;;^UTILITY(U,$J,358.3,2033,0)
 ;;=S93.402A^^8^91^338
 ;;^UTILITY(U,$J,358.3,2033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2033,1,3,0)
 ;;=3^Sprain Left Ankle Ligament Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,2033,1,4,0)
 ;;=4^S93.402A
 ;;^UTILITY(U,$J,358.3,2033,2)
 ;;=^5045777
 ;;^UTILITY(U,$J,358.3,2034,0)
 ;;=S63.92XA^^8^91^340
 ;;^UTILITY(U,$J,358.3,2034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2034,1,3,0)
 ;;=3^Sprain Left Wrist/Hand Unspec Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,2034,1,4,0)
 ;;=4^S63.92XA
 ;;^UTILITY(U,$J,358.3,2034,2)
 ;;=^5136047
 ;;^UTILITY(U,$J,358.3,2035,0)
 ;;=S93.401A^^8^91^341
