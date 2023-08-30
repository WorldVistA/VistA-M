IBCE837P ;EDE/JWSP - OUTPUT FOR 837 TRANSMISSION - CONTINUED ;
 ;;2.0;INTEGRATED BILLING;**718,727,743**;21-MAR-94;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
POST ;POST execute for 837, called by IBCE837A@POST
 ;FSC Work Arounds - moved from FSC to VistA
 ;
 ; WCJ;IB718v22;quit if flag is not set to do the post workarounds
 Q:$G(IBXPOSTWA)'=1
 ;WCJ;IB718;SQA
 N I
 ;TPF;EBILL-2629;IB*2.0*718v20 remove EBILL-1641 (label 3 below) because of story implementation sequence issues
 F I=1,2,6,7,9,8,10 D @I
 Q
 ;;
1 ;;IB*2.0*718;JWS;11/30/21;EBILL-1629;Incorporate FSC Override - clear PRF9 and PRF10 when there is an RX1 segment
 ;;for the same service line with a Service Date (refill)
 N X1,X2,XLN
 S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,180,X1)) Q:X1=""  S XLN=$G(^TMP("IBXDATA",$J,1,180,X1,2)) I XLN D
 . S X2=0 F  S X2=$O(^TMP("IBXDATA",$J,1,190,X2)) Q:X2=""  I XLN=$G(^TMP("IBXDATA",$J,1,190,X2,2)),$G(^TMP("IBXDATA",$J,1,190,X2,7))'="" D
 .. K ^TMP("IBXDATA",$J,1,180,X1,9)
 .. K ^TMP("IBXDATA",$J,1,180,X1,10)
 .. Q
 . Q
 Q
 ;
