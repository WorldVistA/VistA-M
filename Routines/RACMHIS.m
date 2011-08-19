RACMHIS ;HISC/GJC-Radiology Contrast Media History option (driver)
 ;;5.0;Radiology/Nuclear Medicine;**45**;Mar 16, 1998
 ;Note: new routine with the release of RA*5*45
 ;
EN ;begin; find all procedures with a CM audit history
 S RADIC="^RAMIS(71,",RADIC(0)="EMQZ",RADIC("A")="Select Procedure: "
 S RADIC("S")="I $O(^RAMIS(71,+Y,""AUD"",0))",RAUTIL="RA PROC W/CM"
 K ^TMP($J,"RA PROC W/CM") D EN1^RASELCT(.RADIC,RAUTIL,"",1)
 I $O(^TMP($J,"RA PROC W/CM",""))="" D  D KILL Q
 .W !?3,"No procedures have been selected, exiting this option." Q
 ;
STRTDT ;Prompt for Starting Date
 W ! K DIR S DIR(0)="DA^:"_DT_":PEA"
 S DIR("A")="Enter the start date for the search: "
 S DIR("?",1)="This is the date from which our search will begin."
 S DIR("?",2)="Think of it in terms of 'FROM' and 'TO'. This date is our 'FROM'."
 S DIR("?",3)="The starting date must not exceed: "_$$FMTE^XLFDT(DT,"1P")_"."
 S DIR("?")="Dates associated with a time will not be accepted."
 D ^DIR K DIR
 I $D(DIRUT) D KILL Q
 ;int. date/time ^ ext. date/time ^ int. date/time minus one second
 S RASTRT=Y_"^"_Y(0)_"^"_$$FMADD^XLFDT(Y,"","","",-1)
 ;
ENDDT ;Prompt for Ending Date
 W ! K DIR S DIR(0)="DA^"_$P(RASTRT,U)_":"_DT_":PEA"
 S DIR("A")="Enter the ending date for the search: "
 S DIR("?",1)="This is the date in which our search will end."
 S DIR("?",2)="Think of it in terms of 'FROM' and 'TO'. This date is our 'TO'."
 S DIR("?",3)="The ending date must not exceed: "_$$FMTE^XLFDT(DT,"1P")_"."
 S DIR("?",4)="The ending date must not precede: "_$P(RASTRT,U,2)_"."
 S DIR("?")="Dates associated with a time will not be accepted."
 D ^DIR K DIR
 I $D(DIRUT) D KILL Q
 ;int. date/time ^ ext. date/time ^ int. date/time plus 23hrs, 59 min,
 ;& 59 seconds
 S RASTOP=Y_"^"_Y(0)_"^"_(Y+.235959)
 ;
 F I="RASTRT","RASTOP","^TMP($J," S ZTSAVE(I)=""
 K I D EN^XUTMDEVQ("START^RACMHIS","Rad/Nuc Med: Contrast Media History report",.ZTSAVE,,1)
 I +$G(ZTSK)>0 W !!,"Task Number: "_ZTSK,!
 ;
KILL ;clean up symbol table
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,POP,RADIC,RAQUIT,RASTOP,RASTRT,RAUTIL,X
 K Y,ZTSAVE,ZTSK,^TMP($J,"RA PROC W/CM")
 Q
 ;
