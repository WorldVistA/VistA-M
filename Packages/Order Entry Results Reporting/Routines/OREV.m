OREV ;SLC/DAN Event delayed orders set up ;10/25/02  13:46
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**142,141**;Dec 17, 1997
 ;DBIA reference section
 ;2336 - XPAREDIT, which is used in OREV EVENT input template
 ;10102- XQORM1
 ;10104- XLFSTR
 ;10103- XLFDT
 ;519  - ^DIC(45.7
 ;10116- VALM1
 ;10026- DIR
 ;10117- VALM10
 ;10118- VALM
 ;10006- DIC
 ;10018- DIE
 ;10013- DIK
EN ; -- main entry point for OR DELAYED ORDERS
 N DIR,Y,ORTYPE,XQORNOD,VALMHDR,VALMSG,VALMBCK,VALMBG,VALMWD,XQORM,ORNMBR
 F  D  Q:+Y'>0  D SWITCH
 .S DIR(0)="SO^1:Auto-DC Rules;2:Release Events" D ^DIR K DIR
 .Q:+Y'>0  S ORTYPE=$S(Y=1:"A",1:"E")
 Q
 ;
SWITCH D EN^VALM($S(ORTYPE="A":"OREV AUTO-DC ACTIONS",1:"OREV EVENT ACTIONS"))
 Q
 ;
HDR ; -- header code
 N LST,DSP
 S DSP=$G(^TMP("ORDSP",$J,DUZ))
 S LST=$G(^TMP("ORLIST",$J,DUZ))
 S VALMHDR(1)=$S(ORTYPE="E":"Event ",1:"Auto-DC ")_"set up and maintenance"
 S VALMHDR(1)=VALMHDR(1)_" - "_$S(LST="I":"Inactive",LST="A":"Active",1:"All")_" entries/"_$S(DSP:"Expanded",1:"Truncated")_" view"
 Q
 ;
PHDR ;
 S VALMSG=$S($G(ORTYPE)'="":"Select number or enter action desired",1:"")
 S XQORM("#")=$S(ORTYPE="E":$O(^ORD(101,"B","OREV ENTER/EDIT EVENTS MENU",0)),1:$O(^ORD(101,"B","OREV ENTER/EDIT AUTO DC MENU",0)))
 D SHOW^VALM
 Q
 ;
INIT ;
 S VALMBCK="",VALMBG=$S($G(VALMBG)'="":VALMBG,1:1),VALMCNT=0,VALMWD=80
 K ^TMP("OREDO",$J),^TMP("ORCXPND",$J)
 Q
 ;
LIST ; -- produce list of existing events/rules
 N ORI,ORCNT,ORGLOB,ORJ,NAME,DSP,LST
 K ^TMP("OREDO",$J) ;Delete list before building
 S DSP=$G(^TMP("ORDSP",$J,DUZ)) ;Display full text if DSP =1 else truncate
 S LST=$G(^TMP("ORLIST",$J,DUZ)) ;List shows active, inactive or all
 S ORGLOB="^ORD(100."_$S(ORTYPE="E":"5)",1:"6)")
 S VALMBCK="R"
 S ORI="" F  S ORI=$O(@ORGLOB@("B",ORI)) Q:ORI=""  D
 .S ORJ="" F  S ORJ=$O(@ORGLOB@("B",ORI,ORJ)) Q:ORJ=""  Q:ORTYPE="E"&($P($G(@ORGLOB@(ORJ,0)),U,12))  D GETENTRY(ORJ,DSP,LST,.ORCNT,ORGLOB)
 ;set column headers to match display width
 S VALMDDF("NAME")="NAME^5^"_$S(DSP:50,1:40)_"^Event Name"
 S VALMDDF("DISPTXT")="DISPTXT^"_$S(DSP:58,1:46)_"^"_$S(DSP:60,1:20)_"^Display Text"
 S VALMDDF("ACT")="ACT^"_$S(DSP:119,1:67)_"^8^Active?"
 S VALMDDF("EVENT")="EVENT^"_$S(DSP:127,1:76)_"^5^Event"
 D CHGCAP^VALM("DISPTXT","Display Text") ;Causes caption line to be updated to new values set above
 S VALMCNT=+$G(ORCNT)
 Q
 ;
GETENTRY(ENTRY,DSP,LST,ORCNT,ORGLOB) ;
 ;
 N ZNODE,NAME,DN,ACT,ECODE,SP,CHILD,CHENTRY
 I LST'="" Q:LST="A"&($G(@ORGLOB@(ENTRY,1)))  Q:LST="I"&('$G(@ORGLOB@(ENTRY,1)))  ;If not all then only active or inactive
 S ZNODE=@ORGLOB@(ENTRY,0)
 S CHILD=$S($P(ZNODE,U,12):1,1:0)
 S NAME=$P(ZNODE,U) S:'DSP NAME=$E(NAME,1,$S(CHILD:38,1:40)) ;display is truncated
 S DN=$S(ORGLOB["5":8,1:5),DN=$P(ZNODE,U,DN) S:'DSP DN=$E(DN,1,20) ;display is truncated
 S ACT=$S($P($G(@ORGLOB@(ENTRY,1)),U):"N",1:"Y") ;rule active?
 S ECODE=$P(ZNODE,U,2) S:ECODE=""&(CHILD) ECODE=$P(^ORD(100.5,$P(ZNODE,U,12),0),U,2) ;event code
 S ORCNT=$G(ORCNT)+1,SP=$$REPEAT^XLFSTR(" ",$S(CHILD:6,1:4)-$L(ORCNT))
 D SET^VALM10(ORCNT,ORCNT_SP_NAME_$$REPEAT^XLFSTR(" ",($S(DSP&('CHILD):53,DSP&(CHILD):51,'DSP&('CHILD):41,1:39)-$L(NAME)))_DN_$$REPEAT^XLFSTR(" ",($S(DSP:63,1:23)-$L(DN)))_ACT_"       "_ECODE,ENTRY)
 I $D(^ORD(100.5,"DAD",ENTRY))&(ORTYPE="E") D
 .S CHENTRY=0 F  S CHENTRY=$O(^ORD(100.5,"DAD",ENTRY,CHENTRY)) Q:'+CHENTRY  D GETENTRY(CHENTRY,DSP,LST,.ORCNT,ORGLOB) ;Recursive call to list children
 Q
 ;
CHKSEL ;Evaluate selection if done by number
 N ORJ,ORTMP,DIR,NUM,X,Y
 S NUM=$P($G(XQORNOD(0)),"=",2) ;get currently selected entries
 I NUM'="" D
 .I NUM=$G(ORNMBR) D DESELECT Q  ;If user selects same entry without taking an entry, unhighlight and stop processing
 .D DESELECT:$G(ORNMBR) ;If user previously selected entries but took no action, unhighlight before highlighting new choices
 .S ORNMBR=$P(XQORNOD(0),"=",2),DIR(0)="L^"_"1:"_VALMCNT,X=ORNMBR,DIR("V")="" D ^DIR K DIR
 .I Y="" D FULL^VALM1 W !,"Invalid selection." S DIR(0)="E" D ^DIR K ORNMBR,DIR Q  ;Selection out of range, stop processing
 .F ORJ=1:1:$L(ORNMBR,",")-1 S ORTMP=$P(ORNMBR,",",ORJ) D CNTRL^VALM10(ORTMP,1,+$G(VALMWD),IORVON,IORVOFF)
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("OREDO",$J),^TMP("ORCXPND",$J),^UTILITY("DIQ1",$J),^TMP("ORHIST",$J),^TMP("ORDSP",$J,DUZ),^TMP("ORLIST",$J,DUZ),ORNMBR D FULL^VALM1 Q
 ;
EEE ;Enter/edit events
 N DIC,DLAYGO,ORJ,ORTMP,DA,DIE,DR,ORGLOB,NEW,TYPE,Y,DIDEL
 D FULL^VALM1 ;get full screen
 S VALMBCK="R"
 S ORGLOB=$S(ORTYPE="E":"^ORD(100.5,",1:"^ORD(100.6,")
 S DIDEL=$S(ORTYPE="E":100.5,1:100.6)
 S DIC=ORGLOB
 I $G(ORNMBR)="" S ORNMBR=$$ORDERS^OREV1("edit") Q:ORNMBR="^"  ;If action selected before items, get items
 I $G(ORNMBR)="" D  Q
 .S DLAYGO=$S(ORTYPE="E":100.5,1:100.6),DIC(0)="AEMQL"
 .D ^DIC Q:Y=-1  S NEW=$S($L(Y,"^")=3:1,1:0),DIE=DIC,DA=+Y
 .L +@(ORGLOB_DA_")"):1 I '$T W !!,"This entry is being edited by another user." H 3 Q
 .I NEW D COPY(DA) S DR="1///"_$$NOW^XLFDT D ^DIE W !!,"NOTE: New entries start INACTIVATED.",! ;New entries start inactivated
 .I 'NEW S TYPE=$P(@(ORGLOB_DA_",0)"),U,2)
 .I ORTYPE="E" I $$RELEVNTS^OREV1(DA) W !!,$C(7),"** This event has delayed orders associated with it! **",!,"Editing will affect these delayed events.",!
 .I ORTYPE="A" W !!,"Editing auto-dc rules takes effect immediately.",!
 .S DR="[OREV "_$S(ORTYPE="E"&($P($G(^ORD(100.5,DA,0)),U,12)):"CHILD EVENT",ORTYPE="E":"EVENT",1:"AUTO DC") D ^DIE
 .I $G(DA) I 'NEW I $G(TYPE)'=$P(@(ORGLOB_DA_",0)"),U,2) D CHKTYP^OREV1(DA) ;If new event and type changed then check event type for extraneous entries
 .I $G(DA) I 'NEW I TYPE="T",ORTYPE="A",'$D(^ORD(100.6,DA,3,"B",4)) D DELMUL^OREV1(100.6,DA,5),DELMUL^OREV1(100.6,DA,6) ;If not new entry and type is transfer and MAS MOVEMENT TYPE is not interward transfer then delete locations and divisions
 .I $G(DA) D AUDIT(DA,$S($G(NEW):"N",1:"E")) ;If entry not deleted add to audit history
 .I $G(DA) L -@(ORGLOB_DA_")")
 ;
 F ORJ=1:1:$L(ORNMBR,",")-1 S ORTMP=$P(ORNMBR,",",ORJ),DA=$O(^TMP("OREDO",$J,"IDX",ORTMP,0)) D
 .W ! W:ORJ'=1 !,"**NOW EDITING NEXT ENTRY**",!
 .L +@(ORGLOB_DA_")"):1 I '$T W !!,"This entry is being edited by another user." H 3 Q  ;Lock global
 .I ORTYPE="E" I $$RELEVNTS^OREV1(DA) W !!,$C(7),"** This event has delayed orders associated with it! **",!,"Editing will affect these delayed events.",!
 .I ORTYPE="A" W !!,"Editing auto-dc rules takes effect immediately.",!
 .S TYPE=$P(@(ORGLOB_DA_",0)"),U,2)
 .S DIE=DIC,DR="[OREV "_$S(ORTYPE="E"&($P($G(^ORD(100.5,DA,0)),U,12)):"CHILD EVENT",ORTYPE="E":"EVENT",1:"AUTO DC") D ^DIE
 .I $G(DA) I $G(TYPE)'=$P(@(ORGLOB_DA_",0)"),U,2) D CHKTYP^OREV1(DA) ;If entry not deleted check event type and add to audit history
 .I $G(DA) I TYPE="T",ORTYPE="A",'$D(^ORD(100.6,DA,3,"B",4)) D DELMUL^OREV1(100.6,DA,5),DELMUL^OREV1(100.6,DA,6) ;If not new entry and type is transfer and MAS MOVEMENT TYPE is not interward transfer then delete locations and divisions
 .I $G(DA) D AUDIT(DA,"E") ;If entry not deleted add to audit history
 .I $G(DA) L -@(ORGLOB_DA_")") ;Unlock global
 K DIE("NO^") Q
 ;
DESELECT ;Un-highlight selected choices
 N ORJ,ORTMP
 F ORJ=1:1:$L($G(ORNMBR),",")-1 S ORTMP=$P(ORNMBR,",",ORJ) D CNTRL^VALM10(ORTMP,1,+$G(VALMWD),IORVOFF,IORVOFF)
 K ORNMBR
 Q
 ;
COPY(NEWENT) ;Allow new entries to copy from existing entries
 N DIR,DLAYGO,DIC,DA,DIK,DIE,NAME,DIVISN,DR,Y
 S DIR(0)="Y",DIR("A")="Do you want to copy from an existing entry",DIR("B")="NO",DIR("?")="Enter Yes to copy an existing entry to this one" D ^DIR Q:Y'=1
 S DIC(0)="AEMQ",DIC=ORGLOB,DIC("S")="I Y'=NEWENT,$P(@(ORGLOB_+Y_"",0)""),U,2)=$P(@(ORGLOB_NEWENT_"",0)""),U,2)" D ^DIC Q:Y=-1  ;Quit if no selection made
 W !,"Copying..."
 S NAME=$P(@(ORGLOB_NEWENT_",0)"),U) ;get name of new entry
 S DIVISN=$P(@(ORGLOB_NEWENT_",0)"),U,3) ;get division of new entry
 M @(ORGLOB_NEWENT_")")=@(ORGLOB_+Y_")")
 K @(ORGLOB_NEWENT_",2)") ;Delete activation history that was copied
 K @(ORGLOB_NEWENT_",9)") ;Delete audit history that was copied.
 S DIK=DIC,DA=+Y D IX1^DIK ;set all xrefs for new entry
 S DIE=ORGLOB,DA=NEWENT,DR=".01///"_NAME_";3///"_DIVISN D ^DIE ;reset name and division of new entry
 Q
 ;
AUDIT(ENTRY,TYPE) ;Adds audit history for entry
 N DIC,DA,DIE,X,Y,DR
 S DA(1)=ENTRY,DIC(0)="L",X=$$NOW^XLFDT,DIC=ORGLOB_DA(1)_",9,"
 D ^DIC Q:Y=-1  ;Stop processing if entry not added
 S DIE=DIC K DIC
 S DA=+Y
 S DR="1///"_$S($G(DUZ):"`"_DUZ,1:"")_";2///"_TYPE D ^DIE
 Q
 ;
