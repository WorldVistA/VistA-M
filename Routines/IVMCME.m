IVMCME ;ALB/SEK,BRM,TDM - DCD INCOME TEST EDIT CHECK DRIVER ; 3/22/06 4:12pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,49,58,115**;21-OCT-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will perform edit checks to validate income tests
 ; which are transmitted to DHCP from that Data Collection Division
 ; of the IVM Center.  Any errors will be recorded and will be sent
 ; automatically to the IVM Center for processing.
 ;
 ; This routine is called from IVMCM1.
 ;
 ; Required Input:
 ;   The global array ^TMP($J,"IVMCM" which contains the income test
 ;   The local variable IVMTYPE, which may be:
 ;       1 - Means Test
 ;       2 - Copay Test
 ;       3 - Income Screening information only
 ;       4 - Long Term Care Test
 ;
 ; Output:
 ;   IVMMTERR as error condition found (free text)
 ;
EN() ; Entry point to begin edit checks.
 ;
 N ARRAY,DEP,ERROR,I,IEN,SPOUSE,STRING,TYPE,X,Y
 S ERROR=""
 ;
 I '$G(IVMTYPE) S ERROR="Income Test Type not Specified" G ENQ
 ;
 ; - build strings for the veteran
 S SPOUSE=0,DEP=1
 ;S ARRAY("PID")=$$CLEAR($G(^TMP($J,"IVMCM","PIDV")))
 S X=0 F  S X=$O(^TMP($J,"IVMCM","PIDV",X)) Q:X=""  D
 .I $D(^TMP($J,"IVMCM","PIDV",X))=1 D
 ..S ARRAY("PID",X)=$$CLEAR(^TMP($J,"IVMCM","PIDV",X))
 .I $D(^TMP($J,"IVMCM","PIDV",X))=10 D
 ..S Y=0 F  S Y=$O(^TMP($J,"IVMCM","PIDV",X,Y)) Q:Y=""  D
 ...S ARRAY("PID",X,Y)=$$CLEAR(^TMP($J,"IVMCM","PIDV",X,Y))
 ;
 S ARRAY("ZIC")=$$CLEAR($G(^TMP($J,"IVMCM","ZICV"))),$P(ARRAY("ZIC"),HLFS,21)=$$TOTAL(ARRAY("ZIC"))
 S ARRAY("ZIR")=$$CLEAR($G(^TMP($J,"IVMCM","ZIRV")))
 ;
 ; - build strings for spouse as dependent
 S ARRAY(DEP,"ZDP")=$$CLEAR($G(^TMP($J,"IVMCM","ZDPS")))
 S ARRAY(DEP,"ZIC")=$$CLEAR($G(^TMP($J,"IVMCM","ZICS")))
 S ARRAY(DEP,"ZIR")=$$CLEAR($G(^TMP($J,"IVMCM","ZIRS")))
 D ADJ
 ;
 ; - build strings for children as dependents
 S IEN=0 F  S IEN=$O(^TMP($J,"IVMCM","ZDPC",IEN)) Q:'IEN  D
 . S DEP=DEP+1
 . S ARRAY(DEP,"ZDP")=$$CLEAR($G(^TMP($J,"IVMCM","ZDPC",IEN)))
 . S ARRAY(DEP,"ZIC")=$$CLEAR($G(^TMP($J,"IVMCM","ZICC",IEN)))
 . S ARRAY(DEP,"ZIR")=$$CLEAR($G(^TMP($J,"IVMCM","ZIRC",IEN)))
 . D ADJ
 ;
 ; - build income test string and check for errors
 S ARRAY("ZMT")=$$CLEAR($G(^TMP($J,"IVMCM","ZMT"_IVMTYPE)))
 S ERROR=$$CHECK()
ENQ Q ERROR
 ;
 ;
CHECK() ; check validity of transmission data
 ;
 ; Output:  error message (first one found)
 ;
 N ERROR,IEN
 S ERROR=$$ZIC^IVMCME2(ARRAY("ZIC"))
 I ERROR']"" S ERROR=$$ZIR^IVMCME1(ARRAY("ZIR"))
 I ERROR']"","^1^2^4^"[("^"_IVMTYPE_"^") S ERROR=$$ZMT^IVMCME4(ARRAY("ZMT"))
 I ERROR']"" F IEN=0:0 S IEN=$O(ARRAY(IEN)) Q:'IEN  D  I ERROR]"" G CHECKQ ; check dependent segments
 . S ERROR=$$ZDP^IVMCME3(ARRAY(IEN,"ZDP"),IEN)
 . I ERROR']"" S ERROR=$$ZIC^IVMCME2(ARRAY(IEN,"ZIC"),IEN)
 . I ERROR']"" S ERROR=$$ZIR^IVMCME1(ARRAY(IEN,"ZIR"),IEN)
CHECKQ Q ERROR
 ;
 ;
CLEAR(NODE) ; convert HLQ to null
 N I
 F I=1:1:$L(NODE,HLFS) I $P(NODE,HLFS,I)=HLQ S $P(NODE,HLFS,I)=""
 Q NODE
 ;
 ;
TOTAL(STRING,INCR,DEP) ; append total on the end
 N I,D,N,INC,DEB,NET S (INC,DEB,NET)=""
INC ; income
 I $D(INCR),$P($G(DEP),HLFS,6)'=2,'$P(INCR,HLFS,9) S INC=0 G DEBT
 F I=3:1:12 S INC=$G(INC)+$P(STRING,HLFS,I)
DEBT ; debts
 F I=13:1:15 S DEB=$G(DEB)+$P(STRING,HLFS,I)
NET ; net worth
 F I=16:1:19 I $P(STRING,HLFS,I)]"" S NET=$G(NET)+$P(STRING,HLFS,I)
 I NET]"" S NET=NET-$P(STRING,HLFS,20)
 Q INC_HLFS_DEB_HLFS_NET
 ;
 ;
ADJ ; Adjust spouse dependent's strings
 I $P(ARRAY(DEP,"ZDP"),HLFS,6)=2,$P(ARRAY(DEP,"ZDP"),HLFS,2,4)'="^^" S SPOUSE=DEP
 I $P(ARRAY(DEP,"ZDP"),HLFS,6)=2,$P(ARRAY(DEP,"ZDP"),HLFS,2,4)="^^" K ARRAY(DEP) S DEP=DEP-1
 I DEP S $P(ARRAY(DEP,"ZIC"),HLFS,21)=$$TOTAL(ARRAY(DEP,"ZIC"),ARRAY(DEP,"ZIR"),ARRAY(DEP,"ZDP"))
 Q
