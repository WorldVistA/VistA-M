PXRMREDT ;SLC/PKR,PJH - Edit PXRM reminder definition. ;03/08/2011
 ;;2.0;CLINICAL REMINDERS;**4,6,12,18**;Feb 04, 2005;Build 152
 ;
 ;=======================================================
EEDIT ;Entry point for PXRM DEFINITION EDIT option.
 ;Build list of finding file definitions.
 N DEF,DEF1,DEF2,NEW
 D DEF^PXRMRUTL("811.902",.DEF,.DEF1,.DEF2)
 ;
 N DA,DIC,DLAYGO,DTOUT,DUOUT,Y
 S DIC="^PXD(811.9,"
 S DIC(0)="AEMQL"
 S DIC("A")="Select Reminder Definition: "
 S DLAYGO=811.9
GETNAME ;Get the name of the reminder definition to edit.
 ;Set the starting place for additions.
 D SETSTART^PXRMCOPY(DIC)
 W !
 S DIC("W")="W $$LUDISP^PXRMREDT(Y)"
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 G END
 S DA=$P(Y,U,1)
 S NEW=$P(Y,U,3)
 D ALL(DIC,DA,.DEF1,NEW)
 G GETNAME
END ;
 Q
 ;
 ;=======================================================
 ;Select section of reminder to edit, also called at ALL by PXRMEDIT.
 ;----------------------------------
ALL(DIC,DA,DEF1,NEW) ;
 ;Get list of findings/terms for reminder
 N BLDLOGIC,CS1,CS2,DTOUT,DUOUT,LIST,NODE,OPTION,TYPE
 ;Save the original checksum.
 S CS1=$$FILE^PXRMEXCS(811.9,DA)
STRTEDIT S BLDLOGIC=0
 ;Build finding list
 S NODE="^PXD(811.9)"
 D LIST(NODE,DA,.DEF1,.LIST)
 ;If this is a new reminder enter all fields
 I $G(NEW) D EDIT(DIC,DA) Q 
 ;National reminder allows editing of term findings only 
 I '$$VEDIT^PXRMUTIL(DIC,DA) D  Q:$D(DUOUT)!$D(DTOUT)
 .S TYPE=""
 .F  S TYPE=$O(LIST(TYPE)) Q:TYPE=""  D
 .. I TYPE="RT" Q
 .. K LIST(TYPE)
 .I '$D(LIST) S DUOUT=1 Q
 .S BLDLOGIC=1
 .D TFIND(DA,.LIST)
 .I $D(Y) S DUOUT=1
 ;Otherwise choose fields to edit
 I $$VEDIT^PXRMUTIL(DIC,DA) F  D  Q:($G(OPTION)="^")!$D(DUOUT)!$D(DTOUT)
 .S OPTION=$$OPTION^PXRMREDT Q:(OPTION="^")!$D(DUOUT)!$D(DTOUT)
 .;All details
 .I OPTION="A" D
 .. S BLDLOGIC=1
 .. D EDIT(DIC,DA)
 .;Set up local variables
 .N DIE,DR S DIE=DIC N DIC
 .;Descriptions
 .I OPTION="G" D
 ..D GEN
 .;Baseline Frequency
 .I OPTION="B" D
 ..S BLDLOGIC=1
 ..D BASE
 .;Findings
 .I OPTION="F"  D
 ..S BLDLOGIC=1
 ..D FIND(.LIST)
 .;Function findings
 .I OPTION="FF"  D
 ..S BLDLOGIC=1
 ..D FFIND
 .;Logic
 .I OPTION="L" D
 ..S BLDLOGIC=1
 ..D LOGIC
 .;Custom date due
 . I OPTION="C" D
 ..S BLDLOGIC=1
 ..D CDUE
 .;Dialog
 .I OPTION="D" D
 ..D DIALOG
 .;Web addresses
 .I OPTION="W" D
 ..D WEB
 .;If necessary build the internal logic strings.
 .I BLDLOGIC D BLDALL^PXRMLOGX(DA,"","")
 ;See if any changes have been made.
 S CS2=$$FILE^PXRMEXCS(811.9,DA)
 I CS2=0 Q
 ;If the file has been edited, do an integrity check.
 I CS2'=CS1 D
 . I OPTION="^" Q
 . W !,"Checking integrity of the definition ...",#
 . I OPTION'="^",'$$DEF^PXRMICHK(DA) G STRTEDIT
 .;If it passes the integrity check save the edit history.
 . D SEHIST^PXRMUTIL(811.9,DIC,DA)
 Q
 ;
 ;Reminder Edit
 ;-------------
