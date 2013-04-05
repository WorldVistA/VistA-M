PSIVCHK ;BIR/PR,MLM-CHECK ORDER FOR INTEGRITY ; 10/1/10 8:48am
 ;;5.0;INPATIENT MEDICATIONS ;**54,58,81,111,213,113,179,248**;16 DEC 97;Build 6
 ;
 ; Reference to ^PS(51.1 supported by DBIA# 2177.
 ; Reference to ^DIE supported by DBIA# 2053.
 ;
 ;Need DFN and ON
 W ! S ERR=0,P("TYP")=P(4) S:P("TYP")="C" P("TYP")=P(23) I P("TYP")="S" S P("TYP")=$S(+P(5):"P",1:"A")
 I '+P("MR") W !,"*** You have not specified a med route! ",! S ERR=1
 I P(11)]"" S X=P(11),X(2)=$G(P(15)) D
 .N PSGSCH S PSGSCH=$G(P(9))
 .D ENCHK^PSGS0 K X(2)
 .I $G(P(15)) I $$ODD^PSGS0(P(15)) W !,"*** Administration times not permitted for Odd Schedules ***" S P(11)="",ERR=1 Q
 .I $G(P(9))]"" I $$PRNOK^PSGS0(P(9)) W !,"*** Administration times not permitted for PRN Schedules ***" S P(11)="",ERR=1 Q
 .I '$D(X) W !,"*** Your administration time(s) are in an invalid format, ",!,"*** or there are more times than indicated by the schedule !" S ERR=1
 ; If schedule exists in schedule file, and order's schedule is continuous,
 ; OR the order's schedule type is fill on request and the order's schedule is defined as continuous in schedule file,
 ; AND the order's schedule is not a PRN schedule, the order must have admin times.
 I $G(P(9))'="" I $D(^PS(51.1,"AC","PSJ",P(9))),'$G(ERR) D
 .N XC,XIEN,XTYP,XAR S (XC,XIEN)="" F XC=0:1 S XIEN=$O(^PS(51.1,"AC","PSJ",P(9),XIEN)) Q:XIEN=""  S XTYP=$P(^PS(51.1,XIEN,0),"^",5) S:XTYP'="" XAR(XTYP)=""
 .S XTYP="" F XC=0:1 S XTYP=$O(XAR(XTYP)) Q:XTYP=""
 .I $$ODD^PSGS0($G(P(15)))!($$PRNOK^PSGS0($G(P(9)))) S P(11)="" Q
 .I $G(P(15))]"" I XC<2,'$$PRNOK^PSGS0(P(9)),'$G(P(11)),($G(P(15))'="O"),'$$ONCALL^PSIVEDT1($G(P(9))),'$$ONETIME^PSIVEDT1($G(P(9))) S ERR=1 W !,"*** There are no administration times defined for this order!"
M I P(15)<0 S ERR=1 W !,"*** Time interval between doses is less than zero !"
 NEW X,PSJLDD S X=0 S:P(9)]"" X=$O(^PS(51.1,"APPSJ",P(9),0))
 N XX F XX=2,3 I $P(P(XX),".",2)=""!($L(P(XX))>12) S ERR=1 W !,"*** ",$S(XX=2:"Start",1:"Stop")," date is in an invalid format or must contain time !"
 I P(2)>P(3) S ERR=1 W !,"*** Start date/time CANNOT be greater than the stop date/time"
 I $$SCHREQ^PSJLIVFD(.P),'X D
 .N PSJXSTMP S PSJXSTMP=P(9) I PSJXSTMP="" S ERR=1 Q
 .N X,Y,PSGS0XT,PSGS0Y,PSGOES S PSGOES=2,X=PSJXSTMP D ENOS^PSGS0 I $G(X)]""&($G(X)=$G(PSJXSTMP)) Q
 .W !," *** WARNING -- Missing or Invalid Schedule ...",! S ERR=1
 ;179 Add Error for before dose if given.
 I $G(ON)&$G(DFN)&$G(PSIVCHG) D  ;179 xtra Protection.
 .S PSJLDD=$P($$EN^PSBAPIPM(DFN,ON),"^")
 .;PSJ*5*248 - Changed warning message
 .I PSJLDD>P(2) S ERR=1 W !,"*** Start date/time must be set AFTER last BCMA admin time ("_$$ENDTC1^PSGMI(PSJLDD)_")",!,"of this medication ***"
INF I P(8)="","AH"[P("TYP") S ERR=1 W !,"*** You have no infusion rate defined !"
 I "AH"[P("TYP"),P(8)'?1N.N.1".".1N1" ml/hr",P(8)'?.E1"@"1N.N,P(8)'?1"0."1N1" ml/hr" S ERR=1 W !,"*** Your infusion rate is in an invalid format !"
 I P(8)="",P("TYP")="P" S:'ERR ERR=2 W !,"*** WARNING -- You have not specified an infusion rate. "
 I '$$CODES1^PSIVUTL(P("TYP"),55.01,.04)!(P("TYP")="") S ERR=1 W !,"*** Type of order is invalid !"
 I '$$CODES1^PSIVUTL(P(17),55.01,100)!(P(17)="") S ERR=1 W !,"*** Status of order is invalid !"
AH ;
 I "HA"[P("TYP"),(P(11)]""!(P(9)]"")) W !,$C(7),"Order type is an admixture, hyperal, or continuous syringe, and you have",!,"a schedule and/or administration times defined!"
 I  F Q=0:0 W !,"Ok to delete these fields" S %=1 D YN^DICN D NULSET Q:%
 K % I P(6)="" S ERR=1 W !,"*** You have not entered a physician!"
 I P(6)]"",'$D(^VA(200,+P(6),"PS")) S ERR=1 W !,"*** Physician entered does not exist or is not authorized to write",!,"medication orders"
 I P(6)]"",$D(^VA(200,+P(6),"PS")),(+$P(^("PS"),U,4)),($P(^("PS"),U,4)'>DT) S ERR=1 W !,"*** Physician entered is no longer active."
 D ^PSIVCHK1
 Q
 ;
NULSET ;Delete admin/schedule fields for hyperals and/or admixtures
 I '% W !!?2,"Enter 'YES' to delete the schedule and/or administration times fields from",!,"this order.  Enter 'NO' (or '^') to leave the fields intact.",! Q
 S:%=1 P(9)="",P(11)=""
 Q
CKO S P16=0,PSIVEXAM=1,PSIVCT=1 D PSIVCHK S PSIVNOL=1 W ! D ^PSIVORLB K PSIVEXAM Q:'ERR
 I ERR=2 F J=0:0 W !!,"Since there is a warning with this order.",!,"do you wish to re-edit this order" S %=1 D YN^DICN Q:%  W !!,"Answer 'YES' to re-edit this order."
 I ERR=2,%=1 S PSIVOK="57^58^59^26^39^63^64^62^10^25^1" D ^PSIVORV2,GSTRING^PSIVORE1,GTFLDS^PSIVORFE K DA,DIE,DR G CKO
 Q
