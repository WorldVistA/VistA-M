XQALSURO ;ISC-SF.SEA/JLI,ISD/HGW - SURROGATES FOR ALERTS ; May 12, 2021@14:27
 ;;8.0;KERNEL;**114,125,173,285,366,443,513,602,730,754**;Jul 10, 1995;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified
 Q
OTHRSURO ; OPT:- XQALERT SURROGATE SET/REMOVE -- OTHERS SPECIFY SURROGATE FOR SELECTED USER
 N XQAUSER,DIR,Y
 S DIR(0)="PD^200:AEMQ",DIR("A",1)="SURROGATE related to which"
 S DIR("A")="NEW PERSON entry"
 D ^DIR K DIR Q:Y'>0  W "  ",$P(Y,U,2)
 S XQAUSER=+Y
 G SURROGAT
 Q
 ;
SURROGAT ; USER SPECIFICATION OF SURROGATE
 I '$D(XQAUSER) N XQAUSER S XQAUSER=DUZ
 D SURRO1^XQALSUR1(XQAUSER)
 Q
 ;
CYCLIC(XQALSURO,XQAUSER,XQASTRT,XQAEND) ; code added to prevent cyclical surrogates
 I '$$ACTIVE^XUSER(XQALSURO) Q "You cannot have an INACTIVE USER ("_$$NAME^XUSER(XQALSURO,"F")_") as a surrogate!" ;P443
 I XQALSURO=XQAUSER Q "You cannot specify yourself as your own surrogate!" ; moved in P443
 I $G(XQASTRT)>0 Q $$DCYCLIC^XQALSUR1(XQALSURO,XQAUSER,XQASTRT,$G(XQAEND))
 ;p602 in SURRO11^XQALSUR1 split the check for cyclical surrogates into two parts. The following code becomes unnecessary.
 ;N XQALSTRT
 ;S XQALSTRT=$$CURRSURO(XQALSURO) I XQALSTRT>0 D
 ;. I XQALSTRT=XQAUSER S XQALSURO="YOU are designated as the surrogate for this user ("_XQALSURO_") - can't do it!" Q
 ;. F  S XQALSTRT=$$CURRSURO(XQALSTRT) Q:XQALSTRT'>0  I XQALSTRT=XQAUSER S XQALSURO="This forms a circle which leads back to you - can't do it!" Q
 ;. Q
 Q XQALSURO
 ;
SETSURO(XQAUSER,XQALSURO,XQALSTRT,XQALEND) ; SR. ICR #2790 (Supported)
 ; Use SETSURO1 instead
 N XQALVAL ; P443
 S XQALVAL=$$SETSURO1(XQAUSER,XQALSURO,$G(XQALSTRT),$G(XQALEND)) ; P443
 Q
 ;
