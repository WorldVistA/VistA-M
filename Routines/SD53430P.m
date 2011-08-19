SD53430P ;WOIFO/CLC - PFSS Scheduled Outpatient Conversion Backload ;22-APR-2005
 ;;5.3;Scheduling;**430**;Aug 13, 1993
 D HDR
 Q
 ;
PRECHK ;
 N VCNT
 D HDR W !!,"Pre-Backload Analysis - Outpatient future appointments."
 S VCNT=$$FUTRAPP(0)
 I VCNT<0 W !,"Analysis exited without processing..." Q
 W !!,VCNT," Outpatient future appointments identified in VistA..."
 W !!,"Analysis complete...."
 Q
FUTRAPP(CMP) ;
 N I,DFN,APP,STDT,DT,APPINFO
 S (DFN,APP)=0
 S STDT=$$GETRESP($$NOW^XLFDT(),"Future Appointment search start date") I STDT="" S APP=-1 G OFAQ
 W !,"Checking VistA future appointments ",STDT," forward..."
 F I=1:1 S DFN=$O(^DPT(DFN)) Q:+DFN<1  D
    .I I#10000=0 W "."
    .S DT=STDT
    .F  S DT=$O(^DPT(DFN,"S",DT)) Q:+DT<1  D
      ..S APPINFO=$G(^DPT(DFN,"S",DT,0))
      ..I APPINFO="" W !,"Invalid Patient Appointment Node:",DFN,"-",DT Q
      ..I $P(APPINFO,"^",2)="" D
         ...S APP=APP+1
         ...I CMP I $G(^TMP($J,"OFA",DFN))="" S EXC(DFN_"^"_DT)=^DPT(DFN,0)
OFAQ Q APP
POSTCHK ;
 N PATH,FILENM,LN,TMP,I,DFN,BLCNT,EXC,VCNT
 D HDR W !!,"Post-Backload Analysis - Outpatient future appointments."
 S FILENM="SDCONV_ACCT.TXT",BLCNT=0,PATH=$$PWD^%ZISH()
 S PATH=$$GETRESP(PATH,"Select Backload Path") Q:PATH=""
 I '$$LISTF(PATH) S FILENM=""
 S FILENM=$$GETRESP(FILENM,"Select Backload File") Q:FILENM=""
 ;
 K ^TMP($J,"OFA")
 D OPEN^%ZISH("SD",PATH,FILENM,"R")
 F  U IO R LN:1 Q:LN']""  S ^TMP($J,"OFA",$P(LN,"^"))=LN,BLCNT=BLCNT+1
 D CLOSE^%ZISH(IO)
 ;
 W !!,"File: ",FILENM," contains: ",BLCNT," records."
 S VCNT=$$FUTRAPP(1)
 W !!,VCNT," Outpatient future appointments identified in VistA..."
 ;
 W !,"   VistA Total:",$J(VCNT,10)
 W !,"Backload Total:",$J(BLCNT,10)
 W !,"=================================="
 W !,"               ",$J(VCNT-BLCNT,10)
 ;
 I '$D(EXC) W !,"No Discrepencies between VistA and the Backload file" Q
 W !!,"Missing patients from backload file:",!
 S DFN=0
 F I=1:1 S DFN=$O(EXC(DFN)) Q:DFN=""  W !,I,") ",DFN,"^",EXC(DFN)
 W !!,"Post analysis complete...."
 K ^TMP($J,"OFA")
 Q
EP1 ;
 N CNT,GOOD,ERR,SDKEY,ANS,PATH,Y,FN,GFILE,RFILE,FILENM
 S SDKEY="SDCONV_ACCT.TXT",FILENM=SDKEY
 S PATH=$$PWD^%ZISH(),(CNT,GOOD)=0
 D HDR
 S PATH=$$GETRESP(PATH,"Select Backload Path") Q:PATH=""
 ;
 I '$$LISTF(PATH) S FILENM=""
 S FILENM=$$GETRESP(FILENM,"Select Backload File") Q:FILENM=""
 S CNT=$$LOADFILE(PATH,FILENM)
 ;
 I CNT>0 S GOOD=$$PROCESS(CNT)
 D RPTERR(CNT,GOOD,PATH_FILENM)
 W !!,"Finished.... Mailman message sent to:",$$GET1^DIQ(200,DUZ,.01)," and G.PATCHES"
 Q
