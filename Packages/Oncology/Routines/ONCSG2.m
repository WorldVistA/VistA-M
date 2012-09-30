ONCSG2 ;Hines OIFO/GWB - Automatic Staging Tables ;07/26/11
 ;;2.11;ONCOLOGY;**35,36,51,52,54**;Mar 07, 1995;Build 10
 ;
 ;THORAX
 ;
LUN34 ;Lung - 3rd and 4th editions
 S SG=99
 I M=1 S SG=4
 E  I M=0 D
 .I T=4 S SG="3B"
 .E  I N=3 S SG="3B"
 .E  I N=2 S SG=$S(T=1:"3A",T=2:"3A",T=3:"3A",1:99)
 .E  I N=1 S SG=$S(T=1:2,T=2:2,T=3:"3A",1:99)
 .E  I N=0 S SG=$S(T="X":"OC",T="IS":0,T=1:1,T=2:1,T=3:"3A",1:99)
 Q
 ;
LUN56 ;Lung - 5th and 6th editions
 S TNM=T_N_M D  K TNM Q
 .I TNM="X00" S SG="OC" Q   ;Occult Tx    N0    M0
 .I TNM="IS00" S SG=0 Q     ;0      Tis   N0    M0
 .I TNM=100 S SG="1A" Q     ;IA     T1    N0    M0
 .I TNM=200 S SG="1B" Q     ;IB     T2    N0    M0
 .I TNM=110 S SG="2A" Q     ;IIA    T1    N1    M0
 .I TNM=210 S SG="2B" Q     ;IIB    T2    N1    M0
 .I TNM=300 S SG="2B" Q     ;       T3    N0    M0
 .I TNM=120 S SG="3A" Q     ;IIIA   T1    N2    M0
 .I TNM=220 S SG="3A" Q     ;       T2    N2    M0
 .I TNM=310 S SG="3A" Q     ;       T3    N1    M0
 .I TNM=320 S SG="3A" Q     ;       T3    N2    M0
 .I N=3,M=0 S SG="3B" Q     ;IIIB   Any T N3    M0
 .I T=4,M=0 S SG="3B" Q     ;       T4    Any N M0
 .I M=1 S SG=4 Q            ;IV     Any T Any N M1
 ;
LUN7 ;Lung - 7th editions
 S TNM=T_N_M D  K TNM Q
 .I TNM="X00" S SG="OC" Q   ;Occult Tx    N0    M0
 .I TNM="IS00" S SG=0 Q     ;0      Tis   N0    M0
 .I TNM="1A00" S SG="1A" Q  ;IA     T1a   N0    M0
 .I TNM="1B00" S SG="1A" Q  ;       T1b   N0    M0
 .I TNM="2A00" S SG="1B" Q  ;IB     T2a   N0    M0
 .I TNM="2B00" S SG="2A" Q  ;IIA    T2a   N0    M0
 .I TNM="1A10" S SG="2A" Q  ;       T1a   N1    M0
 .I TNM="1B10" S SG="2A" Q  ;       T1b   N1    M0
 .I TNM="2A10" S SG="2A" Q  ;       T2a   N1    M0
 .I TNM="2B10" S SG="2B" Q  ;IIB    T2b   N1    M0
 .I TNM=300 S SG="2B" Q     ;       T3    N0    M0
 .I TNM="1A20" S SG="3A" Q  ;IIIA   T1a   N2    M0
 .I TNM="1B20" S SG="3A" Q  ;       T1b   N2    M0
 .I TNM="2A20" S SG="3A" Q  ;       T2a   N2    M0
 .I TNM="2B20" S SG="3A" Q  ;       T2b   N2    M0
 .I TNM=310 S SG="3A" Q     ;       T3    N1    M0
 .I TNM=320 S SG="3A" Q     ;       T3    N2    M0
 .I TNM=400 S SG="3A" Q     ;       T4    N0    M0
 .I TNM=410 S SG="3A" Q     ;       T4    N1    M0
 .I TNM="1A30" S SG="3B" Q  ;IIIB   T1a   N3    M0
 .I TNM="1B30" S SG="3B" Q  ;       T1b   N3    M0
 .I TNM="2A30" S SG="3B" Q  ;       T2a   N3    M0
 .I TNM="2B30" S SG="3B" Q  ;       T2b   N3    M0
 .I TNM=330 S SG="3B" Q     ;       T3    N3    M0
 .I TNM=420 S SG="3B" Q     ;       T4    N2    M0
 .I TNM=430 S SG="3B" Q     ;       T4    N3    M0
 .I M=1 S SG=4 Q            ;IV     Any T Any N M1
 .I M="1A" S SG=4 Q         ;       Any T Any N M1a
 .I M="1B" S SG=4 Q         ;       Any T Any N M1b
 ;
