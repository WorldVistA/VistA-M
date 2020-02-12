IVMPREC8 ;ALB/KCL,BRM,PJR,CKN,TDM,PWC,LBD,DPR,KUM - PROCESS INCOMING (Z05 EVENT TYPE) HL7 MESSAGES (CON'T) ;02 SEPT 2019  8:56 AM
 ;;2.0;INCOME VERIFICATION MATCH;**5,6,12,58,73,79,102,115,121,148,151,152,168,167,171,164,188**;21-OCT-94;Build 12
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is called from IVMPREC6.
 ; This routine will process batch ORU demographic (event type Z05) HL7
 ; messages received from the IVM center.
 ;
PID ;-compare PID fields with DHCP fields
 N COMPPH1,COMPPH2,COUNTRY
 ;
 S IVMFLD=""
 ; - strip off seg name
 S IVMPIECE=$E(IVMXREF,4,9)
 ;Only process if value exist-also handles multiple addr
 I $G(IVMPID(+$E(IVMPIECE,1,2)))'=""!($O(IVMPID(+$E(IVMPIECE,1,2),""))) D
 .;
 .; -if PID field is the addr field-parse addr
 .S IVMADFLG=0
 .I IVMXREF["PID11",'$G(DODSEG) D  Q:IVMFLD=""
 ..;
 ..;-Process Place of Birth City&State
 ..;I (IVMXREF="PID113N")!(IVMXREF="PID114N") D  Q
 ..;.Q:'$D(ADDRESS("N"))
 ..;.S IVMADDR=ADDRESS("N")
 ..;.S IVMPIECE=$E(IVMPIECE,3,4),IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE)
 ..;.Q:IVMFLD=""
 ..;.I IVMPIECE="4N" S (IVMSTPTR,IVMFLD)=+$O(^DIC(5,"C",IVMFLD,0))
 ..; IVM*2.0*164-Uncomment Conf and Add Res
 ..I $G(AUPFARY(IVMDEMDA))="CA" S IVMADDR=$G(ADDRESS("CA")) ;Conf Addr
 ..I $G(AUPFARY(IVMDEMDA))'="CA" D
 ...S IVMADDR=$S($D(ADDRESS("P")):ADDRESS("P"),$D(ADDRESS("VAB1")):ADDRESS("VAB1"),$D(ADDRESS("VAB2")):ADDRESS("VAB2"),$D(ADDRESS("VAB3")):ADDRESS("VAB3"),$D(ADDRESS("VAB4")):ADDRESS("VAB4"),1:"")
 ...I $G(AUPFARY(IVMDEMDA))="RA" S IVMADDR=$G(ADDRESS("R"))
 ..I IVMADDR="" Q
 ..S COUNTRY=$P(IVMADDR,$E(HLECH),6)
 ..S FORADDR=$S(COUNTRY="USA":0,1:1)
 ..;-get piece of addr field, and set IVMFLD
 ..S IVMPIECE=$E(IVMPIECE,3,6),IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE)
 ..;Enable del of Addr2,Addr3-164-Fix End dt
 ..I (IVMPIECE="2C")!(IVMPIECE="8C")!(IVMPIECE="2R")!(IVMPIECE="8R") S:IVMFLD="" IVMFLD="@"
 ..I $E(IVMPIECE,1,3)="13C" D
 ...S IVMFLD=$P(IVMADDR,$E(HLECH),12)
 ...S IVMFLD=$$FMDATE^HLFNC($P(IVMFLD,$E(HLECH,4),2))
 ...S:IVMFLD="" IVMFLD="@"
 ..Q:IVMFLD=""
 ..;convert st abbrev. to pointer
 ..I (IVMPIECE=4)!(IVMPIECE="4C")!(IVMPIECE="4R") D
 ...S IVMFLD=$S('FORADDR:IVMFLD,1:"")
 ...I IVMFLD'="" S (IVMSTPTR,IVMFLD)=+$O(^DIC(5,"C",IVMFLD,0))
 ...;IVM*2.0*164-PMA State Pointer
 ...I IVMPIECE=4 S IVMPMAST=$G(IVMSTPTR)
 ...I IVMPIECE="4C" S IVMCMAST=$G(IVMSTPTR)
 ..I (IVMPIECE=5)!(IVMPIECE="5C")!(IVMPIECE="5R") D
 ...S IVMFLD=$S('FORADDR:IVMFLD,1:"")
 ...I IVMFLD'="" S X=IVMFLD D ZIPIN^VAFADDR S IVMFLD=X
 ..I (IVMPIECE="4F")!(IVMPIECE="4CF")!(IVMPIECE="4RF") S IVMFLD=$S(FORADDR:IVMFLD,1:"") ;PROVINCE
 ..I (IVMPIECE="5F")!(IVMPIECE="5CF")!(IVMPIECE="5RF") S IVMFLD=$S(FORADDR:IVMFLD,1:"") ;POSTAL CODE
 ..I (IVMPIECE=6)!(IVMPIECE="6C")!(IVMPIECE="6R") S IVMFLD=$$CNTRCONV(COUNTRY) ;COUNTRY
 ..I IVMPIECE=7 S IVMFLD=$$BAICONV(IVMFLD) ;Bad Address Indicator
 ..I IVMPIECE="7C" S IVMFLD=CONFADCT  ;CONFADCT set in PID11^IVMPRECA
 ..;County for Conf
 ..I IVMPIECE="9C" D
 ...S IVMFLD=$S('FORADDR:IVMFLD,1:"") Q:IVMFLD=""
 ...I IVMCMAST'="" S IVMFLD=+$O(^DIC(5,IVMCMAST,1,"C",IVMFLD,0))
 ..;County for Res
 ..I IVMPIECE="9R" D
 ...S IVMFLD=$S('FORADDR:IVMFLD,1:"") Q:IVMFLD=""
 ...I IVMSTPTR'="" S IVMFLD=+$O(^DIC(5,IVMSTPTR,1,"C",IVMFLD,0))
 ..I $E(IVMPIECE,1,3)="12C" D
 ...S IVMFLD=$$FMDATE^HLFNC($P(IVMFLD,$E(HLECH,4),1))
 ...;IVM*2.0*164-Allow del of start dt
 ...S:IVMFLD="" IVMFLD="@"
 ..S IVMADFLG=1
 .;
 .I IVMXREF["PID12",'$G(DODSEG) D
 ..;IVM*2.0*164-County from PMA St
 ..;I 'FORADDR S IVMADFLG=1,IVMFLD=+$O(^DIC(5,IVMPMAST,1,"C",IVMPID(12),0))
 ..I 'FORADDR D
 ...S IVMADFLG=1
 ...I IVMPMAST'="" S IVMFLD=+$O(^DIC(5,IVMPMAST,1,"C",IVMPID(12),0))
 .;line remove so that the ph is compared 
 .;before saving to 301.5.
 .I IVMXREF["PID13",$D(TELECOM),'$G(DODSEG) D
 ..;Conf Ph
 ..I IVMXREF="PID13CA",$D(TELECOM("VACPN")) D
 ...S IVMFLD=$$CONVPH($P($G(TELECOM("VACPN")),$E(HLECH))),IVMADFLG=1
 ..;Ph Num [Work]
 ..I IVMXREF="PID13W",$D(TELECOM("WPN")) D
 ...S IVMFLD=$$CONVPH($P($G(TELECOM("WPN")),$E(HLECH))),IVMADFLG=1
 ..;Pager Num
 ..I IVMXREF="PID13B",$D(TELECOM("BPN")) D
 ...S IVMFLD=$$CONVPH($P($G(TELECOM("BPN")),$E(HLECH))),IVMADFLG=1
 ..;Cell Ph Num
 ..I IVMXREF="PID13C",$D(TELECOM("ORN")) D
 ...S IVMFLD=$$CONVPH($P($G(TELECOM("ORN")),$E(HLECH))),IVMADFLG=1
 ..;Email Addr
 ..I IVMXREF="PID13E",$D(TELECOM("NET")) D
 ...S IVMFLD=$P($G(TELECOM("NET")),$E(HLECH),4)
 ...S IVMFLD=$S($$CHKEMAIL(IVMFLD):IVMFLD,1:""),IVMADFLG=1
 .; - file addr fields and quit
 .I IVMADFLG D STORE^IVMPREC9 Q
 .;
 .;I (IVMXREF'="PID113N")&(IVMXREF'="PID114N")&($E(IVMXREF,1,5)'="PID13") S IVMFLD=$G(IVMPID(+IVMPIECE))
 .I $E(IVMXREF,1,5)'="PID13" S IVMFLD=$G(IVMPID(+IVMPIECE))
 .;
 .; -if HL7 date convert to FM date,set IVMFLD
 .I IVMXREF["PID07" S IVMFLD=$$FMDATE^HLFNC(IVMFLD)
 .;
 .; - if HL7 code convert to VistA, set IVMFLD
 .I IVMXREF["PID16" D  ;Marital Status
 ..S IVMFLD=$S(IVMFLD="D":"DIVORCED",IVMFLD="M":"MARRIED",IVMFLD="W":"WIDOWED",IVMFLD="A":"SEPARATED",IVMFLD="S":"NEVER MARRIED",IVMFLD="U":"UNKNOWN")
 ..S IVMFLD=$O(^DIC(11,"B",IVMFLD,0))
 .;
 .I IVMXREF["PID17" S IVMFLD=$O(^DIC(13,"C",IVMFLD,0))  ;Religion
 .;
 .I IVMXREF["PID22" D  ;Ethnicity
 ..S IVMFLD=$$CODE2PTR^DGUTL4($P($G(IVMPID(22)),$E(HLECH),4),2,2)
 .;
 .I IVMXREF="PID10",'$G(DODSEG),$D(IVMRACE) D  Q
 ..N XVAL,IVMLST,DHCPLST
 ..S (XVAL,IVMLST,DHCPLST)=""
 ..F  S XVAL=$O(^DPT(DFN,.02,"B",XVAL)) Q:XVAL=""  S IVMLST=IVMLST_XVAL_U
 ..S XVAL="" F  S XVAL=$O(IVMRACE(2,XVAL)) Q:XVAL=""  S DHCPLST=DHCPLST_XVAL_U
 ..Q:IVMLST=DHCPLST
 ..F XVAL=1:1:($L(DHCPLST,U)-1) S IVMFLD=$P(DHCPLST,U,XVAL) D
 ...D STORE^IVMPREC9
 .;
 .; -call VADPT to return DHCP demographics
 .D DEM^VADPT,ADD^VADPT,OPD^VADPT
 .;
 .; -execute code on the 1 node and get DHCP field for compare
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .;
 .; - special logic for ph
 .; - if different store value received,quit
 .;
 .I IVMXREF="PID13",$D(TELECOM("PRN")),'$G(DODSEG) D  Q
 ..S IVMFLD=$P($G(TELECOM("PRN")),$E(HLECH))
 ..I IVMFLD]"" D
 ...K UPPHN
 ...S COMPPH1=$$CONVPH(IVMFLD),COMPPH2=$$CONVPH(IVMDHCP)
 ...I COMPPH1'=COMPPH2 D STORE^IVMPREC9 S UPPHN=1
 .;
 .; -if field from IVM does not equal DHCP-store for uploading
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 Q
 ;
ZPD ; -compare ZPD with DHCP
 N STFLG
 S STFLG=0
 S IVMPIECE=$E(IVMXREF,4,5)
 I IVMXREF="ZPD09"!(IVMXREF="ZPD31")!(IVMXREF="ZPD32") Q:$$DODCK(DFN)
 I $P(IVMSEG,HLFS,IVMPIECE)]"" D
 .;
 .; - set var to HL7 field
 .S IVMFLD=$P(IVMSEG,HLFS,IVMPIECE)
 .;
 .; - if HL7 name format convert to FM
 .I (IVMXREF["ZPD06")!(IVMXREF["ZPD07") S IVMFLD=$$FMNAME^HLFNC(IVMFLD)
 .;
 .; - if HL7 date convert to FM date
 .I IVMXREF["ZPD09"!(IVMXREF["ZPD13")!(IVMXREF["ZPD32") S IVMFLD=$$FMDATE^HLFNC(IVMFLD)
 .;
 .; - execute code on the 1 node and get DHCP field
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .;
 .; - if field from IVM does not equal DHCP field - store for uploading
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) S STFLG=1 D STORE^IVMPREC9 Q
 .I $P(IVMSEG,"^",IVMPIECE)'="""""" D
 ..I IVMXREF["ZPD09" D STORE^IVMPREC9
 ..;I IVMXREF["ZPD09"!(IVMXREF["ZPD31")!(IVMXREF["ZPD32") D STORE^IVMPREC9
 I IVMXREF["ZPD08",STFLG,$$AUTORINC^IVMPREC9(DFN) Q
 I IVMXREF["ZPD32",$$AUTODOD^IVMLDEMD(DFN)
 Q
 ;
 ;
DODCK(DFN) ;this will check if Date of Death information needs to be uploaded or not.
 ;2 requirements are:
 ;  1. When the DOD is received from ESR with a Source of Death Notification equal to "Death Certificate on file and the
 ;     VistA DOD is null or empty then VistA will upload the Date of Death from ESR
 ;  2. When DOD is Received from ESR and VistA DOD is already populated then Vista will ignore the DOD from ESR and VistA
 ;     will not create an entry in the IVM demographic upload option.
 ;
 ; Inputs: DFN for ^DPT
 ;         IVMXREF (must be ZPD09, ZPD31 and ZPD32)
 ;         IVMSEG (the ZPD data)
 ;         IVMFLD (the field number in ^DPT(DFN)
 ;         IVMPIECE (the piece number of IVMSEG)
 ;         IVMDHCP (the data from ^DPT(DFN)
 ;
 N DODARRAY,QUIT
 ;
 S (CKDEL,QUIT)=0
 ;
 I $P(IVMSEG,"^",9)="""""" Q 0
 D GETS^DIQ(2,DFN,".351:.355","","DODARRAY")
 S DOD=DODARRAY(2,DFN_",",.351)
 I DOD'="" Q 1
 I $P(IVMSEG,"^",31)=3,DOD="" S QUIT=0    ;Death Certificate not on File
 I $P(IVMSEG,"^",31)=3,DOD'="" S QUIT=1
 ;
 Q QUIT ;
 ;
ZTA ; -compare ZTA with DHCP
 N COMPPH1,COMPPH2,COUNTRY
 S IVMPIECE=$E(IVMXREF,4,7)
 I $P(IVMSEG,HLFS,$E(IVMPIECE,1,2))]"" D
 .;
 .; - set var IVMFLD to incoming HL7 field
 .S IVMFLD=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2))
 .;
 .; - ZTA05 as the ZTA addr field is 5 pieces seperated by HLECH (~)
 .I IVMXREF["ZTA05" D
 ..S IVMADDR=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2)) Q:IVMADDR=""
 ..S COUNTRY=$P(IVMADDR,$E(HLECH),6)
 ..S FORADDR=$S(COUNTRY="USA":0,1:1)
 ..; - get piece of address field, and set IVMFLD
 ..S IVMPIECE=$E(IVMPIECE,3,4)
 ..S IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE)
 ..I (IVMPIECE=2)!(IVMPIECE=8) S:IVMFLD="" IVMFLD="@"
 ..Q:IVMFLD=""
 ..I (IVMPIECE=4)!(IVMPIECE=5)!(IVMPIECE=9) S IVMFLD=$S('FORADDR:IVMFLD,1:"") Q:IVMFLD=""
 ..I IVMPIECE=4 S (IVMTSTPT,IVMFLD)=$O(^DIC(5,"C",IVMFLD,0))
 ..I IVMPIECE=5 S X=IVMFLD D ZIPIN^VAFADDR S IVMFLD=$G(X)
 ..I IVMPIECE="4F" S IVMFLD=$S(FORADDR:IVMFLD,1:"")  ;PROVINCE
 ..I IVMPIECE="5F" S IVMFLD=$S(FORADDR:IVMFLD,1:"")  ;POSTAL CODE
 ..I IVMPIECE=6 S IVMFLD=$$CNTRCONV(COUNTRY)         ;COUNTRY
 ..I IVMPIECE=9 S IVMFLD=+$O(^DIC(5,+IVMTSTPT,1,"C",IVMFLD,0))  ;COUNTY
 .Q:IVMFLD=""
 .;
 .; - if HL7 data convert to Y/N val
 .I IVMXREF["ZTA02" S IVMFLD=$S(IVMFLD=0:"N",IVMFLD=1:"Y",1:"")
 .;
 .; - if HL7 date convert to FM date
 .I (IVMXREF["ZTA03")!(IVMXREF["ZTA04")!(IVMXREF["ZTA08") S IVMFLD=$$FMDATE^HLFNC(IVMFLD)
 .;
 .; - execute code on the 1 node and get DHCP field
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .;
 .; -special logic for phone
 .; -if different store value received,quit
 .I IVMXREF["ZTA07" D  Q
 ..S COMPPH1=$$CONVPH(IVMFLD),COMPPH2=$$CONVPH(IVMDHCP)
 ..I COMPPH1'=COMPPH2 D STORE^IVMPREC9
 .;
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 .;
 .I IVMXREF["ZTA08" D
 ..I IVMFLD]"",(IVMFLD>IVMDHCP) S UPDAUPG("TA")=1
 Q
 ;
ZAV ; compare ZAV with DHCP
 N IVMATYP
 S IVMFLD=""
 S IVMATYP=""
 S IVMATYP=$P(IVMSEG,HLFS,2)
 S IVMFLD=$P(IVMSEG,HLFS,3)
 I IVMXREF=$S(IVMATYP="P":"ZAV03",IVMATYP="CNF":"ZAV02",IVMATYP="R":"ZAV01",IVMATYP="C":"ZAV04",1:"") D 
 .; Execute 1 node and get DHCP field
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .; field from IVM is not equal DHCP-store
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 ;
 Q
 ;
ZGD ; - compare ZGD with DHCP
 S IVMADFLG=0
 S IVMPIECE=$E(IVMXREF,4,7)
 I $P(IVMSEG,HLFS,$E(IVMPIECE,1,2))]"" D
 .;
 .; - set var IVMFLD to incoming HL7
 .I 'IVMADFLG S IVMFLD=$P(IVMSEG,HLFS,IVMPIECE)
 .;
 .; - ZGD06 as the ZGD address field is 5 pieces seperated by HLECH (~)
 .I IVMXREF["ZGD06" D
 ..S IVMADDR=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2)),IVMPIECE=$E(IVMPIECE,3)
 ..S IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE),IVMADFLG=1
 ..I IVMFLD]"",IVMPIECE=4 S IVMFLD=$O(^DIC(5,"C",IVMFLD,0))
 ..I IVMFLD]"",IVMPIECE=5 S X=IVMFLD D ZIPIN^VAFADDR S IVMFLD=$G(X)
 .;
 .; - if HL7 date convert to FM date
 .I IVMXREF["ZGD08" S IVMFLD=$$FMDATE^HLFNC(IVMFLD)
 .;
 .; - execute code on the 1 node and get DHCP
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .;
 .; if field from IVM does not equal DHCP-store for uploading
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 Q
 ;
ZCT ; - compare ZCT with DHCP
 N ZCTTYP
 S IVMADFLG=0
 S IVMPIECE=$E(IVMXREF,4,8)
 ;IVM*2.0*188-COMMENT BELOW TO ALLOW QUOTES
 ;S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS)
 S ZCTTYP=$E(IVMPIECE,$L(IVMPIECE)-1,$L(IVMPIECE))
 Q:$P(IVMSEG,HLFS,2)'=$S(ZCTTYP="K1":1,ZCTTYP="K2":2,ZCTTYP="E1":3,ZCTTYP="E2":4,ZCTTYP="D1":5,1:"")
 I $P(IVMSEG,HLFS,$E(IVMPIECE,1,2))]"" D
 .;
 .; -set var IVMFLD to incoming HL7 field
 .I 'IVMADFLG S IVMFLD=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2))
 .;IVM*2.0*188-convert "" to @
 .I IVMFLD="""""" S IVMFLD="@"
 .;
 .; - if HL7 name format convert to FM
 .I IVMXREF["ZCT03" S IVMFLD=$$FMNAME^HLFNC(IVMFLD)
 .;
 .I IVMFLD="@," S IVMFLD="@" ;IVM*2.0*188
 .; - ZCT05 as the ZCT address field is 5 pieces seperated by HLECH (~)
 .I IVMXREF["ZCT05" D
 ..S IVMADDR=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2)),IVMPIECE=$E(IVMPIECE,3)
 ..S IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE),IVMADFLG=1
 ..;IVM*2.0*188-convert "" to @
 ..I IVMFLD="""""" S IVMFLD="@" Q
 ..I IVMFLD]"",IVMPIECE=4 S IVMFLD=$O(^DIC(5,"C",IVMFLD,0))
 ..I IVMFLD]"",IVMPIECE=5 S X=IVMFLD D ZIPIN^VAFADDR S IVMFLD=$G(X)
 .;
 .I IVMADFLG D STORE^IVMPREC9 Q
 .; - if HL7 date convert to FM date
 .I IVMXREF["ZCT10" S IVMFLD=$$FMDATE^HLFNC(IVMFLD)
 .;
 .; - execute code on the 1 node and get DHCP field
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .;
 .;IVM*2.0*188-convert "" to @
 .I IVMFLD="""""" S IVMFLD="@"
 .;
 .; if field from IVM does not equal DHCP-store for upload
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 .;
 .I IVMXREF["ZCT10" D
 ..I IVMFLD]"",(IVMFLD>IVMDHCP) S UPDAUPG(ZCTTYP)=1
 Q
 ;
ZEM ; - compare ZEM with DHCP
 S IVMADFLG=0
 S IVMPIECE=$E(IVMXREF,4,7)
 S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS)
 Q:$P(IVMSEG,HLFS,2)'=$S($E(IVMXREF,$L(IVMXREF))="S":2,1:1)
 I $P(IVMSEG,HLFS,$E(IVMPIECE,1,2))]"" D
 .;
 .; - set var IVMFLD to incoming HL7 field
 .I 'IVMADFLG S IVMFLD=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2))
 .;
 .; - ZEM06 as the ZEM addr containing 5 pieces seperated by HLECH (~)
 .I IVMXREF["ZEM06" D
 ..S IVMADDR=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2)),IVMPIECE=$E(IVMPIECE,3)
 ..S IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE)    ;,IVMADFLG=1
 ..I IVMFLD]"",IVMPIECE=4 S IVMFLD=$O(^DIC(5,"C",IVMFLD,0))
 ..I IVMFLD]"",IVMPIECE=5 S X=IVMFLD D ZIPIN^VAFADDR S IVMFLD=$G(X)
 .;
 .; - if HL7 date convert to FM date
 .I IVMXREF["ZEM09" S IVMFLD=$$FMDATE^HLFNC(IVMFLD)
 .;
 .; - execute code on the 1 node and get DHCP field
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .;
 .; if field from IVM does not equal DHCP-store for uploading
 .I $E(IVMXREF,1,6)="ZEM062",IVMFLD'=IVMDHCP S ZEMADRUP(IVMXREF)=1 D STORE^IVMPREC9 Q
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 Q
 ;
RF1 ; -compare RF1 with DHCP
 S IVMPIECE=$E(IVMXREF,4),IVMADFLG=1,RF1TYPE=$P(IVMSEG,HLFS,3)
 ;Delete the comm data (Email, Cell and Pager) if it is not received in Z05.
 ;Hence, remove it from EPCDEL if Data exist in Z05. Comm. fields contained in EPCDEL will be deleted after updating all incoming data.
 ;IVM*2.0*164-Don't Kill if PHH
 I RF1TYPE'="PHH" K EPCDEL(RF1TYPE)
 ;K EPCDEL(RF1TYPE)
 ;if RF1 field is SEQ6, then parse subcomponents
 I RF1TYPE="SAD",((IVMXREF="RF161")!(IVMXREF="RF162")!(IVMXREF="RF171")) D RF1PROC
 ;IVM*2.0*164-Uncomment Conf and Add Res
 I RF1TYPE="CAD",((IVMXREF="RF161CA")!(IVMXREF="RF162CA")!(IVMXREF="RF171CA")) D RF1PROC
 I RF1TYPE="RAD",((IVMXREF="RF161RA")!(IVMXREF="RF162RA")!(IVMXREF="RF171RA")) D RF1PROC
 ;
 I RF1TYPE="CPH",((IVMXREF="RF161C")!(IVMXREF="RF162C")!(IVMXREF="RF171C")) D RF1PROC
 I RF1TYPE="PNO",((IVMXREF="RF161B")!(IVMXREF="RF162B")!(IVMXREF="RF171B")) D RF1PROC
 I RF1TYPE="EAD",((IVMXREF="RF161E")!(IVMXREF="RF162E")!(IVMXREF="RF171E")) D RF1PROC
 I RF1TYPE="PHH",((IVMXREF="RF161P")!(IVMXREF="RF162P")!(IVMXREF="RF171P")) D RF1PROC     ;Added for IVM*2*152
 ;IVM*2.0*164-LAST RF1 change
 ;I '$$RF1CHK^IVMPREC6(IVMRTN,IVMDA),IVMXREF="RF171P" D
 I '$$RF1CHK^IVMPREC6(IVMRTN,IVMDA),IVMXREF="RF171RA" D  ;Last RF1
 . I $$AUTOEPC^IVMPREC9(DFN,.UPDEPC)
 . N NOUPDT,NOPHUP S (NOUPDT,NOPHUP)=0   ;Added for IVM*2*152
 . I 'UPDEPC("SAD") S NOUPDT=1
 . ;Set the NOPHUP flag = 1 if Home Ph Change Dt/Tm not more recent, or
 . ;if Home Ph Change Dt/Tm more recent, but ph the same
 . ;IVM*2*152
 . ;IVM*2.0*167-Make Home ph auto-upload
 . ;Always keep NOPHUP = 0 so Home ph data is not handled here    
 . ;I 'UPDEPC("PHH") S NOPHUP=1
 . ;I UPDEPC("PHH"),'$G(UPPHN) S NOPHUP=1
 . K UPPHN
 . I $$AUTOADDR^IVMLDEM6(DFN,1,NOUPDT,NOPHUP)
 Q
 ;
RF1PROC ;
 N IVMEPC
 I $P(IVMSEG,HLFS,IVMPIECE)]"" D
 .;if RF1 field is SEQ6, then parse subcomponents
 .I IVMXREF["RF16" D  Q
 ..;- get data containing 4 pieces seperated by HLECH (~)
 ..S IVMRFDAT=$P(IVMSEG,HLFS,6)
 ..S IVMPIECE=$E(IVMXREF,5),IVMFLD=$P(IVMRFDAT,"~",IVMPIECE)
 ..;KUM-164-SET IVMEPC TO NONBLANK 
 ..;S IVMEPC=$E(IVMXREF,6)
 ..S IVMEPC=""
 ..I (IVMXREF="RF162E")!(IVMXREF="RF162C")!(IVMXREF="RF162B")!(IVMXREF="RF162P") S IVMEPC="2"
 ..;Convert Change Source for Address, Email, Cell and Pager
 ..I IVMPIECE=2 S IVMFLD=$S(IVMEPC'="":$$EPCSRCC(IVMFLD),1:$$ADDRCNV(IVMFLD))
 ..Q:IVMFLD=""
 ..D STORE^IVMPREC9
 .I IVMXREF["RF17" D  Q
 ..;get address/telecomm change date/tm field
 ..S IVMFLD=$$FMDATE^HLFNC($P(IVMSEG,HLFS,7))
 ..Q:IVMFLD=""
 ..;
 ..;IVM*2*171 - If RF1 type is PHH,home ph is null in PID (IVMPHDFG)
 ..;and RESIDENCE NUMBER CHANGE DT/TM in Patient rec exists then SET EPCDEL(PHH) for ph num 
 ..;deletion IF incoming num change dt/tm is greater than the change dt/tm in Patient rec
 ..;Check if PID13 home ph is null
 ..S:$P($G(TELECOM("PRN")),"~",1)="" IVMPHDFG=1
 ..I RF1TYPE="PHH",+IVMPHDFG,+$$GET1^DIQ(2,DFN_",",.1321,"I") D
 ...S:+$$GET1^DIQ(2,DFN_",",.1321,"I")<IVMFLD EPCDEL("PHH")=".131^.1321^.1322^.1323"
 ..D STORE^IVMPREC9
 ..;
 ..;164-Uncomment Conf and Add Res
 ..I RF1TYPE="CAD",$P($G(ADDRESS("CA")),HLFS)]"" D  Q
 ...; - execute code on the 1 node and get DHCP field
 ...S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 ...I IVMFLD]"",(IVMFLD>IVMDHCP) S UPDAUPG("CA")=1
 ..;
 ..I RF1TYPE="RAD",$P($G(ADDRESS("R")),HLFS)]"" D  Q
 ...S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 ...I IVMFLD]"",(IVMFLD>IVMDHCP) S UPDAUPG("RA")=1
 ..;
 ..; check for auto-upload
 ..S IVMDHCP=$S(RF1TYPE="SAD":$P($G(^DPT(DFN,.11)),HLFS,13),RF1TYPE="CPH":$P($G(^DPT(DFN,.13)),HLFS,9),RF1TYPE="PNO":$P($G(^DPT(DFN,.13)),HLFS,12),RF1TYPE="EAD":$P($G(^DPT(DFN,.13)),HLFS,6),1:"")
 ..I IVMDHCP="" S IVMDHCP=$S(RF1TYPE="PHH":$P($G(^DPT(DFN,.132)),HLFS,1),RF1TYPE="RAD":$P($G(^DPT(DFN,.115)),HLFS,11),1:"")     ;Added for IVM*2*152
 ..I IVMFLD]"",(IVMFLD>IVMDHCP) D
 ...S UPDEPC(RF1TYPE)=$G(EPCFARY(RF1TYPE))
 ...I RF1TYPE="SAD" S UPDEPC("SAD")=1
 ...; 167-Make Home ph rec auto-upload to Patient
 ...; Keep UPDEPC("PHH") value as Home ph record IENs of #301.92
 ...;I RF1TYPE="PHH" S UPDEPC("PHH")=1 ;IVM*2*152
 Q
ADDRCNV(ADDRSRC) ;convert Addr Source from HL7 to DHCP
 ;
 Q:$G(ADDRSRC)']"" ""
 Q:ADDRSRC="USVAHEC" "HEC"
 Q:ADDRSRC="USVAMC" "VAMC"
 Q:ADDRSRC="USVAHBSC" "HBSC"
 Q:ADDRSRC="USNCOA" "NCOA"
 Q:ADDRSRC="USVABVA" "BVA"
 Q:ADDRSRC="USVAINS" "VAINS"
 Q:ADDRSRC="USPS" "USPS"
 Q:ADDRSRC="LACS" "LACS"
 Q:ADDRSRC="USVOA" "VOA"
 Q:ADDRSRC="VET360" "VET360"
 Q ""
EPCSRCC(EPCSRC) ;Convert Email, Cell, Pager Change Source from HL7 to DHCP
 ;
 Q:$G(EPCSRC)']"" ""
 Q:EPCSRC="USVAHEC" "HEC"
 Q:EPCSRC="USVAMC" "VAMC"
 Q:EPCSRC="USVAHBSC" "HBSC"
 Q:EPCSRC="USVOA" "VOA"
 Q:EPCSRC="VET360" "VET360"
 Q ""
BAICONV(BAISRC) ;Convert Bad addr source from HL7 to DHCP format
 Q:$G(BAISRC)']"" ""
 Q:BAISRC="VAB1" 1
 Q:BAISRC="VAB2" 2
 Q:BAISRC="VAB3" 3
 Q:BAISRC="VAB4" 4
 Q ""
CONVPH(PH) ;remove special chars/spaces from Ph
 ;*168 Check format, quit if OK else strip and return if not 10 num
 ;Format if 10 numeric.
 Q:PH?1"(".3N.1")".3N.1"-".4N PH
 S PH=$TR(PH," )(/#\-","")
 Q:PH'?10N PH
 Q "("_$E(PH,1,3)_")"_$E(PH,4,6)_"-"_$E(PH,7,10)
 ;
CNTRCONV(COUNTRY) ;Check if valid country
 I COUNTRY="" Q 0
 Q $O(^HL(779.004,"B",COUNTRY,""))
CHKEMAIL(EMAIL) ;Check for Valid Email
 I $G(EMAIL)="" Q 0
 I '(EMAIL?1.E1"@"1.E1"."1.E) Q 0
 Q 1
