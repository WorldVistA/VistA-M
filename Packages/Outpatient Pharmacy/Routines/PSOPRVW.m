PSOPRVW ;BIR/SAB,MHA-enter/edit/view provider ; 2/9/07 10:39am
 ;;7.0;OUTPATIENT PHARMACY;**11,146,153,263,268,264**;DEC 1997;Build 19
 ;
 ;Ref. to ^VA(200 supp. by IA 224
 ;Ref. to ^DIC(7 supp. by IA 491
 ;Ref.  to $$NPI^XUSNPI supp. by IA 4532
 ;
START W ! S DIC("A")="Select Provider: ",DIC("S")="I $D(^VA(200,+Y,""PS""))",DIC="^VA(200,",DIC(0)="AEQMZ" D ^DIC G:"^"[X EX G:Y<0 START K DIC S PRNO=+Y
 W @IOF,"Name: "_$P(^VA(200,PRNO,0),"^")
 I +$P(^VA(200,PRNO,"PS"),"^",4),$P(^("PS"),"^",4)'>DT W ?40,$C(7),"* * * INACTIVE AS OF ",$E($P(^("PS"),"^",4),4,5),"/",$E($P(^("PS"),"^",4),6,7),"/",$E($P(^("PS"),"^",4),2,3)," * * *"
 ;W !,"SSN#: " S T=$S($P(^VA(200,PRNO,1),"^",9)]"":$P(^(1),"^",9),1:"") W:T $E(T,1,3),"-",$E(T,4,5),"-",$E(T,6,9)
 W !,"Initials: "_$P(^VA(200,PRNO,0),"^",2)
 W !,"NON-VA Prescriber: "
 I $P($G(^VA(200,PRNO,"TPB")),"^")]"" W $S($P(^("TPB"),"^"):"Yes",1:"No")
 W ?40,"Tax ID: "_$P($G(^VA(200,PRNO,"TPB")),"^",2)
 W !,"Exclusionary Check Performed: " I $P($G(^VA(200,PRNO,"TPB")),"^",3)]"" W $S($P(^("TPB"),"^",3):"Yes",1:"No")
 W ?40,"Date Exclusionary List Checked: "
 S Y=$P($G(^VA(200,PRNO,"TPB")),"^",4) I Y W $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W !,"On Exclusionary List: " I $P($G(^VA(200,PRNO,"TPB")),"^",5)]"" W $S($P(^("TPB"),"^",5):"Yes",1:"No")
 W !,"Exclusionary Checked By: "
 I $P($G(^VA(200,PRNO,"TPB")),"^",6) W $P($G(^VA(200,$P(^("TPB"),"^",6),0)),"^")
 W !,"Authorized to Write Orders: "_$S($P(^VA(200,PRNO,"PS"),"^"):"Yes",1:"No")
 W !,"Requires Cosigner: "_$S($P(^("PS"),"^",7):"Yes",1:"No"),?40,"DEA# "_$P(^VA(200,PRNO,"PS"),"^",2) I $P(^("PS"),"^",7),$D(^VA(200,+$P(^("PS"),"^",8),0)) W !,"Usual Cosigner: "_$P(^(0),"^")
 W !,"Class: " S PRCLS=+$P(^VA(200,PRNO,"PS"),"^",5),PRCLS=$S(PRCLS>0&$D(^DIC(7,PRCLS,0)):$P(^(0),"^"),1:"") W PRCLS,?40,"VA#  "_$P(^VA(200,PRNO,"PS"),"^",3)
 W !," Type: " S T=+$P(^("PS"),"^",6),L=$P(^DD(200,53.6,0),"^",3)_";"_T_":Unknown" F I=1:1 I $P($P(L,";",I),":",1)=T W $P($P(L,";",I),":",2) Q
 N NPI S NPI=$P($$NPI^XUSNPI("Individual_ID",PRNO),"^") W ?40,"NPI# "_$S(NPI>0:+NPI,1:"")
 W !,"Remarks: "_$P(^VA(200,PRNO,"PS"),"^",9),!,"Synonym(s):  "_$S($P($G(^VA(200,PRNO,.1)),"^",4)]"":$P(^(.1),"^",4)_",",1:"")_$S($P(^(0),"^",2)]"":" "_$P(^(0),"^",2),1:"")
 W !,"Service/Section: " S PSOSSDA=$G(DA) I $P($G(^VA(200,PRNO,5)),"^") K DIQ S DIC="^DIC(49,",DA=$P(^VA(200,PRNO,5),"^"),DR=.01,DIQ="PSOSECT",DIQ(0)="E" D EN^DIQ1 W $G(PSOSECT(49,DA,.01,"E")) S DA=$G(PSOSSDA) K DR,DIC,DIQ,PSOSSDA,PSOSECT
 I $TR($G(^VA(200,PRNO,.11)),"^","")="" G NUM
 W !!,"Address: ",?10,$P(^VA(200,PRNO,.11),"^") W:$P(^(.11),"^",2)'="" !?10,$P(^(.11),"^",2) W:$P(^(.11),"^",3)'="" !?10,$P(^(.11),"^",3)
 W !?10,$P(^VA(200,PRNO,.11),"^",4) W:$P(^(.11),"^",4)]"" ", " S STAT=+$P($G(^(.11)),"^",5) W $S($D(^DIC(5,STAT,0)):$P(^(0),"^"),1:"")_"  "_$P(^VA(200,PRNO,.11),"^",6)
