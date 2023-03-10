RASYS ;HISC/CAH AISC/TMP-System Definition Menu ; Jan 29, 2021@08:58:56
 ;;5.0;Radiology/Nuclear Medicine;**42,47,178**;Mar 16, 1998;Build 2
1 ;;Division Parameter Set-up
 S DIC="^RA(79,",DIC(0)="AELMQ",DIC("A")="Select Division: ",DLAYGO=79
 D ^DIC K DIC,DLAYGO I Y<0 K X,Y G Q1
 S DA=+Y,DIE="^RA(79,",DR="[RA DIVISION PARAMETERS]",RAXIT=0 D ^DIE
 I $O(^RA(79,DA,"L",0)) D
 . D:'$D(IOF) HOME^%ZIS W @IOF S RAINC=0
 . F  S RAINC=$O(^RA(79,DA,"L",RAINC)) Q:RAINC'>0  D  Q:RAXIT
 .. D EN1^RASYS1($P($G(^RA(79,DA,"L",RAINC,0)),"^"))
 .. Q
 . Q
 K %,%X,%Y,C,D0,DA,DE,DQ,DIE,DR,RAINC,RAXIT D Q1 W ! G 1
Q1 K D,DDC,DG,DI,DIG,DIH,DIU,DIV,DIW,DISYS,DST,DUOUT,I,J,POP
 Q
 ;
2 ;;Print Division Parameter List
 S DIC="^RA(79,",L=0,FLDS="[RA IMAGE DIV LIST]",BY="#DIVISION",FR="",TO="" D EN1^DIP K FR,TO,FLDS,BY,DHD Q
 ;
3 ;;Location Parameter Set-up
 S DIC="^RA(79.1,",DIC(0)="AELMQZ",DIC("A")="Select Location: ",DLAYGO=79.1
 D ^DIC K DIC,DLAYGO I Y<0 D KILL3 Q  ; DIC(0)="AELMQZ" patch 42 'Z' added
 I $P(Y,U,3)=1 W !!," *   Since you have added a new Imaging Location, remember to assign     * ",!," *   it to a Rad/Nuc Med division through Division Parameter Set-up.     * ",!
 W:$P(Y,U,3)'=1 ! W !,"Imaging Location: ",Y(0,0) ; patch 42
 S DA=+Y,DIE="^RA(79.1,",DR="[RA LOCATION PARAMETERS]",RAXIT=0 D ^DIE
 D:'$D(IOF) HOME^%ZIS W @IOF D EN1^RASYS1(DA) D KILL3 W ! G 3
KILL3 K %,%X,%W,%Y,D,E,DE,DA,D0,RAREQPRT,DIE,DIV,DQ,DR,RAFLH,RAJAC,RARPT,RAXIT,X,Y
 K C,DDH,DI,DIG,DIH,DISYS,DIU,DIW,DIWI,I,POP,RALERT,RALINE
 Q
 ;
4 ;;Imaging Location Parameter List
 N RAINA S RAINA=0 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y",DIR("B")="No"
 S DIR("A")="Do you wish to include inactive Imaging Locations"
 S DIR("?",1)="Enter 'Yes' if inactive Imaging Locations are to be"
 S DIR("?")="included, 'No' if only active locations are desired."
 D ^DIR S:$D(DIRUT) RAINA=-1
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT G:RAINA<0 KILL
 S RAINA=Y ; 1 if inactives are included, 0 if only actives included
 N RAX,RAY S RAX=$$LOC^RAUTL12(RAINA) G:'RAX KILL
 S RAY="Rad/Nuc Med Imaging Location Parameter List"
 S DIC="^RA(79.1,",BY="[RA IMAGE LOC LIST]",L=0
 S DIS(0)="I $$INA^RASYS(D0)"
 S RAPOP=$$ZIS(RAY)
 I +RAPOP D HOME^%ZIS,KILL Q
 I +$P(RAPOP,"^",2) D KILL Q  ; Q'ed off in ZIS subroutine
 E  D ENTASK ; not queued, to run now
 Q
 ;
5 ;;Camera/Equip/Room Entry/Edit
 S DIC="^RA(78.6,",DIC(0)="AELMQ",DIC("A")="Select Camera/Equip/Room: ",DLAYGO=78.6 D ^DIC K DIC,DLAYGO I Y<0 K X,Y D KILL5 Q
 S DA=+Y,DIE="^RA(78.6,",DR=".01:99" D ^DIE K %,D0,DA,DE,DQ,DIE,DR,X,Y D KILL5 W ! G 5
KILL5 K D,DG,DI,DISYS,I,POP Q
 ;
