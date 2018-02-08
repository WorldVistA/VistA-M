PSORRPA1 ;AITC/BWF - remote partial prescriptions ;12/12/16 3:21pm
 ;;7.0;OUTPATIENT PHARMACY;**454,475,497**;DEC 1997;Build 25
 ;
 ;External references L,UL, PSOL, and PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^DD(52 supported by DBIA 999
 ; bwf - Modified copy of PSORXPA1
 ; bwf - 2/24/14 adding PAR refill tag for API usage.
 ; VALMSG  - return data for remote facility
 ; RXNUM   - rx number
 ; PFDATE  - Partial Fill Date
 ; MW      - Mail or Window
 ; QTY     - Quantity
 ; DSUPP   - Days Supply
 ; REMARKS - Remarks entered by 'remote' (filling) facility.
 ; PHARM   - Remote pharmacist's name
 ; PHONE   - remote pharmacists phone number
 ; SITE    - remote filling site.
 ;
PAR(VALMSG,RXNUM,PFDATE,MW,QTY,DSUPP,REMARKS,PHARM,PHONE,SITE,RX0,RX2,RXSTA,RPROV,RSIG,RPAR0,ROR1,RX3,RREF0) ;
 N RRXIEN,PSOPAR,ORN,PSOLST,XTMPLOC,PASSLOC,HFSIEN,FULLPTH,HFSDONE,PTHDAT,PTHPIECE,DEL,DELARR,FTGOPEN,FOUND,FTGSTRT,FTGOPEN,STATION,HDRUG
 N PERR,PDIR,PFIL,CSVAL,C,D,E,NEWPFIEN,PFIEN,PFIENS,PSOEXREP,PSOFROM,DINACT,PSOPHDUZ,PSODFDIR,PSOFNAME,PSOZ1,RREFIEN
 S $ETRAP="D ^%ZTER Q"
 S (RRXIEN,RXN)=$O(^PSRX("B",RXNUM,0)),PSOSIEN=$$GET1^DIQ(52,RRXIEN,20,"I")
 I '$$GET1^DIQ(59.7,1,101,"I") D  Q
 .S VALMSG(1)="The OneVA pharmacy flag is turned 'OFF' at this facility."
 .S VALMSG(2)="Unable to process refill/partial fill requests."
 .D PARFAIL(.VALMSG,RRXIEN,PHARM,PHONE,SITE)
 ; PSO*7*497 - trade name block
 I $$GET1^DIQ(52,RRXIEN,6.5,"E")]"" D  Q
 .D PARFAIL(.VALMSG,RRXIEN,PHARM,PHONE,SITE)
 .S VALMSG(1)="This prescription cannot be refilled or partial filled because it has a value"
 .S VALMSG(2)="entered in the Rx trade name field.  Please follow local policy for obtaining"
 .S VALMSG(3)="a new prescription."
 ; PSO*7*497 - end trade name block
 S HDRUG=$$GET1^DIQ(52,RRXIEN,6,"I")
 S DINACT=$$GET1^DIQ(50,HDRUG,100,"I")
 I DINACT>0,DINACT<$$NOW^XLFDT S VALMSG(1)="Drug is inactive for Rx# "_RXNUM_". Cannot process partial fill." D PARFAIL(.VALMSG,RRXIEN,PHARM,PHONE,SITE) Q
 S CSVAL=$$GET1^DIQ(50,HDRUG,3,"E"),CSVAL=$E(CSVAL,1)
 I CSVAL,CSVAL>0,CSVAL<6 D PARFAIL(.VALMSG,RRXIEN,PHARM,PHONE,SITE) S VALMSG(1)="Rx #"_RXNUM_" cannot be partially filled. The associated drug is considered a controlled substance at the host facility." Q
 I $D(^PSRX(RRXIEN,"ADP",PFDATE,RRXIEN)) S VALMSG(1)="A partial fill already exists for "_$$FMTE^XLFDT(PFDATE,"5D")_".",VALMSG(2)="Partial cannot be processed" D PARFAIL(.VALMSG,RRXIEN,PHARM,PHONE,SITE) Q
 S PSOPAR=$G(^PS(59,PSOSIEN,1)),PSOSITE=PSOSIEN
 ; set up PSOLST
 S ORN=1,PSOLST(ORN)=52_U_RRXIEN_U_U
 S PSOPHDUZ=$$GET1^DIQ(52,RRXIEN,23,"I") I 'PSOPHDUZ S PSOPHDUZ=.5
 S PSORPDFN=+$P($G(^PSRX($P(PSOLST(ORN),"^",2),0)),"^",2)
 S DA=$P(PSOLST(ORN),"^",2),RX0=^PSRX(DA,0),J=DA,RX2=$G(^(2)),R3=$G(^(3)) S:'$G(BBFLG) BBRX(1)=""
 N PSORF,PSOTRIC D TRIC^PSORXL1(DA) I PSOTRIC&($$STATUS^PSOBPSUT(DA,PSORF)'["PAYABLE") D  Q
 . S VALMSG(1)="Partial cannot be filled on Tricare non-payable Rx."
 . D PARFAIL(.VALMSG,RRXIEN,PHARM,PHONE,SITE)
 I +$P($G(^PSRX(DA,2)),"^",6)<DT D
 .S:$P($G(^PSRX(DA,"STA")),"^")<12 $P(^PSRX(DA,"STA"),"^")=11
 .S COMM="Medication Expired on "_$E($P(^PSRX(DA,2),"^",6),4,5)_"/"_$E($P(^(2),"^",6),6,7)_"/"_$E($P(^(2),"^",6),2,3)
 .S STAT="SC",PHARMST="ZE" D EN^PSOHLSN1(DA,STAT,PHARMST,COMM) K STAT,PHARMST,COMM,RX0,J,RX2,R3
 I +^PSRX(DA,"STA"),+^("STA")'=5,+^("STA")'=11 D  K DA D ULK Q
 .S C=";"_+^PSRX(DA,"STA")_":",X=$P(^DD(52,100,0),"^",3),E=$F(X,C),D=$P($E(X,E,999),";")   ;IA#999
 .S VALMSG(1)="Prescription is in a "_D_" status."
 .D PARFAIL(.VALMSG,RRXIEN,PHARM,PHONE,SITE)
 I $G(PSXSYS),($O(^PS(52.5,"B",DA,""))) S PSOZ1=$O(^PS(52.5,"B",DA,"")) D
 .I $P($G(^PS(52.5,PSOZ1,0)),"^",7)="Q"!($P($G(^(0)),"^",7)="L") D
 ..S VALMSG(1)="A partial entered for this Rx cannot be suspended."
 ..S VALMSG(2)="A fill for this Rx is already suspended for CMOP transmission."
 ..S VALMSG(3)="You may pull this fill from suspense or enter a partial and print the label."
 ..D PARFAIL(.VALMSG,RRXIEN,PHARM,PHONE,SITE)
CLC S PSOCLC=PSOPHDUZ,PHYS=$P(^PSRX(DA,0),"^",4),DRG=$P(^(0),"^",6)
 I 'PHYS,$O(^PSRX(DA,1,0)) F I=0:0 S I=$O(^PSRX(DA,1,I)) Q:'I  S PHYS=$S($P(^PSRX(DA,1,I,0),"^",17):$P(^PSRX(DA,1,I,0),"^",17),1:PHYS)
 S PSOPRZ=0 I $O(^PSRX(DA,"P",0)) N Z2 F Z2=0:0 S Z2=$O(^PSRX(DA,"P",Z2)) Q:'Z2  S PSOPRZ=Z2
 I $D(RXPR(DA)),'$D(^PSRX(DA,"P",$G(RXPR(DA)))) D RMP^PSOCAN3
 ; bwf - save information into database, just as it would be through ^DIE
 S FDA(52.2,"+1,"_RRXIEN_",",.01)=PFDATE D UPDATE^DIE(,"FDA","NEWPFIEN","PERR") K FDA
 I $D(PERR) M VALMSG=PERR
 S PFIEN=$O(NEWPFIEN(0)),PFIEN=$G(NEWPFIEN(PFIEN))
 ; set Z1 variable as was done in the ^DIE call for later use.
 S Z1=PFIEN
 S PFIENS=PFIEN_","_RRXIEN_","
 ; set PM variable as was done in the ^DIE call for later use.
 I MW="M"!('$P($G(PSOPAR),U,12)) S PM=1
 S FDA(52.2,PFIENS,.02)=MW
 S FDA(52.2,PFIENS,.04)=QTY
 S FDA(52.2,PFIENS,.041)=DSUPP
 ; currently we have no local pharmacist. May need to add entry to file 200 for 'REMOTE,PHARMACIST' or 'PHARMACIST,REMOTE'
 S FDA(52.2,PFIENS,.05)=PSOPHDUZ
 ; can we use DUZ as the clerk code, or will this need another value??
 S FDA(52.2,PFIENS,.07)=PSOPHDUZ
 S FDA(52.2,PFIENS,6)=PHYS
 S FDA(52.2,PFIENS,.08)=$$NOW^XLFDT
 S FDA(52.2,PFIENS,.09)=PSOSITE
 S FDA(52.2,PFIENS,.03)=REMARKS
 ;
 ; setting the partial fill date to the dispense date to match the 
 ; HL7 response
 S FDA(52.2,PFIENS,7.5)=PFDATE
 ;
 S RXPR(RRXIEN)=PFIEN,PSOZZ=1,PRMK=REMARKS
 ; file the rest of the data onto the newly created multiple.
 D FILE^DIE(,"FDA") K FDA
 I Z1,$G(PRMK)]"" D  D:$T(EN^PSOHDR)]"" EN^PSOHDR("PPAR",RXN) K DIE,RXN,RXF
 .D ACT
 .S ZD(RXN)=+^PSRX(RXN,"P",Z1,0),^PSRX(RXN,"TYPE")=Z1,$P(^PSRX(RXN,"P",Z1,0),"^",11)=$P($G(^PSDRUG(DRG,660)),"^",6)
 S:'$D(PSOFROM) PSOFROM="PARTIAL" S BINGCRT=1 ;D:$D(BINGRTE)&($D(DISGROUP)) ^PSOBING1 K BINGRTE,TM,TM1
 ; bwf 8/14/14 - set up needed variables for label printing
 S PSODFN=$P(^PSRX(RRXIEN,0),U,2)
 S PSORX("PSOL",1)=RRXIEN_","
 S PSORX("MAIL/WINDOW")="WINDOW"
 S PSORX("NAME")=$$GET1^DIQ(2,PSODFN,.01)
 S PSORX("QFLG")=0
 S PSORX("METHOD OF PICKUP")=""
 S PSOX=$G(^PS(55,PSODFN,"PS")) I PSOX]"" S PSORX("PATIENT STATUS")=$P($G(^PS(53,PSOX,0)),"^")
 N PPL1
 S PPL1=RRXIEN
 S HFSDONE=0,PTHDAT=""
 S PSODFDIR=$$DEFDIR^%ZISH()
 S PSOFNAME="PSOLBL_"_RXNUM_"_"_PSOSITE_"_"_DT_".DAT"
 S FULLPTH=PSODFDIR_PSOFNAME
 ; bwf 8/14/14 - end setup for label printing.
 ; preserve IO
 D SAVDEV^%ZISUTL("ONEVAHLIO")
 ; delete the file first to ensure there isn't one lingering around
 S DELARR("PSOLBL_"_RXNUM_"_"_PSOSITE_"_"_DT_".DAT")="" S DEL=$$DEL^%ZISH(PSODFDIR,$NA(DELARR))
 S PSOEXREP=1
 ; call out to generate label
 D LABEL^PSORWRAP(RRXIEN,"HFS",PSOSITE,PSOPHDUZ,"",PSOFNAME)
 S XTMPLOC="^XTMP(""PSORLBL"","_HLINSTN_","_+RXNUM_",1,0)"
 S PASSLOC="XTMP(""PSORLBL"","_HLINSTN_","_+RXNUM_")"
 K ^XTMP("PSORLBL",HLINSTN,+RXNUM)
 S ^XTMP("PSORLBL",HLINSTN,+RXNUM,0)=DT_U_$$FMADD^XLFDT(DT,30)
 ; looks like we have to wait a moment before the file shows up.
 S FTGSTRT=$$NOW^XLFDT,(FOUND,FTGOPEN)=0
 N PAR S PAR=0
 F  D  Q:$$NOW^XLFDT>$$FMADD^XLFDT(FTGSTRT,,,,15)!(FOUND)!(FTGOPEN)
 .S FTGOPEN=$$FTG^%ZISH(PSODFDIR,PSOFNAME,XTMPLOC,4)
 .I $O(^XTMP("PSORLBL",HLINSTN,+RXNUM,0)) S FOUND=1
 S DELARR("PSOLBL_"_RXNUM_"_"_PSOSITE_"_"_DT_".DAT")="" S DEL=$$DEL^%ZISH(PSODFDIR,$NA(DELARR))
 ; restore IO
 D USE^%ZISUTL("ONEVAHLIO"),RMDEV^%ZISUTL("ONEVAHLIO")
 D UPDPAR(.VALMSG,RRXIEN,PHARM,PHONE,SITE,PASSLOC)
 S RX0=$G(^PSRX(RRXIEN,0)),RX2=$G(^PSRX(RRXIEN,2)),RX3=$G(^PSRX(RRXIEN,3))
 S RXSTA=$G(^PSRX(RRXIEN,"STA")),RPROV=$$GET1^DIQ(200,$P(RX0,U,4),.01,"E")_U_$$GET1^DIQ(200,$P(RX0,U,16),.01,"E")
 S RSIG=$G(^PSRX(RRXIEN,"SIG"))
 S RPAR0=$G(^PSRX(RRXIEN,"P",PFIEN,0))
 S ROR1=$G(^PSRX(RRXIEN,"OR1"))
 S RREFIEN=$O(^PSRX(RRXIEN,1,"A"),-1)
 I RREFIEN S RREF0=$G(^PSRX(RRXIEN,1,RREFIEN,0))
