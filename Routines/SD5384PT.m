SD5384PT ;ALB/MLI - clean-up routine to remove credit stop code encounters ; 12 Dec 96 @ 10:02
 ;;5.3;Scheduling;**84**;AUG 13, 1993
 ;
 ; This routine will loop through the Outpatient Encounter file for a date range and
 ; look for credit stop codes which are:
 ; 
 ;    a.  associated with location where the stop code is the same as the
 ;        credit stop code.
 ;
 ;    b.  associated with a non-count clinic.
 ;
 ; Credit stop code encounters (originating process = 4) found which meet one of
 ; the above criteria will be deleted.
 ;
 ; The variables SDBEGDT and SDENDDT can be set prior to calling EN if a date range
 ; other than 10/1/96 through the present is desired.  The process will be queued
 ; and a mail message of findings will be sent.
 ;
 ; If SDNODEL is defined, no data will be deleted.
 ;
 ;
EN ; process task
 N SDCOUNT,SDSTART
 S SDSTART=$$NOW^XLFDT()
 D LOOP ; loop through entries and delete
 D MAIL ; build mail message of results
 Q
 ; 
 ;
LOOP ; loop through encounter file and delete bogus credit stop entries
 ;
 ; Input Variables (all optional):
 ; SDBEGDT  = Beginning date of encounter search (default 2961001)
 ; SDENDDT  = Ending date of encounter search (default DT)
 ; SDCLINIC = array of specific locations to look at (otherwise all)
 ; SDNODEL  = 1 if data should not be deleted during run
 ;   
 ; Variables used:
 ; SDALL    = 1 if all clinics searched...otherwise 0
 ; SDDATE   = loop counter for encounter date                        
 ; SDENC    = loop counter for IEN of outpt encounter file
 ; SDNODE   = 0 node of ^SCE
 ; SDCRED   = credit stop code pointer
 ; SDCOUNT  = counter, subscripted by location IEN, of deleted credit
 ;            stop code encounters
 ;
 N SDALL,SDCRED,SDDATE,SDENC,SDNODE,SDPAR
 S SDBEGDT=$G(SDBEGDT,2961001),SDENDDT=$G(SDENDDT,DT)+.9
 S SDALL='$O(SDCLINIC(0)),SDDATE=SDBEGDT-.1
 F  S SDDATE=$O(^SCE("B",SDDATE)) Q:'SDDATE!(SDDATE>SDENDDT)  D
 .  S SDENC=""
 .  F  S SDENC=$O(^SCE("B",SDDATE,SDENC)) Q:'SDENC  D
 .  .  S SDNODE=$G(^SCE(SDENC,0))
 .  .  I $P(SDNODE,"^",8)'=4 Q                                            ; not a credit stop encounter
 .  .  I 'SDALL D  Q                                                      ; if only select clinics chosen
 .  .  .  I $D(SDCLINIC(+$P(SDNODE,"^",4))) D DEL(SDENC)                  ; delete credit associated with location
 .  .  S SDCRED=$P(SDNODE,"^",3)
 .  .  S SDPAR=$G(^SCE(+$P(SDNODE,"^",6),0))                              ; get parent encounter
 .  .  I $P(SDPAR,"^",12)=12 D DEL(SDENC) Q                               ; delete credit for non-counts
 .  .  I SDCRED=$P(SDPAR,"^",3) D DEL(SDENC) Q                            ; delete if credit stop = stop
LOOPQ Q
 ;
 ;
DEL(IEN) ; delete encounter and increment counter by location
 ;
 ; Input - IEN of Outpatient Encounter file
 ;
 N DA,DIK,LOC
 S LOC=$P($G(^SCE(IEN,0)),"^",4)
 S SDCOUNT(LOC)=$G(SDCOUNT(LOC))+1
 S DIK="^SCE("
 S DA=IEN
 I '$G(SDNODEL) D ^DIK
 Q
 ;
 ;
MAIL ; send bulletin of results
 N DIFROM,SDTEXT
 S SDCOUNT=0
 D LINE("The Credit Stop Code Encounter clean-up has run to completion at "_$P($$SITE^VASITE(),"^",2)_"."),LINE("")
 D LINE("    Start Time:         "_$$FMTE^XLFDT(SDSTART))
 D LINE("    End Time:           "_$$FMTE^XLFDT($$NOW^XLFDT())),LINE("")
 I '$O(SDCLINIC(0)) D
 . D LINE("Credit stop code encounters for all clinics were deleted IF either:")
 . D LINE("    a.  the credit stop code associated with the clinic was equal")
 . D LINE("        to the stop code associated with the clinic.")
 . D LINE("    b.  the clinic was set up as NON-COUNT.")
 . D LINE("")
 . D LINE("The following is a list of clinics for which credit stop code")
 . D LINE("encounters were deleted:")
 . F I=0:0 S I=$O(SDCOUNT(I)) Q:'I  D LINE("   #"_I_" - "_$P($G(^SC(I,0)),"^",1)_"..."_+SDCOUNT(I)_" encounters deleted")
 . I '$O(SDCOUNT(0)) D LINE("   No credit stop code encounters were found meeting the above criteria.")
 E  D
 . D LINE("Credit stop code encounters were deleted for the following")
 . D LINE("Hospital Locations:")
 . F I=0:0 S I=$O(SDCLINIC(I)) Q:'I  D LINE("   #"_I_" - "_$P($G(^SC(I,0)),"^",1)_"..."_+$G(SDCOUNT(I))_" encounters deleted")
 S XMSUB="Credit Stop Code Encounter Clean-up is Complete",XMN=0
 S XMTEXT="SDTEXT("
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 K XMDUZ,XMN,XMSUB,XMTEXT,XMY
 Q
 ;
 ;
LINE(TEXT) ; add text to mail message
 S SDCOUNT=SDCOUNT+1,SDTEXT(SDCOUNT)=TEXT
 Q
 ;
 ;
CLINIC ; entry point if a site wants to delete ALL credit stop encounters associated with one (or more) hospital location(s)
 ;
 ; do not use without consulting customer support or development first...
 ;
 N SDCLINIC
 S VAUTVB="SDCLINIC",VAUTSTR="clinic",VAUTNALL=1,VAUTNI=2
 S DIC="^SC(",DIC("S")="I $P(^(0),U,3)=""C"""
 D FIRST^VAUTOMA
 I Y'<0 W !!,"Queuing credit stop encounter cleanup:" D QUEUE
 D RETRAN
 Q
 ;
 ;
QUEUE ; queue process to run
 N I
 S ZTDESC="Credit stop code encounter clean-up process"
 S ZTIO=""
 F I="SDBEGDT","SDENDDT","SDCLINIC","SDNODEL" S ZTSAVE(I)=""
 S ZTRTN="EN^SD5384PT"
 D ^%ZTLOAD
 I $D(ZTSK) W !,"Task number = ",ZTSK
 K ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
 ;
RETRAN ; flag errors of one type to retransmit
 N DTOUT,DIROUT,DIRUT,DUOUT,ERROR,X,Y,DIR,SDLOOP
 S DIR(0)="P^409.76:AQEMZ"
 D ^DIR
 I Y'>0 Q
 S ERROR=+Y,SDLOOP=0
 F  S SDLOOP=$O(^SD(409.75,SDLOOP)) Q:'SDLOOP  S X=$G(^(SDLOOP,0)) D
 .  I $P(X,"^",2)=ERROR D XMITFLAG^SCDXFU01(+X,0)
 Q
