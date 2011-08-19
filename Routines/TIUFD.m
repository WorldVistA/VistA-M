TIUFD ; SLC/MAM - LM Screen D (Display) INIT, DS/BASICS,ITEMS,PARNT,BOILTX,TECH(LASTLIN) ;02/16/06
 ;;1.0;TEXT INTEGRATION UTILITIES;**14,184,211**;Jun 20, 1997;Build 26
 ;
HDR ; -- header code
 S VALMHDR(1)=$$FHDR
HDRX ;
 Q
 ;
FHDR() ; Function returns Type_Name for headers; Requires Array TIUFNOD0.
 N NAME,TYPE
 S NAME=$P(TIUFNOD0,U)
 S TYPE=$$MIXED^TIULS(TIUFNOD0("TYPE"))
 I TYPE'="" S TYPE=TYPE_" "
 Q $$CENTER^TIUFL(TYPE_NAME,79)
 ;
INIT ; -- init variables and list array
 N TEMPLATE
 K ^TMP("TIUF3",$J),^TMP("TIUF3IDX",$J)
 D CLEAN^VALM10
 S VALMCNT=0 D DSBASICS(.VALMCNT)
INITX I $D(DTOUT) S VALMQUIT=1
 Q
 ;
DSBASICS(LASTLIN) ; Set/Update Display Array TIUF3 starting with Basics.
 ; Requires LASTLIN = Last array line set, if setting array; = Last
 ;line to keep before resetting the rest if resetting array.
 ; Updates LASTLIN to Last array line set by this module.
 ; Requires CURRENT arrays TIUFINFO, TIUFNOD0.
 ;WARNING: +TIUFINFO may = 0!
 ; Any blanklines are set at the beginning, not the end, of the module.
 N LINENO,CNT,TIUI,FILEDA,LP,LC,OWNER,DA,DR,TYPE,DIC,DIQ,FLDNO
 S LINENO=LASTLIN
 ;If called to redisplay edited screen rather than by Init, kill array starting with Basics before resetting array.
 S CNT=$O(^TMP("TIUF3",$J,1000000),-1)
 F TIUI=LASTLIN+1:1:CNT K ^TMP("TIUF3",$J,TIUI),^TMP("TIUF3IDX",$J,TIUI)
 S FILEDA=TIUFINFO("FILEDA"),TYPE=$P(TIUFNOD0,U,4)
 S LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)="  Basics"_$S(TYPE'="O":"            Note: Values preceded by * have been inherited",1:"")
 K TIUFQ
 S DIC=8925.1,DR=".01:.15;3.02;3.03;1501",DIQ(0)="I,E",DA=FILEDA,DIQ="TIUFQ" D EN^DIQ1 ;P184
 F FLDNO=.01,1501,.02,.03,.04,.1,0,.13,.07,.05,.11,.08,.15,3.02,3.03 D
 . I FLDNO=0,"NM"'[TIUFWHO Q  ;Sets IFN line.
 . I FLDNO=.1,TYPE'="CO" Q
 . I FLDNO=.11,TIUFTMPL'="A"!(TYPE="O") Q
 . I FLDNO=3.03,TYPE="CO"!(TYPE="O")!(TIUFWHO="C") Q
 . I FLDNO=3.02,"N"'[TIUFWHO Q  ; For now, include OK to Distribute only on Natl options.  MAM
 . D SETFLD^TIUFLD(FILEDA,.LINENO,FLDNO)
 . Q
 K TIUFQ
DSBAX S LASTLIN=LINENO Q:$D(DTOUT)  D DSPARNT(.LASTLIN)
 Q
 ;
DSPARNT(LASTLIN) ; Set/Update Display Array TIUF3 starting with Parents.
 ; See DSBASICS for required variables, etc.
 N LINENO,CNT,TIUI,FILEDA,TIUREC,INFO,NODE0,TYPE,OLDLNO,PARENT
 S (TIUFPLIN,LINENO)=LASTLIN,FILEDA=TIUFINFO("FILEDA"),TYPE=$P(TIUFNOD0,U,4)
 I TYPE="O" G DSPAX
 ; Don't display parents if Template H or C, unless SHARED CO OR (mistakenly) Multiple Parents:
 I "HC"[TIUFTMPL,'((TYPE="CO")&$P(TIUFNOD0,U,10)) S PARENT=+$O(^TIU(8925.1,"AD",FILEDA,0)) I '$O(^TIU(8925.1,"AD",FILEDA,PARENT)) G DSPAX
 ;If called to redisplay edited screen rather than by Init, kill array starting with Parents before resetting array.
 S CNT=$O(^TMP("TIUF3",$J,1000000),-1)
 F TIUI=LASTLIN+1:1:CNT K ^TMP("TIUF3",$J,TIUI),^TMP("TIUF3IDX",$J,TIUI)
 S FILEDA=TIUFINFO("FILEDA")
 S LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)=""
 S LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)="  Parent"_$S(TIUFNOD0("SHARE")="":"",1:"s")_$S($O(^TIU(8925.1,"AD",FILEDA,0)):"                                   Type      IFN  Natl  Status  Owner",1:"")
 I '$O(^TIU(8925.1,"AD",FILEDA,0)) S LASTLIN=LINENO G DSPAX
 S TIUI=0,OLDLNO=LINENO
 F  S TIUI=$O(^TIU(8925.1,"AD",FILEDA,TIUI)) Q:'TIUI  D  G:$D(DTOUT) DSPAX
 . S LINENO=LINENO+1 D NINFO^TIUFLLM(LINENO,TIUI,.INFO),PARSE^TIUFLLM(.INFO),NODE0ARR^TIUFLF(TIUI,.NODE0) Q:$D(DTOUT)
 . I NODE0="" W !!," Entry "_FILEDA_" has parent missing from the file.",! S LINENO=LINENO-1 D PAUSE^TIUFXHLX Q
 . D BUFENTRY^TIUFLLM2(.INFO,.NODE0,"80")
 . Q
 D UPDATE^TIUFLLM1("D",LINENO-OLDLNO,OLDLNO)
