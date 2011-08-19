TIUFHA1 ; SLC/MAM - LM Templates H,A Actn Delete. CANTDEL(FILEDA,USED),ASKOK(OLDLNO,IFLAG,USED) ;1/19/06
 ;;1.0;TEXT INTEGRATION UTILITIES;**2,13,43,184**;Jun 20, 1997
 ;
 ;$$HASAS^USRLFF - IA 2329
 ;$$FNDTITLE^DGPFAPI1 - IA 4383
DELETE ; Templates H and A Action Delete Entries
 ; Requires TIUFTMPL.
 ; Requires TIUFWHO, set in Options TIUF/A/C/H EDIT/SORT/CREATE DDEFS CLIN/MGR/NATL.
 ; Not on Clinician menu: don't worry about TIUFWHO="C".
 N OLDLNO,TIUFDA,FILEDA,USED,IFLAG,PFILEDA,SHARED,ANCQUIT,MSG1
 N ASKOK,ITEMDA,LINENO,INFO,PINFO,MSG,TIUFXNOD,TIUI,ANCESTOR,NODE0,NATL
 N DTOUT,DIRUT,DIROUT
 S VALMBCK="",TIUFXNOD=$G(XQORNOD(0))
 D EN^VALM2(TIUFXNOD,"O")
 I '$O(VALMY(0)) G DELEX
 S OLDLNO=0
 F  S OLDLNO=$O(VALMY(OLDLNO)) Q:'OLDLNO  D
 . S TIUFDA(OLDLNO)=$P(^TMP("TIUF1IDX",$J,OLDLNO),U,2)
 . Q
 S OLDLNO=0 K DIRUT
 F  S OLDLNO=$O(TIUFDA(OLDLNO)) Q:'OLDLNO!$D(DIRUT)  D  L -^TIU(8925.1,+$G(FILEDA))
 . S MSG=" Processing Entry "_OLDLNO_"..." W !!,MSG
 . S FILEDA=TIUFDA(OLDLNO)
 . I $G(TIUFCDA) D  Q:$G(ANCQUIT)
 . . D ANCESTOR^TIUFLF4(TIUFCDA,^TIU(8925.1,TIUFCDA,0),.ANCESTOR) S ANCQUIT=0
 . . F TIUI=0:1 Q:'$G(ANCESTOR(TIUI))  I FILEDA=ANCESTOR(TIUI) D  Q
 . . . S ANCQUIT=1
 . . . I TIUI=0 S MSG=" This is your Current Position in the Hierarchy; Can't delete" W !!,MSG,! D PAUSE^TIUFXHLX Q
 . . . S MSG=" This entry is ABOVE your Current Position in the Hierarchy; Can't delete" W !!,MSG,! D PAUSE^TIUFXHLX
 . S NODE0=^TIU(8925.1,FILEDA,0),NATL=$P(NODE0,U,13),SHARED=$P(NODE0,U,10)
 . I SHARED S MSG=" Shared Components cannot be deleted; if they do not have multiple parents,",MSG1="they can be edited to NOT SHARED and then deleted" W !!,MSG,!,MSG1 D PAUSE^TIUFXHLX Q
 . I $P(^TIU(8925.1,FILEDA,0),U,13) S MSG=" National Entry; Can't delete" W MSG,! D PAUSE^TIUFXHLX Q
 . I $P(NODE0,U,4)="O" W !,"To delete an Object, please select action Detailed Display.",! D PAUSE^TIUFXHLX Q
 . I ($L($P(NODE0,U,5))!$L($P(NODE0,U,6))),'$$PERSOWNS^TIUFLF2(FILEDA,DUZ) S MSG=" Only an Owner can delete a file entry" W MSG,! D PAUSE^TIUFXHLX Q
 . L +^TIU(8925.1,FILEDA):1 I '$T W !!," Another user is editing this entry; Please try later" H 2 Q
 . S USED=$S($P(NODE0,U,4)="O":$$OBJUSED^TIUFLJ(FILEDA),1:$$DDEFUSED^TIUFLF(FILEDA))
 . Q:$$CANTDEL(FILEDA,USED)
 . S IFLAG=+$O(^TIU(8925.1,"AD",FILEDA,0))
 . I TIUFTMPL="A",IFLAG D  D PAUSE^TIUFXHLX Q:$D(DIRUT)
 . . H 1 W !!,"  Entry "_OLDLNO_" has Parent:"
 . . S PFILEDA=0 F  D  Q:'PFILEDA
 . . . S PFILEDA=$O(^TIU(8925.1,"AD",FILEDA,PFILEDA)) Q:'PFILEDA
 . . . W !?5,$P(^TIU(8925.1,PFILEDA,0),U)
 . H 1 S ASKOK=$$ASKOK(OLDLNO,IFLAG,USED) I 'ASKOK  S MSG=" ... Entry "_OLDLNO_" not deleted!" W MSG,! D PAUSE^TIUFXHLX Q
 . I 'IFLAG G DELENTY
 . ; If FILEDA is used as an item, delete it as an item:
 . N DA,DIK
 . S PFILEDA=$O(^TIU(8925.1,"AD",FILEDA,0)) Q:'PFILEDA
 . S ITEMDA=$O(^TIU(8925.1,"AD",FILEDA,PFILEDA,0)) Q:'ITEMDA
 . I TIUFTMPL="A",$E(TIUFATTR)="P" S TIUFREDO=1
 . S DA(1)=PFILEDA,DA=ITEMDA,DIK="^TIU(8925.1,DA(1),10," D ^DIK
