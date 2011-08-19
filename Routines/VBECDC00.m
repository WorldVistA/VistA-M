VBECDC00 ;hoifo/gjc-data conversion & pre-implementation;Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$NEWERR^%ZTER is supported by IA: 1621
 ;Call to $$S^%ZTLOAD is supported by IA: 10063
 ;Call to $$NOW^XLFDT is supported by IA: 10103
 ;Call to ^%ZTLOAD is supported by IA: 10063
 ;Call to UPDATE^DIE is supported by IA: 2053
 ;Execution of ^%ZOSF("TEST") is supported by IA: 10096
 ;Direct global read of ^DPT(DFN,"LR") supported by IA: 10035
 ;
START ; entry point queued/not queued.  Update the VBECS DATA INTEGRITY/CONV
 ; ERSION STATISTICS (#6001)
 ;
 ; Note: the variables VBECCNV & VBECIEN are defined in VBECDC01 and
 ; are passed into START subroutine via the ZTSAVE array when calling
 ; ^%ZTLOAD.
 ;
 S:$D(ZTQUEUED) ZTREQ="@"
 ;
 ; initialize error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 ;
 D:VBECCNV EN^VBECDC19(1) ; lock out options when converting data
 ;
 S (CNT,DFN,LRSTOP)=0 S:$G(U)'="^" U="^" K ^TMP("VBEC 63",$J)
 ;
 ;initialize the global that keeps track of ALL data elements for ALL
 ;records
 ;
 K X S $P(X,"0^",28)="",^TMP("VBEC FINIS",$J,0)=X K X
 K ^TMP($J,"VBEC_TR_REACT"),^TMP($J,"VBEC_TR_TRD") S VBTRA=0 F  S VBTRA=$O(^LRD(65,VBTRA)) Q:'VBTRA  D
  . I $P($G(^LRD(65,VBTRA,6)),"^")]"",$P($G(^LRD(65,VBTRA,6)),"^",5)  D
  . . S VBLRDFN=$P(^LRD(65,VBTRA,6),"^"),VBDFN=$P(^LR(VBLRDFN,0),"^",3) Q:$P(^LR(VBLRDFN,0),"^",2)'=2
  . . S ^TMP($J,"VBEC_TR_REACT",VBDFN,VBTRA)=""
 ;
 ;Create an index in the TMP global to make it easier to find Transfusion Reactions by DFN ;RLM 04/20/2005
 ;
 F  S DFN=$O(^DPT(DFN)) Q:DFN'>0  D  Q:LRSTOP
 .;
 .I $$S^%ZTLOAD() S (ZTSTOP,LRSTOP)=1 Q  ; has the user stopped the task?
 .;
 .Q:'$D(^DPT(DFN,"LR"))#2  ; patient w/o Lab Data (#63) file data
 .;
 .S LRDFN=+$G(^DPT(DFN,"LR"))
 .;
 .I LRDFN'>0 D  Q
 ..K LRARY S LRARY(.01)=2,LRARY(.02)=DFN,LRARY(.09)=$P($T(ERRMSG+1^VBECDC02),";",4)
 ..D LOGEXC^VBECDC02(VBECIEN,.LRARY) K LRARY ; log this exception regardless of the task
 ..Q
 .;
 .I $$BRKPNT^VBECDCU1(LRDFN,DFN) D  Q
 ..K LRARY S LRARY(.01)=2,LRARY(.02)=DFN,LRARY(.03)=63,LRARY(.04)=LRDFN
 ..S LRARY(.09)=$P($T(ERRMSG+2^VBECDC02),";",4)
 ..D LOGEXC^VBECDC02(VBECIEN,.LRARY) K LRARY ; log this exception regardless of the task
 ..Q
 .;
 .I '$O(^LR(LRDFN,"BB",0)) Q  ; blood bank data missing for this patient
 .;
  . I 'LRSTOP,$P(^DPT(DFN,0),"^")["MERGING INTO" S DPTNAME=$P(^DPT(DFN,0),"^") D  Q
  . . S VBECMRG=$P($P(DPTNAME,"`",2)," ")
  . . K LRARY S LRARY(.01)=2,LRARY(.02)=DFN,LRARY(.03)=2,LRARY(.04)=VBECMRG,LRARY(.09)=$P($T(ERRMSG+3^VBECDC02),";",4)
  . . D LOGEXC^VBECDC02(VBECIEN,.LRARY) K LRARY ; log this exception
  . . Q
 .;
 .; if the data conversion process is active save off all LAB DATA file
 .; specific data into the appropriate ^TMP("VBEC 63"*,$J) global
 .;
 .I 'LRSTOP,VBECCNV D PAT^VBECDCX(DFN,LRDFN)
 .;
 .;
 .;save off patient specific data for each record in the Lab Data file
 .I VBECCNV D:$D(^TMP("VBEC FINIS",$J,VBECRTOT,0))#2 PATREC(VBECIEN)
 .Q
 ;
 ; kill off unnecessary ^TMP("VBEC 63",$J) global
 K ^TMP("VBEC 63",$J)
 ;
 ; actions if the user teminates process (a check exists within to
 ; execute specific code depending on if the anomaly check or the data
 ; conversion is executing)
 ;
 S VBECANOM=+$O(^VBEC(6001,VBECIEN,"ERR",0)) ; do anomalies exist?
 ;
 ; If the process was stopped by the user via TaskMan (1)
 ; If errored out, LRSTOP=-1 (set in ERR^VBECDCU1)
 I LRSTOP=1 D STOPPED^VBECDC01
 ;
 ; If the process has completed without user intervention:
 I 'LRSTOP D
 .;
 .; 1-if data to convert, save off the ^TMP("VBEC"*,$J) namespaced
 .;   global into system level files to be extracted by SQL Server
 .;   (make sure data tabulation globals are saved off properly)
 .I VBECCNV,($$DATA^VBECDCU1($J)) D
 ..S VBECNUSB=+$O(^TMP("VBEC FINIS",$J,$C(32)),-1)+1
 ..S ^TMP("VBEC FINIS",$J,0)=^TMP("VBEC FINIS",$J,0)_$C(13)
 ..S ^TMP("VBEC FINIS",$J,VBECNUSB,0)=^TMP("VBEC FINIS",$J,0)
 ..K VBECNUSB,^TMP("VBEC FINIS",$J,0)
 ..D SAVE^VBECDCU1 ;(1)
 ..;the last record in the VBEC FINIS file will be be comprised of the
 ..;totals for all data elements for all records.
 ..Q
 .;
 .; 2-if there is no data to convert, let the user know via an alert.
 .I VBECCNV,('$$DATA^VBECDCU1($J)) D
 ..D ALERT^VBECDCU(DUZ,VBECCNV,VBECANOM,-1) ;(2)
 ..Q
 .;
 .; 3-if there are anomalies, regardless of whether the anomaly check
 .;   or data conversion was run, inform the user via an alert.
 .E  D ALERT^VBECDCU(DUZ,VBECCNV,VBECANOM,"") ;(3)
 .;
 .; 4-file the date/time the data conversion/anomaly check finished
 .D UP6001F^VBECDC02(VBECIEN,+$E($$NOW^XLFDT(),1,12)) ;(4)
 .Q
 ;
XIT ; clean up symbol table, exit routine
 K CNT,DFN,LRD1,LRDFN,LRSTOP,VBECANOM,VBECIEN,VBECRTOT
 Q
 ;
PATREC(VBECIEN) ;file patient specific Lab Data file data into the DATA
 ;CONVERSION STATISTIC multiple (6001.02)
 ;Input: VBECIEN=the record number of the data conversion
 S LRTMP=$G(^TMP("VBEC FINIS",$J,VBECRTOT,0))
 S LRIEN="+"_LRDFN_","_VBECIEN_","
 S LROOT(1,6001.02,LRIEN,.01)=$P(LRTMP,U)
 F I=2:1:27 S LROOT(1,6001.02,LRIEN,I)=$P(LRTMP,U,I)
 D UPDATE^DIE("E","LROOT(1)","")
 K I,LRIEN,LROOT,LRTMP
 Q
