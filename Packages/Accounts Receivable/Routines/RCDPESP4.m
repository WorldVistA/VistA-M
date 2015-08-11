RCDPESP4 ; Albany/hrubovcak - ePayment Auto-post/Decrease for IOC testing, file #344.6 ;Jul 29, 2014@15:19:17
 ;;4.5;Accounts Receivable;**298**;Nov 11, 2013;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; * this routine is to be used for IOC purposes only *
 ; * the VHA CBO prohibits this routine from being used in any option *
 ; * or in any way that is accessible to a VistA user *
 ;
IOCSTRT ; disable auto-post and auto-decrease for all payers (for IOC start)
 ;
 N DIR,DTOUT,DUOUT,X,Y
 W !,"This routine excludes all payers from auto-posting."
 W !,"The routine should only be used at the start of IOC testing."
 S DIR(0)="YA",DIR("A")="Do you wish to proceed? (Y/N): ",DIR("B")="NO"
 D ^DIR
 I 'Y!$D(DTOUT)!$D(DUOUT) W !!,"File not updated.",! Q
 ;
 W !,"Exclusions for start of IOC started "_$$FMTE^XLFDT($$NOW^XLFDT,"1ZPM")
 N J,P,RCDUZ,RCFLD,RCIEN,RCNTRY,RCOMMNT
 S RCDUZ=DUZ X "S DUZ=.5"  ; DUZ is used in triggers for file #344.6
 S RCOMMNT="Auto Addition - Beginning of Field Test/IOC"
 ; iterate through file #344.6
 S RCIEN=0 F  S RCIEN=$O(^RCY(344.6,RCIEN)) Q:'RCIEN  S RCNTRY=$G(^RCY(344.6,RCIEN,0)) D:RCNTRY]""
 .F RCFLD=.06,.07 S P=100*RCFLD,X=$P(RCNTRY,U,P) D:'X  ; if NO, update entry
 ..N I,RCXCLFDA  ; FileMan FDA array
 ..S I=RCIEN_",",I("CMNTFLD")=$S(RCFLD=.06:1,1:2)  ; IENS and comment field #
 ..S RCXCLFDA(344.6,I,RCFLD)=1  ; change to YES
 ..S RCXCLFDA(344.6,I,I("CMNTFLD"))=RCOMMNT
 ..D UPDATE^DIE(,"RCXCLFDA")  ; update entry
 ..D AUDXCLSN(RCIEN_U_RCFLD_U_1_U_0_U_RCOMMNT)
 ;
 W !,"Exclusions for start of IOC finished "_$$FMTE^XLFDT($$NOW^XLFDT,"1ZPM")
 X "S DUZ=RCDUZ"
 ; send MailMan message
 D IOCMLMSG(RCOMMNT) W !!,"A MailMan message has been sent."
 ;
 Q
 ;
IOCEND ; enable auto-post and auto-decrease for all payers (for IOC end)
 ;
 N DIR,DTOUT,DUOUT,X,Y
 W !,"This routine resets all payers as ready for auto-posting."
 W !,"The routine should only be used at the end of IOC."
 S DIR(0)="YA",DIR("A")="Do you wish to proceed? (Y/N): ",DIR("B")="NO"
 D ^DIR
 I 'Y!$D(DTOUT)!$D(DUOUT) W !!,"File not updated.",! Q
 ;
 W !,"Exclusions for end of IOC started "_$$FMTE^XLFDT($$NOW^XLFDT,"1ZPM")
 N J,P,RCDUZ,RCFLD,RCIEN,RCNTRY,RCOMMNT
 S RCDUZ=DUZ X "S DUZ=.5"  ; DUZ is used in triggers for file #344.6
 S RCOMMNT="Auto Deletion - End of Field Test/IOC"
 ; iterate through file #344.6
 S RCIEN=0 F  S RCIEN=$O(^RCY(344.6,RCIEN)) Q:'RCIEN  S RCNTRY=$G(^RCY(344.6,RCIEN,0)) D:RCNTRY]""
 .F RCFLD=.06,.07 S P=100*RCFLD,X=$P(RCNTRY,U,P) D:X  ; if YES, update entry
 ..N I,RCXCLFDA  ; FileMan FDA array
 ..S I=RCIEN_",",I("CMNTFLD")=$S(RCFLD=.06:1,1:2)  ; IENS and comment field #
 ..S RCXCLFDA(344.6,I,RCFLD)=0  ; change to NO
 ..S RCXCLFDA(344.6,I,I("CMNTFLD"))=RCOMMNT
 ..D UPDATE^DIE(,"RCXCLFDA")  ; update entry
 ..D AUDXCLSN(RCIEN_U_RCFLD_U_0_U_1_U_RCOMMNT)
 ;
 W !,"Exclusions for end of IOC finished "_$$FMTE^XLFDT($$NOW^XLFDT,"1ZPM")
 X "S DUZ=RCDUZ"
 ; send MailMan message
 D IOCMLMSG(RCOMMNT) W !!,"A MailMan message has been sent."
 ;
 Q
 ;
