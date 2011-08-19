ENWO2 ;WIRMFO/DH,SAB-Disapprove Work Order ;2/3/97
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
DISAP ;Disapprove work order
EN S DIC("S")="I $P($G(^(5)),U,2)=""""" D WO^ENWOUTL K DIC
 G:Y'>0 EXIT S DA=+Y
 S DIE="^ENG(6920,"
EN1 ;
 I $D(^ENG(6920,DA,5)),$P(^(5),U,2)]"" W !,*7,"NOTE: This Work Order has already been closed out." W:$D(^XUSEC("ENEDCLWO",DUZ)) !,"Use the Work Order EDIT or DISPLAY option if you need to edit." G EXIT
 S ENDA(0)=DA,DR=$S($D(^DIE("B","ENZWODISAP")):"[ENZWODISAP]",1:"[ENWODISAP]") D ^DIE W !!
 S DA=ENDA(0)
 K ENDA(0) G EXIT
EXIT Q
 ;
MSG ; Notify Requestor of W.O. Status Change
 ; File 6920 Field 32 "AH" mumps x-ref
 ; Expects DA (ien of w.o.)
 N ENABBR,ENDAS,ENELWO,ENI,ENQ,ENSEND,ENSO,ENX,ENY
 S ENSEND="" ; flag: =1 send msg, =0 no msg, =NULL don't know yet
 S ENDAS=DA_","
 D GETS^DIQ(6920,ENDAS,".01;.05;2;32","E","ENQ")
 D GETS^DIQ(6920,ENDAS,"7.5;32;32.1","I","ENQ")
 S:$E(ENQ(6920,ENDAS,.01,"E"),1,3)="PM-" ENSEND=0 ; ignore PM W.O.s
 S:ENQ(6920,ENDAS,7.5,"I")'?1.N ENSEND=0 ; no requestor
 S:ENQ(6920,ENDAS,7.5,"I")=DUZ ENSEND=0 ; don't send msg to self
 ; if disapproved
 I ENSEND="",ENQ(6920,ENDAS,32,"E")="DISAPPROVED" D  S:ENSEND="" ENSEND=0
 . I ENQ(6920,ENDAS,2,"E")["COMPUTER" S ENSEND=1
 ; else if existing notification preference
 I ENSEND="",ENQ(6920,ENDAS,32.1,"I")]"" D  S:ENSEND="" ENSEND=0
 . I ENQ(6920,ENDAS,32.1,"I")="S" S ENSEND=1
 . I ENQ(6920,ENDAS,32.1,"I")="C",ENQ(6920,ENDAS,32,"E")="COMPLETED" S ENSEND=1
 ; else if existing software option
 I ENSEND="" D  S:ENSEND="" ENSEND=0
 . S ENI=$O(^ENG(6910.2,"B","NOTIFY W.O. REQUESTOR",0))
 . S ENSO=$S(ENI?1.N:$P($G(^ENG(6910.2,ENI,0)),U,2),1:"")
 . I ENSO]"" D
 . . ; check if electronic w.o.
 . . S ENELWO=0
 . . F ENI=1:1 Q:$E(ENQ(6920,ENDAS,.05,"E"),ENI)'?1U
 . . S ENABBR=$E(ENQ(6920,ENDAS,.05,"E"),1,ENI-1)
 . . Q:ENABBR=""
 . . S ENI=89
 . . F  S ENI=$O(^DIC(6922,ENI)) Q:'ENI  D:ENI#100>89  Q:ENELWO
 . . . I $P($G(^(ENI,0)),U,2)=ENABBR S ENELWO=1
 . . Q:'ENELWO
 . . I ENSO="S" S ENSEND=1
 . . I ENSO="C",ENQ(6920,ENDAS,32,"E")="COMPLETED" S ENSEND=1
 D:ENSEND=1
 . ; send mail message to requestor
 . N ENL,ENTEXT,XMCHAN,XMDUZ,XMSUB,XMTEXT,XMY
 . S ENTEXT(1)="A work request which you entered on "_$$GET1^DIQ(6920,ENDAS,1)
 . S ENTEXT(2)="   Original Work Order #: "_ENQ(6920,ENDAS,.05,"E")
 . S ENTEXT(3)="   Task Description: "_$$GET1^DIQ(6920,ENDAS,6)
 . S ENTEXT(4)="   Contact Person: "_$$GET1^DIQ(6920,ENDAS,7)
 . S ENTEXT(4)=ENTEXT(4)_"   Phone: "_$$GET1^DIQ(6920,ENDAS,8)
 . S ENTEXT(5)=$S(ENQ(6920,ENDAS,32,"I")<5:"is ",1:"has been ")
 . S ENTEXT(5)=ENTEXT(5)_ENQ(6920,ENDAS,32,"E")
 . S:ENQ(6920,ENDAS,32,"I")>4 ENTEXT(5)=ENTEXT(5)_" on "_$$GET1^DIQ(6920,ENDAS,36)
 . S ENTEXT(5)=ENTEXT(5)_"."
 . S ENL=5
 . I ENQ(6920,ENDAS,32,"E")="COMPLETED" D
 . . S ENL=ENL+1,ENTEXT(ENL)=" "
 . . ;
 . . S ENX("DIMSG",1)="Work Perf: "_$P($G(^ENG(6920,DA,5)),U,7)
 . . K ENY D MSG^DIALOG("AM",.ENY,70,"","ENX")
 . . F ENI=1:1 Q:'$D(ENY(ENI))  S ENL=ENL+1,ENTEXT(ENL)=ENY(ENI)
 . . ;
 . I $O(^ENG(6920,DA,6,0)) D
 . . S ENL=ENL+1,ENTEXT(ENL)=" "
 . . S ENL=ENL+1,ENTEXT(ENL)="COMMENTS:"
 . . S ENI=0
 . . F  S ENI=$O(^ENG(6920,DA,6,ENI)) Q:'ENI  S ENL=ENL+1,ENTEXT(ENL)=$G(^(ENI,0))
 . I $O(^DIC(6910,1,5,0)) D
 . . ; add WORK ORDER MESSAGE TEXT if any
 . . S ENL=ENL+1,ENTEXT(ENL)=" "
 . . S ENI=0
 . . F  S ENI=$O(^DIC(6910,1,5,ENI)) Q:'ENI  S ENL=ENL+1,ENTEXT(ENL)=$G(^(ENI,0))
 . S XMSUB="Work Order "_ENQ(6920,ENDAS,.01,"E")_" STATUS"
 . ;_" "_ENQ(6920,ENDAS,32,"E")
 . S XMCHAN=1,XMTEXT="ENTEXT(",XMDUZ="AEMS/MERS"
 . S XMZ=$P($G(^ENG(6920,DA,4)),U,6)
 . I XMZ,$$SUBGET^XMGAPI0(XMZ)]"" D  I ENI>0 Q
 . . ; send message as response
 . . S ENI=$$ENT^XMA2R(XMZ,XMSUB,.ENTEXT,"",DUZ)
 . ; create new message
 . K XMZ D XMZ^XMA2 I XMZ'>0 Q  ; could not create new message
 . ; save message number in w.o.
 . S $P(^ENG(6920,DA,4),U,6)=XMZ
 . ; add text to message
 . S (ENI,ENL)=0 F  S ENI=$O(ENTEXT(ENI)) Q:'ENI  D
 . . S ^XMB(3.9,XMZ,2,ENI,0)=ENTEXT(ENI),ENL=ENL+1
 . I ENL S ^XMB(3.9,XMZ,2,0)="^3.92^"_ENL_U_ENL_U_DT
 . ; make information only
 . K ENL
 . S ENL(3.9,XMZ_",",1.97)="Y"
 . D FILE^DIE("E","ENL")
 . ; forward to user
 . S XMY(ENQ(6920,ENDAS,7.5,"I"))=""
 . D ENT1^XMD
 Q
 ;ENWO2
