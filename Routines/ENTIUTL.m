ENTIUTL ;WOIFO/SAB - Engineering Utilities ;2/14/2008
 ;;7.0;ENGINEERING;**87,89**;Aug 17, 1993;Build 20
 ;
DISEQ(ENDA) ; Display Equipment
 N ENCMR,ENLOC,ENMFGR,ENMOD,ENNAM,ENSER,ENSVC
 ; display equipment data
 S ENCMR=$$GET1^DIQ(6914,ENDA,19)
 S ENLOC=$$GET1^DIQ(6914,ENDA,24)
 S ENSVC=$$GET1^DIQ(6914,ENDA,21)
 S ENNAM=$$GET1^DIQ(6914,ENDA,3)
 S ENMFGR=$$GET1^DIQ(6914,ENDA,1)
 S ENMOD=$$GET1^DIQ(6914,ENDA,4)
 S ENSER=$$GET1^DIQ(6914,ENDA,5)
 W !,"Entry #",?12,"CMR",?19,"Location",?41,"Using Service"
 W !,"---------",?12,"-----",?19,"--------------------"
 W ?41,"------------------------------"
 W !,ENDA,?12,ENCMR,?19,ENLOC,?41,ENSVC
 W !,ENNAM
 W !!,"Mfgr: ",ENMFGR
 W !,"Model: ",ENMOD,?39,"Serial #: ",ENSER
 Q
 ;
CAPEQ(ENDA,ENTAG,SITC,END) ; Captioned Equipment Display
 ; input
 ;   ENDA = equipment ien (file 6914)
 ;   ENTAG = (optional) line tag to call at page break
 ;         this utility expects there to be at least 5 lines to display
 ;         the normal data and will only issue page breaks during the
 ;         IT REMOTE LOCATION or IT COMMENTS output.
 ;   SITC = (optional) flag, true to suppress IT comments from printing
 ; output
 ;   END = true if user enter "^" or timed-out, passed by reference
 N ENCMR,ENI,ENITRL,ENLOC,ENLOCS,ENMFGR,ENMOD,ENNAM,ENSER,ENSVC,X
 S ENTAG=$G(ENTAG,"CAPEQHD^ENTIUTL")
 S END=$G(END)
 ; display equipment data
 S ENCMR=$$GET1^DIQ(6914,ENDA,19)
 S ENLOC=$$GET1^DIQ(6914,ENDA,24)
 S ENLOCS=$$GET1^DIQ(6914,ENDA,"24:1.5")
 S ENSVC=$$GET1^DIQ(6914,ENDA,21)
 S ENNAM=$$GET1^DIQ(6914,ENDA,3)
 S ENMFGR=$$GET1^DIQ(6914,ENDA,1)
 S ENMOD=$$GET1^DIQ(6914,ENDA,4)
 S ENSER=$$GET1^DIQ(6914,ENDA,5)
 W !,"Entry #: ",ENDA,?21,"CMR: ",ENCMR,?33,"Using Service: ",ENSVC
 W !,?2,"Location: ",ENLOC,?34,"Svc of Location: ",ENLOCS
 W !,?2,"Mfgr Name: ",$E(ENNAM,1,65) W:$E(ENNAM,66,80)]"" "*"
 W !,?2,"Mfgr: ",ENMFGR
 W !,?2,"Model: ",ENMOD,?41,"Ser. #: ",ENSER
 S ENITRL=$$GET1^DIQ(6914,ENDA,91)
 I ENITRL]"" D  Q:END
 . I $Y+3>IOSL D @ENTAG Q:END  D CAPEQHD1
 . N DIWF,DIWL,DIWR,X
 . K ^UTILITY($J,"W")
 . S DIWL=3,DIWR=79,DIWF="W|"
 . S X="IT Remote Location: " D ^DIWP
 . S X=ENITRL D ^DIWP
 . D ^DIWW
 I '$G(SITC),$O(^ENG(6914,ENDA,"ITC",0)) D
 . N DIWF,DIWL,DIWR,X
 . K ^UTILITY($J,"W")
 . S DIWL=3,DIWR=79,DIWF="W|"
 . S X="IT Comments: " D ^DIWP
 . S ENI=0 F  S ENI=$O(^ENG(6914,ENDA,"ITC",ENI)) Q:'ENI  D  Q:END
 . . I $Y+3>IOSL D @ENTAG Q:END  D CAPEQHD1
 . . S X=$G(^ENG(6914,ENDA,"ITC",ENI,0)) D ^DIWP
 . I END K ^UTILITY($J,"W") Q
 . I $Y+3>IOSL D @ENTAG I END K ^UTILITY($J,"W") Q
 . D ^DIWW
 Q
 ;
