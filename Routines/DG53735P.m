DG53735P ;EG,TMK - Re-transmit OEF-OIF Data to HEC ; 10/24/2006
 ;;5.3;Registration;**735**;Aug 13,1993;Build 11
 ; LOGIC USED:
 ; - Find all veterans with OEF/OIF data using the 'ALOEIF;' cross
 ;     reference by latest OEF/OIF TO DATE and patient
 ; - Check the PATIENT file (#2) record for a valid CV end date.
 ; - If the CV end date is not valid, or
 ;    If the CV End Date is valid, but the last Z07 message transmission
 ;      for the veteran was dated before the OEF/OIF data was added,
 ;   Flag the record so it will be sent to HEC via an HL7 Z07 message
 ;    and if the CV End date was not valid, update it to be the
 ;    calculated value.
 ;
EP ; Queue the conversion
 N %
 S %=$$NEWCP^XPDUTL("IEN12","POST^DG53735P")
 S %=$$NEWCP^XPDUTL("END","END^DG53735P") ; Leave as last update
 Q
 ;
POST N ZTSK
 D BMES^XPDUTL("Queue-ing Transmit OEF/OIF data to HEC ...")
 D QUE
 D BMES^XPDUTL("This request queued as Task # "_$G(ZTSK))
 D BMES^XPDUTL("=====================================================")
 D BMES^XPDUTL("")
 Q
 ;
END ; Post-install done
 D BMES^XPDUTL("Post install complete.")
 Q
 ;
QUE N ZTRTN,ZTDESC,ZTSAVE,ZTIO,ZTDTH
 S ZTRTN="RUN^DG53735P",ZTDESC="Re-transmit of OEF/OIF Data"
 S ZTIO="",ZTDTH=$$NOW^XLFDT()
 D ^%ZTLOAD
 Q
 ;
RUN ;entry point from taskman
 N NAMSPC
 S NAMSPC=$$NAMSPC
 I '$$CHKSTAT(1,NAMSPC) D  Q
 . D BMES^XPDUTL("Conversion routine already running, process aborted")
 N TESTING
 S TESTING="N" K ^XTMP(NAMSPC) D DEQUE(NAMSPC)
 Q
 ;
TEST ; test entry point
 N TESTING,X,STARTDT,ENDDT,NAMSPC
 S NAMSPC=$$NAMSPC
 S TESTING="Y"
 S X=$$CHKSTAT(0,NAMSPC)
 K ^XTMP(NAMSPC,"TEST RANGE"),^XTMP(NAMSPC,"TEST")
 S STARTDT=$$TESTID("Starting ")
 Q:'STARTDT
 S ENDDT=$$TESTID("Ending ")
 Q:'ENDDT
 I ENDDT<STARTDT W !,?10,"Ending To Date can't be less than starting To Date" Q
 S ^XTMP(NAMSPC,"TEST RANGE")=STARTDT_U_ENDDT
 D DEQUE(NAMSPC)
 Q
 ;
TESTID(MESS) ;
 N DGX,DIR,DTOUT,DUOUT,X,Y
 S DIR(0)="DA",DIR("A")=MESS_" To Date for OEF/OIF xref: "
 W !! D ^DIR K DIR
 S DGX=Y
 I $D(DUOUT)!$D(DTOUT) S DGX=""
 Q DGX
 ;
DEQUE(NAMSPC) ;
 N X
 I '$D(TESTING) N TESTING S TESTING="N"
 D SETUPX(90,NAMSPC)
 S X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,6)="RUNNING"
 S $P(X,U,7)=$$NOW^XLFDT()
 S ^XTMP(NAMSPC,0,0)=X
 ;
 S ZTSTOP=$$LOOP(NAMSPC,TESTING)
 S X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,6)=$S(ZTSTOP:"STOPPED",1:"COMPLETED")
 S $P(X,U,8)=$$NOW^XLFDT()
 S ^XTMP(NAMSPC,0,0)=X
 ;
 D MAIL(NAMSPC,TESTING,DUZ)
 K TESTING
 L -^XTMP(NAMSPC)
 Q
 ;
