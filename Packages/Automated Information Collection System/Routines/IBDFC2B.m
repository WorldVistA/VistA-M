IBDFC2B ;ALB/CJM - ENCOUNTER FORM - converts a form for scanning ;MAR 3, 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
ADDOTHER ;add space to the list to write in other
 N NODE
 S NODE=$G(^IBE(357.2,IBLIST,0))
 I NODE]"",$P(NODE,"^",16)="" S $P(NODE,"^",16)=1,$P(NODE,"^",17)=3,$P(NODE,"^",18)=2 S ^IBE(357.2,IBLIST,0)=NODE
 Q
 ;
CKVALUES ;make sure the internal value to be passed matches the value displayed and is an active code
 ;
 Q:'IBLIST("INPUT_RTN")
 N SUBCOL,I,SLCTN,IEN,TEXT,CODE,NODE
 ;
 ;find the subcolumn with the code
 S SUBCOL=0 F I=1:1:8 I $G(IBLIST("SCPIECE",I))=1,$G(IBLIST("SCTYPE",I))=1 S SUBCOL=I
 ;
 ;check that the display of the code matches its id and that it's active
 S SLCTN=0 F  S SLCTN=$O(^IBE(357.3,"C",IBLIST,SLCTN)) Q:'SLCTN  D
 .S NODE=$G(^IBE(357.3,SLCTN,0))
 .;
 .;check if place holder
 .Q:$P(NODE,"^",2)
 .;
 .S CODE=$P(NODE,"^")
 .Q:CODE=""
 .;
 .;check for inactive codes
 .I '$$CKACTIVE(CODE,IBLIST("RTN")) D
 ..S TEXT=$$DISPLAY(SLCTN)
 ..D WARNING^IBDFC2("IN THE SELECTION LIST '"_IBLIST("NAME")_"' THE ENTRY="_TEXT_" IS AN INACTIVE CODE")
 .;
 .;check for displayed codes that don't match their id stored on piece 1
 .Q:'SUBCOL
 .S IEN=$O(^IBE(357.3,SLCTN,1,"B",SUBCOL,0))
 .Q:'IEN
 .S TEXT=$P($G(^IBE(357.3,SLCTN,1,IEN,0)),"^",2)
 .Q:'$L(TEXT)
 .I CODE'=TEXT D
 ..; -- codes doesn't match text and autochange= yes
 ..I $G(IBDASK("AUTOCHG")),$$CKACTIVE(TEXT,IBLIST("RTN")) D  Q
 ...; use fm to update data and x-refs S $P(^IBE(357.3,SLCTN,0),"^")=TEXT
 ...S DIE=357.3,DR=".01////^S X=TEXT",DA=SLCTN D ^DIE K DIE,DA,DR
 ...D WARNING^IBDFC2("In the Selection List '"_IBLIST("NAME")_"' the Code="_CODE_" was automatically update to match the text="_TEXT)
 ...Q
 ..D WARNING^IBDFC2("IN THE SELECTION LIST '"_IBLIST("NAME")_"' THE CODE="_TEXT_" IS DISPLAYED BUT THE CODE="_CODE_" WILL BE TRANSMITTED") Q
 Q
 ;
