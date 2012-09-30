IVMPREC8 ;ALB/KCL/BRM/PJR/CKN,TDM,PWC - PROCESS INCOMING (Z05 EVENT TYPE) HL7 MESSAGES (CON'T) ; 7/19/11 10:28am
 ;;2.0;INCOME VERIFICATION MATCH;**5,6,12,58,73,79,102,115,121,148,151**;21-OCT-94;Build 10
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is called from IVMPREC6.
 ; This routine will process batch ORU demographic (event type Z05) HL7
 ; messages received from the IVM center.
 ;
 ;
 ;
PID ; - compare PID segment fields with DHCP fields
 N COMPPH1,COMPPH2,COUNTRY
 ;
 S IVMFLD=""
 ; - strip off segment name
 S IVMPIECE=$E(IVMXREF,4,9)
 ;Only process if value exist - also handles multiple address
 I $G(IVMPID(+$E(IVMPIECE,1,2)))'=""!($O(IVMPID(+$E(IVMPIECE,1,2),""))) D
 .;
 .; - if PID field is the address field - parse address
 .S IVMADFLG=0
 .I IVMXREF["PID11",'$G(DODSEG) D  Q:IVMFLD=""
 ..;
 ..; - Process Place of Birth City & State
 ..;I (IVMXREF="PID113N")!(IVMXREF="PID114N") D  Q
 ..;.Q:'$D(ADDRESS("N"))
 ..;.S IVMADDR=ADDRESS("N")
 ..;.S IVMPIECE=$E(IVMPIECE,3,4),IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE)
 ..;.Q:IVMFLD=""
 ..;.I IVMPIECE="4N" S (IVMSTPTR,IVMFLD)=+$O(^DIC(5,"C",IVMFLD,0))
 ..;
 ..; - get PID address field containing 5 pieces seperated by HLECH (~)
 ..;I $G(AUPFARY(IVMDEMDA))="CA" S IVMADDR=$G(ADDRESS("CA")) ;Conf Addr
 ..I $G(AUPFARY(IVMDEMDA))'="CA" D
 ...S IVMADDR=$S($D(ADDRESS("P")):ADDRESS("P"),$D(ADDRESS("VAB1")):ADDRESS("VAB1"),$D(ADDRESS("VAB2")):ADDRESS("VAB2"),$D(ADDRESS("VAB3")):ADDRESS("VAB3"),$D(ADDRESS("VAB4")):ADDRESS("VAB4"),1:"")
 ..I IVMADDR="" Q
 ..S COUNTRY=$P(IVMADDR,$E(HLECH),6)
 ..S FORADDR=$S(COUNTRY="USA":0,1:1)
 ..; - get piece of address field, and set IVMFLD
 ..S IVMPIECE=$E(IVMPIECE,3,6),IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE)
 ..;I (IVMPIECE="2C")!(IVMPIECE="8C") S:IVMFLD="" IVMFLD="@"
 ..Q:IVMFLD=""
 ..; - convert state abbrev. to pointer
 ..I (IVMPIECE=4)!(IVMPIECE="4C") D
 ...S IVMFLD=$S('FORADDR:IVMFLD,1:"")
 ...I IVMFLD'="" S (IVMSTPTR,IVMFLD)=+$O(^DIC(5,"C",IVMFLD,0))
 ..I (IVMPIECE=5)!(IVMPIECE="5C") D
 ...S IVMFLD=$S('FORADDR:IVMFLD,1:"")
 ...I IVMFLD'="" S X=IVMFLD D ZIPIN^VAFADDR S IVMFLD=X
 ..I (IVMPIECE="4F")!(IVMPIECE="4CF") S IVMFLD=$S(FORADDR:IVMFLD,1:"") ;PROVINCE
 ..I (IVMPIECE="5F")!(IVMPIECE="5CF") S IVMFLD=$S(FORADDR:IVMFLD,1:"") ;POSTAL CODE
 ..I (IVMPIECE=6)!(IVMPIECE="6C") S IVMFLD=$$CNTRCONV(COUNTRY) ;COUNTRY
 ..I IVMPIECE=7 S IVMFLD=$$BAICONV(IVMFLD) ;Bad Address Indicator
 ..I IVMPIECE="7C" S IVMFLD=CONFADCT  ;CONFADCT set in PID11^IVMPRECA
 ..I IVMPIECE="9C" D
 ...S IVMFLD=$S('FORADDR:IVMFLD,1:"") Q:IVMFLD=""
 ...S IVMFLD=+$O(^DIC(5,IVMSTPTR,1,"C",IVMFLD,0))  ;CONF ADDR COUNTY
 ..I $E(IVMPIECE,1,3)="12C" S IVMFLD=$$FMDATE^HLFNC($P(IVMFLD,$E(HLECH,4),$E(IVMPIECE,4)))
 ..S IVMADFLG=1
 .;
 .I IVMXREF["PID12",'$G(DODSEG) D
 ..I 'FORADDR S IVMADFLG=1,IVMFLD=+$O(^DIC(5,IVMSTPTR,1,"C",IVMPID(12),0))  ;Process county only if not foreign address
 .; line remove so that the phone number is compared 
 .; before saving to 301.5.
 .I IVMXREF["PID13",$D(TELECOM),'$G(DODSEG) D
 ..;Confidential Phone Number
 ..;I IVMXREF="PID13CA",$D(TELECOM("VACPN")) D
 ..;.S IVMFLD=$$CONVPH($P($G(TELECOM("VACPN")),$E(HLECH))),IVMADFLG=1
 ..;Phone Number [Work]
 ..;I IVMXREF="PID13W",$D(TELECOM("WPN")) D
 ..;.S IVMFLD=$$CONVPH($P($G(TELECOM("WPN")),$E(HLECH))),IVMADFLG=1
 ..;Pager Number
 ..I IVMXREF="PID13B",$D(TELECOM("BPN")) D
 ...S IVMFLD=$$CONVPH($P($G(TELECOM("BPN")),$E(HLECH))),IVMADFLG=1
 ..;Cell Phone Number
 ..I IVMXREF="PID13C",$D(TELECOM("ORN")) D
 ...S IVMFLD=$$CONVPH($P($G(TELECOM("ORN")),$E(HLECH))),IVMADFLG=1
 ..;Email Address
 ..I IVMXREF="PID13E",$D(TELECOM("NET")) D
 ...S IVMFLD=$P($G(TELECOM("NET")),$E(HLECH),4)
 ...S IVMFLD=$S($$CHKEMAIL(IVMFLD):IVMFLD,1:""),IVMADFLG=1
 .; - file address fields and quit
 .I IVMADFLG D STORE^IVMPREC9 Q
 .;
 .; - otherwise, set IVMFLD to field rec'd from IVM
 .;   for comparison with DHCP field
 .;I (IVMXREF'="PID113N")&(IVMXREF'="PID114N")&($E(IVMXREF,1,5)'="PID13") S IVMFLD=$G(IVMPID(+IVMPIECE))
 .I $E(IVMXREF,1,5)'="PID13" S IVMFLD=$G(IVMPID(+IVMPIECE))
 .;
 .; - if HL7 date convert to FM date and set IVMFLD
 .I IVMXREF["PID07" S IVMFLD=$$FMDATE^HLFNC(IVMFLD)
 .;
 .; - if HL7 code convert to VistA and set IVMFLD
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
 .; - call VADPT routine to return DHCP demographics
 .D DEM^VADPT,ADD^VADPT,OPD^VADPT
 .;
 .; - execute code on the 1 node and get DHCP field for comparison
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .;
 .; - special logic for phone number processing
 .; - if different, then store the actual value received, then quit
 .;
 .I IVMXREF="PID13",$D(TELECOM("PRN")),'$G(DODSEG) D  Q
 ..S IVMFLD=$P($G(TELECOM("PRN")),$E(HLECH))
 ..I IVMFLD]"" D
 ...S COMPPH1=$$CONVPH(IVMFLD),COMPPH2=$$CONVPH(IVMDHCP)
 ...I COMPPH1'=COMPPH2 D STORE^IVMPREC9
 .;
 .; - if field from IVM does not equal DHCP field - store for uploading
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 Q
 ;
 ;
ZPD ; - compare ZPD segment fields with DHCP fields
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
ZTA ; - compare ZTA segment fields with DHCP fields
 N COMPPH1,COMPPH2,COUNTRY
 S IVMPIECE=$E(IVMXREF,4,7)
 I $P(IVMSEG,HLFS,$E(IVMPIECE,1,2))]"" D
 .;
 .; - set var IVMFLD to incoming HL7 field
 .S IVMFLD=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2))
 .;
 .; - ZTA05 as the ZTA address field containing 5 pieces seperated by HLECH (~)
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
 .; - if HL7 data convert to Y/N value
 .I IVMXREF["ZTA02" S IVMFLD=$S(IVMFLD=0:"N",IVMFLD=1:"Y",1:"")
 .;
 .; - if HL7 date convert to FM date
 .I (IVMXREF["ZTA03")!(IVMXREF["ZTA04")!(IVMXREF["ZTA08") S IVMFLD=$$FMDATE^HLFNC(IVMFLD)
 .;
 .; - execute code on the 1 node and get DHCP field
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .;
 .; - special logic for phone number processing
 .; - if different, then store the actual value received, then quit
 .I IVMXREF["ZTA07" D  Q
 ..S COMPPH1=$$CONVPH(IVMFLD),COMPPH2=$$CONVPH(IVMDHCP)
 ..I COMPPH1'=COMPPH2 D STORE^IVMPREC9
 .;
 .; if field from IVM does not equal DHCP field - store for uploading
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 .;
 .I IVMXREF["ZTA08" D
 ..I IVMFLD]"",(IVMFLD>IVMDHCP) S UPDAUPG("TA")=1
 Q
 ;
ZGD ; - compare ZGD segment fields with DHCP fields
 S IVMADFLG=0
 S IVMPIECE=$E(IVMXREF,4,7)
 I $P(IVMSEG,HLFS,$E(IVMPIECE,1,2))]"" D
 .;
 .; - set var IVMFLD to incoming HL7 field
 .I 'IVMADFLG S IVMFLD=$P(IVMSEG,HLFS,IVMPIECE)
 .;
 .; - ZGD06 as the ZGD address field containing 5 pieces seperated by HLECH (~)
 .I IVMXREF["ZGD06" D
 ..S IVMADDR=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2)),IVMPIECE=$E(IVMPIECE,3)
 ..S IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE),IVMADFLG=1
 ..I IVMFLD]"",IVMPIECE=4 S IVMFLD=$O(^DIC(5,"C",IVMFLD,0))
 ..I IVMFLD]"",IVMPIECE=5 S X=IVMFLD D ZIPIN^VAFADDR S IVMFLD=$G(X)
 .;
 .; - if HL7 date convert to FM date
 .I IVMXREF["ZGD08" S IVMFLD=$$FMDATE^HLFNC(IVMFLD)
 .;
 .; - execute code on the 1 node and get DHCP field
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .;
 .; if field from IVM does not equal DHCP field - store for uploading
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 Q
 ;
ZCT ; - compare ZCT segment fields with DHCP fields
 N ZCTTYP
 S IVMADFLG=0
 S IVMPIECE=$E(IVMXREF,4,8)
 S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS)
 S ZCTTYP=$E(IVMPIECE,$L(IVMPIECE)-1,$L(IVMPIECE))
 Q:$P(IVMSEG,HLFS,2)'=$S(ZCTTYP="K1":1,ZCTTYP="K2":2,ZCTTYP="E1":3,ZCTTYP="E2":4,ZCTTYP="D1":5,1:"")
 I $P(IVMSEG,HLFS,$E(IVMPIECE,1,2))]"" D
 .;
 .; - set var IVMFLD to incoming HL7 field
 .I 'IVMADFLG S IVMFLD=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2))
 .;
 .; - if HL7 name format convert to FM
 .I IVMXREF["ZCT03" S IVMFLD=$$FMNAME^HLFNC(IVMFLD)
 .;
 .; - ZCT05 as the ZCT address field containing 5 pieces seperated by HLECH (~)
 .I IVMXREF["ZCT05" D
 ..S IVMADDR=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2)),IVMPIECE=$E(IVMPIECE,3)
 ..S IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE),IVMADFLG=1
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
 .; if field from IVM does not equal DHCP field - store for uploading
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 .;
 .I IVMXREF["ZCT10" D
 ..I IVMFLD]"",(IVMFLD>IVMDHCP) S UPDAUPG(ZCTTYP)=1
 Q
 ;
ZEM ; - compare ZEM segment fields with DHCP fields
 S IVMADFLG=0
 S IVMPIECE=$E(IVMXREF,4,7)
 S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS)
 Q:$P(IVMSEG,HLFS,2)'=$S($E(IVMXREF,$L(IVMXREF))="S":2,1:1)
 I $P(IVMSEG,HLFS,$E(IVMPIECE,1,2))]"" D
 .;
 .; - set var IVMFLD to incoming HL7 field
 .I 'IVMADFLG S IVMFLD=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2))
 .;
 .; - ZEM06 as the ZEM address field containing 5 pieces seperated by HLECH (~)
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
 .; if field from IVM does not equal DHCP field - store for uploading
 .I $E(IVMXREF,1,6)="ZEM062",IVMFLD'=IVMDHCP S ZEMADRUP(IVMXREF)=1 D STORE^IVMPREC9 Q
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE^IVMPREC9
 Q
 ;
