XUMF4L1 ;OIFO-OAK/RAM - Load IMF ;02/21/02
 ;;8.0;KERNEL;**217,261**;Jul 10, 1995
 ;
 ;
EN ; -- entry point
 ;
 K ^TMP("XUMF ADD",$J),^TMP("XUMF MOD",$J),^TMP("XUMF DEL",$J)
 ;
 D DSN,GOLD,ASSC,HIST
 ;
 Q
 ;
DSN ; -- clean out local station numbers
 ;
 N IEN,DIE,DR,DA,XUMF,DIK
 ;
 S XUMF=1
 ;
 S IEN=0
 F  S IEN=$O(^DIC(4,IEN)) Q:'IEN  D
 .S STA=$P($G(^DIC(4,+IEN,99)),U) Q:STA=""
 .Q:$D(^TMP("XUMF ARRAY",$J,STA))
 .S ^TMP("XUMF DEL",$J,STA,IEN)=""
 .S DR="99///@",DIE=4,DA=IEN
 .D
 ..N IEN D ^DIE
 ;
 S STA="",IEN=0
 F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  D
 .F  S IEN=$O(^DIC(4,"D",STA,IEN)) Q:'IEN  D
 ..Q:$P($G(^DIC(4,+IEN,99)),U)=STA
 ..K ^DIC(4,"D",STA,IEN)
 ;
 S DIK="^DIC(4,",DIK(1)="99^D" D ENALL^DIK
 ;
 Q
 ;
GOLD ; -- add missing national data from standard table
 ;
 N STA,NAME,FDA,ERROR,IEN,IENS,X,FLAG,CNT
 N OLDNAME,OLDVANM,STATE,FACTYP,XUMF,AGENCY
 ;
 S XUMF=1
 ;
 S STA="",CNT=0
 F  S STA=$O(^TMP("XUMF ARRAY",$J,STA)) Q:STA=""  D
 .S X=^TMP("XUMF ARRAY",$J,STA)
 .S IEN=$O(^DIC(4,"D",STA,0))
 .S:'IEN ^TMP("XUMF ADD",$J,STA)=^TMP("XUMF ARRAY",$J,STA)
 .D:IEN MOD
 .S OLDNAME=$P($G(^DIC(4,+IEN,0)),U,1)
 .S OLDVANM=$P($G(^DIC(4,+IEN,99)),U,3)
 .S IENS=$S(IEN:IEN_",",1:"+1,")
 .S NAME=$P(X,U,2)
 .S FACTYP=$P(X,U,5)
 .S VANAME=$P(X,U,6)
 .S FLAG=$P(X,U,7)
 .S STATE=$P(X,U,8)
 .S AGENCY=$P(X,U,17)
 .K FDA
 .S FDA(4,IENS,.01)=NAME
 .S FDA(4,IENS,.02)=STATE
 .S FDA(4,IENS,99)=STA
 .S FDA(4,IENS,11)="National"
 .S FDA(4,IENS,13)=$P(FACTYP,"~")
 .S FDA(4,IENS,100)=VANAME
 .S FDA(4,IENS,101)=FLAG
 .S FDA(4,IENS,95)=$P(AGENCY,"~")
 .D
 ..N IEN,STA,NAME,VANAME,OLDNAME,OLDVANM
 ..D UPDATE^DIE("E","FDA",,"ERR")
 .I 'IEN S IEN=$O(^DIC(4,"D",STA,0))
 .Q:'IEN
 .I OLDNAME="" Q
 .I OLDNAME=NAME,VANAME=OLDVANM Q
 .S IENS="?+"_DT_","_IEN_","
 .K FDA
 .S FDA(4.999,IENS,.01)=DT
 .S:NAME'=OLDNAME FDA(4.999,IENS,.02)=OLDNAME
 .S:VANAME'=OLDVANM FDA(4.999,IENS,.03)=OLDVANM
 .D
 ..N STA
 ..D UPDATE^DIE("E","FDA")
 ..S CNT=CNT+1
 ;
 Q
 ;
ASSC ; -- populate associations (parent facility and VISN)
 ;
 N IEN,STA,VISN,PARENT,FDA,XUMF,CNT
 ;
 S XUMF=1
 ;
 S STA="",CNT=0
 F  S STA=$O(^TMP("XUMF ARRAY",$J,STA)) Q:STA=""  D
 .S IEN=$O(^DIC(4,"D",STA,0)) Q:'IEN
 .S VISN=$P(^TMP("XUMF ARRAY",$J,STA),U,9)
 .I VISN'="" D
 ..K FDA
 ..S IENS="?+1,"_IEN_","
 ..S FDA(4.014,IENS,.01)="VISN"
 ..S FDA(4.014,IENS,1)=$P(VISN,"~")
 ..D
 ...N IEN,STA
 ...D UPDATE^DIE("E","FDA")
 .S PARENT=$P(^TMP("XUMF ARRAY",$J,STA),U,10)
 .I PARENT'="" D
 ..K FDA
 ..S IENS="?+2,"_IEN_","
 ..S FDA(4.014,IENS,.01)="PARENT FACILITY"
 ..S FDA(4.014,IENS,1)=PARENT
 ..D
 ...N IEN,STA
 ...D UPDATE^DIE("E","FDA")
 ...S CNT=CNT+1
 ;
 Q
 ;
