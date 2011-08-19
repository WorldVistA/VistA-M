RAMAINP ;HISC/GJC AISC/TMP,RMO-Utility Files Print ;9/22/98  15:26
 ;;5.0;Radiology/Nuclear Medicine;**3,19,34**;Mar 16, 1998
2 ;;Long Active Procedure List
 D KILL N RAX,RAY,RA1,RA2,RA3 S RAX=$$IMG^RAUTL12() Q:'RAX
 S RAY="Rad/Nuc Med Active Procedures (Long)"
 S DIC="^RAMIS(71,",L=0,FLDS="[RA PROCEDURE LIST]"
 S BY=.01,(FR,TO)=""
 S DHD="Active Radiology/Nuclear Medicine Procedures (Long)"
 S DHIT="S $P(RALINE,""-"",(IOM+1))="""" W !,RALINE"
 S DIS(0)="I $S('$D(^RAMIS(71,D0,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0),($$IMG^RAMAINP(D0))"
 W ! D 132 S RAPOP=$$ZIS(RAY)
 I +RAPOP D HOME^%ZIS,KILL Q  ; device selection failed
 I +$P(RAPOP,"^",2) D KILL Q
 E  D ENTASK
 Q
 ;
3 ;;Major AMIS Code Print
 S DIC="^RAMIS(71.1,",L=0,FLDS=".001,.01,2",FR="",TO="",BY=".001",DHD="Major AMIS Codes" D EN1^DIP K FLDS,BY,FR,TO,DHD,POP Q
 ;
4 ;;Film Sizes Print
 S DIC="^RA(78.4,",L=0,FLDS="[RA FILM SIZE]",BY="",TO="",FR=""
 D EN1^DIP K BY,DIJ,DP,FLDS,FR,P,TO,X,POP Q
 ;
5 ;;Diagnostic Code Print
 S DIC="^RA(78.3,",L=0,FLDS="[RA DIAGNOSTIC CODE PRINT]",BY=".001",FR="",TO="",DHD="Diagnostic Codes" D EN1^DIP K FLDS,BY,FR,TO,DHD,POP Q
 ;
6 ;;Flash Card/Label Formatter Print
 S L=0,DIC="^RA(78.2,",FLDS="[RA FLASH PRINT]",BY="[RA FLASH PRINT]",FR="",TO="",DHD="Exam Label/Report Header/Report Footer/Flash Card Formats" D EN1^DIP K L,FLDS,BY,FR,TO,DHD,POP Q
 ;
7 ;;Complication Type Print
 S L=0,DIC="^RA(78.1,",FLDS=".01,2",BY="",FR="",TO="",DHD="Complication Types" D EN1^DIP K %DT,%X,%Y,FLDS,BY,FR,TO,DHD,POP,ZTSK Q
 ;
8 ;;Contract/Sharing Agreements Print
 S DIC="^DIC(34,",L=0,FLDS=".01,2,3",BY="",TO="",FR="",DHD="Contract/Sharing Agreements" D EN1^DIP K BY,DHD,FLDS,FR,POP,TO,X Q
 ;
9 ;;Short Active Procedure List
 D KILL N RAX,RAY,RA1,RA2 S RAX=$$IMG^RAUTL12() Q:'RAX
 S RAY="Rad/Nuc Med Active Procedures (Short)"
 S DIC="^RAMIS(71,",L=0,FLDS="[RA PROCEDURE SHORT LIST]"
 S BY=.01,(FR,TO)=""
 S DHD="Active Radiology/Nuclear Medicine Procedures (Short)"
 S DIS(0)="I $S('$D(^RAMIS(71,D0,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0),($$IMG^RAMAINP(D0))"
 W ! D 132 S RAPOP=$$ZIS(RAY)
 I +RAPOP D HOME^%ZIS,KILL Q  ; device selection failed
 I +$P(RAPOP,"^",2) D KILL Q
 E  D ENTASK
 Q
 ;
10 ;;Long Inactive Procedure List
 D KILL N RAX,RAY,RA1,RA2,RA3 S RAX=$$IMG^RAUTL12() Q:'RAX
 S RAY="Rad/Nuc Med Inactive Procedures (Long)"
 S DIC="^RAMIS(71,",L=0,FLDS="[RA PROCEDURE LIST]"
 S BY=.01,(FR,TO)=""
 S DHD="Inactive Radiology/Nuclear Medicine Procedures (Long)"
 S DHIT="S $P(RALINE,""-"",(IOM+1))="""" W !,RALINE"
 S DIS(0)="I $S('$D(^RAMIS(71,D0,""I"")):0,'^(""I""):0,DT'>^(""I""):0,1:1),($$IMG^RAMAINP(D0))"
 W ! D 132 S RAPOP=$$ZIS(RAY)
 I +RAPOP D HOME^%ZIS,KILL Q  ; device selection failed
 I +$P(RAPOP,"^",2) D KILL Q
 E  D ENTASK
 Q
 ;
11 ;;Short Inactive Procedure List
 D KILL N RAX,RAY
 S RAX=$$IMG^RAUTL12() I 'RAX D KILL Q
 S RAY="Rad/Nuc Med Inactive Procedures (Short)"
 S DIC="^RAMIS(71,",L=0,FLDS="[RA PROCEDURE SHORT LIST]"
 S BY=.01,(FR,TO)=""
 S DHD="Inactive Radiology/Nuclear Medicine Procedures (Short)"
 S DIS(0)="I $S('$D(^RAMIS(71,D0,""I"")):0,'^(""I""):0,DT'>^(""I""):0,1:1),($$IMG^RAMAINP(D0))"
 W ! D 132 S RAPOP=$$ZIS(RAY)
 I +RAPOP D HOME^%ZIS,KILL Q  ; device selection failed
 I +$P(RAPOP,"^",2) D KILL Q
 E  D ENTASK
 Q
 ;
