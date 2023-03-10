RCTCSJS ;ALBANY/LEG - CROSS-SERVICING REJECTS SERVER;02/19/14 3:21 PM
V ;;4.5;Accounts Receivable;**301,323,336,343**;Mar 20, 1995;Build 59
 ;;Per VA Directive 6402, this routine should not be modified.
 ;Program to process CS REJECT server messages from AITC
 ;
 ;PRCA*4.5*323 a. Convert reject rec totals to absolute value
 ;             b. Allow C2 B rec type or '3E' reject clear CS flag
 ;
 ;PRCA*4.5*336 Ensure CS date is reset for rejected recalls on bills
 ;
 ;PRCA*4.5*343 Only set the CS date for rejected recall transaction
 ;             if the bill status is active (16).
 ; 
 ;===============================================================================
SERVER G SERVER^RCTCSJS0
 ; 
SETREJS ;
 S IDXS=".01;1;2;3;4;5;6;7;8;9;10;11;12;13;14"
 S BILLIEN=""
 F  S BILLIEN=$O(^XTMP(NMSPC,$J,"BILL",BILLIEN)),SBILL="" Q:'$L(BILLIEN)  D  ;
 . F  S SBILL=$O(^XTMP(NMSPC,$J,"BILL",BILLIEN,SBILL)),HDATE="" Q:'$L(SBILL)  D  ;
 .. F  S HDATE=$O(^XTMP(NMSPC,$J,"BILL",BILLIEN,SBILL,HDATE)),CSRC="" Q:'$L(HDATE)  D  ;
 ... F  S CSRC=$O(^XTMP(NMSPC,$J,"BILL",BILLIEN,SBILL,HDATE,CSRC)),RTYP="" Q:CSRC=""  D  ;
 .... F  S RTYP=$O(^XTMP(NMSPC,$J,"BILL",BILLIEN,SBILL,HDATE,CSRC,RTYP)),RACTN="" Q:RTYP=""  D  ;
 ..... F  S RACTN=$O(^XTMP(NMSPC,$J,"BILL",BILLIEN,SBILL,HDATE,CSRC,RTYP,RACTN)) Q:RACTN=""  D  ;
 ...... S CERRS=$P(^XTMP(NMSPC,$J,"BILL",BILLIEN,SBILL,HDATE,CSRC,RTYP,RACTN),U)
 ...... S ^XTMP(NMSPC,$J,"ERRCDS",CERRS,BILLIEN)="" ; log by errs found
 ...... S REC=ZDATE_U_CSRC_U_$TR(CERRS,",","^")
 ...... S $P(REC,U,12)=RTYP,$P(REC,U,13)=RACTN,$P(REC,U,14)=BCIDA,$P(REC,U,15)=XMZ
 ...... S PATID=$P(^PRCA(430,BILLIEN,0),U,7),OTHERID=$P(^PRCA(430,BILLIEN,0),U,9)
 ...... I OTHERID D  ;
 ....... S IDNUMGLB=$P(^RCD(340,OTHERID,0),U),IDGLOB=$P(IDNUMGLB,";",2),IDNUM=+IDNUMGLB
 ....... S IDREC0=@("^"_IDGLOB_IDNUM_",0)")
 ....... S NAM=$P(IDREC0,U),SSN=$P(IDREC0,U,9)
 ...... I PATID S NAM=$P(^DPT(PATID,0),U),SSN=$P(^DPT(PATID,0),U,9)
 ...... S STATCNT=STATCNT-1
 ...... D UPDREJ
 Q  ; SETREJS
 ;
