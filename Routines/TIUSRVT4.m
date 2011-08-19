TIUSRVT4 ; SLC/PKS Remove all terminated user Templates. ; [3/15/01 12:15pm]
 ;;1.0;TEXT INTEGRATION UTILITIES;**110**;Jun 20, 1997
 ;
 ; Variables used herein:
 ;
 ;     TIUANS  = Result of call to $$VERIF.
 ;     TIUARY  = Array holder.
 ;     TIUCNT  = Counter Variable.
 ;     TIUERR  = Error array for call return.
 ;     TIUIDX  = X-ref holder.
 ;     TIUIEN  = Template IEN holder.
 ;     TIUNOW  = Current date.
 ;     TIUNUM  = Loop counter.
 ;     TIUSR   = Terminated user (DUZ).
 ;     TIUSTAT = Status of user.
 ;     TIUTMP  = Call return array value holder.
 ;     TIUTPLT = Template IEN.
 ;            
 Q
 ;
CTRL ; Main control section.
 ;
 N TIUANS,TIUCNT,TIUERR,TIUIDX,TIUNOW,TIUSR,TIUSTAT,TIUTPLT
 ;
 S TIUANS=$$VERIF ; Confirm before deleting.
 I 'TIUANS Q      ; User failed to confirm - quit.
 ;
 D EACH ; Call to process template cleanup.
 ;
 Q
 ;
EACH ; Process template deletion for each user found who has any.
 ;
 ; Get current date information:
 D NOW^%DTC
 S TIUNOW=X
 K X
 ;
 ; Retrieve each user in ^TIU(8927 file:
 S TIUSR=0
 F  D  Q:'TIUSR
 .S TIUSR=$O(^TIU(8927,"AROOT",TIUSR))
 .I 'TIUSR Q
 .;
 .; Check user's status - look for terminated users:
 .I '$D(^VA(200,TIUSR,0)) Q        ; No user record.
 .I '$L($P($G(^VA(200,TIUSR,0)),"^",1)) Q  ; Invalid user data.
 .S TIUSTAT=$$GET1^DIQ(200,TIUSR,9.2,"I",,.TIUERR) ; Termination date?
 .I 'TIUSTAT Q                     ; Active user.
 .I TIUSTAT>TIUNOW Q               ; User terminated on a future date.
 .;
 .; User terminated, effective today or earlier, so proceed:
 .; Find AROOT x-ref record, if any:
 .S TIUTPLT=0
 .F  D  Q:'TIUTPLT
 ..S TIUTPLT=$O(^TIU(8927,"AROOT",TIUSR,TIUTPLT))
 ..I 'TIUTPLT Q
 ..;
 ..; Get any existing templates, delete them:
 ..D DEL(TIUTPLT)
 ;
 Q
 ;
DEL(TIUIEN) ; Pass root node of AROOT x-ref.
 ;
 N TIUARY,TIUNUM,TIUTMP
 ;
 D BLD(TIUIEN,.TIUARY)             ; Recursive call.
 ;
 D DELETE^TIUSRVT(.TIUTMP,.TIUARY) ; Kill record(s).
 ;
 Q
 ;
BLD(TIUIEN,TIUARY) ; Build array of templates for user.
 ;
 N TIUIDX
 ;
 S TIUIDX=$O(TIUARY(" "),-1)+1
 S TIUARY(TIUIDX)=TIUIEN
 S TIUIDX=0
 F  S TIUIDX=$O(^TIU(8927,TIUIEN,10,TIUIDX))  Q:'TIUIDX  D
 .D BLD($P(^TIU(8927,TIUIEN,10,TIUIDX,0),U,2),.TIUARY)
 ;
 Q
 ;
PARSET ; Edit parameter for auto-cleanup of templates upon termination.
 ;
 D EDITPAR^XPAREDIT("TIU TEMPLATE USER AUTO DELETE")
 ;
 Q
 ;
VERIF() ; Verify that user really wants to execute this option:
 ;
 N DIR,X,Y       ; DIR variables.
 S DIR("T")=120  ; Two minute maximum timeout for response.
 S DIR("A")="   Delete all non-shared templates for all terminated users (Y/N)"
 S DIR("?")="   Templates for terminated users will be permanently lost..."
 S DIR("B")="NO" ; Default. 
 ;
 ; Define DIR input requirements:
 S DIR(0)="YO^1:2:0"
 ;
 ; Call DIR for user choice:
 W !! ; Spacing for screen display.
 D ^DIR
 ;
 ; Check user response:
 I '$L($G(Y)) Q 0                      ; Skip if Y isn't assigned.
 I Y="" Q 0                            ; Skip if Y is null.
 I Y="^" Q 0                           ; Skip if Y is "^" character.
 I Y<1 Q 0                             ; Skip if Y is less than one.
 I Y>2 Q 0                             ; "No" choice.
 I Y=1 Q 1                             ; "Yes" choice.
 ;
 Q 0                                   ; Default return of "No."
 ;
