BPSJZRP ;BHAM ISC/LJF - HL7 Registration ZRP Message ;3/5/08  10:41
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN(HL,PHIX,ZRP,NPI,NCP) ;
 ; ZRP array contains pharmacy registration info
 N ZRPS,FS,CPS,REP,NDZRO,NDHRS,NDREM,NDREP,NDREP1,NDADD,STATE
 N VAIX1,VAIX2,VAIXLP,VATLE,CNF,MSGCNT,TCH
 ;
 ; Quit if no Pharmacy index provided
 I '$G(PHIX) Q
 ;
 K ZRP S ZRPS=""
 ;
 ; Set HL7 Delimiters - use standard defaults if none provided
 S FS=$G(HL("FS")) I FS="" S FS="|"
 S CPS=$E($G(HL("ECH"))) I CPS="" S CPS="^"
 S REP=$E($G(HL("ECH")),2) I REP="" S REP="~"
 ;
 S NDZRO=$G(^BPS(9002313.56,PHIX,0))
 S NDREM=$G(^BPS(9002313.56,PHIX,"REMIT"))
 S NDREP=$G(^BPS(9002313.56,PHIX,"REP"))
 S NDREP1=$G(^BPS(9002313.56,PHIX,"REP1"))
 S NDADD=$G(^BPS(9002313.56,PHIX,"ADDR"))
 ;
 F ZRP=1:1:17 S ZRP(ZRP)="" ;Initialize
 S (ZRP(2),NCP)=$P(NDZRO,U,2)     ;NCPDP #
 S ZRP(3)=$P(NDZRO,U)       ;NAME
 S ZRP(4)=$P(NDZRO,U,3)     ;DEFAULT DEA #
 ;
 I $L($P(NDADD,U,8)) S $P(ZRPS,CPS,1)=$P(NDADD,U,8)  ;SITE ADDRESS NAME
 I $L($P(NDADD,U,1)) S $P(ZRPS,CPS,1)=$P(ZRPS,CPS,1)_" "_$P(NDADD,U,1)  ;SITE ADDRESS 1
 I $L($P(NDADD,U,2)) S $P(ZRPS,CPS,2)=$P(NDADD,U,2)  ;SITE ADDRESS 2
 I $L($P(NDADD,U,3)) S $P(ZRPS,CPS,3)=$P(NDADD,U,3)  ;CITY
 I $L($P(NDADD,U,4)) S STATE=$P(NDADD,U,4) I STATE D  ; State
 . S STATE=$P($G(^DIC(5,STATE,0)),U,2)
 . I STATE]"" S $P(ZRPS,CPS,4)=STATE
 I $L($P(NDADD,U,5)) S $P(ZRPS,CPS,5)=$P(NDADD,U,5)  ;ZIP
 I ZRPS]"" S ZRP(6)=ZRPS,ZRPS=""
 ;
 I $L($P(NDREM,U,1)) S $P(ZRPS,CPS,1)=$P(NDREM,U,1)   ;REMITTANCE ADDRESS NAME
 I $L($P(NDREM,U,2)) S $P(ZRPS,CPS,1)=$P(ZRPS,CPS,1)_" "_$P(NDREM,U,2)  ;REMIT ADDRESS LINE 1
 I $L($P(NDREM,U,3)) S $P(ZRPS,CPS,2)=$P(NDREM,U,3)   ;REMIT ADDRESS LINE 2
 I $L($P(NDREM,U,6)) S $P(ZRPS,CPS,3)=$P(NDREM,U,6)   ;CITY
 I $L($P(NDREM,U,7)) S STATE=$P(NDREM,U,7) I STATE D  ;State
 . S STATE=$P($G(^DIC(5,STATE,0)),U,2)
 . I STATE]"" S $P(ZRPS,CPS,4)=STATE
 I $L($P(NDREM,U,8)) S $P(ZRPS,CPS,5)=$P(NDREM,U,8)  ;ZIP
 I ZRPS]"" S ZRP(7)=ZRPS,ZRPS=""
 ;
 ; Load the Name and Means Fields
 S VAIX1=$P(NDREP,U,3)
 S VAIX2=$P(NDREP,U,4)
 S VAIXLP=$P(NDREP,U,5)
 ;
 ; Contact
 I $G(VAIX1) S VATLE="" D
 . S CNF=$$VA200NM^BPSJUTL(VAIX1,.VATLE,.HL) I CNF]"" S ZRP(8)=CNF
 . I VATLE]"" S ZRP(9)=VATLE
 . S CNF=$$VA20013^BPSJUTL(VAIX1,.HL) I CNF]"" S ZRP(10)=CNF
 ;
 ; Alternate Contact
 I $G(VAIX2) S VATLE="" D
 . S CNF=$$VA200NM^BPSJUTL(VAIX2,.VATLE,.HL) I CNF]"" S ZRP(11)=CNF
 . I VATLE]"" S ZRP(12)=VATLE
 . S CNF=$$VA20013^BPSJUTL(VAIX2,.HL) I CNF]"" S ZRP(13)=CNF
 ;
 ; Lead Pharmacist
 I $G(VAIXLP) S VATLE="" D
 . S CNF=$$VA200NM^BPSJUTL(VAIXLP,.VATLE,.HL) I CNF]"" S ZRP(14)=CNF
 . I VATLE]"" S ZRP(15)=VATLE
 ;
 ; Pharmacist's License
 I $L($P(NDREP1,U)) S ZRP(16)=$P(NDREP1,U)
 ;
 ; NPI
 S ZRP(17)=$G(NPI)
 ;
 ; Encode special chars. Add Field separators.
 S TCH("\")="\E\",TCH("&")="\T\",TCH("|")="\F\"
 S (ZRPS(5),ZRPS(10),ZRPS(13))=1  ;Fields with HL7 repetion chars
 F ZRP=17:-1:1 D  S ZRP(ZRP)=$$ENCODE^BPSJUTL(ZRP(ZRP),.TCH)_FS
 . I $G(ZRPS(ZRP)) K TCH("~")  ; don't convert repetion chars
 . E  S TCH("~")="\R\"         ; ok to convert repetion chars
 S ZRP="ZRP|"
 ;
 Q
 ;
