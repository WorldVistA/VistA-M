IVM2A102 ;ALB/PJR - IVM*2.0*102 PRE-INSTALL ; 10/25/04 12:33pm
 ;;2.0;INCOME VERIFICATION MATCH;**102**; 21-OCT-94
 ;
 Q
PRE ; pre-install entry point
 ; add 2 new entries to the 301.92 file
 N FDA,DATA,ERR,XME,FLDNUM
 S DATA=""
 S XME="  >> Adding entries to IVM DEMOGRAPHIC UPLOAD FIELDS (#301.92) file"
 D BMES^XPDUTL(XME)
 D SOURCE(.DATA),UPDATE(.DATA)
 D LAST(.DATA),UPDATE(.DATA)
 ;;
 D MES^XPDUTL("")
 Q
 ;
SOURCE(DATA) ; setup fda array for Source of Notification for DOD
 S DATA(.01)="SOURCE OF NOTIFICATION"
 S DATA(.02)="ZPD31",DATA(.05)=.353,DATA(.04)=2
 S (DATA(.03),DATA(.06),DATA(.07))=1,DATA(.08)=0
 S (DATA(10),DATA(20))="S DR=.353 D LOOK^IVMPREC9"
 Q
 ;
LAST(DATA) ; setup fda array for Last Updated Date for DOD
 S DATA(.01)="DATE OF DEATH LAST UPDATED"
 S DATA(.02)="ZPD32",DATA(.05)=.354,DATA(.04)=2
 S (DATA(.03),DATA(.06),DATA(.07))=1,DATA(.08)=0
 S (DATA(10),DATA(20))="S DR=.354 D LOOK^IVMPREC9"
 Q
 ;
UPDATE(DATA) ;
 I $$FIND1^DIC(301.92,"","X",$G(DATA(.01))) D ALREADY Q
 S FLDNUM="" F  S FLDNUM=$O(DATA(FLDNUM)) Q:'FLDNUM  D ADD
 D UPDATE^DIE("","FDA","","ERR")
 I $D(ERR) D ERROR Q
 D SUCCESS
 K DATA
 Q
ADD ;;
 S FDA(301.92,"+1,",FLDNUM)=$G(DATA(FLDNUM)) Q
 ;
ALREADY ;;
 D BMES^XPDUTL("      *** "_$G(DATA(.01))_" entry already exists!") Q
ERROR ;
 D BMES^XPDUTL("   >>> ERROR! "_$G(DATA(.01))_" not added to file #301.92!")
 I $D(ERR("DIERR",1))=11 D
 .D MES^XPDUTL(ERR("DIERR",1)_": "_ERR("DIERR",1,"TEXT",1))
 Q
SUCCESS ;
 D BMES^XPDUTL("      "_$G(DATA(.01))_" successfully added.") Q
