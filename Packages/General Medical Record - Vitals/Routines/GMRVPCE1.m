GMRVPCE1 ;HIRMFO/RM-PCE Interface code ;8/2/96
 ;;5.0;GEN. MED. REC. - VITALS;**14**;Oct 31, 2002
PCE(GMRVSTOR) ; Called from VALIDATE^GMRVPCE0 to validate vitals data, or
 ; STORE^GMRVPCE0 to store vitals data.  The variable GMRVSTOR (req.)
 ; will determine if called from VALIDATE (0), or STORE (1).
 ; 08/15/2005 KAM/BAY 107096 added 'Q' for error handling
 ; 09/23/2005 KAM/BAY 113449 add check for invalid HOS/LOC type
 ;
 N GMRVDFN,GMRVDUZ,GMRVHLOC,GMRVPROV,GMRVX
 S GMRVDFN=$P($G(GMRVDAT("ENCOUNTER")),"^",2)
 I GMRVDFN'>0!'$D(^DPT(+GMRVDFN,0)) D ERROR(0,0,1,GMRVDFN) Q
 S GMRVHLOC=$P($G(GMRVDAT("ENCOUNTER")),"^",3)
 I GMRVHLOC'>0!'$D(^SC(+GMRVHLOC,0)) D ERROR(0,0,2,GMRVHLOC) Q
 ; 09/26/2005 KAM/BAY 113449 added next line
 I GMRVHLOC>0,"C,W"'[$P(^SC(+GMRVHLOC,0),"^",3) D ERROR(0,0,8,$$GET1^DIQ(44,GMRVHLOC,.01)_" = "_$$GET1^DIQ(44,GMRVHLOC,2)) Q
 ;
 S GMRVDUZ=$P(GMRVDAT("SOURCE"),"^",2) I 'GMRVDUZ S GMRVDUZ=$G(DUZ)
 I GMRVDUZ'>0!'$D(^VA(200,+GMRVDUZ,0)) D ERROR(0,0,3,GMRVDUZ) Q
 S GMRVPROV=0
 F  S GMRVPROV=$O(GMRVDAT("VITALS",GMRVPROV)) Q:GMRVPROV'>0  D
 .  S GMRVX=0
 .  F  S GMRVX=$O(GMRVDAT("VITALS",GMRVPROV,GMRVX)) Q:GMRVX'>0  D
 .  .  D DATA($G(GMRVDAT("VITALS",GMRVPROV,GMRVX)))
 .  .  Q
 .  Q
 Q
ERROR(PROVIDER,I,CODE,VALUE) ; Given Provider IEN (PROVIDER), subentry (I),
 ; Error code (CODE) and Rejected value (VALUE), this procedure will
 ; set the GMRVDAT("ERROR") array with error.
 ;
 Q:$G(GMRVSTOR)=1
 N MSG,NODE,PIECE,X
 S X=$T(ERRTXT+CODE),MSG=$P(X,";",3),NODE=$P(X,";",4),PIECE=$P(X,";",5)
 S GMRVDAT("ERROR",NODE,PROVIDER,I,PIECE)=MSG_"^"_VALUE
 Q
ERRTXT ; Error messages and <NODE>/<PIECE> information for code passed.
 ;;Vitals missing/invalid Patient;VITALS;0
 ;;Vitals missing/invalid Hospital Location;VITALS;0
 ;;Vitals missing/invalid Source;VITALS;0
 ;;Vitals missing Data node;VITALS;0
 ;;Vitals missing/invalid Measurement Type;VITALS;1
 ;;Vitals missing/invalid Measurement Date;VITALS;4
 ;;Vitals missing/invalid Measurement;VITALS;2
 ;;Invalid Hospital Location Type;VITALS;0
 Q