SETUPX(EXPDAYS,NAMSPC) ; 
 ; requires EXPDAYS - # of days to keep XTMP
 N BEGTIME,PURGDT
 S BEGTIME=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGTIME,EXPDAYS)
 S ^XTMP(NAMSPC,0)=PURGDT_U_BEGTIME
 S $P(^XTMP(NAMSPC,0),U,3)="Transmit unsent OEF/OIF data to HEC"
 Q
 ;
LOOP(NAMSPC,TESTING) ;
 ;returns stop flag
 N X,XREC,LASTREC,TOTREC,TOTPAT
 S LASTREC="0;0;;0;0",ZTSTOP=0
 S TOTREC=0
 I $D(^XTMP(NAMSPC,0,0)) D
 . S XREC=$G(^XTMP(NAMSPC,0,0))
 . ;last TODT processed
 . S LASTREC=$P(XREC,U,1)
 . ;total records read
 . S TOTREC=+$P(XREC,U,2)
 . S TOTPAT=+$P(XREC,U,10)
 . Q
 D ALOEIF(NAMSPC,TESTING,.ZTSTOP)
 Q ZTSTOP
 ;
ALOEIF(NAMSPC,TESTING,ZTSTOP) ;
 N CONF,DFN,END,FIRST,FRDT,IEN,TODT,X
 S ZTSTOP=0
 S TODT=$P(LASTREC,";"),END=9999999
 I $G(TESTING)="Y" D
 . S X=$G(^XTMP(NAMSPC,"TEST RANGE"))
 . I $L(X) S TODT=$P(X,U,1)-1,END=$P(X,U,2)
 S FIRST("FRDT")=$P(LASTREC,";",2),FIRST("CONF")=$P(LASTREC,";",3),FIRST("DFN")=$P(LASTREC,";",4),FIRST("IEN")=$P(LASTREC,";",5)
 F  S TODT=$O(^DPT("ALOEIF",TODT)) Q:'TODT!ZTSTOP  S:TODT>END ZTSTOP=2 Q:ZTSTOP  S FRDT=FIRST("FRDT"),FIRST("FRDT")=0 F  S FRDT=$O(^DPT("ALOEIF",TODT,FRDT)) Q:'FRDT!ZTSTOP  S CONF=FIRST("CONF"),FIRST("CONF")="" D
 . F  S CONF=$O(^DPT("ALOEIF",TODT,FRDT,CONF)) Q:CONF=""!ZTSTOP  S DFN=FIRST("DFN"),FIRST("DFN")=0 F  S DFN=$O(^DPT("ALOEIF",TODT,FRDT,CONF,DFN)) Q:'DFN!ZTSTOP  S IEN=FIRST("IEN"),FIRST("IEN")=0 D
 .. F  S IEN=$O(^DPT("ALOEIF",TODT,FRDT,CONF,DFN,IEN)) Q:'IEN!ZTSTOP  D CHKR(DFN,IEN)
 Q
 ;
