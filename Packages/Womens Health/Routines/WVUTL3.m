WVUTL3 ;HCIOFO/FT,JR - UTIL: DATE, LOCK, DIR, PATVARS;08/08/2017  08:47
 ;;1.0;WOMEN'S HEALTH;**24**;Sep 30, 1998;Build 582
 ;* IHS/ANMC/MWR
 ;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;  UTILITY: ASK DATE RANGE, LOCKS, DIR PROMPTS,
 ;  STORE PAP REGIMEN, PCDVARS & PATVARS.
 ;
OUT ;EP
 ;---> CALLED AFTER ERROR MESSAGES ARE DISPLAYED.
 S WVPOP=1 D DIRZ
 Q
 ;
ASKDATES(WVB,WVE,WVPOP,WVBDF,WVEDF,WVSAME,WVTIME) ;EP
 ;---> ASK DATE RANGE.
 ;---> PARAMETERS:
 ;     1 - WVB    (RETURNED) BEGIN DATE, FILEMAN FORMAT
 ;     2 - WVE    (RETURNED) END DATE, FILEMAN FORMAT
 ;     3 - WVPOP  (RETURNED) WVPOP=1 IF QUIT,FAIL,DTOUT,DUOUT
 ;     4 - WVBDF  (OPTIONAL) BEGIN DATE DEFAULT, FILEMAN FORMAT
 ;     5 - WVEDF  (OPTIONAL) END DATE DEFAULT, FILEMAN FORMAT
 ;     6 - WVSAME (OPTIONAL) FORCE END DATE DEFAULT=BEGIN DATE
 ;     7 - WVTIME (OPTIONAL) ASK TIMES
 ;
 ;---> EXAMPLE:
 ;        D ASKDATES^WVUTL3(.WVBEGDT,.WVENDDT,.WVPOP,"T-365","T")
 ;
 S WVPOP=0 N %DT,Y
 W !!,"   *** Date Range Selection ***"
 S %DT="APEX"_$S($D(WVTIME):"T",1:"")
 S %DT("A")="   Begin with DATE: "
 I $G(WVBDF)]"" S Y=WVBDF D DD^%DT S %DT("B")=Y
 D ^%DT K %DT
 I Y<0 S WVPOP=1 Q
 S (%DT(0),WVB)=Y K %DT("B")
 S %DT="APEX"_$S($D(WVTIME):"T",1:"")
 S %DT("A")="   End with DATE:   "
 I $G(WVEDF)]"" S Y=WVEDF D DD^%DT S %DT("B")=Y
 I $D(WVSAME) S Y=WVB D DD^%DT S %DT("B")=Y
 D ^%DT K %DT
 I Y<0 S WVPOP=1 Q
 S WVE=Y
 Q
 ;
LOCKED ;EP
 Q:$D(ZTQUEUED)  ;quit if called from a background (tasked) job.
 W !?5,"Another user is editing this entry.  Please, try again later."
 D DIRZ
 Q
 ;
LOCKEDE ;EP
 ;---> LOCKED PREGNANCY LOG ENTRY.
 W !?5,"Another user is editing the Pregnancy Log for this patient"
 W !?5,"for this day.  Please, try again later."
 D DIRZ
 Q
 ;
LOCKEDP ;EP
 ;---> LOCKED PAP Regimen Log ENTRY.
 W !?5,"Another user is editing the PAP Regimen Log for this patient"
 W !?5,"for this day.  Please, try again later."
 D DIRZ
 Q
 ;
LOCKEDL ;EP
 ;---> LOCKED LACTATION LOG ENTRY.
 W !?5,"Another user is editing the Lactation Log for this patient"
 W !?5,"for this day.  Please, try again later."
 D DIRZ
 Q
 ;
LOCKEDM ;EP
 ;---> LOCKED MENSTRUAL CYCLE LOG ENTRY.
 W !?5,"Another user is editing the Menstrual Cycle Log for this patient"
 W !?5,"for this day.  Please, try again later."
 D DIRZ
 Q
 ;
DIRZ ;EP
 ;---> PRESS RETURN TO CONTINUE.
 N DIR,DIRUT,X,Y,DTOUT,DUOUT,DIROUT
 I $D(WVPRMT) S DIR("A")=WVPRMT
 I $D(WVPRMT1) S DIR("A",1)=WVPRMT1
 I $D(WVPRMT2) S DIR("A",2)=WVPRMT2
 I $D(WVPRMTQ) S DIR("?")=WVPRMTQ
 S DIR(0)="E" W ! D ^DIR W !
 S WVPOP=$S($D(DIRUT):1,Y<1:1,1:0)
 Q
 ;
