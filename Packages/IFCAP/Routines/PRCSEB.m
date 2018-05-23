PRCSEB ;SF-ISC/LJP/SAW/DXH/DAP - CPA EDITS CON'T ;7.26.99
V ;;5.1;IFCAP;**81,174,184,196,204**;Oct 20, 2000;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*184  Check for error message indicating no 2237 seq nos.
 ;             remaining to be used out of the max 9999 available
 ;             for FCP FY-FQ.
 ;
 ;PRC*5.1*196  Check to move Date Required to Committed Date (MOP= 2,3 or 4)
 ;             to insure a later date is used for FMS document. Also,
 ;             added date check called from templates PRCSENR&NR1,
 ;             PRCSEN2237B & PRCSENPR to insure dates are in same 
 ;             FY/FQ defined.
 ;
ENRB ;ENTER CP CLERK REQUEST FROM OPTION PRCSENRB
 K PRCBBMY
 D ENF^PRCSUT(1) G W2:'$D(PRC("SITE")) G EXIT:'$D(PRC("QTR"))!(Y<0)
 S MSG="" D EN1^PRCSUT3 Q:'X  I MSG'="" W !!,MSG,! S DIR(0)="EAO",DIR("A")="Press <Enter> to exit processing..." D ^DIR K DIR,MSG Q      ;PRC*5.1*184
 K MSG        ;PRC*5.1*184
 S PRCSX1=X D EN2^PRCSUT3 Q:'$D(PRCSX1)  S X=PRCSX1,T1=DA  D W L +^PRCS(410,DA):15 G ENRB:$T=0 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)) S:$P(^(0),"^",11)="Y" PRCS2=1
 ;
 ;*81 Check site parameter to see if issue books should be allowed
 D CKPRM
 W !!,PRCVY,!!
TYPE ;
 S PRCDAA=DA,DIC="^PRCS(410.5,",DIC(0)="AEQZ",DIC("A")="FORM TYPE: ",DIC("S")=PRCVX D ^DIC S TYPE=+Y,DA=PRCDAA
 I TYPE<2 W "??    EXIT NOT ALLOWED" G TYPE
 K PRCVX,PRCVY
 S $P(^PRCS(410,DA,0),"^",4)=TYPE S:$G(PRCSIP) $P(^PRCS(410,DA,0),"^",6)=PRCSIP S (DIE,DIC)="^PRCS(410,",X=TYPE
 ;NOTE THAT THE FOLLOWING LINE OVERWRITES THE USER'S SELECTION OF FORM
 ;TYPE IF THE FUND CONTROL POINT IS NOT 'AUTOMATED'
 S:'$D(PRCS2)&(X>2) $P(^PRCS(410,DA,0),"^",4)=2,X=2
 S PRCSTYP=X     ;PRC*5.1*196
 S (PRCSDR,DR)="["_$S(X=2:"PRCSEN2237B",X=3:"PRCSENPR",X=4:"PRCSENR&NR",1:"PRCSENIB")_"]"
EN1 K DTOUT,DUOUT,Y S PRCSDAA=DA D ^DIE I $D(Y)!($D(DTOUT)) S DA=PRCSDAA L -^PRCS(410,DA) G EXIT
 S DA=PRCSDAA D RL^PRCSUT1
