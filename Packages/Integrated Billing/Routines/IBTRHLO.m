IBTRHLO ;ALB/YMG - Create and send 278 inquiry ;02-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN(IBTRIEN,MSGTYPE) ; entry point
 ; IBTRIEN - ien in file 356.22
 ; MSGTYPE - 1 for 215, 0 or null for 217
 ;
 I +$G(IBTRIEN)'>0 Q  ; not a valid file 356.22 ien
 ;
 N CERT,DFN,ERRMSG,EVNT,HCT,HL,HLECH,HLFS,HLP,HLREP,HLRESLT,GNUM,IBTRHLP,IEN312,IEN36,IEN3553,INPAT,INSNODE0,INSNODE3,MSGOK
 N NODE0,NODE2,NODE4,NODE5,NODE6,NODE7,NODE8,NODE9,NODE10,NODE17,NODE18,NOWDT,PREL,REQCAT,SITEIEN
 ;
 S MSGTYPE=+$G(MSGTYPE)
 S ERRMSG=""
 S SITEIEN=$P($$SITE^VASITE(),U)
 I SITEIEN'>0 S ERRMSG="Invalid IEN for the site in file 4: "_SITEIEN D HLER^IBTRHLO2(IBTRIEN,ERRMSG) Q
 S NODE0=$G(^IBT(356.22,IBTRIEN,0))
 I NODE0="" S ERRMSG="Blank node 0 in file 356.22, IEN: "_IBTRIEN D HLER^IBTRHLO2(IBTRIEN,ERRMSG) Q
 I +$P(NODE0,U,13)>0,'MSGTYPE S ERRMSG="This is a response entry in file 356.22, IEN: "_IBTRIEN D HLER^IBTRHLO2(IBTRIEN,ERRMSG) Q
 S DFN=+$P(NODE0,U,2)
 I DFN'>0 S ERRMSG="Invalid pointer to file 2: "_DFN D HLER^IBTRHLO2(IBTRIEN,ERRMSG) Q
 S IEN312=+$P(NODE0,U,3)
 I IEN312'>0 S ERRMSG="Invalid pointer to sub-file 2.312: "_IEN312 D HLER^IBTRHLO2(IBTRIEN,ERRMSG) Q
 S INSNODE0=$G(^DPT(DFN,.312,IEN312,0)) ; 0-node in file 2.312
 S INSNODE3=$G(^DPT(DFN,.312,IEN312,3)) ; 3-node in file 2.312
 S IEN3553=+$P(INSNODE0,U,18) ; file 355.3 ien
 S IEN36=+$P(INSNODE0,U)
 I IEN36'>0 S ERRMSG="Invalid pointer to file 36: "_IEN36 D HLER^IBTRHLO2(IBTRIEN,ERRMSG) Q
 S GNUM=$S(IEN3553>0:$$GET1^DIQ(355.3,IEN3553_",",.04),1:"") ; group number
 S PREL=$P($G(^DPT(DFN,.312,IEN312,4)),U,3) ; pat. relationship to insured
 ;
 S NODE2=$G(^IBT(356.22,IBTRIEN,2))
 S NODE4=$G(^IBT(356.22,IBTRIEN,4))
 S NODE5=$G(^IBT(356.22,IBTRIEN,5))
 S NODE6=$G(^IBT(356.22,IBTRIEN,6))
 S NODE7=$G(^IBT(356.22,IBTRIEN,7))
 S NODE8=$G(^IBT(356.22,IBTRIEN,8))
 S NODE9=$G(^IBT(356.22,IBTRIEN,9))
 S NODE10=$G(^IBT(356.22,IBTRIEN,10))
 S NODE17=$G(^IBT(356.22,IBTRIEN,17))
 S NODE18=$G(^IBT(356.22,IBTRIEN,18))
 ;
 S REQCAT=$$GET1^DIQ(356.001,+$P(NODE2,U)_",",.01) ; request category
 S CERT=$$GET1^DIQ(356.002,+$P(NODE2,U,2)_",",.01) ; certification type code
 S INPAT=$S($P(NODE0,U,4)="I":1,1:0) ; 1 if inpatient, 0 if outpatient
 ;  Initialize HL7 variables
 K ^TMP("HLS",$J)
 S IBTRHLP="IBTR HCSR OUT"
 D INIT^HLFNC2(IBTRHLP,.HL) ; HL7 init
 S HLFS=HL("FS"),HLECH=$E(HL("ECH"),1),HLREP=$E(HL("ECH"),2),HL("SAF")=$P($$SITE^VASITE,U,2,3),HCT=0
 ; determine event reason code
 I 'MSGTYPE D
 .I REQCAT'="IN" S EVNT="13" Q  ; request category = "HS" (Health Services), "AR" (Admission), or "SC" (Specialty Care) -> event code = 13 (Request)
 .I CERT=3 S EVNT="01" Q  ; request category = "IN" (Individual) and certification type = 3 (Cancel) -> event code = 01 (Cancel)
 .S EVNT=36 ; request category = "IN" (Individual) and certification type '= 3 (other than Cancel) -> event code = 36 (Authority To Deduct)
 .Q
 I MSGTYPE S EVNT="28" ; always 28 for 215 message
 S NOWDT=$$NOW^XLFDT()
 S MSGOK=1
 D EVN
 D IN1 I 'MSGOK D HLER^IBTRHLO2(IBTRIEN,ERRMSG) G ENX  ; failed to create IN1 segment
 D PRD I 'MSGOK D HLER^IBTRHLO2(IBTRIEN,ERRMSG) G ENX  ; failed to create PRD segment
 D CTD,PRD2
 D GT1 I 'MSGOK D HLER^IBTRHLO2(IBTRIEN,ERRMSG) G ENX  ; failed to create GT1 segment
 D PID I 'MSGOK D HLER^IBTRHLO2(IBTRIEN,ERRMSG) G ENX  ; failed to create PID segment
 D G2RPRB,AUT^IBTRHLO1,ZTP,DG1
 I 'MSGTYPE D ZHS^IBTRHLO2,PV1,OBR^IBTRHLO1,G2ORXA^IBTRHLO1,RXE^IBTRHLO1,PRB^IBTRHLO1,PSL^IBTRHLO1,NTE^IBTRHLO2
 D G3OPRD^IBTRHLO1,G5OPRB^IBTRHLO1
 D GENERATE^HLMA(IBTRHLP,"GM",1,.HLRESLT,"",.HLP)
 ; If not successful
 I $P(HLRESLT,U,2)]"" D HLER^IBTRHLO2(IBTRIEN,$P(HLRESLT,U,2,99)) Q
 ; If successful
 D HLSC^IBTRHLO2(IBTRIEN,NOWDT,HLRESLT)
 ;
