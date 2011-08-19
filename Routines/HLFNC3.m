HLFNC3 ;AISC/SAW-Continuation of HLFNC, Additional Functions/Calls Used for HL7 Messages ;1/17/95  11:16
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
BHS(HL,BID,RESULT,SECURITY,MSA) ;Create a BHS Segment for an Outgoing HL7
 ;Batch Message
 ;
 ;This is a subroutine call with parameter passing that returns an HL7
 ;Batch Header (BHS) segment in the variable RESULT (and possibly
 ;RESULT(1) if the BHS segment is longer than 245 characters).  If the
 ;required input parameters HL or BID are missing, RESULT is returned
 ;equal to null
 ;
 ;Required Input Parameters
 ;      HL = The array of values returned by the call to INIT^HLFNC2
 ;     BID = The Batch Control ID to be included in the BHS segment.
 ;             The Batch Control ID for the batch is returned by the
 ;             call to CREATE^HLTF.
 ;  RESULT = The variable that will be returned to the calling
 ;             application as described above
 ;Optional Input Parameters
 ;SECURITY = Security to be included in field #8 of the BHS segment
 ;     MSA = Three components (separated by the HL7 component separator
 ;             character) consisting of the first three fields in the
 ;             MSA segment.  This variable is required if the message
 ;             you are building is a batch acknowledgment
 ;
 ;Check for required parameters
 I '$D(HL)#2!('$D(BID)) Q ""
 N X,X1,X2
 ;Build BHS segment from HL array variables and other input parameters
 S X="BHS"_HL("FS")_HL("ECH")_HL("FS")_HL("SAN")_HL("FS")_HL("SAF")_HL("FS")_$S($D(HL("RAN")):HL("RAN"),1:"")_HL("FS")_$S($D(HL("RAF")):HL("RAF"),1:"")_HL("FS")_$S($D(HL("DTM")):HL("DTM"),1:"")_HL("FS")
 S X=X_$S($G(SECURITY)]"":SECURITY,1:"")_HL("FS")_$E(HL("ECH"))_HL("PID")_$E(HL("ECH"))_HL("MTN")_$E(HL("ECH"))_HL("VER")_HL("FS")_HL("FS")_BID
 ;If the MSA parameter exists, insert it in pieces 11 and 12 and
 ;create new variable X1 if length of X will be greater than 245
 I $D(MSA) D
 .S $P(X,HL("FS"),12)=$P(MSA,$E(HL("ECH")),2),MSA=$P(MSA,$E(HL("ECH")))_$E(HL("ECH"))_$P(MSA,$E(HL("ECH")),3)
 .I $L(X)+$L(MSA)'>245 S $P(X,HL("FS"),10)=MSA Q
 .S X1=HL("FS")_$P(X,HL("FS"),11,12),X=$P(X,HL("FS"),1,10)
 .S X2=$L(X),X=X_$E(MSA,1,(245-X2)),X1=$E(MSA,(246-X2),245)_X1
 .S X2=$L(X) I $L(X2)<245 S X=X_$E(X1,1,(245-X2)),X1=$E(X1,(246-X2),245)
 S RESULT=X S:$L($G(X1)) RESULT(1)=X1
 Q
