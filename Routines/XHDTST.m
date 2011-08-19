XHDTST ; SLC/JER - Test calls ; 25 Jul 2003  9:42 AM
 ;;1.0;HEALTHEVET DESKTOP;;Jul 15, 2003
INLST(ORY,ORX) ; Test input list
 N I,J,RC S I="",(J,RC)=0,ORY=$NA(^TMP("XHDZTST",$J))
 D XMLHDR^XHDLXM(.ORY,"result",.J),RSLTBL(.ORY,.J)
 F  S I=$O(ORX(I)) Q:I']""  D
 . N COL
 . S RC=RC+1
 . D BUILDROW(.COL,.ORX,I),SETROW(.ORY,.COL,.J)
 S SPEC("##")=RC,@ORY@(3)=$$REPLACE^XLFSTR(@ORY@(3),.SPEC)
 S J=J+1,@ORY@(J)="</rows>"
 S J=J+1,@ORY@(J)="</resultTable>"
 D XMLFOOT^XHDLXM(.ORY,"result",.J)
 Q
RSLTBL(ORY,ORI) ; resultTable
 S ORI=ORI+1
 S @ORY@(ORI)="<resultTable name=""test_list"" rowCount=""##"" columnCount=""2"">"
 S ORI=ORI+1,@ORY@(ORI)="<columns>"
 S ORI=ORI+1
 S @ORY@(ORI)="<c name=""name"" type=""string""/>"
 S ORI=ORI+1
 S @ORY@(ORI)="<c name=""value"" type=""string""/>"
 S ORI=ORI+1,@ORY@(ORI)="</columns>"
 S ORI=ORI+1,@ORY@(ORI)="<rows>"
 Q
BUILDROW(COL,ORX,I) ; Resolve fields for each row
 S COL(1)=I
 S COL(2)=ORX(I)
 Q
SETROW(ORY,COL,ORI) ; Generate tags for row
 N ORC,Y S ORC=0
 S ORI=ORI+1,@ORY@(ORI)="<r>"
 S Y=ORI
 F  S ORC=$O(COL(ORC)) Q:+ORC'>0  D
 . S ORI=ORI+1,@ORY@(ORI)=$S(COL(ORC)]"":"<c>"_COL(ORC)_"</c>",1:"<c/>")
 I Y=ORI S ORI=ORI+1,@ORY@(ORI)="<c/>"
 S ORI=ORI+1,@ORY@(ORI)="</r>"
 Q