SETSUROX(XQAUSER,XQALSURO,XQALSTRT,XQALEND) ; SETSURO CODE MOVED TO HERE TO PERMIT AN ERROR TO BE GENERATED AT THE OLD ENTRY POINT
 N XQALFM,XQALIEN,XQAIENS
 I '$D(^XTV(8992,XQAUSER,0)) D
 . N XQALFM,XQALFM1
 . S XQALFM1(1)=XQAUSER
 . S XQALFM(8992,"+1,",.01)=XQAUSER
 . D UPDATE^DIE("","XQALFM","XQALFM1")
 . Q
 S XQAIENS=XQAUSER_","
 ; P366 - force no start date/time to NOW, and anything less than NOW to NOW
 I $G(XQALSTRT)<$$NOW^XLFDT() S XQALSTRT=$$NOW^XLFDT()
 ; P366 - add values to new multiple
 S XQALFM(8992.02,"+1,"_XQAIENS,.01)=XQALSTRT
 S XQALFM(8992.02,"+1,"_XQAIENS,.02)=XQALSURO
 I (XQALEND>0)&(XQALEND'>XQALSTRT) S XQALEND=$$FMADD^XLFDT(XQALSTRT,0,0,0,1) ;p602 force end date/time to be after start date/time
 I XQALEND>0 S XQALFM(8992.02,"+1,"_XQAIENS,.03)=XQALEND
 K XQALIEN D UPDATE^DIE("","XQALFM","XQALIEN")
 ; P366 - if start date time is already in effect - place in old locations to make active
 ;D ACTIVATE(XQAUSER,XQALIEN(1)) ; P513 activate if current or next
 I XQALSTRT'>$$NOW^XLFDT() D ACTIVATE(XQAUSER,XQALIEN(1)) ; p602 activate only if current
 N XQAMESG,XMSUB,XMTEXT
 S XQAMESG(1,0)="You have been specified as a surrogate recipient for alerts for"
 S XQAMESG(2,0)=$$GET1^DIQ(200,XQAIENS,.01,"E")_" (IEN="_XQAUSER_") effective "_$$FMTE^XLFDT(XQALSTRT)
 I $G(XQALEND)'>0 S XQAMESG(2,0)=XQAMESG(2,0)_"."
 E  S XQAMESG(3,0)="until "_$$FMTE^XLFDT(XQALEND)
 S XMSUB="Surrogate Recipient for "_$$GET1^DIQ(200,XQAIENS,.01,"E")
 S XMTEXT="XQAMESG("
 ; ZEXCEPT: XTMUNIT   - Defined if unit tests are being run
 D:'$D(XTMUNIT) SENDMESG
 Q
 ;
ACTIVATE(XQAUSER,XQALIEN) ; activates a surrogate
 N X0,XQALFM,XQALSURO,XQALSTRT,XQALEND
 S X0=$G(^XTV(8992,XQAUSER,2,XQALIEN,0)) Q:X0=""  S XQALSTRT=$P(X0,U),XQALSURO=$P(X0,U,2),XQALEND=$P(X0,U,3)
 S X0=^XTV(8992,XQAUSER,0)
 I $P(X0,U,2)>0,$P(X0,U,3)'>$$NOW^XLFDT() D REMVSURO(XQAUSER) ; If we are activating a new surrogate, if one exists simply remove.
 K XQALFM S XQALFM(8992,XQAUSER_",",.03)=XQALSTRT
 S XQALFM(8992,XQAUSER_",",.02)=XQALSURO
 S XQALFM(8992,XQAUSER_",",.04)=$S($G(XQALEND)>0:XQALEND,1:"@")
 D FILE^DIE("","XQALFM")
 Q
 ;
 ; usage $$SETSURO1(XQAUSER,XQALSURO,XQALSTRT,XQALEND)  returns 0 if invalid, otherwise > 0
SETSURO1(XQAUSER,XQALSURO,XQALSTRT,XQALEND) ;EXTRINSIC. ICR #3213 (supported)
 ; This should be used instead of SETSURO
 I $G(XQAUSER)'>0 Q "Invalid Internal Entry Number for user ("_XQAUSER_")" ; P513 moved from SETSUROX+2
 I $G(XQALSURO)'>0 Q "Invalid Internal Entry Number for surrogate ("_XQALSURO_")" ; P513 moved from SETSUROX+3
 I $G(XQALSTRT)'>0 S XQALSTRT=$$NOW^XLFDT()
 N XQAVAL
 S XQAVAL=$$CYCLIC(XQALSURO,XQAUSER,XQALSTRT,$G(XQALEND)) I XQAVAL'>0 Q XQAVAL ; Can't use as surrogate
 D SETSUROX(XQAUSER,XQALSURO,XQALSTRT,$G(XQALEND)) ; P443
 Q XQALSURO
 ;
CHKREMV ;
 N DIR,XQAI,XQAQUIT,XQASLIST,XQAVAL,YVAL,Y
 ; ZEXCEPT: XQAUSER    (EXTERNAL VALUE)
 ; p730
 ;D SUROLIST^XQALSUR1(XQAUSER,.XQASLIST)
 ; Display list and allow user to remove surrogate periods until satisfied
 S XQAQUIT=0 F  D  Q:$G(XQASLIST)<1!XQAQUIT
 . D DISPSUR^XQALSUR2(XQAUSER,.XQASLIST)
 . Q:$G(XQASLIST)<=0
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Do you want to REMOVE "_$S(XQASLIST>1:"a",1:"THIS")_" surrogate recipient"
 . S DIR("?")="A surrogate will receive your alerts until they are removed as surrogate."
 . D ^DIR K DIR S XQAQUIT='+Y
 . Q:XQAQUIT
 . S DIR("A")="Enter a list (comma separated, e.g., 1,2) of the surrogate(s) to remove"
 . S Y=1 I XQASLIST>1 S DIR(0)="L^1:"_XQASLIST D ^DIR K DIR
 . I Y>0 S YVAL=Y F XQAI=1:1 S XQAVAL=+$P(YVAL,",",XQAI) Q:XQAVAL'>0  D REMVSURO(XQAUSER,$P(XQASLIST(XQAVAL),U),$P(XQASLIST(XQAVAL),U,3))
 . W !
 Q
 ;
 ; P366 - added OPTIONAL second and third arguments to permit deletion of a specific pending surrogate and start date
REMVSURO(XQAUSER,XQALSURO,XQALSTRT) ;SR. ICR #2790 (supported)
 ; Ends the currently active surrogate relationship
 I $G(XQAUSER)'>0 Q
 D REMVSURO^XQALSUR1(XQAUSER,$G(XQALSURO),$G(XQALSTRT))
 Q
 ;
 ; P366 - added OPTIONAL second and third arguments to determine surrogate for specified time range
CURRSURO(XQAUSER,XQASTRT,XQAEND) ;SR. ICR #2790 (supported)
 ; Returns current surrogate for user or -1  usage $$CURRSURO^XQALSURO(DUZ)
 N X,ACTIVE,XQANOW,XQASTR1,XQAIVAL,XQA0,XQAI
 D CHEKSUBS^XQALSUR2(XQAUSER)
 I $G(XQASTRT)>0 Q $$DATESURO^XQALSUR1(XQAUSER,XQASTRT,$G(XQAEND)) ; P366 - check for current in specified date/times
 ;
 ; P366 - find the latest start time which is now or past or the first one in the future
 S XQANOW=$$NOW^XLFDT() D
 . S XQAIVAL=0,XQASTR1=0
 . F XQASTRT=0:0 S XQASTRT=$O(^XTV(8992,XQAUSER,2,"B",XQASTRT)) Q:XQASTRT'>0  Q:XQASTRT'<XQANOW  S XQASTR1=XQASTRT F XQAI=0:0 S XQAI=$O(^XTV(8992,XQAUSER,2,"B",XQASTRT,XQAI)) Q:XQAI'>0  D
 . . ; p754 somebody removed surr by gbl kill, cleanup
 . . I '$D(^XTV(8992,XQAUSER,2,XQAI,0)) K ^XTV(8992,XQAUSER,2,"B",XQASTRT,XQAI) Q
 . . S XQAEND=$P(^XTV(8992,XQAUSER,2,XQAI,0),U,3) I (XQAEND="")!(XQAEND>XQANOW) S XQAIVAL=XQAI
 . . Q
 . ; to be compatible with the past, if there is not a current surrogate, show the next scheduled on the zero node if there is one
 . I XQAIVAL=0 S XQASTRT=$O(^XTV(8992,XQAUSER,2,"B",XQASTR1)) Q:XQASTRT=""  F XQAI=0:0 S XQAI=$O(^XTV(8992,XQAUSER,2,"B",XQASTRT,XQAI)) Q:XQAI'>0  D  Q:XQAIVAL>0
 . . ; p754 somebody removed surr by gbl kill, cleanup
 . . I '$D(^XTV(8992,XQAUSER,2,XQAI,0)) K ^XTV(8992,XQAUSER,2,"B",XQASTRT,XQAI) Q
 . . S XQAEND=$P(^XTV(8992,XQAUSER,2,XQAI,0),U,3) I (XQAEND="")!(XQAEND>XQANOW) S XQAIVAL=XQAI
 . . Q
 . I XQAIVAL>0 S XQA0=^XTV(8992,XQAUSER,2,XQAIVAL,0),XQASTRT=^XTV(8992,XQAUSER,0) I ($P(XQA0,U,2)'=$P(XQASTRT,U,2))!($P(XQA0,U)'=$P(XQASTRT,U,3))!(+$P(XQA0,U,3)'=+$P(XQASTRT,U,4)) D ACTIVATE(XQAUSER,XQAIVAL)
 . Q
 ; P366 - end
 S X=$G(^XTV(8992,XQAUSER,0))
 ; now check for a CURRENT surrogate, already started and not expired or cyclic
 I $P(X,U,2)>0,+$P(X,U,3)'>XQANOW D  I $P($G(^XTV(8992,XQAUSER,0)),U,2)>0 Q +$P(^XTV(8992,XQAUSER,0),U,2)
 . N DATE ;   Get Current date/time to check date/times if present
 . ; FOLLOWING LINES MODIFIED IN P443 TO ELIMINATE A STACK ERROR WHEN SURROGATE WAS CIRCULAR
 . ;  Current Date/time past End date for surrogate
 . S DATE=$P(X,U,4) I (DATE>0&(DATE<XQANOW)) D REMVSURO(XQAUSER) Q
 . ; P513 quit if not already active
 . S DATE=$P(X,U,3) S:DATE="" DATE=XQANOW I DATE>XQANOW Q  ; P513
 . N XQASURO,XQASURO1 S XQASURO1=+$P(^XTV(8992,XQAUSER,0),U,2)
 . ; REMOVE IF SURROGATE IS USER
 . I XQASURO1=XQAUSER D REMVSURO(XQAUSER) Q
 . Q  ; p754 cyclic checks are done at surrogate creation time and the following is not needed
 Q -1
 ;. N XQALLIST,XQAUDATE S XQAUDATE=DATE,XQALLIST(XQAUSER,DATE)="" ; P513 JLI 100504 add XQAUDATE to be able to check earlier start time
 ;. ; REMOVE IF CYCLES BACK TO USER - thought about removing inactive, but best to let those be handled by groups for unprocessed alerts
 ;. ; P513 but ignore if surrogate isn't already active - JLI 100504
 ;. ; begin changes in P513
 ;. S XQASURO1=XQAUSER
 ;. F  S XQASURO=$P($G(^XTV(8992,XQASURO1,0)),U,2) Q:XQASURO'>0  Q:'$$ISACTIVE(XQASURO)  S DATE=$P(^XTV(8992,XQASURO,0),U,3) Q:DATE>XQANOW  D  S XQASURO1=XQASURO ; JLI 100504
 ;. . ;I $D(XQALLIST(XQASURO1)) D
 ;. . I $D(XQALLIST(XQASURO)) D  ; p730 check on NEXT surrogate and not on XQAUSER for first pass
 ;. . . N DATE1 S DATE1=$O(XQALLIST(XQASURO1,""))
 ;. . . ; remove the surrogate relationship that started earliest
 ;. . . I DATE<DATE1 D REMVSURO(XQASURO)
 ;. . . I DATE1<=DATE D REMVSURO(XQASURO1)
 ;. . . S XQASURO=XQAUSER K XQALLIST S DATE=XQAUDATE ; start over
 ;. . . Q
 ;. . S XQALLIST(XQASURO,DATE)=""
 ;. . ; end of P513 modification
 ;. . Q
 ;. ; END OF P443 MODIFICATION
 ;. Q
 ;Q -1
 ;
ISACTIVE(XQAUSER) ; checks for whether a surrogate relationship is active or not (returns 0 or 1)
 N DATA
 S DATA=$G(^XTV(8992,XQAUSER,0)) Q:$P(DATA,U,2)="" 0  ; NO SURROGATE SPECIFIED
 I $P(DATA,U,3)>0,$P(DATA,U,3)>$$NOW^XLFDT() Q 0  ; START DATE/TIME NOT YET
 I $P(DATA,U,4)>0,$P(DATA,U,4)<$$NOW^XLFDT() Q 0  ; PAST END DATE/TIME
 Q 1
 ;
ACTVSURO(XQAUSER) ;SR. ICR #2790 (supported)
 ; Returns the actual surrogate at this time
 N CURRSURO,NEXTSURO,SURODATA,NOW
 S NOW=$$NOW^XLFDT()
 S CURRSURO=$$CURRSURO(XQAUSER),SURODATA=$$GETSURO(XQAUSER) I (CURRSURO'>0)!(+$P(SURODATA,U,3)>NOW)!('(+$$ACTIVE^XUSER(CURRSURO))) Q -1
 F  S NEXTSURO=$$CURRSURO(CURRSURO),SURODATA=$$GETSURO(CURRSURO) Q:NEXTSURO'>0  Q:+$P(SURODATA,U,3)>NOW  Q:'(+$$ACTIVE^XUSER(NEXTSURO))  S CURRSURO=NEXTSURO
 Q CURRSURO
 ;
GETSURO(XQAUSER) ;EXTRINSIC. ICR #3213 (supported)
 ; Returns data for surrogate for user including times
 I $$CURRSURO(XQAUSER)'>0 Q ""
 N GLOBREF,IENS,X
 S IENS=XQAUSER_",",GLOBREF=$NA(^TMP($J,"XQALSURO")) K @GLOBREF
 D GETS^DIQ(8992,IENS,".02;.03;.04","IE",GLOBREF)
 S GLOBREF=$NA(@GLOBREF@(8992,IENS))
 S X=$G(@GLOBREF@(.02,"I"))_U_$G(@GLOBREF@(.02,"E"))_U_$G(@GLOBREF@(.03,"I"))_U_$G(@GLOBREF@(.04,"I"))
 K @GLOBREF
 Q X
 ;
GETFOR ;OPT.
 N XQAUSER,VALUES,XQACNT,DIR,DIRUT,I,Y
 S DIR(0)="PD^200:AEMQ"
 S DIR("A")="Select Surrogate (NEW PERSON entry)"
 S DIR("A",1)="",DIR("A",2)=""
 S DIR("A",3)=" - List Users who have chosen this User to be their current Surrogate." ;p602
 S DIR("A",4)=""
 D ^DIR K DIR Q:Y'>0  W "  ",$P(Y,U,2)
 S XQAUSER=+Y
 D SUROFOR(.VALUES,XQAUSER) I VALUES'>0 W !,"No entries found.",!! Q
 S XQACNT=0 K DIRUT F I=0:0 S I=$O(VALUES(I)) Q:I'>0  D:(XQACNT>(IOSL-4))  Q:$D(DIRUT)  W !,?5,$P(VALUES(I),U,2) S XQACNT=XQACNT+1
 . S DIR(0)="E" D ^DIR K DIR
 . Q
 K DIRUT
 Q
 ;
SUROLIST(XQAUSER,XQALIST) ;SR. ICR #3213 (supported)
 ; Returns list of current and scheduled surrogates for XQAUSER
 D SUROLIST^XQALSUR1(XQAUSER,.XQALIST)
 Q
 ;
SUROFOR(LIST,XQAUSER) ;SR. ICR #3213 (supported)
 ; Returns list of users XQAUSER is acting as a surrogate for
 I $G(XQAUSER)="" Q
 N I,COUNT S I=0,COUNT=0 F  S I=$O(^XTV(8992,"AC",XQAUSER,I)) Q:I'>0  I $$CURRSURO(I)>0 D
 . S COUNT=COUNT+1,LIST(COUNT)=I_U_$$GET1^DIQ(200,(I_","),".01","E")_U_$$GET1^DIQ(8992,(I_","),".03","E")_U_$$GET1^DIQ(8992,(I_","),".04","E")
 S LIST=COUNT
 Q
 ;
SENDMESG ;
 N XMY,XMDUZ,XMCHAN
 ; ZEXCEPT: XQALSURO   (EXTERNAL VALUE)
 S XMY(XQALSURO)="",XMDUZ=.5
 D ^XMD
 Q
