IBCE837P ;EDE/JWSP - OUTPUT FOR 837 TRANSMISSION - CONTINUED ;
 ;;2.0;INTEGRATED BILLING;**718**;21-MAR-94;Build 73
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
POST ;POST execute for 837, called by IBCE837A@POST
 ;FSC Work Arounds - moved from FSC to VistA
 ;
 Q:$G(IBXPOSTWA)'=1   ; WCJ;IB718v22;quit if flag is not set to do the post workarounds
 N I   ;WCJ;IB718;SQA
 ;F I=1,2,3 D @I  ;TPF;EBILL-2629;IB*2.0*718v20 remove EBILL-1641 because of story implementation sequence issues
 F I=1,2 D @I
 Q
 ;;
1 ;;IB*2.0*718;JWS;11/30/21;EBILL-1629;Incorporate FSC Override #1 - clear PRF9 and PRF10 when there is an RX1 segment
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
2 ;;IB*2.0*718;JWS;12/8/21;EBILL-1633;Incorporate FSC Override #2 - remove all NPIs when payer is Medicare
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
4 ;IB*2.0*XXX;JWS;12/14/21;EBILL-XXX;remove adjustment reason code (AB3) and associated amounts when not submitted on a paper Medicare
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
5 ;IB*2.0*XXX;JWS;12/14/21;EBILL-XXX;remove adjustment reason code (AAA) and associated amounts when not submitted on a paper Medicare
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
6 ;IB*2.0*XXX;JWS;12/14/21;EBILL-XXX;remove Secondary ID and Qualifier when Second ID Qualifier = '2U' and payer is Medicare
 ;
 N X1
 S X1=0 F  S X1=$O(^TMP("IBXDATA",$J,1,114,X1)) Q:X1=""  D
 . I $G(^TMP("IBXDATA",$J,1,114,X1,4))="12M61"!($G(^(4)))="SMTX1" D
 .. I $G(^TMP("IBXDATA",$J,1,114,X1,5))="2U" K ^TMP("IBXDATA",$J,1,114,X1,5),^(6)
 .. I $G(^TMP("IBXDATA",$J,1,114,X1,7))="2U" K ^TMP("IBXDATA",$J,1,114,X1,7),^(8)
 .. Q
 . Q
 Q
 ;