12 ;;Series Procedures Only
 D KILL N RAX,RAY,RA1,RA2,RA3
 S RAX=$$IMG^RAUTL12() Q:'RAX
 S RAY="Rad/Nuc Med Series Procedures Only"
 S DIC="^RAMIS(71,",L=0,FLDS="[RA PROCEDURE LIST]",BY="[RA SERIES ONLY]"
 S DHD="Radiology/Nuclear Medicine Procedures (Series Only)"
 S DHIT="S $P(RALINE,""-"",(IOM+1))="""" W !,RALINE"
 S DIS(0)="I $S('$D(^RAMIS(71,D0,""I"")):1,'^(""I""):1,DT'>^(""I""):0,1:0),($$IMG^RAMAINP(D0))"
 W ! D 132 S RAPOP=$$ZIS(RAY)
 I +RAPOP D HOME^%ZIS,KILL Q  ; device selection failed
 I +$P(RAPOP,"^",2) D KILL Q
 E  D ENTASK
 Q
 ;
13 ;;Standard Reports List
 S DIC="^RA(74.1,",L=0,FLDS="[RA STANDARD REPORTS LIST]",BY="#.001",FR="",TO="" D EN1^DIP
 K BY,DHD,FLDS,FR,POP,TO,X Q
 ;
14 ;;Procedure Modifiers Print
 S DIC="^RAMIS(71.2,",L=0,FLDS=".01,4",FR="",TO="",BY="3;S1,.01"
 S DHD="Procedure Modifiers" D EN1^DIP
 K FLDS,BY,FR,TO,DHD,POP,DD00 Q
 ;
15 ;;Alpha List of Active Procedures
 D KILL N RAX,RAY,RA1,RA2 S RAX=$$IMG^RAUTL12() Q:'RAX
 S RAY="Rad/Nuc Med Alpha List of Active Procedures"
 S DIC="^RAMIS(71,",L=0,FLDS="[RA ALPHA LIST OF ACTIVES]"
 S BY="[RA ALPHA LIST OF ACTIVES]",(FR,TO)=""
 S DIS(0)="I $$IMG^RAMAINP(D0)"
 W ! D 132 S RAPOP=$$ZIS(RAY)
 I +RAPOP D HOME^%ZIS,KILL Q  ; device selection failed
 I +$P(RAPOP,"^",2) D KILL Q
 E  D ENTASK
 Q
 ;
16 ;;Reports Distribution List
 S DIC="^RABTCH(74.3,",L=0,FLDS="[RA DISTRIBUTION]",BY=".01",(TO,FR)="" D EN1^DIP K BY,DHD,FLDS,FR,POP,TO,X,X1 Q
17 ;;Rad/Nuc Med Procedure Message List
 S DIC="^RAMIS(71.4,",L=0,FLDS=".01;S;W70",BY=.01,(FR,TO)="" D EN1^DIP K D0,FLDS,BY,FR,TO,DHD Q
132 W !,"This report requires a 132 column output device."
 Q
KILL ; Kill locals, and set ZTREQ if applicable.
 K ^TMP($J,"RA I-TYPE"),%X,%XX,%Y,%YY
 K %ZIS,BY,DHD,DHIT,DIC,DIS,DTOUT,DUOUT,FLDS,FR,L,POP,RAIOP,RALINE,RAPOP
 K TO,X,Y,ZTDESC,ZTRTN,ZTSAVE
 K RADIO,RAPHARM,I,POP
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
IMG(RA) ; Screens procedures by I-Type.  Called from the following
 ; subroutines: 2,9,10,11,12 & 15.  Contained in variable DIS(0)!
 ; 'RA' is the ien of file 71.
 ; return '1' if procedure is correct I-Type, else '0'!
 N RAI,RAII S RAI=+$P($G(^RAMIS(71,RA,0)),"^",12)
 Q:'RAI 0
 S RAII=$P($G(^RA(79.2,RAI,0)),"^")
 Q $S($D(^TMP($J,"RA I-TYPE",RAII,RAI))#2:1,1:0)
ENTASK ; Entry point for tasked job.
 ; All necessary variables are defined by the code calling ENTASK.
 S RAIOP=ION_";"_IOST_";"_IOM_";"_IOSL,IOP=RAIOP
 D EN1^DIP
 D KILL^RAMAINP
 Q
ZIS(RA) ; Select a device
 ; RAPOP=device selection successful ^ '^%ZTLOAD' called 1-yes
 N RAPOP
 K %ZIS,IOP S %ZIS="NMQ" W ! S %ZIS("A")="DEVICE: " D ^%ZIS
 S RAPOP=POP_"^"
 I '+RAPOP,($D(IO("Q"))) D
 . K IO("Q") S ZTDESC=RA,ZTRTN="ENTASK^RAMAINP"
 . D ZTSAVE,^%ZTLOAD S $P(RAPOP,"^",2)=1
 . I +$G(ZTSK) W !?3,"Request Queued, Task #: ",$G(ZTSK)
 . D HOME^%ZIS
 . Q
 Q RAPOP
ZTSAVE ; Save variables for tasked job
 N I F I="BY","DIC","FLDS","FR","L","TO" S ZTSAVE(I)=""
 S:($D(DIS)\10) ZTSAVE("DIS(")=""
 S:($D(DHD)#2) ZTSAVE("DHD")=""
 S:($D(DHIT)#2) ZTSAVE("DHIT")=""
 S:($D(^TMP($J,"RA I-TYPE"))\10) ZTSAVE("^TMP($J,""RA I-TYPE"",")=""
 Q
