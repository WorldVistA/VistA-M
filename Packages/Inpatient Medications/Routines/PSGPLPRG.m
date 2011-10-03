PSGPLPRG ;BIR/CML3-PURGE PICK LISTS ;20 JUL 94 / 5:46 PM
 ;;5.0; INPATIENT MEDICATIONS ;**5**;16 DEC 97
AP ;
 D ENCV^PSGSETU I $D(XQUIT) Q
 S ND=$P($G(^PS(59.7,1,63.5)),"^",1,3) I $P(ND,"^",2) S PSGOD=$$ENDTC^PSGMI($P(ND,"^",2))
 W !!?$S('$P(ND,"^",2):24,ND:13,1:17),"** AUTO PURGE ",$S(ND=""!(ND="^^"):"NEVER STARTED.",ND:"SET TO "_+ND_" DAYS",1:"STOPPED") W:$P(ND,"^",2) ", AS OF ",PSGOD W " **",!
 ;
DA ;
 S Y=-1,%DT="EPTX" F  R !!,"Enter PURGE STOP DATE: ",X:DTIME W:'$T $C(7) S:'$T X="^" D DAM:X?1."?",^%DT:"^"'[X I Y>0!("^"[X) W:Y'>0 !,$C(7),"No date selected for purge run." Q
 K %DT I Y>0 S PSGPLPD=Y K ZTSAVE S PSGTID=$H,PSGTIR="ENQ^PSGPLPRG",ZTSAVE("PSGPLPD")="",ZTDESC="PICK LIST PURGE",ZTIO="" D ENNOIO^PSGTI W:$D(ZTSK) !,"Pick list purge queued!"
 G DONE
 ;
DAM ;
 W !!,"  If a date is entered here, all of the FILED AWAY PICK LISTS that started ",!,"before the entered date will be deleted." Q
 ;
ENQ ;
 F Q=0:0 S Q=$O(^PS(53.5,"AO",Q)) Q:'Q  D
 .F QQ=0:0 S QQ=$O(^PS(53.5,"AO",Q,QQ)) Q:'QQ!(QQ>PSGPLPD)  D
 ..F PLN=0:0 S PLN=$O(^PS(53.5,"AO",Q,QQ,PLN)) Q:'PLN  D
 ...K DA,DIK S DIK="^PS(53.5,",DA=PLN D ^DIK K ^PS(53.5,PLN)
 ...I $D(^PS(53.55,PLN)) K DA,DIK S DIK="^PS(53.55,",DA=PLN D ^DIK K ^PS(53.55,PLN)
 ;
DONE ;
 D ENKV^PSGSETU K AM,ND,PLN,PSGPLPD,ST Q
 ;
ENASK ; sets, resets, or deletes auto purge (# of days)
 D ENCV^PSGSETU I $D(XQUIT) Q
 D NOW^%DTC S PSGDT=% S ND=$P($G(^PS(59.7,1,63.5)),"^",1,3)
 F  W !!,"DAYS 'FILED AWAY' PICK LISTS SHOULD LAST",$S(+ND:"  "_+ND_"// ",1:": ") R X:DTIME Q:"^"[X!(X?1.2N&(X>0)&(X<91))  D QUES:X?1."?",KILL:X="@" Q:X="@"  W:X'?1."?" $C(7),"  ??"
 I X,X'=+ND W:'ND "  (AUTO PURGE WILL ",$P("^RE","^",ND]""+1),"START.)" S $P(^PS(59.7,1,63.5),"^",1,3)=X_"^"_PSGDT_"^"_DUZ
 G DONE
 ;
QUES ;
 W !!,"  If a number is found in this field by the daily background job, the job will   completely delete all PICK LISTS that have been FILED AWAY and have been around longer than the number of days specified in this field."
 W "  Entering a number into",!,"this field will effectively start the AUTO PURGE.  DELETING this field will",!,"effectively STOP the AUTO PURGE."
 W !?3,"ENTER THE NUMBER (1-90) OF DAYS THAT PICK LISTS THAT ARE FILED AWAY MAY STAY IN THE COMPUTER." Q
 ;
KILL ;
 I 'ND W "  NOTHING TO DELETE!" S X="" Q
 W !?5,"OK TO DELETE" S %=0 D YN^DICN I %=1 S ^PS(59.7,1,63.5)="^"_PSGDT_"^"_DUZ W "    DELETED!  (AUTO PURGE STOPPED.)" Q
 W $C(7),"  <NOTHING DELETED>" S X="" Q
