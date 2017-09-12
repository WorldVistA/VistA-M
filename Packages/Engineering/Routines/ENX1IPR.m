ENX1IPR ;WIRMFO/SAB-PRE-INIT ;10/29/97
 ;;7.0;ENGINEERING;**46**;Aug 17, 1993
 ;
 N ENDA,ENFDA
 ;
 ; update .01 of excess fund to prevent adding entry during install
 S ENDA=$$FIND1^DIC(6914.3,"","X","1561","B")
 I ENDA D
 . D BMES^XPDUTL("  Renaming the Excess SGL from 1561 to 1524.")
 . K ENFDA S ENFDA(6914.3,ENDA_",",.01)="1524"
 . D FILE^DIE("","ENFDA") D MSG^DIALOG()
 ;
 ; update id field of supply fund to prevent adding entry during install
 S ENDA=$$FIND1^DIC(6914.6,"","X","4537B","B")
 I ENDA D
 . K ENFDA S ENFDA(6914.6,ENDA_",",1)="Field Supply Fund"
 . D FILE^DIE("","ENFDA") D MSG^DIALOG()
 ;
 Q
 ;ENX1IPR
