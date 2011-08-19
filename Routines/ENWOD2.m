ENWOD2 ;(WASH ISC)/DLM/DH-Formatted Work Order Display ;12.10.97
 ;;7.0;ENGINEERING;**15,35,42,43,47**;Aug 17, 1993
 ;  write the information
TOP N I,I1,J,K,X,ENPG
 N IOINLOW,IOINHI,IOINORM D ZIS^ENUTL
 S X="ENZWO1" X ^%ZOSF("TEST") I $T D ^ENZWO1
 S ENX("WP")=$S($L(EN(31))>120:3,$L(EN(31))>70:2,EN(31)]"":1,1:0),ENPG=0
 S ENX("AT")=0,I=100 F  S I=$O(EN(I)) Q:'I  S ENX("AT")=ENX("AT")+1
 S ENORIG=$P(^ENG(6920,DA,0),U,6) S ENORIG("P")=0 I ENORIG]"",ENORIG'=ENWO S ENORIG("P")=1
 S $X=1,$Y=0 W ?$S(ENORIG("P"):10,1:21) D W("WORK ORDER # "_ENWO)
 W:ENORIG("P") "   (Original #: "_ENORIG_")"
 W ! D W(" 1) ") W "PRIMARY EMPL: " I EN(1)]"",$D(^ENG("EMP",EN(1),0)) D W($P(^(0),U))
 W ?39 D W(" 2) ") W "REQ DATE: " S X=EN(2) D PDT
 W ! D W(" 3) ") W "REQ MODE: " D W(EN(3)) W ?39 D W(" 4) ") W "LOCATION: " D:EN(4)]"" W(EN(4))
 W ! D W(" 5) ") W "BED #: " D:EN(5)]"" W(EN(5))
 W ?39 D W(" 6) ") W $S(ENDSTAT=35.2:"PM STATUS: ",1:"STATUS: ") D W($E(EN(6),1,18))
 W ! D W(" 7) ") W "TASK DESC: " D W(EN(7))
TOP4 D TOP4^ENWOD3
TOP15 W ! D W("25) ") W "WORK CTR: " D:EN(25)]"" W(EN(25))
 W ! D W("26) ") W "TOTAL HOURS: " D:EN(26)]"" W(EN(26))
 W ?39 D W("27) ") W "TOTAL MATERIAL COST: " D:EN(27)]"" W(EN(27))
 W ! D W("28) ") W "TOTAL LABOR COST: " D:EN(28)]"" W(EN(28))
 W ?39 D W("29) ") W "VENDOR SERVICE COST: " D:EN(29)]"" W(EN(29))
 W ! D W("30) ") W "*ASSIGNED TECH*" W ?39 D W("31) ") W "DATE COMPLETE: " S X=EN(31) D PDT
 I 'ENX("AT") G WP
 F I=101:1:(ENJ-1) D WRTEC I I=105,$D(EN(106)) D  G:ENX="^" KILL
 . S ENX="" I $E(IOST,1,2)="C-" D HOLD W ! D W("30) ") W "*ASSIGNED TECH*"
 ;
WP I 'ENPG,((ENX("AT")+ENX("WP"))>5),($E(IOST,1,2)="C-") D HOLD Q:ENX="^"
 W ! D W("32) ") W "WORK PERFORMED: "
 I EN(32)]"" D
 . I $L(EN(32))<60 D W(EN(32)) Q
 . K ^UTILITY($J,"W") S X=EN(32),DIWL=1,DIWR=59,DIWF="" D ^DIWP
 . S J=0 F  S J=$O(^UTILITY($J,"W",1,J)) Q:'J  W:J>1 !,?20 D W(^(J,0))
 I $D(^ENG(6920,DA,6)),'ENPG,$E(IOST,1,2)="C-" D HOLD G:ENX="^" KILL
 W ! D W("33) ") W "COMMENTS: "