CAPEQHD ; Captioned Equipment Display Default Header
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 W @IOF
 Q
CAPEQHD1 ; Captioned Equipment Display Second Header
 W "Equipment Entry #: ",ENDA," (continued)"
 Q
 ;
DISASGN(ENDA) ; Display Active Assignments for Equipment to Screen
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ENADA,END,ENSTAT,X,Y
 ; display assignment data
 S END=0
 D DISASGNH
 I '$D(^ENG(6916.3,"AEA",ENDA)) W !," no active assignments" Q
 S ENADA=0
 F  S ENADA=$O(^ENG(6916.3,"AEA",ENDA,ENADA)) Q:'ENADA  D  Q:END
 . I $Y+4>IOSL D  Q:END
 . . S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 . . W @(IOF) D DISASGNH W !," Entry #: ",ENDA," (continued)"
 . W !,$$GET1^DIQ(6916.3,ENADA,1)
 . W ?32,$P($$GET1^DIQ(6916.3,ENADA,2),"@")
 . S ENSTAT=$$GET1^DIQ(6916.3,ENADA,20)
 . W ?46,ENSTAT
 . I ENSTAT'="ASSIGNED" W ?57,$$GET1^DIQ(6916.3,ENADA,21)
 Q
DISASGNH ; Display Assignments Header
 W !!,"Responsible Person",?32,"Assigned DT",?46,"Status",?57,"Status DT"
 W !,"------------------------------",?32,"------------"
 W ?46,"---------",?57,"------------"
 Q
 ;
BLDHL2(ENSM,ENSMV,ENSRT) ; Build Header Line 2 String for Reports
 ; input
 ;   ENSM  = equipment selection method code
 ;   ENSMV = selection method ien value (for applicable methods)
 ;   ENSRT = sort by code
 ; returns string for page header second line
 N ENHL2
 ;
 S ENHL2=" for "
 S:ENSM="A" ENHL2=ENHL2_"All tracked IT equipment"
 S:ENSM="E" ENHL2=ENHL2_"selected equipment"
 S:ENSM="C" ENHL2=ENHL2_"CMR: "_$$GET1^DIQ(6914.1,ENSMV,.01)
 S:ENSM="U" ENHL2=ENHL2_"Using Service: "_$$GET1^DIQ(49,ENSMV,.01)
 S:ENSM="L" ENHL2=ENHL2_"Location: "_$$GET1^DIQ(6928,ENSMV,.01)
 S:ENSM="S" ENHL2=ENHL2_"Service of Loc: "_$$GET1^DIQ(49,ENSMV,.01)
 S ENHL2=ENHL2_" sorted by "
 S:ENSRT="E" ENHL2=ENHL2_"Entry #"
 S:ENSRT="C" ENHL2=ENHL2_"CMR"
 S:ENSRT="U" ENHL2=ENHL2_"Using Service"
 S:ENSRT="L" ENHL2=ENHL2_"Location"
 S:ENSRT="S" ENHL2=ENHL2_"Service of Loc."
 ;
 Q ENHL2
 ;
