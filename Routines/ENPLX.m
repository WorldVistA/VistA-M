ENPLX ;WISC/SAB-PROJECT TRANSMISSION ;5/12/97
 ;;7.0;ENGINEERING;**23,28,70**;Aug 17, 1993
EN(ENTY) ; entry point
 ;-------------------------------------------------------------
 ;This option is now obsolete
 ;
 NEW MSG ;Array for message
 S MSG(1,"F")="!!!"
 S MSG(1)="     This option is now Out of Order.  Construction project "
 S MSG(1)=MSG(1)_"data is now "
 S MSG(2)="     entered and reported in a web database at "
 S MSG(2)=MSG(2)_"http://vaww.va.gov/capassets."
 S MSG(3,"F")="!!"
 S MSG(3)="     Please, contact your Network Capital Assets Coordinator,"
 S MSG(3)=MSG(3)_" or VSSC"
 S MSG(4)="     representative for assistance."
 ;
 DO EN^DDIOL(.MSG)
 ;
 QUIT
 ;  
 ;------------------------------------------------------------
 ; Input Variables
 ;    ENTY - type of transmission
 ;           F - Five Year Facility Plan
 ;           A - Project Appliation
 ;           R - Progress Report
 Q:$L($G(ENTY))'=1  Q:"FAR"'[ENTY
 ; check environment
 I '$D(^DIC(6910,1,0)) W !,"Your ENG INIT PARAMETERS file (#6910) is not in order.",$C(7) G EXIT
 I "FA"[ENTY D PPDOM^ENPLUTL I ENDOMAIN="" G EXIT
 I "R"[ENTY D PRDOM^ENPRUTL I ENDOMAIN="" G EXIT
 ; check for members in mail group
 S ENX=$$FIND1^DIC(3.8,"","X","EN PROJECTS")
 I 'ENX W $C(7),!,"Mail group EN PROJECTS is missing." G EXIT
 D LIST^DIC(3.81,","_ENX_",","","",1,"","","","","","ENQ")
 I '$P(ENQ("DILIST",0),U) D  G:$D(DIRUT)!'ENX EXIT
 . W $C(7),!,"No members found in mail group EN PROJECTS. At least one is required."
 . S DIR(0)="Y",DIR("B")="YES"
 . S DIR("A")="Should you be added as a member of EN PROJECTS"
 . S DIR("?",1)="Members of mail group EN PROJECTS receive messages from"
 . S DIR("?",2)="the VISN concerning projects which have been transmitted"
 . S DIR("?",3)="from their facility to the VISN Construction Database."
 . S DIR("?")="Enter YES to be added to this mail group."
 . D ^DIR K DIR Q:$D(DIRUT)  I 'Y S ENX="" Q
 . K ENXMY S ENXMY(DUZ)=""
 . S ENX=$$MG^XMBGRP(ENX,"","","",.ENXMY,"",1)
 . K ENXMY
 K ENX,ENQ
 ; select projects
 D EN^ENPLS(ENTY,1)
 I '$D(^TMP($J,"L")) G EXIT
 ; validate projects
 D EN^ENPLV(ENTY,1)
 ; what should be done if not all valid?
 S ENX=$G(^TMP($J,"L")),ENC("V0")=$P(ENX,U)
 S ENC("V1")=$P(ENX,U,3),ENC("V2")=$P(ENX,U,4),ENC("V3")=$P(ENX,U,5)
 S ENT("PROJ")=ENC("V2")+ENC("V3")
 I 'ENT("PROJ") W !!,"No valid projects to transmit!" G EXIT
 I ENC("V1") D  G EXIT
 . W $C(7),!!,"Since some of the selected projects falied the validated checks,"
 . W !,"none of the selected projects will be transmitted."
 ;I ENC("V1") D  G:'Y!$D(DIRUT) EXIT
 ;. W !!,"Projects which failed the validation checks will not be transmitted."
 ;. S DIR(0)="Y",DIR("B")="NO"
 ;. S DIR("A")="Transmit remaining projects which passed the validation checks"
 ;. S DIR("?")="Answer yes to transmit projects which passed (including those with warnings)."
 ;. D ^DIR K DIR
RP I "R"[ENTY D  G:'Y!$D(DIRUT) EXIT
 . S DIR(0)="D^::EP",DIR("A")="REPORTING PERIOD"
 . S ENRP=$E($S($E(DT,6,7)<21:$$FMADD^XLFDT(DT,-21),1:DT),1,5)_"00"
 . S DIR("B")=$$FMTE^XLFDT(ENRP)
 . S DIR("?",1)="Enter the reporting period (month and year) for the"
 . S DIR("?",2)="progress reports. Each selected project will be"
 . S DIR("?")="updated with this reporting period before transmission."
 . D ^DIR K DIR S ENRP=$E(Y,1,5)_"00"
 I "R"[ENTY,$E(ENRP,4,5)="00" W $C(7),!,"Month is required." G RP
 S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to Queue Transmission"
 S DIR("?",1)="Enter 'Y' if you want the project data placed in mail"
 S DIR("?")="messages as part of a tasked job."
 D ^DIR K DIR G:$D(DIRUT) EXIT I Y D  G EXIT
 . S ZTRTN="QEN^ENPLX",ZTIO=""
 . S ZTDESC="TRAMSIT ENG PROJECT DATA ("_$P("^FYFP^APPL^REPT",U,$L("FAR",ENTY))_")"
 . S ZTSAVE("ENTY")="",ZTSAVE("^TMP($J,""L"",")=""
 . S ZTSAVE("ENT(")="",ZTSAVE("ENDOMAIN")=""
 . S ZTSAVE("ENRP")=""
 . S ZTDTH=$H D ^%ZTLOAD
 . W !,ENT("PROJ")," ",$S(ENTY="F":"Five Year Plan project",ENTY="A":"Project Application",ENTY="R":"Project Progress Report",1:"")
 . W $S(ENT("PROJ")=1:" was",1:"s were")," queued for transmission.",!
QEN ; queued entry point
 S END=0
 S (ENC("MSG"),ENC("PROJ"))=0
 ; determine number of msgs needed
 S ENT("PACK")=$P("^10^1^5",U,$F("FAR",ENTY))
 S ENT("MSG")=ENT("PROJ")\ENT("PACK")+$S(ENT("PROJ")#ENT("PACK"):1,1:0)
 ;
 I $D(ZTQUEUED) D LOCK^ENPLX1 G:END EXIT ; lock valid projects on list
 ; create/send data (netmail)
 S ENPN=""
 F  S ENPN=$O(^TMP($J,"L",ENPN)) Q:ENPN=""  S ENX=^(ENPN) D  G:END EXIT
 . S ENDA=$P(ENX,U)
 . I $P(ENX,U,2)>1 D
 . . ; valid project to xmit
 . . I '(ENC("PROJ")#ENT("PACK")) D CREATE^ENPLX1 Q:END
 . . D:"FA"[ENTY ^ENPLX2,UPD^ENPLX1
 . . D:"R"[ENTY REPTPR^ENPLX1,^ENPLX4,REPTPS^ENPLX1
 . . S ENC("PROJ")=ENC("PROJ")+1
 . . I $E(IOST,1,2)="C-" W "."
 I $G(XMZ)'<1 D SEND^ENPLX1
 I '$D(ZTQUEUED) D
 . W !,ENC("PROJ")," ",$S(ENTY="F":"Five Year Plan project",ENTY="A":"Project Application",ENTY="R":"Project Progress Report",1:"")
 . W $S(ENC("PROJ")=1:" was",1:"s were")," transmitted using "
 . W ENC("MSG")," mail message",$S(ENC("MSG")=1:"",1:"s"),".",!
EXIT ;
 D UNLOCK^ENPLS
 K ^TMP($J,"L")
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,XMCHAN,X,Y
 K ENC,ENCLDT,END,ENDA,ENDOMAIN,ENDT,ENL,ENPN,ENQ
 K ENRP,ENT,ENTYT,ENX,ENY
 Q
 ;ENPLX