2 ;;IB*2.0*718;JWS;12/8/21;EBILL-1633;Incorporate FSC Override - remove all NPIs when payer is Medicare
 N IBPID,X1
 S IBPID=$G(^TMP("IBXDATA",$J,1,37,1,3))
 I IBPID="SMTX1"!(IBPID="12M61") D
 . K ^TMP("IBXDATA",$J,1,15,1,9)   ;PRV-9 : Billing Provider Primary ID
 . K ^TMP("IBXDATA",$J,1,15,1,12)  ;PRV-12 : Billing Provider Primary ID Qualifier
 . K ^TMP("IBXDATA",$J,1,57,1,5)   ;SUB2-5 : Lab/Facility Primary ID Qualifier
 . K ^TMP("IBXDATA",$J,1,57,1,6)   ;SUB2-6 : Lab/Facility Primary ID
 . K ^TMP("IBXDATA",$J,1,97,1,2)   ;OPR1-2 : Attending Prov Primary ID Qualifier
 . K ^TMP("IBXDATA",$J,1,97,1,3)   ;OPR1-3 : Attending Prov Primary ID
 . K ^TMP("IBXDATA",$J,1,97,1,5)   ;OPR1-5 : Other Operating Prov Primary ID Qualifier
 . K ^TMP("IBXDATA",$J,1,97,1,6)   ;OPR1-6 : Other Operating Provider Primary ID
 . K ^TMP("IBXDATA",$J,1,97,1,8)   ;OPR1-8 : Operating Phy Primary ID Qualifier
 . K ^TMP("IBXDATA",$J,1,97,1,9)   ;OPR1-9 : Operating Phy Primary ID
 . K ^TMP("IBXDATA",$J,1,97,1,11)  ;OPR1-11 : Referring Prov Primary ID Qualifier
 . K ^TMP("IBXDATA",$J,1,97,1,12)  ;OPR1-12 : Referring Provider Primary ID
 . K ^TMP("IBXDATA",$J,1,103,1,6)  ;OPR7-6 : Supervising Prov Primary ID Qualifier
 . K ^TMP("IBXDATA",$J,1,103,1,7)  ;OPR7-7 : Supervising Provider Primary ID
 . K ^TMP("IBXDATA",$J,1,104.2,1,8)  ;OPR9-8 : Rendering Provider Primary ID Qualifier
 . K ^TMP("IBXDATA",$J,1,104.2,1,9)  ;OPR9-9 : Rendering Provider Primary ID
 . ;;K ^TMP("IBXDATA",$J,1,104.6,1,8)  ;Asst Surgeon Primary ID Qualifier
 . ;;K ^TMP("IBXDATA",$J,1,104.6,1,9)  ;Asst Surgeon Primary ID
 . S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,192,X1)) Q:X1=""  D
 .. K ^TMP("IBXDATA",$J,1,192,X1,8)  ;LOPE-8 : Operating Physician Primary ID Qualifier
 .. K ^TMP("IBXDATA",$J,1,192,X1,9)  ;LOPE-9 : Operating Physician Primary ID
 . S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,193,X1)) Q:X1=""  D
 .. K ^TMP("IBXDATA",$J,1,193,X1,8)  ;LOP1-8 : Other Operating Provider Primary ID Qualifier
 .. K ^TMP("IBXDATA",$J,1,193,X1,9)  ;LOP1-9 : Other Operating Provider Primary ID
 . S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,193.3,X1)) Q:X1=""  D 
 .. K ^TMP("IBXDATA",$J,1,193.3,X1,8)  ;LREN-8 : Rendering Provider Primary ID Qualifier
 .. K ^TMP("IBXDATA",$J,1,193.3,X1,9)  ;LREN-9 : Rendering Provider Primary ID
 . S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,193.6,X1)) Q:X1=""  D
 .. K ^TMP("IBXDATA",$J,1,193.6,X1,4)  ;LPUR-4 : Purchase Service Provider Primary ID Qualifier
 .. K ^TMP("IBXDATA",$J,1,193.6,X1,5)  ;LPUR-5 : Purchase Service Provider Primary ID
 . S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,194,X1)) Q:X1=""  D
 .. K ^TMP("IBXDATA",$J,1,194,X1,8)  ;LSUP-8 : Supervising Provider Primary ID Qualifier
 .. K ^TMP("IBXDATA",$J,1,194,X1,9)  ;LSUP-9 : Supervising Provider Primary ID
 . S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,194.3,X1)) Q:X1=""  D
 .. K ^TMP("IBXDATA",$J,1,194.3,X1,8)  ;LREF-8 : Referring Provider Primary ID Qualifier
 .. K ^TMP("IBXDATA",$J,1,194.3,X1,9)  ;LREF-9 : Referring Provider Primary ID
 .. Q
 . Q
 Q
 ;
3 ;IB*2.0*718;JWS;12/8/21;EBILL-1641;Incorporate FSC Override #3 - if PAYER PRIMARY ID (CI5-3) is not 'IPRNT' or 'PPRNT' and claim
 ;;Adjustment Group Code (LCAS-3) is 'LQ', then delete LCAS segment
 ;;ref to var IBPID (IB Payer ID)
 N IBPID,X1
 N CNT,SEQTMP  ;TPF;EBILL-2629;IB*2.0*718v20
 S CNT=0
 S IBPID=$G(^TMP("IBXDATA",$J,1,37,1,3))
 I IBPID'="IPRNT",IBPID'="PPRNT",$D(^TMP("IBXDATA",$J,1,200)) D
 . S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,200,X1)) Q:X1=""  D
 .. ;I $G(^TMP("IBXDATA",$J,1,200,X1,3))="LQ" K ^TMP("IBXDATA",$J,1,200,X1)
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,3))="LQ" K ^TMP("IBXDATA",$J,1,200,X1) Q  ;TPF;EBILL-2629;IB*2.0*718v20
 .. S CNT=CNT+1
 .. M SEQTMP(CNT)=^TMP("IBXDATA",$J,1,200,X1)
 .. Q
 . Q
 K ^TMP("IBXDATA",$J,1,200)  ;TPF;EBILL-2629;IB*2.0*718v20
 M ^TMP("IBXDATA",$J,1,200)=SEQTMP
 Q
 ;
