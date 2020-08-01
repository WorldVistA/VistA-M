C0CDACW ; GPL - Patient Portal - CCDA HTML Report Routines ;3/1/15  17:05
 ;;0.1;JJOHPP;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 ;
 Q
 ;
GENHTML(HOUT,HARY) ; generate an HTML table from array HARY
 ; HOUT AND HARY are passed by name
 ;
 ; format of the table:
 ;  HARY("TITLE")="Problem List"
 ;  HARY("HEADER",1)="column 1 header"
 ;  HARY("HEADER",2)="col 2 header"
 ;  HARY(1,1)="row 1 col1 value"
 ;  HARY(1,2)="row 1 col2 value"
 ;  HARY(1,2,"ID")="the ID of the element" 
 ;  etc...
 ;
 N C0I,C0J
 D ADDTO(HOUT,"<div align=""center"">")
 ;I $D(@HARY@("TITLE")) D  ;
 ;. N X
 ;. S X="<title>"_@HARY@("TITLE")_"</title>"
 ;. D ADDTO(HOUT,X)
 D ADDTO(HOUT,"<text>")
 D ADDTO(HOUT,"<table border=""1"" style=""width:80%"">")
 I $D(@HARY@("TITLE")) D  ;
 . N X
 . S X="<caption><b>"_@HARY@("TITLE")_"</b></caption>"
 . D ADDTO(HOUT,X)
 I $D(@HARY@("HEADER")) D  ;
 . D ADDTO(HOUT,"<thead>")
 . D ADDTO(HOUT,"<tr>")
 . S C0I=0
 . F  S C0I=$O(@HARY@("HEADER",C0I)) Q:+C0I=0  D  ;
 . . D ADDTO(HOUT,"<th>"_@HARY@("HEADER",C0I)_"</th>")
 . D ADDTO(HOUT,"</tr>")
 . D ADDTO(HOUT,"</thead>")
 D ADDTO(HOUT,"<tbody>")
 I $D(@HARY@(1)) D  ;
 . S C0I=0 S C0J=0
 . F  S C0I=$O(@HARY@(C0I)) Q:+C0I=0  D  ;
 . . D ADDTO(HOUT,"<tr>")
 . . F  S C0J=$O(@HARY@(C0I,C0J)) Q:+C0J=0  D  ;
 . . . N UID S UID=$G(@HARY@(C0I,C0J,"ID"))
 . . . I UID'="" D ADDTO(HOUT,"<td style=""padding:5px;"" ID="""_UID_""">"_@HARY@(C0I,C0J)_"</td>")
 . . . E  D ADDTO(HOUT,"<td style=""padding:5px;"">"_@HARY@(C0I,C0J)_"</td>")
 . . D ADDTO(HOUT,"</tr>")
 D ADDTO(HOUT,"</tbody>")
 D ADDTO(HOUT,"</table>")
 D ADDTO(HOUT,"</text>")
 D ADDTO(HOUT,"</div>")
 Q
 ;
GENVHTML(HOUT,HARY) ; generate a vertical HTML table from array HARY
 ; headers are in the first row
 ; HOUT AND HARY are passed by name
 ;
 ; format of the table:
 ;  HARY("TITLE")="Problem List"
 ;  HARY("HEADER",1)="row 1 column 1 header"
 ;  HARY("HEADER",2)="row 2 col 2 header"
 ;  HARY(1,1)="row 1 col2 value"
 ;  HARY(2,1)="row 2 col2 value"
 ;  etc...
 ;
 N C0I,C0J
 D ADDTO(HOUT,"<div align=""center"">")
 D ADDTO(HOUT,"<text>")
 D ADDTO(HOUT,"<table border=""1"" style=""width:40%"">")
 I $D(@HARY@("TITLE")) D  ;
 . N X
 . S X="<caption><b>"_@HARY@("TITLE")_"</b></caption>"
 . D ADDTO(HOUT,X)
 I $D(@HARY@("HEADER")) D  ;
 . D ADDTO(HOUT,"<tr>")
 . S C0I=0
 . F  S C0I=$O(@HARY@("HEADER",C0I)) Q:+C0I=0  D  ;
 . . D ADDTO(HOUT,"<th style=""padding:5px;"">"_@HARY@("HEADER",C0I)_"</th>")
 . . D ADDTO(HOUT,"<td style=""padding:5px;"">"_@HARY@(C0I,1)_"</td>")
 . D ADDTO(HOUT,"</tr>")
 D ADDTO(HOUT,"</table>")
 D ADDTO(HOUT,"</text>")
 D ADDTO(HOUT,"</div>")
 Q
 ;
ADDTO(DEST,WHAT) ; adds string WHAT to list DEST 
 ; DEST is passed by name
 N GN
 S GN=$O(@DEST@("AAAAAA"),-1)+1
 S @DEST@(GN)=WHAT
 S @DEST@(0)=GN ; count
 Q
 ;
HREF(URL,TAG) ; extrinsic to return an html href statement
 N RTN
 I $D(TAG) S RTN="<a href="""_URL_""" target="""_URL_""">"_TAG_"</a>"
 E  S RTN="<a href="""_URL_""" target="""_URL_""">"_URL_"</a>"
 Q RTN
 ;
