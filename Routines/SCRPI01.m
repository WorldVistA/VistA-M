SCRPI01 ;ALB/SCK - IEMM REPORT OF INCOMPLETE ENCOUNTERS ; 2/2/97
 ;;5.3;Scheduling;**66,338**;AUG 13, 1993
 ;
EN ;  Main entry point for report of incomplete encounters report
 ;  Variables
 ;      SDTXT        - String array for initial message display
 ;      SDDT         - date Range, Begin^End
 ;      SDSEL1,2     - Selection methods Line Tag
 ;      SDOK         - Flag, 1 - Ok to continu, 0 - Quit
 ;
 N VAUTD,VAUTC,VAUDS,VAUTSTR,VAUTNI,SDTXT,SDDT,ZTSAVE,VAUTN,VAUER,SDSEL1,SDSEL2,SDOK,NDX,VAUTVB
 ;
 W !,$C(7)
 F NDX=1:1 S SDTXT=$P($T(MSG+NDX),";;",2) Q:SDTXT="$$END"  D
 . W !,SDTXT
 W !!
 S DIR(0)="E" D ^DIR K DIR Q:'$G(Y)
 ; 
 I $$DIV^SCRPIUT1<0 G ENQ
 D MSG2
 S SDSEL1=$$SELCT("","First") G:SDSEL1']"" ENQ
 S SDSEL2=$$SELCT(SDSEL1,"Next") G:SDSEL2']"" ENQ
 I '$$ASKDT^SCENI01(.SDDT) G ENQ
 ;
 D @SDSEL1 Q:$G(SDOK)<0
 D @SDSEL2 Q:$G(SDOK)<0
 ;
 F X="SDDT","VAUTC","VAUTD","VAUDS","VAUDS(","VAUTC(","VAUTD(","SDSEL1","SDSEL2","VAUTN","VAUTN(","VAUER","VAUER(" D
 . S ZTSAVE(X)=""
 S IOP="Q"
 W !!,"This report requires 132 columns and could take some time.",!,"Remember to QUEUE the report.",!
 D EN^XUTMDEVQ("RPT^SCRPI01","IEMM Error Listing",.ZTSAVE)
 D HOME^%ZIS
ENQ Q
 ;
RPT ; Build report, then call print
 K ^TMP("SCRPI ERR",$J)
 D BLD
 D PRINT^SCRPI01A
 Q
 ;
EXIT ;
 K ^TMP("SCRPI ERR",$J)
 Q
 ;
