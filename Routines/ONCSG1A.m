ONCSG1A ;Hines OIFO/GWB - Automatic Staging Tables ;06/23/10
 ;;2.11;ONCOLOGY;**35,51**;Mar 07, 1995;Build 65
 ;
 ;DIGESTIVE SYSTEM (continued)
 ;
LIV34 ;Liver - 3rd and 4th editions
 S TNM=T_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=110 S SG=3 Q        ;III  T1    N1    M0
 .I TNM=210 S SG=3 Q        ;     T2    N1    M0
 .I TNM=300 S SG=3 Q        ;     T3    N0    M0
 .I TNM=310 S SG=3 Q        ;     T3    N1    M0
 .I T=4,M=0 S SG="4A" Q     ;IVA  T4    Any N M0
 .I M=1 S SG="4B" Q         ;IVB  Any T Any N M1
 ;
LIV5 ;Liver - 5th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=300 S SG="3A" Q     ;IIIA T3    N0    M0
 .I TNM=110 S SG="3B" Q     ;IIIB T1    N1    M0
 .I TNM=210 S SG="3B" Q     ;     T2    N1    M0
 .I TNM=310 S SG="3B" Q     ;     T3    N1    M0
 .I T=4,M=0 S SG="4A" Q     ;IVA  T4    Any N M0
 .I M=1 S SG="4B" Q         ;IVB  Any T Any N M1
 ;
LIV6 ;Liver - 6th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=300 S SG="3A" Q     ;IIIA T3    N0    M0
 .I TNM=400 S SG="3B" Q     ;IIIB T4    N0    M0
 .I N=1,M=0 S SG="3C" Q     ;IIIC Any T N1    M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
LIV7 ;Liver and Intrahepatic Bile Ducts - 7th edition
 I TX=67221 G IBD
 ;Liver (C22.0)
 S TNM=T_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM="3A00" S SG="3A" Q  ;IIIA T3a   N0    M0
 .I TNM="3B00" S SG="3B" Q  ;IIIB T3b   N0    M0
 .I TNM=400 S SG="3C" Q     ;IIIC T4    N0    M0
 .I N=1,M=0 S SG="4A"       ;IVA  Any T N1    M0 
 .I M=1 S SG="4B" Q         ;IVB  Any T Any N M1
 ;
IBD ;Intrahepatic Bile Ducts (C22.1)
 I T="IS" S TNM=T_N_M
 E  S TNM=$E(T,1)_N_M
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=300 S SG=3 Q        ;III  T3    N0    M0
 .I TNM=400 S SG="4A" Q     ;IVA  T4    N0    M0
 .I N=1,M=0 S SG="4A"       ;     Any T N1    M0 
 .I M=1 S SG="4B" Q         ;IVB  Any T Any N M1
 ;
GB3 ;Gallbladder - 3rd edition
 I T="IS" S TNM=T_$E(N,1)_M
 E  S TNM=$E(T,1)_$E(N,1)_M
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=110 S SG=3 Q        ;III  T1    N1    M0
 .I TNM=210 S SG=3 Q        ;     T2    N1    M0
 .I T=3,M=0 S SG=3 Q        ;     T3    Any N M0
 .I T=4,M=0 S SG=4 Q        ;IV   T4    Any N M0
 .I M=1 S SG=4 Q            ;     Any T Any N M1
 ;
GB45 ;Gallbladder - 4th and 5th editions
 I T="IS" S TNM=T_N_M
 E  S TNM=$E(T,1)_N_M
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=110 S SG=3 Q        ;III  T1    N1    M0
 .I TNM=210 S SG=3 Q        ;     T2    N1    M0
 .I TNM=300 S SG=3 Q        ;     T3    N0    M0
 .I TNM=310 S SG=3 Q        ;     T3    N1    M0
 .I TNM=400 S SG="4A" Q     ;IVA  T4    N0    M0
 .I TNM=410 S SG="4A" Q     ;     T4    N1    M0
 .I N=2,M=0 S SG="4B" Q     ;IVB  Any T N2    M0
 .I M=1 S SG="4B" Q         ;     Any T Any N M1
 ;
GB6 ;Gallbladder - 6th edition
 I T="IS" S TNM=T_N_M
 E  S TNM=$E(T,1)_N_M
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q     ;IA   T1    N0    M0
 .I TNM=200 S SG="1B" Q     ;IB   T2    N0    M0
 .I TNM=300 S SG="2A" Q     ;IIA  T3    N0    M0
 .I TNM=110 S SG="2B" Q     ;IIB  T1    N1    M0
 .I TNM=210 S SG="2B" Q     ;     T2    N1    M0
 .I TNM=310 S SG="2B" Q     ;     T3    N1    M0
 .I T=4,M=0 S SG=3 Q        ;III  T4    Any N M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
GB7 ;Gallbladder - 7th edition
 I T="IS" S TNM=T_N_M
 E  S TNM=$E(T,1)_N_M
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=300 S SG="3A" Q     ;IIIA T3    N0    M0
 .I TNM=110 S SG="3B" Q     ;IIIB T1    N1    M0
 .I TNM=210 S SG="3B" Q     ;     T2    N1    M0
 .I TNM=310 S SG="3B" Q     ;     T3    N1    M0
 .I TNM=400 S SG="4A" Q     ;IVA  T4    N0    M0
 .I TNM=410 S SG="4A" Q     ;     T4    N1    M0
 .I N=2,M=0 S SG="4B"       ;IVB  Any T N2    M0
 .I M=1 S SG="4B" Q         ;     Any T Any N M1
 ;
