FBCHEP ;AISC/DMK-ENTER PAYMENT FOR CONTRACT HOSPITAL ;8/18/2004
 ;;3.5;FEE BASIS;**4,61,77,82**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S FBAAPTC="V",FBAAOUT=0
RD K FBAAID,FBAAVID S FBRESUB="" D GETVET^FBAAUTL1 G:DFN']"" Q
 S FBPROG="I $P(^(0),U,3)=6,($P(^(0),U,9)'[""FB583"")" D GETAUTH^FBAAUTL1 G RD:$D(DUOUT),RD:FTP']""
 ;W !!,?25,"<  ASSOCIATED 7078  >",!!
 ;S DIC="^FB7078(",DA=FB7078,DR="0;1" D EN^DIQ
 I FB7078="" W !,*7,"No 7078 on file for this authorization." G RD
 S FBI7078=FB7078_";FB7078("
 I $D(^FBAAI("E",FBI7078)) S FBAAIN=$O(^FBAAI("E",FBI7078,0)) G OUT
SETINV S FBZ(0)=^FB7078(FB7078,0),FBVET=$P(FBZ(0),"^",3),FBVEN=$P(FBZ(0),"^",2),FBVEN=$P(FBVEN,";",1)
 ;
EN583 ;Entry from 583 enter payment
 I FBAAPTC="R" D ^FBAACO0
 S DA=FBVEN D EN1^FBAAVD
 I $P($G(^FBAAV(FBVEN,"ADEL")),U)="Y" W !!,*7,"Vendor is flagged for Austin deletion!" G Q
 D SITEP^FBAAUTL G Q:FBPOP
 ;
RDV S FBVE="" S:$D(^FBAAV(DA,"AMS")) FBVE=$P(^("AMS"),"^",2) S:$G(FBVE)'="Y" FBVE="N"
 I FBVE="Y" W *7,!!,"Vendor is listed as 'exempt from the pricer'." S DIR(0)="Y",DIR("A")="Do you wish to keep this invoice exempt from the pricer",DIR("B")="Yes" D ^DIR K DIR G Q:$D(DIRUT) S FBVE=$S(Y=1:"Y",1:"N")
 I $G(FBVE)'="Y",($P($G(^FBAAV(FBVEN,0)),"^",17)']"") W !!,*7,"Medicare ID Number is needed for this Vendor!" S DIE="^FBAAV(",DR=22 D ^DIE K DIE G Q:$D(DTOUT)!('$L(X))
 ;
BAT S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,3)=""B9""&($P(^(0),U,5)=DUZ)&($P(^(0),U,15)=""Y"")&($G(^(""ST""))=""O"")" W ! D ^DIC K DIC
 G Q:X="^"!(X=""),BAT:Y<0 S FBAABE=+Y,FBY(0)=Y(0),Z1=$P(FBY(0),"^",11),BO=$P(FBY(0),"^",2),Z2=$P(FBY(0),"^",10),FBSTN=$P(FBY(0),"^",8),FBCHOB=FBSTN_"-"_$P(FBY(0),"^",2),FBEXMPT=$P(FBY(0),"^",18) S FBAAOUT=0 D CHK I FBAAOUT K Y,Y(0),FBAABE G BAT
 I FBI7078["FB7078(",BO'=$P($P(FBZ(0),U),".") W !,*7,"Obligation number on batch does not match 1358.",!,"Obligation number on batch must be ",$P($P(FBZ(0),U),"."),".",! G BAT
 S FBINC=$S($P(FBY(0),"^",10)="":0,1:$P(FBY(0),"^",10)),FBLN=$S($P(FBY(0),"^",11)="":0,1:$P(FBY(0),"^",11))
GETNXI D GETNXI^FBAAUTL
 W !!,"Invoice # ",FBAAIN," assigned to this Invoice"
RIN D GETINDT^FBAACO1 G Q:$G(FBAAOUT)
 ; ask patient control number
 S FBCSID=$$ASKPCN^FBUTL5() I FBCSID="^" G Q
 ; if U/C then get FPPS Claim ID else ask user
 I $D(FB583) S FBFPPSC=$P($G(^FB583(FB583,5)),U) W !,"FPPS CLAIM ID: ",$S(FBFPPSC="":"N/A",1:FBFPPSC)
 E  S FBFPPSC=$$FPPSC^FBUTL5() I FBFPPSC=-1 G Q
 ; if EDI claim then ask FPPS line item
 I FBFPPSC]"" S FBFPPSL=$$FPPSL^FBUTL5(,1) I FBFPPSL=-1 G Q
 ; compute default Covered Days
 S FBCDAYS=$$FMDIFF^XLFDT(FBAAEDT,FBAABDT)
 I FBCDAYS=0 S FBCDAYS=1
 S FBAAMM=$S(FBAAPTC="R":"",1:1) D PPT^FBAACO1()
