DGHTHL7 ;ALB/JAM - Home Telehealth Patient Sign-up HL7;10 January 2005 ; 9/25/07 10:18am
 ;;5.3;Registration;**644**;Aug 13, 1993;Build 11
 ;
BLDHL7(DGHTH,MSG) ;Build HL7 Registration message for Home Telehealth
 ;Input : DGHTH - Arry with Home Telehealth transaction data
 ;        MSG   - Array to put message into (full global ref)
 ;Output: N  - Last line number used, or
 ;        0  - no message built, or
 ;        -1^ErrorText on error
 ;        MSG will contain HL7 message
 ;Note  : Insertion into MSG begins at next available line number
 ;
 N DFN,VENDOR,CONSULT,COORD,EVENTDT,VALCHK,DGX,ERR,PROTNAME,VAFPID
 N HLFS,HLECH,HLQ,HL,EVN,PID,PD1,PV1,LINE,X,Y
 S ERR=0,X="" F  S X=$O(DGHTH(X)) Q:X=""  D  I ERR Q
 .I DGHTH(X)="" S VALCHK="-1^Bad Input ("_X_")",ERR=1 Q
 .S @X=DGHTH(X)
 I ERR Q $G(VALCHK)
 I $G(MSG)="" Q "-1^Bad input variable (MSG)"
 S PROTNAME="DG HOME TELEHEALTH ADT-A04 SERVER"
 D INIT^HLFNC2(PROTNAME,.HL)
 I ($O(HL(""))="") Q "-1^Unable to initialize HL7 variables"
 S LINE=+$O(@MSG@(""),-1)
 ;
 ;EVN segment
 S EVN=$$EVN("A04","A04",EVENTDT)
 I $P(EVN,U)=-1 K @MSG Q EVN
 S LINE=LINE+1 S @MSG@(LINE)=EVN
 ;
 ;PID segment
 S PID=$$PID(DFN,.HL,.VAFPID)
 I $P(PID,U)=-1 Q PID
 D PIDVAL I ERR Q ERR
 S DGX=$O(VAFPID(0)),LINE=LINE+1 S @MSG@(LINE)=VAFPID(DGX)
 F  S DGX=$O(VAFPID(DGX)) Q:'DGX  D
 .S @MSG@(LINE,DGX-1)=VAFPID(DGX)
 ;
 ;PD1 segment
 S PD1=$$PD1(DFN,COORD)
 I $P(PD1,U)=-1 Q PD1
 S LINE=LINE+1 S @MSG@(LINE)=PD1
 ;
 ;PV1 segment
 S $P(PV1,HLFS,1)=1,$P(PV1,HLFS,5)=CONSULT
 S $P(PV1,HLFS,39)=$$STA^XUAF4(DUZ(2))
 S PV1="PV1"_HLFS_PV1
 S LINE=LINE+1 S @MSG@(LINE)=PV1
 ;
 Q LINE
 ;
