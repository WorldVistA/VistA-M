FBAACLU ;AISC/DMK,WOIFO/SAB - CLERK WHO ENTERED AUTHORIZATION ;12/8/2014
 ;;3.5;FEE BASIS;**154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; inputs
 ;   FBFILE - (required) file/sub-file # from menu option entry action
 ;
 ; check for required input
 Q:"^161.01^162.2^162.4^162.7^"'[("^"_$G(FBFILE)_"^")
 ;
 N D,FBDA,POP,%ZIS
 ;
 ; ask record in file
 I FBFILE=161.01 D
 . S DIC="^FBAAA(",DIC(0)="AEQM"
 . D ^DIC K DIC Q:Y<0  S FBDA(1)=+Y
 . S DIC="^FBAAA("_FBDA(1)_",1,",DIC(0)="AEQM"
 . D ^DIC K DIC Q:Y<0  S FBDA=+Y
 I FBFILE=162.2 D
 . S DIC="^FBAA(162.2,",DIC(0)="AQEM"
 . D ^DIC K DIC Q:Y<0  S FBDA=+Y
 I FBFILE=162.4 D
 . S DIC="^FB7078(",DIC(0)="AQEM",DIC("A")="Select Patient: ",D="D"
 . D IX^DIC K DIC Q:Y<0  S FBDA=+Y
 I FBFILE=162.7 D
 . N FBARY,FBI,FBOUT
 . D LOOKUP^FBUCUTL3(0)
 . I 'FBOUT D
 . . S FBI=$O(^TMP("FBARY",$J,0))
 . . S:FBI FBDA=$P($G(^TMP("FBARY",$J,FBI)),";",1)
 . K ^TMP("FBARY",$J)
 I '$G(FBDA) G EXIT
 ;
 ; ask device
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . N FBX
 . N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 . S ZTRTN="QEN^FBAACLU",ZTDESC="Fee Clerk Lookup"
 . F FBX="FBFILE","FBDA*" S ZTSAVE(FBX)=""
 . D ^%ZTLOAD,HOME^%ZIS
 ;
