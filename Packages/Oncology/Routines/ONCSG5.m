ONCSG5 ;Hines OIFO/GWB - Automatic Staging Tables ;08/08/11
 ;;2.11;ONCOLOGY;**35,51,54**;Mar 07, 1995;Build 10
 ;
 ;GENITOURINARY SITES
 ;
PEN36 ;Penis - 3rd, 4th, 5th and 6th editions
 K SG
 I M=1 S SG=4
 E  I M=0 D PENNM
 I '$D(SG) S SG=99
 Q
PENNM I (T=4)!(N=3) S SG=4
 E  I (T="IS")!(T="A"),N=0 S SG=0
 E  I T=1,N=0 S SG=1
 E  I T=1,N=1 S SG=2
 E  I T=2,(N=0)!(N=1) S SG=2
 E  I (T=1)!(T=2),N=2 S SG=3
 E  I T=3,(N=0)!(N=1)!(N=2) S SG=3
 Q
 ;
PEN7 ;Penis - 7th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q            ;0    Tis   N0    M0
 .I TNM="A00" S SG=0 Q             ;     Ta    N0    M0
 .I TNM="1A00" S SG=1 Q            ;I    T1a   N0    M0
 .I TNM="1B00" S SG=2 Q            ;II   T1b   N0    M0
 .I TNM=200 S SG=2 Q               ;     T2    N0    M0
 .I TNM=300 S SG=2 Q               ;     T3    N0    M0
 .I $E(T,1)=1,N=1,M=0 S SG="3A" Q  ;IIIA T1    N1    M0
 .I $E(T,1)=2,N=1,M=0 S SG="3A" Q  ;     T2    N1    M0
 .I $E(T,1)=3,N=1,M=0 S SG="3A" Q  ;     T3    N1    M0
 .I $E(T,1)=1,N=2,M=0 S SG="3B" Q  ;IIIB T1    N2    M0
 .I $E(T,1)=2,N=2,M=0 S SG="3B" Q  ;     T2    N2    M0
 .I $E(T,1)=3,N=2,M=0 S SG="3B" Q  ;     T3    N2    M0
 .I T=4,M=0 S SG=4 Q               ;IV   T4    Any N M0
 .I N=3,M=0 S SG=4 Q               ;     Any T N3    M0
 .I M=1 S SG=4 Q                   ;     Any T Any N M1
 ;
