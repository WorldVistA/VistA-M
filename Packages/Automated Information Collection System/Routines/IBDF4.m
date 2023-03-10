IBDF4 ;ALB/CJM - ENCOUNTER FORM - BUILD FORM(editing group's selections) ;11/16/92
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**19,38,56,63,70**;APR 24, 1997;Build 46
 ;
 ;
SLCTNS ;
 N IBRTN
 Q:IBLIST'=$P($G(^IBE(357.4,IBGRP,0)),"^",3)
 S IBRTN=IBLIST("RTN")
 D RTNDSCR^IBDFU1B(.IBRTN)
 D KILL^IBDFUA
 D EN^VALM("IBDF EDIT GROUP'S SELECTIONS") ;call the list manager
 Q
ONENTRY ;entry code for list manager
 D IDXSLCTN
 Q
ONEXIT ;exit code for the list manager
 K @VALMAR
 Q
 ;
IDXSLCTN ;build an array of selections in print order for the list processor
 N SLCTN,ODR,NODE
 K @VALMAR
 I '$D(^TMP("IBDF DELETE SELECTION OPTION",$J)) S ^TMP("IBDF DELETE SELECTION OPTION",$J)=0
 S ODR="",VALMCNT=0
 F  S ODR=$O(^IBE(357.3,"APO",IBLIST,IBGRP,ODR)) Q:ODR=""  D
 .S SLCTN="" F  S SLCTN=$O(^IBE(357.3,"APO",IBLIST,IBGRP,ODR,SLCTN)) Q:'SLCTN  D
 ..;check for messed up index and take appropriate action
 ..S NODE=$G(^IBE(357.3,SLCTN,0))
 ..I ($P(NODE,"^",3)'=IBLIST)!($P(NODE,"^",4)'=IBGRP) D  Q
 ...K ^IBE(357.3,"APO",IBLIST,IBGRP,ODR,SLCTN)
 ...I $P(NODE,"^",3)'=IBLIST,$P(NODE,"^",4)=IBGRP D  Q
 ....K DIK,DA S DIK="^IBE(357.3,",DA=SLCTN D ^DIK K DIK,DA
 ...I $P(NODE,"^",3)=IBLIST,$P($G(^IBE(357.4,+IBGRP,0)),"^",3)'=IBLIST D  Q
 ....K DIK,DA S DIK="^IBE(357.3,",DA=SLCTN D ^DIK K DIK,DA
 ...K DIK,DA S DIK="^IBE(357.3,",DA=SLCTN D IX^DIK K DIK,DA
 ..;
 ..S VALMCNT=VALMCNT+1
 ..S @VALMAR@(VALMCNT,0)=$$DISPLAY(SLCTN,VALMCNT),@VALMAR@("IDX",VALMCNT,VALMCNT)=SLCTN
 ..D FLDCTRL^VALM10(VALMCNT,"ID") ;set video for ID column
 I ^TMP("IBDF DELETE SELECTION OPTION",$J)=1,'$O(^IBE(357.3,"APO",IBLIST,IBGRP,"")) D  ;User deleted all selections. Update history files during save.
 .S ^TMP("IBDF DELETED ALL SELECTIONS",$J)=1
 Q
LMGRPHDR ;header for the screen
 S VALMHDR(1)="SELECTIONS CURRENTLY DEFINED FOR '"_$$GRPNAME_"' PRINT GROUP"
 Q
 ;
GRPNAME() ;the name of the selection group
 Q $P($G(^IBE(357.4,IBGRP,0)),"^",1)
 ;
DISPLAY(SLCTN,COUNT) ;returns a line to display to the list containing a selection - SLCTN is a ptr to the selection, COUNT is the number of the selection on the list
 N SC,SCDA,VAL,RET,W,NODE,ORDER
 ;W - an array containing the widths of the subcolumns that contain text
 S VAL=""
 S RET=$$PADRIGHT^IBDFU(COUNT,4)
 S NODE=$G(^IBE(357.3,SLCTN,0))
 S ORDER=$P(NODE,"^",5),RET=RET_$J(ORDER,6,2)
 I $P(NODE,"^",2) S RET=RET_$S($P(NODE,"^",7):" SH",1:" PH")_"| "_$P(NODE,"^",6)
 I '$P(NODE,"^",2) S RET=RET_"  ",SC="" F SC=1:1:8 S SCDA=$O(^IBE(357.3,SLCTN,1,"B",SC,"")) D
 .I $G(IBLIST("SCTYPE",SC))=1 S W(SC)=IBLIST("SCW",SC)*(1+IBLIST("BTWN"))
 .S:$G(W(SC)) VAL=$$PADRIGHT^IBDFU($S(SCDA:$P($G(^IBE(357.3,SLCTN,1,SCDA,0)),"^",2),1:""),W(SC))
 .S:VAL'="" RET=RET_" | "_VAL
 .S VAL=""
 I $D(^IBE(357.3,SLCTN,2)) S RET=RET_"  ",SC="" F SC=1:1:2 S SCDA=$P(^IBE(357.3,SLCTN,2),"^",SC) S:SC=2 SCDA=$S($D(^LEX)>1:$P($G(^LEX(757.01,+SCDA,0)),"^"),1:$P($G(^GMP(757.01,+SCDA,0)),"^")) D
 .S W(SC)=25
 .S VAL=$$PADRIGHT^IBDFU($S(SCDA]"":SCDA,1:""),W(SC))
 .S:VAL'="" RET=RET_" | "_VAL
 .S VAL=""
 Q RET
