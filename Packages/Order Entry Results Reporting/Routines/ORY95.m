ORY95 ;SLC/DAN Post-Init for patch OR*3*95 ;9/18/01  13:38
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**95**;Dec 17, 1997
 ;Post-init will check for display text and mnemonics that can potentially cause problems with fileman and the fileman reader (DIR)
POST ; -- postinit
 N ORMSG
 S ORMSG(1)=""
 S ORMSG(2)="This patch imports the STATUS OF ORDER entry"
 S ORMSG(3)="from the OE/RR PRINT FIELDS file.  As a result, the entries"
 S ORMSG(4)="in the OE/RR PRINT FORMAT file need to be recompiled."
 S ORMSG(5)=""
 S ORMSG(6)="**NOTE: If you have made local modifications to the compiled"
 S ORMSG(7)="code in the OE/RR PRINT FORMAT file they will be OVERWRITTEN."
 S ORMSG(8)=""
 S ORMSG(9)="Recompiling..."
 D MES^XPDUTL(.ORMSG) H 3
 D RECMPL^ORPR00 K ORMSG
 S ORMSG(1)="",ORMSG(2)="Starting ORDER DIALOG and ORDERABLE ITEMS file checking in the background.",ORMSG(3)="You'll receive an email when it finishes." D MES^XPDUTL(.ORMSG) H 3 K ORMSG
 S ZTRTN="CHECK^ORY95",ZTDTH=$H,ZTDESC="Patch OR*3*95 Post-Init",ZTSAVE("DUZ")="",ZTIO="" D ^%ZTLOAD Q
CHECK ;Enter here to check files for invalid entries
 N IEN,SUBIEN
 K ^TMP($J)
 S IEN=0 F  S IEN=$O(^ORD(101.41,IEN)) Q:'+IEN  D
 .;Check DISPLAY TEXT field first
 .I $$CHKNAM^ORUTL($P($G(^ORD(101.41,IEN,0)),"^",2)) D REPORT(1,"ODFIX")
 .;Check DISPLAY TEXT subfield of ITEMS multiple next
 .S SUBIEN=0 F  S SUBIEN=$O(^ORD(101.41,IEN,10,SUBIEN)) Q:'+SUBIEN  D
 ..I $$CHKNAM^ORUTL($P($G(^ORD(101.41,IEN,10,SUBIEN,0)),"^",4)) D REPORT(2,"ODFIX")
 ..;Check MNEMONIC field next
 ..I $$CHKMNE^ORUTL($P($G(^ORD(101.41,IEN,10,SUBIEN,0)),"^",3)) D REPORT(3,"ODMFIX")
 ..Q
 .Q
 ;Check NAME field of ORDERABLE ITEMS file for ;
 S IEN=0 F  S IEN=$O(^ORD(101.43,IEN)) Q:'+IEN  I $$CHKNAM^ORUTL($P($G(^ORD(101.43,IEN,0)),"^"),";") D REPORT(4,"OIFIX")
 ;Send mail message with results
 D MAIL
 Q
REPORT(E,FIX) ;Store entries that need to be reported
 N FIEN
 S FIEN=0 I $D(^TMP($J,FIX,IEN,FIEN)) S FIEN=$O(^(999),-1)+1 ;get last subscript
 I E=1 S ^TMP($J,FIX,IEN,FIEN)="DISPLAY TEXT <"_$P(^ORD(101.41,IEN,0),"^",2)_"> for ORDER DIALOG <"_$P(^(0),"^")_">" Q
 I E=2 S ^TMP($J,FIX,IEN,FIEN)="DISPLAY TEXT <"_$P(^ORD(101.41,IEN,10,SUBIEN,0),"^",4)_"> for SEQUENCE # "_$P(^(0),"^")_" of ORDER DIALOG < "_$P(^ORD(101.41,IEN,0),"^")_">" Q
 I E=3 S ^TMP($J,FIX,IEN,FIEN)="MNEMONIC <"_$P(^ORD(101.41,IEN,10,SUBIEN,0),"^",3)_"> for SEQUENCE # "_$P(^(0),"^")_" of ORDER DIALOG <"_$P(^ORD(101.41,IEN,0),"^")_">" Q
 I E=4 S ^TMP($J,FIX,IEN,FIEN)=$P(^ORD(101.43,IEN,0),"^")_" entry in ORDERABLE ITEMS file" Q
 Q
