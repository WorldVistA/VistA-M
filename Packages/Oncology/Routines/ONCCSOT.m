ONCCSOT ;Hines OIFO/GWB - Collaborative Staging OUTPUT TRANSFORMS ;06/23/10
 ;;2.11;ONCOLOGY;**40,51,56**;Mar 07, 1995;Build 10
 ;
TOT ;DERIVED AJCC-6 T (165.5,160) OUTPUT TRANSFORM
 ;DERIVED AJCC-7 T (165.5,160.7) OUTPUT TRANSFORM
 I (Y=99)!(Y=999) S Y="TX" Q
 I (Y="00")!(Y="000") S Y="T0" Q
 I (Y="01")!(Y="010") S Y="Ta" Q
 I (Y="05")!(Y="050") S Y="Tis" Q
 I (Y="06")!(Y="060") S Y="Tispu (urethra only)" Q
 I (Y="07")!(Y="070") S Y="Tispd (urethra only)" Q
 I (Y=10)!(Y=100) S Y="T1" Q
 I (Y=11)!(Y=110) S Y="T1mic" Q
 I (Y=19)!(Y=199) S Y="T1 NOS" Q
 I Y=191 S Y="T1 NOS(s)" Q
 I Y=192 S Y="T1 NOS(m)" Q
 I (Y=12)!(Y=120) S Y="T1a" Q
 I Y=121 S Y="T1a(s)" Q
 I Y=122 S Y="T1a(m)" Q
 I (Y=13)!(Y=130) S Y="T1a1" Q
 I (Y=14)!(Y=140) S Y="T1a2" Q
 I (Y=15)!(Y=150) S Y="T1b" Q
 I Y=151 S Y="T1b(s)" Q
 I Y=152 S Y="T1b(m)" Q
 I (Y=16)!(Y=160) S Y="T1b1" Q
 I (Y=17)!(Y=170) S Y="T1b2" Q
 I (Y=18)!(Y=180) S Y="T1c" Q
 I Y=181 S Y="T1d" Q
 I (Y=20)!(Y=200) S Y="T2" Q
 I Y=201 S Y="T2(s)" Q
 I Y=202 S Y="T2(m)" Q
 I (Y=29)!(Y=299) S Y="T2 NOS" Q
 I (Y=21)!(Y=210) S Y="T2a" Q
 I Y=211 S Y="T2a1" Q
 I Y=212 S Y="T2a2" Q
 I Y=213 S Y="T2a NOS" Q
 I (Y=22)!(Y=220) S Y="T2b" Q
 I (Y=23)!(Y=230) S Y="T2c" Q
 I Y=240 S Y="T2d" Q
 I (Y=30)!(Y=300) S Y="T3" Q
 I Y=301 S Y="T3(s)" Q
 I Y=302 S Y="T3(m)" Q
 I (Y=39)!(Y=399) S Y="T3 NOS" Q
 I (Y=31)!(Y=310) S Y="T3a" Q
 I (Y=32)!(Y=320) S Y="T3b" Q
 I (Y=33)!(Y=330) S Y="T3c" Q
 I Y=340 S Y="T3d" Q
 I (Y=40)!(Y=400) S Y="T4" Q
 I (Y=49)!(Y=499) S Y="T4 NOS" Q
 I Y=491 S Y="T4 NOS(s)" Q
 I Y=492 S Y="T4 NOS(m)" Q
 I (Y=41)!(Y=410) S Y="T4a" Q
 I Y=411 S Y="T4a(s)" Q
 I Y=412 S Y="T4a(m)" Q
 I (Y=42)!(Y=420) S Y="T4b" Q
 I Y=421 S Y="T4b(s)" Q
 I Y=422 S Y="T4b(m)" Q
 I (Y=43)!(Y=430) S Y="T4c" Q
 I (Y=44)!(Y=440) S Y="T4d" Q
 I Y=450 S Y="T4e" Q
 I (Y=80)!(Y=800) S Y="T1a NOS" Q
 I (Y=81)!(Y=810) S Y="T1b NOS" Q
 I (Y=88)!(Y=888) S Y="Not applicable" Q
 Q
 ;
