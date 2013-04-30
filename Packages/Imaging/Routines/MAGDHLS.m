MAGDHLS ;WOIFO/MLH/JSL/SAF - IHE-based ADT interface for PACS - segments ; 23 Jul 2009 8:15 AM
 ;;3.0;IMAGING;**49,123**;Mar 19, 2002;Build 67;Jul 24, 2012
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; It is always expected that the HL7 environment variables will have
 ; been initialized by a call to INIT^HLFNC2 for the appropriate event
 ; driver protocol.
 ; 
AL1(XDFN,XYMSG) ; patient allergies
 ; input:  XDFN      internal entry number of the patient on global ^DPT
 ;         XYMSG     name of array to which to add message elts
 ; output: @XYMSG    input array plus new subtree containing EVN elts
 ;         function return   0 (success) always
 ; 
 N DFN ; ------ internal entry number on ^DPT
 N IXAL ; ----- allergy index (on GMRAL array)
 N SETID ; ---- index of the AL1 segment on this message
 N ALDTA ; ---- allergy data
 N IXREAC ; --- reaction index
 N REPIX ; ---- field repetition index
 N VA,VADPT ; - Return arrays from DEM^VADPT containing patient demographics
 ;
 D DEM^VADPT
 ;
 K YSEGA
 S DFN=XDFN D ^GMRADPT ; get patient's allergies
 S IXAL=0
 F SETID=1:1 S IXAL=$O(GMRAL(IXAL)) Q:'IXAL  D
 . S ALDTA=$G(GMRAL(IXAL))
 . S SEGIX=$O(@XYMSG@(" "),-1)+1
 . S @XYMSG@(SEGIX,0)="AL1"
 . S @XYMSG@(SEGIX,1,1,1,1)=SETID
 . S @XYMSG@(SEGIX,2,1,1,1)=$P(ALDTA,U,7) ; type
 . S @XYMSG@(SEGIX,3,1,2,1)=$P(ALDTA,U,2) ; description
 . S IXREAC=0
 . F REPIX=1:1 S IXREAC=$O(GMRAL(IXAL,"S",IXREAC)) Q:'IXREAC  D
 . . S @XYMSG@(SEGIX,5,REPIX,1,1)=$P($G(GMRAL(IXAL,"S",IXREAC)),";",1) ; reaction
 . . Q
 . Q
 Q 0
 ;
DG1(XDFN,XYMSG) ; FUNCTION - diagnosis
 ; input:  XDFN      internal entry number of the patient on global ^DPT
 ;         XYMSG     name of array to which to add message elts
 ; output: @XYMSG    input array plus new subtree containing EVN elts
 ;         function return   0 (success) always
 ;
 N DFN ; ----- internal entry number on ^DPT
 N VAIP ; ---- inpatient episode data array
 N SETID ; --- segment index for diagnoses
 N APROB ; --- problem list array
 N PROBIX ; -- problem list index
 ;
 S SETID=0 ; segment increment base
 S DFN=XDFN D IN5^VADPT ; get patient's inpatient episode data
 I $G(VAIP(9))'="" D  ; is there a diag assoc'd w/the latest movement?
 . ; yes, populate data for the DG1 segment
 . S SEGIX=$O(@XYMSG@(" "),-1)+1
 . S @XYMSG@(SEGIX,0)="DG1" ; segment ID
 . ; populate element leaves
 . S SETID=SETID+1
 . S @XYMSG@(SEGIX,1,1,1,1)=SETID
 . S @XYMSG@(SEGIX,3,1,2,1)=$E(VAIP(9),1,249) ; diagnosis text
 . ; either admitting or working diagnosis
 . S @XYMSG@(SEGIX,6,1,1,1)=$S($P($G(VAIP(2)),"^",1)=1:"A",1:"W")
 . Q
 ;
 ; get patient's active problem list
 D ACTIVE^GMPLUTL(XDFN,.APROB) ; DBIA #928
 S PROBIX=0
 F  S PROBIX=$O(APROB(PROBIX)) Q:'PROBIX  D
 . S SEGIX=$O(@XYMSG@(" "),-1)+1
 . S @XYMSG@(SEGIX,0)="DG1" ; segment ID
 . ; populate element leaves
 . S SETID=SETID+1
 . S @XYMSG@(SEGIX,1,1,1,1)=SETID
 . S @XYMSG@(SEGIX,3,1,2,1)=$E($P(APROB(PROBIX,1),"^",2),1,249) ; problem text
 . S @XYMSG@(SEGIX,6,1,1,1)="W" ; working diagnosis
 . Q
 ;
 Q 0
 ;
