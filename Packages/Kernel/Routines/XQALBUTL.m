XQALBUTL ; slc/CLA,ISC-SF.SEA/JLI - Utilities for OE/RR notifications ;8/26/03  15:21
 ;;8.0;KERNEL;**114,125,171,285**;Jul 10, 1995
 ; PROVIDES FUNCTIONALITY USED BY ORBUTL
EN ;
 Q
RECIPURG(XQX) ;called by option ORB PURG RECIP - purge existing notifs: recipient/DUZ
 N XQK,XQA,XQADAT S XQADAT=$$NOW^XLFDT()
 F XQK=0:0 S XQK=$O(^XTV(8992,XQX,"XQA",XQK)) Q:XQK'>0  S XQA=$P(^(XQK,0),"^",2) D OLDPURG
 Q
 ;
PTPURG(DFN) ;called by option ORB PURG PATIENT - purge existing notifs: patient
 N XQX,XQK,XQA,XQADAT S XQADAT=$$NOW^XLFDT()
 F XQX=0:0 S XQX=$O(^XTV(8992,XQX)) Q:XQX'>0  F XQK=0:0 S XQK=$O(^XTV(8992,XQX,"XQA",XQK)) Q:XQK'>0  S XQA=$P(^(XQK,0),"^",2) I $P($P(XQA,";"),",",2)=DFN D OLDPURG
 Q
 ;
NOTIPURG(Y) ;called by option ORB PURG NOTIF - purge existing notifs: notification
 N XQX,XQK,XQA,XQADAT S XQADAT=$$NOW^XLFDT()
 F XQX=0:0 S XQX=$O(^XTV(8992,XQX)) Q:XQX'>0  F XQK=0:0 S XQK=$O(^XTV(8992,XQX,"XQA",XQK)) Q:XQK'>0  S XQA=$P(^(XQK,0),"^",2) I $P($P(XQA,";"),",",3)=+Y D OLDPURG
 Q
OLDPURG ;called by RECIPURG, PTPURG, NOTIPURG - KILLs specified alert entries
 N XQAID S XQAID=XQA D DELA^XQALDEL ; JLI 9-3-99 FIXES NULL SUBSCRIPT IN DELA+1^XQALDEL
 Q
 ;
AHISTORY(XQAID,ROOT) ; SR  Returns information from alert tracking file for alert with XQAID as its alert ID.  The data is returned desendent from the closed root passed in ROOT.
 N X
 K @ROOT
 S X=$O(^XTV(8992.1,"B",XQAID,0)) I X'>0 Q
 M @ROOT=^XTV(8992.1,X)
 Q
 ;
PENDING(XQAUSER,XQAID) ; SR. Returns whether the user specified has the alert indicated by XQAID pending.  (1=YES, 0=NO)
 Q $D(^XTV(8992,"AXQA",XQAID,XQAUSER))/10
 ;
