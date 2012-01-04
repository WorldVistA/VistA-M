RAHLR1 ;HISC/GJC - Generate Common Order (ORM) Message ;11/10/99  10:42
 ;;5.0;Radiology/Nuclear Medicine;**47**;Mar 16, 1998;Build 21
 ;Generates msg whenever a case is registered or cancelled or examined
 ;              registered   cancelled   examined   complete
 ; Order control : NW            CA         XO         XO
 ; Order status  : IP            CA         IP         CM
 ;
 ;Integration Agreements
 ;----------------------
 ;$$GET1^DIQ(10060); NPFON^MAG7UFO(5021); $$FMTHL7^XLFDT(10103)
 ;$$HLNAME^XLFNAME(3065); $$NS^XUAF4(2171); $$KSP^XUPARAM(2541)
 ;
 ;IA: 767 global read on ^DGSL(38.1,D0,0)
 ;IA: 10039 global read on ^DIC(42,D0,44)
 ;IA: 10040 global read on ^SC(D0
 ;
EN(RADFN,RADTI,RACNI,RAEID) ;Called from RA REG*, RA EXAMINED*, & RA CANCEL*
 ;event driver protocols whose HL7 version exceeds version 2.3.
 ;
 ; Input Variables (from RAHLR):
 ;  RADFN=file 2 IEN (DFN)
 ;  RADTI=file 70 Exam subrec IEN (inverse date/time of exam)
 ;  RACNI=file 70 Case subrecord IEN
 ;  RAEID=ien of the event driver protocol (defined in RAHLRPC)
 ;  RACN0=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)
 ; Output variables:
 ;  HLA("HLS", array containing HL7 msg
 ;
 N RAPID,RAPV1,RAORC,RAOBR,RAOBX,RAX,X,XX,I,I1,I2,I3,II
 ;initialize Rad/Nuc Med specific variables
 D:'$D(HLFS)!'$D(HL) INIT^RAHLRU
 D INIT
 ;RA*5*82 RAEXEDT= Override the EXM conditions if Case edited
 I '$G(RAEXEDT),$G(RAEXMDUN)=1,$P(RAZXAM,U,30)'="" Q  ;last chance to stop exm'd msg if it's already been sent
 ;
PID ;compile the PID segment
 D PID^RAHLRU1(+RADFN)
 ;
PV1 ;compile the PV1 segment determine if the patient is
 ;an inpatient or outpatient by looking at the exam record
 D PV1^RAHLRU1(+RADFN)
 ;
ORC ;build the 'common order segment (ORC) segment
 ;RACANC is the status of the exam 'cancelled'? If ORDER (#3) field in
 ;the EXAMINATION STATUS (#72) file is set to zero, the exam has been
 ;cancelled. If order is set to nine, the exam is complete.
 S RAXAMSTS=$P($G(^RA(72,+$P(RAZXAM,U,3),0)),U,3)
 S RACANC=$S(RAXAMSTS=0:1,1:0),RACOMP=$S(RAXAMSTS=9:1,1:0)
 S RAORC(2)=$S(RACANC:"CA",$G(RAEXMDUN)=1:"XO",1:"NW")
 ; define ORC-2 & ORC-3 to 'site id-mmddyy-case#' ex: 141-041106-6
 ; 9/2008 -- check Site Acc Number division parameter (79,.131) and only
 ; use the long site specific acc num if set to YES, else use old form
 S (RAORC(3),RAORC(4))=RAZDAYCS
 S RAORC(6)=$S(RACANC:"CA",RACOMP:"CM",1:"IP")
 ;
 ;new logic in determining the value of order status (ORC-5)
 ;discovered in the development and testing of p47 on 01/14/2010
 ;Variables:
 ;  RA101Z - defined in RAHLRPC
 ;   RAOPT - array set/killed in the entry/exit actions in options:
 ;- [RA HL7 MESSAGE RESEND]
 ;- [RA HL7 RESEND BY DATE RANGE]
 ;  these two options may impact the definition of ORC-5
 I $E($O(RAOPT("")),1,6)="RESEND",($E($G(RA101Z),1,6)="RA REG") S RAORC(6)="IP"
 ;Executing the RA REG* event driver(s) should send an order control (ORC-1)
 ;value of 'NW' & an order status value of 'IP' when the aforementioned options
 ;are exercised.
 ;
 ;Quantity/Timing ORC-7.4 SCHEDULED DATE (TIME optional) 75.1;23
 ;Priority ORC-7.6 REQUEST URGENCY of order 75.1;6
 S RAORC(8)=$$REPEAT^RAHLRU1($E(HLECH,1),3)_$$FMTHL7^XLFDT($P(RAZORD,U,23))_$$REPEAT^RAHLRU1($E(HLECH,1),2)_$S($P(RAZORD,U,6)=1:"S",$P(RAZORD,U,6)=2:"A",1:"R")
 ;Parent ORC-8 MEMBER OF SET (70.03;25); PURGED DATE (70.03,40)
 S RAORC(9)=$$PARENT(RAPURGE,$P(RAZXAM,U,25))
 ;Note: ORC-8 & OBR-29 share the same value
 ;
 ;S RAORC(10)=$$FMTHL7^XLFDT($P(RAZORD,U,16)) ;transaction d/t (order)
 S RAORC(10)=$$FMTHL7^XLFDT($P(RAZRXAM,U)) ;transaction d/t (exam d/t registered)
 ;
 ;Entered By ORC-10 (USER ENTERING REQUEST) 75.1;15
 I $P(RAZORD,U,15),($$GET1^DIQ(200,$P(RAZORD,U,15),.01)'="") D
 .S RAZNME("FILE")=200,RAZNME("IENS")=$P(RAZORD,U,15)
 .S RAZNME("FIELD")=.01
 .S RAORC(11)=$P(RAZORD,U,15)_$E(HLECH)_$$HLNAME^XLFNAME(.RAZNME,"S",$E($G(HLECH)))
 .Q
 ;Ordering Provider ORC-12 (REQUESTING PHYSICIAN) 75.1;14
 I $P(RAZORD,U,14),($$GET1^DIQ(200,$P(RAZORD,U,14),.01)'="") D
 .K RAZNME S RAZNME("FILE")=200,RAZNME("IENS")=$P(RAZORD,U,14)
 .S RAZNME("FIELD")=.01
 .S RAORC(13)=$P(RAZORD,U,14)_$E(HLECH)_$$HLNAME^XLFNAME(.RAZNME,"S",$E($G(HLECH)))
 .Q
 ;Enterer's Location ORC-13 (USER ENTERING REQUEST)
 S RASERSEC=$$ESCAPE^RAHLRU($$GET1^DIQ(200,$P(RAZORD,U,15),29))
 S RAORC(14)=RASERSEC ;SERVICE/SECTION
 ;
 ;Call Back Phone numbers of Ordering Provider ORC-14
 D
 .N RAX,I,M S M="",I=0
 .D NPFON^MAG7UFO("RAX",$P(RAZORD,U,14))
 .F  S I=$O(RAX(I)) Q:'I  S M=M_$$ESCAPE^RAHLRU($G(RAX(I,1,1)))_$E(HLECH)_$G(RAX(I,2,1))_$E(HLECH)_$G(RAX(I,3,1))_$E(HLECH,2)
 .S:$L(M) RAORC(15)=$E(M,1,$L(M)-1)
 ;
 ;Enterer's Organization ORC-17 (USER ENTERING REQUEST)
 S RASERSEC(0)=+$$GET1^DIQ(200,$P(RAZORD,U,15),29,"I") ;pointer to 49
 S RASERSEC(1)=$$GET1^DIQ(49,RASERSEC(0),1) ;abbr. of service/section
 S RAORC(18)=RASERSEC(1)_$E(HLECH)_RASERSEC_$E(HLECH)_"VISTA49"
 ;build the ORC segment; set the HLA array
 D BLSEG^RAHLRU1("ORC",.RAORC)
 K RACANC,RACOMP,RASERSEC,RAXAMSTS,RAZNME,RAZPHONE
 ;
 D:$T(EN^RAHLR1A)]"" EN^RAHLR1A ;continue building the OBR, OBX, & ZDS segments
 ;
 ; Broadcast the HL7 message and cleanup the symbol table
 D GENERATE^RAHLRU
 Q
 ;
INIT ;initialize some basic package specific variables
 S:'($D(U)#2) U="^"
 S RAZRXAM=$G(^RADPT(RADFN,"DT",RADTI,0)) ;reg. exam zero node
 S RAZXAM=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ;exam zero node
 S RAPURGE=+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"PURGE"))
 S RAZDTE=9999999.9999-RADTI ;FM internal date/time
 ; Check if SSAN exists for the exam:
 ;     Field:  [^DD(70.03,31,0)=SITE ACCESSION NUMBER^RFI^^0;31]
 ; This check should NOT be dependent on the current state of the
 ; SSAN Switch (ON or OFF), don't build RAZDAYCS on the fly, use the
 ; data stored in the exam (legacy accession number or SSAN)
 ; if SSAN          exists set RAZDAYCS=SSAN
 ; if SSAN does not exist  set RAZDAYCS=legacy accession number 
 I $P(RAZXAM,"^",31)="" S RAZDAYCS=$E(RAZDTE,4,7)_$E(RAZDTE,2,3)_"-"_+RAZXAM ;Legacy Accession Number:  mmddyy-case#
 I $P(RAZXAM,"^",31)'="" S RAZDAYCS=$P(RAZXAM,"^",31) ;SSAN: sss-mmddyy-case#
 ;
 S RAZORD=$G(^RAO(75.1,+$P(RAZXAM,U,11),0)) ;rad/nuc med order zero node
 S RAZORD1=$P($G(^RAO(75.1,+$P(RAZXAM,U,11),.1)),U) ;rad/nuc  reason for study
 S RAZPROC=$G(^RAMIS(71,+$P(RAZXAM,U,2),0)) ;exam specific procedure
 Q
 ;
PARENT(PRGE,PRNT) ;Define fields ORC-8 & OBR-29 known as PARENT
 ; input: PRGE=purge date of the exam (if applicable)
 ;        PRNT=parent/descendant if yes, specify if exam or printset
 ;return: VALUE=ORIGINAL ORDER PURGED if purged, EXAMSET: proc_name
 ;        if examset, PRINTSET: proc_name if printset, or null.
 I PRGE,(PRGE'>DT) S VALUE="ORIGINAL ORDER PURGED"
 I PRNT S VALUE=$S(PRNT=1:"Examset: ",1:"Printset: ")_$P($G(^RAMIS(71,+$P(RAZORD,U,2),0)),U)
 Q $G(VALUE)
 ;
