SDWLCU5 ;IOFO BAY PINES/TEH - EWL FILE 409.3 CLEANUP ;2/4/03  ; Compiled August 20, 2007 17:04:58
 ;;5.3;scheduling;**280,427,491**;AUG 13 1993;Build 53
EN ;
 W !!,"Checking file 404.51 one last time.",!
 S SDWLERR="",TEAM=0 F  S TEAM=$O(^SCTM(404.51,TEAM)) Q:'TEAM  D  Q:SDWLERR=1
 . S INST=$$GET1^DIQ(404.51,TEAM_",",.07,"I")
 . S CODE=$$GET1^DIQ(4,INST_",",11,"I")
 . S INCK=$$TF^XUAF4(INST)
 . I CODE'="N"!('INCK) D
 .. W !!,"TEAM: ",$$GET1^DIQ(404.51,TEAM_",",.01),"    INSTITUTION: "
 .. W $$GET1^DIQ(4,INST_",",.01)
 .. D EDIT^SDWLCU2
 Q:SDWLERR=1
 ;
 W !!,"Checking file 409.31 one last time.",!
40931 S SDWLSS=0 F  S SDWLSS=$O(^SDWL(409.31,SDWLSS)) Q:'SDWLSS  D  Q:SDWLERR=1
 . S SDWLINS="" F  S SDWLINS=$O(^SDWL(409.31,SDWLSS,"I","B",SDWLINS)) Q:'SDWLINS  D  Q:SDWLERR=1
 .. S CODE=$$GET1^DIQ(4,SDWLINS_",",11,"I")
 .. S INCK=$$TF^XUAF4(SDWLINS)
 .. I CODE'="N"!('INCK) D
 ... W !!,"SERVICE SPECIALTY: ",$$GET1^DIQ(409.31,SDWLSS_",",.01),"    INSTITUTION: "
 ... W $$GET1^DIQ(4,SDWLINS_",",.01)
 ... D GETINS Q:SDWLERR=1
 ... S SDWLSSX="" F  S SDWLSSX=$O(^SDWL(409.31,SDWLSS,"I","B",SDWLINS,SDWLSSX)) Q:'SDWLSSX  D  Q:SDWLERR=1
 .... D C3^SDWLCU3
 Q:SDWLERR=1
40932 W !!,"Checking file 409.32 one last time.",!
 N INERROR S INERROR="" S SDWLSC=0 F  S SDWLSC=$O(^SDWL(409.32,SDWLSC)) Q:'SDWLSC  D UPDINS(SDWLSC,.INERROR)
 Q:INERROR=1
 N DIK S DIK="^SDWL(409.32," D IXALL^DIK
 W !!,"Checking file 409.3 one last time.",!
 S SDWLERR=""
 S SDWLDA=0,TAG="CHK" F  S SDWLDA=$O(^SDWL(409.3,SDWLDA)) Q:SDWLDA<1  D  Q:SDWLERR=1
 .S X=$G(^SDWL(409.3,SDWLDA,0)),SDWLINST=$P(X,"^",3),SDWLTY=$P(X,"^",5)
 .Q:'SDWLTY!'SDWLINST
 .S SDWLI=$P(X,"^",SDWLTY+5) Q:'SDWLI
 .S TAG="CHK",TAG=TAG_SDWLTY,C=0 K ^TMP($J,"SDWLCU5",$J) D @TAG
 W !,"Done."
 Q
