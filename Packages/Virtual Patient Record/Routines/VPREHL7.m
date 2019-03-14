VPREHL7 ;ALB/MJK,MKB - VPR HL7 Message Processor ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8**;Sep 01, 2011;Build 87
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DGPF PRF ORU/R01 EVENT
 ; RMIM DRIVER                   6990
 ; VAFC ADT-A08 SERVER           4418
 ; MPIF001                       2701
 ;
 ; Note: These variables are provided by the VistA HL7 system when a
 ;       subscriber protocol's ROUTING LOGIC is called:
 ;            - HLNEXT
 ;            - HLQUIT
 ;            - HLNODE
 ;            - HL("FS")
 ;            - HL("ECH")
 ;
ADT ; -- main entry point for these VPR ADT client/router protocols:
 ;          - VPR ADT-A08 CLIENT protocol
 ;             o  subscribes to VAFC ADT-A08 SERVER 
 ;
 ; -- Filters A08 events for patient security level changes
 ;    Scans for PID segment and uses embedded DFN
 ;    Sets ^VPR("AVPR"... freshness queue
 ;
 N DONE,VPRSEG,VPREVT,DFN
 S DONE=0
 F  X HLNEXT Q:HLQUIT'>0  D  Q:DONE
 . S VPRSEG=$E(HLNODE,1,3)
 . ;
 . I VPRSEG="EVN" D  Q
 . . S VPREVT=$P(HLNODE,HLFS,2)
 . . ;I VPREVT="A04" Q
 . . ; -- 97 reason = sensitive patient change occurred
 . . I VPREVT="A08",$P(HLNODE,HLFS,5)=97 Q
 . . ; -- not an event VPR is interested in so done with message
 . . S DONE=1
 . ; -- PID segment always comes after EVN segment
 . I VPRSEG'="PID" Q
 . S DONE=1
 . ; -- VPREVT should always be defined at this point
 . I $G(VPREVT)="" Q
 . S DFN=+$P($P(HLNODE,HL("FS"),4),$E(HL("ECH")))
 . I 'DFN Q
 . D POST^VPRHS(DFN,"Patient",DFN_";2")
 Q
 ;
FIM ; -- main entry point for these VPR RMIM client/router protocols:
 ;          - VPR RMIM EVENTS protocol
 ;             o  subscribes to RMIM DRIVER
 ;
 N DONE,VPRSEG,DFN,CASE
 S DONE=0
 F  X HLNEXT Q:HLQUIT'>0  D  Q:DONE
 . S VPRSEG=$E(HLNODE,1,3)
 . ;
 . I VPRSEG'="PID" Q
 . S DONE=1
 . S DFN=+$P(HLNODE,HL("FS"),4) Q:DFN<1
 . S CASE=+$P($P(HLNODE,HL("FS"),5),$E(HL("ECH")),2)
 . D POST^VPRHS(DFN,"Problem",CASE_";783")
 Q
 ;
PRF ; -- main entry point for these VPR PRF client/router protocols:
 ;          - VPR DGPF EVENTS protocol
 ;             o  subscribes to DGPF PRF ORU/R01 EVENT
 ;
 N DONE,VPRSEG,ICN,DFN,ID,STS
 S DONE=0
 F  X HLNEXT Q:HLQUIT'>0  D  Q:DONE
 . S VPRSEG=$E(HLNODE,1,3)
 . ;
 . I VPRSEG="PID" D  Q
 . . S ICN=$P($P(HLNODE,HL("FS"),4),$E(HL("ECH")))
 . . S DFN=$$GETDFN^MPIF001(ICN)
 . . I DFN<1 S DONE=1
 . ;
 . I VPRSEG="OBR" D  Q
 . . S ID=+$P($P(HLNODE,HL("FS"),5),$E(HL("ECH")))
 . . I ID<1 S DONE=1
 . ;
 . I VPRSEG'="OBX" Q
 . I $P(HLNODE,HL("FS"),3)'="ST" Q
 . S DONE=1 Q:$G(DFN)<1  Q:$G(ID)<1
 . S STS=$P(HLNODE,HL("FS"),6),STS=$S(STS["INACT":"@",STS["ERROR":"@",1:"")
 . I STS="@" D POST^VPRHS(DFN,"Alert") Q  ;rebuild container
 . D POST^VPRHS(DFN,"Alert",ID_"~"_DFN_";26.13")
 Q