4 ;IB*2.0*XXX;JWS;12/14/21;EBILL-1637;remove adjustment reason code (AB3) and associated amounts when not submitted on a paper Medicare
 ; secondary claim.  The AB3 value is used by HCCH for printing MRA files.  It should only appear for IPRINT claims
 N X1
 I $G(^TMP("IBXDATA",$J,1,37,1,3))="IPRNT" Q
 I '$D(^TMP("IBXDATA",$J,1,135)) Q
 S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,135,X1)) Q:X1=""  D
 . I $G(^TMP("IBXDATA",$J,1,135,X1,4))="AB3" D
 .. K ^TMP("IBXDATA",$J,1,135,X1,4),^(5),^(6)
 . I $G(^TMP("IBXDATA",$J,1,135,X1,7))="AB3" D
 .. K ^TMP("IBXDATA",$J,1,135,X1,7),^(8),^(9)
 . I $G(^TMP("IBXDATA",$J,1,135,X1,10))="AB3" D
 .. K ^TMP("IBXDATA",$J,1,135,X1,10),^(11),^(12)
 . I $G(^TMP("IBXDATA",$J,1,135,X1,13))="AB3" D
 .. K ^TMP("IBXDATA",$J,1,135,X1,13),^(14),^(15)
 . I $G(^TMP("IBXDATA",$J,1,135,X1,16))="AB3" D
 .. K ^TMP("IBXDATA",$J,1,135,X1,16),^(17),^(18)
 . I $G(^TMP("IBXDATA",$J,1,135,X1,19))="AB3" D
 .. K ^TMP("IBXDATA",$J,1,135,X1,19),^(20),^(21)
 . I $G(^TMP("IBXDATA",$J,1,135,X1,4))="",$G(^(7))="",$G(^(10))="",$G(^(13))="",$G(^(16))="",$G(^(19))="" K ^TMP("IBXDATA",$J,1,135,X1) Q
 . I $G(^TMP("IBXDATA",$J,1,135,X1,4))="" D
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,7))'="" D 41(4,7) Q
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,10))'="" D 41(4,10) Q
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,13))'="" D 41(4,13) Q
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,16))'="" D 41(4,16) Q
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,19))'="" D 41(4,19) Q
 . I $G(^TMP("IBXDATA",$J,1,135,X1,7))="" D
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,10))'="" D 41(7,10) Q
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,13))'="" D 41(7,13) Q
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,16))'="" D 41(7,16) Q
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,19))'="" D 41(7,19) Q
 . I $G(^TMP("IBXDATA",$J,1,135,X1,10))="" D
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,13))'="" D 41(10,13) Q
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,16))'="" D 41(10,16) Q
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,19))'="" D 41(10,19) Q
 . I $G(^TMP("IBXDATA",$J,1,135,X1,13))="" D
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,16))'="" D 41(13,16) Q
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,19))'="" D 41(13,19) Q
 . I $G(^TMP("IBXDATA",$J,1,135,X1,16))="" D
 .. I $G(^TMP("IBXDATA",$J,1,135,X1,19))'="" D 41(16,19) Q
 . Q
 Q 
 ;  
41(XT,XF) ;shuffle adjustment reason codes
 S ^(XT)=^TMP("IBXDATA",$J,1,135,X1,XF),^(XT+1)=$G(^(XF+1)),^(XT+2)=$G(^(XF+2)) K ^(XF+1),^(XF+2),^(XF+3)
 Q
 ;