UPDINS(SDWLSC,INERROR) ; update 409.32 and the related entroes in 409.3
 N SDWLINS S SDWLINS=$$GET1^DIQ(409.32,SDWLSC_",",.02,"I") ; current set up IN 409.32
 ;check set up in file 44
 ;get clinic
 N CL,CLN S CL=$$GET1^DIQ(409.32,SDWLSC_",",.01,"I"),CLN=$$GET1^DIQ(44,CL_",",.01)
 N STR,SDWMES S SDWMES="",STR=$$CLIN^SDWLPE(CL)
 S SDWMES=SDWMES_$P(STR,U,6)
 I $P(STR,U,5)="L" S SDWMES=SDWMES_" - Local Institution assigned to clinic. "
 I SDWMES'="" D  Q
 .W !!," ** Incorrect Setting up of Clinic "_CLN_" ("_CL_")"_": **"
 .W !!,SDWMES
 .W !!,"INSTALLATION WILL CONTINUE WITHOUT UPDATING THIS ENTRY."
 .W !!,"AFTER INSTALLATION CORRECT THE CLINIC SETUP AND THEN",!," RUN OPTION SD WAIT LIST CLEANUP."
 .S:INERROR="" INERROR=1 Q
 I +STR'=SDWLINS W !!,"Clinic "_CLN_" ("_CL_")"_"does not have the same Institution as EWL set up." D
 .W !!,"EWL Clinic INSTITUTION: ",$$GET1^DIQ(4,SDWLINS_",",.01)_" - "_$$GET1^DIQ(4,SDWLINS_",",99)
 .W !,"Clinic INSTITUTION: ",$P(STR,U,3)_" - "_$P(STR,U,2)
 .W !!,"EWL set up will be updated with the Clinic from the Hospital Location file,"
 .W !,"and the related open EWL entries will be updated as well."
 .N DIE,DR,DA S DR=".02////^S X=+STR",DIE="^SDWL(409.32,",DA=SDWLSC
 .L +^SDWL(409.32,DA):0 I '$T W !?5,"Another user is editing this entry. try later." Q
 .D ^DIE L -^SDWL(409.32,DA)
 .;loop to update EWL entries in FILE 409.3 if any
 .N SCL,DA,DR,CNT S SCL="",CNT=0 F  S SCL=$O(^SDWL(409.3,"SC",CL,SCL)) Q:SCL'>0  D
 ..I '$D(^SDWL(409.3,SCL,0)) K ^SDWL(409.3,"SC",CL,SCL) Q
 ..S DR="2////^S X=+STR",DIE="^SDWL(409.3,",DA=SCL
 ..L +^SDWL(409.3,SCL):0 I '$T W !?5,"Another user is editing this entry. try later." Q
 ..D ^DIE L -^SDWL(409.3,SCL) S CNT=CNT+1
 .I CNT>0 W !,CNT_" EWL entries for clinic "_CLN_" updated."
 N DA I $$GET1^DIQ(409.32,SDWLSC_",",3,"I")="" I $$GET1^DIQ(409.32,SDWLSC_",",1,"I")'>0 D
 .S DA=SDWLSC L +^SDWL(409.32,SDWLSC):0 I '$T W !?5,"Another user is editing this entry. try later." Q
 .S DR="1////^S X=DT;2////^S X=DUZ",DIE="^SDWL(409.32," ;enter activation date and user
 .D ^DIE L -^SDWL(409.32,SDWLSC)
 .W !,"EWL Clinic entry for "_CLN_" updated with today's activation date."
 Q
CHK1 ;CHECK FOR INSTITUTION VALIDILITY
 S SDWLERR=0
 I SDWLTY=1 S SDWLI=0 F  S SDWLI=$O(^SCTM(404.51,"AINST",SDWLI)) Q:SDWLI=""  I $D(^DIC(4,SDWLI)) S C=C+1,^TMP($J,"SDWLCU5",$J,C,SDWLI)="",^TMP($J,"SDWLCU5",$J,"B",SDWLI)=""
 I $D(^TMP($J,"SDWLCU5",$J,"B",SDWLINST)) Q
 K ^TMP($J,"SDWLCU5",$J,"B")
 I 'C S SDWLINSN=$S($D(DUZ(2)):DUZ(2),1:"") D CH1E Q
 I C=1 S SDWLINSN=$O(^TMP($J,"SDWLCU5",$J,C,0)) D CH1E Q
 W !,"Please select a valid Institution for this record from the following list for",!
 D DIS
 S C=0,SDWLI="" F  S C=$O(^TMP($J,"SDWLCU5",$J,C)) Q:C<1  D
 .F  S SDWLI=$O(^TMP($J,"SDWLCU5",$J,C,SDWLI)) Q:SDWLI=""  W !,?20,C,". ",$$GET1^DIQ(4,SDWLI_",",.01) S CS=C
CHK10 W ! S DIR(0)="NO^1:"_CS D ^DIR
 I Y<1!($D(DUOUT)) W !,"Response Required." S SDWLERR=1 Q
 S SDWLINSN=$O(^TMP($J,"SDWLCU5",$J,+Y,0))