PROS3 ;Prostate - 3rd edition
 I M!(N=1)!(N=2)!(N=3)!(T[4) S SG=4
 E  I T="1A"!(T="2A"),$E(N)=0,$E(M)=0,G,G'=9 S SG=$S(G=1:0,G>1:1)
 E  I T="1B"!(T="2B"),$E(N)=0,$E(M)=0 S SG=2
 E  I T=3,$E(N)=0,$E(M)=0 S SG=3
 E  S SG=99
 Q
 ;
PROS4 ;Prostate - 4th edition
 I M!(N=1)!(N=2)!(N=3)!(T[4) S SG=4
 E  I T="1A",$E(N)=0,$E(M)=0,G,G'=9 S SG=$S(G=1:0,G>1:1)
 E  I T="1B"!(T="1C")!(T=1),$E(N)=0,$E(M)=0 S SG=1
 E  I T[2,$E(N)=0,$E(M)=0 S SG=2
 E  I T[3,$E(N)=0,$E(M)=0 S SG=3
 E  S SG=99
 Q 
 ;
PROS56 ;Prostate - 5th and 6th edition
 S TNM=T_N_$E(M,1) D  K TNM Q
 .I (G=1)&(TNM="1A00") S SG=1 Q                ;I    T1a   N0 M0 G1
 .I ((G=2)!(G=3)!(G=4))&(TNM="1A00") S SG=2 Q  ;II   T1a   N0 M0 G2, 3-4
 .I TNM="1B00" S SG=2 Q                        ;     T1b   N0    M0 Any G
 .I TNM="1C00" S SG=2 Q                        ;     T1c   N0    M0 Any G
 .I TNM=100 S SG=2 Q                           ;     T1    N0    M0 Any G
 .I $E(T,1)=2,N=0,M=0 S SG=2 Q                 ;     T2    N0    M0 Any G
 .I $E(T,1)=3,N=0,M=0 S SG=3 Q                 ;III  T3    N0    M0 Any G
 .I TNM=400 S SG=4 Q                           ;IV   T4    N0    M0 Any G
 .I N=1,M=0 S SG=4 Q                           ;     Any T N1    M0 Any G
 .I $E(M,1)=1 S SG=4 Q                         ;     Any T Any N M1 Any G
 ;
PROS7 ;Prostate - 7th edition
 ;I   T1a-c  N0     M0  PSA<10      Gleason<=6 
 ;    T2a    N0     M0  PSA<10      Gleason<=6 
 ;    T1-2a  N0     M0  PSA X       Gleason X 
 ;IIA T1a-c  N0     M0  PSA<20      Gleason=7
 ;    T1a-c  N0     M0  PSA>=10<20  Gleason<=6
 ;    T2a    N0     M0  PSA>=10<20  Gleason<=6
 ;    T2a    N0     M0  PSA<20      Gleason<=7 
 ;    T2b    N0     M0  PSA<20      Gleason<=7 
 ;    T2b    N0     M0  PSA X       Gleason X 
 ;IIB T2c    N0     M0  Any PSA     Any Gleason
 ;    T1-2   N0     M0  PSA>=20     Any Gleason
 ;    T1-2   N0     M0  Any PSA     Gleason>=8
 ;III T3a-b  N0     M0  Any PSA     Any Gleason
 ;IV  T4     N0     M0  Any PSA     Any Gleason
 ;    Any T  N1     M0  Any PSA     Any Gleason
 ;    Any T  Any N  M1  Any PSA     Any Gleason
 ;
 N PSA,GS
 S PSA=+$$GET1^DIQ(165.5,D0,684)
 I (PSA=999.7)!(PSA=999.8)!(PSA=999.9) S PSA=""
 I STGIND="C" S GS=+$$GET1^DIQ(165.5,D0,623,"I")
 I STGIND="P" S GS=+$$GET1^DIQ(165.5,D0,250,"I")
 I GS=99 S GS=""
 S TNM=T_N_$E(M,1) D  K TNM Q
 .I ((TNM=100)!(TNM="1A00")!(TNM="1B00")!(TNM="1C00")),PSA<10,GS<7 S SG=1 Q
 .I (TNM="2A00"),PSA<10,GS<7 S SG=1 Q
 .I ((TNM=100)!(TNM="1A00")!(TNM="1B00")!(TNM="1C00")!(TNM=200)!(TNM="2A00")),PSA="",GS="" S SG=1 Q
 .I ((TNM=100)!(TNM="1A00")!(TNM="1B00")!(TNM="1C00")),PSA<20,GS=7 S SG="2A" Q
 .I ((TNM=100)!(TNM="1A00")!(TNM="1B00")!(TNM="1C00")!(TNM="2A00")),((PSA>9)&(PSA<20)),GS<7 S SG="2A" Q
 .I (TNM="2A00"),PSA<20,GS<8 S SG="2A" Q
 .I (TNM="2B00"),PSA<20,GS<8 S SG="2A" Q
 .I (TNM="2B00"),PSA="",GS="" S SG="2A" Q
 .I TNM="2C00" S SG="2B" Q
 .I ((TNM=100)!(TNM="1A00")!(TNM="1B00")!(TNM="1C00")!(TNM=200)!(TNM="2A00")!(TNM="2B00")!(TNM="2C00")),PSA>19 S SG="2B" Q
 .I ((TNM=100)!(TNM="1A00")!(TNM="1B00")!(TNM="1C00")!(TNM=200)!(TNM="2A00")!(TNM="2B00")!(TNM="2C00")),GS>7 S SG="2B" Q
 .I ((TNM=300)!(TNM="3A00")!(TNM="3B00")) S SG=3 Q
 .I TNM=400 S SG=4 Q
 .I N=1,M=0 S SG=4 Q
 .I $E(M,1)=1 S SG=4 Q
 ;
TES3 ;Testis - 3rd edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q
 .I TNM=100 S SG=1 Q
 .I TNM=200 S SG=1 Q
 .I TNM=300 S SG=2 Q
 .I TNM=400 S SG=2 Q
 .I N=1,M=0 S SG=3 Q
 .I N=2,M=0 S SG=4 Q
 .I N=3,M=0 S SG=4 Q
 .I M=1 S SG=4 Q
 ;
TES4 ;Testis - 4th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q      ;0    Tis   N0    M0
 .I N=0,M=0 S SG=1 Q         ;I    Any T N0    M0
 .I N=1,M=0 S SG=2 Q         ;II   Any T N1    M0
 .I N=2,M=0 S SG=2 Q         ;     Any T N2    M0
 .I N=3,M=0 S SG=2 Q         ;     Any T N3    M0
 .I M=1 S SG=3 Q             ;III  Any T Any N M1
 ;
TES56 ;Testis - 5th and 6th editions
 S STM=$P($G(^ONCO(165.5,D0,24)),U,8),STM=$E(STM,2)
 S TNM=T_N_M_STM D  K TNM,TM1,TM2,TM3,STM Q
 .I TNM="IS000" S SG=0 Q       ;0    Tis   N0    M0  S0
 .I TNM="100X" S SG=1 Q        ;I    T1    N0    M0  SX
 .I TNM="200X" S SG=1 Q        ;     T2    N0    M0  SX
 .I TNM="300X" S SG=1 Q        ;     T3    N0    M0  SX
 .I TNM="400X" S SG=1 Q        ;     T4    N0    M0  SX
 .I TNM=1000 S SG="1A" Q       ;IA   T1    N0    M0  S0
 .I TNM=2000 S SG="1B" Q       ;IB   T2    N0    M0  S0
 .I TNM=3000 S SG="1B" Q       ;     T3    N0    M0  S0
 .I TNM=4000 S SG="1B" Q       ;     T4    N0    M0  S0
 .I N=0,M=0,STM=1 S SG="1S" Q  ;IS   Any T N0    M0  S1
 .I N=0,M=0,STM=2 S SG="1S" Q  ;     Any T N0    M0  S2
 .I N=0,M=0,STM=3 S SG="1S" Q  ;     Any T N0    M0  S3
 .I N=1,M=0,STM="X" S SG=2 Q   ;II   Any T N1    M0  SX
 .I N=2,M=0,STM="X" S SG=2 Q   ;     Any T N2    M0  SX
 .I N=3,M=0,STM="X" S SG=2 Q   ;     Any T N3    M0  SX
 .I N=1,M=0,STM=0 S SG="2A" Q  ;IIA  Any T N1    M0  S0
 .I N=1,M=0,STM=1 S SG="2A" Q  ;     Any T N1    M0  S1
 .I N=2,M=0,STM=0 S SG="2B" Q  ;IIB  Any T N2    M0  S0
 .I N=2,M=0,STM=1 S SG="2B" Q  ;     Any T N2    M0  S1
 .I N=3,M=0,STM=0 S SG="2C" Q  ;IIC  Any T N3    M0  S0
 .I N=3,M=0,STM=1 S SG="2C" Q  ;     Any T N3    M0  S1
 .I M=1,STM="X" S SG=3 Q       ;III  Any T Any N M1  SX
 .I M="1A",STM=0 S SG="3A" Q   ;IIIA Any T Any N M1a S0
 .I M="1A",STM=1 S SG="3A" Q   ;     Any T Any N M1a S1
 .I N=1,M=0,STM=2 S SG="3B" Q  ;IIIB Any T N1    M0  S2
 .I N=2,M=0,STM=2 S SG="3B" Q  ;     Any T N2    M0  S2
 .I N=3,M=0,STM=2 S SG="3B" Q  ;     Any T N3    M0  S2
 .I M="1A",STM=2 S SG="3B" Q   ;     Any T Any N M1a S2
 .I N=1,M=0,STM=3 S SG="3C" Q  ;IIIC Any T N1    M0  S3
 .I N=2,M=0,STM=3 S SG="3C" Q  ;     Any T N2    M0  S3
 .I N=3,M=0,STM=3 S SG="3C" Q  ;     Any T N3    M0  S3
 .I M="1A",STM=3 S SG="3C" Q   ;     Any T Any N M1a S3
 .I M="1B" S SG="3C" Q         ;     Any T Any N M1b Any S
 ;
KID34 ;Kidney - 3rd and 4th editions
 K SG
 I M=1 S SG=4
 E  I M=0 D KIDNM
 I '$D(SG) S SG=99
 Q
KIDNM I (T=4)!(N=2)!(N=3) S SG=4
 E  I T=1,N=0 S SG=1
 E  I T=2,N=0 S SG=2
 E  I (T=1)!(T=2),N=1 S SG=3
 E  I T[3,(N=0)!(N=1) S SG=3
 Q
 ;
KID5 ;Kidney - 5th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q            ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q            ;II   T2    N0    M0
 .I TNM=110 S SG=3 Q            ;III  T1    N1    M0
 .I TNM=210 S SG=3 Q            ;     T2    N1    M0
 .I TNM="3A00" S SG=3 Q         ;     T3a   N0    M0
 .I TNM="3A10" S SG=3 Q         ;     T3a   N1    M0
 .I TNM="3B00" S SG=3 Q         ;     T3b   N0    M0
 .I TNM="3B10" S SG=3 Q         ;     T3b   N1    M0
 .I TNM="3C00" S SG=3 Q         ;     T3c   N0    M0
 .I TNM="3C10" S SG=3 Q         ;     T3c   N1    M0
 .I TNM=400 S SG=4 Q            ;IV   T4    N0    M0
 .I TNM=410 S SG=4 Q            ;     T4    N1    M0
 .;per R-AD 01/13/98
 .I TNM="4X0",STGIND="P" S SG=4 ;     T4    NX    M0 (Pathologic staging)
 .I N=2,M=0 S SG=4 Q            ;     Any T N2    M0
 .I M=1 S SG=4 Q                ;     Any T Any N M1
 ;
KID6 ;Kidney - 6th edition
 S TNM=T_N_M D  K TNM Q
 .I $E(T,1)=1,N=0,M=0 S SG=1 Q  ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q            ;II   T2    N0    M0
 .I $E(T,1)=1,N=1,M=0 S SG=3 Q  ;III  T1    N1    M0
 .I TNM=210 S SG=3 Q            ;     T2    N1    M0
 .I TNM=300 S SG=3 Q            ;     T3    N0    M0
 .I TNM=310 S SG=3 Q            ;     T3    N1    M0
 .I TNM="3A00" S SG=3 Q         ;     T3a   N0    M0
 .I TNM="3A10" S SG=3 Q         ;     T3a   N1    M0
 .I TNM="3B00" S SG=3 Q         ;     T3b   N0    M0
 .I TNM="3B10" S SG=3 Q         ;     T3b   N1    M0
 .I TNM="3C00" S SG=3 Q         ;     T3c   N0    M0
 .I TNM="3C10" S SG=3 Q         ;     T3c   N1    M0
 .I TNM=400 S SG=4 Q            ;IV   T4    N0    M0
 .I TNM=410 S SG=4 Q            ;     T4    N1    M0
 .;per R-AD 01/13/98
 .I TNM="4X0",STGIND="P" S SG=4 ;     T4    NX    M0 (Pathologic staging)
 .I N=2,M=0 S SG=4 Q            ;     Any T N2    M0
 .I M=1 S SG=4 Q                ;     Any T Any N M1
 ;
KID7 ;Kidney - 7th edition
 S TNM=$E(T,1)_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q            ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q            ;II   T2    N0    M0
 .I TNM=110 S SG=3 Q            ;III  T1    N1    M0
 .I TNM=210 S SG=3 Q            ;     T2    N1    M0
 .I TNM=300 S SG=3 Q            ;     T3    N0    M0
 .I TNM=310 S SG=3 Q            ;     T3    N1    M0
 .I T=4,M=0 S SG=4 Q            ;IV   T4    Any N M0
 .I M=1 S SG=4 Q                ;     Any T Any N M1
 ;
CLEANUP ;Cleanup
 K D0,G,M,N,STGIND,T
