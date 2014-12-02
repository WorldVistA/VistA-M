SD53588P ;ALB/MAF - DG*5.3*588 POST INIT ; 
 ;;5.3;Scheduling;**588**;Aug 13,1993;Build 53
 ;
POST ;Adding new parameters for number of days no show and proactive report
 N SDPAR,SDERR,SDPARNM
 ;
 S SDPAR=30
 D BMES^XPDUTL("Updating Parameters File...")
 ;
 S SDPARNM="SDMH PROACTIVE DAYS"
 D ADD^XPAR("PKG.SCHEDULING",SDPARNM,1,SDPAR,.SDERR)
 D ADDERR
 ;
 N SDERR
 S SDPARNM="SDMH NO SHOW DAYS"
 D ADD^XPAR("PKG.SCHEDULING",SDPARNM,1,SDPAR,.SDERR)
 D ADDERR
 Q
 ;
ADDERR ;error message written during install
 I +$G(SDERR)>0 D  Q
 .D BMES^XPDUTL(SDPARNM)
 .D BMES^XPDUTL("    "_SDERR)
 I '+$G(SDERR)>0 D
 .D BMES^XPDUTL(SDPARNM_" updated successfully....")
 Q
 ;
DEL ;Delete the paramater...for patch testing only... will delete out parameters
 N SDERR
 ;
 D BMES^XPDUTL("Deleteing Parameters File...")
 ;
 D DEL^XPAR("PKG.SCHEDULING","SDMH PROACTIVE DAYS",,.SDERR)
 I +$G(SDERR)>0 D 
 . D BMES^XPDUTL(SDERR)
 N SDERR
 D DEL^XPAR("PKG.SCHEDULING","SDMH NO SHOW DAYS",,.SDERR)
 I +$G(SDERR)>0 D  Q
 . D BMES^XPDUTL(SDERR)
 Q
 ;
UPDPRO ; Programmer access point to manually change Parameter entry for proactive report
 N SDPAR,SDRPT,SDERR,DIR,DIRUT,X,Y
 S SDRPT="PROACTIVE REPORT"
 D ASK Q:$D(DIRUT)
 D CHG^XPAR("PKG.SCHEDULING","SDMH PROACTIVE DAYS",,SDPAR,.SDERR)
 D ERR
 Q
UPDNSH ; Programmer access point to manually change Parameter entry for no show report
 N SDPAR,SDRPT,SDERR,DIR,DIRUT,X,Y
 S SDRPT="NO SHOW REPORT"
 D ASK Q:$D(DIRUT)
 D CHG^XPAR("PKG.SCHEDULING","SDMH NO SHOW DAYS",,SDPAR,.SDERR)
 D ERR
 Q
ASK ;ASK NUMBER OF DAYS
 S DIR(0)="FAO^^"
 S DIR("A")="Number of days: "
 S DIR("A",1)="Enter the number of days of future appointments that will"
 S DIR("A",2)="list on the "_SDRPT_" for a patient."
 S DIR("A",3)=" "
 S DIR("?")="Enter a number between 1 and 30"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S SDPAR=$G(Y)
 Q
 ;
 D CHG^XPAR("PKG.SCHEDULING","SDMH PROACTIVE DAYS",,SDPAR,.SDERR)
ERR I '+$G(SDERR) D
 . W !?3,"Parameter Defintion has been updated!"
 ;
 I +$G(SDERR)>0 D
 . W !?3,"An Error occurred:"
 . W !?3,$P($G(SDERR),U,2)
 I +$G(SDERR)>0 G @($S(SDRPT="NO SHOW REPORT":"UPDNSH",1:"UPDPRO"))
 Q
