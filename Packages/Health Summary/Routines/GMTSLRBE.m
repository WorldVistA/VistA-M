GMTSLRBE ; SLC/JER,KER - Blood Availability Extract ; 08/27/2002
 ;;2.7;Health Summary;**17,28,56**;Oct 20, 1995
 ;
 ;                     
 ; External References
 ;   DBIA 10090  ^DIC(4
 ;   DBIA   528  ^LAB(66
 ;   DBIA   525  ^LR(
 ;   DBIA   527  ^LRD(65
 ;   DBIA 10015  EN^DIQ1 (file #65)
 ;                     
XTRCT ; Extract Blood Availability
 N I1,UN,CNT S CNT=0 K ^TMP("LRB",$J)
 I $L($P(^LR(LRDFN,0),U,5,6)) S ^TMP("LRB",$J,0)=$P(^(0),U,5)_U_$P(^(0),U,6)
 S UN="" F  S UN=$O(^LRD(65,"AP",LRDFN,UN)) Q:UN=""!(CNT'<MAX)  D BASET
 Q
BASET ; Sets ^TMP("LRB",$J, with data elements
 N ADT,DA,DIC,DIQ,DON,DR,EFLG,EDT,UID,UDIV,DTYP,COMP,ABO,RH,VOL,XDT,XMR,XMATCH
 N IDT,GMI,ULOC
 S (ADT,EFLG,EDT,UID,DTYP,COMP,ABO,RH,VOL,XMR,ULOC)=""
 S UID=$P(^LRD(65,UN,0),U),EDT=$P(^(0),U,6),ABO=$P(^(0),U,7),RH=$P(^(0),U,8),VOL=$P(^(0),U,11),COMP=$P(^LAB(66,$P(^LRD(65,UN,0),U,4),0),U)
 S ADT=$P(^LRD(65,UN,2,LRDFN,0),U,2)
 S UDIV=$P(^LRD(65,UN,0),U,16),UDIV=$S(UDIV'="":$P(^DIC(4,UDIV,0),U),1:UDIV) ;Gets division unit is located at
 I $D(^LRD(65,UN,8)) S DIC=65,DIQ="DON",DIQ(0)="E",DR=8.3,DA=UN D EN^DIQ1 S:$D(DON) DTYP=DON(65,UN,8.3,"E")
 S GMI=$O(^LRD(65,UN,3,0)) I +GMI>0 D
 . S ULOC=$P($G(^LRD(65,UN,3,GMI,0)),U,4)
 ;   If unit will expire w/in 48 hrs, flag with "*"
 ;                       w/in 24 hrs, flag with "**"
 I EDT>DT S EFLG=$S(EDT-DT<2:"*",EDT-DT<1:"**",1:"")
 S IDT=9999999-ADT
 I $S(IDT<GMTS1:1,IDT>GMTS2:1,EDT<DT:1,1:0) Q
 S X=EDT D REGDT4^GMTSU S EDT=X K X
 F  Q:'$D(^TMP("LRB",$J,IDT))  S IDT=IDT+.0001
 S ^TMP("LRB",$J,IDT)=EFLG_U_EDT_U_UID_U_COMP_U_VOL_U_ABO_U_RH_U_DTYP_U_UDIV_U_ULOC
 S CNT=CNT+1
 Q
