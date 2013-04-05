LR7OV5 ;DALOI/JMC - Lab XPAR Parameter Utility;02/28/12  20:44
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;
LISTPAR ; List user-level values for a parameter
 ;
 N DIR,DIRUT,DDTOUT,UOUT,LN,LRENTITY,LRERR,LROUT,LRPAR,LRREF,LRXPAR,LRXPARLIST
 ;
 ; Select a parameter to display
 F  D  Q:LRXPAR<0!(LRXPAR>0)
 . K LRXPAR
 . D GETPAR^XPAREDIT(.LRXPAR)
 . I $E($P(LRXPAR,"^",2),1,2)?1(1"LR",1"LA") Q
 . I LRXPAR>0 W !!,"*** Please select a PARAMETER within the Laboratory Namespace (LA/LR) ***" S LRXPAR=0
 . E  S LRXPAR=-1
 I LRXPAR<1 Q
 ;
 ; Return all parameter instances
 D ENVAL^XPAR(.LRXPARLIST,+LRXPAR,"",.LRERR)
 I LRERR W !,"Error encountered: "_LRERR Q
 ;
 ; Build list of entities allowed for this parameter
 D BLDLST^XPAREDIT(.LRPAR,+LRXPAR)
 ;
 W !!,"Values for "_$P(LRXPAR,"^",2),!
 D HEADER
 ;
 S LRREF="",LN=1
 F  S LRREF=$O(LRXPARLIST(LRREF)) Q:LRREF=""  D  Q:$D(DIRUT)
 . I $P(LRREF,";",2)'="VA(200," Q
 . D ENTITY
 . K LROUT
 . D GETLST^XPAR(.LROUT,LRREF,+LRXPAR,"N",.LRERR)
 . S LROUT=""
 . F  S LROUT=$O(LROUT(LROUT)) Q:LROUT=""  D  Q:$D(DIRUT)
 . . D WAIT Q:$D(DIRUT)
 . . W !,$E(LRENTITY,1,30)
 . . W ?31,$E(LROUT,1,20),?52,$E($P(LROUT(LROUT),"^",2),1,28)
 ;
 I '$D(DIRUT) S DIR("A")="Enter RETURN to continue",DIR(0)="E" D ^DIR
 ;
 Q
 ;
 ;
 ;
ENTITY ; Resolve entity
 ;
 S LRENTITY=""
 I $P(LRREF,";",2)="VA(200," S LRENTITY="USR: "_$$NAME^XUSER(+LRREF,"F") Q
 I $P(LRREF,";",2)="DIC(9.4," S LRENTITY="PKG: "_$$GET1^DIQ(9.4,+LRREF_",",.01) Q
 I $P(LRREF,";",2)="DIC(4," S LRENTITY="DIV: "_$P($$NS^XUAF4(+LRREF),"^") Q
 ;
 I $P(LRREF,";",2)="DIC(4.2," D  Q
 . N X
 . S X=$G(LRPAR("P","SYS"))
 . I X,$P(LRPAR(X),"^",6)'="" S LRENTITY="SYS: "_$P(LRPAR(X),"^",6) Q
 . S LRENTITY="SYS: "_LRREF Q
 ;
 I $P(LRREF,";",2)="DIC(49," S LRENTITY="SRV: "_$$GET1^DIQ(49,+LRREF_",",.01) Q
 I $P(LRREF,";",2)="SC(" S LRENTITY="LOC: "_$$GET1^DIQ(44,+LRREF_",",.01) Q
 ;
 I $P(LRREF,";",2)="SCTM(404.51," S LRENTITY="TEA: "_LRREF Q
 I $P(LRREF,";",2)="USR(8930," S LRENTITY="CLS: "_LRREF Q
 I $P(LRREF,";",2)="DG(405.4," S LRENTITY="BED: "_LRREF Q
 I $P(LRREF,";",2)="OR(100.21," S LRENTITY="OTL: "_LRREF Q
 ;
 ; Default value if not handled.
 S LRENTITY=LRREF
 Q
 ;
 ;
WAIT ; pause display
 ;
 ;
 S LN=LN+1
 I LN>(IOSL-4) S DIR(0)="E" D ^DIR W !! D:'$D(DIRUT) HEADER S LN=0
 Q
 ;
 ;
HEADER ;
 W !,"Parameter",?31,"Instance",?52,"Value",!
 W $$REPEAT^XLFSTR("-",IOM-4),!
 Q
