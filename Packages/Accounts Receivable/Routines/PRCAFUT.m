PRCAFUT ;WASH-ISC@ALTOONA/CLH-FMS Utilities ;10/8/96  10:50 AM
V ;;4.5;Accounts Receivable;**5,39,64,92,104,169,188,194,220,231**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
CPLK(PRCABN) ;get control point from file 430 and set DR string to edit CP data
 N DR,X,Y,QUIT,FUND,FTBL,CAT,CATTYP,CATTYPE,CP,BBFY,EBFY,DIC,BGFY,CPTBL,CC,SCC,EXIT,FYERROR
 K PRCA("EXIT")
 S PRCA("SITE")=$S($G(PRCABN):$P($P($G(^PRCA(430,PRCABN,0)),"^"),"-"),1:$$SITE^RCMSITE)
 S CP=$P($G(^PRCA(430,PRCABN,11)),U)
 S CAT=+$P($G(^PRCA(430,PRCABN,0)),U,2),CATTYP=$P($G(^PRCA(430.2,CAT,0)),U,13)
 I CAT>39,CAT<45 D  G END
    .S TYPE="09" D CHKELEM,REV Q:$G(PRCA("EXIT"))
    .S DR="257///^S X=$G(PRCA(""SITE""))"
    .;I CAT'=42 S DR=DR_";258////1"
    .D DIE
    .Q
 D TYPE Q:$D(PRCA("EXIT"))
 I CATTYP=2 K PRCA("EXIT") D  G END
  . ;reibursement logic (if there is such a thing)
  . S DR="203" D DIE K DR I $D(Y) Q
  . I '$D(FUND) S FUND=$P($G(^PRCA(430,PRCABN,11)),U,17) D  I FUND=-1 S PRCA("EXIT")="" Q
  .. N X,Y,DIC
  .. S X=FUND,DIC="^PRCD(420.14,",DIC(0)="XMNZ",DIC("B")=FUND D ^DIC
  .. I +Y<0 D FUND^PRCAFBDU D  Q:FUND=-1
  ... S DIC="^PRCD(420.14,",DIC(0)="AEMNQZ",DIC("A")="FUND: ",DIC("B")=FUND
  ... D ^DIC
  ... S:+Y<0 FUND=-1 Q
  .. S FUND=Y
  .. S BBFY=$E($P(Y(0),U,3),3,4),EBFY=$E($P(Y(0),U,4),3,4)
  ..Q
  .S PRCABN(1)=$O(^PRCA(430,+PRCABN,2,0))
  .S PRCABN(2)=$G(^PRCA(430,+PRCABN,2,PRCABN(1),0))
  .S PRCABN(4)=+$G(PRCABN(2))
  .S X=BBFY D ^%DT S PRCABN(3)=$E(Y,1,3)
  .K ^PRCA(430,PRCABN,2,PRCABN(1),0)
  .K ^PRCA(430,PRCABN,2,"B",PRCABN(4),PRCABN(1))
  .S ^PRCA(430,PRCABN,2,PRCABN(3),0)=PRCABN(2)
  .S $P(^PRCA(430,PRCABN,2,PRCABN(3),0),"^")=BBFY
  .S ^PRCA(430,PRCABN,2,"B",BBFY,PRCABN(3))=""
  .D DOCREQ^PRC0C(+FUND,"REV","FTBL")
  . I '$D(FTBL) S PRCA("EXIT")=1 D  Q
  .. W !,*7,"FMS REQUIRED FIELDS missing.  Edit the IFCAP REQUIRED FIELDS table",!,"for FUND/FY combination."
  .. Q
  . S DR="259////^S X=CAT;257////^S X=$G(PRCA(""SITE""));201////^S X=BBFY;202////^S X=$S($G(EBFY)'=BBFY:EBFY,1:"""")"
  . D DR
  . Q
 ;Ask Beginning/end budget fiscal year
 D FY^PRCAFUT1
 I $D(FYERROR) S PRCA("EXIT")=1 Q
 ;S BGFY=$P(^PRCA(430,PRCABN,0),U,10),BGFY=$$FY^RCFN01(BGFY)
 S DR="250;I '$D(CPTBL) D CPTBL^PRCAFUT;259////^S X=CAT;204////^S X=$P(CPTBL,U);206////^S X=$P(CPTBL,U,3)"
 S DR=DR_";203////^S X=$P(CPTBL,U,5);201////^S X=$E($P(CPTBL,U,6),3,4)"
 S DR(1,430,1)="202////^S X=$S($P(CPTBL,U,7)'=$P(CPTBL,U,6):$E($P(CPTBL,U,7),3,4),1:"""")"
 S DR(1,430,2)="261////^S X=$P(CPTBL,U,10)"
 S DA=PRCABN D ^DIE K DR
 I $D(Y) S PRCA("EXIT")=1 Q
 K DR
 D FTBL Q:'$D(FTBL)
 S (X,PRCABN(1))=$E($P(CPTBL,U,6),3,4)
 D ^%DT S PRCABN(2)=$E(Y,1,3)
 S PRCABN(3)=$O(^PRCA(430,+PRCABN,2,0))
 S PRCABN(4)=$G(^PRCA(430,+PRCABN,2,PRCABN(3),0))
 S PRCABN(5)=$E(PRCABN(4),1,2)
 K ^PRCA(430,PRCABN,2,PRCABN(3),0)
 K ^PRCA(430,PRCABN,2,"B",PRCABN(5),PRCABN(3))
 S ^PRCA(430,PRCABN,2,PRCABN(2),0)=PRCABN(4)
 S $P(^PRCA(430,PRCABN,2,PRCABN(2),0),"^")=PRCABN(1)
 S ^PRCA(430,PRCABN,2,"B",PRCABN(1),PRCABN(2))=""
 S $P(^PRCA(430,PRCABN,2,0),"^",3)=PRCABN(2)
 Q
