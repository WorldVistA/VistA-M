TIUFL ; SLC/MAM - Library of Modules and Functions: SETUP, RMSG, CENTER(X,N) ;02/16/06
 ;;1.0;TEXT INTEGRATION UTILITIES;**14,184,211**;Jun 20, 1997;Build 26
 ;
CENTER(X,N) ; Center X in space of N Characters. Adapted from TIULS.
 ; Truncates X to N chars if X>N.  NOTE: LM truncates header at scroll lock if header longer than VALMWD-1.
 N SP,ANSCTR
 S $P(SP," ",((N-$L(X))\2)+1)=""
 S ANSCTR=$G(SP)_X_$G(SP) I $L(ANSCTR)>N S ANSCTR=$E(ANSCTR,1,N)
 Q ANSCTR
 ;
SETUP ; Sets ^TMP("TIUF",$J) array before entering Document Definition Utility, etc.
 ; Array is used in routines and in protocols, including protocol
 ;item text and item displayed name.  If Type field Set of Codes changes,
 ;or allowable Statuses from TIU Status File, then ^TMP("TIUF" array and
 ;associated protocols will need changing.
 ; TIUF uses protocols TIUF TYPE etc. and TIUF STATUS etc. so that Type,
 ;Status, and Sort values can be edited at the bottom of the LM screen
 ;without allowed choices scrolling off.
 N DIC,X,Y,TIUFI,DA
 S TIUFPRIV=1
 S X="IOELALL" D ENDR^%ZISS
ARRNO ; ^TMP("TIUF",$J) subscripts ARRNO_H/A/C/J/T/D/O.
 ; e.g. ^TMP("TIUF",$J,"ARRNOH")= 1 since LM Template H uses Array
 ;number 1, i.e. ^TMP("TIUF1" Arrays.
 F TIUFI="H","A","C","J","T","D","O" S ^TMP("TIUF",$J,"ARRNO"_TIUFI)=$S("HACJ"[TIUFI:1,TIUFI="T":2,1:3) ; D, O are 3
 ;
CLINDOC ; subscript "CLINDOC".
 ; e.g. ^TMP("TIUF",$J,"CLINDOC")=38
 S DIC=8925.1,DIC(0)="X",X="CLINICAL DOCUMENTS" D ^DIC
 G:Y=-1 SETUX
 S ^TMP("TIUF",$J,"CLINDOC")=+Y
CLPAC ; Subscript "CLPAC"  NOTE: may not find it so subscript may not exist
 S DIC=8930,DIC(0)="X"
 S X="CLINICAL COORDINATOR" D ^DIC
 I Y>0 S ^TMP("TIUF",$J,"CLPAC")=+Y
RM ; Subscripts "RMAC", "RMAM", "RMHC", "RMHM",
 ;"RMCM", "RMJC", "RMJM", "RMT", "RMD" similar to VALM("RM"),
 ;LM Template Right Margin for Sub/Templates A, H, C, and J, T, D; 
 ;for TIUFWHO Clinician, Manager.
 S TIUF("RMAC")=186
 S TIUF("RMAM")=195
 S TIUF("RMHC")=179
 S TIUF("RMHM")=188
 S TIUF("RMCM")=188
 S TIUF("RMJC")=157
 S TIUF("RMJM")=166
 S TIUF("RMT")=123
 S (TIUF("RMD"),TIUF("RMXM"),TIUF("RMXC"))=80
NMWIDTH ; Subscript NMWIDTH for entry name in Temps HACJ.
 S ^TMP("TIUF",$J,"NMWIDTH")=$S("NM"[TIUFWHO:65,1:72) ; Used in Create options.
 ;
HIDDEN ; Subscript HIDDEN for IFN of protocol TIUF HIDDEN ACTIONS
 S DIC=101
 S X="TIUF HIDDEN ACTIONS" D ^DIC G:Y=-1 SETUX
 S ^TMP("TIUF",$J,"HIDDEN")=+Y
 ;
STOP ; Subscript STOP for IFN of protocol TIUF QUIT1
 S DIC=101
 S X="TIUF QUIT1" D ^DIC G:Y=-1 SETUX
 S ^TMP("TIUF",$J,"STOP")=+Y
 ;
NEWHELP ; Subscript NEWHELP for IFN of protocol TIUFC ACTION MENU
 S DIC=101
 S X="TIUFC ACTION MENU" D ^DIC G:Y=-1 SETUX
 S ^TMP("TIUF",$J,"NEWHELP")=+Y
 ;
INHERIT ; Subscript INHERIT for IFN of protocol TIUFD ACTION MENU MGR
 S DIC=101
 S X="TIUFD ACTION MENU MGR" D ^DIC G:Y=-1 SETUX
 S ^TMP("TIUF",$J,"INHERIT")=+Y
 ;
RIGHT ; Subscript RIGHT for IFN of protocol TIUF RIGHT.
 S DIC=101
 S X="TIUF RIGHT" D ^DIC G:Y=-1 SETUX
 S ^TMP("TIUF",$J,"RIGHT")=+Y
 ;
LEFT ; Subscript LEFT for IFN of protocol TIUF LEFT.
 S DIC=101
 S X="TIUF LEFT" D ^DIC G:Y=-1 SETUX
 S ^TMP("TIUF",$J,"LEFT")=+Y
 ;
CREATE ; Subscript CREATE for IFN of protocol TIUFC ACTION MENU.
 S DIC=101
 S X="TIUFC ACTION MENU" D ^DIC G:Y=-1 SETUX
 S ^TMP("TIUF",$J,"CREATE")=+Y
 ;
TYPE ; Subscripts TYPECL, TYPEDC, TYPETL, etc.
 S ^TMP("TIUF",$J,"TYPECL")="CLASS"
 S ^TMP("TIUF",$J,"TYPEDC")="DOCUMENT CLASS"
 S ^TMP("TIUF",$J,"TYPETL")="TITLE"
 S ^TMP("TIUF",$J,"TYPECO")="COMPONENT"
 S ^TMP("TIUF",$J,"TYPEO")="OBJECT"
 S ^TMP("TIUF",$J,"TYPENONE")="NONE"
 ;
STAT ; subscripts "STATI" (I for Inactive), "STATT" (T for Test),
 ;"STATA" (A for Active), "PCLSTAT", "STAT#"
 ; e.g. ^TMP("TIUF",$J,"STATI")=13^INACTIVE where
 ;   13 = TIU Status File IFN for INACTIVE.
 ; e.g. ^TMP("TIUF",$J,"STAT13")="INACTIVE" where
 ;   13 = IFN of INACTIVE in TIU Status File.
 ;
 S DIC=8925.6,DIC(0)="X"
 F TIUFI="INACTIVE","TEST","ACTIVE" D  G:Y=-1 SETUX
 . S X=TIUFI D ^DIC Q:Y=-1
 . S ^TMP("TIUF",$J,"STAT"_$E(TIUFI))=+Y_U_TIUFI,^TMP("TIUF",$J,"STAT"_+Y)=TIUFI
 . Q
SORT ; subscripts "SORT", "SORTCM" (CM for CHANGE SORT MENU),
 ; e.g. ^TMP("TIUF",$J,"SORT")=3766, =IFN of protocol TIUF SORT
 ; e.g. ^TMP("TIUF",$J,"SORTCM")=3819, =IFN of protocol TIUF CHANGE SORT MENU
 ; e.g. ^TMP("TIUF",$J,"SORTT")=3635, =IFN of protocol TIUF SORT BY TYPE
 K DIC,DA S DIC=101,DIC(0)="X",X="TIUF SORT" D ^DIC G:Y=-1 SETUX
 S ^TMP("TIUF",$J,"SORT")=+Y
 S X="TIUF CHANGE SORT MENU" D ^DIC G:Y=-1 SETUX
 S ^TMP("TIUF",$J,"SORTCM")=+Y
 F TIUFI="T^TYPE","O^OWNER","S^STATUS","U^USED BY DOCMTS","P^PARENTAGE" D  G:Y=-1 SETUX
 . S X="TIUF SORT BY "_$P(TIUFI,U,2) D ^DIC I Y=-1 Q
 . S ^TMP("TIUF",$J,"SORT"_$P(TIUFI,U))=+Y
MSG S ^TMP("TIUF",$J,"SMSG")="?Help   >ScrollRight   PS/PL PrintScrn/List   +/-"
 S ^TMP("TIUF",$J,"MSG")="? Help       +, - Next, Previous Screen     PS/PL"
 S ^TMP("TIUF",$J,"NMSG")="New Users, Please Enter '?NEW' for Help"
FLDNAM ; Single Subscripts are Field Numbers: e.g. ^TMP("TIUF",$J,4,"LABEL")="Upload Look-Up Method".
 ;See also FLDTYPE for second piece.
 S ^TMP("TIUF",$J,0,"LABEL")="IFN^BASICS"
 S ^TMP("TIUF",$J,1.03,"LABEL")="TARGET TEXT FIELD"
 F TIUFI=.01:.01:.15,1.01,1.02,2,3,3.02,3.03,4,4.1,4.2,4.3,4.4,4.45,4.5,4.6,4.7,4.8,4.9,5,6,6.1,6.12,6.13,6.14,7,8,9,10,1501 D FIELD^DID(8925.1,TIUFI,"","LABEL","^TMP(""TIUF"",$J,TIUFI)")
 ;S ^TMP("TIUF",$J,.05,"LABEL")="OWNER^BASICS"
 ; Double Subscripts are Field Numbers of Multiples,SubField Numbers: e.g
 ;^TMP("TIUF",$J,1,.01,"LABEL")="Header Piece", the .01 subfield of Multiple field 1:
 F TIUFI=.01:.01:.07,1 D FIELD^DID(8925.11,TIUFI,"","LABEL","^TMP(""TIUF"",$J,1,TIUFI)"),FIELD^DID(8925.12,TIUFI,"","LABEL","^TMP(""TIUF"",$J,2,TIUFI)")
 F TIUFI=2,3,4 D FIELD^DID(8925.14,TIUFI,"","LABEL","^TMP(""TIUF"",$J,10,TIUFI)")
 ;
FLDTYPE ; Sets ^ piece after FLDNAME = BASICS, TECH, UPLOAD or UPHEAD, i.e. which part of the display the field is in.
 F TIUFI=.01:.01:.15,3.02,3.03,1501 S $P(^TMP("TIUF",$J,TIUFI,"LABEL"),U,2)="BASICS"
 F TIUFI=4.1,4.2,4.3,4.4,4.45,4.6,4.7,4.9,5,6,6.1,6.12,6.13,6.14,7,8,9 S $P(^TMP("TIUF",$J,TIUFI,"LABEL"),U,2)="TECH"
 F TIUFI=1.01:.01:1.03,4,4.5,4.8 S $P(^TMP("TIUF",$J,TIUFI,"LABEL"),U,2)="UPLOAD"
 F TIUFI=.01:.01:.07,1,2 S $P(^TMP("TIUF",$J,1,TIUFI,"LABEL"),U,2)="UPHEAD",$P(^TMP("TIUF",$J,2,TIUFI,"LABEL"),U,2)="UPHEAD"
SETUX I $G(Y)=-1 W !!," Missing Basic Variables; See IRM.",! D PAUSE^TIUFXHLX S VALMQUIT=1
 Q
 ;
RMSG ; redisplays standard TIUF msg.  Sets VALMSG=stnd msg.  Called by items of LM Protocol Menus, items of TIUF HIDDEN ACTIONS.
 ; Requires TIUFSTMP if currently in subtemplate;
 ; Requires TIUF messages as set in TIUFL.
 N MSG
 S VALMSG=$$VMSG
 D MSG^VALM10(MSG)
 Q
 ;
VMSG() ; Function returns standard VALMSG for a Template.
 N VMSG
 I $G(TIUFCBEG) S VMSG=^TMP("TIUF",$J,"NMSG") G VMSG1
 I "HACJ"[TIUFTMPL,'$D(TIUFSTMP) D  G VMSG1
 . I $P($G(XQORNOD),";")=^TMP("TIUF",$J,"RIGHT") S VMSG=^TMP("TIUF",$J,"MSG") Q
 . I $P($G(XQORNOD),";")=^TMP("TIUF",$J,"LEFT") S VMSG=^TMP("TIUF",$J,"SMSG") Q
 . I $G(VALMLFT)<80 S VMSG=^TMP("TIUF",$J,"SMSG") Q
 . S VMSG=^TMP("TIUF",$J,"MSG")
 I $G(TIUFSTMP)="T" D  G VMSG1
 . I $P($G(XQORNOD),";")=^TMP("TIUF",$J,"RIGHT") S VMSG=^TMP("TIUF",$J,"MSG") Q
 . I $P($G(XQORNOD),";")=^TMP("TIUF",$J,"LEFT") S VMSG=^TMP("TIUF",$J,"SMSG") Q
 . I $G(VALMLFT)<80 S VMSG=^TMP("TIUF",$J,"SMSG") Q
 . S VMSG=^TMP("TIUF",$J,"MSG")
 I $G(TIUFSTMP)="D"!($G(TIUFSTMP)="X") S VMSG=^TMP("TIUF",$J,"MSG")
VMSG1 Q VMSG
 ;