ADDSLCTN ;allows the user to add a selection to the selection group
 N QUIT,SUB
 ;
 S VALMBCK="R"
 D FULL^VALM1
 I IBRTN("ACTION")'=3 D NOGOOD G ADDEXIT
 S ^TMP("IBDF ADDSLCTN",$J)=1
 K @IBRTN("DATA_LOCATION")
 S QUIT=0 F  D  Q:QUIT  W !!!,"Now for another SELECTION LIST entry!"
 .I '$$DORTN^IBDFU1B(.IBRTN) S QUIT=1 D NOGOOD Q
 .I '$D(@IBRTN("DATA_LOCATION")) S QUIT=1 Q
 .D ADDREC(.QUIT) ;edits and adds the selection
 .K @IBRTN("DATA_LOCATION")
ADDEXIT ;
 D IDXSLCTN
 Q
 ;IBDEXCOD - the external code that we are adding to the group (optional)
ADDREC(QUIT,ORDER,SLCTN,IBDEXCOD,IBDALL) ;allows the user to number the selection, edit the editable subcolumns, then adds the record - sets QUIT=1 if user quits
 N SUB,COUNT,NODE,VAL,DLAYGO,QTY,DTOUT,DUOUT,DIRUT
 I $P($G(^IBE(357.6,$P($G(^IBE(357.2,+IBLIST,0)),"^",11),16)),"^",8) S DIR(0)="NO",DIR("A")="Quantity",DIR("B")=1,DIR("?")="Enter the number of occurrences" D ^DIR K DIR S:$D(DTOUT)!$D(DUOUT) QUIT=1 Q:QUIT  S QTY=$G(Y)
 I '$G(ORDER) D  Q:QUIT
 .K DIR S DIR(0)="357.3,.05",DIR("B")=$$NEXT^IBDF4A(IBLIST,IBGRP) D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 .S ORDER=+Y
 S VAL=$G(@IBRTN("DATA_LOCATION"))
 Q:QUIT
 ;we have all the data needed to add the selection - so add it
 S NODE=$S($P(VAL,"^")'="":$P(VAL,"^"),1:ORDER)_"^^"_IBLIST_"^"_IBGRP_"^"_ORDER_$S($G(QTY):"^^^^"_QTY,1:"")
 K DIC,DD,DO,DINUM S DIC="^IBE(357.3,",X=$P(NODE,"^",1),DIC(0)="FL",DLAYGO=357.3
 D FILE^DICN K DIC,DIE,DA
 S SLCTN=$S(+Y<0:"",1:+Y)
 I 'SLCTN W !,"Unable to create a new selection record!" D PAUSE^VALM1 S QUIT=1 Q
 S ^IBE(357.3,SLCTN,0)=NODE
 ;--- move codes and add modifiers
 D CODES^IBDF4A(.QUIT)
 Q:QUIT
 D ADD^IBDF4C
 ;---move the subcolumn set up
 F SUB=1:1:8 D  Q:QUIT
 .I $G(IBLIST("SCTYPE",SUB))=1 I IBLIST("SCPIECE",SUB),IBLIST("SCW",SUB) D
 ..S NODE=$$DATANODE^IBDFU1B(IBRTN,IBLIST("SCPIECE",SUB))
 ..I NODE]"" S VAL(SUB)=$P($G(@IBRTN("DATA_LOCATION")@(NODE)),"^",IBLIST("SCPIECE",SUB))
 ..E  S VAL(SUB)=$P(VAL,"^",IBLIST("SCPIECE",SUB))
 ..Q:('IBLIST("SCEDITABLE",SUB))!((IBRTN("WIDTH",1))&(IBLIST("SCPIECE",SUB)=1))
 ..W !!,"Subcolumn Header: "_IBLIST("SCHDR",SUB) K DIR S DIR(0)="FO^0:"_(IBLIST("SCW",SUB)*(1+IBLIST("BTWN"))),DIR("A")="Edit Subcolumn "_SUB,DIR("B")=VAL(SUB)_$S($G(QTY)>1:" x "_QTY,1:"")
 ..I $P($G(^IBE(357.3,SLCTN,3,0)),"^",4)>0 D
 ...S:DIR("B")'["w/ mod" DIR("B")=DIR("B")_"w/ mod"
 ..D ^DIR K DIR S:$D(DTOUT)!($D(DUOUT)) QUIT=1 Q:QUIT  S VAL(SUB)=Y I IBLIST("SCPIECE",SUB)=1,X="" S QUIT=1 Q
 Q:QUIT
 ;
 ;add the subcolumn value multiple
 S COUNT=0 F SUB=1:1:8 I $G(VAL(SUB))'="" S COUNT=COUNT+1,^IBE(357.3,SLCTN,1,COUNT,0)=SUB_"^"_VAL(SUB)
 S ^IBE(357.3,SLCTN,1,0)="^357.31IA^"_COUNT_"^"_COUNT
 K DA S DA=SLCTN,DIK="^IBE(357.3," D IX^DIK K DIK,DA
 D NARR(.QUIT)
 Q:QUIT
 D TERM(.QUIT,$G(IBDEXCOD))
 I $G(IBDRPCAL) S:$G(IBDAI)="DG SELECT ICD-10 DIAGNOSIS CODES" IBDX=$$CSUPD357^IBDUTICD(IBFORM,30,"",$$NOW^XLFDT(),DUZ) D ADDALREC(IBSEL)
 Q
 ;
NARR(IBDQUIT) ; -- edit provider narrative, but only for selections where the
 ;    interface allows editing
 N DIE,DA,DR,Y
 I $P($G(^IBE(357.6,+$P($G(^IBE(357.2,+IBLIST,0)),U,11),0)),U,17) D
 .S DIE="^IBE(357.3,",DA=SLCTN,DR=2.01 D ^DIE K DIE,DA,DR
 I $D(Y) S IBDQUIT=1
 Q
 ;IBDCODEX - the external code that we are adding to the group (optional)
TERM(IBDQUIT,IBDCODEX) ; -- map selection to clinical lexicon, but only for selections where
 ;    the package interface allows editing
 ;newed DIC to prevent bug in Lexicon
 N DIE,DA,DR,GMPTUN,GMPTSUB,GMPTSHOW,XTLKGLB,XTLKHLP,XTLKKSCH,XTLKSAY,IBDLEX,DIC,IBDDT
 N LEXQ,LEXVDT,Y,IBLEXNS,IBDLEXSS,IBD1STDT,IBDIMPDT
 ;
 S IBLEXNS="GMPL",IBDLEXSS="PL1"
 ;if this is ICD package interface then if it is ICD-10 then used "10D" if anything else (ICD9 at the moment) - use "ICD"
 I $G(IBRTN("NAME"))["ICD" S (IBLEXNS,IBDLEXSS)=$S($G(IBRTN("NAME"))["ICD-10":"10D",1:"ICD")
 ;
 S IBDDT="" ;keep using "" for ICD-9
 ;for ICD-10 codes:
 ;if IBDCODEX is not provided then use ICD-10 implementation date if it is prior to the ICD-10 implementation date
 ; and default if it is on and after 
 ;if IBDCODEX is defined we rely on the selection logic (see FILTER^IBDUTICD). To pass CONFIG^LEXSET we
 ; use the latest ACTIVE status date of  the code 
 I $G(IBRTN("NAME"))["ICD-10" D
 . ; get the ICD-10 activation date
 . S IBDIMPDT=$$IMPDATE^IBDUTICD("10D")
 . ;if code value is NOT defined/not available then
 . ; set the date to ICD-10 activation if the user adds the code prior to ICD-10 system activation
 . ; and to default "" if in and after ICD-10 activation and quit
 . I $G(IBDCODEX)="" S IBDDT=$S(DT<IBDIMPDT:IBDIMPDT,1:"") Q
 . ;if code value is available then get the date of the last ACTIVE status and use it for CONFIG^LEXSET
 . S IBDDT=$$LSTACTST^IBDUTICD(IBDCODEX)
 . ;if not found for some reason then follow the logic "when the code is NOT available" above
 . I IBDDT=0 S IBDDT=$S(DT<IBDIMPDT:IBDIMPDT,1:"")
 I $P($G(^IBE(357.6,+$P($G(^IBE(357.2,+IBLIST,0)),U,11),0)),U,18) D
 .I $D(^LEX)>1 S X="LEXSET" X ^%ZOSF("TEST") I $T D CONFIG^LEXSET(IBLEXNS,IBDLEXSS,IBDDT) S IBDLEX=1
 .I '$D(IBDLEX) S X="GMPTSET" X ^%ZOSF("TEST") I $T D CONFIG^GMPTSET(IBLEXNS,IBDLEXSS,IBDDT) S IBDLEX=1
 .;D CONFIG^GMPTSET("ICD","ICD") (this is an alternate filter)
 .Q:'$D(IBDLEX)
 .S DIE="^IBE(357.3,",DA=SLCTN,DR="2.02//"_$P($G(^IBE(357.3,DA,0)),"^") D ^DIE
 K DIC
 I $D(Y) S IBDQUIT=1
 Q
 ;
CODES ; -- allow selection of a second code to pass through for this entry
 ; -- only as if pi allows input of more than one code
 ;N PI S PI=+$P($G(^IBE(357.2,+IBLIST,0)),U,11)
 ;Q:'$P($G(^IBE(357.6,PI,16)),U,9)
 ;N IBI,QUIT,IBVAL S QUIT=0
 ;F IBI=1,2 D  Q:QUIT
 ;.W !,"****Select a ",$S(IBI=1:"second",1:"third")," code to pass along with original."
 ;.I '$$DORTN^IBDFU1B(.IBRTN) S QUIT=1 Q
 ;.I +Y'>0 S QUIT=1 Q
 ;.X $G(^IBE(357.6,PI,9)) S IBVAL=X
 ;.S DIE="^IBE(357.3,",DA=SLCTN,DR=$S(IBI=1:"2.03",1:"2.04")_"////^S X=IBVAL" D ^DIE K DIE,DA,DR
 ;Q
 ;
NOGOOD ;
 W !,"The package interface routine for selection is not properly defined" D PAUSE^VALM1
 Q
 ;
SEQUENCE ;allows the user to resequence all of the selections on the list
 ;
 N SUBCOL,CNT,P,SORT,GROUP,NODE,VALUE,ITEM,IEN,HDR,DTOUT,DUOUT,DIRUT,SORT1
 S VALMBCK="R"
 D FULL^VALM1
 ;
 ;sort by which subcolumn?
 K DIR S DIR("A")="Which subcolumn do you want to sort by?",DIR("?")=" "
 S SUBCOL=0 F  S SUBCOL=$O(IBLIST("SCTYPE",SUBCOL)) Q:'SUBCOL  I IBLIST("SCTYPE",SUBCOL)=1 S SUBCOL(SUBCOL)=""
 S (CNT,SUBCOL)=0,DIR(0)="SOX^"
 F CNT=1:1 S SUBCOL=$O(SUBCOL(SUBCOL)) Q:'SUBCOL  D
 .S P=IBLIST("SCPIECE",SUBCOL),P=$S(P=1:1,P=2:3,P=3:5,P=4:7,P=5:9,P=6:11,P=7:13,1:0),HDR=$P($G(^IBE(357.6,+IBLIST("RTN"),2)),"^",P),DIR("?",CNT)=SUBCOL_" = "_HDR
 .S HDR=$S($G(IBLIST("SCHDR",SUBCOL))="":HDR,1:IBLIST("SCHDR",SUBCOL))
 .S DIR(0)=DIR(0)_SUBCOL_":"_HDR_";"
 D ^DIR
 Q:$D(DIRUT)!(Y=-1)
 K SUBCOL S SUBCOL=+Y
 ;
 ;sort alphabetically or numerically?
 K DIR
 S DIR("A")="How should the list be sorted?",DIR(0)="SO^1:ALPHABETICALLY;2:NUMERICALLY;",DIR("B")="ALPHABETICALLY"
 D ^DIR
 Q:$D(DIRUT)!(Y=-1)
 S SORT=Y
 ;  -- Resequence by group or group and placeholders
 K DIR
 S DIR("A")="Resequence by Group or Group and Place Holders?",DIR(0)="SO^1:GROUP/PLACE HOLDERS;2:GROUP;",DIR("B")="GROUP/PLACE HOLDERS"
 D ^DIR
 Q:$D(DIRUT)!(Y=-1)
 S SORT1=Y
 ;
 ;sort
 I SORT1=2 D EN^IBDF4A Q
 N CNTR,GROUP1,IBGROUP,IBORDER
 K ^TMP("IBDF",$J)
 S (GROUP,GROUP1,CNTR,IBGROUP)=0
 ;  -- Resequence only specific groups in block.
 I $D(IBGRUP) F  S IBGROUP=$O(IBGRUP(IBGROUP)) Q:'IBGROUP  D RESEQ
 I $D(IBGRUP) D ORDER Q
 ;  -- Resequence all groups of the block.
 I '$D(IBGRUP) F  S IBGROUP=$O(^IBE(357.3,"APO",IBLIST,IBGROUP)) Q:'IBGROUP  D RESEQ
 I '$D(IBGRUP) D ORDER Q
 Q
RESEQ S IBORDER=0 F  S IBORDER=$O(^IBE(357.3,"APO",IBLIST,IBGROUP,IBORDER)) Q:'IBORDER  S ITEM=0 F  S ITEM=$O(^IBE(357.3,"APO",IBLIST,IBGROUP,IBORDER,ITEM)) Q:'ITEM  D
 .S NODE=$G(^IBE(357.3,ITEM,0))
 .I ($P(NODE,"^",3)'=IBLIST) Q
 .S GROUP1=GROUP,GROUP=+$P(NODE,"^",4)
 .Q:$P($G(^IBE(357.4,GROUP,0)),"^",3)'=IBLIST
 .I $P(NODE,"^",2)=1 D  Q
 ..S CNTR=CNTR+1
 ..S VALUE=$S(SORT=1:" ",1:+$P(NODE,"^",1))
 ..S ^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,CNTR,VALUE,ITEM)=""
 .S IEN=$O(^IBE(357.3,ITEM,1,"B",SUBCOL,0)) Q:'IEN
 .S VALUE=$P($G(^IBE(357.3,ITEM,1,IEN,0)),"^",2)
 .S VALUE=$S(SORT=1:VALUE=" "_VALUE,1:+$P(NODE,"^",1))
 .I GROUP'=GROUP1 S CNTR=CNTR+1
 .S ^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,CNTR,$E(VALUE,1,40),ITEM)=""
 ;set the order
ORDER S GROUP=0,CNTR=0
 F  S GROUP=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP)) Q:'GROUP  D
 .S VALUE="",CNT=0
 .F  S CNTR=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,CNTR)) Q:'CNTR  F  S VALUE=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,CNTR,VALUE)) Q:VALUE=""  D
 ..S ITEM=0 F  S ITEM=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,CNTR,VALUE,ITEM)) Q:'ITEM  D
 ...S CNT=CNT+1
 ...K DIE,DA,DR S DIE="^IBE(357.3,",DR=".05///"_CNT,DA=ITEM D ^DIE K DIE,DA,DR
 ;
 K Y,X,DIR,^TMP("IBDF",$J,"RESEQUENCE LIST")
 D IDXGRP^IBDF3
 Q