HIST ; -- history
 ;
 N IEN,STA,EFFDT,FDA,XUMF,CNT
 ;
 S XUMF=1
 ;
 S STA="",CNT=0
 F  S STA=$O(^TMP("XUMF ARRAY",$J,STA)) Q:STA=""  D
 .S IEN=$O(^DIC(4,"D",STA,0)) Q:'IEN
 .S EFFDT=$P(^TMP("XUMF ARRAY",$J,STA),U,11)
 .S EFFDT=$$FMDATE^HLFNC(+EFFDT)
 .I EFFDT D
 ..S IENS="?+"_EFFDT_","_IEN_","
 ..K FDA
 ..S FDA(4.999,IENS,.01)=EFFDT
 ..S FDA(4.999,IENS,.06)=$P(^TMP("XUMF ARRAY",$J,STA),U,12)
 ..D
 ...N IEN,STA
 ...D UPDATE^DIE("E","FDA")
 .S EFFDT=$P(^TMP("XUMF ARRAY",$J,STA),U,13)
 .S EFFDT=$$FMDATE^HLFNC(+EFFDT)
 .I EFFDT D
 ..S IENS="?+"_EFFDT_","_IEN_","
 ..K FDA
 ..S FDA(4.999,IENS,.01)=EFFDT
 ..S FDA(4.999,IENS,.05)=$P(^TMP("XUMF ARRAY",$J,STA),U,14)
 ..D
 ...N IEN,STA
 ...D UPDATE^DIE("E","FDA")
 ...S CNT=CNT+1
 ;
 Q
 ;
CDSN() ; -- check for duplicate sta # (true=duplicates, false=none)
 ;
 K ^TMP("XUMF TMP",$J)
 ;
 N IEN,STA,CNT
 ;
 S STA="",IEN=0
 F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  D
 .F  S IEN=$O(^DIC(4,"D",STA,IEN)) Q:'IEN  D
 ..S ^TMP("XUMF TMP",$J,STA,IEN)=$P(^DIC(4,IEN,0),U)
 ;
 S STA="",(CNT,IEN)=0
 F  S STA=$O(^TMP("XUMF TMP",$J,STA)) Q:STA=""  D
 .Q:'$O(^TMP("XUMF TMP",$J,STA,+$O(^TMP("XUMF TMP",$J,STA,0))))
 .F  S IEN=$O(^TMP("XUMF TMP",$J,STA,IEN)) Q:'IEN  D
 ..S CNT=CNT+1
 ;
 K ^TMP("XUMF TMP",$J)
 ;
 Q CNT
 ;
MOD ; if entry modified set TMP
 ;
 N NAME,FACTYP,VANAME,STANUM,FLAG,PRNT,VISN,STATE,X,Y
 ;
 Q:'$D(^DIC(4,+IEN,0))
 ;
 S X=$P(^TMP("XUMF ARRAY",$J,STA),U,2,10)
 ;
 S NAME=$P($G(^DIC(4,+IEN,0)),U)
 S FACTYP=$P($G(^DIC(4.1,+$G(^DIC(4,+IEN,3)),0)),U)
 S:FACTYP'="" FACTYP=FACTYP_"~FACILITY TYPE~VA"
 S VANAME=$P($G(^DIC(4,+IEN,99)),U,3)
 S STANUM=$P($G(^DIC(4,+IEN,99)),U)
 S FLAG=$S(+$P($G(^DIC(4,+IEN,99)),U,4):"INACTIVE",1:"")
 S PRNT=$P($G(^DIC(4,+$P($G(^DIC(4,+IEN,7,2,0)),U,2),99)),U)
 S VISN=$P($G(^DIC(4,+$P($G(^DIC(4,+IEN,7,1,0)),U,2),0)),U)
 S:VISN'="" VISN=VISN_"~VISN~VA"
 S STATE=$P($G(^DIC(5,+$P($G(^DIC(4,+IEN,0)),U,2),0)),U)
 ;
 S Y=NAME_U_STANUM_U_"National"_U_FACTYP_U_VANAME_U_FLAG_U_STATE
 S Y=Y_U_VISN_U_PRNT
 ;
 Q:Y=X
 ;
 S ^TMP("XUMF MOD",$J,STA,"NEW")=X
 S ^TMP("XUMF MOD",$J,STA,"OLD")=Y
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
