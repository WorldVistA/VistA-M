ONCSGA8C ;HINES OIFO/RTK - AJCC 8th Ed Automatic Staging Tables ;01/17/19
 ;;2.2;ONCOLOGY;**10,12,13**;Jul 31, 2013;Build 7
 ;
 ;
60 ;KIDNEY
 S M=$E(M,2,5)
 I T["T1",N="N0",M="M0" S SG=1 Q
 I T["T1",N="N1",M="M0" S SG=3 Q
 I T["T2",N="N0",M="M0" S SG=2 Q
 I T["T2",N="N1",M="M0" S SG=3 Q
 I T["T3",((N="NX")!(N="N0")),M="M0" S SG=3 Q
 I T["T3",N="N1",M="M0" S SG=3 Q
 I T="T4",M="M0" S SG=4 Q
 I M="M1" S SG=4
 Q
611 ;RENAL PELVIS AND URETER
 S M=$E(M,2,5)
 I T="Ta",N="N0",M="M0" S SG="0a" Q
 I T="Tis",N="N0",M="M0" S SG="0is" Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T3",N="N0",M="M0" S SG=3 Q
 I T="T4",((N="NX")!(N="N0")),M="M0" S SG=4 Q
 I N="N1",M="M0" S SG=4 Q
 I N="N2",M="M0" S SG=4 Q
 I M="M1" S SG=4
 Q
612 ;
 D 611
 Q
621 ;URINARY BLADDER
 S M=$E(M,2,5)
 I T="Ta",N="N0",M="M0" S SG="0a" Q
 I T="Tis",N="N0",M="M0" S SG="0is" Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T2a",N="N0",M="M0" S SG=2 Q
 I T="T2b",N="N0",M="M0" S SG=2 Q
 I ((T="T3a")!(T="T3b")!(T="T4a")),N="N0",M="M0" S SG="3A" Q
 I ((T["T1")!(T["T2")!(T["T3")!(T["T4")),T'="T4b",N="N1",M="M0" S SG="3A" Q
 I ((T["T1")!(T["T2")!(T["T3")!(T["T4")),T'="T4b",((N="N2")!(N="N3")),M="M0" S SG="3B" Q
 I T="T4b",M="M0" S SG="4A" Q
 I M="M1a" S SG="4A" Q
 I M="M1b" S SG="4B"
 Q
622 ;
 D 621
 Q
631 ;URETHRA
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG="0is" Q
 I T="Ta",N="N0",M="M0" S SG="0a" Q
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1",N="N1",M="M0" S SG=3 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T2",N="N1",M="M0" S SG=3 Q
 I T="T3",N="N0",M="M0" S SG=3 Q
 I T="T3",N="N1",M="M0" S SG=3 Q
 I T="T4",N="NX",M="M0" S SG=4 Q
 I T="T4",N="N0",M="M0" S SG=4 Q
 I T="T4",N="N1",M="M0" S SG=4 Q
 I N="N2",M="M1" S SG=4 Q
 I M="M1" S SG=4
 Q
632 ;
 D 631
 Q
633 ;
 D 631
 Q
634 ;
 D 631
 Q
64 ;EYELID CARCINOMA
 S M=$E(M,2,5)
 I T="Tis",N="N0",M="M0" S SG=0 Q
 I T="T1",N="N0",M="M0" S SG="1A" Q
 I T="T2a",N="N0",M="M0" S SG="1B" Q
 I ((T="T2b")!(T="T2c")!(T="T3")),N="N0",M="M0" S SG="2A" Q
 I T="T4",N="N0",M="M0" S SG="2B" Q
 I N="N1",M="M0" S SG="3A" Q
 I N="N2",M="M0" S SG="3B" Q
 I M="M1" S SG=4
 Q
672 ;UVEA
 S M=$E(M,2,5)
 I T="T1a",N="N0",M="M0" S SG=1 Q
 I ((T="T1b")!(T="T1c")!(T="T1d")),N="N0",M="M0" S SG="2A" Q
 I T="T2a",N="N0",M="M0" S SG="2A" Q
 I T="T2b",N="N0",M="M0" S SG="2B" Q
 I T="T3a",N="N0",M="M0" S SG="2B" Q
 I ((T="T2c")!(T="T2d")),N="N0",M="M0" S SG="3A" Q
 I ((T="T3b")!(T="T3c")),N="N0",M="M0" S SG="3A" Q
 I T="T4a",N="N0",M="M0" S SG="3A" Q
 I T="T3d",N="N0",M="M0" S SG="3B" Q
 I ((T="T4b")!(T="T4c")),N="N0",M="M0" S SG="3B" Q
 I ((T="T4d")!(T="T4e")),N="N0",M="M0" S SG="3C" Q
 I N="N1",M="M0" S SG=4 Q
 I ((M="M1a")!(M="M1b")!(M="M1c")) S SG=4
 Q
68 ;RETINOBLASTOMA - this code should work for either "C" or "P" STGIND
 I ((T="T1")!(T="T2")!(T="T3")),N="N0",M="cM0" S SG=1 Q
 I T="T4a",N="N0",M="cM0" S SG=2 Q
 I T="T4b",N="N0",M="cM0" S SG=3 Q
 I N="N1",M="cM0" S SG=3 Q
 I ((M["cM1")!(M["pM1")) S SG=4 Q
 I STGIND="P",T="T4",N="N0",M="cM0" S SG=2 Q
 Q
731 ;THYROID
 S M=$E(M,2,5)
 N X D AGE^ONCOCOM Q:X=""  I X<55 D  Q
 .I M="M0" S SG=1
 .I M="M1" S SG=2
 I T["T1",((N["N0")!(N="NX")),M="M0" S SG=1 Q
 I T["T1",N["N1",M="M0" S SG=2 Q
 I T="T2",((N["N0")!(N="NX")),M="M0" S SG=1 Q
 I T="T2",N["N1",M="M0" S SG=2 Q
 I ((T="T3a")!(T="T3b")),M="M0" S SG=2 Q
 I T="T4a",M="M0" S SG=3 Q
 I T="T4b",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
732 ;THYROID
 S M=$E(M,2,5)
 I ((T["T1")!(T["T2")!(T["T3")),T'="T3b",((N["N0")!(N="NX")),M="M0" S SG="4A" Q
 I ((T["T1")!(T["T2")!(T["T3")),T'="T3b",N["N1",M="M0" S SG="4B" Q
 I T="T3b",M="M0" S SG="4B" Q
 I T="T4",M="M0" S SG="4B" Q
 I M="M1" S SG="4C"
 Q
74 ;THYROID
 S M=$E(M,2,5)
 I T["T1",N["N0",M="M0" S SG=1 Q
 I T["T2",N["N0",M="M0" S SG=2 Q
 I T["T3",N["N0",M="M0" S SG=2 Q
 I ((T["T1")!(T["T2")!(T["T3")),N="N1a",M="M0" S SG=3 Q
 I T="T4a",M="M0" S SG="4A" Q
 I ((T["T1")!(T["T2")!(T["T3")),N="N1b",M="M0" S SG="4A" Q
 I T="T4b",M="M0" S SG="4B" Q
 I M="M1" S SG="4C"
 Q
76 ;ADRENAL CORTICAL CARCINOMA
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T1",N="N1",M="M0" S SG=3 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T2",N="N1",M="M0" S SG=3 Q
 I T="T3",M="M0" S SG=3 Q
 I T="T4",M="M0" S SG=3 Q
 I M="M1" S SG=4
 Q
77 ;ADRENAL NEUROENDOCRINE
 S M=$E(M,2,5)
 I T="T1",N="N0",M="M0" S SG=1 Q
 I T="T2",N="N0",M="M0" S SG=2 Q
 I T="T1",N="N1",M="M0" S SG=3 Q
 I T="T2",N="N1",M="M0" S SG=3 Q
 I T="T3",M="M0" S SG=3 Q
 I M["M1" S SG=4
 Q
811 ;PRIMARY CUTANEOUS LYMPHOMAS
 S M=$E(M,2,5)
 I T["T1",N="N0",M="M0",PBI18<7 S SG="1A" Q
 I T["T2",N="N0",M="M0",PBI18<7 S SG="1B" Q
 I (T["T1")!(T["T2"),(N="N1")!(N="N2"),M="M0",PBI18<7 S SG="2A" Q
 I T="T3",(N="N0")!(N="N1")!(N="N2"),M="M0",PBI18<7 S SG="2B" Q
 I T="T4",(N="N0")!(N="N1")!(N="N2"),M="M0",PBI18<7 S SG=3 Q
 I T="T4",(N="N0")!(N="N1")!(N="N2"),M="M0",PBI18<4 S SG="3A" Q
 I T="T4",(N="N0")!(N="N1")!(N="N2"),M="M0",(PBI18>3)&(PBI18<7) S SG="3B" Q
 I (N="N0")!(N="N1")!(N="N2"),M="M0",PBI18=7 S SG="4A1" Q
 I N="N3",M="M0",PBI18<8 S SG="4A2" Q
 I (N="N0")!(N="N1")!(N="N2")!(N="N3"),M="M1",PBI18<8 S SG="4B" Q
 Q
529 ;CERVIX UTERI -- 9TH EDITION
 S M=$E(M,2,5)
 I T="T1",N["N0",M="M0" S SG=1 Q
 I T="T1a",N["N0",M="M0" S SG="1A" Q
 I T="T1a1",N["N0",M="M0" S SG="1A1" Q
 I T="T1a2",N["N0",M="M0" S SG="1A2" Q
 I T="T1b",N["N0",M="M1" S SG="1B" Q
 I T="T1b1",N["N0",M="M0" S SG="1B1" Q
 I T="T1b2",N["N0",M="M0" S SG="1B2" Q
 I T="T1b3",N["N0",M="M0" S SG="1B3" Q
 I T="T2",N["N0",M="M0" S SG=2 Q
 I T="T2a",N["N0",M="M0" S SG="2A" Q
 I T="T2a1",N["N0",M="M0" S SG="2A1" Q
 I T="T2a2",N["N0",M="M0" S SG="2A2" Q
 I T="T2b",N["N0",M="M0" S SG="2B" Q
 I T="T3",N["N0",M="M0" S SG=3 Q
 I T="T3a",N["N0",M="M0" S SG="3A" Q
 I T="T3b",N["N0",M="M0" S SG="3B" Q
 I T'="T4",N["N1",M="M0" S SG="3C1" Q
 I T'="T4",N["N2",M="M0" S SG="3C2" Q
 I T="T4",M="M0" S SG="4A" Q
 I M="M1" S SG="4B"
 Q
