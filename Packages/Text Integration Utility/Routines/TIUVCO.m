TIUVCO ;SPFO/AJB - VistA Cutoff  ;Mar 19, 2021@12:45:41
 ;;1.0;TEXT INTEGRATION UTILITIES;**330**;Jun 20, 1997;Build 51
 ;
 Q
CREATE(DFN,DOC,DOCTXT,USR) ; create a new document definition
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N %,DG,DICR,DIW,DIC,DILOCKTM,DLAYGO,DISYS,DR,X,Y
 Q:'+$G(DFN) 0_U_"Missing Patient" Q:'+$G(DOC) 0_U_"Missing Note Title"  Q:'+$G(USR) 0_U_"Missing Author"
 Q:'+$D(DOCTXT) 0_U_"Missing Document Text" Q:'+$G(DOCTXT) 0_U_"TEXT is empty"
 N DA,PARENT,TIUFPRIV
 S TIUFPRIV=1
 S (DIC,DLAYGO)=8925,DIC(0)="FL",X=""""_"`"_DOC_""""
 D ^DIC
 S DA=+$G(Y),PARENT=$$DOCCLASS^TIULC1(+$P($G(Y),U,2))
 I '+DA!('+PARENT) I +DA D DIK^TIURB2(DA)
 Q:'+DA "0^Failed to create new entry." Q:'+PARENT "0^Failed to find parent type."
 N CHKSUM,FDA,FDAIEN,FDAMSG,NOW S NOW=$$NOW^XLFDT
 S FDA(8925,DA_",",.02)=DFN ; patient
 S FDA(8925,DA_",",.04)=PARENT ; parent document type
 S FDA(8925,DA_",",.05)=5 ; status unsigned
 S FDA(8925,DA_",",1201)=NOW ; entry date/time
 S FDA(8925,DA_",",1202)=+USR ; author
 S FDA(8925,DA_",",1204)=+USR ; expected signer
 S FDA(8925,DA_",",1212)=$P(USR,U,2) ; division
 S FDA(8925,DA_",",1301)=NOW ; reference date/time
 S FDA(8925,DA_",",1302)=+USR ; entered by
 S FDA(8925,DA_",",1303)="R" ; capture method
 S FDA(8925,DA_",",1304)=NOW ; release date/time
 S FDA(8925,DA_",",1606)=NOW ; administrative closure date
 S FDA(8925,DA_",",1607)=$P(USR,U,3) ; admin closure sig block name
 S FDA(8925,DA_",",1608)=$P(USR,U,4) ; admin closure sig block title
 S FDA(8925,DA_",",1613)="M" ; admin closure mode
 D UPDATE^DIE("","FDA","","FDAMSG")
 ; set document text
 S DOCTXT=DOCTXT+4,^TIU(8925,DA,"TEXT",0)="^^"_DOCTXT_U_DOCTXT_U_DT_"^^" ; set zero node
 S DOCTXT=0 F  S DOCTXT=$O(DOCTXT(DOCTXT)) Q:'+DOCTXT  S ^TIU(8925,DA,"TEXT",DOCTXT,0)=DOCTXT(DOCTXT,0) ; set each line of text
 S DOCTXT=$O(DOCTXT(DOCTXT),-1) ; get last line of text
 S DOCTXT=DOCTXT+1,^TIU(8925,DA,"TEXT",DOCTXT,0)=" " ; admin closure information add to body text
 S DOCTXT=DOCTXT+1,^TIU(8925,DA,"TEXT",DOCTXT,0)="Administrative Closure: "_$$DATE^TIULS(DT,"MM/DD/CCYY")
 S DOCTXT=DOCTXT+1,^TIU(8925,DA,"TEXT",DOCTXT,0)="                    by: "_$P(USR,U,3)
 S DOCTXT=DOCTXT+1,^TIU(8925,DA,"TEXT",DOCTXT,0)="                        "_$P(USR,U,4)
 S CHKSUM=$$CHKSUM^TIULC("^TIU(8925,"_DA_",""TEXT"")")
 S $P(^TIU(8925,DA,15),U,3)=$$ENCRYPT^TIULC1("End of report text.",1,CHKSUM)
 S $P(^TIU(8925,DA,15),U,4)=$$ENCRYPT^TIULC1("["_$$FMTE^XLFDT(NOW,5)_"]",1,CHKSUM)
 K FDA S FDA(8925,DA_",",.05)=7 D UPDATE^DIE("","FDA","","FDAMSG") ; status complete
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration"," zDocument Creation [CPU]")=+$G(@INF@(" Duration"," zDocument Creation [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration"," zDocument Creation [SECS]")=+$G(@INF@(" Duration"," zDocument Creation [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q DA
LU(FILE,NAME,FLAGS,SCREEN,INDEXES,IENS) ;
 N DILOCKTM,DISYS
 Q $$FIND1^DIC(FILE,$G(IENS),$G(FLAGS),$G(NAME),$G(INDEXES),$G(SCREEN),"ERR")
