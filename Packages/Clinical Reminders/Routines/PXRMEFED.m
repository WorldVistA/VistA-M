PXRMEFED ; SLC/PJH - Extract Counting Editor ;05/10/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;Main entry point for PXRM COUNTING RULE EDIT/DISPLAY
START(IEN) ;
 N PXRMDONE,VALMBCK,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 S X="IORESET"
 D ENDR^%ZISS
 S VALMCNT=0
 D EN^VALM("PXRM EXTRACT COUNT RULE EDIT")
 Q
 ;
BLDLIST(IEN) ;Build workfile
 N FLDS,GBL,PXRMROOT
 S FLDS="[PXRM EXTRACT COUNTING]"
 S GBL="^TMP(""PXRMEFED"",$J)"
 S GBL=$NA(@GBL)
 S PXRMROOT="^PXRM(810.7,"
 K ^TMP("PXRMEFED",$J)
 D DIP^PXRMUTIL(GBL,IEN,PXRMROOT,FLDS)
 S VALMCNT=$O(^TMP("PXRMEFED",$J,""),-1)
 Q
 ;
ENTRY ;Entry code
 D BLDLIST(IEN)
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMEFED",$J)
 K ^TMP("PXRMEFEDH",$J)
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
 S SUB="PXRMEFEDH"
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
 S HED="ADD EXTRACT COUNTING RULE",DONE=0
 W IORESET,!
 F  D  Q:$D(DTOUT)  Q:DONE
 .S DIC="^PXRM(810.7,"
 .;Set the starting place for additions.
 .D SETSTART^PXRMCOPY(DIC)
 .S DIC(0)="AELMQ",DLAYGO=810.7
 .S DIC("A")="Select EXTRACT COUNTING RULE to add: "
 .D ^DIC
 .I $D(DUOUT) S DTOUT=1
 .I ($D(DTOUT))!($D(DUOUT)) Q
 .I Y=-1 K DIC S DTOUT=1 Q
 .I $P(Y,U,3)'=1 W !,"This extract counting rule already exists" Q
 .S DA=$P(Y,U,1)
 .;Edit Extract Counting Rule
 .D EDIT(DA)
 .S:$D(DA) DONE=1
 Q
 ;
EDIT(DA) ;Edit Rule
 I '$$VEDIT^PXRMUTIL("^PXRM(810.7,",DA) D  Q
 .W !!,?5,"VA- and national class rules may not be edited" H 2
 .S VALMBCK="R"
 ;
 Q:'$$LOCK(DA)
 W IORESET
 N CS1,CS2,DIC,DIDEL,DIE,DR,DTOUT,DUOUT,ODA,Y
 ;Save checksum
 S CS1=$$FILE^PXRMEXCS(810.7,DA)
 ;
 S DIE="^PXRM(810.7,",DIDEL=810.7,ODA=DA,DR="[PXRM EXTRACT COUNTING]"
 ;
 ;Edit extract counting rule then unlock
 D ^DIE,UNLOCK(ODA)
 ;Deleted ???
 I '$D(DA) S VALMBCK="Q" Q
 ;
 ;Update edit history
 D
 .S CS2=$$FILE^PXRMEXCS(810.7,DA) Q:CS2=CS1  Q:+CS2=0
 .D SEHIST^PXRMUTIL(810.7,DIC,DA)
 ;
 S VALMBCK="R"
 Q
 ;
EFEDIT ;Edit Rule
 D EDIT(IEN) Q:VALMBCK="Q"
 ;
 ;Rebuild Workfile
 D BLDLIST(IEN)
 Q
 ;
EFGRP ;Counting Groups
 D START^PXRMEGM(IEN)
 ;
 ;Rebiuld Workfile
 D BLDLIST(IEN)
 ;
 S VALMBCK="R"
 Q
 ;
LOCK(DA) ;Lock the record
 L +^PXRM(810.7,DA):2 I  Q 1
 E  W !!,?5,"Another user is editing this file, try later" H 2 Q 0
 ;
SCREEN ;validate rule type
 Q
 ;
UNLOCK(DA) ;Unlock the record
 L -^PXRM(810.7,DA)
 Q