5 ;IB*2.0*XXX;JWS;12/14/21;EBILL-1645;remove adjustment reason code (AAA) and associated amounts when not submitted on a paper Medicare
 ; secondary claim.  The AAA value is used by HCCH for printing MRA files.  It should only appear for IPRINT and PPRNT IDs
 N X1
 I $G(^TMP("IBXDATA",$J,1,37,1,3))="IPRNT"!($G(^(3))="PPRNT") Q
 I '$D(^TMP("IBXDATA",$J,1,200)) Q
 S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,200,X1)) Q:X1=""  D
 . I $G(^TMP("IBXDATA",$J,1,200,X1,4))="AAA" D
 .. K ^TMP("IBXDATA",$J,1,200,X1,4),^(5),^(6)
 . I $G(^TMP("IBXDATA",$J,1,200,X1,7))="AAA" D
 .. K ^TMP("IBXDATA",$J,1,200,X1,7),^(8),^(9)
 . I $G(^TMP("IBXDATA",$J,1,200,X1,10))="AAA" D
 .. K ^TMP("IBXDATA",$J,1,200,X1,10),^(11),^(12)
 . I $G(^TMP("IBXDATA",$J,1,200,X1,13))="AAA" D
 .. K ^TMP("IBXDATA",$J,1,200,X1,13),^(14),^(15)
 . I $G(^TMP("IBXDATA",$J,1,200,X1,16))="AAA" D
 .. K ^TMP("IBXDATA",$J,1,200,X1,16),^(17),^(18)
 . I $G(^TMP("IBXDATA",$J,1,200,X1,19))="AAA" D
 .. K ^TMP("IBXDATA",$J,1,200,X1,19),^(20),^(21)
 . I $G(^TMP("IBXDATA",$J,1,200,X1,4))="",$G(^(7))="",$G(^(10))="",$G(^(13))="",$G(^(16))="",$G(^(19))="" K ^TMP("IBXDATA",$J,1,200,X1) Q
 . I $G(^TMP("IBXDATA",$J,1,200,X1,4))="" D
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,7))'="" D 51(4,7) Q
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,10))'="" D 51(4,10) Q
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,13))'="" D 51(4,13) Q
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,16))'="" D 51(4,16) Q
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,19))'="" D 51(4,19) Q
 . I $G(^TMP("IBXDATA",$J,1,200,X1,7))="" D
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,10))'="" D 51(7,10) Q
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,13))'="" D 51(7,13) Q
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,16))'="" D 51(7,16) Q
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,19))'="" D 51(7,19) Q
 . I $G(^TMP("IBXDATA",$J,1,200,X1,10))="" D
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,13))'="" D 51(10,13) Q
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,16))'="" D 51(10,16) Q
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,19))'="" D 51(10,19) Q
 . I $G(^TMP("IBXDATA",$J,1,200,X1,13))="" D
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,16))'="" D 51(13,16) Q
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,19))'="" D 51(13,19) Q
 . I $G(^TMP("IBXDATA",$J,1,200,X1,16))="" D
 .. I $G(^TMP("IBXDATA",$J,1,200,X1,19))'="" D 51(16,19) Q
 . Q
 Q 
 ;  
51(XT,XF) ;shuffle adjustment reason codes
 S ^(XT)=^TMP("IBXDATA",$J,1,200,X1,XF),^(XT+1)=$G(^(XF+1)),^(XT+2)=$G(^(XF+2)) K ^(XF+1),^(XF+2),^(XF+3)
 Q
 ;
6 ;IB*2.0*727;JWS;12/14/21;EBILL-1649;remove Secondary ID and Qualifier when Second ID Qualifier = '2U' and payer is Medicare
 ;
 N X1
 S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,114,X1)) Q:X1=""  D
 . ;JWS;5/9/22;added payer ID 'SMDEV' (Medicare DME claims) to below list
 . I $G(^TMP("IBXDATA",$J,1,114,X1,4))="12M61"!($G(^(4))="SMTX1")!($G(^(4))="SMDEV") D
 .. I $G(^TMP("IBXDATA",$J,1,114,X1,5))="2U" K ^TMP("IBXDATA",$J,1,114,X1,5),^(6)
 .. I $G(^TMP("IBXDATA",$J,1,114,X1,7))="2U" K ^TMP("IBXDATA",$J,1,114,X1,7),^(8)
 .. Q
 . Q
 Q
 ;
