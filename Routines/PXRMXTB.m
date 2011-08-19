PXRMXTB ; SLC/PJH - Reminder Reports Template Load ;07/30/2009
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ; 
 ; Called from PXRMXD
 ;
 ;Select Template
 ;---------------
START N X,Y,CNT,FOUND,PXRMFLD,DIC,MSG
 N ERR,SEQ,TMPLST,LIST
 K DIROUT,DIRUT,DTOUT,DUOUT
 S PXRMTMP="",FOUND=0
 ;
 ;Check if any templates exist for the user
 D GETLST^XPAR(.TMPLST,"USR","PXRM REPORT TEMPLATE (USER)","Q",.ERR)
 I ERR>0 W !!,?5,"Error: "_$P(ERR,U,2) S DUOUT=1 H 2 Q
 I 'TMPLST W !!,?5,"No report Templates for this user" S DUOUT=1 H 2 Q
 ;Build list of templates
 S SEQ=0
 F  S SEQ=$O(TMPLST(SEQ)) Q:'SEQ  D
 .S Y=$P(TMPLST(SEQ),U,2) Q:'Y
 .S LIST(Y)=""
 ;
 ;Select template required
 W !
 S CNT=0,DIC=810.1,DIC(0)="AEQMZ"
 S DIC("A")="Select REPORT TEMPLATE:"
 S DIC("S")="I $D(LIST(+Y)),$P(^PXRMPT(810.1,+Y,0),U,3)=PXRMTYP"
 D ^DIC
 W !!,"1"
 I X="" S DUOUT=1
 I X=(U_U) S DTOUT=1
 I '$D(DTOUT),('$D(DUOUT)) D
 .I +Y'=-1 D  Q
 ..S CNT=CNT+1,ARRAY(CNT)=Y_U_Y(0,0)_U_$P(Y(0),U,3)
 K DIC
 ;
 ;Load template into local array
 I (+Y'=-1)&('$D(DTOUT))&('$D(DUOUT)) D
 .L +^PXRMPT(810.1,$P(Y,U)):0
 .E  W !!?5,"Another user is editing this entry." S DUOUT=1 Q
 .;Load template into an array
 .S PXRMTMP=Y_U_$P(Y(0),U,2) D LOAD^PXRMXT
 .L -^PXRMPT(810.1,$P(PXRMTMP,U))
 .;Exit if problem loading template
 .I $D(MSG) S DTOUT=1 Q
 .;Display Template information
 .D:'$D(MSG) ^PXRMXTD
EXIT Q
 ;
XREF ;       
 K MREF,XREF
 S XREF("NAME")=.01
 S XREF("TITLE")=1.9
 S XREF("PXRMTYP")=1.1
 S XREF("PXRMSEL")=1.2
 S XREF("PXRMPRIM")=1.3
 S XREF("PXRMREP")=1.4
 S XREF("PXRMLCSC")=1.5
 S XREF("PXRMFD")=1.6
 S XREF("PXRMPML")=1.7
 S XREF("PXRMPER")=1.8
 S XREF("PXRMREM")=2
 S XREF("PXRMFAC")=3
 S XREF("PXRMPRV")=4
 S XREF("RUN")=5
 S XREF("PXRMPAT")=6
 S XREF("PXRMOTM")=7
 S XREF("PXRMPCM")=8
 S XREF("PXRMSCAT")=9
 S XREF("PXRMLCHL")=10
 S XREF("PXRMCS")=11
 S XREF("PXRMCGRP")=12
 S XREF("PXRMRCAT")=13
 S XREF("PXRMLIST")=14
 S XREF("PXRMOWN")=15
 ;
 S MREF("REMINDER")=.01
 S MREF("PATIENT")=.01
 S MREF("PROVIDER")=.01
 S MREF("OERR TEAM")=.01
 S MREF("PCMM TEAM")=.01
 S MREF("FACILITY")=.01
 S MREF("SERVICE")=.01
 S MREF("LOCATION")=.01
 S MREF("STOP CODE")=.01
 S MREF("CLINIC GROUP")=.01
 S MREF("DISPLAY ORDER")=.02
 S MREF("REMINDER CATEGORY")=.01
 S MREF("DISPLAY")=.02
 S MREF("PXRMLIST")=.01
 Q
