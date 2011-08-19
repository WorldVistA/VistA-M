PXRMLRED ; SLC/PJH - List Rule Editor ;05/30/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;Main entry point for PXRM LIST RULE EDIT/DISPLAY
START(IEN,PXRMTYP) ;
 N PXRMDONE,VALMBCK,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 S X="IORESET"
 D ENDR^%ZISS
 S VALMCNT=0
 D EN^VALM("PXRM LIST RULE DISPLAY/EDIT")
 Q
 ;
ADD ;Add Rule
 N DA,DIC,DONE,DTOUT,DUOUT,DLAYGO,HED,TYP,Y
 S HED="ADD "_$$TXT,TYP=PXRMTYP,DONE=0
 W IORESET,!
 F  D  Q:$D(DTOUT)  Q:DONE
 .S DIC="^PXRM(810.4,"
 .;Set the starting place for additions.
 .D SETSTART^PXRMCOPY(DIC)
 .S DIC(0)="AELMQ",DLAYGO=810.4
 .S DIC("A")="Select "_$$TXT_" to add: "
 .S DIC("DR")=".03///"_TYP
 .D ^DIC
 .I $D(DUOUT) S DTOUT=1
 .I ($D(DTOUT))!($D(DUOUT)) Q
 .I Y=-1 K DIC S DTOUT=1 Q
 .I $P(Y,U,3)'=1 W !,"This rule name already exists" Q
 .S DA=$P(Y,U,1)
 .;Edit Rule
 .D EDIT(DA,TYP)
 .S:$D(DA) DONE=1
 Q
 ;
BLDLIST(IEN,TYP) ;Build workfile
 N FLDS,GBL,PXRMROOT
 I TYP=1 S FLDS="[PXRM FINDING RULE]"
 I TYP=2 S FLDS="[PXRM REMINDER RULE]"
 I TYP=3 S FLDS="[PXRM RULE SET]"
 I TYP=5 S FLDS="[PXRM PATIENT LIST RULE]"
 S GBL="^TMP(""PXRMLRED"",$J)"
 S GBL=$NA(@GBL)
 S PXRMROOT="^PXRM(810.4,"
 K ^TMP("PXRMLRED",$J)
 D DIP^PXRMUTIL(GBL,IEN,PXRMROOT,FLDS)
 S VALMCNT=$O(^TMP("PXRMLRED",$J,""),-1)
 Q
 ;
