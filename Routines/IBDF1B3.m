IBDF1B3 ;ALB/CJM - ENCOUNTER FORM - (lists data that did not fit on the encounter form);4/28/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**39**;APR 24, 1997
OVERFLOW ;
 ;loops through @IBARRAY("OVERFLOW"), printing in list form all the data that did not fit
 ;
 N IBBLK,FIELD,TYPE,ITEM,RTN,PAGE
 Q:'$D(@IBARRAY("OVERFLOW"))
 S PAGE=1
 D HDR
 S IBBLK="" F  S IBBLK=$O(@IBARRAY("OVERFLOW")@(IBBLK)) Q:'IBBLK  D
 .Q:$$BLKDESCR^IBDFU1B(.IBBLK)
 .D BLOCKBRK
 .S FIELD="" F  S FIELD=$O(@IBARRAY("OVERFLOW")@(IBBLK,FIELD)) Q:'FIELD  D
 ..S TYPE="" F  S TYPE=$O(@IBARRAY("OVERFLOW")@(IBBLK,FIELD,TYPE)) Q:TYPE=""  D
 ...I TYPE="DYNAMIC LIST" D LIST Q
 ...D FIELD
 D FOOTER
 K @IBARRAY("OVERFLOW")
 Q
HDR ;writes header to top of page
 N HDR
 S HDR="ADDITIONAL ENCOUNTER FORM DATA"
 W !,?((IOM-$L(HDR))/2),HDR,?(IOM-10),"PAGE: ",PAGE,!
 W !,"CLINIC:   ",$P($G(^SC(IBCLINIC,0)),"^")
 W !,"PATIENT:  " I $G(DFN) W $P($G(^DPT(DFN,0)),"^")
 W !,"FORM:     ",$P($G(^IBE(357,IBFORM,0)),"^"),!
 S PAGE=PAGE+1
 Q
BLOCKBRK ;writes a line to the report with the block name
 I $Y>(IOSL-3) W @IOF D HDR
 W !!,"BLOCK:  ",$P($G(^IBE(357.1,IBBLK,0)),"^")
 Q
FOOTER ;
 N FTR S FTR="END OF REPORT"
 W !!!,?((IOM-$L(FTR))\2),FTR,@IOF
 Q
FIELD ;displays the field (if list, displays all, if record, displays subfields)
  N LASTITEM,RTN,LABEL,XLAB,YLAB,XIO,YIO,WIO,HIO,BLK,ITEM,PIECE,SPACING,DISPLAY,VALUE,FLDNAME,RTN,LIST,IFARY
 ;
 Q:'$$FLDDESCR^IBDFU1A(FIELD)  ;gets the field description
 D RTNDSCR^IBDFU1B(.RTN) ;get the rtn used by the field
 S IFARY=RTN("DATA_LOCATION")
 W !
 I RTN("DATATYPE")=5 D TXTPRINT Q  ;wordprocessing fields treated differently
 ;now do other than wordprocessing
 S LIST=$S((RTN("DATATYPE")=3)!(RTN("DATATYPE")=4):1,1:0)
 I LIST,TYPE="CURRENT" S ITEM=$G(@IBARRAY("OVERFLOW")@(IBBLK,FIELD,TYPE))
 I TYPE="NEXT",LIST D
 .I $Y>(IOSL-5) W @IOF D HDR
 .S ITEM=1 W !,?5,"**** LIST OF ",$E(RTN("NAME"),$F(RTN("NAME")," "),40)," ****" F  D LISTVAL D  Q:'ITEM
 ..I VALUE'="" D SUBFLDS W !
 I TYPE="CURRENT" D
 .W !,?5,"**** ",$E(RTN("NAME"),$F(RTN("NAME")," "),40)_$S(LIST:" (#"_ITEM_")",1:"")_" ****"
 .I 'LIST D SNGLVAL
 .I LIST D LISTVAL
 .D SUBFLDS
 Q
