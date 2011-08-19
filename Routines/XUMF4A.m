XUMF4A ;CIOFO-SF/RAM - Institution File Clean Up; 06/28/99
 ;;8.0;KERNEL;**206,209,212,261**;Jul 10, 1995
 ;
 ;
EN ; -- entry point
 ;
 I $$CDSN D  Q
 .D MSG^VALM10("Duplicates sta #s exist! -- NOTHING UPDATED!!!")
 .H 5
 .S VALMBCK="R"
 ;
 W "...working",!
 D DSN,CSN,GOLD,ASSC,HIST
 ;
 K ^TMP("XUMF NAME",$J)
 D NAME^XUMF4
 S VALMBG=1
 S VALMBCK="R"
 ;
 Q
 ;
DSN ; -- clean out local station numbers
 ;
 N IEN,DIE,DR,DA,XUMF,DIK
 ;
 S XUMF=7
 ;
 S IEN=0
 F  S IEN=$O(^DIC(4,IEN)) Q:'IEN  D
 .S STA=$P($G(^DIC(4,+IEN,99)),U) Q:STA=""
 .Q:$D(^TMP("XUMF ARRAY",$J,STA))
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
CSN ; -- check/update status
 ;
 N IEN,DIE,DR,DA,XUMF,STATUS,STA
 ;
 S XUMF=7
 ;
 S IEN=0
 F  S IEN=$O(^DIC(4,IEN)) Q:'IEN  D
 .S STA=$P($G(^DIC(4,+IEN,99)),U)
 .I STA S DR="11///N",DIE=4,DA=IEN D  Q
 ..N IEN D ^DIE
 .S STATUS=$P(^DIC(4,IEN,0),U,11)
 .I STATUS="I" S DR="101///I",DIE=4,DA=IEN D
 ..N IEN D ^DIE
 .S DR="11///L",DIE=4,DA=IEN D
 ..N IEN D ^DIE
 ;
 Q
 ;
GOLD ; -- add missing national data from standard table
 ;
 N STA,NAME,FDA,ERROR,IEN,IENS,X,FLAG,CNT
 N OLDNAME,OLDVANM,STATE,FACTYP,XUMF,STATE,AGENCY
 ;
 S XUMF=7
 ;
 S STA="",CNT=0
 F  S STA=$O(^TMP("XUMF ARRAY",$J,STA)) Q:STA=""  D
 .S X=^TMP("XUMF ARRAY",$J,STA)
 .S IEN=$O(^DIC(4,"D",STA,0))
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
 .S FDA(4,IENS,11)="NATIONAL"
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
 ..D UPDATE^DIE("E","FDA",,"ERR")
 ..S CNT=CNT+1 I '(CNT#10) W "."
 ;
 Q
 ;
ASSC ; -- populate associations (parent facility and VISN)
 ;
 N IEN,STA,VISN,PARENT,FDA,XUMF,CNT
 ;
 S XUMF=7
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
 ...S CNT=CNT+1 I '(CNT#10) W "."
 ;
 Q
 ;
HIST ; -- history
 ;
 N IEN,STA,EFFDT,FDA,XUMF,CNT
 ;
 S XUMF=7
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
 ...S CNT=CNT+1 I '(CNT#10) W "."
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
CMVD() ; -- check for missing national data
 ;
 N STA,CNT
 ;
 S CNT=0
 ;
 S STA=""
 F  S STA=$O(^TMP("XUMF ARRAY",$J,STA)) Q:STA=""  D
 .Q:$D(^DIC(4,"D",STA))
 .S CNT=CNT+1
 ;
 Q CNT
 ;
CHCK ; -- check if clean up is complete
 ;
 N VAR,FLD
 ;
 K ^TMP("XUMF CHCK",$J)
 ;
 S VALMCNT=0
 ;
 I $$CDSN D
 .S VALMCNT=VALMCNT+1,VAR=""
 .S FLD="Local/Duplicate station #s exist -- use DSTA"
 .S VAR=$$SETFLD^VALM1(FLD,VAR,"MSG")
 .D SET^VALM10(VALMCNT,VAR,VALMCNT)
 ;
 I $$CMVD D
 .S VALMCNT=VALMCNT+1,VAR=""
 .S FLD="INSTITUTION file not updated with NATIONAL data -- use AUTO"
 .S VAR=$$SETFLD^VALM1(FLD,VAR,"MSG")
 .D SET^VALM10(VALMCNT,VAR,VALMCNT)
 ;
 D:'VALMCNT
 .S VAR="",FLD="CONGRATULATIONS!!!  Update complete!"
 .S VAR=$$SETFLD^VALM1(FLD,VAR,"MSG")
 .D SET^VALM10(1,VAR,1)
 ;
 Q
 ;
FACTYP ;resolve duplicate facility types
 ;
 N FT,CNT,IEN,DA,DIE,DR
 ;
 S FT="",(CNT,IEN)=0
 F  S FT=$O(^DIC(4.1,"B",FT)) Q:FT=""  D
 .F  S IEN=$O(^DIC(4.1,"B",FT,IEN)) Q:'IEN  D
 ..Q:$E(FT,1,2)="ZZ"
 ..S CNT=CNT+1
 ..Q:CNT<2
 ..S DA=IEN,DIE=4.1
 ..S DR=".01///ZZ"_$P($G(^DIC(4.1,+IEN,0)),U)
 ..D ^DIE
 .S CNT=0
 ;
 Q
 ;
STATE ;resolve duplicate states
 ;
 N STATE,CNT,IEN,DA,DIE,DR
 ;
 ;name
 S STATE="",(CNT,IEN)=0
 F  S STATE=$O(^DIC(5,"B",STATE)) Q:STATE=""  D
 .F  S IEN=$O(^DIC(5,"B",STATE,IEN)) Q:'IEN  D
 ..Q:$E(STATE,1,2)="ZZ"
 ..S CNT=CNT+1
 ..Q:CNT<2
 ..S DA=IEN,DIE=5
 ..S DR=".01///ZZ"_$P($G(^DIC(5,+IEN,0)),U)
 ..D ^DIE
 .S CNT=0
 ;
 ;abbreviation
 S STATE="",(CNT,IEN)=0
 F  S STATE=$O(^DIC(5,"C",STATE)) Q:STATE=""  Q:STATE  D
 .F  S IEN=$O(^DIC(5,"C",STATE,IEN)) Q:'IEN  D
 ..Q:$E(STATE,1,2)="ZZ"
 ..S CNT=CNT+1
 ..Q:CNT<2
 ..S DA=IEN,DIE=5
 ..S DR="1///ZZ"_$P($G(^DIC(5,+IEN,0)),U,2)
 ..D ^DIE
 .S CNT=0
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