LISTF(PATH) ;
 N GFILE,Y,RFILE,FN
 S GFILE("SD*.TXT")=""
 S Y=$$LIST^%ZISH(PATH,"GFILE","RFILE")
 W !!,"SD*.TXT Files in ",PATH,!,"=================================="
 I Y=1 S FN="" F  S FN=$O(RFILE(FN))  Q:FN=""  W !,?10,FN
 I Y=0 W !!,?10,"** No files matching the SD*.TXT filter exists **"
 Q Y
HDR ;
 D HOME^%ZIS  W @IOF
 W !!,"==========================================================="
 W !,"Scheduled Outpatient Conversion Backload",!
 W !,"    **********************************************************"
 W !,"    * This Routine should ONLY be run by PFSS Implementation *"
 W !,"    * Staff.  DO NOT run this routine as part of the normal  *"
 W !,"    * Patch installation process.                            *"
 W !,"    **********************************************************"
 W !!,"==========================================================="
 Q
GETRESP(DEF,TXT) ;
 N DIR,DIRUT,DTOUT,X,Y
 S DIR(0)="Fr",DIR("A")=TXT,DIR("B")=DEF D ^DIR
 I $D(DIRUT)!$D(DTOUT) S Y=""
 Q Y
RPTERR(CNT,GOOD,FULLPATH) ;
 N REC,CAT,ROW,ERR,ET,DETAIL
 N XMDF,XMDUZ,XMSUB,XMDUN,XMTEXT,XMSTRIP,XMROU,XMY,XMZ,XMMG
 S XMDF="",XMDUZ="SD53430P-"_$TR($P($$SITE^VASITE(),"^",2,3),"^","-")
 S XMY(DUZ)="",XMY("G.PATCHES")=""
 S XMSUB="PFSS Scheduled Outpatient Conversion"
 D XMZ^XMA2                                 ; Call Create Message Module
 I XMZ<1 D  Q
   .W !!,"** UNABLE TO CREATE MAILMAN MESSAGE PLEASE CHECK XTMP FOR DETAILS!"
 ;
 S ^XMB(3.9,XMZ,2,1,0)="Scheduled OutPatient Conversion Backload"
 S ^XMB(3.9,XMZ,2,2,0)="             File: "_FULLPATH
 S ^XMB(3.9,XMZ,2,3,0)="           Run By: "_$$GET1^DIQ(200,DUZ,.01)
 S ^XMB(3.9,XMZ,2,4,0)=""
 S ^XMB(3.9,XMZ,2,5,0)="Sucessful Records: "_GOOD
 S ^XMB(3.9,XMZ,2,7,0)="                 ----------------------"
 S ^XMB(3.9,XMZ,2,8,0)="  Total Processed: "_CNT
 S ^XMB(3.9,XMZ,2,9,0)="==============================================="
 ;
 S REC="",ROW=9,ERR=0
 F  S REC=$O(^XTMP(SDKEY,"ERR",REC)) Q:REC=""  D
   .S ERR=ERR+1,ROW=ROW+1
   .S ^XMB(3.9,XMZ,2,ROW,0)="Record: "_REC_"     ----------------------"
   .S CAT=""
   .F  S CAT=$O(^XTMP(SDKEY,"ERR",REC,CAT)) Q:CAT=""  D
      ..S ROW=ROW+1,^XMB(3.9,XMZ,2,ROW,0)="   "_CAT
      ..S ET=""
      ..F  S ET=$O(^XTMP(SDKEY,"ERR",REC,CAT,ET)) Q:ET=""  D
         ...S ROW=ROW+1
         ...S ^XMB(3.9,XMZ,2,ROW,0)="        "_^XTMP(SDKEY,"ERR",REC,CAT,ET)
 ;
 S ^XMB(3.9,XMZ,2,6,0)="    Error Records: "_ERR
 I ROW=9 S ROW=10,^XMB(3.9,XMZ,2,ROW,0)="Sucessful Backload..... No ERRORS found..."
 ;
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_ROW_"^"_ROW_"^"_$$NOW^XLFDT()
 D ENT1^XMD                                                 ;Deliver MSG
 K ^XTMP(SDKEY)
 Q
