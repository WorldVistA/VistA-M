ENTIRRH ;WOIFO/LKG - Print hand receipt ;3/19/08  15:48
 ;;7.0;ENGINEERING;**87,89**;Aug 17, 1993;Build 20
ASK ;Main entry point
 N ENOPT D OP^XQCHK S ENOPT=$P(XQOPT,U)
 K DIR S DIR(0)="S^D:DATE OF SIGNATURE;S:SIGNED;U:UNSIGNED",DIR("A")="Print Hand Receipt for Unsigned or Signed IT assignments",DIR("B")="UNSIGNED"
 S DIR("?",1)="'D' selects assignments signed electronically or via wet signature on a"
 S DIR("?",2)="      given date, regardless of current status."
 S DIR("?",3)="'S' selects active assignments signed electronically or via wet signature."
 S DIR("?",4)="'U' selects active assignments not signed, either electronically or via wet"
 S DIR("?",5)="      signature or signed documents where the signature date is more than"
 S DIR("?")="      359 days ago.  Assignments must be re-signed annually."
 D ^DIR K DIR I $D(DIRUT) K DIRUT,DIROUT,DTOUT,DUOUT Q
 G:Y="D" USER^ENTIRRH1:ENOPT="ENIT PRINT HAND RCPT (COM)",ITST2^ENTIRRH1:ENOPT="ENIT PRINT HAND RCPT (IT)"
 G:Y="U" USTART:ENOPT="ENIT PRINT HAND RCPT (COM)",ITSTART:ENOPT="ENIT PRINT HAND RCPT (IT)"
 G:Y="S" USER:ENOPT="ENIT PRINT HAND RCPT (COM)",ITST2:ENOPT="ENIT PRINT HAND RCPT (IT)"
 W !,"UNKNOWN" Q
ITSTART ;Entry point for IT
 N ENDA,ENVR S ENVR=$O(^ENG(6916.2,"@"),-1) I ENVR'>0 W !,"There are no hand receipt templates on file." K DIR S DIR(0)="E" D ^DIR K DIR Q
 N DIC,DTOUT,DUOUT S DIC=200,DIC(0)="AEMQ",DIC("A")="IT Responsible Person: ",DIC("S")="I $D(^ENG(6916.3,""AOA"",Y))"
 D ^DIC I Y<1!$D(DTOUT)!$D(DUOUT) Q
 S ENDA=+Y
 S %ZIS="Q" D ^%ZIS I POP K POP Q
 I $D(IO("Q")) S ZTRTN="IN^ENTIRRH",ZTDESC="IT Equipment Hand Receipt Print",ZTSAVE("ENDA")="",ZTSAVE("ENVR")="" D ^%ZTLOAD,HOME^%ZIS K ZTSK,IO("Q") Q
 G IN
USTART ;User entry point
 N ENDA,ENVR S ENVR=$O(^ENG(6916.2,"@"),-1) I ENVR'>0 W !,"There are no hand receipt templates on file." K DIR S DIR(0)="E" D ^DIR K DIR Q
 I '$D(^ENG(6916.3,"AOA",DUZ)) W !,"You have no active IT assignments." K DIR S DIR(0)="E" D ^DIR K DIR Q
 S ENDA=DUZ
 S %ZIS="Q" D ^%ZIS I POP K POP Q
 I $D(IO("Q")) S ZTRTN="IN^ENTIRRH",ZTDESC="IT Equipment Hand Receipt Print",ZTSAVE("ENDA")="",ZTSAVE("ENVR")="" D ^%ZTLOAD,HOME^%ZIS K ZTSK,IO("Q") Q
 G IN
