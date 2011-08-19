RORRP024 ;HCIOFO/SG - RPC: VISTA USERS ; 12/15/05 4:31pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #10060        Read access (FileMan) to the NEW PERSON file
 ;
 Q
 ;
 ;***** RETURNS THE DEFAULT DIVISION FOR THE USER
 ;
 ; USER          User IEN in file #200 (DUZ)
 ;
 ; Return Values:
 ;      ...  Default Division
 ;             ^01: IEN (in the INSTITUTION file)
 ;             ^02: Name
 ;
DFLTDIV(USER) ;
 N DIV,IENS,IR,RORBUF,RORMSG,TMP
 S IENS=","_(+USER)_",",TMP="@;.01I;.01E;1I"
 D LIST^DIC(200.02,IENS,TMP,"PQ",,,,"#",,,"RORBUF","RORMSG")
 D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,200,IENS)
 S DIV=""
 ;--- Look for default division
 D:$G(RORBUF("DILIST",0))>0
 . S IR=0
 . F  S IR=$O(RORBUF("DILIST",IR))  Q:IR'>0  D  Q:DIV'=""
 . . S TMP=$G(RORBUF("DILIST",IR,0))
 . . S:$P(TMP,U,4) DIV=$P(TMP,U,2,3)
 . ;--- If name of the default division is not available
 . ;    and the only division is associated with the user
 . ;--- then use this division as the default one.
 . I $P(DIV,U,2)=""  D:RORBUF("DILIST",0)<2
 . . S DIV=$P($G(RORBUF("DILIST",1,0)),U,2,3)
 ;--- If default division is not available, use the site
 Q $S($P(DIV,U,2)'="":DIV,1:$P($$SITE^VASITE(),U,1,2))
 ;
 ;***** RETURNS INFORMATION ABOUT THE USER
 ; RPC: [ROR GET USER IFNO]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [USER]        User IEN in the NEW PERSON file. By default
 ;               (if $G(USER)'>0), the DUZ is used).
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, the user info is returned in the RESULTS(0).
 ; 
 ; RESULTS(0)            User Info
 ;                         ^01: IEN
 ;                         ^02: Name
 ;                         ^03: Office Phone
 ;                         ^04: Nickname
 ;                         ^05: Read Timeout
 ;                         ^06: Default Division IEN
 ;                         ^07: Default Division Name
 ;                         ^08: Institution IEN
 ;                         ^09: Institution Name
 ;                         ^10: Station Number (with suffix)
 ;
USERINFO(RESULTS,USER) ;
 N IENS,RORBUF,RORERRDL,RORMSG,TMP
 D CLEAR^RORERR("USERINFO^RORRP024",1)
 K RESULTS  S RESULTS(0)=0
 I $G(USER)'>0  S USER=+$G(DUZ)  Q:USER'>0
 ;--- Load the data
 S IENS=USER_","
 D GETS^DIQ(200,IENS,".01;.132;13",,"RORBUF","RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,200)  K ^TMP("DILIST",$J)
 ;--- Compile the result
 S RESULTS(0)=USER
 S $P(RESULTS(0),U,2)=$G(RORBUF(200,IENS,.01))  ; Name
 S $P(RESULTS(0),U,3)=$G(RORBUF(200,IENS,.132)) ; Office Phone
 S $P(RESULTS(0),U,4)=$G(RORBUF(200,IENS,13))   ; Nick Name
 S $P(RESULTS(0),U,5)=$$DTIME^XUP(USER)         ; Read Timeout
 S TMP=$$DFLTDIV(USER)
 S $P(RESULTS(0),U,6,7)=$P(TMP,U,1,2)           ; Default Division
 S $P(RESULTS(0),U,8,10)=$$SITE^VASITE()
 Q
 ;
 ;***** RETURNS THE LIST OF VISTA USERS
 ; RPC: [ROR LIST VISTA USERS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; PART          The search pattern (partial match restriction)
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 B  Backwards. Traverses the index in the opposite
 ;                    direction of normal traversal.
 ;                 D  Get default division for each user
 ;                 P  Select providers only (check for the PROVIDER
 ;                    security key)
 ;
 ; [NUMBER]      Maximum number of entries to return. A value of "*"
 ;               or no value in this parameter designates all entries.
 ;
 ; [FROM]        The index entry(s) from which to begin the list.
 ;               You should use the pieces of the @RESULTS@(0) node
 ;               (starting from the second one) to continue the
 ;               listing in the subsequent procedure calls.
 ;
 ;               NOTE: The FROM value itself is not included in
 ;                     the resulting list.
 ;
 ; The ^TMP("DILIST",$J) global node is used by the procedure.
 ;
 ; See description of the LIST^DIC for more details about the
 ; PART, NUMBER and FROM parameters.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of VistA users and the value of the FROM
 ; parameter for the next procedure call are returned in the
 ; @RESULTS@(0) and the subsequent nodes of the global array
 ; contain the users.
 ; 
 ; @RESULTS@(0)          Result Descriptor
 ;                         ^01: Number of users
 ;                         ^02: Values that comprise the FROM
 ;                         ^nn: parameter for the subsequent call
 ;
 ; @RESULTS@(i)          User
 ;                         ^01: IEN
 ;                         ^02: Name
 ;                         ^03: Office Phone
 ;                         ^04: Nickname
 ;                         ^05: reserved
 ;                         ^06: Default Division IEN  (only if D flag)
 ;                         ^07: Default Division Name (only if D flag)
 ;
USERLIST(RESULTS,PART,FLAGS,NUMBER,FROM) ;
 N BUF,FIELDS,I,RC,RORERRDL,SCR,TMP
 D CLEAR^RORERR("USERLIST^RORRP024",1)
 K RESULTS  S RESULTS=$NA(^TMP("DILIST",$J))  K @RESULTS
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Flags
 . S FLAGS=$$UP^XLFSTR($G(FLAGS))
 . ;--- Others
 . S PART=$G(PART),FROM=$G(FROM)
 . S NUMBER=$S($G(NUMBER)>0:+NUMBER,1:"*")
 ;--- Setup the start point
 F I=1:1  S TMP=$P(FROM,U,I)  Q:TMP=""  S FROM(I)=TMP
 S FROM=$G(FROM(1))
 ;--- Compile the screen logic (be careful with naked references)
 S SCR=""
 S:FLAGS["P" SCR=SCR_"I $D(^XUSEC(""PROVIDER"",Y))"
 ;--- Query the file
 S FIELDS="@;.01;.132;13",TMP="P"_$S(FLAGS["B":"B",1:"")
 D LIST^DIC(200,,FIELDS,TMP,NUMBER,.FROM,PART,"B",SCR,,,"RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,200)  K ^TMP("DILIST",$J)
 ;--- Add default divisions
 I FLAGS["D"  S I=0  D
 . F  S I=$O(@RESULTS@(I))  Q:I'>0  D
 . . S $P(@RESULTS@(I,0),U,6,7)=$P($$DFLTDIV(+@RESULTS@(I,0)),U,1,2)
 ;--- Success
 S TMP=$G(^TMP("DILIST",$J,0)),BUF=+$P(TMP,U)
 K ^TMP("DILIST",$J,0)
 I $P(TMP,U,3)  S I=0  D
 . F  S I=$O(FROM(I))  Q:I'>0  S TMP=FROM(I)  S:TMP'="" BUF=BUF_U_TMP
 S @RESULTS@(0)=BUF
 Q