LOADFILE(PATH,FILENM) ;
 N POP,NOW,PURGDT,STOP,TOT,LN
 W !,"Loading backload file..."
 K ^XTMP(SDKEY)
 S NOW=$$NOW^XLFDT(),PURGDT=NOW+2,TOT=0             ;Purge 2 days later
 S ^XTMP(SDKEY,0)=PURGDT_"^"_NOW_"^PFSS Scheduled Outpatient Back Load"
 ;
 D OPEN^%ZISH("SD",PATH,FILENM,"R")
 I $G(POP) S ^XTMP(SDKEY,"ERR",0,"FATAL",1)="Could NOT PROCESS File!"
 ;
 S (STOP,TOT)=0
 F  U IO R LN:1 Q:LN']""  Q:$$STATUS^%ZISH  Q:STOP  D
    .I $G(LN)="" S STOP=1 Q
    .S TOT=TOT+1,^XTMP(SDKEY,"DAT",TOT)=LN I TOT#1000=0 U 0 W "."
 ;
 D CLOSE^%ZISH(IO)
LFQ Q TOT
 ;
PROCESS(TOT) ;
 N CNT,INFO,DFN,SDT,SDCLN,SDEXVN,SDANR,SDCHK,GOOD
 W !,"Processing data..."
 S GOOD=0
 F CNT=1:1:TOT D
    .I CNT#1000=0 W "."
    .S INFO=^XTMP(SDKEY,"DAT",CNT)
    .S DFN=$P(INFO,"^",1),SDT=$P(INFO,"^",18)
    .S SDCLN=$P(INFO,"^",8),SDEXVN=$TR($P(INFO,"^",21)," ","")
    .;
    .Q:$$CHKINFO(CNT,DFN,SDT,SDCLN,SDEXVN)
    .S SDANR=$$GETARN^SDPFSS2(SDT,DFN,SDCLN)
    .I +SDANR>0 D  Q
       ..I $$EXTNUM^IBBAPI(DFN,SDANR)'=SDEXVN D  Q
           ...S ^XTMP(SDKEY,"ERR",CNT,"ACCT",1)="Visit Number Discrepancy: "_INFO_" NOT EQUAL: "_SDANR
       ..S GOOD=GOOD+1
    .;
    .S SDANR=$$IBBACONV^IBBAADTI(DFN,"O",SDT,SDCLN,SDEXVN)
    .I SDANR="" S ^XTMP(SDKEY,"ERR",CNT,"ACCT",2)="PFSS Account Reference NOT Created" Q
    .;
    .S SDCHK=$$FILE^SDPFSS(DFN,SDT,SDCLN,SDANR)
    .I +SDCHK<0 D
       ..S ^XTMP(SDKEY,"ERR",CNT,"APPT LINK",1)="Unable to update file 409.55"
       ..S ^XTMP(SDKEY,"ERR",CNT,"APPT LINK",2)=SDCHK
    .I SDCHK="" S ^XTMP(SDKEY,"ERR",CNT,"APPT LINK",3)="Link Already Exists:"_INFO
    .I +SDCHK=1 S GOOD=GOOD+1
 Q GOOD
CHKINFO(CNT,DFN,SDT,SDCLN,SDEXVN) ;
 I SDEXVN="" S ^XTMP(SDKEY,"ERR",CNT,"IDX",1)="NO IDX Vist Number:"_INFO
 ;
 I +DFN=0 S ^XTMP(SDKEY,"ERR",CNT,"PATIENT",1)="DFN Invalid or Missing"
 I +DFN>0 D
   .I $G(^DPT(DFN,0))="" S ^XTMP(SDKEY,"ERR",CNT,"PATIENT",2)="Invalid Patient: "_DFN
 ;
 I +SDT=0 S ^XTMP(SDKEY,"ERR",CNT,"APPT DT/TIME",1)="Appointment Date/Time Invalid or Missing"
 ;
 I +SDCLN=0 S ^XTMP(SDKEY,"ERR",CNT,"LOCATION",1)="Location Invalid or Missing"
 I +SDCLN>0 D
   .I $G(^SC(SDCLN,0))="" S ^XTMP(SDKEY,"ERR",CNT,"LOCATION",2)="Invalid Location:"_SDCLN
 Q $D(^XTMP(SDKEY,"ERR",CNT))
 ;
