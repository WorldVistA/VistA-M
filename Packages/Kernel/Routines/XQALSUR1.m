XQALSUR1 ;ISC-SF.SEA/JLI - SURROGATES FOR ALERTS ; Jul 13, 2021@11:01
 ;;8.0;KERNEL;**366,443,602,730,754**;Jul 10, 1995;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified
 Q
RETURN(XQAUSER) ; P366 - return alerts to the user
 N XQAI,X0,XQASTRT,XQASURO,XQAEND
 ; identify periods in the surrogate multiple that haven't been returned
 F XQAI=0:0 S XQAI=$O(^XTV(8992,XQAUSER,2,"AC",1,XQAI)) Q:XQAI'>0  D
 . I '$D(^XTV(8992,XQAUSER,2,XQAI,0)) K ^XTV(8992,XQAUSER,2,"AC",1,XQAI) Q  ;p754 somebody removed surr by gbl kill, cleanup
 . S X0=$G(^XTV(8992,XQAUSER,2,XQAI,0)) Q:$P(X0,U,4)'=1  ; P754
 . S XQASTRT=$P(X0,U) S XQAEND=$P(X0,U,3)
 . ; and clear the flag indicating we need to restore these alerts
 . N XQAFDA S XQAFDA(8992.02,XQAI_","_XQAUSER_",",.04)="@" D FILE^DIE("","XQAFDA")
 . ; restore alerts to intended user, remove from surrogate if completed (i.e., no other surrogates and not intended recipient)
 . D PUSHBACK(XQAUSER,XQASTRT,XQAEND)
 . Q
 Q
 ;
PUSHBACK(XQAUSER,XQASTRT,XQAEND) ; P366 - identify alerts in alert tracking file for return and return them
 N XQAINIT,XQAI,X0,X30,XNOSURO,XQADT,XQAJ,XQAK,XQAL,XQAOTH,XQASUROP
 S XQAINIT=$$FIND1^DIC(8992.2,,"X","INITIAL RECIPIENT")
 F XQADT=XQASTRT-.0000001:0 S XQADT=$O(^XTV(8992.1,"AUD",XQAUSER,XQADT)) Q:XQADT'>0  Q:XQADT>XQAEND  F XQAI=0:0 S XQAI=$O(^XTV(8992.1,"AUD",XQAUSER,XQADT,XQAI)) Q:XQAI'>0  D
 . S XQAJ=$O(^XTV(8992.1,XQAI,20,"B",XQAUSER,0)) Q:XQAJ'>0
 . N XSURO,XNOSURO,XQAID S XNOSURO=0,XQAID=$P(^XTV(8992.1,XQAI,0),U)
 . F XQAK=0:0 S XQAK=$O(^XTV(8992.1,XQAI,20,XQAJ,1,"B",XQAK)) Q:XQAK'>0  F XQAL=0:0 S XQAL=$O(^XTV(8992.1,XQAI,20,XQAJ,1,"B",XQAK,XQAL)) Q:XQAL'>0  D
 . . S X0=^XTV(8992.1,XQAI,20,XQAJ,1,XQAL,0) S:$P(X0,U,2)>0 XSURO($P(X0,U,2))="" S:$P(X0,U,2)'>0 XNOSURO=1 ; sent to XSURO as surrogate
 . . Q
 . I 'XNOSURO D
 . . N XQA,XQACMNT,XQALTYPE
 . . S XQA(XQAUSER)="",XQACMNT="RESTORED FROM SURROGATE",XQALTYPE="RESTORE FROM SURROGATE"
 . . N XQAUSER,XQAI S XQAUSER=$O(^XTV(8992,"AXQA",XQAID,0)) Q:XQAUSER'>0  D RESETUP^XQALFWD(XQAID,.XQA,XQACMNT)
 . . Q
 . ; walk through each of those it was sent to as a surrogate for XQAUSER
 . F XQASUROP=0:0 S XQASUROP=$O(XSURO(XQASUROP)) Q:XQASUROP'>0  S XQAJ=$O(^XTV(8992.1,XQAI,20,"B",XQASUROP,0)) D
 . . ; and identify each time they were considered a recipient of the alert
 . . S XNOSURO=0 F XQAK=0:0 Q:XNOSURO  S XQAK=$O(^XTV(8992.1,XQAI,20,XQAJ,1,"B",XQAK)) Q:XQAK'>0  F XQAL=0:0 S XQAL=$O(^XTV(8992.1,XQAI,20,XQAJ,1,"B",XQAK,XQAL)) Q:XQAL'>0  S X0=^XTV(8992.1,XQAI,20,XQAJ,1,XQAL,0) D  Q:XNOSURO
 . . . I $P(X0,U,3)'="Y" S XNOSURO=1 Q  ; this one got it directly as a recipient as well
 . . . ; walk through the SURROGATE FOR entries for this user
 . . . F XQAOTH=0:0 S XQAOTH=$O(^XTV(8992.1,XQAI,20,XQAJ,3,XQAOTH)) Q:XQAOTH'>0  S X30=^(XQAOTH,0) D  Q:XNOSURO
 . . . . I +X30=XQAUSER S $P(^XTV(8992.1,XQAI,20,XQAJ,3,XQAOTH,0),U,3)=$$NOW^XLFDT() Q  ; mark this user as returned
 . . . . I $P(X30,U,3)'>0 S XNOSURO=1 Q  ; another surrogate hasn't been returned yet, so leave the alert
 . . . . Q
 . . . Q
 . . I 'XNOSURO D
 . . . N XQAKILL,XQAUSER,XQAI S XQAKILL=1,XQAUSER=XQASUROP D DELETE^XQALDEL
 . . . Q
 . . Q
 . Q
 Q
 ;