SUBFLDS ;process each subfield
 N LAST,PVALUE
 S LAST=$$SFLDDSCR^IBDFU1A(FIELD,0) Q:'LAST
 F  D  S LAST=$$SFLDDSCR^IBDFU1A(FIELD,LAST) Q:'LAST
 .I RTN("DATATYPE")=1!(RTN("DATATYPE")=3) S PIECE=1
 .S PVALUE=$P($G(VALUE),"^",PIECE)
 .;don't use the label appearing on the encounter form - it might be 'context sensitive' - use description form package interface file
 .S LABEL=$$DATANAME^IBDFU1B(RTN,PIECE)
 .I $Y>(IOSL-3) W @IOF D HDR
 .W !,?5,LABEL_": ",PVALUE
 Q
 ;
LIST ;displays the list
 N RTN,LABEL,ITEM,PIECE,VALUE,LIST,IFARY,CNT
 ;
 S LIST=FIELD
 Q:$$LSTDESCR^IBDFU1(.LIST)  ;gets the list description
 S RTN=LIST("RTN")
 D RTNDSCR^IBDFU1B(.RTN) ;get the PACKAGE INTERFACE used
 S IFARY=RTN("DATA_LOCATION")
 W !
 ;
 D
 .S CNT=0
 .I $Y>(IOSL-5) W @IOF D HDR
 .S ITEM=1 W !,?5,"**** LIST OF ",$E(RTN("NAME"),$F(RTN("NAME")," "),40)," ****" F  D LISTVAL D  Q:'ITEM
 ..; -- file overflow data if not re-printing & there is a form ID
 ..I '$G(REPRINT),($G(LIST("INPUT_RTN"))]""),$G(IBPFID) D
 ...S CNT=CNT+1
 ...S DIC="^IBD(357.96,IBPFID,2,",DIC(0)="L",DIC("P")=$P(^DD(357.96,2,0),"^",2),DA(1)=IBPFID,X=CNT,DLAYGO=357.96
 ...S DIC("DR")=".03////^S X=LIST(""INPUT_RTN"");.04////^S X=$P(VALUE,""^"");.06////^S X=""S""_LIST_""("";.08////^S X=$P(VALUE,""^"",2)"
 ...K DD,DO D FILE^DICN K DIC,DA,DLAYGO,DD,DO
 ..I VALUE'="" D SUBCOLS W !
 Q
SUBCOLS ;process each subcolumn
 N PVALUE,SUB,PIECE
 F SUB=1:1:6 D
 .Q:(LIST("SCTYPE",SUB)'=1)
 .Q:'LIST("SCPIECE",SUB)
 .S PIECE=LIST("SCPIECE",SUB)
 .S PVALUE=$P($G(VALUE),"^",PIECE)
 .;don't use the label appearing on the encounter form - it might be 'context sensitive' - use description form package interface file
 .S LABEL=$$DATANAME^IBDFU1B(RTN,PIECE)
 .I $Y>(IOSL-3) W @IOF D HDR
 .W !,?5,LABEL_": ",PVALUE
 Q
 ;
SNGLVAL ;output - VALUE
 S VALUE=$G(@IFARY)
 Q
LISTVAL ;input - ITEM=prior item processes, output - VALUE,ITEM=current item processed
 ;
 S VALUE=$S(ITEM:$G(@IFARY@(ITEM)),1:"")
 ;increment ITEM to next item
 S ITEM=$O(@IFARY@(ITEM))
 Q
TXTPRINT ;for printing a word-processing field
 N LINE,X,DIWL,DIWR,DIWF,LABEL
 S LINE=0,DIWR=IOM-10,DIWL=0,DIWF=""
 K ^UTILITY($J,"W",1)
 F  S LINE=$O(@IFARY@(LINE)) Q:'LINE  S X=$G(@IFARY@(LINE,0)) I X'="" D ^DIWP
 S LABEL=$E(RTN("NAME"),$F(RTN("NAME")," "),40)
 I $Y>(IOSL-5) W @IOF D HDR
 W !,?5,LABEL_": "
 S X=0 F  S X=$O(^UTILITY($J,"W",0,X)) Q:'X  D
 .I $Y>(IOSL-3) W @IOF D HDR
 .W !,?10,$G(^UTILITY($J,"W",0,X,0))
 K ^UTILITY($J,"W",1)
 Q
