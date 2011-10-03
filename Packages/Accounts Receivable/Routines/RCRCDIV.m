RCRCDIV ;ALB/CMS-RC REFERRAL DIVISION UTILITY PROGRAM ; 16-JUN-00
V ;;4.5;Accounts Receivable;**159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
RCDIV(ARRAY) ;Get array of divisions and Remote Address
 ;Returns ARRAY(0)=Number of divisions^Primary 40.8 ien
 ;        ARRAY(40.8#IEN)="P" for Primary (default) or null^Domain Name
 ;                       =^Inst. file#^Inst. name^Station #
 ;        or:  ARRAY(0) Not Definded
 ;
 N CNT,RCA,RCS,RCX,RCY
 S CNT=0,RCX=$O(^RCT(349.1,"B","RC",0))
 I ('RCX)!('$O(^RCT(349.1,+RCX,6,0))) G RCDIVQ
 ;S RCS=$$SITE^VASITE,RCY=$P(RCS,U,2),RCY=$O(^DG(40.8,"B",RCY,0))
 ;S RCS=$$SITE^VASITE S RCY=$P(RCS,U,2) S RCY=$O(^DG(40.8,"B",RCY,0))
 S RCS=$$SITE^VASITE S RCY=$P(RCS,U,1) S RCY=$O(^DG(40.8,"AD",RCY,0))
 I 'RCY G RCDIVQ
 ;S ARRAY(RCY)="P^"_$P($G(^RCT(349.1,+RCX,3)),U,3)_"^"_RCS
 S ARRAY(RCY)="P^"_$P($G(^RCT(349.1,+RCX,3)),U,3)_"^"_RCS_"^"_$P($G(^RCT(349.1,+RCX,3)),U,4)_"^"_$P($G(^RCT(349.1,+RCX,3)),U,5)
 S $P(ARRAY(0),U,2)=RCY,CNT=CNT+1
 S RCY=0 F  S RCY=$O(^RCT(349.1,+RCX,6,RCY)) Q:'RCY  D
 .S RCA=$G(^RCT(349.1,+RCX,6,RCY,0))
 .I $D(ARRAY(+RCA)) Q
 .;S ARRAY(+RCA)="^"_$P($G(^DIC(4.2,+$P(RCA,U,2),0)),U,1)_"^"_$$SITE^VASITE(,+RCA)
 .S ARRAY(+RCA)="^"_$P($G(^DIC(4.2,+$P(RCA,U,2),0)),U,1)_"^"_$$SITE^VASITE(,+RCA)_"^"_$P(RCA,"^",3)_"^"_$P(RCA,"^",4)
 .I $P(ARRAY(+RCA),"^",3)=-1 K ARRAY(+RCA)
 .S CNT=CNT+1
 S $P(ARRAY(0),U,1)=CNT
 ; If only site in multiple is same as primary kill RCDIV
 I CNT=1 K RCDIV
RCDIVQ Q
 ; 
DIVS ;Select division if multi-site
 ; - Use RCDIV^RCRCDIV(.RCDIV) to set RCDIV(0)
 ;
 K ^TMP("RCDOMAIN",$J)
 N CNT,DIR,RCDOMAIN,RCI,RCS,RCX,TCNT,X,Y
 I '$O(RCDIV(0)) G DIVSQ
 S (CNT,RCX)=0,RCS="" K DIR
 F  S RCX=$O(RCDIV(RCX)) Q:'RCX  D
 .S CNT=CNT+1
 .S DIR("A",CNT)=CNT_".   "_$P(RCDIV(RCX),U,5)_"  "_$P(RCDIV(RCX),U,4)
 .;S RCS=RCS_CNT_":"_RCX_"  "_$P(RCDIV(RCX),U,4)_"  "_$P(RCDIV(RCX),U,2)_";"
 .;S RCS(CNT)=CNT_":"_RCX_"  "_$P(RCDIV(RCX),U,4)_"  "_$P(RCDIV(RCX),U,2)
 .S RCDIV(RCX)=RCDIV(RCX)_"^"_CNT
 .I $P(RCDIV(RCX),U,1)="P" S DIR("B")=CNT
 S TCNT=CNT,CNT=CNT+1,DIR("A",CNT)=" "
 S CNT=CNT+1,DIR("A",CNT)=" "
 S DIR("A")=" Enter a number: "
 W !!,"Medical Center Division to include in Build List"
 W !," Select one of the following:         (Required)",!
 S DIR(0)="NO^1:"_TCNT
 ;S DIR(0)="SAXB^"_RCS
 D ^DIR W !
 I $E(Y)="^" S RCOUT=1 G DIVSQ
 S RCI=0 F  S RCI=$O(RCDIV(RCI)) Q:'RCI  I $P(RCDIV(+RCI),"^",8)'=Y K RCDIV(RCI)
 S $P(RCDIV(0),U,3)=$O(RCDIV(0))
 S $P(^TMP("RCDOMAIN",$J,0),U,3)=$O(RCDIV(0))
 S ^TMP("RCDOMAIN",$J,$P(RCDIV(0),U,3))=RCDIV($P(RCDIV(0),U,3))
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G DIVSQ
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
DIVSQ Q
 ;
DIV(PRCABN) ;Check bill # to see if same as selected division
 ;  Returns 1 if same as selected divison 0 if not
 ;  RCDIV(0) must be defined before calling
 N RCX S RCX=0
 I '$G(RCDIV(0)) G DIVQ
 I $P($G(RCDIV(0)),U,3)=$$DIV^IBJDF2(PRCABN) S RCX=1
DIVQ Q RCX
 ;
 ;RCRCDIV