AUDXCLSN(NTRY) ; add entry to RCDPE PARAMETER AUDIT file (#344.7)
 ;     for IOC changes to RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;     the POSTMASTER is the user for each update
 ; NTRY = audit value in this format:
 ;        IEN^FIELD #^NEW VALUE^OLD VALUE^COMMENT
 ;         1 ^   2   ^   3     ^   4     ^  5
 ;
 Q:$G(NTRY)=""  ; NTRY is required
 N RCFDA  ; FileMan FDA array for audits
 S RCFDA(344.7,"+1,",.01)=$$NOW^XLFDT
 S RCFDA(344.7,"+1,",.02)=$P(NTRY,U) ; IEN
 S RCFDA(344.7,"+1,",.03)=.5  ; USER (POSTMASTER)
 S RCFDA(344.7,"+1,",.04)=$P(NTRY,U,2) ; FIELD NUMBER
 S RCFDA(344.7,"+1,",.05)=344.6 ; FILE NUMBER
 S RCFDA(344.7,"+1,",.06)=$P(NTRY,U,3) ; NEW VALUE
 S RCFDA(344.7,"+1,",.07)=$P(NTRY,U,4) ; OLD VALUE
 S RCFDA(344.7,"+1,",.08)=$P(NTRY,U,5) ; COMMENT
 D UPDATE^DIE(,"RCFDA")
 Q
 ;
IOCMLMSG(RCACT) ; RCACT - activity to include MailMan message text
 N RCMSGTXT,RCSITE,RCSUBJ,XMINSTR,XMTO
 S RCSITE=$$SITE^VASITE
 ; limit subject to 65 chars.
 S RCSUBJ=$E("ePayments IOC activity "_$P(RCSITE,U,2),1,65)
 S RCMSGTXT(1)=" "
 S RCMSGTXT(2)="        Site: "_$P(RCSITE,U,2)
 S RCMSGTXT(3)="    Station # "_$P(RCSITE,U,3)
 S RCMSGTXT(4)="      Domain: "_$G(^XMB("NETNAME"))
 S RCMSGTXT(5)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"1ZPM")
 S RCMSGTXT(6)="        User: "_$P($G(^VA(200,DUZ,0)),U)
 S RCMSGTXT(7)=" "
 S RCMSGTXT(8)=" The following IOC activity was performed: "
 S RCMSGTXT(9)="  "_$C(34)_$G(RCACT)_$C(34)
 ;
 S XMINSTR("FROM")="POSTMASTER"
 ;
 S XMTO(DUZ)="",XMTO("G.RCDPE PAYMENTS MGMT")=""
 ;
 K ^TMP("XMERR",$J)
 D SENDMSG^XMXAPI(DUZ,RCSUBJ,"RCMSGTXT",.XMTO,.XMINSTR)
 ;
 I $D(^TMP("XMERR",$J)) D
 .D MES^XPDUTL("MailMan returned an error.")
 .D MES^XPDUTL("The error text is:")
 .N G S G=$NA(^TMP("XMERR",$J))
 .F  S G=$Q(@G) Q:G=""  Q:$QS(G,2)'=$J  D MES^XPDUTL("  "_$C(34)_@G_$C(34))
 .D MES^XPDUTL(" * End of Error Text *")
 .K ^TMP("XMERR",$J)
 ;
 Q
 ;
