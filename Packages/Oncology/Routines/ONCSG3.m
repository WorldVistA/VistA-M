ONCSG3 ;Hines OIFO/GWB - Automatic Staging Tables ;06/23/10
 ;;2.11;ONCOLOGY;**35,51**;Mar 07, 1995;Build 65
 ;
 ;SKIN
 ;
CS ;Carcinoma of the Skin - 3rd, 4th, 5th and 6th editions
 K SG
 I $E(M)=1 S SG=4
 E  I $E(M)=0 D SKNRP
 I '$D(SG) S SG=99
 Q
SKNRP ;Carcinoma of the Skin
 I $E(N)=1 S SG=3
 E  I $E(N)=0 D
 .I T="IS" S SG=0
 .E  I T=1 S SG=1
 .E  I (T=2)!(T=3) S SG=2
 .E  I T=4 S SG=3
 Q
 ;
CSC ;Cutaneous Squamous Cell/Other Cutaneous Carcinoma - 7th edition
 I $E(HT,1,4)=8247,ONCOED=7 G MCC
 S TNM=T_N_M
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=300 S SG=3 Q        ;III  T3    N0    M0
 .I TNM=110 S SG=3 Q        ;     T1    N1    M0
 .I TNM=210 S SG=3 Q        ;     T2    N1    M0
 .I TNM=310 S SG=3 Q        ;     T3    N1    M0
 .I TNM=120 S SG=4 Q        ;IV   T1    N2    M0
 .I TNM=220 S SG=4 Q        ;     T2    N2    M0
 .I TNM=320 S SG=4 Q        ;     T3    N2    M0
 .I N=3,M=0 S SG=4 Q        ;     Any T N3    M0
 .I T=4,M=0 S SG=4 Q        ;     T4    Any N M0
 .I M=1 S SG=4 Q            ;     Any T Any N M1
 ;
MCC ;Merkel Cell Carcinoma - 7th edition
 I STGIND="C" D MCCC Q
 I STGIND="P" D MCCP Q
 Q
 ;
MCCC ;Merkel Cell Carcinoma - 7th edition (Clinical Stage Grouping)
 S TNM=T_N_$E(M,1)
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q        ;0    Tis   N0    M0
 .I TNM=100 S SG="1B" Q        ;IB   T1    N0    M0
 .I TNM=200 S SG="2B" Q        ;IIB  T2    N0    M0
 .I TNM=300 S SG="2B" Q        ;     T3    N0    M0
 .I TNM=400 S SG="2C" Q        ;IIC  T4    N0    M0
 .I $E(N,1)=1,M=0 S SG="3B" Q  ;IIIB Any T N1    M0
 .I N="1B",M=0 S SG="3B" Q     ;     Any T N1b   M0
 .I N=2,M=0 S SG="3B" Q        ;     Any T N2    M0
 .I $E(M,1)=1 S SG=4 Q         ;IV   Any T Any N M1
 ;
MCCP ;Merkel Cell Carcinoma - 7th edition (Pathologic Stage Grouping)
 S TNM=T_N_$E(M,1)
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q      ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q      ;IA   T1    pN0   M0
 .I TNM=200 S SG="2A" Q      ;IIA  T2    pN0   M0
 .I TNM=300 S SG="2A" Q      ;     T3    pN0   M0
 .I TNM=400 S SG="2C" Q      ;IIC  T4    N0    M0
 .I N="1A",M=0 S SG="3A" Q   ;IIIA Any T N1a   M0
 .I N="1B",M=0 S SG="3B" Q   ;IIIB Any T N1b   M0
 .I M=1 S SG=4 Q             ;IV   Any T Any N M1
 ;
