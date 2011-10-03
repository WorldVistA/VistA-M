RGEX01 ;BAY/ALS-LIST MANAGER FOR MPI/PD EXCEPTIONS ;10/07/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**3,12,19,23,43,45,47,48,52,57**;30 Apr 99;Build 2
 ;
 ;Reference to MAIN^VAFCPDAT supported by IA #3299
EN ; -- main entry point for RG EXCPT SUMMARY
 N STDT,ENDDT,PRGSTAT,XFLAG,NOW,%,X,%H,%I,INDT,RUN,INDTT
 S XFLAG=0 D NOW^%DTC S NOW=%
 S STDT=$P($G(^RGSITE(991.8,1,"EXCPRG")),"^",1),INDT=STDT
 I $D(STDT) S STDT=$$FMTE^XLFDT(STDT,1)
 S PRGSTAT=$P($G(^RGSITE(991.8,1,"EXCPRG")),"^",3)
 ;status shows 'running' but lock shows 'not running';**47
 I PRGSTAT="R" D
 .L +^RGHL7(991.1,"RG PURGE EXCEPTION"):0 I $T D  ;can get lock
 ..L +^RGSITE(991.8):10
 ..S DIE="^RGSITE(991.8,",DA=1,DR="42///@"
 ..D ^DIE K DA,DIE,DR ;delete old status
 ..L -^RGSITE(991.8)
 ..S PRGSTAT=""
 .L -^RGHL7(991.1,"RG PURGE EXCEPTION")
 I PRGSTAT="" D
 . W $C(7)
 . W !!,"The MPI/PD Exception Purge process has not been run."
 . ;**48 NO LONGER A CHOICE
 . W !!,"The MPI/PD Exception Purge process will now run."
 . W !,"Please come back to this option in five minutes."
 . W !!,"Please contact IRM to schedule the MPI/PD EXCEPTION PURGE"
 . W !,"[RG EXCEPTION PURGE] option via TaskMan with a frequency of once an hour."
 . S XFLAG=1 D QUEPRG
 L +^RGHL7(991.1,"RG PURGE EXCEPTION"):0 I '$T W $C(7),!!,"The MPI/PD Exception Purge process is currently running.",!,"Please try this option again in five minutes." S XFLAG=1 G EXIT
 L -^RGHL7(991.1,"RG PURGE EXCEPTION")
 S RUN=0
 I $G(PRGSTAT)="C" D
 . I $P(INDT,".")<$P(NOW,".") S RUN=1 ;RAN A PREVIOUS DAY
 . I $P(INDT,".")=$P(NOW,".") D
 .. S INDTT=$E($P(INDT,".",2),1,4),INDTT=INDTT+101
 .. I INDTT<$E($P(NOW,".",2),1,4) S RUN=1
 . Q:RUN=0
 . ;** if job ran more than 1 hour ago, run it now.
 . W !!,"The MPI/PD Exception Purge process last ran "_STDT_"."
 . W !!,"The MPI/PD Exception Purge process will now run."
 . W !,"Please come back to this option in five minutes."
 . W !!,"Please contact IRM to verify that the MPI/PD EXCEPTION PURGE "
 . W !,"[RG EXCEPTION PURGE] option is scheduled to run via TaskMan"
 . W !,"with a frequency of once an hour."
 . S XFLAG=1 D QUEPRG
 I XFLAG=1 G EXIT
 K RGANS
 D WAIT^DICD
 D EN^VALM("RG EXCPT SUMMARY")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="MPI/PD Exception Handling"
 S VALMHDR(2)=""
 Q
 ;
INIT ; -- init variables and list array
 I '$D(RGSORT) S RGSORT="SD"
 K @VALMAR
 I RGSORT="SD" D DTLIST^RGEXHND1
 E  I RGSORT="ST" D EXCLST^RGEXHND1
 E  I RGSORT="SN" D PATLST^RGEXHND1
 E  I RGSORT="VT" D SELTYP^RGEXHND1
 Q
 ;
SORT ;
 D INIT
 S VALMBCK="R"
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
HLPPRG ;
 W !,"Enter Y(YES) to run the MPI/PD Exception Purge process now."
 W !!,"Enter N(NO) to go directly into the MPI/PD Exception Handling option."
 Q
 ;
EXIT ; -- exit code
 K VADM,RGDFN,RGNM,RGSORT,RGSSN,STAT,STRING,NDX,NM,IEN,IEN2,X,DATA,CNT,EXCTYPE,ETYPE,^TMP("RGEXC",$J),^TMP("RGEX01",$J)
 Q
