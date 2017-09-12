HLPAT24 ;SFIRMFO/RJH   Change data in file #771.7  ;04/16/97  16:23
 ;;1.6;HEALTH LEVEL SEVEN;**24**;Oct 13, 1995
 ;
 ; This routine is for one time use only. It modifys data in file
 ; #771.7
 N HLTMP
 S HLTMP(771.7,"1,",.01)="Invalid Event Protocol IEN"
 D FILE^DIE("EK","HLTMP")
 S HLTMP(1)="The event protocol IEN that was provided could not be found in the"
 S HLTMP(2)="Protocol file (#101)."
 D WP^DIE(771.7,"1,",2,"K","HLTMP")
 I $D(^TMP("DIERR",$J)) D
 .  D MES^XPDUTL("Error occurred, see global ^TMP(""DIERR"","_$J)
 Q
