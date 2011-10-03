SCRPI02 ;ALB/SCK - Incomplete Encounter Mgmt Statistical Summary Report ; 2/4/97
 ;;5.3;Scheduling;**66**;AUG 13, 1993
 ;
EN ; Entry point for summary report
 ;  Variables
 ;     VAUTD,VAUTC - VA variables
 ;     SDDT        - Date range, Begin^End
 ;     SDRTYP      - Report type S - Summary Only
 ;                               D - Summary with Detail
 ;
 N VAUTD,VAUTC,SDDT,ZTSAVE,SDRTYP
 ;
 W !!,"Select Summary Report Only, or Summary Report with Detail",!
 Q:$$REPORT(.SDRTYP)'>-1
 ;
 S:SDRTYP["S" (VAUTD,VAUTC)=1
 I SDRTYP["D",$$DIV^SCRPIUT1<0 G ENQ
 I SDRTYP["D",$$CLN^SCRPIUT1<0 G ENQ
 ;
 I '$$ASKDT(.SDDT) G ENQ
 W !
 F X="SDDT","VAUTC","VAUTD","VAUTC(","VAUTD(","SDRTYP" D
 . S ZTSAVE(X)=""
 ;
 D EN^XUTMDEVQ("RPT^SCRPI02","IEMM Summary Error Report",.ZTSAVE)
 D HOME^%ZIS
ENQ Q
 ;
ENBLT ;  Entry point for bulletin generation of summary only report
 ;  Variables
 ;     SDBLT  - Flag to send output to a bulletin
 ;     SDRTYP - See above
 ;     SDDT   - See above
 ;
 N SDBLT,VAUTC,VAUTD,SDRTYP,SDDT
 ;
 S SDBLT=1,SDRTYP="S",(VAUTD,VAUTC)=1
 S SDDT=$$FMADD^XLFDT($$DT^XLFDT,-2)_"^"_$$DT^XLFDT
 D RPT^SCRPI02
 Q
 ;
RPT ; Entry point for building the summary report
 N SCCNT
 ;
 K ^TMP("SCRPI SUM",$J)
 S SCCNT=0
 Q:"SD"'[SDRTYP
 ;
 I '$G(SDBLT) I '$D(ZTQUEUED),IOST?1"C-".E  D WAIT^DICD
 D BLD,BLDDEL
 D PRINT^SCRPI02A
 ;
EXIT ;
 K ^TMP("SCRPI SUM",$J)
 Q
 ;
BLD ; Search for errors in the transmitted outpatient encounter error file 
 ; and begin building the report
 ;
 ;   Variables
 ;       SDEND  - Ending date of date range
 ;       SDOEDT - Encounter date
 ;       SDOE   - Encounter IEN in #409.68
 ;
 ;   Output
 ;       ^TMP("SCRPI SUM",$J,Division Name,Clinic Name,0)=P1^P2^P3^P4
 ;          P1 - Total Incomplete Encounters
 ;          P2 - Total Incomplete Deleted Encounters
 ;          P3 - Total Encounters
 ;          P4 - Total Deleted Encounters
 ;
 N SDEND,SDOE,SDOEDT
 ;
 S SDCNT=0
 S SDOEDT=$P(SDDT,U)-.1,SDEND=$P(SDDT,U,2)+.9
 F  S SDOEDT=$O(^SCE("B",SDOEDT)) Q:'SDOEDT!(SDOEDT>SDEND)  D
 . S SDOE=0 F  S SDOE=$O(^SCE("B",SDOEDT,SDOE)) Q:'SDOE  D
 .. Q:'$D(^SD(409.73,"AENC",SDOE))
 .. S SDIV=+$P($G(^SCE(SDOE,0)),U,11) Q:'SDIV
 .. S SDIVN=$P($G(^DG(40.8,SDIV,0)),U)
 .. Q:$S(VAUTD:0,$D(VAUTD(SDIV)):0,1:1)
 .. S SDDCL=+$P($G(^SCE(SDOE,0)),U,4) Q:'SDDCL
 .. S SDDCLN=$P($G(^SC(SDDCL,0)),U)
 .. Q:$S(VAUTC:0,$D(VAUTC(SDDCL)):0,1:1)
 .. S SDXMT=$O(^SD(409.73,"AENC",SDOE,0)) Q:'$D(^SD(409.73,SDXMT))
 .. S $P(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0),U,3)=+$P($G(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0)),U,3)+1
 .. Q:'$D(^SD(409.75,"B",SDXMT))
 .. S $P(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0),U)=+$P($G(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0)),U)+1
 .. D ADD(SDXMT,SDIV,SDIVN,SDDCL,SDDCLN,1)
 Q
 ;
