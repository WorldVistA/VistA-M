PRSNCGP ;WOIFO-JAH - Release POC Record corrections for VANOD;11/03/09
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
CRELEASE ; Routine provides functionality to release corrected records for
 ; VANOD extraction. These are daily records with a CORRECTION STATUS
 ; of Approved for a Day
 ;
 ;    Prompt Coordinator for Divisions to release (one, many, all) 
 ;
 N PRSINST,PPI,PPS,MMR,INSTCC
 ;
 D GETDIV^PRSNCGR(.PRSINST) Q:PRSINST<0
 ;
 ; Check all pay periods with approved corrections to released records.
 ;
 D PRECHK(.INSTCC,.PRSINST)
 ;
 ; do prelimary report of record status
 ;
 D CNTREP(.INSTCC)
 Q:$G(INSTCC)=0
 ;
 S X=$$ASK^PRSLIB00() Q:X
 ;
 ;    prompt for mismatch report 
 ;
 S MMR=$$ASKMM^PRSNCGR() Q:MMR<0
 ;
 I MMR D
 . N %ZIS,POP,IOP
 . S %ZIS="MQ"
 . D ^%ZIS
 . Q:POP
 . I $D(IO("Q")) D
 .. K IO("Q")
 .. N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 .. S ZTDESC="PRSN POC/ETA MISMATCH REPORT FOR POC CORRECTIONS"
 .. S ZTRTN="MMREP^PRSNCGP"
 .. S ZTSAVE("PRSINST(")=""
 .. D ^%ZTLOAD
 .. I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 . E  D
 .. D MMREP
 ;
 I $$SUREQ^PRSNCGR() D
 . N %ZIS,POP,IOP
 . S %ZIS="MQ"
 . D ^%ZIS
 . Q:POP
 . I $D(IO("Q")) D
 .. K IO("Q")
 .. N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 .. N ZTDESC,ZTRTN,ZTSAVE
 .. S ZTDESC="PRSN POC/ETA MISMATCH REPORT"
 .. S ZTRTN="DRIVER^PRSNCGP"
 .. S ZTSAVE("PRSINST(")=""
 .. D ^%ZTLOAD
 .. I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 .E  D
 .. D DRIVER
 Q
DRIVER ;
 N REC,CNT,FIELD,SEGCNT,PC,CI,SN
 U IO
 S REC=0
 F  S REC=$O(PRSINST(REC)) Q:REC'>0  D
 .  S CI=+PRSINST(REC)
 .  D GETS^DIQ(4,CI_",","99","E","FIELD(",,)
 .  S SN=FIELD(4,CI_",",99,"E")
 .  S CNT(CI)="0^0"
 .;
 .;  loop thru Approved Daily Corrections index (sorted by Division,
 .;  pay period, nurse, day number)
 .;
 .  S (SEGCNT,PPI,RECCNT)=0
 .  F  S PPI=$O(^PRSN(451,"ACA",CI,PPI)) Q:PPI'>0  S PRSIEN=0 F  S PRSIEN=$O(^PRSN(451,"ACA",CI,PPI,PRSIEN)) Q:PRSIEN'>0  D
 ..    S $P(CNT(CI),U)=$P(CNT(CI),U)+1
 ..;
 ..; build node with days corrected
 ..;
 ..    K CDS
 ..    S I=0
 ..    F  S I=$O(^PRSN(451,"ACA",CI,PPI,PRSIEN,I)) Q:I'>0  D
 ...     S CDS(I)=""
 ..;
 ..;  get all records for the pay period
 ..;
 ..    K PC D EXTRECS^PRSNCGR(.PC,.RECCNT,PPI,PRSIEN)
 ..;
 ..;  trim days from PC that aren't impacted by corrections
 ..;
 ..   D TRIMPC(.PC,.CDS,PRSIEN)
 ..;
 ..; note that day 15 has data and we need to determine whether
 ..; to file that days correction after filing for this pp
 ..    S PCNX=0 I $D(PC(15)) S PCNX=1 K PC(15)
 ..;
 ..;   file all corrections in PC array 
 ..;
 ..    D FILEPP^PRSNCGR1(.PC,PRSIEN,PPI,CI,SN)
 ..;
 ..;   increment counter
 ..;
 ..    S $P(CNT(CI),U,2)=$P(CNT(CI),U,2)+$$PCCOUNT(.PC)
 ..;
 ..;  update daily POC record status from approved to released
 ..;
 ..    D UPDTPOC(.PC,PPI,PRSIEN,"R")
 ..;
 ..; File and update for day one of next pp, if necessary.
 ..; If there is correction data from a two day tour of current pay
 ..; period that impacts day 1 of next pay period and that pay
 ..; period has been released then we need to include any data
 ..; that is explicitly recorded on that day.  If there is also
 ..; a correction on that day or that pay period is not released
 ..; then we need do nothing as the release of that correction or pp
 ..; will pick up the two day tour spillover.
 ..;
 ..  S NXTPPSTA=$P($G(^PRSN(451,PPI+1,"E",PRSIEN,0)),U,2)
 ..  S NXTPPDAT=$D(^PRSN(451,PPI+1,"E",PRSIEN,"D",1,0))
 ..  S NXTPPCOR=$D(^PRSN(451,"ACA",CI,PPI+1,PRSIEN,1))
 ..    I PCNX,'NXTPPCOR,NXTPPSTA="R",NXTPPDAT D
 ...      K PC D EXTRECS^PRSNCGR(.PC,.SEGCNT,PPI+1,PRSIEN)
 ...;only need day one, so kill the rest
 ...      N I F I=0,2:1:15 K PC(I)
 ...      D FILEPP^PRSNCGR1(.PC,PRSIEN,PPI+1,CI,SN)
 ...      S $P(CNT(CI),U,2)=$P(CNT(CI),U,2)+$$PCCOUNT(.PC)
 ...      D UPDTPOC(.PC,PPI+1,PRSIEN,"R")
 D RESULTS(.CNT)
 ;
 D ^%ZISC
 Q
 ;
