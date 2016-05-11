SDCED ;ALB/JCH - VSE GUI RESOURCE MANAGEMENT REPORT DATA COMPILER ;19 Oct 14  04:11PM
 ;;5.3;Scheduling;**628**;Aug 13, 1993;Build 371
 ;;
 ; Reference to NOTES^TIUSRVLV is supported by ICR #2812
 ; Reference to V PROVIDER file is supported by ICR #2316
 Q
QUEUE ; Task to background
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 S ZTIO=""
 ;
 I $$ISLOCKED() Q
 ;
 S ZTRTN="EN^SDCED"
 S ZTSAVE("SDECMAIL")=""
 S ZTDTH=$$NOW^XLFDT
 S ZTDESC="SD Resource Management Report Data Compiler"
 D ^%ZTLOAD
 Q
 ;
EN ; This utility will create a temporary storage global in ^XTMP("SDVSE") that contains
 ; data used by the VSE GUI Resource Management Reports.
 ;      
 N SDFAC,DATE,SDWEEKS,SDSTPAR,SDSTART,SDECTOT,OLOC,SDRPT,SDRPTAR,SDBEGRNG,SDENDRNG,DTRANGE,PROV
 N SDSTRT,SDSTP,SDCMP,DAYS,STCNT,STGL
 ;
 S STGL="^XTMP(""SDVSE"",""RPTSTATS"")" K @STGL
 ; If last process completed successfully, only check for data for the last 90 days
 ; from the last completed process.
 S DAYS=$S($P($G(^XTMP("SDVSE",0)),U,5)'="":90,1:365)
 S SDATE=$$NOW^XLFDT
 S SDSTART=$$FMADD^XLFDT(SDATE,-DAYS),SDEND=$$NOW^XLFDT
 S SDFAC=$P($$SITE^VASITE(),"^",2)
 ;
 I '$$LOCK() D  Q
 .I '$G(ZTSK) W !!?5,"SD Resource Management Report Data compile cannot be started at this time.",!! D PAUSE
 ;
 D BLDSTAT("")
 D BLDSTAT("SDEC REPORT DATA option runtime statistics")
 D BLDSTAT("------------------------------------------"),BLDSTAT("")
 D BLDSTAT("Collecting data from "_$$FMTE^XLFDT(SDSTART)_" to "_$$FMTE^XLFDT(SDEND)),BLDSTAT("")
 D GETCLNS^SDECSTP(.SDSTPAR)
 ; Get Clinic Appointment data
 S SDSTRT=$$NOW^XLFDT D RPT^SDECRPT(DAYS,.SDSTPAR) S SDSTP=$$NOW^XLFDT,SDCMP=$$FMDIFF^XLFDT(SDSTP,SDSTRT,3) D
 . D BLDSTAT("Collect Clinic Appointment Data:")
 . D BLDSTAT("     Started at "_$$FMTE^XLFDT(SDSTRT)_" Finished at "_$$FMTE^XLFDT(SDSTP))
 . D BLDSTAT("     Total Run Time: "_$S(SDCMP]"":SDCMP,1:"0:00:01")_"  (DD HH:MM:SS)")
 ; Get Clinic Supply data
 N SDSTRT,SDSTP,SDCMP S SDSTRT=$$NOW^XLFDT D SUPPLY S SDSTP=$$NOW^XLFDT,SDCMP=$$FMDIFF^XLFDT(SDSTP,SDSTRT,3) D
 . D BLDSTAT("")
 . D BLDSTAT("Collect Clinic Supply Data:")
 . D BLDSTAT("     Started at "_$$FMTE^XLFDT(SDSTRT)_" Finished at "_$$FMTE^XLFDT(SDSTP))
 . D BLDSTAT("     Total Run Time: "_$S(SDCMP]"":SDCMP,1:"0:00:01")_"  (DD HH:MM:SS)")
 ; Get Provider Outpatient Appointment data
 N SDSTRT,SDSTP,SDCMP S SDSTRT=$$NOW^XLFDT D PROVIDER S SDSTP=$$NOW^XLFDT,SDCMP=$$FMDIFF^XLFDT(SDSTP,SDSTRT,3) D
 . D BLDSTAT("")
 . D BLDSTAT("Collect Provider Data:")
 . D BLDSTAT("     Started at "_$$FMTE^XLFDT(SDSTRT)_" Finished at "_$$FMTE^XLFDT(SDSTP))
 . D BLDSTAT("     Total Run Time: "_$S(SDCMP]"":SDCMP,1:"0:00:01")_"  (DD HH:MM:SS)")
 ; Merge all compiled data
 D MERGE(SDATE)
 F SDRPT="M","P","S" S SDRPTAR(SDRPT)=""
 N SDSTRT,SDSTP,SDCMP S SDSTRT=$$NOW^XLFDT D EN^SDCED1(.SDRPTAR) S SDSTP=$$NOW^XLFDT,SDCMP=$$FMDIFF^XLFDT(SDSTP,SDSTRT,3) D
 . D BLDSTAT("")
 . D BLDSTAT("Cross Reference and Aggregate All Data:")
 . D BLDSTAT("     Started at "_$$FMTE^XLFDT(SDSTRT)_" Finished at "_$$FMTE^XLFDT(SDSTP))
 . D BLDSTAT("     Total Run Time: "_$S(SDCMP]"":SDCMP,1:"0:00:01")_"  (DD HH:MM:SS)")
 ; Build the Report Filter data
 N SDSTRT,SDSTP,SDCMP,XMLNODE
 S SDSTRT=$$NOW^XLFDT,XMLNODE="FLTXML" D START^SDECXML("MPS","YQMWD",,,1,"","",XMLNODE) S SDSTP=$$NOW^XLFDT,SDCMP=$$FMDIFF^XLFDT(SDSTP,SDSTRT,3) D
 . D BLDSTAT("")
 . D BLDSTAT("Build Filter Data:")
 . D BLDSTAT("     Started at "_$$FMTE^XLFDT(SDSTRT)_" Finished at "_$$FMTE^XLFDT(SDSTP))
 . D BLDSTAT("     Total Run Time: "_$S(SDCMP]"":SDCMP,1:"0:00:01")_"  (DD HH:MM:SS)")
 ; Build the Full Year Report data
 N SDLAST,SDSTRT,SDBEGDT,SDSTP,SDCMP,XMLNODE
 S SDSTRT=$$NOW^XLFDT,SDLAST=$O(^XTMP("SDVSE","DT",""),-1),SDBEGDT=$$FMADD^XLFDT(SDLAST,-365),XMLNODE="YRPTXML-S"
 D START^SDECXML("S","D",SDBEGDT,SDSTRT,,"Year","",XMLNODE) S SDSTP=$$NOW^XLFDT,SDCMP=$$FMDIFF^XLFDT(SDSTP,SDSTRT,3) D
 . D BLDSTAT("")
 . D BLDSTAT("Build Specialty Care Year XML Report Data:")
 . D BLDSTAT("     Started at "_$$FMTE^XLFDT(SDSTRT)_" Finished at "_$$FMTE^XLFDT(SDSTP))
 . D BLDSTAT("     Total Run Time: "_$S(SDCMP]"":SDCMP,1:"0:00:01")_"  (DD HH:MM:SS)")
 N SDLAST,SDSTRT,SDBEGDT,SDSTP,SDCMP,XMLNODE
 S SDSTRT=$$NOW^XLFDT,SDLAST=$O(^XTMP("SDVSE","DT",""),-1),SDBEGDT=$$FMADD^XLFDT(SDLAST,-365),XMLNODE="YRPTXML-P"
 D START^SDECXML("P","D",SDBEGDT,SDSTRT,,"Year","",XMLNODE) S SDSTP=$$NOW^XLFDT,SDCMP=$$FMDIFF^XLFDT(SDSTP,SDSTRT,3) D
 . D BLDSTAT("")
 . D BLDSTAT("Build Primary Care Year XML Report Data:")
 . D BLDSTAT("     Started at "_$$FMTE^XLFDT(SDSTRT)_" Finished at "_$$FMTE^XLFDT(SDSTP))
 . D BLDSTAT("     Total Run Time: "_$S(SDCMP]"":SDCMP,1:"0:00:01")_"  (DD HH:MM:SS)")
 N SDLAST,SDSTRT,SDBEGDT,SDSTP,SDCMP,XMLNODE
 S SDSTRT=$$NOW^XLFDT,SDLAST=$O(^XTMP("SDVSE","DT",""),-1),SDBEGDT=$$FMADD^XLFDT(SDLAST,-365),XMLNODE="YRPTXML-M"
 D START^SDECXML("M","D",SDBEGDT,SDSTRT,,"Year","",XMLNODE) S SDSTP=$$NOW^XLFDT,SDCMP=$$FMDIFF^XLFDT(SDSTP,SDSTRT,3) D
 . D BLDSTAT("")
 . D BLDSTAT("Build Mental Health Year XML Report Data:")
 . D BLDSTAT("     Started at "_$$FMTE^XLFDT(SDSTRT)_" Finished at "_$$FMTE^XLFDT(SDSTP))
 . D BLDSTAT("     Total Run Time: "_$S(SDCMP]"":SDCMP,1:"0:00:01")_"  (DD HH:MM:SS)")
 D CLEAN,RPTSTAT
 Q
 ;