BLDDEL ; Search for entries in the Deleted Outpatient Encounter File and add to
 ; the report.
 ;  Variables
 ;      See list in BLD
 ;
 N SDOEDT,SDEND,SDOE
 ;
 S SDCNT=0
 S SDOEDT=$P(SDDT,U)-.1,SDEND=$P(SDDT,U,2)+.9
 F  S SDOEDT=$O(^SD(409.74,"B",SDOEDT)) Q:'SDOEDT!(SDOEDT>SDEND)  D
 . S SDOE=0 F  S SDOE=$O(^SD(409.74,"B",SDOEDT,SDOE)) Q:'SDOE  D
 .. Q:'$D(^SD(409.73,"ADEL",SDOE))
 .. S SDIV=+$P($G(^SD(409.74,SDOE,1)),U,11) Q:'SDIV
 .. S SDIVN=$P($G(^DG(40.8,SDIV,0)),U)
 .. Q:$S(VAUTD:0,$D(VAUTD(SDIV)):0,1:1)
 .. S SDDCL=+$P($G(^SD(409.74,SDOE,1)),U,4) Q:'SDDCL
 .. S SDDCLN=$P($G(^SC(SDDCL,0)),U)
 .. Q:$S(VAUTC:0,$D(VAUTC(SDDCL)):0,1:1)
 .. S SDXMT=$O(^SD(409.73,"ADEL",SDOE,0)) Q:'$D(^SD(409.73,SDXMT))
 .. Q:'$D(^SD(409.75,"B",SDXMT))
 .. S $P(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0),U,4)=+$P($G(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0)),U,4)+1
 .. D ADD(SDXMT,SDIV,SDIVN,SDDCL,SDDCLN,2)
 Q
 ;
ADD(SDXMT,SDIV,SDIVN,SDDCL,SDDCLN,SDPCE) ;  Add error entries from #409.75
 ;  for transmission entry.
 ;   Input
 ;       SDXMT   - Pointer to #409.75
 ;       SDIV    - Division IEN
 ;       SDIVN   - Division Name
 ;       SDDCL   - Clinic IEN
 ;       SDDCLN  - Clinic Name
 ;       SDPCE   - Piece to increment in ^TMP("SCRPI SUM",$J...
 ;                  1 - Incomplete Encounter (P1)
 ;                  2 - Deleted Incomplete Encounter (P2)
 ;
 ;   Output
 ;    ^TMP("SCRPI SUM",$J,Div Name, Clin Name, Error Table IEN,0)=P1^P2
 ;
 ;   Variables
 ;       SCDE  - #409.75 IEN
 ;       SCER  - Pointer to #409.76
 ;
 N SCDE,SCER
 ;
 S SCDE=0 F  S SCDE=$O(^SD(409.75,"B",SDXMT,SCDE)) Q:'SCDE  D
 . S SCER=$P($G(^SD(409.75,SCDE,0)),U,2) Q:'SCER
 . S $P(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,SCER,0),U,SDPCE)=+$P($G(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,SCER,0)),U)+1
 . S SDCNT=SDCNT+1
 . I '$D(ZTQUEUED),(IOST?1"C-".E),(SDCNT#10=0) W "."
 Q
 ;
REPORT(SDR) ;  Select type of summary report
 ;  Variable Input
 ;      SDR  - Returns with Report Type  S - Summary Only, 
 ;                                       D - Summary with detail
 ;
 ;  Returns
 ;      1  - Ok
 ;     -1  - No report type selected
 N NX,Y
 ;
 S SDR=""
 S DIR(0)="YA",DIR("A")="Summary report only? ",DIR("B")="YES"
 S DIR("?")="Answer with Yes or No."
 S DIR("??")="^D HELP^SCRPI02"
 D ^DIR K DIR I $D(DIRUT) S Y=-1 G RPTQ
 S SDR=$S(Y:"S",1:"D")
RPTQ Q Y
 ;
ASKDT(SDT) ;  Ask for date range for report
 ;  Variable Input
 ;       SDT  - Returns date range as Begin^End
 ;
 ;  Returns
 ;     1 - Date range selected
 ;     0 - No date range selected
 ;
 S SDBDT=$$FMADD^XLFDT($$DT^XLFDT,-7)
 W !!,"Date Range for Encounters"
 S DIR(0)="DA^2961001:NOW:EXP",DIR("A")="Enter beginning date for search: "
 S DIR("?")="^D HELP^%DTC"
 S DIR("B")=$$FMTE^XLFDT(SDBDT)
 D ^DIR I $D(DIRUT) K SDT G ASKQ
 K DIRUT
 S SDT=Y
 ;
 S DIR("A")="Enter ending date for search: "
 S DIR("B")="TODAY"
 D ^DIR K DIR I $D(DIRUT) K SDT G ASKQ
 K DIRUT
 S $P(SDT,U,2)=Y
ASKQ Q $G(SDT)>0
 ;
HELP ;
 W !?2,"Answering YES, will provide a table of all clinics,"
 W !?2,"showing total encounters, number of incomplete encounters, and"
 W !?2,"percentage.  Answering NO will include a list of error details "
 W !?2,"for each selected clinic, in decsending order of occurrence,"
 W !?2,"and the number of encounters and incomplete encounters.",!
 Q
