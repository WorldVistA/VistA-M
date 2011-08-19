PSGPEN ;BIR/CML3-FIND DEFAULT FOR PRE-EXCHANGE NEEDS ;03 Feb 99 / 9:13 AM
 ;;5.0; INPATIENT MEDICATIONS ;**30,37,50,58,115,110,127,129**;16 DEC 97
 ;
 ; References to ^PSD(58.8 supported by DBIA #2283.
 ; References to ^PSI(58.1 supported by DBIA #2284.
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ; Reference to ^PSDRUG is supported by DBIA #2192.
 ; Reference to ^PS(59.7 is supported by DBIA #2181.
 ;
EN(PSGPENO) ;
 S PSGPENO=+PSGPENO
 N PSJSITE,PSJPRN S PSJSITE=0,PSJSITE=$O(^PS(59.7,PSJSITE)) I $P($G(^(PSJSITE,26)),U,5)=1 S PSJPRN=1
 D NOW^%DTC S PSGDT=%,DT=$$DT^XLFDT,PSGPEN="" S ND=$G(^PS(55,PSGP,5,PSGPENO,0))
 S PSGPENWS=0 I PSJPWD F Q=0:0 S Q=$O(^PS(55,PSGP,5,PSGPENO,1,Q)) Q:'Q  S ND=$G(^(Q,0)) I ND,'$P(ND,"^",3),($D(^PSI(58.1,"D",+ND,PSJPWD))!$D(^PSD(58.8,"D",+ND,PSJPWD))) S PSGPENWS=1 Q
 I PSGPENWS F  S Q=$O(^PS(55,PSGP,5,PSGPENO,1,Q)) Q:'Q  S ND=$G(^(Q,0)) I ND,'$P(ND,"^",3) S:'$D(^PSI(58.1,"D",+ND,PSJPWD))&'$D(^PSD(58.8,"D",+ND,PSJPWD)) PSGPENWS=0 Q:'PSGPENWS  S $P(PSGPENWS,"^",2)=1
 I PSGPENWS W !!,"The dispense drug",$E("s",$P(PSGPENWS,"^",2))," for this order ",$S($P(PSGPENWS,"^",2):"are",1:"is a")," WARD STOCK item",$E("s",$P(PSGPENWS,"^",2)),"." S PSGPEN=0
 I 'PSGPENWS,PSJPWD S WG=+$O(^PS(57.5,"AB",PSJPWD,0)),PSGPLS=$P($G(^PS(55,PSGP,5,PSGPENO,2)),"^",2) I PSGPLS D
 .S PSGPLF=$O(^PS(53.5,"AB",WG,PSGDT))
 .N RNDT,PSJRNOS S RNDT=$$LASTREN^PSJLMPRI(PSGP,$S($G(PSJORD)["P":PSJORD,1:"")),PSJRNOS=$P(RNDT,"^",4) I PSJRNOS,'$G(PSJREN) S PSGPLS=PSJRNOS
 .I $G(PSJREN),$G(PSJORD)["U" S PSJRNOS=$P(^PS(55,PSGP,5,+PSJORD,2),"^",4) S PSGPLS=$S(PSJRNOS>PSGDT:PSJRNOS,1:$$DATE2^PSJUTL2(PSGDT))
 .D:'PSGPLF GF I PSGPLF S PSGPLO=PSGPENO D NCE,^PSGPL0 S:PSGPLC'<0 PSGPEN=PSGPLC
 I $G(PSGPRIO)="DONE" S PSGPEN=0
 ;
UPDD ;
 N DIR S DIR(0)="NOA^0:9999:0",DIR("A")="Pre-Exchange DOSES: ",DIR("?")="^D DH^PSGPEN" S:PSGPEN]"" DIR("B")=PSGPEN W ! D ^DIR G:'Y DONE S PSGY=+Y W !!,"...updating dispense drug(s)..."
 F FQ=0:0 S FQ=$O(^PS(55,PSGP,5,PSGPENO,1,FQ)) Q:'FQ  S ND=$G(^(FQ,0)),$P(^(0),"^",9)="" I ND,'$P(ND,"^",3) D DD
 ;
DONE ;
 I $P(PSJSYSW0,"^",29)="",$$DEFON^PSGPER1 S $P(PSJSYSW0,"^",29)=0
 K PSGID,PSGMAR,PSGOD,PSGPLC,PSGPLF,PSGPLO,PSGPLS,PSGPLUD,WG S:$G(PSJREN) DUOUT=0 Q
 ;
NCE ;
 W !!,"The next cart exchange is ",$$ENDTC^PSGMI(PSGPLF),! Q
 ;
GF ;
 S QQ=0 F Q=0:0 S Q=$O(^PS(53.5,"AB",WG,Q)) Q:'Q  S QQ=Q
 I QQ S QQ=$O(^PS(53.5,"AB",WG,QQ,0)) I QQ,$D(^PS(53.5,QQ,0)) S QQ=$P(^(0),"^",4) I QQ>PSGDT S PSGPLF=QQ
 Q
 ;
DD ;
 N DA S DRG=$S($P(ND,"^")="":"NOT FOUND",'$D(^PSDRUG(+ND,0)):"NOT FOUND ("_$P(ND,"^")_")",$P(^(0),"^")]"":$P(^(0),"^"),1:$P(ND,"^")_";PSDRUG("),UD=$S('$P(ND,"^",2):1,1:$P(ND,"^",2))
 W !,"...",DRG,?45,"U/D: ",UD,"..."
 S PSGDA=PSGY I 'PSGPENWS,ND,PSJPWD,($D(^PSI(58.1,"D",+ND,PSJPWD))!$D(^PSD(58.8,"D",+ND,PSJPWD))) D PSGPENWS Q:'PSGDA
 K DA,DR S PSGDA=$S(UD#1:(PSGDA*((UD\1)+1)),1:PSGDA*UD)
 S DIE="^PS(55,"_PSGP_",5,"_PSGPENO_",1,",DA(2)=PSGP,DA(1)=PSGPENO,DA=FQ,DR=".09////"_PSGDA D ^DIE
 S PSGPXN=$G(PSGPXN)
 D:'PSGPXN
 .D NOW^%DTC L +^PS(53.4,0):0 S ND=$G(^PS(53.4,0)) S:ND="" ND="PRE-EXCHANGE NEEDS^53.4P" F PSGPXN=$P(ND,"^",3)+1:1 I '$D(^PS(53.4,PSGPXN)) L +^PS(53.4,PSGPXN):0 I  S ^PS(53.4,0)=$P(ND,"^",1,2)_"^"_PSGPXN_"^"_($P(ND,"^",4)+1) L -^PS(53.4,0) Q
 .S ^PS(53.4,PSGPXN,0)=DUZ_"^"_%,^PS(53.4,"B",DUZ,PSGPXN)="",^PS(53.4,"AUD",DUZ,%,PSGPXN)="" L -^PS(53.4,PSGPXN) Q
 I $D(^PS(53.4,PSGPXN,1,PSGP,1,PSGPENO,1,FQ,0)) S $P(^(0),"^",2)=$P(^(0),"^",2)+PSGDA Q
 ; naked reference below refers to line above
 S ^(0)=FQ_"^"_PSGDA I $D(^PS(53.4,PSGPXN,1,PSGP,1,PSGPENO,1,0)) S $P(^(0),"^",3,4)=FQ_"^"_($P(^(0),"^",4)+1) Q
 ; naked reference below refers to line above
 S ^(0)="^53.401101A^"_FQ_"^1" Q:$D(^PS(53.4,PSGPXN,1,PSGP,1,PSGPENO,0))  S ^(0)=PSGPENO
 I $D(^PS(53.4,PSGPXN,1,PSGP,1,0)) S $P(^(0),"^",3,4)=PSGPENO_"^"_($P(^(0),"^",4)+1) Q
 ; naked reference below is from line above
 S ^(0)="^53.4011A^"_PSGPENO_"^1" Q:$D(^PS(53.4,PSGPXN,1,PSGP,0))  S ^(0)=PSGP
 I $D(^PS(53.4,PSGPXN,1,0)) S $P(^(0),"^",3,4)=PSGP_"^"_($P(^(0),"^",4)+1) Q
 ; naked reference below is from line above
 S ^(0)="^53.401PA^"_PSGP_"^1" Q
 ;
DH ;
 W !!?2,"Enter a number from 0 to 9999, 0 decimal digits."
 W !!?2,"Enter the number DOSES needed for this order until the next cart exchange.",!,"This will be the number of times the order will be administered to the patient",!,"from the start of the order until the next cart exchange."
 W !!?2,"PLEASE NOTE that this is DOSES, and NOT UNITS.  The doses entered will be",!,"converted to units for each dispense drug of this order, as each dispense drug",!,"may have a different units per dose." Q
 ;
PSGPENWS ;
 W !,"This dispense drug is a WARD STOCK item."
 W !,"Would you like to:",!?3,"1 - Enter 0 (no) doses needed for this dispense drug.",!?3,"2 - Enter ",PSGDA," doses needed for this dispense drug.",!?3,"3 - Enter another amount as the doses needed for this dispense drug."
 K DIR S DIR(0)="SA^1:0 (no) doses;2:"_PSGDA_" doses;3:another amount",DIR("A")="Select ACTION: ",DIR("?")="^D WH^PSGPEN" W ! D ^DIR I Y=1!'Y S PSGDA=0 Q
 Q:Y=2  K DIR S DIR(0)="NA^0:9999:0",DIR("A")="Pre-Exchange DOSES for this dispense drug: ",DIR("?")="^D WDH^PSGPEN" W ! D ^DIR S PSGDA=+Y Q
 ;
WH ;
 S Q="This dispense drug ("_DRG_") is a ward stock item.  Select:"
 W !! F Q1=1:1:$L(Q," ") S Q2=$P(Q," ",Q1) W:$X+$L(Q2)>78 ! W Q2," "
 W !?3,"1 to enter 0 (no) pre-exchange doses for this dispense drug.",!?3,"2 to enter ",PSGDA," doses for this dispense drug.",!?3,"3 to enter another amount for this dispense drug." Q
 ;
WDH ;
 W !!?2,"Enter a number from 0 to 9999, 0 decimal digits.  If you enter an '^' to exit",!,"NO pre-exchange doses will be entered for this dispense drug." Q
