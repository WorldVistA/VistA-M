PRCHITM ;WOIFO/LKG-ITEM UPDATE FROM NIF ;11/15/04  13:02
V ;;5.1;IFCAP;**63,121,145**;Oct 20, 2000;Build 3
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
EN ;Entry for server invoked filer
 S PRCERRC=0
 ; loading ^XTMP with 888 transaction from MailMan message
 F  X XMREC Q:XMER<0!($E(XMRG,1,4)="ISA^")
 I XMER<0 G EXIT
 S PRCTXN=$P(XMRG,U,14)
 S PRCHNODE="PRCHITM;"_PRCTXN K ^XTMP(PRCHNODE)
 ; set up ^XTMP header node including automated purge date
 S DT=$$DT^XLFDT,X1=DT,X2=10 D C^%DTC S ^XTMP(PRCHNODE,0)=X_"^"_DT_"^"_"NIF ITEM UPDATE"
 S PRCSUB=1,^XTMP(PRCHNODE,1,PRCSUB)=XMRG
 F  X XMREC Q:XMER<0!($E(XMRG,1,4)="IEA^")  D
 . S PRCSUB=PRCSUB+1,^XTMP(PRCHNODE,1,PRCSUB)=XMRG
 I XMER<0 D ERR("IEA segment is missing.") G EXIT
 S PRCSUB=PRCSUB+1,^XTMP(PRCHNODE,1,PRCSUB)=XMRG
 ; processing data
RESTART ;Restart filer with data from ^XTMP global
 S PRCX=$G(^XTMP(PRCHNODE,1,1)) I $P(PRCX,U)'="ISA" D ERR("ISA segment is missing.") G EXIT
 S PRCY=$P(PRCX,U,7) I $TR(PRCY," ")'="36001200NIF" D ERR("Interchange Sender ID '"_PRCY_"' is invalid.") G EXIT
 S PRCY=$P(PRCX,U,9) I $TR(PRCY," ")'="IFCAPNIF" D ERR("Interchange Receiver ID '"_PRCY_"' is invalid.") G EXIT
 S PRCX=$G(^XTMP(PRCHNODE,1,2)) I $P(PRCX,U)'="ST" D ERR("ST segment is missing.") G EXIT
 I $P(PRCX,U,2)'="888" D ERR("Transaction is not the 888.") G EXIT
 S PRCX=$G(^XTMP(PRCHNODE,1,3)) I $P(PRCX,U)'="N1" D ERR("N1 segment is missing.") G EXIT
 I $P(PRCX,U,3)'="NIF" D ERR("Source is not the National Item File database.") G EXIT
 S Y=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99) I $P(PRCX,U,5)'=Y D ERR("Intended recipient station is "_$P(PRCX,U,5)_", not "_Y_".") G EXIT
 I $P(PRCX,U,7)'="KA" D ERR("Intended recipient application is not IFCAP's ITEM MASTER file.") G EXIT
 S PRCSUB=6 I $P($G(^XTMP(PRCHNODE,1,PRCSUB)),U)'="G39" D ERR("Item characteristics node 'G39' is missing.") G EXIT
