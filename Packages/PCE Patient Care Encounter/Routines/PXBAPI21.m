PXBAPI21 ;ISL/DCM - API for Classification check out ;Aug 04, 2025@11:51:40
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**130,147,124,184,168,235,240,244**;Aug 12, 1996;Build 37
 ; Reference to ^SCE(DA,0) in ICR #402
 ; Reference to INP^SDAM2 in ICR #1582
 ; Reference to REQ^SDM1A in ICR #1583
 ; Reference to CLINIC^SDAMU in ICR #1580
 ; Reference to EXOE^SDCOU2 in ICR #1015
 ; Reference to CLOE^SDCO21 in ICR #1300
 ; Reference to SEQ^SDCO21 in ICR #1300
 ; Reference to CL^SDCO21 in ICR #1300
 ; Reference to ^SCE("AVSIT") in ICR #2045
 ;
 ; In ^PXBAPI22 which is called by PXBAPI21 (not documented in ^PXBAPI22)
 ; Reference to ^DG(43,1,"SCLR") piece 24 in ICR #2085
 ; Reference to ^SD(409.41,DA,0), ^SD(409.41,DA,2) in ICR #2083
 ; Reference to VAL^SDCODD in ICR #2025
 ; Reference to SC^SDCO23 in ICR #2468
 ; Reference to ^DPT(D0,"S", in ICR #1301
 ;
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
 I $G(ENCOWNTR)'>0,$G(VISIT)>0 D
 . S ENCOWNTR=$O(^SCE("AVSIT",VISIT,0))
 . I ENCOWNTR,$P(^SCE(ENCOWNTR,0),"^",6) S ENCOWNTR=$P(^SCE(ENCOWNTR,0),"^",6)
 . I DFN="",VISIT'="" S DFN=$P(^AUPNVSIT(VISIT,0),U,5)
 N CODE,CODES,IEN,IFN,NODE,PXDIAG,SAS,SDCLOEY,SEQ,ORG,END,DA,X,SIDX,SQUIT
 I $G(ENCOWNTR) Q:'$D(^SCE(+ENCOWNTR,0))  N APTDT,DFN,LOC S END=0,X0=^SCE(+ENCOWNTR,0) D ENCHK(ENCOWNTR,X0) Q:END  G ON ;PX*1.0*240 removed dot structure to ensure proper command flow
 Q:'$G(DFN)!'$G(LOC)!'$G(APTDT)
 S X=$G(^DPT(DFN,"S",APTDT,0))
 I +X,+X=LOC,$P(X,"^",20),$D(^SCE($P(X,"^",20),0)) S ENCOWNTR=$P(X,"^",20),END=0,X0=^(0) D ENCHK(ENCOWNTR,X0) Q:END  G ON
 S END=0 D OPCHK(DFN,LOC,APTDT) I END Q
 I +$G(VISIT)=0 S VISIT=$P($G(^SCE(+ENCOWNTR,0)),U,5)
ON ;D ASKCL($G(ENCOWNTR),.SDCLOEY,DFN,APTDT)
 D SC^PXCEVFI2(DFN) ;PX*1.0*235 moved to ON tag
 D GETPATSA^PXSPECAUTH(DFN,APTDT,LOC,VISIT,.SAS)
 S CODE="" F  S CODE=$O(SAS(CODE)) Q:CODE=""  D
 .I +$P(SAS(CODE),U)=0 Q
 .S SIDX=+$O(^PXIND(820,"C",CODE,"")) I SIDX=0 Q
 .S NODE=$G(^PXIND(820,SIDX,0)) S SEQ=$P(NODE,U,4)
 .I CODE="SC",$P(SAS(CODE),U,2)="" I +$$SC^SDSCAPI(DFN,.PXDIAG,ENCOWNTR,$G(VISIT))>0 S $P(SAS(CODE),U,2)=1
 .S CODES(SEQ)=SIDX_U_$TR($P(NODE,U,3),"&","")_U_CODE_U_$P(SAS(CODE),U,2)
 I '$D(CODES) Q
 D ASK(.CODES,VISIT)
 Q
 ;
ASKCL(ENCOWNTR,SDCLOEY,DFN,APTDT) ;Ask classifications on check out
 I $G(ENCOWNTR) D CLOE^SDCO21(ENCOWNTR,.SDCLOEY) Q
 D CL^SDCO21(DFN,APTDT,"",.SDCLOEY)
 Q
 ;ASK(ENCOWNTR,SDCLOEY,SQUIT) ;Ask classifications
ASK(CODES,VISIT) ;
 N CNT,DIR,DONE,I,IDX,IOINHI,IOINORM,NODE,NOTFILED,TYPI,TYPSEQ,CTS,X,PXVST,PXEOCNUM,PXANS,SEQ,SIDX,Y
 N CNT,DIR,DONE,DIRUT,DTOUT,DUOUT,IDX,IOINHI,IOINORM,NODE,NOTFILED,SEQ,SIDX,X,Y
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 W !!,"--- ",IOINHI,"Classification",IOINORM," --- [",IOINHI,"Required",IOINORM,"]"
 W !
 S PXVST=$P($G(X0),U,5) I 'PXVST,($G(PXCECAT)="VST")!($G(PXCECAT)="SIT") Q
 S DIR(0)="Y",CNT=0
 S SEQ=0,DONE=0 F  S SEQ=$O(CODES(SEQ)) Q:SEQ'>0!(DONE=1)  D
 .S NODE=CODES(SEQ)
 .S DIR("A")="Was treatment related to "_$P(NODE,U,2)_" condition"
 .S DIR("B")=$S($P(NODE,U,4)=1:"Yes",1:"No")
 .D ^DIR
 .I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) S DONE=1 Q
 .I ($G(PXCECAT)="VST")!($G(PXCECAT)="SIT") D  Q
 ..I +$G(VISIT)>0 D
 ...I '$D(^AUPNVSIT(VISIT,900)) S CNT=CNT+1,PXBDATA(CNT,0)=$P(NODE,U)_U_Y Q
 ...S SIDX=$P($P(NODE,U),";") S IDX=+$O(^AUPNVSIT(VISIT,900,"B",SIDX,"")) I IDX=0 S NOTFILED($P(NODE,U)_U_Y)="" Q
 ...S PXBDATA(IDX,0)=$P(NODE,U)_U_Y
 ..I '$D(NOTFILED) Q
 ..S CNT=+$O(^AUPNVSIT(VISIT,900,""))
 ..S NODE="" F  S NODE=$O(NOTFILED(NODE)) Q:NODE=""  S CNT=CNT+1,PXBDATA(CNT,0)=NODE
 .S CNT=CNT+1,PXBDATA(CNT,0)=$P(NODE,U)_U_Y
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
 Q
