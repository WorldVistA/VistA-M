TIUSRVT3 ; SLC/PKS Remove a user's non-shared Templates. ; [6/26/01 9:17am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**110**;Jun 20, 1997
 ;
 ; Variables used herein:
 ;
 ;    DIR     = FM call varible.
 ;    TIUARY  = Array holder.
 ;    TIUCNT  = Returned array counter.
 ;    TIUGET  = Holder for returned array $O command.
 ;    TIUIDX  = X-ref holder.
 ;    TIUIEN  = Template IEN holder.
 ;    TIUNM   = Holder variable for name of user.
 ;    TIUNUM  = Loop counter from this routine.
 ;    TIUPAR  = Current setting of auto-cleanup parameter.  
 ;    TIURARY = Returned array; zero node will contain user's DUZ and
 ;              AROOT IEN (if any) or error message (RPC use only).
 ;    TIUSR   = DUZ of user to process.
 ;    TIUTMP  = Call return array values holder.
 ;    TIUTPLT = Template IEN.
 ;    X,Y     = Variables for FM call.
 ;            
 Q
 ;
SELUSR ; Call here for manual selection of TIUSR from NEW PERSON file.
 ;
 N DIR,TIUCNT,TIUGET,TIUIDX,TIUNM,TIUNUM,TIUTPLT,TIURARY,TIUSR,X,Y
 ;
 ; Get input for user:
 S TIUSR=""          ; Default.
 S DIR(0)="PAO^200,:AEMNQ"
 S DIR("A")="  Enter/select user for whom templates will be deleted: "
 S DIR("?")="Specify user for template cleanup."
 D ^DIR
 S TIUSR=Y
 K DIR,X,Y                             ; Clean up from FM call.
 I TIUSR<1 S TIUSR="" Q                ; No acceptable entry.
 S TIUSR=+TIUSR                        ; Selected user's DUZ.
 I TIUSR="" Q        ; Punt here if there's a problem.
 ;
 ; Confirm before deletion:
 S TIUNM=$P($G(^VA(200,TIUSR,0)),U,1)
 S DIR("T")=120  ; Two minute maximum timeout for response.
 S DIR("A")="   Delete all non-shared templates for user "_TIUNM_" (Y/N)"
 S DIR("?")="   Non-shared templates for this user will be permanently lost..."
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
 I '$L($G(Y)) Q                        ; Skip if Y isn't assigned.
 I Y="" Q                              ; Skip if Y is null.
 I Y="^" Q                             ; Skip if Y is "^" character.
 I Y<1 Q                               ; Skip if Y is less than one.
 I Y>2 Q                               ; "No" choice.
 K DIR,X,Y                             ; Clean up from FM call.
 ;
 ; Proceed with clean up:
 D CTRL
 K TIURARY           ; Array not returned under manual functionality.
 ;
 Q
 ;
KUSER ; Get USER from Kernel - called by option: TIU TEMPLATE USER DELETE.
 ;
 ; See if this function is "active" by checking Parameter:
 ;
 N TIUCNT,TIUGET,TIUIDX,TIUNUM,TIUTPLT,TIUPAR,TIURARY,TIUSR
 S TIUPAR=$$GET^XPAR("DIV^SYS^PKG","TIU TEMPLATE USER AUTO DELETE",1,"E")
 I TIUPAR'="YES" Q
 I TIUPAR="" Q
 ;
 ; Parameter set to activate auto-cleanup - proceed:
 S TIUSR=$GET(XUIFN) ; Assign TIUSR variable.
 I TIUSR="" Q        ; Punt here if there's a problem.
 D CTRL
 K TIURARY           ; Array not returned when triggered by Kernel.
 ;
 Q
 ;
CLEAN(TIUSR,TIURARY) ; Call here as an RPC: Dump templates for one user.
 ;
 N TIUCNT,TIUGET,TIUIDX,TIUNUM,TIUTPLT
 I 'TIUSR>0 S TIURARY(0)="No user DUZ passed." Q
 ;
CTRL ; Main control code for actual cleanup process.
 ;
 S TIUCNT=0
 ;
 ; See if there is an AROOT x-ref entry for this user:
 I '$D(^TIU(8927,"AROOT",TIUSR)) S TIURARY(0)="No AROOT record." Q
 ;
 ; Get parent record for user's templates:
 S TIUTPLT=0
 F  D  Q:'TIUTPLT
 .S TIUTPLT=$O(^TIU(8927,"AROOT",TIUSR,TIUTPLT))
 .I 'TIUTPLT Q
 .;
 .; Compile an array of applicable templates:
 .D DEL(TIUTPLT)
 ;
 Q
 ;
DEL(TIUIEN) ; Pass root node of AROOT x-ref of <^TIU(8927,> file.
 ;
 N TIUARY,TIUTMP
 ;
 S TIURARY(TIUCNT)=TIUSR_U_TIUIEN ; 0-node: "UserDUZ^ARootIEN" format.
 D BLD(TIUIEN,.TIUARY)            ; Recursive array builder.
 ;
 ; Create or add to return array:
 S (TIUGET,TIUNUM)=0
 F  D  Q:'TIUGET
 .S TIUNUM=TIUNUM+1
 .S TIUGET=$G(TIUARY(TIUNUM))
 .I 'TIUGET Q
 .S TIUCNT=TIUCNT+1
 .S TIURARY(TIUCNT)=TIUGET
 ;
 ; Using the array of templates, make call that kills only orphans:
 D DELETE^TIUSRVT(.TIUTMP,.TIUARY)
 ;
 Q
 ;
BLD(TIUIEN,TIUARY) ; Recursively build an array of templates.
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