SELCT(S1,SCT) ;  Set selection criteria
 ;   Input
 ;       S1    - Previous selection method
 ;       SCT   - first or second selection method
 ;
 ;   Returns
 ;       CLN - Clinic
 ;       ERR - Error Code
 ;       PAT - Patient
 ;       DSS - Stop Code
 ;
 ;   Variables
 ;       SCTEXT - Set up display list
 ;
 N X,CNT,SCTEXT
 S X="SM^"
 F CNT=1:1 S SCTEXT=$P($T(OPTIONS+CNT),";;",2) Q:SCTEXT="$$END"  D
 . Q:S1[$P(SCTEXT,":")
 . S X=X_SCTEXT
 ;
 S DIR(0)=X,DIR("A")="Set "_SCT_" Selection Criteria"
 S DIR("?")="Pick a selection criteria from those listed below."
 S DIR("??")="^D HLP^SCRPI01"
 D ^DIR K DIR
 Q $S(Y["C":"CLN",Y["P":"PAT",Y["E":"ERR",Y["D":"DSS",1:"")
 ;
CLN ; Clinic selection o/m/a
 W !!,"Clinic Selection"
 S VAUTNI=2
 D CLINIC^VAUTOMA
 W !
 S SDOK=Y
 Q
 ;
PAT ; Patient selection o/m/a
 W !!,"Patient Selection"
 S VAUTNI=2
 D PATIENT^VAUTOMA
 W !
 S SDOK=Y
 Q
 ;
ERR ; Error selection o/m/a
 W !!,"Transmission Error Selection"
 S DIC="^SD(409.76,",VAUTSTR="Error",VAUTVB="VAUER",VAUTNI=2
 D FIRST^VAUTOMA
 W !
 S SDOK=Y
 Q
 ;
DSS ; Clinic Stop code selection o/m/a
 W !!,"Clinic Stop Code Selection"
 S DIC="^DIC(40.7,",VAUTSTR="Stop Code",VAUTVB="VAUDS",VAUTNI=2
 D FIRST^VAUTOMA
 W !
 S SDOK=1
 Q
 ;
BLD ; Search for incomplete encounters and build TMP global
 ;    Variables
 ;        SDEND  - End date of date range
 ;        SDOE   - Encounter IEN
 ;        SDOEDT - Encounter date
 ;        SDCNT  - Entry count
 ;
 N SDEND,SDOE,SDOEDT,SDCNT
 ;
 S SDOEDT=$P(SDDT,U)-.1,SDEND=$P(SDDT,U,2)+.9,SDCNT=0
 F  S SDOEDT=$O(^SD(409.75,"AEDT",SDOEDT)) Q:'SDOEDT!(SDOEDT>SDEND)  D
 . S SDXMT=0 F  S SDXMT=$O(^SD(409.75,"AEDT",SDOEDT,SDXMT)) Q:'SDXMT  D
 .. S SDXER=0 F  S SDXER=$O(^SD(409.75,"AEDT",SDOEDT,SDXMT,SDXER)) Q:'SDXER  D BLD1(SDXER,SDXMT)
 Q
 ;
BLD1(SDE,SDX) ;  If error passes checks, add to sorted TMP global
 ;   Input
 ;       SDE  - Pointer to #409.75
 ;       SDX  - Pointer to #409.73
 ;
 ;   Variables
 ;       SCEN   - Temporary array for encounter information
 ;       SDDEL  - Deleted Encounter Marker "*"
 ;       SDRSLT - -1:error, 1:Deleted Encounter, 0:Not deleted
 ;       SDIV   - Division IEN
 ;       SDCDE  - Stop code
 ;
 ;   Output
 ;       ^TMP("SCRPI ERR",$J,Division Name,Clinic Name,Patient Name,Encounter Date,Error code IEN,0)=DFN^#409.73 Pointer^Deleted Flag
 ;
 N SCEN,SDDEL,SDRSLT,SDIV,SDCDE
 ;
 I '$D(ZTQUEUED) S SDCNT=SDCNT+1 W:(SDCNT#10)=0 "."
 ;
 S SDRSLT=$$OPENC^SCUTIE1(SDXMT,"SCEN")
 Q:SDRSLT<0
 S:SDRSLT SDDEL="*"
 ;
 I SDRSLT D
 . S SDIV=$P(^SD(409.74,SCEN("DELIEN"),1),U,11)
 . S SDCDE=$P(^SD(409.74,SCEN("DELIEN"),1),U,3)
 E  D
 . S SDIV=$P(^SCE(SCEN("SDOIEN"),0),U,11)
 . S SDCDE=$P(^SCE(SCEN("SDOIEN"),0),U,3)
 ;
 I $S(VAUTD:0,$D(VAUTD(SDIV)):0,1:1) Q
 ;
 I SDSEL1="CLN",$S(VAUTC:0,$D(VAUTC(SCEN("CLINIC"))):0,1:1) Q
 I SDSEL1="PAT",$S(VAUTN:0,$D(VAUTN(SCEN("DFN"))):0,1:1) Q
 I SDSEL1="ERR" Q:'$D(^SD(409.75,SDE,0))  I $S(VAUER:0,$D(VAUER($P(^SD(409.75,SDE,0),U,2))):0,1:1) Q  ; SD*5.3*338
 I SDSEL1="DSS",$S(VAUDS:0,$D(VAUDS(SDCDE)):0,1:1) Q
 ;
 I SDSEL2="CLN",$S(VAUTC:0,$D(VAUTC(SCEN("CLINIC"))):0,1:1) Q
 I SDSEL2="PAT",$S(VAUTN:0,$D(VAUTN(SCEN("DFN"))):0,1:1) Q
 I SDSEL2="ERR" Q:'$D(^SD(409.75,SDE,0))  I $S(VAUER:0,$D(VAUER($P(^SD(409.75,SDE,0),U,2))):0,1:1) Q  ; SD*5.3*338
 I SDSEL2="DSS",$S(VAUDS:0,$D(VAUDS(SDCDE)):0,1:1) Q
 ;
 S ^TMP("SCRPI ERR",$J,$P(^DG(40.8,SDIV,0),U),$P(^SC(SCEN("CLINIC"),0),U),$P(^DPT(SCEN("DFN"),0),U),SCEN("ENCOUNTER"),SDE,0)=SCEN("DFN")_U_SDX_U_$G(SDDEL)
 Q
 ;
SELMTHD(SEL) ;  Returns 'external' version of selection method
 Q $S(SEL="CLN":"Clinic",SEL="PAT":"Patient",SEL="ERR":"Error Code",SEL="DSS":"Clinic Stop Code")
 ;
HLP ;  '??' help for the selection criteria.
 ;
 W !?2,"You may select any two of the following selection criteria, one at a time, for"
 W !?2,"your report.  You will be asked for one/many/all selections for each criteria"
 W !?2,"selected."
 W !
 W !?2,"Selection criteria are not sort criteria.  The sort criteria are  Division,"
 W !?2,"Clinic, Patient, and Encounter.  Selection criteria limit what will be"
 W !?2,"printed in the report."
 Q
 ;
MSG2 ;
 W !!!
 W "The following are selection criteria which are used to specify a group of or"
 W !,"particular clinic, patient, error code or clinic stop code to be printed."
 W !,"You are asked to pick two, one at a time.  Type '??' for more details."
 Q
 ;
MSG ;
 ;;  This report requires 132 columns to print and will default to 
 ;;  QUEUING required.  If you print this report to your terminal,
 ;;  answer 'NO' to the 'Do you still want your output queued' prompt.
 ;;$$END
 ;
OPTIONS ;  Selection methods
 ;;C:Clinic;
 ;;P:Patient;
 ;;E:Error Code;
 ;;D:Clinic Stop Code;
 ;;$$END
 ;
