EAS155PT ;ALB/SCK - PATCH 55 USER ENROLLEE MT LETTER CLEANUP ; 9-AUG-04
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**55**;Mar 15, 2004
 ;
 Q
 ;
CHECK ;
 N CURSTN,CURSITE,PRNT,PTYP
 N MSG,XMDUZ,XMSUB,XMTEXT,XMY,XX
 ;
 S XMSUB="EAS*1*55 PARENT CHECK"
 S XMDUZ="EAS*1*55"
 S XMY(.5)="",XMY(DUZ)=""
 S XMTEXT="MSG("
 ;
 S CURSITE=$P($$SITE^VASITE,U,3)
 S CURSTN=$$STA^XUAF4(CURSITE)
 S PRNT=$$PRNT^XUAF4(CURSITE)
 S PTYP=$$GET1^DIQ(4,+PRNT,13)
 ;
 S MSG(1)="Current Site: "_CURSITE
 S MSG(2)="Current Station: "_$$GET1^DIQ(4,CURSTN,.01)_" ("_CURSTN_")"
 S MSG(3)="Parent Facility: "_$P(PRNT,U,3)
 S MSG(4)="Parent Type: "_PTYP
 S MSG(5)=""
 I PTYP="HCS" D
 . S MSG(6)="Because your parent facility type is ""HCS"", it's recommended that you run"
 . S MSG(7)="the MT Letter cleanup at this time.  Please refer to the patch for directions"
 E  D
 . S MSG(6)="Your parent facility type does not appear to be of type ""HCS"". "
 . S MSG(7)="It is not recommended that you run the MT letter cleanup at this time"
 . S MSG(8)="If you are experiencing problems with the MT Letters, please contact EVS."
 D MES^XPDUTL(.MSG)
 D ^XMD
 ;
 Q
 ;
EN ; Que off the background task
 N ZTRTN,ZTDESC,ZTSK,ZTIO,ZTDH,MSG,ZTSAVE
 ;
 W !,"Preparing to run the EAS*1*55 MT Letters Cleanup"
 W !,"After the cleanup, you will be sent a MailMan summary of the cleanup"
 W !,"statistics.  You will also be asked to select a printer to send the"
 W !,"detailed results to.  This report could be quite lengthy.  Please "
 W !,"DO NOT run the report to your screen!",!
 D ^%ZIS
 S ZTRTN="LETTERS^EAS155PT"
 S ZTDH=$$NOW^XLFDT
 S ZTSAVE("DUZ")=""
 S ZTDESC="EAS155 MT LETTER CLEANUP FOR UE STATUS"
 D ^%ZTLOAD
 I $D(ZTSK) W !!?5,"Task: "_ZTSK_" Queued."
 D HOME^%ZIS
 Q
 ;
LETTERS ; Reflag those MT letters which need to be updated for UE Status update
 N EASIEN,EASPTR,EASDFN,EASLTR,EASCNT,XX
 ;
 K ^TMP("EAS155P",$J)
 S ^TMP("EAS155P",$J,"START")=$H,^TMP("EAS155P",$J,"COUNT")=0,^TMP("EAS155P",$J,"NOCHANGE")=0
 ;
 F XX="60D","30D","0D","OFF" S EASCNT(XX)=0
 S EASIEN=0
 F  S EASIEN=$O(^EAS(713.2,"AC",0,EASIEN)) Q:'EASIEN  D
 . S EASPTR=$$GET1^DIQ(713.2,EASIEN,2,"I")
 . Q:$D(^EAS(713.1,"AP",1,EASPTR))  ; Quit if Letter Prohibit Flag set
 . Q:$$DECEASED^EASMTUTL(EASIEN)  ; Quit if patient deceased
 . ; ** Safety check for bad patient pointers in 713.1
 . Q:$$GET1^DIQ(713.2,EASIEN,2)']""
 . D TESTLTR(EASIEN)
 ;
 S ^TMP("EAS155P",$J,"END")=$H
 D MAIL
 D REPORT
 Q
 ;