DSPAX S LASTLIN=LINENO Q:$D(DTOUT)  D DSITEMS(.LASTLIN)
 Q
 ;
DSITEMS(LASTLIN) ; Set/Update Display Array TIUF3 starting with Items.
 ; See DSBASICS for required variables, etc.
 ; Called by subtemplates D AND T
 N LINENO,CNT,TIUI,FILEDA,TIUREC,ITEMS,OLDLNO,HASITEMS
 S (TIUFILIN,LINENO)=LASTLIN
 G:TIUFNOD0("ITEMS")="" DSITX ; Items is NA
 ;If called to redisplay edited screen rather than by Init, kill array starting with Items before resetting array.
 S CNT=$O(^TMP("TIUF3",$J,1000000),-1)
 F TIUI=LASTLIN+1:1:CNT K ^TMP("TIUF3",$J,TIUI),^TMP("TIUF3IDX",$J,TIUI)
 S FILEDA=TIUFINFO("FILEDA")
 S LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)=""
 ; HASITEMS may have changed if edited items:
 S ITEMS="  Items",HASITEMS=$$HASITEMS^TIUFLF1(FILEDA) I HASITEMS S ITEMS=ITEMS_" (By Sequence if they have it, otherwise alphabetically by Menu Text)"
 S LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)=ITEMS
 I 'HASITEMS G DSITX
 S TIUREC=$$SETSTR^VALM1("Item","",2,37)
 S:"NM"[TIUFWHO TIUREC=$$SETSTR^VALM1("    IFN",TIUREC,32,7)
 S TIUREC=$$SETSTR^VALM1("Seq   ",TIUREC,41,6),TIUREC=$$SETSTR^VALM1("Mnem",TIUREC,49,4),TIUREC=$$SETSTR^VALM1("Menu Text",TIUREC,55,26)
 S LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)=TIUREC,OLDLNO=LINENO
 ; Checked for items existing before entered EDIT/View.  So items exist:
 D BUFITEMS^TIUFLT("D",.TIUFINFO,.LINENO) G:$D(DTOUT) DSITX
 D UPDATE^TIUFLLM1("D",LINENO-OLDLNO,OLDLNO)
