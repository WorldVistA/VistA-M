HLFNC2 ;AISC/SAW-Continuation of HLFNC, Additional Functions/Calls Used for HL7 Messages ;12/17/2002  16:40
 ;;1.6;HEALTH LEVEL SEVEN;**2,26,57,59,101**;Oct 13, 1995
INIT(EID,HL,INT) ;Initialize Variables in HL array for Building a Message
 ;
 ;This is a subroutine call with parameter passing that returns an
 ;array of values in the variable specified by the parameter HL.  If no
 ;error occurs, the array of values is returned.  Otherwise, the single
 ;value HL is returned equal to the following:  error code^error message
 ;
 ;Required Input Parameters
 ;    EID = Name or IEN of the event driver or subscriber protocol in
 ;            Protocol file for which the initialization variables are
 ;            to be returned
 ;     HL = The variable in which the array of values will be returned
 ;            This parameter must be passed by reference
 ;Optional Input Parameter
 ;    INT = 1 indicates that only array values for internal DHCP
 ;            to DHCP message exchange should be initialized
 ;
 ;Check for required input parameter
 I $G(EID)="" S HL="7^Missing EID Input Parameter" Q
 I '$D(INT) S INT=0
 ;Convert EID to IEN if necessary
 I 'EID S EID=$O(^ORD(101,"B",EID,0)) I 'EID S HL="1^"_$G(^HL(771.7,1,0)) Q
 N X0,X,X1,X2
 ;Get node 770 from file 101 and node 0 from file 771
 S X0=$G(^ORD(101,EID,0))
 ;if server application is disabled quit
 I $P(X0,U,3)]"" S HL="16^"_$G(^HL(771.7,16,0)) Q
 ;if no known clients, set error but allow app to continue
 I '$D(^ORD(101,EID,775,"B")) S HL="15^"_$G(^HL(771.7,15,0))
 S X=$G(^ORD(101,EID,770)),X1=$G(^HL(771,+X,0))
 I X1']"" S HL="14^"_$G(^HL(771.7,14,0)) Q
 ;Set HL array variables
 S HL("Q")="""""",HL("FS")=$G(^HL(771,+X,"FS")),HL("ECH")=$G(^("EC")) S:HL("FS")']"" HL("FS")="^" S:HL("ECH")']"" HL("ECH")="~|\&"
 S HL("SAN")=$P(X1,"^"),HL("SAF")=$P(X1,"^",3) S:$P(X1,"^",7) HL("CC")=$P($G(^HL(779.004,$P(X1,"^",7),0)),"^")
 S HL("MTN")=$P($G(^HL(771.2,+$P(X,"^",3),0)),"^"),HL("ETN")=$P($G(^HL(779.001,+$P(X,"^",4),0)),"^")
 S:$P(X,"^",5) HL("MTN_ETN")=$P($G(^HL(779.005,+$P(X,"^",5),0)),"^")
 S HL("PID")=$S($P(X,"^",6)="D":"D",1:$P($$PARAM^HLCS2,"^",3)),HL("VER")=$P($G(^HL(771.5,+$P(X,"^",10),0)),"^")
 S:$P(X,"^",9) HL("APAT")=$P($G(^HL(779.003,$P(X,"^",9),0)),"^")
 I 'INT S:$P(X,"^",8) HL("ACAT")=$P($G(^HL(779.003,$P(X,"^",8),0)),"^")
 ;-- Set variables for backwards compatablity
 S HLQ=HL("Q"),HLFS=HL("FS"),HLECH=HL("ECH")
 Q