EDIT(ROOT,DA) ;
 N DIC,DIDEL,DIE,DR,RESULT
 S DIE=ROOT,DIDEL=811.9
 ;Edit the fields in the same order they are printed by a reminder
 ;inquiry.
 ;Reminder name
 W !!
 S DR=".01"
 D ^DIE
 ;If DA is undefined then the entry was deleted and we are done.
 I '$D(DA) S DTOUT=1 Q
 I $D(Y) S DTOUT=1 Q
 ;
 ;Other fields
 D GEN Q:$D(Y)
 D BASE Q:$D(Y)
 D FIND(.LIST) Q:$D(Y)
 D FFIND Q:$D(Y)
 D LOGIC Q:$D(Y)
 D DIALOG Q:$D(Y)
 D WEB Q:$D(Y)
 W #
 I '$$DEF^PXRMICHK(DA) G STRTEDIT
 ;If it passes the integrity check save the edit history.
 D SEHIST^PXRMUTIL(811.9,DIC,DA)
 Q
 ;
GEN ;Print name
 W !!
 S DR="1.2"
 D ^DIE
 I $D(Y) Q
 ;
CLASS ;
 ;Class
 W !!
 S DR="100"
 D ^DIE
 I $D(Y) Q
 ;Sponsor
 S DR="101"
 D ^DIE
 I $D(Y) Q
 ;Make sure Class and Sponsor Class are in synch.
 S RESULT=$$VSPONSOR^PXRMINTR(X)
 I RESULT=0 G CLASS
 ;Review date, Usage
 S DR="102;103"
 D ^DIE
 I $D(Y) Q
 ;
 ;Related VA-* reminder
 W !!
 S DR="1.4"
 D ^DIE
 I $D(Y) Q
 ;
 ;Inactive flag
 W !!
 S DR="1.6"
 D ^DIE
 I $D(Y) Q
 ;Ignore on N/A
 S DR=1.8
 D ^DIE
 I $D(Y) Q
 ;
 ;Recision Date
 S DR="69"
 D ^DIE
 I $D(Y) Q
 ;
 ;Reminder description
 W !!
 S DR="2"
 D ^DIE
 I $D(Y) Q
 ;
 ;Technical description
 W !!
 S DR="3"
 D ^DIE
 ;
 ;Priority
 W !!
 S DR="1.91"
 D ^DIE
 Q
 ;
BASE W !!,"Baseline Frequency"
 ;Do in advance time frame
 S DR=1.3
 D ^DIE
 I $D(Y) Q
 ;
 ;Sex specific
 S DR=1.9
 D ^DIE
 I $D(Y) Q
FARS ;
 W !!,"Baseline frequency age range set"
 S DR="7"
 S DR(2,811.97)=".01;1;2;3;4"
 D ^DIE
 I $$OVLAP^PXRMAGE G FARS
 D SNMLA^PXRMFNFT(DA)
 Q
 ;
FIND(LIST) ;Edit findings (multiple)
 D FIND^PXRMREDF(.LIST)
 D SNMLF^PXRMFNFT(DA,20)
 Q
 ;
FFIND W !!,"Function Findings"
 D FFIND^PXRMREDF
 D SNMLF^PXRMFNFT(DA,25)
 Q
 ;
LOGIC W !!,"Patient Cohort and Resolution Logic"
 S DR="30T;60T;61T;70T;71T;34T;65T;66T;75T;76T"
 D ^DIE
 ;Make sure the Patient Cohort Logic at least contains the default.
 I $G(^PXD(811.9,DA,31))="" D
 . S ^PXD(811.9,DA,31)="(SEX)&(AGE)"
 . S ^PXD(811.9,DA,32)="2"_U_"SEX;AGE"
 D SNMLL^PXRMFNFT(DA)
 Q
CDUE W !!,"Custom Date Due"
 S DR=45
 D ^DIE
 Q
 ;
DIALOG W !!,"Reminder Dialog"
 S DR="51"
 D ^DIE
 Q
 ;
WEB W !!,"Web Addresses for Reminder Information"
 S DR="50"
 D ^DIE
 Q
 ;
 ;Get full list of findings
 ;-------------------------