DSITX S LASTLIN=LINENO Q:$D(DTOUT)  D DSBOILTX(.LASTLIN)
 Q
 ;
DSBOILTX(LASTLIN) ; Set Display Array TIUF3 starting with Boilerplte Text.
 ; Used by subtemplates D and X AND T
 ; See DSBASICS for required variables, etc.
 N LINENO,CNT,TIUI,FILEDA,NAME
 S (TIUFBLIN,LINENO)=LASTLIN
 G:TIUFNOD0("BOILPT")="" DSBOX ; NA
 ;If called to redisplay edited screen rather than by Init, kill array starting with Boilpt Txt before resetting array.
 S CNT=$O(^TMP("TIUF3",$J,1000000),-1)
 F TIUI=LASTLIN+1:1:CNT K ^TMP("TIUF3",$J,TIUI),^TMP("TIUF3IDX",$J,TIUI)
 S FILEDA=TIUFINFO("FILEDA")
 I TIUFSTMP'="X" S LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)="",LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)="  Boilerplate Text"
 I TIUFNOD0("TYPE")="COMPONENT" S NAME=$P(TIUFNOD0,U),LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)=NAME_":"
 D SETBOIL^TIUFLD1(FILEDA,.LINENO)
 D DSETBOIL^TIUFLD1(FILEDA,.LINENO)
DSBOX S LASTLIN=LINENO Q:$D(DTOUT)  D:TIUFSTMP'="X" DSTECH(.LASTLIN)
 Q
 ;
DSTECH(LASTLIN) ; Set/Update Display Array TIUF3 starting with Technical Flds.
 ; See DSBASICS for required variables, etc.
 ; Called by subtemp D and T
 N LINENO,CNT,TIUI,FILEDA,FLDNO,PFILEDA,PNODE61,PCUSTOM,TYPE
 N DIC,DR,DIQ,DA
 S (TIUFTLIN,LINENO)=LASTLIN
 I "NM"'[TIUFWHO G DSTEX
 S TYPE=$P(TIUFNOD0,U,4) I TYPE="CO" G DSTEX
 ;If called to redisplay edited screen rather than by Init, kill array starting with Tech flds before resetting array.
 S CNT=$O(^TMP("TIUF3",$J,1000000),-1)
 F TIUI=LASTLIN+1:1:CNT K ^TMP("TIUF3",$J,TIUI),^TMP("TIUF3IDX",$J,TIUI)
 S FILEDA=TIUFINFO("FILEDA")
 S LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)=""
 S LINENO=LINENO+1,^TMP("TIUF3",$J,LINENO,0)="  Technical Fields"_$S(TYPE'="O":"      Note: Values preceded by * have been inherited",1:"")
 K TIUFQ
 S DIC=8925.1,DR="4.1:4.45;4.6;4.7;4.9;5:9",DIQ(0)="I,E",DA=FILEDA,DIQ="TIUFQ" D EN^DIQ1
 I TYPE="O" D SETFLD^TIUFLD(FILEDA,.LINENO,9) G DSTEX
 S PFILEDA=+$O(^TIU(8925.1,"AD",FILEDA,0))
 I TYPE="CL"!(TYPE="DC")!(TYPE="DOC") S PNODE61=$G(^TIU(8925.1,PFILEDA,6.1)),PCUSTOM=$P(PNODE61,U,4) I PCUSTOM="" D INHERIT^TIUFLD(FILEDA,0,6.14,"","","",.PCUSTOM)
 F FLDNO=4.1,4.2,4.3,4.4,4.45,4.6,4.7,4.9,5,6,6.1,6.12,6.13,7,8,6.14 D
 . I FLDNO=6.14,TYPE'="CL",TYPE'="DC" Q
 . I FLDNO=6.1!(FLDNO=6.12)!(FLDNO=6.13),'$G(PCUSTOM) Q
 . D SETFLD^TIUFLD(FILEDA,.LINENO,FLDNO)
 . Q
DSTEX K TIUFQ S LASTLIN=LINENO Q:$D(DTOUT)  D DSEMBED^TIUFD1(.LASTLIN)
 Q
 ;
