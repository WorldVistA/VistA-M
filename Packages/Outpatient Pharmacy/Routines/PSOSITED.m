PSOSITED ;BHAM ISC/SAB - ENTER/EDIT OUTPATIENT SITE PARAMETERS ; 09/18/92 9:11
 ;;7.0;OUTPATIENT PHARMACY;**24,65,268,354**;DEC 1997;Build 16
 ;External reference to ^PS(59.7 supported by DBIA 694
 I $G(PSOPAR)']"" D ^PSOLSET
1 W ! K DIC S DIC("A")="Select SITE NAME: ",(DIC,DIE)="^PS(59,",DIC(0)="QEALM",DLAYGO=59
 K PSOSITEX D ^DIC G:"^"[X EX K DIC("A") G:Y<0 1 S DA=+Y D FLDQ G:$D(PSOSITEX) EX S DR="[PSO SITE]" W ! D ^DIE K DIE("NO^")
 W !!,"Outpatient System Parameters",! S DA=1,DIE=59.7,DR="40;40.1;40.19;40.14;40.15" L +^PS(59.7,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W !,"Another person is editing this entry.  Try Later!",! K DA,DIE,DR G 1
 D ^DIE L -^PS(59.7,DA)
 N CNT,TOT S (TOT,CNT)=0 F  S CNT=$O(^PS(59,CNT)) Q:'CNT  S TOT=TOT+1
 D:TOT>1 ^PSODIV K CNT,TOT
 S:$G(PSOSITE)=DA PSOPAR=$G(^PS(59,DA,1)),PSOPAR7=$G(^PS(59,DA,"IB")),PSOSYS=$G(^PS(59.7,1,40.1)) D EX G 1
EX K DIC,DA,DIE,DIR,DIV,DR,I,PS1,PS11,PSIX,PSOCNT,PSOSITEX,X,Y,%,%X,%Y,D0,DI,DQ,DX,S Q
 Q
FLDQ S DIR("?",1)="Press <RETURN> if you want to see a list of all outpatient",DIR("?")="pharmacy answered site fields.  Enter 'N' if you don't want to see the list."
 S DIR(0)="Y",DIR("A")="Would you like to see all site parameters for this division",DIR("B")="Y" D ^DIR K DIR S:$D(DTOUT) PSOSITEX="" I Y,'$D(PSOSITEX) W @IOF D EN^DIQ
 K DIR Q
 ;
CATVAL(X) ;Input transform for CATEGORY field #1, OPAI sub-file #59.20081 
 ;of the DISPENSING SYSTEM PRINTER sub-file #59.02008 of File #59.
 ;This check ensures that a dispensing printer is not assigned more
 ;than one ADD device with conflicting categories which guarantees an 
 ;RX is routed to only one dispensing device. Valid category
 ;combinations are shown at the COMB line tag. Category "A"ny is
 ;selectable only when no other category is defined on file for that
 ;device and vice versa. The category "S"torage can be combined with
 ;any other category or can standalone.
 ;
 I $G(X)="" Q 0
 N DEV,CAT,CATL,FLG,II,XX
 S (DEV,FLG)=0,CATL=""
 F  S DEV=$O(^PS(59,DA(2),"P",DA(1),"OPAI",DEV)) Q:'DEV  D  I FLG Q
 .S CAT=$P($G(^PS(59,DA(2),"P",DA(1),"OPAI",DEV,0)),"^",2) I CAT="" Q
 .I DEV=DA Q  ;current entry
 .I CAT'="S",X=CAT D EN^DDIOL("  <-- Category already on file.","","?0") S FLG=1 Q
 .S CATL=CATL_"^"_CAT
 I FLG Q FLG
 ;if no categories are on file or the category entered is storage then quit
 I (CATL="")!(X="S") Q FLG
 S CATL=CATL_"^"_X
 F II=1:1 S XX=$T(COMB+II) Q:XX["END"  S XX=$P(XX,";;",2),FLG=$$COMCHK(XX,CATL) I 'FLG Q
 I FLG D
 .;D EN^DDIOL("  <-- Can't be combined with categories on file.","","?0")
 .D EN^DDIOL("  <-- Conflicting categories.","","?0")
 .D EN^DDIOL("*** Valid category combinations are:","","!?5")
 .F II=1:1 S XX=$T(COMB+II) Q:XX["END"  S XX=$P(XX,";;",2) D
 ..S XX=$E(XX,2,9999)
 ..D EN^DDIOL(II_". "_$TR(XX,"^",", "),"","!?8")
 .D EN^DDIOL("  ","","?0")
 Q FLG
 ;
COMCHK(CMBO,STR) ; check allowable ADD combinations for a printer
 ;INPUT CMBO - contains a set of categories that can be combined together
 ;      STR  - checked against CMBO for validity.
 ;OUTPUT     - returns a 0 if a combination is valid, else a 1.
 ;
 N I1,VAL,FLG
 S FLG=0
 ;find valid CMBO combination base on value in STR
 F I1=1:1:$L(STR,"^") S VAL=$P(STR,"^",I1) D  I FLG Q
 .I VAL'="",VAL'="S",CMBO'[("^"_VAL_"^") S FLG=1
 Q FLG
 ;
COMB ; valid category combinations for ADDs that can be assigned to a dispensing printer.
 ;;^MCS^MNCS^WCS^WNCS^S
 ;;^MCS^MNCS^WIND^S
 ;;^WCS^WNCS^MAIL^S
 ;;^CS^MNCS^WNCS^S
 ;;^NCS^WCS^MCS^S
 ;;^MAIL^WIND^S
 ;;^CS^NCS^S
 ;;^A^S
 ;;^S
 ;;END