7 ;IB*2.0*727;JWS;5/4/22;EBILL-1657;remove provider secondary ID and qualifer if Dest Payer is Medicare Part-A
 ; removes valid 5010 provider IDs that are not allowed by Medicare
 N X1,X2,I
 S X1=0
 I $G(^TMP("IBXDATA",$J,1,37,1,3))="12M61" D  ;Medicare Part A payer ID (changeHealth care)
 . F I=2,4,6,8 D 71(98,1,I) D  ;seq=98 : OPR2 attending provider sec id
 . D 72(98,1,2)
 . F I=2,4,6,8 D 71(99,1,I)  ;seq=99 : OPR3 operating provider sec id
 . D 72(99,1,2)
 . F I=2,4,6,8 D 71(100,1,I)  ;seq=100 : OPR4 other operating provider sec id
 . D 72(100,1,2)
 . F I=2,4,6,8 D 71(104.4,1,I)  ;seq=104.4 : OPRA rendering provider sec id
 . D 72(104.4,1,2)
 . F I=2,4,6 D 71(101,1,I)  ;seq=101 : OPR5 referring provider sec id
 . D 72(101,1,2)
 . F I=7:1:12 K ^TMP("IBXDATA",$J,1,57,1,I)  ;seq=57 : SUB2 service facility data
 . S X2=0 F  S X2=$O(^TMP("IBXDATA",$J,1,192,X2)) Q:X2=""  D  ;seq=192 : LOPE line operating physician data
 .. F I=10,12,14 D 71(192,X2,I)
 .. D 72(192,X2,10)
 . S X2=0 F  S X2=$O(^TMP("IBXDATA",$J,1,193,X2)) Q:X2=""  D  ;seq=193 : LOP1 line other operating physician data
 .. F I=10,12,14 D 71(193,X2,I)
 .. D 72(193,X2,10)
 . S X2=0 F  S X2=$O(^TMP("IBXDATA",$J,1,193.3,X2)) Q:X2=""  D  ;seq=193.3 : LREN line rendering provider data
 .. F I=10,12,14 D 71(193.3,X2,I)
 .. D 72(193.3,X2,10)
 . S X2=0 F  S X2=$O(^TMP("IBXDATA",$J,1,194.3,X2)) Q:X2=""  D  ;seq=194.3 : LREF line referring provider data
 .. F I=10,12,14 D 71(194.3,X2,I)
 .. D 72(194.3,X2,10)
 . Q
 Q
 ;
71(SEQ,REC,FLD) ;function to delete entries
 I $G(^TMP("IBXDATA",$J,1,SEQ,REC,FLD))'="1G" K ^TMP("IBXDATA",$J,1,SEQ,REC,FLD),^(FLD+1)
 Q
 ;
72(SEQ,REC,FLD) ;reshuffle entries to prevent any FSC issues; should not be necessary, but just incase it is.
 I FLD=2 D
 . I $G(^TMP("IBXDATA",$J,1,SEQ,REC,2))="" D
 .. I $G(^TMP("IBXDATA",$J,1,SEQ,REC,4))'="" S ^(2)=^(4),^(3)=^(5) K ^(4),^(5) Q
 .. I $G(^TMP("IBXDATA",$J,1,SEQ,REC,6))'="" S ^(2)=^(6),^(3)=^(7) K ^(6),^(7) Q
 .. I $G(^TMP("IBXDATA",$J,1,SEQ,REC,8))'="" S ^(2)=^(8),^(3)=^(9) K ^(8),^(9) Q
 . I $G(^TMP("IBXDATA",$J,1,SEQ,REC,4))="" D
 .. I $G(^TMP("IBXDATA",$J,1,SEQ,REC,6))'="" S ^(4)=^(6),^(5)=^(7) K ^(6),^(7) Q
 .. I $G(^TMP("IBXDATA",$J,1,SEQ,REC,8))'="" S ^(4)=^(8),^(5)=^(9) K ^(8),^(9) Q
 . I SEQ=101 Q
 . I $G(^TMP("IBXDATA",$J,1,SEQ,REC,6))="" D
 .. I $G(^TMP("IBXDATA",$J,1,SEQ,REC,8))'="" S ^(6)=^(8),^(7)=^(9) K ^(8),^(9) Q
 I FLD=10 D
 . I $G(^TMP("IBXDATA",$J,1,SEQ,REC,10))="" D
 .. I $G(^TMP("IBXDATA",$J,1,SEQ,REC,12))'="" S ^(10)=^(12),^(11)=^(13) K ^(12),^(13) Q
 .. I $G(^TMP("IBXDATA",$J,1,SEQ,REC,14))'="" S ^(10)=^(14),^(11)=^(15) K ^(14),^(15) Q
 . I $G(^TMP("IBXDATA",$J,1,SEQ,REC,12))="" D
 .. I $G(^TMP("IBXDATA",$J,1,SEQ,REC,14))'="" S ^(12)=^(14),^(13)=^(15) K ^(14),^(15) Q
 Q
 ;
