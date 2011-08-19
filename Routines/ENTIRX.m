ENTIRX ;WOIFO/LKG - TRANSFER RESPONSIBILITY ;2/5/08  14:58
 ;;7.0;ENGINEERING;**87,89**;Aug 17, 1993;Build 20
TERMLST ;Entry for transfer processing
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DIC,D,ENA,ENACL,ENCNT,ENCNT2,ENDA,ENMETHOD,ENNAME,ENNBR,ENPER,ENRES,ENERR,ENX,ENI,ENJ,X,X1,Y
LSTSTART S DIR(0)="S^E:EQUIPMENT;P:PERSON",DIR("A")="Specify method for selecting IT assignments"
 D ^DIR K DIR G:$D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) LSTEXIT
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
 I '$D(ENACL)!$D(DIRUT)!$D(DIROUT) K ^TMP($J,"SCR"),^TMP($J,"INDX") G LSTEXIT
ASKNAME K DIC S DIC=200,DIC(0)="AEMQ",DIC("A")="Select person for new assignment: "
 D ^DIC I +Y<1!$D(DTOUT)!$D(DUOUT) G LSTEXIT
 S ENPER=+Y,ENNAME=$P(Y,U,2) K DIR S DIR(0)="Y",DIR("A")="Assign responsibility to "_ENNAME,DIR("B")="NO"
 D ^DIR G LSTEXIT:$D(DIRUT),ASKNAME:'Y
 S DIR(0)="Y",DIR("A")="OK to transfer assignments",DIR("B")="NO" D ^DIR K DIR
 G:'Y!$D(DIRUT) LSTEXIT W !
 S ENCNT=0,ENCNT2=0,ENX="" K ENA K ^TMP($J,"ENSIGN")
 F  S ENX=$O(ENACL(ENX)) Q:ENX=""  D
 . N ENXSTR
 . S ENXSTR=$G(ENACL(ENX)) Q:ENXSTR=""
 . I $L(ENXSTR,",")>0 D
 . . F ENJ=1:1 S ENI=$P(ENXSTR,",",ENJ) Q:+ENI'>0  D
 . . . S DA=^TMP($J,"INDX",ENI) L +^ENG(6916.3,DA):$S($G(DILOCKTM)>5:DILOCKTM,1:5) E  D MSG^ENTIRT(DA,"Transfer") Q
 . . . S X=$$TERM^ENTIUTL1(DA)
 . . . L -^ENG(6916.3,DA)
 . . . S ENCNT=ENCNT+1
 . . . S ENNBR=$P($G(^ENG(6916.3,DA,0)),U) Q:'ENNBR
 . . . I '$D(ENA(ENNBR)) S ENRES=$$ASGN^ENTIUTL1(ENNBR,ENPER),ENA(ENNBR)=ENRES S:ENRES ENCNT2=ENCNT2+1 W:ENRES=0 !,ENNBR," is already assigned to ",ENNAME,"." S:(ENPER=DUZ)&ENRES ^TMP($J,"ENSIGN",ENRES)=""
 W !!,ENCNT," IT responsibilities were terminated.",!,ENCNT2," assignments were created." K DIR S DIR(0)="E" D ^DIR K DIR K ^TMP($J,"SCR"),^TMP($J,"INDX") G:'Y LSTEXIT
 I ENPER=DUZ,$$SIGNOK() D
 . N L,DIC,FLDS,FR,TO,BY,IOP,DHD,ENMSG
 . S DA=$O(^ENG(6916.2,"@"),-1)
 . I '$$CMP^XUSESIG1($P($G(^ENG(6916.2,DA,0)),U,3),$NAME(^ENG(6916.2,DA,1))) W !!,"Hand receipt text is corrupted - Please contact EPS AEMS/MERS support." Q
 . S L=0,DIC=6916.2,FLDS=1,FR=DA,TO=DA,BY="@NUMBER",IOP="HOME",DHD="@"
 . D EN1^DIP
 . K DIR S DIR(0)="Y",DIR("A")="OK to sign",DIR("B")="NO" D ^DIR K DIR
 . Q:'Y!$D(DIRUT)
 . D SIG^XUSESIG I X1="" W !,"<Invalid Electronic Signature> Signing Aborted." Q
 . S ENDA="",ENCNT=0
 . F  S ENDA=$O(^TMP($J,"ENSIGN",ENDA)) Q:ENDA=""  D
 . . L +^ENG(6916.3,ENDA):$S($G(DILOCKTM)>5:DILOCKTM,1:5) E  D MSG^ENTIRT(ENDA,"Signature") Q
 . . I $$SIGN^ENTIUTL1(ENDA) S ENCNT=ENCNT+1 K ^TMP($J,"ENSIGN",ENDA)
 . . L -^ENG(6916.3,ENDA)
 . W !!,ENCNT," assignment records were signed."
 . S ENDA=""
 . F  S ENDA=$O(^TMP($J,"ENSIGN",ENDA)) Q:ENDA=""  D
 . . N END,ENERR,ENDAC S ENDAC=ENDA_"," D GETS^DIQ(6916.3,ENDAC,".01;1","E","END","ENERR")
 . . W !,"Assignment Equip Entry# ",$G(END(6916.3,ENDAC,.01,"E"))," for ",$G(END(6916.3,ENDAC,1,"E"))," was not signed."
 . . K ^TMP($J,"ENSIGN",ENDA)
 G LSTSTART:'$D(DIRUT)
LSTEXIT ;
 K ^TMP($J,"ENSIGN"),^TMP($J,"ENITTR"),^TMP($J,"INDX"),^TMP($J,"SCR")
 Q
SIGNOK() ;Ask if want to sign for equipment
 K DIR S DIR(0)="Y",DIR("A")="Do you want to sign to accept responsibility now",DIR("B")="NO"
 D ^DIR K DIR
 Q Y
 ;
 ;ENTIRX
