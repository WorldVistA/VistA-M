PXRMHOST ; SLC/PKR - Host file routines. ;07/20/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;=======================================================================
MKWSDEV ;Make the PXRM WORKSTATION device.
 N FDA,FDAIEN,MSG
 ;Make sure that the device does not get created more than once.
 I +$$FIND1^DIC(3.5,"","MX","PXRM WORKSTATION")>0 Q
 S FDA(3.5,"+1,",.01)="PXRM WORKSTATION" ;NAME
 S FDA(3.5,"+1,",.02)="PXRM Workstation HFS Device" ;LOCATION OF TERMINAL
 S FDA(3.5,"+1,",1)="PXRMWSD.DAT" ;$I
 S FDA(3.5,"+1,",1.95)=0 ;SIGN-ON/SYSTEM DEVICE
 S FDA(3.5,"+1,",2)="HFS" ;TYPE
 S FDA(3.5,"+1,",3)=$$FIND1^DIC(3.2,"","MX","P-OTHER") ;SUBTYPE
 S FDA(3.5,"+1,",4)=0 ;ASK DEVICE
 S FDA(3.5,"+1,",5)=0 ;ASK PARAMETERS
 S FDA(3.5,"+1,",5.1)=0 ;ASK HOST FILE
 S FDA(3.5,"+1,",5.2)=0 ;ASK HFS I/O OPERATION
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG) D
 . W !,"PXRM Workstation device creation failed, UPDATE^DIE returned the following error message:"
 . D AWRITE^PXRMUTIL("MSG")
 Q
 ;
