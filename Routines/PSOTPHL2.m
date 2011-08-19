PSOTPHL2        ;BPFO/EL-Query for patient demographics (ORIG: VAFCQRY1) ;09/10/2003  15:00
 ;;7.0;OUTPATIENT PHARMACY;**146**;DEC 1997
 ;
 ;Reference to $$GETDFNS^MPIF002 supported by IA #3634.
 ;
BLDPID(DFN,CNT,PID,HL,ERR)  ;build PID from File #2
 N VAFCMN,VAFCMMN,SITE,VAFCZN,SSN,SITE,APID,PDOD,HIST,HISTDT,VAFCHMN,LVL,LVL1,NXT,LNGTH,NXTC,COMP,REP,SUBCOMP,LVL2,X,STATE,CITY,CLAIM,HLECH,HLFS,HLQ,X,STATEIEN
 S HLECH=HL("ECH"),HLFS=HL("FS"),HLQ=HL("Q")
 S COMP=$E(HL("ECH"),1)
 S SUBCOMP=$E(HL("ECH"),4)
 S REP=$E(HL("ECH"),2)
 ;get Patient File MPI node
 S VAFCMN=$$MPINODE^MPIFAPI(DFN)
 I +VAFCMN<0 S VAFCMN=""
 S VAFCZN=^DPT(DFN,0)
 S SSN=$P(^DPT(DFN,0),"^",9)
 S SITE=$$SITE^VASITE
 S APID(2)=CNT
 ;repeat patient ID list including ICN (NI),SSN (SS),CLAIM# (PN) AND DFN (PI)
 S APID(4)=""
 ;National Identifier (ICN)
 I $G(VAFCMN)>0,($E($P(VAFCMN,"^"),1,3)'=$P($$SITE^VASITE,"^",3)) D
 .  S APID(4)=$P(VAFCMN,"^")_"V"_$P(VAFCMN,"^",2)_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"HL70363"_COMP_"NI"_COMP_"VA FACILITY ID"_SUBCOMP_$$STA^XUAF4(+SITE)_SUBCOMP_"L"
 I $G(SSN)'="" S APID(4)=APID(4)_$S(APID(4)'="":REP,1:"")_SSN_COMP_COMP_COMP_"USSSA"_SUBCOMP_SUBCOMP_"HL70363"_COMP_"SS"_COMP_"VA FACILITY ID"_SUBCOMP_$$STA^XUAF4(+SITE)_SUBCOMP_"L"
 I $G(DFN)'="" S APID(4)=APID(4)_$S(APID(4)'="":REP,1:"")_DFN_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"HL70363"_COMP_"PI"_COMP_"VA FACILITY ID"_SUBCOMP_$$STA^XUAF4(+SITE)_SUBCOMP_"L" D
 .;CLAIM#
 .I $D(^DPT(DFN,.31)) S CLAIM=$P(^DPT(DFN,.31),"^",3) I +CLAIM>0 S APID(4)=APID(4)_REP_CLAIM_COMP_COMP_COMP_"USVBA"_SUBCOMP_SUBCOMP_"HL70363"_COMP_"PN"_COMP_"VA FACILITY ID"_SUBCOMP_$$STA^XUAF4(+SITE)_SUBCOMP_"L"
 ;
 ;patient name (last^first^middle^suffix^prefix^^"L" for legal)
 S APID(6)=$$HLNAME^XLFNAME($P(VAFCZN,"^"),"",$E(HL("ECH"),1)) I $P(APID(6),$E(HL("ECH"),1),7)'="L" S $P(APID(6),$E(HL("ECH"),1),7)="L"
 ;mother's maiden name  (last^first^middle^suffix^prefix^^"M" for maiden name)
 S APID(7)=HL("Q")
 I $D(^DPT(DFN,.24)) S VAFCMMN=$P(^DPT(DFN,.24),"^",3) D
 . S APID(7)=$$HLNAME^XLFNAME(VAFCMMN,"",$E(HL("ECH"),1)) I APID(7)="" S APID(7)=HL("Q")
 . I $P(APID(7),$E(HL("ECH"),1),7)'="M" S $P(APID(7),$E(HL("ECH"),1),7)="M"
 S APID(8)=$$HLDATE^HLFNC($P(VAFCZN,"^",3))  ;date/time of birth
 S APID(9)=$P(VAFCZN,"^",2)  ;sex
 ;place of birth city and state
