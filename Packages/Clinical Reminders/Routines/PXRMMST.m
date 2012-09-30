PXRMMST ;SLC/PKR - Routines for dealing with MST. ;07/29/2010
 ;;2.0;CLINICAL REMINDERS;**4,6,17,18**;Feb 04, 2005;Build 152
 ;Use of DGMSTAPI supported by DBIA #2716.
 ;====================================================
GSYINFO(TYPE) ;Return the Clinical Reminders MST synchronization date
 ;and the number of updates made. The format is an up-arrow delimited
 ;string. The first piece is the date and the second is the number
 ;of updates. If TYPE is "I" then the data for the initial
 ;synchronization is returned. For any other value the data for the
 ;last daily synchronization is returned.
 I $G(TYPE)="I" Q $P($G(^PXRM(800,1,"MST")),U,1,2) Q
 Q $P($G(^PXRM(800,1,"MST")),U,3,4)
 ;
 ;====================================================
QUE ;Queue the MST synchronization job.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,MINDT,SDTIME,STIME,X,Y
 S MINDT=$$NOW^XLFDT
 W !,"Queue the Clinical Reminders MST synchronization."
 S DIR("A",1)="Enter the date and time you want the job to start."
 S DIR("A",2)="It must be after "_$$FMTE^XLFDT(MINDT,"5Z")
 S DIR("A")="Start the task at: "
 S DIR(0)="DAU"_U_MINDT_"::RSX"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S SDTIME=Y
 K DIR
 S DIR(0)="YA"
 S DIR("A")="Do you want to run the MST synchronization at the same time every day? "
 S DIR("B")="Y"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S STIME=$S(Y:"1."_$P(SDTIME,".",2),1:-1)
 ;
 ;Put the task into the queue.
 K ZTSAVE
 S ZTSAVE("STIME")=STIME
 S ZTRTN="SYNCH^PXRMMST"
 S ZTDESC="Clinical Reminders MST synchronization job"
 S ZTDTH=SDTIME
 S ZTIO=""
 D ^%ZTLOAD
 W !,"Task number ",ZTSK," queued."
 Q
 ;
 ;====================================================
