ONCSG4A ;Hines OIFO/GWB - AUTOMATIC STAGING TABLES ;07/15/02
 ;;2.11;ONCOLOGY;**35**;Mar 07, 1995
 ;
 ;GYNECOLOGICAL SITES (continued)
 ;
OVA345 ;Ovary - 3rd, 4th and 5th editions
 I M S SG=4
 E  I $E(M)=0,$E(N)=0,$L(T)=2,"123"[$E(T),"ABC"[$E(T,2) S SG=T
 E  I $E(N)=1,$E(M)=0 S SG="3C"
 E  S SG=99
 Q
 ;
OVA6 ;Ovary - 6th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q          ;I    T1    N0    M0
 .I TNM="1A00" S SG="1A" Q    ;IA   T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q    ;IB   T1b   N0    M0
 .I TNM="1C00" S SG="1C" Q    ;IC   T1c   N0    M0
 .I TNM=200 S SG=2 Q          ;II   T2    N0    M0
 .I TNM="2A00" S SG="2A" Q    ;IIA  T2a   N0    M0
 .I TNM="2B00" S SG="2B" Q    ;IIB  T2b   N0    M0
 .I TNM="2C00" S SG="2C" Q    ;IIC  T2c   N0    M0
 .I TNM=300 S SG=3 Q          ;III  T3    N0    M0
 .I TNM="3A00" S SG="3A" Q    ;IIIA T3a   N0    M0
 .I TNM="3B00" S SG="3B" Q    ;IIIB T3b   N0    M0
 .I TNM="3C00" S SG="3C" Q    ;IIIC T3c   N0    M0
 .I N=1,M=0 S SG="3C" Q       ;     Any T N1    M0
 .I M=1 S SG=4 Q              ;IV   Any T Any N M1
 ;
FT5 ;Fallopian Tube - 5th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM="1A00" S SG="1A" Q  ;IA   T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q  ;IB   T1b   N0    M0
 .I TNM="1C00" S SG="1C" Q  ;IC   T1c   N0    M0
 .I TNM="2A00" S SG="2A" Q  ;IIA  T2a   N0    M0
 .I TNM="2B00" S SG="2B" Q  ;IIB  T2b   N0    M0
 .I TNM="2C00" S SG="2C" Q  ;IIC  T2c   N0    M0
 .I TNM="3A00" S SG="3A" Q  ;IIIA T3a   N0    M0
 .I TNM="3B00" S SG="3B" Q  ;IIIB T3b   N0    M0
 .I TNM="3C00" S SG="3C" Q  ;IIIC T3c   N0    M0
 .I N=1,M=0 S SG="3C" Q     ;     Any T N1    M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
FT6 ;Fallopian Tube - 6th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q       ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q          ;I    T1    N0    M0
 .I TNM="1A00" S SG="1A" Q    ;IA   T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q    ;IB   T1b   N0    M0
 .I TNM="1C00" S SG="1C" Q    ;IC   T1c   N0    M0
 .I TNM=200 S SG=2 Q          ;II   T2    N0    M0
 .I TNM="2A00" S SG="2A" Q    ;IIA  T2a   N0    M0
 .I TNM="2B00" S SG="2B" Q    ;IIB  T2b   N0    M0
 .I TNM="2C00" S SG="2C" Q    ;IIC  T2c   N0    M0
 .I TNM=300 S SG=3 Q          ;III  T3    N0    M0
 .I TNM="3A00" S SG="3A" Q    ;IIIA T3a   N0    M0
 .I TNM="3B00" S SG="3B" Q    ;IIIB T3b   N0    M0
 .I TNM="3C00" S SG="3C" Q    ;IIIC T3c   N0    M0
 .I N=1,M=0 S SG="3C" Q       ;     Any T N1    M0
 .I M=1 S SG=4 Q              ;IV   Any T Any N M1
 ;
GTT5 ;Gestational Trophoblastic Tumors - 5th edition
 S:$G(STGIND)="C" RF=$P($G(^ONCO(165.5,D0,2.1)),U,12)
 S:$G(STGIND)="P" RF=$P($G(^ONCO(165.5,D0,2.1)),U,13)
 S TNM=T_M_RF D  K TNM,RF Q  ;     T     M     Risk Factors
 .I TNM="100" S SG="1A" Q    ;IA   T1    M0    w/o
 .I TNM="101" S SG="1B" Q    ;IB   T1    M0    1
 .I TNM="102" S SG="1B" Q    ;     T1    M0    1
 .I TNM="103" S SG="1C" Q    ;IC   T1    M0    2
 .I TNM="200" S SG="2A" Q    ;IIA  T2    M0    w/o
 .I TNM="201" S SG="2B" Q    ;IIB  T2    M0    1
 .I TNM="202" S SG="2B" Q    ;     T2    M0    1
 .I TNM="203" S SG="2C" Q    ;IIC  T2    M0    2
 .I M="1A",RF=0 S SG="3A" Q  ;IIIA Any T M1a   w/o
 .I M="1A",RF=1 S SG="3B" Q  ;IIIB Any T M1a   1
 .I M="1A",RF=2 S SG="3B" Q  ;     Any T M1a   1
 .I M="1A",RF=3 S SG="3C" Q  ;IIIC Any T M1a   2
 .I M="1B",RF=0 S SG="4A" Q  ;IVA  Any T M1b   w/o
 .I M="1B",RF=1 S SG="4B" Q  ;IVB  Any T M1b   1
 .I M="1B",RF=2 S SG="4B" Q  ;     Any T M1b   1
 .I M="1B",RF=3 S SG="4C" Q  ;IVC  Any T M1b   2
 ;
GTT6 ;Gestational Trophoblastic Tumors - 6th edition
 S:$G(STGIND)="C" RF=$P($G(^ONCO(165.5,D0,2.1)),U,12)
 S:$G(STGIND)="P" RF=$P($G(^ONCO(165.5,D0,2.1)),U,13)
 S TNM=T_M_RF D  K TNM,RF Q    ;     T     M     Risk Factors
 .I TNM="10U" S SG=1 Q         ;I    T1    M0    Unknown
 .I TNM="10L" S SG="1A" Q      ;IA   T1    M0    Low risk
 .I TNM="10H" S SG="1b" Q      ;IB   T1    M0    High risk
 .I TNM="20U" S SG=2 Q         ;II   T2    M0    Unknown
 .I TNM="20L" S SG="2A" Q      ;IIA  T1    M0    Low risk
 .I TNM="20H" S SG="2B" Q      ;IIB  T1    M0    High risk
 .I M="1A",RF="U" S SG=3 Q     ;III  Any T M1a   Unknown
 .I M="1A",RF="L" S SG="3A" Q  ;IIIA Any T M1a   Low risk
 .I M="1A",RF="H" S SG="3B" Q  ;IIIB Any T M1a   High risk
 .I M="1B",RF="U" S SG=4 Q     ;IV   Any T M1b   Unknown
 .I M="1B",RF="L" S SG="4A" Q  ;IVA  Any T M1b   Low risk
 .I M="1B",RF="H" S SG="4B" Q  ;IVB  Any T M1b   High risk
 ;
