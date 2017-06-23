FBAASKR ;WIOFO/LKG - SECURITY KEY REPORT ;1/29/15  11:27
 ;;3.5;FEE BASIS;**154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ; IAs
 ;  #1340   Lookup Security Key file (#19.1) entries
 ;  #4398   FIRST^VAUTOMA
 ;  #10060  New Person File (#200) Read w/FileMan
 ;  #10090  Institution File (#4) Read w/FileMan
 ;  #10076  ^XUSEC GLOBAL
 ;
ST ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y,FBABORT,FBACTIVE,FBRT,POP,VAUTSTR,VAUTNI,VAUTVB,FBKEY,FBUSER
 S DIR(0)="YB",DIR("A")="Should report include terminated users with keys",DIR("B")="NO"
 D ^DIR G:$D(DIRUT) END
 S FBACTIVE=$S('Y:1,1:0) K DIR
 S FBABORT=0
 S DIR(0)="SB^S:SECURITY KEY;U:USER",DIR("A")="Sort by Security Key or User"
 S DIR("?",1)="Enter 'S' to have report by Security Key or"
 S DIR("?")="  'U' to have the report by User.  Enter '^' to exit."
 S DIR("??")="^D EN^DDIOL(""The report is users listed by Security Key (S) or Keys listed by User (U)."","""",""!?2"")"
 D ^DIR
 G END:$D(DIRUT)
 S FBRT=Y
 I FBRT="S" D  G END:FBABORT,DEV
 . N DIC S DIC="^DIC(19.1,",DIC("S")="I $E($P($G(^(0)),U),1,2)=""FB"",$E($P($G(^(0)),U),3)'=""Z"""
 . S VAUTSTR="Fee Basis Security Key",VAUTNI=2,VAUTVB="FBKEY"
 . D FIRST^VAUTOMA I Y=-1 S FBABORT=1
 . I FBKEY=1 D
 . . N FBARR,FBERR,FBI
 . . D LIST^DIC(19.1,"","","","","","FB","B","I $E($P($G(^(0)),U),1,3)'=""FBZ""","","FBARR","FBERR")
 . . F FBI=1:1:(+FBARR("DILIST",0)) S FBKEY(FBARR("DILIST",2,FBI))=FBARR("DILIST",1,FBI)
 I FBRT="U" D  G END:FBABORT,DEV
 . N DIC S DIC="^VA(200,",VAUTSTR="User",VAUTNI=2,VAUTVB="FBUSER"
 . S:FBACTIVE DIC("S")="I '$$TERM^FBAASKR(Y)"
 . D FIRST^VAUTOMA I Y=-1 S FBABORT=1
DEV ;Ask device
 S %ZIS="Q" D ^%ZIS G:POP END
 I $D(IO("Q")) D  G END
 . N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 . S ZTRTN="COMPILE^FBAASKR",ZTDESC="Security Key Report for Fee Basis"
 . S ZTSAVE("FBKEY")="",ZTSAVE("FBKEY(")="",ZTSAVE("FBUSER")="",ZTSAVE("FBUSER(")="",ZTSAVE("FBRT")="",ZTSAVE("FBACTIVE")=""
 . D ^%ZTLOAD,HOME^%ZIS
COMPILE ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,FBABORT,FBDTR,FBLINE,FBLP,FBPAGE,X,Y
 S FBABORT=0,$P(FBLINE,"-",41)="",FBPAGE=0
 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 ;
 K ^TMP($J)
 I FBRT="S" D
 . N FBERR,FBI,FBJ,FBK,FBN S FBI=""
 . F  S FBI=$O(FBKEY(FBI)) Q:'FBI  D
 . . S FBJ=FBKEY(FBI)
 . . I '$D(^XUSEC(FBJ)) S ^TMP($J,FBJ,"No holders^0")="" Q
 . . S FBK=""
 . . F  S FBK=$O(^XUSEC(FBJ,FBK)) Q:FBK=""  D
 . . . I FBACTIVE,$$TERM(FBK) Q
 . . . S FBN=$$GET1^DIQ(200,FBK_",",.01,"","","FBERR") K FBERR
 . . . S ^TMP($J,FBJ,FBN_"^"_FBK)=""
 I FBRT="U" D
 . I FBUSER'=1 D  Q
 . . N FBC,FBK,FBJ S FBK=""
 . . F  S FBK=$O(FBUSER(FBK)) Q:FBK=""  D
 . . . S FBJ="FA~",FBC=0
 . . . F  S FBJ=$O(^XUSEC(FBJ)) Q:FBJ]"FBY~"!(FBJ="")  D
 . . . . I $D(^XUSEC(FBJ,FBK)) S ^TMP($J,FBUSER(FBK)_"^"_FBK,FBJ)="",FBC=FBC+1
 . . . S:FBC=0 ^TMP($J,FBUSER(FBK)_"^"_FBK,"No Fee Basis Key Held")=""
 . I FBUSER=1 D
 . . N FBERR,FBJ,FBK,FBN
 . . S FBJ="FA~"
 . . F  S FBJ=$O(^XUSEC(FBJ)) Q:FBJ]"FBY~"!(FBJ="")  D
 . . . S FBK=0
 . . . F  S FBK=$O(^XUSEC(FBJ,FBK)) Q:FBK=""  D
 . . . . I FBACTIVE,$$TERM(FBK) Q
 . . . . S FBN=$$GET1^DIQ(200,FBK_",",".01","","","FBERR") K FBERR
 . . . . S ^TMP($J,FBN_"^"_FBK,FBJ)=""
 ;
