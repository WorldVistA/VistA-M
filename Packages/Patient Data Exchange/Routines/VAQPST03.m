VAQPST03 ;ALB/JFP - PDX, POST INIT ROUTINE ;01JUN93
 ;;1.5;PATIENT DATA EXCHANGE;**1**;NOV 17, 1993
SEG ; -- Initialization of VAQ - Segment Group file 394.84
 W !!,"Initialization of VAQ - Segment Group File...",!
 I '$D(^VAT(394.84)) W !,"Error...VAQ - Segment Group file missing, post init halted" S POP=1 QUIT
 D ALL^VAQPST04
 D COP^VAQPST04
 W !!,"Add/Edit/Delete entries in VAQ - Segment Group File",!
 F  D S1 Q:EXIT=-1
 W !!," ** Initialization of VAQ - Segment Group File complete"
 K EXIT,Y
 QUIT
S1 ; -- Prompt entry
 W !
 S DIC="^VAT(394.84,",DIC(0)="ALQ",DIC("DR")="[VAQ EDIT FILE]"
 S DLAYGO=394.84
 D ^DIC K DIC,DLAYGO
 S EXIT=$P(Y,U,1)
 I Y=-1 QUIT
 I $P(Y,U,3)=1 QUIT
 ; -- Update existing entry
 S DIE="^VAT(394.84,",DA=$P(Y,U,1),DR="[VAQ EDIT FILE]"
 D ^DIE K DIE,DA,DR
 I $D(Y) S EXIT=-1
 QUIT
 ;
OUT ; -- Initialization of VAQ - Outgoing Group file 394.83
 W !!,"Initialization of VAQ - Outgoing Group File... (add/edit/delete) ",!
 I '$D(^VAT(394.83)) W !,"Error...VAQ - Outgoing Group file missing, post init halted" S POP=1 QUIT
 F  D O1 Q:EXIT=-1
 W !!," ** Initialization of VAQ - Outgoing Group File complete"
 K EXIT,Y
 QUIT
O1 ; -- Prompt entry
 W !
 S DIC="^VAT(394.83,",DIC(0)="ALQ",DIC("DR")="[VAQ EDIT FILE]"
 S DLAYGO=394.83
 D ^DIC K DIC,DLAYGO
 S EXIT=$P(Y,U,1)
 I Y=-1 QUIT
 I $P(Y,U,3)=1 QUIT
 ; -- Update existing entry
 S DIE="^VAT(394.83,",DA=$P(Y,U,1),DR="[VAQ EDIT FILE]"
 D ^DIE K DIE,DA,DR
 I $D(Y) S EXIT=-1
 QUIT
 ;
REL ; -- Initialization of VAQ - Release Group file 394.82
 W !!,"Initialization of VAQ - Release Group File... ",!
 I '$D(^VAT(394.82)) W !,"Error...VAQ -Release Group file missing, post init halted" S POP=1 QUIT
 D COPV1
 W !,"Add/Edit/Delete entries in VAQ - Release Group"
 F  D R1 Q:EXIT=-1
 W !!," ** Initialization of VAQ - Release Group File complete"
 K EXIT,Y
 QUIT
R1 ; -- Prompt entry
 W !
 S DIC="^VAT(394.82,",DIC(0)="ALQ",DIC("DR")="[VAQ EDIT FILE]"
 S DLAYGO=394.82
 D ^DIC K DIC,DLAYGO
 S EXIT=$P(Y,U,1)
 I Y=-1 QUIT
 I $P(Y,U,3)=1 QUIT
 ; -- Update existing entry
 S DIE="^VAT(394.82,",DA=$P(Y,U,1),DR="[VAQ EDIT FILE]"
 D ^DIE K DIE,DA,DR
 I $D(Y) S EXIT=-1
 QUIT
 ;
ENCR ; -- Initialization of VAQ - Encrypted Fields File 394.73
 W !!,"Initialization of VAQ - Encrypted Fields File... (add/edit/delete) ",!
 I '$D(^VAT(394.73)) W !,"Error...VAQ - Encrypted fields file missing, post init halted" S POP=1 QUIT
 F  D E1 Q:EXIT=-1
 W !!," ** Initialization of VAQ - Encrypted Fields File complete"
 K EXIT,Y
 QUIT
E1 ; -- Prompt entry
 W !
 S DIC="^VAT(394.73,",DIC(0)="ALQ",DIC("DR")="[VAQ EDIT FILE]"
 S DLAYGO=394.73
 D ^DIC K DIC,DLAYGO
 S EXIT=$P(Y,U,1)
 I Y=-1 QUIT
 I $P(Y,U,3)=1 QUIT
 ; -- Update existing entry
 S DIE="^VAT(394.73,",DA=$P(Y,U,1),DR="[VAQ EDIT FILE]"
 D ^DIE K DIE,DA,DR
 I $D(Y) S EXIT=-1
 QUIT
 ;
COPV1 ; -- Copies multiple in V1.0 PDX parameter file to release group file
 W !," Updating VAQ - Release Group file from version 1.0",!
 I '$D(^VAT(394.2)) W !,"   ** Unable to update...version 1.0 file missing. Requires Manual entry" QUIT
 N ENTRY,ND,INSTPT,INST,DOMPT,DOM
 S ENTRY=""
 F  S ENTRY=$O(^VAT(394.2,1,1,ENTRY))  Q:ENTRY=""  D V2
 W !!,"Update from version 1 completed",!
 QUIT
V2 ; --
 S ND=$G(^VAT(394.2,1,1,ENTRY,0))
 S INSTPT=$P(ND,U,1),DOMPT=$P(ND,U,2)
 Q:INSTPT=""
 Q:DOMPT=""
 Q:'$D(^DIC(4,INSTPT,0))
 S INST=$P(^DIC(4,INSTPT,0),U,1)
 Q:'$D(^DIC(4.2,DOMPT,0))
 S DOM=$P(^DIC(4.2,DOMPT,0),U,1)
 ; -- update file
 S DIC="^VAT(394.82,",DIC(0)="L",DLAYGO=394.82,X=INST
 S DIC("DR")=".02///"_DOM
 D ^DIC K DIC,X,DLAYGO
 I Y=-1 W !,"   * Unable to add ",INST,"  to VAQ - Release Group File"
 W !,"   ",INST," added"
 QUIT
END ; -- End of code
 QUIT
