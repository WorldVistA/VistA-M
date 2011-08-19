PSGPL ;BIR/CML3-PICK LIST ;12 DEC 97 / 10:01 AM
 ;;5.0; INPATIENT MEDICATIONS ;**50,184**;16 DEC 97;Build 12
 ;
 ; Reference to ^PS(59.7 is supported by DBIA #2181.
 ;
BEGIN ; get ward group, last pick list # for group, see if it's a rerun.
 ;    ND2 - 2 node of WARD GROUP file or WARD GROUP^^start date^stop date from pick list ) node
 ;    PSGPLG - pick list number      PSGPLWG - ward group number
 ;    PSGPLF - start date            PSGPLWGP - 5 node from WARD GROUP
 ;
 D ENCV^PSGSETU,NOW^%DTC S PSGDT=%,RERUN=0
 N PSJSITE,PSJPRN S PSJSITE=0,PSJSITE=$O(^PS(59.7,PSJSITE)) I $P($G(^(PSJSITE,26)),U,5)=1 S PSJPRN=1
 S DIC("S")="I $P(^(0),""^"",2)=""P""",DIC(0)="QEAMI",DIC="^PS(57.5," W ! D ^DIC K DIC G:Y'>0 DONE S PSGPLWG=+Y,ND2=$G(^PS(57.5,+Y,2)),PSGPLWGP=$G(^(5)),PSGPLG=+ND2
 I 'ND2,$D(^PS(53.5,"A",PSGPLWG)) F Q=0:0 S Q=$O(^PS(53.5,"A",PSGPLWG,Q)) Q:'Q  I '$O(^(Q)),$D(^PS(53.5,Q,0)) S ND2=$P(^(0),"^",2)_"^^"_$P(^(0),"^",3,4),PSGPLG=Q Q
 I PSGDT<$P(ND2,"^",3) D RERUN G UL:%<0,BEGIN:%=2
 I ND2]"" D DTEXST S PSGOD=$$ENDTC^PSGMI(PSGPLS) W !,"Start date/time for this pick list: ",PSGOD S MES="STOP" D GETSF G:Y<0 DONE S PSGPLF=Y G BOTH
 F MES="START","STOP" D GETSF G:Y<0 DONE
 ;
BOTH ;
 W ! F  L +^PS(53.5,0):1 I  S ND=$G(^PS(53.5,0)) S:ND="" ND="PICK LIST^53.5" Q
 F PSGPLG=$P(ND,"^",3)+1:1 I '$D(^PS(53.5,PSGPLG)) I $$LOCK^PSGPLUTL(PSGPLG,"PSGPL")  S $P(ND,"^",3)=PSGPLG,$P(ND,"^",4)=$P(ND,"^",4)+1,^PS(53.5,0)=ND Q
 L -^PS(53.5,0)
 D ENPL^PSGTI I $D(IO("Q")) G:'$D(ZTSK) UL W !!,"Pick list queued!" D SET G UL
 I POP W !!,"No device chosen for Pick List ",$E("re",1,RERUN),"run." G UL
 W !,"...this may take a while...(you really should QUEUE the pick list)..." D SET,EN^PSGPL1
 ;
UL ;
 D UNLOCK^PSGPLUTL(PSGPLG,"PSGPL")
 ;
DONE ;
 D ^%ZISC,ENKV^PSGSETU K AM,DIC,FD,FFF,MES,ND,ND2,OG,OS,POP,PSGION,PSGID,PSGOD,PSGPLF,PSGPLG,PSGPLS,PSGPLWG,PSGPLWGP,Q,RERUN,ST,XX,ZTOUT,PSGDT,EST Q
 ;
SET ;
 I RERUN S DIK="^PS(53.5,",DA=OG D ^DIK K DIK I $D(^PS(57.5,PSGPLWG,2)),+^(2)=OG S ^(2)=$P(^(2),"^",6,20)
 S ^PS(53.5,PSGPLG,0)=PSGPLG_"^"_PSGPLWG_"^"_PSGPLS_"^"_PSGPLF_"^^"_$P(PSGPLWGP,"^",1,3)_"^^^"_PSGDT_"^^"_$P(PSGPLWGP,"^",7),^PS(57.5,PSGPLWG,2)=PSGPLG_"^"_PSGDT_"^"_PSGPLS_"^"_PSGPLF_"^"_DUZ_"^"_$P(ND2,"^",1,15),^PS(53.5,"A",PSGPLWG,PSGPLG)=""
 S DIK="^PS(53.5,",DA=PSGPLG D IX^DIK K DIK Q
 ;
DTEXST ;
 S PSGPLS=$$EN^PSGCT($P(ND2,"^",4),1),X=$$ENDTC^PSGMI($P(ND2,"^",4)),Y=$$ENDTC^PSGMI($P(ND2,"^",3)),XX=$$ENDTC^PSGMI($P(ND2,"^",2))
 W !!,"The PICK LIST for this WARD GROUP was last run",$S(XX:" on "_XX,1:""),!,"   for ",Y," through ",X,!
 I $D(^PS(53.5,PSGPLG,0)),$P(^(0),"^",11),'$P(^(0),"^",9) W $C(7),$C(7),!,"*** THIS PICK LIST HAS NOT RUN TO COMPLETION. ***",!
 Q
 ;
GETSF ;
 K %DT S %DT="AERTX",%DT("A")="Enter "_MES_" date/time for this pick list: "
 I MES["O",$D(^PS(57.5,PSGPLWG,0)),$P(^(0),"^",3) S X=$$EN^PSGCT(PSGPLS,$P(^(0),"^",3)*60-1),Y=$$ENDD^PSGMI(X),%DT("B")=Y
GETSF1 D ^%DT I Y<0 W $C(7),!!,"This PICK LIST cannot be ",$E("re",1,RERUN),"run without a ",MES," date." Q
 S @($S(MES["O":"PSGPLF",1:"PSGPLS"))=Y
 I MES["O",(Y'>PSGPLS) W $C(7),!!,"*** Stop date must be greater than start date !! ***",! G GETSF1
 ;PSJ*5*184;Add warning message and prompt if stop date greater than 7 days in the future.
 N X,PSGPLSF S X1=PSGPLS,X2="7" D C^%DTC S PSGPLSF=X
 I MES["O",(Y>PSGPLSF) D  I %'=1 G GETSF1
 . W $C(7),!!,"*** WARNING: You're Attempting to run the Pick List for greater than 7 days ***",!
 . W !,"Are you Sure (Y/N):" S %=2 D YN^DICN
 . Q
 Q
 ;
RERUN ;
 I '$$LOCK^PSGPLUTL(PSGPLG,"PSGPL")  W $C(7),!!,"** THE NEXT PICK LIST FOR THIS WARD GROUP IS CURRENTLY RUNNING. **" S %=2 Q
 D DTEXST F  W !,"Do you want to rerun this pick list" S %=0 D YN^DICN Q:%  D:%Y]"" DTQ W:%Y="" $C(7),"  (Answer required.)"
 I %=1 S OG=PSGPLG,OS=$P(^PS(53.5,OG,0),"^",3),RERUN=2 S:+ND2=OG ND2=$P(ND2,"^",6,20) D UNLOCK^PSGPLUTL(PSGPLG,"PSGPL") Q
 D UNLOCK^PSGPLUTL(PSGPLG,"PSGPL") Q
 ;
DTQ ;
 W !!?2,"Enter a 'Y' to rerun this pick list.  Enter an 'N' (or '^') to NOT rerun this pick list.  NOTE: Rerunning a pick list deletes all of its old data.",! Q
