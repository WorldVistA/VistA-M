PSOHCPRS ;BIR/RTR-Put CHCS message in Pending File and process ;07/02/02
 ;;7.0;OUTPATIENT PHARMACY;**111**;DEC 1997
 ;External reference to ^DG(40.8 supported by DBIA 728
 ;External reference to ^SC( supported by DBIA 2675
 ;
ADD ;Add CHCS message to Outpatient Pending Orders file
 N PSOHQ,PSOHQT,PSOCPEND,PSOHINI,PSOHINLO
 S (PSOHINI,PSOHINLO)=0 D
 .I $G(PSOHY("LOC")) S PSOHINLO=$P($G(^SC(PSOHY("LOC"),0)),"^",4) I PSOHINLO Q
 .I $G(PSOHY("LOC")) S PSOHINI=$P($G(^SC(PSOHY("LOC"),0)),"^",15)
 .I '$G(PSOHINI) S PSOHINI=$O(^DG(40.8,0))
 .S PSOHINLO=+$$SITE^VASITE(PSOHINI)
 I +$G(PSOHINLO)<0 S PSOEXMS="Unable to derive Institution from CLinic." D NAK^PSOHLEXC Q
 K DD,DO,DIC S X=PSOHY("CHNUM"),DIC="^PS(52.41,",DIC(0)="L"
 S:$G(PSOHY("PICK"))="" PSOHY("PICK")="W"
 S DIC("DR")="4////"_$G(PSOHY("ENTER"))_";5////"_PSOHY("PROV")_";6////"_$G(PSOHY("SDT"))_";8////"_PSOHY("ITEM")_";11////"_PSOHY("DRUG")_";12////"_$G(PSOHY("QTY"))_";13////"_$G(PSOHY("REF"))
 D FILE^DICN K DD,DIC,DO I Y<0 S PSOEXMS="Unable to add order to Pending file." D NAK^PSOHLEXC Q
 S PSOCPEND=+Y
 S $P(^PS(52.41,PSOCPEND,0),"^",2)=PSOHY("PAT"),$P(^(0),"^",3)=PSOHY("OCC"),$P(^(0),"^",12)=$G(PSOHY("EDT")),$P(^(0),"^",13)=PSOHY("LOC")
 S $P(^PS(52.41,PSOCPEND,0),"^",14)=$G(PSOHY("PRIOR")),$P(^(0),"^",17)=$G(PSOHY("PICK"))
 S $P(^PS(52.41,PSOCPEND,"EXT"),"^")=PSOHY("CHNUM"),$P(^("EXT"),"^",2)=0,$P(^("EXT"),"^",3)=PSOHY("EXAPP")
 N DA,DIK S DA=PSOCPEND,DIK="^PS(52.41,",DIK(1)="114^C" D EN1^DIK
 I $O(PSOHY("PRCOM",0)) D  I PSOHQT S ^PS(52.41,PSOCPEND,3,0)="^^"_PSOHQT_"^"_PSOHQT_"^"_DT_"^"
 .S PSOHQ="",PSOHQT=0 F  S PSOHQ=$O(PSOHY("PRCOM",PSOHQ)) Q:PSOHQ=""  I $G(PSOHY("PRCOM",PSOHQ))'="" S PSOHQT=PSOHQT+1,^PS(52.41,PSOCPEND,3,PSOHQT,0)=$G(PSOHY("PRCOM",PSOHQ))
 I $O(PSOHY("SIG",0)) D  I PSOHQT S ^PS(52.41,PSOCPEND,"SIG",0)="^52.4124A^"_PSOHQT_"^"_PSOHQT
 .S PSOHQ="",PSOHQT=0 F  S PSOHQ=$O(PSOHY("SIG",PSOHQ)) Q:PSOHQ=""  I $G(PSOHY("SIG",PSOHQ))'="" S PSOHQT=PSOHQT+1,^PS(52.41,PSOCPEND,"SIG",PSOHQT,0)=$G(PSOHY("SIG",PSOHQ))
 S $P(^PS(52.41,PSOCPEND,"INI"),"^")=$G(PSOHINLO)
 ;Cross references not set yet preventing Pharmacy from finishing order
 D EN^PSOHLSNC(PSOCPEND,"SN","IP")
 ;Just set to DC, don't delete because 52.41 entry would be re-used
 ;I '$P($G(^PS(52.41,PSOCPEND,"EXT")),"^",2) S DA=PSOCPEND,DIK="^PS(52.41," D ^DIK K DIK,DA S PSOEXMS="Unable to send CHCS order to CPRS." D NAK^PSOHLEXC Q
 I '$P($G(^PS(52.41,PSOCPEND,"EXT")),"^",2) D  S $P(^PS(52.41,PSOCPEND,0),"^",3)="DC" S PSOEXMS="Unable to send CHCS order to CPRS." D NAK^PSOHLEXC Q
 .;x-ref shouldn't be set, but we'll kill them just in case
 .K ^PS(52.41,"AOR",$P(^PS(52.41,PSOCPEND,0),"^",2),+$P($G(^("INI")),"^"),PSOCPEND),^PS(52.41,"AD",$P(^PS(52.41,PSOCPEND,0),"^",12),+$P($G(^("INI")),"^"),PSOCPEND)
 .K ^PS(52.41,"ACL",+$P(^PS(52.41,PSOCPEND,0),"^",13),$P(^(0),"^",12),PSOCPEND),^PS(52.41,"AQ",+$P($G(^PS(52.41,PSOCPEND,0)),"^",21),PSOCPEND)
 .S $P(^PS(52.41,PSOCPEND,4),"^")="External order, unable to successfully transmit to CPRS."
 ;Successful transmission to CPRS
 S DA=PSOCPEND,DIK="^PS(52.41," D IX^DIK
 Q
SIGS ;
 N PSOHZZZ,PSOHZZZZ
 S PSOHZZZ=1,PSOHZZZZ=""
 F  S PSOHZZZZ=$O(^PS(52.41,ORD,"SIG",PSOHZZZZ)) Q:PSOHZZZZ=""  I $D(^(PSOHZZZZ,0)) S SIG(PSOHZZZ)=$G(^(0)),PSOHZZZ=PSOHZZZ+1
 I $O(PSONEW("SIG",""))'="" S PSOHZZZZ="" F  S PSOHZZZZ=$O(PSONEW("SIG",PSOHZZZZ)) Q:PSOHZZZZ=""  S SIG(PSOHZZZ)=$G(PSONEW("SIG",PSOHZZZZ)),PSOHZZZ=PSOHZZZ+1
 I $O(PSONEW("SIG",""))'="" Q
 I $O(PRC(""))'="" S PSOHZZZZ="" F  S PSOHZZZZ=$O(PRC(PSOHZZZZ)) Q:PSOHZZZZ=""  I $D(PRC(PSOHZZZZ)) S SIG(PSOHZZZ)=$G(PRC(PSOHZZZZ)),PSOHZZZ=PSOHZZZ+1
 Q
