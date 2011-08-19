VAQREQ04 ;ALB/JFP - PDX, REQUEST PATIENT DATA, ASK SEGMENT;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Entry point, second level of loop in VAQREQ03
 ;    NOTE: PDX*MIN is hard coded in this routine
 ;    - Called from VAQREQ03
 ;    - Calls help routine VAQREQ09
 ;
REQ ; -- Request segment
 N DIRUT,DTOUT,DUOUT,X,I,N,L
 N GRPDA,SEGDA,SEGMNU,SEGNODE,SEGNO,SEGNME,GTYPE,GDUZ,GRP
 ;
DRIVER ; -- Driver loop 
 I $D(^TMP("VAQSEG",$J,DOMAIN)) D LISTS ; -- displays segments on edit
 F  D ASKSEG  Q:$D(DIRUT)
 ; -- Cleanup and exit
 K DIRUT,DTOUT,DUOUT,X,I,N,L
 K SEGDA,SEGMNU,SEGNODE,SEGNO,SEGNME,GTYPE,GDUZ,GRP,GRPDA
 QUIT
 ;
ASKSEG ; -- Prompts for segments
 ; -- Sets default segment to PDX*MIN, Minimum patient information
 ;    Note: PDX*MIN is hard coded in this routine, if this mnuemonic
 ;          changes, the routine must change (ASKSEG+3)
 ;
 I '$D(^TMP("VAQSEG",$J,DOMAIN,"PDX*MIN")) D
 .S SEGNO="",SEGNO=$O(^VAT(394.71,"C","PDX*MIN",SEGNO))
 .S SEGNME=$P($G(^VAT(394.71,SEGNO,0)),U,1)
 .S ^TMP("VAQSEG",$J,DOMAIN,"PDX*MIN")=SEGNO_"^"_SEGNME
 ;
 ; -- Call to Dir to request segments
 S POP=0
 S DIR("A")="  Enter Segment: "
 S DIR(0)="FAO^1:30"
 S DIR("?")="^D HLPSEG1^VAQREQ09"
 S DIR("??")="^D HLPSEG2^VAQREQ09"
 W ! D ^DIR K DIR  Q:$D(DIRUT)
 S X=Y
 I X="*L" D LISTS  Q:POP
 I $E(X,1,1)="-" D DELSEG  Q:POP
 I $E(X,1,2)'="G." D SEG  Q:POP
 I $E(X,1,2)="G." D GSEG  Q:POP
 QUIT
 ;
SEG ; -- Dic lookup to verify segment in file 394.71
 S DIC="^VAT(394.71,",DIC(0)="EMQZ"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) S POP=1 QUIT
 S SEGNME=$P(Y(0),U,1),SEGMNU=$P(Y(0),U,2)
 S SEGDA="",SEGDA=$O(^VAT(394.71,"C",SEGMNU,SEGDA))
 S HSCOMPND=$$HLTHSEG^VAQDBIH1(SEGMNU,0)
 I $P(HSCOMPND,U,1)'=0 D EP^VAQREQ11 ; -- Time and occurrence
 D FLESEG
 QUIT
 ;
GSEG ; -- Dic lookup to verify segment group name in file 394.84
 S X=$P(X,".",2) ; -- strip off G.
 S DIC="^VAT(394.84,"
 S DIC(0)="EMQZ"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) S POP=1 QUIT
 S GTYPE=$P(Y(0),U,2),GDUZ=$P(Y(0),U,3)
 I (GTYPE="0")&(DUZ'=GDUZ) D  QUIT
 .W "     ...Private group selected not associated with user"
 .S POP=1
 S GRP=$P(Y,U,2),GRPDA="",GRPDA=$O(^VAT(394.84,"B",GRP,GRPDA))
 D S1
 QUIT
 ;
S1 S SEGDA=""
 F  S SEGDA=$O(^VAT(394.84,GRPDA,"SEG","B",SEGDA)) Q:SEGDA=""  D SETS
 QUIT
SETS S SEGNODE=$G(^VAT(394.71,SEGDA,0))
 Q:SEGNODE=""
 S SEGNME=$P(SEGNODE,U,1),SEGMNU=$P(SEGNODE,U,2)
 S HSCOMPND=$$HLTHSEG^VAQDBIH1(SEGMNU,0)
 I $P(HSCOMPND,U,1)'=0 D GROUP ; -- Time and occurrence
 D FLESEG
 QUIT
 ;
GROUP ; -- Sets time and occurrence limits for segment groups selected
 S PARAMND=$G(^VAT(394.81,1,"LIMITS")) ; -- sets time & occ defaults
 S TLDEF=$P(PARAMND,U,1)
 S OLDEF=$P(PARAMND,U,2)
 ;
 S POS="",POS=$O(^VAT(394.84,GRPDA,"SEG","B",SEGDA,POS))
 S GRPSEGND=$G(^VAT(394.84,GRPDA,"SEG",POS,0))
 S TLIMIT=$P(GRPSEGND,U,4) I TLIMIT="" S TLIMIT=TLDEF
 S OLIMIT=$P(GRPSEGND,U,5) I OLIMIT="" S OLIMIT=OLDEF
 I $P(HSCOMPND,U,2)=0 S TLIMIT=""
 I $P(HSCOMPND,U,3)=0 S OLIMIT=""
 QUIT
 ;
FLESEG ; -- Loops thru domains filing segment data in ^TMP array
 S LPDOM=""
 F  S LPDOM=$O(^TMP("VAQDOM",$J,LPDOM)) Q:LPDOM=""  D FILE
 QUIT
 ;
FILE ;
 S:'$D(TLIMIT) TLIMIT=""
 S:'$D(OLIMIT) OLIMIT=""
 S ^TMP("VAQSEG",$J,LPDOM,SEGMNU)=SEGDA_"^"_SEGNME_"^"_TLIMIT_"^"_OLIMIT
 QUIT
 ;
DELSEG ;  -- Deletes selected segments
 S POP=1,X=$P(X,"-",2)
 I X="" W "     ...No entries selected"  QUIT
 S ARRAY="^TMP(""VAQSEG"","_$J_","_$C(34)_DOMAIN_$C(34)_")"
 S X=$$PARTIC^VAQUTL94(ARRAY,X)
 I X=-1 W "     ... Not Selected" QUIT
 I X="PDX*MIN" W "     ...required segment, not deleted"  QUIT
 I '$D(^TMP("VAQSEG",$J,DOMAIN,X)) W !,X," Not Selected"  QUIT
 K ^TMP("VAQSEG",$J,DOMAIN,X)
 W "     ...Segment Deleted"
 QUIT
 ;
LISTS ; -- Displays a list segments selected for domain
 S POP=1
 I '$D(^TMP("VAQSEG",$J,DOMAIN))  W !!,"** NO SEGMENT(S) SELECTED"  QUIT
 W !!,"------------------------------ Segments Selected ------------------------------"
 S N="" F L=0:1  S N=$O(^TMP("VAQSEG",$J,DOMAIN,N))  Q:N=""  W:'(L#8) ! W ?L#8*10 W N
 W !,"-------------------------------------------------------------------------------"
 W ! QUIT
 ;
END ; -- End of code
 QUIT
