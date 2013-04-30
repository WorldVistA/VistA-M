LA7LOG ;DALOI/STAFF - Log events and errors from Lab Messaging ;11/16/11  12:14
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**17,27,67,74**;Sep 27, 1994;Build 229
 ;
 QUIT
 ;
CREATE(LA762485,LA7FLAG) ;
 ; Creates an entry in the log file to record events or errors
 ; while processing messages.  The calling routine passes the 
 ; ien for a bulletin in file 62.485.
 ; Requires the variables:
 ; LA762485 = 'ien of bulletin in 62.485'
 ; LA76248  = 'ien of config in 62.48 or null if none is defined'
 ; LA7FLAG  = 1 (return error msg text)
 ;
 ; logging turned off
 ;I $G(LA7FLAG),'$P($G(^LAHM(62.48,+LA76248,0)),U,4) Q ""
 ;I '$P($G(^LAHM(62.48,+LA76248,0)),U,4) Q
 ;
 N DA,DIE,DR,X,Y,DIERR
 N LA7,LA7DT,LA7NOW,LA7TIM,LA7TXT,LOGIT
 S LOGIT=$P($G(^LAHM(62.48,+LA76248,0)),U,4)
 ;
 ; change status to error.
 I $G(LA76249)>0 D
 . N LAFDA,LA7DIE
 . S LAFDA(1,62.49,LA76249_",",2)="E"
 . D FILE^DIE("","LAFDA(1)","LA7DIE(1)")
 ;
 I 'LOGIT Q:$Q!($G(LA7FLAG)) ""  Q  ;
 ;
 S LA7TXT=$P($G(^LAHM(62.485,LA762485,0)),"^",1,2)
 S:LA7TXT="" LA7TXT="Log routine was called with a non-existent code number ("_LA762485_")."
 I $G(^LAHM(62.485,LA762485,1))'="" X ^(1)
 I $O(LA7TXT("")) D
 . S LA7=""
 . F  S LA7=$O(LA7TXT(LA7)) Q:LA7=""  D
 . . S LA7TXT=$P(LA7TXT,"|"_LA7_"|")_LA7TXT(LA7)_$P(LA7TXT,"|"_LA7_"|",2)
 ; Set current date/time.
 S LA7NOW=$$HTFM^XLFDT($H),LA7DT=LA7NOW\1,LA7TM=LA7NOW#1
 ;
 ; Set lock on XTMP global.
 L +^XTMP("LA7ERR^"_LA7DT,0):99
 I '$D(^XTMP("LA7ERR^"_LA7DT,0)) S ^XTMP("LA7ERR^"_LA7DT,0)=$$HTFM^XLFDT($H+7,1)_"^"_LA7DT_"^"_"Lab Messaging Error Log"
 F  Q:'$D(^XTMP("LA7ERR^"_LA7DT,LA7TM))  S LA7TM=LA7TM+.0000001
 S ^XTMP("LA7ERR^"_LA7DT,LA7TM)=$G(LA76248)_"^"_$G(LA76249)_"^"_$P(LA7TXT,"^")_"^"_$$ENCODEUP^XMCU1($P(LA7TXT,"^",2,99))
 ; Release lock on XTMP global.
 L -^XTMP("LA7ERR^"_LA7DT,0)
 ;
 ;; change status to error.
 ;I $G(LA76249) D
 ;. N LAFDA,LA7DIE
 ;. S LAFDA(1,62.49,LA76249_",",2)="E"
 ;. D FILE^DIE("","LAFDA(1)","LA7DIE(1)")
 ;
 ; Send alert
 I $P($G(^LAHM(62.485,LA762485,0)),"^",3),$D(^LAHM(62.48,+$G(LA76248),20,"B",2)) D XQA^LA7UXQA(2,$G(LA76248),$G(LA762485),$G(LA76249),$G(LA7AMSG))
 ;
 I $G(LA7FLAG) Q LA7TXT
 I $Q Q LA7TXT
 Q
 ;
 ;