ENX ;
 K ^TMP("HLS",$J)
 Q
 ;
EVN ; create EVN segment
 N EVN
 S EVN="EVN"_HLFS_HLFS_$$HLDATE^HLFNC(NOWDT)_HLFS_HLFS_EVNT
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=EVN
 Q
 ;
IN1 ; create IN1 segment
 N IDTYPE,IENS,IN1,INSNAME,PAYER,PAYID,PNODE0,RELINFO,TMP
 S PAYID="",IENS=IEN36_","
 S INSNAME=$$GET1^DIQ(36,IENS,.01)
 S PAYER=+$$GET1^DIQ(36,IENS,3.1,"I") ; file 365.12 ien
 I PAYER'>0 S MSGOK=0,ERRMSG="Unable to create IN1 segment - insurance company "_INSNAME_" is not linked to a payer" Q
 ; get payer id from file 36
 S IDTYPE="PI",PAYID=$$GET1^DIQ(36,IENS,7.01)
 ; if no id in file 36, try to get VA national id
 I PAYID="" S PNODE0=$G(^IBE(365.12,PAYER,0)),PAYID=$P(PNODE0,U,2) ; VA national id
 ; if no VA national id either, try to get CMS national id
 I PAYID="" S PAYID=$P(PNODE0,U,3),IDTYPE="XV"
 ; if still no id, bail out
 I PAYID="" S MSGOK=0,ERRMSG="Unable to create IN1 segment - missing payer ID" Q
 S RELINFO=$P(NODE2,U,16)
 S TMP=$$ENCHL7^IBCNEHLQ(INSNAME)
 ; get HPID, relies on patch IB*2.0*519
 S $P(TMP,HLECH,3)=$$HPD^IBCNHUT1(IEN36)
 S IN1="IN1"_HLFS_"1"_HLFS_"PLAN ID"_HLFS_$$ENCHL7^IBCNEHLQ(PAYID)_HLECH_HLECH_HLECH_HLECH_IDTYPE_HLFS_TMP
 S $P(IN1,HLFS,28)=RELINFO
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=IN1
 Q
 ;
