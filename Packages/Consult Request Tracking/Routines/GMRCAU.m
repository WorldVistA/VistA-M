GMRCAU ;SLC/DLT,JFR - Action Utilities  ;10/17/01 18:31
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,11,14,12,15,17,22,55**;DEC 27, 1997;Build 4
 ;
 ; This routine invokes IA #2324,#2692
 ;
GETPROV K GMRCORNP N DIR S DIR(0)="123.02,3"
 S DIR("A")=$S($D(GETPROV):GETPROV,1:"Responsible Clinician")
 D ^DIR K DIR I $D(DTOUT)!$D(DIROUT)!(X="^") S GMRCQIT="Q" Q
 G:Y<1 GETPROV S GMRCORNP=+Y
 Q
GETDT ;Get actual activity date
 K GMRCQIT,%
 D NOW^%DTC S (X,GMRCDT)=% D REGDTM^GMRCU S GMRCAD=X
 S DIR(0)="123.02,2",DIR("A")=$S($D(GETDT):GETDT,1:"Date/Time of Actual Activity"),DIR("B")="NOW" D ^DIR K DIR I $D(DIRUT) S GMRCQIT="Q" Q
 I X="NOW" K GMRCAD,Y Q
 S GMRCAD=Y K X,Y,DIRUT,DUOUT
 Q
ORTX(GMRCO) ;Get the abbreviated text for alert displays
 ;GMRCO is the consult entry from 123
 N GMRCSVC,GMRCSSNM,GMRCPROC,GMRCORTX
 S GMRCSSNM=$$SVC(GMRCO)
 S GMRCPROC=$$PROC(GMRCO)
 S GMRCORTX=$S($L(GMRCPROC):($E(GMRCSSNM,1,10)_" "_$E(GMRCPROC,1,10)),1:$E(GMRCSSNM,1,20))
 Q GMRCORTX
 ;
SVC(GMRCO) ;Get abbreviated service text
 N GMRCSSNM,GMRCSVC
 S GMRCSVC=$P(^GMR(123,+GMRCO,0),"^",5),GMRCSSNM=""
 I +GMRCSVC S GMRCSSNM=$S($L($G(^GMR(123.5,+GMRCSVC,.1))):^(.1),1:$P($G(^GMR(123.5,+GMRCSVC,0)),U,1))
 Q GMRCSSNM
PROC(GMRCO) ;Get abbreviated procedure text
 N GMRCPROC
 S GMRCPROC=$P(^GMR(123,+GMRCO,0),"^",8)
 I +GMRCPROC S GMRCPROC=$$GET1^DIQ(123.3,+GMRCPROC,.01)
 Q GMRCPROC
 ;
LMTX(GMRCO) ;Get the text for list manager displays
 ;GMRCO is the consult entry from 123
 N GMRCSVC,GMRCSSNM,GMRCREQ,GMRCORTX
 S GMRCSSNM=$$SVC(GMRCO)
 S GMRCREQ=$$PROC(GMRCO)
 S GMRCORTX=$S($L(GMRCREQ):($E(GMRCSSNM,1,10)_" "_$E(GMRCREQ,1,10)),1:$E(GMRCSSNM,1,20))
 Q GMRCORTX
 ;
 ;