CH1E S SDWLINS(409.3,SDWLDA_",",2)=SDWLINSN D UPDATE^DIE("","SDWLINS","SDWLMSG")
 S TAG="CHK"
 Q
CHK3 ;
 S SDWLERR=""
 S SDWLI=$P(^SDWL(409.3,SDWLDA,0),U,8)
 Q:'SDWLI!'$D(^SDWL(409.31,SDWLI))
 I '$D(^SDWL(409.31,SDWLI,"I","B",SDWLINST)) D  Q:SDWLERR=1
 .S SDWLIX="",C=0 F  S SDWLIX=$O(^SDWL(409.31,SDWLI,"I","B",SDWLIX)) Q:SDWLIX=""  S C=C+1,^TMP($J,"SDWLCU5",$J,C,SDWLIX)="",^TMP($J,"SDWLCU5",$J,"B",SDWLIX)=""
 .I 'C N SITE S SITE=+$$SITE^VASITE(,) S SDWLINSN=$S(SITE>0:SITE,1:""),Y=1 D CHE3 Q
 .I C=1 S SDWLINSN=$O(^TMP($J,"SDWLCU5",$J,C,0)),Y=1 D CHE3 Q
 .W !,"Please select a valid Institution for this record from the following list for",!
 .D DIS
 .S C=0,SDWLIZ=0 F  S SDWLIZ=$O(^SDWL(409.31,SDWLI,"I","B",SDWLIZ)) Q:SDWLIZ=""  D
 ..Q:$$GET1^DIQ(4,SDWLIZ_",",11,"I")'="N"!('$$TF^XUAF4(SDWLIZ))
 ..S C=C+1 W !,?20,C,". ",$$GET1^DIQ(4,SDWLIZ_",",.01)
 .W ! S DIR(0)="NO^1:"_C D ^DIR
 .I $D(DUOUT)!(Y="") S SDWLERR=1 Q
 .S SDWLINSN=$O(^TMP($J,"SDWLCU5",$J,+Y,0))
 .D CHE3
 Q
CHE3 ;
 G CHK3:Y<0
 S SDWLINS(409.3,SDWLDA_",",2)=SDWLINSN D UPDATE^DIE("","SDWLINS","SDWLMSG")
 S TAG="CHK"
 Q
CHK4 ;
 S SDWLI=$P(^SDWL(409.3,SDWLDA,0),U,9)
 Q:'SDWLI!'$D(^SDWL(409.32,SDWLI,0))
 I $P(^SDWL(409.32,SDWLI,0),U,6)'=SDWLINST D
 .D DIS
 .S SDWLINSN=$P(^SDWL(409.32,SDWLI,0),U,6),SDWLINS(409.3,SDWLDA_",",2)=SDWLINSN D UPDATE^DIE("","SDWLINS","SDWLMSG")
 Q
CHK2 ;
 S SDWLPO=$P($G(^SDWL(409.3,SDWLDA,0)),U,7),SDWLTM=$P($G(^SCTM(404.57,SDWLPO,0)),U,2),SDWLINSN=$P($G(^SCTM(404.51,SDWLTM,0)),U,7)
 I SDWLINST'=SDWLINSN D
 .S SDWLINS(409.3,SDWLDA_",",2)=SDWLINSN D UPDATE^DIE("","SDWLINS","SDWLMSG")
 S TAG="CHK"
 Q
DIS ;display record
 S NN=$P($G(^SDWL(409.3,SDWLDA,0)),"^"),NAME=$$GET1^DIQ(2,NN_",",.01,"E")
 S SSN=$$GET1^DIQ(2,NN_",",.09)
 W !,"Record#: ",SDWLDA,"  Patient: ",NAME," (",SSN,")",!!
 Q
GETINS ;Get institution
 N DIR
 S DIR("A")="Select Institution: "
 S DIR(0)="PAO^4:EMZ",DIR("S")="I $P(^DIC(4,+Y,0),U,11)=""N"",$$TF^XUAF4(+Y)" D ^DIR
 I X["^" S SDWLERR=1 Q
 I Y<1 W *7,"Invalid Entry" G GETINS
 S SDWLINSN=+Y
 Q
