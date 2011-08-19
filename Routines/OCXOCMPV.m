OCXOCMPV ;SLC/RJS,CLA - ORDER CHECK CODE COMPILER (Main Entry point - All Rules  cont...) ;1/05/04  14:09
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,105,221,243**;Dec 17,1997;Build 242
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
MAN ;
 I '$D(DUZ) W !!,"DUZ not defined." Q
 N OCXD0,OCXD1,OCXWARN,OCXNAM,OCXTRACE,OCXOETIM,OCXAUTO,OCXERRM,OCXTSPI
 S OCXWARN=0,OCXOETIM=$H
 K ^TMP("OCXCMP",$J)
 S ^TMP("OCXCMP",$J)=($P($H,",",2)+($H*86400)+(2*60*60))_" <- ^TMP ENTRY EXPIRATION DATE FOR ^OCXOPURG"
 ;
 ;  Compiler Constants
 ;
 S OCXCLL=200      ; compiled code line length
 S OCXCRS=4000     ; compiled routine size
 S OCXTSPI=300     ; Duplicate triggered Rule message "ignore period" in seconds
 ;
 S OCXTRACE=0,OCXTLOG=0,OCXDLOG=0,OCXAUTO=0,OCXERRM=""
 ;
 S OCXTRACE=$$READ("Y","Want to enable Compiled Routine Execution Display ","NO") Q:(OCXTRACE[U)
 S OCXDLOG=$$READ("Y","Want to enable Logging of incoming raw data ","NO") Q:(OCXDLOG[U)
 I OCXDLOG S OCXDLOG=$$READ("N^1:20","Number of days to keep raw data ","3") Q:(OCXDLOG[U)
 I OCXDLOG W !!,"*** Note: The raw data log will only hold 200,000 entries. *****",!
 I 0 I OCXDLOG S OCXTLOG=$$READ("Y","Want to enable Elapsed Time Logging ","YES") Q:(OCXTLOG[U)
 ;
 Q:'$$READ("Y","Are you sure you want to recompile the Expert System routines ","NO")
 ;
 D SETFLAG
 L +^OCXD(861,1):5 E  D ERMESG("Run aborted. Another compiler run has ^OCXD(861,1) locked.") Q
 D RUN^OCXOCMP,BULL(DUZ),KILLFLAG
 L -^OCXD(861,1)
 ;
 ;K ^TMP("OCXCMP",$J)
 ;
 Q
 ;
MESG(OCXX) ;
 I '$G(OCXAUTO) W !!,OCXX
 I ($G(OCXAUTO)=1) D BMES^XPDUTL(.OCXX)
 Q
 ;
ERMESG(OCXX) ;
 N OCXY S OCXY=OCXX
 I '$G(OCXAUTO) W !!,OCXX
 I ($G(OCXAUTO)=1) D BMES^XPDUTL(.OCXX)
 S OCXERRM=OCXY
 Q
 ;
WARN(X,FILE,D0,RLINE) ;
 ;
 Q:$G(OCXWARN)
 ;
 S OCXWARN=1
 ;
 I $G(OCXAUTO) D  Q
 .D MESG(" Error... "_X)
 .D MESG(" Error...  File:"_(+$G(FILE)))
 .D MESG(" Error... Index:"_(+$G(D0)))
 .D MESG(" Error... Order Check Routine Compile Aborted.")
 ;
 S OCXWARN=$G(OCXWARN)+1
 N OCXSP,OCXST,OCXTXT,OCXLEN,OCXZZZ,OCXCNT
 S OCXLEN=60,OCXTXT="Compiler Warning # "_OCXWARN
 I ($D(X)>2) S OCXCNT=0 F  S OCXCNT=$O(X(OCXCNT)) Q:'OCXCNT  D
 .I ($L(X(OCXCNT))>OCXLEN),($L(X(OCXCNT))<80) S OCXLEN=$L(X(OCXCNT))
 S (OCXSP,OCXST)="",$P(OCXST,"*",150)="*",$P(OCXSP," ",150)=" "
 W !!
 W !,$E(OCXST,1,OCXLEN+6)
 W !,"**",$E(OCXSP,1,OCXLEN+2),"**"
 W !,"** ",OCXTXT,$E(OCXSP,$L(OCXTXT),OCXLEN-1)," **"
 W:$L($G(RLINE)) !,"** ",RLINE,$E(OCXSP,$L(RLINE),OCXLEN-1)," **"
 W !,"**",$E(OCXSP,1,OCXLEN+2),"**"
 S OCXGL="^OCXS" S:(FILE=1) OCXGL="^OCXD" S:(FILE=7) OCXGL="^OCXD" S:(FILE=10) OCXGL="^OCXD" S FILE=FILE/10+860
 I $G(FILE),$G(D0),$D(@OCXGL@(FILE,D0,0)) D
 .S OCXTXT=$P(@OCXGL@(FILE,0),U,1)
 .W !,"** ",OCXTXT,$E(OCXSP,$L(OCXTXT),OCXLEN-1)," **"
 .S OCXTXT="   "_$P(@OCXGL@(FILE,D0,0),U,1)
 .W !,"** ",OCXTXT,$E(OCXSP,$L(OCXTXT),OCXLEN-1)," **"
 W !,"**",$E(OCXSP,1,OCXLEN+2),"**"
 I ($D(X)#2) D
 .W !,"** " F OCXCNT=1:1:$L(X," ") D
 ..I (($X+$L($P(X," ",OCXCNT)))>OCXLEN) W $E(OCXSP,$X,OCXLEN+2)," **",!,"** "
 ..W $P(X," ",OCXCNT)," "
 .W $E(OCXSP,$X,OCXLEN+2)," **"
 I ($D(X)>2) S OCXCNT=0 F  S OCXCNT=$O(X(OCXCNT)) Q:'OCXCNT  D
 .W !,"** ",X(OCXCNT),$E(OCXSP,$X,OCXLEN+2)," **"
 W !,$E(OCXST,1,OCXLEN+6)
 W !!!,"Press <Return> to continue... " R OCXZZZ:DTIME
 Q
 K D0
 ;
READ(OCXZ0,OCXZA,OCXZB,OCXZL) ;
 N OCXLINE,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q:'$L($G(OCXZ0)) U
 S DIR(0)=OCXZ0
 S:$L($G(OCXZA)) DIR("A")=OCXZA
 S:$L($G(OCXZB)) DIR("B")=OCXZB
 F OCXLINE=1:1:($G(OCXZL)-1) W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q U
 Q Y
 ;
 Q
 ;
DT(X,D) N Y,%DT S %DT=D D ^%DT Q Y
 Q
 ;
CNT(X) ;
 ;
 N CNT,D0
 S D0=0 F CNT=1:1 S D0=$O(@X@(D0)) Q:'D0
 W !!,?10,X,"  ",CNT
 Q CNT
 ;
AUTO ;
 N OCXD0,OCXD1,OCXWARN,OCXNAM,OCXTRACE,OCXAUTO,OCXOETIM,OCXTSPI
 S OCXWARN=0,OCXOETIM=$H
 K ^TMP("OCXCMP",$J)
 S ^TMP("OCXCMP",$J)=($P($H,",",2)+($H*86400)+(2*60*60))_" <- ^TMP ENTRY EXPIRATION DATE FOR ^OCXOPURG"
 ;
 ;  Compiler Constants
 ;
 S OCXCLL=200      ; compiled code line length
 S OCXCRS=8000     ; compiled routine size
 S OCXTSPI=300     ; Duplicate triggered Rule message "ignore period" in seconds
 ;
 S OCXTRACE=0      ; Program Execution Trace Mode (OFF)
 S OCXTLOG=0       ; Elapsed time logging (OFF)
 S OCXDLOG=0       ; Raw Data Logging (OFF)
 S OCXAUTO=1       ; Compile in the Background Mode (ON)
 ;
 D SETFLAG
 L +^OCXD(861,1):5 E  D ERMESG("Run aborted. Another compiler run has ^OCXD(861,1) locked."),BULL(DUZ),KILLFLAG Q
 D RUN^OCXOCMP,BULL(DUZ),KILLFLAG
 L -^OCXD(861,1)
 ;
 K ^TMP("OCXCMP",$J)
 ;
 Q
 ;
BULL(OCXDUZ) ;
 I $L($T(^XMB)) D
 .;
 .N XMB,XMDUZ,XMY,OCXTIME
 .S OCXTIME=$H-OCXOETIM*86400
 .S OCXTIME=OCXTIME+($P($H,",",2)-$P(OCXOETIM,",",2))
 .S XMB="OCX COMPILER RUN"
 .S XMB(1)=$P($T(+3),";;",3)
 .S XMB(2)=$$CONV($$DATE)
 .S XMB(3)=""
 .S:$G(OCXDUZ) XMB(3)="["_OCXDUZ_"]  "_$P($G(^VA(200,OCXDUZ,0)),U,1)
 .S XMB(4)=(OCXTIME\60)_" minutes "_(OCXTIME#60)_" seconds "
 .S XMB(5)=$S(($G(OCXAUTO)>1):"Queued",$G(OCXAUTO):"Automatic Mode",1:"Interactive Mode")
 .S XMB(6)=$S($G(OCXTRACE):" ON",1:"OFF")
 .S XMB(7)=" " ; $S($G(OCXTLOG):" ON",1:"OFF")
 .S XMB(8)=$S($G(OCXDLOG):(" ON  Keep data for "_OCXDLOG_" day"_$S(OCXDLOG=1:"",1:"s")_" then purge."),1:"OFF")
 .S XMB(9)="No longer tracked" ; $S($G(OCXLCNT):OCXLCNT,1:"Zero")
 .S XMB(10)=$G(OCXERRM)
 .S XMB(11)=$S($L($G(OCXERRM)):"ABORTED",1:"has completed normally")
 .S XMY("G.OCX DEVELOPERS@ISC-SLC.VA.GOV")=""
 .S XMY("G.OCX DEVELOPERS")=""
 .S XMY(OCXDUZ)=""
 .S XMDUZ=.5
 .S XMDT="N"
 .D ^XMB
 ;
 Q
 ;
DATE() N X,Y,%DT S X="N",%DT="T" D ^%DT X ^DD("DD") Q Y
 ;
CONV(Y) Q:'(Y["@") Y Q $P(Y,"@",1)_" at "_$P(Y,"@",2,99)
 ;
SETFLAG ;
 I '($P($G(^OCXD(861,1,0)),U,1)="SITE PREFERENCES") K ^OCXD(861,1) S ^OCXD(861,1,0)="SITE PREFERENCES"
 S $P(^OCXD(861,1,0),U,3)=$H
 Q
 ;
KILLFLAG ;
 ;
 I '($P($G(^OCXD(861,1,0)),U,1)="SITE PREFERENCES") K ^OCXD(861,1) S ^OCXD(861,1,0)="SITE PREFERENCES"
 S $P(^OCXD(861,1,0),U,3)=""
 Q
 ;
QUE(OCXADD) ;
 ;
 N ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTPAR,ZTPRE,ZTPRI,ZTRTN,ZTSAVE,ZTSK,ZTUCI
 N OCXDUZ
 ;
 S ZTDTH=$P($H,",",2)+OCXADD,OCXADD=0
 I (ZTDTH>86400) S ZTDTH=(86400-ZTDTH),OCXADD=1
 S ZTDTH=($H+OCXADD)_","_ZTDTH
 S OCXDUZ=$G(DUZ)
 S ZTIO="",ZTRTN="TASK^OCXOCMPV",ZTDESC="Queued Compiler: "_$P($T(+3),";;",2)
 K ZTSAVE,ZTCPU,ZTUCI,ZTPRI,ZTPAR,ZTPRE
 S ZTSAVE("OCXDUZ")=""
 ;
 D ^%ZTLOAD
 ;
 Q
 ;
TASK ;
 ;
 N OCXD0,OCXD1,OCXWARN,OCXNAM,OCXTRACE,OCXAUTO,OCXOETIM,OCXTSPI
 S OCXWARN=0,OCXOETIM=$H
 K ^TMP("OCXCMP",$J)
 S ^TMP("OCXCMP",$J)=($P($H,",",2)+($H*86400)+(2*60*60))_" <- ^TMP ENTRY EXPIRATION DATE FOR ^OCXOPURG"
 ;
 ;  Compiler Constants
 ;
 S OCXCLL=200      ; compiled code line length
 S OCXCRS=8000     ; compiled routine size
 S OCXTSPI=300     ; Duplicate triggered Rule message "ignore period" in seconds
 ;
 S OCXDATA="0^0^0"
 I $L($T(CDATA^OCXOZ01)) S OCXDATA=$$CDATA^OCXOZ01
 ;
 S OCXTRACE=$P(OCXDATA,U,1),OCXTLOG=$P(OCXDATA,U,2),OCXDLOG=$P(OCXDATA,U,3)
 ;
 S OCXAUTO=2       ; Compile in the Background Mode (ON QUEUED)
 ;
 D SETFLAG
 L +^OCXD(861,1):5 E  D QUE^OCXOCMPV(300),ERMESG("Run rescheduled. Another compiler run has ^OCXD(861,1) locked."),BULL(OCXDUZ),KILLFLAG Q
 D RUN^OCXOCMP,BULL(OCXDUZ),KILLFLAG
 L -^OCXD(861,1)
 ;
 K ^TMP("OCXCMP",$J)
 ;
 I $G(ZTSK) D KILL^%ZTLOAD
 ;
 Q
 ;
