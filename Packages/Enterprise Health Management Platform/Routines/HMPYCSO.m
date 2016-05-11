HMPYCSO ;SLC/MJK,ASMR/RRB - Convert system objects utility ;8/2/11  15:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; *S68-JCH* This routine introduced with S68
 Q
 ;
CONV(HMPDATA,HMPCNTS) ; -- execute conversion over a system object type
 ; input: HMPDATA("type") := object type
 ;                             - [ OPD - operational (file #800000.11) | PT - HMP (file #800000.1) / default ]
 ;
 ;         ("collection") := object collection name as it appears in "C" xref
 ;                                - ex. "task"
 ;
 ;           ("callback") := callback code to execute conversion on single object
 ;                             - callback should expect decoded array containing object to convert and IEN of object
 ;                                   - TAG^ROUTINE
 ;                                   - ex. TASK^HMPP3I
 ;                             - callback must return indicator on how to proceed
 ;                                   - 1 : update converted object
 ;                                   - 0 : stop processing this object; no conversion needed
 ;
 ;         HMPCNTS : returns array of counts related to conversion [optional]
 ;                    - closed array reference 
 ;                    - Counts:
 ;                        - HMPTALLY("converted") -> conversion performed
 ;                                  ("errored")   -> errored at some point in process
 ;                                  ("passed")    -> no conversion needed
 ;                                  ("reviewed")  -> count of objects reviewed for conversion
 ;
 N HMPTYPE,HMPCOLL,HMPCB,X,HMPFILE,HMPZCNTS
 S HMPTYPE=$G(HMPDATA("type"),"PT")
 S HMPCOLL=$G(HMPDATA("collection"))
 S HMPCB=$G(HMPDATA("callback"))
 ;
 ; - collection name and callback must be defined
 I HMPCOLL=""!(HMPCB="") Q
 ;
 I HMPTYPE'="PT",HMPTYPE'="OPD" Q
 ;
 ; -- currently only supports PT, as OPD has not been tested
 I HMPTYPE'="PT" Q
 ;
 ; -- initialize counts
 F X="reviewed","errored","converted","passed" S HMPZCNTS(X)=0
 ;
 I HMPTYPE="PT" D
 . N DFN,IEN
 . S HMPFILE=800000.1
 . S DFN=0 F  S DFN=$O(^HMP(HMPFILE,"C",DFN)) Q:DFN'>0  D
 . . S IEN=0 F  S IEN=$O(^HMP(HMPFILE,"C",DFN,HMPCOLL,IEN)) Q:IEN'>0  D CONVOBJ(HMPFILE,IEN,HMPCB)
 E  D
 . N IEN
 . S HMPFILE=800000.11
 . S IEN=0 F  S IEN=$O(^HMP(HMPFILE,"C",HMPCOLL,IEN)) Q:IEN'>0  D CONVOBJ(HMPFILE,IEN,HMPCB)
 ;
 I $G(HMPCNTS)]"" M @HMPCNTS=HMPZCNTS
 Q
 ;
CONVOBJ(HMPFILE,IEN,HMPCB) ; -- convert object
 N HMPY,HMPTEMP,ERROR,UID,I,HMP0,HMPCOLL
 S HMPY=$NA(^TMP($J,"HMPY"))
 S HMPTEMP=$NA(^TMP($J,"HMPTEMP"))
 K @HMPY,@HMPTEMP
 D TALLY("reviewed")
 ;
 S HMP0=$G(^HMP(HMPFILE,IEN,0))
 S HMPCOLL=$P(HMP0,U,3)
 S UID=$P(HMP0,U)
 I UID="" D ERROR("Error:  JSON "_HMPCOLL_" Object (IEN: "_IEN_") missing UID") Q
 ;
 S I=0 F  S I=$O(^HMP(HMPFILE,IEN,1,I)) Q:I<1  S X=$G(^(I,0)),@HMPY@(I)=X
 ;
 D DECODE^HMPJSON(HMPY,HMPTEMP,"ERROR")
 I $D(ERROR) D ERROR("Error in decoding JSON "_HMPCOLL_" Object (IEN: "_IEN_")") Q
 ;
 ; -- execute type conversion callback ; quit if object passed w/o needing conversion
 I @("'$$"_HMPCB_"(HMPTEMP,IEN)") D TALLY("passed") Q
 ;
 K @HMPY
 D ENCODE^HMPJSON(HMPTEMP,HMPY,"ERROR")
 I $D(ERROR) D ERROR("Error in encoding JSON "_HMPCOLL_" object (IEN: "_IEN_")") Q
 ;
 D MES^XPDUTL("Updating "_HMPCOLL_" uid: "_UID)
 I '$$UPDATE(HMPFILE,IEN,HMPY) D  Q
 . D ERROR("Error: Unable to obtain lock on DATA node for JSON "_HMPCOLL_" object (IEN: "_IEN_")")
 E  D
 . D TALLY("converted")
 ;
 K @HMPY,@HMPTEMP
 ;
 Q
 ;
ERROR(MSG) ; -- write out error message and inc error tally
 ;D EN^DDIOL(MSG)
 D BMES^XPDUTL(MSG)
 D TALLY("errored")
 Q
 ;
TALLY(CNTYP) ; -- inc counter
 S HMPZCNTS(CNTYP)=$G(HMPZCNTS(CNTYP))+1
 Q
 ;
UPDATE(HMPFILE,DA,JSON) ; -- update DATA wp field on patient object
 ;  input:  DA - internal entry number in 800000.1
 ;        JSON - closed array reference for M representation of object
 ; return:   1 - update successful | 0 - update not successful (unable to obtain lock)
 L +^HMP(HMPFILE,DA,1):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 I '$T Q 0
 ;
 N CNT,I,HMPSUB
 S CNT=0
 ; -- derive subfile number
 S HMPSUB=HMPFILE_$S(HMPFILE=800000.1:"01",1:"1")
 K ^HMP(HMPFILE,DA,1) S ^(1,0)="^"_HMPSUB_"^^"
 S I="" F  S I=$O(@JSON@(I)) Q:I=""  S CNT=CNT+1,^HMP(HMPFILE,DA,1,CNT,0)=@JSON@(I)
 I CNT S ^HMP(HMPFILE,DA,1,0)="^800000.101^"_CNT_U_CNT
 ;
 L -^HMP(HMPFILE,DA,1)
 Q 1
 ;
TASKCONV ; -- convert patient task objects 
 ;               - converts 'pid' property to SYSID;DFN (ex. F484;237)
 ;               - removes 'patientId' property if it exists
 ;
 N HMPAMS,HMPSTATS
 S HMPAMS("type")="PT"
 S HMPAMS("collection")="task"
 S HMPAMS("callback")="TASKCB^HMPYCSO"
 D CONV^HMPYCSO(.HMPAMS,"HMPSTATS")
 D BMES^XPDUTL("Task object conversion statistics:")
 D MES^XPDUTL("  Reviewed: "_$J($G(HMPSTATS("reviewed")),8))
 D MES^XPDUTL("    Passed: "_$J($G(HMPSTATS("passed")),8))
 D MES^XPDUTL(" Converted: "_$J($G(HMPSTATS("converted")),8))
 D MES^XPDUTL("   Errored: "_$J($G(HMPSTATS("errored")),8))
 K HMPB4
 Q
 ;
TASKCB(OBJREF,IEN) ; -- callback that converts a 'task' object's if necessary
 ;                       - converts 'pid' property to SYSID;DFN (ex. F484;237)
 ;                       - removes 'patientId' property if it exists
 ;
 ;  input: OBJREF := JSON decoded task object for DATA field in 800000.1
 ;            IEN := internal entry number in 800000.1
 ;
 ; return: 1 - task was converted | 0 - no conversion required
 ;
 N HMPOK,DFN,PID
 S HMPOK=0
 S DFN=+$P($G(^HMP(800000.1,+$G(IEN),0)),"^",2)
 I 'DFN Q 0
 S PID=$$SYS^HMPUTILS_";"_DFN
 ; -- if pid different, first kill 'pid' to get rid of possible ...,"pid","\s") node
 I $G(@OBJREF@("pid"))'=PID K @OBJREF@("pid") S @OBJREF@("pid")=PID,HMPOK=1
 I $D(@OBJREF@("patientId")) K @OBJREF@("patientId") S HMPOK=1
 Q HMPOK