ADDNP ; Add New Person
 ; called by option ENIT ADD NEW PERSON
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ENX,X,Y
 W !!,"This option should only be used to add a person to the NEW PERSON"
 W !,"(#200) file when that person will be assigned responsibility for"
 W !,"IT equipment but is not already in the file and will NOT be given"
 W !,"a user account to sign on the computer.",!
 ;
 S DIR(0)="Y"
 S DIR("A")="Do you want to add an entry to the NEW PERSON file"
 S DIR("B")="NO"
 D ^DIR K DIR Q:$D(DIRUT)
 ;
 I Y W ! S ENX=$$ADD^XUSERNEW()
 I $P($G(ENX),U)>0,'$P(ENX,U,3) D
 . W !!,$P(ENX,U,2)," already exists with internal number ",$P(ENX,U),"."
 . W !,"If you want to enter a new record with that name, enter the"
 . W !,"name within quotes (e.g. ""Last,First"")",!
 Q
 ;
USRTRM ;Send MailMan message when user with active assignments is terminated
 Q:'$D(^ENG(6916.3,"AOA",XUIFN))
 N ENDA,ENERR,ENI,ENL,ENMFGNM,ENNAME,ENSPACE,ENTX,ENNBR,ENSTATUS,ENDATE,ENX,XMDUZ,XMMG,XMROU,XMSTRIP,XMSUB,XMTEXT,XMY,XMYBLOB,XMZ
 K ^TMP($J,"ENITUTL") S ENDA=XUIFN,$P(ENSPACE," ",41)=""
 D FIND^DIC(6916.3,"","@;.01;1;20;21","PQX",ENDA,"","AOA2","","","^TMP($J,""ENITUTL"")","ENERR")
 I $P($G(^TMP($J,"ENITUTL","DILIST",0)),U)'>0 K ^TMP($J,"ENITUTL") Q
 S ENNAME=$$GET1^DIQ(200,ENDA_",",".01","","","ENERR")
 S ENTX(1)="Owner: "_ENNAME_" ("_ENDA_")"
 S ENTX(2)="was terminated while having the following active IT responsibility assignments:"
 S ENTX(3)=" ",ENTX(4)="Entry#"_$E(ENSPACE,1,6)_"Mfg Equip Name"_$E(ENSPACE,1,11)_"Assignment Status"_$E(ENSPACE,1,3)_"Status Date",ENL=4
 S ENI=0
 F  S ENI=$O(^TMP($J,"ENITUTL","DILIST",ENI)) Q:+ENI'=ENI  D
 . S ENX=$G(^TMP($J,"ENITUTL","DILIST",ENI,0)) Q:ENX=""
 . S ENNBR=$P(ENX,U,2),ENSTATUS=$P(ENX,U,4),ENDATE=$P(ENX,U,5)
 . S ENMFGNM=$E($$GET1^DIQ(6914,ENNBR_",","3","","","ENERR"),1,20)
 . S ENL=ENL+1,ENTX(ENL)=ENNBR_$E(ENSPACE,$L(ENNBR)+1,12)_ENMFGNM_$E(ENSPACE,$L(ENMFGNM)+1,25)_ENSTATUS_$E(ENSPACE,$L(ENSTATUS)+1,20)_ENDATE
 S ENL=ENL+1,ENTX(ENL)=" ",ENL=ENL+1,ENTX(ENL)="   Number of Items= "_($P($G(^TMP($J,"ENITUTL","DILIST",0)),U)+0)
 S ENL=ENL+1,ENTX(ENL)=" ",ENL=ENL+1,ENTX(ENL)="These IT assignments are still active for "_ENNAME_".",ENL=ENL+1,ENTX(ENL)="If appropriate, use the transfer or terminate option to make changes."
 S XMDUZ="AEMS/MERS",XMSUB="Assigned Equipment of Terminated Owner: "_ENNAME
 S XMY("G.EN IT EQUIPMENT")="",XMTEXT="ENTX("
 D ^XMD
 K ^TMP($J,"ENITUTL")
 Q
 ;
 ;ENITUTL
