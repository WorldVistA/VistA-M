ONCSGA8B ;Hines OIFO/RTK - AJCC 8th Ed Automatic Staging Tables ;01/15/19
 ;;2.2;ONCOLOGY;**10,12**;Jul 31, 2013;Build 8
 ;
 ;
30 ;NET
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M0" S SG=2 Q
 I T="T4",N="N0",M="M0" S SG=3 Q
 I N="N1",M="M0" S SG=3 Q
 I M["M1" S SG=4
 Q
31 ;NET
 S M=$E(M,2,5)
 I ((T="TX")!(T="T0")),((N="NX")!(N="N0")!(N="N1")!(N="N2")),M["M1" S SG=4 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1",((N="N1")!(N="N2")),M="M0" S SG=3 Q
 I T="T1",((N="NX")!(N="N0")!(N="N1")!(N="N2")),M["M1" S SG=4 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T2",((N="N1")!(N="N2")),M="M0" S SG=3 Q
 I T="T2",((N="NX")!(N="N0")!(N="N1")!(N="N2")),M["M1" S SG=4 Q
 I T="T3",N="N0",M="M0" S SG=2 Q
 I T="T3",((N="N1")!(N="N2")),M="M0" S SG=3 Q
 I T="T3",((N="NX")!(N="N0")!(N="N1")!(N="N2")),M["M1" S SG=4 Q
 I T="T4",N="N0",M="M0" S SG=3 Q
 I T="T4",((N="N1")!(N="N2")),M="M0" S SG=3 Q
 I T="T4",((N="NX")!(N="N0")!(N="N1")!(N="N2")),M["M1" S SG=4
 Q
32 ;NET
 D 29^ONCSGA8A
 Q
33 ;NET
 S M=$E(M,2,5)
 I ((T="TX")!(T="T0")),M["M1" S SG=4 Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1",N="N1",M="M0" S SG="3B" Q
 I T="T1",M["M1" S SG=4 Q
 I T="T2",N="N0",M="M0" S SG="2A" Q
 I T="T2",N="N1",M="M0" S SG="3B" Q
 I T="T2",M["M1" S SG=4 Q
 I T="T3",N="N0",M="M0" S SG="2B" Q
 I T="T3",N="N1",M="M0" S SG="3B" Q
 I T="T3",M["M1" S SG=4 Q
 I T="T4",N="N0",M="M0" S SG="3A" Q
 I T="T4",N="N1",M="M0" S SG="3B" Q
 I T="T4",M["M1" S SG=4
 Q
34 ;NET
 D 30
 Q
35 ;THYMUS
 S M=$E(M,2,5)
 I ((T="T1a")!(T="T1b")),N="N0",M="M0" S SG=1 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M0" S SG="3A" Q
 I T="T4",N="N0",M="M0" S SG="3B" Q
 I N="N1",M="M0" S SG="4A" Q
 I ((N="N0")!(N="N1")),M="M1a" S SG="4A" Q
 I N="N2",((M="M0")!(M="M1a")) S SG="4B" Q
 I M="M1b" S SG="4B"
 Q
36 ;LUNG
 S M=$E(M,2,5)
 I T="TX",N="N0",M="M0" S SG="OccultCarcinoma" Q
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1mi",N="N0",M="M0" S SG="1A1" Q
 I T="T1a",N="N0",M="M0" S SG="1A1" Q
 I T="T1a",N="N1",M="M0" S SG="2B" Q
 I T="T1a",N="N2",M="M0" S SG="3A" Q
 I T="T1a",N="N3",M="M0" S SG="3B" Q
 I T="T1b",N="N0",M="M0" S SG="1A2" Q
 I T="T1b",N="N1",M="M0" S SG="2B" Q
 I T="T1b",N="N2",M="M0" S SG="3A" Q
 I T="T1b",N="N3",M="M0" S SG="3B" Q
 I T="T1c",N="N0",M="M0" S SG="1A3" Q
 I T="T1c",N="N1",M="M0" S SG="2B" Q
 I T="T1c",N="N2",M="M0" S SG="3A" Q
 I T="T1c",N="N3",M="M0" S SG="3B" Q
 I T="T2a",N="N0",M="M0" S SG="1B" Q
 I T="T2a",N="N1",M="M0" S SG="2B" Q
 I T="T2a",N="N2",M="M0" S SG="3A" Q
 I T="T2a",N="N3",M="M0" S SG="3B" Q
 I T="T2b",N="N0",M="M0" S SG="2A" Q
 I T="T2b",N="N1",M="M0" S SG="2B" Q
 I T="T2b",N="N2",M="M0" S SG="3A" Q
 I T="T2b",N="N3",M="M0" S SG="3B" Q
 I T="T3",N="N0",M="M0" S SG="2B" Q
 I T="T3",N="N1",M="M0" S SG="3A" Q
 I T="T3",N="N2",M="M0" S SG="3B" Q
 I T="T3",N="N3",M="M0" S SG="3C" Q
 I T="T4",N="N0",M="M0" S SG="3A" Q
 I T="T4",N="N1",M="M0" S SG="3A" Q
 I T="T4",N="N2",M="M0" S SG="3B" Q
 I T="T4",N="N3",M="M0" S SG="3C" Q
 I M="M1" S SG="4A" Q
 I M="M1a" S SG="4A" Q
 I M="M1b" S SG="4A" Q
 I M="M1c" S SG="4B"
 Q
37 ;MALIGNANT PLEURAL MESOTHELIOMA
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0" S SG="1A" Q
 I ((T="T2")!(T="T3")),N="N0",M="M0" S SG="1B" Q
 I T="T1",N="N1",M="M0" S SG=2 Q
 I T="T2",N="N1",M="M0" S SG=2 Q
 I T="T3",N="N1",M="M0" S SG="3A" Q
 I ((T="T1")!(T="T2")!(T="T3")),N="N2",M="M0" S SG="3B" Q
 I T="T4",M="M0" S SG="3B" Q
 I M="M1" S SG=4
 Q
381 ;BONE
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0",((G=1)!(G=9)) S SG="1A" Q
 I T="T2",N="N0",M="M0",((G=1)!(G=9)) S SG="1B" Q
 I T="T3",N="N0",M="M0",((G=1)!(G=9)) S SG="1B" Q
 I T="T1",N="N0",M="M0",((G=2)!(G=3)) S SG="2A" Q
 I T="T2",N="N0",M="M0",((G=2)!(G=3)) S SG="2B" Q
 I T="T3",N="N0",M="M0",((G=2)!(G=3)) S SG=3 Q
 I N="N0",M="M1a" S SG="4A" Q
 I N="N1" S SG="4A" Q
 I M="M1b" S SG="4B"
 Q
41 ;SOFT TISSUE
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0",((G=1)!(G=9)) S SG="1A" Q
 I ((T="T2")!(T="T3")!(T="T4")),N="N0",M="M0",((G=1)!(G=9)) S SG="1B" Q
 I T="T1",N="N0",M="M0",((G=2)!(G=3)) S SG=2 Q
 I T="T2",N="N0",M="M0",((G=2)!(G=3)) S SG="3A" Q
 I ((T="T3")!(T="T4")),N="N0",M="M0",((G=2)!(G=3)) S SG="3B" Q
 I N="N1",M="M0" S SG=4 Q
 I M="M1" S SG=4
 Q
431 ;GIST
 S M=$E(M,2,5)
 I ((T="T1")!(T="T2")),N="N0",M="M0",MTRT="L" S SG="1A" Q
 I T="T3",N="N0",M="M0",MTRT="L" S SG="1B" Q
 I T="T1",N="N0",M="M0",MTRT="H" S SG=2 Q
 I T="T2",N="N0",M="M0",MTRT="H" S SG=2 Q
 I T="T4",N="N0",M="M0",MTRT="L" S SG=3 Q
 I T="T3",N="N0",M="M0",MTRT="H" S SG="3A" Q
 I T="T4",N="N0",M="M0",MTRT="H" S SG="3B" Q
 I N="N1",M="M0" S SG=4 Q
 I M="M1" S SG=4
 Q
432 ;GIST
 S M=$E(M,2,5)
 I ((T="T1")!(T="T2")),N="N0",M="M0",MTRT="L" S SG=1 Q
 I T="T3",N="N0",M="M0",MTRT="L" S SG=2 Q
 I T="T1",N="N0",M="M0",MTRT="H" S SG="3A" Q
 I T="T4",N="N0",M="M0",MTRT="L" S SG="3A" Q
 I T="T2",N="N0",M="M0",MTRT="H" S SG="3B" Q
 I T="T3",N="N0",M="M0",MTRT="H" S SG="3B" Q
 I T="T4",N="N0",M="M0",MTRT="H" S SG="3B" Q
 I N="N1",M="M0" S SG=4 Q
 I M="M1" S SG=4
 Q
44 ;SOFT TISSUE
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0",((G=1)!(G=9)) S SG="1A" Q
 I ((T="T2")!(T="T3")!(T="T4")),N="N0",M="M0",((G=1)!(G=9)) S SG="1B" Q
 I T="T1",N="N0",M="M0",((G=2)!(G=3)) S SG=2 Q
 I T="T2",N="N0",M="M0",((G=2)!(G=3)) S SG="3A" Q
 I ((T="T3")!(T="T4")),N="N0",M="M0",((G=2)!(G=3)) S SG="3B" Q
 I N="N1",M="M0" S SG="3B" Q
 I M="M1" S SG=4
 Q
46 ;MERKEL CELL
 S M=$E(M,2,5)
 I STGIND'="P" D
 .I T="Tis",N="N0",M="M0" S SG=0 Q
 .I T="T1",N="N0",M="M0" S SG=1 Q
 .I ((T="T2")!(T="T3")),N="N0",M="M0" S SG="2A" Q
 .I T="T4",N="N0",M="M0" S SG="2B" Q
 .I ((T="T0")!(T="T1")!(T="T2")!(T="T3")!(T="T4")),((N="N1")!(N="N2")!(N="N3")),M="M0" S SG=3 Q
 .I ((T="T0")!(T="T1")!(T="T2")!(T="T3")!(T="T4")),M["M1" S SG=4 Q
 I STGIND="P" D
 .I T="Tis",N="N0",M="M0" S SG=0 Q
 .I T="T1",N="N0",M="M0" S SG=1 Q
 .I ((T="T2")!(T="T3")),N="N0",M="M0" S SG="2A" Q
 .I T="T4",N="N0",M="M0" S SG="2B" Q
 .I ((T="T1")!(T="T2")!(T="T3")!(T="T4")),N="N1a",M="M0",PNSFX'="(f)" S SG="3A" Q
 .I T="T0",N="N1b",M="M0" S SG="3A" Q
 .I ((T="T1")!(T="T2")!(T="T3")!(T="T4")),((N="N1b")!(N="N2")!(N="N3")),M="M0" S SG="3B" Q
 .I ((T="T0")!(T="T1")!(T="T2")!(T="T3")!(T="T4")),M["M1" S SG=4 Q
 Q
47 ;MELANOMA OF THE SKIN
 S M=$E(M,2,5)
 I STGIND'="P" D
 .I T="Tis",N="N0",M="M0" S SG=0 Q
 .I T="T1a",N="N0",M="M0" S SG="1A" Q
 .I T="T1b",N="N0",M="M0" S SG="1B" Q
 .I T="T2a",N="N0",M="M0" S SG="1B" Q
 .I T="T2b",N="N0",M="M0" S SG="2A" Q
 .I T="T3a",N="N0",M="M0" S SG="2A" Q
 .I T="T3b",N="N0",M="M0" S SG="2B" Q
 .I T="T4a",N="N0",M="M0" S SG="2B" Q
 .I T="T4b",N="N0",M="M0" S SG="2C" Q
 .I N'="NX",N'="N0",M="M0" S SG=3 Q
 .I M["M1" S SG=4 Q
 I STGIND="P" D
 .I T="Tis",N="N0",M="M0" S SG=0 Q
 .I ((T="T1a")!(T="T1b")),N="N0",M="M0" S SG="1A" Q
 .I T="T2a",N="N0",M="M0" S SG="1B" Q
 .I ((T="T2b")!(T="T3a")),N="N0",M="M0" S SG="2A" Q
 .I ((T="T3b")!(T="T4a")),N="N0",M="M0" S SG="2B" Q
 .I T="T4b",N="N0",M="M0" S SG="2C" Q
 .I T="T0",((N="N1b")!(N="N1c")),M="M0" S SG="3B" Q
 .I T="T0",((N="N2b")!(N="N2c")!(N="N3b")!(N="N3c")),M="M0" S SG="3C" Q
 .I ((T="T1a")!(T="T1b")!(T="T2a")),((N="N1a")!(N="N2a")),M="M0" S SG="3A" Q
 .I ((T="T1a")!(T="T1b")!(T="T2a")),((N="N1b")!(N="N1c")!(N="N2b")),M="M0" S SG="3B" Q
 .I ((T="T2b")!(T="T3a")),((N="N1a")!(N="N1b")!(N="N1c")!(N="N2a")!(N="N2b")),M="M0" S SG="3B" Q
 .I ((T="T1a")!(T="T1b")!(T="T2a")!(T="T2b")!(T="T3a")),((N="N2c")!(N="N3a")!(N="N3b")!(N="N3c")),M="M0" S SG="3C" Q
 .I ((T="T3b")!(T="T4a")),((N'="NX")&(N'="N0")),M="M0" S SG="3C" Q
 .I T="T4b",((N="N1a")!(N="N1b")!(N="N1c")!(N="N2a")!(N="N2b")!(N="N2c")),M="M0" S SG="3C" Q
 .I T="T4b",((N="N3a")!(N="N3b")!(N="N3c")),M="M0" S SG="3D" Q
 .I M["M1" S SG=4 Q
 Q
48 ;BREAST
 S M=$E(M,2,3) ;can strip,only use char 2-3 b/c M0(i+) treated same as M0
 I STGIND'="P" D
 .I T["Tis",N="N0",M="M0" S SG=0 Q
 .I ((T["T1")&(N="N0")&(M="M0"))!((T="T0")&(N="N1mi")&(M="M0"))!((T["T1")&(N="N1mi")&(M="M0")) D 1^ONCSGA8X
 .I ((T="T0")&(N["N1")&(M="M0"))!((T["T1")&(N["N1")&(M="M0"))&((T="T2")&(N="N0")&(M="M0")) D 2^ONCSGA8X
 .I ((T="T2")&(N["N1")&(M="M0"))!((T="T3")&(N="N0")&(M="M0")) D 3^ONCSGA8X
 .I ((T="T0")&(N="N2")&(M="M0"))!((T["T1")&(N="N2")&(M="M0"))!((T="T2")&(N="N2")&(M="M0"))!((T="T3")&(N["N1")&(M="M0"))!((T="T3")&(N="N2")&(M="M0")) D 4^ONCSGA8X
 .I ((T="T4")&(N="N0")&(M="M0"))!((T="T4")&(N["N1")&(M="M0"))!((T="T4")&(N="N2")&(M="M0"))!((N="N3")&(M="M0")) D 5^ONCSGA8X
 .I M="M1" S SG=4
 I STGIND="P" D
 .I T["Tis",N="N0",M="M0" S SG=0 Q
 .I ((T["T1")&(N="N0")&(M="M0"))!((T="T0")&(N="N1mi")&(M="M0"))!((T["T1")&(N="N1mi")&(M="M0")) D 1^ONCSGA8X
 .I ((T="T0")&(N["N1")&(M="M0"))!((T["T1")&(N["N1")&(M="M0"))!((T="T2")&(N="N0")&(M="M0")) D 2^ONCSGA8X
 .I ((T="T2")&(N["N1")&(M="M0"))!((T="T3")&(N="N0")&(M="M0")) D 3^ONCSGA8X
 .I ((T="T0")&(N="N2")&(M="M0"))!((T["T1")&(N="N2")&(M="M0"))!((T="T2")&(N="N2")&(M="M0"))!((T="T3")&(N["N1")&(M="M0"))!((T="T3")&(N="N2")&(M="M0")) D 4^ONCSGA8X
 .I ((T="T4")&(N="N0")&(M="M0"))!((T="T4")&(N["N1")&(M="M0"))!((T="T4")&(N="N2")&(M="M0"))!((N="N3")&(M="M0")) D 5^ONCSGA8X
 .I M="M1" S SG=4
 Q
 ;
50 ;VULVA
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1a",N="N0",M="M0" S SG="1A" Q
 I T="T1b",N="N0",M="M0" S SG="1B" Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")),(($E(N,1,2)="N1")!($E(N,1,2)="N2")),M="M0" S SG=3 Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")),N="N1",M="M0" S SG="3A" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")),((N="N2a")!(N="N2b")),M="M0" S SG="3B" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")),N="N2c",M="M0" S SG="3C" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")!($E(T,1,2)="T3")),N="N3",((M="M0")!(M="M1")) S SG=4 Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")),N="N3",M="M1" S SG="4A" Q
 I T="T3",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
51 ;VAGINA
 S M=$E(M,2,5)
 I T="T1a",N="N0",M="M0" S SG="1A" Q
 I T="T1b",N="N0",M="M0" S SG="1B" Q
 I T="T2a",N="N0",M="M0" S SG="2A" Q
 I T="T2b",N="N0",M="M0" S SG="2B" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")!($E(T,1,2)="T3")),N="N1",((M="M0")!(M="M1")) S SG=3 Q
 I T="T3",N="N0",M="M1" S SG=3 Q
 I T="T4",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
52 ;CERVIX UTERI
 S M=$E(M,2,5)
 I T="T1",M="M0" S SG=1 Q
 I T="T1a",M="M0" S SG="1A" Q
 I T="T1a1",M="M0" S SG="1A1" Q
 I T="T1a2",M="M0" S SG="1A2" Q
 I T="T1b",M="M1" S SG="1B" Q
 I T="T1b1",M="M0" S SG="1B1" Q
 I T="T1b2",M="M0" S SG="1B2" Q
 I T="T2",M="M0" S SG=2 Q
 I T="T2a",M="M0" S SG="2A" Q
 I T="T2a1",M="M0" S SG="2A1" Q
 I T="T2a2",M="M0" S SG="2A2" Q
 I T="T2b",M="M0" S SG="2B" Q
 I T="T3",M="M0" S SG=3 Q
 I T="T3a",M="M0" S SG="3A" Q
 I T="T3b",M="M0" S SG="3B" Q
 I T="T4",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
53 ;CORPUS UTERI
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1a",N="N0",M="M0" S SG="1A" Q
 I T="T1b",N="N0",M="M0" S SG="1B" Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M1" S SG=3 Q
 I T="T3a",N="N0",M="M0" S SG="3A" Q
 I T="T3b",N="N0",M="M0" S SG="3B" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")!($E(T,1,2)="T3")),((N="N1")!(N="N1mi")!(N="N1a")),M="M0" S SG="3C1" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")!($E(T,1,2)="T3")),((N="N2")!(N="N2mi")!(N="N2a")),M="M0" S SG="3C2" Q
 I T="T4",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
541 ;CORPUS UTERI
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1a",N="N0",M="M0" S SG="1A" Q
 I T="T1b",N="N0",M="M0" S SG="1B" Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3a",N="N0",M="M0" S SG="3A" Q
 I T="T3b",N="N0",M="M0" S SG="3B" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")!($E(T,1,2)="T3")),N="N1",M="M0" S SG="3C" Q
 I T="T4",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
542 ;CORPUS UTERI
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1a",N="N0",M="M0" S SG="1A" Q
 I T="T1b",N="N0",M="M0" S SG="1B" Q
 I T="T1c",N="N0",M="M0" S SG="1C" Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3a",N="N0",M="M0" S SG="3A" Q
 I T="T3b",N="N0",M="M0" S SG="3B" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")!($E(T,1,2)="T3")),N="N1",M="M0" S SG="3C" Q
 I T="T4",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
55 ;OVARY, FALLOPIAN TUBE AND PRIMARY PERITONEAL CARCINOMA
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1a",N="N0",M="M0" S SG="1A" Q
 I T="T1b",N="N0",M="M0" S SG="1B" Q
 I T="T1c",N="N0",M="M0" S SG="1C" Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T2a",N="N0",M="M0" S SG="2A" Q
 I T="T2b",N="N0",M="M0" S SG="2B" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")),N="N1",M="M0" S SG="3A1" Q
 I T="T3a",((N="NX")!(N="N0")!(N="N1")),M="M0" S SG="3A2" Q
 I T="T3b",((N="NX")!(N="N0")!(N="N1")),M="M0" S SG="3B" Q
 I T="T3c",((N="NX")!(N="N0")!(N="N1")),M="M0" S SG="3C" Q
 I M="M1" S SG=4 Q
 I M="M1a" S SG="4A" Q
 I M="M1b" S SG="4B"
 Q
56 ;GTN
 S M=$E(M,2,5)
 I T="T1",M="M0" S SG=1
 I T="T1",M="M1a" S SG=3
 I T="T1",M="M1b" S SG=4
 I T="T2",M="M0" S SG=2
 I T="T1",M="M1a" S SG=3
 I T="T1",M="M1b" S SG=4
 I SG'="",RSCORE'="" S SG=SG_":"_RSCORE
 Q
57 ;PENIS
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG="0is" Q
 I T="Ta",N="N0",M="M0" S SG="0a" Q
 I T="T1a",N="N0",M="M0" S SG=1 Q
 I T="T1b",N="N0",M="M0" S SG="2A" Q
 I T="T2",N="N0",M="M0" S SG="2A" Q
 I T="T3",N="N0",M="M0" S SG="2B" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")!($E(T,1,2)="T3")),N="N1",M="M0" S SG="3A" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")!($E(T,1,2)="T3")),N="N2",M="M0" S SG="3B" Q
 I T="T4",M="M0" S SG=4 Q
 I N="N3",M="M0" S SG=4 Q
 I M="M1" S SG=4
 Q
58 ;PROSTATE
 S M=$E(M,2,5)
 I (($E(T,1,2)="T1")!(T="T2a")),N="N0",M="M0",PSA<10,G=1 S SG=1 Q
 I T="T2",N="N0",M="M0",PSA<10,G=1 S SG=1 Q
 I (($E(T,1,2)="T1")!(T="T2")!(T="T2a")),N="N0",M="M0",((PSA>10)&(PSA<20)),G=1 S SG="2A" Q
 I (($E(T,1,2)="T2")),N="N0",M="M0",PSA<20,G=1 S SG="2A" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")),N="N0",M="M0",PSA<20,G=2 S SG="2B" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")),N="N0",M="M0",PSA<20,G=3 S SG="2C" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")),N="N0",M="M0",PSA<20,G=4 S SG="2C" Q
 I (($E(T,1,2)="T1")!($E(T,1,2)="T2")),N="N0",M="M0",PSA>19,G<5 S SG="3A" Q
 I (($E(T,1,2)="T3")!($E(T,1,2)="T4")),N="N0",M="M0",G<5 S SG="3B" Q
 I N="N0",M="M0",G=5 S SG="3C" Q
 I N="N1",M="M0" S SG="4A" Q
 I M["M1" S SG="4B" Q
 Q
59 ;TESTIS
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0",SCAT=0 S SG=0 Q
 I ((T="T1")!(T="T2")!(T="T3")!(T="T4")),N="N0",M="M0",SCAT=9 S SG=1 Q
 I T="T1",N="N0",M="M0",SCAT=0 S SG="1A" Q
 I T="T2",N="N0",M="M0",SCAT=0 S SG="1B" Q
 I T="T3",N="N0",M="M0",SCAT=0 S SG="1B" Q
 I T="T4",N="N0",M="M0",SCAT=0 S SG="1B" Q
 I N="N0",M="M0",((SCAT=1)!(SCAT=2)!(SCAT=3)) S SG="1S" Q
 I ((N="N1")!(N="N2")!(N="N3")),M="M0",SCAT=9 S SG=2 Q
 I N="N1",M="M0",SCAT=0 S SG="2A" Q
 I N="N1",M="M0",SCAT=1 S SG="2A" Q
 I N="N2",M="M0",SCAT=0 S SG="2B" Q
 I N="N2",M="M0",SCAT=1 S SG="2B" Q
 I N="N3",M="M0",SCAT=0 S SG="2C" Q
 I N="N3",M="M0",SCAT=1 S SG="2C" Q
 I M="M1",SCAT=9 S SG=3 Q
 I M="M1a",SCAT=0 S SG="3A" Q
 I M="M1b",SCAT=1 S SG="3A" Q
 I ((N="N1")!(N="N2")!(N="N3")),M="M0",SCAT=2 S SG="3B" Q
 I M="M1a",SCAT=2 S SG="3B" Q
 I ((N="N1")!(N="N2")!(N="N3")),M="M0",SCAT=3 S SG="3C" Q
 I M="M1a",SCAT=3 S SG="3C" Q
 I M="M1b" S SG="3C"
 Q
 ;
CLEANUP ;Cleanup
 K M,N,SG,T
 Q
