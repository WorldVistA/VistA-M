MPIFQUE5 ;SF/TNV-Process the RESULT from CMOR COMPARISON request ;FEB 20, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,6,11**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;
 ;  EXC^RGHLLOG     IA #2796
 ;  START^RGHLLOG   IA #2796
 ;  STOP^RGHLLOG    IA #2796
 ;
 ; This routine will process the message from the CMOR site to change
 ; the CMOR as a result of a change cmor request
 ;
EN ; Entry point for process the update of CMOR
 N U,LINE,IKI,ERROR,RGL,RGLOG
 S U="^"
 D START^RGHLLOG()
 ;
 N MPII,U,LINE,ERROR,PARENT,COUNT,NDATE,IKI,MPIFFS,MPIFSFS,MPIFREAP,RGLOG
 F MPII=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S LINE=HLNODE
 . I $P(LINE,HL("FS"))["MSH" D MSH
 . I $P(LINE,HL("FS"))["PV1" D PV1
 . I $P(LINE,HL("FS"))["PID" D PID
 I $G(ERROR)]"" D ACK Q          ; Any problems before changing the CMOR
 I ($G(SITE)]"")&($G(DFN)]"") D CHANGE
 I $G(SITE)=""!($G(DFN)="") D
 .S ERROR="Missing new CMOR or Patient to be changed"
 .D EXC^RGHLLOG(219,ERROR_" for change CMOR request HL7 msg "_$G(HL("MID")))
 D ACK
 Q
 ;
MSH ; Process MSH segment
 I $P(LINE,HL("FS"),16)="AL" S ACK="YES"
 I $P(LINE,HL("FS"),16)="ER" S ACK="ERROR"
 Q
 ;
PV1 ; Process PV1 segment
 S SITE=$P(LINE,HL("FS"),4)
 I SITE="" S ERROR="Missing CMOR site number in Change CMOR message for ICN "_ICN_" HL7 msg# "_$G(HL("MID")) D EXC^RGHLLOG(221,ERROR)
 Q
NTE ; Process NTE segment
 S SITE=$P(LINE,HL("FS"),8)
 I SITE="" S ERROR="Missing CMOR site number in Change CMOR message for ICN "_ICN_" HL7 msg# "_$G(HL("MID")) D EXC^RGHLLOG(221,ERROR)
 Q
 ;
PID ; Process PID segment
 S ICN=+$P(LINE,HL("FS"),3)                  ; get ICN out.
 I ICN<1 S ERROR="Missing Patient ICN in Change CMOR message HL7 msg# "_$G(HL("MID")) D EXC^RGHLLOG(219,ERROR) Q
 S DFN=$$IEN^MPIFNQ(ICN)                  ; get DFN of this patient
 I DFN="" S ERROR="ICN "_ICN_" not found from Change CMOR message HL7 msg# "_$G(HL("MID")) D EXC^RGHLLOG(219,ERROR) Q
 Q
 ;
CHANGE ; Process the change CMOR to the new CMOR site (YOUR SITE NOW)
 S DIC="^DIC(4,",DIC(0)="QMOZX",X=SITE D ^DIC K DIC          ; Figure out
 I Y=-1 S ERROR="CMOR Site name is not on file for Station Number "_SITE_" processing Change CMOR msg for ICN "_ICN D EXC^RGHLLOG(211,ERROR,DFN) Q            ; the CMOR site
 S CHANGE=$$CHANGE^MPIF001(+DFN,+Y)              ; name and change
 I +CHANGE=-1 S ERROR="Unable to update CMOR for site "_SITE_". For DFN "_DFN_" Processing CHANGE CMOR message "_HLMTIEN D EXC^RGHLLOG(211,ERROR,DFN)
 Q
 ;
ACK ; Clean up the partition.
 ;
 D STOP^RGHLLOG()
 K X,Y,DFN,ICN,SITE,MPIFREAP,ACK,PARENT,CHANGE
 Q