VALID(GMRCSER,GMRCO,GMRCUSER,GMRCTST,GMRCIFC) ;Get users update authority
 ; check GMRCSS and all parents for authority
 ; codes returned are same as $$VALIDU
 N GMRCUPDL,GMRCLIS,GMRCHKD,GMRCNT,GMRCLP,GMRCQUIT
 I '$G(GMRCUSER) S GMRCUSER=DUZ
 ; check initial service first
 S GMRCUPDL=$$VALIDU(GMRCSER,GMRCUSER,$G(GMRCIFC)) I +GMRCUPDL D  G VALEX
 . I $G(GMRCTST) S $P(GMRCUPDL,U,3)=$P($G(^GMR(123.5,+GMRCSER,0)),U)
 S GMRCHKD(+GMRCSER)="",GMRCNT=1
 ; find parents if set to process, quit if none
 I '$P($G(^GMR(123.5,+GMRCSER,0)),U,7) G VALEX ;process parents = 0
 D FINDPAR(GMRCSER,.GMRCNT) I '$D(GMRCLIS) S GMRCUPDL=0 G VALEX
 S GMRCLP=0
 F  S GMRCLP=$O(GMRCLIS(GMRCLP)) Q:'GMRCLP!($D(GMRCQUIT))  D  I +GMRCUPDL G VALEX
 . I +$P(GMRCLIS(GMRCLP),U,2) K GMRCLIS(GMRCLP) Q  ;been checked
 . I '$D(GMRCHKD(+GMRCLIS(GMRCLP))) D
 .. ; check parent 
 .. S GMRCUPDL=$$VALIDU(+GMRCLIS(GMRCLP),GMRCUSER,$G(GMRCIFC))
 .. S GMRCHKD(+GMRCLIS(GMRCLP))=""
 . S $P(GMRCLIS(GMRCLP),U,2)=1
 . I +GMRCUPDL D  Q  ;got one
 .. S:$G(GMRCTST) $P(GMRCUPDL,U,3)=$P($G(^GMR(123.5,+GMRCLIS(GMRCLP),0)),U)
 . I $P(^GMR(123.5,+GMRCLIS(GMRCLP),0),U,7) D  ;process parents
 .. D FINDPAR(+GMRCLIS(GMRCLP),.GMRCNT)
 . S GMRCLP=0 ;start back at top and don't miss any
VALEX Q GMRCUPDL
FINDPAR(SERV,ARCNT)     ;find parents of SERV
 ; SERV = service to find parents of
 ; ARCNT = next array element
 N PARENT
 S PARENT=0
 F  S PARENT=$O(^GMR(123.5,"APC",SERV,PARENT)) Q:'PARENT  D
 . S GMRCLIS(ARCNT)=PARENT
 . S ARCNT=ARCNT+1
 Q
 ;
VALIDU(GMRCSS,GMRCUSR,GMRCIFC) ;Check to see if user is an update user
 ;The value returned is the equivalent of this set of codes:
 ;    0 = not an update user
 ;    1 = unrestricted access user
 ;    2 = update user
 ;    3 = administrative update user
 ;    4 = admin AND update user
 ;    5 = IFC coordinator
 ;
 N GMRCUPD,GMRCAD,GMRCUP
 I '$G(GMRCUSR) S GMRCUSR=DUZ
 I '+$G(GMRCSS) Q 0
 S GMRCAD=0,GMRCUP=0
 I $G(GMRCIFC),$P($G(^GMR(123.5,GMRCSS,"IFC")),U,3) Q 5
 I 'GMRCUP,$D(^GMR(123.5,+GMRCSS,123.3,"B",GMRCUSR)) D
 . S GMRCUP=2_$$FIELD(123.3)
 I 'GMRCUP,GMRCUSR=$P($G(^GMR(123.5,+GMRCSS,123)),"^",8) D
 . S GMRCUP=2_$$FIELD(123.08)
 I 'GMRCUP,+$P($G(^GMR(123.5,GMRCSS,0)),U,6) S GMRCUP=1_$$FIELD(.06)
 I $D(^GMR(123.5,+GMRCSS,123.33,"B",GMRCUSR)) S GMRCAD=3_$$FIELD(123.33)
 ;
 I GMRCAD,GMRCUP Q $$BOTH(GMRCAD,GMRCUP) ;admin and upd user
 ;
 S GMRCUPD=0
 ; check service teams to notify, update teams w/o
 I 'GMRCUP N NODE F NODE=123.1,123.31 D  I +GMRCUP Q
 . I '$D(^GMR(123.5,+GMRCSS,NODE)) Q
 . D TEAM(.GMRCUP,NODE,GMRCUSR)
 ;
 I GMRCAD,GMRCUP Q $$BOTH(GMRCUP,GMRCAD) ;admin and upd user
 ;
 I 'GMRCAD D  ;check adm teams w/o
 . I '$D(^GMR(123.5,+GMRCSS,123.34)) Q
 . D TEAM(.GMRCAD,123.34,GMRCUSR)
 ; 
 I GMRCAD,GMRCUP Q $$BOTH(GMRCUP,GMRCAD) ;admin and upd user
 ;
 ; check ASU user classes in field 123.35
 I 'GMRCUP S GMRCUP=$$USR(GMRCSS,GMRCUSR)
 ;
 I GMRCAD,GMRCUP Q $$BOTH(GMRCUP,GMRCAD) ;admin and upd
 ;
 I 'GMRCUP I $D(^GMR(123.5,+GMRCSS,123.2)) D LOC(.GMRCUP)
 ;
 I GMRCAD,GMRCUP Q $$BOTH(GMRCUP,GMRCAD) ;admin and upd
 I GMRCUP,'GMRCAD Q GMRCUP ;update user only
 I GMRCAD,'GMRCUP Q GMRCAD ;admin user only
 Q 0
 ;
