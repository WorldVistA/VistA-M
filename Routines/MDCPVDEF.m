MDCPVDEF ;HINES OIFO/BJ - CP Outbound message queue routine.;30 Jul 2007
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10061       - IN5^VADPT                        Registration                   (supported)
 ;  # 4253       - $$QUEUE^VDEFQM                   VDEF             (controlled subscription)
 ;  # 2817       - access "AD" x-ref per ^DG(40.8,  Registration     (controlled subscription)
 ;  # 1373       - access ^ORD(101                  Kernel           (controlled subscription)
 ;  #10039       - access ^DIC(42                   Registration                   (supported)
 ;  # 1181       - access DGPM* event variables     Registration     (controlled subscription)
 ;
 ; only call via line tags.
 Q
 ;
EN ;
 ; Parses outbound message from PIMS to send to 3rd party devices via ADT/A?? message.
 ;
 ; Parameters -
 ;   Covert (Preset local variables) -
 ;     DFN - The internal entry number of the patient in file 2.
 ;     DGPMDA - The movement internal entry number of the entry in the PATIENT_MOVEMENT
 ;       file.
 ;     DGPMA - Zero node of entry DGPMDA after the movement has been changed in the
 ;       PATIENT MOVEMENT file.
 ;     DGPMP - Zero node of entry DGPMDA before the movement has been changed in the
 ;       PATIENT MOVEMENT file.
 ;
 ; Returns -
 ;   None
 ;
 N MDNODE,MDDIV,MDWARD,MDBED,MDEVNT,MDTYPE,MDDFN,MDMVMT,MDQUIT,MDDA,MDEDIT,VAIP
 S MDNODE=$S(DGPMA]"":DGPMA,1:DGPMP)
 S MDEDIT=(DGPMA]"")&(DGPMP]"")
 S MDMVMT=DGPMDA
 S MDDFN=$P(MDNODE,U,3)
 S MDTYPE=+$P(MDNODE,U,2) Q:(MDTYPE'=MDTYPE\1)!(MDTYPE>3)!(MDTYPE<1)
 S MDWARD=$P(MDNODE,U,6) Q:MDWARD=""
 S MDBED=$P(MDNODE,U,7) Q:MDBED=""
 Q:$D(^MDC(704.005,"APIMS",MDMVMT,MDDFN,MDWARD))&MDEDIT  ; We've already seen this movement - Future A08
 ;
 ; It appears that DIV might be empty if this is a single division facility.  So, we have to
 ;   get a division of our own.
 ;
 S MDDIV=$P(^DIC(42,MDWARD,0),U,11)
 I MDDIV="" S MDDIV=DUZ(2),MDDIV=$O(^DG(40.8,"AD",MDDIV,0))
 ;
 ;   Movement         |  DGPMP  |   DGPMA
 ;   ---------------------------------
 ;   Admit            | Absent  |  Present
 ;   Cancel Admit     | Present |  Absent
 ;   Transfer         | Absent  |  Present
 ;   Cancel Xfer      | Present |  Absent
 ;   Discharge        | Absent  |  Present
 ;   Cancel Discharge | Present |  Absent
 ;
 S MDEVNT=$S(DGPMA]"":"A0",1:"A1")
 S MDEVNT=MDEVNT_MDTYPE
 Q:'$$SENDMSG(MDDIV,MDWARD,"ADT",MDEVNT)
 D ADD(MDDFN,MDDIV,MDWARD,$G(MDBED),"ADT",MDEVNT,MDMVMT)
 Q
 ;
