DG53P951 ;SHRPE/YMG - Post Install for DG patch 951 ;03-May-2018
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; entry point
 N XPDIDTOT,XPDIDVT
 S XPDIDTOT=2,XPDIDVT=0
 D USR(1)          ; 1. create non-human user for PRF interface
 D EN1(2)  ;entry point for HL7 CHECK POST INSTALLATION REPORT
 Q
 ;
USR(DGXPD) ; create non-human user for PRF interface
 N UIEN
 I '$D(ZTQUEUED) D  ;if not background
 .D BMES^XPDUTL(" STEP "_DGXPD_" of "_XPDIDTOT)
 .D MES^XPDUTL("-------------")
 .D MES^XPDUTL("Creating non-human user for PRF interface ... ")
 .Q
 ;
 ; either in taskmode or not
 ; ICR #4677.
 S UIEN=$$CREATE^XUSAP("DGPRF,INTERFACE","")
 I '$D(ZTQUEUED) D
 .I +UIEN=0 D BMES^XPDUTL(" Already exists.")
 .I +UIEN>0 D BMES^XPDUTL(" Successfully added.")
 .I +UIEN<0 D BMES^XPDUTL(" ERROR: user NOT added.")
 .D UPDATE^XPDID(DGXPD)
 .Q
 Q
 ;
 ; This subroutine is the post installation for patch DG*5.3*951
 ; that will generate HL7 CHECK POST INSTALLATION REPORT.
 ;
 ; The generation of report is required as there is a risk about being
 ; out of synchronization when flags are being transferred from one site
 ; to another, however, one of the sites has not installed the patch yet.
 ; This will produce errors in HL7.
 ;
 ;ICR#  TYPE      DESCRIPTION
 ;----- ----      ---------------------
 ;10103 Sup       ^XLFDT: $$FMADD,$$DT,$$HL7TFM
 ;2056  Sup       ^DIQ: $$GET1,GETS
 ;10070 Sup       ^XMD
 ;2171  Sup       ^XUAF4: $$IEN,$$NAME
 ;2172  Sup       UPDATE^XPDID
 ;2701  Sup       $$GETDFN^MPIF001
 ;10000 Sup       NOW^%DTC
 ;10003 Sup       DD^%DT
 ;3099  Sup       $$MSG^HLCSUTL
 ;4669  Private   DG has approval for direct global read of "B" index of FILE #773; Fileman read of field #2
 ;10035 Sup       Fileman read of FILE #2 ;field #.01
 ;2052  Sup       $$GET1^DID
 ;10141 Sup       ^XPDUTL:BMES, MES
 ;10063 Sup       %ZTLOAD
 ;
 ;
EN1(DGXPD) ;Queue the HL7 CHECK POST INSTALLATION REPORT to Taskman
 I $D(ZTQUEUED) D EN3 Q  ;queued to Taskman
 N X,MES,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTREQ,ZTSK,ZTSAVE
 S MES(1)="  "
 S MES(2)=" STEP "_DGXPD_" of "_XPDIDTOT
 S MES(3)="-------------"
 S MES(4)="  "
 S MES(5)="You will now be prompted for Requested Start Time to generate"
 S MES(6)="the HL7 CHECK POST INSTALLATION REPORT"
 S MES(7)="  "
 S MES(8)="If you do not enter a time, then this report will be queued to run NOW."
 S MES(9)="  "
 D MES^XPDUTL(.MES)
 S ZTDESC="DGPF HL7 CHECK POST INSTALLATION REPORT GENERATION"
 S ZTRTN="EN3^DG53P951"
 S ZTIO=""
 D ^%ZTLOAD
 I $D(ZTSK) S X="Queued to Task #"_$G(ZTSK) D BMES^XPDUTL(X)
 I '$D(ZTSK) D
 . K MES
 . S MES(1)="  "
 . S MES(2)="******************************************"
 . S MES(3)="Since you did not enter a time to run the report"
 . S MES(4)="Running Post Installation Report NOW."
 . S MES(5)="  "
 . S MES(6)="Depending upon the size of your database, this report could take"
 . S MES(7)="sometime to run."
 . S MES(8)="  "
 . S MES(9)="There will be no further screen display while running this report."
 . S MES(10)="******************************************"
 . S MES(11)="  "
 . D MES^XPDUTL(.MES)
 . S ZTDESC="DGPF HL7 CHECK POST INSTALLATION REPORT GENERATION"
 . S ZTRTN="EN3^DG53P951"
 . S ZTIO=""
 . S ZTDTH=$H
 . D ^%ZTLOAD
 . S X="Queued to Task #"_$G(ZTSK) D BMES^XPDUTL(X)
 . Q
 D UPDATE^XPDID(DGXPD)
 Q
 ;
