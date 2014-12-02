FBAAAUDR ;WIOFO/SAB - AUTHORIZATION DATA AUDIT REPORT ;3/27/2014
 ;;3.5;FEE BASIS;**151**;JAN 30, 1995;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IAs
 ;  #10003  DD^%DT
 ;  #10000  NOW^%DTC
 ;  #10086  %ZIS, HOME^%ZIS
 ;  #10089  %ZISC
 ;  #10063  %ZTLOAD
 ;  #2056   $$GET1^DIQ
 ;  #10004  EN^DIQ
 ;  #10026  DIR
 ;
 N DFN,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FTP,%ZIS,POP,X,Y
 ;
 ; ask patient
 S DFN=$$ASKVET^FBAAUTL1()
 G:'DFN EXIT
 ;
 ; ask authorization
 D GETAUTH^FBAAUTL1
 G:$G(FTP)="" EXIT
 ;
 ; ask device
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 . S ZTRTN="QEN^FBAAAUDR",ZTDESC="Historical Authorization Data Report"
 . F FBX="DFN","FTP" S ZTSAVE(FBX)=""
 . D ^%ZTLOAD,HOME^%ZIS
 ;
QEN ; queued entry point
 N %
 ;
 U IO
 ;
 S FBQUIT=0
 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 ;
 I $E(IOST,1,2)="C-" W @IOF
 W !,"Historical Authorization Data Report",?49,FBDTR
 ;
 ; display patient
 W !,"Patient: ",$$GET1^DIQ(161,DFN_",",.01)
 W "   Pt.ID: ",$$SSN^FBAAUTL(DFN),!
 ;
 ; display current authorization data
 W !,"Current Authorization Data: "
 S DIC="^FBAAA("_DFN_",1,",DA(1)=DFN,DA=FTP,DR="0:LOG"
 D EN^DIQ
 ;
 I $E(IOST,1,2)="C-",IOSL<($Y+18) S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1
 ;
 ; display historical data
 I 'FBQUIT D
 . W !,"Historical Audit Data (since patch FB*3.5*151): "
 . W:'$O(^FBAAA(DA(1),1,DA,"LOG2",0)) !,"  No historical audit data on file."
 . S DIC="^FBAAA("_DFN_",1,",DA(1)=DFN,DA=FTP,DR="LOG2"
 . D EN^DIQ
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1
 ;
 ; close device
 D ^%ZISC
 ;
EXIT ; exit
 I $D(ZTQUEUED) S ZTREQ="@"
 K DA,DIC,DIR,DR,DIROUT,DTOUT,DUOUT,X,Y
 K FB583,FB7078,FBAABDT,FBAAEDT,FBASSOC,FBDMRA,FBDTR,FBPOV,FBPROG,FBPSA
 K FBPT,FBQUIT,FBTT,FBTYPE,FBVEN,FBX,FTP,TA
 D GETAUTHK^FBAAUTL1
 K FBAAOUT,FBAUD,CNT,DFN,PI
 Q
 ;
 ;FBAAAUDR