ADD(MDCPDFN,MDCPDIV,MDCPWARD,MDCPBED,MDCPMSG,MDCPEVNT,MDCPMVMT) ;
 ;
 ; Adds information to CP_PATIENT_MOVEMENT file (704.005), and calls the VDEF queue.
 ;
 ; Parameters -
 ;   Covert (Preset local variables) -
 ;   None
 ;
 ;   Overt -
 ;   MDCPDFN - The IFN of the patient in the PATIENT file.
 ;   MDCPDIV - A pointer to the division of the ward for which the message was sent
 ;   MDCPWARD - A pointer to the ward for which the movement was sent
 ;   MDCPBED - A pointer to the bed for which the movement was sent
 ;   MDCPMSG - The HL7 message type (at this point, this should ALWAYS be ADT).
 ;   MDCPEVNT - The HL7 event type for the message (A01, A02, A03, etc.)
 ;   MDCPMVMT - PATIENT MOVEMENT IEN (Stored as PIMS_EVENT_ID, not a pointer)
 ;
 ; Returns -
 ;   None
 ;
 ; The first thing we want to do is see if this is a cancellation.  If it is, we need
 ; to look back at the most recent previous movement in our system.  If the most recent
 ; previous movement does NOT refer to the same division, ward, and bed, then we ignore
 ; the event.
 ;
 ; $ESTACK, UNWIND^%ZTER, and ^%ZTER appear courtesy of IA 1621 (Supported)
 ;
 N MDCPDTTM
 D NOW^%DTC S MDCPDTTM=%
 N MDCPFLG S MDCPFLG=0
 I MDCPEVNT?1"A1"1N D
 .; The concept here is that, if this is a cancel movement, we need to take a look at
 .; the most recent movement and cancellation of that movement type.  If there was another
 .; cancel between the last movement and this cancel, we don't want to resend the message.
 .N MDCPPREV,MDCPOLD,MDCPPOLD
 .S MDCPOLD=$S(MDCPEVNT="A11":"A01",MDCPEVNT="A12":"A02",MDCPEVNT="A13":"A03",1:"")
 .S MDCPPREV=$O(^MDC(704.005,"LAST",MDCPDFN,MDCPMSG,MDCPOLD,""),-1)
 .S MDCPPOLD=$O(^MDC(704.005,"LAST",MDCPDFN,MDCPMSG,MDCPEVNT,""),-1)
 .S MDCPFLG=$S(+MDCPPOLD'<+MDCPPREV:"1",1:"0")
 ;
 Q:MDCPFLG
 N MDCFDA,MDCPIEN,MDCPPAIR
 S MDCFDA(704.005,"+1,",.01)=MDCPDFN
 S MDCFDA(704.005,"+1,",.02)=MDCPDTTM
 S MDCFDA(704.005,"+1,",.03)=MDCPDIV
 S MDCFDA(704.005,"+1,",.04)=MDCPWARD
 S MDCFDA(704.005,"+1,",.05)=MDCPBED
 S MDCFDA(704.005,"+1,",.06)=MDCPMSG
 S MDCFDA(704.005,"+1,",.07)=MDCPEVNT
 S MDCFDA(704.005,"+1,",.08)=MDCPMVMT
 D UPDATE^DIE("","MDCFDA","MDCPIEN") Q:$G(MDCPIEN(1))<1
 ;
 N STYPE,RETRN,DYNAMIC,EVNTDRVR,REQIEN,DYNAMIC
 S STYPE=$S(MDCPEVNT="A01":"CPAN",MDCPEVNT="A02":"CPTP",MDCPEVNT="A03":"CPDE",MDCPEVNT="A08":"CPUI",MDCPEVNT="A11":"CPCAN",MDCPEVNT="A12":"CPCT",MDCPEVNT="A13":"CPCDE",1:"")
 S MDCPPAIR="SUBTYPE="_STYPE_"^IEN="_MDCPIEN(1)
 K MDCFDA
 S MDCFDA(704.005,MDCPIEN(1)_",",.09)=$$QUEUE^VDEFQM(MDCPMSG_U_MDCPEVNT,MDCPPAIR,.RETRN)
 S:MDCFDA(704.005,MDCPIEN(1)_",",.09)=0 MDCFDA(704.005,MDCPIEN(1)_",",.1)=$G(RETRN,"No return message.")
 D UPDATE^DIE("","MDCFDA")
 Q
 ;
DEL(MDCPIFN) ;
 ;
 ; Removes entry from CP_PATIENT_MOVEMENT file (704.005).
 ;
 ; Parameters -
 ;   Covert (Preset local variables) -
 ;   None
 ;
 ;   Overt -
 ;   MDCPIFN - IFN of entry in 704.005 to delete.
 ;
 ; Returns -
 ;   None
 ;
 N MDCFDA
 S MDCFDA(704.005,MDCPIFN_",",.01)="@"
 D FILE^DIE("K","MDCFDA")
 Q
 ;
GENA08(MDCPDFN,MDCPDIV,MDCPWARD,MDCPBED) ;
 ;
 ; Generates an outbound A08 message.
 ;
 ; Parameters -
 ;   MDCPDFN - The DFN of the patient (Required)
 ;   MDCPDIV - The current facility to which the patient is admitted (optional)
 ;   MDCPWARD - The current ward to which the patient is admitted (optional)
 ;   MDCPBED - The current bed to which the patient is admitted (optional)
 ;
 ;   If division, ward, or bed are blank, ^VADPT will be called to get the most recent movement information
 ;     for the patient.
 ;
 ; Returns -
 ;   None
 I ($G(MDCPDIV)="")!($G(MDCPWARD)="")!($G(MDCPBED)="") D
 .N DFN S DFN=MDCPDFN
 .D IN5^VADPT
 .S MDCPWARD=$P(VAIP(5),U)
 .S MDCPDIV=$P(^DIC(42,MDCPWARD,0),U,11)
 .S MDCPBED=$P(VAIP(6),U)
 ;
 D ADD(MDCPDFN,MDCPDIV,MDCPWARD,MDCPBED,"ADT","A08")
 Q
 ;
GENDESTS ;
 ; Filters outbound messages.  See HL*1.6*56/66 Site Manager and Developer Manual
 ;   p. 11-7 to 11-11 (inc).
 ;
 ; IA's -
 ;   1373 (provisional: subscription requested 3 Aug 2007)
 ;
 ; Parameters -
 ;   Covert (Preset local variables) -
 ;     HLNEXT - Executable code to retrieve the next line of an outbound HL7 message.
 ;     HL("ECH") - Encoding characters for this HL7 message.
 ;     HL("FS") - The Field Separator for this HL7 message.
 ;     NAMEVAL - Local array passed from VDEF to HL7.  Must not be newed or killed.
 ;
 ;
 ; Returns -
 ;   None overt.  HLL("LINKS",n) will be read by HLO upon return.
 ;
 N MDCPV1,MDHLFS,MDHLECH,MDDIV,MDDIVI,MDWARD,MDWARDI,MDBED,MDCPSUB,MDCPROT,I,IEN
 S IEN=$P($G(NAMEVAL(2,0)),"=",2)
 S MDHLFS=HL("FS")
 S MDHLECH=$E(HL("ECH"),1,1)
 F  X HLNEXT D  Q:HLQUIT'>0
 .S:$P($G(HLNODE),MDHLFS)="PV1" MDCPV1=HLNODE
 ; Division is PV1(3)(1), Room is PV1(3)(2), Bed is PV1(3)(3)
 S MDDIV=$P(MDCPV1,MDHLFS,4)
 S MDWARD=$P(MDDIV,MDHLECH,2)
 S MDBED=$P(MDDIV,MDHLECH,3)
 S MDDIVI=$P(^MDC(704.005,IEN,0),U,3)
 S MDWARDI=$P(^MDC(704.005,IEN,0),U,4)
 D ARRYDEST(MDDIVI,MDWARDI,$G(HL("MTN")),$G(HL("ETN")))
 ;
 Q
 ;
GETSUBS ;
 ; Get subscriber protocols
 ;
 ; IA's -
 ;   1373 (provisional, see above)
 ;
 ; Parameters -
 ;   None
 ;
 ; Returns -
 ;   Overt - None
 ;
 N Y S Y=0
 F  S Y=$O(^ORD(101,Y)) Q:'Y  S:$P(^ORD(101,Y,0),U,4)="S"&($P(^(0),U,1)?1"MD".E) @MDROOT@(Y)=""
 Q
 ;
GENDEST2(IEN) ; Filters outbound messages.  Unlike GENDESTS, this is set to filter
 ;  assuming that we have not yet queued the outbound message in VDEF.
 ;
 ;
 ; Parameters
 ;   IEN: The IEN of the entry in the CLIO_HL7_LOG file that will be used to generate
 ;        this message.
 ;
 ; Returns -
 ;   None overt.  HLL("LINKS",n) will be read by HLO upon return.
 ;
 N MDCPDIV,MDCPMSGT,MDCPEVNT
 N MDCPMSG
 D GETS^DIQ(704.005,IEN_",","*","I","MDCPMSG")
 S MDCPDIV=$G(MDCPMSG("704.005",IEN_",",".03","I"))
 S MDCPMSGT=$G(MDCPMSG("704.005",IEN_",",".06","I"))
 S MDCPEVNT=$G(MDCPMSG("704.005",IEN_",",".07","I"))
 S MDCPWARD=$G(MDCPMSG("704.005",IEN_",",".04","I"))
 D ARRYDEST(MDCPDIV,MDCPWARD,MDCPMSGT,MDCPEVNT)
 Q
 ;
ARRYDEST(DIVISION,WARD,MSGTYPE,EVNTTYPE) ;
 ;
 ; DIVISION: IEN of division in file 40.8.
 ; WARD: IEN of ward in file 42.
 ;
 N MDCPSUB,I,MDCPPROT,MDCPWARD
 S MDCPSUB=0,I=0
 F  S MDCPSUB=$O(^MDC(704.006,"LOCDEV",DIVISION,MDCPSUB)) Q:'MDCPSUB  D
 .Q:MSGTYPE'=$P(^MDC(704.006,MDCPSUB,0),U,4)
 .Q:EVNTTYPE'=$P(^MDC(704.006,MDCPSUB,0),U,5)
 .S MDCPWARD=$P(^MDC(704.006,MDCPSUB,0),U,3)
 .Q:(MDCPWARD'="")&(MDCPWARD'=WARD)
 .;Q:(MDBED'="")&(MDBED'=$P(^MDC(704.006,"LOCDEV",MDCPPROT),U,3)
 .S MDCPROT=$P(^MDC(704.006,MDCPSUB,0),U)
 .S I=I+1
 .S HLL("LINKS",I)=$P(^ORD(101,MDCPROT,0),U)_U_$$EXTERNAL^DILFD(101,770.7,"",$P(^ORD(101,MDCPROT,770),U,7))
 Q
 ;
SENDMSG(DIVISION,WARD,MSGTYPE,EVNTTYPE) ;
 ;
 ; Determines whether or not we should continue to build or save this message.  On a basis
 ;   of division, ward, message type, and event type, will return 1 or 0 based on whether or
 ;   not there is an entry in 704.006 to send the message to a specific device.  Requires
 ;   build 260 or greater of MD*1.0*16, as there are 2 new indexes that will be required.
 ;
 ; Parameters
 ;   DIVISION - Division (internal)
 ;   WARD - Ward (internal)
 ;   MSGTYPE - HL7 message type
 ;   EVNTTYPE - HL7 event type
 ;
 ; Returns
 ;   1 if message should be sent
 ;   0 if not
 ;
 N USE
 I $G(WARD)'="" D
 .S USE=$O(^MDC(704.006,"AMSGDIVWARD",MSGTYPE,EVNTTYPE,$G(DIVISION),$G(WARD),0))
 I $G(WARD)="" D
 .N WD S WD=0 S USE=0
 .F  S WD=$O(^MDC(704.006,"AMSGDIV",MSGTYPE,EVNTTYPE,$G(DIVISION),WD)) Q:+WD=0  D
 ..I $P(^MDC(704.006,WD,0),U,3)="" S USE=1 Q
 Q:+$G(USE) 1
 Q 0
 ;