TESTLTR(EASIEN) ; Test letter conditions
 N NODE6,NODE4,NODEZ,IENS,FDA,FIN
 ;
 S ^TMP("EAS155P",$J,"COUNT")=^TMP("EAS155P",$J,"COUNT")+1
 ; Piece 1: Threshold date, Piece 2: Flag-to-print, Piece 3: Letter Printed?, Piece 4: Date printed 
 S NODE6=$G(^EAS(713.2,EASIEN,6))
 S NODE4=$G(^EAS(713.2,EASIEN,4))
 S NODEZ=$G(^EAS(713.2,EASIEN,"Z"))
 ;
 ; Check 1, check if letters have been completely turned off, No flags to print and no letters printed.  Turn back on most appropriate letter.
 I '$P(NODE6,U,3),'$P(NODE4,U,3),'$P(NODEZ,U,3) D  Q:$G(FIN)
 . I '$P(NODE6,U,2),'$P(NODE4,U,2),'$P(NODEZ,U,2) D
 . . I $P(NODEZ,U)<DT D  Q
 . . . S EASCNT("0D")=EASCNT("0D")+1
 . . . S ^TMP("EAS155P",$J,"0D",EASIEN)=""
 . . . S FDA(1,713.2,EASIEN_",",18)="YES"
 . . . S FDA(1,713.2,EASIEN_",",9)="NO"
 . . . S FDA(1,713.2,EASIEN_",",12)="NO",FIN=1
 . . . D FILE^DIE("E","FDA(1)")
 . . I $P(NODE4,U)<DT D  Q
 . . . S EASCNT("30D")=EASCNT("30D")+1
 . . . S ^TMP("EAS155P",$J,"30D",EASIEN)=""
 . . . S FDA(1,713.2,EASIEN_",",12)="YES"
 . . . S FDA(1,713.2,EASIEN_",",9)="NO"
 . . . S FDA(1,713.2,EASIEN_",",18)="NO",FIN=1
 . . . D FILE^DIE("E","FDA(1)")
 . . S EASCNT("60D")=EASCNT("6OD")+1
 . . S ^TMP("EAS155P",$J,"60D",EASIEN)=""
 . . S FDA(1,713.2,EASIEN_",",9)="YES"
 . . S FDA(1,713.2,EASIEN_",",12)="NO"
 . . S FDA(1,713.2,EASIEN_",",18)="NO",FIN=1
 . . D FILE^DIE("E","FDA(1)")
 ;
 ; Check 2, check if 60d ltrs have not been printed, but 30d ltrs are flagged to print.
 I '$P(NODE6,U,3)&($P(NODE4,U,2))&($P(NODE4,U,1)>DT) D  Q:$G(FIN)
 . S EASCNT("60D")=EASCNT("60D")+1
 . S ^TMP("EAS155P",$J,"60D",EASIEN)=""
 . S FDA(1,713.2,EASIEN_",",9)="YES"
 . S FDA(1,713.2,EASIEN_",",12)="NO"
 . D FILE^DIE("E","FDA(1)")
 . S FIN=1
 ;
 ; Check 3, if the 60d ltr has been printed AND the 30d ltr has not AND the 
 ; 0d ltr is flagged to print.
 I $P(NODE6,U,3)&('$P(NODE4,U,3))&($P(NODEZ,U,2))&($P(NODEZ,U,1)>DT) D  Q:$G(FIN)
 . S EASCNT("30D")=EASCNT("30D")+1
 . S ^TMP("EAS155P",$J,"30D",EASIEN)=""
 . S FDA(1,713.2,EASIEN_",",12)="YES"
 . S FDA(1,713.2,EASIEN_",",18)="NO"
 . D FILE^DIE("E","FDA(1)")
 . S FIN=1
 ;
 ; Check 4, if the 30d ltr has been printed and the 0d has not AND is not flagged.
 I $P(NODE4,U,3)&('$P(NODEZ,U,3))&('$P(NODEZ,U,2)) D  Q
 . S EASCNT("0D")=EASCNT("0D")+1
 . S ^TMP("EAS155P",$J,"0D",EASIEN)=""
 . S FDA(1,713.2,EASIEN_",",18)="YES"
 . D FILE^DIE("E","FDA(1)")
 ;
 S ^TMP("EAS155P",$J,"NOCHANGE")=^TMP("EAS155P",$J,"NOCHANGE")+1
 Q
 ;
UPD(FDA) ;  Update file entry
 N ERR
 ;
 D FILE^DIE("E","FDA(1)","ERR")
 Q
 ;
MAIL ;
 N MSG,XMDUZ,XMSUB,XMTEXT,XMY,XX
 ;
 S (XMDUZ,XMSUB)="EAS*1*55 CLEANUP"
 S XMY(.5)="",XMY(DUZ)=""
 S XMTEXT="MSG("
 S MSG(10)="Begin: "_$$HTE^XLFDT(^TMP("EAS155P",$J,"START"))
 S MSG(20)="End:   "_$$HTE^XLFDT(^TMP("EAS155P",$J,"END"))
 S MSG(30)="Processing Time: "_$$HDIFF^XLFDT(^TMP("EAS155P",$J,"END"),^TMP("EAS155P",$J,"START"),3)
 S MSG(31)=""
 S MSG(35)="   Turned Off:    "_EASCNT("OFF")
 S MSG(40)="60-Day Letters:   "_EASCNT("60D")
 S MSG(50)="30-Day Letters:   "_EASCNT("30D")
 S MSG(60)=" 0-Day Letters:   "_EASCNT("0D")
 S MSG(65)=""
 S MSG(70)="No action required: "_^TMP("EAS155P",$J,"NOCHANGE")
 D ^XMD
 Q
 ;
REPORT ;
 N EAX,PAGE,EANAME,EASIEN,EASLTR
 ;
 U IO
 S (PAGE,EAX)=0
 F EASLTR="60D","30D","0D" D
 . D HDR
 . I EASCNT(EASLTR)'>0 D  Q
 . . W !!,"There were no letters reset for this letter type"
 . S EASIEN=0
 . F  S EASIEN=$O(^TMP("EAS155P",$J,EASLTR,EASIEN)) Q:EASIEN']""  D
 . . W !,$$GET1^DIQ(713.2,EASIEN,2),?35,EASIEN,?55,$$GET1^DIQ(713.2,EASIEN,.01)
 . . I ($Y+6)>IOSL D HDR
 D FTR
 Q
 ;
HDR ;
 N DDASH,LINE,PART1,PART2,SPACE
 ;
 W @IOF
 S PAGE=PAGE+1
 W !,"Patch EAS*1*55 MT Letter Cleanup Results"
 S PART1="Run Date: "_$$FMTE^XLFDT(DT)
 S PART2="Page: "_PAGE
 S SPACE=IOM,SPACE=SPACE-($L(PART1)+$L(PART2))
 S $P(LINE," ",SPACE)=""
 W !,PART1,LINE,PART2
 W !!,$S(EASLTR="60D":"60-Day",EASLTR="30D":"30-Day",EASLTR="0D":"0-Day",1:"")," Letters for the following Veterans have been reset"
 W !?5,"Name",?35,"File 713.2 IEN",?55,"Processing Date"
 S $P(DDASH,"=",IOM)="" W !,DDASH
 Q
 ;
FTR ;
 W !!!!?5,"60-Day Letters:   "_EASCNT("60D")
 W !?5,"30-Day Letters:   "_EASCNT("30D")
 W !?5," 0-Day Letters:   "_EASCNT("0D")
 Q
