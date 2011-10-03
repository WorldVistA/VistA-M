XUMF218A ;OIFO-OAK/RAM - Load DMIS ID's;04/15/02
 ;;8.0;KERNEL;**218,261**;Jul 10, 1995
 ;
 ;
EN ; -- entry point
 ;
 N ID,NAME,FDA,ERROR,IEN,IENS,X,XUMF,STANUM,OFNME,AGENCY
 ;
 S XUMF=1
 ;
 S ID=""
 F  S ID=$O(^TMP("XUMF ARRAY",$J,ID)) Q:ID=""  D
 .S X=^TMP("XUMF ARRAY",$J,ID)
 .S STANUM=$P(X,U,3)
 .S IEN=$$IEN^XUMF(4,"DMIS",ID)
 .I 'IEN,$G(STANUM)'="" S IEN=$O(^DIC(4,"D",STANUM,0))
 .S IENS=$S(IEN:IEN_",",1:"+1,")
 .S NAME=$P(X,U,2)
 .S OFNME=$P(X,U,6)
 .S AGENCY=$P(X,U,17)
 .K FDA,IEN1
 .S FDA(4,IENS,.01)=NAME
 .S FDA(4,IENS,100)=OFNME
 .S FDA(4,IENS,95)=$P(AGENCY,"~")
 .D UPDATE^DIE("E","FDA","IEN1")
 .I 'IEN S IEN=$G(IEN1(1))
 .Q:'IEN
 .S IENS="?+1,"_IEN_","
 .K FDA
 .S FDA(4.9999,IENS,.01)="DMIS"
 .S FDA(4.9999,IENS,.02)=ID
 .D UPDATE^DIE("E","FDA")
 ;
 Q
 ;
FTCLEAN ; -- add missing facility types
 ;
 N NAME,FULL,FDA
 ;
 S NAME=""
 F  S NAME=$O(^TMP("XUMF ARRAY",$J,NAME)) Q:NAME=""  D
 .S FULL=$P(^TMP("XUMF ARRAY",$J,NAME),U,3)
 .D
 ..K FDA
 ..S FDA(4.1,"?+1,",.01)=NAME
 ..S FDA(4.1,"?+1,",1)=FULL
 ..S FDA(4.1,"?+1,",3)="N"
 ..N NAME
 ..D UPDATE^DIE("E","FDA",,"ERR")
 ;
 Q
 ;