ADDALREC(IBSEL) ;updates all forms with the same code
 N IBDCD,IBDY,IBDNODE,IBDOLD,IBDERR,IBDN,IBDSUB,IBDSUB1,IBDN1,IBDATA,IBDNEW,IBDCODE,IBDFRN,IBDBLK,IBDFRM1,IBDFORM,IBDDPC,IBDDUP,IBDTMP1,IBDCL,IBDYS,IBDSBI,IBDSELN,IBDSNEW,DA,DIK
 N IBDFSEL,IBDATA1,IBBLK,IBDANT
 S IBDANT=1
 K ^TMP("IBDANT",$J) S ^TMP("IBDANT",$J,IBDANT)=^IBE(357.3,SLCTN,0)
 S IBDCD=$P(IBDFSLC,U) S IBDY=0 F  S IBDY=$O(^XTMP("CPTIDX",IBDY)) Q:'IBDY  I $P(^XTMP("CPTIDX",IBDY),U,2)=IBDCD D
 .S IBDDPC=0,IBDDUP=0 F  S IBDDPC=$O(IBDSEL1(IBDDPC)) Q:'IBDDPC  D
 ..I $P(^XTMP("CPTIDX",IBDY),U,2,6)=$P(^XTMP("CPTIDX",IBDDPC),U,2,6) S IBDDUP=1,IBDTMP1=$P($G(^XTMP("CPTIDX",IBDY)),"^") S DA=$P(^XTMP("CPTIDX",IBDDPC),U,4),DIK="^IBE(357.3," D ^DIK K DIK
 .I IBDDUP S:^XTMP("IBDCPT",IBDTMP1,0)'="   " ^XTMP("IBDCPT",IBDTMP1,0)=$P(^XTMP("IBDCPT",IBDTMP1,0),")")_")        *******Replaced*******" D  Q
 ..S IBDFSEL=$P(^XTMP("CPTIDX",IBDY),U,4)
 ..S ^XTMP("CPTIDX",IBDY)="*Replaced*"
 .S IBDFORM=$P($G(^XTMP("CPTIDX",IBDY)),"^",5)
 .S IBDTMP1=$P($G(^XTMP("CPTIDX",IBDY)),"^")
 .S IBBLK=$P($G(^XTMP("CPTIDX",IBDY)),"^",6)
 .S IBDFSEL=$P(^XTMP("CPTIDX",IBDY),U,4) S IBDNODE=$G(^IBE(357.3,IBDFSEL,0)) I IBDNODE="" D  Q
 ..S:^XTMP("IBDCPT",IBDTMP1,0)'="   " ^XTMP("IBDCPT",IBDTMP1,0)=$P(^XTMP("IBDCPT",IBDTMP1,0),")")_")        *******Replaced*******" S ^XTMP("CPTIDX",IBDY)="*Replaced*"
 .K DIC,DD,DO,DINUM S DIC="^IBE(357.3,",X=$P(^IBE(357.3,IBSEL,0),"^",1),DIC(0)="FL",DLAYGO=357.3 D FILE^DICN S IBDNEW=+Y K DIC,DIE,DA
 .S IBDYS=IBDFSEL_"," D GETS^DIQ(357.3,IBDYS,"**","NI","IBDOLD","IBDERR")
 .S IBDN=.01,DIE="^IBE(357.3,",DA=IBDNEW F  S IBDN=$O(IBDOLD(357.3,IBDYS,IBDN)) Q:'IBDN  D
 ..S IBDATA=IBDOLD(357.3,IBDYS,IBDN,"I") I IBDATA'="" I IBDN'=.03 I IBDN'=.04 I IBDN'=2.02 I IBDN'=4.02 S DR=IBDN_"///"_IBDATA D ^DIE
 .S IBDATA=$G(IBDOLD(357.3,IBDYS,.03,"I")) I IBDATA'="" S DR=".03////"_IBDATA D ^DIE
 .S IBDATA=$G(IBDOLD(357.3,IBDYS,.04,"I")) I IBDATA'="" S DR=".04////"_IBDATA D ^DIE
 .S IBDATA=$G(IBDOLD(357.3,IBDYS,2.02,"I")) I IBDATA'="" S DR="2.02////"_IBDATA D ^DIE
 .S IBDATA=$G(IBDOLD(357.3,IBDYS,4.02,"I")) I IBDATA'="" S DR="4.02////"_IBDATA D ^DIE
 .S IBDSELN=IBSEL_"," D GETS^DIQ(357.3,IBDSELN,"**","N","IBDCODE","IBDERR")
 .I $D(IBDCODE(357.31)) S IBDSUB="" F  S IBDSUB=$O(IBDCODE(357.31,IBDSUB)) Q:IBDSUB=""  S IBDSBI=IBDCODE(357.31,IBDSUB,.01) S DIC="^IBE(357.3,"_IBDNEW_",1,",X=IBDSBI,DA(1)=IBDNEW,DA=X,DIC(0)="FL",DLAYGO=357.31 D FILE^DICN S IBDSNEW=+Y D
 ..S IBDN1=.01,DIE="^IBE(357.3,"_DA(1)_",1,",DA(1)=IBDNEW,DA=IBDSNEW,IBDSUB1=.01 F  S IBDSUB1=$O(IBDCODE(357.31,IBDSUB,IBDSUB1)) Q:IBDSUB1=""  S IBDATA1=IBDCODE(357.31,IBDSUB,IBDSUB1) I IBDATA1'="" S DR=IBDSUB1_"///^S X=IBDATA1" D ^DIE
 .I $D(IBDCODE(357.33)) S IBDSUB="" F  S IBDSUB=$O(IBDCODE(357.33,IBDSUB)) Q:IBDSUB=""  S IBDSBI=IBDCODE(357.33,IBDSUB,.01) S DIC="^IBE(357.3,"_IBDNEW_",3,",X=IBDSBI,DA(1)=IBDNEW,DA=X,DIC(0)="FL",DLAYGO=357.33 D FILE^DICN S IBDSNEW=+Y D
 ..S IBDN1=.01,DIE="^IBE(357.3,"_DA(1)_",3,",DA(1)=IBDNEW,DA=IBDSNEW,IBDSUB1=.01 F  S IBDSUB1=$O(IBDCODE(357.33,IBDSUB,IBDSUB1)) Q:IBDSUB1=""  S IBDATA1=IBDCODE(357.31,IBDSUB,IBDSUB1) I IBDATA1'="" S DR=IBDSUB1_"///^S X=IBDATA1" D ^DIE
 .S DA=IBDFSEL,DIK="^IBE(357.3," D ^DIK K DIK
 .S IBDANT=IBDANT+1,^TMP("IBDANT",$J,IBDANT)=^IBE(357.3,IBDNEW,0)
 .S:^XTMP("IBDCPT",IBDTMP1,0)'="   " ^XTMP("IBDCPT",IBDTMP1,0)=$P(^XTMP("IBDCPT",IBDTMP1,0),")")_")        *******Replaced*******" S ^XTMP("CPTIDX",IBDY)="*Replaced*"
 Q
