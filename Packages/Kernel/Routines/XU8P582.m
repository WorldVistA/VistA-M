XU8P582 ;BP-OAK/BT - Error Trap Summary Utilities ;08/02/2011
 ;;8.0;KERNEL;**582**;Jul 10, 1995;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
POST ;Post-init for patch XU*8*582
 N FDA,XU582
 S XU582=+$P($G(^XTV(8989.3,1,"ZTER")),"^",1)
 I XU582=10 S FDA(8989.3,"1,",520.1)=100 D FILE^DIE("","FDA")
 D GETXUIEN ; Update Descption for the option XUERTRP AUTO CLEAN
 D PATCH^ZTMGRSET(582)
 Q
 ;
GETXUIEN ; get IEN of the option XUERTRP AUTO CLEAN
 N XUIEN S XUIEN=$$FIND1^DIC(19,"","MX","XUERTRP AUTO CLEAN","","","ERR")
 I XUIEN'>0 Q
 D DEF1(XUIEN) ; Update Description for the option XUERTRP AUTO CLEAN
 Q
 ;
DEF1(XUIEN) ; Update TEXT Description for an option
 N XUI1,XUDATA,XUY
 K ^TMP($J,"XUBA")
 F XUY=1:1:4 S XUDATA=$T(TEXT+XUY) Q:XUDATA=" ;;END"  D 
 . S ^TMP($J,"XUBA",XUIEN,XUY,0)=$P(XUDATA,";;",2)
 S XUI1=XUIEN_","
 D WP^DIE(19,XUI1,3.5,"K","^TMP($J,""XUBA"",XUIEN)")
 K ^TMP($J,"XUBA")
 Q
 ;
TEXT ;
 ;;This is a queueable option to clean up the error trap. This option will 
 ;;clean-up any errors that were recorded more than a number of days ago. The
 ;;number of days is defined on the KEEP ERROR TRAP field (#520.3) in the KERNEL
 ;;SYSTEM PARAMETERS file (#8989.3). The default is 7 if the field is blank.
 ;;END
