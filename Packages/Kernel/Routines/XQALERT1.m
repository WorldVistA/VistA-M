XQALERT1 ;ISC-SF.SEA/JLI - ALERT HANDLER ;4/9/07  14:54
 ;;8.0;KERNEL;**20,65,114,123,125,164,173,285,366,443**;Jul 10, 1995;Build 4
 ;;
 Q
 ;
DOIT I $D(XQX1),XQX1'>0 K XQX1
 I $D(XQAID) D  I '$D(XQAID) G EXIT
 . N XQACHOIC,REASK S REASK=0
 . I '$D(XQX1),$O(^XTV(8992,XQAUSER,"XQA",+$O(^XTV(8992,XQAUSER,"XQA",0))))'>0,$G(XQAROUX)="^ " S XQAROU=""
AGAIN . S XQACHOIC="Y:YES;N:NO;C:CONTINUE;",XQAQ("?")="Enter Y (or C) to continue, N to exit alert processing"
 . S XQACHOIC=$G(XQACHOIC)_"F:FORWARD ALERT;R:RENEW(MAKE NEW AGAIN);" S XQAQ("?",1)="Enter F to forward this alert to someone else",XQAQ("?",2)="Enter R to Renew (Make New) this alert"
 . D  I REASK=1 G AGAIN
 . . S REASK=0 W !! K DIR S DIR(0)="SA^"_XQACHOIC,DIR("A")=$S(XQACHOIC["F:":"Continue (Y/N) or F(orward) or R(enew) ",1:"Continue Processing (Y/N) "),DIR("B")="YES" M DIR("?")=XQAQ("?") D ^DIR K DIR
 . . I $D(DUOUT)!$D(DIRUT) S Y="N" K DUOUT,DIRUT
 . . I Y="N" D:$D(XQAKILL) DELETEA^XQALERT K XQAID
 . . I Y="R" S REASK=REASK+1 K XQAKILL I '$D(^XTV(8992,"AXQA",XQAID,DUZ)) D RESTORE
 . . I Y="F" D:'$D(^XTV(8992,"AXQA",XQAID,DUZ)) RESTORE D FRWRDONE S REASK=REASK+1
 . . Q
 . Q
 I $D(XQAKILL) D DELETEA^XQALERT
 S XQAREV=1,XQXOUT=0,XQK=0,XQACNT=0 K XQADATA,XQAID,XQAROU,XQAKILL,XQAROUX
 I '$D(XQX1) S XQX1=0 K ^TMP("XQ",$J,"XQA"),^("XQA1"),^("XQA2") I $O(^XTV(8992,XQAUSER,"XQA",0))'>0 K XQX1 D:'$G(^TMP("XQALERT1",$J,"NOTFIRST")) CHKSURO G:$O(^XTV(8992,XQAUSER,"XQA",0))'>0 EXIT S XQX1=0 ; P366
 I $$ACTVSURO^XQALSURO(XQAUSER)'>0 D RETURN^XQALSUR1(XQAUSER) ; P366
 S ^TMP("XQALERT1",$J,"NOTFIRST")=1 ; Added 2/2/99 jli to clear flag for initial entry
 ;Sort and remove display only
 I 'XQX1 W !!! D
 . D SORT
 ; Now display them.
SUBLOOP W @IOF
 N XQZ1,XQZ
 S XQK=0 F XQI=0:0 Q:XQX1!XQXOUT  S XQI=$O(^TMP("XQ",$J,"XQA",XQI)) Q:XQI'>0  S XQX=^(XQI),XQII=^(XQI,1),XQZ=^(2),XQZ1=^(3),XQZ4=^(4) D  I XQX'="" D DOIT1
 . I '$D(^XTV(8992,XQAUSER,"XQA",XQII)) S XQX="" K ^TMP("XQ",$J,"XQA",XQI),^TMP("XQ",$J,"XQA1",(999999-XQI))
 . Q
 S:'$D(XQXOUT) XQXOUT=0 G:XQXOUT EXIT G:XQK'>0&'XQX1 EXIT I 'XQX1 D ASK G:XQXOUT EXIT
 G:+XQX1=0 EXIT I XQX1<0 S XQX1=0 G DOIT
 I $D(XQALDELE)!$D(XQALFWD) Q
 ;D WAIT(+XQX1) G:XQXOUT EXIT
 G:XQXOUT EXIT
 G EN^XQALDOIT
 ;
RESTORE ; Restore a deleted message for use
 N ALERTREF,XTVGLOB,ADUZ,X,X0,X1,X2,TIME,MESG,OPT,TAG,ROU,X4,LONG
 S XTVGLOB=$NA(^XTV(8992,DUZ,"XQA"))
 S ADUZ=$O(^XTV(8992,"AXQA",XQAID,0)) I ADUZ>0 S TIME=$O(^(ADUZ,0)) D  I 1
 . M @XTVGLOB@(TIME)=^XTV(8992,ADUZ,"XQA",TIME) K @XTVGLOB@(TIME,2) ; copy alert, kill comment if any
 E  S ALERTREF=$O(^XTV(8992.1,"B",XQAID,0)) Q:ALERTREF'>0  D  ; otherwise rebuild from alert tracking file if possible
 . S X0=^XTV(8992.1,ALERTREF,0),X1=$G(^(1)),X2=$G(^(2)),X4=$O(^(4,0))
 . S TIME=$P($P(X0,U),";",3),MESG=$P(X1,U),OPT=$P(X1,U,2),TAG=$P(X1,U,3),ROU=$P(X1,U,4),LONG=(X4>0)
 . S X=TIME_U_XQAID_U_MESG_U_U_$S(OPT'=""!(ROU'=""):"R",LONG:"L",1:"I")_U_U_$S(OPT'="":OPT,TAG'="":TAG,1:"")_U_$S(OPT'="":"",ROU'="":ROU,1:" ")
 . S @XTVGLOB@(TIME,0)=X I $G(X2)'="" S ^(1)=X2
 S ^XTV(8992,"AXQA",XQAID,DUZ,TIME)="",^XTV(8992,"AXQAN",$E($P(XQAID,";"),1,30),DUZ,TIME)=""
 Q
 ;