PROCITM ;Process items
 S PRCX=$G(^XTMP(PRCHNODE,1,PRCSUB))
 I $P(PRCX,U,24)'="ZZ" D ERR("The G39 segment for NIF Item #"_$P(PRCX,U,25)_" is defective.") G EXIT
 S PRCIEN=$P(PRCX,U,4),PRCNIF=$P(PRCX,U,25)
 I PRCNIF?1.N D
 . I PRCIEN?1.N D
 . . ; updating IMF entry specified by IMF Number in G39 segment
 . . I '$$FIND1^DIC(441,"","XQ","`"_PRCIEN,"","","PRCE") D ERR("Item Master Number "_PRCIEN_" does not exist.") Q
 . . K PRCE I $$GET1^DIQ(441,PRCIEN_",",16,"I","","PRCE") D ERR("Item Master Number "_PRCIEN_" is inactive, so it will not be updated.") Q
 . . S PRCLOCK=0 F PRCI=1:1:20 L +^PRC(441,PRCIEN):30 I $T S PRCLOCK=1 Q
 . . I 'PRCLOCK D ERR("Filer was unable to lock Item Master Number "_PRCIEN_"/NIF Item #"_PRCNIF_".") Q
 . . ; filing NIF Item #
 . . K PRCRR,PRCE S PRCRR(441,PRCIEN_",",51)=PRCNIF D FILE^DIE("E","PRCRR","PRCE")
 . . I $D(PRCE("DIERR")) S PRCY=0 F  S PRCY=$O(PRCE("DIERR",1,"TEXT",PRCY)) Q:PRCY'>0  D ERR("Item Master Number "_PRCIEN_": "_PRCE("DIERR",1,"TEXT",PRCY))
 . . K PRCRR,PRCE
 . . S PRCSUB=$O(^XTMP(PRCHNODE,1,PRCSUB))
 . . I PRCSUB="" D ERR("No descriptions exist for NIF Item Number "_PRCNIF_".") L -^PRC(441,PRCIEN) Q
 . . D DESC(PRCIEN,1) L -^PRC(441,PRCIEN)
 . . I $O(^PRCP(445,"AH",PRCIEN,""))]"" D BLDSEG^PRCPHLFM(3,PRCIEN,0) ;update supply stations
 . I PRCIEN'?1.N D
 . . ; updating all IMF entries with specified NIF Item Number
 . . K PRCE,PRCRR
 . . D FIND^DIC(441,"","@","XQ",PRCNIF,"","I","","","PRCRR","PRCE")
 . . I '$D(PRCRR("DILIST",2)) D ERR("No entry was found with NIF Item #"_PRCNIF_".") Q
 . . S PRCSUB=$O(^XTMP(PRCHNODE,1,PRCSUB)),PRCZ=PRCSUB
 . . I PRCSUB="" D ERR("No descriptions exist for NIF Item Number "_PRCNIF_".") Q
 . . K PRCL M PRCL=PRCRR("DILIST",2) ; save list of iens
 . . S PRCCTR=0 F  S PRCCTR=$O(PRCL(PRCCTR)) Q:PRCCTR=""  D
 . . . S PRCIEN=PRCL(PRCCTR)
 . . . K PRCE I $$GET1^DIQ(441,PRCIEN_",",16,"I","","PRCE") D ERR("Item Master Number "_PRCIEN_" is inactive, so it will not be updated.") Q
 . . . S PRCLOCK=0 F PRCI=1:1:20 L +^PRC(441,PRCIEN):30 I $T S PRCLOCK=1 Q
 . . . I 'PRCLOCK D ERR("Filer was unable to lock Item Master Number "_PRCIEN_"/NIF Item #"_PRCNIF_".") Q
 . . . S PRCSUB=PRCZ D DESC(PRCIEN,0) L -^PRC(441,PRCIEN)
 . . . I $O(^PRCP(445,"AH",PRCIEN,""))]"" D BLDSEG^PRCPHLFM(3,PRCIEN,0) ;update supply stations
 . . K PRCRR,PRCE,PRCL,PRCZ
 I PRCNIF'?1.N D ERR("NIF Item Number is missing for Item Master Number "_PRCIEN_".")
