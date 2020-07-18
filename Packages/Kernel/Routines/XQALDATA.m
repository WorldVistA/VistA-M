XQALDATA ;ISC/JLI ISD/HGW - PROVIDE DATA ON ALERTS ;10/19/18  13:08
 ;;8.0;KERNEL;**207,285,443,513,602,653**;Jul 10, 1995;Build 18
 ;Per VHA Directive 2004-038, this routine should not be modified
 Q
GETUSER(ROOT,XQAUSER,FRSTDATE,LASTDATE) ; SR. ICR #4834 (private OE/RR)
 N XREF,XVAL,X,X2,X3,I,NCNT ; P443
 S:$G(XQAUSER)'>0 XQAUSER=DUZ
 S:$G(FRSTDATE)'>0 FRSTDATE=0
 S:$G(LASTDATE)'>0 LASTDATE=0
 S NCNT=0 K @ROOT
 I FRSTDATE=0 D  Q
 . F I=0:0 S I=$O(^XTV(8992,XQAUSER,"XQA",I)) Q:I'>0  S X=^(I,0),X3=$G(^(3)),X2=$G(^(2)) D
 . . S NCNT=NCNT+1
 . . S @ROOT@(NCNT)=$S($P(X3,U)'="":"G  ",$P(X,U,7,8)="^ ":"I  ",1:"   ")_$P(X,U,3)_U_$P(X,U,2)_$S($P(X2,U,3)'="":U_$P(X2,U,3),1:"") ; P443
 . S @ROOT=NCNT
 S XREF="R"
 S XVAL=XQAUSER
 D CHKTRAIL
 Q
GETPAT(ROOT,PATIENT,FRSTDATE,LASTDATE) ;
 N XREF,XVAL,NCNT
 S NCNT=0 K @ROOT
 I $G(PATIENT)'>0 S @ROOT=0 Q
 S XREF="C"
 S XVAL=PATIENT
 D CHKTRAIL
 Q
GETPAT2(ROOT,PATIENT,PAGE,LIMIT) ; P653
 N XREF,XVAL,NCNT
 S NCNT=0 K @ROOT
 I $G(PATIENT)'>0 S @ROOT=0 Q
 S XREF="C"
 S XVAL=PATIENT
 D GETPAGE
 Q
