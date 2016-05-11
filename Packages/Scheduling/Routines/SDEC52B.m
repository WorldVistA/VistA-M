SDEC52B ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
RECAPGET(SDECY) ; GET entries from the RECALL REMINDERS APPT TYPE file 403.51
 ;RECAPGET(SDECY)  external parameter tag is in SDEC
 ;INPUT: none
 ;RETURN:
 ; Successful Return:
 ;   Global Array in which each array entry contains Recall Reminders Appt
 ;   type names from the RECALL REMINDERS APPT TYPE file 403.51
 ;    Data is separated by ^:
 ;      1. RECALL REMINDERS APPT TYPE ien
 ;      2. RECALL REMINDERS APPT TYPE name
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 ;
 N NAME,SDECI,SDI
 S SDECI=0
 K ^TMP("SDEC52",$J,"RECAPGET")
 S SDECY="^TMP(""SDEC52"","_$J_",""RECAPGET"")"
 ; data header
 S @SDECY@(SDECI)="T00030RRAPPTYP^T00030RRAPPTYPN"_$C(30)
 S SDI=0 F  S SDI=$O(^SD(403.51,SDI)) Q:SDI'>0  D
 .S NAME=$$GET1^DIQ(403.51,SDI_",",.01)   ; $P($G(^SD(403.51,SDI,0)),U,1)
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=SDI_U_NAME_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
RECPRGET(SDECY,RECINACT,SDECP,MAXREC,LASTSUB) ; GET entries from the RECALL REMINDERS PROVIDERS file 403.54
 ;RECAPGET(SDECY,RECINACT)  external parameter tag is in SDEC
 ;INPUT:
 ; RECINACT - flag to include inactive providers
 ; SDECP    - (optional) Partial name text
 ; MAXREC   - (optional) Max records returned
 ; LASTSUB  - (optional) last subscripts from previous call
 ;RETURN:
 ; Successful Return:
 ;   Global Array in which each array entry contains data from RECALL REMINDERS PROVIDERS file 403.54.
 ;   Data is separated by ^:
 ;     1. IEN - Pointer to RECALL REMINDERS PROVIDERS file
 ;     2. Provider IEN - Pointer to NEW PERSON file
 ;     3. Provider Name - NAME from NEW PERSON file
 ;     4. Team ID - Pointer to RECALL REMINDERS TEAM file 403.55
 ;     5. Team Name - NAME from RECALL REMINDERS TEAM file 403.55
 ;     6. Division ID - Pointer to MEDICAL CENTER DIVISION file 40.8
 ;     7. Division Name - NAME from MEDICAL CENTER DIVISION file 40.8
 ;     8. Direct Phone - Free-Text 7-14 Characters
 ;     9. EXT. - Free-Text 4-20 characters
 ;    10. Status - Valid values are:
 ;                 ACTIVE
 ;                 INACTIVE
 ;    11. Security Key ID - Pointer to SECURITY KEY file 19.1
 ;    12. Security Key Name - NAME from SECURITY KEY file 19.1
 ;    13. LASTSUB - Subscripts from last call
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 ;
 N LSUB,PRVDATA,SDCNT,SDECI,SDI,SDJ,SDK,SDTMP
 S (SDI,SDJ,SDK)=""
 S (SDCNT,SDECI)=0
 K ^TMP("RECDATA",$J)
 S RECINACT=$G(RECINACT)
 I RECINACT="" S RECINACT=0
 K ^TMP("SDEC52",$J,"RECPRGET")
 S SDECY="^TMP(""SDEC52"","_$J_",""RECPRGET"")"
 ; data header
 S SDTMP="T00030RRPROVIEN^T00030PROVIEN^T00030PROVNAME^T00030TEAMID^T00030TEAMNAME^T00030DIVIEN"
 S SDTMP=SDTMP_"^T00030DIVNAME^T00030PTELEPHONE^T00020EXT^T00010RRPSTATUS^T00020KEYIEN^T00030KEYNAME"
 S SDTMP=SDTMP_"^T00030LASTSUB"
 S @SDECY@(SDECI)=SDTMP_$C(30)
 S SDECP=$G(SDECP)
 S MAXREC=$G(MAXREC,200) S:MAXREC="" MAXREC=200
 S LASTSUB=$G(LASTSUB)
 I SDECP'="" D
 .S SDK=$S($P(LASTSUB,"|",1)'="":$$GETSUB^SDECU($P(LASTSUB,"|",1)),1:$$GETSUB^SDECU(SDECP))
 .F  S SDK=$O(^VA(200,"B",SDK)) Q:SDK=""  Q:SDK'[SDECP  D  Q:SDCNT'<MAXREC
 ..S SDJ=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2)-1,1:0)
 ..F  S SDJ=$O(^VA(200,"B",SDK,SDJ)) Q:SDJ'>0  D  Q:SDCNT'<MAXREC
 ...S SDI=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)
 ...F  S SDI=$O(^SD(403.54,"B",SDJ,SDI)) Q:SDI'>0  D GET1PR(SDI,RECINACT,.SDCNT) Q:SDCNT'<MAXREC
 E  S SDI=0 F  S SDI=$O(^SD(403.54,SDI)) Q:SDI'>0  D GET1PR(SDI,RECINACT,.SDCNT)
 N PRVNAME
 S PRVNAME=""
 F  S PRVNAME=$O(^TMP("RECDATA",$J,PRVNAME)) Q:PRVNAME=""  D
 .S PRVDATA=$G(^TMP("RECDATA",$J,PRVNAME))
 .S SDECI=SDECI+1
 .S @SDECY@(SDECI)=PRVDATA_$C(30)
 .S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 I SDCNT'<MAXREC,SDECP'="",SDK[SDECP D
 .S SDTMP=$P(@SDECY@(SDECI),$C(30,31),1)
 .S $P(SDTMP,U,13)=SDK_"|"_SDJ_"|"_SDI
 .S @SDECY@(SDECI)=SDTMP_$C(30,31)
 K ^TMP("RECDATA",$J)
 Q
GET1PR(SDI,RECINACT,SDCNT)  ;
 N SDDATA,SDMSG
 N RRPSTATUS,DIVIEN,DIVNAME,EXT,KEYIEN,KEYNAME,PROVIEN,PROVNAME,TEAMID,TEAMNAME,PTELE
 D GETS^DIQ(403.54,SDI,"**","IE","SDDATA","SDMSG")
 S PROVIEN=SDDATA(403.54,SDI_",",.01,"I")
 S PROVNAME=SDDATA(403.54,SDI_",",.01,"E")
 S TEAMID=SDDATA(403.54,SDI_",",1,"I")
 S TEAMNAME=SDDATA(403.54,SDI_",",1,"E")
 S DIVIEN=SDDATA(403.54,SDI_",",2,"I")
 S DIVNAME=SDDATA(403.54,SDI_",",2,"E")
 S PTELE=SDDATA(403.54,SDI_",",3,"I")
 S EXT=SDDATA(403.54,SDI_",",4,"I")
 S RRPSTATUS=SDDATA(403.54,SDI_",",5,"E")
 S KEYIEN=SDDATA(403.54,SDI_",",6,"I")
 S KEYNAME=SDDATA(403.54,SDI_",",6,"E")
 Q:RRPSTATUS="INACTIVE"&(RECINACT=0)
 S SDCNT=SDCNT+1
 S ^TMP("RECDATA",$J,PROVNAME)=SDI_U_PROVIEN_U_PROVNAME_U_TEAMID_U_TEAMNAME_U_DIVIEN_U_DIVNAME_U_PTELE_U_EXT_U_RRPSTATUS_U_KEYIEN_U_KEYNAME
 Q
