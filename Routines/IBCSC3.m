IBCSC3 ;ALB/MJB - MCCR SCREEN 3 (PAYER/MAILING ADDRESS) ;27 MAY 88 10:15
 ;;2.0;INTEGRATED BILLING;**8,43,52,80,82,51,137,232,320,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRSC3
 ;
EN N IB,IBX,IBINS,Y,Z
 I $D(DGRVRCAL) D ^IBCU6 K DGRVRCAL
 D ^IBCSCU S IBSR=3,IBSR1="",IBV1="000" I IBV S IBV1="111"
 D H^IBCSCU
 D:$D(^DGCR(399,IBIFN,"AIC")) 3^IBCVA0
 D:'$D(^DGCR(399,IBIFN,"AIC")) 123^IBCVA
 D POL^IBCNSU41(DFN)
 F I=0,"M","M1","U","U2" S IB(I)=$S($D(^DGCR(399,IBIFN,I)):(^(I)),1:"")
 S IBOUTP=2,IBINDT=$S(+$G(IB("U")):+IB("U"),1:DT)
 ;
 S X=" Rate Type  : "_$S($P(IB(0),U,7)']"":IBU,$D(^DGCR(399.3,$P(IB(0),U,7),0)):$P(^(0),U),1:IBUN)
 S Z=1,IBW=1 X IBWW W X
 I +$P($G(^IBE(350.9,1,1)),U,22) W $J("",(42-$L(X))),"Form Type: ",$P($G(^IBE(353,+$P(IB(0),U,19),0)),U,1)
 W !?4,"Responsible: ",$S($P(IB(0),U,11)']"":IBU,$P(IB(0),U,11)="p":"PATIENT",$P(IB(0),U,11)="i":"INSURER",1:"OTHER")
 W ?45,"Payer Sequence: " S IBX=$P(IB(0),U,21) W $S(IBX="P":"Primary",IBX="S":"Secondary",IBX="T":"Tertiary",IBX="A":"Patient",1:"")
 I $P(IB(0),U,11)="i" D
 . W !?4,"Bill Payer : " S X=$G(^DGCR(399,IBIFN,"MP"))
 . W $S(+X:$P($G(^DIC(36,+X,0)),U,1),$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)):"MRA NEEDED FROM MEDICARE",1:IBU)
 . W ?45,"Transmit: " S Z=0,X=$$TXMT^IBCEF4(IBIFN,.Z)
 . W $S(X:"Yes",1:"No-"_$S(Z=1:"Forced to print local",Z=2&($$WNRBILL^IBEFUNC(IBIFN)):"MRA not active",Z=2:"EDI not active",Z=3:"Rate typ transmit off",Z=4:"Ins. co transmit off",Z=5:"Failed RULE #"_$G(Z(0)),Z=6:"Invalid NDC code type",1:"??"))
 I $P(IB(0),U,11)']"" G MAIL
 I $P(IB(0),U,11)="p" G MAIL
 I $P(IB(0),U,11)="o" W !?4,"Inst. Name : ",$S($P(IB("M"),U,11)']"":IBU,$D(^DIC(4,$P(IB("M"),U,11),0)):$P(^(0),U,1),1:"UNKNOWN INSTITUTION") G MAIL
 I $P(IB(0),U,11)="i" I $D(IBDD)>1,$D(^DGCR(399,IBIFN,"AIC")) G SHW
 D UP G LST:$D(IBDD)>1 W !?4,"Insurance : NO REIMBURSABLE INSURANCE INFORMATION ON FILE",!?17,"[Add Insurance Information by entering '1' at the prompt below]" G MAIL
 ;
LST N IBDTIN,IBICT
 S IBDTIN=+$G(IB("U")),IBICT=0
 W ! D HDR^IBCNS
 S I=0 F  S I=$O(IBDD("S",I)) Q:'I  D  Q:IBICT'<5
 .S IBX=0 F  S IBX=$O(IBDD("S",I,IBX)) Q:'IBX  S IBINS=$G(IBDD(IBX,0)) I IBINS'="" S IBICT=IBICT+1 D:IBICT<5 D1^IBCNS I IBICT'<5 W !,?1,"**Patient has additional insurance - use ?INS to see the entire list" Q
 G MAIL
LST1 W !?4,$S($D(^DIC(36,+IBDD(IBX,0),0)):$E($P(^(0),"^",1),1,20),1:"UNKNOWN") S X=$P(IBDD(IBX,0),"^",6) W ?26,$S(X="v":"VETERAN",X="s":"SPOUSE",1:"OTHER") S X=$P(IBDD(IBX,0),"^",16)
 S X=$S(+X=1:"PATIENT",+X=2:"SPOUSE",+X=3:"CHILD",+X=8:"EMPLOYEE",+X=11:"ORGAN DONOR",+X=18:"PARENT",+X=15:"PLANTIFF",1:"UNKNOWN")
 I X="UNKNOWN" S X1=$S($D(IBDD(IBX,0)):$P(IBDD(IBX,0),"^",6),1:""),X=$S(X1="v":"PATIENT",X1="s":"SPOUSE",1:X)
 W ?37,X,?49 S Y=$P(IBDD(IBX,0),"^",8) X ^DD("DD") W Y,?64 S Y=$P(IBDD(IBX,0),"^",4) X ^DD("DD") W Y
 Q
SHW I $D(IBDD) S I="" F  S I=$O(IBDD(I)) Q:'I  D SHW1
MAIL I $$BUFFER^IBCNBU1(DFN) W !!,?17,"***  Patient has Insurance Buffer entries  ***"
 ;
 S IB("M")=$S($D(^DGCR(399,IBIFN,"M")):^("M"),1:""),IB("M1")=$S($D(^DGCR(399,IBIFN,"M1")):^("M1"),1:""),IB(0)=^DGCR(399,IBIFN,0)
 S Z=2,IBW=1 W ! X IBWW
 N IBRAMS S IBRAMS=4.06
 I $$FT^IBCEF(IBIFN)=3 S IBRAMS=4.08
 S IB("RAFLAG",1)=$S($P(IB("M"),U,1)="":0,1:$$GET1^DIQ(36,$P(IB("M"),U,1),IBRAMS,"I"))
 S IB("RAFLAG",2)=$S($P(IB("M"),U,2)="":0,1:$$GET1^DIQ(36,$P(IB("M"),U,2),IBRAMS,"I"))
 S IB("RAFLAG",3)=$S($P(IB("M"),U,3)="":0,1:$$GET1^DIQ(36,$P(IB("M"),U,3),IBRAMS,"I"))
 S X=0
 I $P(IB("M1"),U,2)="",'IB("RAFLAG",1),$P(IB("M1"),U,3)="",'IB("RAFLAG",2),$P(IB("M1"),U,4)="",'IB("RAFLAG",3) S X=1
 W " Billing Provider Secondary IDs: "
 I X W IBUN          ; no data found, unspecified not required
 I 'X D              ; data found, display below
 . W !?5,"Primary Payer: ",$S($P(IB("M1"),U,2)]"":$P(IB("M1"),U,2),IB("RAFLAG",1):"ATT/REND ID",1:"")
 . W !?5,"Secondary Payer: ",$S($P(IB("M1"),U,3)]"":$P(IB("M1"),U,3),IB("RAFLAG",2):"ATT/REND ID",1:"")
 . W ?46,"Tertiary Payer: ",$S($P(IB("M1"),U,4)]"":$P(IB("M1"),U,4),IB("RAFLAG",3):"ATT/REND ID",1:"")
 . Q
 ;
 S Z=3,IBW=1 W ! X IBWW
 W " Mailing Address : "
 S X=+$G(^DGCR(399,IBIFN,"MP"))
 I 'X,$$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(IBIFN)) S X=+$$CURR^IBCEF2(IBIFN)
 I X,+$G(^DIC(36,X,3)) S I=$P(^(3),U,$S($$FT^IBCEF(IBIFN)=2:2,1:4)) W ?56,"Electronic ID: ",$S(I'="":I,1:"<NONE>")
 S X="" I IB("M")]"" F I=4:1:9 Q:X]""  S X=$P(IB("M"),"^",I)
 I X']"" W !?4,"NO MAILING ADDRESS HAS BEEN SPECIFIED!",?45,$$UP1,!?4,"Send Bill to PAYER listed above." G ENDSCR
 S X=IB("M") W !,?4,$S($P(X,"^",4)]"":$P(X,"^",4),1:"'MAIL TO' PERSON/PLACE UNSPECIFIED"),?45,$$UP1
 W !?4,$S($P(X,"^",5)]"":$P(X,"^",5),1:"STREET ADDRESS UNSPECIFIED") W:$P(X,"^",6)]"" ", ",$P(X,"^",6)
 W ! W:$P(IB("M1"),"^",1)]"" ?4,$P(IB("M1"),"^",1),", "
 W ?4,$S($P(X,"^",7)]"":$P(X,"^",7),1:"CITY UNSPECIFIED"),", ",$S($D(^DIC(5,+$P(X,"^",8),0)):$P(^(0),"^",2),1:"STATE UNSPECIFIED"),"  ",$S($P(X,"^",9)]"":$P(X,"^",9),1:"ZIP UNSPECIFIED")
 ;