FTBL S FUND=$$FUND^PRC0C($P(CPTBL,U,5),$P(CPTBL,U,6))
 D DOCREQ^PRC0C(+FUND,"SPE","FTBL")
 I '$D(FTBL) W !!,*7,"UNABLE TO GET FMS-LINE FUND ACCOUNTING INFORMATION.  CHECK CONTROL POINT." H 5 S PRCA("EXIT")=1 Q
 S DR="257////^S X=$G(PRCA(""SITE""))"
DR I $$INTEG^RCFN01($G(PRCA("SITE"))) S DR=DR_";260"
 I $G(FTBL("AO"))="Y" S DR=DR_";204"
 I $G(FTBL("FCPRJ"))="Y" S DR=DR_";I '$D(CPTBL) D CPTBL^PRCAFUT;206////^S X=$P(CPTBL,U,3)"
 I $G(FTBL("CC"))="Y"            S DR=DR_";251;252////^S X=$G(SCC)"
 I $G(FTBL("BOC"))="Y"           S DR=DR_";253"
 I $G(FTBL("SBOC"))="Y"!(CAT=20) S DR=DR_";254"
 I $G(FTBL("JOB"))="Y"           S DR=DR_";261"
 I $G(FTBL("RC"))="Y"            S DR=DR_";263"
 I $G(FTBL("REV"))="Y"           D DIE Q:$G(PRCA("EXIT"))  D REV Q:$G(PRCA("EXIT"))
 I $G(FTBL("SREV"))="Y"          S DR=$S(DR="":"256",1:DR_";256")
 I $G(FTBL("OC"))="Y"            S DR=$S(DR="":"205",1:DR_";205")
 I DR'="" D DIE
 Q
DIE S DA=PRCABN,DIE="^PRCA(430," D ^DIE
END I $D(Y) S PRCA("EXIT")=1
 K DR Q
 ;
RECTYP(BN) ;Refund or reimbursement
 I '$D(BN),'$D(^PRCA(430,BN,0)) Q -1
 Q $P($G(^PRCA(430,BN,11)),U,10)
 ;