EDIT(DA,TYP) ;Edit Rule
 I '$$VEDIT^PXRMUTIL("^PXRM(810.4,",DA) D  Q
 .W !!,?5,"VA- and national class rules may not be edited" H 2
 .S VALMBCK="R"
 ;
 Q:'$$LOCK(DA)
 W IORESET
 N CS1,CS2,DIC,DIDEL,DIE,DR,DTOUT,DUOUT,ODA,Y
 ;Save checksum
 S CS1=$$FILE^PXRMEXCS(810.4,DA)
 ;Check rule type
 S DIE="^PXRM(810.4,",DIDEL=810.4,ODA=DA
 ;List Rule
 I TYP=1 S DR="[PXRM EDIT FINDING RULE]"
 ;Reminder Rule
 I TYP=2 S DR="[PXRM EDIT REMINDER RULE]"
 ;Rule Set
 I TYP=3 S DR="[PXRM EDIT RULE SET]"
 ;Report Output Rule
 I TYP=4 S DR="[PXRM EDIT REPORT OUTPUT RULE]"
 ;Patient List Rule
 I TYP=5 S DR="[PXRM EDIT PATIENT LIST RULE]"
 ;Display any sets using the rule
 I (TYP'=3) D USE(DA,1)
 ;
 ;Save list of components for rule set
 I TYP=3 N COMP D COMP^PXRMLREX(DA,.COMP)
 ;
 ;Edit rule then unlock
 D ^DIE,UNLOCK(ODA)
 ;Deleted ???
 I '$D(DA) D  Q
 .;Option to delete components
 .I TYP=3,$D(COMP) D DELETE^PXRMLREX(.COMP)
 .S VALMBCK="Q"
 ;
 ;Update edit history
 D
 .S CS2=$$FILE^PXRMEXCS(810.4,DA) Q:CS2=CS1  Q:+CS2=0
 .D SEHIST^PXRMUTIL(810.4,DIC,DA)
 S VALMBCK="R"
 Q
 ;
ENTRY ;Entry code
 D BLDLIST(IEN,PXRMTYP)
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMLRED",$J)
 K ^TMP("PXRMLREDH",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
HDR ; Header code
 S VALMHDR(1)="Available "_$$LIT(PXRMTYP)_":"
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HLP ;Help code
 N ORU,ORUPRMT,SUB,XQORM
 S SUB="PXRMLREDH"
 D EN^VALM("PXRM LIST RULE HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 Q
 ;
LIT(VIEW) ;Header text depnds on view
 Q $S(PXRMTYP=3:"Rule Sets",PXRMTYP=1:"List Rules",PXRMTYP=2:"Reminder List Rules",1:"Unknown")
 ;
LOCK(DA) ;Lock the record
 L +^PXRM(810.4,DA):0 I  Q 1
 E  W !!,?5,"Another user is editing this file, try later" H 2 Q 0
 ;
LRDESC ;Display list rule fields - called by [PXRM RULE SET]
 N IEN
 S IEN=$P(X,U,2) Q:'IEN
 D LROUT(IEN,23)
 Q
 ;
LREDIT ;Edit Rule
 D EDIT^PXRMLRED(IEN,PXRMTYP)
 ;Rebuild Workfile
 D BLDLIST(IEN,PXRMTYP)
 Q
 ;
LREND(END,RJC) ;Display end date
 I END]"" W !,$$RJ^XLFSTR("LR Ending Date: ",RJC)_END
 Q
 ;
LROUT(IEN,RJC) ;Output list rule display
 ;also called for parameter display from PXRMEPM
 N BEG,DATA,END,LRN,PLIST,PLIEN,TERM,TIEN,TYPE
 S DATA=$G(^PXRM(810.4,IEN,0))
 S LRN=$P(DATA,U,1)
 ;Type of list rule, start and end dates
 S TYPE=$P(DATA,U,3),BEG=$P(DATA,U,4),END=$P(DATA,U,5)
 W !,$$RJ^XLFSTR("List Rule: ",RJC),LRN
 ;Display description
 W !,$$RJ^XLFSTR("Description: ",RJC),$P(DATA,U,2)
 ;Display Rule Type
 W !,$$RJ^XLFSTR("Rule Type: ",RJC)
 ;Finding Rule
 I TYPE=1 D
 .W "FINDING RULE"
 .W !,$$RJ^XLFSTR("Reminder Term: ",RJC+2)
 .S TIEN=$P(DATA,U,7) Q:'TIEN
 .;Display Term name
 .W $P($G(^PXRMD(811.5,TIEN,0)),U)
 I TYPE=2 D
 .W "REMINDER RULE"
 .W !,$$RJ^XLFSTR("Reminder Definition: ",RJC+2)
 .S RIEN=$P(DATA,U,10) Q:'RIEN
 .;Display Reminder Defintion name
 .W $P($G(^PXD(811.9,RIEN,0)),U,1)
 ;Patient List Rule
 I TYPE=5 D
 .W "PATIENT LIST RULE"
 .N EXISTPL,EXTRPL
 .S EXISTPL=$P(DATA,U,8)
 .I EXISTPL]"" D
 .. S EXISTPL=$P(^PXRMXP(810.5,EXISTPL,0),U,1)
 .. W !,$$RJ^XLFSTR("Use Existing PT List: ",RJC+2),EXISTPL
 .S EXTRPL=$G(^PXRM(810.4,IEN,1))
 .I EXTRPL]"" W !,$$RJ^XLFSTR("Use Extract PT List Named: ",RJC+5)
 .I (RJC+5+$L(EXTRPL))>80 W !,"  "
 .W EXTRPL
 ;Format Start and Stop Dates
 D LRSTRT(BEG,RJC+2),LREND(END,RJC+2)
 Q
 ;
