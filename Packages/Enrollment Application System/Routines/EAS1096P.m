EAS1096P ;ALB/PJH - Utility to disable HEC legacy protocols; ; 7/2/09 4:36pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**96**; 15-MAR-01;Build 18
 Q
 ;
 ;This routine is the post install for patch EAS*1*96
 ;
 ;The routine calls the EAS1071A routine to remove HEC Legacy
 ;subscriber protocols used for dual messaging of outbound Z07
 ;and also to insert disable text into all HEC Legacy server
 ;protocols
 ;
 ;
EN ;Entry Point
 N PNAME,RESULT,RTN,STATION,STOP,EAS1096P
 ;
 D BMES^XPDUTL("Post Install Running")
 ;
 ;Reset QRY protocols
 S STATION=$P($$SITE^VASITE,"^",3),STOP=0,RTN="D ORF^EASCM"
 ;
 ;Update Z10 server
 S PNAME="VAMC "_STATION_" QRY-Z10 SERVER"
 S RESULT=$$EDP(PNAME,RTN)
 D:+RESULT<0 ERROR(RESULT,PNAME)
 ;
 ;Update Z11 server
 S PNAME="VAMC "_STATION_" QRY-Z11 SERVER"
 S RESULT=$$EDP(PNAME,RTN)
 D:+RESULT<0 ERROR(RESULT,PNAME)
 ;
 ;Abort if unable to update QRY protocols correctly - Removed to allow for sites that may not have all interfaces
 ;I STOP D BMES^XPDUTL("Post Install Unable to Complete") Q
 ;
 ; To prevent Reset and Quitting from Loop if any protocols missing
 S EAS1096P=1
 ;
 ;Disable HECL protocols
 D TAG^EAS1071A(.RESULT,3)
 ;Display result of RPC and any warnings or errors - Removed as errors are printed in EAS1071B
 ;D BMES^XPDUTL(.RESULT)
 ;Completed OK
 D BMES^XPDUTL("Post Install Completed")
 ;
 Q
 ;
EDP(PNAME,RTN) ;Update response routine on QRY Z10/Z11 server Protocols
 ;
 N DA,DATA,DGENDA,ERROR,FILE,IEN101,RETURN
 S FILE=101
 ; If already exists then skip
 S IEN101=$O(^ORD(101,"B",PNAME,0))
 I 'IEN101 D  Q RETURN
 . S ERROR="IEN OF RECORD TO BE UPDATED NOT FOUND"
 . S RETURN=-1_"^"_ERROR,RETURN(1)=PNAME
 ;
 S DATA(772)=RTN
 S RETURN=$$UPD^DGENDBS(FILE,IEN101,.DATA,.ERROR)
 I ERROR'=""!(+RETURN=0) S RETURN=-1_"^"_ERROR,RETURN(1)=PNAME
 ;
 Q RETURN
 ;
ERROR(ERRMSG,SUBJ) ;Display Install Error message and set STOP
 N ARR
 ;
 S STOP=1
 S ARR(1)="===================================================="
 S ARR(2)="=                   WARNING                        ="
 S ARR(3)="===================================================="
 S ARR(4)="When updating "_SUBJ
 S ARR(5)="===================================================="
 S ARR(5)="**ERROR MSG: "_$P(ERRMSG,"^",2)
 ;
 D BMES^XPDUTL(.ARR)
 Q
