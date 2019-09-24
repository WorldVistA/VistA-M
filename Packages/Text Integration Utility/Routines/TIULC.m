TIULC ; SLC/JER - Computational functions ;08/06/2009
 ;;1.0;TEXT INTEGRATION UTILITIES;**3,9,19,23,53,93,109,182,250**;Jun 20, 1997;Build 14
 ;
 ; ICR #2054    - ^%DT
 ;     #10000   - NOW^%DTC Routine & %H, %I Local Vars
 ;     #10003   - %DT Local Var
 ;     #10103   - $$FMDIFF^XLFDT
 ;
LINECNT(DA) ; Compute line count for document record
 N CPL,CCNT S CPL=$S(+$P($G(TIUPRM0),U,3)>0:$P(TIUPRM0,U,3),1:60)
 Q $$CHARCNT(DA)\CPL
CHARCNT(DA) ; Compute character count for a record
 N TIUI
 N:'$D(CCNT) CCNT ; Character count is static
 S TIUI=0 F  S TIUI=$O(^TIU(8925,DA,"TEXT",TIUI)) Q:+TIUI'>0  D
 . S CCNT=+$G(CCNT)+$L($$STRIP^TIULS(^TIU(8925,DA,"TEXT",TIUI,0)))
 S TIUI=0
 F  S TIUI=$O(^TIU(8925,"DAD",DA,TIUI)) Q:+TIUI'>0!+$$ISADDNDM^TIULC1(+TIUI)  S CCNT=$$CHARCNT(TIUI)
 Q +$G(CCNT)
VBCLINES(DA,ROOT) ; Compute the Visible Black Character (VBC) Line Count for a document
 Q $FN(($$VBCCNT(DA,$G(ROOT,"^TIU(8925,"_DA_",""TEXT"")"))/65),"",2)