WCO S (ENX,X)="" I $D(^ENG(6920,DA,6)) S DIWL=5,DIWR=(IOM-5),DIWF="|" K ^UTILITY($J,"W") D  G:ENX="^" KILL
 . S ENNX=0 F  S ENNX=$O(^ENG(6920,DA,6,ENNX)) Q:'ENNX  S X=^(ENNX,0) D ^DIWP
 . W IOINHI S ENNX=0 F  S ENNX=$O(^UTILITY($J,"W",DIWL,ENNX)) Q:'ENNX  W !,?DIWL,^UTILITY($J,"W",DIWL,ENNX,0) I (IOSL-$Y)'>2 D  Q:ENX="^"
 .. W IOINLOW D HOLD
 .. W:ENX'="^" IOINHI
 . W IOINLOW
 I EN(14)]"",$D(^ENG(6914,EN(14),0)) K ENX S EQDA=EN(14) D NOTES(EQDA) D  ;  Look for flags
 . I $G(ENX("T"))>0 D
 .. I (IOSL-$Y)'>4 D HOLD Q:ENX="^"
 .. I ENX(1)]"" D
 ... W !,"WARRANTY EXPIRATION: ",IOINHI W:ENX(1)>DT "**" W $E(ENX(1),4,5),"/",$E(ENX(1),6,7),"/",$E(ENX(1),2,3) W:ENX(1)>DT "**" W IOINLOW
 ... I ENX(9)]"" W ?49 D W("JCAHO=YES")
 ... I ENX(4)]"" W !,"Last PMI was DEFERRED."
 .. I ENX(1)="",(ENX(4)]""!(ENX(9)]"")) D
 ... W ! W:ENX(4)]"" "Last PMI was DEFERRED." I ENX(9)]"" W ?49 D W("JCAHO=YES")
 .. I ENX(3) W ! D W("NOTE: Equipment must be isolated and rendered inoperative prior to service.")
 .. I ENX(7)]"" W !,"EQUIPMENT USE STATUS LISTED AS " D W(ENX(7)) W "."
 . I $D(ENX("WO")) D
 .. I (IOSL-$Y)'>5 D HOLD Q:ENX="^"
 .. W !!,"              [OTHER OPEN WORK ORDERS FOR THIS EQUIPMENT]"
 .. W !,"  Work Order #",?18,"Task Description"
 .. S SHOP=0 I $D(ENX("WO","HAZ")) D
 ... F  S SHOP=$O(ENX("WO","HAZ",SHOP)) Q:SHOP'>0  S J=9999999999 D
 .... F  S J=$O(ENX("WO","HAZ",SHOP,J),-1) Q:J'>0  W !,?2 D W($P(^ENG(6920,J,0),U)) W ?18 D W($E($P($G(^ENG(6920,J,1)),U,2),1,52)_" (Hazard)")
 .. S SHOP=0 I $D(ENX("WO","PM")) D
 ... F  S SHOP=$O(ENX("WO","PM",SHOP)) Q:SHOP'>0  S J=$O(ENX("WO","PM",SHOP,0)) W !,?2,$P(^ENG(6920,J,0),U),?18,$P($G(^ENG(6920,J,5)),U,7)
 .. S J=9999999999,K=0
 .. F  S J=$O(ENX("WO",J),-1),K=K+1 Q:J'>0!(K>9)  W !,?2,$P(^ENG(6920,J,0),U),?18,$S($E(^(0),1,3)'="PM-":$P($G(^(1)),U,2),1:$P($G(^(5)),U,7)) I (IOSL-$Y)'>2 D HOLD Q:ENX="^"
 .. I K>9 W !,?2,"There are more..."
 S X="ENZWO2" X ^%ZOSF("TEST") I $T D ^ENZWO2
 I $O(^DIPT("B","ENZWO.LOCAL",0))>0 D
 . S L=0,DIC="^ENG(6920,",FLDS="[ENZWO.LOCAL]",BY=".01",(FR,TO)=ENWO,DHD="@@",IOP=ION,DISUPNO=1,ENX("DA")=DA
 . I (IOSL-$Y)'>5 D HOLD Q:ENX="^"
 . D EN1^DIP
 . S DA=ENX("DA")
