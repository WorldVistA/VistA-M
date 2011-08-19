OREV2 ;SLC/DAN Event delayed orders set up ;10/22/03  09:06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**142,141,208**;Dec 17, 1997
 ;DBIA reference section
 ;10060- ^VA(200
 ;2336 - XPAREDIT
 ;10026- DIR
 ;10116- VALM1
 ;2052 - DID
 ;10015- DIQ
 ;10117- VALM10
 ;10103- XLFDT
 ;10104- XLFSTR
DET ;Detailed display 
 N DIC,Y,ORJ,ORTMP,DA,CNT
 S CNT=1,VALMBCK="R" K ^UTILITY("DIQ1",$J),^TMP("ORCXPND",$J),^TMP("VALM VIDEO",$J)
 I $G(ORNMBR)="" S ORNMBR=$$ORDERS^OREV1("display")
 F ORJ=1:1:$L(ORNMBR,",")-1 S ORTMP=$P(ORNMBR,",",ORJ),DA=$O(^TMP("OREDO",$J,"IDX",ORTMP,0)) D
 .I ORJ'=1 S ^TMP("ORCXPND",$J,CNT,0)=$$REPEAT^XLFSTR("*",79),CNT=CNT+1 S ^TMP("ORCXPND",$J,CNT,0)="   ",CNT=CNT+1
 .D SETG(DA)
 S VALMCNT=CNT-1 S:VALMCNT=0 VALMBCK="Q" S:ORNMBR="^" VALMQUIT="Q"
 Q
 ;
SETG(IEN) ;Set details into global
 N DIC,DA,ORI,DR,GLOB,NAME,I,HASPRNT,ETYPE,PIECE
 K ^UTILITY("DIQ1",$J)
 S (DIC,GLOB)=$S(ORTYPE="E":100.5,1:100.6)
 S DA=IEN
 I '$D(@("^ORD("_GLOB_","_DA_",0)")) Q
 I ORTYPE="E" D
 .S HASPRNT=+$P($G(^ORD(100.5,IEN,0)),U,12)
 .S ETYPE=$P(^ORD(100.5,$S(HASPRNT:HASPRNT,1:IEN),0),U,2)
 .I HASPRNT D  Q
 ..S ^TMP("ORCXPND",$J,CNT,0)="This is a CHILD entry. (p) indicates value is from its parent entry.",CNT=CNT+1,^TMP("ORCXPND",$J,CNT,0)="",CNT=CNT+1
 ..S DR=".01;.1;1;5;8;9;13;14"
 ..D EN^DIQ1
 ..S DA=HASPRNT ;Get parent information to display with child
 ..S DR="2;3;4;6"_$S("^A^D^T^"[("^"_ETYPE_"^"):";7",1:"")
 ..D EN^DIQ1
 ..S PIECE="" F I=1:1:$L(DR,";") S PIECE=$P(DR,";",I) S ^UTILITY("DIQ1",$J,GLOB,IEN,PIECE)=^UTILITY("DIQ1",$J,GLOB,DA,PIECE)
 ..S DA=IEN ;Reset DA to child IEN
 .;
 .S DR=".01:6"_$S("^A^T^D^"[("^"_ETYPE_"^"):";7:9",1:";8:9")_";13"
 .D EN^DIQ1
 I ORTYPE="A" D
 .S ETYPE=$P(^ORD(100.6,DA,0),U,2)
 .S DR=".01:"_$S("^D^T^"[("^"_$P(^ORD(100.6,IEN,0),U,2)_"^")&($$ASKOBS^OREV1):"6",1:"5")
 .D EN^DIQ1
 S ORI=0 F  S ORI=$O(^UTILITY("DIQ1",$J,GLOB,DA,ORI)) Q:ORI=""  D
 .S NAME=$$GET1^DID(GLOB,ORI,,"LABEL")
 .I NAME="DIVISION" S NAME=$S(ETYPE="A":"ADMIT TO",ETYPE="D":"DISCHARGE FROM",ETYPE="T":"TRANS TO/WITHIN",ETYPE="O":"SURGERY WITHIN",ETYPE="S":"TR SP CHANGE WITHIN",1:"MAN. REL. WITHIN")_" "_NAME
 .S:$G(HASPRNT)&("^2^3^4^6^7^"[("^"_ORI_"^")) NAME=NAME_" (P)"
 .S NAME=NAME_":"
 .S ^TMP("ORCXPND",$J,CNT,0)=$$LJ^XLFSTR($E(NAME)_$$LOW^XLFSTR($E(NAME,2,$L(NAME))),30)_$G(^UTILITY("DIQ1",$J,GLOB,IEN,ORI)),CNT=CNT+1
 I ORTYPE="E",$D(^ORD(100.5,"DAD",DA)) D GETCHILD ;If parent then show children
 D GETMULT($S($G(HASPRNT):HASPRNT,1:IEN))
 I $G(^TMP("ORHIST",$J,DUZ)) D GETHIST(ORTYPE),GETAHIST(ORTYPE)
 K ^UTILITY("DIQ1",$J)
 Q
 ;
GETMULT(IEN) ;Retrieve values from multiples
 N ORK,I,J,DCNT,DEF,GLOB,LOC0,ORI,SUB
 ;Multiples for release event file
 I ORTYPE="E" D  Q
 .F ORK="LOC","TS" D
 ..S GLOB=$S(ORK="LOC":"^DIC(42,",1:"^DIC(45.7,")
 ..I $O(^ORD(100.5,IEN,ORK,0))>0 D
 ...S ^TMP("ORCXPND",$J,CNT,0)="   ",CNT=CNT+1
 ...S ^TMP("ORCXPND",$J,CNT,0)=$S(ORK="LOC":"Included Locations",1:"Included Treating Specialties")_$S($G(HASPRNT):" (p)",1:"")_":"
 ...D:$D(IOUON)&($D(IOUOFF)) CNTRL^VALM10(CNT,1,$L(^(0)),IOUON,IOUOFF)
 ...S CNT=CNT+1
 ...S ORI=0 F  S ORI=$O(^ORD(100.5,IEN,ORK,ORI)) Q:'+ORI  D
 ....S DEF=$P(^ORD(100.5,IEN,ORK,ORI,0),"^",2) ;Is this the default?
 ....S ^TMP("ORCXPND",$J,CNT,0)=$P($G(@(GLOB_+$P(^ORD(100.5,IEN,ORK,ORI,0),"^")_",0)")),"^")_$S(DEF:" (Default)",1:""),CNT=CNT+1
 ;Multiples for auto-dc file
 ;Get movements, divisions, packages, display groups, and orderable items
 F SUB=3,6,7,10,8 D
 .I $O(^ORD(100.6,IEN,SUB,0))>0 D
 ..S ^TMP("ORCXPND",$J,CNT,0)=" ",CNT=CNT+1
 ..S ^TMP("ORCXPND",$J,CNT,0)=$S(SUB=3:"Movement Types:",SUB=6:"From Divisions:",SUB=7:"Included Packages:",SUB=10:"Excluded Display Groups:",1:"Excluded Orderable Items:")
 ..D:$D(IOUON)&($D(IOUOFF)) CNTRL^VALM10(CNT,1,$L(^(0)),IOUON,IOUOFF)
 ..S CNT=CNT+1
 ..S GLOB=$S(SUB=3:"^DG(405.2,",SUB=6:"^DIC(4,",SUB=7:"^DIC(9.4,",SUB=10:"^ORD(100.98,",1:"^ORD(101.43,")
 ..S I=0 F  S I=$O(^ORD(100.6,IEN,SUB,I)) Q:'+I  D
 ...S ^TMP("ORCXPND",$J,CNT,0)=$$GET1^DIQ(+$P(GLOB,"(",2),+$P(^ORD(100.6,IEN,SUB,I,0),U)_",",.01,"")
 ...I SUB=8,$G(@(GLOB_+$P(^ORD(100.6,IEN,SUB,I,0),U)_",.1)")) S ^TMP("ORCXPND",$J,CNT,0)=^TMP("ORCXPND",$J,CNT,0)_" (* INACTIVE *)"
 ...S CNT=CNT+1
 ;
 ;Get Treating Specialties
 I $O(^ORD(100.6,IEN,4,0))>0 D
 .S ^TMP("ORCXPND",$J,CNT,0)=" ",CNT=CNT+1
 .S ^TMP("ORCXPND",$J,CNT,0)="Excluding From Treating Specialties:    To Treating Specialties:"
 .D:$D(IOUON)&($D(IOUOFF)) CNTRL^VALM10(CNT,1,$L(^(0)),IOUON,IOUOFF)
 .S CNT=CNT+1
 .S GLOB="^DIC(45.7,"
 .S I=0 F  S I=$O(^ORD(100.6,IEN,4,I)) Q:'+I  D
 ..S ^TMP("ORCXPND",$J,CNT,0)=$$LJ^XLFSTR($P($G(@(GLOB_+$P(^ORD(100.6,IEN,4,I,0),U)_",0)")),U),40)
 ..S DCNT=0
 ..S J=0 F  S J=$O(^ORD(100.6,IEN,4,I,1,J)) Q:'+J  D
 ...S:DCNT'=0 CNT=CNT+1
 ...S ^TMP("ORCXPND",$J,CNT,0)=$S(DCNT=0:^TMP("ORCXPND",$J,CNT,0),1:$$REPEAT^XLFSTR(" ",40))_$P($G(@(GLOB_+$P(^ORD(100.6,IEN,4,I,1,J,0),U)_",0)")),U)
 ...S DCNT=1
 ..S CNT=CNT+1
 ;Locations
 I $O(^ORD(100.6,IEN,5,0)) D
 .S ^TMP("ORCXPND",$J,CNT,0)=" ",CNT=CNT+1
 .S ^TMP("ORCXPND",$J,CNT,0)="Including From Locations:"_$$REPEAT^XLFSTR(" ",15)_"To Locations:"
 .D:$D(IOUON)&($D(IOUOFF)) CNTRL^VALM10(CNT,1,$L(^(0)),IOUON,IOUOFF)
 .S CNT=CNT+1
 .S GLOB="^SC("
 .S I=0 F  S I=$O(^ORD(100.6,IEN,5,I)) Q:'+I  D
 ..S LOC0=^ORD(100.6,IEN,5,I,0)
 ..S ^TMP("ORCXPND",$J,CNT,0)=$$LJ^XLFSTR($S($P(LOC0,U,2)=1:"* (All Locations)",1:$P($G(@(GLOB_+$P(LOC0,U,3)_",0)")),U)),40)
 ..S ^TMP("ORCXPND",$J,CNT,0)=^TMP("ORCXPND",$J,CNT,0)_$S($P(LOC0,U,4)=1:"* (All Locations)",1:$P($G(@(GLOB_+$P(LOC0,U,5)_",0)")),U)),CNT=CNT+1
 Q
 ;
GETHIST(TYPE) ;Print activation history on detailed report
 N ORGLOB,I,VALUE
 S ORGLOB="^ORD(100."_$S(ORTYPE="E":"5,",1:"6,")
 I $D(@(ORGLOB_IEN_",2)")) S ^TMP("ORCXPND",$J,CNT,0)=" ",CNT=CNT+1,^TMP("ORCXPND",$J,CNT,0)="Activation History:" D
 .D:$D(IOUON)&($D(IOUOFF)) CNTRL^VALM10(CNT,1,$L(^(0)),IOUON,IOUOFF)
 .S CNT=CNT+1
 S I=0 F  S I=$O(@(ORGLOB_IEN_",2,"_I_")")) Q:'+I  D
 .S VALUE=$G(^(I,0)) Q:VALUE=""
 .S ^TMP("ORCXPND",$J,CNT,0)="Activated: "_$$FMTE^XLFDT($P(VALUE,U),1)_"  Inactivated: "_$$FMTE^XLFDT($P(VALUE,U,2),1),CNT=CNT+1
 Q
 ;
GETAHIST(TYPE) ;Print audit history on detailed report
 N ORGLOB,ORI,VALUE,DIC,DR,DA,DIQ,NAME
 S ORGLOB="^ORD(100."_$S(ORTYPE="E":"5,",1:"6,")
 I $D(@(ORGLOB_IEN_",9)")) S ^TMP("ORCXPND",$J,CNT,0)=" ",CNT=CNT+1,^TMP("ORCXPND",$J,CNT,0)="Add/Edit History:" D
 .D:$D(IOUON)&($D(IOUOFF)) CNTRL^VALM10(CNT,1,$L(^(0)),IOUON,IOUOFF)
 .S CNT=CNT+1
 S ORI=0 F  S ORI=$O(@(ORGLOB_IEN_",9,"_ORI_")")) Q:'+ORI  D
 .S VALUE=$G(^(ORI,0)) Q:VALUE=""
 .K NAME S DIC=200,DR=".01",DA=+$P(VALUE,U,2),DIQ="NAME",DIQ(0)="E" D EN^DIQ1
 .S ^TMP("ORCXPND",$J,CNT,0)=$S($P(VALUE,U,3)="N":"Added",1:"Edited")_" on "_$$FMTE^XLFDT($P(VALUE,U),1)_" by "_$G(NAME(200,DA,.01,"E")),CNT=CNT+1
 Q
 ;
IWT(DA) ;Function to determine if MAS MOVEMENT Interward transfer is being used by itself.  It may not be used in conjunction with other transfer types
 N IWT
 S IWT=0
 I $P($G(^ORD(100.6,DA,0)),U,2)="T",$P($G(^ORD(100.6,DA,3,0)),U,4)=1,$D(^ORD(100.6,DA,3,"B",4)) S IWT=1
 Q IWT
 ;
INCHIST ;Toggles audit and activation histories for inclusion on the detailed display
 N INC,DIR,Y
 S INC=$G(^TMP("ORHIST",$J,DUZ))
 S VALMBCK="R" D FULL^VALM1
 W !!,"Currently, the audit and activation histories are "_$S('INC:"not ",1:"")_"appearing",!,"on the detailed display.",!
 S DIR(0)="Y",DIR("A")="Do you want to "_$S('INC:"include them on",1:"remove them from")_" the detailed display",DIR("B")="N" D ^DIR
 I Y'=1 W !,"Nothing changed!" Q
 W !,"Histories are now "_$S('INC:"included.",1:"removed.")
 I 'INC S ^TMP("ORHIST",$J,DUZ)=1
 I INC K ^TMP("ORHIST",$J,DUZ)
 Q
 ;
FULLDSP ;Toggle between expanded and truncated display
 N DSP,DIR,Y,DIRUT
 S DSP=$G(^TMP("ORDSP",$J,DUZ))
 W !!,"Currently, the display is "_$S('DSP:"truncated.",1:"expanded."),!
 S DIR(0)="Y",DIR("A")="Do you want to "_$S(DSP:"truncate",1:"expand")_" this display",DIR("B")="N" D ^DIR K DIR
 W:Y'=1 !,"Nothing changed!",! Q:$D(DIRUT)
 W:Y=1 !,"List is now "_$S('DSP:"expanded.",1:"truncated."),!
 I Y&('DSP) S ^TMP("ORDSP",$J,DUZ)=1
 I Y&(DSP) K ^TMP("ORDSP",$J,DUZ)
 S DIR(0)="Y",DIR("A")="Terminal emulator in 80 column mode",DIR("B")="Y"
 S DIR("?")="Enter yes for 80 column or no for 132 column mode.  Display will be updated to relfect your answer."
 D ^DIR Q:$D(DIRUT)
 S VALMWD=$S(Y=1:80,1:132)
 Q
 ;
LIST ;Change which entries appear in list
 N LST,Y,DIR,DIRUT
 S LST=$G(^TMP("ORLIST",$J,DUZ))
 W !!,"Currently, the list includes "_$S(LST="A":"only active",LST="I":"only inactive",1:"all")_" entries."
 S DIR(0)="SO^1:Active entries only;2:Inactive entries only;3:All entries",DIR("A")="Select which entries should appear on the list"
 D ^DIR
 Q:+Y'>0
 I Y=3 K ^TMP("ORLIST",$J,DUZ) Q
 S ^TMP("ORLIST",$J,DUZ)=$E(Y(0))
 I LST'=$G(^TMP("ORLIST",$J,DUZ)) S VALMBG=1
 Q
 ;
CD ;Change display
 S VALMBCK="R" D FULL^VALM1
 D FULLDSP,LIST
 Q
 ;
GETCHILD ;
 N I
 S ^TMP("ORCXPND",$J,CNT,0)="",CNT=CNT+1
 S ^TMP("ORCXPND",$J,CNT,0)="Child events:"
 D:$D(IOUON)&($D(IOUOFF)) CNTRL^VALM10(CNT,1,$L(^(0)),IOUON,IOUOFF)
 S CNT=CNT+1
 S I=0 F  S I=$O(^ORD(100.5,"DAD",DA,I)) Q:'+I  S ^TMP("ORCXPND",$J,CNT,0)=$P(^ORD(100.5,I,0),U),CNT=CNT+1
 Q