GETPAGE ;P653
 N XQ1,XQCNT,XQSTART,XQEND,XQCNTTOT
 S XQ1="",XQCNT=0,XQCNTTOT=0
 S XQSTART=(PAGE-1)*LIMIT+1
 S XQEND=PAGE*LIMIT
 F  S XQ1=$O(^XTV(8992.1,XREF,XVAL,XQ1),-1) Q:'XQ1  D
 . S XQCNT=XQCNT+1
 . I (XQCNT>=XQSTART),(XQCNT<=XQEND) D
 . . S XQCNTTOT=XQCNTTOT+1
 . . N X,X1,X2,X3
 . . S X=$G(^XTV(8992.1,XQ1,0)),X1=$G(^(1)),X3=$G(^(3)),X2=$G(^(2)) Q:X=""
 . . S @ROOT@(XQCNT)=$S($P(X3,U)'="":"G  ",$P(X1,U,2,3)="^":"I  ",$P(X1,U,2,3)="":"I  ",1:"   ")_$P(X1,U)_U_$P(X,U)_$S($P(X2,U,3)'="":U_$P(X2,U,3),1:"")
 S @ROOT@(0)=PAGE_U_(XQCNT\LIMIT+$S(XQCNT#LIMIT:1,1:0)) ; @ROOT@(0)=PAGE^TOTALPAGES
 S @ROOT=XQCNTTOT
 Q
CHKTRAIL ;
 ; ZEXCEPT: FRSTDATE,LASTDATE,NCNT,ROOT,XREF,XVAL  -- from GETPAT or GETUSER
 N XQ1,X,X1,X2,X3
 F XQ1=0:0 S XQ1=$O(^XTV(8992.1,XREF,XVAL,XQ1)) Q:XQ1'>0  D
 . S X=$G(^XTV(8992.1,XQ1,0)),X1=$G(^(1)),X3=$G(^(3)),X2=$G(^(2)) Q:X=""
 . I FRSTDATE'>0,'$D(^XTV(8992,"AXQA",$P(X,U))) Q
 . I FRSTDATE>0,$P(X,U,2)<FRSTDATE Q
 . I FRSTDATE>0,LASTDATE>0,$P(X,U,2)>LASTDATE Q
 . S NCNT=NCNT+1
 . S @ROOT@(NCNT)=$S($P(X3,U)'="":"G  ",$P(X1,U,2,3)="^":"I  ",$P(X1,U,2,3)="":"I  ",1:"   ")_$P(X1,U)_U_$P(X,U)_$S($P(X2,U,3)'="":U_$P(X2,U,3),1:"") ; P443
 S @ROOT=NCNT
 Q
GETUSER1(ROOT,XQAUSER,FRSTDATE,LASTDATE,FLAG) ;Add FLAG to check for deferred alert. P653
 N NCNT,KEY
 S:$G(XQAUSER)'>0 XQAUSER=DUZ
 S:$G(FRSTDATE)'>0 FRSTDATE=0
 S:$G(LASTDATE)'>0 LASTDATE=0
 S:$G(FLAG)'>0 FLAG=0 ;P653
 I $$ACTVSURO^XQALSURO(XQAUSER)'>0 D RETURN^XQALSUR1(XQAUSER) ; P513
 S NCNT=0 K @ROOT
 I FRSTDATE=0 D  Q
 . N X,X2,X3,X4,XDEF,XCKUSER,I S I="" F  S I=$O(^XTV(8992,XQAUSER,"XQA",I),-1) Q:I'>0  S X=^(I,0),X2=$G(^(2)),X3=$G(^(3)),X4=$D(^(4)) S XDEF=$P($G(X),"^",6) D  ; P653
 . . N XNOW,XQUIT S XQUIT=0
 . . I $G(FLAG)>0 D  Q:XQUIT=1 
 . . . S XNOW=$$NOW^XLFDT()
 . . . I XDEF'="" D
 . . . . I XNOW<XDEF S XQUIT=1
 . . . . Q
 . . I $P(X,U,4)'="" D
 . . . N XQAID,XQXX,XQXY,XQADAT ; P513, update ALERT TRACKING FILE
 . . . S $P(^XTV(8992,XQAUSER,"XQA",I,0),U,4)="" ; P513 - MARK SEEN
 . . . S XQAID=$P(X,U,2) ; P513
 . . . S XQXX=$O(^XTV(8992.1,"B",XQAID,0)),XQXY=0,XQADAT=$$NOW^XLFDT() ;P513
 . . . I XQXX>0 S XQXY=$O(^XTV(8992.1,XQXX,20,"B",XQAUSER,0)) I XQXY>0 D
 . . . . I $P(^XTV(8992.1,XQXX,20,XQXY,0),U,2)="" S $P(^XTV(8992.1,XQXX,20,XQXY,0),U,2)=XQADAT
 . . . . I $P(^XTV(8992.1,XQXX,20,XQXY,0),U,3)="" S $P(^XTV(8992.1,XQXX,20,XQXY,0),U,3)=XQADAT
 . . S NCNT=NCNT+1
 . . S KEY=$S($P(X3,U)'="":"G  ",X4>1:"L  ",$P(X,U,7,8)="^ ":"I  ",1:"R  "),@ROOT@(NCNT)=KEY_$P(X,U,3)_U_$P(X,U,2)
 . . I X2'="" D
 . . . S NCNT=NCNT+1,@ROOT@(NCNT)=KEY_"-----Forwarded by: "_$$GET1^DIQ(200,($P(X2,U)_","),.01)_"   Generated: "_$$DAT8^XQALERT($P(X2,U,2),1)_U_$P(X,U,2)
 . . . I $P(X2,U,3)'="" S NCNT=NCNT+1,@ROOT@(NCNT)=KEY_"-----"_$P(X2,U,3)_U_$P(X,U,2)
 . . . Q
 . S @ROOT=NCNT
 . Q
 Q
DEFALERT(ROOT,XQAUSER1,DEFDATE,ALERTID) ;ADD DEFERRED DATE/TIME TO ALERT; FOR CPRS USE P653
 ;ROOT            =Global created to store the information
 ;XQAUSER1        =User responsible for the alert
 ;DEFDATE         =The date/time the alert is deferred til...user
 ;                 responsible sets the date...maximum of 14 days 
 ;                 from the date/time deferred.
 ;ALERTID         =ALERT ID - the IEN of the alert in file 8992 2nd piece
 ;                 of the alert date/time multiple.
 ;                 DG,IEN of file;original recipient;date/time of alert
 N NCNT,X,X1,X2,%
 S NCNT=0 K @ROOT
 S:$G(XQAUSER1)'>0 XQAUSER=DUZ
 I $G(DEFDATE)'>0 D  Q
 . S @ROOT@(1)="-1^No Deferred Date/Time has been entered. The alert will not be deferred!"
 . Q
 ; Check deferred date can't be over 14 days deferred.
 D NOW^%DTC S X1=%,X2=14 D C^%DTC
 N XDT,XFLAG S XFLAG=0,XDT=$P(ALERTID,";",3)-.00000001  ;P653
 F XDT=XDT:0 S XDT=$O(^XTV(8992,XQAUSER1,"XQA",XDT)) Q:XDT'>0!(XFLAG=1)  I $D(^XTV(8992,XQAUSER1,"XQA",XDT,0)) D  Q:XFLAG=1  ;P653
 .I $P(^XTV(8992,XQAUSER1,"XQA",XDT,0),"^",2)=ALERTID S XFLAG=1 Q  ;P653
 I DEFDATE>X D  Q
 . S @ROOT@(1)="-1^Deferred Date/Time is greater than 14 days in the future. The alert will not be deferred!"
 . Q
 S DA(1)=XQAUSER1
 S DA=XDT
 S DIE="^XTV(8992,"_DA(1)_","_"""XQA"""_","
 S DR=".06///^S X=DEFDATE"
 ;Lock Subentry
 L +^XTV(8992,XQAUSER1,"XQA",DA):10
 ;Update value
 D ^DIE
 K DA,DIE,DR
 ;Unlock subentry
 ;L -^XTV(8992,XQAUSER1,"XQA",DA)
 Q
 ;. . . I XCKUSER=XQAUSER&(XNOW<XDEF) S XQUIT=1
 Q
GETPAT3(ROOT,PATIENT,XFROM,XTO) ;
 N XREF,XVAL,NCNT,XQ1,XQCNT,XQSTART,XQEND,X,XDATE,X1,X2,X3
 S NCNT=0 K @ROOT
 I $G(PATIENT)'>0 S @ROOT=0 Q
 S XREF="C"
 S XVAL=PATIENT
 S XQ1="",XQCNT=0
 F  S XQ1=$O(^XTV(8992.1,XREF,XVAL,XQ1),-1) Q:'XQ1  D
 . S X=$G(^XTV(8992.1,XQ1,0)) Q:X=""
 . Q:'$D(^XTV(8992,"AXQA",$P(X,U)))
 . S XDATE=$P(X,U,2)
 . I XDATE'<XFROM,XDATE'>XTO D
 . . S XQCNT=XQCNT+1
 . . S X1=$G(^XTV(8992.1,XQ1,1)),X3=$G(^(3)),X2=$G(^(2))
 . . S @ROOT@(XQCNT)=$S($P(X3,U)'="":"G ",$P(X1,U,2,3)="^":"I ",$P(X1,U,2,3)="":"I ",1:" ")_$P(X1,U)_U_$P(X,U)_$S($P(X2,U,3)'="":U_$P(X2,U,3),1:"")
 S @ROOT@(0)=XQCNT
 Q
