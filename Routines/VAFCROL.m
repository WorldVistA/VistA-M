VAFCROL ;ALB/MRY - HL7 ADT MESSAGE BUILDING ROUTINE ; 3/24/03 9:57 AM
 ;;5.3;Registration;**484**;Aug 13,  1993
 ;hl7v1.6
 ;
 ; Called from routines: VAFCA04, VAFCADT2, VAFCMSG3
 ;
BLDROL(ROLARRY,DFN,VAFHDT,VAFSTR,PIVOT,IEN) ;
 ;Build ROL HL7 segments for a given patient
 ;
 ;Input    :  ROLARRY - Array to place output in (full global reference)
 ;                      (Defaults to ^TMP("VAFC ROL SEGMENTS",$J))
 ;            DFN     - Pointer to entry in PATIENT file (#2)
 ;            VAFHDT  - Date/time event occurred (Fileman format)
 ;            VAFSTR  - String of fields to put into segment separated by commas
 ;            PIVOT   - PIVOT entry (file #391.71)
 ;            IEN     - Pointer to entry in PATIENT MOVEMENT file (#405)
 ;Output : None
 ;            ROLARRY(Seq,0) = Fields
 ;            ROLARRY(Seq,1) = Continuation Fields
 ;Note:  : ROLARRY will be KILLed on entry
 ;
 S ROLARRY=$G(ROLARRY)
 S:(ROLARRY="") ROLARRY="^TMP(""VAFC ROL SEGMENTS"","_$J_")"
 K @ROLARRY
 ;
 I $G(PIVOT)'>0 Q  ; no pivot number
 N VAFCPRV,VAFCPAR,VAFCROL,TYPPRV,NODE,PRVNUM
 D GETPRV(DFN,VAFHDT,$G(IEN),"VAFCPRV")
 S TYPPRV=0
 F PRVNUM=1:1 S TYPPRV=$O(VAFCPRV(TYPPRV)) Q:TYPPRV=""  D
 .K VAFCPAR,VAFCROL
 .S NODE=VAFCPRV(TYPPRV)
 .S VAFCPAR("PTR200")=+NODE
 .S VAFCPAR("INSTID")=PIVOT_"-"_(+NODE)_"*"_PRVNUM
 .S VAFCPAR("ACTION")="CO"
 .S VAFCPAR("ALTROLE")=$TR(TYPPRV,"12","TA")_$E(HL("ECH"),1)_HL("Q")_$E(HL("ECH"),1)_"VA01"
 .S VAFCPAR("CODEONLY")=0
 .S VAFCPAR("RDATE")=VAFHDT
 .D OUTPAT^VAFHLROL("VAFCPAR","VAFCROL",VAFSTR,HL("FS"),HL("ECH"),HL("Q"),240)
 .K VAFCROL("ERROR"),VAFCROL("WARNING")
 .M @ROLARRY@(PRVNUM)=VAFCROL
 Q
 ;
GETPRV(DFN,VAFHDT,IEN,GETPRV) ;
 ;Build array; array(1) = attending; array(2) = admitting
 N CURRENT,VAROOT,VA200
 D KVAR^VADPT
 S VAROOT="CURRENT",VAIP("D")=VAFHDT,VA200=1
 I $G(IEN)'="" S VAIP("E")=IEN
 D IN5^VADPT
 ;Build array allowing Attending physician display first in ROL segment
 S:$G(CURRENT(7)) @GETPRV@(2)=CURRENT(7) S:$G(CURRENT(18)) @GETPRV@(1)=CURRENT(18)
 Q
