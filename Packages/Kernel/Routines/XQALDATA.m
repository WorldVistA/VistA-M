XQALDATA ;ISC/JLI ISD/HGW - PROVIDE DATA ON ALERTS ;Jan 27, 2022@10:18
 ;;8.0;KERNEL;**207,285,443,513,602,653,734,662**;Jul 10, 1995;Build 49
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
 I $$ACTVSURO^XQALSURO(XQAUSER)'>0 D
 . D RETURN^XQALSUR1(XQAUSER) ; P513
 . ;D RETURN(XQAUSER) ; p734
 ; p734
 N SURFOR D SUROFOR^XQALSURO(.SURFOR,XQAUSER) I SURFOR D FORWARD(.SURFOR,XQAUSER)
 ;
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
GETUSER2(ROOT,XQAUSER,FRSTDATE,LASTDATE,MAXRET,PROONLY,FLAG) ;Get PROCESSED alerts rather than pending alerts p662
 N NCNT,KEY,TYPNODE,RTYP,SURRFOR,PROCBY,SURRDA,FWDNM,FWDDT,LASTTYPE
 N RETURN
 S NCNT=0 K @ROOT
 S @ROOT=NCNT
 S:$G(XQAUSER)'>0 XQAUSER=DUZ
 S:$G(FRSTDATE)'>0 FRSTDATE=0
 S:$G(LASTDATE)'>0 LASTDATE=0
 S:$G(FLAG)'>0 FLAG=0
 I $$ACTVSURO^XQALSURO(XQAUSER)'>0 D RETURN^XQALSUR1(XQAUSER)
 N X,X1,X2,X3,X4,X20,XDEF,XCKUSER,PDATE,RECIPDA,XDA,XMDA
 S RECIPDA=XQAUSER Q:'$D(^XTV(8992.1,"PAR",XQAUSER))  D
 . S PDATE=FRSTDATE I PDATE'=0 S PDATE=PDATE-.000001
 . F  S PDATE=$O(^XTV(8992.1,"PAR",RECIPDA,PDATE)) Q:PDATE>LASTDATE!(PDATE="")  D
 . . S XDA="" F  S XDA=$O(^XTV(8992.1,"PAR",RECIPDA,PDATE,XDA)) Q:XDA=""  I $D(^XTV(8992.1,XDA)) D
 . . . S XMDA="" F  S XMDA=$O(^XTV(8992.1,"PAR",RECIPDA,PDATE,XDA,XMDA)) Q:XMDA=""  D
 . . . . S X=$G(^XTV(8992.1,XDA,0)),X1=$G(^(1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4))
 . . . . S X20(0)=$G(^XTV(8992.1,XDA,20,XMDA,0))
 . . . . S (SURRFOR,PROCBY,RTYP,SURRDA,RETURN,FWDNM,FWDDT,LASTTYPE)=""
 . . . . S RETURN=$P($G(^XTV(8992.1,XDA,20,XMDA,3,1,0)),U,3)
 . . . . I RETURN Q
 . . . . S LASTTYPE=$O(^XTV(8992.1,XDA,20,XMDA,1,999999999),-1)
 . . . . S TYPNODE=$G(^XTV(8992.1,XDA,20,XMDA,1,LASTTYPE,0))
 . . . . I $P(TYPNODE,U)]"" S RTYP=$G(^XTV(8992.2,$P(TYPNODE,U),0))
 . . . . I RTYP="FWD BY USER" D
 . . . . . N LASTFWD,FWD0
 . . . . . S LASTFWD=$O(^XTV(8992.1,XDA,20,XMDA,2,999999999),-1)
 . . . . . S FWD0=$G(^XTV(8992.1,XDA,20,XMDA,2,LASTFWD,0))
 . . . . . S FWDNM=+$P(FWD0,U,3)
 . . . . . I +FWDNM>0 D
 . . . . . . S FWDDT=$TR($$FMTE^XLFDT($P(FWD0,U,1),2),"@"," ")
 . . . . . . S FWDNM=$P($G(^VA(200,FWDNM,0)),U)_"   "_FWDDT
 . . . . N I,BEST S (I,BEST)=0 F  S I=$O(^XTV(8992.1,XDA,20,I)) Q:'I  D
 . . . . . N TMP0 S TMP0=$G(^XTV(8992.1,XDA,20,I,0))
 . . . . . I $P(TMP0,U,4),'$P($G(^XTV(8992.1,XDA,20,I,3,1,0)),U,3) D  ; if recipient has processed, excluding returned from surrogate
 . . . . . . I $P(TMP0,U,4)>BEST S BEST=$P(TMP0,U,4),PROCBY=$P($G(^VA(200,$P(TMP0,U),0)),U)
 . . . . I PROCBY="" S PROCBY="UNKNOWN"
 . . . . S SURRDA=$P($G(^XTV(8992.1,XDA,20,XMDA,3,1,0)),U)
 . . . . I SURRDA]"" S SURRFOR=$P($G(^VA(200,SURRDA,0)),U)
 . . . . S NCNT=NCNT+1
 . . . . I MAXRET,NCNT>MAXRET Q
 . . . . S KEY=$S($P(X3,U)'="":"G  ",X4>1:"L  ",$P(X1,U,3,4)="^ ":"I  ",1:"R  "),@ROOT@(NCNT)=KEY_$P(X1,U)_U_$P(X,U),@ROOT@(NCNT,"PROCESSED")=$P(X20(0),U,2)_U_$P(X20(0),U,3)_U_$P(X20(0),U,4)_U_$P(X20(0),U,5)_U_RTYP_U_PROCBY_U_SURRFOR_U_FWDNM
 I MAXRET,NCNT>MAXRET S NCNT=MAXRET
 S @ROOT=NCNT
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
 I DEFDATE>X D  Q
 . S @ROOT@(1)="-1^Deferred Date/Time is greater than 14 days in the future. The alert will not be deferred!"
 . Q
 ; Check if surrogacy is before DEFDATE. p734
 N SURFOR D SUROFOR^XQALSURO(.SURFOR,XQAUSER1) I SURFOR D
 . N USERS D USERLIST^XQALBUTL($G(ALERTID),$NAME(USERS)) I $D(USERS)>9 D
 . . N COMUSERS D COMMON(.SURFOR,.USERS,.COMUSERS) I COMUSERS D
 . . . N DEFDATE1 S DEFDATE1=$$MINEND(.COMUSERS,DEFDATE)
 . . . I DEFDATE1<DEFDATE S DEFDATE=DEFDATE1,@ROOT@(1)="1^Deferred Date set to end of surrogacy: "_DEFDATE
 ;
 N XDT,XFLAG S XFLAG=0,XDT=$P(ALERTID,";",3)-.00000001  ;P653
 F XDT=XDT:0 S XDT=$O(^XTV(8992,XQAUSER1,"XQA",XDT)) Q:XDT'>0!(XFLAG=1)  I $D(^XTV(8992,XQAUSER1,"XQA",XDT,0)) D  Q:XFLAG=1  ;P653
 .I $P(^XTV(8992,XQAUSER1,"XQA",XDT,0),"^",2)=ALERTID S XFLAG=1 Q  ;P653
 I 'XFLAG D  Q  ; p734
 . S @ROOT@(1)="-1^No match on alert id. The alert will not be deferred!"
 . Q
 S DA(1)=XQAUSER1
 S DA=XDT
 S DIE="^XTV(8992,"_DA(1)_","_"""XQA"""_","
 S DR=".06///^S X=DEFDATE"
 ;Lock Subentry
 L +^XTV(8992,XQAUSER1,"XQA",DA):10
 ;Update value
 D ^DIE
 ;Unlock subentry
 L -^XTV(8992,XQAUSER1,"XQA",DA) ; p734
 K DA,DIE,DR
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
 ;
COMMON(SURFOR,USERS,RES) ; List of users common in SURFOR and USERS. p734
 N I,J,K
 K RES S RES=0
 Q:'$G(SURFOR)
 Q:$D(USERS)<10
 S K=0
 S I=0 F  S I=$O(SURFOR(I)) Q:'I  D
 . S J=0 F  S J=$O(USERS(J)) Q:'J  D
 . . I $P(USERS(J),U)=$P(SURFOR(I),U) S K=K+1,RES(K)=SURFOR(I)
 S RES=K
 Q
 ;
MINEND(SURFOR,ENDDATE)  ; Minimum of ENDDATE and end dates in surrogacy. p734
 N XQI
 Q:'$G(SURFOR) $G(ENDDATE)
 S ENDDATE=$G(ENDDATE,$$FMADD^XLFDT($$NOW^XLFDT,100))
 F XQI=1:1:SURFOR D
 . N X
 . S X=$P(SURFOR(XQI),U,4)
 . Q:X=""  ; surrogacy with no end date
 . S X=$$ETFM(X) Q:'X
 . I X<ENDDATE S ENDDATE=X
 Q ENDDATE
 ;
ETFM(EXDATE)    ; p734 external to internal FM date
 N %DT,X,Y S %DT="TS"
 S X=$G(EXDATE) D ^%DT
 Q Y
 ;
FORWARD(SURFOR,SURR) ; p734 Forward deferred-alerts to current surrogate
 Q:'$G(SURFOR)
 N I,IEN,XQAUSER
 ; for each original recipient
 S I=0 F  S I=$O(SURFOR(I)) Q:'I  S XQAUSER=$P(SURFOR(I),U) D
 . S IEN=0 F  S IEN=$O(^XTV(8992,XQAUSER,"XQA",IEN)) Q:'IEN  D
 . . ; for each deferred alert by recipient, forward to surrogate
 . . N BEGDATE,DEFDATE,ENDDATE,FWD,XQA,XQALERT,XQACMNT,XQALTID,XQALTYPE
 . . S BEGDATE=$$ETFM($P(SURFOR(I),U,3)),ENDDATE=$$ETFM($P(SURFOR(I),U,4))
 . . S XQALERT=$G(^XTV(8992,XQAUSER,"XQA",IEN,0)),DEFDATE=$P(XQALERT,U,6),XQAID=$P(XQALERT,U,2)
 . . S XQALTID=$O(^XTV(8992.1,"B",XQAID,0)),FWD=$D(^XTV(8992.1,XQALTID,20,"B",SURR)) ; been fwd to surr?
 . . I ENDDATE<0 S ENDDATE=DEFDATE ; surrogacy has no end date
 . . I DEFDATE'="",(DEFDATE>=BEGDATE),(DEFDATE<=ENDDATE),'FWD D
 . . . S $P(^XTV(8992,XQAUSER,"XQA",IEN,0),U,6)="" ; clear deferred date before forwarding
 . . . S XQA(SURR)="",XQACMNT="DEFERRED BY INITIAL RECIPIENT",XQALTYPE="FWD TO SURROGATE"
 . . . D FORWARD^XQALFWD($P(XQALERT,U,2),SURR,"A",XQACMNT)
 . . . S $P(^XTV(8992,XQAUSER,"XQA",IEN,0),U,6)=DEFDATE ; restore after forwarding
 . . . ;N XQAID S XQAID=$P(XQALERT,U,2) D DELETE^XQALERT
 Q
 ;
RETURN(XQAUSER) ; p734 - return surrogate-deferred alerts to the user
 Q:'$G(XQAUSER)
 N IEN,IEN2,END,RCPNT,SURR,SURR0
 ; for each surrogate that had XQAUSER as original recipient in the past
 S SURR=0,IEN=0 F  S IEN=$O(^XTV(8992,XQAUSER,2,IEN)) Q:'IEN  D
 . S SURR0=$G(^XTV(8992,XQAUSER,2,IEN,0)),SURR=$P(SURR0,U,2),END=$P(SURR0,U,3) D:SURR
 . . S RCPNT="",IEN2=0 F  S IEN2=$O(^XTV(8992,SURR,"XQA",IEN2)) Q:IEN2=""  D
 . . . S RCPNT=$G(^XTV(8992,SURR,"XQA",IEN2,2)) I $P(RCPNT,U)=XQAUSER,END'="",END<$$NOW^XLFDT D
 . . . . ; for each alert still in surrogate, return to original recipient
 . . . . N XQA,XQAID,XQALERT,XQACMNT,XQALTYPE
 . . . . S XQALERT=$G(^XTV(8992,SURR,"XQA",IEN2,0)),XQAID=$P(XQALERT,U,2) Q:XQAID=""
 . . . . S XQA(1)=XQAUSER,XQACMNT="RESTORED FROM SURROGATE",XQALTYPE="RESTORE FROM SURROGATE"
 . . . . N XQAUSER S XQAUSER=SURR D FORWARD^XQALFWD(XQAID,.XQA,"A",XQACMNT)
 . . . . D DELETE^XQALERT
 Q
 ;