8 ;TPF;IB*2.0*727;EBILL-1665;6/23/2022;Remove Remaining Patient Liability Amount and Other Payer Check Date when the Other Payer is a Primary or Secondary Payer
 N X1,X2,LCOBPRIM,LCOBSEC
 Q:'$D(^TMP("IBXDATA",$J,1,195))  ;NO LCOBs FOR THIS CLAIM
 ;GO THROUGH THE LCOB ENTRIES AND SEE IF ANY APPLY TO THESE SPECS. PROCESS ONLY ONE PRIMARY AND ONE SECONDARY LCOB
 S (LCOBPRIM,LCOBSEC)=0
 S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,195,X1)) Q:X1=""  D  Q:$G(LCOBPRIM)&(LCOBSEC)  ;ONCE ONE SECONDARY AND ONE PRIMARY HAS BEEN PROCESSED QUIT
 .;
 .Q:$G(^TMP("IBXDATA",$J,1,195,X1,18))="T"  ;DO NOT PROCESS TERTIARY LCOBS
 .Q:$G(LCOBPRIM)&($G(^TMP("IBXDATA",$J,1,195,X1,18))="P")  ;ALREADY PROCESSED A PRIMARY.
 .Q:$G(LCOBSEC)&($G(^TMP("IBXDATA",$J,1,195,X1,18))="S")   ;ALREADY PROCESSED A SECONDARY.
 .S LCOBPRIM=$G(^TMP("IBXDATA",$J,1,195,X1,18))="P"
 .S LCOBSEC=$G(^TMP("IBXDATA",$J,1,195,X1,18))="S"
 .;
 .I LCOBPRIM D
 ..S X2=0 F  S X2=$O(^TMP("IBXDATA",$J,1,107,X2)) Q:X2=""  D
 ...I $G(^TMP("IBXDATA",$J,1,107,X2,2))="P" D  Q
 ....S ^TMP("IBXDATA",$J,1,107,X2,6)=""
 ....S ^TMP("IBXDATA",$J,1,107,X2,7)=""
 ..;
 ..S X2=0 F  S X2=$O(^TMP("IBXDATA",$J,1,112,X2)) Q:X2=""  D
 ...I $G(^TMP("IBXDATA",$J,1,112,X2,2))="P" D  Q
 ....S ^TMP("IBXDATA",$J,1,112,X2,8)=""
 ....S ^TMP("IBXDATA",$J,1,112,X2,9)=""
 .;
 .I LCOBSEC D
 ..S X2=0 F  S X2=$O(^TMP("IBXDATA",$J,1,107,X2)) Q:X2=""  D
 ...I $G(^TMP("IBXDATA",$J,1,107,X2,2))="S" D  Q
 ....S ^TMP("IBXDATA",$J,1,107,X2,6)=""
 ....S ^TMP("IBXDATA",$J,1,107,X2,7)=""
 ..;
 ..S X2=0 F  S X2=$O(^TMP("IBXDATA",$J,1,112,X2)) Q:X2=""  D
 ...I $G(^TMP("IBXDATA",$J,1,112,X2,2))="S" D  Q
 ....S ^TMP("IBXDATA",$J,1,112,X2,8)=""
 ....S ^TMP("IBXDATA",$J,1,112,X2,9)=""
 Q
 ;