MMREP ;
 N REC,CNT,FIELD,SEGCNT,PC,PPI,CI,PG,OUT,SN
 U IO
 S (PG,REC,OUT)=0
 F  S REC=$O(PRSINST(REC)) Q:REC'>0!OUT  D
 .  S CI=+PRSINST(REC)
 .  D GETS^DIQ(4,CI_",","99","E","FIELD(",,)
 .  S SN=FIELD(4,CI_",",99,"E")
 .  S PRSIEN=0
 .  S PPI=0
 .  F  S PPI=$O(^PRSN(451,"ACA",CI,PPI)) Q:PPI'>0!OUT  D
 ..    S PRSIEN=0
 ..    F  S PRSIEN=$O(^PRSN(451,"ACA",CI,PPI,PRSIEN)) Q:PRSIEN'>0!OUT  D
 ...      D PPMM^PRSNRMM(PRSIEN,PPI,.PG,.OUT)
 ;
 D ^%ZISC
 Q
 ;
TRIMPC(PC,CDS,PRSIEN) ;Trim days from pay per array that are not either
 ; a corrected day or a day impacted by the correction
 ; i.e., we must resend days that have time from a corrected day
 ; that cross midnight into them.
 ;
 N PRSD,CORSPIL
 S PRSD=0
 F  S PRSD=$O(PC(PRSD)) Q:PRSD'>0  D
 .  S CORSPIL=0
 .;
 .; if prior day is a correction with spillover we must include today
 .;
 .  I $D(CDS(PRSD-1)),$$SPILLOVR($G(PC(PRSD-1)),PRSD-1) S CORSPIL=1
 .;
 .; kill days that aren't part of the correction set
 .;
 .  I '$D(CDS(PRSD))&('CORSPIL) K PC(PRSD)
 ; 
 Q
SPILLOVR(SEGS,I) ; return true if a segment on this day crosses midnight
 N SPILL,J
 S (SPILL,J)=0
 F  S J=$O(SEGS(I,J)) Q:J'>0!SPILL  D
 .  I $P(SEGS(I,J),U,10)>2400 S SPILL=1
 Q SPILL
 ;
PCCOUNT(ARRAY2D) ; COUNT records in 2D array with integer subscripts
 N I,J,CNT
 S (CNT,I)=0
 F  S I=$O(ARRAY2D(I)) Q:I'>0  D
 .  S J=0 F  S J=$O(ARRAY2D(I,J)) Q:J'>0  D
 ..   S CNT=CNT+1
 Q CNT
