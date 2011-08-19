TIUALFUN ;SLC/AJB - TIU Alert Functions; Mar 17, 2003
 ;;1.0;TEXT INTEGRATION UTILITIES;**158**;Jun 20, 1997
 ;
 Q
ALRTDEL ;
 S TIU("DELETE")=1
 S TIU("MSG")="     Delete Alerts for the following documents:"
 D RESEND
 K TIU("DELETE"),TIU("MSG")
 Q
ASKUSR ;
 N TIUTMP
 D   I TIUTMP("ASK")=-1 S TIU("QUIT")=1 Q
 . N DIR,POP,TIUCONT,X,Y
 . S DIR(0)="SA^1:Browse Document;2:Combination Alerts;3:Delete Alerts;4:Detailed Display;5:Edit a Document;6:Identify Signers;7:Resend Alerts;8:Third Party Alerts"
 . S DIR("A")="Select ACTION: "
 . S DIR("B")="RESEND ALERTS"
 . S DIR("L",1)="1.  Browse a Document   4.  Detailed Display    7.  Resend Alerts"
 . S DIR("L",2)="2.  Combination Alerts  5.  Edit a Document     8.  Third Party Alerts"
 . S DIR("L",3)="3.  Delete Alerts       6.  Identify Signers"
 . S DIR("L",4)=""
 . S DIR("L")="Enter selection by typing the name, number, or abbreviation"
 . S DIR("?",1)="The following actions are available:"
 . S DIR("?",2)="Browse a Document  - View a selected document (if authorized)"
 . S DIR("?",3)="Combination Alerts - Send alerts to expected signers and 3rd parties"
 . S DIR("?",4)="Delete Alerts      - Delete a document's alerts"
 . S DIR("?",5)="Detailed Display   - View detailed display of a document (if authorized)"
 . S DIR("?",6)="Edit a Document    - Edit a selected document (if authorized)"
 . S DIR("?",7)="Identify Signers   - Identify/Change Signers of a document (if authorized)"
 . S DIR("?",8)="Resend Alerts      - Resend alerts to expected signers"
 . S DIR("?")="Third Party Alerts - Send alerts to one or more 3rd parties"
 . F  D ^DIR D  Q:$G(TIUCONT)!$D(DIRUT)
 . . I $D(TIUC(2)),+Y=1 W !,"You can only browse one document at a time.  Select another action." Q
 . . I $D(TIUC(2)),+Y=4 W !,"You can only view the detailed display of one document at a time.",!,"Select another action." Q
 . . I $D(TIUC(2)),+Y=5 W !,"You can only edit one document at a time.  Select another action." Q
 . . I $D(TIUC(2)),+Y=6 W !,"You can only identify signers one document at a time.  Select another action." Q
 . . S TIUCONT=1
 . S TIUTMP("ASK")=$S(+Y=1:"BROWSE",+Y=2:"COMBO",+Y=3:"ALRTDEL",+Y=4:"DETDISP^TIUALSET",+Y=5:"EDIT^TIUAL1",+Y=6:"IDSIGNER",+Y=7:"RESEND",+Y=8:"THIRD",Y=U:-1,1:-1)
 D @TIUTMP("ASK")
 Q
