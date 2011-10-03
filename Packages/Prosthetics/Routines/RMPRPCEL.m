RMPRPCEL ;HCIOFO/RVD - LINK SUSPENSE UTILITY; 08/14/01
 ;;3.0;PROSTHETICS;**62,69**;Feb 09, 1996
 ;
 ;RVD patch #69 4/17/02 - prevent error if record in 668 is not complete
 ;                        for 2319 linking.
 ;This routine contains the code for linking file #660 and #668.
 ;Link the selected suspense to a corresponding 2319 record(s).
 ;And call routine for updating #660 and #668
 ;
 ;Variables need for this subroutine:
 ; ^TMP($J,"RMPRPCE",660
 ; ^TMP($J,"RMPRPCE",668
LINK60 ;link suspense to 2319 records
SEL60 ;
 K RMSUS60
 S RMSULINK=DA
 D NEWVAR
 W !!,"List of 2319 Records:"
 S (RM60CNT,RMSERR)=0
 F RMSI=0:0 S RMSI=$O(^TMP($J,"RMPRPCE",660,RMSI)) Q:RMSI'>0  D
 .I $D(^RMPR(660,RMSI,0)) S RM60CNT=RM60CNT+1,RMSUS60(RM60CNT)=RMSI
 ;
RES60 K DIR
 S (RMQUIT,RMSCNT,RMNT)=0
 F RMSI=0:0 S RMSI=$O(RMSUS60(RMSI)) Q:(RMSI'>0)!(RMQUIT=1)  D
 .S DIR(0)="E"
 .S RMSCNT=RMSCNT+1,RMNT=RMNT+1,(RM60IT,RM60VEN0,RMPRPRC)=""
 .S RM60DATA=$G(^RMPR(660,RMSUS60(RMSI),0))
 .S RM60DATE=$P(RM60DATA,U,1),RM60ITEM=$P(RM60DATA,U,6)
 .S RM60TYPT=$P(RM60DATA,U,4),RM60VEN=$P(RM60DATA,U,9)
 .S RM60D=$E(RM60DATE,4,5)_"/"_$E(RM60DATE,6,7)_"/"_$E(RM60DATE,2,3)
 .I RM60ITEM,$D(^RMPR(661,RM60ITEM,0)) S RM60IT=$P(^RMPR(661,RM60ITEM,0),U,1)
 .I RM60VEN,$D(^PRC(440,RM60VEN,0)) S RM60VEN0=$E($P(^PRC(440,RM60VEN,0),U,1),1,15)
 .I RM60VEN,'$D(^PRC(440,RM60VEN,0)) S RM60VEN0=""
 .I RM60ITEM,'$D(^RMPR(661,RM60ITEM,0)) S RM60IT=""
 .I RM60IT,$D(^PRC(441,RM60IT,0)) S RMPRPRC=$E($P(^PRC(441,RM60IT,0),U,2),1,15)
 .W !,?5,RMSI_".",?9,RM60D,?21,RMPRPRC,?39,RM60VEN0
 .I RMNT>14 D ^DIR S RMNT=0 I Y'=1 S RMQUIT=1
 Q:RMQUIT
 S DIR(0)="LO^1:"_RMSCNT
 S DIR("A")="Enter 2319 Record to be LINKED "
 D ^DIR
 I $D(DUOUT)!$D(DTOUT)!$D(DIRUT)!(Y="") W !!,"***NO Link to Suspense!!",!! Q
 S RM60L=Y
 S RC=0 F  S RC=RC+1 S RMD=$P(RM60L,",",RC) Q:RMD=""  D
 .Q:'$D(RMSUS60(RMD))
 .S RMSEL(RMD)=""
 .S $P(^TMP($J,"RMPRPCE",660,RMSUS60(RMD)),U,3)=1
 .S $P(^TMP($J,"RMPRPCE",660,RMSUS60(RMD)),U,4)=RMSULINK
 .K RMSUS60(RMD)
 .;S RNT=0 F RMSI=0:0 S RMSI=$O(RMSUS60(RMSI)) Q:RMSI'>0  S RNT=RNT+1 I (RMSI>1),(RNT'=RMSI) S RMSUS60(RNT)=RMSUS60(RMSI) K RMSUS60(RMSI)
 ;
UPFILE ;call update 660 & 668
 ;process link to suspense, update field in file #660.
 S RMSCHECK=0
 F I=0:0 S I=$O(^TMP($J,"RMPRPCE",660,I)) Q:I'>0  D
 .S RM60DAT=$G(^TMP($J,"RMPRPCE",660,I))
 .S RMSAMIS=$P(RM60DAT,U,1)
 .S RMSTATUS=$P(RM60DAT,U,3)
 .S RM668=$P(RM60DAT,U,4)
 .Q:'$G(RM668)
 .Q:'$G(RMSAMIS)
 .S RMSCHECK=$$UP60^RMPRPCE1(I,RM668,RMSTATUS)
 .S RMSERR=$$UP68^RMPRPCE1(I,RM668,RMSAMIS)
 .K ^TMP($J,"RMPRPCE",660,I)
 K ^TMP($J,"RMPRPCE",668)
 S:$G(RMSULINK) DA=RMSULINK
 Q
 ;
SMESS8   ;print/display message for mandatory suspense entry.
 W !!,"*********************************************************"
 W !,"** No suspense record has been selected for this trans-**"
 W !,"** action.  You must select an entry from the list to  **"
 W !,"** complete this transaction, otherwise transaction    **"
 W !,"** will not be linked to SUSPENSE....................  **"
 W !,"*********************************************************"
 W !!
 Q
 ;
SMESS0   ;print/display message for 2319 entry.
 W !!,"*********************************************************"
 W !,"** Patient record(s) still exist...................... **"
 W !,"** You must select an entry from the list to complete  **"
 W !,"** all transactions, otherwise some transactions will  **"
 W !,"** not be linked to SUSPENSE!!!                        **"
 W !,"*********************************************************"
 W !!
 Q
 ;
CDIR K DIR
 S DIR(0)="SBO^L:LINK Suspense to Patient Record;E:EXIT without linking to Suspense"
 S DIR("A")="Would you like to LINK Suspense or EXIT without linking"
 S DIR("B")="L"
 S DIR("?")="Answer `L` to Link to suspense, 'E' to exit without linking to suspense"
 D ^DIR S RMENTSUS=Y
 I $D(DIRUT)!$D(DUOUT)!$D(DTOUT) S RMENTSUS="E"
 W !! K DIR
 Q
 ;
AUTO ;auto-link a suspense record.
 ;added by #62
 ;input rm60link(),rm68link, rgrp1 and rmprdfn
 F R6I=0:0 S R6I=$O(RM60LINK(R6I)) Q:R6I'>0  D
 .;do auto-link if only one suspense
 .Q:'$D(RM68LINK)
 .I $D(RM68LINK) S RM668I=$O(RM68LINK(0))
 .S ^TMP($J,"RMPRPCE",660,R6I)=$G(RGRP1)_"^"_RMPRDFN_"^"_1_"^"_RM668I
 .S ^TMP($J,"RMPRPCE",668,RM668I)=""
 .D UPFILE^RMPRPCEL
 G KILL
 ;
MAN ;link record.
 ;input rm60link(), rgrp1 and rmprdfn
 ;call suspense listmanager screen for multiple suspense and items.
 S RMSUCLFG=1
 F R6I=0:0 S R6I=$O(RM60LINK(R6I)) Q:R6I'>0  D
 .S ^TMP($J,"RMPRPCE",660,R6I)=$G(RGRP1)_"^"_RMPRDFN
 D LINK^RMPRS
 G KILL
 ;
KILL ;kill link variables
 K RM60LINK,RM68LINK,R6I,RM668I,RMSUCLFG
 Q
 ;
COL ;collect PREVIOUS items for CO & CPO options only.
 ;input variable RMPRA
 ;return variable RM68FG = a flag if previous item is linked.
 ;if linked, variables RM60LINK & RM68LINK are sets.
 S RM68FG=0
 F RI=0:0 S RI=$O(^RMPR(664,RMPRA,1,RI)) Q:RI'>0  S RM664DAT=$G(^RMPR(664,RMPRA,1,RI,0)) I $P(RM664DAT,U,13) D
 .S RM660I=$P(RM664DAT,U,13)
 .S:$D(^RMPR(660,RM660I,"AMS")) RGRP1=$P(^RMPR(660,RM660I,"AMS"),U,1)
 .I $P($G(^RMPR(660,RM660I,10)),U,14) S RM668D10=$O(^RMPR(668,"F",RM660I,0)) D
 ..I $G(RM668D10),'$D(RM68LINK(RM668D10)) S RM68FG=RM68FG+1,RM68LINK(RM668D10)=""
 .I '$D(^RMPR(660,RM660I,10)) S RM60LINK(RM660I)=""
 .I $D(^RMPR(660,RM660I,10)),$P(^RMPR(660,RM660I,10),U,1)="" S RM60LINK(RM660I)=""
 Q
 ;
ICDT(R68) ;update the initial and completion date in #660
 ;input variable R68 = FILE 668 ien
 N RMDAT,RM660,RI,RMINDT,RMCODT,RMERROR,DA
 Q:'$D(^RMPR(668,R68,10))
 F RI=0:0 S RI=$O(^RMPR(668,R68,10,RI)) Q:RI'>0  I $P(^RMPR(668,R68,10,RI,0),U,1) D
 .S RM660=$P(^RMPR(668,R68,10,RI,0),U,1)
 .I $G(RM660),$D(^RMPR(660,RM660,10)) D
 ..S RMINDT=$P(^RMPR(668,R68,0),U,9)
 ..S RMCODT=$P(^RMPR(668,R68,0),U,5)
 ..S RMDAT(660,RM660_",",8.3)=RMINDT
 ..S RMDAT(660,RM660_",",8.4)=RMCODT
 ..D FILE^DIE("","RMDAT","RMERROR")
 ..I $D(RMERROR) W !!,"*** Error in 2319 Record = ",RM660," !!!",!! Q
 Q
 ;
NEWVAR N DIE,DIC,I,J,Y,RMDFN,RMI,RMDATE,RM680,RM6810,RMERROR,RM60L,RC
 N RMERR,RMCHK,RMAMIS,DLAYGO,X,DR,RM668,RM60DAT,RMSTATUS
 N RM68CNT,RM60CNT,RMSI,RMSAMIS,RM68IEN,RM60IEN,RMSUS60,RMSUS68,RMD
 N RM68DATA,RM60TYP,RM68D,RM68TRAN,RMPRPRC,RM60IT,RMENTSUS,RMQUIT
 Q
