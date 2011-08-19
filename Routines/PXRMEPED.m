PXRMEPED ; SLC/PJH - Extract Definition Editor ;05/15/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;Main entry point for PXRM EXTRACT DEFINITION EDIT/DISPLAY
START(IEN) ;
 N PXRMDONE,VALMBCK,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 S X="IORESET"
 D ENDR^%ZISS
 S VALMCNT=0
 D EN^VALM("PXRM EXTRACT DEFINITION EDIT")
 Q
 ;
BLDLIST(IEN) ;Build workfile
 N FLDS,GBL,PXRMROOT
 S FLDS="[PXRM EXTRACT DEFINITION]"
 S GBL="^TMP(""PXRMEPED"",$J)"
 S GBL=$NA(@GBL)
 S PXRMROOT="^PXRM(810.2,"
 K ^TMP("PXRMLRED",$J)
 D DIP^PXRMUTIL(GBL,IEN,PXRMROOT,FLDS)
 S VALMCNT=$O(^TMP("PXRMEPED",$J,""),-1)
 Q
 ;
ENTRY ;Entry code
 D BLDLIST(IEN)
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMEPED",$J)
 K ^TMP("PXRMEPEDH",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
HDR ; Header code
 S VALMHDR(1)=""
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HLP ;Help code
 N ORU,ORUPRMT,SUB,XQORM
 S SUB="PXRMEPEDH"
 D EN^VALM("PXRM EXTRACT HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 Q
 ;
PEXIT ;Protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 Q
 ;
ADD ;Add Rule
 N DA,DIC,DONE,DTOUT,DUOUT,DLAYGO,HED,Y
 S HED="ADD EXTRACT DEFINITION",DONE=0
 W IORESET,!
 F  D  Q:$D(DTOUT)  Q:DONE
 .S DIC="^PXRM(810.2,"
 .;Set the starting place for additions.
 .D SETSTART^PXRMCOPY(DIC)
 .S DIC(0)="AELMQ",DLAYGO=810.2
 .S DIC("A")="Select EXTRACT DEFINITION to add: "
 .D ^DIC
 .I $D(DUOUT) S DTOUT=1
 .I ($D(DTOUT))!($D(DUOUT)) Q
 .I Y=-1 K DIC S DTOUT=1 Q
 .I $P(Y,U,3)'=1 W !,"This extract definition name already exists" Q
 .S DA=$P(Y,U,1)
 .;Edit Extract Definition
 .D EDIT(DA)
 .S:$D(DA) DONE=1
 Q
 ;
EDIT(DA) ;Edit Rule
 I '$$VEDIT^PXRMUTIL("^PXRM(810.2,",DA) D  Q
 .W !!,?5,"VA- and national class rules may not be edited" H 2
 .S VALMBCK="R"
 ;
 Q:'$$LOCK(DA)
 W IORESET
 N CS1,CS2,DIC,DIDEL,DIE,DR,DTOUT,DUOUT,ODA,Y
 ;Save checksum
 S CS1=$$FILE^PXRMEXCS(810.2,DA)
 ;
 S DIE="^PXRM(810.2,",DIDEL=810.2,ODA=DA,DR="[PXRM EXTRACT DEFINITION]"
 ;
 ;Edit extract definition then unlock
 D ^DIE,UNLOCK(ODA)
 ;Deleted ???
 I '$D(DA) S VALMBCK="Q" Q
 ;
 ;Update edit history
 D
 .S CS2=$$FILE^PXRMEXCS(810.2,DA) Q:CS2=CS1  Q:+CS2=0
 .D SEHIST^PXRMUTIL(810.2,DIC,DA)
 ;
 S VALMBCK="R"
 Q
 ;
EPEDIT ;Edit Rule
 D EDIT(IEN) Q:VALMBCK="Q"
 ;
 ;Rebuild Workfile
 D BLDLIST(IEN)
 Q
 ;
LOCK(DA) ;Lock the record
 L +^PXRM(810.2,DA):0 I  Q 1
 E  W !!,?5,"Another user is editing this file, try later" H 2 Q 0
 ;
SCREEN ;validate rule type
 Q
 ;
UNLOCK(DA) ;Unlock the record
 L -^PXRM(810.2,DA)
 Q
