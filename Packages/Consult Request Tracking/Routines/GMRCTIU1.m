GMRCTIU1 ;SLC/JER - More CT/TIU interface modules ;7/9/2003 [7/9/03 1:51pm]
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,21,17,34**;DEC 27, 1997
 ;
 ;This routine invokes IA #2693
ROLLBACK(DA,TIUDA) ; Roll-back a CT record when result is deleted or
 ;reassigned
 ;Disassociate Note logic
 ;The action removes the association of a TIU note with a consult.
 ;The new CPRS status will change to "ACTIVE", unless one of the
 ;remaining notes has a completed status. 
 ;This action should send an alert to the service notification users.
 N DIE,DR,GMRCSTS,GMRCA,GMRCO,GMRCOM,GMRCORNP,GMRCDFN,GMRCNODE,GMRCLIST,GMRCD0,GMRCD1,GMRCSF,GMRCADUZ,MSGTOSRV,GMRCATX,GMRCORTX,GMRCSTAR,GMRCERR,ACTDA,ACTREC,GMRCLSCH,GMRCLER,GMRCRBDA,GMRCTDA,GMRCRSLT
 S GMRCNODE=$G(^GMR(123,+DA,0))
 ; If current result has never been posted, no need to roll back
 ; Patch GMRC*1*21
 I '+$O(^GMR(123,+DA,50,"B",+TIUDA_";TIU(8925,",0)) Q
 I ($P(GMRCNODE,U,20)=TIUDA) S DIE="^GMR(123,",DR="16///@" D ^DIE
 S GMRCD0=DA,GMRCD1=0 F  S GMRCD1=$O(^GMR(123,GMRCD0,50,GMRCD1)) Q:'GMRCD1  D
 .N DA,DIK
 .Q:'(TIUDA=+$G(^GMR(123,GMRCD0,50,GMRCD1,0)))
 .S DA(1)=GMRCD0,DA=GMRCD1
 .S DIK="^GMR(123,"_DA(1)_",50,"
 .D ^DIK
 ;
 S GMRCA=12,GMRCO=DA
 D GETLIST^GMRCTIUL(DA,2,1,.GMRCLIST)
 S GMRCSTS=9
 ;Following if statement and DO block accomplish the following
 ;If there are no other associated TIU Docs then
 ;Set status to scheduled if it was last status before the TIU doc
 ;Set status to pending if it was the last status before the TIU doc
 ;Set status to active otherwise
 I '$G(GMRCLIST(0)) S GMRCSTS=6 D
 .S ACTDA=0,ACTREC=0,GMRCRBDA=0,GMRCLER=-1,GMRCLSCH=-1
 .F  S ACTDA=$O(^GMR(123,DA,40,ACTDA)) Q:-ACTDA=0  D
 ..S ACTREC=$G(^GMR(123,DA,40,ACTDA,0))
 ..I $P(ACTREC,U,2)=9,$P($P(ACTREC,U,9),";",1)=TIUDA S GMRCRBDA=ACTDA
 ..I $P(ACTREC,U,2)=8 S GMRCLSCH=ACTDA
 ..I $P(ACTREC,U,2)=11 S GMRCLER=ACTDA
 .I GMRCLER'=-1,GMRCLER>GMRCLSCH S GMRCSTS=5
 .I GMRCLSCH'=-1,GMRCLSCH>GMRCLER S GMRCSTS=8
 E  S GMRCD0="" F  S GMRCD0=$O(^TMP("GMRC50",$J,GMRCD0)) Q:'$L(GMRCD0)  D
 .Q:(+GMRCD0=TIUDA)
 .S GMRCD1=0 F  S GMRCD1=$O(^TMP("GMRC50",$J,GMRCD0,GMRCD1)) Q:'GMRCD1  D
 ..S:($P($G(^TMP("GMRC50",$J,GMRCD0,GMRCD1)),U,6)="completed") GMRCSTS=2
 Q:$G(NOSAVE)
 ;Make status completed if the Consult was Admin. Completed
 S ACTDA=0,ACTREC=0
 F  S ACTDA=$O(^GMR(123,DA,40,ACTDA)) Q:-ACTDA=0  D
 .S ACTREC=$G(^GMR(123,DA,40,ACTDA,0))
 .I $P(ACTREC,U,2)=10,$P(ACTREC,U,9)="" S GMRCSTS=2
 D STATUS^GMRCP
 K ^TMP("GMRC50",$J),^TMP("GMRC50R",$J)
 ;
 S GMRCOM=0,MSGTOSRV=0,GMRCRSLT=TIUDA_";TIU(8925," D AUDIT^GMRCP
 ;
 ;Build message information if status has changed or sig finding="Y"
 S GMRCSF=$P(GMRCNODE,U,19)
 I ($P(GMRCNODE,U,12)=$P($G(^GMR(123,GMRCO,0)),U,12)) D  Q:GMRCATX=""
 . S GMRCATX="" Q:GMRCSF'="Y"
 . S GMRCATX="*Removed consult note for "
 E  S GMRCATX=$S((GMRCSF="Y"):"*",1:"")_"Reactivated consult, removed note for ",MSGTOSRV=1
 S GMRCORNP=$P(GMRCNODE,U,14),GMRCDFN=$P(GMRCNODE,U,2)
 S GMRCORTX=$$ORTX^GMRCAU(GMRCO)
 S GMRCORTX=GMRCATX_GMRCORTX
 S:GMRCORNP GMRCADUZ(GMRCORNP)=""
 S GMRCTDA=TIUDA
 D EXTRACT^TIULQ(GMRCTDA,"GMRCSTAR",.GMRCERR,.05)
 I '$G(GMRCERR) D
 .I $G(GMRCSTAR(GMRCTDA,.05,"I"))'=5 D
 ..D MSG^GMRCP(GMRCDFN,GMRCORTX,+GMRCO,23,.GMRCADUZ,MSGTOSRV)
 Q:($P(GMRCNODE,U,12)=$P($G(^GMR(123,+GMRCO,0)),U,12))
 ;
 ;On status change, send "SC" (status change) HL7 msg to update order
 D EN^GMRCHL7(GMRCDFN,+GMRCO,$G(GMRCTYPE),$G(GMRCRB),"SC",GMRCORNP,$G(GMRCVSIT),.GMRCOM)
 Q
 ;
