PXRMXQUE ; SLC/PJH - Reminder reports general queuing routine.;02/10/2010
 ;;2.0;CLINICAL REMINDERS;**4,6,12,17**;Feb 04, 2005;Build 102
 ;
 ;===============================
DEVICE(RTN,DESC,SAVE,%ZIS,RETZTSK) ;
 ;Pass RETZTSK as number such as 1 if you want to get ZTSK.
 N ZTSK
 W !
 D EN^XUTMDEVQ(RTN,DESC,.SAVE,.%ZIS,RETZTSK)
 I $D(ZTSK) W !!,DESC," has been queued, task number "_ZTSK H 2
 Q $G(ZTSK)
 ;
 ;===============================
JOB ;Get the output device.
 N POP,%ZIS
 S %ZIS="NQ"
 W !
 D ^%ZIS
 I POP G EXIT^PXRMXD
 I IOT="HFS" S PXRMHFIO=IO
 S PXRMQUE=$G(IO("Q"))
 S PXRMIOP=ION_";"_$G(IOST)_";"_$G(IO("DOC"))_";"_$G(IOM)_";"_$G(IOSL)
 ;
 I PXRMQUE D  Q
 .;Queue the report.
 . N DESC,ROUTINE,TASK
 . S DESC="Reminder Due Report"
 . S ROUTINE="START^PXRMXSE1"
 . S TASK=$$QUE^PXRMXQUE(DESC,ROUTINE,"","SAVE^PXRMXQUE")
 . Q:TASK=""
 . W !,"Report queued, task number is ",TASK
 I 'PXRMQUE D ^PXRMXSE1
 Q
 ;
 ;===============================
QUE(ZTDESC,ZTRTN,ZTDTH,SAVERTN) ;Queue a task.
 N ZTSK
 ;If ZTIO is not explicitly set to null then %ZTLOAD will open
 ;the device.
 S ZTIO=""
 D @SAVERTN
 D ^%ZTLOAD
 I $D(ZTSK)=0 W !!,DESC," cancelled"
 Q ZTSK
 ;
 ;===============================
SAVE ;Save the variables for queing.
 S ZTSAVE("PXRMBDT")="",ZTSAVE("PXRMEDT")="",ZTSAVE("PXRMSDT")=""
 S ZTSAVE("PXRMCS(")="",ZTSAVE("NCS")=""
 S ZTSAVE("PXRMCGRP(")="",ZTSAVE("NCGRP")=""
 S ZTSAVE("PXRMFAC(")="",ZTSAVE("NFAC")=""
 S ZTSAVE("PXRMFACN(")=""
 S ZTSAVE("PXRMFCMB")=""
 S ZTSAVE("PXRMFUT")="",ZTSAVE("PXRMDLOC")=""
 S ZTSAVE("PXRMFD")=""
 S ZTSAVE("PXRMHFIO")=""
 S ZTSAVE("PXRMINP")=""
 S ZTSAVE("PXRMIO")=""
 S ZTSAVE("PXRMIOP")=""
 S ZTSAVE("PXRMLCHL(")="",ZTSAVE("NHL")=""
 S ZTSAVE("PXRMLCMB")=""
 S ZTSAVE("PXRMLCSC")=""
 S ZTSAVE("PXRMPRIM")=""
 S ZTSAVE("PXRMQUE")=""
 S ZTSAVE("PXRMREP")=""
 S ZTSAVE("PXRMRT")=""
 S ZTSAVE("PXRMSCAT")="",ZTSAVE("PXRMSCAT(")=""
 S ZTSAVE("PXRMSEL")=""
 S ZTSAVE("PXRMSRT")=""
 S ZTSAVE("PXRMSSN")=""
 S ZTSAVE("PXRMTABC")=""
 S ZTSAVE("PXRMTABS")=""
 S ZTSAVE("PXRMTCMB")=""
 S ZTSAVE("PXRMTMP")=""
 S ZTSAVE("PXRMTOT")=""
 S ZTSAVE("PXRMXTMP")=""
 ; Time initiated
 S ZTSAVE("PXRMXST")=""
 ; New selection criteria
 S ZTSAVE("PXRMOTM(")="",ZTSAVE("NOTM")=""
 S ZTSAVE("PXRMPRV(")="",ZTSAVE("NPRV")=""
 S ZTSAVE("PXRMPAT(")="",ZTSAVE("NPAT")=""
 S ZTSAVE("PXRMPCM(")="",ZTSAVE("NPCM")=""
 S ZTSAVE("PXRMREM(")="",ZTSAVE("NREM")=""
 S ZTSAVE("PXRMRCAT(")="",ZTSAVE("NCAT")=""
 S ZTSAVE("PXRMUSER")=""
 ;Reminder list
 S ZTSAVE("REMINDER(")=""
 ; Arrays by IEN
 S ZTSAVE("PXRMLOCN(")=""
 S ZTSAVE("PXRMCSN(")=""
 S ZTSAVE("PXRMCGRN(")=""
 ;Patient List
 S ZTSAVE("PATCREAT")=""
 S ZTSAVE("PATLST")=""
 S ZTSAVE("PXRMLIST(")=""
 S ZTSAVE("PXRMLIS1")=""
 S ZTSAVE("PLISTPUG")=""
 ;User DUZ
 S ZTSAVE("DBDUZ")=""
 S ZTSAVE("DBERR")=""
 S ZTSAVE("PXRMRERR(")=""
 ;Dubug information
 S ZTSAVE("PXRMDBUG")=""
 S ZTSAVE("PXRMDBUS")=""
 ;Patient Information
 S ZTSAVE("PXRMTPAT")=""
 S ZTSAVE("PXRMDPAT")=""
 I +$G(PXRMIDOD)>0 S ZTSAVE("PXRMIDOD")=""
 S ZTSAVE("PXRMPML")=""
 S ZTSAVE("PXRMPER")=""
 S ZTSAVE("PXRMCCS")=""
 S ZTSAVE("PXRMXCCS")=""
 I $D(^TMP("XM-MESS",$J)) S ZTSAVE("^TMP(""XM-MESS"",$J,")=""
 Q
 ;
