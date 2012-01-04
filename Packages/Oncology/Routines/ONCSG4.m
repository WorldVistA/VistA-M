ONCSG4 ;Hines OIFO/GWB - Automatic Staging Tables ;02/28/11
 ;;2.11;ONCOLOGY;**35,51,52,53**;Mar 07, 1995;Build 31
 ;
 ;GYNECOLOGICAL SITES
 ;
VU3 ;Vulva - 3rd edition
 I M!($E(N)=3)!(T=4) S SG=4
 E  I T="IS" S SG=0
 E  I T=1,($E(N)=0)!($E(N)=1),$E(M)=0 S SG=1
 E  I T=2,($E(N)=0)!($E(N)=1),$E(M)=0 S SG=2
 E  I T=3,($E(N)=0)!($E(N)=1)!($E(N)=2),$E(M)=0 S SG=3
 E  I (T=1)!(T=2),$E(N)=2,$E(M)=0 S SG=3
 E  S SG=99
 Q
 ;
VU4 ;Vulva - 4th edition
 I M S SG="4B"
 E  I T=4,$E(M)=0 S SG="4A"
 E  I (T=1)!(T=2)!(T=3),$E(N)=2,$E(M)=0 S SG="4A"
 E  I T="IS",$E(N)=0,$E(M)=0 S SG=0
 E  I T=1,$E(N)=0,$E(M)=0 S SG=1
 E  I T=2,$E(N)=0,$E(M)=0 S SG=2
 E  I (T=1)!(T=2),$E(N)=1,$E(M)=0 S SG=3
 E  I T=3,($E(N)=0)!($E(N)=1),$E(M)=0 S SG=3
 E  S SG=99
 Q
 ;
VU56 ;Vulva - 5th and 6th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM="1A00" S SG="1A" Q  ;IA   T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q  ;IB   T1b   N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=110 S SG=3 Q        ;III  T1    N1    M0
 .I TNM=210 S SG=3 Q        ;     T2    N1    M0
 .I TNM=300 S SG=3 Q        ;     T3    N0    M0
 .I TNM=310 S SG=3 Q        ;     T3    N1    M0
 .I TNM=120 S SG="4A" Q     ;IVA  T1    N2    M0
 .I TNM=220 S SG="4A" Q     ;     T2    N2    M0
 .I TNM=320 S SG="4A" Q     ;     T3    N2    M0
 .I T=4,M=0 S SG="4A" Q     ;     T4    Any N M0
 .I M=1 S SG="4B" Q         ;IVB  Any T Any N M1
 ;
VU7 ;Vulva - 7th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q               ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q                  ;I    T1    N0    M0
 .I TNM="1A00" S SG="1A" Q            ;IA   T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q            ;IB   T1b   N0    M0
 .I TNM=200 S SG=2 Q                  ;II   T2    N0    M0
 .I $E(T,1)=1,N="1A",M=0 S SG="3A" Q  ;IIIA T1    N1a   M0
 .I $E(T,1)=1,N="1B",M=0 S SG="3A" Q  ;     T1    N1b   M0
 .I TNM="21A0" S SG="3A" Q            ;     T2    N1a   M0
 .I TNM="21B0" S SG="3A" Q            ;     T2    N1b   M0
 .I $E(T,1)=1,N="2A",M=0 S SG="3B" Q  ;IIIB T1    N2a   M0
 .I $E(T,1)=1,N="2B",M=0 S SG="3B" Q  ;     T1    N2b   M0
 .I TNM="22A0" S SG="3B" Q            ;     T2    N2a   M0
 .I TNM="22B0" S SG="3B" Q            ;     T2    N2b   M0
 .I $E(T,1)=1,N="2C",M=0 S SG="3C" Q  ;IIIC T1    N2c   M0
 .I TNM="22C0" S SG="3C" Q            ;     T2    N2c   M0
 .I $E(T,1)=1,N=3,M=0 S SG="4A" Q     ;IVA  T1    N3   M0
 .I TNM=230 S SG="4A" Q               ;     T2    N3   M0
 .I T=3,M=0 S SG="4A" Q               ;     T3    Any N M0
 .I M=1 S SG="4B" Q                   ;IVB  Any T Any N M1
 ;
