ONCSG0A ;Hines OIFO/GWB - AUTOMATIC STAGING TABLES ;10/28/10
 ;;2.11;ONCOLOGY;**35,41,43,50,52**;Mar 07, 1995;Build 13
 ;
 ;HEAD AND NECK SITES (continued)
 ;
PAR12 ;Paranasal Sinuses - 1st and 2nd editions
 I M[1 S SG=4
 E  I M[0 D
 .I (N[2)!(N[3) S SG=4
 .E  I N[1,(T[1)!(T[2)!(T[3)!(T[4) S SG=$S(T=4:4,1:3)
 .E  I N[0,(T[1)!(T[2)!(T[3)!(T[4) S SG=+T
 Q
 ;
PAR34 ;Paranasal Sinuses - 3rd and 4th editions
 I M[1 S SG=4
 E  I M[0 D
 .I (N[2)!(N[3) S SG=4
 .E  I N[1,(T[1)!(T[2)!(T[3)!(T[4) S SG=$S(T=4:4,1:3)
 .E  I N[0,(T["IS")!(T[1)!(T[2)!(T[3)!(T[4) S SG=+T
 Q
 ;
PAR5 ;Paranasal Sinuses - 5th edition
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
 .I $E(N,1)=2,M=0 S SG="4B" Q  ;IVB  Any T N2    M0
 .I $E(N,1)=3,M=0 S SG="4B" Q  ;     Any T N3    M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
PAR6 ;Paranasal Sinuses - 6th edition
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
SAL12 ;Major Salivary Glands - 1st and 2nd editions
 I M[1 S SG=4
 E  I M[0 D
 .I N[1,(T[1)!(T[2)!(T[3)!(T[4) S SG=$S(T>2:4,1:3)
 .E  I N[0,(T[1)!(T[2)!(T[3)!(T[4) S SG=$S(T[4:3,T[3:2,1:1)
 Q
 ;
SAL34 ;Major Salivary Glands - 3rd and 4th editions
 I M S SG=4
 E  I (T["4B")!(N[2)!(N[3),M[0 S SG=4
 E  I (T["1A")!(T["2A"),N[0,M[0 S SG=1
 E  I (T["1B")!(T["2B")!(T["3A"),N[0,M[0 S SG=2
 E  I (T["3B")!(T["4A"),N[0,M[0 S SG=3
 E  I N[1,M[0 S SG=3
 Q
 ;
SAL5 ;Major Salivary Glands - 5th edition
 S TNM=T_$E(N,1)_M D  K TNM Q
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM=200 S SG=1 Q           ;     T2    N0    M0
 .I TNM=300 S SG=2 Q           ;II   T3    N0    M0
 .I TNM=110 S SG=3 Q           ;III  T1    N1    M0
 .I TNM=210 S SG=3 Q           ;     T2    N1    M0
 .I TNM=400 S SG=4 Q           ;IV   T4    N0    M0
 .I TNM=310 S SG=4 Q           ;     T3    N1    M0
 .I TNM=410 S SG=4 Q           ;     T4    N1    M0
 .I $E(N,1)=2,M=0 S SG=4 Q     ;     Any T N2    M0
 .I $E(N,1)=3,M=0 S SG=4 Q     ;     Any T N3    M0
 .I M=1 S SG=4 Q               ;     Any T Any N M1
 ;
SAL6 ;Major Salivary Glands - 6th edition
 S TNM=T_$E(N,1)_M D  K TNM Q
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
 .I N=3,M=0 S SG="4B" Q        ;     Any T N3    M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
THY15 K SG
 I G=4 S SG=4
 E  D
 .N MO S MO=$$HIST^ONCFUNC(D0)
 .D @$S((MO=85103)!(MO=85113):"THYDM",1:"THYDPF")
 I '$D(SG) S SG=99
 Q
 ;
THYDM ;Thyroid - Medullary
 I M S SG=4
 E  I T[1,N[0,M[0 S SG=1
 E  I (T[2)!(T[3)!(T[4),N[0,M[0 S SG=2
 E  I N[1,M[0 S SG=3
 E  S SG=99
 Q
 ;
THYDPF ;Thyroid - Papillary or Follicular
 N OKMO
 S OKMO=("^80503^82603^82900^82903^83300^83303^83313^83323^83333^83340^83403^83503^80203^"[(U_MO_U))
 I 'OKMO W:$G(RESTAGE)="" !!?12,"Histology code is incompatible." Q
 E  D
 .D AGE^ONCOCOM
 .I X<45 S SG=$S(M[1:2,M[0:1,1:"E")
 .E  D THYDP45
 Q
 ;
THYDP45 ;THYROID - Papillary or Follicular - 45 years and older
 I M[1 S SG=4
 E  I M[0 D
 .I N[1 S SG=3
 .E  I N[0 D
 ..I T[1 S SG=1
 ..E  I (T[2)!(T[3) S SG=2
 ..E  I T[4 S SG=3
 Q
 ;
THY6 ;Thyroid Gland - 6th and 7th editions
 D AGE^ONCOCOM
 S MO=$$HIST^ONCFUNC(D0)
 S OKMO="80503^82603^82903^83303^83313^83323^83353^83403^83413^83423^83433^83443^83503" ;Papillary or Follicular
 I X<45,OKMO[MO S SG=$S(M=0:1,M=1:2,1:99) D  Q
 .Q:$G(RESTAGE)="YES"
 .W !!,?12,"NOTE: Papillary or Follicular"
 .W !,?12,"      Under 45 years"
 S TNM=$E(T,1)_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q           ;II   T2    N0    M0
 .I TNM=300 S SG=3 Q           ;III  T3    N0    M0
 .I TNM="11A0" S SG=3 Q        ;     T1    N1a   M0
 .I TNM="21A0" S SG=3 Q        ;     T2    N1a   M0
 .I TNM="31A0" S SG=3 Q        ;     T3    N1a   M0
 .I TNM="4A00" S SG="4A" Q     ;IVA  T4a   N0    M0
 .I TNM="4A1A0" S SG="4A" Q    ;     T4a   N1a   M0
 .I TNM="11B0" S SG="4A" Q     ;     T1    N1b   M0
 .I TNM="21B0" S SG="4A" Q     ;     T2    N1b   M0
 .I TNM="31B0" S SG="4A" Q     ;     T3    N1b   M0
 .I TNM="4A1B0" S SG="4A" Q    ;     T4a   N1b   M0
 .I T="4B",M=0 S SG="4B" Q     ;IVB  T4b   Any N M0
 .I M=1 S SG="4C" Q            ;IVC  Any T Any N M1
 ;
CLEANUP ;Cleanup
 K D0,G,M,N,RESTAGE,T,X
