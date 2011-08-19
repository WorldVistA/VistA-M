EEO211 ;HISC/JWR - GATHERS INFORMATION FOR FORM 0210 (COUNS. INTAKE FORM) ;Apr 20, 1995
 ;;2.0;EEO Complaint Tracking;**1,2**;Apr 27, 1995
GATHER ;Gathers complaint information for the Complaint Intake Form (0210)
 S EEOFIL=785,EEOSJ=$J K ^TMP("EEOJ",EEOSJ)
 K EEO1 F NO=0,1,5,6 S EEO1(NO)=$G(^EEO(EEOFIL,DA,NO))
 S EEONA=$P(EEO1(0),U),EEOSE=$P(EEO1(0),U,4),EEOPO=$P(EEO1(0),U,5)
 S EEORE=$P(EEO1(0),U,7),EEOPH=$P(EEO1(0),U,8),EEOSTR=$P(EEO1(0),U,9)
 S EEOCI=$P(EEO1(0),U,10),EEOST=$P(EEO1(0),U,11),EEOZI=$P(EEO1(0),U,12)
 S EEOIN=$P(EEO1(1),U,12),EEOFI=$P(EEO1(1),U,2),EEOCO=$P(EEO1(1),U)
 S EEOUN=$P(EEO1(6),U),EEOMS=$P(EEO1(6),U,2),EEOJO=$P(EEO1(5),U,19)
 I EEOST>0 I '$D(^DIC(5,EEOST)) S EEOST=" "
 E  S:EEOST>0 EEOST=$P(^DIC(5,EEOST,0),U,2)
 I EEOSE>0 I '$D(^ECC(730,EEOSE)) S EEOSE=" "
 E  S:EEOSE>0 EEOSE=$P(^ECC(730,EEOSE,0),U)
 S:EEOCI'="" EEOCI=EEOCI_"," S EEOVA=""
 S:+$G(^EEO(785,DA,1))>0 EEOVA=$G(^VA(200,+$P(^(1),U),20))
 S EEONAME=$P(EEOVA,U,2),EEOTITL=$E($P(EEOVA,U,3),1,40),EEOCAS=$P(EEO1(5),U,6)
 S Y=EEOIN D DT S EEOIN=Y,Y=EEOFI D DT S EEOFI=Y D NOW^%DTC S EEOCT=%H,Y=DT D DT S EEODT=Y S EEOCT=($E(EEOCT,11)_$E(EEOCT,5)_$E(EEOCT,7,10))
