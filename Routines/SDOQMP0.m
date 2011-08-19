SDOQMP0 ;ALB/SCK - Appointment Monitoring / Performance Measure Rpt. ; [07/23/96]
 ;;5.3;SCHEDULING;**47**;AUG 13, 1993
 ;
 Q
SELECT() ;  Selection method for clinic selection.
 ;  Returns:
 ;     Y = S, D, or C for Stop Code, Division, or Clinic.
 ;     Y = Null for up-arrow or timeout
 ;
 N Y
 S DIR(0)="SM^D:Division;S:Stop Code;C:Clinic"
 S DIR("A")="Select clinics by: "
 S DIR("?")="Select by either: Stop Code, Division, or Clinic"
 S DIR("?",1)="The method by which clinics are selected for this report."
 S DIR("B")="S"
 D ^DIR K DIR
 S:$D(DIRUT) Y=""
SELQ Q $G(Y)
 ;
CLINIC() ;  One-Many-All clinic selection        
 ;  Output
 ;    CLINIC(IEN)=""
 ;
 W !!,"Clinic Selection"
 S DIC="^SC(",VAUTSTR="Clinic",VAUTVB="CLINIC",VAUTNI=2,DIC("S")="I $P(^(0),U,3)[""C"""
 D FIRST^VAUTOMA
 I Y<0 K CLINIC
 Q $D(CLINIC)>0
 ;
STOP() ; -- get stop code data        
 ; output: VAUTC := stop codes selected (VAUTC=1 for all)        
 ; return: was selection made [ 1|yes   0|no]        
 ;
 W !!,"Stop Code Selection"
 S DIC="^DIC(40.7,",VAUTSTR="Stop Code",VAUTVB="VAUTC",VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 K VAUTC
STOPQ Q $D(VAUTC)>0
 ;
DIV() ; -- get division data
 ;  input: none
 ; output: VAUTD := divs selected (VAUTD=1 for all)
 ; return: was selection made [ 1|yes   0|no]
 ;
 W:$P($G(^DG(43,1,"GL")),U,2) !!,"Division Selection"
 D ASK2^SDDIV
 I Y<0 K VAUTD
 Q $D(VAUTD)>0
 ;
STOPCDE(PMIEN) ;  Get associated stop code number for clinic
 ;    Input
 ;       PMIEN  -  Ien of clinic in the Hospital location file
 ;
 ;    Output
 ;       Either Stop code number, or 0 if no stop code is found
 ;
 N PMSC
 S PMSC=+$P($G(^DIC(40.7,$P($G(^SC(PMIEN,0)),U,7),0)),U,2)
 Q $S(+PMSC>0:PMSC,1:0)
 ;
CLNOK(PMSC) ; Checks associated stop code for clinic.
 ;   Input
 ;      PMSC  -  Associated stop code for current clinic
 ;
 ;   Output
 ;     PMOK  -  Returns 1 if stop code is on the list
 ;              Returns 0 if it's not on the list.
 ;
 N PMOK,CNT,PMSTCD
 S PMOK=0
 F CNT=1:1 S PMSTCD=$P($T(STOPS+CNT^SDOQMPL),";;",2) Q:PMSTCD="$$END"  D  Q:PMOK
 . Q:'$D(^DIC(40.7,PMSC,0))
 . I $P($G(^DIC(40.7,PMSC,0)),U,2)=PMSTCD S PMOK=1
 Q PMOK
 ;
DIVISION(PMIEN) ; Returns the name of the division the clinic as assigned to.
 ;   Input:
 ;      Ien of clinic in the Hospital location file.
 ;
 ;   Output:
 ;      Division name in external format.
 ;
 N PMDIEN,PDIV
 S PMDIV=""
 S PMDIEN=+$P($G(^SC(PMIEN,0)),U,15)
 G:PMDIEN'>0 DIVQ
 S PMDIV=$P($G(^DG(40.8,PMDIEN,0)),U)
DIVQ Q PMDIV
 ;
