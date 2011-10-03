RMPRFO3 ;PHX/HPL-PRINT FL 10-90 ADP LETTER ; 12/2/03 1:14pm
 ;;3.0;PROSTHETICS;**82**;Feb 09, 1996
 ;VARIABLES REQUIRED: DFN - DFN OF PATIENT ASSOCIATED WITH THE FL 10-90
 ;                    RMPRFA - LETTER TYPE IN ENGLISH (e.g.:  FL 10-90)
 ; 07/21/2004 KAM Patch RMPR*3*82 - Remove Patient SSN from Letter
VEN ;Enter the Vendor and items
 I '$D(RMPR("SIG")) D DIV4^RMPRSIT Q:$D(X)
 K DIC S DIC="^RMPR(665.4,",DIC(0)="L",X=DFN,DLAYGO=665.4
 D FILE^DICN
 S DA=+Y,ITM=DA,$P(^RMPR(665.4,DA,0),U,2)=RMPRFA
 S $P(^RMPR(665.4,DA,0),U,4)=DUZ
 S $P(^RMPR(665.4,DA,4),U,1)=RMPR("SIG"),$P(^(4),U,2)=RMPR("SBT")
 S $P(^RMPR(665.4,DA,5),U,1)=DT
 K DIK S DIK="^RMPR(665.4," D IX1^DIK
 S ITMFLG=0
 S DIE="^RMPR(665.4,",DR="[RMPR FL 10-90 ADP]"
 D ^DIE,PRNT1,EXIT
 Q
EXIT ;KILL VARIABLES AND EXIT ROUTINE
 K DIE,LP,LINES,LEN,LAPS,ITEM,HEADING,MORE,RMPRTMP1,RMPRTMP2
 K RMPRLNG,RMPRADD,RMPRCIT
 K DA,DIC,DIR,DR,ITM,ITMFLG,NAME,NOIT,RMPR1,RMPR2,RMPRDATE
 K RMPRDEL,RMPRFA,RMPRIN,RMPRL,RMPRTY,RMPRU
 Q