EXIT ;
 I $G(XQALAST)="I",$G(DUZ("AUTO")) D WAIT2
 I $D(XQALDELE)!$D(XQALFWD) Q
 K ^TMP("XQ",$J,"XQA"),^("XQA1"),^("XQA2"),XQI,XQX,XQJ,XQK,XQX1,XQX2,XQXOUT,XQ1,XQII,XQACNT,XQA1,XQAREV,%ZIS,XQAROU,XQALAST,XQAROUX,XQON,XQOFF,XQ1ON,XQ1OFF,XQOUT,XQAQ
 K ^TMP("XQALERT1",$J)
 Q
 ;
 ; CHKSURO added 2/2/99 to give user opportunity to add/remove surrogate if no alerts present
CHKSURO ; If user selects process alerts with no alerts present, give him/her the opportunity to add or delete a surrogate
 ; P366 - list currently established surrogates if any
 I '$G(^TMP("XQALERT1",$J,"NOTFIRST")) W !!,"You have no alerts for processing.",!
 D SURROGAT^XQALSURO ; XU*8*17
 Q
 ;
DOIT1 ;
 I XQK=0 S XQALINFO=0 I '$D(XQALFWD) W @IOF
 S XQON="$C(0)",XQOFF="$C(0)" S XQOUT=$P(XQX,U,3) I ($$UP^XLFSTR(XQOUT)["CRITICAL")!($$UP^XLFSTR(XQOUT)["ABNORMAL IMA") D:'$D(XQ1ON) SETREV^XQALERT S XQON=XQ1ON,XQOFF=XQ1OFF ; P285
 S XQK=XQK+1 W !,$J(XQK,2),".",$S(XQZ4:"L",$P(XQX,U,8)=" ":"I",1:" "),"  ",@XQON,$E($P(XQX,U,3),1,70),@XQOFF S:$P(XQX,U,8)=" " XQALINFO=XQALINFO+1 D:XQZ1'=""  ; P285
 . W !?8,"Forwarded by: ",$P(^VA(200,+XQZ1,0),U),"  Generated: ",$$DAT8^XQALERT(+$P($P(XQX,U,2),";",3),1)
 . I $P(XQZ1,U,3)'="" W !?8,$P(XQZ1,U,3)
 S ^TMP("XQ",$J,"XQA1",XQK)=XQX,^(XQK,1)=XQII,^(2)=XQZ,^(3)=XQZ1
 I ($Y+6)>IOSL N XQKVALUE S XQKVALUE=XQK D ASK0(XQI) S:'$D(XQK) XQK=XQKVALUE Q:XQX1!(XQXOUT)  W @IOF
 Q
 ;
ASK0(XQI) ;Stack XQI
ASK ;
 N XQALNEWF K XQALAST
 ;I '$D(XQALDELE)&'$D(XQALFWD) S XQALNEWF=$P(^XTV(8992,XQAUSER,0),U,5) I XQALNEWF<20 D
 ;. N XQALFDA
 ;. S XQALNEWF=XQALNEWF+1,XQALFDA=(8992,(XQAUSER_","),.05)=XQALNEWF D FILE^DIE("","XQALFDA")
 ;. W !,"NEW OPTIONS: S-to add/remove SURROGATE and D-to selectively Delete SOME alerts"
 S XQ1=0,XQXOUT=0 W !?10,"Select from 1 to ",XQK W:$D(XQALDELE) " to DELETE" W:$D(XQALFWD) " to FORWARD"
 W !?10,"or enter ?, A, " W:'$D(XQALDELE)&'$D(XQALFWD)&(XQALINFO>0) "I, D, " W:'$D(XQALDELE)&'$D(XQALFWD) "F, S, P, M, R, " W "or ^ to exit" I XQI>0,$O(^XTV(8992,XQAUSER,"XQA",XQI))>0 W !?10,"or RETURN to continue" S XQ1=1
 R ": ",XQII:DTIME S:'$T!(XQII[U)!(XQII=""&'XQ1) XQXOUT=1 Q:XQXOUT
 I '$D(XQALDELE)&'$D(XQALFWD),"PpMm"[$E(XQII_".") D MORP^XQALDOIT D:"Pp"[$E(XQII_".") PRINT^XQALDOIT D:"Mm"[$E(XQII_".") MAIL^XQALDOIT K ^TMP("XQ",$J,"XQA2") G ASK
 I XQII'="",XQII["?" D HELP G ASK
 I XQII=""&XQ1 Q
 I "IiAaFfRrSsDd"'[$E(XQII_"."),$L(XQII)>31,$E(XQII,1,32)?1N.N W !,$C(7),"  ??  Invalid number entered",! G ASK
 I "IiAaFfRrSsDd"'[$E(XQII_"."),(XQII<1)!(XQII>XQK) W $C(7),"  ??",! G ASK
 I '$D(XQALDELE)&'$D(XQALFWD),"Ff"[$E(XQII) D FWRD^XQALFWD S XQX1=-2 Q  ; MODIFIED 7-6
 I '$D(XQALDELE)&'$D(XQALFWD),"Ss"[$E(XQII) D CHKSURO S XQX1=-1 Q
 I '$D(XQALDELE)&'$D(XQALFWD),"Dd"[$E(XQII) D ASKDEL S XQX1=-2 Q  ; MODIFIED 7-6
 I '$D(XQALDELE),"Rr"[$E(XQII) S XQX1=-2 Q
 I "Aa"[$E(XQII) S X="1-"_XQACNT,DIR(0)="LV^1:"_XQACNT D ^DIR K DIR,XQX1 M XQX1=Y S XQII="" K Y ;Merge list from Y
 I XQII'="","Ii"[$E(XQII) S XQX1(0)="",XQX2=0,XQII="" F XQK=0:0 S XQK=$O(^TMP("XQ",$J,"XQA1",XQK)) S:XQK'>0 XQX1=XQX1(0) Q:XQK'>0  I $P(^(XQK),U,7,8)="^ " S XQX1(XQX2)=XQX1(XQX2)_XQK_"," S:$L(XQX1(XQX2))>240 XQX2=XQX2+1,XQX1(XQX2)=""
 I XQII="" Q
 S X=XQII,DIR(0)="LV^1:"_XQK D ^DIR I '$D(Y) W $C(7),"  ??" D HELP G ASK ;Use of 'LV' is special
 K XQX1 M XQX1=Y K Y S Y=XQX1 ;Merge list from Y
 Q
WAIT(IFN) ;Wait for user input if last alert is INFO and next isn't.
 N X,YY Q:$G(XQXOUT)
 S X=$G(^TMP("XQ",$J,"XQA1",IFN)),YY=$P(X,U,7,8),YY=$S(YY="^ ":"I",YY="^":"O",1:"R")
 I $G(XQALAST)="I","OR"[YY D WAIT2
 I YY="I",$Y+4>IOSL D WAIT2 W @IOF
 S XQALAST=YY
 Q
WAIT2 ;Wait for user input before continuing
 N DIR,Y,DIROUT,DIRUT S DIR(0)="E",DIR("?")="The next ALERT may cause the loss of info on the screen."
 D ^DIR S:$D(DIRUT) XQXOUT=1
 Q
 ;
HELP W !!,"YOU MAY ENTER:",!?3,$S(XQK>1:"One or more numbers",1:"A number")," in the range 1 to ",XQK," to select specific alert(s)"
 W !?6,"for "_$S($D(XQALDELE):"DELETION.",$D(XQALFWD):"FORWARDING",1:"processing.") W:XQK>1 "  This may be a series of numbers, e.g., 2,3,6-9"
 W !?3,"A to "_$S($D(XQALDELE):"DELETE",$D(XQALFWD):"FORWARD",1:"process")," all of the pending alerts in the order shown."
 W:'$D(XQALDELE)&'$D(XQALFWD) !?3,"I to process all of the INFORMATION ONLY alerts, if any, without further ado."
 W:'$D(XQALDELE)&'$D(XQALFWD) !?3,"S to add or remove a surrogate to receive alerts for you"
 W:'$D(XQALDELE)&'$D(XQALFWD) !?3,"F to forward one or more specific alerts.  Forwarding may be as an ALERT",!,"to specific user(s) and/or mail group(s), or as a MAIL MESSAGE, or to a",!,"specific PRINTER."
 W:'$D(XQALDELE)&'$D(XQALFWD) !?3,"D to delete specific alerts (some alerts may not be deleted)"
 W:'$D(XQALDELE)&'$D(XQALFWD) !?3,"P to print a copy of the pending alerts on a printer"
 W:'$D(XQALDELE)&'$D(XQALFWD) !?3,"M to receive a MailMan message containing a copy of these pending alerts"
 W:'$D(XQALDELE) !?3,"R to Redisplay the available alerts"
 W !?3,"^ to exit"
 I XQI W !?5,"or RETURN to see additional pending ALERTS"
 W !!
 Q
 ;
SORT ;Sort and remove display only
 N XQZ,XQZ1,XQZ4,XQI,XQK,XQX,XQJ
 F XQI=0:0 S XQI=$O(^XTV(8992,XQAUSER,"XQA",XQI)) Q:XQI'>0  S XQX=^(XQI,0),XQZ=$G(^(1)),XQZ1=$G(^(2)),XQZ4=$O(^(4,0)) S XQJ=$P(XQX,U,7,8) K:XQJ=U ^XTV(8992,XQAUSER,"XQA",XQI) I XQJ'=U D
 . S XQACNT=XQACNT+1,XQJ=$S(XQAREV:999999-XQACNT,1:XQACNT),^TMP("XQ",$J,"XQA",XQJ)=XQX,^(XQJ,1)=XQI,^(2)=XQZ,^(3)=XQZ1,^(4)=XQZ4
 S XQK=0 F XQI=0:0 S XQI=$O(^TMP("XQ",$J,"XQA",XQI)) Q:XQI'>0  S XQK=XQK+1 M ^TMP("XQ",$J,"XQA1",XQK)=^TMP("XQ",$J,"XQA",XQI)
 Q
 ;
ASKDEL ;
 N XQALDELE,XQX1COPY,XQAID,DA,XQAKILL,XQXOUT,XQAUSERD,XQALVALU
 S XQALDELE=1
 K XQX1
 D DOIT^XQALERT1
 K XQALDELE S XQAUSERD=1
 I $D(XQX1),XQX1>0 D
 . M XQX1COPY=XQX1
 . F  Q:XQX1=""  S DA=+XQX1,XQX1=$P(XQX1,",",2,99) D  I XQX1="" S Y=$O(XQX1(0)) I Y>0 S XQX1=XQX1(Y) K XQX1(Y)
 . . S XQAID=$P(^TMP("XQ",$J,"XQA1",DA),U,2),XQALVALU=^(DA),XQAKILL=1
 . . I $P(XQALVALU,U,8)=" "!$P(XQALVALU,U,10) D
 . . . I XQAID="" K ^XTV(8992,XQAUSER,"XQA",+^TMP("XQ",$J,"XQA1",DA,1))
 . . . I XQAID'="" D DELETE^XQALDEL
 . . . K ^TMP("XQ",$J,"XQA1",DA),^TMP("XQ",$J,"XQA",(999999-DA))
 . K XQX1 M XQX1=XQX1COPY S XQAID=0
 . F  Q:XQX1=""  S DA=+XQX1,XQX1=$P(XQX1,",",2,99) D  I XQX1="" S Y=$O(XQX1(0)) I Y>0 S XQX1=XQX1(Y) K XQX1(Y)
 . . I $D(^TMP("XQ",$J,"XQA1",DA)) W:'XQAID !!,"Unable to delete alerts which require action: ",DA W:XQAID ",",DA S XQAID=1
 . I XQAID=1 K DIR S DIR(0)="E" D ^DIR K DIR
 K XQX1,XQAKILL
 Q
 ;
FRWRDONE ;
 N XQX1,XQALFWDL S XQALFWDL(1)=XQAID
 N XQAID
 D FWDONE^XQALFWD
 Q
