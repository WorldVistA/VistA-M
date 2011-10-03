ONCEDIT2 ;Hines OIFO/GWB - ONCOLOGY INTERFIELD EDITS (continued);11/30/10
 ;;2.11;ONCOLOGY;**27,28,32,33,44,47,52**;Mar 07, 1995;Build 13
 ;
IF1213 I BCOD=2,SSTI'=0 D  D ERRMSG
 .S MSG(1)="BEHAVIOR CODE = 2 (In situ)"
 .S MSG(2)="SUMMARY STAGE = "_SSTI_" ("_SSTE_")"
 .S MSG(3)="BEHAVIOR CODE and SUMMARY STAGE confict"
 I BCOD=3,SSTI=0 D  D ERRMSG
 .S MSG(1)="BEHAVIOR CODE = 3 (Malignant)"
 .S MSG(2)="SUMMARY STAGE = 0 (In situ)"
 .S MSG(3)="BEHAVIOR CODE and SUMMARY STAGE confict"
 K MSG
 ;
IF14 I $$LEUKEMIA^ONCOAIP2(PRM),TRSI'=7,SSTI'=7 D  D ERRMSG
 .S MSG(1)="HISTOLOGY = "_HSTE
 .S MSG(2)="TYPE OF REPORTING SOURCE = "_TRSI_" ("_TRSE_")"
 .S MSG(3)="SUMMARY STAGE must be 7 (Distant Mets/systemic disease)"
 K MSG
 ;
