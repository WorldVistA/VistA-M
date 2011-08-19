XUMF479P ;OIFO-BP/RAM - Master File Parameters Med Routes ;06/28/00
 ;;8.0;KERNEL;**479**;Jul 10, 1995;Build 9
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ;
MAIN ; -- Entry point
 ;
 ;Q:'$D(^DD(51.23))
 ;
 N FDA,IENS,FIELD,ERR,SEQ,XUMF,X,IEN,XMDUZ
 ;
 S XUMF=1,IEN=51.23
 ;
 D ZERO,CLEAN,NODES,MD5,EXIT
 ;
 Q
 ;
ZERO ; -- zero node
 ;
 N DIC,DA,X,DINUM,Y
 ;
 K DIC S DIC="^DIC(4.001,",X=IEN,DINUM=X,DIC(0)="F" D FILE^DICN K DIC
 ;
 K FDA
 S IENS=IEN_","
 ;
 S FDA(4.001,IENS,.01)=51.23
 S FDA(4.001,IENS,.03)="Medication Routes"
 S FDA(4.001,IENS,.07)="Medication Routes"
 S FDA(4.001,IENS,2)="D MFSUP^HDISVF09(51.23,$G(ERROR))"
 ;
 D UPDATE^DIE("","FDA",,"ERR")
 I $D(ERR) D
 .D EM("UPDATE ZERO error",.ERR)
 .K ERR
 ;
 Q
 ;
CLEAN ; -- clean out SEQUENCE
 ;
 K FDA
 S SEQ=0
 F  S SEQ=$O(^DIC(4.001,IEN,1,SEQ)) Q:'SEQ  D
 .S IENS=SEQ_","_IEN_","
 .S FDA(4.011,IENS,.01)="@"
 ;
 D FILE^DIE("E","FDA")
 ;
 Q
 ;
NODES ; -- SEQUENCE
 ;
 K FDA
 S IENS="+1,"_IEN_","
 S FDA(4.011,IENS,.01)="Term"
 S FDA(4.011,IENS,.02)=.01
 S FDA(4.011,IENS,.15)=1
 ;
 S IENS="+2,"_IEN_","
 S FDA(4.011,IENS,.01)="FDB_Med_Route"
 S FDA(4.011,IENS,.02)=1
 S FDA(4.011,IENS,.15)=2
 ;
 S IENS="+3,"_IEN_","
 S FDA(4.011,IENS,.01)="vista_replaced_by"
 S FDA(4.011,IENS,.02)=99.97
 S FDA(4.011,IENS,.15)=3
 S FDA(4.011,IENS,.13)="VUID"
 ;
 ;S IENS="+4,"_IEN_","
 ;S FDA(4.011,IENS,.01)="EffectiveDate"
 ;S FDA(4.011,IENS,.02)=.01
 ;S FDA(4.011,IENS,.04)=51.2399
 ;S FDA(4.011,IENS,.06)="EffectiveDate"
 ;S FDA(4.011,IENS,.15)=4
 ;
 S IENS="+4,"_IEN_","
 S FDA(4.011,IENS,.01)="Status"
 S FDA(4.011,IENS,.02)=.02
 S FDA(4.011,IENS,.04)=51.2399
 S FDA(4.011,IENS,.06)="Status"
 S FDA(4.011,IENS,.15)=4
 ;
 D UPDATE^DIE("E","FDA",,"ERR")
 I $D(ERR) D
 .D EM("UPDATE NODES error",.ERR)
 .K ERR
 ;
 Q
 ;
MD5 ; -- MD5
 ;
 N IENS1
 ;
 S IEN=$O(^DIC(4.005,"B","Medication Routes",0))
 ;
 I 'IEN D  Q:'IEN
 .K FDA
 .S FDA(4.005,"+1,",.01)="Medication Routes"
 .;
 .D UPDATE^DIE("E","FDA",,"ERR")
 .I $D(ERR) D
 ..D EM("UPDATE MD5 error",.ERR)
 ..K ERR
 .S IEN=$O(^DIC(4.005,"B","Medication Routes",0))
 ;
 S IENS=IEN_","
 ;
 K FDA
 S SEQ=0
 F  S SEQ=$O(^DIC(4.005,IEN,1,SEQ)) Q:'SEQ  D
 .S IENS1=SEQ_","_IEN_","
 .S FDA(4.0051,IENS1,.01)="@"
 D FILE^DIE("E","FDA","ERR")
 ;
 K FDA
 S IENS1="+1,"_IENS
 S FDA(4.0051,IENS1,.01)=51.23
 D UPDATE^DIE("E","FDA",,"ERR")
 I $D(ERR) D
 .D EM("UPDATE MD5 1 error",.ERR)
 .K ERR
 ;
 S IENS1=51.23_","_IENS
 ;
 K FDA
 S FDA(4.00511,"+1,"_IENS1,.01)=.01
 S FDA(4.00511,"+1,"_IENS1,1)=20
 S FDA(4.00511,"+2,"_IENS1,.01)=1
 S FDA(4.00511,"+2,"_IENS1,1)=30
 S FDA(4.00511,"+3,"_IENS1,.01)=99.99
 S FDA(4.00511,"+3,"_IENS1,1)=10
 S FDA(4.00511,"+4,"_IENS1,.01)=99.97
 S FDA(4.00511,"+4,"_IENS1,1)=40
 S FDA(4.00511,"+4,"_IENS1,2)="EXTERNAL"
 S FDA(4.00511,"+4,"_IENS1,3)=51.23
 ;
 D UPDATE^DIE("E","FDA",,"ERR")
 I $D(ERR) D
 .D EM("UPDATE MD5 2 error",.ERR)
 .K ERR
 ;
EXIT ; -- cleanup, and quit
 ;
 Q
 ;
EM(ERROR,ERR,XMSUB,XMY) ; -- error message
 ;
 N X,XMTEXT
 ;
 D MSG^DIALOG("AM",.X,80,,"ERR")
 ;
 S X(.1)="HL7 message ID: "_$G(HL("MID"))
 S X(.2)="",X(.3)=$G(ERROR),X(.4)=""
 S:$G(XMSUB)="" XMSUB="MFS ERROR"
 ;S XMY("G.XUMF ERROR")="",XMDUZ=.5
 S XMY("G.XUMF TEST")="",XMDUZ=.5
 S XMTEXT="X("
 ;
 D ^XMD
 ;
 Q
 ;