PRD ; create PRD segment (X12: NM1, 2010B)
 N ADDR1,ADDR2,PRD,REQDATA
 S REQDATA=$$PRVDATA^IBTRHLO2(SITEIEN,4)
 I $TR(REQDATA,U)="" S MSGOK=0,ERRMSG="Unable to create prd segment - missing name/address data in INSTITUTION file." Q
 S ADDR1=$P(REQDATA,U,2,3),ADDR2=$P(REQDATA,U,4,6)
 S PRD="PRD"_HLFS_HLECH_HLECH_HLECH_"NM1 2010B"_HLFS_$$ENCHL7^IBCNEHLQ($P(REQDATA,U))
 S PRD=PRD_HLFS_$$ENCHL7^IBCNEHLQ($P($$HLADDR^HLFNC(ADDR1,ADDR2),HLECH,1,5))
 S $P(PRD,HLFS,8)=$$ENCHL7^IBCNEHLQ($P(REQDATA,U,7))
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRD
 Q
 ;
CTD ; create CTD segment
 N CTD,COMMSTR,IEN200,NAME,NODE19,QUAL,TMP,VALUE,Z
 S IEN200=+$P(NODE0,U,11) I IEN200'>0 Q
 S NAME=$$GET1^DIQ(200,IEN200_",",.01) I NAME="" Q
 S NODE19=$G(^IBT(356.22,IBTRIEN,19))
 S COMMSTR="" F Z="20^2^19.01","21^3^19.02","22^4^19.03" D
 .S QUAL=$P(NODE19,U,$P(Z,U,2)) I QUAL="" Q
 .S QUAL=$$EXTERNAL^DILFD(356.22,$P(Z,U,3),,QUAL)
 .S VALUE=$G(^IBT(356.22,IBTRIEN,$P(Z,U))) I VALUE="" Q
 .I "^FX^HP^TE^WP^"[(U_QUAL_U) S VALUE=$$NOPUNCT^IBCEF(VALUE,1) ; strip punctuation if phone #
 .S $P(TMP,HLECH,2)=QUAL,$P(TMP,HLECH,8)=$$ENCHL7^IBCNEHLQ(VALUE)
 .S COMMSTR=$S(COMMSTR="":TMP,1:COMMSTR_HLREP_TMP)
 .Q
 S CTD="CTD"_HLFS_"PER 2010B"_HLFS_$$ENCHL7^IBCNEHLQ(NAME)
 S $P(CTD,HLFS,6)=COMMSTR
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=CTD
 Q
 ;
PRD2 ; create PRD segment (X12: PRV, 2010B)
 N PRD,TXNM
 S TXNM=$P($$TAXORG^XUSTAX(SITEIEN),U) I TXNM="" Q
 S PRD="PRD"_HLFS_HLECH_HLECH_HLECH_"PRV 2010B"
 S $P(PRD,HLFS,8)=$$ENCHL7^IBCNEHLQ(TXNM)
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRD
 Q
 ;
GT1 ; create GT1 segment
 N ADDR1,ADDR2,GT1,SID1,SID2,SIDSTR,NAME
 S SID1=$P(INSNODE0,U,2) I SID1=""  S MSGOK=0,ERRMSG="Unable to create GT1 segment - missing primary subscriber ID" Q
 S NAME=$P(INSNODE0,U,17) I NAME="" S MSGOK=0,ERRMSG="Unable to create GT1 segment - missing name of insured" Q
 S SID2=GNUM ; secondary subscriber id is a group number
 S SIDSTR=$$ENCHL7^IBCNEHLQ(SID1) I SID2'="" S SIDSTR=SIDSTR_HLREP_$$ENCHL7^IBCNEHLQ(SID2)_HLECH_HLECH_HLECH_HLECH_"6P"
 S GT1="GT1"_HLFS_"1"_HLFS_SIDSTR_HLFS_$$ENCHL7^IBCNEHLQ($$HLNAME^HLFNC(NAME))_HLFS_HLFS
 I 'MSGTYPE,$P(INSNODE3,U,6)'="",$P(INSNODE3,U,8)'="" D
 .S ADDR1=$P(INSNODE3,U,6,7),ADDR2=$P(INSNODE3,U,8,10)
 .S $P(GT1,HLFS,6)=$$ENCHL7^IBCNEHLQ($P($$HLADDR^HLFNC(ADDR1,ADDR2),HLECH,1,5)) ; subscriber address
 .Q
 S $P(GT1,HLFS,9)=$$HLDATE^HLFNC($P(INSNODE3,U)) ; subscriber dob
 I 'MSGTYPE S $P(GT1,HLFS,10)=$P(INSNODE3,U,12) ; subscriber sex
 I 'MSGTYPE,PREL'="18" S $P(GT1,HLFS,49)=$S(".01.19."[("."_PREL_"."):PREL,1:"G8") ; relationship to insured
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=GT1
 Q
 ;
PID ; create PID segment
 N IDSTR,PID,TMP,VAFSTR
 I PREL="18" Q  ; patient relationship is "self"
 I GNUM="" S MSGOK=0,ERRMSG="Unable to create PID segment - missing group number" Q
 S VAFSTR="7,8,11,"
 S PID=$$EN^VAFHLPID(DFN,VAFSTR)
 S TMP=$P(PID,HLFS,12)
 I $P(TMP,HLECH,2)="""""" S $P(TMP,HLECH,2)="",$P(PID,HLFS,12)=TMP
 S IDSTR=$$ENCHL7^IBCNEHLQ(GNUM),$P(IDSTR,HLECH,4)="EJ"
 S $P(PID,HLFS,4)=IDSTR
 S $P(PID,HLFS,6)=$$ENCHL7^IBCNEHLQ($P(PID,HLFS,6))
 I MSGTYPE S $P(PID,HLFS,9)=""
 S $P(PID,HLFS,12)=$S('MSGTYPE:$$ENCHL7^IBCNEHLQ($P(PID,HLFS,12)),1:"")
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=PID
 Q
 ;
G2RPRB ; create G2R.PRB segment (G2R segment group)
 N PRB,Z
 I CERT="" Q  ; missing certification type code
 S PRB="PRB"_HLFS_"CO"_HLFS_$$HLDATE^HLFNC(DT)_HLFS_CERT_HLFS_"1"_HLFS_"UM 2000E"
 S $P(PRB,HLFS,12)=REQCAT_HLREP_$$GET1^DIQ(365.013,+$P(NODE2,U,3)_",",.01)
 I 'MSGTYPE D
 .S $P(PRB,HLFS,11)=$P(NODE2,U,8)_HLECH_$P(NODE2,U,9)_HLECH_HLECH_$P(NODE2,U,10)
 .S $P(PRB,HLFS,15)=$$GET1^DIQ(356.003,+$P(NODE2,U,14)_",",.01)
 .S $P(PRB,HLFS,19)=$P(NODE2,U,13)
 .S Z=$$GET1^DIQ(356.004,+$P(NODE2,U,15)_",",.01)
 .S $P(Z,HLECH,5)=$$GET1^DIQ(356.005,+$P(NODE2,U,17)_",",.01)
 .S $P(PRB,HLFS,23)=Z
 .Q
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRB
 D G2RPV1
 Q
 ;
G2RPV1 ; create G2R.PV1 segment (G2R segment group)
 N PV1,QUAL,Z
 S QUAL=$P(NODE2,U,4) I QUAL="" Q
 S Z=$S(QUAL="A":$P(NODE2,U,6)_$P(NODE2,U,7),1:$$GET1^DIQ(353.1,+$P(NODE2,U,5)_",",.01))
 S $P(Z,HLECH,6)=QUAL
 S PV1="PV1"_HLFS_HLFS_"U"_HLFS_Z
 I 'MSGTYPE D
 .S $P(PV1,HLFS,11)=$$GET1^DIQ(5,+$P(NODE2,U,11)_",",1)
 .S Z="",$P(Z,HLECH,9)=$$GET1^DIQ(779.004,+$P(NODE2,U,12)_",",.01)
 .S:$P(Z,HLECH,9)'="USA" $P(PV1,HLFS,12)=Z
 .Q
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=PV1
 Q
 ;
ZTP ; create ZTP segments
 N DATA,Z,Z1,ZTP
 S Z=$P(NODE0,U,7) I Z'="" D
 .S Z1="AAH" I INPAT,REQCAT="AR" S Z1="435"
 .S DATA(Z1)=$S(Z["-":$$HLDATE^HLFNC($P($P(Z,"-"),"."))_HLECH_$$HLDATE^HLFNC($P($P(Z,"-",2),".")),1:$$HLDATE^HLFNC($P(Z,"."))) ; admission / appointment date
 .Q
 S Z=$P(NODE2,U,18) I Z'="" S DATA("439")=$$HLDATE^HLFNC($P(Z,".")) ; accident date
 I 'MSGTYPE D
 .S Z=$P(NODE2,U,19) I Z'="" S DATA("484")=$$HLDATE^HLFNC($P(Z,".")) ; last menstrual period date
 .S Z=$P(NODE2,U,20) I Z'="" S DATA("ABC")=$$HLDATE^HLFNC(Z) ; estimated DOB
 .S Z=$P(NODE2,U,21) I Z'="" S DATA("431")=$$HLDATE^HLFNC(Z) ; illness date
 .Q
 ; the following date is for "Admission Review" request category only
 I INPAT,REQCAT="AR" S Z=$P(NODE2,U,22) S:Z'="" DATA("096")=$$HLDATE^HLFNC($P(Z,".")) ; discharge date
 ;
 S Z="" F  S Z=$O(DATA(Z)) Q:Z=""  D
 .S ZTP="ZTP"_HLFS_"1"_HLFS_Z_HLFS_DATA(Z)_HLFS_"DTP 2000E"
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=ZTP
 .Q
 Q
 ;
DG1 ; create DG1 segments
 N DG1,DIAG,NODE0,SEQ,Z
 S (SEQ,Z)=0 F  S Z=$O(^IBT(356.22,IBTRIEN,3,Z)) Q:Z=""!(Z?1.A)  D
 .S NODE0=$G(^IBT(356.22,IBTRIEN,3,Z,0)) I NODE0="" Q  ; 0-node of sub-file 356.223
 .S SEQ=SEQ+1 I SEQ>12 Q  ; only allow up to 12 DG1 segments
 .I MSGTYPE,SEQ>1 Q  ; only allow 1 DG1 segment in 215 message
 .S DIAG=$TR($$EXTERNAL^DILFD(356.223,.02,,$P(NODE0,U,2)),".") I DIAG="" Q  ; invalid diagnosis code
 .S DG1="DG1"_HLFS_SEQ_HLFS_HLFS_$$ENCHL7^IBCNEHLQ(DIAG)_HLFS_HLFS_$S('MSGTYPE:$$HLDATE^HLFNC($P(NODE0,U,3)),1:"")_HLFS_"W"
 .S $P(DG1,HLFS,18)=$$GET1^DIQ(356.006,+$P(NODE0,U)_",",.01)
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=DG1
 .Q
 Q
 ;
PV1 ; create PV1 segments
 N CNDSTR,PC,PV1,Z
 S PV1="PV1"_HLFS_HLFS_HLFS_"CRC 2000E",CNDSTR=""
 I +$P(NODE4,U,10) D  ; at least one ambulance cert. condition exists
 .S CNDSTR=$P(NODE4,U,9)
 .F PC=10:1:14 S Z=+$P(NODE4,U,PC) S:Z CNDSTR=CNDSTR_HLREP_$$GET1^DIQ(356.008,Z_",",.01)
 .S $P(PV1,HLFS,3)="07"
 .S $P(PV1,HLFS,16)=CNDSTR
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PV1
 .Q
 I +$P(NODE5,U,2) D  ; at least one chiropractic cert. condition exists
 .S CNDSTR=$P(NODE5,U)
 .F PC=2:1:6 S Z=+$P(NODE5,U,PC) S:Z CNDSTR=CNDSTR_HLREP_$$GET1^DIQ(356.008,Z_",",.01)
 .S $P(PV1,HLFS,3)="08"
 .S $P(PV1,HLFS,16)=CNDSTR
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PV1
 .Q
 I +$P(NODE5,U,8) D  ; at least one DME cert. condition exists
 .S CNDSTR=$P(NODE5,U,7)
 .F PC=8:1:12 S Z=+$P(NODE5,U,PC) S:Z CNDSTR=CNDSTR_HLREP_$$GET1^DIQ(356.008,Z_",",.01)
 .S $P(PV1,HLFS,3)="09"
 .S $P(PV1,HLFS,16)=CNDSTR
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PV1
 .Q
 I +$P(NODE5,U,14) D  ; at least one oxygen cert. condition exists
 .S CNDSTR=$P(NODE5,U,13)
 .F PC=14:1:18 S Z=+$P(NODE5,U,PC) S:Z CNDSTR=CNDSTR_HLREP_$$GET1^DIQ(356.008,Z_",",.01)
 .S $P(PV1,HLFS,3)="11"
 .S $P(PV1,HLFS,16)=CNDSTR
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PV1
 .Q
 I +$P(NODE6,U,2) D  ; at least one functional limit cert. condition exists
 .S CNDSTR=$P(NODE6,U)
 .F PC=2:1:6 S Z=+$P(NODE6,U,PC) S:Z CNDSTR=CNDSTR_HLREP_$$GET1^DIQ(356.008,Z_",",.01)
 .S $P(PV1,HLFS,3)="75"
 .S $P(PV1,HLFS,16)=CNDSTR
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PV1
 .Q
 I +$P(NODE6,U,8) D  ; at least one activities cert. condition exists
 .S CNDSTR=$P(NODE6,U,7)
 .F PC=8:1:12 S Z=+$P(NODE6,U,PC) S:Z CNDSTR=CNDSTR_HLREP_$$GET1^DIQ(356.008,Z_",",.01)
 .S $P(PV1,HLFS,3)="76"
 .S $P(PV1,HLFS,16)=CNDSTR
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PV1
 .Q
 I +$P(NODE6,U,14) D  ; at least one mental status cert. condition exists
 .S CNDSTR=$P(NODE6,U,13)
 .F PC=14:1:18 S Z=+$P(NODE6,U,PC) S:Z CNDSTR=CNDSTR_HLREP_$$GET1^DIQ(356.008,Z_",",.01)
 .S $P(PV1,HLFS,3)="77"
 .S $P(PV1,HLFS,16)=CNDSTR
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PV1
 .Q
 I INPAT,$TR($P(NODE7,U,1,4),U)'="" D  ; inpatient, admission data exists
 .S PV1="PV1"_HLFS_HLFS_HLFS_"CL1 2000E"_HLFS_$P(NODE7,U)
 .S Z=+$P(NODE7,U,2) S:Z $P(PV1,HLFS,15)=$$GET1^DIQ(356.009,Z_",",.01)
 .S Z=+$P(NODE7,U,3) S:Z $P(PV1,HLFS,37)=$$GET1^DIQ(356.01,Z_",",.01)
 .S Z=+$P(NODE7,U,4) S:Z $P(PV1,HLFS,19)=$$GET1^DIQ(356.011,Z_",",.01)
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PV1
 .Q
 Q
