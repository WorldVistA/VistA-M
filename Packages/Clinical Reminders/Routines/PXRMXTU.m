PXRMXTU ; SLC/PJH - Reminder Reports Template Update ;07/30/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ; 
 ; Called from PXRMYD,PXRMXD (also at UPD from PXRMXPR/PXRMYPR)
 ;
 ;Option to create a new template
 ;-------------------------------
START N PXRMASK,MSG D ASK(.PXRMASK)
 I $G(PXRMASK)="Y" D SAVE
EXIT Q
 ;
 ;Ask name for new template
 ;-------------------------
SAVE N X,Y,DIC,DLAYGO
SAV1 S DIC=810.1,DLAYGO=DIC,DIC(0)="QAELX"
 S DIC("A")="STORE REPORT LOGIC IN TEMPLATE NAME: "
 W !
 D ^DIC
 I X="" W !,"A template name must be entered" G SAV1
 I X=(U_U) S DTOUT=1
 I Y=-1 S DUOUT=1 W !,"Details not saved" Q
 I $D(DTOUT)!$D(DUOUT) Q
 ;Check
 I ($P(Y,U,3)'=1) W !,"This template name already exists" G SAV1
 ;Get template name and title
 S PXRMTMP=Y,TITLE=$P($G(^PXRMPT(810.1,$P(Y,U),0)),U,2)
 S $P(PXRMTMP,U,3)=TITLE
 ;File details
 D FILE(Y,1,0)
 ;File not saved message
 I $D(MSG) D  Q
 .N DA,DIK
 .S DA=$P(Y,U),DIK="^PXRMPT(810.1," D ^DIK
 .D MESS^PXRMXTF(4,$P(PXRMTMP,U,2))
 ;File saved message
 D MESS^PXRMXTF(1,$P(PXRMTMP,U,2))
 Q
 ;
 ;File template detail
 ;--------------------
FILE(INP,UPD,CLR) ;
 N CNT,FDA,FDAIEN,FNO,IC,INT,MODE,NAME,X
 S FDAIEN(1)=$P(INP,U),NAME=$P(INP,U,2)
 ;Save exit flags - needed for rollback
 N DUOUT,DTOUT
 ;
 ;Update or Add
 S MODE=$S(UPD:(FDAIEN(1)_","),1:"+1,")
 ;Delete entries from existing template
 I CLR D
 .N DA S DA=0
 .F  S DA=$O(^PXRMPT(810.1,FDAIEN(1),DA)) Q:'DA  D
 ..K ^PXRMPT(810.1,FDAIEN(1),DA)
 ;
 I PXRMSEL="L" S X=PXRMLCSC,PXRMLCSC=$P(PXRMLCSC,U)
 ;
 N MREF,XREF
 D XREF^PXRMXTB
 ;
 ;Save single fields into FDA
 F IC="NAME","PXRMLCSC","PXRMPRIM","PXRMREP","PXRMSEL","PXRMTYP","PXRMPML","PXRMPER" D
 .S FDA(810.1,MODE,XREF(IC))=$G(@IC)
 F IC="PXRMFD","PXRMSCAT","RUN","TITLE" D
 .S FDA(810.1,MODE,XREF(IC))=$G(@IC)
 ;Save Owner value
 S FDA(810.1,MODE,15)=$S(+$G(PXRMOWN)>0:PXRMOWN,1:DUZ)
 ;
 I PXRMSEL="L" S PXRMLCSC=X
 ;
 ;Save Arrays into FDA
 ;
 ;Reminder Items
 S CNT=1
 D SUB1(.PXRMREM,"810.12",1)
 ;Save Facility codes
 D SUB1(.PXRMFAC,"810.13",1)
 ;Save Provider codes
 D SUB1(.PXRMPRV,"810.14",1)
 ;Save Patient codes
 D SUB1(.PXRMPAT,"810.16",1)
 ;Save OE/RR Team codes
 D SUB1(.PXRMOTM,"810.17",1)
 ;Save PCMM Team codes
 D SUB1(.PXRMPCM,"810.18",1)
 ;Save Hospital Location codes
 D SUB1(.PXRMLCHL,"810.11",2)
 ;Save Clinic Stop codes
 D SUB1(.PXRMCS,"810.111",2)
 ;Save Clinic groups
 D SUB1(.PXRMCGRP,"810.112",1)
 ;Save Reminder Categories
 D SUB1(.PXRMRCAT,"810.113",1)
 ;Save Patient lists
 D SUB1(.PXRMLIST,"810.114",1)
 ;
 ;Update template file
 D UPDATE^DIE("S","FDA","FDAIEN","MSG")
 ;
 I $D(MSG) D
 .W !!,"Update failed, UPDATE^DIE returned the following error message:"
 .S IC="MSG"
 .F  S IC=$Q(@IC) Q:IC=""  W !,IC,"=",@IC
 .W !,"Examine the above error message for the reason.",!
 .H 2
 Q
 ;
 ;Save arrays into FDA
 ;--------------------
SUB1(OUTPUT,VAR,PIECE) ;
 S IC=""
 ;This is use for saving individual reminders back to the original
 ;template
 I VAR=810.12,$D(PXRMTREM($P(INP,U)))>0 D  Q
 .F  S IC=$O(PXRMTREM($P(INP,U),IC)) Q:IC=""  D
 ..S INT=$P(PXRMTREM($P(INP,U),IC),U,PIECE),CNT=CNT+1
 ..S FDA(VAR,"+"_CNT_","_MODE,.01)=INT
 ..S FDA(VAR,"+"_CNT_","_MODE,.02)=IC
 ;
 ;This is use for saving individual reminders category back to the 
 ;original template
 I VAR=810.113,$D(PXRMTCAT($P(INP,U)))>0 D  Q
 .F  S IC=$O(PXRMTCAT($P(INP,U),IC)) Q:IC=""  D
 ..S INT=$P(PXRMTCAT($P(INP,U),IC),U,PIECE),CNT=CNT+1
 ..S FDA(VAR,"+"_CNT_","_MODE,.01)=INT
 ..S FDA(VAR,"+"_CNT_","_MODE,.02)=IC
 ;
 ;this is use for saving everything else to the template
 F  S IC=$O(OUTPUT(IC)) Q:IC=""  D
 .S INT=$P(OUTPUT(IC),U,PIECE),CNT=CNT+1
 .S FDA(VAR,"+"_CNT_","_MODE,.01)=INT
 .;Save Display order for reminders and categories
 .I (VAR=810.12)!(VAR=810.113) S FDA(VAR,"+"_CNT_","_MODE,.02)=IC
 Q
 ;
 ;Save Service Categories into FDA
 ;--------------------------------
SUB2(FLD,VAR) ;
 F IC=1:1 S INT=$E(@FLD,IC) Q:INT=""  D
 .S CNT=CNT+1,FDA(VAR,"+"_CNT_","_MODE,.01)=INT
 Q
 ;
 ;
 ;Option to save a new template
 ;-----------------------------
ASK(YESNO) ;
 N X,Y,TEXT
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")="Create a new report template: "
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXTU(1)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
 ;General help text routine. Write out the text in the HTEXT array
 ;----------------------------------------------------------------
HELP(CALL) ;
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C70",DIWL=0,DIWR=70
 ;
 I CALL=1 D
 .S HTEXT(1)="Enter 'Y' to save the reporting parameters as a report"
 .S HTEXT(2)="template from which the report may be re-run in future."
 ;
 K ^UTILITY($J,"W")
 S IC=""
 F  S IC=$O(HTEXT(IC)) Q:IC=""  D
 . S X=HTEXT(IC)
 . D ^DIWP
 W !
 S IC=0
 F  S IC=$O(^UTILITY($J,"W",0,IC)) Q:IC=""  D
 . W !,^UTILITY($J,"W",0,IC,0)
 K ^UTILITY($J,"W")
 W !
 Q
 ;
 ;Save template info to new name
 ;------------------------------
COPY N PXRMLCSC,PXRMPRIM,PRRMREP,PXRMSEL,PXRMTYP,PXRMFD,RUN,PXRMCS
 N PXRMREM,PXRMFAC,PXRMPRV,PXRMPAT,PXRMOTM,PXRMSCAT,PXRMLCHL,PXRMCS
 ;Load arrays from original template PXRMTMP
 D LOAD^PXRMXT I $D(MSG) Q
 ;Clear last run date
 S RUN=""
 ;Save arrays to new ID
 D FILE(NEWTEMP,0)
 Q
 ;
 ;Update print template last run date (called from PXRMYPR/PXRMXPR)
 ;-----------------------------------------------------------------
UPD S ^PXRMPT(810.1,$P(PXRMTMP,U),7)=PXRMXST
 Q
 ;
 ;Called as an input transform for 810.1/NAME
 ;-------------------------------------------
NAME Q:'$D(X)  Q:X=""  Q:$G(PXRMTYP)=""
 ;Disallow duplicate template names
 Q:'$D(^PXRMPT(810.1,"B",X))
 W !,"This template name already exists" K X
 Q
 ;
 ;Called as an input transform for 810.1/PXRMFD
 ;---------------------------------------------
INP Q:'$D(X)  Q:X=""
 ;If inpatient wards prompt only for Admissions/Current Patients
 I $G(PXRMINP),"FP"[X D
 .W !,"Select either Inpatient Admissions or Current Inpatients" K X
 ;If other locations prompt only for Prior visits/Future Appts
 I '$G(PXRMINP),"AC"[X D
 .W !,"Select either Future Appointments or Prior Visits" K X
 Q