IN ;
 U IO
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,END,ENDAC,ENERR,ENI,ENLNCNT,ENMFGN,ENMODEL,ENNOW,ENPG,ENEQPT,ENX,ENNBR,ENSERNBR,ENNAME,ENSTN,X,Y
 S ENNAME=$$GET1^DIQ(200,ENDA_",",.01),ENNOW=$$FMTE^XLFDT($$NOW^XLFDT(),"2M"),ENPG=0,ENEQPT=1 S:'$G(DT) DT=$$DT^XLFDT()
 S ENSTN=+$O(^DIC(6910,0)),ENSTN=$$GET1^DIQ(6910,ENSTN_",",1)
 D HDR1 G:$D(DIRUT) EX
 K ^TMP($J,"ENITRRH"),ENERR
 D FIND^DIC(6916.3,"","@;.01;1;20","PQX",ENDA,"","AOA2","I $P(^(0),U,8)="""",$S($P(^(0),U,5)="""":1,$$FMDIFF^XLFDT(DT,$P(^(0),U,5))>359:1,1:0)","","^TMP($J,""ENITRRH"")","ENERR")
 I $P($G(^TMP($J,"ENITRRH","DILIST",0)),U)'>0 W !,"The are no unsigned IT assignments." G EX
 I '$$CMP^XUSESIG1($P($G(^ENG(6916.2,ENVR,0)),U,3),$NAME(^ENG(6916.2,ENVR,1))) W !!!,"Hand receipt text is corrupted - Please contact EPS AEMS/MERS support"  G EX
 S ENI=0
 F  S ENI=$O(^TMP($J,"ENITRRH","DILIST",ENI)) Q:+ENI'=ENI  D  Q:$D(DIRUT)
 . S ENX=$G(^TMP($J,"ENITRRH","DILIST",ENI,0))
 . S ENDAC=$P(ENX,U,2)_"," D GETS^DIQ(6914,ENDAC,"3;4;5","E","END","ENERR")
 . S ENNBR=$P(ENX,U,2),ENMFGN=$G(END(6914,ENDAC,3,"E")),ENMODEL=$G(END(6914,ENDAC,4,"E")),ENSERNBR=$G(END(6914,ENDAC,5,"E"))
 . I IOSL-1'>ENLNCNT D HDR1 Q:$D(DIRUT)
 . W !,ENNBR,?11,$E(ENMFGN,1,20),?35,ENMODEL,?65,ENSERNBR S ENLNCNT=ENLNCNT+1
 G:$D(DIRUT) EX
 S ENEQPT=0
 I IOSL-1'>ENLNCNT D HDR1 G:$D(DIRUT) EX
 I ENLNCNT>3 W !! S ENLNCNT=ENLNCNT+2
 S ENI=0 F  S ENI=$O(^ENG(6916.2,ENVR,1,ENI)) Q:+ENI'=ENI  D  Q:$D(DIRUT)
 . I IOSL-1'>ENLNCNT D HDR1 Q:$D(DIRUT)
 . W !,$G(^ENG(6916.2,ENVR,1,ENI,0)) S ENLNCNT=ENLNCNT+1
 G:$D(DIRUT) EX
 I IOSL-6'>ENLNCNT D HDR1 G:$D(DIRUT) EX
 W !!! S ENLNCNT=ENLNCNT+3
 W !,"Signature:______________________________   Date:________________"
 W !,?12,$P($$ESBLOCK^XUSESIG1(ENDA),U)
 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR K DIR
EX S:$D(ZTQUEUED) ZTREQ="@" D ^%ZISC
 K ^TMP($J,"ENITRRH"),ENDA,ENVR
 Q
HDR1 ;Logic to print report heading
 I $E(IOST,1,2)="C-",ENPG K DIR S DIR(0)="E" D ^DIR K DIR Q:$D(DIRUT) 
 W:$E(IOST,1,2)="C-"!ENPG @IOF S ENPG=ENPG+1
 W $S($G(ENPRT)="SIGNED":"IT HAND RECEIPT/LOAN FORM FOR GOVERNMENT FURNISHED EQUIPMENT (GFE)   Page ",1:"INFORMATION TECHNOLOGY HAND RECEIPT FOR GOVERNMENT FURNISHED EQUIPMENT  Page "),ENPG
 W:$G(ENPRT)="SIGNED" !,"Electronic Accepted Substitute for VA Form 0887(a/b)"
 W !,"STATION: ",ENSTN,?14,"ASSIGNED TO: ",$E(ENNAME,1,30),?58,"Printed ",ENNOW,! S ENLNCNT=$S($G(ENPRT)="SIGNED":4,1:3)
 I ENEQPT W !,"ENTRY #",?11,"MFG EQUIP NAME",?35,"MODEL",?65,"SERIAL#",!,"---------",?11,"--------------------",?35,"--------------------------",?65,"----------" S ENLNCNT=ENLNCNT+2
 Q
 ;
ITST2 ;IT personnel entry point for printing signed hand receipts
 N ENDA
 N DIC,DTOUT,DUOUT S DIC=200,DIC(0)="AEMQ",DIC("S")="I $D(^ENG(6916.3,""AOA"",Y))"
 D ^DIC I Y<1!$D(DTOUT)!$D(DUOUT) Q
 S ENDA=+Y
 I '$$SIGNED(ENDA) W !,"There are no active, Signed/Certified IT assignments for "_$$GET1^DIQ(200,ENDA_",",.01)_"." K DIR S DIR(0)="E" D ^DIR K DIR Q
 S %ZIS="Q" D ^%ZIS I POP K POP Q
 I $D(IO("Q")) S ZTRTN="IN2^ENTIRRH",ZTDESC="IT Equipment Hand Receipt Print",ZTSAVE("ENDA")="" D ^%ZTLOAD,HOME^%ZIS K ZTSK,IO("Q") Q
 G IN2