PROVIDER ; Get encounters by provider
 N ENCDCNT,SDDT,SDPR,SDCL,SDCEX,TMPDAY,NXTDAY,SVCAT,SDEC,SDIV
 N CLSTOP,SDEST,DFN,ENC,BDATE,CDATE,LOC,CATEGORY,SDNEW,SDIV
 D BLDPRDT("PR",$P(SDSTART,"."),.SDSTPAR,SDEND)
 S SDIV="" F  S SDIV=$O(^TMP("SDECX",$J,"CL",SDIV)) Q:'SDIV  D
 .S SDEC="" F  S SDEC=$O(^TMP("SDECX",$J,"CL",SDIV,SDEC)) Q:SDEC=""  D
 ..S SDCL=0 F  S SDCL=$O(^TMP("SDECX",$J,"CL",SDIV,SDEC,SDCL)) Q:'SDCL  D CNTPROV(SDIV,SDEC,SDCL)
 Q
 ;
CNTPROV(SDIV,SDEC,SDCL) ; aggregate daily encounters by provider 
 N SDEST,SDNEW,TELCATD,DIVEX,CLINEX,PROVEX S SDEST=0,SDNEW=0
 S SDPR=0 F  S SDPR=$O(^TMP("SDECX",$J,"CL",SDIV,SDEC,SDCL,"PR",SDPR)) Q:'SDPR  D
 .S ENCDCNT=0,TELCATD=0
 .S SDDT=0 F  S SDDT=$O(^TMP("SDECX",$J,"CL",SDIV,SDEC,SDCL,"PR",SDPR,SDDT)) Q:'SDDT  S TMPDAY=$P(SDDT,".") D
 ..N ENC,SDDFN
 ..S ENC=0 F  S ENC=$O(^TMP("SDECX",$J,"CL",SDIV,SDEC,SDCL,"PR",SDPR,SDDT,ENC)) Q:'ENC  D
 ...N SDENCND,SVCAT,SDSGNM,SDTMPND,AGGDATA
 ...S SDENCND=$G(^TMP("SDECX",$J,"CL",SDIV,SDEC,SDCL,"PR",SDPR,SDDT,ENC))
 ...S SDSGNM="" D GETSCAT(SDCL,.SDSGNM,.SDSTPAR) ; Get Stop Code Group Name
 ...Q:SDSGNM="UNKNOWN"
 ...S SVCAT=$P(SDENCND,"^"),TELCATD=$S(SVCAT="T":1,1:0)
 ...S SDEST=+$P(SDENCND,"^",2),SDNEW=$S($G(SDEST):0,1:1)
 ...S SDTMPND=$G(^TMP("SDCEX",$J,$E(SDSGNM),+SDCL,SDDT,+SDPR,"ENC"))
 ...S AGGDATA=($P(SDTMPND,"^")+1)_"^"_(SDNEW+$P(SDTMPND,"^",2))_"^"_(SDEST+$P(SDTMPND,"^",3))_"^"_(TELCATD+$P(SDTMPND,"^",4))
 ...S ^TMP("SDCEX",$J,$E(SDSGNM),+SDCL,SDDT,+SDPR,"ENC")=AGGDATA
 Q
 ;
