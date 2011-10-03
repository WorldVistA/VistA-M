ENEQPMP3 ;(WASH ISC)/DH-Display PMI Schedules ;6.5.97
 ;;7.0;ENGINEERING;**35,42**;Aug 17, 1993
DDT ;  Display Equipment Category PM Data
 ;  Expects IEN of Equipment Category File as loc var ENDTYP
 I '$D(^ENG(6911,ENDTYP,4,0)) W !!,"There is no defined PM schedule for this Equipment Category.",! D HLD Q
 N X,IOINLOW,IOINHI,IOINORM D ZIS^ENUTL ;Get BOLD and UNBOLD for CRT
 S ENY=2,ENRT="6911",ENDVTYP=$P(^ENG(6911,ENDTYP,0),U) W @IOF,"Equipment Category: " D W(ENDVTYP) W !
 S X=^ENG(6911,ENDTYP,0),X(0)=0
 I $P(X,U,2) W ?5,"Lockout Required?: " D W("YES") S X(0)=1
 I $P(X,U,3)="Y" W ?40,"JCAHO Item: " D W("YES") S X(0)=1
 I X(0) W ! S ENY=ENY+2
 S I=0 F  S I=$O(^ENG(6911,ENDTYP,4,I)) Q:I'>0  S ENSH=$P(^ENG(6911,ENDTYP,4,I,0),"^",1),ENEMP=$P(^(0),"^",2),ENSKP=$P(^(0),"^",3),ENCRIT=$P(^(0),U,4) S ENMN="" S:$D(^ENG(6911,ENDTYP,4,I,1)) ENMN=^(1) D MNTH^ENLIB1,DPM
 G EXIT ;End DDT
 ;
DINV ;  Display Equipment Record PM Data
 ;  Expects IEN of Equipment File as loc var DA
 I '$D(^ENG(6914,DA,4)) W !!,"There is no defined PM schedule for this piece of equipment.",! D HLD Q
 N X,IOINLOW,IOINHI,IOINORM D ZIS^ENUTL
 S (ENPMN,ENLID,ENSN,ENDTYP,ENDVTYP)="" S:$D(^ENG(6914,DA,3)) ENPMN=$P(^(3),U,6),ENLID=$P(^(3),U,7) S:$D(^ENG(6914,DA,1)) ENSN=$P(^(1),U,3),ENDTYP=$P(^(1),U,1) I ENDTYP]"" S ENDVTYP=$P($G(^ENG(6911,ENDTYP,0)),U)
 S ENY=3,ENRT=6914 W @IOF,"Equipment ID #: " D W(DA) W ?40 D W(ENDVTYP) W !,"PM #: " D W(ENPMN)
 W ?25,"Local ID: " D W(ENLID) W ?60,"S/N: " D W(ENSN) W !
 S X=0,X(0)=^ENG(6914,DA,0),X(3)=$G(^ENG(6914,DA,3))
 I $P(X(0),U,5) W ?5,"Lockout Required? " D W("YES") S X=1
 I $P(X(3),U,9)="Y" W ?40,"JCAHO Item: " D W("YES") S X=1
 I X W ! S ENY=ENY+2
 S I=0 F  S I=$O(^ENG(6914,DA,4,I)) Q:I'>0  I $D(^ENG(6914,DA,4,I,0)) S ENSH=$P(^(0),U),ENEMP=$P(^(0),U,2),ENSKP=$P(^(0),U,3),ENCRIT=$P(^(0),U,4) S ENMN="" S:$D(^ENG(6914,DA,4,I,1)) ENMN=^(1) D MNTH^ENLIB1,DPM
 G EXIT ;End DINV
 ;
DPM ;  Print data from File 6911 or 6914
 N ENDA S ENDA=$S(ENRT=6911:ENDTYP,1:DA)
 S:ENSH]"" ENSHOP=$P(^DIC(6922,ENSH,0),U) I ENEMP]"",$D(^ENG("EMP",ENEMP)) S ENEMP=$P(^(ENEMP,0),U)
 I ENY>(IOSL-10) R !,"Press <RETURN> to continue...",ENX:DTIME G:ENX="^" EXIT W @IOF,$S(ENRT=6911:"Equip Category (cont'd): ",ENRT=6914:"Entry Number (cont'd): ",1:"") D W($S(ENRT=6911:ENDVTYP,ENRT=6914:ENDA,1:"")) W !! S ENY=2
 W !,?30 D W(ENSHOP_" SHOP") W !,"Tech: " D W(ENEMP) W ?50,"Starting Month: " D W(ENMNTH) W !,"Skip Months: " D W(ENSKP)
 W ?50,"Criticality: " D W(ENCRIT) W !,"Frequency (multiple):" S ENY=ENY+4
 S J=0 F  S J=$O(@("^ENG("_ENRT_","_ENDA_",4,"_I_",2,"_J_")")) Q:J'>0  S ENSBSCR=$P(@("^ENG("_ENRT_","_ENDA_",4,"_I_",2,"_J_",0)"),U) I ENSBSCR]"" S EN(ENSBSCR)=^(0)
 F J="TA","BA","A","S","Q","BM","M","BW","W","N" I $D(EN(J)) D DPM1
 K EN W !! S ENY=ENY+2 Q
 ;
DPM1 I J="N" W !,?3 D W("NONE") S ENY=ENY+1 Q
 I $P(EN(J),U,2)]"",$P(EN(J),U,2)'["." S $P(EN(J),U,2)=$P(EN(J),U,2)_".0"
 W !,?5 D W($S(J="TA":"TRI-ANNUAL",J="BA":"BI-ANNUAL",J="A":"ANNUAL",J="S":"SEMI-ANNUAL",J="Q":"QUARTERLY",J="BM":"BI-MONTHLY",J="M":"MONTHLY",J="BW":"BI-WEEKLY",J="W":"WEEKLY",1:""))
 W ?18 D W($J($P(EN(J),U,2),5,1)) W " hrs  "
 D W($J("$"_$S($P(EN(J),"^",3)]"":$P(EN(J),"^",3),1:0),6)) W " (est)  Level: " D W($S($P(EN(J),"^",4)]"":$P(EN(J),"^",4),1:"N/A")) S ENY=ENY+1
 I $P(EN(J),U,5)]"" W !,?5,"Proc Ref: " S ENA=$G(^ENG(6914.2,$P(EN(J),U,5),0)) D W($P(ENA,U)) W "  Title: " D W($P(ENA,U,2)) K ENA S ENY=ENY+1
 I "^BA^TA^"[(U_J_U) W !,?5,"Starting Year: " D W($P(EN(J),U,6)) S ENY=ENY+1
 Q
 ;
W(ENDATA) ;Bold ENDATA
 N X
 S X=$X W IOINHI S $X=X W ENDATA
 S X=$X W IOINLOW S $X=X
 Q
 ;
EXIT D:'$D(ENNOHLD) HLD
 K ENSH,ENSHOP,ENMN,ENMNTH,ENEMP,ENSKP,ENPRTCL,ENSBSCR,ENRT,ENY
 K ENLID,ENPMN,ENSN,ENCRIT
 Q
 ;
HLD I $E(IOST,1,2)="C-" R !,"Press <RETURN> to continue...",X:DTIME
 Q
 ;ENEQPMP3