IF1718 S HST4=$E(HSTI,1,4)
 S GRDI=$$GET1^DIQ(165.5,PRM,24,"I") ;GRADE/DIFF/CELL TYPE 
 S GRDE=$$GET1^DIQ(165.5,PRM,24,"E")
 I ((HST4=8331)!(HST4=8851)!(HST4=9511)!(HST4=9693)),GRDI'=1 D  D ERRMSG
 .S MSG(1)="HISTOLOGY = "_HSTE
 .S MSG(2)="GRADE/DIFF/CELL TYPE must be 1 (Grade I)"
 I HST4=9083,GRDI'=2 D  D ERRMSG
 .S MSG(1)="HISTOLOGY = "_HSTE
 .S MSG(2)="GRADE/DIFF/CELL TYPE must be 2 (Grade II)"
 I ((HST4=8020)!(HST4=8021)!(HST4=9062)!(HST4=9082)!(HST4=9390)!(HST4=9401)!(HST4=9451)!(HST4=9512)),GRDI'=4 D  D ERRMSG
 .S MSG(1)="HISTOLOGY = "_HSTE
 .S MSG(2)="GRADE/DIFF/CELL TYPE must be 4 (Grade IV)"
 I (((DDXI<3010000)&(HST4=9696))!((DDXI>3001231)&(HST4=9695))),((GRDI'=3)&(GRDI'=5)&(GRDI'=6)&(GRDI'=7)) D  D ERRMSG
 .S MSG(1)="HISTOLOGY = "_HSTE
 .S MSG(2)="GRADE/DIFF/CELL TYPE must be: 3 (Grade III)"
 .S MSG(3)="                               5 (T-cell)"
 .S MSG(4)="                               6 (B-cell)"
 .S MSG(5)="                               7 (Null cell)"
 I (((DDXI<3010000)&(HST4=9694))!((DDXI>3001231)&(HST4=9591))),((GRDI'=2)&(GRDI'=5)&(GRDI'=6)&(GRDI'=7)&(GRDI'=9)) D  D ERRMSG
 .S MSG(1)="HISTOLOGY = "_HSTE
 .S MSG(2)="GRADE/DIFF/CELL TYPE must be: 2 (Grade II)"
 .S MSG(3)="                               5 (T-cell)"
 .S MSG(4)="                               6 (B-cell)"
 .S MSG(5)="                               7 (Null cell)"
 .S MSG(6)="                               9 (Unknown)"
 I (((DDXI<3010000)&(HST4=9683))!((DDXI>3001231)&(HST4=9680))),((GRDI'=4)&(GRDI'=5)&(GRDI'=6)&(GRDI'=7)) D  D ERRMSG
 .S MSG(1)="HISTOLOGY = "_HSTE
 .S MSG(2)="GRADE/DIFF/CELL TYPE must be: 4 (Grade IV)"
 .S MSG(3)="                               5 (T-cell)"
 .S MSG(4)="                               6 (B-cell)"
 .S MSG(5)="                               7 (Null cell)"
IF19 I ((GRDI=5)!(GRDI=6)!(GRDI=7)!(GRDI=8)),((HST4<9590)!(HST4>9948)) D  D ERRMSG
 .S MSG(1)="GRADE/DIFF/CELL TYPE = "_GRDI_" ("_GRDE_")"
 .S MSG(2)="HISTOLOGY must be leukemia or lymphoma (9590-9948)"
 K MSG,HST4,GRDI,GRDE
 ;
IF20 I ($E(HSTI,1,3)>958)&($E(HSTI,1,3)<973),SSTI="" D  D ERRMSG
 .S MSG(1)="No TNM classification is available for LYMPHOMA"
 .S MSG(2)="SUMMARY STAGE cannot be blank"
 I HSTI=91403,SSTI="" D  D ERRMSG
 .S MSG(1)="No TNM classification is available for KAPOSI'S SAROMA"
 .S MSG(2)="SUMMARY STAGE cannot be blank"
 K MSG
 ;
IF21 S EXTE=$$GET1^DIQ(165.5,PRM,30,"E")   ;EXTENSION
 I BCOD=3,$E(EXTE,1,2)="00" D  D ERRMSG
 .S MSG(1)="BEHAVIOR CODE = 3 (Malignant)"
 .S MSG(2)="EXTENSION may not be 00 (In situ)"
 K MSG,EXTE
 ;
IF22 S PEXI=$$GET1^DIQ(165.5,PRM,30.1,"I") ;PATHOLOGIC EXTENSION
 S PEXE=$$GET1^DIQ(165.5,PRM,30.1,"E")
 I PEXI'="",PEXI'=99,TOPI'=67619 D  D ERRMSG
 .S MSG(1)="PRIMARY SITE = "_TOPE
 .S MSG(2)="PATHOLGIC EXTENSION = "_PEXE
 .S MSG(3)="PATHOLOGIC EXTENSION may only be coded for PROSTATE (C61.9) cases"
 K MSG,PEXI,PEXE
 ;
IF24 S LYMP=$$GET1^DIQ(165.5,PRM,31,"I")   ;LYMPH NODES
 S NPRI=$$GET1^DIQ(165.5,PRM,32,"I")   ;REGIONAL NODES POSITIVE
 S NPRE=$$GET1^DIQ(165.5,PRM,32,"E")
 I ((NPRI>0)&(NPRI<98)),LYMP=0 D  D ERRMSG
 .S MSG(1)="REGIONAL NODES POSITIVE = "_NPRE
 .S MSG(2)="LYMPH NODES may not be 0 (No lymph nodes)"
 K MSG,LYMP,NPRI,NPRE
IF2A S NERI=$$GET1^DIQ(165.5,PRM,33,"I")   ;REGIONAL NODES EXAMINED
 S NPRI=$$GET1^DIQ(165.5,PRM,32,"I")   ;REGIONAL NODES POSITIVE
 S NERE=$$GET1^DIQ(165.5,PRM,33,"E")
 I ((NERI=99)&(NPRI'=99)) D  D ERRMSG
 .S MSG(1)="REGIONAL NODES EXAMINED = 99 ("_NERE_")"
 .S MSG(2)="REGIONAL NODES POSITIVE must be 99 (Unk if nodes + or -, NA)"
 K MSG,NERI,NPRI,NERE
 ;
IF25 S HORI=$$GET1^DIQ(165.5,PRM,54.2,"I")  ;HORMONE THERAPY
 S HORE=$$GET1^DIQ(165.5,PRM,54.2,"E")
 I ((HORI=2)!(HORI=3)),((TOPI'=67619)&($E(TOPI,3,4)'=50)) D  D ERRMSG
 .S MSG(1)="PRIMARY SITE = "_TOPE
 .S MSG(2)="HORMONE THERAPY = "_HORI_" ("_HORE_")"
 .S MSG(3)="Only BREAST and PROSTATE cases may be coded as receiving"
 .S MSG(4)="endocrine surgery or endocrine radiation"
 K MSG,HORI,HORE
 ;
IF2627 S PDTH=$$GET1^DIQ(160,PTN,21)         ;PLACE OF DEATH
 I STAT="Dead",PDTH="" D  D ERRMSG
 .S MSG(1)="STATUS = "_STAT
 .S MSG(2)="PLACE OF DEATH may not be blank"
 K MSG,PDTH
 ;
RACE S RACE1=$$GET1^DIQ(160,PTN,8)   ;RACE 1
 S RACE2=$$GET1^DIQ(160,PTN,8.1) ;RACE 2
 S RACE3=$$GET1^DIQ(160,PTN,8.2) ;RACE 3
 S RACE4=$$GET1^DIQ(160,PTN,8.3) ;RACE 4
 S RACE5=$$GET1^DIQ(160,PTN,8.4) ;RACE 5
 I RACE1="White",((RACE2'="NA")&(RACE2'="Unknown")&(RACE2'="")) D  D ERRMSG
 .S MSG(1)="RACE 1 = "_RACE1
 .S MSG(2)="RACE 2 = "_RACE2
 .S MSG(3)="RACE 3 = "_RACE3
 .S MSG(4)="RACE 4 = "_RACE4
 .S MSG(5)="RACE 5 = "_RACE5
 .S MSG(6)="For race combinations RACE 1 may not be 'White'"
 I (RACE1="")!(RACE2="")!(RACE3="")!(RACE4="")!(RACE5="") G RACEX
 S RACE(RACE1)="" I ((RACE2'="NA")&(RACE2'="Unknown")),$D(RACE(RACE2)) D DUPRACE
 S RACE(RACE2)="" I ((RACE3'="NA")&(RACE3'="Unknown")),$D(RACE(RACE3)) D DUPRACE
 S RACE(RACE3)="" I ((RACE4'="NA")&(RACE4'="Unknown")),$D(RACE(RACE4)) D DUPRACE
 S RACE(RACE4)="" I ((RACE5'="NA")&(RACE5'="Unknown")),$D(RACE(RACE5)) D DUPRACE
 K MSG,RACE,RACE1,RACE2,RACE3,RACE4,RACE5
 ;
RACEX K BCOD,COCI,COCE,DDXI,DDXE,HSTI,HSTE,SSTI,SSTE,STAT,TOPI,TOPE,TRSI,TRSE
 Q
 ;
DUPRACE S MSG(1)="RACE 1 = "_RACE1
 S MSG(2)="RACE 2 = "_RACE2
 S MSG(3)="RACE 3 = "_RACE3
 S MSG(4)="RACE 4 = "_RACE4
 S MSG(5)="RACE 5 = "_RACE5
 S MSG(6)="A specific race code may not occur more than once"
 D ERRMSG
 Q
 ;
ERRMSG ;Error message
 S CMPLT=0
 W !," WARNING: "
 S MSGSUB=0 F  S MSGSUB=$O(MSG(MSGSUB)) Q:MSGSUB'>0  W ?10,MSG(MSGSUB),!
 R Z:10
 Q
 ;
CLEANUP ;Cleanup
 K CMPLT,MSGSUB,PRM,PTN,Z