MSH(HL,MID,RESULT,SECURITY) ;Create an MSH Segment for an Outgoing HL7
 ;Message
 ;
 ;This is a subroutine call with parameter passing that returns an HL7
 ;Message Header (MSH) segment in the variable RESULT (and possibly
 ;RESULT(1) if the MSH segment is longer than 245 characters).  If the
 ;required input parameters HL or MID are missing, RESULT is returned
 ;equal to null
 ;
 ;Required Input Parameters
 ;      HL = The array of values returned by the call to INIT^HLFNC2
 ;     MID = The Message Control ID to be included in the MSH segment.
 ;             The Batch Control ID for the batch is returned by the
 ;             call to CREATE^HLTF.  The application concatenates a
 ;             sequential number to the batch ID to create the MID
 ;  RESULT = The variable that will be returned to the calling
 ;             application as described above
 ;Optional Input Parameter
 ;SECURITY = Security to be included in field #8 of the MSH segment
 ;
 ;Check for required parameters
 I '$D(HL)#2!('$D(MID)) Q ""
 N X,X1,X2
 ;Build MSH segment from HL array variables and other input parameters
 S X="MSH"_HL("FS")_HL("ECH")_HL("FS")_HL("SAN")_HL("FS")_HL("SAF")_HL("FS")_$S($D(HL("RAN")):HL("RAN"),1:"")_HL("FS")_$S($D(HL("RAF")):HL("RAF"),1:"")_HL("FS")_$S($D(HL("DTM")):HL("DTM"),1:"")_HL("FS")
 S X=X_$S($G(SECURITY)]"":SECURITY,1:"")_HL("FS")_HL("MTN")_$E(HL("ECH"))_HL("ETN")
 ;Message structure component for HL7 v 2.3.1 and beyond
 S:$D(HL("MTN_ETN")) X=X_$E(HL("ECH"))_HL("MTN_ETN")
 S X=X_HL("FS")_MID_HL("FS")_HL("PID")_HL("FS")_HL("VER")
 S:$D(HL("SN")) $P(X,HL("FS"),13)=HL("SN") S:$D(HL("ACAT")) $P(X,HL("FS"),15)=HL("ACAT") S:$D(HL("APAT")) $P(X,HL("FS"),16)=HL("APAT") S:$D(HL("CC")) $P(X,HL("FS"),17)=HL("CC")
 ;If continuation pointer variable exists, insert it in piece 14 and
 ;create new variable X1 if length of X will be greater than 245
 I $D(HL("CP")) D
 .I $L(X)+$L(HL("CP"))+2'>245 S $P(X,HL("FS"),14)=HL("CP") Q
 .S $P(X,HL("FS"),14)="",X1=HL("FS")_$P(X,HL("FS"),15,17),X=$P(X,HL("FS"),1,14)
 .S X2=$L(X),X=X_$E(HL("CP"),1,(245-X2)),X1=$E(HL("CP"),(246-X2),245)_X1
 .S X2=$L(X) I $L(X2)<245 S X=X_$E(X1,1,(245-X2)),X1=$E(X1,(246-X2),245)
 S RESULT=X S:$L($G(X1)) RESULT(1)=X1
 Q
RSPINIT(EIDS,HL) ;Initialize Variables in HL array for Building a Response Message
 ;
 ;This is a subroutine call with parameter passing that returns an
 ;array of values in the variable specified by the parameter HL.  If no
 ;error occurs, the array of values is returned.  Otherwise, the single
 ;value HL is returned equal to the following:  error code^error message
 ;
 ;Required Input Parameters
 ;    EIDS = Name or IEN of the subscriber protocol in
 ;            Protocol file for which the initialization variables are
 ;            to be returned
 ;     HL = The variable in which the array of values will be returned
 ;            This parameter must be passed by reference
 ;
 ;Check for required input parameter
 I $G(EIDS)="" S HL="7^Missing EIDS Input Parameter" Q
 ;Convert EIDS to IEN if necessary
 I 'EIDS S EIDS=$O(^ORD(101,"B",EIDS,0)) I 'EIDS S HL="15^"_"Invalid Subscriber Protocol" Q
 N X0,X,X1,X2
 ;Get node 770 from file 101 and node 0 from file 771
 S X0=$G(^ORD(101,EIDS,0))
 S X=$G(^ORD(101,EIDS,770)),X1=$G(^HL(771,+$P(X,"^",2),0))
 I X1']"" S HL="15^"_"Subscriber Application Missing in Protocol File" Q
 ;Set HL array variables
 S HL("RFS")=$G(^HL(771,+$P(X,"^",2),"FS")),HL("RECH")=$G(^("EC")) S:HL("RFS")']"" HL("RFS")="^" S:HL("RECH")']"" HL("RECH")="~|\&"
 S HL("RAN")=$P(X1,"^")
 S HL("RMTN")=$P($G(^HL(771.2,+$P(X,"^",11),0)),"^"),HL("RETN")=$P($G(^HL(779.001,+$P(X,"^",4),0)),"^")
 Q
