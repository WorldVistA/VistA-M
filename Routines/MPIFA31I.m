MPIFA31I ;ALB/JRP-PROCESS ADT-A31 MESSAGE FROM MPI ;03-JAN-97
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,21**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;  ^DGCN(391.91 - #2751
 ;  ^DPT("AICNL" - #2070
 ;  EXC^RGHLLOG - #2796
 ;
PROCESS(MSGARR) ;Process ADT-A31 message received from MPI when a new
 ; patient is assigned an Integration Control Number
 ;
 ;Input  : MSGARR - Array containing ADT-A31 message (full global ref)
 ;                - MSGARR must be in format compatible with interaction
 ;                  with DHCP HL7 package
 ;                    MSGARR(1) = First segment of message
 ;                    MSGARR(1,n) = Continuation node(s) for segment
 ;                    MSGARR(x) = Xth segment of message
 ;                    MSGARR(x,n) = Continuation node(s) for segment
 ;                - Defaults to ^TMP("MPIFA31",$J,"MPI-ADT-A31")
 ;Output : ICN = Successfully processed
 ;        -1^Reason = Failure
 ;Notes  : The MPI uses an ADT-A31 message to return the ICN of new
 ;         patients.  This value (seq # 2 of PID segment) is the only
 ;         information that will be stored.
 ;
 ;Check input
 S MSGARR=$G(MSGARR)
 S:(MSGARR="") MSGARR="^TMP(""MPIFA31"","_$J_",""MPI-ADT-A31"")"
 Q:(('$D(@MSGARR))!('$O(@MSGARR@(0)))) "-1^Array containing ADT-A31 message not valid"
 ;Declare variables
 N MSH,EVN,PID,SEND,RECEIVE,EVENT,REASON,SEGMENT,SEGNAME
 N ICN,ICNNUM,ICNCHECK,DFNCHECK,CHKSCHM,SSN,LOCAL,TMP,FLDSEP,HLECH
 N CMPSEP,REPSEP,ESC,SUBSEP,TMP1,TMP2
 ;Parse required segments out of message
 S (MSH,EVN,PID)=""
 S TMP=0
 F  S TMP=+$O(@MSGARR@(TMP)) Q:('TMP)  D
 .;Get segment and screen out unused segments
 .S SEGMENT=$G(@MSGARR@(TMP))
 .S SEGNAME=$E(SEGMENT,1,3)
 .S TMP1=","_SEGNAME_","
 .Q:('(",MSH,EVN,PID,"[TMP1))
 .;Use first occurrance of segment
 .Q:(@SEGNAME'="")
 .;Remember field separator if MSH segment
 .S:(SEGNAME="MSH") FLDSEP=$E(SEGMENT,4)
 .;Drop segment name and field separator for storage
 .S @SEGNAME=$E(SEGMENT,5,$L(SEGMENT))
 .;Account for rollover (begin rollover subscripting with 1)
 .S TMP1=0
 .S TMP2=1
 .F  S TMP1=+$O(@MSGARR@(TMP,TMP1)) Q:('TMP1)  D
 ..;Get/save rollover
 ..S @SEGNAME@(TMP2)=$G(@MSGARR@(TMP,TMP1))
 ..S TMP2=TMP2+1
 ;Make sure used segments were all found
 F SEGNAME="MSH","EVN","PID" Q:(@SEGNAME="")
 Q:(@SEGNAME="") "-1^Required segment ("_SEGNAME_") missing"
 ;Safety check on field separator (use DHCP default value)
 S:($G(FLDSEP)="") FLDSEP="^"
 ;Get encoding characters
 S HLECH=$P(MSH,FLDSEP,1)
 ;Component separator
 S CMPSEP=$E(HLECH,1)
 ;Repetion separator
 S REPSEP=$E(HLECH,2)
 ;Escape character
 S ESC=$E(HLECH,3)
 ;Subcomponent separator
 S SUBSEP=$E(HLECH,4)
 ;Process MSH segment
 ; - Get sending facility
 S SEND=$P(MSH,FLDSEP,3)
 ; - Get receiving facility
 S RECEIVE=$P(MSH,FLDSEP,5)
 ; - Get event type
 S EVENT=$P($P(MSH,FLDSEP,8),CMPSEP,2)
 ; - Validate information in MSH segment
 ;   - MPI is sending facility
 ;Q:(SEND'="200M") "-1^Sending facility not valid (must be '200M')"
 ;   - Receiving facility is local facility
 S TMP=+$P($$SITE^VASITE(),"^",3)
 Q:(RECEIVE'=TMP) "-1^Receiving facility not valid (must be "_TMP_")"
 ;   - Event type is A31
 Q:(EVENT'="A31") "-1^Event type not valid (must be 'A31')"
 ;Process EVN segment
 ; - Get event reason
 S REASON=$P(EVN,FLDSEP,4)
 ; - Validate information in EVN segment
 ;   - Event reason is 95
 Q:(REASON'="95") "-1^Event reason code not valid (must be '95')"
 ;Process PID segment
 ; - Get ICN & checksum & checksum scheme
 S TMP=$P(PID,FLDSEP,2)
 S ICN=$P(TMP,CMPSEP,1)
 Q:(ICN'?1.16N1"V"6N) "-1^ICN not in correct format"
 S ICNNUM=$P(ICN,"V",1)
 S ICNCHECK=$P(TMP,"V",2)
 Q:((ICNNUM="")!(ICNCHECK="")) "-1^Could not determine ICN"
 ; - Validate checksum
 Q:(ICNCHECK'=$$CHECKDG^MPIFSPC(ICNNUM)) "-1^ICN/checksum not valid"
 ; - Get DFN & checksum & checksum scheme
 S TMP=$P(PID,FLDSEP,3)
 ; - Get SSN (account for roll over)
 S SSN=""
 S TMP=$L(PID,FLDSEP)
 S TMP1=$P(PID,FLDSEP,TMP)
 S:(TMP=19) SSN=$P(PID,FLDSEP,19)_$P($G(PID(1)),FLDSEP,1)
 S:(TMP>19) SSN=$P(PID,FLDSEP,19)
 S:(TMP<19) SSN=$P($G(PID(1)),FLDSEP,((19-TMP)+1))
 ; - Validate information in PID
 ;   - Make sure DFN exists
 S LOCAL=$G(^DPT(DFN,0))
 Q:($P(LOCAL,"^",1)="") "-1^Could not locate patient (bad DFN)"
 ;   - Make sure SSNs match
 Q:($P(LOCAL,"^",9)'=SSN) "-1^DFN/SSN pairing not valid"
 ;Extra validation checks
 ; - Verify lack of national ICN
 I ($$GETICN^MPIF001(DFN)>0) Q:('$D(^DPT("AICNL",1,DFN))) "-1^National ICN already assigned to patient"
 ;Passed all validation checks - store ICN & checksum
 S TMP=$$SETICN^MPIF001(DFN,ICNNUM,ICNCHECK)
 Q:(TMP<0) "-1^Unable to store ICN and checksum"
 ;Delete local ICN flag
 S TMP=$$SETLOC^MPIF001(DFN,0)
 S TMP=$$CHANGE^MPIF001(DFN,+$$SITE^VASITE)
 N HERE,TFSITE
 S HERE=+$P($$SITE^VASITE,"^",3)
 S TFSITE=$$LKUP^XUAF4(HERE)
 Q:+TFSITE'>0 ICN
 Q:$D(^DGCN(391.91,"APAT",DFN,TFSITE)) ICN
 K DD,DO N DIC,X,Y
 S DIC="^DGCN(391.91,",DIC("DR")=".02///`"_TFSITE,X=DFN,DIC(0)="LQZ"
 D FILE^DICN
 I +Y=-1 S ^XTMP($J,"MPIF","MSHERR")="Treating Facility Add Failed" D
 .D EXC^RGHLLOG(212,"DFN= "_DFN_"  Treating Facility= "_TFSITE,DFN)
 K DD,DO,DIC,X,Y
 ;Done
 Q ICN