COMDT I PRCSTYP>1,PRCSTYP<5,$P($G(^PRCS(410,DA,4)),U,2)="" D          ;PRC*5.1*196, PRC*5.1*204 protect global with $G
 . S PRCOMDT=$S($P(^PRCS(410,DA,1),U,4)'=DT:$P(^PRCS(410,DA,1),U,4),1:DT)
 . S DR="21///^S X=PRCOMDT",DIE="^PRCS(410," D ^DIE
 . S DR=$G(PRCSDR) ;reset DR to template value, PRC*5.1*204
 D ^PRCSCK I $D(PRCSERR),PRCSERR G EN1
 K PRCSERR
 I PRCSDR="[PRCSENCOD]" D W7^PRCSEB0 D:$D(PRCSOB) ENOD1^PRCSEB1 K PRCSOB
 S:$P($G(^PRCS(410,DA,7)),"^")="" $P(^PRCS(410,DA,7),"^")=DUZ
 D:PRCSDR'="[PRCSENCOD]" W1 I $D(PRCS2),+^PRCS(410,DA,0) D W6
 S DA=PRCSDAA L -^PRCS(410,DA) D W3 G EXIT:%'=1 W !! K PRCS,PRCS2
 G ENRB
W W !!,"This transaction is assigned transaction number: ",X Q
W1 W !!,"Would you like to review this request" S %=2 D YN^DICN G W1:%=0 Q:%'=1  S (N,PRCSZ)=DA,PRCSF=1 D PRF1^PRCSP1 S DA=PRCSZ K X,PRCSF,PRCSZ Q
W2 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W3 W !!,"Would you like to enter another request" S %=1 D YN^DICN G W3:%=0 Q
W5 S:'$D(^PRCS(410,DA,11)) ^(11)="" S $P(^(11),U,3)="" K ^PRCS(410,"F",PRC("SITE")_"-"_+PRC("CP")_"-"_$P($P(^PRCS(410,DA,0),U),"-",5),DA),^PRCS(410,"F1",$P($P(^PRCS(410,DA,0),U),"-",5)_"-"_PRC("SITE")_"-"_+PRC("CP"),DA),^PRCS(410,"AQ",1,DA) Q
W51 S:'$D(^PRCS(410,DA,11)) ^(11)="" S $P(^(11),U,3)=1,(^PRCS(410,"F",PRC("SITE")_"-"_+PRC("CP")_"-"_$P($P(^PRCS(410,DA,0),U),"-",5),DA),^PRCS(410,"F1",$P($P(^PRCS(410,DA,0),U),"-",5)_"-"_PRC("SITE")_"-"_+PRC("CP"),DA),^PRCS(410,"AQ",1,DA))="" Q
W6 N JUMP,SKIPRNT,OK,TEST,TEST1,CURQTR,CURQTR1
W61 ;
 N REPORT2 I $P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),1,DUZ,0)),"^",2)'=1 S REPORT2=1 D T1^PRCSAPP1
 ;*****PRC*5.1*174 start*****
 ;if Level of Access is not Control Point Official DO block
 I $P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),1,DUZ,0)),"^",2)'=1 D  Q
 . N PRCFTYPE S PRCFTYPE=+$$GET1^DIQ(410,$G(DA)_",",3,"I") ;Form Type
 . S %=1
 . ;if request is a 2237 (Form Type IEN 2,3, or 4)
 . I $G(PRCFTYPE)>1&($G(PRCFTYPE)<5) D
 . . ;don't allow approval of 2237 if Requesting Service OR any line item description is missing
 . . I '$$REQCHECK^PRCHJUTL($G(DA),,1) S %=2
 . I $G(%)'=2 S %=1 W !,"Is this request ready for approval" D YN^DICN
 . D:%=1 W51
 . D:%=0 W61
 . D:%=2 W5
 ;*****PRC*5.1*174 end******
 S PRCSN=^PRCS(410,DA,0),PRCHQ=$P(PRCSN,"^",4),PRC("FY")=$P(PRCSN,"-",2),PRC("QTR")=$P(PRCSN,"-",3)
 S (CURQTR,CURQTR1)=PRC("QTR"),(JUMP,TEST,TEST1,OK)=0
 D T1^PRCSAPP1 I OK=1 S SKIPRNT=1 D FINAL^PRCSAPP2
 Q
 ;*81 Site Parameter Check
CKPRM I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 S PRCVX="I Y>1&(Y<5)",PRCVY="The form types 1358, Issue Book, and NO FORM are no longer used within this option."
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1 S PRCVX="I Y>1",PRCVY="The form types 1358 and NO FORM are no longer used within this option"
 Q
 ;
CHKREQ ;Check Date to insure it is within the FY/FQ range during option entry for 'NEW 2237'    ;PRC*5.1*196
 N PRCDT,PRCDT1
 I $D(PRCBBMY) S PRCCKERR=0 Q
 S PRCDTT=1700+$E(DT,1,3)
 I '$D(PRC("BBFY"))!(+$P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),"^",12)>0)!($P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),"^",3)["X") S PRC("BBFY")=PRC("FY")+2000
 S PRCCKERR=0,PRCDT=(PRC("BBFY")-$S(PRC("QTR")=1:1701,1:1700))_$P("10:01:04:07",":",PRC("QTR"))_"01",PRCDT1=(PRC("BBFY")-1700)_"0930"
 I PRCSTDT<PRCDT!(PRCSTDT>PRCDT1) D
 . S PRCCKERR=1
 . W !!," ** Date must be specified for time **",!," ** period covered by fiscal year ",PRC("BBFY"),"       **",!
 Q
EXIT K %,C,D,DA,DIC,DIE,DQ,DR,PRCS,PRCS2,PRCSDAA,PRCSDR,PRCSERR,PRCSL,PRCSTT,I,N,T,T1,T2,X,X1,PRCSX3,Y,Z,PRCOMDT,PRCCKERR,PRCSTYP Q     ;PRC*5.1*196
