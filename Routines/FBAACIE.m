FBAACIE ;AISC/GRR-COMPLETE PHARMACY INVOICE ;4/21/2004
 ;;3.5;FEE BASIS;**38,61,91**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D DT^DICRW,HOME^%ZIS I '$D(^FBAA(162.1,"AC",2)) W !!,*7,"There are no Invoices Pending completion!",!! Q
 D SITEP^FBAAUTL I FBPOP W !,*7,"Fee Site Parameters must be Initialized!" K FBPOP Q
 S FBAAOUT=1,FBMDF=$P(FBSITE(0),"^",10),UL="",$P(UL,"=",79)="="
RINV W ! S FBINTOT=0,DIC="^FBAA(162.1,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,5)=2&($D(^(""RX"",""AC"",2)))" D ^DIC K DIC("S") G END:X="^"!(X=""),RINV:Y<0 S FBIN=+Y,FBINTOT=+$P(^(0),"^",7)
 I '$D(^FBAA(162.1,FBIN,"RX","AC",2)) G RINV
 S J=0 F  S J=$O(^FBAA(162.1,FBIN,"RX","AC",2,J)) Q:'J  I $D(^FBAA(162.1,FBIN,"RX",J,0)) S Y(0)=^(0) D GOT
 I '$D(^FBAA(162.1,FBIN,"RX","AC",2)) K ^FBAA(162.1,"AC",2,FBIN) S ^FBAA(162.1,"AC",3,FBIN)="",$P(^FBAA(162.1,FBIN,0),"^",5)=3
 I $D(^FBAA(162.1,"AC",3,FBIN)) W !!,"Invoice is Complete",?30,"Totals: $ "_$J(FBINTOT,1,2)
 G RINV
END K FBAAOUT,FBIN,FBRX,FBSITE,FBDATEF,FBDRUG,FBPATN,FBPID,FBVNAME,FBVID,FBAC,FBAAPR,DA,X,Y,D0,D1,DI,DIC,DIE,DIRUT,DIV,DQ,DR,FBAP,FBGEN,FBGENSUB,FBINTOT,FBMDF,FBQTY,FBRBC,FBSTR,FBVEN,S,UL,ULL,POP,J,DFN,Z,ZZ,FBSW,FBPOP,FB1725
 K FBADJ,FBFPPSC,FBFPPSL,FBRRMK,DTOUT
 Q
GOT S FBDRUG=$P(Y(0),"^",2)
 S FBGENSUB=$$GET1^DIQ(162.11,J_","_FBIN_",",8.5)
 S FBGEN=$$GET1^DIQ(162.11,J_","_FBIN_",",9)
 S FBRX=$P(Y(0),"^"),FBDATEF=$P(Y(0),"^",3),FBAC=$P(Y(0),"^",4),DFN=+$P(Y(0),"^",5),FBPATN=$$VET^FBUCUTL(DFN),FBPID=$$SSN^FBAAUTL(DFN)
 S FBSTR=$P(Y(0),"^",12),FBQTY=$P(Y(0),"^",13),FBAAPR=$P(Y(0),"^",22)
 S Y=$S($D(^FBAA(162.1,FBIN,0)):^(0),1:"")
 S FBFPPSC=$P(Y,U,13)
 S FBFPPSL=$P($G(^FBAA(162.1,FBIN,"RX",J,3)),U)
 S FBVEN=+$P(Y,"^",4),FBVNAME=$$VEN^FBUCUTL(FBVEN),FBVID=$P($G(^FBAAV(FBVEN,0)),"^",2)
 ; set FB1725 flag = true if payment for a 38 U.S.C. 1725 claim
 S Y(2)=$G(^FBAA(162.1,FBIN,"RX",J,2))
 S FB1725=$S($P(Y(2),U,6)["FB583":+$P($G(^FB583(+$P(Y(2),U,6),0)),U,28),1:0)
 W @IOF,"Vendor: ",FBVNAME,"   Vendor ID: ",FBVID
 W !!,"Patient: ",FBPATN,"   Patient ID: ",FBPID
 W !,"FPPS Claim ID: ",$S(FBFPPSC="":"N/A",1:FBFPPSC)
 W ?28,"FPPS Line Item: ",$S(FBFPPSL="":"N/A",1:FBFPPSL)
 W !!,"Drug Name",?32,"   RX #  "," Strength  ","  Qty","   Amt Claimed   ",!,UL
 W !,FBDRUG,?34,FBRX,?43,FBSTR,?54,FBQTY,?63,FBAC
 I FBGENSUB]"" W !!,?4,"Generic Drug Issued: ",FBGENSUB,?30,"Generic Drug Name: ",$E(FBGEN,1,30)
 W:FBAAPR]"" !!,?5,"Pharmacy Remarks: ",FBAAPR
FEE S DIR(0)="161.4,9",DIR("B")=FBMDF,DIR("?")="Hit Return to accept default dispensing fee or enter a dollar amount between .01 and 20" D ^DIR K DIR Q:$D(DIRUT)
 W:FB1725 !?2,"**Payment is for emergency treatment under 38 U.S.C. 1725."
 W !! S FBMDF=+Y K FBAP
 S DA(1)=FBIN,DIE="^FBAA(162.1,"_FBIN_",""RX"",",DA=J,DIC=DIE,DR="5;S FBRBC=X;6.5//^S X=$S(FBRBC+FBMDF>FBAC:FBAC,1:FBRBC+FBMDF);S FBAP=X"
 S DR(1,162.11,1)="I FBAP>FBAC S $P(^FBAA(162.1,DA(1),""RX"",DA,0),U,16)="""" W !,*7,""Amount Paid cannot be greater than the Amount Claimed"" S Y=6.5"
 ;S DR(1,162.11,2)="S:(FBAC-FBAP)'>0 Y=8;6///^S X=FBAC-FBAP;Q;6R;7R;S:X'=4 Y=8;20;8////^S X=3"
 S DR(1,162.11,2)="S FBX=$$ADJ^FBUTL2(FBAC-FBAP,.FBADJ,2,,,1)"
 S DR(1,162.11,3)="S FBX=$$RR^FBUTL4(.FBRRMK,2);8////^S X=3"
 D ^DIE K DIE Q:$D(Y)'=0
 S:$D(FBAP) FBINTOT=FBINTOT+FBAP
 S $P(^FBAA(162.1,FBIN,0),"^",7)=FBINTOT
 G:$D(DTOUT) H^XUS
 ; file adjustments
 D FILEADJ^FBRXFA(DA_","_FBIN_",",.FBADJ)
 ; file remittance remarks
 D FILERR^FBRXFR(DA_","_FBIN_",",.FBRRMK)
 Q