MAIL ;prepare results for sending
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,ORTXT,I,J,K
 S XMDUZ="PATCH OR*3*95 POST-INIT",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 ;Check mnemonics in this section
 S I=0 I '$D(^TMP($J,"ODMFIX")) S I=I+1,^TMP($J,"ORTXT",I)="No problems with MNEMONIC names were found."
 I $D(^TMP($J,"ODMFIX")) D  ;Add entries that have problems with mnemonics
 .S I=I+1,^TMP($J,"ORTXT",I)="The following entries in the ORDER DIALOG file have MNEMONICS that are the same"
 .S I=I+1,^TMP($J,"ORTXT",I)="as a standard List Manager mnemonic and need to be changed."
 .S I=I+1,^TMP($J,"ORTXT",I)="List Manager mnemonics take precedence over the MNEMONIC field and"
 .S I=I+1,^TMP($J,"ORTXT",I)="will cause the entry to be unselectable by MNEMONIC from within List Manager.",I=I+1,^TMP($J,"ORTXT",I)=""
 .S J=0 F  S J=$O(^TMP($J,"ODMFIX",J)) Q:'+J  S K="" F  S K=$O(^TMP($J,"ODMFIX",J,K)) Q:K=""  S I=I+1 S ^TMP($J,"ORTXT",I)=^(K)
 S I=I+1 S ^TMP($J,"ORTXT",I)=""
 ;Check orderable items name section
 I '$D(^TMP($J,"OIFIX")) S I=I+1 S ^TMP($J,"ORTXT",I)="No problems with ORDERABLE ITEM names were found."
 I $D(^TMP($J,"OIFIX")) D  ;add ORDERABLE ITEMS that have problems
 .S I=I+1,^TMP($J,"ORTXT",I)="The following entries in the ORDERABLE ITEMS file contain"
 .S I=I+1,^TMP($J,"ORTXT",I)="a semi colon (;) and may cause problems during editing.  You need to remove"
 .S I=I+1,^TMP($J,"ORTXT",I)="these characters from these entries to avoid potential problems."
 .S I=I+1,^TMP($J,"ORTXT",I)=""
 .S I=I+1,^TMP($J,"ORTXT",I)="Please use PACKAGE SPECIFIC options to change the names.  The changes"
 .S I=I+1,^TMP($J,"ORTXT",I)="will then update the ORDERABLE ITEMS file and will remain synchronized."
 .S I=I+1,^TMP($J,"ORTXT",I)=""
 .S J=0 F  S J=$O(^TMP($J,"OIFIX",J)) Q:'+J  S I=I+1 S ^TMP($J,"ORTXT",I)=^TMP($J,"OIFIX",J,0)
 S I=I+1,^TMP($J,"ORTXT",I)=""
 ;Check display text section
 I '$D(^TMP($J,"ODFIX")) S I=I+1,^TMP($J,"ORTXT",I)="No problems with DISPLAY TEXT in the ORDER DIALOG file were found."
 I $D(^TMP($J,"ODFIX")) D  ;add ORDER DIALOG problems to mail message
 .S I=I+1,^TMP($J,"ORTXT",I)="The following entries in the ORDER DIALOG file contain special"
 .S I=I+1,^TMP($J,"ORTXT",I)="characters in the DISPLAY TEXT field or the DISPLAY TEXT subfield of"
 .S I=I+1,^TMP($J,"ORTXT",I)="the ITEMS multiple that will not display in the List Manager display."
 .S I=I+1,^TMP($J,"ORTXT",I)="",I=I+1,^TMP($J,"ORTXT",I)="In order to be consistent you may wish to remove the special characters"
 .S I=I+1,^TMP($J,"ORTXT",I)="from the following entries.  The special characters are ;,-^="
 .S I=I+1,^TMP($J,"ORTXT",I)="This is recommended but it is NOT REQUIRED.  They are being"
 .S I=I+1,^TMP($J,"ORTXT",I)="reported for information only.",I=I+1,^TMP($J,"ORTXT",I)=""
 .S J=0 F  S J=$O(^TMP($J,"ODFIX",J)) Q:'+J  S K="" F  S K=$O(^TMP($J,"ODFIX",J,K)) Q:K=""  S I=I+1 S ^TMP($J,"ORTXT",I)=^(K)
 S I=I+1,^TMP($J,"ORTXT",I)="",I=I+1,^TMP($J,"ORTXT",I)="Patch OR*3*95 post-init complete."
 S XMTEXT="^TMP($J,""ORTXT"",",XMSUB="PATCH OR*3*95 Post-init completed"
 D ^XMD