CLCX D ULK K DR,DIE,DRG,PPL,RXP,IOP,DA,PHYS,PSOPRZ,PSORX,PSOSIEN,PSOSITE,PSOX,PSOZZ,PSXSYS,RXPR,ZD Q
 ;
KILL S DA=Z1,DIK="^PSRX("_RXN_",""P""," D ^DIK S ^PSRX(RXN,"TYPE")=0
 D ULK S VALMSG(1)="No Partial Fill Dispensed" D PARFAIL(.VALMSG,RRXIEN,PHARM,PHONE,SITE) Q
KL K DFN,RFDAT,RLL,%,PRMK,PM,%Y,%X,D0,D1,DA,DI,DIC,DIE,DLAYGO,DQ,DR,I,II,J,JJJ,N,PHYS,PS,PSDATE,RFL,RFL1,RXF,ST,ST0,Z,Z1,X,Y,PDT,PSL,PSNP
 K PSOM,PSOP,PSOD,PSOU,DIK,DUOUT,IFN,RXN,DRG,HRX,I1,PSOCLC,PSOLIST,PSOLST,PSPAR,RXP D KVA^VADPT Q
ACT ;adds activity info for partial rx
 S RXF=0 F I=0:0 S I=$O(^PSRX(RRXIEN,1,I)) Q:'I  S RXF=I S:I>5 RXF=I+1
 S DA=0 F FDA=0:0 S FDA=$O(^PSRX(RRXIEN,"A",FDA)) Q:'FDA  S DA=FDA
 S DA=DA+1,^PSRX(RRXIEN,"A",0)="^52.3DA^"_DA_"^"_DA,^PSRX(RRXIEN,"A",DA,0)=DT_"^"_"P"_"^"_PSOPHDUZ_"^"_RXF_"^"_PRMK
