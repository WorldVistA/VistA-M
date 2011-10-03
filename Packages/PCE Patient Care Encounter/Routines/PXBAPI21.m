PXBAPI21 ;ISL/DCM - API for Classification check out ; 4/13/05 12:55pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**130,147,124,184,168**;Aug 12, 1996;Build 14
CLASS(ENCOWNTR,DFN,APTDT,LOC,VISIT) ;Edit classification fields
 ; Input  - ENCOWNTR - ien of ^SCE(ien (409.68 Outpatient Encounter file)
 ;          ENCOWNTR optional if DFN,LOC,APTDT params used
 ;          DFN - ien of ^DPT(DFN, (only used if no ENCOWNTR)
 ;          LOC - ien of ^SC(LOC,  (only used if no ENCOWNTR)
 ;          APTDT - Appointment Date/time (only used if no ENCOWNTR)
 ;          VISIT - optional if no ENCOWNTR look for main encounter that
 ;                  points to this visit
 ; Output - PXBDATA(Classification type)=OutPT Class ien^Value
 ;          PXBDATA("ERR",Class type)=1 Bad ptr to 409.41
 ;                                    =2 DATA entry not applicable
 ;                                    =3 DATA entry uneditable
 ;                                    =4 User ^ out of prompt
 ;            Classification type 1 - Agent Orange
 ;                                2 - Ionizing Radiation
 ;                                3 - Service Connected
 ;                                4 - SW Asia Coditions
 ;                                5 - Military Sexual Trauma
 ;                                6 - Head and/or Neck Cancer
 ;                                7 - Combat Veteran
 ;                                8 - Project 112/SHAD
 ;
 ; Ext References: ^SCE(DA,0)              INP^SDAM2
 ;                 REQ^SDM1A               CLINIC^SDAMU
 ;                 EXOE^SDCOU2             CLOE^SDCO21
 ;                 SEQ^SDCO21              CL^SDCO21
 ;   In ^PXBAPI22
 ;                 ^DG(43,1,"SCLR")  piece 24
 ;                 ^SD(409.41,DA,0)        ^SD(409.41,DA,2)
 ;                 VAL^SDCODD              SC^SDCO23
 I $G(ENCOWNTR)'>0,$G(VISIT)>0 D SC^PXCEVFI2($P(^AUPNVSIT(VISIT,0),U,5)) D
 . S ENCOWNTR=$O(^SCE("AVSIT",VISIT,0))
 . I ENCOWNTR,$P(^SCE(ENCOWNTR,0),"^",6) S ENCOWNTR=$P(^SCE(ENCOWNTR,0),"^",6)
 N IEN,IFN,SDCLOEY,ORG,END,DA,X,SQUIT
 I $G(ENCOWNTR) Q:'$D(^SCE(+ENCOWNTR,0))  N APTDT,DFN,LOC S END=0,X0=^(0) D ENCHK(ENCOWNTR,X0) Q:END  G ON
 Q:'$G(DFN)!'$G(LOC)!'$G(APTDT)
 D SC^PXCEVFI2(DFN)
 S X=$G(^DPT(DFN,"S",APTDT,0))
 I +X,+X=LOC,$P(X,"^",20),$D(^SCE($P(X,"^",20),0)) S ENCOWNTR=$P(X,"^",20),END=0,X0=^(0) D ENCHK(ENCOWNTR,X0) Q:END  G ON
 S END=0 D OPCHK(DFN,LOC,APTDT) I END Q
ON D ASKCL($G(ENCOWNTR),.SDCLOEY,DFN,APTDT)
 I '$D(SDCLOEY) Q
 I $G(PXCECAT)="POV" D
 .I $P($G(PXCEAFTR(800)),"^",1)]"",$D(SDCLOEY(3)) S $P(SDCLOEY(3),"^",2)=$P(PXCEAFTR(800),"^",1)
 .I $P($G(PXCEAFTR(800)),"^",2)]"",$D(SDCLOEY(1)) S $P(SDCLOEY(1),"^",2)=$P(PXCEAFTR(800),"^",2)
 .I $P($G(PXCEAFTR(800)),"^",3)]"",$D(SDCLOEY(2)) S $P(SDCLOEY(2),"^",2)=$P(PXCEAFTR(800),"^",3)
 .I $P($G(PXCEAFTR(800)),"^",4)]"",$D(SDCLOEY(4)) S $P(SDCLOEY(4),"^",2)=$P(PXCEAFTR(800),"^",4)
 .I $P($G(PXCEAFTR(800)),"^",5)]"",$D(SDCLOEY(5)) S $P(SDCLOEY(5),"^",2)=$P(PXCEAFTR(800),"^",5)
 .I $P($G(PXCEAFTR(800)),"^",6)]"",$D(SDCLOEY(6)) S $P(SDCLOEY(6),"^",2)=$P(PXCEAFTR(800),"^",6)
 .I $P($G(PXCEAFTR(800)),"^",7)]"",$D(SDCLOEY(7)) S $P(SDCLOEY(7),"^",2)=$P(PXCEAFTR(800),"^",7)
 .I $P($G(PXCEAFTR(800)),"^",8)]"",$D(SDCLOEY(8)) S $P(SDCLOEY(8),"^",2)=$P(PXCEAFTR(800),"^",8)
 I $D(SDCLOEY) D ASK($G(ENCOWNTR),.SDCLOEY,.SQUIT) Q:$D(SQUIT)
 Q
