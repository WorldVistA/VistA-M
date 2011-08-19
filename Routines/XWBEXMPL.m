XWBEXMPL ;ISC-SF/VYD - RPC BROKER EXAMPLE ;07/13/2004  15:03
 ;;1.1;RPC BROKER;**22,35**;Mar 28, 1997
ECHOSTR(RESULT,OSTRING) ;receive string and return it
 S RESULT=OSTRING
 Q
 ;
 ;
GETLIST(RESULT,WHAT,QTY) ; -- return list
 ;WHAT - LINES or KILOBYTES, QTY - number of lines of kilobytes
 ;here the resulting list can get quite large - use global structure
 N I,J,L,V                ;looping vars
 S $P(L,"-+",128)=" "
 K ^TMP($J,"XWB RESULTS") ;clean out temporary storage
 I WHAT="LINES" D         ;lines requested
 . F I=1:1:QTY D
 . . S V="Line #"_I,V=V_$S(I'>$L(V):"",1:$E(L,1,$S(QTY+$L(V)>255:255-$L(V),1:QTY-$L(V))))
 . . S ^TMP($J,"XWB RESULTS",I)=V
 . . ;S ^TMP($J,"XWB RESULTS",I)="Line #"_I
 ;
 E  D                     ;kilobytes of data requested
 . F I=1:1:QTY D
 . . F J=1:1:64 D         ;64 lines * 16 chars = 1K
 . . . S ^TMP($J,"XWB RESULTS",I*100+J)=$E(I_"-Kilobyte******",1,16)
 ;
 S RESULT=$NA(^TMP($J,"XWB RESULTS")) ;give Broker data root
 Q
 ;
 ;
WPTEXT(RESULT) ;return word processing text
 N TEXT
 ;use DBS call to get REMOTE PROCEDURE file description
 D FILE^DID(8994,"","DESCRIPTION","TEXT")
 M RESULT=TEXT("DESCRIPTION")
 Q
 ;
 ;
SORTNUM(RESULT,DIRCTN,ARRAY) ; -- sort numbers and return sorted
 ;DIRCTN - direction to sort in HI or LO
 ;ARRAY - array of numbers to sort
 ;S $ECODE=",U411," Q
 N I,J
 IF DIRCTN="LO" D        ;sort LOW -> HIGH
 . S I="" F  S I=$O(ARRAY(I)) Q:I=""  S J=ARRAY(I) D
 . . S RESULT(J)=J
 . . S JLIN=$G(JLIN)+1,^TMP("JLI",JLIN)=I_U_J
 E  D                    ;sort HIGH -> LOW
 . S I="" F  S I=$O(ARRAY(I)) Q:I=""  S J=ARRAY(I) D
 . . S RESULT(99999999-J)=J
 Q
 ;
GSORT(RESULT,DIRCTN,ROOT) ; -- Sort numbers in a global array
 ;DIRCTN - direction to sort in HI or LO
 ;ROOT - Closed Root of the Global array of numbers to sort 
 ;Data is in ^TMP("XWB",$J,n)
 N I,V K ^TMP($J)
 IF DIRCTN="LO" D        ;sort LOW -> HIGH
 . S I="" F  S I=$O(@ROOT@(I)) Q:I=""  D
 . . S V=$G(@ROOT@(I)) I $L(V) S ^TMP($J,V)=V
 E  D                    ;sort HIGH -> LOW
 . S I="" F  S I=$O(@ROOT@(I)) Q:I=""  D
 . . S V=$G(@ROOT@(I)) I $L(V) S ^TMP($J,99999999-V)=V
 S RESULT=$NA(^TMP($J))
 M ^RWF($J)=@ROOT
 Q
 ;
BIGTXT(RESULT,ARRAY) ;-- Accept a big text block.
 ;Return count. char^lines
 N CC,LC,I
 S CC=0,LC=0,I=""
 F  S I=$O(ARRAY(I)) Q:I=""  S LC=LC+1,CC=CC+$L(ARRAY(I))
 K ^TMP($J) M ^TMP($J)=ARRAY
 S RESULT=CC_"^"_LC
 Q