NEXT F  S PRCSUB=$O(^XTMP(PRCHNODE,1,PRCSUB)) Q:PRCSUB=""  S PRCX=$G(^(PRCSUB)) Q:"^G39^SE^"[("^"_$P(PRCX,U)_"^")
 G PROCITM:$P(PRCX,U)="G39"
EXIT I $D(PRCHNODE) D
 . ; send message if errors
 . I $D(^XTMP(PRCHNODE,"ERR")) D
 . . N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 . . S XMSUB="Item Filing Errors for Interchange Control: "_PRCTXN
 . . S XMDUZ=.5,XMTEXT="^XTMP(PRCHNODE,""ERR"","
 . . S XMY("VHANIFMO@va.gov")="",XMY("G.ISM")=""
 . . D ^XMD
 . ; if no errors delete ^XTMP nodes when done
 . I '$D(^XTMP(PRCHNODE,"ERR")) K ^XTMP(PRCHNODE)
 K PRCCTR,PRCE,PRCERRC,PRCI,PRCIEN,PRCL,PRCLOCK,PRCNIF,PRCHNODE,PRCRR,PRCSUB,PRCTXN,PRCX,PRCY,PRCZ,XMPOS,X,X1,X2,XMER,XMREC,XMRG,Y
 ; delete MailMan message from server basket
 I $D(XMZ) S XMSER="S."_XQSOP D REMSBMSG^XMA1C
 Q
DESC(PRCDA,PRCFLG) ;File Short and Extended Descriptions
 N PRCDES
 S PRCX=$G(^XTMP(PRCHNODE,1,PRCSUB))
 I $P(PRCX,U)'="G69" D ERR("No descriptions exist for NIF Item Number "_PRCNIF_".") Q
 S X=$P(PRCX,U,2) X ^%ZOSF("UPPERCASE") S PRCDES=Y
 I PRCDES'="" D
 . ; file NIF version of short description, but first save off
 . I PRCFLG,$L($P($G(^PRC(441,PRCDA,9)),"^"))=0 D  I $D(PRCE("DIERR")) K PRCE,PRCRR Q
 . . N PRCDESO S PRCDESO=$P($G(^PRC(441,PRCDA,0)),"^",2)
 . . K PRCRR,PRCE S PRCRR(441,PRCDA_",",52)=PRCDESO
 . . D FILE^DIE("E","PRCRR","PRCE")
 . . I $D(PRCE("DIERR")) S PRCY=0 F  S PRCY=$O(PRCE("DIERR",1,"TEXT",PRCY)) Q:PRCY'>0  D ERR("Item Master Number "_PRCDA_": "_PRCE("DIERR",1,"TEXT",PRCY))
 . . I $D(PRCE("DIERR")) K PRCRR Q
 . . K PRCRR,PRCERR S PRCDESO=$E(PRCDESO,1,36)
 . . I '$$FIND1^DIC(441.05,","_PRCDA_",","X",PRCDESO,"","","PRCE") D
 . . . S PRCRR(441.05,"+1,"_PRCDA_",",.01)=PRCDESO D UPDATE^DIE("E","PRCRR","","PRCERR")
 . . . I $D(PRCERR("DIERR")) S PRCY=0 F  S PRCY=$O(PRCERR("DIERR",1,"TEXT",PRCY)) Q:PRCY'>0  D ERR("Item Master Number "_PRCDA_": "_PRCERR("DIERR",1,"TEXT",PRCY))
 . . . K PRCRR,PRCERR
 . K PRCRR,PRCE S PRCRR(441,PRCDA_",",.05)=PRCDES D FILE^DIE("E","PRCRR","PRCE")
 . I $D(PRCE("DIERR")) S PRCY=0 F  S PRCY=$O(PRCE("DIERR",1,"TEXT",PRCY)) Q:PRCY'>0  D ERR("Item Master Number "_PRCDA_": "_PRCE("DIERR",1,"TEXT",PRCY))
 . K PRCRR,PRCE
 ; save off prior description during first NIF import
 ; if save fails, don't overwrite existing description with NIF extended description
 I PRCFLG,$P($G(^PRC(441,PRCDA,8,0)),U,4)'>0 D  I $D(PRCE("DIERR")) K PRCE Q
 . K PRCE D WP^DIE(441,PRCDA_",",50,"","^PRC(441,PRCDA,1)","PRCE")
 . I $D(PRCE("DIERR")) S PRCY=0 F  S PRCY=$O(PRCE("DIERR",1,"TEXT",PRCY)) Q:PRCY'>0  D ERR("Item Master Number "_PRCDA_": "_PRCE("DIERR",1,"TEXT",PRCY))
 ; extract extended description
 S PRCI=0 K PRCY
 F  S PRCSUB=$O(^XTMP(PRCHNODE,1,PRCSUB)) Q:PRCSUB=""  S PRCX=$G(^XTMP(PRCHNODE,1,PRCSUB)) Q:$P(PRCX,U)'="G69"  D
 . S PRCI=PRCI+1,PRCY(PRCI)=$P($G(^XTMP(PRCHNODE,1,PRCSUB)),U,2)
 I PRCI'>0 D ERR("No extended description exists for NIF Item Number "_PRCNIF_".")
 I PRCI D
 . ; file NIF extended description in description field
 . K PRCE D WP^DIE(441,PRCDA_",",.1,"","PRCY","PRCE")
 . K PRCY
 . I $D(PRCE("DIERR")) S PRCY=0 F  S PRCY=$O(PRCE("DIERR",1,"TEXT",PRCY)) Q:PRCY'>0  D ERR("Item Master Number "_PRCDA_": "_PRCE("DIERR",1,"TEXT",PRCY))
 . K PRCE
 S PRCSUB=$O(^XTMP(PRCHNODE,1,PRCSUB),-1)
 Q
ERR(PRCMSG) ;Error processing
 S PRCERRC=PRCERRC+1 S ^XTMP(PRCHNODE,"ERR",PRCERRC)=PRCMSG
 Q
