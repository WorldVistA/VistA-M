ONCSGA8A ;HINES OIFO/RTK - AJCC 8th Ed Automatic Staging Tables ;01/09/19
 ;;2.2;ONCOLOGY;**10,12,17**;Jul 31, 2013;Build 6
 ;
 ;
6 ;CERVICAL LN AND UNK PRIMARIES OF HEAD AND NECK
 S TNM=$E(T,2)_$E(N,2)_$E(M,3)
 I TNM="010" S SG=3 Q
 I TNM="020" S SG="4A" Q
 I TNM="030" S SG="4B" Q
 I T="T0",$E(M,3)="1" S SG="4C"
 Q
 ;
7 ;ORAL CAVITY
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M0" S SG=3 Q
 I ((T="T1")!(T="T2")!(T="T3")),N="N1",M="M0" S SG=3 Q
 I T="T4a",((N="N0")!(N="N1")),M="M0" S SG="4A" Q
 I ((T="T1")!(T="T2")!(T="T3")!(T="T4a")),N["N2",M="M0" S SG="4A" Q
 I N["N3",M="M0" S SG="4B" Q
 I T="T4b",M="M0" S SG="4B" Q
 I M="M1" S SG="4C"
 Q
 ;
8 ;MAJOR SALIVARY GLANDS
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M0" S SG=3 Q
 I ((T="T0")!(T="T1")!(T="T2")!(T="T3")),N="N1",M="M0" S SG=3 Q
 I T="T4a",((N="N0")!(N="N1")),M="M0" S SG="4A" Q
 I ((T="T0")!(T="T1")!(T="T2")!(T="T3")!(T="T4a")),N["N2",M="M0" S SG="4A" Q
 I N["N3",M="M0" S SG="4B" Q
 I T="T4b",M="M0" S SG="4B" Q
 I M="M1" S SG="4C"
 Q
 ;
9 ;NASOPHARYNX
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I ((T="T1")!(T="T0")),N="N1",M="M0" S SG=2 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T2",N="N1",M="M0" S SG=2 Q
 I ((T="T1")!(T="T0")),N="N2",M="M0" S SG=3 Q
 I T="T2",N="N2",M="M0" S SG=3 Q
 I T="T3",((N="N0")!(N="N1")!(N="N2")),M="M0" S SG=3 Q
 I T="T4",((N="N0")!(N="N1")!(N="N2")),M="M0" S SG="4A" Q
 I N="N3",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
 ;
10 ;HPV MEDIATED OROPHARYNGEAL
 S M=$E(M,2,5)
 I STGIND'="P" D
 .I ((T="T0")!(T="T1")!(T="T2")),((N="N0")!(N="N1")),M="M0" S SG=1 Q
 .I ((T="T0")!(T="T1")!(T="T2")),N="N2",M="M0" S SG=2 Q
 .I T="T3",((N="N0")!(N="N1")!(N="N2")),M="M0" S SG=2 Q
 .I ((T="T0")!(T="T1")!(T="T2")!(T="T3")!(T="T4")),N="N3",M="M0" S SG=3 Q
 .I T="T4",((N="N0")!(N="N1")!(N="N2")!(N="N3")),M="M0" S SG=3 Q
 .I M="M1" S SG=4
 I STGIND="P" D
 .I ((T="T0")!(T="T1")!(T="T2")),((N="N0")!(N="N1")),M="M0" S SG=1 Q
 .I ((T="T0")!(T="T1")!(T="T2")),N="N2",M="M0" S SG=2 Q
 .I ((T="T3")!(T="T4")),((N="N0")!(N="N1")),M="M0" S SG=2 Q
 .I ((T="T3")!(T="T4")),N="N2",M="M0" S SG=3 Q
 .I M="M1" S SG=4
 Q
111 ;A BUNCH USE THIS ONE 11.1-13.3
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T["T1",N="N0",M="M0" S SG=1 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M0" S SG=3 Q
 I ((T["T1")!(T="T2")!(T="T3")),N="N1",M="M0" S SG=3 Q
 I T="T4a",((N="N0")!(N="N1")),M="M0" S SG="4A" Q
 I ((T["T1")!(T="T2")!(T="T3")!(T="T4a")),N["N2",M="M0" S SG="4A" Q
 I N["N3",M="M0" S SG="4B" Q
 I T="T4b",M="M0" S SG="4B" Q
 I M="M1" S SG="4C"
 Q
112 ;
 D 111
 Q
121 ;
 D 111
 Q
122 ;
 D 111
 Q
131 ;
 D 111
 Q
132 ;
 D 111
 Q
133 ;
 D 111
 Q
15 ;CUTANEOUS SARCOMA OF THE HEAD AND NECK
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M0" S SG=3 Q
 I T="T1",N="N1",M="M0" S SG=3 Q
 I T="T2",N="N1",M="M0" S SG=3 Q
 I T="T3",N="N1",M="M0" S SG=3 Q
 I T="T1",N="N2",M="M0" S SG=4 Q
 I T="T2",N="N2",M="M0" S SG=4 Q
 I T="T3",N="N2",M="M0" S SG=4 Q
 I N="N3",M="M0" S SG=4 Q
 I T="T4",M="M0" S SG=4 Q
 I M="M1" S SG=4
 Q
161 ;ESOPHAGUS & JUNCTION: SQUAMOUS CELL CARCINOMA
 I STGIND="C" D
 .S M=$E(M,2,5)
 .I T="Tis",N="N0",M="M0" S SG=0 Q
 .I T["T1",((N="N0")!(N="N1")),M="M0" S SG=1 Q
 .I T="T2",((N="N0")!(N="N1")),M="M0" S SG=2 Q
 .I T="T3",N="N0",M="M0" S SG=2 Q
 .I T="T3",N="N1",M="M0" S SG=3 Q
 .I ((T["T1")!(T="T2")!(T="T3")),N="N2",M="M0" S SG=3 Q
 .I T["T4",((N="N0")!(N="N1")!(N="N2")),M="M0" S SG="4A" Q
 .I N="N3",M="M0" S SG="4A" Q
 .I M="M1" S SG="4B" Q
 I STGIND="P" D
 .S M=$E(M,2,5)
 .I T="Tis",N="N0",M="M0" S SG=0 Q
 .I T="T1a",N="N0",M="M0",((G=1)!(G=9)) S SG="1A" Q
 .I T="T1a",N="N0",M="M0",((G=2)!(G=3)) S SG="1B" Q
 .I T="T1b",N="N0",M="M0",((G=1)!(G=2)!(G=3)!(G=9)) S SG="1B" Q
 .I T="T2",N="N0",M="M0",G=1 S SG="1B" Q
 .I T="T2",N="N0",M="M0",((G=2)!(G=3)!(G=9)) S SG="2A" Q
 .I T="T3",N="N0",M="M0",((G=1)!(G=2)!(G=3)),EETE=2 S SG="2A" Q
 .I T="T3",N="N0",M="M0",G=1,((EETE=0)!(EETE=1)) S SG="2A" Q
 .I T="T3",N="N0",M="M0",((G=2)!(G=3)),((EETE=0)!(EETE=1)) S SG="2B" Q
 .I T="T3",N="N0",M="M0",G=9,((EETE=0)!(EETE=1)!(EETE=2)) S SG="2B" Q
 .I T="T3",N="N0",M="M0",EETE=9 S SG="2B" Q
 .I T="T1",N="N1",M="M0" S SG="2B" Q
 .I T="T1",N="N2",M="M0" S SG="3A" Q
 .I T="T2",N="N1",M="M0" S SG="3A" Q
 .I T="T2",N="N2",M="M0" S SG="3B" Q
 .I T="T3",((N="N1")!(N="N2")),M="M0" S SG="3B" Q
 .I T="T4a",((N="N0")!(N="N1")),M="M0" S SG="3B" Q
 .I T="T4a",N="N2",M="M0" S SG="4A" Q
 .I T="T4b",((N="N0")!(N="N1")!(N="N2")),M="M0" S SG="4A" Q
 .I N="N3",M="M0" S SG="4A" Q
 .I M="M1" S SG="4B" Q
 I STGIND="PT" D
 .S M=$E(M,2,5)
 .I ((T="T0")!(T["T1")!(T="T2")),N="N0",M="M0" S SG=1 Q
 .I T="T3",N="N0",M="M0" S SG=2 Q
 .I ((T="T0")!(T["T1")!(T="T2")),N="N1",M="M0" S SG="3A" Q
 .I T="T3",N="N1",M="M0" S SG="3B" Q
 .I ((T="T0")!(T["T1")!(T="T2")!(T="T3")),N="N2",M="M0" S SG="3B" Q
 .I T="T4a",N="N0",M="M0" S SG="3B" Q
 .I T="T4a",((N="N1")!(N="N2")),M="M0" S SG="4A" Q
 .I T="T4a",N="NX",M="M0" S SG="4A" Q
 .I T="T4b",((N="N0")!(N="N1")!(N="N2")),M="M0" S SG="4A" Q
 .I N="N3",M="M0" S SG="4A" Q
 .I M="M1" S SG="4B" Q
 Q
162 ;ESOPHAGUS & JUNCTION: ADENOCARCINOMA
 I STGIND="C" D
 .S M=$E(M,2,5)
 .I T="Tis",N="N0",M="M0" S SG=0 Q
 .I T["T1",N="N0",M="M0" S SG=1 Q
 .I T["T1",N="N1",M="M0" S SG="2A" Q
 .I T="T2",N="N0",M="M0" S SG="2B" Q
 .I T="T2",N="N1",M="M0" S SG=3 Q
 .I T="T3",((N="N0")!(N="N1")),M="M0" S SG=3 Q
 .I T="T4a",((N="N0")!(N="N1")),M="M0" S SG=3 Q
 .I ((T["T1")!(T="T2")!(T="T3")!(T="T4a")),N="N2",M="M0" S SG="4A" Q
 .I T="T4b",((N="N0")!(N="N1")!(N="N2")),M="M0" S SG="4A" Q
 .I N="N3",M="M0" S SG="4A" Q
 .I M="M1" S SG="4B" Q
 I STGIND="P" D
 .S M=$E(M,2,5)
 .I T="Tis",N="N0",M="M0" S SG=0 Q
 .I T="T1a",N="N0",M="M0",((G=1)!(G=9)) S SG="1A" Q
 .I T="T1a",N="N1",M="M0",G=2 S SG="1B" Q
 .I T="T1b",N="N0",M="M0",((G=1)!(G=2)!(G=9)) S SG="1B" Q
 .I T="T1",N="N0",M="M0",G=3 S SG="1C" Q
 .I T="T2",N="N0",M="M0",((G=1)!(G=2)) S SG="1C" Q
 .I T="T2",N="N0",M="M0",((G=3)!(G=9)) S SG="2A" Q
 .I T="T1",N="N1",M="M0" S SG="2B" Q
 .I T="T3",N="N0",M="M0" S SG="2B" Q
 .I T="T1",N="N2",M="M0" S SG="3A" Q
 .I T="T2",N="N1",M="M0" S SG="3A" Q
 .I T="T2",N="N2",M="M0" S SG="3B" Q
 .I T="T3",((N="N1")!(N="N2")),M="M0" S SG="3B" Q
 .I T="T4a",((N="N0")!(N="N1")),M="M0" S SG="3B" Q
 .I T="T4a",N="N2",M="M0" S SG="4A" Q
 .I T="T4b",((N="N0")!(N="N1")!(N="N2")),M="M0" S SG="4A" Q
 .I N="N3",M="M0" S SG="4A" Q
 .I M="M1" S SG="4B" Q
 I STGIND="PT" D
 .S M=$E(M,2,5)
 .I ((T="T0")!(T["T1")!(T="T2")),N="N0",M="M0" S SG=1 Q
 .I T="T3",N="N0",M="M0" S SG=2 Q
 .I ((T="T0")!(T["T1")!(T="T2")),N="N1",M="M0" S SG="3A" Q
 .I T="T3",N="N1",M="M0" S SG="3B" Q
 .I ((T="T0")!(T["T1")!(T="T2")!(T="T3")),N="N2",M="M0" S SG="3B" Q
 .I T="T4a",N="N0",M="M0" S SG="3B" Q
 .I T="T4a",((N="N1")!(N="N2")!(N="NX")),M="M0" S SG="4A" Q
 .I T="T4b",((N="N0")!(N="N1")!(N="N2")),M="M0" S SG="4A" Q
 .I N="N3",M="M0" S SG="4A" Q
 .I M="M1" S SG="4B" Q
 Q
17 ;STOMACH
 I STGIND="C" D
 .S M=$E(M,2,5)
 .I T="Tis",N="N0",M="M0" S SG=0 Q
 .I ((T="T1")!(T="T2")),N="N0",M="M0" S SG=1 Q
 .I ((T="T1")!(T="T2")),((N="N1")!(N="N2")!(N="N3")),M="M0" S SG="2A" Q
 .I ((T="T3")!(T="T4a")),N="N0",M="M0" S SG="2B" Q
 .I ((T="T3")!(T="T4a")),((N="N1")!(N="N2")!(N="N3")),M="M0" S SG=3 Q
 .I T="T4b",M="M0" S SG="4A" Q
 .I M="M1" S SG="4B" Q
 I STGIND="P" D
 .S M=$E(M,2,5)
 .I T="Tis",N="N0",M="M0" S SG=0 Q
 .I T="T1",N="N0",M="M0" S SG="1A" Q
 .I T="T1",N="N1",M="M0" S SG="1B" Q
 .I T="T2",N="N0",M="M0" S SG="1B" Q
 .I T="T1",N="N2",M="M0" S SG="2A" Q
 .I T="T2",N="N1",M="M0" S SG="2A" Q
 .I T="T3",N="N0",M="M0" S SG="2A" Q
 .I T="T1",N="N3a",M="M0" S SG="2B" Q
 .I T="T2",N="N2",M="M0" S SG="2B" Q
 .I T="T3",N="N1",M="M0" S SG="2B" Q
 .I T="T4a",N="N0",M="M0" S SG="2B" Q
 .I T="T2",N="N3a",M="M0" S SG="3A" Q
 .I T="T3",N="N2",M="M0" S SG="3A" Q
 .I T="T4a",N="N1",M="M0" S SG="3A" Q
 .I T="T4a",N="N2",M="M0" S SG="3A" Q
 .I T="T4b",N="N0",M="M0" S SG="3A" Q
 .I T="T1",N="N3b",M="M0" S SG="3B" Q
 .I T="T2",N="N3b",M="M0" S SG="3B" Q
 .I T="T3",N="N3a",M="M0" S SG="3B" Q
 .I T="T4a",N="N3a",M="M0" S SG="3B" Q
 .I T="T4b",N="N1",M="M0" S SG="3B" Q
 .I T="T4b",N="N2",M="M0" S SG="3B" Q
 .I T="T3",N="N3b",M="M0" S SG="3C" Q
 .I T="T4a",N="N3b",M="M0" S SG="3C" Q
 .I T="T4b",N="N3a",M="M0" S SG="3C" Q
 .I T="T4b",N="N3b",M="M0" S SG="3C" Q
 .I M="M1" S SG=4 Q
 I STGIND="PT" D
 .S M=$E(M,2,5)
 .I ((T="T1")!(T="T2")),N="N0",M="M0" S SG=1 Q
 .I T="T1",N="N1",M="M0" S SG=1 Q
 .I T="T3",N="N0",M="M0" S SG=2 Q
 .I T="T2",N="N1",M="M0" S SG=2 Q
 .I T="T1",N="N2",M="M0" S SG=2 Q
 .I T="T4a",N="N0",M="M0" S SG=2 Q
 .I T="T3",N="N1",M="M0" S SG=2 Q
 .I T="T2",N="N2",M="M0" S SG=2 Q
 .I T="T1",N="N3",M="M0" S SG=2 Q
 .I T="T4a",N="N1",M="M0" S SG=3 Q
 .I T="T3",N="N2",M="M0" S SG=3 Q
 .I T="T2",N="N3",M="M0" S SG=3 Q
 .I T="T4b",((N="N0")!(N="N1")),M="M0" S SG=3 Q
 .I T="T4a",N="N2",M="M0" S SG=3 Q
 .I T="T3",N="N3",M="M0" S SG=3 Q
 .I T="T4b",((N="N2")!(N="N3")),M="M0" S SG=3 Q
 .I T="T4a",N="N3",M="M0" S SG=3 Q
 .I M="M1" S SG=4 Q
 Q
181 ;
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I ((T="T1")!(T="T2")),N="N0",M="M0" S SG=1 Q
 I T="T3",N="N0",M="M0" S SG="2A" Q
 I T="T4",N="N0",M="M0" S SG="2B" Q
 I N="N1",M="M0" S SG="3A" Q
 I N="N2",M="M0" S SG="3B" Q
 I M="M1" S SG=4
 Q
19 ;APPENDIX
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="Tis(LAMN)",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T2",N="N0",M="M0" S SG=1 Q
 I T="T3",N="N0",M="M0" S SG="2A" Q
 I T="T4a",N="N0",M="M0" S SG="2B" Q
 I T="T4b",N="N0",M="M0" S SG="2C" Q
 I T="T1",N["N1",M="M0" S SG="3A" Q
 I T="T2",N["N1",M="M0" S SG="3A" Q
 I T="T3",N["N1",M="M0" S SG="3B" Q
 I T["T4",N["N1",M="M0" S SG="3B" Q
 I N="N2",M="M0" S SG="3C" Q
 I M="M1a" S SG="4A" Q
 I M="M1b",G=1 S SG="4A" Q
 I M="M1b",((G=2)!(G=3)!(G=9)) S SG="4B" Q
 I M="M1c" S SG="4C"
 Q
20 ;COLON & RECTUM
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I ((T="T1")!(T="T2")),N="N0",M="M0" S SG=1 Q
 I T="T3",N="N0",M="M0" S SG="2A" Q
 I T="T4a",N="N0",M="M0" S SG="2B" Q
 I T="T4b",N="N0",M="M0" S SG="2C" Q
 I ((T="T1")!(T="T2")),($E(N,1,2)="N1"),M="M0" S SG="3A" Q
 I T="T1",N="N2a",M="M0" S SG="3A" Q
 I ((T="T3")!(T="T4a")),($E(N,1,2)="N1"),M="M0" S SG="3B" Q
 I ((T="T2")!(T="T3")),N="N2a",M="M0" S SG="3B" Q
 I ((T="T1")!(T="T2")),N="N2b",M="M0" S SG="3B" Q
 I T="T4a",N="N2a",M="M0" S SG="3C" Q
 I ((T="T3")!(T="T4a")),N="N2b",M="M0" S SG="3C" Q
 I T="T4b",(($E(N,1,2)="N1")!($E(N,1,2)="N2")),M="M0" S SG="3C" Q
 I M="M1a" S SG="4A" Q
 I M="M1b" S SG="4B" Q
 I M="M1c" S SG="4C"
 Q
21 ;ANUS
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1",N="N1",M="M0" S SG="3A" Q
 I T="T2",N="N0",M="M0" S SG="2A" Q
 I T="T2",N="N1",M="M0" S SG="3A" Q
 I T="T3",N="N0",M="M0" S SG="2B" Q
 I T="T3",N="N1",M="M0" S SG="3C" Q
 I T="T4",N="N0",M="M0" S SG="3B" Q
 I T="T4",N="N1",M="M0" S SG="3C" Q
 I M="M1" S SG=4
 Q
22 ;LIVER
 S M=$E(M,2,5)
 I T="T1a",N="N0",M="M0" S SG="1A" Q
 I T="T1b",N="N0",M="M0" S SG="1B" Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M0" S SG="3A" Q
 I T="T4",N="N0",M="M0" S SG="3B" Q
 I N="N1",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
23 ;INTRAHEPATIC BILE DUCTS
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1a",N="N0",M="M0" S SG="1A" Q
 I T="T1b",N="N0",M="M0" S SG="1B" Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M0" S SG="3A" Q
 I T="T4",N="N0",M="M0" S SG="3B" Q
 I N="N1",M="M0" S SG="3B" Q
 I M="M1" S SG=4
 Q
24 ;GALLBLADDER
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T2a",N="N0",M="M0" S SG="2A" Q
 I T="T2b",N="N0",M="M0" S SG="2B" Q
 I T="T3",N="N0",M="M0" S SG="3A" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")!(($E(T,1,2)="T3"))),N="N1",M="M0" S SG="3B" Q
 I T="T4",(($E(N,1,2)="N0")!($E(N,1,2)="N1")),M="M0" S SG="4A" Q
 I N="N2",M="M0" S SG="4B" Q
 I M="M1" S SG="4B"
 Q
25 ;PERIHILAR BILE DUCTS
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I ((T="T2a")!(T="T2b")),N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M0" S SG="3A" Q
 I T="T4",N="N0",M="M0" S SG="3B" Q
 I N="N1",M="M0" S SG="3C" Q
 I N="N2",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
26 ;DISTAL BILE DUCTS
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1",N="N1",M="M0" S SG="2A" Q
 I T="T1",N="N2",M="M0" S SG="3A" Q
 I T="T2",N="N0",M="M0" S SG="2A" Q
 I T="T2",N="N1",M="M0" S SG="2B" Q
 I T="T2",N="N2",M="M0" S SG="3A" Q
 I T="T3",N="N0",M="M0" S SG="2B" Q
 I T="T3",N="N1",M="M0" S SG="2B" Q
 I T="T3",N="N2",M="M0" S SG="3A" Q
 I T="T4",N="N0",M="M0" S SG="3B" Q
 I T="T4",N="N1",M="M0" S SG="3B" Q
 I T="T4",N="N2",M="M0" S SG="3B" Q
 I M="M1" S SG=4
 Q
27 ;AMPULLA OF VATER
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1a",N="N0",M="M0" S SG="1A" Q
 I T="T1a",N="N1",M="M0" S SG="3A" Q
 I T="T1b",N="N0",M="M0" S SG="1B" Q
 I T="T1b",N="N1",M="M0" S SG="3A" Q
 I T="T2",N="N0",M="M0" S SG="1B" Q
 I T="T2",N="N1",M="M0" S SG="3A" Q
 I T="T3a",N="N0",M="M0" S SG="2A" Q
 I T="T3a",N="N1",M="M0" S SG="3A" Q
 I T="T3b",N="N0",M="M0" S SG="2B" Q
 I T="T3b",N="N1",M="M0" S SG="3A" Q
 I T="T4",M="M0" S SG="3B" Q
 I N="N2",M="M0" S SG="3B" Q
 I M="M1" S SG=4
 Q
28 ;EXOCRINE PANCREAS
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG="1A" Q
 I T="T1",N="N1",M="M0" S SG="2B" Q
 I T="T1",N="N2",M="M0" S SG=3 Q
 I T="T2",N="N0",M="M0" S SG="1B" Q
 I T="T2",N="N1",M="M0" S SG="2B" Q
 I T="T2",N="N2",M="M0" S SG=3 Q
 I T="T3",N="N0",M="M0" S SG="2A" Q
 I T="T3",N="N1",M="M0" S SG="2B" Q
 I T="T3",N="N2",M="M0" S SG=3 Q
 I T="T4",M="M0" S SG=3 Q
 I M="M1" S SG=4
 Q
29 ;NET
 S M=$E(M,2,5)
 I ((T="TX")!(T="T0")),((N="NX")!(N="N0")!(N="N1")),M["M1" S SG=4 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1",N="N1",M="M0" S SG=3 Q
 I T="T1",((N="NX")!(N="N0")!(N="N1")),M["M1" S SG=4 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T2",N="N1",M="M0" S SG=3 Q
 I T="T2",((N="NX")!(N="N0")!(N="N1")),M["M1" S SG=4 Q
 I T="T3",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N1",M="M0" S SG=3 Q
 I T="T3",((N="NX")!(N="N0")!(N="N1")),M["M1" S SG=4 Q
 I T="T4",N="N0",M="M0" S SG=3 Q
 I T="T4",N="N1",M="M0" S SG=3 Q
 I T="T4",((N="NX")!(N="N0")!(N="N1")),M["M1" S SG=4
 Q
 ;
 ;
CLEANUP ;Cleanup
 K M,N,SG,T
 Q