PM45 ;Pleural Mesothelioma - 4th and 5th editions
 I M S SG=4
 E  I T[4,M[0 S SG=4
 E  I N[3,M[0 S SG=4
 E  I (T[1)!(T[2),N[0,M[0 S SG=1
 E  I (T[1)!(T[2),N[1,M[0 S SG=2
 E  I (T[1)!(T[2),N[2,M[0 S SG=3
 E  I T[3,(N[0)!(N[1)!(N[2),M[0 S SG=3
 E  S SG=99
 Q
 ;
PM6 ;Pleural Mesothelioma - 6th and 7th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q        ;I      T1    N0    M0
 .I TNM="1A00" S SG="1A" Q  ;IA     T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q  ;IB     T1b   N0    M0
 .I TNM=200 S SG=2 Q        ;II     T2    N0    M0
 .I TNM=110 S SG=3 Q        ;III    T1    N1    M0
 .I TNM=210 S SG=3 Q        ;       T2    N1    M0
 .I TNM=120 S SG=3 Q        ;       T1    N2    M0
 .I TNM=220 S SG=3 Q        ;       T2    N2    M0
 .I TNM=300 S SG=3 Q        ;       T3    N0    M0
 .I TNM=310 S SG=3 Q        ;       T3    N1    M0
 .I TNM=320 S SG=3 Q        ;       T3    N2    M0
 .I T=4,M=0 S SG=4 Q        ;IV     T4    Any N M0
 .I N=3,M=0 S SG=4 Q        ;       Any T N3    M0
 .I M=1 S SG=4 Q            ;       Any T Any N M1
 ;
 ;MUSCULOSKELETAL SITES
 ;
BONE345 ;Bone - 3rd, 4th and 5th editions
 K SG
 I M=1 S SG="4B"
 E  I M=0 D
 .I N=1 S SG="4A"
 .E  I N=0 D BONLG
 I '$D(SG) S SG=99
 Q
 ;
BONLG ;Bone - 3rd, 4th and 5th editions (continued)
 I (G=1)!(G=2) D
 .I T=1 S SG="1A"
 .E  I T=2 S SG="1B"
 E  I (G=3)!(G=4) D
 .I T=1 S SG="2A"
 .E  I T=2 S SG="2B"
 Q
 ;
BONE6 ;Bone - 6th edition
 S TNM=T_N_M D  K TNM Q
 .I ((G=1)!(G=2))&(TNM=100) S SG="1A" Q  ;IA  T1    N0    M0    G1,2
 .I ((G=1)!(G=2))&(TNM=200) S SG="1B" Q  ;IB  T2    N0    M0    G1,2
 .I ((G=3)!(G=4))&(TNM=100) S SG="2A" Q  ;IIA T1    N0    M0    G3,4
 .I ((G=3)!(G=4))&(TNM=200) S SG="2B" Q  ;IIB T2    N0    M0    G3,4
 .I TNM=300 S SG=3 Q                     ;III T3    N0    M0    Any G
 .I N=0,M="1A" S SG="4A" Q               ;IVA Any T N0    M1a   Any G
 .I N=1 S SG="4B" Q                      ;IVB Any T N1    Any M Any G
 .I M="1B" S SG="4B" Q                   ;    Any T Any N M1b   Any G
 ;
BONE7 ;Bone - 7th edition
 S TNM=T_N_M D  K TNM Q
 .I ((G=1)!(G=2))&(TNM=100) S SG="1A" Q  ;IA  T1    N0    M0    G1,2
 .I ((G=1)!(G=2))&(TNM=200) S SG="1B" Q  ;IB  T2    N0    M0    G1,2
 .I ((G=1)!(G=2))&(TNM=300) S SG="1B" Q  ;IB  T3    N0    M0    G1,2
 .I ((G=3)!(G=4))&(TNM=100) S SG="2A" Q  ;IIA T1    N0    M0    G3,4
 .I ((G=3)!(G=4))&(TNM=200) S SG="2B" Q  ;IIB T2    N0    M0    G3,4
 .I ((G=3)!(G=4))&(TNM=300) S SG=3 Q     ;III T3    N0    M0    G3,4
 .I N=0,M="1A" S SG="4A" Q               ;IVA Any T N0    M1a   Any G
 .I N=1 S SG="4B" Q                      ;IVB Any T N1    Any M Any G
 .I M="1B" S SG="4B" Q                   ;    Any T Any N M1b   Any G
 ;
STS34 ;Soft Tissue Sarcoma - 3rd and 4th editions
 I $E(M)=1 S SG="4B"
 E  I $E(M)=0 D
 .I $E(N)=1 S SG="4A"
 .E  I $E(N)=0,(G=1)!(G=2)!(G=3)!(G=4),(T=1)!(T=2) S SG=$S(G=1:1,G=2:2,1:3)_$S(T=1:"A",1:"B")
 I '$D(SG) S SG=99
 Q
 ;
STS5 ;Soft Tissue Sarcoma - 5th edition
 S TNM=T_N_M D  K TNM Q
 .I ((G=1)!(G=2))&(TNM="1A00") S SG="1A" Q  ;IA  G1-2  T1a   N0 M0
 .I ((G=1)!(G=2))&(TNM="1B00") S SG="1A" Q  ;          T1b   N0 M0
 .I ((G=1)!(G=2))&(TNM="2A00") S SG="1B" Q  ;IB  G1-2  T2a   N0 M0
 .I ((G=1)!(G=2))&(TNM="2B00") S SG="2A" Q  ;IIA G1-2  T2b   N0 M0
 .I ((G=3)!(G=4))&(TNM="1A00") S SG="2B" Q  ;IIB G3-4  T1a   N0 M0
 .I ((G=3)!(G=4))&(TNM="1B00") S SG="2B" Q  ;          T1b   N0 M0
 .I ((G=3)!(G=4))&(TNM="2A00") S SG="2C" Q  ;IIC G3-4  T2a   N0 M0
 .I ((G=3)!(G=4))&(TNM="2B00") S SG=3 Q     ;III G3-4  T2b   N0 M0
 .I N=1,M=0 S SG=4 Q                        ;IV  Any G Any T N1 M0
 .I N=0,M=1 S SG=4 Q                        ;IV  Any G Any T N0 M1
 .I N=1,M=1 S SG=4 Q                        ;IV  Any G Any T N1 M1
 ;
STS6 ;Soft Tissue Sarcoma - 6th edition
 S TNM=T_N_M D  K TNM Q
 .I ((G=1)!(G=2))&(TNM="1A00") S SG="1A" Q  ;IA   T1a   N0 M0 G1-2
 .I ((G=1)!(G=2))&(TNM="1AX0") S SG="1A" Q  ;     T1a   NX M0 G1-2
 .I ((G=1)!(G=2))&(TNM="1B00") S SG="1A" Q  ;     T1b   N0 M0 G1-2
 .I ((G=1)!(G=2))&(TNM="1BX0") S SG="1A" Q  ;     T1b   NX M0 G1-2
 .I ((G=1)!(G=2))&(TNM="2A00") S SG="1B" Q  ;IB   T2a   N0 M0 G1-2
 .I ((G=1)!(G=2))&(TNM="2AX0") S SG="1B" Q  ;     T2a   NX M0 G1-2
 .I ((G=1)!(G=2))&(TNM="2B00") S SG="1B" Q  ;     T2b   N0 M0 G1-2
 .I ((G=1)!(G=2))&(TNM="2BX0") S SG="1B" Q  ;     T2b   NX M0 G1-2
 .I ((G=3)!(G=4))&(TNM="1A00") S SG="2A" Q  ;IIA  T1a   N0 M0 G3-4
 .I ((G=3)!(G=4))&(TNM="1AX0") S SG="2A" Q  ;     T1a   NX M0 G3-4
 .I ((G=3)!(G=4))&(TNM="1B00") S SG="2A" Q  ;     T1b   N0 M0 G3-4
 .I ((G=3)!(G=4))&(TNM="1BX0") S SG="2A" Q  ;     T1b   NX M0 G3-4
 .I ((G=3)!(G=4))&(TNM="2A00") S SG="2B" Q  ;IIB  T2a   N0 M0 G3-4
 .I ((G=3)!(G=4))&(TNM="2AX0") S SG="2B" Q  ;     T2a   NX M0 G3-4
 .I ((G=3)!(G=4))&(TNM="2B00") S SG=3 Q     ;III  T2b   N0 M0 G3-4
 .I ((G=3)!(G=4))&(TNM="2BX0") S SG=3 Q     ;     T2b   NX M0 G3-4
 .I N=1,M=0 S SG=4 Q                        ;IV   Any T N1 M0 Any G
 .I N=0,M=1 S SG=4 Q                        ;     Any T N0 M1 Any G
 .I N=1,M=1 S SG=4 Q                        ;     Any T N1 M1 Any G
 ;
STS7 ;Soft Tissue Sarcoma - 7th edition
 S TNM=T_N_M D  K TNM Q
 .I ((G=1)!(G=9))&(TNM="1A00") S SG="1A" Q  ;IA   T1a   N0    M0 G1,GX
 .I ((G=1)!(G=9))&(TNM="1B00") S SG="1A" Q  ;     T1b   N0    M0 G1,GX
 .I ((G=1)!(G=9))&(TNM="2A00") S SG="1B" Q  ;IB   T2a   N0    M0 G1,GX
 .I ((G=1)!(G=9))&(TNM="2B00") S SG="1B" Q  ;     T2b   N0    M0 G1,GX
 .I ((G=2)!(G=3))&(TNM="1A00") S SG="2A" Q  ;IIA  T1a   N0    M0 G2,3
 .I ((G=2)!(G=3))&(TNM="1B00") S SG="2A" Q  ;     T1b   N0    M0 G2,3
 .I G=2,TNM="2A00" S SG="2B" Q              ;IIB  T2a   N0    M0 G2
 .I G=2,TNM="2B00" S SG="2B" Q              ;     T2b   N0    M0 G2
 .I G=3,TNM="2A00" S SG=3 Q                 ;III  T2a   N0    M0 G3
 .I G=3,TNM="2B00" S SG=3 Q                 ;     T2b   N0    M0 G3
 .I N=1,M=0 S SG=3 Q                        ;     Any T N1    M0 Any G
 .I M=1 S SG=4 Q                            ;IV   Any T Any N M1 Any G
 ;
CLEANUP ;Cleanup
 K G,M,N,T
