DVBAEDIT ;ALB ISC/THM-EDIT AMIE BENEFICIARY INFO STATUS ;21 JUL 89@0117
 ;;2.7;AMIE;**17**;Apr 10, 1995
 I $D(DUZ)#2=0 W !!,*7,"You have no USER NUMBER.  Contact the site manager.",!! H 3 G EXIT
 ;
TERM D HOME^%ZIS S OPER=$S($D(^VA(200,+DUZ,0)):$P(^(0),U,1),1:"Unknown operator")
 S HD="7131 REQUEST STATUS EDITING"
 ;
SETUP W @IOF,!?(IOM-$L(HD)\2),HD,!! S DIE="^DVB(396,",DR="[DVBA STATUS EDIT]",DIC=DIE,DIC(0)="AEQMZ",DIC("A")="Enter PATIENT NAME: " K DVBACORR,OUT
 D DICW^DVBAUTIL
 S DVBACORR="N",SUPER=0 I $D(^XUSEC("DVBA SUPERVISOR",DUZ)) S SUPER=1,DVBACORR="Y"
 ;
EDIT D ^DIC G:X=U!(X="") EXIT W:Y<0 *7,"  ??" G:Y<0 EDIT I Y>0 S DVBAPNAM=Y(0,0),DA=+Y W !! G CHK
 ;;;OLD  D ^DIC G:X=U!(X="") EXIT W:Y<0 *7,"  ??" G:Y<0 EDIT I Y>0 S DA=+Y W !! G CHK
 ;
EDIT1 K OUT,%,%Y S %DT(0)=-DT I SUPER=1 W !!!,*7,"Supervisory edit -- all fields available.",!!
 I  W "Note:  As a Supervisor you will be allowed to use the ""^"" to escape",!,"from the program if desired.  This is not normally allowed.",! S DIE("NO^")="OUTOK" D CON G:$D(OUT) FINAL
 I SUPER=0 S DIE("NO^")=1
 W @IOF,!,?(IOM-$L(HD)\2),HD,!!!,"Patient Name: ",DVBAPNAM D ^DIE K DIE("NO^")
 ; NEW FIX - W !,?(IOM-$L(HD)\2) D ^DIE K DIE("NO^")
 ;
FINAL D CHK1 G:NOFINAL=1 SETUP W !!,*7,"All items are completed.  This record is now FINALIZED.",!
 S DIE="^DVB(396,",DR="25////"_DT_";26////"_OPER W !,"Updating record, please wait  ",! D ^DIE H 1
 D CON G:$D(OUT) EXIT
 K DA,Y G SETUP
 ;
EXIT W @IOF K DIE,DR,DIC,DIC(0),DIC("A"),DA,OPER,FDATE,%DT,X,NOFINAL,ZA,Y,%DT,HD,ANS,ZTYPE,DVBADIC,CODE,D0,DLAYGO,DQ,C,%X,%Y,%,DREF,DI,DIYS,ZX,%DT,DVBASTAT,DVBADT,CODE,ZX,FDT(0)
 K DVBAPNAM,POP,DG,DIFLD,DK,DL,DM,SUPER,OUT,DVBACORR,D,OLDDR,DTOUT
 Q
 ;
CHK ;CHECK TO SEE IF FINALIZED
 K %,%Y
 I SUPER=1,$D(^DVB(396,DA,1)),$P(^(1),U,12)]"" W *7,!,"This is finalized.  Do you want to 'unfinalize' it" S %=1 D YN^DICN I $D(%Y),%Y["?" W !!,"Enter Y if you wish to reopen this and be able to edit it,",!,"or N to leave it as is",!! G CHK
 G:$D(DTOUT) EXIT I SUPER=1,$D(%),%=1 S OLDDR=DR,DR="25///@",DIE="^DVB(396," D ^DIE S DR=OLDDR G EDIT1
 I SUPER=1,$D(%),%'=1 G SETUP
 I SUPER=0,$P(^DVB(396,DA,1),U,12)'="" S FDATE=$P(^(1),U,12) W !!,*7,"This record has already been finalized on ",$$FMTE^XLFDT(FDATE,"5DZ"),! H 3 G SETUP
 G EDIT1
 ;
CHK1 ;CHECK STATUS OF EACH FIELD
 S NOFINAL=0
 F ZA=9,11,13,15,17,19,21,23,26,28 I $P(^DVB(396,DA,0),U,ZA)="P" S NOFINAL=1 Q
 Q:NOFINAL=1  I $P(^DVB(396,DA,1),U,7)="P" S NOFINAL=1 Q
 Q
CON ;continue
 W !!,"Press RETURN to continue or ""^"" to exit  " R ANS:DTIME S:'$T!(ANS=U) OUT=1
 Q
