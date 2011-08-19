ONCSG0 ;Hines OIFO/GWB - Automatic Staging Tables ;06/23/10
 ;;2.11;ONCOLOGY;**35,36,51**;Mar 07, 1995;Build 65
 ;
 ;HEAD AND NECK SITES
 ;
LIP12 ;Lip and Oral Cavity - 1st and 2nd editions
 I M[1 S SG=4
 E  I M[0 D
 .I (N[2)!(N[3) S SG=4
 .E  I N[1,(T[1)!(T[2)!(T[3)!(T[4) S SG=$S(T=4:4,1:3)
 .E  I N[0,(T[1)!(T[2)!(T[3)!(T[4) S SG=+T
 Q
 ;
LIP34 ;Lip and Oral Cavity - 3rd and 4th editions
 I M[1 S SG=4
 E  I M[0 D
 .I (N[2)!(N[3) S SG=4
 .E  I N[1,(T[1)!(T[2)!(T[3)!(T[4) S SG=$S(T=4:4,1:3)
 .E  I N[0,(T["IS")!(T[1)!(T[2)!(T[3)!(T[4) S SG=+T
 Q
 ;
LIP5 ;Lip and Oral Cavity - 5th edition
 S TNM=T_$E(N,1)_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q        ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q           ;II   T2    N0    M0
 .I TNM=300 S SG=3 Q           ;III  T3    N0    M0
 .I TNM=110 S SG=3 Q           ;     T1    N1    M0
 .I TNM=210 S SG=3 Q           ;     T2    N1    M0
 .I TNM=310 S SG=3 Q           ;     T3    N1    M0
 .I TNM=400 S SG="4A" Q        ;IVA  T4    N0    M0
 .I TNM=410 S SG="4A" Q        ;     T4    N1    M0
 .I $E(N,1)=2,M=0 S SG="4A" Q  ;     Any T N2    M0
 .I $E(N,1)=3,M=0 S SG="4B" Q  ;IVB  Any T N3    M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
LIP6 ;Lip and Oral Cavity - 6th edition
 S TNM=T_$E(N,1)_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q        ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q           ;II   T2    N0    M0
 .I TNM=300 S SG=3 Q           ;III  T3    N0    M0
 .I TNM=110 S SG=3 Q           ;     T1    N1    M0
 .I TNM=210 S SG=3 Q           ;     T2    N1    M0
 .I TNM=310 S SG=3 Q           ;     T3    N1    M0
 .I TNM="4A00" S SG="4A" Q     ;IVA  T4a   N0    M0
 .I TNM="4A10" S SG="4A" Q     ;     T4a   N1    M0
 .I TNM=120 S SG="4A" Q        ;     T1    N2    M0
 .I TNM=220 S SG="4A" Q        ;     T2    N2    M0
 .I TNM=320 S SG="4A" Q        ;     T3    N2    M0
 .I TNM="4A20" S SG="4A" Q     ;     T4a   N2    M0
 .I T="4B",M=0 S SG="4B" Q     ;IVB  T4b   Any N M0
 .I $E(N,1)=3,M=0 S SG="4B" Q  ;     Any T N3    M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
PHA12 ;Pharynx - 1st and 2nd editions
 I M[1 S SG=4
 E  I M[0 D
 .I (N[2)!(N[3) S SG=4
 .E  I N[1,(T[1)!(T[2)!(T[3)!(T[4) S SG=$S(T=4:4,1:3)
 .E  I N[0,(T[1)!(T[2)!(T[3)!(T[4) S SG=+T
 Q
 ;
PHA34 ;Pharynx - 3rd and 4th editions
 I M[1 S SG=4
 E  I M[0 D
 .I (N[2)!(N[3) S SG=4
 .E  I N[1,(T[1)!(T[2)!(T[3)!(T[4) S SG=$S(T=4:4,1:3)
 .E  I N[0,(T["IS")!(T[1)!(T[2)!(T[3)!(T[4) S SG=+T
 Q
 ;
PHAN56 ;Pharynx - nasopharynx - 5th and 6th editions
 S TNM=T_$E(N,1)_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q        ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM="2A00" S SG="2A" Q     ;IIA  T2a   N0    M0
 .I TNM=110 S SG="2B" Q        ;IIB  T1    N1    M0
 .I TNM=210 S SG="2B" Q        ;     T2    N1    M0
 .I TNM="2A10" S SG="2B" Q     ;     T2a   N1    M0
 .I TNM="2B00" S SG="2B" Q     ;     T2b   N0    M0
 .I TNM="2B10" S SG="2B" Q     ;     T2b   N1    M0
 .I TNM=120 S SG=3 Q           ;III  T1    N2    M0
 .I TNM="2A20" S SG=3 Q        ;     T2a   N2    M0
 .I TNM="2B20" S SG=3 Q        ;     T2b   N2    M0
 .I TNM=300 S SG=3 Q           ;     T3    N0    M0
 .I TNM=310 S SG=3 Q           ;     T3    N1    M0
 .I TNM=320 S SG=3 Q           ;     T3    N2    M0
 .I TNM=400 S SG="4A" Q        ;IVA  T4    N0    M0
 .I TNM=410 S SG="4A" Q        ;     T4    N1    M0
 .I TNM=420 S SG="4A" Q        ;     T4    N2    M0
 .I $E(N,1)=3,M=0 S SG="4B" Q  ;IVB  Any T N3    M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
PHAOH5 ;Pharynx - oropharynx, hypopharynx - 5th edition
 S TNM=T_$E(N,1)_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q        ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q           ;II   T2    N0    M0
 .I TNM=300 S SG=3 Q           ;III  T3    N0    M0
 .I TNM=110 S SG=3 Q           ;     T1    N1    M0
 .I TNM=210 S SG=3 Q           ;     T2    N1    M0
 .I TNM=310 S SG=3 Q           ;     T3    N1    M0
 .I TNM=400 S SG="4A" Q        ;IVA  T4    N0    M0
 .I TNM=410 S SG="4A" Q        ;     T4    N1    M0
 .I $E(N,1)=2,M=0 S SG="4A" Q  ;     Any T N2    M0
 .I $E(N,1)=3,M=0 S SG="4B" Q  ;IVB  Any T N3    M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
PHAOH6 ;Pharynx - oropharynx, hypopharynx - 6th edition
 S TNM=T_$E(N,1)_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q        ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q           ;II   T2    N0    M0
 .I TNM=300 S SG=3 Q           ;III  T3    N0    M0
 .I TNM=110 S SG=3 Q           ;     T1    N1    M0
 .I TNM=210 S SG=3 Q           ;     T2    N1    M0
 .I TNM=310 S SG=3 Q           ;     T3    N1    M0
 .I TNM="4A00" S SG="4A" Q     ;IVA  T4a   N0    M0
 .I TNM="4A10" S SG="4A" Q     ;     T4a   N1    M0
 .I TNM=120 S SG="4A" Q        ;     T1    N2    M0
 .I TNM=220 S SG="4A" Q        ;     T2    N2    M0
 .I TNM=320 S SG="4A" Q        ;     T3    N2    M0
 .I TNM="4A20" S SG="4A" Q     ;     T4a   N2    M0
 .I T="4B",M=0 S SG="4B" Q     ;IVB  T4b   Any N M0
 .I $E(N,1)=3,M=0 S SG="4B" Q  ;     Any T N3    M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
PHAN7 ;Pharynx - nasopharynx - 7th edition
 S TNM=T_$E(N,1)_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q        ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM=110 S SG=2 Q           ;II   T1    N1    M0
 .I TNM=200 S SG=2 Q           ;     T2    N0    M0
 .I TNM=210 S SG=2 Q           ;     T2    N1    M0
 .I TNM=120 S SG=3 Q           ;III  T1    N2    M0
 .I TNM=220 S SG=3 Q           ;     T2    N2    M0
 .I TNM=300 S SG=3 Q           ;     T3    N0    M0
 .I TNM=310 S SG=3 Q           ;     T3    N1    M0
 .I TNM=320 S SG=3 Q           ;     T3    N2    M0
 .I TNM=400 S SG="4A" Q        ;IVA  T4    N0    M0
 .I TNM=410 S SG="4A" Q        ;     T4    N1    M0
 .I TNM=420 S SG="4A" Q        ;     T4    N2    M0
 .I $E(N,1)=3,M=0 S SG="4B" Q  ;IVB  Any T N3    M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
LAR12 ;Larynx - 1st and 2nd editions
 I M[1 S SG=4
 E  I M[0 D
 .I (N[2)!(N[3) S SG=4
 .E  I N[1,(T[1)!(T[2)!(T[3)!(T[4) S SG=$S(T=4:4,1:3)
 .E  I N[0,(T[1)!(T[2)!(T[3)!(T[4) S SG=+T
 Q
 ;
LAR34 ;Larynx - 3rd and 4th editions
 I M[1 S SG=4
 E  I M[0 D
 .I (N[2)!(N[3) S SG=4
 .E  I N[1,(T[1)!(T[2)!(T[3)!(T[4) S SG=$S(T=4:4,1:3)
 .E  I N[0,(T["IS")!(T[1)!(T[2)!(T[3)!(T[4) S SG=+T
 Q
 ;
LAR5 ;Larynx - 5th edition
 I T="IS" S TNM=T_$E(N,1)_M
 E  S TNM=$E(T,1)_$E(N,1)_M
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q        ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q           ;II   T2    N0    M0
 .I TNM=300 S SG=3 Q           ;III  T3    N0    M0
 .I TNM=110 S SG=3 Q           ;     T1    N1    M0
 .I TNM=210 S SG=3 Q           ;     T2    N1    M0
 .I TNM=310 S SG=3 Q           ;     T3    N1    M0
 .I TNM=400 S SG="4A" Q        ;IVA  T4    N0    M0
 .I TNM=410 S SG="4A" Q        ;     T4    N1    M0
 .I $E(N,1)=2,M=0 S SG="4A" Q  ;     Any T N2    M0
 .I $E(N,1)=3,M=0 S SG="4B" Q  ;IVB  Any T N3    M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
LAR6 ;Larynx - 6th edition
 S TNM=T_$E(N,1)_M
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q        ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM="1A00" S SG=1 Q
 .I TNM="1B00" S SG=1 Q
 .I TNM=200 S SG=2 Q           ;II   T2    N0    M0
 .I TNM=300 S SG=3 Q           ;III  T3    N0    M0
 .I TNM=110 S SG=3 Q           ;     T1    N1    M0
 .I TNM="1A10" S SG=3 Q
 .I TNM="1B10" S SG=3 Q
 .I TNM=210 S SG=3 Q           ;     T2    N1    M0
 .I TNM=310 S SG=3 Q           ;     T3    N1    M0
 .I TNM="4A00" S SG="4A" Q     ;IVA  T4a   N0    M0
 .I TNM="4A10" S SG="4A" Q     ;     T4a   N1    M0
 .I TNM=120 S SG="4A" Q        ;     T1    N2    M0
 .I TNM="1A20" S SG="4A" Q
 .I TNM="1B20" S SG="4A" Q
 .I TNM=220 S SG="4A" Q        ;     T2    N2    M0
 .I TNM=320 S SG="4A" Q        ;     T3    N2    M0
 .I TNM="4A20" S SG="4A" Q     ;     T4a   N2    M0
 .I T="4B",M=0 S SG="4B" Q     ;IVB  T4b   Any N M0
 .I $E(N,1)=3,M=0 S SG="4B" Q  ;     Any T N3    M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
CLEANUP ;Cleanup
 K M,N,SG,T