NOT ;DERIVED AJCC-6 N (165.5,162) OUTPUT TRANSFORM
 ;DERIVED AJCC-7 N (165.5,162.7) OUTPUT TRANSFORM
 I (Y=99)!(Y=999) S Y="NX" Q
 I (Y="00")!(Y="000") S Y="N0" Q
 I (Y="01")!(Y="010") S Y="N0(i-)" Q
 I (Y="02")!(Y="020") S Y="N0(i+)" Q
 I (Y="03")!(Y="030") S Y="N0(mol-)" Q
 I (Y="04")!(Y="040") S Y="N0(mol+)" Q
 ;I Y="09" S Y="N0 NOS" Q ;No longer used
 I (Y=10)!(Y=100) S Y="N1" Q
 I (Y=19)!(Y=199) S Y="N1 NOS" Q
 I (Y=11)!(Y=110) S Y="N1a" Q
 I (Y=12)!(Y=120) S Y="N1b" Q
 I (Y=13)!(Y=130) S Y="N1c" Q
 I (Y=18)!(Y=180) S Y="N1mi" Q
 I (Y=20)!(Y=200) S Y="N2" Q
 I (Y=29)!(Y=299) S Y="N2 NOS" Q
 I (Y=21)!(Y=210) S Y="N2a" Q
 I (Y=22)!(Y=220) S Y="N2b" Q
 I (Y=23)!(Y=230) S Y="N2c" Q
 I (Y=30)!(Y=300) S Y="N3" Q
 I (Y=39)!(Y=399) S Y="N3 NOS" Q
 I (Y=31)!(Y=310) S Y="N3a" Q
 I (Y=32)!(Y=320) S Y="N3b" Q
 I (Y=33)!(Y=330) S Y="N3c" Q
 I Y=400 S Y="N4" Q
 I (Y=88)!(Y=888) S Y="Not applicable" Q
 Q
 ;
MOT ;DERIVED AJCC-6 M (165.5,164) OUTPUT TRANSFORM
 ;DERIVED AJCC-7 M (165.5,164.7) OUTPUT TRANSFORM
 I (Y=99)!(Y=999) S Y="MX" Q
 I (Y="00")!(Y="000") S Y="M0" Q
 I Y="010" S Y="M0(i+)" Q
 I (Y=10)!(Y=100) S Y="M1" Q
 I (Y=11)!(Y=110) S Y="M1a" Q
 I (Y=12)!(Y=120) S Y="M1b" Q
 I (Y=13)!(Y=130) S Y="M1c" Q
 I Y=140 S Y="M1d" Q
 I Y=150 S Y="M1e" Q
 I (Y=19)!(Y=199) S Y="M1 NOS" Q
 I (Y=88)!(Y=888) S Y="Not applicable" Q
 Q
 ;