UPDREJ ;
 K DR,DA,DD,DO,Y
 ;
 ; checks for valid bill
 S DIC="^PRCA(430,",DIC(0)="KMNZ",X=BILLIEN D ^DIC
 S KBILL=$E(SBILL,5,11)
 ; 
 ; Set ID for errors if ARTXNID not available
 N ERRORID
 S ERRORID=$S($G(ARTXNID(BILLIEN))="":U_U_RECN,1:ARTXNID(BILLIEN))
 ;
 I Y=-1 D  Q  ;
 . S ZMSG="Unknown Bill: "_BILLIEN_"/"_SBILL_"/"_RTYP
 . D RECERR(.ERRCNT,"UNK-BILL:",ZMSG,$P(ERRORID,U,3),.RECERR) Q  ; UPDREJ ;
 ; checks if REJECT record was previously logged
 S COMMENT="XMB "_XMZ_" "_BCIDA
 ;I $D(^PRCA(430,BILLIEN,18,"B",ZDATE)) D  Q:PREV  ;UPDREJ
 ;. S IDX="",PREV=0
 ;. F  S IDX=$O(^PRCA(430,BILLIEN,18,"B",ZDATE,IDX)) Q:'IDX  D  ;
 ;.. I $P(^PRCA(430,BILLIEN,18,IDX,0),U,1,14)=$P(REC,U,1,14) S PREV=1 Q
 ;. I PREV D  ;
 ;. . S ZMSG="BILL Previously Logged IEN: "_BILLIEN_"/"_SBILL_"/"_RTYP
 ;. . D RECERR(.ERRCNT,"BILL PREV LOGGED",ZMSG,$P(ERRORID,U,3),.RECERR)
 ;
 ; gets next rejects subfile entry number
 K DR,DA,DD,DO
 S DA(1)=+Y
 S DIC="^PRCA(430,"_DA(1)_",18,"
 S DIC(0)="KMNZ"
 S DIC("P")=$P(^DD(430,172,0),"^",2)
 S (DA,X)=$O(@(DIC_"""A"")"),-1)
 D ^DIC
 ;
 ; set Reject Fields
 K DD,DO
 S DA(1)=BILLIEN
 ; S DA=$S(Y=-1:1,1:DA+1)
 S DA=$S($O(^PRCA(430,BILLIEN,18,"A"),-1):($O(^PRCA(430,BILLIEN,18,"A"),-1)+1),1:1)
 S DIE=DIC K DIC
 S DR=""
 D RJCDCONV
 F PC=1:1:15 S DTA=$P(REC,U,PC) I $L(DTA) S DR=DR_$P(IDXS,";",PC)_"////"_DTA_";"
 S DIC("DR")=DR
 I $L(DR) D  ;
 . D ^DIE
 . ; Re-Index AB x_ref
 . S DIK(1)=".01^AB^B"
 . S DIK="^PRCA(430,"_BILLIEN_",18," D ENALL^DIK ;,DA(1)=HDATE
 . S $P(^PRCA(430,BILLIEN,18,0),U,3)=$O(^PRCA(430,BILLIEN,18,"A"),-1)
 . ;
 . D STOPFILE ; resets STOP TCSP REFERRAL FLAG 
 . D LOGBULTN ; logs data into Bulletin
 Q  ;UPDREJ
 ;
STOPFILE ;set stop referral data in file 430
 N B0,DEBTOR,BTRNNUM
 S B0=$G(^PRCA(430,BILLIEN,0))
 S $P(^PRCA(430,BILLIEN,15),U,7,10)="1^"_RUNDT_U_"R"_U_$G(COMMENT)
 I RTYP=1 D  Q
 .I RACTN="A" K ^PRCA(430,BILLIEN,15),^(16),^PRCA(430,"TCSP",BILLIEN)
 .I RACTN="U" S $P(^PRCA(430,BILLIEN,19),U,1)="1" Q
 .I RACTN="L" D  Q    ;PRCA*4.5*336
 .. K DR I $P(^PRCA(430,BILLIEN,0),U,8)=16 S DR="151////^S X=DT;"    ;PRCA*4.5*343
 .. S DA=BILLIEN,DIE="^PRCA(430,",DR=$G(DR)_"152///@;153///@;154///@;155///@" D ^DIE K DIE,DR,DA  ;PRCA*4.5*336/343
 I RTYP="2" S DEBTOR=$P(B0,U,9) D  Q
 .I RACTN="A" K ^RCD(340,DEBTOR,7),^RCD(340,"TCSP",DEBTOR) Q
 .I RACTN="B",$G(CERRS)["3E" K ^PRCA(430,BILLIEN,15),^(16),^PRCA(430,"TCSP",BILLIEN)
 .I RACTN="L" D  Q     ;PRCA*4.5*336
 .. S DA=DEBTOR,DIE="^RCD(340,",DR="7.02///@;7.03///@;7.04///@" D ^DIE K DIE,DR,DA  ;PRCA*4.5*336/343
 .. K DR I $P(^PRCA(430,BILLIEN,0),U,8)=16 S DR="151////^S X=DT;"    ;PRCA*4.5*343
 .. S DA=BILLIEN,DIE="^PRCA(430,",DR=$G(DR)_"152///@;153///@;154///@;155///@" D ^DIE K DIE,DR,DA  ;PRCA*4.5*336/343
 .I RACTN="U" S $P(^PRCA(430,BILLIEN,19),U,2)="1" Q
 I RTYP="2A" D  Q
 .I RACTN="A" Q
 .I RACTN="U" S $P(^PRCA(430,BILLIEN,19),U,3)="1" Q
 I RTYP="2C" D  Q
 . I RACTN="A" S $P(^PRCA(430,BILLIEN,19),U,4)="1" Q
 I RTYP=3 Q
 I RTYP="5B" D  Q
 .I RACTN="U" I $D(ARTXNID(BILLIEN)) S TRNNUM=+$P(ARTXNID(BILLIEN),U,1) I TRNNUM D
 ..;N INDX 
 ..S INDX=0
 ..F  S INDX=$O(^PRCA(430,BILLIEN,17,INDX)) Q:+INDX=0  I $P($G(^PRCA(430,BILLIEN,17,INDX,0)),U,1)=TRNNUM S $P(^PRCA(430,BILLIEN,17,INDX,0),U,2)=1 S DR="151///DT",DIE="^PRCA(430,",DA=BILLIEN D ^DIE Q
 Q
 ;
RECERR(ERRCNT,ETYP,ERRDATA,RECN,RECERR) ; log TRANSMITTED FORMAT err
 S (ERRCNT,^XTMP(NMSPC,$J,"ERR",0))=$G(^XTMP(NMSPC,$J,"ERR",0))+1
 S ^XTMP(NMSPC,$J,"ERR",ERRCNT)=RECN_U_ERRDATA
 S RECERR=1
 Q  ;
LOGBULTN ; logs the bulletin records
 S ERRS=$S($E(CERRS,$L(CERRS))=",":$E(CERRS,1,$L(CERRS)-1),1:CERRS)
 S BLTNCNT=$G(BLTNCNT)+1
 S BLTNREC=$E(NAM_BLNKS,1,20)_" "_$E(SSN_BLNKS,1,10)_$E(SBILL_BLNKS,1,12)
 S BLTNREC=BLTNREC_$E(RTYP_BLNKS,1,5)_$E(RACTN_BLNKS,1,5)_$E($P(CERRS,",",1,$L(CERRS,",")-1)_BLNKS,1,26)
 ;
 S ^XTMP(NMSPC,$J,"BULTN",BLTNCNT)=BLTNREC
 S ^XTMP(NMSPC,$J,"SRC",CSRC,NAM,SBILL,BLTNCNT)=""
 Q
RJCDCONV ;Will modify code string to convert code data to linked file pointer
 N COD,CVI
 F CVI=3:1:13 S COD=$P(REC,U,CVI) D:COD'=""
 . I CVI>2,CVI<12 S COD=$O(^RC(348.5,"B",COD,0)),$P(REC,U,CVI)=COD Q
 . I CVI=12 S COD=$O(^RC(348.7,"B",COD,0)),$P(REC,U,CVI)=COD Q
 . I CVI=13 S COD=$O(^RC(348.6,"B",COD,0)),$P(REC,U,CVI)=COD
 . Q
