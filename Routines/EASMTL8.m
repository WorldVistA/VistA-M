EASMTL8 ;618/TCM ALB/SCK/PHH - AUTOMATED MEANS TEST LETTER, 20-DAY REPORT OF CONTACT FORM ; 07/17/01
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,54**;MAR 15,2001
 ;
QUE ;
 N EASTMP,DIR,DUOUT,DTOUT,DIRUT
 ;
 S EASTMP="^TMP(""EASROC"",$J)"
 K @EASTMP
 ;
START ;
 S DIR(0)="PAO^713.2:EMZ",DIR("A")="Select Patient: "
 S DIR("?")="Select patient or press ENTER when finished"
 D ^DIR K DIR
 Q:$D(DUOUT)!($D(DTOUT))
 S @EASTMP@(+Y)=""
 I '$D(DIRUT) G START
END ;
 S ZTSAVE("EASTMP")=""
 D EN^XUTMDEVQ("PRINT^EASMTL8","EAS MT REPORT OF CONTACTS",.ZTSAVE)
 Q
 ;
PRINT ;
 N EASIEN
 ;
 S EASIEN=0
 F  S EASIEN=$O(@EASTMP@(EASIEN)) Q:'EASIEN  D  Q:$D(DIRUT)
 . D FORM(EASIEN)
 . I $E(IOST,1,2)="C-" D
 . . S DIR(0)="E"
 . . D ^DIR K DIR
 . . I 'Y S DIRUT=1
 . . W @IOF
 K @EASTMP
 Q
 ;
FORM(EASIEN) ; Print 20 day form
 N DFN,EASDEM,EASADD,EASHDR,EASFAC,EASLIEN,ULC,ULNE,EASANV,LINE,EASOK,EASDEV,XL,EAX,EASPTR
 ;
 S EASANV=$$GET1^DIQ(713.2,EASIEN,3,"I")
 S EASPTR=$$GET1^DIQ(713.2,EASIEN,2,"I")
 S DFN=$$GET1^DIQ(713.1,EASPTR,.01,"I")
 D GETPAT^EASMTL6A(DFN,.EASDEM,.EASADD)
 D GETFAC^EASMTL6(DFN,.EASFAC)
 ;
 ;  Merge FileMan data arrays into more usable formats
 M EASHDR("F")=EASFAC
 M EASHDR("D")=EASDEM
 M EASHDR("A")=EASADD
 ;
 D HDR(.EASHDR)
 ;
 W !?5,"Means Test Anniversary Date: ",$$FMTE^XLFDT($$ADDLEAP^EASMTUTL(EASANV),"D")
 ;
 S EASLIEN=$O(^EAS(713.3,"C",3,0))
 Q:'EASLIEN
 S EALNE=0
 I $D(^EAS(713.3,EASLIEN,1)) D  S EASOK=1
 . F  S EALNE=$O(^EAS(713.3,EASLIEN,1,EALNE)) Q:'EALNE  D
 . . S LINE=^EAS(713.3,EASLIEN,1,EALNE,0)
 . . I LINE["|ANNVDT|" W !?6,$P(LINE,"|ANNVDT|",1)," ",$$FMTE^XLFDT(EASANV,"D"),$P(LINE,"|ANNVDT|",2) Q
 . . W !?6,LINE
 ;
 I $D(^EAS(713.3,EASLIEN,2)) D  S EASOK=1
 . S EALNE=0
 . F  S EALNE=$O(^EAS(713.3,EASLIEN,2,EALNE)) Q:'EALNE  D
 . . S LINE=^EAS(713.3,EASLIEN,2,EALNE,0)
 . . W !,LINE
 ;
 F EAX=0:0 Q:($Y+8)>IOSL  W !
 W ! F XL=1:1:IOM-1 W "-"
 W !,"| Division or Section",?40,"| Executed By (signature and title)",?(IOM-1),"|"
 W !,"|",?40,"|",?(IOM-1),"|"
 W !,"|",?40,"|",?(IOM-1),"|"
 W ! F XL=1:1:IOM-1 W "-"
 W !,?40,"PRINTED: ",$$FMTE^XLFDT($$NOW^XLFDT,"P")
 Q
 ;
HDR(EASHDR) ; Print form header for report of contact
 ; Input
 ;    EASHDR - Header information array
 ;
 N EALNE,EAX,TS1,TS2,TS3,TS4
 ;
 Q:'$D(EASHDR)
 D SETLNE(.EALNE)
 ;
 S TS2=40,TS3=58,TS4=$G(IOM)-1
 ;W $E(EALNE("DD"),1,IOM)
 W !,"D E P A R T M E N T  O F  V E T E R A N  A F F A I R S"
 W !,$E(EALNE("DD"),1,IOM)
 W !,"| REPORT OF CONTACT",?TS2,"| VA Office",?TS3,"| Identification No.",?TS4,"|"
 W !,"| Note: This form must be filled out in",?TS2,"|",?TS3,"| ",?TS4,"|"
 W !,"| ink or on typewriter as it becomes a"
 W ?TS2,"| ",?TS3,"| ",$P(EASHDR("D",2),U,2),?TS4,"|"
 W !,"| permanent record in veterans' folders.",?TS2,"|",?TS3,"|",?TS4,"|"
 W !,$E(EALNE("D"),1,TS4)
 W !,"| Last Name-First Name-Middle Name (Type or print)",?TS3,"| Date of Contact",?TS4,"|"
 W !,"|",?TS3,"|",?TS4,"|"
 W !,"| ",EASHDR("D",1),?TS3,"|",?TS4,"|"
 W !,$E(EALNE("D"),1,TS4)
 W !,"| Address of Veteran",?TS3,"| Telephone",?TS4,"|"
 W !,"| ",EASHDR("A",1),?TS3,"| ",EASHDR("A",8),?TS4,"|"
 I EASHDR("A",2)]"" W !,"| ",EASHDR("A",2),?TS3,"|",?TS4,"|"
 I EASHDR("A",3)]"" W !,"| ",EASHDR("A",3),?TS3,"|",?TS4,"|"
 W !,"| ",EASHDR("A",4)_", "_$P(EASHDR("A",5),U,2)_"  "_$P(EASHDR("A",11),U,2),?TS3,"|",?TS4,"|"
 W !,$E(EALNE("D"),1,TS4)
 W !,"| Person Contacted",?TS3,"| Type of Contact",?TS4,"|"
 W !,"|",?TS3,"| Personal/Telephone",?TS4,"|"
 W !,"|",?TS3,"|",?TS4,"|"
 W !,$E(EALNE("D"),1,TS4)
 W !,"| Address of Person Contacted",?TS3,"| Telephone",?TS4,"|"
 W !,"|",?TS3,"|",?TS4,"|"
 W !,"|",?TS3,"|",?TS4,"|"
 W !,"|",?TS3,"|",?TS4,"|"
 W !,$E(EALNE("D"),1,TS4)
 W !,"  Brief statement of information requested and given",!
EXIT Q
 ;
 ;
SETLNE(EALNE) ;
 N RMAR
 ;
 S RMAR=$G(IOM) S:'RMAR RMAR=80
 S EALNE("D")="",EALNE("DD")="",EALNE("UL")=""
 S $P(EALNE("D"),"-",RMAR)=""
 S $P(EALNE("DD"),"=",RMAR)=""
 Q
