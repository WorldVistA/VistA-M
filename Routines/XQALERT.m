XQALERT ;ISC-SF.SEA/JLI - ALERT HANDLER ;5/4/05  10:25
 ;;8.0;KERNEL;**1,65,125,173,285,366**;Jul 10, 1995
 ;;
 Q
 ;
SETUP ;SR.
 D SETUP^XQALSET
 Q
 ;
SETUP1() ;SR.
 N I S I=$$SETUP1^XQALSET()
 Q I
 ;
DISPLAY ;SR. Display any new alerts
 Q:$O(^XTV(8992,DUZ,"XQA",0))'>0
 N X,XQI,XQX,XQX1,DIR,XQA,Y,XQON,XQOFF,XQ1ON,XQ1OFF,XQXDAT S XQX=0,XQX1=0,Y=1,DIR(0)="E" ; P285
 I $$ACTVSURO^XQALSURO(DUZ)'>0 D RETURN^XQALSUR1(DUZ) ; P366
 F XQI=0:0 D:XQX1&'(XQX1#20) ^DIR Q:'Y  S XQI=$O(^XTV(8992,DUZ,"XQA",XQI)) Q:XQI'>0  S XQX=XQX+1,X=$G(^XTV(8992,DUZ,"XQA",XQI,0)) I $P(X,U,4) D
 . N XQXXX,XQXX,XQXY
 . S XQXXX=X,(XQXX,XQXY)=0,XQXX=$P(X,U,2) I XQXX'="" S XQXX=$O(^XTV(8992.1,"B",$E(XQXX,1,50),0)) I XQXX>0 S XQXY=$O(^XTV(8992.1,XQXX,20,"B",DUZ,0)) I XQXY>0 S XQXDAT=$$NOW^XLFDT(),$P(^XTV(8992.1,XQXX,20,XQXY,0),U,2)=XQXDAT ; P173
 . S XQON="$C(0)",XQOFF="$C(0)"
 . S XQOUT=$P(XQXXX,U,3) I ($$UP^XLFSTR(XQOUT)["CRITICAL")!($$UP^XLFSTR(XQOUT)["ABNORMAL IMA") D:'$D(XQ1ON) SETREV S XQON=XQ1ON,XQOFF=XQ1OFF ; P285 modified to highlight critical and abnormal imaging alerts
 . S X=XQXXX W:XQX1=0 $C(7) W !,@XQON,$P(X,U,3),@XQOFF S XQX1=XQX1+1,$P(^XTV(8992,DUZ,"XQA",XQI,0),U,4)="" I $D(^(2)) S X1=^(2) D  ; P285
 . . S X2=$P(X1,U,3)
 . . W !?5,"*** FORWARDED BY: ",$P(^VA(200,+X1,0),U),"   Generated: " S X1=$P($P(X,U,2),";",3) W $$DAT8(X1,1)
 . . I X2'="" W !?5,X2
 . I $P(X,U,5)="D" S XQA=$P(X,U,2) K ^XTV(8992,DUZ,"XQA",XQI) D  S XQX=XQX-1 D:XQA'="" D
 . . I $G(XQXX)>0,$G(XQXY)>0 S $P(^XTV(8992.1,XQXX,20,XQXY,0),U,5)=XQXDAT
 . K XQXX,XQXY
 I XQX>0 W:XQX1=0 !!,"You have PENDING ALERTS" W !?10,"Enter  ""VA to jump to VIEW ALERTS option",! ; ISL-0898-51279
 W:XQX1>0 !
 K XQI,XQX,XQX1,DIR,XQA,Y
 Q
D K ^XTV(8992,"AXQA",XQA,DUZ),^XTV(8992,"AXQAN",$P(XQA,";"),DUZ)
 Q
 ;
 ;
DAT8(FMDAT,TFLG) ;
 N X
 S X=$E(FMDAT,4,5)_"/"_$E(FMDAT,6,7)_"/"_$E(FMDAT,2,3)
 I $G(TFLG)>0 S FMDAT=FMDAT_"0000000",X=X_" "_$E(FMDAT,9,10)_":"_$E(FMDAT,11,12)_":"_$E(FMDAT,13,14)
 Q X
DOIT ;OPT. Process Alerts
 N XQALAST,XQALFWD,XQAUSER K DTOUT,DIRUT,DUOUT,DIROUT
 S XQAUSER=DUZ D DOIT^XQALERT1,COUNT^XQALDEL(0,XQAUSER)
 Q
 ;
DELETE ;
 D DELETE^XQALDEL
 Q
 ;
DELETEA ;
 D DELETEA^XQALDEL
 Q
 ;
OLDDEL ;OPT.
 D OLDDEL^XQALDEL
 Q
 ;
USERDEL ;OPT.
 D USERDEL^XQALDEL
 Q
 ;
USER(ROOT,XQAUSER,FRSTDATE,LASTDATE) ; Returns current alerts for the user in an array located under root
 I '$D(XQAUSER) S XQAUSER=DUZ
 I $$ACTVSURO^XQALSURO(XQAUSER)'>0 D RETURN^XQALSUR1(XQAUSER) ; P366
 D GETUSER^XQALDATA(ROOT,XQAUSER,$G(FRSTDATE),$G(LASTDATE))
 Q
 ;
PATIENT(ROOT,PATIENT,FRSTDATE,LASTDATE) ;
 I $G(PATIENT)'>0 Q
 D GETPAT^XQALDATA(ROOT,PATIENT,$G(FRSTDATE),$G(LASTDATE))
 Q
ACTION(ALERTID) ;
 D ACTION^XQALDOIT(ALERTID)
 Q
GETACT(ALERTID) ; Return to calling routine the information needed to act on
 ; the specified alert.
 ; On return the following variables are defined:
 ;  XQAID = the full alert id
 ;  XQADATA = Any data passed as XQADATA at the time the alert was generated
 ;  XQAROU  = Indicates routine to be run (includes tag if necessary)
 ;    This value may have three meanings
 ;      1.  A null value indicates no routine to be used (XQAOPT contains
 ;          option name to be run)
 ;      2.  A value of ^<space>  indicates that the alert is information
 ;          only (no routine or option action involved).
 ;      3.  The name of the routine as ^ROUTINE  or TAG^ROUTINE
 ;  XQAOPT  = Indicates the name of the option to be run if not null.
 ;
 N XQX,XQZ,XQAGETAC
 S XQAGETAC=1,XQX="",XQZ=""
 D ACTION^XQALDOIT(ALERTID)
 S XQAID=$P(XQX,U,2)
 S XQADATA=$S(XQZ'="":XQZ,1:$P(XQX,U,9,99))
 S XQAROU=$S($P(XQX,U,8)="":"",1:$P(XQX,U,7,8))
 S XQAOPT=$S($P(XQX,U,8)="":$P(XQX,U,7),1:"")
 Q
 ;
SETREV ; Set on (XQ1ON) and off (XQ1OFF) variables for Reverse video ; P285
 N XQ1ON1,XQ1OFF1
 S XQ1ON="$C(0)",XQ1OFF="$C(0)" I IOST(0)>0 D
 . S XQ1ON1=$$GET1^DIQ(3.2,IOST(0)_",",14) I XQ1ON1'="" S XQ1ON=XQ1ON1
 . S XQ1OFF1=$$GET1^DIQ(3.2,IOST(0)_",",15) I XQ1OFF1'="" S XQ1OFF=XQ1OFF1
 . Q
 Q