EX K RXF,I,FDA S DA=RXN
 Q
ULK ;
 K PSOMSG,PSOPLCK,PSORPDFN
 Q
PARFAIL(PSOMSG,PSOIEN,RPHARM,RPHONE,RSITE) ;
 S PSOMSG(0)=0_U_$$GET1^DIQ(52,PSOIEN,.01,"I")_U_PSOIEN,$P(PSOMSG(0),U,15)=RPHARM,$P(PSOMSG(0),U,16)=RPHONE,$P(PSOMSG(0),U,17)=RSITE
 Q
UPDPAR(PSOMSG,PSOIEN,RPHARM,RPHONE,RSITE,PASSLOC) ;
 N PARIEN,PARIENS,PARDATA,FIL,RXNUM,RFILLDT,QTY,DSUPP,CLERK,LOGDATE,IDIV,EDIV,DISPDT,NDC,FDA,DNAME,DIEN
 S FIL=52.2
 ; get last partial data node
 S PARIEN=$O(^PSRX(PSOIEN,"P",""),-1)
 S RXNUM=$$GET1^DIQ(52,PSOIEN,.01,"E")
 S DNAME=$$GET1^DIQ(52,PSOIEN,6,"E")
 S DIEN=$$GET1^DIQ(52,PSOIEN,6,"I")
 S PARIENS=PARIEN_","_PSOIEN_","
 ; first, set in the remote pharmacist data
 S FDA(52.2,PARIENS,91)=RSITE
 S FDA(52.2,PARIENS,92)=RPHARM
 S FDA(52.2,PARIENS,93)=RPHONE
 D FILE^DIE(,"FDA","MSG") K FDA,RPHARM,RPHONE,RSITE
 ; now query data and build RET(0) holding accurate information from the refill multiple
 D GETS^DIQ(FIL,PARIENS,"**","IE","PARDATA")
 S RFILLDT=$G(PARDATA(FIL,PARIENS,.01,"I"))
 S QTY=$G(PARDATA(FIL,PARIENS,.04,"I"))
 S DSUPP=$G(PARDATA(FIL,PARIENS,.041,"I"))
 S CLERK=$G(PARDATA(FIL,PARIENS,.07,"E"))
 S LOGDATE=$G(PARDATA(FIL,PARIENS,.08,"I"))
 ; internal division number (IEN to PSO SITE file)
 S IDIV=$G(PARDATA(FIL,PARIENS,.09,"I"))
 S EDIV=$G(PARDATA(FIL,PARIENS,.09,"E"))
 ;
 ; there is nothing in this field.
 ; HL7 is returning refill date in the RXD
 ; but trying to log the blank dispense date from file 52.2 into 52.09
 S DISPDT=$G(PARDATA(FIL,PARIENS,7.5,"I"))
 ;
 S NDC=$G(PARDATA(FIL,PARIENS,1,"E"))
 S RSITE=$G(PARDATA(FIL,PARIENS,91,"I"))
 S RPHARM=$G(PARDATA(FIL,PARIENS,92,"E"))
 S RPHONE=$G(PARDATA(FIL,PARIENS,93,"E"))
 S $P(DAT(1),U,3)=RXNUM,$P(DAT(1),U,4)=RSITE,$P(DAT(1),U,7)=QTY,$P(DAT(1),U,8)=DISPDT,$P(DAT(1),U,9)=DNAME,$P(DAT(1),U,10)=DSUPP,$P(DAT(1),U,11)=RPHARM,$P(DAT(1),U,12)=RFILLDT
 D LOGDATA^PSORWRAP($NA(DAT),"OP",,,PSOIEN)
 S PSOMSG(0)=1_U_RXNUM_U_PSOIEN_U_PARIEN_U_RFILLDT_U_DNAME_U_QTY_U_DSUPP_U_CLERK_U_LOGDATE_U_IDIV_U_EDIV_U_DISPDT_U_NDC_U_RPHARM_U_RPHONE_U_RSITE_U_PASSLOC
 I '$L($G(PSOMSG(1))) S PSOMSG(1)="Partial complete for RX #"_RXNUM_"."
 Q