VBCCNT(DA,ROOT) ; Compute Visible Black Character (VBC) Count for a record
 N TIUVBC,TIUI S ROOT=$G(ROOT,"^TIU(8925,"_DA_",""TEXT"")")
 N:'$D(VBCCNT) VBCCNT
 S TIUVBC=$$VBC
 S TIUI=0
 F  S TIUI=$O(@ROOT@(TIUI)) Q:+TIUI'>0  D
 . N TIUL,TIUJ S TIUL=$G(@ROOT@(TIUI,0)),TIUJ=0
 . F TIUJ=1:1:$L(TIUL) D
 . . N TIUC S TIUC=$E(TIUL,TIUJ)
 . . S:TIUVBC[TIUC VBCCNT=+$G(VBCCNT)+1
 S TIUI=0
 I ROOT["^TIU(8925," D
 . F  S TIUI=$O(^TIU(8925,"DAD",DA,TIUI)) Q:+TIUI'>0!+$$ISADDNDM^TIULC1(+TIUI)  S CCNT=$$VBCCNT(TIUI)
 Q +$G(VBCCNT)
VBC() ; Return string of Visible Black Characters (VBC)
 Q "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~!@#$%^&*()_+{}|:<>?÷±`1234567890-=[]\;',./"""
STATUS(DA) ; Evaluate Status of Reports
 N NODE12,NODE13,NODE15,NODE16,AMENDED,STATUS,SIGNED,COSIGNED,PURGED
 N VERIFIED,RELEASED,SIGNER,COSIGNER,SIGSTAT,TYPE,REQVER,REQREL,REQCOS
 N DELETED,TIUDPARM,ADMINCL
 S STATUS=""
 S TYPE=$S($D(TIUTYP(1)):$P(TIUTYP(1),U,2),1:+$G(^TIU(8925,+DA,0)))
 D DOCPRM^TIULC1(TYPE,.TIUDPARM,DA)
 S REQVER=$$REQVER(+DA,+$P($G(TIUDPARM(0)),U,3))
 S REQREL=+$P($G(TIUDPARM(0)),U,2)
 S NODE12=$G(^TIU(8925,+DA,12)),NODE13=$G(^TIU(8925,+DA,13))
 S NODE15=$G(^TIU(8925,+DA,15)),NODE16=$G(^TIU(8925,+DA,16))
 S SIGNED=+$P(NODE15,U),COSIGNED=+$P(NODE15,U,7),REQCOS=+$P(NODE15,U,6)
 S SIGNER=+$P(NODE12,U,2),COSIGNER=+$P(NODE12,U,4)
 S ADMINCL=+$P(NODE16,U,6) ;P182
 S AMENDED=+$P(NODE16,U),PURGED=+$P(NODE16,U,9),DELETED=+$P(NODE16,U,11)
 S RELEASED=+$P(NODE13,U,4),VERIFIED=+$P(NODE13,U,5)
 I PURGED S STATUS="purged" G STATUSX
 I DELETED S STATUS="deleted" G STATUSX
 I AMENDED S STATUS="amended" G STATUSX
 I +$$ISA^TIULX(+TYPE,+$$CLASS^TIUCP),'SIGNER S STATUS="undictated" G STATUSX
 I '+NODE12,+NODE13 S STATUS="untranscribed" G STATUSX
 I REQREL,'RELEASED S STATUS="unreleased" G STATUSX
 I REQVER,'VERIFIED S STATUS="unverified" G STATUSX
 I SIGNED,$S('REQCOS:1,COSIGNED:1,1:0) S STATUS="completed" G STATUSX
 I ADMINCL S STATUS="completed" G STATUSX
 I 'SIGNED S STATUS="unsigned" G STATUSX
 I REQCOS,'COSIGNED S STATUS="uncosigned"
STATUSX Q STATUS
REQVER(TIUDA,TIUVPRM) ; Evaluate conditions of verification requirement
 N TIUD0,TIUD13,TIUD15,TIUY
 S TIUD0=$G(^TIU(8925,+TIUDA,0)),TIUD13=$G(^(13)),TIUD15=$G(^(15))
 I +$G(TIUVPRM)'>0!(+$P(TIUD13,U,5)>0) S TIUY=0 G REQVX
 I +$G(TIUVPRM)>0,+$G(TIUD15) S TIUY=0 G REQVX
 I +$G(TIUVPRM)=1 S TIUY=1 G REQVX
 I +$G(TIUVPRM)=2,($P(TIUD13,U,3)="U") S TIUY=1 G REQVX
 I +$G(TIUVPRM)=3,($P(TIUD13,U,3)="D") S TIUY=1
REQVX Q +$G(TIUY)
PRCDNC(DA,SCREEN) ; Determine sort precedence of each record
 N SIGNED,URGENCY
 S URGENCY=$P($G(^TIU(8925,+DA,0)),U,9)
 I +$$SIGNED(DA,.SCREEN)'>0 S Y=$S(URGENCY="P":1,1:2)
 E  S Y=3
 Q Y
PURGE(TIUDA) ; Checks whether or not a given Document should be purged
 N TIUEDT,TIUY S TIUY=0
 ; if parameters not in symbol table, get them
 I '$D(TIUPRM0) D SETPARM^TIULE
 ; exit if no Archive/purge grace period defined
 I +$P(TIUPRM0,U,4)'>0 G PURGEX
 S TIUEDT=$P($G(^TIU(8925,TIUDA,12)),U)
 I +TIUEDT'>0 G PURGEX ;Transcription date blank
 I +$$ISPN^TIULX(+$G(^TIU(8925,+TIUDA,0))) G PURGEX ; PN's exempt
 I +$$ISADDNDM^TIULC1(+TIUDA),+$$ISPN^TIULX(+$G(^TIU(8925,+$P(^TIU(8925,+TIUDA,0),U,6),0))) G PURGEX ; Addenda to Progress Notes exempt
 I +$P($G(^TIU(8925,+TIUDA,0)),U,5)<7 G PURGEX ;Incomplete--don't purge
 I +$P($G(^TIU(8925,TIUDA,16)),U,4)>0 G PURGEX ;Document already purged
 I $$FMDIFF^XLFDT(DT,TIUEDT)>+$P(TIUPRM0,U,4) S TIUY=1
PURGEX Q TIUY
OVERDUE(TIUDA) ; Checks whether or not a given document is overdue
 N TIUD0,TIUDATE,TIUY,TIUDPRM S TIUY=0,TIUD0=$G(^TIU(8925,TIUDA,0))
 ; if parameters not in symbol table, get them
 I '$D(TIUPRM0) D SETPARM^TIULE
 D DOCPRM^TIULC1(+TIUD0,.TIUDPRM,TIUDA)
 ; exit if no signature grace period defined
 I +$P(TIUPRM0,U,5)'>0 G OVERX
 I '$D(TIUDPRM) G OVERX
 S TIUDATE=$S($$REQVER(TIUDA,+$P(TIUDPRM(0),U,3)):$P($G(^TIU(8925,+TIUDA,13)),U,5),$P(TIUDPRM(0),U,2):$P($G(^TIU(8925,+TIUDA,13)),U,4),1:$P($G(^TIU(8925,+TIUDA,12)),U))
 G:+TIUDATE'>0 OVERX
 I $$FMDIFF^XLFDT(DT,TIUDATE)>$P(TIUPRM0,U,5),(+$P($G(^TIU(8925,+TIUDA,0)),U,5)>4),(+$P($G(^TIU(8925,+TIUDA,0)),U,5)<7) S TIUY=1
OVERX Q TIUY
NOW() ; Extrinsic function returning current date/time to nearest .01 second
 N %,%H,%I,X
 D NOW^%DTC
 Q %
IDATE(X) ; Recieves date in external format, returns internal format
 N %DT,Y
 I ($L(X," ")=2),(X?1.2N1P1.2N1P1.2N1" "1.2N.E) S X=$TR(X," ","@")
 S %DT="TSP" D ^%DT
 Q Y
SIGNED(TIUDA,SCREEN) ; Check whether document requires signature or
 ; cosignature on user-sensitive basis
 N Y S Y=0 ; Initialize return value to FALSE
 ; If archived/purged return TRUE
 I +$P($G(^TIU(8925,+TIUDA,16)),U,9) S Y=1 G SIGNEDX
 ; If OPTION is Act on MY Unsigned Documents, check
 ; whether his/her signature is present
 I $P($G(SCREEN(1)),U)="AAU",($P($G(SCREEN(2)),U)="ASUP") D  G SIGNEDX
 . ; If dictated by user and signed return TRUE
 . I $P($G(^TIU(8925,+TIUDA,12)),U,4)=DUZ,(+$P($G(^(15)),U)>0) S Y=1
 . ; If user is Expected Cosigner and cosigned, return TRUE
 . I $P($G(^TIU(8925,+TIUDA,12)),U,8)=DUZ,(+$P($G(^(15)),U,7)>0) S Y=1
 ; Otherwise check search criteria to determine signature status
 I $P($G(SCREEN(1)),U)="AAU",+$P($G(^TIU(8925,+TIUDA,15)),U) S Y=1 G SIGNEDX
 I $P($G(SCREEN(1)),U)="ASUP",+$P($G(^TIU(8925,+TIUDA,15)),U,7) S Y=1 G SIGNEDX
 I +$P($G(^TIU(8925,+TIUDA,15)),U),+$P($G(^(15)),U,7) S Y=1
SIGNEDX Q Y
BLANK(TIUDA) ; Reads a given document for blank lines
 ; Returns: 1:Record contains 1 or more blanks
 ;          0:Record contains no blanks
 N BLANK,TIUI,Y S (TIUI,Y)=0
 I '$D(TIUPRM1) D SETPARM^TIULE
 I $P($G(TIUPRM1),U,6)']"" G BLANKX
 S BLANK=$P(TIUPRM1,U,6)
 F  S TIUI=$O(^TIU(8925,TIUDA,"TEXT",TIUI)) Q:+TIUI'>0  D
 . I $G(^TIU(8925,TIUDA,"TEXT",TIUI,0))[BLANK S Y=1
BLANKX Q Y
CHKSUM(TIUROOT,TIUY) ; Calculates checksum for a record
 N TIUI,X S TIUI=0,TIUY=+$G(TIUY)
 F  S TIUI=$O(@TIUROOT@(TIUI)) Q:+TIUI'>0  D
 . S X=$G(@TIUROOT@(TIUI,0))
 . N TIUJ
 . F TIUJ=1:1:$L(X) S TIUY=+$G(TIUY)+(($A(X,TIUJ)*TIUI)*TIUJ)
 S TIUI=0
 F  S TIUI=$O(^TIU(8925,"DAD",+$P(TIUROOT,",",2),TIUI)) Q:+TIUI'>0  D
 . I +$$ISADDNDM^TIULC1(+TIUI) Q
 . S TIUY=+$G(TIUY)+$$CHKSUM("^TIU(8925,"_+TIUI_",""TEXT"")",TIUY)
 Q +$G(TIUY)