NUM G:'$D(^VA(200,PRNO,.13)) START
 W !,"Phone:    "_$P(^VA(200,PRNO,.13),"^"),! W:$P(^(.13),"^",2)]"" "Office:   ",$P(^(.13),"^",2),!
 W:$P(^VA(200,PRNO,.13),"^",3)]"" "Phone #3: "_$P(^(.13),"^",3),?40 W:$P(^(.13),"^",7)]"" "Voice Pager  #: "_$P(^(.13),"^",7) W !
 W:$P(^VA(200,PRNO,.13),"^",4)]"" "Phone #4: "_$P(^(.13),"^",4),?40 W:$P(^(.13),"^",8)]"" "Digital Pager#: "_$P(^(.13),"^",8)
 W:$P(^VA(200,PRNO,.13),"^",6)]"" !,"Fax #:    "_$P(^(.13),"^",6)
 W:$P($G(^VA(200,PRNO,.14)),"^")]"" !,"Room Loc: "_$P(^(.14),"^")
 G START
EX K DIC,DIE,DA,DR,D0,PRNO,PRCLS,STAT,T,Y,X,L,LF,I,DIR,DIROUT,DUOUT,DTOUT,DIRUT,%,%Y,%W,%Z,C,DDH,DI,DIH,DLAYGO,DQ,X1,XMDT,XMN
 Q
