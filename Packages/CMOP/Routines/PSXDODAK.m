PSXDODAK ;BIR/PDW-FILE .QACs FACILITY RELEASE PROCESSED ACKs & NAKs ;09/09/02 10:45 AM
 ;;2.0;CMOP;**38,45**;11 Apr 97
EN(PATH,FNAME) ; needs directory & file name
 ; force an error in the next line
 ;S X=ERROR ; generate an undefined error 
 D EXIT
 I $L(PATH),$L(FNAME) I 1
 E  S PSXERR="0^BAD PATH OR FILENAME" G ERRMSG
 K ^TMP($J,"PSXDOD")
 S GBL="^TMP("_$J_",""PSXDOD"",1)"
 S Y=$$FTG^%ZISH(PATH,FNAME,GBL,3)
 I Y'>0 S PSXERR="9^"_PATH_U_FNAME_U_" DID NOT LOAD" G ERRMSG
 I $D(^TMP($J,"PSXDOD"))'>1 S PSXERR="9^"_PATH_U_FNAME_U_" DID NOT LOAD" G ERRMSG
 S FHS=^TMP($J,"PSXDOD",1),BHS=^TMP($J,"PSXDOD",2)
 I $E(FHS,1,3)="FHS",$E(BHS,1,3)="BHS" I 1
 E  S PSXERR="1^File headers not correct ^"_FNAME Q
 ; setup variables to call into PSXVEND for filing acks and nacks
 ;BHS|^~\&|CHCS|VistA|20020417081343||||0617-021081441
 F YY="PDT^5","MSG^9" D PIECE(BHS,"|",YY)
 S (PSXPDT,PDT)=$$FMDATE^HLFNC(PDT),TXMZ="1"_MSG
 ;MSGNUM is to be the same ID of the release message .qry the .qac is responding to
 S SS="1"_$P(MSG,"-"),MSGNUM=$P(MSG,"-",2)
 D NOW^%DTC S ACKTM=%
 I $E(IOST)="C" W !,"UPDATING ",MSGNUM
 D DOD^PSXVEND ; update 554 message status
 ;
 F LNNUM=3:1 S LN=$G(^TMP($J,"PSXDOD",LNNUM)) Q:LN=""  S SEG=$E(LN,1,3) Q:SEG="BTS"  D:SEG="MSA" MSA
 ;
EXIT ;
 K ^TMP($J,"PSXDOD")
 K FHS,BHS,PDT,MSG,TXMZ,MSGNUM,HOLD
 Q
MSA ; pull variables from MSA segment and call into PSXVEND $RX or $INV
 ;MSA|CA|0617-AA116-2|
 ;MSA|CR|516-11450-8954|2-RX ENTRY MISSING
 I $E(IOST)="C" W !,LN
 F YY="TYP^2","RXNDX^3","STAT^4" D PIECE(LN,"|",YY)
 S RXNDX="1"_RXNDX,(RXN,RXNUM)=$P(RXNDX,"-",2),FILL=$P(RXNDX,"-",3),STAT=+STAT
 I '$D(^PSX(552.4,"E",RXNDX)) S PSXERR=".QAC RX Not Found "_RXNDX_" "_FNAME D ERRMSG Q
 S AA=$O(^PSX(552.4,"E",RXNDX,0)),BB=$O(^PSX(552.4,"E",RXNDX,AA,0))
 I $E(IOST)="C" W !,"ENTRY AA BB ",AA," ",BB
 I AA,BB I 1
 E  S PSXERR="QAC RX Entry Not Found "_RXNDX_" "_FNAME D ERRMSG Q
 S SS="1"_$P(MSG,"-"),PDT=PSXPDT
 K DIC,DA,DR,DIE,DO,DD
 D:TYP="CA" DODRX^PSXVEND
 D:TYP="CR" DODINV^PSXVEND
 Q
PIECE(REC,DLM,XX) ;
 ; Set variable V = piece P of REC using delimiter DLM
 N V,P S V=$P(XX,U),P=$P(XX,U,2),@V=$P(REC,DLM,P)
 Q
PUT(REC,DLM,XX) ;
 ; Set Variable V into piece P of REC using delimiter DLM
 N V,P S V=$P(XX,U),P=$P(XX,U,2)
 S $P(REC,DLM,P)=$G(@V)
 Q
ERRMSG ;send error message to folks & DOD
 S DIRHOLD=$$GET1^DIQ(554,1,23),HOLD=$G(HOLD)+1
 I HOLD=1 D
 . F XX=1:1:5 S Y=$$GTF^%ZISH($NA(^TMP($J,"PSXDOD",1)),3,DIRHOLD,FNAME) Q:Y=1  H 4
 . I Y'=1 S GBL=$NA(^TMP($J,"PSXDOD")) D FALERT^PSXDODNT(FNAME,DIRHOLD,GBL)
 S XMSUB="DOD CMOP Error "_FNAME
 ;S XMY(DUZ)="" ;***TESTING
 S XMY("G.PSXX CMOP MANAGERS")=""
 S XMTEXT="PSXTXT("
 S PSXTXT(1,0)="DOD CMOP .QAC Facility Release Acknowledgement filing experienced an error"
 S PSXTXT(2,0)=$G(PSXERR)
 S PSXTXT(3,0)="FILE: "_FNAME
 S PSXTXT(4,0)="A copy of the file has been placed in the hold directory "_DIRHOLD
 D ^XMD
 I $E(IOST)="C" W ! F I=1:1:4 W !,PSXTXT(I,0) I I=4 H 3
 K PSXTXT,DIRHOLD
 Q
RXNDX ; backfill the RX multiple RXNDX field #40 of file 552.4 
 S ORDDA=0 F  S ORDDA=$O(^PSX(552.4,ORDDA)) Q:ORDDA'>0  D
 . S SITE=$$GET1^DIQ(552.4,ORDDA,.01),SITE=$P(SITE,"-")
 . S RXDA=0 F  S RXDA=$O(^PSX(552.4,ORDDA,1,RXDA)) Q:RXDA'>0  S XX=^(RXDA,0) D
 .. F YY="RXNM^1","FILL^12" D PIECE(XX,U,YY)
 .. S FILL=FILL+1,VAL=SITE_"-"_RXNM_"-"_FILL
 .. K DR,DIE,DA
 .. S DIE="^PSX(552.4,"_ORDDA_",1,",DA(1)=ORDDA,DA=RXDA,DR="40///^S X=VAL"
 .. D ^DIE K DR,DIE,DA
 Q