LRSTRT(BEG,RJC) ;Display start date
 I BEG]"" W !,$$RJ^XLFSTR("LR Beginning Date: ",RJC)_BEG
 Q
 ;
PEXIT ;PXRM EXCH MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 Q
 ;
SCREEN ;validate rule type
 Q:'$G(DA(1))
 ;rule sets may not be a component of a rule set
 I $P($G(^PXRM(810.4,DA(1),0)),U,3) S DIC("S")="I $P(^(0),U,3)'=3"
 Q
 ;
SEQPRT ;Display list rule sequence fields - called by [PXRM RULE SET]
 N EXTRPL,IND,LR,LRN,OPER,RJC,RR
 N SEQ,SEQBDT,SEQEDT,TEMP,TEXT
 S RJC=22
 S SEQ=""
 F  S SEQ=$O(^PXRM(810.4,D0,30,"B",SEQ)) Q:SEQ=""  D
 . S IND=$O(^PXRM(810.4,D0,30,"B",SEQ,""))
 . S TEMP=^PXRM(810.4,D0,30,IND,0)
 . S LR=+$P(TEMP,U,2),OPER=$P(TEMP,U,3)
 . S OPER=$$EXTERNAL^DILFD(810.41,.03,"",OPER)
 . S TEMP=$G(^PXRM(810.4,D0,30,IND,1))
 . S SEQBDT=$P(TEMP,U,1),SEQEDT=$P(TEMP,U,2)
 . S EXTRPL=$G(^PXRM(810.4,D0,1))
 . ;Output the sequence fields
 . W !!,$$RJ^XLFSTR("Sequence: ",RJC),SEQ
 . I SEQBDT]"" W !,$$RJ^XLFSTR("Seq Beginning Date: ",RJC),SEQBDT
 . I SEQEDT]"" W !,$$RJ^XLFSTR("Seq Ending Date: ",RJC),SEQEDT
 . W !,$$RJ^XLFSTR("Operation: ",RJC),OPER
 .;Output the List Rule information
 . D LROUT^PXRMLRED(LR,RJC)
 Q
 ;
TXT() ;Return Rule Type text
 N TEXT
 S TEXT="OTHER"
 I PXRMTYP=1 S TEXT="FINDING RULE"
 I PXRMTYP=2 S TEXT="REMINDER DEFINITION RULE"
 I PXRMTYP=3 S TEXT="RULE SET"
 I PXRMTYP=5 S TEXT="PATIENT LIST RULE"
 Q TEXT
 ;
UNLOCK(DA) ;Unlock the record
 L -^PXRM(810.4,DA)
 Q
 ;
USE(DA,EDIT) ;Display usage of list rule
 N TTAB
 S TAB=$S(EDIT:0,1:7)
 W !!,?TAB,"Used by:"
 ;If the AD cross ref is missing this is not used
 I '$D(^PXRM(810.4,"AD",DA)) W " Not used by any rule set",! Q
 ;
 N LRNAM,LRTYP,PXRMTYP
 S TAB=TAB+10
 ;Check if used by any rule sets
 S SUB=0
 F  S SUB=$O(^PXRM(810.4,"AD",DA,SUB)) Q:'SUB  D
 .S DATA=$G(^PXRM(810.4,SUB,0)) Q:DATA=""
 .S LRNAM=$P(DATA,U) Q:LRNAM=""
 .S PXRMTYP=$P(DATA,U,3),LRTYP=$$TXT^PXRMLRED
 .W ?TAB,LRNAM_" ("_LRTYP_")",!
 Q
 ;
USET ;Usage display called from PXRM LIST RULE print template
 D USE(IEN,0)
 Q
 ;
