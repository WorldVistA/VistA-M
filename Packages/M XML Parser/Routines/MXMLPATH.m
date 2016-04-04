MXMLPATH ; VEN/SMH - XPATH Extensions to MXML Package ;2015-05-25  11:37 AM
 ;;2.4;XML PROCESSING UTILITIES;;June 15, 2015;Build 14
 ;
 ; (c) Sam Habiel 2014
 ;
 ; Public Entry Point: [$$]XPATH. The rest is private.
 ;
 ; TODO:
 ; - Handle /a/*
 ; - Handle /a/[]
 ; - Handle /a//b
 ; - Handle . and ..
 ;
XPATH(RETURN,DOCHAND,XPATH) ; Public Entry Point - XPATH Processor
 ; Input:
 ; - .RETURN - Return array. Returns nodes where the XPATH found data. (Reference)
 ; ---> E.g. RETURN(8)=""
 ; --->      RETURN(15)=""
 ; - DOCHAND - The MXMLDOM Document Handle (Value)
 ; - XPATH - XPATH Expression (Value)
 ;
 ; If $$, return first found node; or first attribute value if attribute requested.
 ;
 KILL RETURN
 ;
 ; Handle / all by itself. Return 1.
 IF XPATH="/" DO  QUIT:$QUIT $$QUITVAL(.RETURN) QUIT
 . SET RETURN(1)=""
 . SET ^TMP("MXMLDOM",$JOB,DOCHAND,"CURRENT-NODE")=1
 ;
 ; Handle //a/b/c/d ; find a/b/c/d anywhere in the document.
 IF $EXTRACT(XPATH,1,2)="//" DO  QUIT:$QUIT $$QUITVAL(.RETURN) QUIT  ; find element anywhere in the document
 . SET XPATH=$EXTRACT(XPATH,3,999) ; Strip off the //
 . IF XPATH="" SET $ECODE=",U-INVALID-XPATH," ; // by itself is invalid
 . DO SS(.RETURN,DOCHAND,XPATH) ; find all nodes with the rest of the path (no parents; i.e. look anywhere)
 . SET ^TMP("MXMLDOM",$JOB,DOCHAND,"CURRENT-NODE")=$ORDER(RETURN(""),-1)
 ;
 ;
 ; Handle /a/b/c/d ; find /a/b/c/d starting from the root.
 IF $EXTRACT(XPATH)="/" DO  QUIT:$QUIT $$QUITVAL(.RETURN) QUIT
 . ;
 . ; Make sure that the document root is "a"
 . SET XPATH=$EXTRACT(XPATH,2,999)
 . NEW H SET H=$PIECE(XPATH,"/")
 . IF ^TMP("MXMLDOM",$JOB,DOCHAND,1)'=H QUIT
 . SET XPATH=$PIECE(XPATH,"/",2,99) ; we change this now to a relative path from the root node.
 . ;
 . ; Pass in the root node as the parent
 . NEW PARENTS SET PARENTS(1)=""
 . DO SS(.RETURN,DOCHAND,XPATH,.PARENTS)
 . SET ^TMP("MXMLDOM",$JOB,DOCHAND,"CURRENT-NODE")=$ORDER(RETURN(""),-1)
 ;
 ; We have a relative path
 DO  QUIT:$QUIT $$QUITVAL(.RETURN) QUIT
 . NEW CURRNODE SET CURRNODE=$GET(^TMP("MXMLDOM",$JOB,DOCHAND,"CURRENT-NODE"),1)
 . NEW PARENTS SET PARENTS(CURRNODE)=""
 . DO SS(.RETURN,DOCHAND,XPATH,.PARENTS)
 . SET ^TMP("MXMLDOM",$JOB,DOCHAND,"CURRENT-NODE")=$ORDER(RETURN(""),-1)
 ;
 ; IF NEITHER OF THESE FORMATS, FAIL WITH NOT-IMPLEMENTED EXCEPTION.
 SET $ECODE=",UUNIMPLEMENTED,"
 ;
 QUIT:$QUIT "" QUIT  ; We won't hit this; but for future use
 ;
QUITVAL(RETURN) ; $$/Private - What is the quit value? ; Input .RETURN.
 NEW N1 SET N1=$ORDER(RETURN("")) ;first node
 IF N1="" QUIT "" ; No results found.
 IF $DATA(RETURN(N1))=10 NEW N2 SET N2=$ORDER(RETURN(N1,"")) QUIT RETURN(N1,N2) ; VALUE of first found attribute
 ELSE  QUIT N1 ; first found node
 ;
SS(RETURN,DOCHAND,XPATH,PARENTS) ; Private; Main search code
 ; .RETURN -> Return array to be populated
 ; DOCHAND -> MXMLDOM Handle
 ; XPATH -> XPATH to search
 ; .PARENTS -> XML Parent nodes already identified
 ;             Don't pass if you want to search anywhere in the document.
 ;             Pass PARENTS(NODEID)="" if you want to limit searching to below
 ;             ...these node(s).
 ;
 NEW SURPARENTS MERGE SURPARENTS=PARENTS ; Surviving parents
 ;
 ; Now, recurse over the rest of the XPATH expression
 NEW XPATHL SET XPATHL=$LENGTH(XPATH,"/") ; # of pieces
 NEW QUITFLAG SET QUITFLAG=0
 NEW I FOR I=1:1:XPATHL DO  QUIT:'$DATA(SURPARENTS)  QUIT:QUITFLAG
 . NEW CHILD SET CHILD=$PIECE(XPATH,"/",I)  ; XPATH piece
 . ;
 . ; make sure that each piece is at least 1 character long
 . IF CHILD="",I=XPATHL SET $ECODE=",U-INVALID-XPATH," ; error if  the user give us something with a trailing slash. (a/b/c/)
 . ELSE  ; this is the abc//def case. TODO.
 . ;
 . IF $EXTRACT(CHILD)="@" DO  SET QUITFLAG=1 QUIT  ; Attribute requested...
 . . ; SURPARENTS will only be empty if we have the special case of //@attribute
 . . IF '$DATA(SURPARENTS) DO ALLNODES(.SURPARENTS,DOCHAND) ; This is really confusing!!!!
 . . DO ATTRIB(DOCHAND,CHILD,.SURPARENTS)
 . ;
 . NEW FILTER SET FILTER=""
 . IF $EXTRACT(CHILD,$LENGTH(CHILD))="]" DO  ; The child has a condition on it.
 . . SET FILTER=$PIECE(CHILD,"[",2),FILTER=$PIECE(FILTER,"]") ; get contents of [...]
 . . SET CHILD=$PIECE(CHILD,"[") ; strip [...]
 . ;
 . ; Handle . and ..
 . ; IF $E(CHILD)="." D
 . ; . I CHILD="." S:$O(SURPARENTS("")) CNODES($O(SURPARENTS(""),-1))="" ; Set to the last found parent
 . ; . I CHILD=".." S CNODES(PARENT^MXMLDOM(DOCHAND,SURPARENTS)) ; TODO: Loop through parents and move up.
 . ;
 . NEW CNODES DO SEARCHNO(.CNODES,DOCHAND,CHILD)  ; Grab child nodes from XML doc.
 . IF '$DATA(CNODES) KILL SURPARENTS QUIT  ; XPATH expr yielded no results.
 . ;
 . ; Now make sure that the children nodes are indeed children of the parents.
 . N SURCHILDREN ; Surviving Children
 . DO WEEDOUT(.SURCHILDREN,.SURPARENTS,.CNODES,DOCHAND) ; only run if we have parents (not first node in //)
 .
 . ; Any children left?
 . IF '$DATA(SURCHILDREN) KILL SURPARENTS QUIT  ; XPATH expr yielded no results.
 . ;
 . DO:$LENGTH(FILTER) FILTER(DOCHAND,.SURCHILDREN,FILTER) ; Apply filter expression
 . ;
 . ; DO DEBUG(.SURCHILDREN,DOCHAND)
 . ;
 . ; Any children left?
 . IF '$DATA(SURCHILDREN) KILL SURPARENTS QUIT  ; XPATH expr yielded no results.
 . ;
 . ; The children are now the new parents
 . KILL SURPARENTS MERGE SURPARENTS=SURCHILDREN
 ;
 MERGE RETURN=SURPARENTS ; The surviving parents are the return value
 QUIT
 ;
WEEDOUT(SURVIVORS,PARENTS,CHILDREN,DOCHAND) ; Remove bastard child nodes
 ; Input: .PARENTS AND .CHILDREN - node subscripted arrays
 ; Output: .SURVIVORS
 ; DOCHAND ditto
 ;
 ; No parents? Children are survivors
 I '$D(PARENTS) M SURVIVORS=CHILDREN QUIT
 ;
 NEW P SET P=0 FOR  SET P=$ORDER(PARENTS(P)) QUIT:'P  D
 . ;NEW C SET C=0 FOR  SET C=$ORDER(CHILDREN(C)) QUIT:'C  D
 . NEW C SET C=0 FOR  SET C=$ORDER(^TMP("MXMLDOM",$JOB,DOCHAND,P,"C",C)) QUIT:'C  D
 . . I $D(CHILDREN(C)) S SURVIVORS(C)=""
 QUIT
 ;
SEARCHNO(RETURN,DOCHAND,NODENAME) ; Simple linear search of nodes on MXML document
 ; Find nodes in document called NODENAME and return in RETURN.
 ; .RETURN,DOCHAND - ditto; NODENAME - string name of element node.
 NEW I SET I=0
 FOR  SET I=$ORDER(^TMP("MXMLDOM",$JOB,DOCHAND,I)) QUIT:'I  SET:^(I)=NODENAME RETURN(I)=""
 QUIT
 ;
ALLNODES(RETURN,DOCHAND) ; Return all XML element nodes in DOM.
 NEW I SET I=0 FOR  SET I=$ORDER(^TMP("MXMLDOM",$JOB,DOCHAND,I)) QUIT:'I  SET RETURN(I)=""
 QUIT
 ;
ISCHILD(PARENT,CHILD,DOCHAND) ; Is node CHILD (int) a child of node PARENT (int)?
 QUIT $DATA(^TMP("MXMLDOM",$JOB,DOCHAND,PARENT,"C",CHILD))
 ;
TEXTFIL(DOCHAND,NODES,TEXT) ; Text filter though the nodes
 ; Search the .NODES in MXMLDOM document DOCHAND for TEXT.
 NEW I SET I=0 FOR  SET I=$ORDER(NODES(I)) QUIT:'I  DO
 . IF ^TMP("MXMLDOM",$JOB,DOCHAND,I,"T",1)'=TEXT KILL NODES(I)
 QUIT
 ;
ATTRIB(DOCHAND,ATTRIB,NODES) ; Get ATTRIB attribute from each of the NODES
 ; Change NODES(n) array to NODES(n,ATTNAME)=VALUE array
 ; DOCHAND, ditto; ATTRIB - attribute string; NODES - subscripted array of
 ;   MXMLDOM nodes
 SET ATTRIB=$PIECE(ATTRIB,"@",2,99) ; Strip the @.
 NEW I SET I="" FOR  SET I=$ORDER(NODES(I)) QUIT:'I  DO
 . NEW V SET V=$$VALUE^MXMLDOM(DOCHAND,I,ATTRIB)
 . IF V="" KILL NODES(I)
 . ELSE  KILL NODES(I) SET NODES(I,ATTRIB)=V
 QUIT
 ;
FILTER(DOCHAND,NODES,FILTER) ; process [...] filter on xpath results
 ; INPUT:
 ; - DOCHAND, NODES: ditto
 ; - NODES is both INPUT and OUTPUT, as it is the array being filtered.
 ; - FILTER: filter string without the [].
 ;
 ; supports only the following filter expressions right now:
 ; - position(n)
 ; - n
 ; - last()
 ; - @att
 ; - @att="foo"
 ; - node
 ; - node="foo"
 ;
 QUIT:'$DATA(NODES)
 ;
 ; position(n)? convert to number.
 IF FILTER["position(" SET FILTER=$PIECE(FILTER,"position(",2),FILTER=$PIECE(FILTER,")")
 ;
 ; Number? Kill all nodes not in that ordinal position and done.
 IF +FILTER=FILTER DO  QUIT
 . NEW CNT SET CNT=0
 . NEW I SET I=0 FOR  SET I=$ORDER(NODES(I)) QUIT:'I  DO
 . . SET CNT=CNT+1
 . . IF CNT'=FILTER KILL NODES(I)
 ;
 ; last()? Grab that and done.
 IF FILTER="last()" DO  QUIT
 . NEW LAST SET LAST=$ORDER(NODES(""),-1)
 . NEW VAL SET VAL=NODES(LAST)
 . KILL NODES
 . SET NODES(LAST)=VAL
 ;
 ;
 ; No = sign. Either @attribute or node
 IF $LENGTH(FILTER,"=")=1 DO  QUIT
 . IF $EXTRACT(FILTER)="@" DO  QUIT  ; attribute
 . . NEW ATTRIB SET ATTRIB=FILTER
 . . DO ATTRIB(DOCHAND,ATTRIB,.NODES) ; filter by attribute
 . . ; Re-align the nodes as we don't care about attrib contents.
 . . ; (i.e. discard the return value of ATTRIB call and return nodes back
 . . ; (to original NODES(n) form).
 . . NEW I SET I=0 FOR  SET I=$ORDER(NODES(I)) QUIT:'I  SET NODES(I)="" KILL NODES(I,$PIECE(ATTRIB,"@",2))
 . ;
 . ELSE  DO  QUIT  ; node
 . . NEW CHILDNAME SET CHILDNAME=FILTER ; node name is same as FILTER
 . . ;
 . . ; Get all nodes with that filter name
 . . NEW CHILDREN DO SEARCHNO(.CHILDREN,DOCHAND,CHILDNAME)
 . . IF '$DATA(CHILDREN) KILL NODES QUIT  ; no children
 . . ;
 . . ; Remove all the filter nodes who are not directly under us
 . . ; Store result in PARENTS(n)=""
 . . NEW PARENTS
 . . NEW I SET I=0 FOR  SET I=$ORDER(NODES(I)) QUIT:'I  NEW J SET J=0 FOR  SET J=$ORDER(CHILDREN(J)) QUIT:'J  DO
 . . . IF $$ISCHILD(I,J,DOCHAND) SET PARENTS(I)=""
 . . ;
 . . ; Kill the original return array and recreate it from PARENTS
 . . KILL NODES
 . . MERGE NODES=PARENTS
 . . KILL PARENTS
 ;
 ; attribute @attribute="value"
 IF $EXTRACT(FILTER)="@" DO  QUIT
 . NEW ATTRIB SET ATTRIB=$PIECE(FILTER,"=")
 . DO ATTRIB(DOCHAND,ATTRIB,.NODES) ; Grab nodes that have this attribute
 . NEW V SET V=$PIECE(FILTER,"=",2),V=$PIECE(V,"""",2),V=$PIECE(V,"""") ; get value, rm quotes
 . ;
 . ; Filter out nodes whose attribute value doesn't match.
 . NEW I SET I=0 FOR  SET I=$ORDER(NODES(I)) QUIT:'I  DO
 . . IF NODES(I,$PIECE(ATTRIB,"@",2))'=V KILL NODES(I)
 . . ELSE  SET NODES(I)="" KILL NODES(I,$PIECE(ATTRIB,"@",2))
 ;
 ; NODE node="value"
 ELSE  DO  QUIT
 . NEW CHILDNAME SET CHILDNAME=$PIECE(FILTER,"=")
 . NEW CHILDREN DO SEARCHNO(.CHILDREN,DOCHAND,CHILDNAME) ; Grab nodes with this value
 . NEW V SET V=$PIECE(FILTER,"=",2),V=$PIECE(V,"""",2),V=$PIECE(V,"""") ; get value, rm quotes
 . ;
 . ; Remote nodes whose text contents are not the filter value.
 . DO TEXTFIL(DOCHAND,.CHILDREN,V)
 . IF '$DATA(CHILDREN) KILL NODES QUIT
 . ;
 . ; Remove all filter nodes not directly under us.
 . ; Store result in PARENTS(n)=""
 . NEW PARENTS
 . NEW I SET I=0 FOR  SET I=$ORDER(NODES(I)) QUIT:'I  NEW J SET J=0 FOR  SET J=$ORDER(CHILDREN(J)) QUIT:'J  DO
 . . IF $$ISCHILD(I,J,DOCHAND) SET PARENTS(I)=""
 . ;
 . ; Kill return value and replace it with PARENTS.
 . KILL NODES
 . MERGE NODES=PARENTS
 . KILL PARENTS
 ;
 QUIT
DEBUG(NODES,DOCHAND) ; Debug print; Just used internally for debugging.
 N C S C=0
 N N S N=0 F  S N=$O(NODES(N)) Q:'N  W N_": "_^TMP("MXMLDOM",$J,DOCHAND,N),! S C=C+1
 W "Count: "_C,!
 QUIT