DELENTY . ; Delete FILEDA as Docmt Def entry in file 8925.1:
 . N DA,DIK
 . I TIUFTMPL="A",$E(TIUFATTR)="P" S TIUFREDO=1 ;Delete affects parentage globally.
 . S DA=FILEDA,DIK="^TIU(8925.1," D ^DIK
 . S LINENO=$O(^TMP("TIUF1IDX",$J,"DAF",FILEDA,0))
 . G:'LINENO MSG ; not there since parent was already deleted
 . I "AJ"[TIUFTMPL D  G MSG
 . . I '$G(TIUFREDO) D UPDATE^TIUFLLM1(TIUFTMPL,-1,LINENO-1) S VALMCNT=VALMCNT-1
 . ; Update LM Template H: collapse and then delete FILEDA's LINENO.
 . S INFO=^TMP("TIUF1IDX",$J,LINENO) D PARSE^TIUFLLM(.INFO)
 . I INFO("XPDLCNT") S VALMCNT=VALMCNT-INFO("XPDLCNT") D COLLAPSE^TIUFH1(.INFO)
 . S PINFO=^TMP("TIUF1IDX",$J,INFO("PLINENO")) D PARSE^TIUFLLM(.PINFO)
 . D UPDATE^TIUFLLM1("H",-1,LINENO-1,.PINFO) S VALMCNT=VALMCNT-1
MSG . S MSG=" ... Entry "_OLDLNO_" Deleted!" W MSG,! H 1 S VALMBCK="R"
 . Q
 I TIUFTMPL="C" K TIUFCMSG D
 . S TIUFCMSG(1)=" Select "_$S(TIUFCTYP="DC":"TITLE",1:"CLASS/DOCUMENTCLASS")_" to create a new "_TIUFCNM
 . S TIUFCMSG(2)="or to Go Down a Level, Select NEXT LEVEL."
 . I VALMCNT>VALM("LINES") S TIUFCMSG(2)="or to Go Down a Level, Screen to (+/-) Desired ",TIUFCMSG(3)=TIUFCNM_" Item, and Select NEXT LEVEL."
DELEX I $D(DTOUT) S VALMBCK="Q" Q
 I "AJ"[TIUFTMPL,VALMBCK="R",TIUFREDO D INIT^TIUFA S:$D(DTOUT) VALMBCK="Q"
 Q
 ;
ASKOK(OLDLNO,IFLAG,USED) ; Function warns user, asks if OK to continue delete. 1/OK; 0/not OK
 N DIR,X,Y,ANS
 S ANS=0
 I USED=0 S DIR("A")="Object has not been embedded in Boilerplate Text.  Delete" G ASKOX
 S DIR("A",1)="Entry "_OLDLNO_" is not presently used by any documents.  If entry is deleted,"
 I IFLAG S DIR("A",2)="any items UNDER it will be Orphans.  I will delete entry as an item under its",DIR("A")="parent AND as a Document Definition.  It will no longer exist. OK"
 E  S DIR("A",2)="any items UNDER it will be Orphans.  I will delete entry as a Document",DIR("A")="Definition.  It will no longer exist. OK"
ASKOX S DIR(0)="Y",DIR("B")="NO" D ^DIR S ANS=Y W !
 Q ANS
 ;
CANTDEL(FILEDA,USED) ; Function returns 1 if FILEDA can't be deleted, else 0.
 N ANS,MSG
 S ANS=0
 I USED="YES" S MSG="Entry In Use by documents; Can't delete" W MSG,! S ANS=1 G CANTX
 I USED S MSG="Object embedded in boilerplate text; Can't delete" W !,MSG,! S ANS=1 G CANTX
 I $$HASAS^USRLFF(FILEDA) S MSG=" Entry has Authorizations/Subscriptions; Can't delete." W !!,MSG,! S ANS=1 G CANTX ;**43**
 I $$FNDTITLE^DGPFAPI1(FILEDA)>0 S MSG="Entry Associated with PRF Flag; Can't delete" W MSG,! S ANS=1 G CANTX
 I '$D(^TIU(8925.1,"AS",+^TMP("TIUF",$J,"STATI"),FILEDA)),$P(^TIU(8925.1,FILEDA,0),U,7) D  G CANTX
 . S MSG=" Status not INACTIVE; Can't delete" W MSG,! S ANS=1
CANTX ;
 I $D(MSG) D PAUSE^TIUFXHLX
 Q ANS
 ;