CLEAN ; Clean up
 K ^TMP("SDECX",$J),^TMP("SDCEX",$J)
 S $P(^XTMP("SDVSE",0),U,5)=$$NOW^XLFDT()
 N SDSTRT,SDSTP,SDCMP
 S SDSTRT=$P(^XTMP("SDVSE",0),U,2),SDSTP=$P(^XTMP("SDVSE",0),U,5)
 S SDCMP=$$FMDIFF^XLFDT(SDSTP,SDSTRT,3)
 D BLDSTAT("")
 D BLDSTAT("SDEC REPORT DATA Option:")
 D BLDSTAT("     Started at "_$$FMTE^XLFDT(SDSTRT)_" Finished at "_$$FMTE^XLFDT(SDSTP))
 D BLDSTAT("     Total Run Time: "_SDCMP_"  (DD HH:MM:SS)")
 D BLDSTAT(""),BLDSTAT("")
 D BLDSTAT("*****************************************************************")
 D BLDSTAT("This message can be disabled by setting the SDECMAIL value in the")
 D BLDSTAT("Entry Action field of the SDEC REPORT DATA Option to zero.")
 D BLDSTAT("ENTRY ACTION: S SDECMAIL=0"),BLDSTAT("")
 D BLDSTAT("To re-enable the statistics, set the value back to one.")
 D BLDSTAT("ENTRY ACTION: S SDECMAIL=1")
 D BLDSTAT("*****************************************************************")
 Q
 ;
