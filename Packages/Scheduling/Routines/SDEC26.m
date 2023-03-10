SDEC26 ;ALB/SAT - VISTA SCHEDULING RPCS ;DEC 12,2022
 ;;5.3;Scheduling;**627,658,722,831**;Aug 13, 1993;Build 4
 ;
 Q
 ;
EDITAPPT(SDECY,SDECAPTID,SDECNOTE,SDECLEN) ;Edit appointment (only 'note text' and appointment length can be edited)
 ;EDITAPPT(SDECY,SDECAPTID,SDECNOTE,SDECLEN)  external parameter tag is in SDEC
 ; SDECAPTID - Appointment ID - Pointer to SDEC APPOINTMENT
 ; SDECNOTE  - Note
 ; SDECLEN   - no longer allowed If there is a change in the length of appointment, this is the new value (in minutes) for length
 ;
 N SDECAP,SDECCL,SDECNEND,SDECNOD,SDECOLEN,SDECPAT,SDECPATID,SDECRES,SDECSTART
 N DIK,DA,INP,SDECID,SDECI,SDECZ,SDECIENS,SDECEND
 ;
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,SDECI)="T00020ERRORID"_$C(30)
 S SDECI=SDECI+1
 ;validate SDEC appointment pointer
 I '+SDECAPTID D ERR(SDECI,"SDEC26: Invalid Appointment ID") Q
 I '$D(^SDEC(409.84,SDECAPTID,0)) D ERR(SDECI,"SDEC26: Invalid Appointment ID") Q
 ;alb/sat 658 begin
 N SDID,SDNOD,SDRET,SDTYP  ;check if request is open
 S SDNOD=$G(^SDEC(409.84,SDECAPTID,0))
 I $P(SDNOD,U,23)="",$P(SDNOD,U,12)="" D
 .S SDTYP=$P($G(^SDEC(409.84,SDECAPTID,2)),U,1)
 .Q:SDTYP=""
 .S SDID=$P(SDTYP,";",1)
 .S SDTYP=$S($P(SDTYP,";",2)="SDWL(409.3,":1,$P(SDTYP,";",2)="SDEC(409.85,":2,1:0)
 .I SDTYP=2,$$GET1^DIQ(409.85,SDID_",",23,"I")="O" D
 ..S INP(1)=SDID
 ..S INP(2)="SA"
 ..S INP(4)=$P(SDNOD,U,9)   ;date appt made
 ..D ARCLOSE1^SDEC(.SDRET,.INP)
 .I SDTYP=1,$$GET1^DIQ(409.3,SDID_",",23,"I")="O" D
 ..S INP(1)=SDID
 ..S INP(2)="SA"
 ..S INP(4)=$P(SDNOD,U,9)   ;date appt made
 ..D WLCLOSE1^SDEC(.SDRET,.INP)
 ..;end check if request is open
 S SDECNOTE=$G(SDECNOTE) S:SDECNOTE'="" SDECNOTE=$E(SDECNOTE,1,150),SDECNOTE=$TR(SDECNOTE,"^"," ")   ;alb/sat 658 - only use 1st 150 characters
 D:SDECNOTE'="" SETNOTE(SDECAPTID,SDECNOTE)
 ;alb/sat 658 end
 ;
 ;Edit appointment length - no longer permitted.
 N POP
 S POP=0
 I $G(SDECLEN),$G(SDECLEN)>0 D
 . I $G(SDECLEN)'=$$GET1^DIQ(409.84,SDECAPTID_",",.18,"I") D
 . . D ERR(SDECI,"SDEC26: Appointment Length cannot be modified. Cancel appointment and recreate.")
 . . S POP=1
 Q:POP
 ;
 ;Return Recordset
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)="-1"_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
SETNOTE(APID,NOTE)  ;set note to SDEC APPOINTMENT and file 44-APPOINTMENT-OTHER  alb/sat 658
 N DFN,DIC,DA,FDA,IENS,X,Y,DLAYGO,DD,DO,DINUM
 N SDCL,SDID,SDRES,SDRTYP,SDT
 S NOTE=$G(NOTE)
 Q:NOTE=""
 S:NOTE'="" NOTE=$E(NOTE,1,150)
 S DFN=$$GET1^DIQ(409.84,APID_",",.05,"I")
 S SDRES=$$GET1^DIQ(409.84,APID_",",.07,"I")
 Q:SDRES=""
 S SDRTYP=$$GET1^DIQ(409.831,SDRES_",",.012,"I")
 Q:$P(SDRTYP,";",2)'="SC("
 S SDCL=$P(SDRTYP,";",1)
 S SDT=$$GET1^DIQ(409.84,APID_",",.01,"I")
 S SDID=0 F  S SDID=$O(^SC(SDCL,"S",SDT,1,SDID)) Q:SDID=""  Q:(($P($G(^SC(SDCL,"S",SDT,1,SDID,0)),U,9)'="C")&(+$G(^SC(SDCL,"S",SDT,1,SDID,0))=DFN))  ;*zeb 722 2/21/19 skip cancelled appts
 Q:SDID=""
 S IENS=SDID_","_SDT_","_SDCL_","
 S FDA(44.003,IENS,3)=NOTE
 ;S FDA(44.003,IENS,7)=DUZ   ;alb/sat 658 - removed
 ;S FDA(44.003,IENS,8)=$$NOW^XLFDT   ;alb/sat 658 - removed
 D UPDATE^DIE("","FDA")
 ;S DIC="^SC("_SDCL_",""S"","_SDT_",1,"_SDID
 ;S DA(3)=SDCL,DA(2)=SDT,DA(1)=SDID,X=DFN
 ;S DIC("DR")="3///"_$E(NOTE,1,150)_";7////"_DUZ_";8////"_$$NOW^XLFDT
 ;S DIC("P")="44.003PA",DIC(0)="L",DLAYGO=44.003
 ;D FILE^DICN
 D SDECWP^SDEC07(APID,NOTE)
 Q
 ;
 ;
ERR(SDECI,SDECERR) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERR_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
ETRAP ;EP Error trap entry
 D ^%ZTER
 I '$D(SDECI) N SDECI S SDECI=999999
 S SDECI=SDECI+1
 D ERR(SDECI,"SDEC26 Error")
 Q