EBD3 ;Extrahepatic Bile Ducts - 3rd edition
 S SG=$S(M:"4B",T=3:"4A",+N=1:3,T=2:2,+T=1:1,T="IS":0,1:"E")
 Q
 ;
EBD45 ;Extrahepatic Bile Ducts - 4th and 5th editions
 S SG=$S(M:"4B",T=3:"4A",N&T:3,T=2:2,+T=1:1,T="IS":0,1:"E")
 Q
 ;
EBD6 ;Extrahepatic Bile Ducts - 6th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q     ;IA   T1    N0    M0
 .I TNM=200 S SG="1B" Q     ;IB   T2    N0    M0
 .I TNM=300 S SG="2A" Q     ;IIA  T3    N0    M0
 .I TNM=110 S SG="2B" Q     ;IIB  T1    N1    M0
 .I TNM=210 S SG="2B" Q     ;     T2    N1    M0
 .I TNM=310 S SG="2B" Q     ;     T3    N1    M0
 .I T=4,M=0 S SG=3 Q        ;III  T4    Any N M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
PBD ;Perihilar Bile Ducts - 7th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM="2A00" S SG=2 Q     ;II   T2a   N0    M0
 .I TNM="2B00" S SG=2 Q     ;     T2b   N0    M0
 .I TNM=300 S SG="3A" Q     ;IIIA T3    N0    M0
 .I TNM=110 S SG="3B" Q     ;IIIB T1    N1    M0
 .I TNM="2A10" S SG="3B" Q  ;     T2a   N1    M0
 .I TNM="2B10" S SG="3B" Q  ;     T2b   N1    M0
 .I TNM=310 S SG="3B" Q     ;     T3    N1    M0
 .I TNM=400 S SG="4A" Q     ;IVA  T4    N0    M0
 .I TNM=410 S SG="4A" Q     ;     T4    N1    M0
 .I N=2,M=0 S SG="4B" Q     ;IVB  Any T N2    M0
 .I M=1 S SG="4B" Q         ;     Any T Any N M1
 ;
DBD ;Distal Bile Duct - 7th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q     ;IA   T1    N0    M0
 .I TNM=200 S SG="1B" Q     ;IB   T2    N0    M0
 .I TNM=300 S SG="2A" Q     ;IIA  T3    N0    M0
 .I TNM=110 S SG="2B" Q     ;IIB  T1    N1    M0
 .I TNM=210 S SG="2B" Q     ;     T2    N1    M0
 .I TNM=310 S SG="SB" Q     ;     T3    N1    M0
 .I T=4,M=0 S SG=4 Q        ;III  T4    Any N M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
AV345 ;Ampulla of Vater - 3rd, 4th and 5th editions
 K SG
 I M=1 S SG=4
 E  I M=0 D
 .I T="IS",N=0 S SG=0
 .E  I T=1,N=0 S SG=1
 .E  I (T=2)!(T=3),N=0 S SG=2
 .E  I (T=1)!(T=2)!(T=3),N=1 S SG=3
 .E  I T=4 S SG=4
 I '$D(SG) S SG=99
 Q
 ;
AV6 ;Ampulla of Vater - 6th and 7th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q     ;IA   T1    N0    M0
 .I TNM=200 S SG="1B" Q     ;IB   T2    N0    M0
 .I TNM=300 S SG="2A" Q     ;IIA  T3    N0    M0
 .I TNM=110 S SG="2B" Q     ;IIB  T1    N1    M0
 .I TNM=210 S SG="2B" Q     ;     T2    N1    M0
 .I TNM=310 S SG="2B" Q     ;     T3    N1    M0
 .I T=4,M=0 S SG=3 Q        ;III  T4    Any N M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
EXO34 ;Exocrine Pancreas - 3rd and 4th editions
 S SG=99
 I M=1 S SG=4
 E  I M=0 D
 .I (T[1)!(T=2),N=0 S SG=1
 .E  I T=3,N=0 S SG=2
 .E  I N=1 S SG=3
 Q
 ;
EXO5 ;Exocrine Pancreas - 5th edition
 S TNM=T_$E(N,1)_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=1 Q        ;     T2    N0    M0
 .I TNM=300 S SG=2 Q        ;II   T3    N0    M0
 .I TNM=110 S SG=3 Q        ;III  T1    N1    M0
 .I TNM=210 S SG=3 Q        ;     T2    N1    M0
 .I TNM=310 S SG=3 Q        ;     T3    N1    M0
 .I T=4,M=0 S SG="4A" Q     ;IVA  T4    Any N M0
 .I M=1 S SG="4B" Q         ;IVB  Any T Any N M1
 ;
EXO6 ;Exocrine Pancreas - 6th and 7th edition
 S TNM=T_$E(N,1)_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q     ;IA   T1    N0    M0
 .I TNM=200 S SG="1B" Q     ;IB   T2    N0    M0
 .I TNM=300 S SG="2A" Q     ;IIA  T3    N0    M0
 .I TNM=110 S SG="2B" Q     ;IIB  T1    N1    M0
 .I TNM=210 S SG="2B" Q     ;     T2    N1    M0
 .I TNM=310 S SG="2B" Q     ;     T3    N1    M0
 .I T=4,M=0 S SG=3 Q        ;III  T4    Any N M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
CLEANUP ;Cleanup
 K M,N,T,TX