QUEPRG S ZTRTN="MAIN^RGEVPRG",ZTDESC="PURGE ZZ*, OVER 30 DAY AND DUPLICATE RECORDS FROM THE CIRN HL7 EXCEPTION LOG FILE"
 D NOW^%DTC
 S ZTIO="",ZTDTH=%
 I $D(DUZ) S ZTSAVE("DUZ")=DUZ
 D ^%ZTLOAD
 D HOME^%ZIS K IO("Q")
 K ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK,%
 Q
 ;
EXPND ; -- expand code
 Q
 ;
CUREX() ;**57 MPIC_1893 The CUREX module is obsolete and is no longer being called.
 ;Are there any patients in the CIRN HL7 EXCEPTION LOG file (#991.1)
 ;that are NOT PROCESSED for specific exception types?
 ;     Return RGEX:
 ;If RGEX=3 both unprocessed and Primary View Reject exceptions exist
 ;If RGEX=2 only Primary View Reject exceptions exist
 ;If RGEX=1 only unprocessed exceptions exist
 ;If RGEX=0 no unprocessed exceptions exist
 ;
 ;N EXCTYP,RG1,RG2,RGEX
 ;S EXCTYP="",(RG1,RG2,RGEX)=0
 ;F  S EXCTYP=$O(^RGHL7(991.1,"ASTAT","0",EXCTYP)) Q:'EXCTYP  D
 ;.I (EXCTYP=234)!(EXCTYP=218) S RG1=1 ;**52 MPIC_772 remove 215, 216 & 217
 ;.I (EXCTYP=234) S RG2=1 ;Primary View Reject
 ;I (RG1=1),(RG2=1) S RGEX=3 ;Send both messages
 ;I (RG1=1),(RG2=0) S RGEX=1 ;Only unresolved exceptions exist
 ;I (RG1=0),(RG2=1) S RGEX=2 ;Only Primary View Reject exceptions exist
 S RGEX=0 Q RGEX
 ;
PROC ; For a given patient, set exceptions STATUS to PROCESSED.
 ;**52 The PROC module is obsolete and is no longer being called.
 ; DFN must be defined
 ;Q:'$D(DFN)
 ;S EXCTYP=""
 ;S HOME=$$SITE^VASITE()
 ;F  S EXCTYP=$O(^RGHL7(991.1,"ADFN",EXCTYP)) Q:'EXCTYP  D
 ;. S RGDFN="",ICN=""
 ;. F  S RGDFN=$O(^RGHL7(991.1,"ADFN",EXCTYP,RGDFN)) Q:'RGDFN  D
 ;.. I DFN=RGDFN D
 ;... S ICN=+$$GETICN^MPIF001(DFN)
 ;... ;Only set to PROCESSED if patient has national ICN.
 ;... I $E(ICN,1,3)'=$E($P(HOME,"^",3),1,3)&(ICN>0) D
 ;.... ;Exclude Death exceptions (215-217); they must be processed manually.
 ;.... ;Exclude 218 Potential Matches Returned exception **43
 ;.... I (EXCTYP>218)!(EXCTYP<215) D
 ;..... S IEN=0
 ;..... F  S IEN=$O(^RGHL7(991.1,"ADFN",EXCTYP,RGDFN,IEN)) Q:'IEN  D
 ;...... S IEN2=0
 ;...... F  S IEN2=$O(^RGHL7(991.1,"ADFN",EXCTYP,RGDFN,IEN,IEN2)) Q:'IEN2  D
 ;....... L +^RGHL7(991.1,IEN):10
 ;....... S DA(1)=IEN,DA=IEN2,DR="6///"_1,DIE="^RGHL7(991.1,"_DA(1)_",1,"
 ;....... D ^DIE K DIE,DA,DR
 ;....... L -^RGHL7(991.1,IEN)
 ;K IEN,IEN2,RGDFN,EXCTYP,ICN
 Q
PDAT ;
 K DIRUT
 W !,"This report prints MPI/PD Data for a selected patient.  The"
 W !,"information displayed includes the Integration Control Number"
 W !,"(ICN), patient identity information, and Treating Facility list."
 W !!,"The information is pulled from the Patient (#2) file and the"
 W !,"Treating Facility List (#391.91) file."
 ;
ASK ;Ask for PATIENT
 I $D(DIRUT) G QUIT
 W !!,"Patient lookup can be done by Patient Name/SSN or by ICN.",!
 N DFN,ICN
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: ",D="SSN^AICN^B^BS^BS5"
 D MIX^DIC1 K DIC
 G:Y<0 QUIT
 S DFN=+Y
 D MAIN^VAFCPDAT
 G ASK
 Q
QUIT ;
 K DFN,ICN,D,Y,HOME
