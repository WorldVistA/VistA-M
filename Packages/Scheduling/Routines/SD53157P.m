SD53157P ;ALB/JLU;POST INIT FOR PATCH SD*5.3*157;10/15/98
 ;;5.3;Scheduling;**157**;Aug 13, 1993
 ;
EN ;Main entry point
 N PARIEN,PCMM,PCMMOUT,PCMMERR,PCMMPAR
 ;
 D FIND^DIC(3.8,"",.01,"X","SCMC PCMM REASSIGNMENT","","","","","PCMMOUT","PCMMERR")
 ;
 ;check for error from call
 I $D(PCMMERR("DIERR")) D  G EXIT
 .D BMES^XPDUTL("An error has been recorded:")
 .D MES^XPDUTL(PCMMERR("DIERR",1,"TEXT",1))
 .Q
 ;
 ;check to see if the mail group was installed.
 I +$G(PCMMOUT("DILIST",0))<1 D  G EXIT
 .D BMES^XPDUTL("Could not find the SCMC PCMM REASSIGNMENT mail group.")
 .D MES^XPDUTL("The REASSIGNMENT MAIL GROUP parameter will not be populated.  Consult")
 .D MES^XPDUTL("National VISTA Support.")
 .Q
 ;
 ;get scheduling parameter file entry
 S PARIEN=$O(^SD(404.91,0))
 I 'PARIEN D BMES^XPDUTL("No entry exists in the Scheduling Parameter file.  No update occured.") G EXIT
 I $P(^SD(404.91,PARIEN,"PCMM"),U,4)]"" D BMES^XPDUTL("REASSIGNMENT MAIL GROUP Parameter already populated.  No updating performed.") G EXIT
 ;
 D CLEAN
 ;stuffing mail group into pcmm parameter.
 S PCMMPAR(404.91,PARIEN_",",804)="SCMC PCMM REASSIGNMENT"
 D FILE^DIE("E","PCMMPAR","PCMMERR")
 I $D(PCMMERR("DIERR")) D  G EXIT
 .D BMES^XPDUTL("The Scheduling Parameter file field REASSIGNMENT MAIL GROUP, could")
 .D MES^XPDUTL("not be updated.  The following error has occured.")
 .D BMES^XPDUTL(PCMMERR("DIERR",1,"TEXT",1))
 .Q
 D BMES^XPDUTL("The Scheduling Parameter file field REASSIGNMENT MAIL GROUP has been updated.")
 ;
EXIT D CLEAN
 Q
 ;
CLEAN ;
 K PCMMERR("DIERR"),PCMMOUT("DILIST")
 Q