PRT ;Print report
 U IO D HDR
 N FBI,FBIOLD,FBDA,FBJ,FBK,FBN,FBOLDPG,FBU,FBX S FBOLDPG=FBPAGE
 S FBI="",FBIOLD="",FBJ=""
 F  S FBI=$O(^TMP($J,FBI)) Q:FBI=""  D  Q:FBABORT
 . F  S FBJ=$O(^TMP($J,FBI,FBJ)) Q:FBJ=""  D  Q:FBABORT
 . . D:FBLP+5>IOSL HDR Q:FBABORT
 . . I FBRT="S" D
 . . . I FBI=FBIOLD,FBPAGE'=FBOLDPG W !!,"Key: ",FBI,?35,"(continued)" S FBLP=FBLP+2
 . . . I FBI'=FBIOLD W !!,"Key: ",FBI S FBIOLD=FBI,FBLP=FBLP+2
 . . . S FBDA=$P(FBJ,U,2),FBN=$P(FBJ,U),FBX=$S(FBDA>0:$$GETDATA(FBDA),1:FBN)
 . . . W !?2,$P(FBX,U)_$S($P(FBX,U,5)'="":" (T)",1:""),?37,$P(FBX,U,2),?44,$P(FBX,U,3) S FBLP=FBLP+1
 . . . I $P(FBX,U,4)'="" W !?5,"Division(s): ",$P(FBX,U,4) S FBLP=FBLP+1
 . . . S FBOLDPG=FBPAGE
 . . I FBRT="U" D
 . . . I FBI=FBIOLD,FBPAGE'=FBOLDPG W !,$P(FBI,U),?35,"(continued)" S FBLP=FBLP+1
 . . . I FBI'=FBIOLD D
 . . . . S FBIOLD=FBI
 . . . . S FBDA=$P(FBI,U,2),FBN=$P(FBI,U),FBX=$S(FBDA>0:$$GETDATA(FBDA),1:"")
 . . . . W !,$P(FBX,U)_$S($P(FBX,U,5)'="":" (T)",1:""),?37,$P(FBX,U,2),?44,$P(FBX,U,3) S FBLP=FBLP+1
 . . . . I $P(FBX,U,4)'="" W !?5,"Division(s): ",$P(FBX,U,4) S FBLP=FBLP+1
 . . . W !?3,"Key: ",FBJ S FBLP=FBLP+1
 . . . S FBOLDPG=FBPAGE
 I 'FBABORT,$E(IOST,1,2)="C-" N DIR S DIR(0)="E" D ^DIR
 D ^%ZISC
END ;
 S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J),FBKEY,FBUSER,FBRT,FBACTIVE
 Q
TERM(FBIEN) ;Extrinsic function that returns
 ; '1' if user is terminated, or
 ; '0' if not terminated.
 ;Input FBIEN is the IEN of the person in the New Person file (#200)
 N FBTERMDT,FBERR,FBRESULT S FBRESULT=0
 S FBTERMDT=$$GET1^DIQ(200,FBIEN_",",9.2,"","","FBERR")
 I FBTERMDT'="",FBTERMDT'>DT S FBRESULT=1
 Q FBRESULT
 ;
HDR ;Writing report heading
 I $E(IOST,1,2)="C-",FBPAGE>0 D  Q:FBABORT
 . N DIR S DIR(0)="E" D ^DIR
 . S:$D(DIRUT) FBABORT=1
 S FBPAGE=FBPAGE+1
 W @IOF,"Security Key Report for Fee Basis",?44,FBDTR,"   page ",FBPAGE
 I FBRT="S" W !?2,"by Security Key for ",$S(FBKEY=1:"all",1:"specified")," FB keys"
 I FBRT="U" W !?2,"by User for ",$S(FBUSER=1:"all",1:"specified")," users"
 W:'FBACTIVE " including terminated (T) users"
 W !!,"Name",?37,"SSN",?44,"Title",!,$E(FBLINE,1,35),?37,$E(FBLINE,1,4),?44,$E(FBLINE,1,30)
 S FBLP=5
 Q
 ;
GETDATA(FBIEN) ;This extrinsic function returns a caret delimited string
 ;of Name^Last4_SSN^Title^Division(comma-delimited station #s)^Terminated_flag
 ;FBIEN is the IEN of the person in the New Person file (#200)
 N FBARRAY,FBERR,FBI,FBW,FBX,FBY
 S FBIEN=FBIEN_","
 D GETS^DIQ(200,FBIEN,".01;8;9","","FBARRAY","FBERR")
 S FBY=FBARRAY(200,FBIEN,9)
 S FBX=FBARRAY(200,FBIEN,.01)_"^"_$E(FBY,$L(FBY)-3,$L(FBY))_"^"_FBARRAY(200,FBIEN,8)
 K FBARRAY,FBERR D GETS^DIQ(200,FBIEN,"16*","I","FBARRAY","FBERR")
 S FBY="",FBI="",FBW=""
 F  S FBI=$O(FBARRAY(200.02,FBI)) Q:FBI=""  D
 . S FBW=FBARRAY(200.02,FBI,.01,"I") K FBERR
 . S FBW=$$GET1^DIQ(4,FBW_",",99,"","","FBERR")
 . S:FBW'="" FBY=FBY_$S(FBY="":"",1:", ")_FBW
 S FBX=FBX_"^"_FBY_"^"_$S($$TERM(FBIEN):"T",1:"")
 Q FBX
 ;FBAASKR