STATUS(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding for checking a
 ;patient's MST status.
 N IEN,TEMP
 S TEMP=$$GETSTAT^DGMSTAPI(DFN)
 S IEN=$P(TEMP,U,1)
 I IEN=-1 D  Q
 . S TEST=0,VALUE="",DATE=$$NOW^PXRMDATE
 I IEN=0 D  Q
 . S TEST=0
 . S VALUE=$P(TEMP,U,2)
 . S DATE=$P(TEMP,U,3)
 . S TEXT="No MST status found"
 ;If we get to here then a valid entry was found.
 S TEST=1
 S VALUE=$P(TEMP,U,2)
 S DATE=$P(TEMP,U,3)
 Q
 ;
 ;====================================================
STCODE(TERM) ;Return the MST status code based on the term name.
 N STCODE
 S STCODE=$S(TERM="VA-MST DECLINES REPORT":"D",TERM="VA-MST NEGATIVE REPORT":"N",TERM="VA-MST POSITIVE REPORT":"Y",1:"U")
 Q STCODE
 ;
 ;====================================================
SYNCH ;Synchronize the MST history file.
 N INID,LTIME,NUMUPD,START,TEMP
 ;STIME is passed from QUE via ZTSAVE.
 D UPDSTAT(.NUMUPD,.START)
 ;If the initial sync data has been stored then update the daily
 ;data.
 S INID=+$P($G(^PXRM(800,1,"MST")),U,1)
 I INID>0 D
 . S $P(^PXRM(800,1,"MST"),U,3)=$$NOW^XLFDT
 . S $P(^PXRM(800,1,"MST"),U,4)=NUMUPD
 . S $P(^PXRM(800,1,"MST"),U,6)=START
 E  D
 . S $P(^PXRM(800,1,"MST"),U,1)=$$NOW^XLFDT
 . S $P(^PXRM(800,1,"MST"),U,2)=NUMUPD
 . S $P(^PXRM(800,1,"MST"),U,5)=START
 ;
 ;Cleanup the task stuff.
 I STIME=-1 S ZTREQ="@" Q
 E  D
 . S TEMP=$G(^PXRM(800,1,"MST"))
 . S LTIME=+$P(TEMP,U,3)
 . I LTIME=0 S LTIME=+$P(TEMP,U,1)
 .;Adding STIME sets the new starting time at exactly one day following
 .;the previous starting time.
 . S $P(ZTREQ,U,1)=$P(LTIME,".",1)+STIME
 Q
 ;
 ;====================================================
SYNREP ;Provide a report of the synchronization data.
 N EDTIME,EITIME,IDATE,LDATE,NIUPD,NLUPD,TEMP
 S TEMP=$G(^PXRM(800,1,"MST"))
 S IDATE=$$FMTE^XLFDT($P(TEMP,U,1))
 I IDATE=0 S IDATE="none"
 S NIUPD=$P(TEMP,U,2)
 S EITIME=$$FMDIFF^XLFDT($P(TEMP,U,1),$P(TEMP,U,5),2)
 S LDATE=$$FMTE^XLFDT($P(TEMP,U,3))
 I LDATE=0 S LDATE="none"
 S NLUPD=$P(TEMP,U,4)
 S EDTIME=$$FMDIFF^XLFDT($P(TEMP,U,3),$P(TEMP,U,6),2)
 W !!,"Clinical Reminders MST Synchronization Report"
 W !,"---------------------------------------------"
 W !,"Initial synchronization date: ",IDATE
 W !,"Number of updates made: ",NIUPD
 I EITIME>60 D
 . S EITIME=$$FMDIFF^XLFDT($P(TEMP,U,1),$P(TEMP,U,5),3)
 . W !,"Elapsed time: ",EITIME
 E  W !,"Elapsed time: ",EITIME," secs"
 W !!,"Last daily synchronization date: ",LDATE
 W !,"Number of updates made: ",NLUPD
 I EDTIME>60 D
 . S EDTIME=$$FMDIFF^XLFDT($P(TEMP,U,3),$P(TEMP,U,6),3)
 . W !,"Elapsed time: ",EDTIME
 E  W !,"Elapsed time: ",EDTIME," secs"
 Q
 ;
 ;====================================================
UPDATE(DFN,VISIT,SOURCE,STCODE,TYPE) ;Make an update to the MST History file.
 N DATE,MSTDATE,PROV,STAT,TEMP,UPDSTAT,VPRVIEN
 S UPDSTAT=-1
 ;If the update is because of a protocol event use NOW for the
 ;date/time. If it is being done as part of a synchronization use
 ;the date the visit was created.
 S DATE=$S(TYPE="PROTOCOL":$$NOW^XLFDT,1:$P($G(^AUPNVSIT(VISIT,0)),U,2))
 ;If the date does not contain the time use noon.
 I DATE'["." S DATE=DATE_".12"
 S STAT=$$GETSTAT^DGMSTAPI(DFN)
 S MSTDATE=$S($P(STAT,U,1)>0:$P(STAT,U,3),1:0)
 I DATE>MSTDATE D
 .;Determine the provider.
 . S TEMP=$P(SOURCE,";",2)_$P(SOURCE,";",1)_",12)"
 . S PROV=$P($G(@TEMP),U,4)
 . I PROV="" D
 ..;DBIA #2316
 .. S VPRVIEN=+$O(^AUPNVPRV("AD",VISIT,""))
 .. I VPRVIEN>0 S PROV=$P(^AUPNVPRV(VPRVIEN,0),U,1)
 . S UPDSTAT=$$NEWSTAT^DGMSTAPI(DFN,STCODE,DATE,PROV)
 . I +UPDSTAT=-1 D
 .. N FN,GBL,IEN,NAME,TARGET,XMSUB,VADM
 .. K ^TMP("PXRMXMZ",$J)
 .. S XMSUB="CLINICAL REMINDER MST UPDATE PROBLEM"
 .. S ^TMP("PXRMXMZ",$J,1,0)="NEWSTAT^DGMSTAPI returned the following error:"
 .. S ^TMP("PXRMXMZ",$J,2,0)=$P(UPDSTAT,U,2)
 .. S ^TMP("PXRMXMZ",$J,3,0)="The following data was passed to NEWSTAT^DGMSTAPI"
 .. S ^TMP("PXRMXMZ",$J,4,0)="DFN = "_DFN
 .. S ^TMP("PXRMXMZ",$J,5,0)="Status code = "_STCODE
 .. S ^TMP("PXRMXMZ",$J,6,0)="Date = "_DATE
 .. S ^TMP("PXRMXMZ",$J,7,0)="Provider = "_PROV
 .. S ^TMP("PXRMXMZ",$J,8,0)="Data source = "_SOURCE
 .. S ^TMP("PXRMXMZ",$J,9,0)="This corresponds to the following:"
 .. D DEM^VADPT
 .. S ^TMP("PXRMXMZ",$J,10,0)="Patient = "_VADM(1)
 .. S ^TMP("PXRMXMZ",$J,11,0)="SSN = "_$P(VADM(2),U,2)
 .. S ^TMP("PXRMXMZ",$J,12,0)="MST Status = "_$$EXTERNAL^DILFD(29.11,3,"",STCODE)
 .. S ^TMP("PXRMXMZ",$J,13,0)="Date = "_$$FMTE^XLFDT(DATE,"5Z")
 .. S TEMP=$S(PROV="":"Unknown",1:TEMP=$$GET1^DIQ(200,PROV,.01,"","",""))
 .. I TEMP="" S TEMP="Unknown"
 .. S ^TMP("PXRMXMZ",$J,14,0)="Provider = "_TEMP
 .. S GBL=$P($P(SOURCE,";",2),"(",1)
 .. S TEMP=GBL_"(0)"
 .. S FN=+$P(@TEMP,U,2)
 .. S TEMP=GBL_"("_$P(SOURCE,";",1)_",0)"
 .. S TEMP=$G(@TEMP)
 .. S IEN=$P(TEMP,U,1)
 .. D FIELD^DID(FN,.01,"N","POINTER","TARGET")
 .. S GBL="^"_$P(TARGET("POINTER"),"(",1)
 .. S TEMP=GBL_"(0)"
 .. S FN=$P(@TEMP,U,1)
 .. S TEMP=GBL_"("_IEN_",0)"
 .. S NAME=$P(@TEMP,U,1)
 .. S ^TMP("PXRMXMZ",$J,14,0)="Data type = "_FN
 .. S ^TMP("PXRMXMZ",$J,15,0)="Name = "_NAME
 .. D SEND^PXRMMSG("PXRMXMZ",XMSUB,"",DUZ)
 Q UPDSTAT
 ;
 ;====================================================
UPDPAT(EVENT,DFN,VISIT,VFL) ;Update the MST history file for a single patient
 ;using term mappings. Called from DATACHG^PXRMPINF which is invoked
 ;by the protocol PXK VISIT DATA EVENT.
 N AFTER,BEFORE,DGBL,SP,STCODE,SIEN,SOURCE
 N TEMP,TERM,TERMIEN,VF
 ;Search all the MST terms to build patient lists.
 F TERM="VA-MST DECLINES REPORT","VA-MST NEGATIVE REPORT","VA-MST POSITIVE REPORT" D
 . S TERMIEN=$O(^PXRMD(811.5,"B",TERM,""))
 . S VF=""
 . F  S VF=$O(VFL(VF)) Q:VF=""  D
 .. I VFL(VF)=U Q
 .. S DGBL=$P(VFL(VF),U,1)
 .. I '$D(^PXRMD(811.5,TERMIEN,20,"E",DGBL)) Q
 .. S SIEN=""
 .. F  S SIEN=$O(^XTMP(EVENT,VISIT,VF,SIEN)) Q:SIEN=""  D
 ... S AFTER=$G(^XTMP(EVENT,VISIT,VF,SIEN,0,"AFTER"))
 ... S BEFORE=$G(^XTMP(EVENT,VISIT,VF,SIEN,0,"BEFORE"))
 ... I AFTER=BEFORE Q
 ... S SP=$P(AFTER,U,1)
 ... I SP="" Q
 ... I '$D(^PXRMD(811.5,TERMIEN,20,"E",DGBL,SP)) Q
 ... S SOURCE=SIEN_";^"_$P(VFL(VF),U,2)
 ...;The status code depends on the term name.
 ... S STCODE=$$STCODE^PXRMMST(TERM)
 ... S TEMP=$$UPDATE^PXRMMST(DFN,VISIT,SOURCE,STCODE,"PROTOCOL")
 Q
 ;
 ;====================================================
UPDSTAT(NUMUPD,START) ;Update the MST history file using term mappings.
 N DAS,DATA,DFN,FILENUM,FINDPA,INDEX,ITEM,NOCC,STCODE,SOURCE
 N TEMP,TERM,TERMARR,TERMIEN,UPDSTAT,VDATE,VISIT
 S FINDPA=""
 ;Set the start time for the synchronization.
 S START=$$NOW^XLFDT
 S INDEX="PXRM_MST_LIST"
 S NUMUPD=0
 ;Search all the MST terms to build patient lists. Only V file data
 ;is used for the update.
 F TERM="VA-MST DECLINES REPORT","VA-MST NEGATIVE REPORT","VA-MST POSITIVE REPORT" D
 . K TERMARR,^TMP($J,INDEX)
 .;The status code depends on the term name.
 . S STCODE=$$STCODE(TERM)
 . S TERMIEN=$O(^PXRMD(811.5,"B",TERM,""))
 . I TERMIEN="" Q
 . D TERM^PXRMLDR(TERMIEN,.TERMARR)
 . D EVALPL^PXRMTERL(.FINDPA,.TERMARR,INDEX)
 . S DFN=0
 . F  S DFN=+$O(^TMP($J,INDEX,1,DFN)) Q:DFN=0  D
 .. S ITEM=""
 .. F  S ITEM=$O(^TMP($J,INDEX,1,DFN,ITEM)) Q:ITEM=""  D
 ... S NOCC=0
 ... F  S NOCC=$O(^TMP($J,INDEX,1,DFN,ITEM,NOCC)) Q:NOCC=""  D
 .... S FILENUM=""
 .... F  S FILENUM=$O(^TMP($J,INDEX,1,DFN,ITEM,NOCC,FILENUM)) Q:FILENUM=""  D
 ..... S TEMP=^TMP($J,INDEX,1,DFN,ITEM,NOCC,FILENUM)
 ..... S DAS=$P(TEMP,U,1)
 ..... K DATA
 ..... D GETDATA^PXRMDATA(FILENUM,DAS,.DATA)
 ..... S VISIT=$G(DATA("VISIT"))
 ..... I VISIT="" Q
 ..... S SOURCE=DAS_";"_^PXRMINDX(FILENUM,"GLOBAL NAME")
 ..... S UPDSTAT=$$UPDATE(DFN,VISIT,SOURCE,STCODE,"SYNCH")
 ..... I UPDSTAT'=-1 S NUMUPD=NUMUPD+1
 K ^TMP($J,INDEX)
 Q
 ;
