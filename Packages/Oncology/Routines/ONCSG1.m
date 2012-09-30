ONCSG1 ;Hines OIFO/GWB - Automatic Staging Tables ;10/28/10
 ;;2.11;ONCOLOGY;**35,51,52,54**;Mar 07, 1995;Build 10
 ;
 ;DIGESTIVE SYSTEM
 ;
ESO1234 ;Esophagus - 1st, 2nd, 3rd and 4th editions
 I M[1 S SG=4
 E  I T["IS",N[0,M[0 S SG=0
 E  I T[1,N[0,M[0 S SG=1
 E  I (T[2)!(T[3),N[0,M[0 S SG="2A"
 E  I (T[1)!(T[2),N[1,M[0 S SG="2B"
 E  I T[3,N[1,M[0 S SG=3
 E  I T[4,M[0 S SG=3
 E  S SG=99
 Q
 ;
ESO56 ;Esophagus - 5th and 6th editions
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q        ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q           ;I    T1    N0    M0
 .I TNM=200 S SG="2A" Q        ;IIA  T2    N0    M0
 .I TNM=300 S SG="2A" Q        ;     T3    N0    M0
 .I TNM=110 S SG="2B" Q        ;IIB  T1    N1    M0
 .I TNM=210 S SG="2B" Q        ;     T2    N1    M0
 .I TNM=310 S SG=3 Q           ;III  T3    N1    M0
 .I T=4,M=0 S SG=3 Q           ;     T4    Any N M0
 .I M=1 S SG=4 Q               ;IV   Any T Any N M1
 .I M="1A" S SG="4A" Q         ;IVA  Any T Any N M1a
 .I M="1B" S SG="4B" Q         ;IVB  Any T Any N M1b
 ;
ESO7 ;Esophagus - 7th edition
 I ($E(HT,1,3)>804)&($E(HT,1,3)<808) G ESO7A
 E  G ESO7B
ESO7A ;Squamous Cell Carcinoma
 I T="IS" S TNM=T_N_M
 E  S TNM=$E(T,1)_N_M
 D  K TNM Q
 .I (TNM="IS00")&(G=1) S SG=0 Q
 .I (TNM=100)&(G=1) S SG="1A" Q
 .I (TNM=100)&((G=2)!(G=3)) S SG="1B" Q
 .I TNM=100 S SG="1A" Q
 .I ((TNM=200)!(TNM=300))&(G=1)&((TX=67152)!(TX=67155)) S SG="1B" Q
 .I ((TNM=200)!(TNM=300))&(G=1)&((TX=67150)!(TX=67151)!(TX=67153)!(TX=67154)) S SG="2A" Q
 .I ((TNM=200)!(TNM=300))&((G=2)!(G=3))&((TX=67152)!(TX=67155)) S SG="2A" Q
 .I ((TNM=200)!(TNM=300))&((G=2)!(G=3))&((TX=67150)!(TX=67151)!(TX=67153)!(TX=67154)) S SG="2B" Q
 .I ((TNM=200)!(TNM=300))&(G=1) S SG="1B" Q
 .I ((TNM=200)!(TNM=300))&((TX=67152)!(TX=67155)) S SG="1B" Q
 .I ((TNM=200)!(TNM=300))&((TX=67150)!(TX=67151)!(TX=67153)!(TX=67154)) S SG="2A" Q
 .I ((TNM=200)!(TNM=300))&((G=2)!(G=3)) S SG="2A" Q
 .I (TNM=200)!(TNM=300) S SG="1B" Q
 .I (TNM=110)!(TNM=210) S SG="2B" Q
 .I (TNM=120)!(TNM=220) S SG="3A" Q
 .I TNM=310 S SG="3A" Q
 .I (T="4A")&(N=0)&(M=0) S SG="3A" Q
 .I TNM=320 S SG="3B" Q
 .I ((TNM="410")!(TNM="420")) S SG="3C" Q
 .I (T="4B")&(M=0) S SG="3C" Q
 .I (N=3)&(M=0) S SG="3C" Q
 .I M=1 S SG=4 Q
 ;
ESO7B ;Adenocarcinoma
 I T="IS" S TNM=T_N_M
 E  S TNM=$E(T,1)_N_M
 D  K TNM Q
 .I (TNM="IS00")&(G=1) S SG=0 Q
 .I (TNM=100)&((G=1)!(G=2)) S SG="1A" Q
 .I (TNM=100)&(G=3) S SG="1B" Q
 .I (TNM=200)&((G=1)!(G=2)) S SG="1B" Q
 .I (TNM=200)&(G=3) S SG="2A" Q
 .I (TNM=300) S SG="2B" Q
 .I ((TNM=110)!(TNM=210)) S SG="2B" Q
 .I ((TNM=120)!(TNM=220)) S SG="3A" Q
 .I TNM=310 S SG="3A" Q
 .I (T="4A")&(N=0)&(M=0) S SG="3A" Q
 .I TNM=320 S SG="3B" Q
 .I ((TNM="410")!(TNM="420")) S SG="3C" Q
 .I (T="4B")&(M=0) S SG="3C" Q
 .I (N=3)&(M=0) S SG="3C" Q
 .I M=1 S SG=4 Q
 ;
STO34 ;Stomach - 3rd and 4th editions
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q     ;IA   T1    N0    M0
 .I TNM=110 S SG="1B" Q     ;IB   T1    N1    M0
 .I TNM=200 S SG="1B" Q     ;     T2    N0    M0
 .I TNM=120 S SG=2 Q        ;II   T1    N2    M0
 .I TNM=210 S SG=2 Q        ;     T2    N1    M0
 .I TNM=300 S SG=2 Q        ;     T3    N0    M0
 .I TNM=220 S SG="3A" Q     ;IIIA T2    N2    M0
 .I TNM=310 S SG="3A" Q     ;     T3    N1    M0
 .I TNM=400 S SG="3A" Q     ;     T4    N0    M0
 .I TNM=320 S SG="3B" Q     ;IIIB T3    N2    M0
 .I TNM=410 S SG="3B" Q     ;     T4    N1    M0
 .I TNM=420 S SG=4 Q        ;IV   T4    N2    M0
 .I M=1 S SG=4 Q            ;     Any T Any N M1
 ;
STO5 ;Stomach - 5th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q     ;IA   T1    N0    M0
 .I TNM=110 S SG="1B" Q     ;IB   T1    N1    M0
 .I TNM=200 S SG="1B" Q     ;     T2    N0    M0
 .I TNM=120 S SG=2 Q        ;II   T1    N2    M0
 .I TNM=210 S SG=2 Q        ;     T2    N1    M0
 .I TNM=300 S SG=2 Q        ;     T3    N0    M0
 .I TNM=220 S SG="3A" Q     ;IIIA T2    N2    M0
 .I TNM=310 S SG="3A" Q     ;     T3    N1    M0
 .I TNM=400 S SG="3A" Q     ;     T4    N0    M0
 .I TNM=320 S SG="3B" Q     ;IIIB T3    N2    M0
 .I TNM=410 S SG=4 Q        ;IV   T4    N1    M0
 .I TNM=130 S SG=4 Q        ;     T1    N3    M0
 .I TNM=230 S SG=4 Q        ;     T2    N3    M0
 .I TNM=330 S SG=4 Q        ;     T3    N3    M0
 .I TNM=420 S SG=4 Q        ;     T4    N2    M0
 .I TNM=430 S SG=4 Q        ;     T4    N3    M0
 .I M=1 S SG=4 Q            ;     Any T Any N M1
 ;
STO6 ;Stomach - 6th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q     ;IA   T1    N0    M0
 .I TNM=110 S SG="1B" Q     ;IB   T1    N1    M0
 .I TNM="2A00" S SG="1B" Q  ;     T2a   N0    M0
 .I TNM="2B00" S SG="1B" Q  ;     T2b   N0    M0
 .I TNM=120 S SG=2 Q        ;II   T1    N2    M0
 .I TNM="2A10" S SG=2 Q     ;     T2a   N1    M0
 .I TNM="2B10" S SG=2 Q     ;     T2b   N1    M0
 .I TNM=300 S SG=2 Q        ;     T3    N0    M0
 .I TNM="2A20" S SG="3A" Q  ;IIIA T2a   N2    M0
 .I TNM="2B20" S SG="3A" Q  ;     T2b   N2    M0
 .I TNM=310 S SG="3A" Q     ;     T3    N1    M0
 .I TNM=400 S SG="3A" Q     ;     T4    N0    M0
 .I TNM=320 S SG="3B" Q     ;IIIB T3    N2    M0
 .I TNM=410 S SG=4 Q        ;IV   T4    N1    M0
 .I TNM=130 S SG=4 Q        ;     T1    N3    M0
 .I TNM="2A30" S SG=4 Q     ;     T2a   N3    M0
 .I TNM="2B30" S SG=4 Q     ;     T2b   N3    M0
 .I TNM=330 S SG=4 Q        ;     T3    N3    M0
 .I TNM=420 S SG=4 Q        ;     T4    N2    M0
 .I TNM=430 S SG=4 Q        ;     T4    N3    M0
 .I M=1 S SG=4 Q            ;     Any T Any N M1
 ;
STO7 ;Stomach - 7th edition
 I $E(T,1)=1 S T=$E(T,1)
 I $E(N,1)=3 S N=$E(N,1)
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q     ;IA   T1    N0    M0
 .I TNM=200 S SG="1B" Q     ;IB   T2    N0    M0
 .I TNM=110 S SG="1B" Q     ;     T1    N1    M0
 .I TNM=300 S SG="2A" Q     ;IIA  T3    N0    M0
 .I TNM=210 S SG="2A" Q     ;     T2    N1    M0
 .I TNM=120 S SG="2A" Q     ;     T1    N2    M0
 .I TNM="4A00" S SG="2B" Q  ;IIB  T4a   N0    M0
 .I TNM=310 S SG="2B" Q     ;     T3    N1    M0
 .I TNM=220 S SG="2B" Q     ;     T2    N2    M0
 .I TNM=130 S SG="2B" Q     ;     T1    N3    M0
 .I TNM="4A10" S SG="3A" Q  ;IIIA T4a   N1    M0
 .I TNM=320 S SG="3A" Q     ;     T3    N2    M0
 .I TNM=230 S SG="3A" Q     ;     T2    N3    M0
 .I TNM="4B00" S SG="3B" Q  ;IIIB T4b   N0    M0
 .I TNM="4B10" S SG="3B" Q  ;     T4b   N1    M0
 .I TNM="4A20" S SG="3B" Q  ;     T4a   N2    M0
 .I TNM=330 S SG="3B" Q     ;     T3    N3    M0
 .I TNM="4B20" S SG="3C" Q  ;IIIC T4b   N2    M0
 .I TNM="4B30" S SG="3C" Q  ;     T4b   N3    M0
 .I TNM="4A30" S SG="3C" Q  ;     T4a   N3    M0
 .I M=1 S SG=4 Q            ;     Any T Any N M1
 ;
SI456 ;Small Intestine - 4th, 5th and 6th editions
 I M S SG=4
 E  I T["IS",N[0,M[0 S SG=0
 E  I (T[1)!(T[2),N[0,M[0 S SG=1
 E  I (T[3)!(T[4),N[0,M[0 S SG=2
 E  I N[1,M[0 S SG=3
 E  S SG=99
 Q
 ;
SI7 ;Small Intestine - 7th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q  ;0    Tis   N0    M0
 .I TNM="1A00" S SG=1 Q  ;I    T1a   N0    M0
 .I TNM="1B00" S SG=1 Q  ;I    T1b   N0    M0
 .I TNM=200 S SG=1 Q     ;     T2    N0    M0
 .I TNM=300 S SG="2A" Q  ;IIA  T3    N0    M0
 .I TNM=400 S SG="2B" Q  ;IIB  T0    N0    M0
 .I N=1,M=0 S SG="3A" Q  ;IIIA Any T N1    M0
 .I N=2,M=0 S SG="3B" Q  ;IIIB Any T N2    M0
 .I M=1 S SG=4 Q         ;IV   Any T Any N M1
 ;
APP7 ;Appendix- 7th edition
 N HT14
 S HT14=$E(HT,1,4)
 I (HT14=8153)!(HT14=8240)!(HT14=8241)!(HT14=8242)!(HT14=8246)!(HT14=8249) G APP7B
 ;
APP7A ;Carcinoma
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q                  ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q                    ;I    T1    N0    M0
 .I TNM=200 S SG=1 Q                    ;I    T2    N0    M0
 .I TNM=300 S SG="2A" Q                 ;IIA  T3    N0    M0
 .I TNM="4A00" S SG="2B" Q              ;IIB  T4a   N0    M0
 .I TNM="4B00" S SG="2C" Q              ;IIC  T4b   N0    M0
 .I TNM=110 S SG="3A" Q                 ;IIIA T1    N1    M0
 .I TNM=210 S SG="3A" Q                 ;     T2    N1    M0
 .I TNM=310 S SG="3B" Q                 ;IIIB T3    N1    M0
 .I TNM=410 S SG="3B" Q                 ;     T4    N1    M0
 .I N=2,M=0 S SG="3C" Q                 ;IIIC Any T N2    M0
 .I N=0,M="1A",G=1 S SG="4A" Q          ;IVA  Any T N0    M1a G1
 .I N=0,M="1A",(G=2)!(G=3) S SG="4B" Q  ;IVB  Any T N0    M1a G2,3
 .I N=1,M="1A" S SG="4B" Q              ;     Any T N1    M1a Any G
 .I N=2,M="1A" S SG="4B" Q              ;     Any T N2    M1a Any G
 .I M="1B" S SG="4C" Q                  ;IVC  Any T Any N M1b Any G
 ;
APP7B ;Carcinoid
 S TNM=T_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q  ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q  ;II   T2    N0    M0
 .I TNM=300 S SG=2 Q  ;     T3    N0    M0
 .I TNM=400 S SG=3 Q  ;III  T4    N0    M0
 .I N=1,M=0 S SG=3 Q  ;     Any T N1    M0
 .I M=1 S SG=4 Q      ;IV   Any T Any N M1
 ;
COL34 ;Colon and Rectum - 3rd and 4th editions
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=1 Q        ;     T2    N0    M0
 .I TNM=300 S SG=2 Q        ;II   T3    N0    M0
 .I TNM=400 S SG=2 Q        ;     T4    N0    M0
 .I N=1,M=0 S SG=3 Q        ;III  Any T N1    M0
 .I N=2,M=0 S SG=3 Q        ;     Any T N2    M0
 .I N=3,M=0 S SG=3 Q        ;     Any T N3    M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
COL5 ;Colon and Rectum - 5th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=1 Q        ;     T2    N0    M0
 .I TNM=300 S SG=2 Q        ;II   T3    N0    M0
 .I TNM=400 S SG=2 Q        ;     T4    N0    M0
 .I N=1,M=0 S SG=3 Q        ;III  Any T N1    M0
 .I N=2,M=0 S SG=3 Q        ;     Any T N2    M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
COL6 ;Colon and Rectum - 6th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=1 Q        ;     T2    N0    M0
 .I TNM=300 S SG="2A" Q     ;IIA  T3    N0    M0
 .I TNM=400 S SG="2B" Q     ;IIB  T4    N0    M0
 .I TNM=110 S SG="3A" Q     ;IIIA T1    N1    M0
 .I TNM=210 S SG="3A" Q     ;     T2    N1    M0
 .I TNM=310 S SG="3B" Q     ;IIIB T3    N1    M0
 .I TNM=410 S SG="3B" Q     ;     T4    N1    M0
 .I N=2,M=0 S SG="3C" Q     ;IIIC Any T N2    M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
COL7 ;Colon and Rectum - 7th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q
 .I TNM=100 S SG=1 Q
 .I TNM=200 S SG=1 Q
 .I TNM=300 S SG="2A" Q
 .I TNM="4A00" S SG="2B" Q
 .I TNM="4B00" S SG="2C" Q
 .I ((T=1)!(T=2))&($E(N,1)=1)&(M=0) S SG="3A" Q
 .I TNM="12A0" S SG="3A" Q
 .I ((T=3)!(T="4A"))&($E(N,1)=1)&(M=0) S SG="3B" Q
 .I ((TNM="22A0")!(TNM="32A0")) S SG="3B" Q
 .I ((TNM="12B0")!(TNM="22A0")) S SG="3B" Q
 .I TNM="4A2A0" S SG="3C" Q
 .I ((TNM="32B0")!(TNM="4A2B0")) S SG="3C" Q
 .I ((TNM="4B10")!(TNM="4B20")) S SG="3C" Q
 .I M="1A" S SG="4A" Q
 .I M="1B" S SG="4B" Q
 ;
AC ;Anus - all editions
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=300 S SG=2 Q        ;     T3    N0    M0
 .I TNM=110 S SG="3A" Q     ;IIIA T1    N1    M0
 .I TNM=210 S SG="3A" Q     ;     T2    N1    M0
 .I TNM=310 S SG="3A" Q     ;     T3    N1    M0
 .I TNM=400 S SG="3A" Q     ;     T4    N0    M0
 .I TNM=410 S SG="3B" Q     ;IIIB T4    N1    M0
 .I N=2,M=0 S SG="3B" Q     ;     Any T N2    M0
 .I N=3,M=0 S SG="3B" Q     ;     Any T N3    M0
 .I M=1 S SG=4 Q            ;IV   Any T Any N M1
 ;
GIST ;Gastrointestinal Stromal Tumor - 7th Edition
 N MR
 S MR=$P($G(^ONCO(165.5,D0,2.3)),U,9)
 I MR="" W !!?12,"MITOTIC RATE is required for AJCC 7th Edition GIST staging." Q
 I $E(TX,3,4)=16 G GASTRIC
SI ;Small Intestinal GIST - 7th Edition
 S TNM=T_N_M D  K TNM Q
 .I TNM=100,MR="L" S SG=1 Q           ;I     T1    N0    M0  Low
 .I TNM=200,MR="L" S SG=1 Q           ;      T2    N0    M0  Low
 .I TNM=300,MR="L" S SG=2 Q           ;II    T3    N0    M0  Low
 .I TNM=100,MR="H" S SG="3A" Q        ;IIIA  T1    N0    M0  High
 .I TNM=400,MR="L" S SG="3A" Q        ;      T4    N0    M0  Low
 .I TNM=200,MR="H" S SG="3B" Q        ;IIIB  T2    N0    M0  High
 .I TNM=300,MR="H" S SG="3B" Q        ;      T3    N0    M0  High
 .I TNM=400,MR="H" S SG="3B" Q        ;      T4    N0    M0  High
 .I N=1,M=0 S SG=4 Q                  ;IV    Any T N1    M0  Any rate
 .I M=1 S SG=4 Q                      ;      Any T Any N M1  Any rate
 ;
GASTRIC ;Gastric GIST
 S TNM=T_N_M D  K TNM Q
 .I TNM=100,MR="L" S SG="1A" Q        ;IA    T1    N0    M0  Low
 .I TNM=200,MR="L" S SG="1A" Q        ;      T2    N0    M0  Low
 .I TNM=300,MR="L" S SG="1B" Q        ;IB    T3    N0    M0  Low
 .I TNM=100,MR="H" S SG=2 Q           ;II    T1    N0    M0  High
 .I TNM=200,MR="H" S SG=2 Q           ;      T2    N0    M0  High
 .I TNM=400,MR="L" S SG=2 Q           ;      T4    N0    M0  Low
 .I TNM=300,MR="H" S SG="3A" Q        ;IIIA  T3    N0    M0  High
 .I TNM=400,MR="H" S SG="3B" Q        ;IIIB  T4    N0    M0  High
 .I N=1,M=0 S SG=4 Q                  ;IV    Any T N1    M0  Any rate
 .I M=1 S SG=4 Q                      ;      Any T Any N M1  Any rate
 ;
NT ;Neuroendocrine Tumor - 7th Edition
 S TNM=$E(T,1)_N_M D  K TNM Q
 .I TNM="IS00",$E(TX,3,4)=16 S SG=0 Q  ;0     Tis*  N0    M0
 .I TNM=100 S SG=1 Q                   ;I     T1    N0    M0
 .I TNM=200 S SG="2A" Q                ;IIA   T2    N0    M0
 .I TNM=300 S SG="2B" Q                ;IIB   T3    N0    M0
 .I TNM=400 S SG="3A" Q                ;IIIA  T4    N0    M0
 .I N=1,M=0 S SG="3B" Q                ;IIIB  Any T N1    M0
 .I M=1 S SG=4 Q                       ;IV    Any T Any N M1
 ;                                     ;Note: TIS applies only to stomach
 ;
CLEANUP ;Cleanup
 K D0,G,HT,M,N,SG,T,TX