PRINT ;Print the error log which is stored in ^XTMP.  Errors are
 ;logged only if the Debug Log field is turned on in 62.48
 N DIR,LA7,LA76248,LA76249,LA7DT,LA7ETXT,LA7TM,LA7TXT,LA7XTMP
 S DT=$$DT^XLFDT,LA7XTMP="LA7ERR^"_DT
 I '$O(^XTMP(LA7XTMP,0)) W !!,?5,"Nothing logged for Today!"
 E  S DIR("B")="TODAY"
 S DIR("A")="Look at log for what date? "
 S DIR("?")="^D HELP^%DTC"
 S DIR(0)="DAO^:DT:EX"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S LA7XTMP="LA7ERR^"_Y
 I '$O(^XTMP(LA7XTMP,0)) D  G PRINT
 . W !!,?5,"Nothing logged for ",$$FMTE^XLFDT(Y)
 S (LA76248,X,Y)=0 ; Find out if running multiple configurations.
 F  S X=$O(^LAHM(62.48,X)) Q:'X  I $P($G(^LAHM(62.48,X,0)),"^",3) S Y=Y+1
 I Y>1 D  Q:'LA76248
 . N DIC,X,Y
 . S DIC="^LAHM(62.48,",DIC(0)="AEMQ",DIC("A")="Select CONFIGURATION: " D ^DIC
 . I Y>0 S LA76248=+Y
 S DIR(0)="Y",DIR("A")="Print message text with error",DIR("B")="YES",DIR("?",1)="Do you want the text of the message also printed with the error",DIR("?")="Answer 'Y' or 'N'" D ^DIR K DIR Q:$D(DIRUT)
 S LA7ETXT=Y ; Flag to print message text with error.
 S %ZIS="Q"
 D ^%ZIS
 I POP D HOME^%ZIS K DIR,%ZIS,DIRUT,LA7XTMP QUIT
 K ZTSK
 I $D(IO("Q")) D  QUIT
 . S ZTDESC="Lab Interface Error Log",ZTRTN="START^LA7LOG"
 . S ZTSAVE("LA7XTMP")=LA7XTMP
 . S ZTSAVE("LA76248")=LA76248
 . S ZTSAVE("LA7ETXT")=LA7ETXT
 . D ^%ZTLOAD
 . I $D(ZTSK) U IO(0) W !?5,"Report queued...",!!
 . D ^%ZISC K ZTDESC,ZTDTH,ZTSAVE,ZTRTN,ZTSK
 U IO
START ;
 N LA76249,LA7FS,LA7QUIT,LA7SEG,LA7TM
 S LA7TM=""
 W:$Y @IOF
 F  S LA7TM=$O(^XTMP(LA7XTMP,LA7TM),-1) Q:LA7TM=0  D  Q:LA7QUIT
 . S LA7QUIT=0
 . I LA76248,+^XTMP(LA7XTMP,LA7TM),+^XTMP(LA7XTMP,LA7TM)'=LA76248 Q  ; Error message not for requested configuration.
 . S LA76249=+$P(^XTMP(LA7XTMP,LA7TM),"^",2)
 . I $Y>(IOSL-5) D  Q:LA7QUIT
 . . I '$D(ZTQUEUED),"Pp"'[$E(IOST) K DIR S DIR(0)="E" D ^DIR I 'Y S LA7QUIT=1 Q
 . . W @IOF
 . W:$X !! W $$FMTE^XLFDT($P(LA7XTMP,"^",2)+LA7TM)," "
 . W $P(^XTMP(LA7XTMP,LA7TM),"^",3)," " S X=$$DECODEUP^XMCU1($P(^(LA7TM),"^",4,99))
 . F LA7=1:1:$L(X," ") S Y=$P(X," ",LA7) W:($L(Y)+$X+1)>IOM ! W Y," "
 . I 'LA76249!('LA7ETXT) Q  ; Don't print message if no text or not requested.
 . Q:'$O(^LAHM(62.49,LA76249,150,0))
 . S LA7=0,LA7FS=" "
 . F  S LA7=$O(^LAHM(62.49,LA76249,150,LA7)) Q:'LA7  D  Q:LA7QUIT
 . . S LA7SEG=$G(^LAHM(62.49,LA76249,150,LA7,0))
 . . I LA7SEG="" W ! Q
 . . S LA7QUIT=0
 . . I $Y>(IOSL-5) D  Q:LA7QUIT
 . . . I '$D(ZTQUEUED),"Pp"'[$E(IOST) K DIR S DIR(0)="E" D ^DIR I 'Y S LA7QUIT=1 Q
 . . . W @IOF
 . . I LA7FS=" ",$E(LA7SEG,1,3)?1(1"MSH",1"FSH",1"BSH") S LA7FS=$E(LA7SEG,4)
 . . W !
 . . F I=1:1:$L(LA7SEG,LA7FS) S Y=$P(LA7SEG,LA7FS,I) W:($L(Y)+$X+1)>IOM ! W ?2,Y,LA7FS
 . W !
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 K LA7,LA76248,LA76249,LA7FS,LA7QUIT,LA7SEG,LA7TM,LA7XTMP
 K DIR,DIRUT,DTOUT,X,Y
 Q