STATUS ;Update the status of a consult that has a TIU result
 N GMRCAD,GMRCATX,GMRCOA,GMRCOSTS,GMRCOTFN,GMRC,GMRCSF,GMRCLAE,GMRCRSLT,GMRCADUZ,GMRCOADT
 D GETOLD
 S GMRCORNP=$G(GMRCAUTH) ;author
 S GMRCRSLT=GMRCTUFN_";TIU(8925,"
 ;
 ;Evaluate whether a complete action is actually an addendum or New note
 I GMRCA=10 S GMRCA=$$EVALACT(GMRCOSTS,+GMRCO,GMRCRSLT)
 ;
 ;Update the status and last activity field
 ;Do not change the status if already completed
 I GMRCOSTS=2,GMRCSTS=9 S GMRCSTS=2
 D STATUS^GMRCP
 ;
 ;Update activity log
 D AUDIT
 ;
 ;Update the last TIU entry modified and add result to result multiple
 D ADD^GMRCTIUA(GMRCTUFN,GMRCO)
 ;
 ;Update order
 S GMRCORNP=$P(^GMR(123,+GMRCO,0),"^",14)
 D EN^GMRCHL7(GMRCDFN,+GMRCO,$G(GMRCTYPE),$G(GMRCRB),"RE",GMRCORNP,$G(GMRCVSIT),.GMRCOM)
 ;
 ;Send a message
 I $$COMPLETE(GMRCA) D
 . N GMRCDATA
 . S GMRCATX=""
 . I GMRCA=14 S GMRCATX="New Note for "
 . I GMRCA=13 S GMRCATX="Addendum Added for "
 . S GMRCATX=$S((GMRCSF="Y"):"*",1:"")_GMRCATX
 . S GMRCORTX=GMRCATX_"Completed Consult "_$$ORTX^GMRCAU(+GMRCO)
 . S GMRCDATA=+GMRCO
 . S GMRCDATA=GMRCDATA_"|"_$G(GMRCRSLT)
 . I $P(GMRC(0),"^",14) S GMRCADUZ($P(GMRC(0),"^",14))=""
 . D MSG^GMRCP(GMRCDFN,GMRCORTX,GMRCDATA,23,.GMRCADUZ,0)
 . Q
 Q
 ;