BLDPRDT(ENCTYP,SDSTARTD,SDSTPAR,SDEND) ; Collect Provider Encounter data from ENCOUNTER (#409.68) file "D" xref
 N II,IC,SDENC,SDENCDT,SDENCPR,SDENCL,DGENDTST,SDDIVI,SDDIVIE,SDGRPA,SDEST,SDNEW,SDENCND,VISIT,SDCHILD,SDCKODT
 S DGENDTST=$$FMADD^XLFDT(SDSTARTD,,,-1)
 S SDEND=$P(SDEND,".")_".24"
 F  S DGENDTST=$O(^SCE("D",DGENDTST)) Q:'DGENDTST!(DGENDTST>SDEND)  D
 .S SDCKODT=0 F II=1:1 S SDCKODT=$O(^SCE("D",DGENDTST,SDCKODT)) Q:'SDCKODT  D
 ..S SDENC=0 F IC=1:1 S SDENC=$O(^SCE("D",DGENDTST,SDCKODT,SDENC)) Q:'SDENC  D
 ...N SDDFN,CDATE,SDEST,SDNEW,SDAPDATA,ENCARAY,SDENC0,SDVISIT
 ...N SDVPRV,SDENCAR,SDVAR
 ...; Delete invalid cross references
 ...I '$D(^SCE(SDENC,0)) K ^SCE("D",DGENDTST,SDCKODT,SDENC) Q
 ...S SDENC0=^SCE(SDENC,0)
 ...S SDVISIT=$P(SDENC0,U,5) Q:$G(SDVISIT)=""
 ...S SDENCPR=$$VPRV(SDVISIT) Q:$G(SDENCPR)=""
 ...S SDENCL=$P(SDENC0,U,4) Q:'$G(SDENCL)
 ...S SDENCDT=$P(SDENC0,U) Q:'$G(SDENCDT)
 ...S SDDIVI=$P(SDENC0,U,11) Q:$G(SDDIVI)=""
 ...S SDDFN=$P($G(^SCE(+SDENC,0)),"^",2) Q:'$G(SDDFN)
 ...S CDATE=DGENDTST
 ...N SDTMPLOC,SDTMPSTP S SDTMPSTP=$P($G(^SCE(+SDENC,0)),"^",3) Q:'SDTMPSTP
 ...S SDTMPLOC=$$CHKEST(SDDFN,CDATE,SDENC,.SDTMPSTP) S SDEST=$S(+$G(SDTMPLOC):1,1:""),SDNEW=$S($G(SDEST):0,1:1)
 ...S SVCAT="" S SVCAT=$S($$TELE(SDVISIT):"T",1:$P($G(^AUPNVSIT(+SDVISIT,0)),"^",7))
 ...N SDSGNM S SDSGNM="" D GETSCAT(SDENCL,.SDSGNM,.SDSTPAR) ; Get Stop Code Group Name
 ...S ^TMP("SDECX",$J,"CL",+$G(SDDIVI),SDSGNM,SDENCL,"PR",SDENCPR,SDENCDT,SDENC)=SVCAT_"^"_$G(SDEST)
 Q
 ;
MERGE(SDATE) ; copy data to ^TMP
 M ^XTMP("SDVSE","DT",$P(SDATE,"."))=^TMP("SDCEX",$J)
 K ^TMP("SDCEX",$J)
 Q
 ;
GETSCAT(SDLOC,SDSGNM,SDSTPAR)  ; Get Stop Code Group Name
 N CSTOP S CSTOP="",SDSGNM="UNKNOWN"
 D CLSTOP(SDLOC,.CSTOP)
 I $G(CSTOP) D STOPCAT(CSTOP,.SDSGNM,.SDSTPAR)
 Q
 ;
STOPCAT(CLSTOP,CAT,SDSTPAR) ; Get stop code category (Mental Health, Specialty, Primary)
 N CLINEX,STPCNT,OK,TMPCAT,FOUND S FOUND=0
 Q:'$G(CLSTOP)  K CAT S TMPCAT="UNKNOWN"
 S STPCNT="" F  S STPCNT=$O(SDSTPAR(STPCNT)) Q:(STPCNT="")!$G(FOUND)  D
 .S CLINEX="" F  S CLINEX=$O(SDSTPAR(STPCNT,CLINEX)) Q:CLINEX=""!$G(FOUND)  D
 ..I +$P($G(SDSTPAR(STPCNT,CLINEX)),"^",2)=+CLSTOP S FOUND=CLSTOP
 ..S TMPCAT=STPCNT
 S CAT=$S(TMPCAT="S":"SPECIALTY CARE",TMPCAT="M":"MENTAL HEALTH",TMPCAT="P":"PRIMARY CARE",1:"UNKNOWN")
 Q
 ;
CLSTOP(SDLOC,CSTOP) ; Get Clinic Stop
 N X,Y,DIQ,DIC,DA,DR,SDCS K CSTOP S CSTOP=""
 S DIC="44",DA=SDLOC,DR="8"
 D GETS^DIQ(DIC,DA,DR,"I","SDCS")
 S CSTOP=$G(SDCS(DIC,DA_",",8,"I"))
 Q:'CSTOP  K SDCS
 N X,Y,DIQ,DIC,DA,DR
 S DIC=40.7,DA=CSTOP,DR="1"
 D GETS^DIQ(DIC,DA,DR,"I","SDCS")
 S CSTOP=$G(SDCS(DIC,DA_",",1,"I"))
 Q
 ;
CHKEST(DFN,BDATE,ENC,CLSTOP) ; Was Patient DFN's encounter on date DATE considered Established or New?
 N SDLOC,OENCND,SDCHIT,PRVDATE,PRVENC,OCLSTOP S PRVDATE=BDATE,PRVENC=ENC
 Q:'$G(DFN) ""  Q:'$G(BDATE) ""  Q:'$G(ENC) ""  Q:'$D(^SCE(ENC,0)) ""
 S SDLOC=$P($G(^SCE(ENC,0)),"^",4),CLSTOP=""
 D CLSTOP(SDLOC,.CLSTOP) I 'CLSTOP S CLSTOP=$P($G(^SCE(ENC,0)),"^",3) Q:'CLSTOP ""
 S SDCHIT=0
 F  Q:$G(SDCHIT)  S PRVDATE=$O(^SCE("ADFN",DFN,PRVDATE),-1) Q:'PRVDATE!($$FMDIFF^XLFDT(BDATE,PRVDATE)>730)  S PRVENC=0 F  S PRVENC=$O(^SCE("ADFN",DFN,PRVDATE,PRVENC)) Q:'PRVENC!$G(SDCHIT)  D
 .S OENCND=$G(^SCE(PRVENC,0)) S OCLSTOP="",OLOC=$P(OENCND,"^",4)
 .D CLSTOP(OLOC,.OCLSTOP) S:'$G(OCLSTOP) OCLSTOP=$P(OENCND,"^",3)
 .I OCLSTOP=CLSTOP S SDCHIT=$P(^SCE(ENC,0),"^",4)
 Q $S($G(SDCHIT):$G(SDCHIT),1:0)
 ;
TELE(VISIT) ; If the Visit has at least one telephone note, return true
 N TMPNM,SDPHN,GLB S TMPNM=""
 D NOTES^TIUSRVLV(.TMPNM,VISIT)
 Q:TMPNM="" ""  S SDPHN=0
 S GLB=TMPNM F  Q:$G(SDPHN)  S GLB=$Q(@GLB) Q:GLB'["TIU"!(GLB'[$J)  I @GLB["TELEPHON" S SDPHN=1
 Q $S($G(SDPHN):1,1:0)
 ;
VPRV(VISIT) ; Find encounter provider
 Q:'$G(VISIT)
 N VPRV,ENCARAY,VARAY,DIC,DA,DR,DIQ
 S VPRV=$O(^AUPNVPRV("AD",+VISIT,0))
 Q:'VPRV ""
 Q +$P(^AUPNVPRV(VPRV,0),U)
 ;
SUPPLY ; Supply by clinic
 N RDT S RDT=DT
 D SUPPLY^SDECXUTL(.SDSTPAR)
 Q
 ;
NONCNT(SDCL) ; Non-Count Clinic?
 Q $S($P($G(^SC(+SDCL,0)),"^",17)="Y":1,1:0)
 ;
ISLOCKED() ; -- Returns 1 if the locked, otherwise 0 if unlocked
 ; Format of zero node:
 ; ^XTMP("SDVSE",0)="Save Through Date/Time^Last Start Date/Time^Description^Task #^Complete Date/Time
 ; Check if top level node does not exist then let it run
 I '$D(^XTMP("SDVSE",0)) Q 0
 ; Check the task status. If task defined and is still running then it's locked
 I +$P($G(^XTMP("SDVSE",0)),U,4),$$TSKSTAT($P(^XTMP("SDVSE",0),U,4)) Q "1^Resource Management Report data is compiling.  Please try again later."
 ; Not Locked
 Q 0
 ;
LOCK()  ; -- lock "SDCEX,0" node
 I +$$ISLOCKED() Q 0
 S ^XTMP("SDVSE",0)=$$FMADD^XLFDT($$NOW^XLFDT,7,0,0,)_U_$$NOW^XLFDT_U_"SD Resource Management Report Data compile started by "_$P(^VA(200,DUZ,0),U)_U_$G(ZTSK)_U_""
 Q 1
 ;
TSKSTAT(ZTSK) ; Check the status of a task
 ; Returns 0 if task is undefined or 1 if task is still running
 D STAT^%ZTLOAD
 I 'ZTSK(0) Q 0
 ; Task status is still Active if ZTSK(1)=1 or 2
 I ZTSK(1)=1!(ZTSK(1)=2) Q 1
 ; Any other task status means the task is inactive
 Q 0
 ;
BLDSTAT(TEXT) ; Build the report data collection stats email text
 I $G(STCNT)="" S STCNT=0
 I $G(STGL)="" S STGL="^XTMP(""SDVSE"",""RPTSTATS"")"
 S STCNT=STCNT+1
 S @STGL@(0)="",@STGL@(STCNT)=TEXT
 Q
 ;
RPTSTAT ; Report the status of the job
 N XMSUB,XMTEXT,XMDUZ,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMZ,XMMG,TMPDUZ
 S $P(^XTMP("SDECMAIL",0),U)=$$FMADD^XLFDT($$NOW^XLFDT,7,0,0,)
 Q:$G(SDECMAIL)'=1
 S TMPDUZ=$P($G(^XTMP("SDECMAIL",0)),U,2)
 Q:'TMPDUZ
 S XMY(TMPDUZ)="",XMSUB="SDEC REPORT DATA Stats for "_$$FMTE^XLFDT($$NOW^XLFDT)
 S XMTEXT=$P(STGL,")")_","
 D ^XMD
 ; Reset Purge date for MailMan Status Report user id.
 S $P(^XTMP("SDECMAIL",0),U)=$$FMADD^XLFDT($$NOW^XLFDT,7,0,0,)
 Q
 ;
EXITOPT  ; SD VSE REPORT DATA option exit action
 I '$D(IO("Q")) D  Q
 .I '$G(ZTSK),+$P($G(^XTMP("SDVSE",0)),U,4),$$TSKSTAT($P(^XTMP("SDVSE",0),U,4)) W !!?5,"SD Resource Management Report Data compile has been queued.",!! D PAUSE Q
 .I '$G(ZTSK),+$P($G(^XTMP("SDVSE",0)),U,2),$P($G(^XTMP("SDVSE",0)),U,5)="" W !!?5,"SD Resource Management Report Data compile is running",!! D PAUSE
 .I '$G(ZTSK),+$P($G(^XTMP("SDVSE",0)),U,2),+$P($G(^XTMP("SDVSE",0)),U,5) W !!?5,"SD Resource Management Report has completed",!! D PAUSE
 Q
 ;
SETDXREF(DA) ; This function is the set condition for the "D" index on the Outpatient Encounter file #409.68
 ; This cross reference is only used by the VistA Scheduling GUI Resource Management Reports. 
 ; The cross reference is used to collect the total Outpatient Encounters for a Provider over a year time period.
 ; Verify that all required fields exist before setting cross reference
 ; Input: DA = IEN of file 409.68
 N SDOK,SDEDT,SDLOC,SDVST S SDOK=0
 ; Don't set index if Date of encounter greater than one year and a day in the past.
 S SDEDT=$P(^SCE(DA,0),U) I $$FMDIFF^XLFDT(DT,SDEDT,1)>366 Q SDOK
 ; Don't set index if this is a Child Encounter
 Q:+$P(^SCE(DA,0),U,6) SDOK
 ; Don't set if Visit is not defined
 S SDVST=$P(^SCE(DA,0),U,5) Q:SDVST="" SDOK
 ; Don't set index if Encounter Provider is not defined in the V PROVIDER file
 Q:'$O(^AUPNVPRV("AD",+SDVST,0)) SDOK
 ; Don't set index if Location not defined
 S SDLOC=$P(^SCE(DA,0),U,4) Q:'$D(^SC(+SDLOC)) SDOK
 ; Don't set index if Location is a non-count clinic
 Q:$P($G(^SC(+SDLOC,0)),"^",17)="Y" SDOK
 Q 1
 ;
KILDXREF(DA) ; This function is the kill condition for the "D" index ont he Outpatient Encounter file #409.68
 N SDOK,SDEDT,SDVST S SDOK=1
 ; Kill index if date of encounter is greater than one year and a day in the past
 S SDEDT=$P(^SCE(DA,0),U) I $$FMDIFF^XLFDT(DT,SDEDT,1)>366 Q SDOK
 ; Kill index if this is a Child Encounter
 Q:+$P(^SCE(DA,0),U,6) SDOK
 ; Kill index if Visit is not defined
 S SDVST=$P(^SCE(DA,0),U,5) Q:SDVST="" SDOK
 ; Kill index if Encounter Provider is not defined
 Q:'$O(^AUPNVPRV("AD",+SDVST,0)) SDOK
 ; Kill index if Location not defined
 S SDLOC=$P(^SCE(DA,0),U,4) Q:'$D(^SC(+SDLOC)) SDOK
 ; Kill index if Location is a non-count clinic
 Q:$P($G(^SC(+SDLOC,0)),"^",17)="Y" SDOK
 Q 0
 ;
PAUSE ;
 Q:$E(IOST)'="C"!(IO'=IO(0))
 N DIRUT,DUOUT
 S DIR(0)="EO",DIR("A")="Press return to continue...." D ^DIR K DIR S:$D(DUOUT) DIRUT=1
 Q
