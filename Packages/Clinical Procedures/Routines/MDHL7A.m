MDHL7A ; HOIFO/WAA - Routine to Decode HL7 for CP ;05/21/09  15:57
 ;;1.0;CLINICAL PROCEDURES;**6,11,21**;Apr 01, 2004;Build 30
 ; Reference DBIA #10035 [Supported] for DPT calls.
 ; Reference DBIA #10106 [Supported] for HLFNC calls.
 ; Reference DBIA #10062 [Supported] for VADPT6 calls.
 ; Reference DBIA #2701 [Supported] for MPIF001 calls
 ; Reference DBIA #10096 [Supported] for ^%ZOSF calls
EN ; [Procedure] Entry Point for Message Array in MSG
 N %,BID,CODE,CPT,DA,DATE,DFN,DIK,DLCO,DTO,DZ,ERRTX,EXAM,EXE,MDFLAG,FIL
 N I,ICNT,ID,IMP,J,K,LBL,LINO,LINE,LN,MDAPP,MDRTN,MG,MSG,N,NAM,NEXT,NUM
 N ORIFN,P,PID,PIEN,S,SEG,SET,SEP,MDSSN,STR,STYP,SUB,TCNT,TXT,UNIQ,SEC
 N UNITS,VA,VAL,X,XMBODY,XMDUZ,XMSUBJ,XMTO,Z,ZZ,Z1,Z2,MDERROR
 N ECODE,MDIEN,MDOBX,NUMZ,PNAM,ZCODE,MDDEV,MDD702,DEVNAME,DEVIEN,MDQFLG
 N MDIORD,MDHORD
 K ^TMP($J,"MDHL7A"),^TMP($J,"MDHL7"),^TMP($J,"MDHL7A1")
 S MDFLAG=0,MDERROR=0,MDQFLG=0,MDHORD=""
 Q:$G(HLMTIENS)=""
 S ^TMP($J,"MDHL7A1")=""
 S HLREST="^TMP($J,""MDHL7A1"")"
 S X=$$MSGIEN^MDHL7U3(HLMTIENS,HLREST) ; This code is to convert the HL7 Message **6**
 I $P(X,U)=0 D  Q
 . S DEVIEN=0,ECODE=0
 . S ERRTX=$P(X,U,2)
 . D ^MDHL7X
 . Q
 I $P(X,U)=1 D XVERT^MDHL7U3("MDHL7A1","MDHL7A")
 K HLNODE,^TMP($J,"MDHL7A1")
 ;
EN2 ; [Procedure] No Description
 S (DEVIEN,DEVNAME)="",I=0
 F I=1:1 S X=$G(^TMP($J,"MDHL7A",I)) Q:X=""  Q:$E(X,1,3)="OBX"  D
 . S:$E(X,1,3)="MSH" DEVNAME=$P(X,"|",4)
 . I DEVNAME="",HLREC("SFN")'="" S DEVNAME=HLREC("SFN")
 . I $E(X,1,3)="MSH",DEVNAME'="Instrument Manager" S DEVIEN=$O(^MDS(702.09,"B",DEVNAME,0))
 . I $E(X,1,3)="OBR" D
 .. I DEVNAME="Instrument Manager" D
 ... S DEVNAME=$P(X,"|",25)
 ... Q
 .. S MDIORD=$P(X,"|",4)
 .. S MDD702=$S(+MDIORD<1:"",1:$$GETSTDY^MDRPCOT1(MDIORD))
 .. I MDD702<1 S MDD702="" Q
 .. I MDD702>0 D  ;Validate the entry from 702 is good.
 ... I $G(^MDD(702,MDD702,0))="" S MDD702="" Q
 ... S DEVIEN=$$GET1^DIQ(702,MDD702,.11,"I")
 ... I DEVIEN<1 S DEVIEN="" ; No device defined
 ... Q
 .. Q
 . Q
 I DEVIEN="",DEVNAME'="" S DEVIEN=$O(^MDS(702.09,"B",DEVNAME,0))
 I DEVNAME="" S ERRTX="Invalid device Code" D ^MDHL7X Q
 I DEVIEN="" S ERRTX="Invalid device entry "_DEVNAME D ^MDHL7X Q
 S ZCODE=$P($G(^MDS(702.09,DEVIEN,.1)),"^",2)
 S ECODE=0,INST=DEVIEN,MDAPP=DEVNAME
 I 'INST S ERRTX="Invalid Application Code" D ^MDHL7X Q
 D INST^MDHL7U2(DEVIEN,.ECODE) I 'ECODE D  Q
 . S ERRTX="Device Error" D ^MDHL7X
 . Q
 I (ZCODE="M")!(ZCODE="B") D  Q:MDERROR  Q:ZCODE="M"  ;
 . S MDFLAG=1,MDERROR=0 ; Tell Medicine that CP is talking to HL7
 . D ^MDHL7MCA ; Run the Medicine routines
 . Q:MDERROR  ; Medicine found an error and sent an error back
 . Q
 S NUMZ=$O(^TMP($J,"MDHL7A",""),-1)
 S NUM=0,MDOBX=0
 F NUM=1:1:NUMZ  D  Q:$G(ERRTX)'=""
 . S LINO=^TMP($J,"MDHL7A",NUM)
 . S SEC=$P(LINO,"|")
 . I SEC="MSH" D MSH Q
 . I SEC="PID" D PID Q
 . I SEC="OBR" D OBR Q
 . I SEC="PV1" Q
 . I SEC="ORC" Q
 . I SEC="OBX" S MDOBX=1 Q
 . Q
 Q:$G(ERRTX)'=""
 I 'MDOBX S ERRTX="OBX not found when expected" D ^MDHL7X Q
 D OBX
 D STATUS(MDIEN,"P")
 K ^TMP($J,"MDHL7A"),^TMP($J,"MDHL7")
 Q