QEN ; queued entry point
 ; inputs from Taskman
 ;   ZTQUEUED - (optional) set by TaskMan to indicate report is tasked
 ; outputs to Taskman
 ;   ZTREQ - set when report is tasked
 ;   ZTSTOP - set when report is tasked and job was stopped per request
 ;
 N %
 ;
 U IO
 ;
 S (FBQUIT,FBPG)=0 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 K FBDL
 S FBDL="",$P(FBDL,"-",80)=""
 S FBDL("ED")="    "_$E(FBDL,1,21)_"  "_$E(FBDL,1,35)
 ;
 ; build page header text
 I FBFILE=161.01 S FBHD="Clerk Lookup for an authorization"
 I FBFILE=162.2 S FBHD="Clerk Lookup for a CH notification"
 I FBFILE=162.4 S FBHD="Clerk Lookup for a 7078 authorization"
 I FBFILE=162.7 S FBHD="Clerk Lookup for an unauthorized claim"
 ;
 ; determine which files to display
 F FBX=161.01,162.2,162.4,162.7 S FBSHOW(FBX)=0 ; init FBSHOW(
 S FBSHOW(FBFILE)=FBDA ; always show input file
 I FBFILE=161.01 D
 . S FBX=$P($G(^FBAAA(FBDA(1),1,FBDA,0)),U,9) ; ASSOC 7078/583
 . I FBX["FB7078" S FBSHOW(162.4)=+FBX
 . I FBX["FB583" S FBSHOW(162.7)=+FBX
 I FBSHOW(162.4) D
 . S FBX=$O(^FBAA(162.2,"AM",FBSHOW(162.4),0))
 . I FBX S FBSHOW(162.2)=FBX
 ;
 ; display output
 D HD
 ;
 ; show information for authorization
 I 'FBQUIT,FBSHOW(161.01) D
 . N FBDATA
 . ; skip if no user audit data and either 7078 or unauthorized claim
 . ;   (very similar information) will be shown later
 . S FBDATA=$O(^FBAAA(FBDA(1),1,FBDA,"LOG1",0))
 . I 'FBDATA,FBSHOW(162.4)!FBSHOW(162.7) Q
 . ;
 . S FBIENS=FBDA_","_FBDA(1)_","
 . I $Y+6>IOSL D HD Q:FBQUIT
 . W !!,"Authorization"
 . W !,"Veteran: ",$$GET1^DIQ(161,FBDA(1)_",",.01)
 . W ?40,"Vendor: ",$$GET1^DIQ(161.01,FBIENS,.04)
 . W !,"Authorization Number: ",FBDA(1),"-",FBDA
 . W !,"Authorized From Date: ",$$GET1^DIQ(161.01,FBIENS,.01)
 . W ?40,"Authorized To Date: ",$$GET1^DIQ(161.01,FBIENS,.02)
 . D DUA("^FBAAA("_FBDA(1)_",1,"_FBDA_",""LOG1"",")
 ;
 ; show information for 10-7078 authorization
 I 'FBQUIT,FBSHOW(162.4) D
 . N FBVEN
 . S FBIENS=FBSHOW(162.4)_","
 . I $Y+6>IOSL D HD Q:FBQUIT
 . W !!,"10-7078 Authorization"
 . W !,"Veteran: ",$$GET1^DIQ(162.4,FBIENS,2)
 . S FBVEN=+$P($G(^FB7078(FBSHOW(162.4),0)),"^",2)
 . W ?40,"Vendor: ",$$GET1^DIQ(161.2,FBVEN_",",.01)
 . W !,"Reference Number: ",$$GET1^DIQ(162.4,FBIENS,.01)
 . W ?40,"Fee Program: ",$$GET1^DIQ(162.4,FBIENS,.5)
 . W !,"Authorized From Date: ",$$GET1^DIQ(162.4,FBIENS,3)
 . W ?40,"Authorized To Date: ",$$GET1^DIQ(162.4,FBIENS,4)
 . D DUA("^FB7078("_FBSHOW(162.4)_",""LOG1"",")
 ;
 ; show information for civil hospital notification
 I 'FBQUIT,FBSHOW(162.2) D
 . S FBIENS=FBSHOW(162.2)_","
 . I $Y+6>IOSL D HD Q:FBQUIT
 . W !!,"CH Notification"
 . W !,"Date/Time: ",$$GET1^DIQ(162.2,FBIENS,.01)
 . W !,"Veteran: ",$$GET1^DIQ(162.2,FBIENS,3)
 . W ?40,"Vendor: ",$$GET1^DIQ(162.2,FBIENS,1)
 . D DUA("^FBAA(162.2,"_FBSHOW(162.2)_",""LOG1"",")
 ;
 ; show information for unauthorized claim
 I 'FBQUIT,FBSHOW(162.7) D
 . S FBIENS=FBSHOW(162.7)_","
 . I $Y+6>IOSL D HD Q:FBQUIT
 . W !!,"Unauthorized Claim"
 . W !,"Veteran: ",$$GET1^DIQ(162.7,FBIENS,2)
 . W ?40,"Vendor: ",$$GET1^DIQ(162.7,FBIENS,1)
 . W !,"Date Claim Received: ",$$GET1^DIQ(162.7,FBIENS,.01)
 . W ?40,"Fee Program: ",$$GET1^DIQ(162.7,FBIENS,.5)
 . W !,"Treatment From Date: ",$$GET1^DIQ(162.7,FBIENS,3)
 . W ?40,"Treatment To Date: ",$$GET1^DIQ(162.7,FBIENS,4)
 . D DUA("^FB583("_FBSHOW(162.7)_",""LOG1"",")
 ;
 I 'FBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K FBDA,FBDL,FBDT,FBDTR,FBHD,FBIENS,FBPG,FBSHOW,FBQUIT,FBX
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
HD ; page header
 N FBI
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W FBHD,?49,FBDTR,?72,"page ",FBPG
 W !,FBDL
 Q
 ;
HDEDT(FBCONT) ; header for edited table
 ; input
 ;   FBCONT (optional) =1 when table continued after page break
 W !!,?4,"Date/Time Edited",?27,"Edited By"
 W:$G(FBCONT) " (continued)"
 W !,FBDL("ED")
 Q
 ;
DUA(FBROOT) ; display the user audit for a record in one of the supported files
 N FBC,FBDT,FBI,FBTXT,FBUSR,FBY0
 I $Y+6>IOSL D HD Q:FBQUIT
 D HDEDT(0)
 S (FBC,FBI)=0 F  S FBI=$O(@(FBROOT_FBI_")")) Q:'FBI  D  Q:FBQUIT
 . S FBC=FBC+1
 . S FBY0=$G(@(FBROOT_FBI_",0)"))
 . S FBDT=$P(FBY0,"^")
 . S FBUSR=$P(FBY0,"^",2)
 . S FBTXT=$P(FBY0,"^",3)
 . I $Y+4>IOSL D HD Q:FBQUIT  D HDEDT(1)
 . W !
 . W ?4,$S(FBDT:$$FMTE^XLFDT(FBDT),1:"")
 . W ?27,$S(FBUSR:$$GET1^DIQ(200,FBUSR,.01),1:"")
 . I FBTXT]"" W !,?6,"Comments: ",FBTXT
 I FBC=0 W !,?4,"No information found in user audit"
 Q
 ;
 ;FBAACLU