RF1 ; - compare RF1 segment fields with DHCP fields
 S IVMPIECE=$E(IVMXREF,4),IVMADFLG=1,RF1TYPE=$P(IVMSEG,HLFS,3)
 ;As per requirements, delete the communication data (Email, Cell and Pager) if it is not received in Z05.
 ;Hence, remove it from EPCDEL (deletion array) if Data exist in Z05. Comm. fields contained in EPCDEL will be deleted after updating all incoming communication data.
 K EPCDEL(RF1TYPE)
 ;if RF1 field is SEQ6, then parse subcomponents
 I RF1TYPE="SAD",((IVMXREF="RF161")!(IVMXREF="RF162")!(IVMXREF="RF171")) D RF1PROC
 ;I RF1TYPE="CAD",((IVMXREF="RF161CA")!(IVMXREF="RF171CA")) D RF1PROC
 I RF1TYPE="CPH",((IVMXREF="RF161C")!(IVMXREF="RF162C")!(IVMXREF="RF171C")) D RF1PROC
 I RF1TYPE="PNO",((IVMXREF="RF161B")!(IVMXREF="RF162B")!(IVMXREF="RF171B")) D RF1PROC
 I RF1TYPE="EAD",((IVMXREF="RF161E")!(IVMXREF="RF162E")!(IVMXREF="RF171E")) D RF1PROC
 I '$$RF1CHK^IVMPREC6(IVMRTN,IVMDA),IVMXREF="RF171E" D  ;Last RF1
 . I $$AUTOEPC^IVMPREC9(DFN,.UPDEPC)
 . I 'UPDEPC("SAD") S NOUPDT=1
 . I $$AUTOADDR^IVMLDEM6(DFN,1,NOUPDT)
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
 ..;get 6th character of IVMXREF to determine if value is for Address
 ..;OR Email, Cell and Pager
 ..S IVMEPC=$E(IVMXREF,6)
 ..;Convert Change Source for Address, Email, Cell and Pager
 ..I IVMPIECE=2 S IVMFLD=$S(IVMEPC'="":$$EPCSRCC(IVMFLD),1:$$ADDRCNV(IVMFLD))
 ..Q:IVMFLD=""
 ..D STORE^IVMPREC9
 .I IVMXREF["RF17" D  Q
 ..;get address/telecomm change date/tm field
 ..S IVMFLD=$$FMDATE^HLFNC($P(IVMSEG,HLFS,7))
 ..Q:IVMFLD=""
 ..D STORE^IVMPREC9
 ..;
 ..;I RF1TYPE="CAD",$P($G(ADDRESS("CA")),HLFS)]"" D  Q
 ..;.; - execute code on the 1 node and get DHCP field
 ..;.S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 ..;.I IVMFLD]"",(IVMFLD>IVMDHCP) S UPDAUPG("CA")=1
 ..;
 ..; check for auto-upload
 ..S NOUPDT=0
 ..S IVMDHCP=$S(RF1TYPE="SAD":$P($G(^DPT(DFN,.11)),HLFS,13),RF1TYPE="CPH":$P($G(^DPT(DFN,.13)),HLFS,9),RF1TYPE="PNO":$P($G(^DPT(DFN,.13)),HLFS,12),RF1TYPE="EAD":$P($G(^DPT(DFN,.13)),HLFS,6),1:"")
 ..I IVMFLD]"",(IVMFLD>IVMDHCP) D
 ...S UPDEPC(RF1TYPE)=$G(EPCFARY(RF1TYPE))
 ...I RF1TYPE="SAD" S UPDEPC("SAD")=1
 Q
