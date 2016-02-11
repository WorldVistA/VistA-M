GMRCEDT4 ;SLC/DCM,JFR - UTILITIES FOR EDITING FIELDS ;10/13/15  07:31
 ;;3.0;CONSULT/REQUEST TRACKING;**1,5,12,15,22,33,66,73,85**;DEC 27, 1997;Build 3
 ;
 ; This routine invokes IA #5747 (ICDEX), #872 (ORD(101)), #10142 (DDIOL), #10006 (DIC)
 ;                         #2051 (FIND1^DIC), #2056 (GET1^DIQ), #10026 (DIR), #10028 (DIWE), #5679 (LEXU)
 ;                         #1572 (LEX(757.01), #1609 (CONFIG^LEXSET), #10103 (XLFDT), #10104 (XLFSTR), #10140 (XQORM)
 ;
 Q
EDITFLD(GMRCO)    ;edit field in file 123.
 ;GMRCO=IEN of consult record in file 123
 N DIR,X,Y,GMRCSS,GMRCPROC,GMRCPROC,GMRCURG,GMRCPL,GMRCREND,GMRCY,GMRCX
 N GMRCMSG,GMRCTAG
 I $S($P(^GMR(123,GMRCO,0),"^",12)'=13:1,$D(GMRCRSUB):1,1:0) D  Q
 .S GMRCMSG="This consult is no longer editable." D EXAC^GMRCADC(GMRCMSG)
 S GMRCMSG=$$EDRESOK^GMRCEDT2(GMRCO)
 I '+GMRCMSG D EXAC^GMRCADC($P(GMRCMSG,U,2)) Q
 ;patch 85 removed call to $$PDOK(GMRCO)
 S DIR(0)="LAO^1:9",DIR("A")="Select the fields to edit: "
 D ^DIR I $D(DIRUT) Q
 I $P(Y,",")<1 Q
 S GMRCY=Y
 F GMRCX=1:1:9 S GMRCTAG=$P(GMRCY,",",GMRCX) Q:'GMRCTAG  D
 . D SETUP
 . D @GMRCTAG
 . K DIROUT,DIRUT,DTOUT,DUOUT
 . D EN^GMRCEDT1(+GMRCO),INIT^GMRCEDIT
 Q
SETUP   ;get info needed for edit (save global reads)
 S:$D(GMRCEDT(1)) GMRCSS=GMRCEDT(1)
 I '$D(GMRCSS) S GMRCSS=$P(^GMR(123,+GMRCO,0),U,5),GMRCSS=GMRCSS_U_$P(^GMR(123.5,GMRCSS,0),U)
 S:$D(GMRCED(1)) GMRCPROC=GMRCED(1)
 I '$D(GMRCPROC) S GMRCPROC=+$P(^GMR(123,+GMRCO,0),U,8),GMRCPROC=GMRCPROC_U_$$GET1^DIQ(123.3,+GMRCPROC,.01)
 S:$D(GMRCED(2)) GMRCREND=GMRCED(2)
 I '$D(GMRCREND) S GMRCREND=$P(^GMR(123,GMRCO,0),U,18),GMRCREND=GMRCREND_U_$S(GMRCREND="I":"In",1:"Out")_"patient"
 S:$D(GMRCED(3)) GMRCURG=GMRCED(3)
 I '$D(GMRCURG) S GMRCURG=$P(^GMR(123,+GMRCO,0),U,9),GMRCURG=GMRCURG_U_$$GET1^DIQ(101,+GMRCURG,1)
 S:$D(GMRCED(4)) GMRCPL=GMRCED(4)
 I '$D(GMRCPL) S GMRCPL=$P(^GMR(123,+GMRCO,0),U,10),GMRCPL=GMRCPL_U_$$GET1^DIQ(101,+GMRCPL,1)
 Q
01       ;edit TO SERVICE
 N I,PROCSERV,DIR,X,Y
 I $G(GMRCPROC) D  Q:'PROCSERV
 . N I S I=0,PROCSERV=0 F  S I=$O(^GMR(123.3,+GMRCPROC,2,"B",I)) Q:'I  D
 .. S PROCSERV(I)="",PROCSERV=PROCSERV+1
 . I PROCSERV=1 W !,"Only one SERVICE can perform this procedure.",!
 S DIR(0)="PA^123.5:EMQ"
 I $G(PROCSERV) D
 . I $D(PROCSERV(+GMRCSS)) Q
 . S DIR("B")=$$GET1^DIQ(123.5,$O(PROCSERV(0)),.01)
 I '$D(DIR("B")) S DIR("B")=$P(GMRCSS,U,2)
 S DIR("A")="Select the Service to perform this request: "
 S DIR("S")="I $P(^(0),U,2)<1" ;naked reference for ^GMR(123.5
 I +$G(GMRCPROC) S DIR("S")=DIR("S")_",$D(PROCSERV(+Y))"
 S DIR("??")="^D LISTALL^GMRCASV"
 D ^DIR I $D(DUOUT)!($D(DTOUT)) Q
 I Y<1!(+Y=+GMRCSS) W !,$$NOCHG,! Q
 S GMRCEDT(1)=Y,GMRCSS=Y
 Q
1 ;edit Procedure
 W !,$C(7),"The procedure associated with a request may not be changed."
 W !,"Place a new request if a different procedure is desired"
 H 2
 Q
2       ;edit service rendered
 N DIR,X,Y,GMRCURSV,GMRCPLSV,GMRCED4,GMRCED5,RENDED
 S DIR(0)="S:A^I:Inpatient;O:Outpatient",DIR("B")=$P(GMRCREND,U,2)
 S DIR("A")="Service to be performed Inpatient or Outpatient: "
 D ^DIR I $D(DUOUT)!($D(DTOUT)) W !,$$NOCHG,! Q
 I Y'=$P(GMRCREND,U) S RENDED=Y_U_Y(0)
 I '$D(RENDED) Q
 I '$$VALIDUR(GMRCURG,RENDED,+$G(GMRCPROC)) D  I '$D(RENDED) Q
 . N GMRCREND,CHGIO S GMRCREND=RENDED
 . W $C(7),!!,"The urgency of this request is no longer valid.",!
 . S GMRCURSV=GMRCURG S:$D(GMRCED(3)) GMRCED3=GMRCED(3)
 . S CHGREND="" D 3
 . I '$$VALIDUR(GMRCURG,RENDED,+$G(GMRCPROC)) D  Q
 .. W !,$C(7),"Unable to change the way service is rendered.",!
 .. K RENDED S GMRCURG=GMRCURSV S:$D(GMRCED3) GMRCED(3)=GMRCED3
 I '$$VALIDPL(GMRCPL,RENDED) D  I '$D(RENDED) Q
 . N GMRCREND,CHGREND S GMRCREND=RENDED
 . W $C(7),!!,"The Place of Consultation is no longer valid.",!
 . S GMRCPLSV=GMRCPL S:$D(GMRCED(4)) GMRCED4=GMRCED(4) S CHGREND="" D 4
 . I '$$VALIDPL(GMRCPL,RENDED) D  Q
 .. W !,$C(7),"Unable to change the way service is rendered.",!
 .. K RENDED S GMRCPL=GMRCPLSV S:$D(GMRCED4) GMRCED(4)=GMRCED4
 .. S:$D(GMRCURSV) GMRCURG=GMRCURSV
 .. S:$D(GMRCED3) GMRCED(3)=GMRCED3
 S (GMRCREND,GMRCED(2))=RENDED
 Q
3 ;edit urgency
 N X,Y,XQORM
 I $P(GMRCREND,U)="O" S Y=$$FIND1^DIC(101,"","QX","GMRCURGENCYM - OUTPATIENT")
 I '$D(Y) D  ;inpatient
 .I '$G(GMRCPROC) S Y=$$FIND1^DIC(101,"","QX","GMRCURGENCYM CSLT - INPATIENT") Q
 .S Y=$$FIND1^DIC(101,"","QX","GMRCURGENCYM REQ - INPATIENT")
 I 'Y W !,$C(7),"Unable to change urgency." Q
 S XQORM=+Y_";ORD(101,",XQORM(0)="1A\",XQORM("A")="Urgency: "
 S XQORM("^^NO")=0
 S:'$D(CHGREND) XQORM("B")=$P($G(GMRCURG),U,2)
 D EN^XQORM
 Q:Y'>0
 I $P(Y(1),U,2)'=+GMRCURG D
 . S GMRCED(3)=$P(Y(1),U,2)_U_$P(Y(1),U,3),GMRCURG=GMRCED(3)
 Q
4 ;edit place of CSLT
 N X,Y,XQORM
 S Y=$$FIND1^DIC(101,,"QX","GMRCPLACEM - "_$$UP^XLFSTR($P(GMRCREND,U,2))) Q:'Y
 S XQORM=Y_";ORD(101,"
 S XQORM(0)="1AR\",XQORM("A")="Place of Consultation: ",XQORM("NO^^")=""
 S:'$D(CHGREND) XQORM("B")=$P($G(GMRCPL),U,2)
 D EN^XQORM
 Q:Y'>0
 I $P(Y(1),U,2)'=+GMRCPL D
 . S GMRCED(4)=$P(Y(1),U,2)_U_$P(Y(1),U,3),GMRCPL=GMRCED(4)
 Q
5 ;edit Earliest Appr. Date wat/66
 N X,Y,DIR
 S DIR(0)="D^^K:Y<DT X",DIR("A")="Earliest Appropriate Date: " ;S DIR(0)="D^DT:GMRCFTDT:EX"
 S DIR("?")="Enter a date greater than or equal to TODAY"
 S DIR("B")=$$FMTE^XLFDT(DT)
 D ^DIR I $D(DTOUT)!($D(DUOUT)) Q
 S GMRCED(5)=Y_U_Y(0)
 Q
6 ;edit ATTN person
 N X,Y,DIR
 S DIR(0)="PAO^200:EQM",DIR("A")="Select ATTENTION person: "
 S DIR("B")=$$GET1^DIQ(200,+$P(^GMR(123,+GMRCO,0),U,11),.01)
 S:$D(GMRCED(6)) DIR("B")=$P($G(GMRCED(6)),U,2)
 K:'$L(DIR("B")) DIR("B")
 D ^DIR I $D(DTOUT)!($D(DUOUT)) Q
 I $G(DIR("B"))=$P(Y,U,2) Q
 S GMRCED(6)=$S(Y=-1:"",1:Y)
 I GMRCED(6)="" W !,?5,"<DELETED>",!
 Q
7 ;edit prov. DX
 N X,Y,DIC,DIR,PRMPT
 S PRMPT=$$PROVDX^GMRCUTL1(+$P(^GMR(123,+GMRCO,0),U,5))
 I $P(PRMPT,U,2)="F" D
 . S DIR(0)="FA^2:245",DIR("A")="Provisional Diagnosis: "
 . I $P(PRMPT,U)'="R" S $P(DIR(0),U)="FAO"
 . S:$D(GMRCED(7)) DIR("B")=$P(GMRCED(7),U)
 . I '$D(DIR("B")) S DIR("B")=$G(^GMR(123,+GMRCO,30))
 . K:'$L(DIR("B")) DIR("B")
 . D ^DIR Q:$D(DTOUT)!($D(DUOUT))  Q:Y=$G(DIR("B"))
 . I '$L(Y) W !,?5,"<DELETED>",!
 . S GMRCED(7)=Y
 I $P(PRMPT,U,2)="L" D
 . N DIR,X,Y,DTOUT,DUOUT,VAL
 . I $D(GMRCED(7)) D
 .. I '$L($P(GMRCED(7),U,2)) S DIR("B")=$P(GMRCED(7),U) Q
 .. S DIR("B")=$P(GMRCED(7),U)_" ("_$P(GMRCED(7),U,2)_")"
 . I '$D(DIR("B")) S DIR("B")=$G(^GMR(123,GMRCO,30))
 . K:'$L(DIR("B")) DIR("B")
 . S DIR("?")="Enter a code or term for the provisional diagnosis."
 . S DIR("A")="Provisional Diagnosis: "
 . S DIR(0)="FA"_$S($P(PRMPT,U)'="R":"O",1:"")_"^1:245"
 . D ^DIR
 . I $D(DTOUT)!($D(DUOUT)) Q
 . I '$L(Y) W !,?5,"<DELETED>",! S GMRCED(7)="" Q
 . I Y=$G(DIR("B")) Q
 . I $E(Y,1)=" " W !,"Leading space not allowed, no change." Q
 . S VAL=$$LEXLKUP(Y)
 . I '$L(VAL),$P(PRMPT,U)="R" W !,"Prov. DX required. No change." Q
 . I VAL=$G(^GMR(123,GMRCO,30)) W !,"No change." Q
 . I ($P(VAL,U)_" ("_$P(VAL,U,2)_")")=$G(^GMR(123,GMRCO,30)) D  Q
 .. W !,"No change."
 . I '$L(VAL) W !,?5,"<DELETED>",!
 . S GMRCED(7)=VAL
 Q
 ;
LEXLKUP(GMRCX)  ; run input through the Lexicon
 ;
 N DIC,X,Y,DUOUT,DTOUT,GMRCSYS
 S GMRCSYS="ICD" I DT>=$$IMPDATE^LEXU("10D") S GMRCSYS="10D"
 D CONFIG^LEXSET(GMRCSYS,GMRCSYS,DT)
 S DIC="^LEX(757.01,",DIC(0)="EQM",DIC("B")=GMRCX,X=GMRCX
 D ^DIC
 I $D(DTOUT)!($D(DUOUT))!($G(Y)<1) Q ""
 Q $P(Y,U,2)_U_$S(GMRCSYS="ICD":$G(Y(1)),1:$G(Y(30)))
 ;
8 ;edit Reason for Request
 N DIC,DIWESUB,DWLW,DWPK
 I $D(^TMP("GMRCED",$J,20)) M ^TMP("GMRCEDSV",$J,20)=^TMP("GMRCED",$J,20)
 I '$D(^TMP("GMRCED",$J,20)) M ^TMP("GMRCED",$J,20)=^GMR(123,+GMRCO,20)
 S DIC="^TMP(""GMRCED"",$J,20,",DIWESUB="Reason for Request"
 W !,"Editing Reason for Request:",!
 S DWPK=1,DWLW=74 D EN^DIWE
 I '$$DIFFRFR($D(^TMP("GMRCEDSV",$J,20))) D  Q
 . I $D(^TMP("GMRCEDSV",$J,20)) K ^TMP("GMRCEDSV",$J,20) Q
 . K ^TMP("GMRCED",$J,20)
 K ^TMP("GMRCEDSV",$J,20)
 I '$D(^TMP("GMRCED",$J,20))!('$O(^TMP("GMRCED",$J,20,0))) D
 . N GMRCMSG
 . S GMRCMSG="Unable to delete Reason for Request (REQUIRED)"
 . D EXAC^GMRCADC(GMRCMSG)
 . K ^TMP("GMRCED",$J,20)
 Q
9 ;add comment
 N DIC,DIWEPSE,DIWESUB,DWLW,DWPK
 I $D(^TMP("GMRCED",$J,40)) D
 . W !,"An unsaved comment exists. You may edit this comment.",!
 . S DIWEPSE=1
 S DIC="^TMP(""GMRCED"",$J,40,",DIWESUB="New Comment"
 W !,"Adding new comment:",!
 S DWPK=1,DWLW=74 D EN^DIWE
 I '$O(^TMP("GMRCED",$J,40,0)) K ^TMP("GMRCED",$J,40)
 Q
DIFFRFR(SAVED) ;edited reason for req same as original?
 N I,DIFF
 I SAVED,$P($G(^TMP("GMRCED",$J,20,0)),U,3,4)'=$P($G(^TMP("GMRCEDSV",$J,20,0)),U,3,4) S DIFF=1 Q 1
 I 'SAVED,$P($G(^TMP("GMRCED",$J,20,0)),U,3,4)'=$P($G(^GMR(123,+GMRCO,20,0)),U,3,4) S DIFF=1 Q 1
 I SAVED S I=0 F  S I=$O(^TMP("GMRCED",$J,20,I)) Q:'I!($D(DIFF))  D
 . I ^TMP("GMRCED",$J,20,I,0)=$G(^TMP("GMRCEDSV",$J,20,I,0)) Q
 . S DIFF=1
 . Q
 I 'SAVED S I=0 F  S I=$O(^TMP("GMRCED",$J,20,I)) Q:'I!($D(DIFF))  D
 . I ^TMP("GMRCED",$J,20,I,0)'=$G(^GMR(123,+GMRCO,20,I,0)) S DIFF=1
 . Q
 Q $G(DIFF)
VALIDPL(PL,REND) ; place still valid?
 N PLMENU
 S PLMENU=$S($P(REND,U)="I":"IN",1:"OUT")
 S PLMENU="GMRCPLACEM - "_PLMENU_"PATIENT"
 S PLMENU=$$FIND1^DIC(101,,"QX",PLMENU) Q:PLMENU'>1 0
 Q $D(^ORD(101,PLMENU,10,"B",+PL))
VALIDUR(URG,REND,PROC) ;urgency still valid?
 N URMENU
 I $P(REND,U)="I" D
 .I 'PROC S URMENU="GMRCURGENCYM CSLT - INPATIENT" Q
 .S URMENU="GMRCURGENCYM REQ - INPATIENT" Q
 I '$D(URMENU) S URMENU="GMRCURGENCYM - OUTPATIENT"
 S URMENU=$$FIND1^DIC(101,,"QX",URMENU) Q:URMENU<0 0
 Q $D(^ORD(101,URMENU,10,"B",+URG))
 Q
NOCHG() ;no changes made
 Q "No Changes made!"
PDOK(GMRCDA) ;check validity of Prov. DX code for active status
 ;WAT - as of patch 85 this code no longer called. Leaving here in case biz needs change.
 N MSG,GMRCCPTR,GMRCCSYS,GMRCCODE
 I '$L($G(^GMR(123,GMRCDA,30.1))) Q 1
 S GMRCCODE=$P($G(^GMR(123,+GMRCO,30.1)),"^",1)
 S GMRCCSYS=$P($G(^GMR(123,+GMRCO,30.1)),"^",3)
 S GMRCCPTR=$S(GMRCCSYS="ICD":1,1:30)
 I +$$STATCHK^ICDEX(GMRCCODE,DT,GMRCCPTR) Q 1 ;code still active
 S MSG="The provisional DX code must be edited before this request"
 S MSG=MSG_" may be resubmitted."
 D EN^DDIOL(MSG,,"!!")
 Q 0
