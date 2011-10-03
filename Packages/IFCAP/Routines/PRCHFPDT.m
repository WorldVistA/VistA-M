PRCHFPDT ;WISC/RWS-FPDS SCREENS FOR FY89 ;12/20/96  2:02 PM
V ;;5.1;IFCAP;**79**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;This routine supports the collection of FPDS data for Purchase Card
 ;and Delivery Orders users during a purchase order creation. It's
 ;called from the input template [PRCHAMT89 NEW].
 ;
PREF ;Screen for Pref Prog. Codes
 ;List possible 'PREF. PROGRAM' choices.
 ;
 W !!,"Possible Preference Program Codes: "
 S I=0 F Y=149:0 S Y=$O(^PRCD(420.6,Y)) Q:Y="B"  D  I PRCHDISP'="N" D PREF2 I $T W:I "," W $P(^PRCD(420.6,Y,0),U,1) S I=I+1
 . S PRCHDISP=$P(^PRCD(420.6,Y,0),U,5)
 . Q
 ;
 ;Y = field # 1.2 'PREF. PROGRAM' -- the Y is set to jump back to template [PRCHAMT89 NEW] to proper field 1.2 rather than first field #1.2
 ;
 S Y="@12"
 W ! K Z,Z1
 Q
 ;
PREF2 ;Z2=COMPETITIVE STATUS/BUSINESS, Z1=PREFERENCE PROGRAM CODE, PRCHN("MB")=METHOD OF BUSINESS
 S Z1=$P(^PRCD(420.6,Y,0),U,1),Z0=0
 I $P(^PRCD(420.6,Y,0),U,3)'=PRCHDT G PREFQ
 ;
 ;Add new codes for the FPDS report to Austin: #170-#174, PRC*5.1*79.
 I "^151^154^155^169^170^171^172^173^174^"'[Y G PREFQ
 S Z2=$P($G(^PRCD(420.6,+$P(^PRC(442,DA(1),9,DA,0),U,4),0)),U,1)
 ;if source code=5 & method of business=4 & comp stat/bus=Z4 then pref program code must be set to O i.e. none of the above.
 I Z2["Y1","X1","K"'[Z1 G PREFQ                ;new for PRC*5.1*79
 I Z2["X",Z1="I" G PREFQ
 ;if vendor size=1 show all pref programs, otherwise show only 'O'
 I +PRCHN("MB")=1 S Z0=1 G PREFQ                ;new for PRC*5.1*79
 I "234"[+PRCHN("MB"),"O"[$E(Z1) S Z0=1 G PREFQ
 ;
PREFQ I Z0
 K Z0,Z1
 Q
 ;
BREAK ;Setting BREAKOUT CODE (# 442.16)
 ;When Source Code=5, then Breakout/Socio.Gr. must be set to OO (161).
 I PRCHSC=5 D  Q
 . S ^PRC(442,PRCHPO,9,DA,1,0)="^442.16PA^161^1"
 . S ^PRC(442,PRCHPO,9,DA,1,161,0)=161
 . S ^PRC(442,PRCHPO,9,DA,1,"B",161,161)=""
 . Q
 I $O(PRCHB(0)) S ^PRC(442,PRCHPO,9,DA,1,0)=PRCHB(0) F I=0:0 S I=$O(PRCHB(I)) Q:'I  S ^PRC(442,PRCHPO,9,DA,1,I,0)=I,^PRC(442,PRCHPO,9,DA,1,"B",I,I)=""
 S I=$P(^PRC(442,PRCHPO,9,DA,0),"^",2),PRCHN("TC")=$P($G(^PRCD(420.6,+I,0)),"^",1)
 Q
 ;
COMP ;template [PRCHAMT89 NEW] calls COMP
 ;List possible 'COMP. STATUS/BUSINESS' choices.
 ;
 W !!,"Possible Competitive Status/Business codes: "
 S I=0 F Y=120:0 S Y=$O(^PRCD(420.6,Y)) Q:Y>132  D COMP2 I $T W:I "," W $P(^PRCD(420.6,Y,0),U,1) S I=I+1
 ;
 W ! K Z,Z1
 Q
COMP2 ;
 S Z1=$P(^PRCD(420.6,Y,0),U,1),Z0=0 G COMPQ:$P(^(0),U,3)'=PRCHDT!(Y<121)!(Y>132)
 ;if source code=5 business type=4 then add $$ amt in code index Z4 category.
 I PRCHN("MB")[$E(Z1,2) S Z0=1
 ;
COMPQ I Z0
 K Z0,Z1
 Q
CHK ; CHECK FOR VARIOUS COMBINATIONS OF 'SOCIOECONOMIC GROUP (FY89)' CODES IN VENDOR FILE.
 K PRCHTO
 I $P($G(^PRC(440,DA,1.1,0)),"^",3)="" G ERR ;See NOIS:V13-0802-N1396
 F I=0:0 S I=$O(^PRC(440,DA,1.1,I)) Q:'I  S PRCHTO(I)=""
 I $D(PRCHTO(161)) K PRCHTO(161) I $O(PRCHTO(0)) W $C(7),!!,"You CANNOT have a Socioeconomic Group of OO--NONE OF THE OTHER CATEGORIES",!,"in combination with any other Socioeconomic Group",!,"RE-ENTER ALL!!!",! G ERR
 I $D(PRCHTO(157)),$D(PRCHTO(153))!$D(PRCHTO(163))!$D(PRCHTO(164)) W $C(7),!!,"You CANNOT have the Socioeconomic Group of P--JAVITS-WAGNER-O'DAY",!,"in combination with any LARGE group",!,"RE-ENTER ALL!!!",! G ERR
 I '$D(PRCHTO(162)),$D(PRCHTO(167)) W $C(7),!!,"Category RV--SERVICE-DISABLED VETERAN must also include S--VETERAN-OWNED SM BUSINESS",!,"RE-ENTER ALL!!!" G ERR
 ;
EX K PRCHTO,I
 Q
 ;
ERR K ^PRC(440,DA,1.1) S Y=10
 G EX
 ;
D1 ; DISPLAY BREAKOUT CODES BROUGHT FROM VENDOR FILE IN ROUTINE PREF (CALLED FROM INPUT TEMPLATE [PRCHAMT89 NEW])
 S I=0 F J=1:1 S I=$O(^PRC(442,PRCHPO,9,DA,1,I)) Q:'I  S X=$G(^PRCD(420.6,+I,0)) W:J=1 !!,"Following Socioeconomic Group Codes brought over from Vendor File:",! W ?5,$P(X,"^",1)_"  "_$P(X,"^",2),!
 Q