MMS3 ;Melanoma of the Skin - 3rd edition
 I M[1 S SG=4
 E  I (T[1)!(T[2)!(T[3),N[0,M[0 S SG=+T
 E  I N,M[0 S SG=3
 E  S SG=99
 Q
 ;
MMS4 ;Malignant Melanoma of the Skin - 4th edition
 S SG=99
 I M[1 S SG=4
 E  I (N[1)!(N[2),M[0 S SG=3
 E  I N[0,M[0 S SG=$S((T[3)!(T[4):2,(T[1)!(T[2):1,T["IS":0,1:99)
 Q
 ;
MMS5 ;Malignant Melanoma of the Skin - 5th edition
 I T="IS" S TNM=T_$E(N,1)_$E(M,1)
 E  S TNM=$E(T,1)_$E(N,1)_$E(M,1)
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=1 Q        ;     T2    N0    M0
 .I TNM=300 S SG=2 Q        ;II   T3    N0    M0
 .I TNM=400 S SG=3 Q        ;III  T4    N0    M0
 .I $E(N,1)=1,M=0 S SG=3 Q  ;     Any T N1    M0
 .I $E(N,1)=2,M=0 S SG=3 Q  ;     Any T N2    M0
 .I $E(M,1)=1 S SG=4 Q      ;IV   Any T Any N M1
 ;
MMS6 ;Melanoma of the Skin - 6th edition
 I STGIND="C" D MMS6C Q
 I STGIND="P" D MMS6P Q
 Q
 ;
MMS6C ;Melanoma of the Skin - 6th edition (Clinical Stage Grouping)
 S TNM=T_$E(N,1)_$E(M,1)
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM="1A00" S SG="1A" Q  ;IA   T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q  ;IB   T1b   N0    M0
 .I TNM="2A00" S SG="1B" Q  ;     T2a   N0    M0
 .I TNM="2B00" S SG="2A" Q  ;IIA  T2b   N0    M0
 .I TNM="3A00" S SG="2A" Q  ;     T3a   N0    M0
 .I TNM="3B00" S SG="2B" Q  ;IIB  T3b   N0    M0
 .I TNM="4A00" S SG="2B" Q  ;     T4a   N0    M0
 .I TNM="4B00" S SG="2C" Q  ;IIC  T4b   N0    M0
 .I $E(N,1)=1,M=0 S SG=3 Q  ;III  Any T N1    M0
 .I $E(N,1)=2,M=0 S SG=3 Q  ;     Any T N2    M0
 .I $E(N,1)=3,M=0 S SG=3 Q  ;     Any T N3    M0
 .I $E(M,1)=1 S SG=4 Q      ;IV   Any T Any N M1
 ;
MMS6P ;Melanoma of the Skin - 6th edition (Pathologic Stage Grouping)
 S TNM=T_N_$E(M,1)
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q      ;0    Tis   N0    M0
 .I TNM="1A00" S SG="1A" Q   ;IA   T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q   ;IB   T1b   N0    M0
 .I TNM="2A00" S SG="1B" Q   ;     T2a   N0    M0
 .I TNM="2B00" S SG="2A" Q   ;IIA  T2b   N0    M0
 .I TNM="3A00" S SG="2A" Q   ;     T3a   N0    M0
 .I TNM="3B00" S SG="2B" Q   ;IIB  T3b   N0    M0
 .I TNM="4A00" S SG="2B" Q   ;     T4a   N0    M0
 .I TNM="4B00" S SG="2C" Q   ;IIC  T4b   N0    M0
 .I TNM="1A1A0" S SG="3A" Q  ;IIIA T1a   N1a   M0
 .I TNM="2A1A0" S SG="3A" Q  ;     T2a   N1a   M0
 .I TNM="3A1A0" S SG="3A" Q  ;     T3a   N1a   M0
 .I TNM="4A1A0" S SG="3A" Q  ;     T4a   N1a   M0
 .I TNM="1A2A0" S SG="3A" Q  ;     T1a   N2a   M0
 .I TNM="2A2A0" S SG="3A" Q  ;     T2a   N2a   M0
 .I TNM="3A2A0" S SG="3A" Q  ;     T3a   N2a   M0
 .I TNM="4A2A0" S SG="3A" Q  ;     T4a   N2a   M0
 .I TNM="1B1A0" S SG="3B" Q  ;IIIB T1b   N1a   M0
 .I TNM="2B1A0" S SG="3B" Q  ;     T2b   N1a   M0
 .I TNM="3B1A0" S SG="3B" Q  ;     T3b   N1a   M0
 .I TNM="4B1A0" S SG="3B" Q  ;     T4b   N1a   M0
 .I TNM="1B2A0" S SG="3B" Q  ;     T1b   N2a   M0
 .I TNM="2B2A0" S SG="3B" Q  ;     T2b   N2a   M0
 .I TNM="3B2A0" S SG="3B" Q  ;     T3b   N2a   M0
 .I TNM="4B2A0" S SG="3B" Q  ;     T4b   N2a   M0
 .I TNM="1A1B0" S SG="3B" Q  ;     T1a   N1b   M0
 .I TNM="2A1B0" S SG="3B" Q  ;     T2a   N1b   M0
 .I TNM="3A1B0" S SG="3B" Q  ;     T3a   N1b   M0
 .I TNM="4A1B0" S SG="3B" Q  ;     T4a   N1b   M0
 .I TNM="1A2B0" S SG="3B" Q  ;     T1a   N2b   M0
 .I TNM="2A2B0" S SG="3B" Q  ;     T2a   N2b   M0
 .I TNM="3A2B0" S SG="3B" Q  ;     T3a   N2b   M0
 .I TNM="4A2B0" S SG="3B" Q  ;     T4a   N2b   M0
 .I TNM="1A2C0" S SG="3B" Q  ;     T1a   N2c   M0
 .I TNM="2A2C0" S SG="3B" Q  ;     T2a   N2c   M0
 .I TNM="3A2C0" S SG="3B" Q  ;     T3a   N2c   M0
 .I TNM="4A2C0" S SG="3B" Q  ;     T4a   N2c   M0
 .I TNM="1B2C0" S SG="3B" Q  ;     T1b   N2c   M0
 .I TNM="2B2C0" S SG="3B" Q  ;     T2b   N2c   M0
 .I TNM="3B2C0" S SG="3B" Q  ;     T3b   N2c   M0
 .I TNM="4B2C0" S SG="3B" Q  ;     T4b   N2c   M0
 .I TNM="1B1B0" S SG="3C" Q  ;IIIC T1b   N1b   M0
 .I TNM="2B1B0" S SG="3C" Q  ;     T2b   N1b   M0
 .I TNM="3B1B0" S SG="3C" Q  ;     T3b   N1b   M0
 .I TNM="4B1B0" S SG="3C" Q  ;     T4b   N1b   M0
 .I TNM="1B2B0" S SG="3C" Q  ;     T1b   N2b   M0
 .I TNM="2B2B0" S SG="3C" Q  ;     T2b   N2b   M0
 .I TNM="3B2B0" S SG="3C" Q  ;     T3b   N2b   M0
 .I TNM="4B2B0" S SG="3C" Q  ;     T4b   N2b   M0
 .I N=3,M=0 S SG="3C" Q      ;     Any T N3    M0
 .I $E(M,1)=1 S SG=4 Q       ;IV   Any T Any N M1
 ;
 ;BREAST
 ;
BRST345 ;Breast - 3rd, 4th and 5th editions 
 I $E(M)=1 S SG=4
 E  I ($E(N)=3)!($E(T)=4),$E(M)=0 S SG="3B"
 E  I $E(T,1,2)="IS",$E(N)=0,$E(M)=0 S SG=0
 E  I $E(T)=1,$E(N)=0,$E(M)=0 S SG=1
 E  I ($E(T)=0)!($E(T)=1),$E(N)=1,$E(M)=0 S SG="2A"
 E  I $E(T)=2,$E(N)=0,$E(M)=0 S SG="2A"
 E  I $E(T)=2,$E(N)=1,$E(M)=0 S SG="2B"
 E  I $E(T)=3,$E(N)=0,$E(M)=0 S SG="2B"
 E  I ($E(T)=0)!($E(T)=1)!($E(T)=2)!($E(T)=3),$E(N)=2,$E(M)=0 S SG="3A"
 E  I $E(T)=3,$E(N)=1,$E(M)=0 S SG="3A"
 E  S SG=99
 Q
 ;
BRST6 ;Breast - 6th edition 
 I T="IS" S TNM=T_$E(N,1)_$E(M,1)
 E  S TNM=$E(T,1)_$E(N,1)_$E(M,1)
 S N=$E(N,1)
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q       ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q          ;I    T1    N0    M0
 .I TNM="010" S SG="2A" Q     ;IIA  T0    N1    M0
 .I TNM=110 S SG="2A" Q       ;     T1    N1    M0
 .I TNM=200 S SG="2A" Q       ;     T2    N0    M0
 .I TNM=210 S SG="2B" Q       ;IIB  T2    N1    M0
 .I TNM=300 S SG="2B" Q       ;     T3    N0    M0
 .I TNM="020" S SG="3A" Q     ;IIIA T0    N2    M0
 .I TNM=120 S SG="3A" Q       ;     T1    N2    M0
 .I TNM=220 S SG="3A" Q       ;     T2    N2    M0
 .I TNM=310 S SG="3A" Q       ;     T3    N1    M0
 .I TNM=320 S SG="3A" Q       ;     T3    N2    M0
 .I TNM=400 S SG="3B" Q       ;IIIB T4    N0    M0
 .I TNM=410 S SG="3B" Q       ;     T4    N1    M0
 .I TNM=420 S SG="3B" Q       ;     T4    N2    M0
 .I N=3,M=0 S SG="3C" Q       ;IIIC Any T N3    M0
 .I M=1 S SG=4 Q              ;IV   Any T Any N M1
 ;
BRST7 ;Breast - 7th edition 
 I T="IS" S TNM=T_$E(N,1)_$E(M,1)
 E  S TNM=$E(T,1)_$E(N,1)_$E(M,1)
 D  K TNM Q
 .I TNM="IS00" S SG=0 Q          ;0    Tis   N0    M0
 .I TNM=100 S SG="1A" Q          ;IA   T1    N0    M0
 .I T=0,N="1MI",M=0 S SG="1B" Q  ;IB   T0    N1mi  M0
 .I T=1,N="1MI",M=0 S SG="1B" Q  ;     T1    N1mi  M0
 .I TNM="010" S SG="2A" Q        ;IIA  T0    N1    M0
 .I TNM=110 S SG="2A" Q          ;     T1    N1    M0
 .I TNM=200 S SG="2A" Q          ;     T2    N0    M0
 .I TNM=210 S SG="2B" Q          ;IIB  T2    N1    M0
 .I TNM=300 S SG="2B" Q          ;     T3    N0    M0
 .I TNM="020" S SG="3A" Q        ;IIIA T0    N2    M0
 .I TNM=120 S SG="3A" Q          ;     T1    N2    M0
 .I TNM=220 S SG="3A" Q          ;     T2    N2    M0
 .I TNM=310 S SG="3A" Q          ;     T3    N1    M0
 .I TNM=320 S SG="3A" Q          ;     T3    N2    M0
 .I TNM=400 S SG="3B" Q          ;IIIB T4    N0    M0
 .I TNM=410 S SG="3B" Q          ;     T4    N1    M0
 .I TNM=420 S SG="3B" Q          ;     T4    N2    M0
 .I $E(N,1)=3,M=0 S SG="3C" Q    ;IIIC Any T N3    M0
 .I M=1 S SG=4 Q                 ;IV   Any T Any N M1
 ;
CLEANUP ;Cleanup
 K HT,M,N,ONCOED,STGIND,T