SGOT ;DERIVED AJCC-6 STAGE GROUP (165.5,166) OUTPUT TRANSFORM
 ;DERIVED AJCC-7 STAGE GROUP (165.5,166.7) OUTPUT TRANSFORM
 I (Y="00")!(Y="000") S Y="Stage 0" Q
 I (Y="01")!(Y="010") S Y="Stage 0a" Q
 I (Y="02")!(Y="020") S Y="Stage 0is" Q
 I (Y=10)!(Y=100) S Y="Stage I" Q
 I (Y=11)!(Y=110) S Y="Stage I NOS" Q
 I (Y=12)!(Y=120) S Y="Stage IA" Q
 I (Y=13)!(Y=130) S Y="Stage IA1" Q
 I (Y=14)!(Y=140) S Y="Stage IA2" Q
 I Y=121 S Y="Stage IA NOS" Q
 I (Y=15)!(Y=150) S Y="Stage IB" Q
 I (Y=16)!(Y=160) S Y="Stage IB1" Q
 I (Y=17)!(Y=170) S Y="Stage IB2" Q
 I Y=151 S Y="Stage IB NOS" Q
 I (Y=18)!(Y=180) S Y="Stage IC" Q
 I (Y=19)!(Y=190) S Y="Stage IS" Q
 I (Y=23)!(Y=230) S Y="Stage ISA (lymphoma only)" Q
 I (Y=24)!(Y=240) S Y="Stage ISB (lymphoma only)" Q
 I (Y=20)!(Y=200) S Y="Stage IEA (lymphoma only)" Q
 I (Y=21)!(Y=210) S Y="Stage IEB (lymphoma only)" Q
 I (Y=22)!(Y=220) S Y="Stage IE (lymphoma only)" Q
 I (Y=30)!(Y=300) S Y="Stage II" Q
 I (Y=31)!(Y=310) S Y="Stage II NOS" Q
 I (Y=32)!(Y=320) S Y="Stage IIA" Q
 I Y=321 S Y="Stage IIA NOS" Q
 I Y=322 S Y="Stage IIA1" Q
 I Y=323 S Y="Stage IIA2" Q
 I (Y=33)!(Y=330) S Y="Stage IIB" Q
 I (Y=34)!(Y=340) S Y="Stage IIC" Q
 I (Y=35)!(Y=350) S Y="Stage IIEA (lymphoma only)" Q
 I (Y=36)!(Y=360) S Y="Stage IIEB (lymphoma only)" Q
 I (Y=37)!(Y=370) S Y="Stage IIE (lymphoma only)" Q
 I (Y=38)!(Y=380) S Y="Stage IISA (lymphoma only)" Q
 I (Y=39)!(Y=390) S Y="Stage IISB (lymphoma only)" Q
 I (Y=40)!(Y=400) S Y="Stage IIS (lymphoma only)" Q
 I (Y=41)!(Y=410) S Y="Stage IIESA (lymphoma only)" Q
 I (Y=42)!(Y=420) S Y="Stage IIESB (lymphoma only)" Q
 I (Y=43)!(Y=430) S Y="Stage IIES (lymphoma only)" Q
 I (Y=50)!(Y=500) S Y="Stage III" Q
 I (Y=51)!(Y=510) S Y="Stage III NOS" Q
 I (Y=52)!(Y=520) S Y="Stage IIIA" Q
 I (Y=53)!(Y=530) S Y="Stage IIIB" Q
 I (Y=54)!(Y=540) S Y="Stage IIIC" Q
 I Y=541 S Y="Stage IIIC1" Q
 I Y=542 S Y="Stage IIIC2" Q
 I (Y=55)!(Y=550) S Y="Stage IIIEA (lymphoma only)" Q
 I (Y=56)!(Y=560) S Y="Stage IIIEB (lymphoma only)" Q
 I (Y=57)!(Y=570) S Y="Stage IIIE (lymphoma only)" Q
 I (Y=58)!(Y=580) S Y="Stage IIISA (lymphoma only)" Q
 I (Y=59)!(Y=590) S Y="Stage IIISB (lymphoma only)" Q
 I (Y=60)!(Y=600) S Y="Stage IIIS (lymphoma only)" Q
 I (Y=61)!(Y=610) S Y="Stage IIIESA (lymphoma only)" Q
 I (Y=62)!(Y=620) S Y="Stage IIIESB (lymphoma only)" Q
 I (Y=63)!(Y=630) S Y="Stage IIIES (lymphoma only)" Q
 I (Y=70)!(Y=700) S Y="Stage IV" Q
 I (Y=71)!(Y=710) S Y="Stage IV NOS" Q
 I (Y=72)!(Y=720) S Y="Stage IVA" Q
 I Y=721 S Y="Stage IVA1" Q
 I Y=722 S Y="Stage IVA2" Q
 I (Y=73)!(Y=730) S Y="Stage IVB" Q
 I (Y=74)!(Y=740) S Y="Stage IVC" Q
 I (Y=88)!(Y=888) S Y="Not applicable" Q
 I (Y=90)!(Y=900) S Y="Stage Occult" Q
 I (Y=99)!(Y=999) S Y="Stage Unknown"
 Q
 ;
CLEANUP ;Cleanup
 K Y
