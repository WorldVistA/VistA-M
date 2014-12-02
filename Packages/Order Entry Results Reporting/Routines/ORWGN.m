ORWGN ;;SLC/JDL/DRP - Group Notes ;09/10/12  19:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**222,353**;;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;Uses supported ICR 5679
AUTHUSR(ORY) ;Does user has permission to access GN?
 S ORY=0
 I $D(^XUSEC("OR GN ACCESS",DUZ)) S ORY=1
 Q
 ;
GNLOC(ORY,ORFROM,DIR) ;Is valid GN location? 1: true 0: false
 ; .ORY=returned list, ORFROM=text to $O from, DIR=$O direction.
 N IX,ORLST,CHKVAL,ORERR,ORX
 K ^TMP("ORGN",$J)
 S (ORLST,ORERR)="",CHKVAL=0
 D GETLST^XPAR(.ORLST,"ALL","OR GN LOCATIONS","N",.ORERR)
 I ORERR S ORY=ORERR Q
 Q:$D(ORLST)=1
 S IX=0 F  S IX=$O(ORLST(IX)) Q:'IX  D
 . S CHKVAL=ORLST(IX)
 . S:($$ACTLOC^ORWU(+CHKVAL)) ^TMP("ORGN",$J,$P(CHKVAL,U,2))=ORLST(IX)
 N I,CNT S I=0,CNT=44,ORY=""
 Q:$D(^TMP("ORGN",$J))<10
 F  Q:I'<CNT  S ORFROM=$O(^TMP("ORGN",$J,ORFROM),DIR) Q:ORFROM=""  D
 . S I=I+1,ORY(I)=^TMP("ORGN",$J,ORFROM)
 Q
 ; Begin OR*3.0*353 changes
IDTVALID(IDATE,CSYS) ; Returns Implementation date of the ICD code set
 ;CSYS = System abbreviation for the coding system
 K IDATE
 I $G(CSYS)="" S IDATE="-1^CODING SYSTEM PARAMETER MISSING" Q
 S IDATE=$$IMPDATE^LEXU(CSYS)
 Q
 ;
MAXFRQ(ORY,ORTRM) ;Checks if frequency of search term is greater than
 ; max ICD-10 setting
 ; Input Value: ORTRM = Search term to look up
 ;
 ; Return Value: 2 pieces (first piece is 0 or 1, second piece is
 ;               occurrance frequency of search term)
 ;               First piece:
 ;                            0 - Search term frequency is less than
 ;                                maximum return
 ;                            1 - Search term frequency is greater
 ;                                than maximum return
 N ORMAX,ORFRQ
 S ORY=0
 I ORTRM="" Q  ;if search term not sent in, then quit
 S ORMAX=+$$MAX^LEXU("10D")
 I ORMAX=0 S ORMAX=20000  ;if Max value not set, default to 20,000
 S ORFRQ=+$$FREQ^LEXU(ORTRM)
 I ORFRQ'>ORMAX Q  ;if frequency not greater than Max value
 S ORY="1^"_ORFRQ
 Q
 ; End OR*3.0*353 changes