EVN(TYPE,FLAG,DGEVDT) ;Build EVN segment
 ;Input:  TYPE   - HL7 event type
 ;        FLAG   - HL7 Event Reason Code
 ;        DGEVDT - Event Date/Time [Optional]
 ;Output: value  - EVN segment
 ;        -1^ErrorText on error
 ;
 N USRNAM,USERID,COMP,SUBCOMP,EVN
 I $G(TYPE)=""!($G(FLAG)="") Q "-1^Value missing to build message (EVN segment)"
 S EVN=$$EVN^VAFHLEVN(TYPE,FLAG,DGEVDT)
 I ($E(EVN,1,3)'="EVN") Q "-1^Error build message (EVN segment)"
 ;Add user and user's facility to EVN segment
 S COMP=$E(HL("ECH"),1),SUBCOMP=$E(HL("ECH"),4)
 S USRNAM=$$HLNAME^HLFNC($$GET1^DIQ(200,DUZ_",",.01),HL("ECH"))
 S USERID=DUZ_COMP_$P(USRNAM,COMP)_COMP_$P(USRNAM,COMP,2)_COMP_COMP_COMP
 S USERID=USERID_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"L"
 S USERID=USERID_COMP_COMP_COMP_"NI"_COMP_"VA FACILITY ID"_SUBCOMP
 S USERID=USERID_$P($$SITE^VASITE,"^",3)_SUBCOMP_"L"
 S $P(EVN,HLFS,6)=USERID,$P(EVN,HLFS,8)=$P($$SITE^VASITE,HLFS,3)
 Q EVN
 ;
PID(DFN,HL,DGPID) ;Build PID segment
 ;Input:  DFN    - Patient DFN
 ;        HL     - HL7 values
 ;Output: DGPIR  - PID array segment
 ;            1  - PID segment build (no error)
 ;        -1^ErrorText on error
 ;
 N FLDS,DGX
 I $G(DFN)="" Q "-1^Value missing to build message (PID segment)"
 S FLDS=$$COMMANUM^VAFCADT2(1,9)_",10NTB,11,"
 S FLDS=FLDS_$$COMMANUM^VAFCADT2(12,21)_",22B"
 D BLDPID^VAFCQRY(DFN,"",FLDS,.DGPID,.HL)
 S DGX=$O(DGPID(0)) I DGX S DGX=DGPID(DGX)
 I $P(DGX,"^")'="PID" Q "-1^Error build message (PID segment)"
 Q 1
 ;
PD1(DFN,COORD) ;Build PD1 segment
 ;Input:  DFN    - Patient DFN
 ;        COOR   - Care Coordinator
 ;Output: PD1    - PD1 segment
 ;        -1^ErrorText on error
 ;
 N PD1,DGNAME
 I $G(DFN)=""!($G(COORD)="") Q "-1^Value missing to build message (PD1 segment)"
 S PD1=$$EN^VAFHLPD1(DFN,3)
 I ($E(PD1,1,3)'="PD1") Q "-1^Error build message (PD1 segment)"
 S DGNAME("FILE")=200,DGNAME("IENS")=COORD,DGNAME("FIELD")=.01
 S $P(PD1,HLFS,5)=COORD_$E(HLECH)_$$HLNAME^XLFNAME(.DGNAME,"",$E(HLECH))
 Q PD1
 ;
PIDVAL ;validate PID segment
 ;locate the fields in variable FLDS in VAFPID array, check its not null
 N NSTR,STR,FLN,FLDS,FLC,X,Y,Z
 S FLDS="4^6^8^12^20",(FLN,FLN(0))=0,DGX=0
 S STR="Patient Identifier list^Patient Name^Date of Birth^Patient address^SSN"
 F  S DGX=$O(VAFPID(DGX)) Q:'DGX  D  I ERR Q
 .S FLN(DGX)=$L(VAFPID(DGX),"^")-1,FLC=FLN,FLN=FLN+FLN(DGX)
 .F X=1:1 S Y=$P(FLDS,"^",X) Q:Y=""  I Y'="C" D  I ERR Q
 ..I Y'>FLN S $P(FLDS,"^",X)="C" D
 ...I FLN(DGX)=FLN S:($P(VAFPID(DGX),"^",Y-FLC)="")!($P(VAFPID(DGX),"^",Y-FLC)="""""") ERR="-1^Error in PID-"_(Y-1)_" field ("_$P(STR,"^",X)_")" Q
 ...S NSTR=$P(VAFPID(DGX-1),"^",FLN(DGX-1)+1)_VAFPID(DGX) I ($P(NSTR,"^",Y-FLC)="")!($P(NSTR,"^",Y-FLC)="""""") S ERR="-1^Error in PID-"_(Y-1)_" field ("_$P(STR,"^",X)_")" Q
 Q
 ;
BLDHL7I(DFN,MSG) ;Build HL7 Registration message for telehealth
 ;Input : DFN  - Pointer to PATIENT
 ;        MSG  - Array to put message into (full global ref)
 ;Output: Last line number used
 ;        -1^ErrorText on error
 ;        MSG will contain HL7 message
 ;Notes : Insertion into MSG begins at next available line number
 I '$D(^DPT(DFN,0)) Q "-1^Bad input (DFN)"
 I $G(MSG)="" Q "-1^Bad input variable (MSG)"
 N HLFS,HLECH,HLQ,HL,EVN,VAFPID,PV1,LINE,FLDS,DGVEN,DGX
 N EVNTDT,ERR,PROT4HL7,COMP,SUBCOMP,USRNAM,USERID
 S PROT4HL7="DG HOME TELEHEALTH ADT-A03 SERVER"
 D INIT^HLFNC2(PROT4HL7,.HL)
 I ($O(HL(""))="") Q "-1^Unable to initialize HL7 variables"
 S EVNTDT=$$NOW^XLFDT()
 S LINE=+$O(@MSG@(""),-1)
 ;EVN segment
 S EVN=$$EVN("A03","A03",EVNTDT)
 I EVN<0 K @MSG Q "-1^Error build message (EVN segment)"
 S LINE=LINE+1
 S @MSG@(LINE)=EVN
 ;
 ;PID segment
 N DGX
 S PID=$$PID(DGDFN,.HL,.VAFPID)
 I +PID'>0 S ERR=1 K @MSG Q "-1^Error build message (PID segment)"
 S DGX=$O(VAFPID(0)),LINE=LINE+1 S @MSG@(LINE)=VAFPID(DGX)
 F  S DGX=$O(VAFPID(DGX)) Q:'DGX  D
 .S @MSG@(LINE,DGX-1)=VAFPID(DGX)
 ;Done
 Q 1
SNDHL7(MSG,PTRRCV,PROTNAME)     ;Send HL7 Home Telehealth message to server
 ;Input : MSG - Array containing HL7 message to transmit
 ;              (full global reference)
 ;            - Must be in format required for interaction
 ;              with the HL7 package
 ;     PTRRCV  - Pointer for vendor receiving system
 ;    PROTNAME - Protocol name
 ;Output: Message ID
 ;        Message ID or 0^ErrorText on error
 ;Notes  : The global array ^TMP("HLS",$J) will be KILLed if MSG
 ;         does not use this global location
 I $G(MSG)="" Q "-1^Bad input variable(MSG)"
 I '$G(PTRRCV) Q "-1^Bad input variable for vendor (PTRRCV)"
 I ($O(@MSG@(""))="") Q "-1^Message empty... can't send empty"
 N DGARRAY,HL,HLL,HLFS,HLECH,HLQ,HLMTIEN,HLRESLT,HLP,KILLARRY,ARRY4HL7,APPINFO,DIC,CLPROT,SIEN,LINK
 S ARRY4HL7=$NA(^TMP("HLS",$J))
 D INIT^HLFNC2(PROTNAME,.HL)
 I ($O(HL(""))="") Q "-1^Unable to initialize HL7 variables"
 S APPINFO=$$APP4MSH(PTRRCV)
 I APPINFO="" Q "-1^Unable to determine receiving system information"
 ;See if MSG is ^TMP("HLS",$J)
 S KILLARRY=0
 I (MSG'=ARRY4HL7) D
 .;Make sure '$J' wasn't used
 .Q:(MSG="^TMP(""HLS"",$J)")
 .;Initialize ^TMP("HLS",$J) and merge XMITARRY into it
 .K @ARRY4HL7
 .M @ARRY4HL7=@MSG
 .S KILLARRY=1
 ;Using dynamic MSH segment
 S $P(HLP("SUBSCRIBER"),"^",2)="DG HOME TELEHEALTH"
 S $P(HLP("SUBSCRIBER"),"^",3)=$P(APPINFO,"^",1)
 S $P(HLP("SUBSCRIBER"),"^",4)="HTAPPL"
 S $P(HLP("SUBSCRIBER"),"^",5)=$P(APPINFO,"^",2)
 S HLP("PRIORITY")="I"  ;Immediate priority
 ;Get subscriber protocol
 S DIC="^ORD(101,",DIC(0)="B",X=PROTNAME D ^DIC
 D GETS^DIQ(101,+Y,"775*","E","ARRAY1")
 S CLPROT=ARRAY1(101.0775,$O(ARRAY1(101.0775,0)),.01,"E")
 ;Use inst file ien to retrieve logical link for dynamic addressing
 D LINK^HLUTIL3(DGVEN,.DGARRAY,"")
 S LINK=DGARRAY($O(DGARRAY(0)))
 S HLL("LINKS",1)=CLPROT_U_LINK
 D GENERATE^HLMA(PROTNAME,"GM",1,.HLRESLT,"",.HLP)
 ;S:('HLRESLT) HLRESLT=$P(HLRESLT,"^",2,3)
 ;Delete ^TMP("HLS",$J) if MSG was different
 K:(KILLARRY) @ARRY4HL7
 ;Done
 Q HLRESLT
 ;
APP4MSH(PTRRCV) ;Determine sending and receiving application for MSH segment
 ;Input : PTRRCV = Pointer to file #4 for receiving system
 ;Output: Sending Facility ^ Receiving Facility
 ;        Null = Error/bad input
 N SNDFAC,RCVFAC
 I 'PTRRCV Q ""
 I $$GET1^DIQ(4,PTRRCV,.01)="" Q ""
 S SNDFAC=$P($$SITE^VASITE(),"^",3)_$E(HLECH)
 S SNDFAC=SNDFAC_$$GET1^DIQ(4,$P($$SITE^VASITE(),"^"),60,"E")_$E(HLECH)
 S SNDFAC=SNDFAC_"DNS"
 S RCVFAC=$$GET1^DIQ(4,PTRRCV,99,"E")_$E(HLECH)
 S RCVFAC=RCVFAC_$$GET1^DIQ(4,PTRRCV,60,"E")_$E(HLECH)_"DNS"
 Q SNDFAC_"^"_RCVFAC