DIRPRMT ;EP
 ;---> REQUIRED VARIABLE: WVPROMPT,M (M=LAST SELECTION# DISPLAYED)
 ;---> OPTIONAL VARIABLE: WVCODE (EXECUTABLE CODE ACTING ON INPUT X)
 ;---> WVD=1 IF RANGE OF SELECTION NUMBERS SHOULD BE DISPLAYED.
 N DIR,DIRUT,Y,X,DTOUT,DUOUT,DIROUT
 W ! S:'$D(WVD) WVD=0
 S DIR(0)="LO^"_$S(WVD:":"_M,1:"1:"_M)
 I $D(WVPRMT) S DIR("A")=WVPRMT
 I $D(WVPRMT1) S DIR("A",1)=WVPRMT1
 I $D(WVPRMT2) S DIR("A",2)=WVPRMT2
 I $D(WVPRMTQ) S DIR("?")=WVPRMTQ
 I $D(WVCODE) S DIR(0)=DIR(0)_U_WVCODE
 D ^DIR
 S:$D(DTOUT)!($D(DUOUT)) WVPOP=1
 Q
 ;
STORPAP ;EP
 ;---> STORE PAP REGIMEN, START DATE AND DATE ENTERED; CALLED BY
 ;---> MUMPS XREF ON FIELDS #.16 AND #.17 IN WV PATIENT FILE.
 ;---> REQUIRED VARIABLES: WVLDAT=BEGIN DATE, WVLPRG=PAP REGIMEN, WVDFN.
 Q:'$D(WVLDAT)!('$D(WVLPRG))!('$D(WVDFN))
 Q:'WVLDAT!('WVLPRG)!('WVDFN)
 N DA,DIC,DIE,DLAYGO,DR,N,WVQUIT,X,DG
 D SETVARS^WVUTL5
 S WVQUIT=0,DLAYGO=790
 S DIE="^WV(790.04,"
 S DR=".01////"_WVLDAT_";.03////"_WVLPRG
 S N=0
 F  S N=$O(^WV(790.04,"C",WVDFN,N)) Q:'N!(WVQUIT)  D
 .I $D(^WV(790.04,"B",WVLDAT,N)) S DA=N D
 ..L +^WV(790.04,DA):0 I '$T D LOCKEDP S WVQUIT=1 Q
 ..D DIE^WVFMAN(790.04,DR,DA,.WVPOP) L -^WV(790.04,DA) S WVQUIT=1
 Q:WVQUIT
 ;
 K DD,DO
 S DIC="^WV(790.04,",DIC(0)="L",X=WVLDAT,DLAYGO=790
 S DIC("DR")=".02////"_WVDFN_";.03////"_WVLPRG
 D FILE^DICN
 Q
 ;
PCDVARS(DA,TEXTDATE,COLP) ;EP
 ;---> SET VARIABLES FOR PROCEDURE DATA FOR HEADERS.
 ;---> REQUIRED VARIABLES: DA=IEN OF PROCEDURE IN PROC FILE 790.1.
 ;--->               TEXTDATE=1 PROVIDE DATE IN TEXT FORMAT,
 ;--->                          OTHERWISE IN NUMERIC FORMAT (1/1/95)
 ;--->                   COLP=1 TO SET WVC0=ASSOC'D COLP IF THIS IS
 ;--->                          A PAP.
 ;---> Y=ZERO NODE OF PROCEDURE, WVACCN=ACCESSION#,
 ;---> WVPCDN=IEN OF PROCEDURE TYPE,
 ;---> WVRESN=IEN OF RESULT/DIAG,WVRES=TEXT OF RESULT/DIAG
 ;---> WVPN=PROCEDURE TYPE, WVDFN=DFN OF PATIENT.
 ;---> WV0=ZERO NODE OF THIS PROCEDURE, WV2=TWO NODE.
 ;---> WVPAP=1=PCD IS A PAP, WVMAM=1=PCD IS A SCREENING MAM.
 ;---> WVC0=ZERO NODE OF ASSOCIATED COLP (IF THIS IS A PAP).
 ;
 N X,Y S (WV0,Y)=^WV(790.1,DA,0),WVC0=""
 S WV2=$S($D(^WV(790.1,DA,2)):^(2),1:"")
 S COLP=$G(COLP) S:COLP WVC0=$$COLP0^WVUTL4(DA)
 S TEXTDATE=$G(TEXTDATE)
 S WVACCN=$$ACC^WVUTL1(DA)
 S WVPCDN=$P(Y,U,4)
 S X=DA,WVPN=$$PROC^WVUTL1A
 S WVRESN=$P(Y,U,5),WVRES=$$DIAG^WVUTL4(WVRESN)
 S X=$P(Y,U,7),WVPROV=$$PROV^WVUTL6
 S WVDFN=$P(Y,U,2) D PATVARS(WVDFN,TEXTDATE)
 S (WVMAM,WVPAP)=0
 S:WVPCDN=28 WVMAM=1 S:WVPCDN=1 WVPAP=1
 Q
 ;
PATVARS(DFN,TEXTDATE) ;EP
 ;---> SET VARIABLES FO PATIENT DATA FOR HEADERS.
 ;---> REQUIRED VARIABLES: WVDFN=IEN OF PATIENT
 ;---> YIELDS: WVNAME=PATIENT NAME, WVCHRT=SSN#
 ;---> WVCMGR=CASE MANAGER, WVCNEED=CX TX NEED,
 ;---> WVPAPRG=PAP REGIMEN, WVBNEED=BR TX NEED, WVEDC=EDC.
 S TEXTDATE=$G(TEXTDATE)
 S WVNAME=$$NAME^WVUTL1(DFN)
 S WVNAMAGE=$$NAMAGE^WVUTL1(DFN)
 S WVCHRT=$$SSN^WVUTL1(DFN)
 S WVCMGR=$$CMGR^WVUTL1(DFN)
 S WVCNEED=$$CNEED^WVUTL1(DFN,TEXTDATE)
 S WVPAPRG=$$PAPRG^WVUTL1(DFN,TEXTDATE)
 S WVBNEED=$$BNEED^WVUTL1(DFN,TEXTDATE)
 S WVEDC=$$EDC^WVUTL1(DFN)
 Q
 ;
SETFMVAR ;SAVE FILEMAN VARIABLES FOR RESTORATION
 S:$D(DI) WVDI=DI
 S:$D(DQ) WVDQ=DQ
 S:$D(DC) WVDC=DC
 S:$D(DM) WVDM=DM
 S:$D(DK) WVDK=DK
 S:$D(DP) WVDP=DP
 S:$D(DL) WVDL=DL
 S:$D(DIU) WVDIU=DIU
 Q
 ;
GETFMVAR ;RESTORE FILEMAN VARIABLS
 S:$D(WVDI) DI=WVDI
 S:$D(WVDQ) DQ=WVDQ
 S:$D(WVDC) DC=WVDC
 S:$D(WVDM) DM=WVDM
 S:$D(WVDK) DK=WVDK
 S:$D(WVDP) DP=WVDP
 S:$D(WVDL) DL=WVDL
 S:$D(WVDIU) DIU=WVDIU
 K WVDI,WVDQ,WVDC,WVDM,WVDK,WVDP,WVDL,WVDIU
 Q
 ;
FMADD(WVDAYS,WVPDT) ; This function adds the date offset indicated to the
 ; specified date to calculate a future date.
 ;  Input: WVDAYS - date offset (e.g., 90D, 6M, 1Y)  [required]
 ;         WVPDT  - date of procedure [optional]
 ;                  default is today
 ; Output: FileMan date. Returns null if a FileMan date could not
 ;         be calculated.
 ;
 Q:'WVDAYS ""
 S:'$G(WVPDT) WVPDT=DT
 N WVARRAY,WVERR,WVLOOP,WVMONTH,WVNEWDT,WVYEAR,X
 S WVNEWDT=""
 S X=WVDAYS
 D DMYCHECK^WVPURP ;check offset value
 S WVDAYS=X
 I X=-1 Q WVNEWDT
 I WVDAYS["D" D
 .S WVARRAY=$$FMADD^XLFDT(WVPDT,+WVDAYS)
 .S:WVARRAY>0 WVNEWDT=WVARRAY
 .Q
 I WVDAYS["M" D
 .S WVMONTH=+$E(WVPDT,4,5),WVYEAR=0
 .F WVLOOP=1:1:+WVDAYS D
 ..S WVMONTH=WVMONTH+1
 ..I WVMONTH>12 S WVMONTH=1,WVYEAR=WVYEAR+1
 ..Q
 .S WVNEWDT=WVPDT+(+WVYEAR*10000)
 .S WVMONTH=$S(WVMONTH<10:"0"_WVMONTH,1:WVMONTH)
 .S WVNEWDT=$E(WVNEWDT,1,3)_WVMONTH_$E(WVNEWDT,6,7)
 .Q
 I WVDAYS["Y" S WVNEWDT=WVPDT+(+WVDAYS*10000)
 Q WVNEWDT
 ;
PSTATCHG(OLDVAL,NEWVAL,DA) ;UPDATE RELATED FIELDS WHEN PREGNANCY STATUS
 ;                          FIELD VALUE CHANGES ('AF' CROSS-REFERENCE
 ;                          IN PREGNANCY STATUSES SUB-FILE #790.05)
 ; INPUT: OLDVAL - The original value in internal format
 ;        NEWVAL - The new value in internal format
 ;        DA - Reference to a FileMan DA array containing the IEN values
 ;             that identify the entry the user is modifying
 N DIK,DIH,DIG,DIV,DIW
 I ($G(NEWVAL)=1)&(($G(OLDVAL)=0)!($G(OLDVAL)=2)) D
 .S $P(^WV(790,DA(1),4,DA,2),U,4)="",$P(^WV(790,DA(1),4,DA,4),U,4)=""
 .S $P(^WV(790,DA(1),4,DA,4),U,5)=""
 .S DIK="^WV(790,"_DA(1)_",4,"
 .F DIK(1)=24,44,45 D EN^DIK
 .D METHOD^WVTDALRT(DA(1),.DA,0)
 I ((+$G(NEWVAL)=0)!($G(NEWVAL)=2)!($G(NEWVAL)=3))&($G(OLDVAL)=1) D
 .S $P(^WV(790,DA(1),4,DA,4),U)="",$P(^WV(790,DA(1),4,DA,4),U,2)=""
 .S $P(^WV(790,DA(1),4,DA,4),U,3)=""
 .S DIK="^WV(790,"_DA(1)_",4,"
 .F DIK(1)=41,42,43 D EN^DIK
 I ($G(NEWVAL)=3)&(($G(OLDVAL)=0)!($G(OLDVAL)=2)) D
 .S $P(^WV(790,DA(1),4,DA,2),U,4)=""
 .S DIK="^WV(790,"_DA(1)_",4,",DIK(1)=24 D EN^DIK
 Q
EIECHG(OLDVAL,NEWVAL,DA,NODE) ;UPDATE RELATED FIELDS WHEN ENTERED IN ERROR FIELD
 ;                        VALUE CHANGES ('AN' CROSS-REFERENCE IN PREGNANCY
 ;                        STATUSES SUB-FILE #790.05 AND 'AG' CROSS-REFERENCE IN
 ;                        LACTATION STATUSES SUB-FILE #790.16)
 ; INPUT: OLDVAL - The original value in internal format
 ;        NEWVAL - The new value in internal format
 ;        DA - Reference to a FileMan DA array containing the IEN values
 ;             that identify the entry the user is modifying
 ;        NODE - THE SUBSCRIPT THAT CONTAINS THE DATA
 N DIK,STAT,DIH,DIG,DIV,DIW
 I $G(OLDVAL)="",$G(NEWVAL)=1 D
 .S $P(^WV(790,DA(1),NODE,DA,0),U,7)=DUZ,$P(^(0),U,8)=$$NOW^XLFDT
 .S DIK="^WV(790,"_DA(1)_","_NODE_","
 .F DIK(1)=4,5  D EN2^DIK
 .S $P(^WV(790,DA(1),NODE,DA,0),U,4)=""
 .S $P(^WV(790,DA(1),NODE,DA,0),U,5)=""
 .S STAT("CSTAT")=$P($G(^WV(790,DA(1),NODE,DA,2)),U),STAT("CDATE")=$P($G(^WV(790,DA(1),NODE,DA,0)),U)
 .S STAT("PDATE")=$O(^WV(790,DA(1),NODE,"B",STAT("CDATE")),-1)
 .I STAT("PDATE")>0 D
 ..S STAT("PIEN")=$O(^WV(790,DA(1),NODE,"B",STAT("PDATE"),0)),STAT("PSTAT")=$P($G(^WV(790,DA(1),NODE,STAT("PIEN"),2)),U)
 .I STAT("CSTAT")=1,$G(STAT("PSTAT"))'=1 D @($S(NODE=4:"PREG",NODE=5:"LACT",1:"")_U_"WVTDALRT(DA(1),0)")
 .I NODE=4 D
 ..S STAT("CTRY")=$P($G(^WV(790,DA(1),NODE,DA,2)),U,4)
 ..S STAT("CLIKE")=$$COBP^WVUTL11(DA(1),DA)
 ..I $G(STAT("PIEN"))>0 D
 ...S STAT("PTRY")=$P($G(^WV(790,DA(1),NODE,STAT("PIEN"),2)),U,4)
 ...S STAT("PLIKE")=$$COBP^WVUTL11(DA(1),STAT("PIEN"))
 ..I STAT("CTRY")=1,$G(STAT("PTRY"))'=1 D TRY^WVTDALRT(DA(1),0)
 ..I STAT("CLIKE")<$G(STAT("PLIKE"))!(+$G(STAT("PLIKE"))=0&(STAT("CLIKE")=1)) D DELALERT^WVTDALRT($$MTEXT^WVTDALRT,DA(1))
 Q