KILL K EN,ENLTH,ENORD,ENNU,ENNX,DIWL,DIWR,DIWF,ENA,ENB,ENTNX,ENORIG,ENJ,ENDATA,EQDA,ENX
 Q
 ;
PDT ;Display date in external format
 I X]"" S Y=X X ^DD("DD") D W(Y)
 Q
 ;
WRTEC ;Print assigned techs
 W !,"    #",I-100,": " I EN(I)]"",$D(^ENG("EMP",EN(I),0)) D W($P(^(0),U)) W "  HRS: " D W(EN(I,1)) W "  SHOP: " D W(EN(I,2))
 Q
 ;
HOLD S ENX="" S:$G(ENPG)]"" ENPG=ENPG+1 I $E(IOST,1,2)="C-" D  Q
 . W !,"Press <RETURN> to continue, '^' to escape..."
 . R ENX:DTIME
 . S $Y=0
 W @IOF,"(Work Order: "_ENWO_")"
 Q
 ;
NOTES(EQDA) ;  Check for flagging situations, counted in loc var ENX("T")
 ;  EQDA contains IEN for file 6914
 ;  Expects ENWO as IEN of work order in question
 ;  Flagging situations noted in loc array ENX
 ;
 N HAZCODE,SHOP
 S HAZCODE=$O(^ENG(6920.1,"B","HAZARD ALERT (Equipment)",0))
 S I1=1,ENX("T")=0 F I=1:1:9 S ENX(I)=""
 S ENX(1)=$P($G(^ENG(6914,EQDA,2)),U,5) ;Warranty expiration
 S ENX(2)=$$GET1^DIQ(6914,EQDA,53) ;Condition code
 S ENX(3)=$P(^ENG(6914,EQDA,0),U,5) ;Lockout/Tagout
 S I=0 F  S I=$O(^ENG(6914,EQDA,6,I)) Q:'I  I $E($P(^(I,0),U,2),1,3)="PM-" Q:$P(^(0),U,3)'["D"  S ENX(4)=$P(^(0),U,3) Q  ;Deferred PM  work order
 I $D(ENWO),$E(ENWO,1,3)'="PM-" D
 . S I=0,J=999999999999 F  Q:I>30  S J=$O(^ENG(6920,"G",EQDA,J),-1) Q:J'>0  S I=I+1 D:$P($G(^ENG(6920,J,5)),U,2)=""
 .. I '$D(^ENG(6920,J,0)) K ^ENG(6920,"G",EQDA,J) Q
 .. I ENWO=$P(^ENG(6920,J,0),U) Q
 .. S K=0,SHOP=$P($G(^ENG(6920,J,2)),U) Q:SHOP'>0  I $E(^ENG(6920,J,0),1,3)="PM-",'$D(ENX("WO","PM",SHOP)) S ENX("WO","PM",SHOP,J)="" Q  ;Open PM
 .. F  S K=$O(^ENG(6920,J,8,K)) Q:K'>0  I ^(K,0)=HAZCODE S ENX("WO","HAZ",SHOP,J)="" Q  ;Open Hazard Alert
 .. S:'$D(ENX("WO","HAZ",SHOP,J)) ENX("WO",J)=""
 S ENX(7)=$$GET1^DIQ(6914,EQDA,20) I ENX(7)]"","TURNED IN^LOST OR STOLEN"'[ENX(7) S ENX(7)=""
 S ENX(9)=$$GET1^DIQ(6914,EQDA,27) I ENX(9)'="YES" S ENX(9)="" ;jcaho
 S ENX("T")=(ENX(1)]"")+(ENX(4)]"")+(ENX(9)]"") I ENX("T")>1 S ENX("T")=ENX("T")-1
 S ENX("T")=ENX("T")+(ENX(3)]"")+(ENX(7)]"")
 Q
 ;
W(ENDATA) ;Bold ENDATA
 N X
 S X=$X W IOINHI S $X=X W ENDATA
 S X=$X W IOINLOW S $X=X
 Q
 ;ENWOD2