EVN(XEVENT,XEVNRDT,XEVNODT,XYMSG) ; FUNCTION - event
 ; input:  XEVENT   trigger event code
 ;         XEVNRDT  date/time the event was recorded (FM format)
 ;         XEVNODT  date/time the event occurred (FM format)
 ;         XYMSG    name of array to which to add message elts
 ; output: @XYMSG   input array plus new subtree containing EVN elts
 ;         function return   0 (success) always
 ; 
 N SEGIX ; ---- segment index on @XYMSG
 N STAT ; ----- status return from function calls
 N FLDIX ; ---- field index on @XYMSG
 ;
 S SEGIX=$O(@XYMSG@(" "),-1)+1
 S @XYMSG@(SEGIX,0)="EVN"
 ; populate trigger event code and dates into element leaves
 S @XYMSG@(SEGIX,1,1,1,1)=XEVENT
 S @XYMSG@(SEGIX,2,1,1,1)=$$FMTHL7^XLFDT(XEVNRDT)
 S @XYMSG@(SEGIX,6,1,1,1)=$$FMTHL7^XLFDT(XEVNODT)
 F FLDIX=2,6 S STAT=$$STRIP0^MAG7UD($NA(@XYMSG@(SEGIX,FLDIX,1,1,1)))
 Q 0
 ;
MRG(XMRGICN,XYMSG) ; FUNCTION - merge ICNs
 ; input:  XMRGICN   DFN being merged from
 ;         XYMSG     name of array to which to add MRG segment
 ; output: @XYMSG    input array plus new subtree containing MRG elts
 ;         function return   0 (success) always
 ;         
 N SEGIX ; ---- segment index on @XYMSG
 N STAT ; ----- status return from function calls
 ;
 S SEGIX=$O(@XYMSG@(" "),-1)+1
 S @XYMSG@(SEGIX,0)="MRG"
 ; populate ICN info into element leaves
 S @XYMSG@(SEGIX,1,1,1,1)=XMRGICN
 S @XYMSG@(SEGIX,1,1,4,1)=$S($$ISIHS^MAGSPID():"USIHS",1:"USVHA")  ;P123
 S @XYMSG@(SEGIX,1,1,5,1)="NI"
 Q 0
 ;
OBXADT(XDFN,XYMSG) G OBXADT^MAGDHLSO ; FUNCTION - patient height/weight
 ;
