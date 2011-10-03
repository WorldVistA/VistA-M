VAQREQ03 ;ALB/JFP - PDX, REQUEST PATIENT DATA, ASK DOMAIN/SEGMENT;01MAR93<<= NOT VERIFIED > [ 10/18/96  9:19 AM ]
 ;;1.5;PATIENT DATA EXCHANGE;**22,30**;NOV 17, 1993
EP ; -- Main entry point
 ;    - Called from VAQREQ02
 ;    - Calls ask segment routine VAQREQ04
 ;    - Calls help routine VAQREQ09
 ;
REQ ; -- Request domain
 N L,N,X,POP,INSTDA,DOMAIN,STNO,INST,DOMDA,FLAGS
 N DIRUT,DTOUT,DUOUT
 ;
 S SEGNO="",SEGNO=$O(^VAT(394.71,"C","PDX*MIN",SEGNO))
 S SEGNME=$P($G(^VAT(394.71,SEGNO,0)),U,1)
 ;
 F  D ASKDOM  Q:$D(DIRUT)
 QUIT
 ;
ASKDOM ; -- Call to Dir to request domain
 D:$D(^TMP("VAQSEG",$J)) LISTD
 K ^TMP("VAQDOM",$J)
 S POP=0
 S DIR("A")="Enter Domain: "
 S DIR(0)="FAO^1:30"
 S DIR("?")="^D HLPDOM1^VAQREQ09"
 S DIR("??")="^D HLPDOM2^VAQREQ09"
 W ! D ^DIR K DIR  Q:$D(DIRUT)
 S X=Y
 I X="*L" D LISTD  Q:POP
 I $E(X,1,1)="-" D DELDOM  Q:POP
 I $E(X,1,2)'="G." D DOM  Q:POP
 I $E(X,1,2)="G." D GDOM  Q:POP
 D EP^VAQREQ04 ; -- ask segments
 QUIT
 ;
DOM ; -- Dic lookup to verify domain in file 4.2
 S DIC=4.2,DIC(0)="EMQZ"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) S POP=1  QUIT
 ; -- Check for closed domains
 S FLAGS=$P(Y(0),U,2)
 I FLAGS["C" W $C(7),"     ...Domain is closed" S POP=1 QUIT
 ;
 S STNO=$P(Y(0),U,13),DOMAIN=$P(Y,U,2)
 I STNO="" W "     ...Domain entered does not have a station number" S POP=1  QUIT
 S INSTDA=$O(^DIC(4,"D",STNO,""))
 I INSTDA=""  W "     ...Domain does not have a valid station number"  S POP=1  QUIT
 S INST=$P(^DIC(4,INSTDA,0),U,1)
 S ^TMP("VAQSEG",$J,DOMAIN,"PDX*MIN")=SEGNO_"^"_SEGNME
 S ^TMP("VAQDOM",$J,DOMAIN)=""
 QUIT
 ;
GDOM ; -- Dic lookup to verify domain group name in file 394.83
 S X=$P(X,".",2) ; -- strip off G.
 S DIC="^VAT(394.83,"
 S DIC(0)="EMQZ"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) S POP=1  QUIT
 S GRP=$P(Y,U,2),GRPDA="",GRPDA=$O(^VAT(394.83,"B",GRP,GRPDA))
 D G1
 QUIT
 ;
G1 S (INSTDA,DOMDA)=""
 F I=1:1  S INSTDA=$O(^VAT(394.83,GRPDA,"FAC","A-OUTGRP",INSTDA))  Q:'INSTDA  D G2
 QUIT
G2 F I=1:1  S DOMDA=$O(^VAT(394.83,GRPDA,"FAC","A-OUTGRP",INSTDA,DOMDA))  Q:'DOMDA  D SETG
 QUIT
 ;
SETG ; -- 
 Q:'$$OKDOM(GRPDA,INSTDA,DOMDA)
 S INST=$P($G(^DIC(4,INSTDA,0)),U,1)
 S DOMAIN=$P($G(^DIC(4.2,DOMDA,0)),U,1)
 S ^TMP("VAQSEG",$J,DOMAIN,"PDX*MIN")=SEGNO_"^"_SEGNME
 S ^TMP("VAQDOM",$J,DOMAIN)=""
 QUIT
OKDOM(GRPDA,INSTDA,DOMDA) ;
 N REC
 S REC=$G(^DIC(4.2,DOMDA,0))
 Q:$P(REC,U,2)'["C" 1
 ; Domain is closed.  Tell the user and delete the remote facility
 ; record from the group.
 W !!,"Domain ",$P(REC,U,1)," is closed."
 N FDA,VIEN
 S VIEN=$O(^VAT(394.83,GRPDA,"FAC","B",INSTDA,0)) Q:'VIEN
 S FDA(394.831,VIEN_","_GRPDA_",",.01)="@"
 D FILE^DIE("","FDA")
 W !,"Because of that, Facility '",$P($G(^DIC(4,INSTDA,0)),U,1),"'"
 W !,"has been deleted from Outgoing Group '",$P($G(^VAT(394.83,GRPDA,0)),U,1),"'."
 Q 0
 ;
DELDOM ; -- Deletes domain & segments associated with domain
 S POP=1,X=$E(X,2,99)
 I X="" W !!,"** NO ENTRIES SELECTED"  QUIT
 S X=$$PARTIC^VAQUTL94("^TMP(""VAQSEG"","_$J_")",X)
 I X=-1 W "     ... Not Selected"  QUIT
 I '$D(^TMP("VAQSEG",$J,X)) W "     ... ",X," Not Selected"  QUIT
 K ^TMP("VAQSEG",$J,X)
 W "     ...domain deleted and associated segments"
 QUIT
 ;
LISTD ; -- Displays a list domains selected
 S POP=1
 I '$D(^TMP("VAQSEG",$J))  W !!,"** NO DOMAIN(S) SELECTED"  QUIT
 W !!,"------------------------------ Domains Selected ------------------------------"
 S N="" F L=0:1  S N=$O(^TMP("VAQSEG",$J,N))  Q:N=""  W:'(L#8) ! W ?L#8*40 W N
 W !,"-------------------------------------------------------------------------------"
 W ! QUIT
 ;
END ; -- End of code
 QUIT
