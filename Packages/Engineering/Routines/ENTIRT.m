ENTIRT ;WOIFO/LKG - TERMINATE RESPONSIBILITY ;2/4/08  12:32
 ;;7.0;ENGINEERING;**87,89**;Aug 17, 1993;Build 20
TERMLST ;Entry for list termination processing
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DIC,D,ENACL,ENCNT,ENDA,ENMETHOD,ENERR,ENX,ENI,ENJ,X,Y
LSTSTART S DIR(0)="S^E:EQUIPMENT;P:PERSON",DIR("A")="Specify method for selecting IT assignments"
 D ^DIR K DIR G:$D(DIRUT) LSTEXIT
 S ENMETHOD=Y
 I ENMETHOD="E" D  G:$D(ENERR) LSTEXIT
 . N D,DIC S DIC("S")="I $D(^ENG(6916.3,""AEA"",Y))" D GETEQ^ENUTL
 . I $D(DTOUT)!$D(DUOUT)!(Y<1) S ENERR=1 Q
 . S ENDA=+Y
 . K DIC,D,^TMP($J,"ENITTR"),ENERR
 . D FIND^DIC(6916.3,"","@;.01;1;20","PQX",ENDA,"","AEA","I $P(^(0),U,8)=""""","","^TMP($J,""ENITTR"")","ENERR")
 I ENMETHOD="P" D  G:$D(ENERR) LSTEXIT
 . N D,DIC S DIC=200,DIC(0)="AEMQ",DIC("S")="I $D(^ENG(6916.3,""AOA"",Y))"
 . D ^DIC I $D(DTOUT)!$D(DUOUT)!(Y<1) S ENERR=1 Q
 . S ENDA=+Y
 . K DIC,D,^TMP($J,"ENITTR"),ENERR
 . D FIND^DIC(6916.3,"","@;.01;1;20","PQX",ENDA,"","AOA2","I $P(^(0),U,8)=""""","","^TMP($J,""ENITTR"")","ENERR")
 I $P($G(^TMP($J,"ENITTR","DILIST",0)),U)'>0 W !!,"There are no active responsibilities for this "_$S(ENMETHOD="E":"equipment",ENMETHOD="P":"person",1:"")_"." K DIR S DIR(0)="E" D ^DIR K DIR K ^TMP($J,"ENITTR") G LSTEXIT:'Y,LSTSTART
 K ^TMP($J,"SCR"),^TMP($J,"INDX"),ENACL
 S ^TMP($J,"SCR")=$P(^TMP($J,"ENITTR","DILIST",0),U)_"^ACTIVE IT RESPONSIBILITIES"
 S ^TMP($J,"SCR",0)="5;9;ENTRY #^15;20;MFG EQUIP NAME^37;30;OWNER^69;10;STATUS"
 S ENI=0
 F  S ENI=$O(^TMP($J,"ENITTR","DILIST",ENI)) Q:+ENI'>0  D
 . N ENX S ENX=$G(^TMP($J,"ENITTR","DILIST",ENI,0))
 . S ^TMP($J,"SCR",ENI)=$P(ENX,U,2)_U_$E($$GET1^DIQ(6914,$P(ENX,U,2)_",",3),1,20)_U_$P(ENX,U,3,4)
 . S ^TMP($J,"INDX",ENI)=$P(ENX,U)
 K ^TMP($J,"ENITTR")
 D EN2^ENPLS2(1)
 G:'$D(ENACL)!$D(DIRUT) LSTEXIT
 S DIR(0)="Y",DIR("A")="OK to terminate assignments",DIR("B")="NO" D ^DIR K DIR
 G:'Y!$D(DIRUT) LSTEXIT
 S ENCNT=0,ENX=""
 F  S ENX=$O(ENACL(ENX)) Q:ENX=""  D
 . N ENXSTR
 . S ENXSTR=$G(ENACL(ENX)) Q:ENXSTR=""
 . I $L(ENXSTR,",")>0 D
 . . F ENJ=1:1 S ENI=$P(ENXSTR,",",ENJ) Q:+ENI'>0  D
 . . . S DA=^TMP($J,"INDX",ENI) L +^ENG(6916.3,DA):$S($G(DILOCKTM)>5:DILOCKTM,1:5) E  D MSG(DA,"Termination") Q
 . . . S X=$$TERM^ENTIUTL1(DA)
 . . . L -^ENG(6916.3,DA) K DA
 . . . S ENCNT=ENCNT+1
 W !!,ENCNT," IT responsibilities were terminated." K DIR S DIR(0)="E" D ^DIR K DIR
 K ^TMP($J,"SCR"),^TMP($J,"INDX")
 G LSTEXIT:'Y,LSTSTART
LSTEXIT ;
 K ^TMP($J,"SCR"),^TMP($J,"INDX")
 Q
MSG(ENDA,ENMSG) ;Write Error Message
 N END,ENERR,ENDAC S ENDAC=ENDA_"," D GETS^DIQ(6916.3,ENDAC,".01;1","E","END","ENERR")
 W !,"Assignment Equip Entry# ",$G(END(6916.3,ENDAC,.01,"E"))," for ",$G(END(6916.3,ENDAC,1,"E"))," is locked by another process.",!?10,ENMSG," was bypassed."
 Q
 ;
 ;ENTIRT