6 ;;List of Camera/Equip/Rooms
 S DIC="^RA(79.1,",L=0,BY="[RA EXAM ROOM LIST]"
 S DIOEND="D NOLOC^RASYS" D EN1^DIP
 K DIOEND,FLDS,BY,DHD,TO,FR,RANOLOC,POP
 Q
ENTASK ; Entry point for the tasked job.
 S RAIOP=ION_";"_IOST_";"_IOM_";"_IOSL,IOP=RAIOP
 S:$E(IOP,1,3)="HFS" %ZIS("HFSNAME")=IO,%ZIS("HFSMODE")="W"
 D EN1^DIP
 D KILL^RASYS
 Q
INA(RAD0) ; Determine if an Imaging Location is inactive.
 ; Input : 'RAD0'  ien of file 79.1
 ; Output: '1' if the location is valid, '0' if invalid
 N RA791 S RA791=$G(^RA(79.1,D0,0))
 S RA791(1)=$$XTERNAL^RAUTL5($P(RA791,"^"),$P($G(^DD(79.1,.01,0)),"^",2))
 Q:'($D(^TMP($J,"RA L-TYPE",RA791(1),D0))#2) 0 ; not user selected
 Q 1
KILL ; Kill and quit
 K ^TMP($J,"RA L-TYPE"),%X,%XX,%Y,%YY
 K %ZIS,BY,DHD,DIC,DIS,DTOUT,DUOUT,FLDS,FR,L,POP,RAIOP,RAINA,RAPOP,TO
 K X,Y,ZTDESC,ZTRTN,ZTSAVE,POP,I
 Q
NOLOC ;print camera/equip/rm's not assigned to any imaging loc
 I $D(RANOLOC) Q
 N R1,R2,R3,RACAM,R4 S R4=0
 S R1=0 F  S R1=$O(^RA(78.6,R1)) Q:'R1  S RACAM(R1)=""
 S R2=0 F  S R2=$O(^RA(79.1,R2)) Q:'R2  S R3=0 F  S R3=$O(^RA(79.1,R2,"R",R3)) Q:'R3  D
 . S R1=$G(^RA(79.1,R2,"R",R3,0))
 . K RACAM(R1)
 S R1=0 F  S R1=$O(RACAM(R1)) W:'R1 # Q:'R1  D
 . W:R4 ! S R4=1 W ?3,$E($P(^RA(78.6,R1,0),U),1,15),?20,"**UNASSIGNED**",?45,"**UNASSIGNED**"
 S RANOLOC=1 Q
INACT ; write inactive flag, called by 'List of Camera/Equip/Rms' option
 Q:$G(DDDD0)=""
 N RA1,RA2 S RA1=$O(^RA(78.6,"B",DDDD0,0)),RA2=0
 I RA1 I $G(^RA(78.6,RA1,0))]"",$P(^(0),U,3)]"" S RA2=1
 W ?0,$S(RA2:"(*)",1:"   "),$E(DDDD0,1,15)
 Q