ASK ;edit providers
 K DIR,DTOUT,DUOUT,DIROUT,DIRUT
 W !! S DIC("A")="Select Provider: ",(DIC,DIE)=200,DIC(0)="AEQMZ" D ^DIC G:"^"[X EX G:Y<0 ASK S (FADA,DA)=+Y
 I '$D(^VA(200,DA,"PS")) G NPRV
ASK1 W @IOF,?25,"Provider: "_$P(^VA(200,DA,0),"^"),! F DR="TPB","PS",".11",".13",".14" D EN^DIQ
 K DIC,Y
EDT W ! L +^VA(200,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3)
 I '$T W $C(7),!!,"Provider Data is Being Edited by Another User!",! G QX
 N RTPB S RTPB=$G(^VA(200,DA,"TPB"))
 S DR="53.91" D ^DIE I $D(Y)!$D(DTOUT) G QX
 I 'X,$G(PSOTPBFG) G QX
 I X S DR="53.92R;53.93R;53.94R;53.95R"
 E  S DR="53.92;53.93;53.94;53.95"
 S DR=DR_";D:X MS^PSOPRVW",DIE("NO^")="OUTOK" D ^DIE K DIE("NO^")
 I '$D(^VA(200,DA,"TPB")),$G(PSOTPBFG) G QX
 I $D(Y)!$D(DTOUT) D:$P($G(^VA(200,DA,"TPB")),"^",3)  G QX
 .I RTPB=""!('$P(RTPB,"^",3)) S DR="53.96////"_DUZ D ^DIE
 I $P($G(^VA(200,DA,"TPB")),"^",3) D
 .I RTPB=""!('$P(RTPB,"^",3)) S DR="53.96////"_DUZ D ^DIE
 G:$G(PSOTPBFG) QX
ED1 S DR="53.1:53.6;I X'=4 S Y=""@1"";29;8932.1;@1;53.7;I 'X S Y=""@2"";53.8;@2;53.9;.111:.116;.131:.134;.136;.137;.138;.141",DR(2,200.05)=".01;2;3"
 D ^DIE S FADA=DA D:'$D(Y) KEY
QX K FADA,RTPB L -^VA(200,DA) Q:$G(PSOTPBFG)  G:+$G(VADA) ADD G ASK
 Q
 G:'$D(^VA(200,DA,"TPB")) ED1
ADD ;add new providers (kernel 7)
 W !
 S VADA=$$ADD^XUSERNEW("53.91;S:'X Y=""@2"";53.92R;53.93R;53.94R;53.95R;D:X MS^PSOPRVW;@2;53.1;53.2;53.3;53.4;53.5;53.6;53.7;S:'X Y=""@1"";53.8;@1;53.9;.111:.116;.131:.134;.136;.141")
 S (FADA,DA)=+VADA,(DIC,DIE)="^VA(200,"
 I VADA>0,$P(VADA,"^",3),$P($G(^VA(200,DA,"TPB")),"^") D
 .S DR="53.96////"_DUZ D ^DIE
 I VADA>0,'$P(VADA,"^",3) S DIC(0)="AEQMZ" G:'$D(^VA(200,+VADA,"PS")) NPRV G:$D(^VA(200,+VADA,"PS")) ASK1
 D:VADA>0 KEY K DIK,DIC,Y,X,VADA,VA,DEA Q:$G(PSOTPBFG)  K DA G EX
 Q
NPRV W ! S DIR("A",1)=$P(^VA(200,DA,0),"^")_" is NOT currently indicated as being a provider.",DIR("A")="Do you want to make "_$P(^VA(200,DA,0),"^")_" a provider? (Y/N): ",DIR(0)="SA^1:YES;0:NO",DIR("B")="NO"
 S DIR("?",1)="Answer with '1' or 'Yes' if "_$P(^VA(200,DA,0),"^")_" is to become a provider",DIR("?")="otherwise press return for 'No' and re-enter name." D ^DIR G:$D(DTOUT) EX
 G:'Y!($D(DIRUT))&('+$G(VADA)) ASK G:'$P(+$G(VADA),"^",3)&('Y) ADD
 G EDT
 Q
KEY I $D(^VA(200,DA,"PS")) D
 .I '$P(^VA(200,DA,"PS"),"^",4)!($P(^("PS"),"^",4)>DT) S PSOPDA=DA K DIC S DIC="^DIC(19.1,",DIC(0)="MZ",X="PROVIDER" D ^DIC K DIC S DA=PSOPDA K PSOPDA I +Y>0 S X=+Y D
 ..S:'$D(^VA(200,FADA,51,0)) ^VA(200,FADA,51,0)="^"_$P(^DD(200,51,0),"^",2)_"^^"
 ..S DIC="^VA(200,"_FADA_",51,",DIC(0)="LM",DIC("DR")="1////"_$S($G(DUZ):DUZ,1:"")_";2///"_DT,DLAYGO=200.051,DINUM=X,DA(1)=FADA
 ..L +^VA(200,FADA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) K DD,DO D FILE^DICN L -^VA(200,FADA) K DIC,DR,X,Y
 Q
MS ;
 W !!,$C(7),"This provider will not be selectable during TPB medication order entry!!",!
 Q
