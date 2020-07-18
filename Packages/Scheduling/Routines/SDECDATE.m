SDECDATE ; ALB/WTC - VISTA SCHEDULING - Date Utilities ;MAY 3,2018@14:12
 ;;5.3;Scheduling;**694**;;Build 61
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
