SPNJRPPL ;BP/JAS - Returns list of CPT codes and short names ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to ^ICPT supported by IA# 2815
 ; Reference to API CPT^ICPTCOD supported by IA# 1995
 ;
 ; Parm values:
 ;     RETURN is the sorted data based on clinic stop name
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 K ^TMP($J)
 ;JAS - 05/15/08 - DEFECT 1090
 ;S CODE=""
 S CODE=0
 F  S CODE=$O(^ICPT("B",CODE)) Q:CODE=""  D
 . S CSTRING=$$CPT^ICPTCOD(CODE,"","")
 . Q:+CSTRING=-1
 . ; Next two lines added for defect SCI1020
 . S IDATE=$P(CSTRING,"^",8)
 . I IDATE'="",IDATE?7N,IDATE'>DT Q
 . S CPT=$P(CSTRING,"^",2)
 . S CNAME=$P(CSTRING,"^",3)
 . S CNAME=$$UP^XLFSTR(CNAME)
 . S ^TMP($J,CNAME,RETCNT)=CPT_"^"_CNAME_"^EOL999"
 . S RETCNT=RETCNT+1
 K RETCNT,CODE,CSTRING,CPT,CNAME,IDATE
 Q