CHKR(DFN,IEN) ;
 N X,CEN,CALC
 ; Assume TODT,FRDT,CONF,TOTREC,LASTREC,TOTPAT,NAMSPC are defined
 S TOTREC=TOTREC+1
 ;
 ; Chk for correct CV End Date
 I '$$CHPAT(DFN,.CEN,.CALC) D
 . D TRANSMIT(DFN)
 ;
 E  D  ; If CV End Date OK, must be transmitted after OEF/OIF filed
 . N LD,LTR,LOEIF
 . S LD=$$YEAR^IVMPLOG(DFN),LTR=$P($G(^IVM(301.5,+$O(^IVM(301.5,"APT",DFN,+LD,0)),0)),U,5)
 . S LOEIF=$P($G(^DPT(DFN,.3215,IEN,0)),U,5)
 . I $S('LD!'LTR:1,LOEIF>LTR:1,1:0) D
 .. D SET(DFN,CEN,CALC,"OEF/OIF DATA NOT TX")
 .. D TRANSMIT(DFN)
 ;
 S LASTREC=TODT_";"_FRDT_";"_CONF_";"_DFN_";"_IEN
 D UPDATEX(NAMSPC,TOTREC,LASTREC,TOTPAT)
 ;
 I (TOTREC#100)=0 S ZTSTOP=$$STOP(NAMSPC)
 Q
 ;
TRANSMIT(DFN) ;
 S TOTPAT=TOTPAT+1
 Q:TESTING="Y"  ; No update
 D EVENT^IVMPLOG(DFN)
 Q
 ;
CHPAT(DFN,CEN,CALC) ; Function returns:
 ;   0 if no CV End date or CV End date not correct
 ;   1 if CV End Date correct
 ; Also returns CEN=CV END DATE ON FILE   CALC=CALCULATED CV END DATE
 ;
 N DGARRY,DGOK,X
 S (CEN,CALC)=""
 S CEN=$P($G(^DPT(DFN,.52)),U,15)
 S CALC=$$CVDATE^DGCVRPT(DFN,.DGARRY)
 ;
 I 'CEN D:CALC UPDCVED(NAMSPC,DFN,CEN,CALC) D SET(DFN,CEN,CALC,"CV END DATE MISSING") S DGOK=0
 ;
 I CEN D
 . I $G(DGARRY("OEF/OIF")) D
 .. N LSSD
 .. S LSSD=$G(DGARRY(2,DFN_",",.327,"I"))
 .. I DGARRY("OEF/OIF")>LSSD S ^XTMP(NAMSPC,"DATA",DFN,"MSE DATA MISSING")=CEN_U_CALC
 .. ; Correct CV End Date if value on file is not the calculated value
 .. Q:CEN=CALC
 .. D UPDCVED(NAMSPC,DFN,CEN,CALC)
 . I CEN=CALC S DGOK=1 Q
 . D SET(DFN,CEN,CALC,"CV END DATE INCORRECT")
 . S DGOK=0
 Q DGOK
 ;
UPDCVED(NAMSPC,DFN,CEN,CALC) ; Update CV end date
 N DA,DIE,DR,X,Y
 S DA=DFN,DIE="^DPT(",DR=".5295////"_CALC
 D ^DIE
 S ^XTMP(NAMSPC,"DATA",DFN,"CV END DATE UPDATED TO "_CALC)=CEN
 Q
 ;
SET(DFN,CEN,CALC,REASON) ;
 S ^XTMP(NAMSPC,"DATA",DFN)=CEN_U_CALC_U_REASON
 Q
 ;
UPDATEX(NAMSPC,TOTREC,LASTREC,TOTPAT) ;
 N X
 S X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,1)=$G(LASTREC),$P(X,U,2)=$G(TOTREC)
 S $P(X,U,10)=$G(TOTPAT)
 S ^XTMP(NAMSPC,0,0)=X
 Q
 ;
STATUS ; current run status
 N X,NAMSPC
 S NAMSPC=$$NAMSPC
 S X=$G(^XTMP(NAMSPC,0,0))
 I X="" U 0 W !!,"Task not started!!!" Q
 W !!," Current status: ",$P(X,U,6)
 W !,"  Starting time: ",$$FMTE^XLFDT($P(X,U,7))
 I $P(X,U,8) D
 . W !,"                                  Ending time: ",$$FMTE^XLFDT($P(X,U,8))
 W !!,"                   Total patient records read: ",$P(X,U,2)
 W !,"                   Last ALOEIF xref processed: ",$P(X,U,1)
 W !,"    Total patient records set for re-transmit: ",$P(X,U,10)
 Q
 ;