PID(XDFN,XYMSG) ; FUNCTION - patient ID/demo
 ; input:  XDFN      internal entry number of the pt on gbl ^DPT
 ;         XYMSG    name of array to which to add message elts
 ; output: @XYMSG    input array plus new subtree containing PID elts
 ;         function return   0 (success) always
 ;
 N PIDARY ; --- array for segment to be returned by VistA HL7 fcn
 N HL ; ------- array containing delims, etc. expected by VistA HL7 fcn
 N MSGDMY ; --- dummy array of scalar message lines for parser
 N I ; -------- loop counter
 N IX,IX1,IX2,IX3,IX4 ; dummy indices
 N SEGIX ; ---- segment index on @XYMSG
 N NUL ; ------ null return from called function
 N MSGTREE ; -- tree of message elements to be returned by $$PARSE^MAG7UP
 N STATNUMB ; - station number
 N STAT ; ----- status return from function calls
 N PTICN ; ---- patient integration control number
 N DFN ; ---- patient internal entry number (needed for VADPT call)
 ;
 S HL("ECH")=HLECH,HL("FS")=HLFS,HL("Q")=HLQ
 S STATNUMB=$P($$SITE^VASITE(),"^",3) ; station number
 ;S STATNUMB=$E($P($$NS^XUAF4($$KSP^XUPARAM("INST")),U,2),1,3) ; station number
 ; does pt have a national ICN?
 I $L($T(IFLOCAL^MPIF001)) I $$IFLOCAL^MPIF001(XDFN)'=1 D   ;p123 - ICN is local, not national
 . S PTICN=$$GETICN^MPIF001(XDFN) ; ICR #2701
 . K:+PTICN<0 PTICN ; no ICN exists
 . Q
 ; build a dummy message including MSH, PID
 ; (MSH required for $$PARSE^MAG7UP to work)
 S MSGDMY(1)="MSH"_HLFS_HLECH
 S MSGDMY(2)=$$EN^VAFHLPID(XDFN,"5,7,8,10BN,11,19,22B"),IX=0 ; DBIA #263
 S NUL=$$PARSE^MAG7UP("MSGDMY","MSGTREE") ; parse the message
 S DFN=XDFN D PID^VADPT  ;Get patient Identifiers in VA array
 ; purge patient identifiers PID-2 thru PID-4
 F IX=2,3,4 K MSGTREE(2,IX)
 ; assign station number-dfn to PID-2
 S MSGTREE(2,2,1,1,1)=STATNUMB_"-"_XDFN
 S MSGTREE(2,2,1,2,1)=""
 S MSGTREE(2,2,1,3,1)=""
 S MSGTREE(2,2,1,4,1)=$S($$ISIHS^MAGSPID():"USIHS",1:"USVHA")  ;P123
 S MSGTREE(2,2,1,5,1)="PI"
 ; assign HRN or social security number to PID-3
 S MSGTREE(2,3,1,1,1)=$S($$ISIHS^MAGSPID():VA("PID"),1:$G(MSGTREE(2,19,1,1,1)))  ;P123
 S MSGTREE(2,3,1,2,1)=""
 S MSGTREE(2,3,1,3,1)=""
 S MSGTREE(2,3,1,4,1)=$S($$ISIHS^MAGSPID():"USIHS",1:"USVHA")  ;P123
 S MSGTREE(2,3,1,5,1)="NI"
 D:$D(PTICN)  ; use nat'l ICN (if available) as the alternate pt id in PID-4
 . S MSGTREE(2,4,1,1,1)=PTICN
 . S MSGTREE(2,4,1,2,1)="" ; no checksum (included in ICN)
 . S MSGTREE(2,4,1,3,1)="" ; no checksum (included in ICN)
 . S MSGTREE(2,4,1,4,1)=$S($$ISIHS^MAGSPID():"USIHS",1:"USVHA")  ;P123
 . S MSGTREE(2,4,1,5,1)="NI"
 . Q
 ; strip suffix, if any, off race and ethnicity codes
 F IX1=10,22 D
 . S:$G(MSGTREE(2,IX1,1,1,1))["-" MSGTREE(2,IX1,1,1,1)=$P(MSGTREE(2,IX1,1,1,1),"-",1,2)
 . Q
 ; insert PID subtree into passed-in element array
 ; this code eliminates values on intermediate (i.e., non-leaf) nodes
 S SEGIX=$O(@XYMSG@(" "),-1)+1
 S @XYMSG@(SEGIX,0)="PID" ; segment tag
 S IX1=0 F  S IX1=$O(MSGTREE(2,IX1)) Q:'IX1  D
 . S IX2=0 F  S IX2=$O(MSGTREE(2,IX1,IX2)) Q:'IX2  D
 . . S IX3=0 F  S IX3=$O(MSGTREE(2,IX1,IX2,IX3)) Q:'IX3  D
 . . . S IX4=0 F  S IX4=$O(MSGTREE(2,IX1,IX2,IX3,IX4)) Q:'IX4  D
 . . . . S @XYMSG@(SEGIX,IX1,IX2,IX3,IX4)=MSGTREE(2,IX1,IX2,IX3,IX4)
 . . . . Q
 . . . Q
 . . Q
 . Q
 S STAT=$$STRIP0^MAG7UD($NA(@XYMSG@(SEGIX,7,1,1,1))) ; strip 0's off DOB
 Q 0
 ;
PV1(XDFN,XEVN,XEVNDT,XYMSG) G PV1^MAGDHLSV ; FUNCTION - patient visit
 ;
ROL(XDFN,XYMSG) ; FUNCTION role (for physicians) - propagate from PV1
 ; assumes PV1 segment is already populated
 ; 
 ; input:  XDFN      internal entry number of the pt on gbl ^DPT
 ;         XYMSG    name of array to which to add message elts
 ; output: @XYMSG    input array plus new subtree containing PID elts
 ;         function return   0 (success) always
 ;
 N PRCTYP ; -- type of practitioner
 N NUL ; ----- null return from called function
 N SETID ; --- sequential index of ROL seg(s) in this message
 N PV1IX ; --- index of PV1 segment in message array
 N PHYSELT ; - element index of attending / referring physician on PV1 segment
 N I ; ------- scratch loop counter
 ;
 S DFN=XDFN,SETID=0
 S PV1IX="",I=0 F  S I=$O(@XYMSG@(I)) Q:'I  I @XYMSG@(I,0)="PV1" S PV1IX=I Q
 Q:'PV1IX  ; no physicians to propagate
 F PRCTYP="ATT","REF" D
 . S PHYSELT=$S(PRCTYP="ATT":7,1:8) Q:'$D(@XYMSG@(PV1IX,PHYSELT))
 . S SEGIX=$O(@XYMSG@(" "),-1)+1,SETID=SETID+1
 . S @XYMSG@(SEGIX,0)="ROL"
 . S @XYMSG@(SEGIX,1,1,1,1)=SETID
 . S @XYMSG@(SEGIX,2,1,1,1)="UP" ; receiver should always update
 . S @XYMSG@(SEGIX,3,1,1,1)=$S(PRCTYP="ATT":"AT",1:"RP")
 . M @XYMSG@(SEGIX,4)=@XYMSG@(PV1IX,PHYSELT)
 . S NUL=$$NPFON^MAG7UFO($NA(@XYMSG@(SEGIX,12)),$G(@XYMSG@(SEGIX,4,1,1,1)))
 . Q
 Q 0
