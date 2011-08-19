XWBRPCC ;OIFO-Oakland/REM - M2M Broker Client Utilities  ;06/05/2002  17:25
 ;;1.1;RPC BROKER;**28,34**;Mar 28, 1997
 ;
 QUIT
 ;
 ;p34 - added line to set "MODE" like in PRE^XWBM2MC. No longer will it
 ;      be set in PRE^XWBM2MC - REQUEST.
 ;
 ; -------------------------------------------------------------------
 ;                  RPC Client:  Methods Calls
 ; -------------------------------------------------------------------
 ; 
 ; [Public/Supported Method]
EXECUTE(XWBPARMS) ; -- execute rpc call
 ;
 ; -- validate parameters passed
 IF '$$VALIDATE(.XWBPARMS) QUIT 0
 ;
 ; -- call method to build request from parameters array
 DO REQUEST(.XWBPARMS)
 IF $G(XWBPARMS("RESULTS"))="" SET XWBPARMS("RESULTS")=$NA(^TMP("XWBRPC",$J,"XML"))
 QUIT $$EXECUTE^XWBVLC(.XWBPARMS)
 ;
VALIDATE(XWBPARMS) ; -- validate parameters sent in
 ; // TODO: Do checks and build validate error message
 QUIT 1
 ;
REQUEST(XWBPARMS) ; -- build XML request
 ;
 NEW XWBLINE,XWBPI,PTYPE
 SET XWBLINE=0
 SET XWBPARMS("MESSAGE TYPE")="Gov.VA.Med.RPC.Request"
 ;
 S XWBPARMS("MODE")="RPCBroker" ;*p34-added line to set "MODE" instead of in PRE^XWBM2MC.
 ;SET XWBPARMS("MODE")="single call" ;Comment out for **M2M
 ;
 IF $G(XWBPARMS("REQUEST"))="" SET XWBPARMS("REQUEST")=$NA(XWBPARMS("REQUEST","XML"))
 SET XWBREQ=XWBPARMS("REQUEST")
 KILL @XWBREQ
 ;
 DO ADD($$XMLHDR^XWBUTL())
 ;p34-added 'broker m2m' in XML message
 DO ADD("<vistalink type="""_$G(XWBPARMS("MESSAGE TYPE"))_""" mode="""_$G(XWBPARMS("MODE"))_""" >")
 ;
 I $G(XWBPARMS("MODE"))'="RPCBroker" D
 . DO ADD("<session>")
 . ;
 . ;**M2M - don't send DUZ 
 . DO ADD("<duz value="""_$G(XWBPARMS("DUZ"))_""" />")
 . DO ADD("<security>")
 . ;
 . DO ADD("<token value="""_$G(XWBPARMS("TOKEN"))_""" />")
 . DO ADD("</security>")
 . DO ADD("</session>")
 . Q
 DO ADD("<rpc uri="""_$G(XWBPARMS("URI"))_""" method="""_$G(XWBPARMS("METHOD"))_""" >")
 IF $D(XWBPARMS("PARAMS"))>9 DO
 . DO ADD("<params>")
 . SET XWBPI=0
 . FOR  SET XWBPI=$O(XWBPARMS("PARAMS",XWBPI)) Q:'XWBPI!(XWBCRLFL)  DO
 . . SET PTYPE=$G(XWBPARMS("PARAMS",XWBPI,"TYPE"))
 . . IF PTYPE="STRING" DO STRING QUIT
 . . IF PTYPE="ARRAY" DO ARRAY QUIT
 . . IF PTYPE="REF" DO REF QUIT
 . DO ADD("</params>")
 DO ADD("</rpc>")
 DO ADD("</vistalink>")
 QUIT
 ;
STRING ;
 ;;DO ADD("<param type=""string"" position="""_XWBPI_""" >"_$G(XWBPARMS("PARAMS",XWBPI,"VALUE"))_"</param>")
 I $$CTLCHK($G(XWBPARMS("PARAMS",XWBPI,"VALUE"))) S XWBCRLFL=1 D ERROR^XWBM2MC(8) Q
 DO ADD("<param type=""string"" position="""_XWBPI_""" >"_$$CHARCHK^XWBUTL($G(XWBPARMS("PARAMS",XWBPI,"VALUE")))_"</param>")
 QUIT
 ;
ARRAY ;
 NEW XWBNAME
 DO ADD("<param type=""array"" position="""_XWBPI_""" >")
 DO ADD("<indices>")
 ;
 SET XWBNAME="" FOR  SET XWBNAME=$O(XWBPARMS("PARAMS",XWBPI,"VALUE",XWBNAME)) Q:XWBNAME=""  DO
 . ;;DO ADD("<index name="""_XWBNAME_""" value="""_$G(XWBPARMS("PARAMS",XWBPI,"VALUE",XWBNAME))_""" />")
 . I $$CTLCHK($G(XWBPARMS("PARAMS",XWBPI,"VALUE",XWBNAME))) S XWBCRLFL=1 D ERROR^XWBM2MC(8) Q
 . DO ADD("<index name="""_XWBNAME_""" >"_$$CHARCHK^XWBUTL($G(XWBPARMS("PARAMS",XWBPI,"VALUE",XWBNAME)))_"</index>")
 DO ADD("</indices>")
 DO ADD("</param>")
 QUIT
 ;
REF ;
 I $$CTLCHK($G(XWBPARMS("PARAMS",XWBPI,"VALUE"))) S XWBCRLFL=1 D ERROR^XWBM2MC(8) Q
 DO ADD("<param type=""ref"" position="""_XWBPI_""" >"_$$CHARCHK^XWBUTL($G(XWBPARMS("PARAMS",XWBPI,"VALUE")))_"</param>")
 QUIT
 ;
ADD(STR) ; -- add string to array
 SET XWBLINE=XWBLINE+1
 ;
 I $G(XWBDBUG) S ^REM("M2MCL","REQUEST",XWBLINE)=STR
 ;
 SET @XWBREQ@(XWBLINE)=STR
 QUIT
 ;
CTLCHK(STR) ;Check for control character in string.  
 ;        Exception are $C(10)-LF, $C(13)-CR
 N I,Q,X
 S X=0
 I '(STR?.E1C.E) Q X
 S I="" F I=1:1:$L(STR) D
 .S Q="" F Q=1:1:31 D  Q:X
 ..;I Q=10!(Q=13) Q
 ..;W !,"I= ",I," Q= ",Q
 ..I $E(STR,I)[$C(Q) S X=1 Q
 Q X
 ;
 ; -------------------------------------------------------------------
 ;                   Request Format Documentation
 ; -------------------------------------------------------------------
 ; 
 ; [ Parameter Array Format -->> passed to REQUEST^XWBRPCC(.XWBPARMS) ] 
 ; 
 ; -- general information
 ; XWBPARMS("ADDRESS")="127.0.0.1"
 ; XWBPARMS("ADDRESS")="152.127.1.35"
 ; XWBPARMS("PORT")=9800
 ; XWBPARMS("DUZ")=990
 ; XWBPARMS("TOKEN")="SOMETHING"
 ; XWBPARMS("RPC NAME")="SDOE LIST ENCOUNTERS FOR PAT"
 ;
 ; -- string parameter type
 ; XWBPARMS("PARAMS",1,"TYPE")="STRING"
 ; XWBPARMS("PARAMS",1,"VALUE")=2
 ; XWBPARMS("PARAMS",2,"TYPE")="STRING"
 ; XWBPARMS("PARAMS",2,"VALUE")=2961001
 ; XWBPARMS("PARAMS",3,"TYPE")="STRING"
 ; XWBPARMS("PARAMS",3,"VALUE")=3030101
 ;
 ; -- sample array parameter type
 ; XWBPARMS("PARAMS",4,"TYPE")="ARRAY"
 ; XWBPARMS("PARAMS",4,"VALUE","FNAME")="JOE"
 ; XWBPARMS("PARAMS",4,"VALUE","LNAME")="GOODMAN"
 ;                   
 ; -------------------------------------------------------------------
 ;                   
 ; [ Sample XML produced by calling REQUEST^XWBRPCC(.XWBPARMS) ]
 ; 
 ; <?xml version="1.0" encoding="utf-8" ?>
 ; <vistalink type="Gov.VA.Med.RPC.Request" mode="single call" >
 ;   <rpc uri="XWB TEST CALL" >
 ;      <session>
 ;         <duz value="990" />
 ;         <security>
 ;            <token value="something" />
 ;         </security>
 ;      </session>
 ;      <params>
 ;         <param type="string" position="1" >2</param>
 ;         <param type="string" position="2" >2961001</param>
 ;         <param type="string" position="3" >3030101</param>
 ;         <param type="array" position="4" >
 ;            <indices>
 ;               <index name="status" value="veteran" />
 ;               <index name="gender" value="male" />
 ;            </indices>
 ;         </param>
 ;      </params>
 ;   </rpc>
 ; </vistalink>
 ;
 ; -------------------------------------------------------------------
 ;
