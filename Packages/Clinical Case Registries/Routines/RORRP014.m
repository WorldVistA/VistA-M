RORRP014 ;HCIOFO/SG - RPC: REGISTRY INFO & PARAMETERS ; 11/14/05 8:31am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** RETURNS THE REGISTRY INFORMATION
 ; RPC: [ROR GET REGISTRY INFO]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGISTRY      Either a registry IEN or a registry name
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, 0 is returned in the RESULTS(0) and the subsequent
 ; nodes of the RESULTS array contain the registry information.
 ; 
 ; RESULTS(0)            0
 ;
 ; RESULTS(1)            Registry
 ;                         ^01: IEN
 ;                         ^02: Name
 ;
 ; RESULTS(2)            National (0/1)
 ;
 ; RESULTS(3)            Registry Description
 ;
 ; RESULTS(4)            Last registry update date (int)
 ;
 ; RESULTS(5)            Last data extraction date (int)
 ;
 ; RESULTS(6)            Number of Active Patients
 ;
 ; RESULTS(7)            Number of Pending Patients
 ;
 ; RESULTS(8)            Registry Status
 ;                         ^01: Internal value (0-Active, 1-Inactive)
 ;                         ^02: External value
 ;
 ; RESULTS(9)            reserved
 ;
 ; RESULTS(10)           Version information
 ;                         ^01: Package version
 ;                         ^02: Latest patch number
 ;                         ^03: Date of the latest patch (int)
 ;
REGINFO(RESULTS,REGISTRY) ;
 N IENS,RC,REGIEN,RORBUF,RORERRDL,RORMSG,TMP
 D CLEAR^RORERR("REGINFO^RORRP014",1)
 ;--- Check the parameters
 S TMP=$$UP^XLFSTR($G(REGISTRY)),REGIEN=+TMP
 I TMP'=REGIEN  D:TMP?3.UNP
 . S REGIEN=$$REGIEN^RORUTL02(TMP)
 . S:REGIEN<0 TMP=$$ERROR^RORERR(REGIEN)
 I REGIEN'>0  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"REGISTRY",$G(REGISTRY))
 ;--- Initialize the variables
 K RESULTS
 ;--- Load the registry info
 S IENS=REGIEN_",",TMP=".01;.09;1;2;4;11;19.1;19.2"
 D GETS^DIQ(798.1,IENS,TMP,"I","RORBUF","RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.1,IENS)
 ;--- Registry IEN and Name
 S RESULTS(1)=REGIEN_"^"_$G(RORBUF(798.1,IENS,.01,"I"))
 ;--- National
 S RESULTS(2)=+$G(RORBUF(798.1,IENS,.09,"I"))
 ;--- Registry Description
 S RESULTS(3)=$G(RORBUF(798.1,IENS,4,"I"))
 ;--- Registry Updated Until
 S RESULTS(4)=$G(RORBUF(798.1,IENS,1,"I"))
 ;--- Data Extracted Until
 S RESULTS(5)=$G(RORBUF(798.1,IENS,2,"I"))
 ;--- Number of Active Patients
 S RESULTS(6)=+$G(RORBUF(798.1,IENS,19.1,"I"))
 ;--- Number of Pending Patients
 S RESULTS(7)=+$G(RORBUF(798.1,IENS,19.2,"I"))
 ;--- Registry Status
 S TMP=+$G(RORBUF(798.1,IENS,11,"I"))
 S $P(TMP,"^",2)=$$EXTERNAL^DILFD(798.1,11,,TMP,"RORMSG")
 S RESULTS(8)=TMP
 ;--- reserved (former Awaiting Acknowledgement)
 S RESULTS(9)=""
 ;--- Version information
 S TMP="CLINICAL CASE REGISTRIES"
 S RESULTS(10)=$$VERSION^XPDUTL(TMP),TMP=$$LAST^XPDUTL(TMP)
 S:TMP>0 $P(RESULTS(10),"^",2,3)=+TMP_"^"_$P(TMP,U,2)
 ;---
 S RESULTS(0)=0
 Q
 ;
 ;***** RETURNS LIST OF REGISTRY SELECTION RULES
 ; RPC: [ROR LIST SELECTION RULES]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; See the description of the ROR LIST SELECTION RULES remote
 ; procedure for more details.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) node
 ; indicates an error (see the RPCSTK^RORERR procedure for details).
 ;
SELRULES(RESULTS,REGIEN) ;
 N CNT,IEN,IENS,IRL,RC,RORBUF,RORLST,RORMSG
 D CLEAR^RORERR("SELRULES^RORRP014",1)
 K RESULTS  S (RESULTS(0),CNT)=0
 ;
 ;=== Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 ;
 ;=== Load the list of selection rules
 S IENS=","_REGIEN_","
 D LIST^DIC(798.13,IENS,"@;.01",,,,,"B",,,"RORLST","RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.13,IENS)
 ;
 ;=== Add rule definitions to the results
 S IRL=0
 F  S IRL=$O(RORLST("DILIST","ID",IRL))  Q:IRL'>0  D
 . K RORBUF,RORMSG
 . S NAME=RORLST("DILIST","ID",IRL,.01)
 . S IEN=$$SRLIEN^RORUTL02(NAME,".01;4",.RORBUF)  Q:IEN'>0
 . S CNT=CNT+1,RESULTS(CNT)=IEN
 . S $P(RESULTS(CNT),U,2)=$G(RORBUF("DILIST","ID",1,.01))
 . S $P(RESULTS(CNT),U,3)=$G(RORBUF("DILIST","ID",1,4))
 ;
 ;=== Success
 S RESULTS(0)=CNT
 Q
