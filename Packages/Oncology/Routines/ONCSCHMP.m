ONCSCHMP ;HINES OIFO/RTK - PROGNOSTIC STAGE GROUP CALCULATIONS ;01/09/19
 ;;2.2;ONCOLOGY;**10,12,13**;Jul 31, 2013;Build 7
 ;
STAGE ;AJCC 8TH EDITION AUTO CALCULATION OF STAGE GROUPS
 ;
 N T,N,M
 ;
 I STGIND="C" D
 .S T=$P($G(^ONCO(165.5,D0,"AJCC8")),U,2)  ; Clin T 
 .S N=$P($G(^ONCO(165.5,D0,"AJCC8")),U,3)  ; Clin N 
 .S M=$P($G(^ONCO(165.5,D0,"AJCC8")),U,4)  ; Clin M
 I STGIND="P" D
 .S T=$P($G(^ONCO(165.5,D0,"AJCC8")),U,6)  ; Path T 
 .S N=$P($G(^ONCO(165.5,D0,"AJCC8")),U,7)  ; Path N 
 .S M=$P($G(^ONCO(165.5,D0,"AJCC8")),U,8)  ; Path M
 I STGIND="PT" D
 .S T=$P($G(^ONCO(165.5,D0,"AJCC8")),U,10)  ; Post Ther T 
 .S N=$P($G(^ONCO(165.5,D0,"AJCC8")),U,11)  ; Post Ther N 
 .S M=$P($G(^ONCO(165.5,D0,"AJCC8")),U,12)  ; Post Ther M
 ;
 ;
 D STRPCPTN  ;strip "c","p","yp" prefix from T and N codes
 ;
 S ONCAJCHP="" D GTAJIEN^ONCSCHMG
 S SG=""
 I '$D(ONCAJCHP) Q
 I ONCAJCHP="" Q
 I ONCAJCHP<6 Q
 I (ONCAJCHP>77)&(ONCAJCHP'=81.1) Q
 S ONCHP=$P(ONCAJCHP,".",1)_$P(ONCAJCHP,".",2)
 I ONCHP=181,$P($G(^ONCO(165.5,D0,"AJCC8")),U,1)="18.2" S ONCHP=182
 D @ONCHP
 I SG="" D
 .S SG=99
 .I STGIND="P",$P($G(^ONCO(165.5,D0,"AJCC8")),U,13)'="" S SG=""
 .I STGIND="PT",$P($G(^ONCO(165.5,D0,"AJCC8")),U,9)'="" S SG=""
 I SG=88 D
 .I STGIND="P",$P($G(^ONCO(165.5,D0,"AJCC8")),U,13)'="" S SG=""
 .I STGIND="PT",$P($G(^ONCO(165.5,D0,"AJCC8")),U,9)'="" S SG=""
 I STGIND="C" I $P(^ONCO(165.5,D0,"AJCC8"),U,5)=SG Q
 I STGIND="P" I $P(^ONCO(165.5,D0,"AJCC8"),U,9)=SG Q
 I STGIND="PT" I $P(^ONCO(165.5,D0,"AJCC8"),U,13)=SG Q
READ W !,"*** ONCOTRAX Calculated Stage Group value = ",SG," ***"
 N ONCTRX R "  Accept? Y//",ONCTRX:DTIME
 S ONCTRX=$TR(ONCTRX,"yesno","YESNO")
 I (ONCTRX="?")!(ONCTRX="??")!(ONCTRX="???") W !,"Enter Y or N" D READ Q
 I (ONCTRX="")!(ONCTRX="Y")!(ONCTRX="YES") D
 .I STGIND="C" S $P(^ONCO(165.5,D0,"AJCC8"),U,5)=SG
 .I STGIND="P" S $P(^ONCO(165.5,D0,"AJCC8"),U,9)=SG
 .I STGIND="PT" S $P(^ONCO(165.5,D0,"AJCC8"),U,13)=SG
 ;
 Q
 ;
STRPCPTN ;
 I $E(T,1)="c" S T=$E(T,2,99)
 I $E(T,1)="p" S T=$E(T,2,99)
 I $E(T,1,2)="yp" S T=$E(T,3,99)
 I $E(N,1)="c" S N=$E(N,2,99)
 I $E(N,1)="p" S N=$E(N,2,99)
 I $E(N,1,2)="yp" S N=$E(N,3,99)
 Q
 ;
 ;AJCC 8TH (and beyond) EDITION CHAPTERS
6 D 6^ONCSGA8A Q
7 D 7^ONCSGA8A Q
8 D 8^ONCSGA8A Q
9 D 9^ONCSGA8A Q
10 N SCDSP16
 S SCDSP16=$P($G(^ONCO(165.5,D0,"SSD4")),U,22)  ; Schema Discriminator 2
 I SCDSP16'=2 Q
 D 10^ONCSGA8A Q
111 N SCDSP16
 S SCDSP16=$P($G(^ONCO(165.5,D0,"SSD4")),U,22)  ; Schema Discriminator 2
 I SCDSP16=2 Q
 D 111^ONCSGA8A Q
112 D 112^ONCSGA8A Q
121 D 121^ONCSGA8A Q
122 D 122^ONCSGA8A Q
13 D 132^ONCSGA8A Q
131 D 131^ONCSGA8A Q
132 D 132^ONCSGA8A Q
133 D 133^ONCSGA8A Q
14 S SG=88 Q  ;no stage grouping
15 D 15^ONCSGA8A Q
161 N G I STGIND="C" S G=$P($G(^ONCO(165.5,D0,2.3)),U,12)  ; Grade Clinical
 I STGIND="P" S G=$P($G(^ONCO(165.5,D0,2.3)),U,13)  ; Grade Pathologic
 I STGIND="PT" S G=$P($G(^ONCO(165.5,D0,2.3)),U,14)  ; Grade Post-Therapy
 N EETE S EETE=$P($G(^ONCO(165.5,D0,"SSD1")),U,30)  ; Esoph EJT T Epicntr
 D 161^ONCSGA8A Q
162 N G I STGIND="C" S G=$P($G(^ONCO(165.5,D0,2.3)),U,12)  ; Grade Clinical
 I STGIND="P" S G=$P($G(^ONCO(165.5,D0,2.3)),U,13)  ; Grade Pathologic
 I STGIND="PT" S G=$P($G(^ONCO(165.5,D0,2.3)),U,14)  ; Grade Post-Therapy
 D 162^ONCSGA8A Q
163 S SG=88 Q  ;no stage grouping
17 D 17^ONCSGA8A Q
181 D 181^ONCSGA8A Q
182 S SG=88 Q  ;no stage grouping
19 N G I STGIND="C" S G=$P($G(^ONCO(165.5,D0,2.3)),U,12)  ; Grade Clinical
 I STGIND="P" S G=$P($G(^ONCO(165.5,D0,2.3)),U,13)  ; Grade Pathologic
 I STGIND="PT" S G=$P($G(^ONCO(165.5,D0,2.3)),U,14)  ; Grade Post-Therapy
 D 19^ONCSGA8A Q
20 D 20^ONCSGA8A Q
21 D 21^ONCSGA8A Q
22 D 22^ONCSGA8A Q
23 D 23^ONCSGA8A Q
24 D 24^ONCSGA8A Q
25 D 25^ONCSGA8A Q
26 D 26^ONCSGA8A Q
27 D 27^ONCSGA8A Q
28 D 28^ONCSGA8A Q
29 D 29^ONCSGA8A Q
 ;
30 D 30^ONCSGA8B Q
31 D 31^ONCSGA8B Q
32 D 32^ONCSGA8B Q
33 D 33^ONCSGA8B Q
34 D 34^ONCSGA8B Q
35 D 35^ONCSGA8B Q
 ;
36 D 36^ONCSGA8B Q
37 D 37^ONCSGA8B Q
381 N G I STGIND="C" S G=$P($G(^ONCO(165.5,D0,2.3)),U,12)  ; Grade Clinical
 I STGIND="P" S G=$P($G(^ONCO(165.5,D0,2.3)),U,13)  ; Grade Pathologic
 I STGIND="PT" S G=$P($G(^ONCO(165.5,D0,2.3)),U,14)  ; Grade Post-Therapy
 D 381^ONCSGA8B Q
382 S SG=88 Q  ;no stage grouping
383 S SG=88 Q  ;no stage grouping
40 S SG=88 Q  ;no stage grouping
41 N G I STGIND="C" S G=$P($G(^ONCO(165.5,D0,2.3)),U,12)  ; Grade Clinical
 I STGIND="P" S G=$P($G(^ONCO(165.5,D0,2.3)),U,13)  ; Grade Pathologic
 I STGIND="PT" S G=$P($G(^ONCO(165.5,D0,2.3)),U,14)  ; Grade Post-Therapy
 D 41^ONCSGA8B Q
42 S SG=88 Q  ;no stage grouping
431 N MTRT S MTRT=$P($G(^ONCO(165.5,D0,2.3)),U,9)  ; Mitototic Rate
 D 431^ONCSGA8B Q
432 N MTRT S MTRT=$P($G(^ONCO(165.5,D0,2.3)),U,9)  ; Mitototic Rate
 D 432^ONCSGA8B Q
44 N G I STGIND="C" S G=$P($G(^ONCO(165.5,D0,2.3)),U,12)  ; Grade Clinical
 I STGIND="P" S G=$P($G(^ONCO(165.5,D0,2.3)),U,13)  ; Grade Pathologic
 I STGIND="PT" S G=$P($G(^ONCO(165.5,D0,2.3)),U,14)  ; Grade Post-Therapy
 D 44^ONCSGA8B Q
45 S SG=88 Q  ;no TNM code or stage grouping
46 N PNSFX S PNSFX=$P($G(^ONCO(165.5,D0,"AJCC8")),U,17)  ; Path N Suffix
 D 46^ONCSGA8B Q
47 D 47^ONCSGA8B Q
 ;
48 N G,HER2,ER,PR,VAL
 I STGIND="C" S G=$P($G(^ONCO(165.5,D0,2.3)),U,12)  ; Grade Clinical
 I STGIND="P" S G=$P($G(^ONCO(165.5,D0,2.3)),U,13)  ; Grade Pathologic
 I STGIND="PT" S G=$P($G(^ONCO(165.5,D0,2.3)),U,14)  ; Grade Post-Therapy
 S VAL=$P($G(^ONCO(165.5,D0,"SSD2")),U,21) ; HER2 Summary (3855)
 S HER2=$S(VAL=0:"N",VAL=1:"P",1:"")
 S VAL=$P($G(^ONCO(165.5,D0,"SSD1")),U,28) ; Estrogen Rec Summ (3827)
 S ER=$S(VAL=0:"N",VAL=1:"P",1:"")
 S VAL=$P($G(^ONCO(165.5,D0,"SSD4")),U,10) ; Progesterone Rec Summ (3915)
 S PR=$S(VAL=0:"N",VAL=1:"P",1:"")
 D 48^ONCSGA8B Q
50 D 50^ONCSGA8B Q
51 D 51^ONCSGA8B Q
52 I $P($G(^ONCO(165.5,D0,0)),"^",16)<3210000 D 52^ONCSGA8B Q
 I $P($G(^ONCO(165.5,D0,0)),"^",16)>3201231 D 529^ONCSGA8C Q
53 D 53^ONCSGA8B Q
541 D 541^ONCSGA8B Q
542 D 542^ONCSGA8B Q
55 D 55^ONCSGA8B Q
56 N RSCORE R "Enter the Risk Score (1-25): ",RSCORE:DTIME
 I (RSCORE'?1.2N)!(RSCORE<1)!(RSCORE>25) W !!,"Risk Score must be 1 - 25 or NULL",! D 56 Q
 D 56^ONCSGA8B Q
57 D 57^ONCSGA8B Q
58 N G I STGIND="C" S G=$P($G(^ONCO(165.5,D0,2.3)),U,12)  ; Grade Clinical
 I STGIND="P" S G=$P($G(^ONCO(165.5,D0,2.3)),U,13)  ; Grade Pathologic
 I STGIND="PT" S G=$P($G(^ONCO(165.5,D0,2.3)),U,14)  ; Grade Post-Therapy
 N PSA S PSA=$P($G(^ONCO(165.5,D0,"SSD4")),U,15) ; PSA Lab Value (3920)
 D 58^ONCSGA8B Q
59 N SCAT
 I STGIND="C" S SCAT=$P($G(^ONCO(165.5,D0,"SSD4")),U,18)  ; S Category Clin
 I STGIND="P" S SCAT=$P($G(^ONCO(165.5,D0,"SSD4")),U,19)  ; S Category Path
 I STGIND="PT" S SCAT=0  ; No post-therapy S Category field
 D 59^ONCSGA8B Q
60 D 60^ONCSGA8C Q
611 D 611^ONCSGA8C Q
612 D 612^ONCSGA8C Q
621 D 621^ONCSGA8C Q
622 D 622^ONCSGA8C Q
631 D 631^ONCSGA8C Q
632 D 632^ONCSGA8C Q
633 D 633^ONCSGA8C Q
634 D 634^ONCSGA8C Q
64 D 64^ONCSGA8C Q
65 S SG=88 Q  ;no stage grouping
66 S SG=88 Q  ;no stage grouping
671 S SG=88 Q  ;no stage grouping
672 D 672^ONCSGA8C Q
68 D 68^ONCSGA8C Q
69 S SG=88 Q  ;no stage grouping
70 S SG=88 Q  ;no stage grouping
71 S SG=88 Q  ;no stage grouping
72 Q  ;no TNM codes or stage grouping
731 D 731^ONCSGA8C Q
732 D 732^ONCSGA8C Q
74 D 74^ONCSGA8C Q
75 S SG=88 Q  ;no stage grouping
76 D 76^ONCSGA8C Q
77 D 77^ONCSGA8C Q
811 N PBI18 S PBI18=$P($G(^ONCO(165.5,D0,"SSD4")),U,6)  ;Prph Bl Inv (3910)
 D 811^ONCSGA8C Q
 Q