SUROLIST(XQAUSER,XQALIST) ; returns for XQAUSER a list of current and/or future surrogates in XQALIST
 ;  usage  D SUROLIST^XQALSUR1(DUZ,.XQALIST)
 ;
 ;  returns  XQALIST=count
 ;           XQALIST(1)=IEN2^NEWPERSON,USER2^STARTDATETIME^ENDDATETIME
 ;           XQALIST(2)=3^NAME,USER3^3050407.1227^3050406
 ;
 N XQA0,XQADATE,XQAIEN,XQAL,XQALCNT,XQALEND,XQANOW,XQASTART,XQASURO,XQAVALU
 D CHEKSUBS^XQALSUR2(XQAUSER)
 S XQALCNT=$$CURRSURO^XQALSURO(XQAUSER)
 S XQANOW=$$NOW^XLFDT(),XQALCNT=0
 S XQADATE="" F  S XQADATE=$O(^XTV(8992,XQAUSER,2,"B",XQADATE)) Q:XQADATE'>0  S XQAIEN="" F  S XQAIEN=$O(^XTV(8992,XQAUSER,2,"B",XQADATE,XQAIEN)) Q:XQAIEN'>0  D
 . S XQA0=$G(^XTV(8992,XQAUSER,2,XQAIEN,0)) Q:XQA0=""  S XQASTART=$P(XQA0,U),XQASURO=$P(XQA0,U,2),XQALEND=$P(XQA0,U,3) I XQALEND>0,XQALEND'>XQANOW Q
 . S XQALCNT=XQALCNT+1,XQAVALU=$$GET1^DIQ(200,XQASURO_",",.01),XQAL(XQALCNT)=XQASURO_U_XQAVALU_U_XQASTART_U_XQALEND
 . Q
 ; now rearrange by earliest to last
 K XQALIST S XQALIST=0
 S XQALCNT="" F  S XQALCNT=$O(XQAL(XQALCNT)) Q:XQALCNT'>0  D
 . ; if end date not specified, and start date follows, set end date to next start date
 . I $D(XQAL(XQALCNT+1)),($P(XQAL(XQALCNT),U,4)>$P(XQAL(XQALCNT+1),U,3))!($P(XQAL(XQALCNT),U,4)'>0) S $P(XQAL(XQALCNT),U,4)=$P(XQAL(XQALCNT+1),U,3)
 . S XQALIST=XQALIST+1,XQALIST(XQALIST)=XQAL(XQALCNT)
 . Q
 Q
 ;
DCYCLIC(XQALSURO,XQAUSER,XQALSTRT,XQALEND) ; code added to prevent cyclical surrogates - use dates for surrogacy
 Q $$DCYCLIC2(XQALSURO,XQAUSER,XQALSTRT,XQALEND)
 ; p754 replaced with DCYCLIC2
 ;N XQALNEXT,XQALIST,I,XQALAST
 ;I XQALSURO=XQAUSER Q "This forms a circle which leads back to this user during this period - can't do it!"
 ;S XQALNEXT=$$CURRSURO^XQALSURO(XQALSURO,XQALSTRT,XQALEND) I XQALNEXT>0 D
 ;. F I=1:1 Q:$P(XQALNEXT,U,I)=""  S XQALAST=$$DCYCLIC($P(XQALNEXT,U,I),XQAUSER,XQALSTRT,XQALEND) I XQALAST'>0 S XQALSURO=XQALAST Q
 ;. Q
 ;Q XQALSURO
 ;
DCYCLIC2(XQALSURO,XQAUSER,XQALSTRT,XQALEND) ; p754 uses overlapped dates for surrogacy
 ; XQALSURO is intended surrogate for XQAUSER but cannot be the same
 ; returns last actual surrogate (good) or the error string (cyclic)
 N I,END,GOODSURO,OVERLAP,START,SURO,SUROLIST
 I XQALSURO=XQAUSER Q "This forms a circle which leads back to this user during this period - can't do it!"
 S GOODSURO=XQALSURO
 ; but recursively check the same for surrogates of XQALSURO for
 ; SUROLIST(I)=suro^name^start^end
 D SUROLIST^XQALSURO(XQALSURO,.SUROLIST) I SUROLIST>0 D
 . F I=1:1:SUROLIST D  Q:'GOODSURO  ; quit when cyclic
 . . S SURO=$P(SUROLIST(I),U),START=$P(SUROLIST(I),U,3),END=$P(SUROLIST(I),U,4)
 . . S OVERLAP=$$OVERLAP(XQALSTRT,XQALEND,START,END) I OVERLAP>0 D
 . . . S START=$P(OVERLAP,U),END=$P(OVERLAP,U,2)
 . . . S GOODSURO=$$DCYCLIC2(SURO,XQAUSER,START,END)
 . . . I 'GOODSURO D
 . . . . S SURO=SUROLIST(I)
 . . . . S GOODSURO="Can't do it. Cyclic with existing surrogacy: "_$C(10,13)
 . . . . S GOODSURO=GOODSURO_$$GET1^DIQ(200,XQALSURO_",",.01)_" has surrogate: "_$P(SURO,U,2)_$C(10,13)
 . . . . S GOODSURO=GOODSURO_"From "_$$FMTE^XLFDT($P(SURO,U,3),"2")_" To "_$$FMTE^XLFDT($P(SURO,U,4),"2")
 Q GOODSURO ; int or string
 ;
OVERLAP(STR1,END1,STR2,END2) ; returns time intersection (overlap) p754
 ; STR1---------END1
 ;      STR2----------END2
 ;       STR    END
 N END,NOVERLAP,NOW,STR
 S NOVERLAP="^",STR1=$G(STR1),STR2=$G(STR2),END1=$G(END1),END2=$G(END2)
 S NOW=$$NOW^XLFDT
 I $G(STR1)'>0 S STR1=NOW
 I $G(STR2)'>0 S STR2=NOW
 I $G(END1)>0,END1<=STR2 Q NOVERLAP
 I $G(END2)>0,END2<=STR1 Q NOVERLAP
 S STR=$S(STR1>STR2:STR1,1:STR2),END=$S(END1>0&(END1<END2):END1,1:END2)
 Q STR_"^"_END
 ;
DATESURO(XQAUSER,XQALSTRT,XQALEND) ; returns surrogate(s) for XQAUSER in date range XQALSTRT to XQALEND, may be multiple values ^-separated
 N XQALY,XQA0,XQALIEN,XQALS
 S XQALY="" I XQALEND'>0 S XQALEND=4000101
 F XQALS=0:0 S XQALS=$O(^XTV(8992,XQAUSER,2,"B",XQALS)) Q:XQALS'>0  Q:XQALS'<XQALEND  D
 . F XQALIEN=0:0 S XQALIEN=$O(^XTV(8992,XQAUSER,2,"B",XQALS,XQALIEN)) Q:XQALIEN'>0  S XQA0=$G(^XTV(8992,XQAUSER,2,XQALIEN,0)) Q:$P(XQA0,U,3)'>XQALSTRT  S XQALY=XQALY_$S(XQALY="":"",1:U)_$P(XQA0,U,2)
 . Q
 Q XQALY
 ;
SURRO1(XQAUSER) ;
 N XQALSURO,XQALSTRT,XQALEND,XQASLIST
 D CHKREMV^XQALSURO
SURRO11 ;
 S XQALSURO=$$NEWDLG() I XQALSURO'>0 Q
 I $$CYCLIC^XQALSURO(XQALSURO,XQAUSER)'>0 W $C(7),!,$$CYCLIC^XQALSURO(XQALSURO,XQAUSER),! G SURRO11
 S XQALSTRT=+$$STRTDLG() I XQALSTRT<0 Q
 S XQALEND=+$$ENDDLG() I XQALEND<0 Q
 ; p602 check again for cyclical surrogates
 S:XQALSTRT'>0 XQALSTRT=$$NOW^XLFDT ; p754  
 I $$DCYCLIC(XQALSURO,XQAUSER,XQALSTRT,XQALEND)'>0 W $C(7),!!,$$DCYCLIC(XQALSURO,XQAUSER,XQALSTRT,XQALEND),! G SURRO11
 D SETSURO^XQALSURO(XQAUSER,XQALSURO,XQALSTRT,XQALEND)
 D DISPSUR^XQALSUR2(XQAUSER,.XQASLIST) ; p730
 G SURRO11 ;
 Q
 ;
 ; P366 - added OPTIONAL second and third arguments to permit deletion of a specific pending surrogate and start date
REMVSURO(XQAUSER,XQALSURO,XQALSTRT) ; SR - ends the currently active surrogate relationship
 I $G(XQAUSER)'>0 Q
 S XQALSURO=$G(XQALSURO),XQALSTRT=$G(XQALSTRT)
 N XQALFM,XQALXREF,XQALSTR1,XQALSUR1,XQALNOW,XQALEND,XQA0
 D CHEKSUBS^XQALSUR2(XQAUSER)
 S XQALSUR1=+$P($G(^XTV(8992,XQAUSER,0)),U,2) S:XQALSURO'>0 XQALSURO=XQALSUR1
 S XQALSTR1=$P($G(^XTV(8992,XQAUSER,0)),U,3) S:XQALSTRT'>0 XQALSTRT=XQALSTR1
 S XQALEND=$P($G(^XTV(8992,XQAUSER,0)),U,4)
 S XQALXREF=0 I XQALSTRT>0 F  S XQALXREF=$O(^XTV(8992,XQAUSER,2,"B",XQALSTRT,XQALXREF)) Q:XQALXREF'>0  I $P($G(^XTV(8992,XQAUSER,2,XQALXREF,0)),U,2)=XQALSURO D
 . S XQALEND=$P(^XTV(8992,XQAUSER,2,XQALXREF,0),U,3) D DELETENT(XQAUSER,XQALXREF,XQALSURO,XQALSTRT,XQALSUR1,XQALSTR1,XQALEND)
 . Q
 S XQALSURO=$$CURRSURO^XQALSURO(XQAUSER) ; make sure current surrogate is updated if necessary.
 D CLEANUP^XQALSUR2(XQAUSER) ;p602 clean up surrogate history (moved from SR. RETURN)
 Q
 ;
DELETENT(XQAUSER,XQALXREF,XQALSURO,XQALSTRT,XQALSUR1,XQALSTR1,XQALEND) ;
 N XQALNOW,XQALFM
 S XQAUSER=XQAUSER_",",XQALXREF=XQALXREF_","_XQAUSER
 I XQALXREF>0 D
 . S XQALNOW=$$NOW^XLFDT()
 . I XQALSTRT>XQALNOW S XQALFM(8992.02,XQALXREF,.01)=XQALNOW ; if scheduled for later, mark start as now
 . I (XQALEND>XQALNOW)!(XQALEND'>0) S XQALFM(8992.02,XQALXREF,.03)=XQALNOW ; update end time for surrogate to now
 . I XQALSTRT'>XQALNOW S XQALFM(8992.02,XQALXREF,.04)=1
 . Q
 I XQALSUR1=XQALSURO,XQALSTRT=XQALSTR1 D
 . S XQALFM(8992,XQAUSER,.02)="@"
 . S XQALFM(8992,XQAUSER,.03)="@"
 . S XQALFM(8992,XQAUSER,.04)="@"
 . Q
 I $D(XQALFM) D FILE^DIE("","XQALFM")
 ; ZEXCEPT: XTMUNIT   (EXTERNAL VALUE - INDICATING UNIT TEST BEING RUN)
 I XQALSURO>0,'$D(XTMUNIT) D
 . N XQAMESG,XMSUB,XMTEXT
 . S XQAMESG(1,0)="You have been REMOVED as a surrogate recipient for alerts for"
 . S XQAMESG(2,0)=$$GET1^DIQ(200,XQAUSER,.01,"E")_" (IEN="_$P(XQAUSER,",")_")."
 . S XMTEXT="XQAMESG(",XMSUB="Removal as surrogate recipient"
 . D SENDMESG^XQALSURO
 . Q
 Q
 ;
NEWDLG() ; new surrogate dialog
 N DIR,Y S DIR(0)="Y",DIR("A")="Do you want to SET a new surrogate recipient",DIR("?")="A surrogate will receive your alerts until they are removed as surrogate.",DIR("B")="NO"
 S Y=$$ASKDIR(.DIR) I 'Y Q 0
 ;
 S DIR(0)="P^200:AEMQ",DIR("A")="Select USER to be SURROGATE" S Y=$$ASKDIR(.DIR)  ; COS-0401-41366
 I Y>0 W "  ",$P(Y,U,2)
 Q +Y
 ;
STRTDLG() ; new surrogate start date/time dialog
 N DIR ; p754 shortened prompt
 S DIR(0)="DAO^NOW::AEFRX",DIR("A")="Enter Date/Time SURROGATE is to start: " ; BRX-1000-10427
 S DIR("A",1)="",DIR("A",2)=""
 S DIR("A",3)=" - If no date/time is entered, new alerts will start going to"
 S DIR("A",4)="   the SURROGATE immediately."
 S DIR("A",5)=" - A past date/time (earlier than NOW) is not permitted."
 S DIR("A",6)=" - A time is also required. Ex: T+1@1pm, 5/15@12am, 12/12/2021@12am"
 S DIR("A",7)=""
 Q +$$ASKDIR(.DIR)
 ;
ENDDLG() ; new surrogate end date/time dialog
 N DIR ; p754 shortened prompt
 S DIR(0)="DAO^NOW::AEFRX",DIR("A")="Enter Date/Time SURROGATE is to end: " ; BRX-1000-10427
 S DIR("A",1)="",DIR("A",2)=""
 S DIR("A",3)=" - If no date/time is entered, YOU must remove the SURROGATE"
 S DIR("A",4)="   to terminate the surrogacy."
 S DIR("A",5)=" - A past date/time (earlier than NOW) is not permitted."
 S DIR("A",6)=" - A time is also required. Ex: T+1@1pm, 5/15@12am, 12/12/2021@12am"
 S DIR("A",7)=""
 Q +$$ASKDIR(.DIR)
 ;
ASKDIR(DIR) ;
 N Y,DTOUT,DUOUT
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S Y=-1
 Q Y
