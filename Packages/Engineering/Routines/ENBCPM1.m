ENBCPM1 ;(WASH ISC)/DH-Record Bar Coded PMI ;1/9/2001
 ;;7.0;ENGINEERING;**10,14,21,32,35,68**;Aug 17, 1993
DNLD ;Get PM Inspector
 S ENEMP="",DIC="^ENG(""EMP"",",DIC(0)="AEQMZ",DIC("A")="Select PM Inspector: ",DIC("S")="I $P(^(0),U,7)'=""V""" D ^DIC S:Y>0 ENEMP=$P(Y(0),U,1) K DIC
 I ENEMP]"",$O(^ENG("EMP","B",ENEMP,+Y))]"" S ENEMP=+Y
 I ENEMP]"" S ENEMP=""""_ENEMP_"""" D ^ENCTBAR
 Q
RES ;Restart an aborted process
 S X="",ENY=0 W !!,"Enter PROCESS ID: " R X:DTIME G:X="^"!(X="") EXIT S ENCTID=$O(^PRCT(446.4,"C",X,"")) I ENCTID="" W !!,*7,"Wrong application. Aborting..." D HOLD G EXIT
 S X="" W !!,"Enter TIME STAMP of process to be restarted: " R X:DTIME G:X="^"!(X="") EXIT S ENCTTI=$O(^PRCT(446.4,ENCTID,2,"B",X,"")) I ENCTTI="" W !!,"NO DATA. Aborting..." D HOLD G EXIT
EN ;Main entry point. Expects ENCTID and ENCTTI.
 ;Normally called by ENCTBAR.
 G:'$D(ENCTID) ERR^ENBCPM5
 S ENCTTI(0)=$P(^PRCT(446.4,ENCTID,2,ENCTTI,0),U)
 S ENSTA=$P($G(^DIC(6910,1,0)),U,2),ENSTAL=$L(ENSTA)
 I ENSTA="" W !!,"Can't seem to find your STATION NUMBER.  Please check File 6910.",!,"Your IRM staff may need to assist you.",*7 G ERR^ENBCPM5
 F I=1,2,3,4,5,6,7,8 S ENSTA(I)="",ENSTAL(I)=0
 I $G(^DIC(6910,1,3,0))]"" D
 . S (I,ENX)=0 F  S ENX=$O(^DIC(6910,1,3,ENX)) Q:'ENX!(I>8)  D
 .. S I=I+1,ENSTA(I)=$P(^DIC(6910,1,3,ENX,0),U)
 .. S ENSTAL(I)=$L(ENSTA(I))
 I '$D(DT) S U="^",%DT="",X="T" D ^%DT S DT=+Y S:'$D(DTIME) DTIME=600
 S Y=DT X ^DD("DD") S ENDATE=Y
 W !! S Y=$E(DT,1,5)_"00" X ^DD("DD") S %DT("A")="For which month do you wish to record PMI's: ",%DT("B")=Y,%DT="AEPMX" D ^%DT G:Y'>0 ERR^ENBCPM5 S ENPMDT=$E(Y,2,5),ENPM="M"
MORW W !,"Are you recording a MONTHLY (as opposed to a WEEKLY) worklist" S %=1 D YN^DICN G:%<0 ERR^ENBCPM5 G:%=0 MORW I %=1 G EN1
WEEK R !,"Week number (enter an integer from 1 to 5): ",X:DTIME G:X="^" ERR^ENBCPM5 I X?1N,X>0,X<6 S ENPM="W"_X G EN1
 W "??",*7 G WEEK
EN1 S DIC="^DIC(6922,",DIC(0)="AEMQ" D ^DIC G:Y'>0 ERR^ENBCPM5 S ENSHKEY=+Y,ENSHOP=$P(^DIC(6922,ENSHKEY,0),U,1),ENSHABR=$P(^(0),U,2)
 S ENPMWO="PM-"_ENSHABR_ENPMDT_ENPM
