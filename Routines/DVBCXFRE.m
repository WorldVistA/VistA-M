DVBCXFRE ;ALB/GTS-557/THM-SEND BACK TRANSFERS WHEN RELEASED ; 5/30/91  9:42 AM
 ;;2.7;AMIE;**10**;Apr 10, 1995
 ;
EN W !!,*7,"This request was transferred in.",!,"Please wait while I return it.",!! H 2
 ;
EN1 W @FF,!! S SITE=$P(^DVB(396.3,REQDA,0),U,22),DTTRNSC=$P(^(0),U,12),SITE1=$S($D(^DIC(4.2,+SITE,0)):$P(^(0),U,1),1:""),SITE=$S($P(^(0),U,3)]"":$P(^(0),U,3),1:SITE)
 I SITE="" W !!,*7,"There is no home domain indicated.",!,"This request was not transferred in.",!! H 3 Q
 S NREQDA=$S($D(^DVB(396.3,REQDA,1)):$P(^(1),U,8),1:"") I +NREQDA=0 W !!,*7,"The original request indicator is missing!",!,"I have no way to match it back at "_SITE1,!! H 3 Q
 W !!,"Setting up return mail message ...",!! H 1
 S L=3,^TMP("DVBCXFR",$J,1,0)="$TRANSFER OUT FROM V"_$$VERSION^XPDUTL("DVBA"),^TMP("DVBCXFR",$J,2,0)="$RQDA "_NREQDA_U_DTTRNSC_U_$P(^DVB(396.3,REQDA,0),U,18)_U_$P(^(0),"^",19) W ".."
 I $D(ALLROPN) S ^TMP("DVBCXFR",$J,L,0)="$ROPN 1^",L=L+1 W "."
 F JJ=0:0 S JJ=$O(^DVB(396.4,"C",REQDA,JJ)) Q:JJ=""  S DIE="^DVB(396.4,",DA=JJ,DR="64///N" D ^DIE K DA,DIE,DR D RSLT,RSLT1
 S ^TMP("DVBCXFR",$J,L,0)="$USER "_$S($D(^VA(200,+DUZ,0)):$P(^(0),U,1),1:"POSTMASTER")_U_SITE_U_SITE1,L=L+1 W "."
 S ^TMP("DVBCXFR",$J,L,0)="$END ",L=L+1 W "."
 S ^TMP("DVBCXFR",$J,L,0)=" ",L=L+1 W "."
 S ^TMP("DVBCXFR",$J,L,0)="Veteran name: "_$P(^DPT(DFN,0),U,1),L=L+1 W "."
 S ^TMP("DVBCXFR",$J,L,0)="         SSN: "_SSN,L=L+1 W "."
 S ^TMP("DVBCXFR",$J,L,0)=" " W "." H 1 W !!,"Message is now ready to send back ...",!! H 2
 ;
SEND ;set status now for manual return if auto send fails; skip reopens
 I '$D(ALLROPN) S DIC(0)="QM",(DIC,DIE)="^DVB(396.3,",DA=REQDA,DR="17////CT" D ^DIE
 K XMZ S XMY(DUZ)="",XMSUB="Return of Transferred C&P Exams",XMTEXT="^TMP(""DVBCXFR"",$J,",XMY("S.DVBA C PROCESS MAIL MESSAGE@"_SITE1)=SITE D ^XMD
 I $D(XMZ) W !!,"Transmitted as message # "_XMZ_" from this site to "_SITE1,! H 3
 I '$D(XMZ) W !!,*7,"Message transmission error!",!,"Request WILL NOT be transferred!",!!,"Press RETURN  " R ANS:DTIME S OUT=1 Q:'$D(MANUAL)  I $D(MANUAL) K MANUAL G KILL^DVBCUTIL
 K DIC,DIE,DR,DA,LN,^TMP("DVBCXFR",$J),XMZ,ANS,L,JY,XMY,XMSUB,XMTEXT,XMDUZ
 I $D(MANUAL) K MANUAL G KILL^DVBCUTIL
 Q
 ;
RSLT1 F LN=0:0 S LN=$O(^DVB(396.4,JJ,"RES",LN)) Q:LN=""  S ^TMP("DVBCXFR",$J,L,0)="$RSLT "_^(LN,0),L=L+1 W "."
 Q
 ;
MANUAL S MANUAL=1 D HOME^%ZIS S FF=IOF
 ;
MANUAL1 W @FF,!,"Manual Return of C&P Transfers",!!!!
 K DIC S DIC="^DVB(396.3,",DIC(0)="AEQMZ",DIC("A")="Select VETERAN NAME: " D ^DIC G:X=""!(X=U) EXIT I +Y<0 W *7,"  ???" H 3 G MANUAL1
 I '$P(^DVB(396.3,+Y,0),U,22) W *7,!!,"This request was not transferred in to this site and",!,"it is not possible to select it for return." K OUT D PAUSE G:$D(OUT) KILL^DVBCUTIL G MANUAL1
 I $P(^DVB(396.3,+Y,0),U,18)'="CT" W !!,*7,"This request is not in the proper status to manually return it.",!,"The status must be COMPLETED/TRANSFERRED OUT (CT)." K OUT D PAUSE G:$D(OUT) KILL^DVBCUTIL G MANUAL1
 ;
ASK S REQDA=+Y W !!!,"Is this the correct request" S %=2 D YN^DICN G:%<0!($D(DTOUT)) EXIT I %=2 G MANUAL1
 I %=0 W !!,"Enter Y if this is the correct request or N to re-select.",!! H 3 G ASK
 S DFN=$P(^DVB(396.3,REQDA,0),U,1),SSN=$P(^DPT(DFN,0),U,9)
 G EN1
 ;
EXIT K MANUAL,DIC,X,Y,REQDA,%,%Y,DTTRNSC,J,TSTDT,POP,STAT,RONAME,RO,JY,EXAM,C Q
 ;
RSLT S X=^DVB(396.4,JJ,0),WRKSHT=$P(X,U,5),EXSTAT=$P(X,U,4)
 S CANCNODE=$S($D(^DVB(396.4,JJ,"CAN")):^DVB(396.4,JJ,"CAN"),1:""),CANCREM=$P(CANCNODE,U,3)
 S CANCBY=$P(CANCNODE,U,2) S:CANCBY]"" CANCBY=.5
 S CANCDT=$P(CANCNODE,U,1)
 S EXMDT=$P(X,U,6),EXPHYS=$P(X,U,7),FEXM=$P(X,U,8),EXMPL=$P(X,U,9)
 S ^TMP("DVBCXFR",$J,L,0)="$EXAM "_$P(^DVB(396.4,JJ,0),U,3)_U_WRKSHT_U_EXSTAT_U_CANCREM_U_CANCBY_U_CANCDT_U_EXMDT_U_EXPHYS_U_FEXM_U_EXMPL,L=L+1
 K CANCNODE
 Q
 ;
PAUSE W !!,"Press RETURN to continue or ""^"" to exit  " R ANS:DTIME I ANS[U S OUT=1
 Q