STOP(NAMSPC) ; returns stop flag
 N X
 S ZTSTOP=0
 I $$S^%ZTLOAD S ZTSTOP=1
 I $D(^XTMP(NAMSPC,"STOP")) S ZTSTOP=1 K ^XTMP(NAMSPC,"STOP")
 I ZTSTOP D
 . S X=$G(^XTMP(NAMSPC,0,0))
 . S $P(X,U,6)="STOPPED",$P(X,U,7)=$$NOW^XLFDT()
 . S ^XTMP(NAMSPC,0,0)=X
 . Q
 Q ZTSTOP
 ;
MAIL(NAMSPC,TESTING,DUZ) ; stats
 N ETIME,STAT,STIME,TOTPAT,TOTREC,X
 S X=$G(^XTMP(NAMSPC,0,0))
 S TOTREC=$P(X,U,2)
 S STAT=$P(X,U,6),STIME=$P(X,U,7)
 S ETIME=$P(X,U,8)
 S TOTPAT=$P(X,U,10)
 ;
 D HDNG(NAMSPC,.LIN,STAT,STIME,ETIME,TESTING)
 D SUMRY(.LIN,TOTREC,TOTPAT,NAMSPC)
 D MAILIT("SUMMARY STATS - TRANSMIT UNSENT OEF/OIF DATA TO HEC",DUZ,NAMSPC)
 K ^TMP(NAMSPC,$J,"MSG")
 Q
 ;
HDNG(NAMSPC,LIN,STAT,STIME,ETIME,TESTING) ; hdr lines
 N HTEXT,TEXT,X
 K ^TMP(NAMSPC,$J,"MSG")
 S LIN=0
 S HTEXT="Transmit unsent OEF/OIF data to HEC "_STAT_" on "
 D BLDLINE(NAMSPC,HTEXT,.LIN)
 S HTEXT=$$FMTE^XLFDT(ETIME)
 D BLDLINE(NAMSPC,HTEXT,.LIN)
 D BLDLINE(NAMSPC,"",.LIN)
 I TESTING="Y" D
 . S TEXT="** TESTING - NO CHANGES MADE TO DATABASE **"
 . D BLDLINE(NAMSPC,TEXT,.LIN)
 D BLDLINE(NAMSPC,"",.LIN)
 Q
 ;
SUMRY(LIN,TOTREC,TOTPAT,NAMSPC) ; summary lines
 N TEXT,X
 S TEXT="                  Total Patient Records Read: "_$J($FN(TOTREC,","),11)
 D BLDLINE(NAMSPC,TEXT,.LIN)
 S TEXT="   Total Patient Records Set for Re-transmit: "_$J($FN(TOTPAT,","),11)
 D BLDLINE(NAMSPC,TEXT,.LIN)
 Q
 ;
BLDLINE(NAMSPC,TEXT,LIN) ;bld line in TMP
 S LIN=LIN+1
 S ^TMP(NAMSPC,$J,"MSG",LIN)=TEXT
 Q
 ;
MAILIT(HTEXT,DUZ,NAMSPC) ; send mail msg
 N XMY,XMDUZ,XMSUB,XMTEXT
 S XMY(DUZ)="",XMDUZ=.5
 S XMY("G.DGEN ELIGIBILITY ALERT")=""
 S XMSUB=HTEXT
 S XMTEXT="^TMP(NAMSPC,$J,""MSG"","
 D ^XMD
 Q
 ;
CHKSTAT(POST,NAMSPC) ;check if job is running, stopped, or complete
 L +^XTMP(NAMSPC):1
 I '$T Q 0
 D KILIT(POST,NAMSPC)
 Q 1
 ;
KILIT(POST,NAMSPC) ;
 I 'POST K ^XTMP(NAMSPC)
 Q
 ;
NAMSPC() ;
 Q $T(+0)
 ;
