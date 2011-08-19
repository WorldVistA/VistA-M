RORRP013 ;HCIOFO/SG - RPC: ACCESS & SECURITY ; 11/9/05 8:56am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** RETURNS A LIST OF REGISTRIES ACCESSIBLE TO THE GUI USER
 ; RPC: [ROR GUI ACCESS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [USER]        User IEN in the NEW PERSON file. By default
 ;               (if $G(USER)'>0), the DUZ is used).
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ; 
 ; RESULTS(0)            Number of accessible registries
 ;
 ; RESULTS(i)            Registry descriptor
 ;                         ^01: Registry IEN
 ;                         ^02: Registry name
 ;                         ^03: Administrator? (0 or 1)
 ;                         ^04: Short description
 ;
ACREGLST(RESULTS,USER) ;
 N ADMIN,CNT,IENS,KEY,RC,REGIEN,RORBUF,RORERRDL,RORMSG,TMP
 K RESULTS  S RESULTS(0)=0
 D CLEAR^RORERR("ACREGLST^RORRP013",1)
 ;--- Check the version of the GUI
 I $G(XWBAPVER)<1.5  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . N DIERR,DIHELP,DIMSG
 . S TMP("CV")=$S($G(XWBAPVER)>0:XWBAPVER,1:"1.0")
 . S TMP("RV")="1.5"
 . D BLD^DIALOG(7980000.006,.TMP,,"RORBUF")
 . S RC=$$ERROR^RORERR(-107,,.RORBUF)
 . K RORBUF,TMP
 ;--- User must be defined
 I $G(USER)'>0  S USER=+$G(DUZ)  Q:USER'>0
 ;
 S (CNT,RC,REGIEN)=0
 F  S REGIEN=$O(^ROR(798.1,"ACL",USER,REGIEN))  Q:REGIEN=""  D  Q:RC<0
 . Q:REGIEN'>0  S IENS=REGIEN_","  K RORBUF
 . D GETS^DIQ(798.1,IENS,".01;4",,"RORBUF","RORMSG")
 . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,,798.1,IENS)  Q
 . ;--- Add the registry descriptor to the list
 . S CNT=CNT+1,RESULTS(CNT)=REGIEN_"^"_$G(RORBUF(798.1,IENS,.01))
 . S $P(RESULTS(CNT),"^",4)=$G(RORBUF(798.1,IENS,4))
 . ;--- Check if the user has the administrator security key
 . S KEY="",ADMIN=0
 . F  S KEY=$O(^ROR(798.1,"ACL",USER,REGIEN,KEY))  Q:KEY=""  D  Q:RC<0
 . . I KEY?1"ROR"1.E  S:KEY["ADMIN" ADMIN=1
 . S $P(RESULTS(CNT),"^",3)=ADMIN
 ;
 I RC'<0  D:CNT'>0  S RESULTS(0)=CNT
 . D ACVIOLTN^RORLOG(-91)  ; Record the access violation
 E  D RPCSTK^RORERR(.RESULTS,RC)
 Q
 ;
 ;***** RETURNS THE LIST OF ACCESS VIOLATIONS
 ; RPC: [ROR LOG GET ACCESS VIOLATIONS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [STDT]        Start date (by default, from the earliest violation)
 ; [ENDT]        End date (by default, to the latest violation)
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, number of logs is returned in the RESULTS(0) and the
 ; subsequent nodes of the RESULTS array contain the violations.
 ; 
 ; @RESULTS@(0)          Number of access violations
 ;
 ; @RESULTS@(i)          Access violation descriptor
 ;                         ^01: Date/Time (int)
 ;                         ^02: User Name
 ;                         ^03: User IEN
 ;                         ^04: Message
 ;
AVLIST(RESULTS,STDT,ENDT) ;
 N BUF,CNT,DATE,IEN,IENS,RC,ROOT,RORBUF,RORERRDL,RORMSG
 D CLEAR^RORERR("AVLIST^RORRP013",1)
 ;--- Check the parameters
 S STDT=$G(STDT)\1,ENDT=$G(ENDT)\1
 S ENDT=$S(ENDT>0:$$FMADD^XLFDT(ENDT,1),1:9999999)
 ;--- Initialize the variables
 S ROOT=$$ROOT^DILFD(798.7,,1),CNT=0
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 ;--- Browse through the logs
 S DATE=STDT
 F  S DATE=$O(@ROOT@("B",DATE))  Q:DATE=""  Q:DATE'<ENDT  D
 . S IEN=0
 . F  S IEN=$O(@ROOT@("B",DATE,IEN))  Q:IEN'>0  D
 . . S IENS=IEN_","  K RORBUF
 . . D GETS^DIQ(798.7,IENS,".01;1;7","EI","RORBUF","RORMSG")
 . . Q:$G(DIERR)
 . . ;--- Check for the 'Access Violation' Activity
 . . Q:$G(RORBUF(798.7,IENS,1,"I"))'=6
 . . ;--- Date/Time of the event
 . . S BUF=$G(RORBUF(798.7,IENS,.01,"I"))
 . . ;--- User Name (ext)
 . . S $P(BUF,"^",2)=$G(RORBUF(798.7,IENS,7,"E"))
 . . ;--- User IEN (int)
 . . S $P(BUF,"^",3)=$G(RORBUF(798.7,IENS,7,"I"))
 . . ;--- Message
 . . S $P(BUF,"^",4)=$$GET1^DIQ(798.74,"1,"_IENS,2,,,"RORMSG")
 . . ;--- Add the record to the output
 . . S CNT=CNT+1,@RESULTS@(CNT)=BUF
 ;--- Number of violations
 S @RESULTS@(0)=CNT
 Q
 ;
 ;***** ADDS THE USERS WHO HAVE THE SECURITY KEY TO THE LIST
 ;
 ; KEYNAME       Name of the security key
 ; ACCESS        Level of the user access to the registry
 ;               (1-User, 2-Administrator, 3-IRM)
 ;
 ; Return Values:
 ;
KLIST(KEYNAME,ACCESS) ;
 N IEN  S IEN=0
 F  S IEN=$O(^XUSEC(KEYNAME,IEN))  Q:IEN'>0  D
 . S $P(@RORULST@(IEN,0),"^",ACCESS)=1
 Q
 ;
 ;***** RETURNS THE LIST OF REGISTRY USERS
 ; RPC: [ROR GET REGISTRY USERS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, number of users is returned in the RESULTS(0) and the
 ; subsequent nodes of the RESULTS array contain the users.
 ; 
 ; @RESULTS@(0)          Number of users
 ;
 ; @RESULTS@(i)          User descriptor
 ;                         ^01: User IEN (DUZ)
 ;                         ^02: User Name
 ;                         ^03: User          (0/1)
 ;                         ^04: Administrator (0/1)
 ;                         ^05: IRM           (0/1)
 ;
USERLIST(RESULTS,REGIEN) ;
 N ACCESS,ADMIN,CNT,IEN,NAME,RORERRDL,RORMSG,RORULST
 D CLEAR^RORERR("USERLIST^RORRP013",1)
 ;--- Check the parameters
 I $G(REGIEN)'>0  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 S REGIEN=+REGIEN
 ;--- Initialize the variables
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 S RORULST=$$ALLOC^RORTMP()
 ;--- Browse the security keys
 S NAME=""
 F  S NAME=$O(^ROR(798.1,REGIEN,18,"B",NAME))  Q:NAME=""  D
 . S ADMIN=(NAME?1"ROR"1.E)&(NAME["ADMIN")
 . D KLIST(NAME,$S(ADMIN:2,1:1))
 ;--- Add the authorized IRM personnel
 D KLIST("ROR VA IRM",3)
 ;--- Sort the users by their names
 S IEN=0
 F  S IEN=$O(@RORULST@(IEN))  Q:IEN'>0  D
 . S NAME=$$GET1^DIQ(200,IEN_",",.01,,,"RORMSG")
 . S:NAME'="" @RORULST@("B",NAME,IEN)=""
 ;--- Generate the output
 S NAME="",CNT=0
 F  S NAME=$O(@RORULST@("B",NAME)) Q:NAME=""  D
 . S IEN=0
 . F  S IEN=$O(@RORULST@("B",NAME,IEN)) Q:IEN'>0  D
 . . S ACCESS=$G(@RORULST@(IEN,0))
 . . S CNT=CNT+1,@RESULTS@(CNT)=IEN_"^"_NAME_"^"_ACCESS
 S @RESULTS@(0)=CNT
 ;--- Cleanup
 D FREE^RORTMP(RORULST)
 Q
