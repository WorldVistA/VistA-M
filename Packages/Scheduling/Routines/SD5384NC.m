SD5384NC ;ALB/MLI - Non-count encounter cleanup ; January 13, 1996
 ;;5.3;Scheduling;**84**;AUG 13, 1993
 ;
 ; This routine will update encounters to be non-count for locations
 ; selected.  It was written to correct problems caused when clinics
 ; were changed to non-count after 10/1/96.  It will also delete any
 ; related entries from the Transmitted Outpatient Encounter file.
 ;
 ; To run, call the routine from the top (D ^SD5384NC).  You will be
 ; asked for one or more hospital location entries which are set-up
 ; as non-count.  You will be asked for a date range where you can
 ; select beginning 10/1/96 and ending today's date.  It is STRONGLY
 ; recommended that you select the range where the problem actually
 ; occurred to reduce the amount of processing this routine will
 ; have to do.  For example, if you changed the locations to non-count
 ; on 11/4/96, enter 11/4/96 as your end date.
 ;
EN ; ask questions, queue process
 N DIROUT,DIRUT,DTOUT,DUOUT,RANGE,SDBEG,SDEND,SDLOC
 D GETLOC(.SDLOC) I '$O(SDLOC(0)) G ENQ
 W ! S RANGE=$$GETDTRNG^SCDXUTL1(2961001,$P($$NOW^XLFDT(),".",1)) I RANGE<0 G ENQ
 S SDBEG=$P(RANGE,"^"),SDEND=$P(RANGE,"^",2)
 D QUEUE ; to queue process
 ;D DQ ; for testing
ENQ Q
 ;
 ;
GETLOC(ARRAY) ; get list of location(s)
 S DIC="^SC(",DIC("S")="I $P(^(0),""^"",17)=""Y"""
 S VAUTSTR="clinic",VAUTNI=2,VAUTVB="ARRAY",VAUTNALL=1
 D FIRST^VAUTOMA
 Q
 ;
 ;
QUEUE ; queue job
 N I,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTIO="",ZTDESC="Reset non-count encounters",ZTRTN="DQ^SD5384NC"
 F I="SDLOC(","SDBEG","SDEND" S ZTSAVE(I)=""
 D ^%ZTLOAD
 I $G(ZTSK) W !,"Task queued:  #",ZTSK
 Q
 ;
 ;
DQ ; dequeue point...collect results and generate message.
 N SDCOUNT,SDSTART
 S SDSTART=$$NOW^XLFDT()
 S SDCOUNT=0
 D COLLECT
 D RESULTS
 Q
 ;
 ;
COLLECT ; collect data
 N OK,SDI,SDJ,SDX
 F SDI=SDBEG:0 S SDI=$O(^SCE("B",SDI)) Q:'SDI!(SDI>(SDEND+.9))  D
 . F SDJ=0:0 S SDJ=$O(^SCE("B",SDI,SDJ)) Q:'SDJ  D
 . . ;
 . . S SDX=$G(^SCE(SDJ,0)) I 'SDX Q                     ; no 0 node
 . . S SDLOC=+$P(SDX,"^",4)                             ; location of encounter
 . . I '$D(SDLOC(SDLOC)) Q                              ; not for a selected location
 . . I $P(SDX,"^",6) Q                                  ; child encounter
 . . I $P(SDX,"^",12)=12 Q                              ; not non-count
 . . ;
 . . D FILE("^SCE(",SDJ,".12////12")                    ; file as non-count
 . . D EN^SDCOM(SDJ,0,,.ERROR)                          ; call to update check-out
 . . S OK=$$DELXMIT^SCDXFU03(SDJ,1)                     ; delete trans outpt enc entry
 . . ;
 . . S $P(SDLOC(SDLOC),"^",2)=$P(SDLOC(SDLOC),"^",2)+1  ; increment counter by location
 Q
 ;
 ;
FILE(DIE,DA,DR) ; update entry defined in DA in file DIE with DR string
 N X,Y
 D ^DIE
 Q
 ;
 ;
RESULTS ; generate an e-mail bulletin when done
 N DIFROM,I,LINE,X
 S SDCOUNT=0
 D LINE("The Non-count Encounter cleanup has run to completion."),LINE("")
 D LINE("    Start Time:         "_$$FMTE^XLFDT(SDSTART))
 D LINE("    End Time:           "_$$FMTE^XLFDT($$NOW^XLFDT())),LINE("")
 F I=0:0 S I=$O(SDLOC(I)) Q:'I  D
 . S X=+$P(SDLOC(I),"^",2)
 . I X=1 S LINE="1 entry"
 . I X=0 S LINE="No entries"
 . I X>1 S LINE=X_" entries"
 . S LINE=LINE_" updated to be non-count for "_$P(SDLOC(I),"^",1)_" clinic (IEN #"_I_")"
 . D LINE(LINE)
 S XMSUB="Non-count Encounter Cleanup is Complete",XMN=0
 S XMTEXT="SDTEXT("
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 K SDCOUNT,SDTEXT,XMDUZ,XMN,XMSUB,XMTEXT,XMY
 Q
 ;
 ;
LINE(TEXT) ; add text to mail message
 S SDCOUNT=SDCOUNT+1,SDTEXT(SDCOUNT)=TEXT
 Q