DATA(VITALS) ; Process GMRVDAT("VITALS") node.  Data in in variable VITALS.
 ; Present but not passed are GMRVPROV=Provider IEN, GMRVX=subentry
 ; for GMRVPROV and GMRVSTOR=$S(1:Store data,0:Validate Data).
 ;
 N GMRVMTYP,GMRVRATE,GMRVUNIT,GMRVMDT
 I $G(VITALS)="" D ERROR(GMRVPROV,GMRVX,4,VITALS) Q
 N GMRVTYP,GMRVRATE,GMRVUNIT,GMRVMDT
 S GMRVMTYP=$P(VITALS,"^")
 I '$$VMTYPES^GMRVPCE0(GMRVMTYP) D ERROR(GMRVPROV,GMRVX,5,GMRVMTYP) Q
 S X=$P(VITALS,"^",4),%DT="TS" D ^%DT K %DT S GMRVMDT=Y
 I GMRVMDT'>0 D  I GMRVMDT'>0 D ERROR(GMRVPROV,GMRVX,6,GMRVMDT) Q
 .  S X=$P($G(GMRVDAT("ENCOUNTER")),"^"),%DT="TSR"
 .  D ^%DT K %DT S GMRVMDT=Y
 .  Q
 S GMRVRATE=$P(VITALS,"^",2)
 S GMRVUNIT=$P(VITALS,"^",3) I GMRVUNIT="" D
 .  I GMRVMTYP="HT" S GMRVUNIT="IN"
 .  I GMRVMTYP="WT" S GMRVUNIT="LB"
 .  I GMRVMTYP="TMP" S GMRVUNIT="F"
 .  Q
 I $S(GMRVRATE="":1,1:'$$RATECHK^GMRVPCE0(GMRVMTYP,GMRVRATE,GMRVUNIT)) D ERROR(GMRVPROV,GMRVX,7,GMRVRATE) Q
 S GMRVMTYP=$O(^GMRD(120.51,"APCE",GMRVMTYP,""))
 ; 08/15/2005 KAM 107096 Added 'Q' to next line
 I GMRVMTYP'>0 D ERROR(GMRVPROV,GMRVX,5,$P(VITALS,"^")) Q
 D DUPCHK I GMRVSTOR D
 .  N GMRVFDA
 .  S GMRVFDA(99,120.5,"+1,",.01)=GMRVMDT
 .  S GMRVFDA(99,120.5,"+1,",.02)=GMRVDFN
 .  S GMRVFDA(99,120.5,"+1,",.03)=GMRVMTYP
 .  S GMRVFDA(99,120.5,"+1,",.04)=$$NOW^XLFDT()
 .  S GMRVFDA(99,120.5,"+1,",.05)=GMRVHLOC
 .  S GMRVFDA(99,120.5,"+1,",.06)=GMRVDUZ
 .  S GMRVFDA(99,120.5,"+1,",1.2)=GMRVRATE
 .  D UPDATE^DIE("","GMRVFDA(99)")
 .  Q
 Q
DUPCHK ; This procedure checks for duplicate data.  If data is being
 ; validated, a warning message will be sent, if data is being stored,
 ; the old record that is duplicate will be entered in error and the
 ; new data filed.
 ;
 N GMRVDA S GMRVDA=0
 F  S GMRVDA=$O(^GMR(120.5,"AA",GMRVDFN,GMRVMTYP,9999999-GMRVMDT,GMRVDA)) Q:GMRVDA'>0  D:'+$G(^GMR(120.5,GMRVDA,2))
 .  S %=$G(^GMR(120.5,GMRVDA,0))
 .  I $P(%_"^","^",5,9)'=(GMRVHLOC_"^"_GMRVDUZ_"^^"_GMRVRATE_"^") D
 .  .  I GMRVSTOR D
 .  .  .  ;S DIE="^GMR(120.5,",DA=GMRVDA,DR="2////1;3////"_GMRVDUZ D ^DIE
 .  .  .  N GMRVFDA
 .  .  .  S GMRVFDA(88,120.5,GMRVDA_",",2)=1,GMRVFDA(88,120.5,GMRVDA_",",3)=GMRVDUZ D FILE^DIE("","GMRVFDA(88)")
 .  .  .  S GMRVFDA(77,120.506,"?+1,"_GMRVDA_",",.01)=4 D UPDATE^DIE("","GMRVFDA(77)")
 .  .  .  Q
 .  .  I 'GMRVSTOR S GMRVDAT("WARNING","VITALS",GMRVPROV,GMRVX,0)="Duplicate measurement data exists in database!  That data was overwritten by this transaction."
 .  Q
 Q