ASKCL(ENCOWNTR,SDCLOEY,DFN,APTDT) ;Ask classifications on check out
 I $G(ENCOWNTR) D CLOE^SDCO21(ENCOWNTR,.SDCLOEY) Q
 D CL^SDCO21(DFN,APTDT,"",.SDCLOEY)
 Q
ASK(ENCOWNTR,SDCLOEY,SQUIT) ;Ask classifications
 N I,IOINHI,IOINORM,TYPI,TYPSEQ,CTS,X,PXVST
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 I '$D(SDCLOEY) Q
 W !!,"--- ",IOINHI,"Classification",IOINORM," --- [",IOINHI,"Required",IOINORM,"]"
 W ! S TYPSEQ=$$SEQ^SDCO21 ;Get classification type sequence (3,1,2,4,5,6,7)
 F CTS=1:1 S TYPI=+$P(TYPSEQ,",",CTS) Q:'TYPI!($D(SQUIT))  D
 .I $D(SDCLOEY(TYPI)) D
 ..S PXVST=$P($G(X0),U,5) I 'PXVST,($G(PXCECAT)="VST")!($G(PXCECAT)="SIT") Q
 ..I $G(PXCECAT)="VST",TYPI=3,($P($G(^AUPNVSIT(PXVST,800)),U,11)="1")  Q
 ..I $G(PXCECAT)="VST",TYPI=1,($P($G(^AUPNVSIT(PXVST,800)),U,12)="1")  Q
 ..I $G(PXCECAT)="VST",TYPI=2,($P($G(^AUPNVSIT(PXVST,800)),U,13)="1")  Q
 ..I $G(PXCECAT)="VST",TYPI=4,($P($G(^AUPNVSIT(PXVST,800)),U,14)="1")  Q
 ..I $G(PXCECAT)="VST",TYPI=5,($P($G(^AUPNVSIT(PXVST,800)),U,15)="1")  Q
 ..I $G(PXCECAT)="VST",TYPI=6,($P($G(^AUPNVSIT(PXVST,800)),U,16)="1")  Q
 ..I $G(PXCECAT)="VST",TYPI=7,($P($G(^AUPNVSIT(PXVST,800)),U,17)="1")  Q
 ..I $G(PXCECAT)="VST",TYPI=8,($P($G(^AUPNVSIT(PXVST,800)),U,18)="1")  Q
 ..D ONE^PXBAPI22(TYPI,SDCLOEY(TYPI),ENCOWNTR,.SQUIT)
 ..I TYPI=3 F I=1,2,4 S:$D(SDCLOEY(I))&($P($G(PXBDATA(3)),"^",2)=1) $P(SDCLOEY(I),"^",3)=1 S:$P($G(PXBDATA(3)),"^",2)=0&('$D(SDCLOEY(I))) SDCLOEY(I)=""
 I $P($G(PXBDATA(3)),"^",2)'="" D
 .N END
 .S END=0
 .F CTS=1:1 S TYPI=+$P(TYPSEQ,",",CTS) Q:'TYPI  I TYPI'=3 D
 ..I $P($G(PXBDATA(TYPI)),"^",2)'="" S END=1 Q
 .I 'END H 1
 Q
ENCHK(ENCOWNTR,X0) ;Do outpatient encounter checks
 S APTDT=+X0,DFN=$P(X0,"^",2),LOC=$P(X0,"^",4),ORG=$P(X0,"^",8),DA=$P(X0,"^",9)
 I +$G(VADM(6)),+$G(VADM(6))<APTDT D  K DIR I $D(DIRUT) S (PXDOD,END)=1 Q
 . S DIR(0)="E",DIR("A")="Enter RETURN to continue or '^' to Quit"
 . S DIR("A",2)="WARNING "_VADM(7),DIR("A",1)=" ",DIR("A",3)=" " D ^DIR
 I $$REQ^SDM1A(+X0)'="CO" S END=1 Q  ;Check MAS Check out date parameter
 I ORG=1,'$$CLINIC^SDAMU(+LOC) S END=1 Q  ;Screen for valid clinic
 I "^1^2^"[("^"_ORG_"^"),$$INP^SDAM2(+DFN,+X0)="I" S END=1 Q  ;Inpat chk
 I $$EXOE^SDCOU2(ENCOWNTR) S END=1 Q  ;Chk exempt Outpt classifications
 Q
OPCHK(DFN,LOC,APTDT) ;Do standalone outpatient encounter checks
 I +$G(VADM(6)),+$G(VADM(6))<APTDT D  K DIR I $D(DIRUT) S (PXDOD,END)=1 Q
 . S DIR(0)="E",DIR("A")="Enter RETURN to continue or '^' to Quit"
 . S DIR("A",2)="WARNING "_VADM(7),DIR("A",1)=" ",DIR("A",3)=" " D ^DIR
 I $$REQ^SDM1A(APTDT)'="CO" S END=1 Q  ;Check MAS Check out date parameter
 I '$$CLINIC^SDAMU(+LOC) S END=1 Q  ;Screen for valid clinic
 I $$INP^SDAM2(+DFN,APTDT)="I" S END=1 Q  ;Inpat chk
 Q
TEST ;Test call to CLASS
 N PXIFN S PXIFN=63
 F  S PXIFN=$O(^SCE(PXIFN)) Q:PXIFN<1  S DFN=$P(^(PXIFN,0),"^",2) K PXBDATA W !!,PXIFN_"   "_$P(^DPT(DFN,0),"^") D  S %=1 W !,"Continue " D YN^DICN Q:%'=1
 . D CLASS(PXIFN)
 . ;W ! ZW PXBDATA
 Q
