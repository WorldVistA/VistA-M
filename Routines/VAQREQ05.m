VAQREQ05 ;ALB/JFP - REQUEST PDX RECORD, COPY DOMAIN;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;**30**;NOV 17, 1993
EP ; -- Main entry point for the list processor
 ;    - Called from VAQREQ02
 ;
REQ ; -- Request domain
 N SDI,SDAT,DIRUT,DTOUT,DUOUT,X,Y,N,L,POP
 N INSTDA,INST,STNO,GRP,GRPDA,DOMDA,DOMAIN,DOM,DOMNODE
 S SDI=0
 F  S SDI=$O(VALMY(SDI))  Q:SDI=""  D
 .S SDAT=$G(^TMP("VAQIDX",$J,SDI))
 ;
 F  D ASKDOM  Q:$D(DIRUT)
 D:$D(^TMP("VAQCOPY",$J)) COPY
 K SDI,SDAT,VALMY,DIRUT,DTOUT,DUOUT,X,Y,N,L,POP
 K INSTDA,INST,STNO,GRP,GRPDA,DOMDA,DOMAIN,DOM,DOMNODE
 K ^TMP("VAQCOPY",$J),SEGNODE
 QUIT
 ;
ASKDOM ; -- Call to Dir to request domain
 D:$D(^TMP("VAQCOPY",$J)) LISTD
 S POP=0
 S DIR("A")="Copy to Domain: "
 S DIR(0)="FAO^1:30"
 S DIR("?")="^D HLPDOM1^VAQREQ09"
 S DIR("??")="^D HLPDOM2^VAQREQ09"
 W ! D ^DIR K DIR  Q:$D(DIRUT)
 S X=Y
 I X="*L" D LISTD  Q:POP
 I $E(X,1,1)="-" D DELDOM  Q:POP
 I $E(X,1,2)'="G." D DOM  Q:POP
 I $E(X,1,2)="G." D GDOM  Q:POP
 QUIT
 ;
DOM ; -- Dic lookup to verify domain in file 4.2
 N FLAGS
 S DIC="^DIC(4.2,",DIC(0)="EMQZ"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) S POP=1  QUIT
 ; -- Check for closed domains
 S FLAGS=$P(Y(0),U,2)
 I FLAGS["C" W $C(7),"     ...Domain is closed" S POP=1 QUIT
 ;
 S INSTDA=$P(Y(0),U,13),DOMAIN=$P(Y,U,2)
 I INSTDA="" W "     ...Domain entered does not have a station number" S POP=1  QUIT
 S STNO=$O(^DIC(4,"D",INSTDA,""))
 I STNO=""  W "     ...Domain does not have a valid station number"  S POP=1  QUIT
 S INST=$P(^DIC(4,STNO,0),U,1),^TMP("VAQCOPY",$J,DOMAIN)=INSTDA_"^"_INST
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
 F  S INSTDA=$O(^VAT(394.83,GRPDA,"FAC","A-OUTGRP",INSTDA))  Q:'INSTDA  D G2
 QUIT
G2 F  S DOMDA=$O(^VAT(394.83,GRPDA,"FAC","A-OUTGRP",INSTDA,DOMDA))  Q:'DOMDA  D SETG
 QUIT
 ;
SETG ; -- 
 Q:'$$OKDOM^VAQREQ03(GRPDA,INSTDA,DOMDA)
 S INST=$P($G(^DIC(4,INSTDA,0)),U,1)
 S DOMAIN=$P($G(^DIC(4.2,DOMDA,0)),U,1)
 S ^TMP("VAQCOPY",$J,DOMAIN)=INSTDA_"^"_INST
 QUIT
 ;
DELDOM ; -- Deletes domain & segments associated with domain
 S POP=1,X=$E(X,2,99)
 I X="" W !!,"** NO ENTRIES SELECTED"  QUIT
 I '$D(^TMP("VAQCOPY",$J,X)) W "     ... ",X," Not Selected"  QUIT
 K ^TMP("VAQCOPY",$J,X)
 QUIT
 ;
COPY ; -- Copies segments to new domain(s)
 S DOM=""
 F  S DOM=$O(^TMP("VAQCOPY",$J,DOM))  Q:DOM=""  D C1
 QUIT
 ;
C1 S DOMNODE=$G(^TMP("VAQCOPY",$J,DOM)),^TMP("VAQSEG",$J,DOM)=DOMNODE,SEG=""
 F  S SEG=$O(^TMP("VAQSEG",$J,SDAT,SEG))  Q:SEG=""  D C2
 QUIT
C2 S SEGNODE=$G(^TMP("VAQSEG",$J,SDAT,SEG)),^TMP("VAQSEG",$J,DOM,SEG)=SEGNODE
 QUIT
 ;
LISTD ; -- Displays a list domains selected
 S POP=1
 I '$D(^TMP("VAQCOPY",$J))  W !!,"** NO DOMAIN(S) SELECTED"  QUIT
 W !!,"------------------------------ Domains Selected ------------------------------"
 S N="" F L=0:1  S N=$O(^TMP("VAQCOPY",$J,N))  Q:N=""  W:'(L#8) ! W ?L#8*40 W N
 W !,"-------------------------------------------------------------------------------"
 W ! QUIT
 ;
END ; -- End of code
 QUIT
