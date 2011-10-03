RANMUSE1 ;HISC/SWM-Nuclear Medicine Usage reports ;9/3/97  14:37
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN1 ;
 N RADIVNAM,RAIMGNAM,RADIOPH,RAXMDTM,RAPRCNAM,RAPATNAM,RACN,DFN,I
 N P02,P03,S3,S4,VA,VAERR
 D KIL
 S RATITLE="Radiopharmaceutical "_RATITLE,RAPG=0
 S X="NOW",%DT="T" D ^%DT K %DT D D^RAUTL S RATDY=Y,$P(RALN,"-",133)=""
 K DIR
 ;****W @IOF,!?3,RATITLE,!?3,$E(RALN,1,$L(RATITLE)),!
 S DIR(0)="YA",DIR("A")="Do you wish only the summary report? ",DIR("B")="No",DIR("?")="Enter 'Yes' for a summary report, or 'No' for a detailed report."
 D ^DIR K DIR I $D(DIRUT) G OUT
 S RASUM=+Y ; =1 summary rpt only
 K DIROUT,DIRUT,DTOUT,DUOUT
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0)
 N X S X=$$SETUPDI^RAUTL7() Q:X
 D SELDIV^RAUTL7 ; <-------------- Select Rad division(s)
 I '$D(^TMP($J,"RA D-TYPE"))!(RAQUIT) D  G OUT
 . K RACCESS(DUZ,"DIV-IMG"),^TMP($J,"DIV-IMG")
 . Q
 ; selection of img type should be based on
 ; (1) loc access and/or RA ALLOC key
 ; (2) img type must have RADIOPHARMS USED = Y
 D SELIMG^RANMUTL1 ; <-------------- Select Imaging type
 I '$D(^TMP($J,"RA I-TYPE"))!(RAQUIT) D  G OUT
 . K RACCESS(DUZ,"DIV-IMG"),^TMP($J,"DIV-IMG")
 . Q
 I RATITLE["Usage" D SELRADIO^RANMUTL1 Q:RAINPUT=""  ; <-------------- Select Radiopharm(s)
 I RATITLE["Admin" D SELADMIN^RANMUTL1 Q:RAINPUT=""  ; <-------------- Select Dose Administerer
 G:RAQUIT OUT
 I RAINPUT=0,'$D(^TMP($J,"RA EITHER")) G OUT
 D SELDATES^RANMUTL1 ; <-------------- Select date range
 G:RAPOP OUT
 D SELSORT^RANMUTL1 ; <-------------- Select sort order
 G:RAPOP OUT
 ; ^tmp($j,"ra",
 ;              subscr 3 - div's numerical sort order
 ;              subscr 4 - img typ's numerical sort order
 ;
 ; 3rd & 4th sorts are interchangeable, depending on user's choice
 ; If user chooses to sort by exam date/time later :
 ;              subscr 5 - radiopharm name OR who admin dose
 ;              subscr 6 - exam date/time
 ;
 ; If user chooses to sort by exam date/time earlier :
 ;              subscr 5 - exam date/time
 ;              subscr 6 - radiopharm name OR who admin dose
 ;
 ;              subscr 7 - patient name
 ;              subscr 8 - case number 
 ;              subscr 9 - radiopharm (would be a repeat for Usage rpt)
 ;
 S ZTRTN="START^RANMUSE1"
 S ZTSAVE("^TMP($J,""RA"",")=""
 S ZTSAVE("^TMP($J,""RA D-TYPE"",")=""
 S ZTSAVE("^TMP($J,""RA I-TYPE"",")=""
 S ZTSAVE("^TMP($J,""RA EITHER"",")=""
 F I="RACCESS*","RAINPUT","RADTBEG*","RADTEND*","RALN","RASORT","RASUM","RAPG","RATDY","RATITLE" S ZTSAVE(I)=""
 W !!?5,"***",?57,"***",!?5,"*** This report requires a 132 column output device ***",!?5,"***",?57,"***"
 W ! D ZIS^RAUTL
 I RAPOP G OUT
START ;
 K RATDRAWN,RATDOSE,RATRADIO,RATOUTSD,RATUNIQ,RAHDTYP
 ; RATDRAWN() total dose drawn
 ; RATADMIN() total dose administered
 ; RATRADIO() total cases using this radiopharm
 ; RATOUTSD() total cases where admin dose fell outside of dosage range
 D SET^RANMUSE2
 D ZERO^RANMUSE3
 U IO
 D:'RASUM WRT^RANMUSE2 G:$G(RAXIT) OUT
 D SUM^RANMUSE3
OUT ;
 S:$D(ZTQUEUED) ZTREQ="@"
 D CLOSE^RAUTL
 D KIL
 Q
KIL ;
 K ^TMP($J,"RA"),^("RASUM"),^("RATUNIQ"),^("RA D-TYPE"),^("RA I-TYPE"),^("RA EITHER"),^("DIV-IMG")
 K ^TMP($J,"RATOUTSD"),^("RATDRAWN"),^("RATDOSE"),^("RATRADIO")
 K RA0,RA1,RA2,RASTERSK,RASORT,RADTBEG,RADTEND,RASUM,RAPG,RAUNIQ,RAFIRST
 K RADFN,RADTI,RACNI,RAN0,RANUC,RALONGCN,RATDY,RALN,RAINPUT
 K RAXIT,RAWHO,RAXMDTM,RASSN,RASEQD,RAPRC0,RASEQI,RAQUIT,RAPOP
 K RANUMI,RANUMD,RANUC1,RALOW,RAHIGH,RAHDTYP,RADRAWN,RADOSE,RAMES
 K RAEITHER,DIR,I
 Q
RADUSE ; Entry point for Radiopharm usage report
 N ZTDESC S ZTDESC="Rad/Nuc Med Radiopharmaceutical Usage Report"
 N RATITLE S RATITLE="Usage" G EN1
 Q
RADADM ; Entry point for Radiopharm administerer report
 N ZTDESC S ZTDESC="Rad/Nuc Med Radiopharmaceutical Administerer Report"
 N RATITLE S RATITLE="Administration" G EN1
 Q
