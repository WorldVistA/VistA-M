SDESGETUDDUZ ;ALB/ANU/DJS - VISTA SCHEDULING RPCS GET USER KEYS AND OPTIONS ; Jan 07, 2022@15:
 ;;5.3;Scheduling;**807,809,814,818**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$GETS^DIQ,$$GETS1^DIQ in ICR #2056
 ; Reference to ^%DT in ICR #10003
 ; Reference to $$FIND1^DIC in ICR #2051
 ;
 ; Global References Supported
 ; ----------------- ----------------- ----------
 ; ^TMP($J SACC 2.3.2.5.1
 Q
 ;
GETUSRDTL(SDUSRJSON,SDUSRIEN,SDEAS) ;Called from RPC: SDES GET USER PROFILE
 ; This RPC gets User name, Keys and Scheduling Options for a given User.
 ; Input:
 ; SDCLNJSON - [required] - Successs or Error message
 ; SDDUZ - [required] - The IEN from the NEW PERSON File #200
 ; SDEAS - [optional] - Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
 ;
 N ERRPOP,ERR,ERRMSG,SDECI,SDUSRSREC
 D INIT
 D VALIDATE
 I ERRPOP D BLDJSON Q
 D GETUSRINF
 D BLDJSON
 Q
 ;
INIT ; initialize values needed
 S SDECI=0
 S ERR=""
 S ERRPOP=0,ERRMSG=""
 Q
 ;
VALIDATE ; validate incoming parameters
 I SDUSRIEN="" D ERRLOG^SDESJSON(.SDUSRSREC,127) S ERRPOP=1 Q
 I '$D(^VA(200,SDUSRIEN,0)) D ERRLOG^SDESJSON(.SDUSRSREC,44) S ERRPOP=1 Q
 S SDEAS=$G(SDEAS,"")
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL(SDEAS)
 I +SDEAS=-1 D ERRLOG^SDESJSON(.SDUSRSREC,142) S ERRPOP=1
 Q
 ;
BLDJSON ; Build JSON format
 D ENCODE^SDESJSON(.SDUSRSREC,.SDUSRJSON,.ERR)
 K SDUSRSREC
 Q
 ;
GETUSRINF ; Get User Keys and Scheduling Options
 N SDFIELDS,SDDATA,SDMSG,SDX,SDC,SDOPT,SDKEY,SDDIV,SDDIVIEN,SDSTN,SDDEF
 S SDFIELDS=".01;201"
 D GETS^DIQ(200,SDUSRIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 S SDECI=SDECI+1
 S SDUSRSREC("User","Name")=$G(SDDATA(200,SDUSRIEN_",",.01,"E")) ;User Name
 S SDUSRSREC("User","IEN")=SDUSRIEN
 S SDUSRSREC("User","Station ID")=$$DEFAULTSTATION^SDECDUZ()
 S SDOPT=$G(SDDATA(200,SDUSRIEN_",",201,"E"))
 I (($E(SDOPT,1,2)="SD")!($E(SDOPT,1,2)="SC")) S SDUSRSREC("User","Primary Menu Option")=SDOPT ;Primary Menu Option
 ; Secondary Options Multiple
 S SDX="",SDC=0
 S SDFIELDS="203*"
 K SDDATA,SDMSG
 D GETS^DIQ(200,SDUSRIEN_",",SDFIELDS,"E","SDDATA","SDMSG")
 F  S SDX=$O(SDDATA(200.03,SDX)) Q:SDX=""  D
 . S SDOPT=$G(SDDATA(200.03,SDX,.01,"E"))
 . I (($E(SDOPT,1,2)="SD")!($E(SDOPT,1,2)="SC")) S SDC=SDC+1 S SDUSRSREC("User","Secondary Menu",SDC,"Option")=SDOPT
 ; Security Keys Multiple
 S SDX="",SDC=0
 S SDFIELDS="51*"
 K SDDATA,SDMSG
 D GETS^DIQ(200,SDUSRIEN_",",SDFIELDS,"E","SDDATA","SDMSG")
 F  S SDX=$O(SDDATA(200.051,SDX)) Q:SDX=""  D
 . S SDKEY=$G(SDDATA(200.051,SDX,.01,"E"))
 . I (($E(SDKEY,1,2)="SD")!($E(SDKEY,1,2)="SC")) S SDC=SDC+1 S SDUSRSREC("User","Security Key",SDC,"Name")=SDKEY
 ; Divisions Multiple
 S (SDX,SDSTN,SDDEF)="",SDC=0
 S SDFIELDS="16*"
 K SDDATA,SDMSG
 D GETS^DIQ(200,SDUSRIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 F  S SDX=$O(SDDATA(200.02,SDX)) Q:SDX=""  D
 . S SDDIVIEN=$G(SDDATA(200.02,SDX,.01,"I"))
 . S SDSTN=$$GET1^DIQ(4,SDDIVIEN,99,"I")
 . S SDDIV=$G(SDDATA(200.02,SDX,.01,"E"))
 . S SDDEF=$G(SDDATA(200.02,SDX,1,"I"))
 . S SDDEF=$S(SDDEF=1:"YES",1:"")
 . S SDC=SDC+1
 . S SDUSRSREC("User","Division",SDC,"Division")=SDSTN
 . S SDUSRSREC("User","Division",SDC,"IEN")=SDDIVIEN
 . S SDUSRSREC("User","Division",SDC,"Name")=SDDIV
 . S SDUSRSREC("User","Division",SDC,"Default")=SDDEF
 I SDC=0 D
 . I $G(DUZ(2))'="" D
 . . S SDC=SDC+1
 . . S SDUSRSREC("User","Division",SDC,"Division")=$G(DUZ(2))
 . . S SDUSRSREC("User","Division",SDC,"IEN")=$G(DUZ(2))
 . . S SDUSRSREC("User","Division",SDC,"Name")=$$GET1^DIQ(4,$G(DUZ(2)),.01,"E")
 . . S SDUSRSREC("User","Division",SDC,"Default")=""
 I '$D(SDUSRSREC("User")) S SDUSRSREC("User")=""
 Q
