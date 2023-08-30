VPREHL7 ;ALB/MJK,MKB - VPR HL7 Message Processor ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,14,30**;Sep 01, 2011;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; RMIM DRIVER                   6990
 ; VAFC ADT-A08 SERVER           4418
 ; DIQ                           2056
 ; MPIF001                       2701
 ; XLFDT                        10103
 ;
 ; Note: These variables are provided by the VistA HL7 system when a
 ;       subscriber protocol's ROUTING LOGIC is called:
 ;            - HLNEXT
 ;            - HLQUIT
 ;            - HLNODE
 ;            - HLFS
 ;            - HLECH
 ;
ADT ; -- main entry point for these VPR ADT client/router protocols:
 ;          - VPR ADT-A08 CLIENT protocol
 ;             o  subscribes to VAFC ADT-A08 SERVER 
 ;
 ; -- Posts A08 events for patient demographics changes
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
 . . ;I VPREVT="A04" Q  ;no longer tracking registration events
 . . ; -- 97 reason = sensitive patient change occurred
 . . I VPREVT="A08" Q  ;,$P(HLNODE,HLFS,5)=97 Q  ;P14: all updates
 . . ; -- not an event VPR is interested in so done with message
 . . S DONE=1
 . ; -- PID segment always comes after EVN segment
 . I VPRSEG'="PID" Q
 . S DONE=1
 . ; -- VPREVT should always be defined at this point
 . I $G(VPREVT)="" Q
 . S DFN=+$P($P(HLNODE,HLFS,4),$E(HLECH))
 . I 'DFN Q
 . D QUE^VPRHS(DFN)
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
 . S DFN=+$P(HLNODE,HLFS,4) Q:DFN<1
 . S CASE=+$P($P(HLNODE,HLFS,5),$E(HLECH),2)
 . D POST^VPRHS(DFN,"Problem",CASE_";783")
 Q
 ;
PRF ; -- main entry point for these VPR PRF client/router protocols:
 ;          - VPR DGPF EVENTS protocol
 ;             o  subscribes to DGPF PRF ORU/R01 EVENT
 ;
 Q  ;replaced by new DGPF PRF EVENT protocol
 N DONE,VPRSEG,ICN,DFN,ID,STS,ACT
 S DONE=0
 F  X HLNEXT Q:HLQUIT'>0  D  Q:DONE
 . S VPRSEG=$E(HLNODE,1,3)
 . ;
 . I VPRSEG="PID" D  Q
 . . S ICN=$P($P(HLNODE,HLFS,4),$E(HLECH))
 . . S DFN=$$GETDFN^MPIF001(ICN)
 . . I DFN<1 S DONE=1
 . ;
 . I VPRSEG="OBR" D  Q
 . . S ID=+$P($P(HLNODE,HLFS,5),$E(HLECH))
 . . I ID<1 S DONE=1
 . ;
 . I VPRSEG'="OBX" Q
 . I $P(HLNODE,HLFS,3)'="ST" Q
 . S DONE=1 Q:$G(DFN)<1  Q:$G(ID)<1
 . S STS=$P(HLNODE,HLFS,6),ACT=$S(STS["INACT":"@",STS["ERROR":"@",1:"")
 . ;I STS="@" D POST^VPRHS(DFN,"Alert") Q  ;rebuild container
 . D POST^VPRHS(DFN,"Alert",ID_"~"_DFN_";26.13",ACT)
 Q
 ;
PSO ; -- main entry point for these VPR PRF client/router protocols:
 ;          - VPR PSO VDEF EVENTS protocol
 ;             o  subscribes to PSO VDEF RDS O13 OP PHARM PREF VS 
 ;             o  subscribes to PSO VDEF RDS O13 OP PHARM PPAR VS 
 ;
 N DONE,VPRSEG,ICN,DFN,ID,NOW,ORDER
 S DONE=0,NOW=$$NOW^XLFDT
 F  X HLNEXT Q:HLQUIT'>0  D  Q:DONE
 . S VPRSEG=$E(HLNODE,1,3)
 . ;
 . I VPRSEG="PID" D  Q
 . . S ICN=$P(HLNODE,HLFS,3)
 . . S DFN=$$GETDFN^MPIF001(ICN)
 . . I DFN<1 S DONE=1
 . ;
 . I VPRSEG'="ORC" Q
 . S ID=+$P($P(HLNODE,HLFS,4),$E(HLECH))
 . S DONE=1 Q:$G(DFN)<1  Q:$G(ID)<1
 . S ORDER=$$GET1^DIQ(52,ID,39.3,"I")
 . D:ORDER POST^VPRHS(DFN,"Medication",ORDER_";100")
 Q