LIST(GBL,DA,DEF1,ARRAY) ;
 N CNT,DATA,GLOB,IEN,NAME,NODE,SUB,TYPE
 ;Clear passed arrays
 K ARRAY
 S CNT=0
 ;Build cross reference global to file number
 ;Get each finding
 S SUB=0 F  S SUB=$O(@GBL@(DA,20,SUB)) Q:'SUB  D
 .S DATA=$G(@GBL@(DA,20,SUB,0)) I DATA="" Q
 .;Determine global and global ien
 .S NODE=$P(DATA,U),GLOB=$P(NODE,";",2),IEN=$P(NODE,";")
 .;Ignore null entries
 .I (GLOB="")!(IEN="") Q
 .;Work out the file type
 .S TYPE=$G(DEF1(GLOB)) Q:TYPE=""
 .S CNT=CNT+1
 .I $P($G(@(U_GLOB_IEN_",0)")),U)="" D
 ..W !,"**WARNING** Finding #"_SUB_" does not exist, select finding `"_SUB_" to edit it." Q
 .E  S NAME=$P($G(@(U_GLOB_IEN_",0)")),U) S ARRAY(TYPE,NAME,SUB)=IEN
 Q
 ;
 ;Choose which part of Reminder to edit
 ;-------------------------------------
OPTION() ;
 N DIR,X,Y
 ;Display warning message if un-mapped terms exist
 K DIROUT,DIRUT
 S DIR(0)="SO"_U
 S DIR(0)=DIR(0)_"A:All reminder details;"
 S DIR(0)=DIR(0)_"G:General;"
 S DIR(0)=DIR(0)_"B:Baseline Frequency;"
 S DIR(0)=DIR(0)_"F:Findings;"
 S DIR(0)=DIR(0)_"FF:Function Findings;"
 S DIR(0)=DIR(0)_"L:Logic;"
 S DIR(0)=DIR(0)_"C:Custom date due;"
 S DIR(0)=DIR(0)_"D:Reminder Dialog;"
 S DIR(0)=DIR(0)_"W:Web Addresses;"
 S DIR("A",1)="Select a section to edit; press ENTER when you are done editing."
 S DIR("A")="To quit and exit type '^'"
 S DIR("?")="Select which section of the reminder you wish to edit."
 S DIR("??")="^D HELP^PXRMREDF(2)"
 D ^DIR K DIR
 I (Y="")!(Y="^") S DUOUT=1
 Q Y
 ;
 ;-------------------------------------
LUDISP(IEN) ;Use for DIC("W") to augment look-up display.
 N CLASS,EM,INACTIVE,TEXT
 S INACTIVE=$P(^PXD(811.9,IEN,0),U,6)
 S CLASS=$P(^PXD(811.9,IEN,100),U,1)
 I INACTIVE'="" S INACTIVE="("_$$EXTERNAL^DILFD(811.9,1.6,"",INACTIVE,.EM)_")"
 S CLASS=$$EXTERNAL^DILFD(811.9,100,"",CLASS,.EM)
 S TEXT="  "_CLASS_" "_INACTIVE
 Q TEXT
 ;
 ;-------------------------------------
TFIND(DA,LIST) ;Allow edit of term findings for national reminders.
 N DIR,IENLIST,IND,JND,NAME,NAMELIST,SUB,X,Y
 S IND=0,NAME=""
 F  S NAME=$O(LIST("RT",NAME)) Q:NAME=""  D
 . S IND=IND+1
 . S NAMELIST(IND)=$$RJ^XLFSTR(IND,3)_" "_NAME
 . S SUB=$O(LIST("RT",NAME,""))
 . S IENLIST(IND)=LIST("RT",NAME,SUB)
 M DIR("A")=NAMELIST
 S DIR("A")="Enter your list"
 S DIR(0)="LO^1:"_IND
 W !!,"Select term(s) for finding edit:"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S LIST="" Q
 I $D(DUOUT)!$D(DTOUT) S LIST="" Q
 F IND=1:1:$L(Y,",")-1 D
 . S JND=$P(Y,",",IND)
 . S NAME=$P(NAMELIST(JND),JND,2)
 . W !!,"Reminder Term:",NAME
 . D TMAP^PXRMREDF(DA,IENLIST(JND))
 Q
 ;