BOTH(ADMN,UPD) ;return string with fields if testing
 I $G(GMRCTST) Q "4^"_$P(ADMN,U,2)_" and "_$P(UPD,U,2)
 Q 4
 ;
LOC(GMRCUPD) ;Check for the DUZ in the NOTIFICATION BY PT LOCATION multiple
 N GMRCL,GMRCTM
 S GMRCL=0 ;Check if DUZ is associated with any location/ward
 F  S GMRCL=$O(^GMR(123.5,+GMRCSS,123.2,GMRCL))  Q:'GMRCL!+GMRCUPD  D  Q:+GMRCUPD
 . ;Get user and/or team assigned to location
 . S GMRCL(0)=$G(^GMR(123.5,+GMRCSS,123.2,+GMRCL,0))
 . I $P(GMRCL(0),"^",2)=DUZ S GMRCUPD=2 Q
 . I $P(GMRCL(0),"^",3) S GMRCTM=$P(GMRCL(0),"^",3) ;D CHKTM
 Q
 ;
TEAM(TYPE,SUBSC,USER) ;Check for the DUZ in the multiple of SUBSC
 N GMRCTM,GMRCHIT
 S GMRCTM=""
 I '$G(USER) S USER=DUZ
 F  S GMRCTM=$O(^GMR(123.5,GMRCSS,SUBSC,"B",GMRCTM)) Q:'GMRCTM!+TYPE  D
 . S GMRCHIT=$$CHKTM(GMRCTM,USER) Q:'GMRCHIT
 . S TYPE=$S(SUBSC=123.34:3,1:2)_$$FIELD(SUBSC)
 Q
 ;
CHKTM(TEAM,PERS) ;checks for PERS in list of users on TEAM
 ;Input:  TEAM must be set to the Order Team entry number
 ;Output: 1 will be returned PERS is on TEAM
 N ND,GMRCLST,FOUND
 S GMRCLST=""
 D TEAMPROV^ORQPTQ1(.GMRCLST,TEAM)
 I $P(GMRCLST(1),"^",2)="No providers found." Q 0
 S ND=0
 F  S ND=$O(GMRCLST(ND)) Q:ND=""  I +GMRCLST(ND)=PERS S FOUND=1 Q
 Q $S($G(FOUND):1,1:0)
 ;
USR(SERV,USER) ; check USR classes for user
 N UCLS,UPD
 I '$O(^GMR(123.5,+SERV,123.35,0)) Q 0
 S UCLS=0,UPD=0
 F  S UCLS=$O(^GMR(123.5,+SERV,123.35,"B",UCLS)) Q:'UCLS!(+UPD)  D
 . Q:'UCLS
 . S UPD=$$ISA^USRLM(USER,UCLS)
 . I +UPD S UPD=2_$$FIELD(123.35)
 . Q
 Q UPD