ENDSCR K IBADI,IBDD,IBOUTP,IBINDT,I,X,X1
 G ^IBCSCP
 ;
SHW1 S X=IBDD(I,0),Z=$G(^DIC(36,+X,0))
 W !!?4,"Ins ",I,": " W $E($S($P(Z,U,1)'="":$P(Z,U,1),1:IBU),1,16)
 I $P(Z,U,2)="N" W ?30,"WILL NOT REIMBURSE"
 W ?51,"Policy #: ",$E($S($P(X,"^",2)]"":$P(X,"^",2),1:IBU),1,18)
 W !?4,"Grp #: ",$E($S($P(X,"^",3)]"":$P(X,"^",3),1:IBU),1,16)
 W ?30,"Whose: ",$S($P(X,"^",6)="v":"VETERAN",$P(X,"^",6)="s":"SPOUSE",1:"OTHER")
 W ?51,"Rel to Insd: ",IBIR(I)
 W !?4,"Grp Nm: ",$E($S($P(X,"^",15)]"":$P(X,"^",15),1:IBU),1,16)
 W ?30,"Insd Sex: ",$S($D(IBISEX(I)):IBISEX(I),1:IBU)
 W ?51,"Insured: ",$E($P(X,"^",17),1,19)
 Q
 ;
UP K IBDD D ALL^IBCNS1(DFN,"IBDD",2,IBINDT,1)
 I $D(IBDD("S",.5)) D  ; At least 1 MCR WNR insurance policy exists
 . ;try to put correct part (A for institution and B for facility)
 . N Z,IBAB
 . S IBAB=$S($$FT^IBCEF(IBIFN)=3:"A",1:"B")
 . S Z=0 F  S Z=$O(IBDD("S",.5,Z)) Q:'Z  D
 .. I $P($G(IBDD(Z,355.3)),U,14)=IBAB S IBDD("S",.1,Z,0)="" K IBDD("S",.5,Z)
 Q
 ;
UP1() ;check if patient has medicare so can print a flag for the user
 N IBDD,IBX,IBY S IBY="" D ALL^IBCNS1(DFN,"IBDD",2,IBINDT)
 S IBX=0 F  S IBX=$O(IBDD(IBX)) Q:'IBX  I $P($G(IBDD(IBX,355.3)),U,9)=33 S IBY="(Patient has Medicare)"
 Q IBY
 ;IBCSC3
