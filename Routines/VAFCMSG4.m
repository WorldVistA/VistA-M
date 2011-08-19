VAFCMSG4 ;ALB/JRP-MESSAGE BUILDER UTILITIES ;26-MAR-2003
 ;;5.3;Registration;**91,209,149,415,484,508**;Jun 06, 1996
 ;
SEGMENTS(EVNTTYPE,SEGARRY) ;Build list of HL7 segments for given event type
 ;
 ;Input  : EVNTTYPE - Event type to build list for (Defaults to A08)
 ;                    Currently supported events:
 ;                      A04, A08, A28
 ;         SEGARRY - Array to place output in (full global reference)
 ;                   (Defaults to ^TMP("VAFC SEGMENTS",$J))
 ;Output : None
 ;           SEGARRY(Seq,Name) = Fields
 ;           SEGARRY(Name,"BLD") = Executable code to build HL7 segment
 ;           SEGARRY(Name,"CPY") = Executable code to copy HL7 segment
 ;                                 into HL7 message
 ;           SEGARRY(Name,"DEL") = Executable code to delete variables
 ;                                 used to build HL7 segment
 ;             Seq - Sequencing number to order the segments as
 ;                   they should be placed in the HL7 message
 ;             Name - Name of HL7 segment
 ;             Fields - List of fields used by segment
 ;                      VAFSTR would be set to this value
 ;Notes  : MSH segment is not included
 ;       : SEGARRY will be KILLed on entry
 ;
 ;Check input
 S EVNTTYPE=$G(EVNTTYPE)
 S:(EVNTTYPE="") EVNTTYPE="A08"
 S SEGARRY=$G(SEGARRY)
 S:(SEGARRY="") SEGARRY="^TMP(""VAFC SEGMENTS"","_$J_")"
 K @SEGARRY
 ;Declare variables
 N X,OK
 ;Check for supported event
 S OK=0
 F X="A04","A08","A28" I X=EVNTTYPE S OK=1 Q
 Q:('OK)
 ;Segments used by A04, A08, A28
 S @SEGARRY@(1,"EVN")="1,2,4"
 S @SEGARRY@("EVN","BLD")="D BLDEVN^VAFCMSG3"
 S @SEGARRY@("EVN","CPY")="D CPYEVN^VAFCMSG3"
 S @SEGARRY@("EVN","DEL")="D DELEVN^VAFCMSG3"
 S @SEGARRY@(2,"PID")=$$COMMANUM^VAFCADT2(1,9)_",10B,11PC,"_$$COMMANUM^VAFCADT2(13,21)_",22B,"_$$COMMANUM^VAFCADT2(23,30)
 S @SEGARRY@("PID","BLD")="D BLDPID^VAFCMSG3"
 S @SEGARRY@("PID","CPY")="D CPYPID^VAFCMSG3"
 S @SEGARRY@("PID","DEL")="D DELPID^VAFCMSG3"
 S @SEGARRY@(3,"PD1")=$$COMMANUM^VAFCADT2(1,12)
 S @SEGARRY@("PD1","BLD")="D BLDPD1^VAFCMSG3"
 S @SEGARRY@("PD1","CPY")="D CPYPD1^VAFCMSG3"
 S @SEGARRY@("PD1","DEL")="D DELPD1^VAFCMSG3"
 S @SEGARRY@(4,"PV1")="2,3,6,7,10,18,44,45,50"
 S @SEGARRY@("PV1","BLD")="D BLDPV1^VAFCMSG3"
 S @SEGARRY@("PV1","CPY")="D CPYPV1^VAFCMSG3"
 S @SEGARRY@("PV1","DEL")="D DELPV1^VAFCMSG3"
 S @SEGARRY@(5,"ROL")="1,2,3,4"
 S @SEGARRY@("ROL","BLD")="D BLDROL^VAFCMSG3"
 S @SEGARRY@("ROL","CPY")="D CPYROL^VAFCMSG3"
 S @SEGARRY@("ROL","DEL")="D DELROL^VAFCMSG3"
 S @SEGARRY@(6,"OBX")=""
 S @SEGARRY@("OBX","BLD")="D BLDOBX^VAFCMSG3"
 S @SEGARRY@("OBX","CPY")="D CPYOBX^VAFCMSG3"
 S @SEGARRY@("OBX","DEL")="D DELOBX^VAFCMSG3"
 S @SEGARRY@(7,"ZPD")=$$COMMANUM^VAFCADT2(1,21)
 S @SEGARRY@("ZPD","BLD")="D BLDZPD^VAFCMSG3"
 S @SEGARRY@("ZPD","CPY")="D CPYZPD^VAFCMSG3"
 S @SEGARRY@("ZPD","DEL")="D DELZPD^VAFCMSG3"
 S @SEGARRY@(8,"ZSP")="1,2,3,4,5"
0 S @SEGARRY@("ZSP","BLD")="D BLDZSP^VAFCMSG3"
 S @SEGARRY@("ZSP","CPY")="D CPYZSP^VAFCMSG3"
 S @SEGARRY@("ZSP","DEL")="D DELZSP^VAFCMSG3"
 S @SEGARRY@(9,"ZEL")=$$COMMANUM^VAFCADT2(1,22)
 S @SEGARRY@("ZEL","BLD")="D BLDZEL^VAFCMSG3"
 S @SEGARRY@("ZEL","CPY")="D CPYZEL^VAFCMSG3"
 S @SEGARRY@("ZEL","DEL")="D DELZEL^VAFCMSG3"
 S @SEGARRY@(10,"ZCT")="1,2,3,4,5,6,7,8,9"
 S @SEGARRY@("ZCT","BLD")="D BLDZCT^VAFCMSG3"
 S @SEGARRY@("ZCT","CPY")="D CPYZCT^VAFCMSG3"
 S @SEGARRY@("ZCT","DEL")="D DELZCT^VAFCMSG3"
 S @SEGARRY@(11,"ZEM")="1,2,3,4,5,6,7,8"
 S @SEGARRY@("ZEM","BLD")="D BLDZEM^VAFCMSG3"
 S @SEGARRY@("ZEM","CPY")="D CPYZEM^VAFCMSG3"
 S @SEGARRY@("ZEM","DEL")="D DELZEM^VAFCMSG3"
 S @SEGARRY@(12,"ZFF")=""
 S @SEGARRY@("ZFF","BLD")="D BLDZFF^VAFCMSG3"
 S @SEGARRY@("ZFF","CPY")="D CPYZFF^VAFCMSG3"
 S @SEGARRY@("ZFF","DEL")="D DELZFF^VAFCMSG3"
 S @SEGARRY@(13,"ZIR")=$$COMMANUM^VAFCADT2(1,13)
 S @SEGARRY@("ZIR","BLD")="D BLDZIR^VAFCMSG3"
 S @SEGARRY@("ZIR","CPY")="D CPYZIR^VAFCMSG3"
 S @SEGARRY@("ZIR","DEL")="D DELZIR^VAFCMSG3"
 S @SEGARRY@(14,"ZEN")=$$COMMANUM^VAFCADT2(1,10)
 S @SEGARRY@("ZEN","BLD")="D BLDZEN^VAFCMSG3"
 S @SEGARRY@("ZEN","CPY")="D CPYZEN^VAFCMSG3"
 S @SEGARRY@("ZEN","DEL")="D DELZEN^VAFCMSG3"
 Q