STATUS(DA,STAT) ; Update the status of the report in 703.1
 Q:$G(ERRTX)'=""
 S $P(^MDD(703.1,DA,0),U,9)=STAT
 S DIK="^MDD(703.1," D IX1^DIK
 Q
IM ;Instrument Manager Interface
 Q:DEVNAME'="Instrument Manager"
 I $E(X,1,3)'="OBR" Q
 S DEVNAME=$P(X,"|",25)
 S DEVIEN=$O(^MDS(702.09,"B",DEVNAME,0))
 Q
 ;
MSH ; [Procedure] Decode MSH
 N SEG
 I '$D(^TMP($J,"MDHL7A",NUM)) Q
 S X=$G(^TMP($J,"MDHL7A",NUM)),SEG("MSH")=X
 I $E(X,1,3)'="MSH" S ERRTX="MSH not first record" D ^MDHL7X Q
 Q
 ;
OBR ; [Procedure] Check OBR
 Q:$G(MDHORD)'=""
 N MDGMRC
 S X=$G(^TMP($J,"MDHL7A",NUM)) I $E(X,1,3)'="OBR" S ERRTX="OBR not found when expected" D ^MDHL7X Q
 S SEG("OBR")=X
 S MDIORD=$P(X,"|",4)
 S MDD702=$S(+MDIORD<1:"",1:$$GETSTDY^MDRPCOT1(MDIORD)) S:MDHORD="" MDHORD=MDD702
 S:MDD702="" MDD702=MDHORD
 I MDD702'="" S MDD702=$$CHK^MDNCHK(MDD702) ; PATCH 11
 S ORIFN=$P(X,"|",3),(EXAM,%)=$P(X,"|",5) I EXAM'="" S EXAM=$P(%,"^",2) I EXAM="" S EXAM=$P(%,"^",1)
 S CPT=$P(X,"|",5) I $P(CPT,"^",3)["CPT" S CPT=$P(CPT,"^",1)
 S DTO="",DATE=$P(X,"|",8) I DATE'="" S:$L(DATE)>14 DATE=$E(DATE,1,14) S DTO=$$FMDATE^HLFNC(DATE)
 ;  vvv== Added to address the issues of mismatch
 I $G(MDD702)>0 I DFN'=$$GET1^DIQ(702,MDD702,.01,"I") S ERRTX="Patient name Mismatch. Name in PID doesn't match the name in the CP Order #"_MDD702_"." D ^MDHL7X Q
 I $G(MDD702)>0 I MDDOB'=$$GET1^DIQ(2,DFN,.03,"I") S ERRTX="Patient DOB Mismatch. DOB in PID doesn't match the DOB in the CP Order #"_MDD702_"." D ^MDHL7X Q
 I DTO="" S ERRTX="Missing required Date/Time of Procedure in OBR" D ^MDHL7X Q
 ;;S UNIQ=$TR($H,",","-")
 S UNIQ=$$NEWID(DFN,DATE,INST,$G(MDD702),HLMTIEN)
 I +UNIQ="-1" S ERRTX="Unable to Create or Lock 703.1" D ^MDHL7X Q
 S MDIEN=$P(UNIQ,"^",1) ; Got the IEN for 703.1
 N SET S SET=DTO_"^"_$P(UNIQ,U,2),ICNT=0 N IMP
 S MDRTN=$P($G(^MDS(702.09,INST,.1)),"^",1) S:MDRTN'["^" MDRTN="^"_MDRTN
 S X=MDRTN S:X["^" X=$P(X,"^",2) X ^%ZOSF("TEST") I '$T S ERRTX="Processing routine not found" D ^MDHL7X Q  ; IA %10096
 D CPTICD^MDHL7U3(X,MDIEN) ; Update CPT and ICD9
 D PHY^MDHL7U3(X,MDIEN) ; Get Doc who did the procedure.
 Q
 ;
PID ; [Procedure] Check PID
 S X=$G(^TMP($J,"MDHL7A",NUM)) I $E(X,1,3)'="PID" S ERRTX="PID not second record" D ^MDHL7X Q
 S SEG("PID")=X
 S MDDOB=$P(X,"|",8) I MDDOB'="" S MDDOB=($E(MDDOB,1,4)-1700)_$E(MDDOB,5,8)
 I $L($P(X,"|",4))'<16 D  I +DFN=-1 Q
 . N ICN
 . S ICN=$P(X,"|",4)
 . S DFN=$$GETDFN^MPIF001(ICN)
 . I +DFN=-1 S ERRTX=$P(DFN,U,2)
 . D MDSSN I DFN<1 S ERRTX="SSN not found" D ^MDHL7X Q
 . I DFN>0 K ERRTX
 . S MDSSN=$$GET1^DIQ(2,DFN,.09,"I") I MDSSN="" S MDSSN=" ",DFN=0
 . Q
 E  D MDSSN
 I 'DFN S ERRTX="SSN not found" D ^MDHL7X Q
 S Z1=$P($G(^DPT(DFN,0)),",",1),Z2=$P(NAM,"^",1)
 S Z1=$TR(Z1,"abcdefghijklmnopqrstuvwxyz- '","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S Z2=$TR(Z2,"abcdefghijklmnopqrstuvwxyz- '","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I $E(Z1,1,3)'=$E(Z2,1,3) S ERRTX="Last Name MisMatch" D ^MDHL7X Q
 S PNAM=$TR(NAM,"^",",")
 D PID^VADPT6 S PID=$G(VA("PID")),BID=$G(VA("BID")) N VA
 Q
MDSSN ; This subroutine is to match up the SSN for a patient.
 S NAM=$P(X,"|",6),MDSSN=$P(X,"|",20) I $L(MDSSN)<9 S MDSSN=$P(X,"|",4)
 S MDSSN=$P(MDSSN,"^",1) I MDSSN'?9N S MDSSN=$TR(MDSSN,"- ","")
 I $E(MDSSN,$L(MDSSN))="P" S MDSSN=$E(MDSSN,1,9)
 S:MDSSN'?9N MDSSN=" " S DFN=$O(^DPT("SSN",MDSSN,0))
 I 'DFN S DFN=$O(^DPT("SSN",MDSSN_"P",0))
 Q
 ;
OBX ; [Observation]
 D @MDRTN
 Q
NEWID(DFN,DATE,INST,MDD702,HLMTIEN) ; Generate a new entry and ID of 703.1
 N NEWID,MDFDA,MDIEN,MDNO,MDRECI
 S NEWID=$TR($H,",","-")  ; Create inital ID
 L +(^MDD(703.1,"B")):60 E  Q "-1"
 ;^^--- Unable to get a lock in the file
 F  Q:'$D(^MDD(703.1,"B",NEWID))  H 1 S NEWID=$TR($H,",","-")
 ;^^--- Search to create a new ID if current ID is in use
 S MDFDA(703.1,"+1,",.01)=NEWID
 S MDFDA(703.1,"+1,",.02)=DFN
 S MDFDA(703.1,"+1,",.03)=$$HL7TFM^MDHL7U(DATE)
 S MDFDA(703.1,"+1,",.04)=INST
 S MDFDA(703.1,"+1,",.05)=MDD702
 S MDFDA(703.1,"+1,",.06)=HLMTIEN
 D UPDATE^DIE("","MDFDA","MDIEN")
 L -(^MDD(703.1,"B"))
 I $G(MDIEN(1))>0 D  Q MDIEN(1)_U_NEWID
 . S ^MDD(703.1,MDIEN(1),.1,0)="^703.11S^0^0"
 . S MDRECI=+MDIEN(1)
 . S MDNO=$$NTIU^MDRPCW1(+MDD702,+MDRECI)
 . Q
 ; ^^--- Create Subfile and quit
 Q "-1"  ; Unable to create file
 ;
PROC ; [Procedure] Create report entry in file (703.1)
 D PROC^MDHL7U
 Q
