PSODGAL2 ;BIR/SAB-displays stored DRUG ALLERGY w/sign/symptoms ;10/27/11  02:22
 ;;7.0;OUTPATIENT PHARMACY;**390**;DEC 1997;Build 86
 ;External reference to ^PS(50.605, supported by DBIA 696
 ;External reference to GETOC4^OROCAPI1 supported by DBIA 5729
 ;External reference to ^ORD(100.05 supported by DBIA 5731
 ;External reference to ^GMRD(120.83 supported by DBIA 5767
 ;External reference to ^VA(200 supported by DBIA 10060
 ;
 W @IOF
 N ZORN,X,RET,DA,ZCNT,ZCNTT,XXI,ZZQ,DA,ZI,IT,SEVT,SEVN,ZFND S (ZCNT,ZCNTT,ZFND)=0
 S DA=$P(PSOLST(ORN),"^",2),ZORN=$P(^PSRX(DA,"OR1"),"^",2)
 I 'ZORN W !,"NO Drug Allergy Order Checks found for Rx#: "_$P(^PSRX(DA,0),"^") G EXT
 K ^TMP("PSODAOCD",$J) D GETOC4^OROCAPI1(ZORN,.RET)
 I $O(RET(ZORN,"DATA",""))="" W !,"NO Drug Allergy Order Checks found for Rx#: "_$P(^PSRX(DA,0),"^") G EXT
 F ZI=0:0 S ZI=$O(RET(ZORN,"DATA",ZI)) Q:'ZI  I $P(RET(ZORN,"DATA",ZI,1),"^")=3 S ZCNTT=1
 I 'ZCNTT W !,"NO Drug Allergy Order Checks found for Rx#: "_$P(^PSRX(DA,0),"^") G EXT
 F ZI=0:0 S ZI=$O(RET(ZORN,"DATA",ZI)) Q:'ZI  I $P(RET(ZORN,"DATA",ZI,1),"^")=3 D
 .S ZCNT=ZCNT+1,^TMP("PSODAOCD",$J,"AOC",ZCNT,0)=$P(RET(ZORN,"DATA",ZI,0),"^",3)_"^"_$P(^VA(200,$P(RET(ZORN,"DATA",ZI,0),"^",4),0),"^")
 .I $G(RET(ZORN,"DATA",ZI,"OR",1,0))]"" S ^TMP("PSODAOCD",$J,"AOR",$G(RET(ZORN,"DATA",ZI,"OR",1,0)))=""
 .;
 .F XXI=0:0 S XXI=$O(^ORD(100.05,ZI,4,XXI)) Q:'XXI  D:$P($G(^ORD(100.05,ZI,4,XXI,0)),"^",3)]""
 ..S ZFND=1,^TMP("PSODAOCD",$J,"CA",$P(^ORD(100.05,ZI,4,XXI,0),"^",3))="",^TMP("PSODAOCD",$J,"OH")=$P(^ORD(100.05,ZI,4,XXI,0),"^",7)
 ..S IT=+$P(^ORD(100.05,ZI,4,XXI,0),"^",5)
 ..S SEVT=$P(^ORD(100.05,ZI,4,XXI,0),"^",8),SEVN=$S(SEVT=1:"MILD",SEVT=2:"MODERATE",SEVT=3:"SEVERE",1:"Not Entered")
 ..F ZZQ=0:0 S ZZQ=$O(^ORD(100.05,ZI,4,XXI,1,ZZQ)) Q:'ZZQ  S ^TMP("PSODAOCD",$J,"DC",$P(^ORD(100.05,ZI,4,XXI,1,ZZQ,0),"^"))=$P(^PS(50.605,$P(^ORD(100.05,ZI,4,XXI,1,ZZQ,0),"^"),0),"^")_" "_$P(^(0),"^",2)
 ..F ZZQ=0:0 S ZZQ=$O(^ORD(100.05,ZI,4,XXI,2,ZZQ)) Q:'ZZQ  S ^TMP("PSODAOCD",$J,"DI",$P(^PS(50.416,$P(^ORD(100.05,ZI,4,XXI,2,ZZQ,0),"^"),0),"^"))=""
 ..F ZZQ=0:0 S ZZQ=$O(^ORD(100.05,ZI,4,XXI,3,ZZQ)) Q:'ZZQ  S ^TMP("PSODAOCD",$J,"SS",$P(^GMRD(120.83,$P(^ORD(100.05,ZI,4,XXI,3,ZZQ,0),"^"),0),"^"))=""
 I 'ZFND W !,"NO Drug Allergy Order Checks found for Rx#: "_$P(^PSRX(DA,0),"^") G EXT
 K ^UTILITY($J,"W") S DIWL=1,DIWR=55,DIWF="" N Z,ZI,ZX
 D FULL^VALM1 N ING,SS,DC,CA,OH,CAG S (ING,SS,DC,CA)=""
 S CA=$O(^TMP("PSODAOCD",$J,"CA",""))
 W !,"Drug Allergy Occurrence Event for Rx#: "_$P(^PSRX(DA,0),"^"),!
 S CAG="^"_$P(CA,";",2)_$P(CA,";")_",0)"
 W !,"    Causative Agent: "_$S(CA="None Found":CA,1:$P(@(CAG),"^"))
 S OH=$G(^TMP("PSODAOCD",$J,"OH")) W !,"Historical/Observed: "_$S(OH="H":"HISTORICAL",OH="O":"OBSERVED",1:"Not Entered")
 W !,"           Severity: "_SEVN
 W !,"         Ingredient: " I $O(^TMP("PSODAOCD",$J,"DI",""))]"" D
 .F  S ING=$O(^TMP("PSODAOCD",$J,"DI",ING)) Q:ING=""  S X=ING_", " D ^DIWP
 .F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?21,^UTILITY($J,"W",1,ZX,0),!
 .K ^UTILITY($J,"W") S DIWL=1,DIWR=55,DIWF="" N Z,ZI,ZX
 E  W "None Entered",!
 ;
 W "     Signs/Symptoms: " I $O(^TMP("PSODAOCD",$J,"SS",""))]"" D
 .F  S SS=$O(^TMP("PSODAOCD",$J,"SS",SS)) Q:SS=""  S X=SS_", " D ^DIWP
 .F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?21,^UTILITY($J,"W",1,ZX,0),!
 .K ^UTILITY($J,"W") S DIWL=1,DIWR=55,DIWF="" N Z,ZI,ZX
 E  W "None Entered",!
 ;
 W "         Drug Class: " I $O(^TMP("PSODAOCD",$J,"DC",0))]"" D
 .F DC=0:0 S DC=$O(^TMP("PSODAOCD",$J,"DC",DC)) Q:'DC  S X=^TMP("PSODAOCD",$J,"DC",DC)_", " D ^DIWP
 .F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?21,^UTILITY($J,"W",1,ZX,0),!
 .K ^UTILITY($J,"W") S DIWL=1,DIWR=55,DIWF="" N Z,ZI,ZX
 E  W "None Found",!
 ;
 K ^UTILITY($J,"W") S DIWL=1,DIWR=55,DIWF="" N Z,ZI,ZX,OR
 S OR="" W "Provider Override Reason: " I $O(^TMP("PSODAOCD",$J,"AOR",""))]"" D
 .S OR=$O(^TMP("PSODAOCD",$J,"AOR","")) S X=OR D ^DIWP
 .F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?26,^UTILITY($J,"W",1,ZX,0),!
 E  W "N/A - Order Entered Through VistA",!
 I $G(IT) D
 .K DIC,DR,DIQ,DA,INTY S DIC=9009032.4,DA=IT,DR=".01;.03;.04;.08",DIQ="INTY" D EN^DIQ1
 .W !,"  Intervention Date: "_INTY(9009032.4,IT,.01)
 .W !,"           Provider: "_INTY(9009032.4,IT,.03)
 .W !,"         Pharmacist: "_INTY(9009032.4,IT,.04)
 .W !,"     Recommendation: "_INTY(9009032.4,IT,.08)
 .K DIC,DR,DIQ,DA,INTY
 E  W !," Pharmacist Intervention Not Entered"
EXT W !
 K DIR,DUOUT,DIRUT,ZFND
 S DIR(0)="E",DIR("A")="Press Return to Continue",DIR("?")="Press Return to Redisplay Rx."
 D ^DIR S VALMBCK="R" K DIR,DUOUT,DIRUT,^TMP("PSODAOCD",$J)