FIELD(GMRCFLD) ;return field name where became update user
 I '$G(GMRCTST) Q ""
 D FIELD^DID(123.5,GMRCFLD,,"LABEL","GMRCFLD")
 Q "^"_$G(GMRCFLD("LABEL"))
COMPLETE(GMRCA) ;Determine if the action is a complete action (10,13,14)
 S GMRCA=$G(GMRCA)
 Q $S(GMRCA=13:1,GMRCA=14:1,GMRCA=10:1,1:0)
 ;   10=administrative complete, 13=ADDENDUM ADDED, 14=New Note
 ;
RESOLUA(GMRCA) ;Determine if action has resolution info for clinician
 ;Action value is based on value in ^ORD(100.01,"
 ;Returns 1 for consult resolution, 0 for pending resolution
 S GMRCA=$G(GMRCA)
 Q $S(GMRCA=4:1,GMRCA=6:1,GMRCA=10:1,GMRCA=11:1,GMRCA=12:1,GMRCA=13:1,GMRCA=14:1,GMRCA=19:1,1:0)
 ;    4=Sig Findings, 6=discontinued, 10=administrative complete
 ;    11=Edit/resubmit
 ;    12=Disassociate result, 13=Addendum Added, 14=New Note
 ;    19=cancelled
 ;
RESOLUS(GMRCSTS) ;Determine status indicates the consult has a resolution
 ;Status value is based on values in ^ORD(100.01,"
 ;Returns 1 for consult resolution, 0 for pending resolution
 S GMRCSTS=$G(GMRCSTS)
 Q $S(GMRCSTS:1,GMRCSTS=2:1,GMRCSTS=13:1,1:0)
 ;    1=dc,2=comp,13=canc
 ;
TEST ;called from GMRC UPDATE AUTHORITY
 ; determines how a user gets update authority for a service 
 W !
 N GMRCSRV,GMRCUSR,UPD,GMRCDG,GMRC1
 N DIR,DIROUT,DIRUT,DUOUT,DTOUT,X,Y
 S DIR(0)="PO^123.5:EM",DIR("A")="Select Consult Service"
 S DIR("?")="Choose the consult service to check update status of user"
 S DIR("??")="^D TESTHELP^GMRCAU(""ALL SERVICES"")" D ^DIR
 I $D(DIRUT) Q
 S GMRCSRV=+Y
 N DIR
 S DIR(0)="PO^200:EM",DIR("A")="Choose user to check for update status"
 D ^DIR I $D(DIRUT) Q
 S GMRCUSR=+Y
 S UPD=$$VALID(GMRCSRV,,GMRCUSR,1)
 I +UPD=0 W !!,"This user has no update authority"
 I +UPD D
 . I +UPD=2 W !!,"This user is an update user for: ",$P(UPD,U,3)
 . I +UPD=3 W !!,"This user is an administrative user for: ",$P(UPD,U,3)
 . I +UPD=4 D
 .. W !!,"This user is both and administrative and update user"
 .. W " for: ",!,$P(UPD,U,3)
 . W !,"via the ",$P(UPD,U,2)," field",$S(+UPD=4:"(s).",1:".")
 . W ! I $L($P(UPD,U,3)) D
 .. I $P(UPD,U,3)'=$P(^GMR(123.5,+GMRCSRV,0),U) D HIER^GMRCT($P(UPD,U,3))
 W !!
 K GMRCSRV,GMRCUSR,UPD
 K DIR,DIROUT,DIRUT,DUOUT,DTOUT,X,Y
 G TEST
TESTHELP(GMRCSVNM) ;wrapper for LISTSRV^GMRCASV
 N DIR,GMRC1,GMRCDG
 D LISTSRV^GMRCASV
 Q
TSTINTRO ;entry action of GMRC UPDATE AUTHORITY option
 W !!,"This option will allow you to check a user's update authority for any given"
 W !,"service in the consults hierarchy.  If the PROCESS PARENTS FOR UPDATES field"
 W !,"is set to YES, all ancestors of the selected service will be checked."
 W !,"The type of update authority and the service to which they are assigned will"
 W !,"be displayed.",!!
 Q