GETOLD ;save the old values of status, and the last activity data
 ;to determine how to update status and TIU activity log
 S GMRC(0)=$G(^GMR(123,+GMRCO,0))
 S GMRCDFN=$P(GMRC(0),"^",2)
 S GMRCSF=$P(GMRC(0),U,19)
 S GMRCOSTS=$P(GMRC(0),"^",12) ;status before activity
 S GMRCLAE=+$P($G(^GMR(123,+GMRCO,40,0)),U,3) ;last activity entry
 S GMRC(40)=$G(^GMR(123,+GMRCO,40,+GMRCLAE,0))
 S GMRCOADT=+$P(GMRC(40),U,1) ;last activity entry date
 S GMRCOA=$P(GMRC(40),"^",2) ;last activity
 S GMRCOTFN=$P(GMRC(40),"^",9) ;last result
 Q
 ;
AUDIT ;Determine appropriate update activity.
 ;Quit if new activity is same as previous "Incomplete Rpt" activity
 I GMRCOTFN=GMRCRSLT,GMRCOA=9,GMRCOA=GMRCA,GMRCOSTS=GMRCSTS Q
 ;
 S GMRCOM=0
 S GMRCDT=$$NOW^XLFDT
 ;Check for overwrite of incomplete rpt activity if the new
 ;activity occurs within 15 minutes of the last.
 S GMRCOADT=$$FMADD^XLFDT(GMRCOADT,0,0,15)
 I GMRCOTFN=GMRCRSLT,GMRCOA=9,$$COMPLETE(GMRCA),GMRCDT<GMRCOADT D AUDIT1 Q
 D AUDIT^GMRCP Q
 Q
 ;
AUDIT1 ;overwrite last activity
 L +^GMR(123,+GMRCO,40):5 I '$T S GMRCUT=1,GMRCERR=1,GMRCERMS="Activity Trail Not filed - Consult In Use By Another User." L -^GMR(123,+GMRCO,40)  Q
 S DA=$P(^GMR(123,+GMRCO,40,0),"^",3)
 D AUDIT1^GMRCP
 Q
 ;
COMPLETE(GMRCA) ;Determine if the action is a complete action (10,13,14)
 Q $S(GMRCA=13:1,GMRCA=14:1,GMRCA=10:1,1:0)
 ;
EVALACT(GMRCOSTS,GMRCO,GMRCRSLT) ;Evaluate complete action based on prev results and sts
 N EVALA,GMRCLAE
 I '$D(^GMR(123,+GMRCO,50)) Q 10
 I GMRCOSTS'=2 Q 10
 I '$D(^GMR(123,+GMRCO,50,"B",GMRCRSLT)) Q 14
 S EVALA=0,GMRCLAE=+$P($G(^GMR(123,+GMRCO,40,0)),U,3)+1
 F  S GMRCLAE=$O(^GMR(123,+GMRCO,40,GMRCLAE),-1) Q:'GMRCLAE  D  Q:+EVALA
 . S GMRCLAE(40)=^GMR(123,+GMRCO,40,GMRCLAE,0)
 . I $P(GMRCLAE(40),U,9)=GMRCRSLT D
 .. I $P(GMRCLAE(40),U,2)=9 S EVALA=14 Q
 .. I $$COMPLETE($P(GMRCLAE(40),U,2)) S EVALA=13 Q
 I +EVALA Q EVALA
 Q 10
 ;