DIC S DIC="^FBAAI(",DIC(0)="LQ",DLAYGO=162.5,X=FBAAIN D ^DIC G Q:Y<0
 S DA=+Y,DIE=DIC,DR="[FBCH ENTER PAYMENT]",DIE("NO^")=""
 D
 . N ICDVDT S ICDVDT=$G(FBAABDT) D ^DIE
 ; file adjustment reasons
 D FILEADJ^FBCHFA(DA_",",.FBADJ)
 ; file remittance remarks
 D FILERR^FBCHFR(DA_",",.FBRRMK)
 K DIE,DIC,D,DA,DR
 S $P(FBY(0),"^",10)=FBINC+1,$P(FBY(0),"^",11)=FBLN+1,$P(FBY(0),"^",18)=FBEXMPT,^FBAA(161.7,FBAABE,0)=FBY(0) D:'$D(FBNOPTF) PTF G Q:$D(FB583),RD
OUT W !!,*7,?3,"Invoice number ",FBAAIN," has already been entered for this authorization.",!,?3,"Use the Contract Hospital 'Invoice Edit' option if needed.",!
 ;check if user wants to add a second invoice for this 7078
 W ! S DIR("A")="Want to add another invoice for this episode of care",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR I Y S (FBNOPTF,FBRESUB)=1 G SETINV
Q K BO,CNT,D,DA,DAT,DIC,DIE,DLAYGO,DR,FB7078,FBAABDT,FBAABE,FBAAEDT,FBAAID,FBAAIN,FBAAOUT,FBAAPTC,FBDX,FBTT,FBTYPE,FBVEN,FBVET,FBXX,FTP,I,J,FBK,PI,FBPOP,PTYPE,S,FBZ,Z1,FBI,FBPROG,FBRR,FBSW,FBPOV,FBPT,FBY,T,Y,Z1,Z2,ZZ,FBPSA,A,FBI7078
 K FBCHOB,FBAUT,FBSEQ,X,FBSITE,F,FBSTN,FBASSOC,FBLOC,DUOUT,PSA,FBCOUNTY,DFN,FBNOPTF,DIRUT,FBVE,FBAAOUT,FBEXMPT,FBAAPN,FBAMTC,FBDEL,FBINC,FBLN,FBRESUB
 K FBD1,FBFDC,FBMST,FBTTYPE,FB583
 K FBCSID,FBFPPSC,FBFPPSL,FBCDAYS,FBAMTP,FBADJ,FBRRMK
 Q
PTF I $G(FBVET),$G(FBI7078)["FB583" S:'$G(DFN) DFN=FBVET D PTFC^FBUTL6(DFN,$P(FBZ(0),"^",4))
 Q
PRBT ;Entry point for patient reimbursement option
 ;
 S FBAAPTC="R"
 G RD
CHK ;Check for vendor and batch being exempt from pricer
 I $G(FBVE)'="Y"&($G(FBVE)'="N") S FBVE="N"
 I $G(FBEXMPT)="Y" Q:FBVE="Y"  G OPEN:FBVE="N"
 I $G(FBEXMPT)="N" Q:FBVE="N"  G OPEN:FBVE="Y"
 I '$G(FBEXMPT)&($G(Z2)'>0) S FBEXMPT=FBVE Q
 I '$G(FBEXMPT)&($G(Z2)>0) S $P(^FBAA(161.7,FBAABE,0),"^",18)="N",FBEXMPT="N" G CHK
 Q
OPEN W *7,!!,"This Invoice may not be added to Batch # ",+FBY(0),".",!,"***You may not add a ",$S(FBVE="Y":"pricer exempt",1:"non-exempt")," invoice to a ",$S(FBVE="Y":"non-exempt",1:"pricer exempt")," batch.***"
 S DIR(0)="Y",DIR("A")="Do you want to open a new batch at this time",DIR("B")="Y" D ^DIR K DIR S:$D(DIRUT)!('Y) FBAAOUT=1 Q:FBAAOUT  D RCHOP^FBAAOB S FBEXMPT=FBVE D
 .S FBY(0)=$G(^FBAA(161.7,FBAABE,0)),Z1=$P(FBY(0),"^",11),BO=$P(FBY(0),"^",2),Z2=$P(FBY(0),"^",10),FBSTN=$P(FBY(0),"^",8),FBCHOB=FBSTN_"-"_$P(FBY(0),"^",2)
 Q