BROWSE ;
 N TEMP,TIUCNT,TIUSEL,TIUQUIK,TIUDA,TIUPRM0,TIUPRM1,TIUPRM3,RSTOK S TIUQUIK=1
 K TIUC
 D FULL^VALM1
 I TIU("CNT")=0 W !,"No documents to select." H 3 Q
 S TIUSEL=$P(XQORNOD(0),"=",2)
 I TIUSEL="" D  Q:TIUSEL=U!($D(DIRUT))
 . N DIR,X,Y
 . S DIR("A")="Select Document: (1-"_VALMLST_") "
 . S DIR(0)="NA^1:"_VALMLST
 . D ^DIR S TIUSEL=Y
 I $A($E(TIUSEL,$L(TIUSEL)))<48!($A($E(TIUSEL,$L(TIUSEL)))>57) S TIUSEL=$E(TIUSEL,1,$L(TIUSEL)-1)
 F X=1:1  Q:$P(TIUSEL,",",X)=""  S TIUC($P(TIUSEL,",",X))=$O(@VALMAR@("IDX",$P(TIUSEL,",",X),""))
 S TIUDA=TIUC(TIUSEL)
 S RSTOK=$$DOCCHK^TIULRR(TIUDA)
 I RSTOK'>0 D  Q
 . W !!,$C(7),"Ok, no harm done...",! ; Echo denial message
 . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 I $P(^TIU(8925,+TIUDA,0),U,5)'<7,'+$$ISSIGNR^TIUALRT(TIUDA,DUZ)
 D:'$D(TIUPRM0)!'$D(TIUPRM1) SETPARM^TIULE
 S TEMP("CNT")=TIU("CNT"),TEMP("P")=TIU("P"),TEMP("S")=TIU("S")
 S TEMP("D",1)=TIU("D",1),TEMP("D",2)=TIU("D",2)
 S TEMP=""
 F  S TEMP=$O(TIU("C",TEMP)) Q:TEMP=""  S TEMP("C",TEMP)=TIU("C",TEMP)
 F TIUCNT=1:1:TIU("S") S TEMP("S",TIUCNT)=TIU("S",TIUCNT) S $P(TEMP("S",TIUCNT),U)=$S(+TEMP("S",TIUCNT)=10:14,+TEMP("S",TIUCNT)=11:15,1:+TEMP("S",TIUCNT))
 K TIU D EN^VALM("TIU BROWSE FOR READ ONLY")
 S TIU("CNT")=TEMP("CNT"),TIU("P")=TEMP("P"),TIU("S")=TEMP("S")
 S TEMP=""
 F  S TEMP=$O(TEMP("C",TEMP)) Q:TEMP=""  S TIU("C",TEMP)=TEMP("C",TEMP)
 S TIU("D",1)=TEMP("D",1),TIU("D",2)=TEMP("D",2)
 F TIUCNT=1:1:TEMP("S") S TIU("S",TIUCNT)=TEMP("S",TIUCNT) S $P(TIU("S",TIUCNT),U)=$S(+TIU("S",TIUCNT)=10:14,+TIU("S",TIUCNT)=11:15,1:+TIU("S",TIUCNT))
 Q
COMBO ;
 I TIU("CNT")=0 W !,"No documents to select." H 3 Q
 S TIUTMP("CMSG")=1,TIU("MSG")="     Send COMBINATION Alerts for the following documents:"
 S TIUTMP("THIRD PARTY ALERTS")="",TIUTMP("NODEL")=""
 D USERS
 K TIUTMP("CMSG"),TIU("MSG")
 Q