VA34 ;Vagina - 3rd and 4th editions
 S SG=99
 I M[1 S SG="4B"
 E  I M[0 D
 .I T[4 S SG="4A"
 .E  I N[2,(T[1)!(T[2)!(T[3) S SG="4A"
 .E  I N[1,(T[1)!(T[2)!(T[3) S SG=3
 .E  I N[0,(T["IS")!(T[1)!(T[2)!(T[3) S SG=+T
 Q
 ;
VA567 ;Vagina - 5th, 6th and 7th editions
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q     ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q        ;I    T1    N0    M0
 .I TNM=200 S SG=2 Q        ;II   T2    N0    M0
 .I TNM=110 S SG=3 Q        ;III  T1    N1    M0
 .I TNM=210 S SG=3 Q        ;     T2    N1    M0
 .I TNM=300 S SG=3 Q        ;     T3    N0    M0
 .I TNM=310 S SG=3 Q        ;     T3    N1    M0
 .I T=4,M=0 S SG="4A" Q     ;IVA  T4    Any N M0
 .I M=1 S SG="4B" Q         ;IVB  Any T Any N M1
 ;
CEU34 ;Cervix Uteri - 3rd and 4th editions
 I $E(M)=1 S SG="4B"
 E  I $E(T)=4,$E(M)=0 S SG="4A"
 E  I $E(T,1,2)="IS",$E(N)=0,$E(M)=0 S SG=0
 E  I $E(T,1,2)="1A",$E(N)=0,$E(M)=0 S SG="1A"
 E  I $E(T,1,2)="1B",$E(N)=0,$E(M)=0 S SG="1B"
 E  I $E(T,1,2)="2A",$E(N)=0,$E(M)=0 S SG="2A"
 E  I $E(T,1,2)="2B",$E(N)=0,$E(M)=0 S SG="2B"
 E  I $E(T,1,2)="3A",$E(N)=0,$E(M)=0 S SG="3A"
 E  I ($E(T)=1)!($E(T)=2)!($E(T,1,2)="3A"),$E(N)=1,$E(M)=0 S SG="3B"
 E  I $E(T,1,2)="3B",$E(M)=0 S SG="3B"
 E  S SG=99
 Q
 ;
CEU56 ;Cervix Uteri - 5th and 6th editions
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q       ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q          ;I    T1    N0    M0
 .I TNM="1A00" S SG="1A" Q    ;IA   T1a   N0    M0
 .I TNM="1A100" S SG="1A1" Q  ;IA1  T1a1  N0    M0
 .I TNM="1A200" S SG="1A2" Q  ;IA2  T1a2  N0    M0
 .I TNM="1B00" S SG="1B" Q    ;IB   T1b   N0    M0
 .I TNM="1B100" S SG="1B1" Q  ;IB1  T1b1  N0    M0
 .I TNM="1B200" S SG="1B2" Q  ;IB2  T1b2  N0    M0
 .I TNM=200 S SG=2 Q          ;II   T2    N0    M0
 .I TNM="2A00" S SG="2A" Q    ;IIA  T2a   N0    M0
 .I TNM="2B00" S SG="2B" Q    ;IIB  T2b   N0    M0
 .I TNM=300 S SG=3 Q          ;III  T3    N0    M0
 .I TNM="3A00" S SG="3A" Q    ;IIIA T3a   N0    M0
 .I TNM=110 S SG="3B" Q       ;IIIB T1    N1    M0
 .I TNM=210 S SG="3B" Q       ;     T2    N1    M0
 .I TNM="3A10" S SG="3B" Q    ;     T3a   N1    M0
 .I T="3B",M=0 S SG="3B" Q    ;     T3b   Any N M0
 .I T=4,M=0 S SG="4A" Q       ;IVA  T4    Any N M0
 .I M=1 S SG="4B" Q           ;IVB  Any T Any N M1
 ;
CEU7 ;Cervix Uteri - 7th editions
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q            ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q               ;I    T1    N0    M0
 .I TNM="1A00" S SG="1A" Q         ;IA   T1a   N0    M0
 .I TNM="1A100" S SG="1A1" Q       ;IA1  T1a1  N0    M0
 .I TNM="1A200" S SG="1A2" Q       ;IA2  T1a2  N0    M0
 .I TNM="1B00" S SG="1B" Q         ;IB   T1b   N0    M0
 .I TNM="1B100" S SG="1B1" Q       ;IB1  T1b1  N0    M0
 .I TNM="1B200" S SG="1B2" Q       ;IB2  T1b2  N0    M0
 .I TNM=200 S SG=2 Q               ;II   T2    N0    M0
 .I TNM="2A00" S SG="2A" Q         ;IIA  T2a   N0    M0
 .I TNM="2A100" S SG="2A1" Q       ;IIA1 T2a1  N0    M0
 .I TNM="2A200" S SG="2A2" Q       ;IIA2 T2a1  N0    M0
 .I TNM="2B00" S SG="2B" Q         ;IIB  T2b   N0    M0
 .I TNM=300 S SG=3 Q               ;III  T3    N0    M0
 .I TNM="3A00" S SG="3A" Q         ;IIIA T3a   N0    M0
 .I T="3B",M=0 S SG="3B" Q         ;IIIB T1    Any T M0
 .I $E(T,1)<4,N=1,M=0 S SG="3B" Q  ;     T1-3  N1    M0
 .I T=4,M=0 S SG="4A" Q            ;IVA  T4    Any N M0
 .I M=1 S SG="4B" Q                ;IVB  Any T Any N M1
 ;
COU3 ;Corpus Uteri - 3rd edition
 I $E(M)=1 S SG="4B"
 E  I $E(T,1,2)="IS",$E(N)=0,$E(M)=0 S SG=0
 E  I $E(T,1,2)="1A",$E(N)=0,$E(M)=0 S SG="1A"
 E  I $E(T,1,2)="1B",$E(N)=0,$E(M)=0 S SG="1B"
 E  I $E(T)=2,$E(N)=0,$E(M)=0 S SG=2
 E  I $E(T)=1,$E(N)=1,$E(M)=0 S SG=3
 E  I $E(T)=2,$E(N)=1,$E(M)=0 S SG=3
 E  I $E(T)=3,$E(M)=0 S SG=3
 E  I $E(T)=4,$E(M)=0 S SG="4A"
 E  S SG=99
 Q
 ;
COU45 ;Corpus Uteri - 4th and 5th editions
 I $E(M)=1 S SG="4B"
 E  I $E(T,1,2)="IS",$E(N)=0,$E(M)=0 S SG=0
 E  I $E(T,1,2)="1A",$E(N)=0,$E(M)=0 S SG="1A"
 E  I $E(T,1,2)="1B",$E(N)=0,$E(M)=0 S SG="1B"
 E  I $E(T,1,2)="1C",$E(N)=0,$E(M)=0 S SG="1C"
 E  I $E(T,1,2)="2A",$E(N)=0,$E(M)=0 S SG="2A"
 E  I $E(T,1,2)="2B",$E(N)=0,$E(M)=0 S SG="2B"
 E  I $E(T,1,2)="3A",$E(N)=0,$E(M)=0 S SG="3A"
 E  I $E(T,1,2)="3B",$E(N)=0,$E(M)=0 S SG="3B"
 E  I $E(T)=1,$E(N)=1,$E(M)=0 S SG="3C"
 E  I $E(T)=2,$E(N)=1,$E(M)=0 S SG="3C"
 E  I $E(T)=3,$E(N)=1,$E(M)=0 S SG="3C"
 E  I $E(T)=4,$E(M)=0 S SG="4A"
 E  S SG=99
 Q
 ;
COU6 ;Corpus Uteri - 6th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q       ;0    Tis   N0    M0
 .I TNM=100 S SG=1 Q          ;I    T1    N0    M0
 .I TNM="1A00" S SG="1A" Q    ;IA   T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q    ;IB   T1b   N0    M0
 .I TNM="1C00" S SG="1C" Q    ;IC   T1c   N0    M0
 .I TNM=200 S SG=2 Q          ;II   T2    N0    M0
 .I TNM="2A00" S SG="2A" Q    ;IIA  T2a   N0    M0
 .I TNM="2B00" S SG="2B" Q    ;IIB  T2b   N0    M0
 .I TNM=300 S SG=3 Q          ;III  T3    N0    M0
 .I TNM="3A00" S SG="3A" Q    ;IIIA T3a   N0    M0
 .I TNM="3B00" S SG="3B" Q    ;IIIB T3b   N0    M0
 .I TNM=110 S SG="3C" Q       ;IIIC T1    N1    M0
 .I TNM=210 S SG="3C" Q       ;     T2    N1    M0
 .I TNM=310 S SG="3C" Q       ;     T3    N1    M0
 .I T=4,M=0 S SG="4A" Q       ;IVA  T4    Any N M0
 .I M=1 S SG="4B" Q           ;IVB  Any T Any N M1
 ;
COU7 ;Corpus Uteri - 7th edition
 N HT14
 S HT14=$E(HT,1,4)
 I (HT14>7999)&(HT14<8791) G COU7C
 I (HT14>8979)&(HT14<8982) G COU7C
 I (HT14>9699)&(HT14<9702) G COU7C
 I (HT14>8889)&(HT14<8899) G COU7S
 I (HT14>8929)&(HT14<8932) G COU7S
 I HT14=8933 G COU7S
 ;
COU7C ;Corpus Uteri Carcinoma - 7th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM="IS00" S SG=0 Q       ;0     Tis   N0    M0
 .I TNM=100 S SG=1 Q          ;I     T1    N0    M0
 .I TNM="1A00" S SG="1A" Q    ;IA    T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q    ;IB    T1b   N0    M0
 .I TNM="1C00" S SG="1C" Q    ;IC    T1c   N0    M0
 .I TNM=200 S SG=2 Q          ;II    T2    N0    M0
 .I TNM="2A00" S SG="2A" Q    ;IIA   T2a   N0    M0
 .I TNM="2B00" S SG="2B" Q    ;IIB   T2b   N0    M0
 .I TNM=300 S SG=3 Q          ;III   T3    N0    M0
 .I TNM="3A00" S SG="3A" Q    ;IIIA  T3a   N0    M0
 .I TNM="3B00" S SG="3B" Q    ;IIIB  T3b   N0    M0
 .I TNM=110 S SG="3C1" Q      ;IIIC1 T1    N1    M0
 .I TNM="1A10" S SG="3C1" Q   ;      T1a   N1    M0
 .I TNM="1B10" S SG="3C1" Q   ;      T1B   N1    M0
 .I TNM=210 S SG="3C1" Q      ;      T2    N1    M0
 .I TNM=310 S SG="3C1" Q      ;      T3    N1    M0
 .I TNM="3A10" S SG="3C1" Q   ;      T3a   N1    M0
 .I TNM="3B10" S SG="3C1" Q   ;      T3b   N1    M0
 .I TNM=120 S SG="3C2" Q      ;IIIC2 T1    N2    M0
 .I TNM="1A20" S SG="3C2" Q   ;      T1a   N2    M0
 .I TNM="1B20" S SG="3C2" Q   ;      T1b   N2    M0
 .I TNM=220 S SG="3C2" Q      ;      T2    N2    M0
 .I TNM=320 S SG="3C2" Q      ;      T3    N2    M0
 .I TNM="3A20" S SG="3C2" Q   ;      T3a   N2    M0
 .I TNM="3B20" S SG="3C2" Q   ;      T3b   N2    M0
 .I T=4,M=0 S SG="4A" Q       ;IVA   T4    Any N M0
 .I M=1 S SG="4B" Q           ;IVB   Any T Any N M1
 ;
COU7S ;Corpus Uteri Sarcoma - 7th edition
 S TNM=T_N_M D  K TNM Q
 .I TNM=100 S SG=1 Q            ;I    T1    N0    M0
 .I TNM="1A00" S SG="1A" Q      ;IA   T1a   N0    M0
 .I TNM="1B00" S SG="1B" Q      ;IB   T1b   N0    M0
 .I TNM="1C00" S SG="1C" Q      ;IC   T1c   N0    M0
 .I $E(T,1)=2,N=0,M=0 S SG=2 Q  ;II   T2    N0    M0
 .I TNM="3A00" S SG="3A" Q      ;IIIA T3a   N0    M0
 .I TNM="3B00" S SG="3B" Q      ;IIIB T3b   N0    M0
 .I TNM=110 S SG="3C" Q         ;IIIC T1    N1    M0
 .I TNM="1A10" S SG="3C" Q      ;     T1a   N1    M0
 .I TNM="1B10" S SG="3C" Q      ;     T1b   N1    M0
 .I TNM="1C10" S SG="3C" Q      ;     T1c   N1    M0
 .I TNM=210 S SG="3C" Q         ;     T2    N1    M0
 .I TNM=310 S SG="3C" Q         ;     T3    N1    M0
 .I TNM="3A10" S SG="3C" Q      ;     T3a   N1    M0
 .I TNM="3B10" S SG="3C" Q      ;     T3b   N1    M0
 .I T=4,M=0 S SG="4A" Q         ;IVA  T4    Any N M0
 .I M=1 S SG="4B" Q             ;IVB  Any T Any N M1
 ;
CLEANUP ;Cleanup
 K HT,M,N,SG,T