EN3 ;
 N DGLIST       ;temp global name used for report list
 N DGSORT       ;array or report parameters
 N ACTNARY      ;array that contain all the PRF ACTIONs
 N LN           ;subscript line
 N DGRCPNT
 N SNDMAIL
 S DGLIST=$NA(^TMP("DG951PST",$J))
 K @DGLIST
 ;
 D BLDARR  ;build PRF ACTION array
 S SNDMAIL=0
 ;beginning and ending date
 S DGSORT("DGBEG")=$$FMADD^XLFDT(DT,-4)
 S DGSORT("DGEND")=$$DT^XLFDT
 D LOOP1(DGLIST)
 D PRINT1(DGLIST)
 D RECPIENT
 D MAIL1
 K @DGLIST
 S ZTREQ="@"
 Q
 ;
BLDARR ;
 ;build PRF ACTION Array
 N I,X,DGERR,Y
 S X=$$GET1^DID(26.14,.03,,"SET OF CODES",,"DGERR")
 Q:$D(DGERR)
 F I=1:1:$L(X,";") S Y=$P(X,";",I) Q:Y=""  S ACTNARY($P(Y,":",2))=""
 Q
 ;
LOOP1(DGLIST) ;
 ;loop variable pointer flag x-ref file to run report
 N DG772,DG773,DGPROCDT,DGMSGTYP,DGREF,DGEVNTYP,DGPTICN
 N DGSTANUM,DGSTNAME,DGACTN,DGPTNAME,DGSSN
 S DGREF=$NA(^TMP("DG53951P1",$J))
 S DG772="" F  S DG772=$O(^HLMA("B",DG772),-1) Q:DG772=""  D
 . S DG773="" F  S DG773=$O(^HLMA("B",DG772,DG773),-1) Q:DG773=""  D
 . . K @DGREF,DGPROCDT,DGMSGTYP,DGEVNTYP,DGPTICN
 . . K DGSTANUM,DGSTNAME,DGACTN,DGPTNAME,DGSSN
 . . Q:$$MSG^HLCSUTL($$GET1^DIQ(773,DG773_",",2,"I"),$NA(@DGREF@(1)))<1
 . . D PARSE(DGREF)
 K @DGREF
 Q
 ;