REV ;lookup revenue by calling "C" xref
 N DS,DIC,DIBTDH,HELP,I,IAT,OUT,RV,X,Y
 S OUT=0,RV=$P($G(^PRCA(430,PRCABN,11)),U,6)
 F  D  Q:OUT
 .W !,"REVENUE SOURCE: "_$S(RV'="":RV_"// ",1:"") R X:DTIME
 .I $E(X)="?",X?."?" D @($S($L(X)=1:"REVH1",1:"REVH2")) S DIC=347.3,DIC(0)="QE" D ^DIC Q:Y<1  Q
 .I $E(X)="^",X?."^" S OUT=1,PRCA("EXIT")=1 Q
 .I X="@" W "??  Required" Q
 .I X="",RV'="" S OUT=1 Q
 .I X="",RV="" W "??" D REVH1 Q
 .I $D(^RC(347.3,"B",X)) D  Q
 ..S DS=$P($G(^RC(347.3,+$O(^RC(347.3,"B",X,0)),0)),U,2),IAT=$P(^(0),U,3)
 ..W "       "_DS W:IAT "         INACTIVE" D REVDIE
 .S DIC="^RC(347.3,",DIC(0)="QE",D="C" D IX^DIC I Y<1 D REVH1 Q
 .S X=$P(Y,U,2) D REVDIE
 S DR=""
 Q
REVDIE S DA=PRCABN,DIE="^PRCA(430,",DR="255///"_X D ^DIE I $G(X)'="" S OUT=1 Q
 D REVH1 Q
REVH1 S HELP("DIHELP",1)=$G(^DD(430,255,3)) D MSG^DIALOG("WH","",70,5,"HELP") Q
REVH2 D HELP^DIE(430,"",255,"D","HELP"),MSG^DIALOG("WH","",70,8,"HELP") Q
 ;
FUND ;get fund
 N DIC,Y
 S DIC="^PRCD(420.14,",DIC(0)="EMNQZ"
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) S PRCA("EXIT")=1 Q
 Q:+Y<0
 S FUND=Y
 S BBFY=$E($P(Y(0),U,3),3,4),EBFY=$E($P(Y(0),U,4),3,4)
 Q
 ;
DISPLACC ;display account information
 Q:'$D(PRCABN)  NEW DIC,L,FR,TO,FLDS,IOP,X
 R !!,"Press <RETURN> to continue: ",X:60
 I X["^" S PRCA("EXIT")="" Q
 S IOP=IO(0),DIC="^PRCA(430,",FLDS="[PRCA DISP AUDIT2]",(FR,TO)=PRCABN,L=0,BY="@NUMBER" D EN1^DIP
 Q
 ;
CP ;lookup control point
 N DIC
 S DIC="^PRC(420,"_$S($D(PRCA("SITE")):PRCA("SITE"),1:$$SITE^RCMSITE)_",1,",DIC(0)="EMNQ",X=CP
 D ^DIC
 I +Y<0 K X,CP Q
 S CP=+Y
 Q
 ;
CC ;cost center
 G CC^PRCAFBDU
 ;
BOC ;budget object code
 G BOC^PRCAFBDU
 ;
TYPE ;ask if bill is a refund or reimbursement
 W !!,"Building FMS Accounting Elements...",!
 N DIR,Y,TYPE
 I +$G(CAT)=1 S CAT="02",CATTYPE=2 D CHKELEM Q
 I +$G(CAT)=10 S CAT=50,CATTYPE=2 D CHKELEM Q
 D BDTRANS^PRCAFBDU
 Q:$D(PRCA("EXIT"))
 S CATTYP=$S(TYPE="01":"1",TYPE="20":"1",1:"2")
 S CAT=TYPE ; I CAT>2 S CAT=$S(CAT=4:"20",1:"9")
 D CHKELEM
 Q
 ;
CHKELEM ;check for correct accounting line data
 N I
 Q:'$D(^PRCA(430,PRCABN,11))
 I $G(CATTYP)=1 D  Q
  . F I=6,7 S $P(^PRCA(430,PRCABN,11),U,I)=""
  . Q
 Q:$G(TYPE)=10
 F I=1:1:5,11:1:16,18:1:21 S $P(^PRCA(430,PRCABN,11),U,I)=""
 S $P(^PRCA(430,PRCABN,11),U,15)="05"
 Q
CPTBL ;build CP table
 S:'$D(BGFY) BGFY=$$FY^RCFN01(DT)
 S BGFY(1)=$S(BGFY>50:19,1:20)
 S CPTBL=$$ACC^PRC0C($G(PRCA("SITE")),+CP_U_BGFY_U_BGFY(1)_BGFY)
 I '$D(CPTBL) S CPTBL=""
 Q
 ;
CPHLP ;executable help for cp prompt
 N DIC,X,Y
 S DIC="^PRC(420,"_$S($D(PRCA("SITE")):PRCA("SITE"),1:$$SITE^RCMSITE)_",1,",DIC(0)="EMQ",X="?" D ^DIC
 Q
 ;
FND(BILL) ;Get fund for a bill
 I '$D(^PRCA(430,BILL,0)) Q -1
 I $D(^PRCA(430,BILL,11)),$P(^(11),"^",17)'="" Q $P(^(11),"^",17)
 I $P(^PRCA(430,BILL,0),"^",18)'="" Q $E($P(^(0),"^",18),4,9)
 Q -1
 ;