PRNT1 ;
 S %ZIS="MQ" D ^%ZIS G:POP EXIT
 K IOP I $E(IOST,1,2)["C-" G ENT
 I $D(IO("Q")) D  G EXIT
 .S ZTSAVE("DA")="",ZTSAVE("DFN")="",ZTSAVE("RMPR(")=""
 .S ZTSAVE("DATE(")="",ZTSAVE("RMPRSITE")=""
 .S ZTIO=ION,ZTRTN="ENT^RMPRFO3",ZTDESC="PRINT PROSTHETICS FL 10-90"
 .D ^%ZTLOAD K ZTDESC,ZTIO,ZTRTN,ZTSAVE
 ;
ENT ;ENTRY POINT FOR ACTUAL PRINTING
 ;If DA is not set then a skeleton ADP FL 10-90 letter is being printed.
 I $G(DA)>0&('$D(RMPR)) D DIV4^RMPRSIT Q:$D(X)
ENTR ;
 U IO
 S MORE=0,HEADING="REQUEST FOR QUOTATION"
 W !!,?IOM-$L(HEADING)\2,HEADING
 S HEADING="Date: "_$$FMTE^XLFDT(DT,"D")
 W !,?IOM-$L(HEADING)\2,HEADING
 W !!,?5,"TO: "
 I $G(DA)>0 I $D(^RMPR(665.4,DA,2)) W:($P(^RMPR(665.4,DA,2),U,1)'="") $P(^PRC(440,$P(^RMPR(665.4,DA,2),U,1),0),U,1)
 S RMPRCIT=RMPR("CITY")
 S RMPRADD=$L(RMPR("ADD"))
 S RMPRLNG=$S(RMPRCIT>RMPRADD:RMPRCIT,1:RMPRADD)
 S RMPRLNG=$S(RMPRLNG>$L(RMPR("ADD")):RMPRLNG,1:$L(RMPR("ADD")))
 S RMPRLNG=$S(RMPRLNG>$L(RMPR("NAME")):RMPRLNG,1:$L(RMPR("NAME")))
 W ?IOM-5-RMPRLNG-6,"FROM: Prosthetics Service" ;,RMPR("NAME")
 I $G(DA)>0 I $D(^RMPR(665.4,DA,2)) S:($P(^RMPR(665.4,DA,2),U,1)'="") RMPRTMP1=$P(^RMPR(665.4,DA,2),U,1),RMPRTMP2=^PRC(440,RMPRTMP1,0)
 I $G(DA)'>0 S RMPRTMP2="^^^^^^^^^"
 I $G(DA)>0 I '$D(^RMPR(665.4,DA,2)) S RMPRTMP2="^^^^^^^^^"
 S:$P(RMPRTMP2,U,7)'="" $P(RMPRTMP2,U,7)=$P(^DIC(5,$P(RMPRTMP2,U,7),0),U,1)
 W !,?9,$S($P(RMPRTMP2,U,2)'="":$P(RMPRTMP2,U,2),$P(RMPRTMP2,U,6)'=""&($P(RMPRTMP2,U,7)'=""):$P(RMPRTMP2,U,6)_", "_$P(RMPRTMP2,U,7)_"  "_$P(RMPRTMP2,U,8),1:"")
 W ?IOM-5-RMPRLNG,RMPR("NAME") ;"Prosthetics Service"
 W !,?9,$S($P(RMPRTMP2,U,2)'=""&($P(RMPRTMP2,U,3)'=""):$P(RMPRTMP2,U,3),$P(RMPRTMP2,U,6)'="":$P(RMPRTMP2,U,6)_", "_$P(RMPRTMP2,U,7)_"  "_$P(RMPRTMP2,U,8),1:"") W ?IOM-5-RMPRLNG,RMPR("ADD")
 I $P(RMPRTMP2,U,2)="",$P(RMPRTMP2,U,3)="",$P(RMPRTMP2,U,4)="" W !,?IOM-5-RMPRLNG,RMPR("CITY") G DNE
 I $P(RMPRTMP2,U,2)'=""&($P(RMPRTMP2,U,3)'="") D
 .I $P(RMPRTMP2,U,4)'="" W !,?9,$P(RMPRTMP2,U,4),?IOM-5-RMPRLNG,RMPR("CITY") S RDN=1
 I $P(RMPRTMP2,U,2)'=""&($P(RMPRTMP2,U,3)'="")&(($P(RMPRTMP2,U,4)'="")&($P(RMPRTMP2,U,5)'="")) D
 .W !,?9,$P(RMPRTMP2,U,5)
 .I $G(RDN)<1 W ?IOM-5-RMPRLNG,RMPR("CITY") S RDN=1
 I $P(RMPRTMP2,U,2)'=""&($P(RMPRTMP2,U,3)'="") W:$P(RMPRTMP2,U,6)'=""&($P(RMPRTMP2,U,7)'="") !,?9,$P(RMPRTMP2,U,6)_", "_$P(RMPRTMP2,U,7)_"  "_$P(RMPRTMP2,U,8) I $G(RDN)<1 W ?IOM-5-RMPRLNG,RMPR("CITY") S RDN=1
 I $G(RDN)<1 W !,?IOM-5-RMPRLNG,RMPR("CITY")
DNE K RDN S NAME=" ",SSN=" "
 ;Vendor phone on ADP FL 10-90
 W !!
 I $G(DA)'>0 S NAME="               "
DNE1 W ?9,"Vendor Phone #: "
 I $D(DA),$G(^RMPR(665.4,DA,2)) W $P(^PRC(440,$P(^RMPR(665.4,DA,2),U,1),0),U,10)
 I $G(DA)>0 S NAME=$P(^DPT($P(^RMPR(665.4,DA,0),U,1),0),U,1)
 ; *82 removed patient SSN from next line
 W ?IOM-5-$L(NAME)-9,"Veteran: ",NAME,!
 W !!,?5,"Your firm is being considered for the following:"
 S LINES=0,ITM=0,LEN=0
 F  Q:$G(DA)'>0  S ITM=$O(^RMPR(665.4,DA,3,ITM)) Q:ITM'>0!(LINES=5)  D:LINES<5
 .I LEN=0 W !,?6," " S LINES=LINES+1
 .I LEN>0,LEN+$L($P(^RMPR(665.4,DA,3,ITM,0),U,1))<71 W ", "
 .I LEN>0,LEN+$L($P(^RMPR(665.4,DA,3,ITM,0),U,1))>70 S LEN=0 W !,?6," " S LINES=LINES+1
 .W:LINES<5 ^RMPR(665.4,DA,3,ITM,0)
 .S LEN=LEN+2+$L($P(^RMPR(665.4,DA,3,ITM,0),U,1))
 .I LINES>4&(ITM>0) S MORE=1,ITEM=ITM Q
 W !!,?5,"An estimate on the above-listed item(s) is requested.  "
 W "YOUR QUOTATION "
 W !,?5,"DOES NOT CONSTITUTE A PURCHASE ORDER."
 W "  Upon completion of the esti-"
 W !,?5,"mate, return the original to the Veterans Affairs facility indicated"
 W !,?5,"above and retain a copy for your files."
 W !!,?5,"If approved, a purchase order will be prepared and forwarded to you."
 W !!,?5,"Sincerely,"
 I $Y+2>IOST,$E(IOST,1,2)["C-" W !! S DIR(0)="E" D ^DIR S:+Y'>0 FL=1 Q:Y'>0  W @IOF
 W !!!!,?5,RMPR("SIG"),!,?5,RMPR("SBT")
EST ;PRINT VENDOR'S ESTIMATE SECTION OF FL 10-90
 S LINES=0,HEADING="VENDOR'S ESTIMATE" W !!,?IOM-$L(HEADING)\2,HEADING
 S HEADING="(To be completed by Vendor)" W !,?IOM-$L(HEADING)\2,HEADING
 W !,?5,$$REPEAT^XLFSTR("-",70)
 W !,?5,"|",?12,"Article or Service"
 W ?37,"|Quantity| Unit |Unit Cost|Total Cost|"
 W !,?5,$$REPEAT^XLFSTR("-",70)
 S LAPS=$Y
 F LP=LAPS:1:47 W !,?5,"|",?37,"|",?46,"|",?53,"|",?63,"|",?74,"|" I $Y>20&($E(IOST,1,2)["C-") K DIR S DIR(0)="E" D ^DIR G:(X="^")!($D(DTOUT)) QWIT W @IOF
 W !,?5,$$REPEAT^XLFSTR("-",70)
 W !,?5,"|  Vendor:",?42,"Contract number (if applicable) |"
 W !,?5,"|  Address:",?74,"|"
 W !,?5,"|  City:",?74,"|",!,?5,"|  State:",?26,"Zip:",?74,"|"
 W !,?5,"|  Telephone:",?74,"|",!,?5,"|  Date:",?37,"Signature & Title of Company Official|"
 W !,?5,"|  Note:List Terms/Discounts if Applicable",?74,"|"
 W !,?5,$$REPEAT^XLFSTR("-",70)
 W !,?59,"FL 10-90 ADP"
 I $E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR
 W @IOF D:$G(MORE)=1 MORE^RMPRFO6,EST D EXIT,^%ZISC
QWIT Q