PARSE(DGREF) ;
 N SUB1,SUB2,DGSGMENT,DGBEHAV,DFN,DGOUT
 S (SUB1,SUB2,DGSGMENT(0))=""
 S DGOUT=0
 F  S SUB1=$O(@DGREF@(SUB1)) Q:SUB1=""!DGOUT  D
 . N DGBEHAV,DFN
 . S DGBEHAV=0
 . F  S SUB2=$O(@DGREF@(SUB1,SUB2)) Q:SUB2=""!DGOUT  D
 . . S DGSGMENT(0)=$P(@DGREF@(SUB1,SUB2),U)
 . . I (",MSH,PID,QRD,OBR,OBX,")[(","_DGSGMENT(0)_",") D @DGSGMENT(0)
 Q
 ;
MSH ;Parse MSH segment
 ;Processing date/time check...
 S DGPROCDT=$$HL7TFM^XLFDT($P($P(@DGREF@(SUB1,SUB2),U,7),"-"))
 I DGPROCDT'>0 S DGOUT=1 Q
 ;check if date is within the date range TODAY-4 and TODAY
 I ($P(DGPROCDT,".")<DGSORT("DGBEG"))!($P(DGPROCDT,".")>DGSORT("DGEND")) S DGOUT=1 Q
 ;extract the message and event type
 S DGMSGTYP=$P($P(@DGREF@(SUB1,SUB2),U,9),"~")
 S DGEVNTYP=$P($P(@DGREF@(SUB1,SUB2),U,9),"~",2)
 I ((DGMSGTYP["ORU")&(DGEVNTYP["R01"))!((DGMSGTYP["ORF")&(DGEVNTYP["R04")) D
 . S DGSTANUM=$P($P(@DGREF@(SUB1,SUB2),U,4),"~")
 . I DGSTANUM'="" S DGSTNAME=$$NAME^XUAF4($$IEN^XUAF4(DGSTANUM))
 E  S DGOUT=1
 Q
 ;
PID ;Parse PID segment
 S DGPTICN=$P($P(@DGREF@(SUB1,SUB2),U,4),"~")
 S DFN=$$GETDFN^MPIF001(DGPTICN)
 Q:+DFN'>0
 S DGPTNAME=$$GET1^DIQ(2,DFN,.01)
 D SSN
 Q
 ;
QRD ;Parse QRD segment
 S DGPTICN=$P($P(@DGREF@(SUB1,SUB2),U,9),"~")
 S DFN=$$GETDFN^MPIF001(DGPTICN)
 Q:+DFN'>0
 S DGPTNAME=$$GET1^DIQ(2,DFN,.01)
 D SSN
 Q
 ;
OBR ;Parse OBR segment
 ;only check "BEHAVIORAL"
 I $P($P(@DGREF@(SUB1,SUB2),U,5),"~",2)="BEHAVIORAL" S DGBEHAV=1
 Q
 ;
OBX ;Parse OBX segment
 ;check the OBX segment if it contains the new DBRS DATA
 Q:DGBEHAV<1
 I $P(@DGREF@(SUB1,SUB2),U,3)="ST" S DGACTN=$P(@DGREF@(SUB1,SUB2),U,6)
 I $G(DGACTN)'="",$D(ACTNARY($G(DGACTN))),$P($P(@DGREF@(SUB1,SUB2),U,4),"~")="D" D BLDLST1(DGLIST)
 Q
 ;
SSN ;extract patient's SSN4
 D GETS^DIQ(2,DFN_",",.0905,"ER","DGSSN")
 S DGSSN=DGSSN(2,DFN_",","1U4N","E")
 Q
 ;
BLDLST1(DGLIST) ;
 ;Build the list to be printed later
 I DGPTNAME=""!DGSTANUM="" Q
 S @DGLIST@(DGPTNAME,DGSTANUM)=DGSSN_U_DGPTICN_U_DGSTANUM_U_DGSTNAME_U_DG772_U_DG773
 Q
 ;
PRINT1(DGLIST) ;
 ;
 N DDASH,DGSITE,DGPTNAME,DGCNT
 S DDASH="",$P(DDASH,"-",81)=""
 I $O(@DGLIST@(""))="" D  Q
 . S @DGLIST@(1,0)="  "
 . S @DGLIST@(2,0)=">>> No incoming ""BEHAVIORAL"" PRF HL7 transaction messages found"
 . S @DGLIST@(3,0)="    for the last 4 days "
 . S @DGLIST@(4,0)="  "
 . S @DGLIST@(5,0)="    NO REPORT GENERATED"
 S (DGSITE,DGPTNAME)="",DGCNT=0
 F  S DGPTNAME=$O(@DGLIST@(DGPTNAME)) Q:DGPTNAME=""  D
 . N DGDATA,TEXT
 . D:'DGCNT HEAD1(DGLIST)
 . F  S DGSITE=$O(@DGLIST@(DGPTNAME,DGSITE)) Q:DGSITE=""  D
 . . S DGDATA=@DGLIST@(DGPTNAME,DGSITE)
 . . S TEXT=DGSITE_"/"_$E($P(DGDATA,U,4),1,25)
 . . S TEXT=$$BLDSTR(DGSITE_"/"_$E($P(DGDATA,U,4),1,25),TEXT,1,30)
 . . S TEXT=$$BLDSTR($E(DGPTNAME,1,20),TEXT,33,20)
 . . S TEXT=$$BLDSTR($P(DGDATA,U,2),TEXT,55,17)
 . . S TEXT=$$BLDSTR($P(DGDATA,U),TEXT,75,5)
 . . S LN=LN+1
 . . S @DGLIST@(LN,0)=TEXT
 Q
 ;
HEAD1(DGLIST) ;
 ;Display user instruction
 N DDASH,TEXT
 S LN=1
 S @DGLIST@(LN,0)=""
 S DDASH="",$P(DDASH,"=",80)=""
 S LN=LN+1
 S @DGLIST@(LN,0)="The list of PRF BEHAVIORAL flags that will be reported to the help desk"
 S LN=LN+1
 S @DGLIST@(LN,0)="are contained below."
 S LN=LN+1
 S @DGLIST@(LN,0)="These flags need to be re-sent after the DG*5.3*951 compliance date by"
 S LN=LN+1
 S @DGLIST@(LN,0)="using the REFRESH option for the sites and patients listed below:"
 S LN=LN+1
 S @DGLIST@(LN,0)=""
 S TEXT="SENDING SITE#/NAME"
 S TEXT=$$BLDSTR("SENDING SITE#/NAME",TEXT,1,30)
 S TEXT=$$BLDSTR("PATIENT NAME",TEXT,33,20)
 S TEXT=$$BLDSTR("ICN #",TEXT,55,17)
 S TEXT=$$BLDSTR("SSN4",TEXT,75,5)
 S LN=LN+1
 S @DGLIST@(LN,0)=TEXT
 S LN=LN+1
 S @DGLIST@(LN,0)=DDASH
 S LN=LN+1
 S @DGLIST@(LN,0)=""
 S DGCNT=1
 Q
 ;
BLDSTR(NSTR,STR,COL,NSL) ;build a string
 Q $E(STR_$J("",COL-1),1,COL-1)_$E(NSTR_$J("",NSL),1,NSL)_$E(STR,COL+NSL,999)
 ;
RECPIENT ;
 ;mail recipient
 S DGRCPNT(1)="G.DGPF BEHAVIORAL FLAG REVIEW"
 S DGRCPNT(2)="G.IRM"
 Q
 ;
MAIL1 ;Send mailman message to user with results
 ;
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 S (XMDUZ,XMSUB)="HL7 CHECK POST-INSTALL REPORT"
 S XMTEXT="^TMP(""DG951PST"",$J,"
 S (XMY(DUZ),XMY(.5))=""
 S DGRCPNT="" F  S DGRCPNT=$O(DGRCPNT(DGRCPNT)) Q:DGRCPNT=""  S XMY(DGRCPNT(DGRCPNT))=""
 D NOW^%DTC S Y=% D DD^%DT
 D ^XMD
 S SNDMAIL=1
 Q
 ;
 ; This subroutine is the post installation for patch DG*5.3*951
 ; that will generate IOC SITE DBRS PATIENTS POST-RELEASE REPORT
 ;
 ; The "IOC SITE DBRS PATIENTS POST-RELEASE REPORT" will be developed to determine patients
 ; in the IOC site that meet the following criteria:
 ;  - have DBRS numbers in their behavioral flag in database by the end 
 ;    of National Release period,
 ;  - are registered in other sites 
 ; HL7 messages for these patients need to be re-sent to other site to
 ; ensure synchronization of DBRS data
 ;
 ; ICR# TYPE      DESCRIPTION
 ;----- ----      ---------------------
 ;10112 Sup       $$SITE^VASITE
 ;2056  Sup       ^DIQ: $$GET1,GETS
 ;10070 Sup       ^XMD
 ;10000 Sup       NOW^%DTC
 ;10003 Sup       DD^%DT
 ;2171  Sup       ^XUAF4: $$STA
 ;2990  Sup       TFL^VAFCTFU1
 ;
EN2 ;
 ;entry point for IOC SITE DBRS PATIENTS POST-RELEASE REPORT
 N DGLIST       ;temp global name used for report list
 N LN           ;subscript line
 N SNDMAIL
 N DGRCPNT
 S DGLIST=$NA(^TMP("DG53951P2",$J))
 K @DGLIST
 W @IOF
 W !,"DG*5.3*951 IOC SITE DBRS PATIENTS POST-RELEASE REPORT",!
 ;
 ;user description message
 D MSG2
 W !
 S SNDMAIL=0
 D LOOP2(DGLIST)
 D PRINT2(DGLIST)
 Q:$O(@DGLIST@(""))=""
 D RECPIENT
 D MAIL2
 K @DGLIST
 I $G(SNDMAIL) D
 . W !!,"SUCCESSFULLY SENT EMAIL   : IOC SITE DBRS PATIENTS POST-RELEASE REPORT",!!
 . W "To the following recipient:",!
 . W ?3,"POSTMASTER"
 . S DGRCPNT="" F  S DGRCPNT=$O(DGRCPNT(DGRCPNT)) Q:DGRCPNT=""  W !,?3,$G(DGRCPNT(DGRCPNT))
 W !!
 Q
 ;
MSG2 ;
 W !,"This post install routine will check all patients with DBRS data in the local"
 W !,"PRF ASSIGNMENT FILE (#26.13) and verify if patients are registered in other VA"
 W !,"sites."
 ;
 W !!,"HL7 transaction messages for these patients need to be re-sent to other site to"
 W !,"ensure synchronization of DBRS data.",!
 Q
 ;
LOOP2(DGLIST) ;
 ;loop variable pointer flag x-ref file to run report
 N DGDFN,DGIEN,DGINST,DGOWN,IOC
 I '$D(ZTQUEUED) S IOC=0 W "Working..."
 S DGDFN="" F  S DGDFN=$O(^DGPF(26.13,"B",DGDFN)) Q:DGDFN=""  D
 . S IOC=IOC+1
 . I '$D(ZTQUEUED),'(IOC#15) W "."
 . s DGIEN="" F  S DGIEN=$O(^DGPF(26.13,"B",DGDFN,DGIEN)) Q:DGIEN=""  D
 . . N DGFLDS,DGERR,DGRESULT,DGSITE,DGPTNAME,DGSSN4,DGOWN,DGCURNT
 . . D GETS^DIQ(26.13,DGIEN_",","**","IE","DGFLDS","DGERR")
 . . Q:$D(DGERR)
 . . ;check if BEHAVIORAL and contain DBRS data
 . . ;if true, check if patient is registered to other VA site
 . . I DGFLDS(26.13,DGIEN_",",.02,"E")="BEHAVIORAL",$D(DGFLDS(26.131)) D TFL^VAFCTFU1(.DGRESULT,DGDFN)
 . . Q:'$D(DGRESULT)
 . . Q:DGRESULT(1)'>0
 . . S DGPTNAME=DGFLDS(26.13,DGIEN_",",.01,"E") ;patient name
 . . ;extract the patient SSN terminal digits
 . . D GETS^DIQ(2,DGDFN_",",.0905,"ER","DGSSN4")
 . . S DGSSN4=DGSSN4(2,DGDFN_",","1U4N","E")
 . . ;PRF owned by this site?
 . . S DGSITE=DGFLDS(26.13,DGIEN_",",.04,"I")
 . . S DGOWN=$S($G(DGSITE)=$P($$SITE^VASITE,U):1,1:0)
 . . S DGCURNT=$$STA^XUAF4(DGSITE)
 . . D BLDLST2(DGLIST)
 Q
 ;
BLDLST2(DGLIST) ;
 ;build list
  S @DGLIST@(DGSITE,DGIEN,DGPTNAME)=DGSSN4_U_$S(DGOWN:"YES",1:"NO")_U_DGCURNT
  Q
  ;
PRINT2(DGLIST) ;
 ;print the list
 N DDASH,DGIEN,DGSITE,DGPTNAME,DGCNT
 S DDASH="",$P(DDASH,"-",81)=""
 I $O(@DGLIST@(""))="" D  Q
 . W !!," >>> No IOC SITE DBRS PATIENTS record have been found."
 . W !!,"     NO EMAIL GENERATED.",!
 S (DGSITE,DGPTNAME,DGIEN)="",DGCNT=0
 F  S DGSITE=$O(@DGLIST@(DGSITE)) Q:DGSITE=""  D
 . N DGDATA,TEXT
 . D:'DGCNT HEAD2(DGLIST)
 . F  S DGIEN=$O(@DGLIST@(DGSITE,DGIEN)) Q:DGIEN=""  D
 . . F  S DGPTNAME=$O(@DGLIST@(DGSITE,DGIEN,DGPTNAME)) Q:DGPTNAME=""  D
 . . . S DGDATA=@DGLIST@(DGSITE,DGIEN,DGPTNAME)
 . . . S TEXT=$E(DGPTNAME,1,30)
 . . . S TEXT=$$BLDSTR($E(DGPTNAME,1,30),TEXT,1,25)
 . . . S TEXT=$$BLDSTR($P(DGDATA,U),TEXT,28,5)
 . . . S TEXT=$$BLDSTR($P(DGDATA,U,2),TEXT,37,24)
 . . . S TEXT=$$BLDSTR($P(DGDATA,U,3),TEXT,62,18)
 . . . S LN=LN+1
 . . . S @DGLIST@(LN,0)=TEXT
 Q
 ;
HEAD2(DGLIST) ;
 ;Display user instruction
 N DDASH,TEXT
 S LN=1
 S @DGLIST@(LN,0)=""
 S DDASH="",$P(DDASH,"=",80)=""
 S LN=LN+1
 S @DGLIST@(LN,0)="The list of IOC SITE DBRS PATIENTS whose HL7 transaction messages needs to be"
 S LN=LN+1
 S @DGLIST@(LN,0)="re-sent using the REFRESH option to other site to ensure synchronization"
 S LN=LN+1
 S @DGLIST@(LN,0)="of DBRS data are listed below:"
 S LN=LN+1
 S @DGLIST@(LN,0)=""
 S TEXT="PATIENT NAME"
 S TEXT=$$BLDSTR("PATIENT NAME",TEXT,1,25)
 S TEXT=$$BLDSTR("SSN4",TEXT,28,5)
 S TEXT=$$BLDSTR("PRF OWNED BY THIS SITE?",TEXT,37,23)
 S TEXT=$$BLDSTR("CURRENT SITE OWNER",TEXT,62,18)
 S LN=LN+1
 S @DGLIST@(LN,0)=TEXT
 S LN=LN+1
 S @DGLIST@(LN,0)=DDASH
 S LN=LN+1
 S @DGLIST@(LN,0)=""
 S DGCNT=1
 Q
 ;
MAIL2 ;Send mailman message to user will results
 ;
 N DIFROM,%,XMDUZ,XMSUB,XMTEXT,XMY
 S (XMDUZ,XMSUB)="IOC SITE DBRS PATIENTS REPORT"
 S XMTEXT="^TMP(""DG53951P2"",$J,"
 S (XMY(DUZ),XMY(.5))=""
 S DGRCPNT="" F  S DGRCPNT=$O(DGRCPNT(DGRCPNT)) Q:DGRCPNT=""  S XMY(DGRCPNT(DGRCPNT))=""
 D NOW^%DTC S Y=% D DD^%DT
 D ^XMD
 S SNDMAIL=1
 Q
 ; 
