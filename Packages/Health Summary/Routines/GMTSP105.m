GMTSP105 ; MWA/VMP - Pre install GMTS*2.7*105 ; 6/26/12 10:09am
 ;;2.7;Health Summary;**105**;;Build 5
 ;
 ;
 Q
EN ; main entry point
 D BMES^XPDUTL("Starting Pre-install Routine...")
 D CHANGE
 D BMES^XPDUTL("Pre-install Routine Finished")
 Q
CHANGE ; changes descriptions
 N CPNM,CPIEN
 K ^TMP("GMTSP105",$J)
 F CPNM="MHA Administration List","MHA Score" I $D(^GMT(142.1,"B",CPNM)) S CPIEN=$O(^GMT(142.1,"B",CPNM,0)) D
 .I CPNM="MHA Administration List" D  Q
 ..I $G(^GMT(142.1,CPIEN,3.5,1,0))="This component displays all administrations of intruments in"!($G(^GMT(142.1,CPIEN,3.5,5,0))="Date ranges and maximum occurances apply. ") D
 ...M ^TMP("GMTSP105",$J,"WP")=^GMT(142.1,CPIEN,3.5)
 ...S:$G(^TMP("GMTSP105",$J,"WP",1,0))="This component displays all administrations of intruments in" ^TMP("GMTSP105",$J,"WP",1,0)="This component displays all administrations of instruments in"
 ...S:$G(^TMP("GMTSP105",$J,"WP",5,0))="Date ranges and maximum occurances apply. " ^TMP("GMTSP105",$J,"WP",5,0)="Date ranges and maximum occurrences apply."
 ...D DIECALL(142.1,CPIEN_",",3.5,"","^TMP(""GMTSP105"",$J,""WP"")")
 .I CPNM="MHA Score" D
 ..I $G(^GMT(142.1,CPIEN,3.5,2,0))="intruments in the mental health package. Tests, interviews and surveys from MH"!($G(^GMT(142.1,CPIEN,3.5,5,0))="Date ranges and maximum occurances apply.") D
 ...M ^TMP("GMTSP105",$J,"WP")=^GMT(142.1,CPIEN,3.5)
 ...S:$G(^TMP("GMTSP105",$J,"WP",2,0))="intruments in the mental health package. Tests, interviews and surveys from MH" ^TMP("GMTSP105",$J,"WP",2,0)="instruments in the mental health package. Tests, interviews and surveys from MH"
 ...S:$G(^TMP("GMTSP105",$J,"WP",5,0))="Date ranges and maximum occurances apply." ^TMP("GMTSP105",$J,"WP",5,0)="Date ranges and maximum occurrences apply."
 ...D DIECALL(142.1,CPIEN_",",3.5,"","^TMP(""GMTSP105"",$J,""WP"")")
 Q
DIECALL(FILE,IENS,FIELD,FLAGS,ROOT) ; FILEMAN CALL
 D WP^DIE(FILE,IENS,FIELD,FLAGS,ROOT)
 K ^TMP("GMTSP105",$J)
 Q