7 ;;RA SYSUPLOC /RA178;KLM - Menu to automatically set outside locations 'Suppress Ordering?' prompt to YES.
 N RACM,RAILOC,RAIL,RAFDA,RADIC,RAUTIL S RACM=2
 K ^TMP($J,"RA178")
 W !!,?5,"This option will set the selected outside imaging locations to"
 W !,?5,"'Suppress Ordering'. Doing this will prevent the location from"
 W !,?5,"showing up in CPRS as a 'Submit To' location for a radiology"
 W !,?5,"request."
 W !!,?3,"**Note that your selection is limited to outside (no credit) locations.**"
 W !,?3,"**If you select 'ALL', all of your outside locations will be updated.**"
 S RADIC="^RA(79.1,",RADIC(0)="OEMZ",RADIC("S")="I $P(^RA(79.1,+Y,0),U,19)="""",$D(^RA(79.1,""ACM"",2,+Y))"
 S RADIC("A")="Select Location(s): ",RAUTIL="RA178"
 W !! D EN1^RASELCT(.RADIC,RAUTIL)
 I $O(^TMP($J,"RA178",""))="" W !!?3,$C(7),"No location selected." Q
 S RAILOC="" F  S RAILOC=$O(^TMP($J,"RA178",RAILOC)) Q:RAILOC=""  D
 .S RAIL=0 F  S RAIL=$O(^TMP($J,"RA178",RAILOC,RAIL)) Q:RAIL=""  D
 ..S:$$GET1^DIQ(79.1,RAIL,.1)="" RAFDA(79.1,RAIL_",",.1)="Y"
 ..Q
 .Q
 D FILE^DIE("","RAFDA") W !!?2,"Location(s) updated...",!
 W !,?2,"Your outside location order suppression status:"
 N RAI S RAI=0 F  S RAI=$O(^RA(79.1,"ACM",RACM,RAI)) Q:RAI=""  D
 .W !?2,$E($$GET1^DIQ(79.1,RAI,.01),1,25),?30,"Suppress Order?: ",$S($G(^RA(79.1,RAI,.1))="Y":"YES",1:"NO")
 .Q
 W ! S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 K ^TMP($J,"RA178"),DIR,DIRUT,DUOUT
 Q
ZIS(RA) ; Select a device.
 ; 'RAPOP'=device selection successful (1:no) ^ '^%ZTLOAD' called (1:yes)
 K %ZIS,IOP S %ZIS="NMQ"
 W ! S %ZIS("A")="DEVICE: " D ^%ZIS
 S RAPOP=POP_"^"
 I '+RAPOP,($D(IO("Q"))) D
 . K IO("Q") S ZTDESC=RA,ZTRTN="ENTASK^RASYS"
 . D ZTSAVE,^%ZTLOAD S $P(RAPOP,"^",2)=1
 . I +$G(ZTSK) W !?3,"Request Queued, Task #: ",$G(ZTSK)
 . D HOME^%ZIS
 . Q
 Q RAPOP
ZTSAVE ; Save off variables for the tasked job.
 N I F I="BY","DIC","FLDS","FR","L","RAINA","TO" S ZTSAVE(I)=""
 S:($D(DIS)\10) ZTSAVE("DIS(")=""
 S:($D(DHD)#2) ZTSAVE("DHD")=""
 S:($D(^TMP($J,"RA L-TYPE"))\10) ZTSAVE("^TMP($J,""RA L-TYPE"",")=""
 Q
RDEV ; Select a Resource Device for a division.  This subroutine is linked
 ; directly to the option: RA RESOURCE DEVICE.  This option is a menu
 ; item under the RA SITEMANAGER menu option.
 N %,%X,%Y,C,D,D0,DA,DDER,DDH,DI,DIC,DIE,DQ,DR,X,Y S (DIC,DIE)="^RA(79,"
 S DIC(0)="QEAMZ",DIC("A")="Select a Rad/Nuc Med Division: " D ^DIC
 G:Y'>0 QRDEV S DA=+Y,DR="D RDEVHLP^RASYS;100" D ^DIE
QRDEV K DISYS,DST,I,POP
 Q
RDEVHLP ; Display the Description Text for the Resource Device (#100) field
 ; on the Rad/Nuc Med Division file.
 N RA100DES,Z S Z=0 D FIELD^DID(79,100,"","DESCRIPTION","RA100DES")
 Q:'$D(RA100DES("DESCRIPTION"))  W !
 F  S Z=$O(RA100DES("DESCRIPTION",Z)) Q:Z'>0  D
 . W !,$G(RA100DES("DESCRIPTION",Z))
 . Q
 W !
 Q
 ;
SACNPAR ; Site (long) Accession Number Parameter Entry/Edit
 ;W !!?3,"Warning: Editing the 'USE SITE ACCESSION NUMBER?' field on a record"
 ;W !?3,"in the RAD/NUC MED DIVISION file may lead to the instability of the"
 ;W !?3,"VistA RADIOLOGY/NUCLEAR MEDICINE application.",!
 W !!?3,"Warning: Turning on the Site Specific Accession Number should only"
 W !?3,"be done in conjunction with using the RA v2.4 messaging protocols."
 W !!?3,"NOTE: Changing the Site Specific Accession Number parameter at a"
 W !?3,"multidivisional site will change the parameter for ALL divisions."
 ;K DIC S DIC(0)="AEMQZ",DIC("A")="Select Facility to Edit: "
 ;S DIC="^RA(79," D ^DIC
 ;I $D(DTOUT)!($D(DUOUT))!(Y=-1) D END Q
 N RAVAL S RAVAL=$O(^RA(79,0)),RAVAL=$P($G(^RA(79,RAVAL,.1)),"^",31)
 W !!,"Current value of Site Specific Accession Number parameter: ",$S(RAVAL="Y":"YES",1:"NO")
 S DIR(0)="YA",DIR("A")="Use Site Specific Accession Number? " D ^DIR
 S DIR("?")="Answer 'YES' to turn on use of the Site Specific Accession Number or 'NO' to turn it off."
 Q:$D(DIRUT)
 N RAZVAL S RAZVAL="N" I Y=1 S RAZVAL="Y"
 F RAZZDIV=0:0 S RAZZDIV=$O(^RA(79,RAZZDIV)) Q:RAZZDIV'>0  D
 .S (DA,RADA)=+RAZZDIV,DR=".131////^S X=RAZVAL",DIE="^RA(79,"
 .D ^DIE
 Q
END ;
 K DA,DIC,DIE,DR,DTOUT,DUOUT,RADA,X,Y
 Q
 ; 