9 ; IB*2.0*727;JWS;5/4/22;EBILL-2602;remove or change provider secondary ID and qualifier if Dest Payer is Medicare Part B
 N I,X1
 I $G(^TMP("IBXDATA",$J,1,37,1,3))="SMTX1" D  ;Medicare Part B payer ID (changeHealth care)
 . I $G(^TMP("IBXDATA",$J,1,28,1,6))="1C" S ^(6)="G2"  ;seq=28 : CI1A billing provider secondary id data
 . F I=2,4,6 I $G(^TMP("IBXDATA",$J,1,101,1,I))'="1G",$G(^(I))'="0B" K ^(I),^(I+1)  ;seq=101 : OPR5 referring provider secondary id
 . F I=2,4,6,8 I $G(^TMP("IBXDATA",$J,1,104.4,1,I))="1C" S ^(I)="G2"  ;seq=104.4 : OPRA rendering provider sec id
 . F I=7:1:12 K ^TMP("IBXDATA",$J,1,57,1,I)  ;seq=57 : SUB2 service facility data
 .;F I=2,4,6,8 I $G(^TMP("IBXDATA",$J,1,104,1,I))="EI" S ^(I)="G2"  ;seq=104 : OPR8 supervising provider secondary id data ; WCJ EBILL-3260;IB743
 . F I=2,4,6,8 I $G(^TMP("IBXDATA",$J,1,104,1,I))="EI" K ^(I),^(I+1)  ;seq=104 : OPR8 supervising provider secondary id data ; WCJ EBILL-3260;IB743
 . S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,193.6,X1)) Q:X1=""  D  ;seq=193.6 : LPUR line purchase service provider data
 .. ;JWS;8/15/22;IB*2.0*727v12;FSC workaround documentation was incorrect - Set LPUR-6 = "1G" and LPUR-7 = 'VAD001'
 .. ;JWS;10/19/22;EBILL-2979;IB*2.0*727v14;should only set if LPUR line exists
 .. I $G(^TMP("IBXDATA",$J,1,193.6,X1,2))'="" D
 ... S ^TMP("IBXDATA",$J,1,193.6,X1,6)="1G"
 ... S ^TMP("IBXDATA",$J,1,193.6,X1,7)="VAD001"
 . S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,194,X1)) Q:X1=""  D  ;seq=194 : LSUP line supervising provider data
 .. F I=10,12,14 I $G(^TMP("IBXDATA",$J,1,194,X1,I))="G2" K ^(I),^(I+1)
 . S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,194.3,X1)) Q:X1=""  D  ;seq=194.3 : LREF line referring provider data
 .. ;8/1/22;EBILL-2711;IB*270*727v10;JWS;was missing a not (') condition, so remove ID and qualifier if NOT = '1G'
 .. F I=10,12,14 I $G(^TMP("IBXDATA",$J,1,194.3,X1,I))'="1G" K ^(I),^(I+1)
 Q
 ;
10 ;IB*2.0*727;JWS;7/29/22;EBILL-1653;group DCx records by Diagnosis Type (DCx-3); ABK (BK) 1st, ABF (BF) 2nd grp, ABN (BN) last
 ; only perform this check/re-order for Institutional Claims
 I $$FT^IBCEF(IBXIEN)'=3 Q
 ; if no DCx records, quit
 I '$D(^TMP("IBXDATA",$J,1,90)) Q
 ; X1 is array of record 90 field values as entered by user
 ; X2 is entry counter
 ; X3 is array of Diagnosis Types by original line number
 ; IBDT is the Diagnosis Type found in DCx-3 (Code List Qualifier Code, i.e. ABK, ABF, ABN)
 N X1,X2,X3,IBDT,XCT
 M X1=^TMP("IBXDATA",$J,1,90)
 S X2=1 F  S X2=$O(X1(X2)) Q:X2=""  S X3(X1(X2,3),X2)=""
 K ^TMP("IBXDATA",$J,1,90)
 M ^TMP("IBXDATA",$J,1,90,1)=X1(1)
 ; JWS;9/12/22;Changed to reverse $O because FSC wants External Injury codes before Other Diag codes
 S IBDT="",XCT=1 F  S IBDT=$O(X3(IBDT),-1) Q:IBDT=""  S X2="" F  S X2=$O(X3(IBDT,X2)) Q:X2=""  S XCT=XCT+1,X1(X2,1)="DC"_XCT_" " M ^TMP("IBXDATA",$J,1,90,XCT)=X1(X2)
 Q
 ; 
