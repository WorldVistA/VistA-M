TIUFD2 ; SLC/MAM - LM Template D (Display) Action Edit Basics ;02/16/06
 ;;1.0;TEXT INTEGRATION UTILITIES;**13,64,211**;Jun 20, 1997;Build 26
 ;
 ;*** INCLUDES JOEL'S MODS FOR VUID PATCH ***
 ;
EDBASICS ; Template D (Display) Action Edit Basics
 ; Requires TIUFTMPL.
 ; Requires TIUFWHO, set in Options TIUF/A/C/H EDIT/SORT/CREATE DDEFS CLIN/MGR/NATL
 ; Requires CURRENT array TIUFINFO, CURRENT variable TIUFVCN1
 ;as set in EDVIEW^TIUFHA, updated (if Template A has changed) 
 ;in AUPDATE^TIUFLA1, or (if Template H has changed) in UPDATE^TIUFLLM1.
 ;WARNING: +TIUFINFO may = 0 if Template A has changed!
 ; If TIUFWHO="C" (Clinician), only owner can edit.
 ; If TIUFTMPL = "A", requires TIUFATTR and TIUFAVAL as set in protocols
 ;TIUF SORT BY ... and subprotocols.
 ; Edit Basics for LM entries as entries in file 8925.1 (not as items
 ;for entries in 8925.1).
 N FILEDA,NAME,OPTFLDS,NEWFLAG,NODE0,STATUS,FIELDS,NEWSTAT,DTOUT,DIRUT
 N DIROUT,CNTCHNG,MSG
 N PFILEDA,DIR,X,Y,ALLFLDS,BYPASS,TIUFXNOD,TIUFFULL,TYPE,LINENO
 S FILEDA=TIUFINFO("FILEDA"),VALMBCK="" ;Redisplay each time.
 S NODE0=$G(^TIU(8925.1,FILEDA,0)),TIUFXNOD=$G(XQORNOD(0))
 I NODE0="" W !!," Entry not in File; See IRM",! D PAUSE^TIUFXHLX G EDBAX
 S NAME=$P(NODE0,U),STATUS=$P(NODE0,U,7),TYPE=$P(NODE0,U,4)
 S STATUS=$$STATWORD^TIUFLF5(STATUS) ;e.g. INACTIVE
 L +^TIU(8925.1,FILEDA):1 I '$T W !!," Another user is editing this entry.",! H 2 G EDBAX
 S PFILEDA=+$O(^TIU(8925.1,"AD",FILEDA,0))
 D  G:'$D(FIELDS)!$D(DTOUT) EDBAX
 . S ALLFLDS=";.01;.02;.03;"_$S(TYPE="DOC":"1501;",1:"")_".04;.05;.06;.07;.1;.13;3.02;3.03;"
 . I $P(NODE0,U,10),'$$PERSOWNS^TIUFLF2(FILEDA,DUZ) S FIELDS=";.05;.06;" W !!," Edit Owner only: only an Owner can edit a Shared Component.",! Q
 . ; Natl entry, nonnat user => protocol screens out all except titles;
 . ;edit status & abbrev only, quit:
 . I $P(NODE0,U,13),TIUFWHO'="N" S FIELDS=";.02;.07;" W !!," Edit Abbreviation and Status only: Entry is National Title." Q  ;P64 permit edit of abbr, stat for natl titles
 . I TYPE="O",'$$PERSOWNS^TIUFLF2(FILEDA,DUZ) S FIELDS=";.05;.06;" W !!," Edit Owner only: only an Owner can edit an Object.",! Q
 . I STATUS="NO/BAD",TYPE'="CO" S FIELDS=";.07;" W !!," Edit Status only: Entry has No Status/Bad Status",! Q
 . I STATUS'="INACTIVE",TIUFWHO="N" K DIRUT D  Q:$D(DIRUT)  I BYPASS=1 S FIELDS=ALLFLDS Q
 . . S DIR(0)="Y",DIR("A",1)=" Entry not Inactive.  You can edit 'safe' Basic fields only OR you can bypass" ;P64 too many safe fields to list them
 . . S DIR("A",2)="safety measures and edit ALL Basic fields even though this may cause errors"
 . . S DIR("A",3)="if, for example, a document is being entered using this entry." ;P64 language works for objects (as well as titles)
 . . S DIR("A")="Do you want to edit ALL Basic Fields"
 . . S DIR("B")="NO" D ^DIR S BYPASS=Y K DIR,X,Y
 . I STATUS="NO/BAD" D  Q
 . . S FIELDS=";.07;" W !!," Edit Status only; Entry has No Status/Bad Status" Q
 . I STATUS'="INACTIVE" D  Q
 . . I TYPE="CO" S FIELDS=";.05;.06;" W !!," Edit Owner only; Entry is not Inactive" Q
 . . S FIELDS=";.02;.05;.06;.07;" ;Abbrev, Pers&Cls Owner, Status
 . . S MSG=" Edit Abbreviation, Owner"
 . . I TYPE="O" S $E(MSG,6,19)="",$E(FIELDS,1,4)="" ;P64 add abbr to editable flds except if entry is object
 . . S MSG=MSG_$S(TIUFWHO'="N":" and Status",1:", Status, & OK to Distribute")_" only; Entry not Inactive"
 . . I TIUFWHO="N" S FIELDS=FIELDS_"3.02;"
 . . W !!,MSG
 . I $P(NODE0,U,10),'$$CANEDIT^TIUFLF6(FILEDA) S FIELDS=";.05;.06;" W !!," Edit Owner only: Shared Component with parent that isn't Inactive" Q
 . I TIUFWHO="C" S FIELDS=";.02;.03;"_$S(TYPE="DOC":"1501;",1:"")_";.05;.06;.07;" Q
 . I TYPE="O" S FIELDS=";.01;.02;.03;.05;.06;.07;3.02;" Q
 . S FIELDS=ALLFLDS
 D ASKFLDS^TIUFLF1(FILEDA,FIELDS,PFILEDA,.NEWSTAT) G:$D(DTOUT) EDBAX
 D NODE0ARR^TIUFLF(FILEDA,.TIUFNOD0) G:$D(DTOUT) EDBAX
 I TIUFTMPL="A"!(TIUFTMPL="J") D  ; Update line if 'REDO, no new status:
 . I NEWSTAT S TIUFREDO=1 ; One new status affects status globally.
 . ;Update line even if going to reinit, to get correct VALMCNT, and to get Not in Current View msg:
 . D AUPDATE^TIUFLA1(TIUFNOD0,FILEDA,.CNTCHNG) I CNTCHNG S TIUFVCN1=TIUFVCN1-1 ;doesn't match.
 ; Update entry itself in TIUFTMPL; entry will be reexpanded when leave EV:
 I "HC"[TIUFTMPL D LINEUP^TIUFLLM1(.TIUFINFO,TIUFTMPL)
 S LINENO=0 D DSBASICS^TIUFD(.LINENO) S VALMCNT=LINENO
 G:$D(DTOUT) EDBAX
 D HDR^TIUFD
 S VALMSG=$$VMSG^TIUFL D RE^VALM4 I $G(TIUFFULL) D RESET^TIUFXHLX
EDBAX ;
 L -^TIU(8925.1,+$G(FILEDA))
 I $D(DTOUT) S VALMBCK="Q"
 Q
 ;