RESULTS(CNT) ; Print results of the Release
 N DIVI,DIVE,I,F,X,STNAME,STNUM
 W @IOF,!!,?14,"POC CORRECTED RECORDS RELEASED RESULTS"
 W !,?14,"======================================"
 W !!,?30,"TOTAL",?42,"TOTAL"
 W !,?4,"DIVISION",?30,"NURSES",?42,"RECORDS"
 W !,?4,"========",?30,"======",?42,"======="
 N I S I=0
 F  S I=$O(CNT(I)) Q:I'>0  D
 .  D GETS^DIQ(4,I_",",".01;99","EI","F(",,)
 .  S STNUM=F(4,I_",",99,"E"),STNAME=F(4,I_",",.01,"E")
 .  W !,?4,STNAME," (",STNUM,")",?30,$P(CNT(I),U),?44,$P(CNT(I),U,2)
 W !!! S X=$$ASK^PRSLIB00(1)
 Q
PRECHK(INSTCC,PRSINST) ; Count up corrections by division
 ;
 ;  INPUT:
 ;    PRSINST (required) array of institutions to check
 ;  OUTPUT:
 ;    INSTCC (returned by reference) Institution correction counts
 ;         e.g.,  INSTCC(500)=32 
 ;                INSTCC(16473)=10 
 ;         Where the node is the institution # and it is set equal
 ;         to the total number of corrections across all released
 ;         pay periods.
 ;
 N REC,CNT,FIELD,STOP
 ;
 S (INSTCC,I)=0
 F  S I=$O(PRSINST(I)) Q:I'>0  D
 .  S INSTCC(+PRSINST(I))=0
 ;
 S I=0
 F  S I=$O(INSTCC(I)) Q:I'>0  D
 .  S PPI=0
 .  F  S PPI=$O(^PRSN(451,"ACA",I,PPI)) Q:PPI'>0  D
 ..  S PRSIEN=0
 ..  F  S PRSIEN=$O(^PRSN(451,"ACA",I,PPI,PRSIEN)) Q:PRSIEN'>0  D
 ...    S INSTCC=INSTCC+1
 ...    S INSTCC(I)=INSTCC(I)+1
 Q
CNTREP(INSTCC) ;
 N I,STNUM,STNAME,X
 W @IOF,!!!,?20,"CORRECTION TOTALS BY DIVISION"
 W !,?20,"============================="
 ;
 W !!,"DIVISION",?30,"# OF DAILY"
 W !,?30,"DAILY CORRECTIONS"
 S I=0
 F  S I=$O(INSTCC(I)) Q:I'>0  D
 .  D GETS^DIQ(4,I_",",".01;99","EI","F(",,)
 .  S STNUM=F(4,I_",",99,"E"),STNAME=F(4,I_",",.01,"E")
 .  W !,?4,STNAME," (",STNUM,")"
 .  W ?30,$J(INSTCC(I),10,0)
 I $G(INSTCC)=0 D
 .  W !!,"  No approved corrections are ready for release."
 .  W !!! S X=$$ASK^PRSLIB00(1)
 Q
UPDTPOCD(PPI,PRSIEN,PRSD,PRSV,STATUS) ; update DAILY RECORD status for POC records
 ; INPUT :
 ;    PPI,PRSIEN,PRSD : Standard
 ;    PRSV : (optional) if STATUS is (A)pproved PRSV must be defined
 ;                      to the version number of the POC record
 ;    STATUS: (optional) : set to (A)pproved
 ;                                (R)eleased
 ;                                (E)ntered
 ;                                Null (remove status)
 ;
 N IENS,PRSFDA
 S IENS=PRSD_","_PRSIEN_","_PPI_","
 I STATUS="" S STATUS="@"
 S PRSFDA(451.99,IENS,1)=STATUS
 D UPDATE^DIE("","PRSFDA","IENS"),MSG^DIALOG()
 I STATUS="A"&(PRSV>0) D
 .;  update approver and date time of approval
 .  K IENS,PRSFDA N %
 .  S IENS=PRSV_","_PRSD_","_PRSIEN_","_PPI_","
 .  S PRSFDA(451.999,IENS,1)=DUZ
 .  D NOW^%DTC
 .  S PRSFDA(451.999,IENS,2)=%
 .  D UPDATE^DIE("","PRSFDA","IENS"),MSG^DIALOG()
 Q
UPDTPOC(PC,PPI,PRSIEN,STATUS) ; update POC daily record status
 N IENS,FDA
 S I=0
 F  S I=$O(PC(I)) Q:I'>0  D
 . S IENS=I_","_PRSIEN_","_PPI_","
 . S FDA(451.99,IENS,1)=STATUS
 D UPDATE^DIE("","FDA","IENS"),MSG^DIALOG()
 Q