ADDR S APID(12)="" D
 . I $D(^DPT(DFN,0)) D
 .. ;address info
 .. S $P(APID(12),COMP)=$$GET1^DIQ(2,DFN_",",.111) I $P(APID(12),COMP)="" S $P(APID(12),COMP)=HL("Q")
 .. N LINE2 S LINE2=$$GET1^DIQ(2,DFN_",",.112) N LINE3 S LINE3=$$GET1^DIQ(2,DFN_",",.113)
 .. S $P(APID(12),COMP,2)=LINE2 I $P(APID(12),COMP,2)="" S $P(APID(12),COMP,2)=HL("Q")
 .. S $P(APID(12),COMP,8)=LINE3 I $P(APID(12),COMP,8)="" S $P(APID(12),COMP,8)=HL("Q")
 .. S $P(APID(12),COMP,3)=$$GET1^DIQ(2,DFN_",",.114) I $P(APID(12),COMP,3)="" S $P(APID(12),COMP,3)=HL("Q")
 .. S STATEIEN=$$GET1^DIQ(2,DFN_",",.115,"I") S STATE=$$GET1^DIQ(5,+STATEIEN_",",1) S $P(APID(12),COMP,4)=$G(STATE) I $P(APID(12),COMP,4)="" S $P(APID(12),COMP,4)=HL("Q")
 .. S $P(APID(12),COMP,5)=$$GET1^DIQ(2,DFN_",",.1112) I $P(APID(12),COMP,5)="" S $P(APID(12),COMP,5)=HL("Q")
 .. S $P(APID(12),COMP,7)="P"
 .. ;place of birth information
 .. S CITY=$$GET1^DIQ(2,DFN_",",.092) D
 ... I $G(CITY)'="" S $P(X,COMP,3)=CITY
 ... I $G(CITY)="" S $P(X,COMP,3)=HL("Q")
 ... S STATEIEN=$$GET1^DIQ(2,DFN_",",.093,"I") S STATE=$$GET1^DIQ(5,+STATEIEN_",",1) D
 .... I $G(STATE)'="" S $P(X,COMP,4)=STATE
 .... I $G(STATE)="" S $P(X,COMP,4)=HL("Q")
 ... S $P(X,COMP,7)="N"
 ... S APID(12)=$G(APID(12))_REP_X
 S APID(13)=$$GET1^DIQ(2,DFN_",",.117) I APID(13)="" S APID(13)=HL("Q")  ;county code
 N PHONEN,HNUM,WNUM S PHONEN=$G(^DPT(DFN,.13)) S HNUM=$P(PHONEN,"^",1),WNUM=$P(PHONEN,"^",2)
 S APID(14)=$$HLPHONE^HLFNC(HNUM)
 S APID(15)=$$HLPHONE^HLFNC(WNUM)
 D DEM^VADPT
 S APID(17)="" I +VADM(10)>0 S X=$P($G(^DIC(11,+VADM(10),0)),"^",3),APID(17)=$S(X="N":"S",X="U":"",X="":HLQ,1:X) ;marital status (DHCP N=HL7 S, U="") ;**477
 S APID(18)="" I +VADM(9)>0 S APID(18)=$P($G(^DIC(13,+VADM(9),0)),"^",4) I APID(18)="" S APID(18)=29  ;religious pref (if blank send 29 (UNKNOWN))
 S APID(30)="" I $D(^DPT(DFN,.35)) S PDOD=$P(^DPT(DFN,.35),"^") S APID(30)=$$HLDATE^HLFNC(PDOD)  ;date of death
 N X F X=6,7,8,9,13,14,15,17,18,30 I APID(X)="" S APID(X)=HL("Q")
 ;list of fields used for backwards compatibility with HDR
 S APID(20)=SSN  ;ssn passed in PID-3
 S APID(24)=CITY_" "_STATE  ;place of birth (not used) use PID-11 with an 'N' instead
 ;list of fields not currently used or supported (# is 1 more than seq)
 S APID(3)=""  ;Patient ID
 S APID(5)=""  ;Alternate Patient Identifier
 S APID(10)=""  ;patient alias
 S APID(11)=""  ;race
 S APID(16)=""  ;primary language
 S APID(19)=""  ;patient account #
 S APID(21)=""  ;drivers lic #
 S APID(22)=""  ;mother's id
 S APID(23)=""  ;ethnic group
 S APID(25)=""
 S APID(26)=""
 S APID(27)=""
 S APID(28)=""
 S APID(29)=""
 S APID(31)=""
 S PID(1)="PID"_HL("FS")
 S LVL=1,X=1 F  S X=$O(APID(X)) Q:'X  D
 . S PID(LVL)=$G(PID(LVL))
 . S NXT=APID(X) D
 .. I '$O(APID(X,0)) S NXT=NXT_HL("FS")
 .. I $L($G(PID(LVL))_NXT)>245 S LNGTH=245-$L(PID(LVL)),PID(LVL)=PID(LVL)_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)),LVL=LVL+1
 .. I $L($G(PID(LVL))_NXT)'>245 S PID(LVL)=$G(PID(LVL))_NXT
 . S LVL2=0 F  S LVL2=$O(APID(X,LVL2)) Q:'LVL2  D
 .. S NXT=APID(X,LVL2) D
 ... I $L($G(PID(LVL))_NXT)>245 S LNGTH=245-$L(PID(LVL)),PID(LVL)=PID(LVL)_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)),LVL=LVL+1
 ... I $L($G(PID(LVL))_NXT)'>245 S PID(LVL)=$G(PID(LVL))_NXT
 ... I '$O(APID(X,LVL2)) S PID(LVL)=PID(LVL)_HL("FS")
 D KVA^VADPT
 Q
