PSJUTL1 ;BIR/MLM-MISC. INPATIENT UTILITIES ;29 Jul 98 / 4:29 PM
 ;;5.0; INPATIENT MEDICATIONS ;**15,50,58**;16 DEC 97
 ;
 ; Reference to ^PSSLOCK is supported by DBIA# 2789.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PS(50.7 is supported by DBIA# 2180.
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^PS(59.7 is supported by DBIA# 2181.
 ; Reference to ^PSDRUG is supported by DBIA# 2192.
 ; Reference to ^XPD(9.7 is supported by DBIA# 2197.
 ;
CONVERT(DFN,TYPE) ;
 ; Convert existing UD orders to new format. Only run once/patient, and
 ; only converts orders with a stop date<(5.0 Install date-365)
 ;  DFN = Patient IEN
 ; TYPE = Background or Interactive mode
 ;
 S TYPE=TYPE&($E($G(IOST))="C")
 ;I '$D(^PS(55,DFN,0))!($P($G(^PS(55,DFN,5.1)),U,11)=1) Q
 ;I $S($P($G(^PS(55,DFN,5.1)),U,11)=1:1,$O(^PS(55,DFN,"IV",0)):0,$O(^PS(55,DFN,5,0)):0,1:'$O(^PS(53.1,"C",DFN,0))) Q
 I $P($G(^PS(55,DFN,5.1)),U,11)=1 Q
 N ADS,ADS1,DDRG,ND,ON,ON1,PSGDT,PSJOI,STAT,STPDT,STS,X,XX,X1,X2
 ;I '$D(^PS(55,DFN,0)) D
 ;I '$D(^PS(55,DFN,0))&(($O(^PS(55,DFN,"IV",0)))!($O(^PS(55,DFN,5,0)))!($O(^PS(53.1,"C",DFN,0)))) D
 I '$D(^PS(55,DFN,0))&($D(^PS(55,DFN))!($O(^PS(53.1,"C",DFN,0)))) D
 .N X,Y,DA,DIK S ^PS(55,DFN,0)=DFN K DIK S DA=DFN,DIK="^PS(55,",DIK(1)=.01 D EN^DIK
 ;I TYPE W !!,"Converting old orders for ",$P($G(^DPT(DFN,0)),U)," to new format."
 S X1=$P($G(^PS(59.7,1,20)),U,2),X2=-365 I 'X1 D NOW^%DTC S X1=$P(%,".")
 D C^%DTC S PSGDT=X
 ;Convert and Backfill orders in 53.1.
 F STAT="D","DE","N","P","U" S STS=$O(^PS(53.1,"AS",STAT)) F ON=0:0 S ON=$O(^PS(53.1,"AS",STAT,DFN,ON)) Q:'ON  I '$G(^PS(53.1,ON,.2)) D
 .S PSJOI="",ND=$G(^PS(53.1,+ON,.1)),DDRG=+$G(^PS(53.1,ON,1,+$O(^PS(53.1,ON,1,0)),0)) S:DDRG PSJOI=+$G(^PSDRUG(DDRG,2))
 .I 'PSJOI F DDRG=0:0 S DDRG=$O(^PSDRUG("AP",+ND,DDRG)) Q:'DDRG!PSJOI  S PSJOI=+$G(^PSDRUG(DDRG,2)) D
 .; convert pending UD orders that have "I" in 4th piece for TYPE
 .I STAT="P",($P($G(^PS(53.1,ON,0)),"^",4)="I"),(PSJOI) S $P(^PS(53.1,ON,0),"^",4)=$$CNV2(PSJOI)
 .I PSJOI S ^PS(53.1,ON,.2)=PSJOI_U_$P(ND,U,2) W:TYPE "."
 .I PSJOI!($P($G(^PS(53.1,+ON,0)),U,4)="F") D EN1^PSJHL2(DFN,"ZC",ON_"P")
 .; convert order location codes for ^PS(53.1
 .K PSJXX S PSJXX=$G(^PS(53.1,ON,0)) I $L(PSJXX) S $P(PSJXX,"^",25,26)=$$CNV($P(PSJXX,"^",25))_"^"_$$CNV($P(PSJXX,"^",26)) S ^(0)=PSJXX K PSJXX
 ;Convert and Backfill UD orders.
 F STPDT=PSGDT:0 S STPDT=$O(^PS(55,DFN,5,"AUS",STPDT)) Q:'STPDT  F ON=0:0 S ON=$O(^PS(55,DFN,5,"AUS",STPDT,ON)) Q:'ON  I '$G(^PS(55,DFN,5,ON,.2)) D
 .S PSJOI="",ND=$G(^PS(55,DFN,5,+ON,.1)),DDRG=$O(^PS(55,DFN,5,ON,1,0)),XX=+$G(^PS(55,DFN,5,ON,1,+DDRG,0)) S:XX PSJOI=+$G(^PSDRUG(XX,2))
 .I 'PSJOI F DDRG=0:0 S DDRG=$O(^PSDRUG("AP",+ND,DDRG)) Q:'DDRG!PSJOI  S PSJOI=+$G(^PSDRUG(DDRG,2))
 .I PSJOI S ^PS(55,DFN,5,ON,.2)=PSJOI_U_$P(ND,U,2) W:TYPE "." D EN1^PSJHL2(DFN,"ZC",ON_"U")
 .; convert order location codes for Unit Dose orders
 .K PSJXX S PSJXX=$G(^PS(55,DFN,5,ON,0)) I $L(PSJXX) S $P(PSJXX,"^",25,26)=$$CNV($P(PSJXX,"^",25))_"^"_$$CNV($P(PSJXX,"^",26)) S ^(0)=PSJXX K PSJXX
 ;Convert and Backfill IV orders.
 F STPDT=PSGDT:0 S STPDT=$O(^PS(55,DFN,"IV","AIS",STPDT)) Q:'STPDT  F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",STPDT,ON)) Q:'ON  I '$G(^PS(55,DFN,"IV",ON,.2)) D
 .S PSJOI="",ND=$G(^PS(55,DFN,"IV",ON,6)) F ADS="AD","SOL" I 'PSJOI F ON1=0:0 S ON1=$O(^PS(55,DFN,"IV",ON,ADS,ON1))  Q:'ON1!PSJOI  S XX=+$G(^PS(55,DFN,"IV",ON,ADS,ON1,0)) D
 ..S:XX PSJOI=$S(ADS="AD":$P($G(^PS(52.6,XX,0)),U,11),1:$P($G(^PS(52.7,XX,0)),U,11)) I PSJOI  S ^PS(55,DFN,"IV",ON,.2)=PSJOI_U_$P(ND,U,2,3) W:TYPE "."
 .S PSJ200=$P($G(^PS(55,DFN,"IV",ON,2)),U,3) Q:PSJ200=""
 .S X=$O(^VA(200,"B",PSJ200,0)),XX=$O(^VA(200,"B",PSJ200,X))
 .I 'X!XX S ^XTMP("PSJ NEW PERSON",PSJ200,DFN,ON)="" Q
 .S $P(^PS(55,DFN,"IV",ON,2),U,11)=X
 .D EN1^PSJHL2(DFN,"ZC",ON_"V")
 .; convert order location codes for IVs
 .K PSJXX S PSJXX=$G(^PS(55,DFN,"IV",ON,2)) I $L(PSJXX) S $P(PSJXX,"^",5,6)=$$CNV($P(PSJXX,"^",5))_"^"_$$CNV($P(PSJXX,"^",6)) S ^(2)=PSJXX K PSJXX
 ;Delete Unreleased entries after converting.
 F ON=0:0 S ON=$O(^PS(53.1,"AS","U",DFN,ON)) Q:'ON  I $G(^PS(53.1,ON,.2)) S DIK="^PS(53.1,",DA=ON D ^DIK K DIK
 S:$D(^PS(55,DFN,0)) $P(^PS(55,DFN,5.1),U,11)=1
 Q
 ;
NFWS(DFN,ON,PSJPWD)       ; Determine if order is NF or WS
 ;Input: DFN - Patient IEN
 ;        ON - Order #_Order Code
 ;    PSJPWD - IEN of patient's ward
 ; Where Order Code IDs order location ("P":53.1; "U":55.06,1:55.01)
 ;Output: NF flag^WS flag^Self Med^Hosp Supplied Self Med
 N ND
 Q:$S(ON["U":0,1:ON'["P") ""
 ;S PSJPWD="",X=$P($G(^DPT(DFN,.1)),U) I X]"" S PSJPWD=$O(^DIC(42,"B",X,0))
 S PSJ="",PSJREF=$S(ON["P":"^PS(53.1,",1:"^PS(55,"_DFN_",5,")_+ON_","
 F PSJDD=0:0 S PSJDD=$O(@(PSJREF_"1,"_PSJDD_")")) Q:'PSJDD  S ND=$G(^(PSJDD,0)) D CHKDD
 S $P(PSJ,U,3,4)=$P($G(@(PSJREF_"0)")),U,5,6)
 Q PSJ
 ;
CHKDD ; Determine if dispense drug is NF or WS
 ;
 S:$P($G(^PSDRUG(+ND,0)),U,9) $P(PSJ,U)=1
 S:$$WSCHK^PSJO(PSJPWD,+ND) $P(PSJ,U,2)=1
 Q
FIND ;
 F DFN=0:0 S DFN=$O(^PS(55,DFN)) Q:'DFN  D
 .I $O(^PS(55,DFN,5,0))!$O(^PS(55,DFN,"IV",0)) D
 ..I '$P($G(^PS(55,DFN,5.1)),U,11) W !,DFN
 Q
 ;
CNV(PSJM)          ; converts order location codes to just 'U' 'P' and 'V'
 I PSJM="" Q PSJM
 I PSJM["V" Q PSJM
 I PSJM["A"!(PSJM["O") Q ($E(PSJM,1,$L(+PSJM))_"U")
 I PSJM["N"!(PSJM["P") Q ($E(PSJM,1,$L(+PSJM))_"P")
 Q PSJM
CNV2(IEN507)          ; converts pending orders with 3rd piece set to "I"
 ;            is the orderable item marked for IV ?
 I $P($G(^PS(50.7,IEN507,0)),"^",3)=1 Q "I"
 E  Q "U"
 Q
CNIV(DFN)    ;Converts OI on active and pending IV orders for POE
 ;for all patients or a selected patient
 NEW ON,PSGDT,STPDT,START,PSJX
 I $G(DFN) D  Q:PSJX>1
 . S PSJX=$P($G(^PS(55,DFN,5.1)),U,11)
 . Q:PSJX=3
 . I PSJX=2 D MARKIV^PSJUTL3(DFN) Q
 ;I '$D(^XTMP("PSSCONA")),'$D(^XTMP("PSSCONS")) Q
 D NOW^%DTC S START=%
 S X1=DT_".0001",X2=-365
 D C^%DTC S PSGDT=X
 I $G(DFN) D CNIV1(DFN),MARKIV^PSJUTL3(DFN) Q
 NEW DFN
 F DFN=0:0 S DFN=$O(^PS(55,DFN)) Q:'DFN  D CNIV1(DFN),MARKIV^PSJUTL3(DFN)
 D ENIVUD^PSJ0050
 D SEND
 Q
CNIV1(DFN)   ;
 ;I $P($G(^PS(55,DFN,5.1)),U,11)=2 Q
 Q:'$$L^PSSLOCK(DFN,0)
 S $P(^PS(55,DFN,5.1),U,11)=2
 I '$D(^XTMP("PSSCONA")),'$D(^XTMP("PSSCONS")) D UL^PSSLOCK(DFN) Q
 F STPDT=PSGDT:0 S STPDT=$O(^PS(55,DFN,"IV","AIS",STPDT)) Q:'STPDT  D
 . F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",STPDT,ON)) Q:'ON  D IVCHK
 F ON=0:0 S ON=$O(^PS(53.1,"AS","P",DFN,ON)) Q:'ON  D PENDING
 D UL^PSSLOCK(DFN)
 Q
IVCHK ;Match AD/SOL against Xtmp
 NEW PSJAD,PSJCNR,PSJOI,PSJSOL,PSJXAD,PSJXNOI,PSJXSOL
 S PSJOI=+$G(^PS(55,DFN,"IV",ON,.2)) Q:'+PSJOI
 ;
 ;Set local array for AD/SOL from the order
 F PSJAD=0:0 S PSJAD=$O(^PS(55,DFN,"IV",ON,"AD",PSJAD)) Q:'PSJAD  D
 . I $G(^PS(55,DFN,"IV",ON,"AD",PSJAD,0)) S PSJAD(+^(0))=""
 F PSJSOL=0:0 S PSJSOL=$O(^PS(55,DFN,"IV",ON,"SOL",PSJSOL)) Q:'PSJSOL  D
 . I $G(^PS(55,DFN,"IV",ON,"SOL",PSJSOL,0)) S PSJSOL(+^(0))=""
 D MATCH,UPD(ON_"V")
 Q
 ;
MATCH ;If AD/SOL from XTMP matches to AD/SOL within the order, set new OI array
 K PSJXNOI
 F PSJXAD=0:0 S PSJXAD=$O(^XTMP("PSSCONA",+PSJOI,PSJXAD)) Q:'PSJXAD  D
 . I $D(PSJAD(PSJXAD)) S PSJXNOI(+^XTMP("PSSCONA",+PSJOI,PSJXAD))=""
 F PSJXSOL=0:0 S PSJXSOL=$O(^XTMP("PSSCONS",+PSJOI,PSJXSOL)) Q:'PSJXSOL  D
 . I $D(PSJSOL(PSJXSOL)) S PSJXNOI(+^XTMP("PSSCONS",+PSJOI,PSJXSOL))=""
 Q
 ;
UPD(ON) ;Loop thru the new OI array
 NEW PSJCNT S PSJCNT=0
 F X=0:0 S X=$O(PSJXNOI(X)) Q:'X  S PSJCNT=PSJCNT+1
 I PSJCNT=1 D
 . S PSJXNOI=$O(PSJXNOI(0))
 . I +PSJOI=PSJXNOI Q
 . S X=$P($G(^PS(50.7,PSJXNOI,0)),U,4)
 . I X]"",(X'>DT) Q
 . ;/W !,"DFN: ",DFN," ON: ",ON," NEW OI: ",PSJXNOI
 . S:ON["V" $P(^PS(55,DFN,"IV",+ON,.2),U,1)=+PSJXNOI
 . S:ON["P" $P(^PS(53.1,+ON,.2),U,1)=+PSJXNOI
 . D EN1^PSJHL2(DFN,"ZC",ON)
 . D EN^PSJ0050(DFN,+ON,+PSJOI,PSJXNOI)
 Q
PENDING ;Converting Pending IV order with Ad/Sol
 NEW PSJAD,PSJOI,PSJSOL,PSJXNOI
 S X=$P($G(^PS(53.1,ON,0)),U,4) I $S(X="I":0,X="F":0,1:1) Q
 S PSJOI=+$G(^PS(53.1,ON,.2)) Q:'+PSJOI
 ;
 ;If pending has no AD/SOL, and on 1 new OI matched to old OI then update.
 I '$D(^PS(53.1,ON,"AD")),'$D(^PS(53.1,ON,"SOL")) D  Q
 . F X=0:0 S X=$O(^XTMP("PSSCONA",PSJOI,X)) Q:'X  S PSJXNOI(+^(X))=""
 . F X=0:0 S X=$O(^XTMP("PSSCONS",PSJOI,X)) Q:'X  S PSJXNOI(+^(X))=""
 . D UPD(ON_"P")
 ;
 ;Loop thru the pending AD/SOL
 F PSJAD=0:0 S PSJAD=$O(^PS(53.1,ON,"AD",PSJAD)) Q:'PSJAD  D
 . I $G(^PS(53.1,ON,"AD",PSJAD,0)) S PSJAD(+^(0))=""
 F PSJSOL=0:0 S PSJSOL=$O(^PS(55,ON,"SOL",PSJSOL)) Q:'PSJSOL  D
 . I $G(^PS(53.1,ON,"SOL",PSJSOL,0)) S PSJSOL(+^(0))=""
 D MATCH,UPD(ON_"P")
 Q
SEND ;Send mail message
 NEW DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,STOP,LINE
 D NOW^%DTC S STOP=%
 S LINE(1)="The conversion was first started:  "_$$FMTE^XLFDT(START)
 S LINE(2)="It ran to completion:              "_$$FMTE^XLFDT(STOP)
 S XMSUB="Inpatient Meds IV conversion",XMTEXT="LINE("
 S XMDUZ="Inpatient Meds POE"
 S XMY(+DUZ)="" D ^XMD
 Q
INSTLDT() ;Return the date PSJ*5*58 was first installed
 NEW DIC,X,Y
 S X=$O(^XPD(9.7,"B","PSJ*5.0*58",0))
 Q:'+X ""
 S DIC="^XPD(9.7,",DIC(0)="NZ" D ^DIC
 Q $P($G(Y(0)),U,3)