PKGPEND(XQAUSER,XQAPKG) ; SR. Returns 1 if the user indicated by XQAUSER has any pending alerts with the first ';'-piece of XQAID contains the package identifier indicated by XQAPKG.
 N I,X
 F I=0:0 S X="",I=$O(^XTV(8992,XQAUSER,"XQA",I)) Q:I'>0  S X=$P($P(^(I,0),U,2),";") I X[XQAPKG Q
 Q $S(X'="":1,1:0)
 ;
ALERTDAT(XQAID,ROOT) ; SR. Returns information from alert tracking file for alert with XQAID in array XQALERTD.  If the alert is not present, the array is undefined.
 N IEN
 I $G(ROOT)="" S ROOT="XQALERTD"
 K @ROOT
 S IEN=$O(^XTV(8992.1,"B",XQAID,0)) I IEN'>0 S @ROOT="" Q
 D MAKELIST(ROOT,8992.1,(IEN_","))
 Q
USERLIST(XQAID,ROOT) ; SR. Returns recipients of alert with ID of XQAID from alert tracking file in array XQALUSER
 N IEN,N,I,X
 I $G(ROOT)="" S ROOT="XQALUSRS"
 K @ROOT
 S IEN=$O(^XTV(8992.1,"B",XQAID,0)) I IEN'>0 S @ROOT="" Q
 S N=0 F I=0:0 S I=$O(^XTV(8992.1,IEN,20,I)) Q:I'>0  S N=N+1,X=+^(I,0),X=X_U_$$GET1^DIQ(8992.11,(I_","_IEN_","),.01),@ROOT@(N)=X
 Q
USERDATA(XQAID,XQAUSER,ROOT) ; SR. returns information from alert tracking file related to alert with ID of XQAID for user specified by XQAUSER
 N IEN,IEN2
 I $G(ROOT)="" S ROOT="XQALUSER"
 K @ROOT
 S IEN=$O(^XTV(8992.1,"B",XQAID,0)) I IEN'>0 S @ROOT="" Q
 S IEN2=$O(^XTV(8992.1,IEN,20,"B",XQAUSER,0)) I IEN2'>0 S @ROOT="" Q
 D MAKELIST(ROOT,8992.11,(IEN2_","_IEN_","))
 Q
MAKELIST(ARRAY,FILE,IENS) ; Makes a list of fields as subscripts in ARRAY with the values of the fields as the value.  If internal and external differ, the value is given as internal^external.
 N ROOT,FIELD,X
 K @ARRAY
 S ROOT=$NA(^TMP("XQALMAKELIST",$J))
 K @ROOT
 D GETS^DIQ(FILE,IENS,"*","IE",ROOT)
 F FIELD=0:0 S FIELD=$O(@ROOT@(FILE,IENS,FIELD)) Q:FIELD'>0  S X=^(FIELD,"I") S:X'=^("E") X=X_U_^("E") S @ARRAY@(FIELD)=X,@ARRAY@(FIELD,$$GET1^DID(FILE,FIELD,"","LABEL"))=""
 K @ROOT
 Q
 ;
 ;;  DELSTAT - For the most recent alert with XQAIDVAL as the PackageID
 ;;  passed in, on return array VALUES contains the DUZ for users in 
 ;;  VALUES along with an indicator of whether the alert has been 
 ;;  deleted or not, e.g., DUZ^0 if not deleted or DUZ^1 if deleted.  
 ;;  Note that contents of VALUES will be killed prior to building the 
 ;;  list.
 ;;
 ;;  Example:   D DELSTAT^XQALBUTL("OR;14765;23",.RESULTS)
 ;;
 ;;  Returned:   The value of RESULTS indicates the number of entries in
 ;;              the array.  The entries are then ordered in numerical 
 ;;              order in the RESULTS array.
 ;;                  RESULTS = 3
 ;;                  RESULTS(1) = "146^0"   User 146 - not deleted
 ;;                  RESULTS(2) = "297^1"   User 297 - deleted
 ;;                  RESULTS(3) = "673^0"   User 673 - not deleted
 ;;
DELSTAT(XQAIDVAL,VALUES) ; .SR
 N XQAX,XQADATE,XQAID,XQAFN,I,X,X1,X
 S XQAX=XQAIDVAL,XQADATE=0,XQAID="" K VALUES S VALUES=0
 F  S XQAX=$O(^XTV(8992.1,"B",XQAX)) Q:XQAX'[XQAIDVAL  I XQADATE<$P(XQAX,";",3) S XQADATE=$P(XQAX,";",3),XQAID=XQAX
 Q:XQAID=""  S XQAFN=$O(^XTV(8992.1,"B",XQAID,0)) Q:XQAFN'>0
 F I=0:0 S I=$O(^XTV(8992.1,XQAFN,20,I)) Q:I'>0  S X=^(I,0),X1=+X,X2=($P(X,U,5)>0!($P(X,U,6)>0)),VALUES=VALUES+1,VALUES(VALUES)=X1_U_X2
 Q
 ;
BKUPREVW ;OPT - SET BACKUP REVIEWER(S) IN PARAMETER FILE - Moved from XQALDEL
 N DIR,DIRUT,XQALBKUP,XQALCASE,XQPARAM,ERR
 S XQPARAM="XQAL BACKUP REVIEWER"
BK1 ; Select NEW PERSON entry as backup reviewer
 F  S XQALBKUP=$$NEWPERSN() Q:$D(DIRUT)  Q:XQALBKUP'>0  D  Q:$D(DIRUT)
 . D LISTCURR(XQALBKUP)
BK2 . ; Select Entity type for backup reviewer - XQALLAST indicates maximum number of choices, last is SYSTEM.
 . N XQALVALS,XQALLAST
 . S XQALLAST=4,XQALVALS(1)="User^200^USER^USR",XQALVALS(2)="Service^49^SERVICE^SRV",XQALVALS(3)="Division^4^DIVISION^DIV",XQALVALS(4)="System^"
 . F  S XQALCASE=$$ENTTYPE(.XQALVALS,XQALLAST) Q:$D(DIRUT)  Q:XQALCASE'>0  D  K:X="" DIRUT Q:$D(DIRUT)
 . . ; Select individual in Entity for backup reviewer
 . . I XQALCASE<XQALLAST D
 . . . S DIR(0)="PO^"_$P(XQALVALS(XQALCASE),U,2)_":AEQM",DIR("A")="Select "_$P(XQALVALS(XQALCASE),U,3)_" to set "_$P(XQALBKUP,U,2)_" as BACKUP REVIEWER for"
 . . . F  D ^DIR Q:Y'>0  S XQAENT=+Y D CHKCURR($P(XQALVALS(XQALCASE),U,4)_".`"_XQAENT,+XQALBKUP)
 . . . K DIR
 . . . Q
 . . ; Special handling for SYSTEM entity
 . . I XQALCASE=XQALLAST S Y=$$GET1^DIQ(8989.3,"1,",.01,"I") D CHKCURR("SYS.`"_Y,+XQALBKUP)
 . . Q
 . Q
 Q
 ;
NEWPERSN() ;
 ;   Select a Backup Reviewer, then select parameter cases for this Backup
 ;   Reviewer.  You may then select another Backup Reviewer for additional
 ;   parameter cases if necessary.
 ;   
 ;   Select NEW PERSON entry to be BACKUP REVIEWER
NEWLOOP ;
 W ! S DIR(0)="PO^200:AEQM",DIR("A")="Select NEW PERSON entry to be BACKUP REVIEWER",DIR("A",1)="Select a Backup Reviewer, then select parameter cases for this Backup"
 S DIR("A",2)="Reviewer.  You may then select another Backup Reviewer for additional",DIR("A",3)="parameter cases if necessary.",DIR("A",4)=""
 D ^DIR K DIR I X="" K DIRUT
 I Y>0,'$$ACTIVE^XUSER(+Y) W !,$C(7),"This is not an ACTIVE USER...  Select an Active user",! G NEWLOOP
 Q Y
 ;
ENTTYPE(XQALVALS,XQALLAST) ;
 K DIR("A")
 S XQALCASE="" F I=1:1:XQALLAST S XQALCASE=XQALCASE_I_":"_$P(XQALVALS(I),U)_";"
 S DIR(0)="SO^"_XQALCASE D ^DIR K DIR I X="" K DIRUT
 Q Y
 ;
CHKCURR(ENTITY,XQALBKUP) ;
 S XQAINST=$$GETINST(ENTITY,XQALBKUP)
 I XQAINST>0 D PUT^XPAR(ENTITY,XQPARAM,XQAINST,XQALBKUP,.ERR) W "   ...Done"
 I XQAINST<0 D PUT^XPAR(ENTITY,XQPARAM,-XQAINST,"@",.ERR) W "    ...Done"
 Q
 ;
GETINST(ENTITY,XQALBKUP) ;
 N DIR,DIRUT,I,J,IMAX,XQAA,XQATYP,XQAI,Y,ISELF,IEN,XQAVAL
 D GETLST^XPAR(.XQAA,ENTITY,XQPARAM,"Q",.XQERR) I XQAA=0 Q 1
LOOP ;
 W !,"There "_$S(XQAA=1:"is",1:"are")_" currently "_XQAA_" instance"_$S(XQAA>1:"s",1:"")_" for this entity"
 S ISELF=0
 F I=0:0 S I=$O(XQAA(I)) Q:I'>0  S IEN=+$P(XQAA(I),U,2) W !,?5,+XQAA(I),?10,$$GET1^DIQ(200,IEN_",",.01) S IMAX=+XQAA(I) I IEN=XQALBKUP S ISELF=+XQAA(I)
 S DIR(0)="S^"_$S(ISELF=0:";a:Add an instance;r:Replace an instance;",1:"")_"d:Delete an instance;q:Quit",DIR("A")="Select Action" D ^DIR K DIR I $D(DIRUT)!(Y="q") K DIRUT Q 0
 S XQATYP=Y I XQATYP="a" S J=0 D  Q J
 . F XQAI=1:1 I +$G(XQAA(XQAI))'=XQAI S J=XQAI I J>0 Q
 E  D  Q:Y=0 0
 . S Y=IMAX I XQAA>1 S DIR(0)="N^1:"_IMAX,DIR("A")="Select Instance number to "_$S(XQATYP="r":"REPLACE",1:"DELETE") D ^DIR K DIR I $D(DIRUT) K DIRUT S Y=0 Q
 . F XQAI=1:1 Q:'$D(XQAA(XQAI))  I +XQAA(XQAI)=Y Q
 . I '$D(XQAA(XQAI)) S Y=-1
 I Y<0 W $C(7),!!,"To "_$S(XQATYP="r":"REPLACE",1:"DELETE")_" an entry enter an instance number from the list." G LOOP
 S XQAVAL=+Y I XQATYP="d" S XQAVAL=-Y
 Q XQAVAL
 ;
LISTCURR(XQALBKUP) ;
 N XLIST,NVALS,ENT,XQIEN,X,ENTIEN,ENTFIL,FILNAM,FILNUM
 S NVALS=$$LISTGET(+XQALBKUP,.XLIST) I NVALS>0 D
 . W !,"Currently Backup Reviewer for:"
 . S ENT="" F  S ENT=$O(XLIST(ENT)) Q:ENT=""  F XQIEN=0:0 S XQIEN=$O(XLIST(ENT,XQIEN)) Q:XQIEN'>0  D
 . . S X=$$GET1^DIQ(8989.5,XQIEN_",",.01,"I"),ENTIEN=$P(X,";"),ENTFIL=$P(X,";",2),FILNAM=$P(@(U_ENTFIL_"0)"),U),FILNUM=+$P(@(U_ENTFIL_"0)"),U,2) I FILNUM>0 D
 . . . W !?10,$S(FILNUM=4:"Division",FILNUM=4.2:"System",FILNUM=49:"Service",FILNUM=200:"User",1:"UNKNOWN???")_":",?25,$$GET1^DIQ(FILNUM,ENTIEN_",",.01)
 . . . Q
 . . Q
 . Q
 Q
 ;
LISTGET(XQALBKUP,XLIST) ;
 N PARAMIEN,ENT,INST,X,IEN,ENT1,CNT
 S PARAMIEN=$$FIND1^DIC(8989.51,"","","XQAL BACKUP REVIEWER"),CNT=0
 S ENT="" F  S ENT=$O(^XTV(8989.5,"AC",PARAMIEN,ENT)) Q:ENT=""   F INST=0:0 S INST=$O(^XTV(8989.5,"AC",PARAMIEN,ENT,INST)) Q:INST'>0  S IEN=^(INST),X=$O(^(INST,"")) I IEN=XQALBKUP S ENT1=$P(ENT,";",2),XLIST(ENT1,X)="",CNT=CNT+1
 Q CNT
