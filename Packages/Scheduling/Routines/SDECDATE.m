SDECDATE ; ALB/WTC,TAW,LAB - VISTA SCHEDULING - Date Utilities ;APR 07,2022
 ;;5.3;Scheduling;**694,805,814**;;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q  ;
 ;
FMTONET(IN,SPACE)    ;
 ;
 ;  Convert FileMan format date/time to .NET compatible date
 ;
 ;  IN = FileMan format date
 ;  SPACE = Y if @ should be converted to a space
 ;
 N OUT,X,Y,X1 ;
 ;
 ;  If time is midnight, increment date by one and change time to "0000"
 ;
 I $P(IN,".",2)="24" D  G RETURN ;
 . S X=$P(IN,".",1),X1=$$FMADD^DILIBF(X,1,0,0,1),X1=$P(X1,".",1) ;
 . S OUT=$$FMTE^DILIBF(X1)_"@00:00" ;
 ;
 ; Other than midnight.
 ;
 S OUT=$$FMTE^DILIBF(IN) ;
 ;
 I $G(SPACE)="Y" S OUT=$TR(OUT,"@"," ") ;
 ;
RETURN ;
 Q OUT ;
 ;
NETTOFM(IN,TIME,SECONDS)    ;
 ;
 ;  Convert .NET date/time to FileMan format.
 ;
 ;  IN = date/time in external format
 ;  TIME = time required (Y/N default=Y)
 ;  SECONDS = seconds permitted (Y/N default=Y)
 ;
 N OUT,X,Y,X1,TM ;
 ;
 ;  If time is midnight, decrement date by one and change time to 24.
 ;
 S TM=$P(IN,"@",2) ;  May need to add additional checks for correct time depending on how .NET returns date/time.
 ;
 S %DT="" ;
 I $G(TIME)'="N" S %DT=%DT_"R" ;
 I $G(TIME)'="N",$G(SECONDS)'="N" S %DT=%DT_"S" ;
 ;
 I TM="00:00"!(TM="0000") D  G RETURN ;
 . S X=$P(IN,"@",1),%DT="" D ^%DT S X=$$FMADD^DILIBF(Y,-1,0,0,1),X1=$P(X,".",1) ;
 . S OUT=X1_".24" ;
 ;
 ;  Other than midnight
 ;
 S X=IN D ^%DT S OUT=Y G RETURN
 ;
VALIDFMFORMAT(DATE) ;Is DATE a valind FileMan format
 ;Return 1=Yes
 ;       0=No
 N X,Y,%DT
 S %DT="T"
 I $G(DATE)="" Q 0
 I $$FR^XLFDT(DATE) Q 0
 S X=DATE D ^%DT
 I Y=-1 Q 0
 Q 1
 ;
VALIDISO(DATE) ;Is DATE a valid ISO8601 format (e.g., 2022-01-12T13:21)
 ; Return
 ; 0 = not ISO8601 format
 ; 1 = ISO8601 format
 N RESULT,SDDATE,SDTIME,SDOFFSET,KEEPSDTIME
 S (RESULT)=0
 I $G(DATE)="" Q 0
 S SDDATE=$P(DATE,"T")
 I SDDATE D
 .;Validate date
 .;   YYYYMMDD, YYYY-MM-DD or YYYY-MM
 .I SDDATE?6N Q  ;YYYY-MM is not allowed
 .S SDDATE=$TR(SDDATE,"-")
 .I SDDATE?8N!(SDDATE?6N) S RESULT=1
 ;
 S (SDTIME,KEEPSDTIME)=$P(DATE,"T",2)
 I RESULT,SDTIME'="" D
 .;Validate time (ignore seconds)
 .;  THH
 .;  THHMM or THH:MM
 .;  THHMMSS or THH:MM:SS
 .S SDTIME=$$REMOVEOFFSET^SDAMUTDT(SDTIME)
 .S SDTIME=$P(SDTIME,".")  ;Ignore seconds
 .S SDTIME=$TR(SDTIME,":")
 .I SDTIME'?6N,SDTIME'?4N,SDTIME'?2N S RESULT=0 Q
 .;Validate offset
 .;   Z
 .;   + or - followed by HH
 .;   + or - followed by HHMM or HH:MM
 .I $E(DATE,$L(DATE))="Z" S RESULT=1 Q
 .S SDTIME=$TR(KEEPSDTIME,":")
 .S SDOFFSET=$P(SDTIME,"+",2)
 .I SDOFFSET'="" D  Q
 ..I SDOFFSET'?2N,SDOFFSET'?4N S RESULT=0
 .S SDOFFSET=$P(SDTIME,"-",2)
 .I SDOFFSET'="" D  Q
 ..I SDOFFSET'?2N,SDOFFSET'?4N S RESULT=0
 Q RESULT
