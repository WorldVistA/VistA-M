ENTIRC ;WOIFO/LKG - Certify IT Acceptance ;2/5/08  14:48
 ;;7.0;ENGINEERING;**87,89**;Aug 17, 1993;Build 20
IN ;Entry point
 N D,DIC,DTOUT,DUOUT,DIRUT,DIROUT,DIR,ENDA,ENDAC,ENNAME,ENI,ENJ,ENDATE,ENCNT,ENX,ENZ,X,X1,Y,L,DIC,FLDS,FR,TO,BY,IOP,DHD
LOOPST ;
 S:'$G(DT) DT=$$DT^XLFDT()
 K D,DIC S DIC=200,DIC(0)="AEMQ",DIC("S")="I $D(^ENG(6916.3,""AOA"",Y))"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT)!(Y<1) G EX
 S ENDA=+Y,ENNAME=$P(Y,U,2)
 K D,^TMP($J,"ENITRC"),ENERR
 D FIND^DIC(6916.3,"","@;.01;1;20","PQX",ENDA,"","AOA2","I $P(^(0),U,8)="""",$S($P(^(0),U,5)="""":1,$$FMDIFF^XLFDT(DT,$P(^(0),U,5))>359:1,1:0)","","^TMP($J,""ENITRC"")","ENERR")
 I $P($G(^TMP($J,"ENITRC","DILIST",0)),U)'>0 W !!,"There are no unaccepted IT responsibilities to be certified." K DIR S DIR(0)="E" D ^DIR K DIR K ^TMP($J,"ENITRC") G EX:'Y,LOOPST
 K ^TMP($J,"SCR"),^TMP($J,"INDX"),ENACL W !
 S ^TMP($J,"SCR")=$P(^TMP($J,"ENITRC","DILIST",0),U)_"^IT RESPONSIBILITIES TO CERTIFY FOR "_ENNAME
 S ^TMP($J,"SCR",0)="5;9;ENTRY #^15;20;MFG EQUIP NAME^37;25;MODEL^65;14;SERIAL#"
 S ENI=0
 F  S ENI=$O(^TMP($J,"ENITRC","DILIST",ENI)) Q:+ENI'>0  D
 . N ENX,END,ENERR S ENX=$G(^TMP($J,"ENITRC","DILIST",ENI,0))
 . S ENDAC=$P(ENX,U,2)_"," D GETS^DIQ(6914,ENDAC,"3;4;5","E","END","ENERR")
 . S ^TMP($J,"SCR",ENI)=$P(ENX,U,2)_U_$E($G(END(6914,ENDAC,3,"E")),1,20)_U_$G(END(6914,ENDAC,4,"E"))_U_$G(END(6914,ENDAC,5,"E"))
 . S ^TMP($J,"INDX",ENI)=$P(ENX,U)
 K ^TMP($J,"ENITRC")
 D EN2^ENPLS2(1) G:'$D(ENACL) EX
 K DIR S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="NO" D ^DIR K DIR
 G:'Y!$D(DIRUT) EX
 S ENDA=$O(^ENG(6916.2,"@"),-1)
 I '$$CMP^XUSESIG1($P($G(^ENG(6916.2,ENDA,0)),U,3),$NAME(^ENG(6916.2,ENDA,1))) W !!,"Hand receipt text is corrupted - Please contact EPS AEMS/MERS support" G EX
 K L,DIC,FLDS,FR,TO,BY,IOP,DHD
 S L=0,DIC=6916.2,FLDS=1,FR=ENDA,TO=ENDA,BY="@NUMBER",IOP="HOME",DHD="@"
 D EN1^DIP K DIR S DIR(0)="Y",DIR("A")="Is this the text on the signed, printed hand receipt",DIR("B")="NO" D ^DIR K DIR
 G:$D(DIRUT) EX I 'Y W !!,"Signed copy is not current.",!?5,"Please ask person to sign current version of hand receipt." K DIR S DIR(0)="E" D ^DIR K DIR G EX
 K L,DIC,FLDS,FR,TO,BY,IOP,DHD
 K DIR S DIR(0)="D^"_$$BEGDATE()_":"_DT_":EX",DIR("A")="Date person signed hard copy hand receipt" D ^DIR K DIR
 I 'Y!$D(DIRUT) W !!,"Certification Aborted." G EX
 S ENDATE=Y
 K DIR S DIR(0)="Y",DIR("A")="OK to certify",DIR("B")="NO" D ^DIR K DIR
 G:'Y!$D(DIRUT) EX
 D SIG^XUSESIG I X1="" W !,"<Failed Electronic Signature> Certification Aborted." G EX
 S ENCNT=0,ENX=""
 F  S ENX=$O(ENACL(ENX)) Q:ENX=""  D
 . N ENXSTR S ENXSTR=$G(ENACL(ENX)) Q:ENXSTR=""
 . I $L(ENXSTR,",")>0 D
 . . F ENJ=1:1 S ENI=$P(ENXSTR,",",ENJ) Q:+ENI'>0  D
 . . . S ENDA=^TMP($J,"INDX",ENI) L +^ENG(6916.3,ENDA):$S($G(DILOCKTM)>5:DILOCKTM,1:5) E  D MSG^ENTIRT(ENDA,"Certification") Q
 . . . S ENZ=$$CERT^ENTIUTL1(ENDA,ENDATE)
 . . . S:ENZ ENCNT=ENCNT+1 D:'ENZ MSG2(ENDA)
 . . . L -^ENG(6916.3,ENDA)
 W !!,ENCNT," assignment records were certified."
 K DIR S DIR(0)="E" D ^DIR K DIR
 G:Y LOOPST
EX ;
 K ^TMP($J,"SCR"),^TMP($J,"INDX"),ENACL
 Q
MSG2(ENDA) ;error message on certification failure
 N END,ENERR,ENDAC S ENDAC=ENDA_","
 D GETS^DIQ(6916.3,ENDAC,".01;1","E","END","ENERR")
 W !,"Assignment Equip Entry# ",$G(END(6916.3,ENDAC,.01,"E"))," for ",$G(END(6916.3,ENDAC,1,"E"))," is not active ",!?5,"and was not certified."
 Q
BEGDATE() ;Earliest date for certification
 N ENDA,ENDATE,ENI,ENJ,ENASGNDT,ENX,ENXSTR
 S ENX="",ENDATE=$$FMADD^XLFDT(DT,-359)
 F  S ENX=$O(ENACL(ENX)) Q:ENX=""  D
 . S ENXSTR=$G(ENACL(ENX)) Q:ENXSTR=""
 . I $L(ENXSTR,",")>0 D
 . . F ENJ=1:1 S ENI=$P(ENXSTR,",",ENJ) Q:+ENI'>0  D
 . . . S ENDA=^TMP($J,"INDX",ENI),ENASGNDT=$P($P($G(^ENG(6916.3,ENDA,0)),U,3),".")
 . . . S:ENASGNDT>ENDATE ENDATE=ENASGNDT
 Q ENDATE
 ;
 ;ENTIRC