CHKVISIT ;should the selection list use the new Package Interface for Type of Visit?
 ;
 I ($$UP^XLFSTR(IBLIST("NAME"))["VISIT")!($$UP^XLFSTR(IBBLK("NAME"))["VISIT"),IBLIST("RTN") I $P($G(^IBE(357.6,IBLIST("RTN"),0)),"^")["SELECT CPT PROCEDURE" D
 .N SLCTN,CODE,PI,CHANGE
 .S PI=$O(^IBE(357.6,"B","DG SELECT VISIT TYPE CPT PROCE",0))
 .Q:'PI
 .S CHANGE=1,SLCTN=0 F  S SLCTN=$O(^IBE(357.3,"C",IBLIST,SLCTN)) Q:'SLCTN  S CODE=$P($G(^IBE(357.3,SLCTN,0)),"^") I CODE I '$D(^IBE(357.69,CODE,0)) S CHANGE=0 Q
 .;change the list to visit type
 .I CHANGE D
 ..N CNT,SC,NODE,SUB S (CNT,SC)=""
 ..;change the package interface to type of visit
 ..S $P(^IBE(357.2,IBLIST,0),"^",11)=PI
 ..;set the selection rule to exactly one as long as there is only one marking subcolumn
 ..F  S SC=$O(^IBE(357.2,IBLIST,2,SC)) Q:'SC  S NODE=$G(^IBE(357.2,IBLIST,2,SC,0)) I $P(NODE,"^",4)=2 S CNT=CNT+1,SUB=SC
 ..I CNT=1,$P(NODE,"^",10)="" S $P(^IBE(357.2,IBLIST,2,SUB,0),"^",10)=1
 .;
 .I 'CHANGE,IBLIST("NAME")["VISIT",IBLIST("NAME")["TYPE" D WARNING^IBDFC2("THE BLOCK '"_IBBLK("NAME")_"' HAS A LIST FOR CPT PROCEDURES THAT PERHAPS SHOULD BE REPLACED WITH VISIT TYPE")
 Q
 ;
CKACTIVE(X,PI) ;returns 1 if the X=an active code, 0 otherwise
 Q:'PI 1
 X $G(^IBE(357.6,PI,11))
 Q $D(X)
 ;
DISPLAY(SLCTN) ;returns selection display
 N SC,SCDA,VAL,RET,W,NODE
 ;W - an array cotaining the widths of the subcolumns that contain text
 S NODE=$G(^IBE(357.3,SLCTN,0))
 S RET="  ",(VAL,SC)=""
 F SC=1:1:8 S SCDA=$O(^IBE(357.3,SLCTN,1,"B",SC,"")) D
 .I $G(IBLIST("SCTYPE",SC))=1 S W(SC)=IBLIST("SCW",SC)*(1+IBLIST("BTWN"))
 .S:$G(W(SC)) VAL=$$PADRIGHT^IBDFU($S(SCDA:$P($G(^IBE(357.3,SLCTN,1,SCDA,0)),"^",2),1:""),W(SC))
 .S:VAL'="" RET=RET_"  "_VAL
 .S VAL=""
 Q RET
 ;
ASKOTH() ; Function
 ; -- ask if want to add other hand print field automatically
 ;    Returns 1 if yes, 0 if no, or -1 if uparrow
 ;
 N X,Y,ANS,DIR
 W !
 S ANS=-1
 S DIR("?")="Answer YES if you want to automatically add 1 hand print field to each selection list.  If you answer NO nothing will be added."
 S DIR("?",1)="   Hand print fields can be automatically added to your form"
 S DIR("?",2)="   if you wish. If there isn't suffient room in the block"
 S DIR("?",3)="   or on the form them adding the hand print field will cause"
 S DIR("?",4)="   part of the list to disappear."
 S DIR("?",5)=" "
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Automatically Add 'Other' Hand Print Fields"
 D ^DIR
 I $D(DIRUT) G ASKOTHQ
 S ANS=Y
ASKOTHQ Q ANS
 ;
ASKAUTO() ; Function
 ; -- ask if want to automatically update codes
 ;    Returns 1 if yes, 0 if no, or -1 if uparrow
 ;
 N X,Y,ANS,DIR
 W !
 S ANS=-1
 S DIR("?")="Answer YES if you want codes in the selection lists that will be transmitted to PCE to automatically be updated to match the displayed codes.  If you answer No, warnings will be generated but the codes will not be updated."
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Automatically update codes to be transmitted"
 D ^DIR
 I $D(DIRUT) G ASKAUTQ
 S ANS=Y
ASKAUTQ Q ANS
