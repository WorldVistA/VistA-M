SDEC796P ;ALB/LAB - SD*5.3*796 Post Init Routine ; Sep 2, 2021@17:30
 ;;5.3;SCHEDULING;**796**;AUG 13, 1993;Build 2
 ;
 D FIND
 D JOBUPDATE
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 W !!?3,"Updating SDEC SETTINGS file (#409.98)",!!
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
 ;
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.12
 S DA=SDECDA,DIE=409.98,DR="2///1.7.12;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.12;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 W !!?3,"VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)"
 Q
 ;
JOBUPDATE ;
 ; This subroutine will loop through existing entries in the SDEC APPT REQUEST
 ; (#409.85) file.
 ;
 D MSG("SD*5.3*796 Post-Install to fix CID/PREFERRED DATE")
 D MSG("in the SDEC APPT REQUEST (#409.85) file and clear")
 D MSG("incomplete user preferences is being jobbed off")
 D MSG("to run as a remote process.")
 D MSG("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="UPDATE^SDEC796P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MSG(">>>Task "_ZTSK_" has been queued.")
 . D MSG("")
 I '$D(ZTSK) D
 . D MSG("UNABLE TO QUEUE THIS JOB.")
 . D MSG("Please contact the National Help Desk to report this issue.")
 Q
 ;
END ;
 D ^%ZISC
 Q
 ;
MSG(SDMES) ;
 D BMES^XPDUTL(SDMES)
 Q
 ;
UPDATE ;call values to update
 D UPDATEPID ;VSE-1375
 D CLEAR ;VSE-1437
 D RECPROV ;VSE-1306
 Q
 ;
UPDATEPID ;Updating any CID/PID that has a day of 00 or a null
 N SDIEN,SDCID,SDFDA,SDCRTDT
 S SDIEN=0
 F  S SDIEN=$O(^SDEC(409.85,SDIEN)) Q:'(+SDIEN)  D
 . S SDCID=$$GET1^DIQ(409.85,SDIEN_",",22,"I")
 . S SDCRTDT=$$GET1^DIQ(409.85,SDIEN_",",1,"I")
 . I '(+$E(SDCID,6,7)) D
 . . S SDFDA(409.85,SDIEN_",",22)=SDCRTDT
 . . D FILE^DIE(,"SDFDA","ERR")
 Q
 ;
CLEAR ;Clear user preferences if they do not include the latest columns 
 ;Need to clear user preferences for SDEC to allow for user preference names to be sent in
 N SDPARID,ENT,VAL,ERR,UPDATA,UPERR,RET,SDUSER
 S SDPARID=0
 ;loop through all parameters to find those users with User Preferences set.
 F  S SDPARID=$O(^XTV(8989.5,SDPARID)) Q:(SDPARID="")!(SDPARID'=+SDPARID)  D
 . K UPDATA,UPERR
 . D GETS^DIQ(8989.5,SDPARID,"**","I","UPDATA","UPERR")
 . I UPDATA(8989.5,SDPARID_",",1,"I")="SET USER PREFERENCES" D
 . . S SDUSER=$P($P(^XTV(8989.5,SDPARID,0),U,1),";",1)
 . . S ENT=UPDATA(8989.5,SDPARID_",",.01,"I") ;entity
 . . S VAL="SET USER PREFERENCES"
 . . S VAL("X")="SET USER PREFERENCES"
 . . S ERR=0
 . . D GETRMGUP^SDECRMGP(.RET,SDUSER) Q:RET="-1: NO USER PREFERENCE SET"
 . . ;if covid priority, contact phone, or contact letter column is mssing, clear out user preference
 . . I '$FIND(RET,"COVID PRIORITY")!'$FIND(RET,"CA LETTER")!'$FIND(RET,"CA PHONE") D
 . . . D EN^XPAR(ENT,"SDEC REQ MGR GRID FILTER",1,.VAL,.ERR)
 Q
 ;
RECPROV ;
 ; Cleanup existing RECALL APPOINTMENTS with incorrect Providers
 ; Determine install date of SD*5.3*785
 N DA,DIE,DR,SDIEN,SD785ID,SDDATA0,SDDATA2,SDPRVIEN,SDPRV40354E,SDPRV40354I,SDPRV200E,SDORIGPRVE
 S (SDIEN,SD785ID)=""
 S SDIEN=$O(^XPD(9.7,"B","SD*5.3*785",SDIEN),-1)
 I SDIEN S SD785ID=$$GET1^DIQ(9.7,SDIEN_",",17,"I"),SD785ID=$P(SD785ID,".",1)
 I SD785ID="" S SD785ID=DT
 ; Loop through Appts don't process appts created after 785 install
 S SDIEN=0
 F  S SDIEN=$O(^SDEC(409.84,SDIEN)) Q:'SDIEN  D
 . S SDDATA2=$G(^SDEC(409.84,SDIEN,2))
 . ; Quit if not a Recall
 . Q:$P($P(SDDATA2,U,1),";",2)'="SD(403.5,"
 . S SDDATA0=$G(^SDEC(409.84,SDIEN,0))
 . ; Quit it Appt created after 785 install
 . Q:$P(SDDATA0,U,9)>SD785ID
 . ; Quit if Provider not defined on record in #409.84
 . S SDPRVIEN=$P(SDDATA0,U,16)
 . Q:'SDPRVIEN
 . ; Quit if Provider not defined in #200
 . Q:'$D(^VA(200,SDPRVIEN,0))
 . S SDORIGPRVE=$P($G(^VA(200,SDPRVIEN,0)),U,1)
 . ; Using SDPRVIEN which is an erroneous data pointer load corresponding entry in #403.54
 . S SDPRV40354E=$$GET1^DIQ(403.54,SDPRVIEN,.01,"E")
 . ; Quit if no entry found in #403.54
 . Q:SDPRV40354E=""
 . ; Get the Provider pointer value to #200
 . S SDPRV40354I=$P($G(^SD(403.54,SDPRVIEN,0)),U,1)
 . ; Use the pointer value from 403.54 to get Provider from #200
 . I SDPRV40354I S SDPRV200E=$$GET1^DIQ(200,SDPRV40354I,.01,"E")
 . ; Quit if Provider names from #403.54 & #200 don't match
 . Q:SDPRV40354E'=SDPRV200E
 . ; Quit if the Provider name from #403.54 equals Provider name from #409.84
 . Q:SDPRV40354E=SDORIGPRVE
 . ; Update the Provider in #409.84
 . S SDFDA(409.84,SDIEN_",",.16)=SDPRV40354I
 . D FILE^DIE(,"SDFDA","ERR")
 Q