RESEND ;
 I TIU("CNT")=0 W !,"No documents to select." H 3 Q
 N DIR,TIUCNT,TIUDA,TIUDIV1,TIUOD,TIUPRM0,TIUPRM1,TIUQUIT,X,Y
 ;
 I '$D(TIU("MSG")) S TIU("MSG")="     Resend Alerts for the following documents:"
 W @IOF,!,TIU("MSG"),!!
 S TIUCNT="",TIUCNT(1)=0,TIUCNT(2)=19
 F  S TIUCNT(1)=TIUCNT(1)+1,TIUCNT=$O(TIUC(TIUCNT)) W:TIUCNT=""&($G(Y)'=0) ! Q:TIUCNT=""  W $E(@VALMAR@(TIUCNT,0),1,80) D:TIUCNT(1)#TIUCNT(2)=0
 . S TIUCNT(2)=TIUCNT(2)+21
 . N DIR S DIR(0)="E" W ! D ^DIR W !! I Y=0 S TIUCNT="",TIUCNT=$O(TIUC(TIUCNT),-1)
 S DIR(0)="Y",DIR("A")="     Send these alerts as OVERDUE",DIR("B")="NO"
 I '$D(TIU("DELETE")) D ^DIR S TIUOD=+Y Q:TIUOD=U!($D(DIRUT))  W !
 S DIR(0)="Y",DIR("A")="     Is this correct",DIR("B")="YES"
 D ^DIR I +Y'=1 S TIUQUIT=1 Q
 I $G(TIUTMP("CMSG"))=1 F  S TIUCNT=$O(TIUC(TIUCNT)) Q:TIUCNT=""  D ALERTDEL^TIUALRT(TIUC(TIUCNT))
 I '$D(TIU("DELETE")) W !!,"     Sending Alerts..."
 I $D(TIU("DELETE")) W !!,"     Deleting Alerts..."
 S TIUCNT=""
 I '$D(TIU("DELETE")) D
 . F  S TIUCNT=$O(TIUC(TIUCNT)) Q:TIUCNT=""  W "." D SEND^TIUALRT(TIUC(TIUCNT),TIUOD)
 . K TIUTMP("THIRD PARTY ALERTS")
 . I $G(TIUTMP("CMSG"))=1 S TIUCNT="" F  S TIUCNT=$O(TIUC(TIUCNT)) Q:TIUCNT=""  W "." D SEND^TIUALRT(TIUC(TIUCNT),TIUOD)
 I $D(TIU("DELETE")) F  S TIUCNT=$O(TIUC(TIUCNT)) Q:TIUCNT=""  W "." D ALERTDEL^TIUALRT(TIUC(TIUCNT))
 W !!,"     Finished.",!
 K DIR S DIR("A")="     Enter RETURN to continue or '^' to exit",DIR(0)="E" D ^DIR
 K TIUTMP("NODEL")
 Q
SELECT(TIUACT) ;
 N TIUSEL,X,Y
 K TIUC
 D FULL^VALM1
 I TIU("CNT")=0 W !,"No documents to select." H 3 Q
 S TIUSEL=$P(XQORNOD(0),"=",2)
 I TIUSEL="" D  Q:Y=U
 . N DIR
 . S DIR("A")="Select Document(s): (1-"_VALMLST_") "
 . S DIR(0)="LAC^1:"_VALMLST
 . D ^DIR I $D(DIRUT)!(Y=U) S Y=U Q
 . S TIUSEL=Y(0)
 I $A($E(TIUSEL,$L(TIUSEL)))<48!($A($E(TIUSEL,$L(TIUSEL)))>57) S TIUSEL=$E(TIUSEL,1,$L(TIUSEL)-1)
 F X=1:1  Q:$P(TIUSEL,",",X)=""  D
 . N TIUCNT
 . I $P(TIUSEL,",",X)["-" F TIUCNT=+$P(TIUSEL,",",X):1:$P($P(TIUSEL,",",X),"-",2) S TIUC(TIUCNT)=$O(@VALMAR@("IDX",TIUCNT,""))
 . E  S TIUC($P(TIUSEL,",",X))=$O(@VALMAR@("IDX",$P(TIUSEL,",",X),""))
 D @TIUACT
 Q
THIRD ;
 I TIU("CNT")=0 W !,"No documents to select." H 3 Q
 S TIU("MSG")="     Send 3rd Party Alerts for the following documents:"
 S TIUTMP("THIRD PARTY ALERTS")="",TIUTMP("NODEL")=""
 D USERS
 K TIU("MSG")
 Q
USERS ;
 N TIUQUIT,TIUREM,TIUXQA
 K TIU("3RD"),TIU("CONTINUE")
 F  D  Q:$G(TIUQUIT)=1!($G(TIU("CONTINUE"))=1)
 . N DIC,DIR,POP,TIUCNT,X,Y
 . W @IOF,!
 . W "     Enter the name(s) of individuals to receive an alert for the selected",!
 . W "     document(s).",!!
 . W "     Kernel will not send alerts to Inactive users; they cannot be",!
 . W "     selected.",!!
 . W "     Enter RETURN or '^' to finish selections.",!
 . S TIUCNT=0,DIC="^VA(200,",DIC("S")="I '$P(^(0),U,7)"
 . S DIC(0)="AEMQ",DIC("A")="     Enter 3RD PARTY RECIPIENT(S): "
 . F  D ^DIC Q:Y=-1  D  Q:$G(TIUQUIT)=1  K TIUREM
 . . N TIUDA,TIUASK S TIUDA="" F  S TIUDA=$O(TIUC(TIUDA)) Q:TIUDA=""  I '$G(TIUASK),'$$CANDO(TIUC(TIUDA),+Y) D
 . . . S TIUASK=1
 . . . W !!?5,"Because ",$E($$GET1^DIQ(200,+Y,.01),1,15)," may not be able to SIGN/COSIGN some or all of the"
 . . . W !?5,"selected documents, they may be unable to resolve the resulting alerts.",!
 . . . N DIR,X,Y S DIR(0)="Y",DIR("A")="     Remove",DIR("B")="YES"
 . . . D ^DIR I Y=U!($D(DIRUT)) S TIUQUIT=1 Q
 . . . I +Y S TIUREM=1 W !
 . . S:'$G(TIUREM) TIUCNT=TIUCNT+1,TIU("3RD",+Y)="" S:TIUCNT=1 DIC("A")="                              and  "
 . Q:$G(TIUQUIT)=1
 . I TIUCNT=0 W !!,"     No selections made.",! S DIR("A")="     Enter RETURN to continue or '^' to exit",DIR(0)="E" D ^DIR S TIUQUIT=1 Q
 . W !!,$S(TIUCNT>1:"     Send 3rd Party Alerts to the following individuals: ",1:"     Send 3rd Party Alerts to the following individual: "),!!
 . S X="" F  S X=$O(TIU("3RD",X)) Q:X=""  S TIUXQA(X)="" W ?5,$$GET1^DIQ(200,X_",",.01),!
 . S DIR(0)="Y",DIR("A")="     Is this correct",DIR("B")="YES"
 . D ^DIR I +Y'=1 W !! K TIU("3RD"),TIUXQA S:Y=U TIUQUIT=1 Q
 . S TIU("CONTINUE")=1
 Q:$G(TIUQUIT)=1
 D RESEND
 Q
 ;
CANDO(TIUDA,PERSON) ;
 N TIUACT
 S TIUACT="SIGNATURE" I $$CANDO^TIULP(TIUDA,TIUACT,PERSON) Q 1
 S TIUACT="COSIGNATURE" I $$CANDO^TIULP(TIUDA,TIUACT,PERSON) Q 1
 Q 0
IDSIGNER ;
 N D,DIC,TIUCHNG,TIUDA,TIUDCSNR,TIUDIV1,TIUFPRIV,TIUPRM0,TIUPRM1,TIUSEL,X,Y
 D FULL^VALM1
 I TIU("CNT")=0 W !,"No documents to select." H 3 Q
 S TIUSEL=$P(XQORNOD(0),"=",2)
 I TIUSEL="" D  Q:TIUSEL=U!($D(DIRUT))
 . N DIR,X,Y
 . S DIR("A")="Select Document: (1-"_VALMLST_") "
 . S DIR(0)="NA^1:"_VALMLST
 . D ^DIR S TIUSEL=Y
 I $A($E(TIUSEL,$L(TIUSEL)))<48!($A($E(TIUSEL,$L(TIUSEL)))>57) S TIUSEL=$E(TIUSEL,1,$L(TIUSEL)-1)
 F X=1:1  Q:$P(TIUSEL,",",X)=""  S TIUC($P(TIUSEL,",",X))=$O(@VALMAR@("IDX",$P(TIUSEL,",",X),""))
 S TIUDA=TIUC(TIUSEL)
 D SIGNER^TIURA1
 D UPDATE^TIUALSET
 Q
