ORY106 ;SLC/DAN - Postinit for patch OR*3*92 ;2/1/01  16:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**106**;Dec 17, 1997
 ;
POST ; -- postinit
 N MSG
 S MSG(1)=""
 S MSG(2)="This patch imports the ORDER TEXT and LAB TEST entries"
 S MSG(3)="from the OE/RR PRINT FIELDS file.  As a result, the entries"
 S MSG(4)="in the OE/RR PRINT FORMAT file need to be recompiled."
 S MSG(5)=""
 S MSG(6)="**NOTE: If you have made local modifications to the compiled"
 S MSG(7)="code in the OE/RR PRINT FORMAT file they will be OVERWRITTEN."
 S MSG(8)=""
 S MSG(9)="Recompiling..."
 D MES^XPDUTL(.MSG) H 3
 D RECMPL^ORPR00 K MSG
 Q
