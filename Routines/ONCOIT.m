ONCOIT ;Hines OIFO/GWB - Miscellaneous Input Transforms ;7/10/96
 ;;2.11;ONCOLOGY;**18,19,28,29,33,36,40**;Mar 07, 1995
 ;
NP ;NO PUNCTUATION
 ;PATIENT ADDRESS AT DX (165.5,8)
 ;CITY/TOWN AT DX       (165.5,8.1)
 ;POSTAL CODE AT DX     (165.5,9) 
 S X1=$$STRIP^XLFSTR(X,"!""""#$%&'()*+,-./:;<=>?[>]^_\{|}~`")
 I X'=X1 K X  W "  Punctuation not allowed" K X1 Q
 S X1=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I X'=X1 K X  W "  Lowercase text not allowed" K X1 Q
 Q
 ;
RNEIT ;REGIONAL NODES EXAMINED (165.5,33)
 I (X=91)!(X=92)!(X=93)!(X=94) K X Q
 S DXDT=$P($G(^ONCO(165.5,D0,0)),U,16)
 I DXDT<2980000 D
 .I X=0 W "  No nodes examined" Q
 .I X=97 W "  97 or more nodes examined" Q
 .I X=98 W "  Nodes examined, # not specified" Q
 .I X=99 W "  Unknown if nodes examined, NA" Q
 I DXDT>2971231 D
 .I X=0 W "  No nodes examined" Q
 .I X=90 W "  90 or more nodes examined" Q
 .I X=95 W "  No nodes removed, aspiration performed" Q
 .I X=96 W "  Node removal as sampling, # unknown" Q
 .I X=97 W "  Node removal as dissection, # unknown" Q
 .I X=98 W "  Nodes surgically removed, # unknown" Q
 .I X=99 W "  Unknown, NA or -, not stated" Q
 Q
 ;
RNPIT ;REGIONAL LYMPH NODES POSITIVE (165.5,32)
 I (X=91)!(X=92)!(X=93)!(X=94)!(X=96) W "  Invalid value" K X Q
 I X=0 W "  All nodes examined are negative" Q
 I X=90 W "  90 or more nodes are positive" Q
 I X=95 W "  Positive aspiration was performed" Q
 I X=97 W "  Positive nodes, # not specified" Q
 I X=98 W "  No nodes were examined" Q
 I X=99 W "  Unknown if nodes +, NA, not stated" Q
 Q
 ;
BP ;BIOPSY PROCEDURE (165.5,141)
 S XCODE=X
 D BPGUCHK^ONCOTNE
 I BPSITE="" K X Q
 S FOUND=0
 F XBP=0:0 S XBP=$O(^ONCO(164,BPSITE,"BP5",XBP)) Q:XBP'>0!(FOUND=1)  D
 .I $P(^ONCO(164,BPSITE,"BP5",XBP,0),U,2)=X S X=XBP,FOUND=1 Q
 I FOUND=0 K X Q
 D EN^DDIOL($P(^ONCO(164,BPSITE,"BP5",X,0),U,1))
 K FOUND,XBP Q
 ;
RDIT ;REGIONAL DOSE:cGy (165.5,442)
 I X'?1.5N K X Q
 D NUMIT
 I +X=0 W "  No radiation administered"
 I +X=88888 W "  NA, brachytherapy/radioisotopes administered"
 I X=99999 W "  Dose unknown/unknown if administered"
 Q
 ;
 ;1998 Prostate Cancer Study 
 ;
PSA ;Item 14. Results of Most Recent Pre-Treatment Prostate Specific
 ;         Antigen (PSA) Test
 ;RESULTS OF PSA TEST (PR98) (165.5,684)
 I X'?1.3N&(X'?0.3N1"."1N) K X Q
 I X'["." S X=X_".0"
 I $P(X,".",1)="" S X="000"_X
 I $L($P(X,".",1))=1 S X="00"_X
 I $L($P(X,".",1))=2 S X="0"_X
        Q
 ;
LP25 ;Item 25. Gleason's Score for Biopsy, Local Resection, or Simple
 ;         Prostatectomy
 ;LESSER PATTERN (02-40) (165.5,623.2)
 I +X'=X!(X=6)!(X=7)!(X=8)!($L(X)>1)!(X<0)!(X?.E1"."1N.N) K X Q
 S PP=$P($G(^ONCO(165.5,D0,"PRO2")),U,43)
 I PP>0,PP<6,(X=0)!(X=9) K X
 K PP
 Q
 ;
LP26 ;Item 26. Gleason's Score for Radical Prostatectomy
 ;LESSER PATTERN (50-70) (165.5,623.5)
 I +X'=X!(X=6)!(X=7)!(X=8)!($L(X)>1)!(X<0)!(X?.E1"."1N.N) K X Q
 S PP=$P($G(^ONCO(165.5,D0,"PRO2")),U,46)
 I PP>0,PP<6,(X=0)!(X=9) K X
 K PP
 Q
 ;
 ;2001 Gastric Cancers PCE Study
 ;
AC ;Item 3. Alcohol Consumption
 ;GAS ALCOHOL COMSUMPTION (165.5,1501)
 D NUMIT
 I +X=0 W "  Never consumed alcohol"
 I X=97 W "  97 or more drinks per week"
 I X=98 W "  Yes, number of drinks unknown"
 I X=99 W "  Not documented"
 Q
 ;
LS ;Item 16. Laboratory Studies
 ;GAS LDH (IU/L)               (165.5,1540)
 ;GAS CEA (ng/ml)              (165.5,1541)
 ;GAS CA125 (U/ml)             (165.5,1542)
 ;GAS BETA2 MICROGLOBULIN      (165.5,1543)
 ;GAS URINARY 5-HIAA (mg/24hr) (165.5,1544)
 D FRACIT
 I +X=0 W "  Test not administered"
 I X=8888.8 W "  Test administered but results unknown"
 I X=9999.9 W "  Not documented"
 Q
 ;
IRTD ;Item 40. Intra-operative Radiation Therapy, Dose (cCy)
 ;GAS INTRA-OPERATIVE RADIATION (165.5,1567)
 D NUMIT
 I +X=0 W "  Not administered"
 I X=88888 W "  Administered, dose not documented"
 I X=99999 W "  Not documented"
 Q
 ;
 ;2001 Lung (NSCLC) Cancers PCE Study
 ;
PFT ;Item 7. Pulmonary Function Tests
 ;LNG FVC (165.5,1407
 ;LNG FEV (165.5,1407.1)
 I $L($P(X,".",1))>ONCL K X Q
 D FRACIT
 I X="0.00" W "  Test not done" Q
 I X=9.98 W "  Test done, results not documented" Q
 I X=9.99 W "  Not documented if test performed" Q
 Q
 ;
RE ;Item 9. Radiological Evaluation
 ;LNG TUMOR SIZE (BONE SCAN)     (165.5,1409.4)
 ;LNG NUM OF TUMORS (BONE SCAN)  (165.5,1409.5)
 ;LNG TUMOR SIZE (CHEST CT)      (165.5,1410.4)
 ;LNG NUM OF TUMORS (CHEST CT)   (165.5,1410.5)
 ;LNG TUMOR SIZE (BRAIN CT)      (165.5,1411.4)
 ;LNG NUM OF TUMORS (BRAIN CT)   (165.5,1411.5)
 ;LNG TUMOR SIZE (CHEST MRI)     (165.5,1412.4)
 ;LNG NUM OF TUMORS (CHEST MRI)  (165.5,1412.5)
 ;LNG TUMOR SIZE (BRAIN MRI)     (165.5,1413.4)
 ;LNG NUM OF TUMORS (BRAIN MRI)  (165.5,1413.5)
 ;LNG TUMOR SIZE (PET SCAN)      (165.5,1414.4)
 ;LNG NUM OF TUMORS (PET SCAN)   (165.5,1414.5)
 ;LNG TUMOR SIZE (CHEST XRAY)    (165.5,1415.4)
 ;LNG NUM OF TUMORS (CHEST XRAY) (165.5,1415.5)
 D NUMIT
 I +X=0 W "  Test not performed"
 I X=999!(X=99) W "  Test performed, not documented"
 Q
 ;
TPBR ;Item 17. Total Peri-Operative Blood Replacement
 ;LNG PERI-OPERATIVE BLOOD REP (165.5,1420)
 D NUMIT
 I +X=0 W "  No transfusion performed"
 I X=98 W "  Transfusion performed, units not documented"
 I X=99 W "  Not recorded if transfusion done"
 Q
 ;
 ;2001 Lung (NSCLC) Cancers PCE Study
 ;2001 Gastric Cancers PCE Study
 ;
DTU ;Item 2. Duration of Tobacco Use
 ;LNG DURATION OF TOBACCO USE (165.5,1401)
 ;Item 4. Duration of Tobacco Use
 ;GAS DURATION OF TOBACCO USE (165.5,1572)
 D NUMIT
 I +X=0 W "  Never used tobacco"
 I X=99 W "  Not documented"
 Q
 ;
GYGR ;YEAR OF GASTRIC RESECTION I.T.
 I +X=0 W "  No prior gastric resection"
 I X=9999 W "  Not documented"
 Q
GTOBR ;GASTRIC TOTAL OPERATIVE BLOOD REPLACEMENT I.T.
 I X="00" W " No transfusion"
 I X="98" W " Transfusion, # of units not documented"
 I X="99" W " Not recorded if transfusion done"
 Q
HVBT ;Item 16. Hct (Hematocrit) Values Before Transfusion
 ;LNG HCT VAL BEFORE TRANSFUSION (165.5,1430)
 ;Item 33. Hct (Hematocrit) Values Before Transfusion
 ;GAS HCT VAL BEFORE TRANSFUSION (165.5,1562)
 D FRACIT
 I +X=0 W "  No transfusion"
 I X=99.9 W "  Not documented"
 Q
 ;
BD ;Item 23. Boost Dose (cCy)
 ;LNG BOOST DOSE (cGy) (165.5,1422)
 ;Item 39. Boost Dose (cCy)
 ;GAS BOOST DOSE (cGy) (165.5,1575)
 D NUMIT
 I +X=0 W "  Not administered"
 I X=99999 W "  Not documented"
 Q
 ;
DMCM ;Item 12. Distance in Millimeters to Closest Margin
 ;LNG PROXIMAL MARGIN (165.5,1429)
 ;LNG DISTAL MARGIN   (165.5,1429.1)
 D NUMIT
 I +X=0 W "  No free margins"
 I X=998 W "  NA, no surgery of primary site"
 I X=999 W "  Unknown, not documented"
 Q
 ;
EFM ;Item 30. Extent of Free Margin
 ;GAS PROXIMAL MARGIN (165.5,1558)
 ;GAS DISTAL MARGIN   (165.5,1558.1)
 D NUMIT
 I +X=0 W "  No free margins"
 I X=999 W "  Not documented"
 Q
 ;
NUMIT ;Pad with leading zeros
 S ONCZZZ="000000000",ONCXLEN=$L(X) I ONCL=ONCXLEN Q
 S ONCPNUM=ONCL-ONCXLEN,ONCPAD=$E(ONCZZZ,1,ONCPNUM),X=ONCPAD_X
 K ONCZZZ,ONCXLEN,ONCPNUM,ONCPAD
 Q
 ;
FRACIT ;Pad with leading zeros, 1 decimal place
 I X[".",$P(X,".",2)="" S X=+X
 S ONCZZZ="000000000",ONCNUM=$P(X,".",1),ONCFRAC=$P(X,".",2)
 S ONCNLEN=$L(ONCNUM),ONCFLEN=$L(ONCFRAC)
 S ONCNPD=ONCL-ONCNLEN,ONCFPD=ONCF-ONCFLEN
 S ONCPADN=$E(ONCZZZ,1,ONCNPD),ONCPADF=$E(ONCZZZ,1,ONCFPD)
 I ONCFRAC="" S ONCPADF="."_ONCPADF
 S X=ONCPADN_X_ONCPADF
 K ONCZZZ,ONCNUM,ONCFRAC,ONCNLEN,ONCFLEN,ONCNPD,ONCFPD,ONCPADN,ONCPADF
 Q