USER ;User entry point for printing signed hand receipts
 I '$D(^ENG(6916.3,"AOA",DUZ)) W !,"You have no active IT assignments." K DIR S DIR(0)="E" D ^DIR K DIR Q
 N ENDA S ENDA=DUZ
 I '$$SIGNED(ENDA) W !,"You do not have any active, Signed/Certified IT assignments." K DIR S DIR(0)="E" D ^DIR K DIR Q
 S %ZIS="Q" D ^%ZIS I POP K POP Q
 I $D(IO("Q")) S ZTRTN="IN2^ENTIRRH",ZTDESC="IT Equipment Hand Receipt Print",ZTSAVE("ENDA")="" D ^%ZTLOAD,HOME^%ZIS K ZTSK,IO("Q") Q
 G IN2
IN2 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,ENVR,ENPRT S ENPRT="SIGNED"
 S ENVR=0 F  S ENVR=$O(^ENG(6916.2,ENVR)) Q:+ENVR'=ENVR  D PRT Q:$D(DIRUT)
 G EX2
PRT U IO
 N END,ENDAC,ENERR,ENI,ENLNCNT,ENMFGN,ENMODEL,ENNOW,ENEQPT,ENPG,ENRDA,ENX,ENNBR,ENSERNBR,ENSIG,ENSIGNDT,ENNAME,ENSTN,ENVAL,X,Y S ENPG=0,ENEQPT=1
 S ENNAME=$$GET1^DIQ(200,ENDA_",",.01),ENNOW=$$FMTE^XLFDT($$NOW^XLFDT(),"2M")
 S ENSTN=+$O(^DIC(6910,0)),ENSTN=$$GET1^DIQ(6910,ENSTN_",",1)
 K ^TMP($J,"ENITRRH"),ENERR
 D FIND^DIC(6916.3,"","@;.01;1;20","PQX",ENDA,"","AOA2","I $P(^(0),U,6)=ENVR,"";SIGNED;CERTIFIED;""[("";""_$$GET1^DIQ(6916.3,Y_"","",20)_"";"")","","^TMP($J,""ENITRRH"")","ENERR")
 I $P($G(^TMP($J,"ENITRRH","DILIST",0)),U)'>0 K ^TMP($J,"ENITRRH") Q 
 D HDR1 Q:$D(DIRUT)
 I '$$CMP^XUSESIG1($P($G(^ENG(6916.2,ENVR,0)),U,3),$NAME(^ENG(6916.2,ENVR,1))) W !!!,"Hand receipt v",$P($G(^ENG(6916.2,ENVR,0)),U)," text is corrupted.",!?5," - Please contact EPS AEMS/MERS support"  Q
 S ENI=0
 F  S ENI=$O(^TMP($J,"ENITRRH","DILIST",ENI)) Q:+ENI'=ENI  D  Q:$D(DIRUT)
 . N END,ENERR,ENERR1,ENERR2,ENERR3,ENERR4,X1,X2
 . S ENX=$G(^TMP($J,"ENITRRH","DILIST",ENI,0))
 . S ENDAC=$P(ENX,U,2)_"," D GETS^DIQ(6914,ENDAC,"3;4;5","E","END","ENERR")
 . S ENNBR=$P(ENX,U,2),ENMFGN=$G(END(6914,ENDAC,3,"E")),ENMODEL=$G(END(6914,ENDAC,4,"E")),ENSERNBR=$G(END(6914,ENDAC,5,"E"))
 . I IOSL-1'>ENLNCNT D HDR1 Q:$D(DIRUT)
 . W !,ENNBR,?11,$E(ENMFGN,1,20),?35,ENMODEL,?65,ENSERNBR S ENLNCNT=ENLNCNT+1
 . S ENRDA=$P(ENX,U) K ENERR,ENSIG,ENSIGNDT
 . S X=$G(^ENG(6916.3,ENRDA,1))
 . I X'="" D
 . . S X1=ENRDA,X2=1 D DE^XUSHSHP S ENSIG=$P(X,U),ENSIGNDT=$$FMTE^XLFDT($P(X,U,4))
 . . S:$P(X,U,8)'=$P($G(^ENG(6916.2,ENVR,0)),U,3) ENERR1=1
 . . S:$P(X,U,5)'=$P(ENX,U,2) ENERR2=1
 . . S:$P(X,U,6)'=$P($G(^ENG(6916.3,ENRDA,0)),U,2) ENERR3=1
 . . S:$P(X,U,4)'=$P($G(^ENG(6916.3,ENRDA,0)),U,5) ENERR4=1
 . I $D(ENSIGNDT) D:IOSL-1'>ENLNCNT HDR1 Q:$D(DIRUT)  W !?4,"Signed: ",ENSIGNDT,?35,"Signature: /ES/",$G(ENSIG) S ENLNCNT=ENLNCNT+1
 . I '$D(ENSIGNDT) D:IOSL-1'>ENLNCNT HDR1 Q:$D(DIRUT)  W !,?4,"Signed: "_$$GET1^DIQ(6916.3,ENRDA_",",4),?35,"Certified by: ",$$GET1^DIQ(6916.3,ENRDA_",",6)  S ENLNCNT=ENLNCNT+1
 . S ENVAL=$$LOAN($P(ENDAC,","))
 . W !,?2,"Issued By: ",$$ISSUEDBY(ENRDA),?49,"Contact #: ",$P(ENVAL,U,2) S ENLNCNT=ENLNCNT+1
 . W !,?2,"Equipment Return Date: ",$$DATEDUE($P(ENDAC,","),$P(ENVAL,U)) S ENLNCNT=ENLNCNT+1
 . I $G(ENERR1) D:IOSL-1'>ENLNCNT HDR1 Q:$D(DIRUT)  W !?19,"** Hand Receipt Text Altered **" S ENLNCNT=ENLNCNT+1
 . I $G(ENERR2) D:IOSL-1'>ENLNCNT HDR1 Q:$D(DIRUT)  W !?19,"** Assigned Equipment Altered **" S ENLNCNT=ENLNCNT+1
 . I $G(ENERR3) D:IOSL-1'>ENLNCNT HDR1 Q:$D(DIRUT)  W !?19,"** Assigned Person Altered **" S ENLNCNT=ENLNCNT+1
 . I $G(ENERR4) D:IOSL-1'>ENLNCNT HDR1 Q:$D(DIRUT)  W !?19,"** Date Signed Altered **" S ENLNCNT=ENLNCNT+1
 Q:$D(DIRUT)  S ENEQPT=0
 I IOSL-3'>ENLNCNT D HDR1 Q:$D(DIRUT)
 I ENLNCNT>3 W !! S ENLNCNT=ENLNCNT+2
 S ENI=0 F  S ENI=$O(^ENG(6916.2,ENVR,1,ENI)) Q:+ENI'=ENI  D  Q:$D(DIRUT)
 . I IOSL-1'>ENLNCNT D HDR1 Q:$D(DIRUT)
 . W !,$G(^ENG(6916.2,ENVR,1,ENI,0)) S ENLNCNT=ENLNCNT+1
 Q:$D(DIRUT)
 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR K DIR
 Q
