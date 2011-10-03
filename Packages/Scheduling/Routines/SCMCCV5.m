SCMCCV5 ;ALB/JAM;Allow edits of invalid .03 field in 404.52;12/1/99@1055
 ;;5.3;Scheduling;**204,297**;DEC 01, 1999
 ;
EDIT ;Entry point for cnahes to .03 field in file 404.52
 N SCEND
 D HDR(0)
 S SCEND=0
 F  D PROCESS I SCEND Q
 K DIE,^TMP("PCMM PRACTITIONER",$J),DTOUT,DUOUT,DIROUT,DR,DA,X,Y
 Q
 ;
PROCESS ;Get list of invalid .03 field in file 404.52, select and then edit
 N SCIEN,FND
 K ^TMP("PCMM PRACTITIONER",$J)
 S FND=$$LST()
 I 'FND W "No Entries found" S SCEND=1 Q
 ;select a valid IEN to edit
 S SCIEN=$$GETIEN() I 'SCIEN S SCEND=1 Q
 ;edit .03 field
REP D TPHIS(SCIEN)
 K DA,DR,DIE S DIE="^SCTM(404.52,",DA=SCIEN
 S DR=".03Practitioner" D ^DIE K DR
 I $D(DTOUT)!($D(DUOUT)) S SCEND=1 Q
 I $G(Y)<0 Q
 ;verify practitioner response
 K DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y",DIR("A")="         ...OK",DIR("B")="Yes"
 S DIR("?")="Enter Yes or <RT> to accept or No to change response"
 D ^DIR K DIR I Y Q
 I $D(DTOUT)!$D(DUOUT)!($D(DIROUT)) Q
 G REP
 Q
 ;
GETIEN() ;Select IEN from FILE 404.52
 N DIR,X,Y
 S DIR("A")="Select IEN",DIR("?")="^D LSTIEN^SCMCCV5"
 S DIR(0)="FO^^K:'$D(^TMP(""PCMM PRACTITIONER"",$J,X)) X"
 D ^DIR I $D(DIRUT) Q 0
 D DSP(X)
 Q X
 ;
LSTIEN ;Display a list of .03 entries stored in ^TMP("PCMM PRACTITIONER",$J
 N IEN,SCSTP
 S (IEN,SCSTP)=0
 D HDR(1)
 F  S IEN=$O(^TMP("PCMM PRACTITIONER",$J,IEN)) Q:'IEN  D  I SCSTP Q
 . I ($Y+3>IOSL) D  I 'Y S SCSTP=1 Q
 . . S DIR(0)="E",DIR("A")="Enter RETURN to continue or '^' to exit"
 . . D ^DIR D:Y HDR(1)
 . D DSP(IEN)
 I 'SCSTP W !,?20,"To Edit, enter an IEN number from the displayed list"
 Q
 ;
HDR(FL) ;Print header for list of invalid entries in file 404.52
 W @IOF
 W !,?23,$S(FL:"LIST OF",1:"EDITING")_" INVALID PRACTITIONER ENTRY",!!
 I FL D
 . W ?20,"IEN",?27,"Effective Date",?44,"Team",?68,"Status",!
 . W ?20,"---",?27,"--------------",?44,"----",?68,"------",!
 Q
 ;
DSP(DIEN) ;Display record from file 404.52 for DIEN entry
 N SCDAT,SCDT,SCSTA,SCTP
 I $G(DIEN)="" Q
 S SCDAT=$G(^SCTM(404.52,DIEN,0)),Y=$P(SCDAT,U,2) X ^DD("DD") S SCDT=Y
 S SCTP=$P(SCDAT,U) S:SCTP'="" SCTP=$P($G(^SCTM(404.57,SCTP,0)),U)
 S SCSTA=$S($P(SCDAT,U,4):"Active",1:"Inactive")
 W ?20,DIEN,?27,SCDT,?44,$E(SCTP,1,20),?68,SCSTA,!
 Q
 ;
TPHIS(SCIEN) ;Display complete position history for team position
 N ZDATE,ZLIST,ZERROR,SCX,SCY,TP,C,SCSTP,SCNAM
 S TP=$P(^SCTM(404.52,SCIEN,0),U) I TP="" Q
 S ZDATE("BEGIN")=1,ZDATE("END")=9999999,ZDATE("INCL")=0,SCSTP=0,C=1
 S SCX=$$PRTP^SCAPMC(TP,"ZDATE","ZLIST","ZERROR",0,1)
 I 'SCX!($D(ZERROR)) Q
 W !?25,"TEAM POSITION HISTORY"
 W !?10,"Effective Date",?30,"Staff",?54,"Status",!
 S SCX=0 F  S SCX=$O(ZLIST("ALL",404.52,SCX)) Q:'SCX  D  I SCSTP Q
 . S SCY=ZLIST("ALL",404.52,SCX),SCNAM=$P(SCY,U,6),C=C+1
 . I '(C#10) S DIR(0)="E" D ^DIR W ! I 'Y S SCSTP=1 Q
 . W:SCNAM="" ?6,"***"
 . W ?10,$P(SCY,U,4),?30,$E(SCNAM,1,20),?54,$P(SCY,U,2)
 . W:SCNAM="" " ***" W !
 Q
 ;
LST() ;Returns list of invalid entries from file #404.52 for field .03
 ;This subroutine checks the POSITION ASSIGNMENT HISTORY FILE (#404.52)
 ;for invalid pointers stored in the PRACTITIONER field (#.03) and
 ;returns a list of all such entries ien.
 ;
 ; Output:-  
 ;    ^TMP("PCMM PRACTITIONER",$J,IEN - Name of array to return list
 ;                                      Array subsripted by ien number
 ;     Returns - 1 if entry found, 0 no entry found
 ;
 N IEN,PRAC
 S IEN=0
 F  S IEN=$O(^SCTM(404.52,IEN)) Q:'IEN  I $G(^SCTM(404.52,IEN,0))'="" D
 . S PRAC=$P(^SCTM(404.52,IEN,0),U,3)
 . I PRAC'>0!('$D(^VA(200,+PRAC))) S ^TMP("PCMM PRACTITIONER",$J,IEN)="" Q
 . I $D(^USR(8930.3,"B",PRAC))!('$$USEUSR^SCMCTPU) Q
 . S ^TMP("PCMM PRACTITIONER",$J,IEN)=""
 Q $S($D(^TMP("PCMM PRACTITIONER",$J)):1,1:0)