EN2 S ENDEL="" I $D(^DIC(6910,1,0)) S ENDEL=$P(^(0),U,5)
 I ENDEL="" R !,"Should existing PM work orders be deleted after close out? YES// ",X:DTIME G:X="^" ERR^ENBCPM5 S:X=""!("Yy"[$E(X)) ENDEL="Y"
 I ENDEL="","Nn"'[$E(X) D COBH1^ENEQPMR4 G EN2
CONT ;Physical processing of uploaded data
 N PMTOT
 S (ENY,ENPG)=0,ENX=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,0)) I ENX'>0 D HDR^ENBCPM2 W *7,!!,"No data to process." D:$E(IOST,1,2)="C-" HOLD G EXIT
 S ENX=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) ;ignore file ID
 S ENTEC="",ENEMP=^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0),ENX=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) I ENEMP?.N S ENTEC=ENEMP S ENEMP=$P($G(^ENG("EMP",ENTEC,0)),U)
 S DIR(0)="P^6929:AEQM^I Y>0,$P(^ENG(""EMP"",+Y,0),U,7)=""V"" K X D EN^DDIOL(""VACATED positions may not be selected."")"
 S DIR("A",1)="This bar code PMI program was downloaded for "_ENEMP_"."
 S DIR("A")="Who actually did the work? ",DIR("B")=ENEMP
 S DIR("?",1)="If "_ENEMP_" performed the PMI, just press <RETURN>."
 S DIR("?",2)="If you choose another technician, that individual will become the technician"
 S DIR("?",3)="of record in both the Work Order and Equipment Files."
 S DIR("?",4)=" "
 S DIR("?",5)="If more than one technician worked on a PMI then you should either close that"
 S DIR("?",6)="PM work order individually (before continuing with this update) or perhaps"
 S DIR("?",7)="use teams in your PMI program. If you want to abort this update and come back"
 S DIR("?",8)="to it after closing selected work orders manually (via the 'Close Out PM Work"
 S DIR("?",9)="Order' option), press the caret key ('^') and be sure to write down the"
 S DIR("?")="'Process ID' and 'Time stamp' that the system will give you."
 D ^DIR K DIR G:Y'>0!($D(DIRUT)) ERR^ENBCPM5
 S ENTEC=+Y,ENEMP=$P(Y,U,2)
 ;
DEV D MSG^ENBCPM6
 S %ZIS="Q",%ZIS("A")="Select Device for PMI Exception Messages: " D ^%ZIS K %ZIS G:POP ERR^ENBCPM5
 G:$D(IO("Q")) ZTSK^ENBCPM2
 ;
NEWLOC ;Beginning of a specific location
 S ENLBL=^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0),ENLOC=$E(ENLBL,3,50) I $E(ENLBL,1,2)'="SP" S ENMSG="LOCATION EXPECTED." D XCPTN^ENBCPM2 S ENX=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) G:ENX'>0 EXIT G NEWLOC
 I ENLOC["  " S ENLOC=$P(ENLOC,"  ")
 S X=$L(ENLOC) I $E(ENLOC,X)=" " S ENLOC=$E(ENLOC,1,(X-1))
NEWNX ;Process a piece of equipment
 S (ENTIME,ENMATRL)=""
 S ENX=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) G:ENX'>0 DONE S (ENEQ,ENLBL)=^(ENX,0) G:$E(ENLBL)="*" NEWNX
 I $E(ENEQ,1,2)="SP" K ENEQ G NEWLOC
 S ^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0)="*"_ENEQ
 I $E(ENEQ,1,4)="MOD:" D NOLBL^ENBCPM3 G NEWNX
 I $E(ENEQ,1,4)="PM#:" D PMN^ENBCPM3 G NEWNX
 I $E(ENEQ,3,8)[" EE",$P(ENEQ," ")'=ENSTA D  I $D(ENMSG) D XCPTN^ENBCPM2 G NEWNX
 . K ENMSG S ENMSG="FOREIGN EQUIPMENT."
 . F I=1:1:8 I ENSTAL(I),$E(ENEQ,1,ENSTAL(I))=ENSTA(I) K ENMSG Q
 . I $D(ENMSG) S ENMSG(0,1)="Cannot process a bar code label from another VAMC."
 S ENEQ=$S($D(^ENG(6914,"OEE",ENLBL)):$O(^(ENLBL,0)),1:+$P(ENLBL,"EE",2))
 I ENEQ>0 D UPDATE^ENBCPM2,POST^ENBCPM4
 G NEWNX
 ;
HOLD I $E(IOST,1,2)="C-" W !,"Press RETURN to continue..." R X:DTIME
 Q
DONE ;Delete DATE/TIME OF DATA UPLOAD
 ;K DA,DIK S DIK="^PRCT(446.4,"_ENCTID_",2,",DA(1)=ENCTID,DA=ENCTTI
 ;D ^DIK
 ;K DIK
EXIT D:$D(PMTOT) ^ENBCPM8 G EXIT^ENBCPM5
 ;ENBCPM1