EX2 S:$D(ZTQUEUED) ZTREQ="@" D ^%ZISC
 K ^TMP($J,"ENITRRH"),ENDA
 Q
SIGNED(ENDA) ;Returns how many signed/certified, active assignments exist for this person
 N ENERR,ENCNT
 K ^TMP($J,"ENITRRH")
 D FIND^DIC(6916.3,"","@","PQX",ENDA,"","AOA2","I "";SIGNED;CERTIFIED;""[("";""_$$GET1^DIQ(6916.3,Y_"","",20)_"";"")","","^TMP($J,""ENITRRH"")","ENERR")
 S ENCNT=+$P($G(^TMP($J,"ENITRRH","DILIST",0)),U)
 K ^TMP($J,"ENITRRH")
 Q ENCNT
 ;
ISSUEDBY(ENRDA) ;Name of person assigning responsibility
 N ENARR,ENDA,ENNAME S ENDA=$$GET1^DIQ(6916.3,ENRDA_",",3,"I")
 S ENARR("FILE")=200,ENARR("IENS")=ENDA_",",ENARR("FIELD")=".01"
 S ENNAME=$$NAMEFMT^XLFNAME(.ENARR,"G","L35")
 Q ENNAME
 ;
DATEDUE(ENDA,ENADD) ;Returns Date Due for Return
 N ENINVDT,ENDT
 S ENINVDT=$$GET1^DIQ(6914,ENDA_",",23,"I") S:$G(ENADD)'>0 ENADD=90
 S ENDT=$S(ENINVDT="":DT,1:$$FMADD^XLFDT(ENINVDT,ENADD)),ENDT=$$FMTE^XLFDT(ENDT,"2M")
 Q ENDT
 ;
LOAN(ENEQ) ;Loan Data for Equipment
 ;input ENDA (equipment ien file 6914)
 ;return value = number of days^loan form phone
 N ENCMR,ENRET,ENY1
 S ENRET="90^" ;default number of days is 90
 S ENCMR=$P($G(^ENG(6914,ENEQ,2)),U,9)
 S ENY1=$S(ENCMR:$G(^ENG(6914.1,ENCMR,1)),1:"")
 I $P(ENY1,U) S $P(ENRET,U)=$P(ENY1,U) ;days for CMR (if specified)
 I $P(ENY1,U,2)]"" S $P(ENRET,U,2)=$P(ENY1,U,2) ;loan form phone for CMR
 Q ENRET
 ;
 ;ENTIRRH
