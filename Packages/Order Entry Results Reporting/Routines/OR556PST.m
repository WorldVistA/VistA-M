OR556PST ;HPS/DSK - OR*3.0*556 PATCH POST INSTALL ROUTINE; May 24, 2021@16:38
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**556**;Dec 17, 1997;Build 6
 ;
 Q
 ;
EN ;
 ;This routine is not deleted after install since it is tasked. A future
 ;patch will delete the routine.
 ;
 N ORDUZ
 S ZTRTN="START^OR556PST"
 S ZTDESC="OR*3.0*556 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S ORDUZ=DUZ
 S ZTSAVE("ORDUZ")=""
 D ^%ZTLOAD
 W !!,"OR*3.0*556 Post-Install Routine has been tasked - TASK NUMBER: ",$G(ZTSK)
 W !!,"You as well as members of the OR CACS MailMan Groups will receive"
 W !,"a MailMan message when the search completes.",!
 Q
 ;
START ;
 N ORDLG,ORDSTR,ORPRMPT,ORSEQ,ORPRX,ORID,ORPRSTR,ORARR,ORIGNORE,ORSPACE,ORCOUNT
 K ^XTMP("OR*3.0*556 MAILMAN MESSAGE")
 S $P(ORSPACE," ",45)=" "
 S ORIGNORE("PSJI OR PAT FLUID OE")=""
 S ORIGNORE("CLINIC OR PAT FLUID OE")=""
 S ORIGNORE("FHW OP MEAL")=""
 S (ORCOUNT,ORDLG)=0,ORSEQ=18
 F  S ORDLG=$O(^ORD(101.41,ORDLG)) Q:'ORDLG  D
 . S ORDSTR=$G(^ORD(101.41,ORDLG,0))
 . ;The first piece which is "NAME" should not be null.
 . ;But checking anyway.
 . Q:$P(ORDSTR,"^")=""
 . ;Do not include "ZZ" dialogs since no longer in use.
 . Q:$E(ORDSTR,1,2)="ZZ"
 . ;Do not include three order dialogs which appear to
 . ;have been nationally released years ago and are
 . ;causing no problems
 . Q:$D(ORIGNORE($P(ORDSTR,"^")))
 . ;only scanning type "Dialog"
 . Q:$P(ORDSTR,"^",4)'="D"
 . K ORARR
 . S ORPRMPT=0
 . F  S ORPRMPT=$O(^ORD(101.41,ORDLG,10,ORPRMPT)) Q:'ORPRMPT  D
 . . S ORPRX=$P($G(^ORD(101.41,ORDLG,10,ORPRMPT,0)),"^",2)
 . . Q:ORPRX=""
 . . S ORPRSTR=$G(^ORD(101.41,ORPRX,0))
 . . ;Should be type "P", but check to be sure.
 . . Q:$P(ORPRSTR,"^",4)'="P"
 . . S ORID=$P($G(^ORD(101.41,ORPRX,1)),"^",3)
 . . I ORID]"" D
 . . . S ORARR(ORID)=$G(ORARR(ORID))+1
 . . . S ORARR(ORID,ORPRMPT)=$P(ORPRSTR,"^")
 . ;Do any prompts share the same ID?
 . S ORID=""
 . F  S ORID=$O(ORARR(ORID)) Q:ORID=""  I ORARR(ORID)>1 D
 . . N ORSTR
 . . S ORCOUNT=ORCOUNT+1
 . . S ORSEQ=ORSEQ+1
 . . S ORSTR=$E($P($G(^ORD(101.41,ORDLG,0)),"^"),1,24)
 . . S ORSTR=ORSTR_$E(ORSPACE,1,26-$L(ORSTR))
 . . S ORSTR=ORSTR_$E(ORID,1,15)_"  "
 . . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",ORSEQ)=ORSTR
 . . S ORPRX=$O(ORARR(ORID,""))
 . . D SET
 . . F  S ORPRX=$O(ORARR(ORID,ORPRX)) Q:ORPRX=""  D
 . . . S ORSEQ=ORSEQ+1
 . . . D SET
 D XTMP,MAIL
 Q
 ;
SET ;
 N ORSTR,ORNAMPR
 S ORSTR=$G(^XTMP("OR*3.0*556 MAILMAN MESSAGE",ORSEQ))
 S ORNAMPR=ORARR(ORID,ORPRX)_" (#"_ORPRX_")"
 S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",ORSEQ)=$G(^XTMP("OR*3.0*556 MAILMAN MESSAGE",ORSEQ))_$E(ORSPACE,1,43-$L(ORSTR))
 S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",ORSEQ)=^XTMP("OR*3.0*556 MAILMAN MESSAGE",ORSEQ)_$E(ORNAMPR,1,32)
 Q
 ;
XTMP ;Generate MailMan message and keep in ^XTMP for 60 days
 S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^OR*3.0*556 POST INSTALL"
 S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",1)=" "
 S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",2)="OR*3.0*556 post-install routine found "_$S(ORCOUNT=0:"no",1:(ORCOUNT))_" entries in the ORDER DIALOG"
 S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",3)="(#101.41) file with more than one prompt defined for the same ID."
 I ORSEQ>18 D
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",4)="Listed below are such entries which should be reviewed to determine"
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",5)="if any prompts should be edited to have a different ID or replaced"
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",6)="with new prompts."
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",7)=" "
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",8)="If your site has not experienced problems with these order dialogs,"
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",9)="changes are probably not necessary."
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",10)=" "
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",11)="If the ID on an existing prompt does need to be changed, make sure"
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",12)="the prompt does not exist on another order dialog and will now have"
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",13)="the same ID as another prompt. The safest method is to create a new"
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",14)="prompt with a different ID. Then replace the existing prompt with"
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",15)="the new prompt."
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",16)=" "
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",17)="Order Dialog              ID               Prompt (#IEN)"
 . S ^XTMP("OR*3.0*556 MAILMAN MESSAGE",18)="------------------------  ---------------  --------------------------------"
 Q
 ;
MAIL ;
 N ORMIN,ORMY,ORMSUB,ORMTEXT
 S ORMIN("FROM")="OR*3.0*556 Post-Install"
 S ORMY(ORDUZ)=""
 S ORMY("G.OR CACS")=""
 S ORMSUB="OR*3.0*556 Post-Install"
 S ORMTEXT="^XTMP(""OR*3.0*556 MAILMAN MESSAGE"")"
 D SENDMSG^XMXAPI(DUZ,ORMSUB,ORMTEXT,.ORMY,.ORMIN,"","")
 Q