LOOPSC ;  Loops through all clinics in the Hospital location file, and selects clinics that are 
 ;  associated with one of the selected stop codes, adding them to the "SDAMMS" TMP global.
 ;     If VAUTC=1, then select clinics for all Stop codes.
 ;     If VAUTC=0, then select only those clinics for the Stop codes in the 
 ;     VAUTC(StopCode Ien) local array.
 ; 
 N PMSC,AMMSD0
 S AMMSD0=0
 ;
 ; ***  Select all
 I VAUTC=1 D
 . F  S AMMSD0=$O(^SC("AC","C",AMMSD0)) Q:'AMMSD0  D
 .. Q:'$P($G(^SC(AMMSD0,0)),"^",7)
 .. Q:$G(^TMP("SDAMMS",$J,"Q"))=1
 .. F X1=1:1:3 D AMMSCNT^SDOQMP1 Q:AMMSLAST=0
 ;
 ; *** Select only clinics with a selected associated stop code 
 I VAUTC=0&($D(VAUTC)) D
 . F  S AMMSD0=$O(^SC("AC","C",AMMSD0)) Q:'AMMSD0  D
 .. Q:'$P($G(^SC(AMMSD0,0)),"^",7)
 .. S PMSC=$P($G(^SC(AMMSD0,0)),"^",7)
 .. Q:'$D(VAUTC(PMSC))
 .. Q:$G(^TMP("SDAMMS",$J,"Q"))=1
 .. F X1=1:1:3 D AMMSCNT^SDOQMP1 Q:AMMSLAST=0
 Q
 ;
LOOPD ;  Loops through all clinics in the Hospital location file, and select clinics that are
 ; in one of the selected divisions, adding them to the "SDAMMS" TMP global.
 ;   If VAUTD=1, then select clinics for all Divisions.
 ;   If VAUTD=0, then select only those clinics for the Divisions in the
 ;   VAUTC(StopCode Ien) local array.
 ;
 N PMDIV,AMMSD0
 ;
 S AMMSD0=0
 ;   Select all
 I VAUTD=1 D
 . F  S AMMSD0=$O(^SC("AC","C",AMMSD0)) Q:'AMMSD0  D
 .. Q:'$P($G(^SC(AMMSD0,0)),"^",7)
 .. Q:$G(^TMP("SDAMMS",$J,"Q"))=1
 .. F X1=1:1:3 D AMMSCNT^SDOQMP1 Q:AMMSLAST=0
 ;
 I VAUTD=0&($D(VAUTD)) D
 . F  S AMMSD0=$O(^SC("AC","C",AMMSD0)) Q:'AMMSD0  D
 .. Q:'$P($G(^SC(AMMSD0,0)),"^",7)
 .. S PMDIV=$P($G(^SC(AMMSD0,0)),"^",15)
 .. Q:PMDIV']""
 .. Q:'$D(VAUTD(PMDIV))
 .. Q:$G(^TMP("SDAMMS",$J,"Q"))=1
 .. F X1=1:1:3 D AMMSCNT^SDOQMP1 Q:AMMSLAST=0
 Q
 ;
CHKTASK() ;  Checks if the expiration date has been reached.  If it has, delete the option
 ;  scheduling run time field to turn off the reschedule option
 ;
 N OIEN,OSIEN,PMTEXT,EXPDT,SDOPT,SDWHN,SDFRQ,SDOK
 ;
 S SDOK=0
 S EXPDT=$P($T(EXPIRE+1^SDOQMPL),";;",2)
 D NOW^%DTC
 G:$P(%,".")<EXPDT CHKQ
 S OIEN="",OIEN=$O(^DIC(19,"B","SDOQM PM NIGHTLY JOB",OIEN))
 Q:OIEN']""
 S OSIEN="",OSIEN=$O(^DIC(19.2,"B",OIEN,OSIEN))
 Q:OSIEN']""
 ;
 S SDWHN="@",SDFRQ="@",SDOPT="SDOQM PM NIGHTLY JOB"
 D RESCH^XUTMOPT(SDOPT,SDWHN,"",SDFRQ,"",.SCERR)
 ;
 S PMTEXT(1)="The Access Performance Measure data collection job"
 S PMTEXT(2)="has expired, and the background server has been unscheduled"
 S PMTEXT(3)=""
 S PMTEXT(4)="The entry in the SCHEDULING OPTION file should be removed"
 S PMTEXT(5)="by your IRM staff"
 S XMSUB="PM EXTRACT EXPIRATION",XMN=0
 S XMTEXT="PMTEXT("
 S XMDUZ=.5,XMY("G.SD PM NOTIFICATION")=""
 D ^XMD
 S SDOK=1
CHKQ Q SDOK
 ;
LOOPS ;  Use appropriate loop for building the clinic global.
 ;
 I $D(CLINIC) D LOOPC^SDOQMP Q
 I $D(VAUTC) D LOOPSC Q
 I $D(VAUTD) D LOOPD Q
 Q
