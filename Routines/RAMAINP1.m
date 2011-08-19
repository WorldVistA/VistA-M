RAMAINP1 ;HISC/GJC AISC/TMP,RMO-Utility Files Print ;9/22/98  15:26
 ;;5.0;Radiology/Nuclear Medicine;**3,45**;Mar 16, 1998
18 ;;Parent Procedure List
 N RA1,RA2,RA3
 D KILL^RAMAINP N RAX,RAY S RAX=$$IMG^RAUTL12() Q:'RAX
 S RASTAT=$$ACTIVE()
 I RASTAT="^" K RASTAT Q
 S DIC="^RAMIS(71,",L=0,FLDS="[RA PARENT PROCEDURE LIST]"
 S BY="12,.01",DHD=$S(RASTAT="B":"Active/Inactive",RASTAT="A":"Active",1:"Inactive")_" Parent Procedure List"
 S:RASTAT="B" DIS(0)="I $P($G(^RAMIS(71,D0,0)),U,6)=""P"",$$IMG^RAMAINP(D0)"
 S:RASTAT="A" DIS(0)="I $P($G(^RAMIS(71,D0,0)),U,6)=""P"",$$IMG^RAMAINP(D0),(+$G(^RAMIS(71,D0,""I""))=0!(+$G(^RAMIS(71,D0,""I""))>DT))"
 S:RASTAT="I" DIS(0)="I $P($G(^RAMIS(71,D0,0)),U,6)=""P"",$$IMG^RAMAINP(D0),+$G(^RAMIS(71,D0,""I""))>0,+$G(^RAMIS(71,D0,""I""))'>DT"
 S (FR,TO)="" K RASTAT S DHIT="S $P(RALINE,""-"",(IOM+1))="""" W !,RALINE"
 W ! D 132^RAMAINP S RAPOP=$$ZIS^RAMAINP("Rad/Nuc Med Parent Procedure Listing")
 I +RAPOP D HOME^%ZIS,KILL^RAMAINP Q  ; device selection failed
 I +$P(RAPOP,"^",2) D KILL^RAMAINP Q
 E  D ENTASK^RAMAINP
 Q
 ;
CMPRT ; Entry Point: print procedures that are associated with contrast
 ; media/medium.
 ; kill ^TMP($J) and select procedure i-types
 K ^TMP($J,"RA I-TYPE") S RAX=$$IMG^RAUTL12() I 'RAX K RAX Q
 S RAITYP="^",RAX=""
 F  S RAX=$O(^TMP($J,"RA I-TYPE",RAX)) Q:RAX=""  D
 .S RAY=$O(^TMP($J,"RA I-TYPE",RAX,0)),RAITYP=RAITYP_RAY_"^"
 .K ^TMP($J,"RA I-TYPE",RAX)
 .Q
 ; ask if active, inactive, or both active & inactive procedures are
 ; to be included.
 S RASTAT=$$ACTIVE()
 I RASTAT="^" K RAITYP,RASTAT,RAX,RAY Q
 ; save off user input parameters
 F I="RAITYP","RASTAT" S ZTSAVE(I)=""
 K I D EN^XUTMDEVQ("PRTCM^RAMAINP1","Rad/Nuc Med: print procedure contrast media association",.ZTSAVE,,1)
 I +$G(ZTSK)>0 W !!,"Task Number: "_ZTSK,!
 K %L,%X,%Y,DDH,POP,RAITYP,RASTAT,RAX,RAY,X,Y,ZTSAVE,ZTSK
 Q
 ;
PRTCM ; Print procedures that are associated with contrast media/medium.
 S:$D(ZTQUEUED) ZTREQ="@"
 S RAHD="Rad/Nuc Med Procedures with Contrast Media/Medium"
 S RAHD=$S(RASTAT="A":"Active ",RASTAT="I":"Inactive ",1:"")_RAHD
 S $P(RALINE,"-",(IOM+1))=""
 S RAPG=0,RADT=$$FMTE^XLFDT(DT,"1P")
 W:$E(IOST,1,2)="C-" @IOF ;clear screen
 D HDR S (RAY,RAXIT)=0
 ;only want procedure with contrast media/medium associations
 F  S RAY=$O(^RAMIS(71,"CM","Y",RAY)) Q:'RAY  D  Q:RAXIT
 .S RAXIT=$$S^%ZTLOAD() S:RAXIT ZTSTOP=1 Q:RAXIT
 .S RAY(0)=$G(^RAMIS(71,RAY,0))
 .;does the procedure have an i-type specified by the user?
 .Q:RAITYP'[("^"_$P(RAY(0),U,12)_"^")
 .S RAY("I")=+$G(^RAMIS(71,RAY,"I"))
 .;if inactive proc are desired, and the inact. date is in the future
 .;(the field will accept future dates), quit
 .I RASTAT="I",RAY("I"),RAY("I")>DT Q
 .;if inactive proc are desired, and no inact. date, quit
 .I RASTAT="I",'RAY("I") Q
 .;if active proc are desired, and the inact. date is today or in the
 .;past, quit
 .I RASTAT="A",RAY("I"),RAY("I")'>DT Q
 .;if both inactive & active procedures are desired all records qualify 
 .W !!,$P($$NAMCODE^RACPTMSC($P(RAY(0),U,9),DT),U),?19,$P(RAY(0),U)
 .I $Y>(IOSL-4) D EOS Q:RAXIT
 .W ! S (RACM,RADCM)=.001
 .F  D  Q:('RACM&'RADCM)!RAXIT  W !
 ..S:RADCM RADCM=$O(^RAMIS(71,RAY,"DCM",RADCM)) W:RADCM ?2,$E($P($$BASICMOD^RACPTMSC(+$G(^(RADCM,0)),DT),U,3),1,47)
 ..S:RACM RACM=$O(^RAMIS(71,RAY,"CM",RACM)) W:RACM ?50,$$EXTERNAL^DILFD(71.0125,.01,"",$P($G(^(RACM,0)),U))
 ..I $Y>(IOSL-4) D EOS Q:RAXIT
 ..Q
 .Q:RAXIT  I $Y>(IOSL-4) D EOS
 .W $$EXTERNAL^DILFD(71,6,"",$P(RAY(0),U,6)),?24,$$EXTERNAL^DILFD(71,12,"",$P(RAY(0),U,12))
 .I RASTAT'="A",(RAY("I")>0) W ?52,$$EXTERNAL^DILFD(71,100,"",RAY("I"))
 .Q
 ;
KILL ; kill and quit
 ;if there are no records to print, alert user
 W:'$D(RAY(0))#2 !,$$CJ^XLFSTR("*** No Records To Print ***",IOM)
 ;
 K RACM,RADCM,RADT,RAHD,RAITYP,RALINE,RAPG,RAXIT,RAY
 Q
 ;
ACTIVE() ; Use the ^DIR call to ask the user if active, inactive, or
 ; both inactive & active procedures are to be included.
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X N Y
 S DIR(0)="S^A:Active;I:Inactive;B:Both",DIR("A")="Select Procedure Status",DIR("B")="A"
 S DIR("?",1)="Enter 'A' for active procedures, 'I' for inactive proceduRes,"
 S DIR("?")="or 'B' for both active and inactive procedures."
 W ! D ^DIR S:$D(DIRUT) Y="^"
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X
 Q Y
 ;
EOS ; end of screen dialog
 I $E(IOST,1,2)="C-" D  Q:RAXIT
 .K DIR,DIRUT,DTOUT,DUOUT
 .S DIR(0)="E" D ^DIR S:$D(DIRUT) RAXIT=1
 .K DIR,DIRUT,DTOUT,DUOUT
 .Q
 ;
HDR ; print header
 W:RAPG @IOF S RAPG=RAPG+1
 W !,$$CJ^XLFSTR(RAHD,IOM),!,"Date: ",RADT,?69,"Page ",RAPG
 W !,"CPT",?19,"Procedure",!?2,"CPT Modifiers",?50,"Contrast Media",!,"Procedure Type",?24,"Imaging Type"
 W:RASTAT'="A" ?52,"Inactivation Date"
 W !,$$CJ^XLFSTR(RALINE,IOM)
 Q
 ;
CMDISP(RAZ71) ;Display contrast media data for descendents when the 'Parent
 ;Procedure List' [RA PROCPARENT] option is exercised
 ;function called from print template: [RA PARENT PROCEDURE LIST]
 ;input-RAZ71 internal entry number of the descendent
 ;formatting issues; differ for print options
 W !?7,"Contrast Medium"
 N RALBL,RAX,RAY S (RALBL,RAY)=0
 F  S RAY=$O(^RAMIS(71,RAZ71,"CM",RAY)) Q:'RAY  D
 .S RAX=$P($G(^RAMIS(71,RAZ71,"CM",RAY,0)),U) ;RAX=CM value (internal)
 .W:RALBL ! W ?40,$$EXTERNAL^DILFD(71.0125,.01,"",RAX) S RALBL=RAY
 .Q
 Q
 ;