MULT ;Makes an array of the information in the multiple field
 S EEOFIL=$S($D(^EEO(785.5,DA)):785.5,1:785)
 F CNT=8,9,10 S CN=0,EEO1(CNT)="^" F  S CN=$O(^EEO(EEOFIL,DA,CNT,CN)) Q:CN=""!(+CN'=CN)  S EEO1(CNT)=EEO1(CNT)_^(CN,0)_"^"
WP S EEOFIL=$S($D(^EEO(785.5,DA)):785.5,1:785)
 S CNT=7,CN=0 F  S CN=$O(^EEO(EEOFIL,DA,CNT,CN)) Q:CN=""!(+CN'=CN)  D
 .S ^TMP("EEOJ",EEOSJ,CNT,CN)=$G(^EEO(EEOFIL,DA,CNT,CN,0))
 Q
BOX ;Fills boxes for Issue Codes on Form 0210
 S EN="",EOC=0,EEO2J=EEO1J F ECN=1:1:60 S CX=$P(EEO1(10),U,ECN) I CX<50&(CX>0) I $D(^EEO(786,CX)) S EOE2=" ",EN=$P(^EEO(786,CX,0),U),CN=$E(EN,1,21) D
 .S Y=$P($P(EEO1(10),U,ECN+1),U) D DD^%DT S EOE2=Y,BOX="[X]",EOC=EOC+1
 .I $P(EEO1(10),U,ECN+1)'>2000000 S EOE2=""
 .I BOX="[X]" I EOC#2=1 W !,OE,BOX,CN,$J(OE,80-$L(CN)-58),EOE2,$J(" ||",15-$L(EOE2)) S EEO1J=EEO1J+1
 .I BOX="[X]" I EOC#2=0 W BOX,CN,$J(OE,22-$L(CN)),EOE2,$J(OE,14-$L(EOE2))
 .X EEOIOF Q:EEOQUIT=1  K EOE2
 I EOC#2=1 W $J(OE,25),$J(OE,14)
 I EEO1J=EEO2J W !,OE,$J(OE,25),$J("||",15),$J(OE,25),$J(OE,14) S EEO1J=EEO1J+1
 Q
DT D DD^%DT Q
BOXB ;Fills basis boxes on Form 0210
 S EEO1J=0,CN="",EOC=0 F  S CN=$O(^EEO(785.1,"B",CN)) Q:CN=""  S BOX="[ ]" D
 .S CX=$O(^EEO(785.1,"B",CN,"")) I EEO1(9)[("^"_CX_"^") S BOX="[X]",EOC=EOC+1
 .I BOX="[X]" I EOC#2=1 W !,OE,BOX," ",CN,$J(OE,36-$L(CN)) S EEO1J=EEO1J+1
 .I BOX="[X]" I EOC#2=0 W BOX," ",CN,$J(OE,35-$L(CN))
 .X EEOIOF Q:EEOQUIT=1 
 I EOC#2=1 W $J(OE,39)
 I EEO1J=0 W !,OE,$J(OE,40),$J(OE,39) S EEO1J=1
 Q
BOXC ;
BOXC1 ;Fills boxes for Corrective actions on Form 0210
 S EEO2J=EEO1J F CN=2:1 Q:$P(EEO1(8),U,CN)'>0  D
 .Q:'$D(^EEO(785.2,$P(EEO1(8),U,CN)))
 .S EOE=$P(^EEO(785.2,$P(EEO1(8),U,CN),0),U) W !,OE," ",EOE,$J(OE,78-$L(EOE)) S EEO1J=EEO1J+1 X EEOIOF Q:EEOQUIT=1 
 .I EEO1J=EEO2J W !,OE,$J(OE,79),!,OE,$J(OE,79) S EEO1J=EEO1J+2
 Q
WPB ;Checks legnth of word processing fields
 Q:EEOQUIT=1
 S EEOH=15-EEO1J,CN=1 S:IOSL>60 EEOH=EEOH+IOSL-60 W !,OE,$J(OE,79)
WPB2 ;Enter here if WP field requires more than one page
 S EEOD=0 F CN=CN:1 Q:'$D(^TMP("EEOJ",EEOSJ,7,CN))  D:$L(^(CN))>78 TEST X EEOIOF Q:EEOQUIT=1  Q:EEOH-2'>EEOD  I $L(^(CN))'>78 W !,OE,^(CN),$J(OE,79-$L(^(CN))) S EEOD=EEOD+1 I EEOH-2'>EEOD I $D(^(CN+1)) Q
 S EEO("WP")="" D:$D(^TMP("EEOJ",EEOSJ,7,CN+1)) WPB3
 I '$D(^TMP("EEOJ",EEOSJ,7,CN+1)) D FILL
 Q
LEND ;If information for Form 0210 is more than one page this makes second page
 Q:EEO("WP")'=1  S EEO1J=0,EEOH=44
 S:IOSL>60 EEOH=EEOH+IOSL-60 W:IOS'=EEOII @IOF W:$D(IO("S")) ! D HEAD^EEO0210 Q:EEOQUIT=1
 W " 17. Case number",$J(OE,29),!,OE,"     ",EEONA,$J(OE,40-$L(EEONA)-11),"     ",EEOCAS,$J(OE,45-$L(EEOCAS)-5),!,OE,EO,OE
 W !,OE,"10.Recommended Information Gathering (list names, documents, and records)     |",!,OE,$J(OE,79) S CN=CN+1 D WPB2 Q:EEOQUIT=1
 D FOOT^EEO0210 I $D(^TMP("EEOJ",EEOSJ,7,CN)) G LEND
EX1 K EEONAME,EEOTITL,EEOVA,^TMP("EEOJ",EEOSJ),EEOSJ
 Q
TEST ;Test legnth of word processing fields
 Q:'$D(^TMP("EEOJ",EEOSJ,7,CN))  Q:$L(^TMP("EEOJ",EEOSJ,7,CN))<79  F CT=1:1 Q:CT-1*78>$L(^TMP("EEOJ",EEOSJ,7,CN))  S EEO=78*(CT-1) D
 .S EEOD=EEOD+1
 .S ^TMP("EEOJ",EEOSJ,7,CN,CT)=$E(^TMP("EEOJ",EEOSJ,7,CN),EEO+1,EEO+78)
 .X EEOIOF Q:EEOQUIT=1 
 .W !,OE,^TMP("EEOJ",EEOSJ,7,CN,CT),$J(OE,79-$L(^TMP("EEOJ",EEOSJ,7,CN,CT)))
 Q
WPB3 ;If more than one page is required for Form 0210
 X EEOIOF Q:EEOQUIT=1
 W !,OE,$J(OE,79),!,OE,$J(OE,79),!,OE,$J("(Recommended Info. Gathering Displayed on Following Page)",67),$J(OE,12) S EEO("WP")=1
 Q
FILL ;Fills in blank lines
 F CN2=EEOD:1:EEOH X EEOIOF Q:EEOQUIT=1  W !,OE,$J(OE,79)
 S EEOD=0 Q
TERMIOF ;
 I $Y'>(IOSL-6) Q
 I IOS=EEOII I $G(EEOQ)'>0 I '$D(IO("S")) D
 .W ! S DIR(0)="FAO^0:1^",DIR("A")="        Hit return to continue or ""^"" to exit "
 .D ^DIR S:X="^" EEOQUIT=1
 .W @IOF Q
