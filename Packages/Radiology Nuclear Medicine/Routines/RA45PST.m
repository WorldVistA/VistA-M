RA45PST ;Hines OI/GJC - Post-init Driver, patch 45 ;10/10/03  06:32
VERSION ;;5.0;Radiology/Nuclear Medicine;**45**;Mar 16, 1998
 ;
EN ;Need to convert the data in the old 'BARIUM USED?' (#5) field in
 ;the 70.03 data dictionary to the CONTRAST MEDIA (#225) multiple
 ;70.3225. If 'Yes' to 'BARIUM USED?' then 'Barium' will be added
 ;as a record to the new CONTRAST MEDIA field. The 'BARIUM USED?'
 ;field will be deleted. This will be a background process queued
 ;to run by the RA*5*45 post-init.
 I '$D(^DD(70.03,5,0))#2 D
 .S RATXT(1)="'BARIUM USED?' (sub-dd: 70.03, fld: 5) field has been deleted in the"
 .S RATXT(2)="past; no further action taken regarding this data dictionary."
 .D MES^XPDUTL(.RATXT) K RATXT
 .Q
 E  D
 .N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN
 .S ZTIO="",ZTRTN="ENQ1^RA45PST1"
 .S ZTDESC="RA*5.0*45: 'BARIUM USED?' (dd: 70.03;fld: 5) field cleanup"
 .S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT(),0,0,2,0) ;add 2 minutes to 'now'
 .D ^%ZTLOAD S RATXT(1)=" "
 .S RATXT(2)="RA*5.0*45: delete 'BARIUM USED?' field, convert data to CONTRAST MEDIA (70.3225) multiple"
 .S:$G(ZTSK)>0 RATXT(3)="Task: "_ZTSK_"."
 .S RATXT(4)=" " D MES^XPDUTL(.RATXT)
 .Q
 ;
SEED71 ;The second process must be tasked off that will identify all the
 ;Rad/Nuc Med orderable items (OI) in file 101.43 checking them to
 ;see if barium, oral cholecystogram or unspecified contrast media
 ;happen to be associated contrasts.
 ;
 ;If no associations move onto the next OI and check for CMs
 ;
 ;If yes, update the procedure in file 71; add barium, oral
 ;cholecystografic or unspecified contrast media to the CONTRAST MEDIA
 ;(#125) multiple in file 71. All successful and unsuccessful updates
 ;will be presented to the user in the form of an email message.
 ;(Failure to update occurs when a record cannot be locked)
 ;
 ;Finally, the Rad/Nuc Med Procedure (71) file will be synchronized with
 ;the Orderable Items (101.43) file.
 ;
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN
 S ZTIO="",ZTRTN="ENQ2^RA45PST2"
 S ZTDESC="RA*5.0*45: seed new CONTRAST MEDIA (#125) field in file 71"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT(),0,0,2,0) ;add 2 minutes to 'now'
 D ^%ZTLOAD S RATXT(1)=" "
 S RATXT(2)="RA*5.0*45: seed new CONTRAST MEDIA (#125) field in file 71"
 S:$G(ZTSK)>0 RATXT(3)="Task: "_ZTSK_"."
 S RATXT(4)=" " D MES^XPDUTL(.RATXT)
 Q
 ;
MAILQ2(FORMAT,SUBJECT) ;Update users via email; let the user(s) know which
 ;Rad/NM Procedures have been updated according to their Orderable Item
 ;equivalents.
 ;input: FORMAT='1' for Orderable Item CM definitions applied to Rad/Nuc
 ;             Med procedure, '2' for sychronization between Rad/Nuc Med
 ;             Procedure and the Orderable Items file (Rad/Nuc Med
 ;             function)
 ;      SUBJECT=subject of the email
 ;
 Q:FORMAT'=1&(FORMAT'=2)  Q:$G(SUBJECT)=""  NEW RAX
 S:FORMAT=1 $P(RAX," ",81)="",$E(RAX,1,6)="Status",$E(RAX,10,18)="Procedure",$E(RAX,52,55)="CPT",$E(RAX,60,67)="Contrast"
 S:FORMAT=2 $P(RAX," ",81)="",$E(RAX,1,6)="Status",$E(RAX,10,18)="Procedure",$E(RAX,55,58)="CPT",$E(RAX,65,72)="Contrast"
 S ^TMP("RA PROC UPDATE 45",$J,.3)=RAX
 S $P(^TMP("RA PROC UPDATE 45",$J,.6),"-",81)="" ;80 dashes
 N XMDUZ,XMSUB,XMTEXT,XMY S XMDUZ=.5
 S XMTEXT="^TMP(""RA PROC UPDATE 45"",$J,",XMSUB=SUBJECT
 I '$$GOTLOCAL^XMXAPIG("G.RAD PERFORMANCE INDICATOR") D
 .S XMY(DUZ)=""
 E  S XMY("G.RAD PERFORMANCE INDICATOR")=""
 D ^XMD
 Q
 ;