ADDRCNV(ADDRSRC) ;convert Address Source from HL7 to DHCP format
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
 Q ""
EPCSRCC(EPCSRC) ;Convert Email, Cell, Pager Change Source from HL7 to DHCP
 ;
 Q:$G(EPCSRC)']"" ""
 Q:EPCSRC="USVAHEC" "HEC"
 Q:EPCSRC="USVAMC" "VAMC"
 Q:EPCSRC="USVAHBSC" "HBSC"
 Q ""
BAICONV(BAISRC) ;Convert Bad address source from HL7 to DHCP format
 Q:$G(BAISRC)']"" ""
 Q:BAISRC="VAB1" 1
 Q:BAISRC="VAB2" 2
 Q:BAISRC="VAB3" 3
 Q:BAISRC="VAB4" 4
 Q ""
CONVPH(PH) ;remove special chars/spaces from Phone number
 Q $TR(PH," )(/#\-","")
CNTRCONV(COUNTRY) ;Check if valid country
 I COUNTRY="" Q 0
 Q $O(^HL(779.004,"B",COUNTRY,""))
CHKEMAIL(EMAIL) ;Check for Valid Email
 I $G(EMAIL)="" Q 0
 I '(EMAIL?1.E1"@"1.E1"."1.E) Q 0
 Q 1
