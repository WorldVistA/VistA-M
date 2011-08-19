GMVGETQ ;HOIFO/YH,FT-UTILITIES TO OBTAIN DATE/TIME, HOSPITAL, DUZ, VITAL CATEGORY AND EDIT V/M ;9/6/02  09:35
 ;;5.0;GEN. MED. REC. - VITALS;**3**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10103 - ^XLFDT calls           (supported)
 ;
 ; This routine supports the following IAs:
 ; #4353 - GMV CONVERT DATE RPC is called at GETDT  (private)
 ;
GETDT(RESULT,GMRDATE) ;GMV CONVERT DATE [RPC entry point]
 ;INPUT VARIABLE:
 ;GMRDATE - DATE/TIME FROM EDIT.TEXT ENTERED BY USER
 ;OUTPUT VARIABLE:
 ;RESULT - CONTAINS INTERNAL AND EXTERNAL DATE/TIME
 N GDATE D DT^DILF("ETS",GMRDATE,.GDATE)
 I $G(GDATE)'>0 S RESULT="" Q
 I $G(GDATE)>$$NOW^XLFDT S RESULT="" Q
 S RESULT=$G(GDATE)_"^"_$G(GDATE(0))
 Q
 ;
ADDQUAL(RESULT,GMRVDATA) ; Add qualifiers to FILE 120.5 entry
 ; ADD QUALIFIER TO 120.505 SUBFILE
 ; Input:
 ;    GMRVDATA=120.5 IEN^QUALIFIER (120.52) IEN
 ; Output:
 ;    RESULT = "" or the IEN of the subfile entry
 ;
 N GMVCNT,GMVERR,GMVFDA,GMVOKAY,GMRVIEN,GMRVQUAL
 S GMRVIEN=+$P(GMRVDATA,"^",1) ;File 120.5 ien
 S GMRVQUAL=+$P(GMRVDATA,"^",2) ;File 120.52 ien
 ; Does File 120.5 entry exist?
 I '$D(^GMR(120.5,GMRVIEN,0)) D  Q
 .S RESULT=""
 .;or S RESULT="-1^Vitals entry not found."
 .Q
 ; Is the qualifier already stored?
 I $O(^GMR(120.5,GMRVIEN,5,"B",GMRVQUAL,0))>0 D  Q
 .S RESULT=""
 .;or S RESULT="-1^Qualifier already filed. No change made."
 .Q
 ; Legitimate Qualifier?
 I '$D(^GMRD(120.52,GMRVQUAL,0)) D  Q
 .S RESULT=""
 .; or S RESULT="-1^"_$P(GMRVDATA,U,2)_" is not a legitimate qualifier"
 .Q
 S GMVCNT=0 ;counter for number of tries to lock an entry
B2 ; Lock the entry
 I GMVCNT>3 D  Q  ;4 strikes and you're out
 .S RESULT=""
 .;or S RESULT="-1^Could not lock entry to file qualifiers."
 .L -^GMR(120.5,GMRVIEN,0)
 .Q
 L +^GMR(120.5,GMRVIEN,0):1
 S GMVCNT=GMVCNT+1
 I '$T L -^GMR(120.5,GMRVIEN,0) G B2
 ; Store the  qualifier
 S GMVFDA(120.505,"+1,"_GMRVIEN_",",.01)=GMRVQUAL
 D UPDATE^DIE("","GMVFDA","GMVOKAY","GMVERR")
 L -^GMR(120.5,GMRVIEN,0)
 I $D(GMVERR) S RESULT="" ; or S RESULT="-1^*fileman error message*"
 E  S RESULT=+$G(GMVOKAY(1))
 Q