START ;main body
 S:$D(ZTQUEUED) ZTREQ="@"
 S RAHD="Contrast Media Edit History By Procedure"
 S $P(RALINE,"-",(IOM+1))="",RAPG=0,RADT=$$FMTE^XLFDT(DT,"1P")
 W:$E(IOST,1,2)="C-" @IOF ;clear screen
 D HDR S RAXIT=0,RAPNME=""
 F  S RAPNME=$O(^TMP($J,"RA PROC W/CM",RAPNME)) Q:RAPNME=""  D  Q:RAXIT
 .S RAXIT=$$S^%ZTLOAD() S:RAXIT ZTSTOP=1 Q:RAXIT
 .S RAY=0
 .F  S RAY=$O(^TMP($J,"RA PROC W/CM",RAPNME,RAY)) Q:'RAY  D  Q:RAXIT
 ..S RAXIT=$$S^%ZTLOAD() S:RAXIT ZTSTOP=1 Q:RAXIT
 ..S RAS=$P(RASTRT,U,3)
 ..F  S RAS=$O(^RAMIS(71,RAY,"AUD","B",RAS)) Q:'RAS!(RAS>$P(RASTOP,U,3))  D  Q:RAXIT
 ...S RAIEN=0
 ...F  S RAIEN=$O(^RAMIS(71,RAY,"AUD","B",RAS,RAIEN)) Q:'RAIEN  D  Q:RAXIT
 ....;get changed date/time, CM value, & user
 ....S RAY(0)=$G(^RAMIS(71,RAY,"AUD",RAIEN,0))
 ....S RAADT=$$FMTE^XLFDT($P(RAY(0),U),"1P"),RACMU=$P(RAY(0),U,2)
 ....S RAX=$S($L(RACMU):$$CONTRAST(RACMU),1:"**User deleted all contrast media data**")
 ....S:+$P(RAY(0),U,3) RAAU=$$GET1^DIQ(200,$P(RAY(0),U,3)_",",.01)
 ....I $Y>(IOSL-4) D EOS Q:RAXIT
 ....W !,$E(RAPNME,1,32),?33,RAADT,?55,$E($G(RAAU),1,24)
 ....I $Y>(IOSL-4) D EOS Q:RAXIT
 ....;display the past CM data value or that CM data has been deleted 
 ....S X=RAX,DIWL=3,DIWR=70,DIWF="W" D ^DIWP,^DIWW K ^UTILITY($J,"W")
 ....Q
 ...Q
 ..Q
 .Q
EXIT ;clean up symbol table, message to user
 ;if there are no records to print, alert user
 W:'$D(RAY(0))#2 !,$$CJ^XLFSTR("*** No Records To Print ***",IOM)
 K DIW,DIWF,DIWL,DIWR,DIWT,DN,I,RAADT,RAAU,RACMU,RADT,RAHD,RAI,RAIEN
 K RALINE,RAPG,RAPNME,RAS,RAXIT,RAX,RAY,X,Y,Z
 Q
 ;
EOS ; end of screen dialog
 I $E(IOST,1,2)="C-" D  Q:RAXIT
 .K DIR,DIRUT,DTOUT,DUOUT
 .S DIR(0)="E" D ^DIR S:$D(DIRUT) RAXIT=1
 .K DIR,DIRUT,DTOUT,DUOUT
 .Q
 ;
 ;'falls' into HDR...
 ;
HDR ; print header
 W:RAPG @IOF S RAPG=RAPG+1
 W !,$$CJ^XLFSTR(RAHD,IOM),!,"Run Date: ",RADT,?25,"From: ",$P(RASTRT,U,2),?45,"To: ",$P(RASTOP,U,2),?68,"Page ",RAPG
 W !,"Procedure",?34,"Date/Time Changed",?55,"User",!?2,"Contrast Media"
 W !,$$CJ^XLFSTR(RALINE,IOM)
 Q
 ;
CONTRAST(RACMU) ;Return the current CM definition for this procedure delimited
 ;by commas.
 ;input: RACMU=internal value of CM; multiple CM references per string
 ;             are possible
 ;return: the external format of CM delimited by commas
 N RAI,RAX S RAX=""
 F RAI=1:1:$L(RACMU) D
 .S RAX=RAX_$$EXTERNAL^DILFD(71.0125,.01,"",$E(RACMU,RAI))_", "
 .Q
 Q $P(RAX,", ",1,($L(RAX,", ")-1)) ;strip off that last ", "
 ;
