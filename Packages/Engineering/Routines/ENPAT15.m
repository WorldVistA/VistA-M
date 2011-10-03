ENPAT15 ;WISC/SAB-FIX PM MANHOURS ;1/13/95
 ;;7.0;ENGINEERING;**15**;Aug 17, 1993
 I DUZ(0)'["@" W "Please set DUZ(0)=""@"" and re-run this routine",! Q
PMHRS W !,"Moving inappropriately posted PM manhours"
 S ENI=0
 F  S ENI=$O(^DIC(6922,ENI)) Q:'ENI  D
 . ; engineering section loop
 . S ENPMM=29000000
 . F  S ENPMM=$O(^DIC(6922,ENI,1,"B",ENPMM)) Q:'ENPMM  D
 . . ; invalid PM month loop
 . . S ENII=$O(^DIC(6922,ENI,1,"B",ENPMM,0))
 . . Q:'ENII
 . . W "."
 . . K PMTOT
 . . S ENIII=0
 . . F  S ENIII=$O(^DIC(6922,ENI,1,ENII,1,ENIII)) Q:'ENIII  D
 . . . ; technician loop
 . . . S ENY0=$G(^DIC(6922,ENI,1,ENII,1,ENIII,0))
 . . . S ENTECH=$P(ENY0,U),ENHRS=$P(ENY0,U,2)
 . . . I ENTECH]"",ENHRS]"" S PMTOT(ENTECH)=ENHRS
 . . ; post accumulated hours
 . . S ENSHKEY=ENI
 . . S ENPMDT=$E(ENPMM,2,5)
 . . I $D(PMTOT) D COUNT^ENBCPM8
 . . ; kill invalid PM month
 . . S DA(1)=ENI,DA=ENII,DIK="^DIC(6922,"_DA(1)_",1,"
 . . D ^DIK
 . ;clean up internal count of technicians
 . ;source of problem was COUNT+8^ENBCPM8 (repaired with this patch)
 . S ENPMM=0
 . L +^DIC(6922,ENI)
 . F  S ENPMM=$O(^DIC(6922,ENI,1,"B",ENPMM)) Q:'ENPMM  D
 . . S ENII=$O(^DIC(6922,ENI,1,"B",ENPMM,0)) Q:'ENII  D
 . . . S (ENIII,ENLAST,ENCOUNT)=0
 . . . F  S ENIII=$O(^DIC(6922,ENI,1,ENII,1,ENIII)) Q:'ENIII  S ENLAST=ENIII,ENCOUNT=ENCOUNT+1
 . . . S:ENLAST $P(^DIC(6922,ENI,1,ENII,1,0),"^",3)=ENLAST,$P(^(0),"^",4)=ENCOUNT
 . L -^DIC(6922,ENI)
 K DA,DIK,ENHRS,ENI,ENII,ENIII,ENPMDT,ENPMM,ENSHKEY,ENTECH,ENY0,PMTOT
 K ENLAST,ENCOUNT
 ;
UBC W !!,"Modifying Data in File #7336.9 (OFM BUDGET CATEGORY)"
 S DIC=1,DIC(0)="X",X="7336.9" D ^DIC
 I Y<0 W "ERROR - File 7336.9 Not Found",! G UBCEND
 ; additional MM Budget Categories
 S (DIC,DIE)="^OFM(7336.9,",DR="1///^S X=ENX1"
 S DIC(0)="X",X="EDUCATION" D ^DIC,ERR:Y'>0
 I Y>0 S ENX1="MA,MI,MM",DA=+Y D ^DIE
 S DIC(0)="X",X="NHCU" D ^DIC,ERR:Y'>0
 I Y>0 S ENX1="MA,MI,MM,NR",DA=+Y D ^DIE
 S DIC(0)="X",X="RESEARCH" D ^DIC,ERR:Y'>0
 I Y>0 S ENX1="MA,MI,MM",DA=+Y D ^DIE
UBCEND K DA,DIC,DIE,DR,ENDA,ENX1,X,Y
UPC W !!,"Modifying Data in File #7336.8 (OFM PROJ CATEGORY)"
 S DIC=1,DIC(0)="X",X="7336.8" D ^DIC
 I Y<0 W "ERROR - File 7336.8 Not Found",! G UPCEND
 ; Update mapping to MM budget categories
 S (DIC,DIE)="^OFM(7336.8,",DR="10///^S X=ENX10"
 S DIC(0)="X",X="EDUCATION" D ^DIC,ERR:Y'>0
 I Y>0 S ENX10="EDUCATION",DA=+Y D ^DIE
 S DIC(0)="X",X="NHCU" D ^DIC,ERR:Y'>0
 I Y>0 S ENX10="NHCU",DA=+Y D ^DIE
 S DIC(0)="X",X="RESEARCH" D ^DIC,ERR:Y'>0
 I Y>0 S ENX10="RESEARCH",DA=+Y D ^DIE
UPCEND K DA,DIC,DIE,DR,ENDA,ENX10,X,Y
INDX W !!,"Re-Indexing ENG SPACE (#6928) file"
 K DIK S DIK="^ENG(""SP""," D IXALL^DIK
 K DIK
 Q
ERR W !,"ERROR - ",X," not found in file",! Q
