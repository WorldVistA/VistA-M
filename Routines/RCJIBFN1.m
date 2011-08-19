RCJIBFN1 ;WASH-ISC@ALTOONA,PA/NYB-FUNC. CALLS FOR JOINT IB/AR ;10/5/95  8:19 AM ;8/8/95  12:18 PM
V ;;4.5;Accounts Receivable;**15**;Mar 20, 1995
N0(RCTRNO) ;Pass IFN for 433 - Returns Pieces of 0 node of 433 where pieces are
 ;$P1=Transaction Number,$P2=Date Calm Done,$P3=Processed By (pointer
 ;value to 200),$P4=Incomplete Transaction Flag
 N IFLG,N0,PBY,STRG
 I '$G(RCTRNO) S STRG="" G N0Q
 S N0=$G(^PRCA(433,RCTRNO,0)) I $G(N0)']"" S STRG="" G N0Q
 S PBY=$P($G(N0),"^",9)
 S IFLG=$P($G(N0),"^",10)
 S IFLG=$S(IFLG="":"N/A",IFLG=0:"TRANSACTION COMPLETE",1:"INCOMPLETE TRANSACTION")
 S STRG=$P($G(N0),"^")_"^"_$P($G(N0),"^",5)_"^"_PBY_"^"_IFLG
N0Q Q STRG
N1(RCTRNO) ;Pass IFN for 433 - Returns Pieces of 1 node of 433 where pieces are
 ;$P1=Transaction Date,$P2=Transaction Type(pointer to value to 430.3)
 ;$P3=Receipt #,$P4=Adjustment Number,$P5=Transaction Amount
 ;$P6=Termination Reason,$P7=Date Entered
 N N1,STRG,TREA,TRTY
 I '$G(RCTRNO) S STRG="" G N1Q
 S N1=$G(^PRCA(433,RCTRNO,1)) I $G(N1)']"" S STRG="" G N1Q
 S TRTY=$P($G(N1),"^",2),TREA=$P($G(N1),"^",7)
 S TREA=$S(TREA=9:"OTHERS",TREA=8:"INCORRECT BILLING",TREA=7:"INABILITY TO COLLECT",TREA=6:"DEBT UNDER $25",TREA=5:"COMPROMISED",TREA=4:"WAIVED",TREA=3:"INABILITY TO LOCATE",TREA=2:"BANKRUPCY",TREA=1:"DEBTOR'S DEATH",1:"")
 S STRG=$P($G(N1),"^")_"^"_TRTY_"^"_$P($G(N1),"^",3)_"^"_$P($G(N1),"^",4)_"^"_$P($G(N1),"^",5)_"^"_TREA_"^"_$P($G(N1),"^",9)
N1Q Q STRG
N2(RCTRNO) ;Pass IFN for 433 - Returns Pieces of 2 node of 433 where pieces are
 ;$P1=IRS Loc.Cost,$P2=Credit Rep. Cost,$P3=DMV Loc. Cost
 ;$P4=Consumer Rep. Agency Cost,$P5=Marsharll Fee,$P6=Court Cost
 ;$P7=Interest Cost,$P8=Administrative Cost
 N N2,STRG
 I '$G(RCTRNO) S STRG="" G N2Q
 S N2=$G(^PRCA(433,RCTRNO,2)) I $G(N2)']"" S STRG="" G N2Q
 S STRG=$P(N2,"^")_"^"_$P(N2,"^",2)_"^"_$P(N2,"^",3)_"^"_$P(N2,"^",4)_"^"_$P(N2,"^",5)_"^"_$P(N2,"^",6)_"^"_$P(N2,"^",7)_"^"_$P(N2,"^",8)
N2Q Q STRG
N3(RCTRNO) ;Pass IFN for 433 - Returns Pieces of 3 node of 433 where pieces are
 ;$P1=Principal Collected,$P2=Interest Collected,$P3=Admin. Collected
 ;$P4=Marshall Fee Collected,$P5=Court Cost Collected,$P6=Total Collected for this transaction number
 N I,N3,STRG,TCOL
 I '$G(RCTRNO) S STRG="" G N3Q
 S TCOL=0,N3=$G(^PRCA(433,RCTRNO,3)) I $G(N3)']"" S STRG="" G N3Q
 F I=1:1:5 S TCOL=TCOL+$P($G(N3),"^",I)
 S STRG=+$P($G(N3),"^")_"^"_+$P($G(N3),"^",2)_"^"_+$P($G(N3),"^",3)_"^"_+$P($G(N3),"^",4)_"^"_+$P($G(N3),"^",5)_"^"_TCOL
N3Q Q STRG
N4(RCTRNO) ;Returns Pieces of 4 node multiple of 433 where pieces are
 ;Caller must kill array - Fiscal Year Multiple
 ;$P1=Fiscal Year,$P2=Principal Amount,$P3=Pat Reference #
 ;$P4=Transaction Amount
 N I,N4,PAT
 I '$G(RCTRNO) S STRG="" G N4Q
 S I=0 F  S I=$O(^PRCA(433,RCTRNO,4,I)) Q:I'>0  D
    .S N4=$G(^PRCA(433,RCTRNO,4,I,0)) I $G(N4)']"" Q
    .S PAT=$P($G(^PRCA(433,RCTRNO,0)),"^",2)
    .S PAT=$P($G(^PRCA(430,PAT,0)),"^")
    .S STRG(I)=$P($G(N4),"^")_"^"_+$P(N4,"^",2)_"^"_$G(PAT)_"^"_+$P(N4,"^",5)
    .Q
N4Q Q
N5(RCTRNO) ;Pass IFN for 433 - Returns Pieces of 5 node of 433 where pieces are
 ;$P1=Breif Comment,$P2=Follow-up Date
 N N5,STRG
 I '$G(RCTRNO) S STRG="" G N5Q
 S N5=$G(^PRCA(433,RCTRNO,5)) I $G(N5)']"" S STRG="" G N5Q
 S STRG=$P($G(N5),"^",2)_"^"_$P($G(N5),"^",3)
N5Q Q STRG
N7(RCTRNO) ;Pass IFN for 433-Returns 7 node multiple for comments in COM array
 ;Caller must kill local array
 N I
 I '$G(RCTRNO) G N7Q
 S I=0 F  S I=$O(^PRCA(433,RCTRNO,7,I)) Q:I'>0  D
    .S COM(I)=$G(^PRCA(433,RCTRNO,7,I,0))
    .Q
N7Q Q
N8(RCTRNO) ;Pass IFN for 433 - Returns Pieces of 8 node of 433 where pieces are
 ;$P1=Principle Balance,$P2=Interest Balance,$P3=Admin. Balance
 ;$P4=Marshal Fee,$P5=Court Cost,$P6=Total Balance after transaction
 ;$P7=Transaction Comment
 N I,N8,STRG,TBAL
 I '$G(RCTRNO) S STRG="" G N8Q
 S TBAL=0,N8=$G(^PRCA(433,RCTRNO,8)) I $G(N8)']"" S STRG="" G N8Q
 F I=1:1:5 S TBAL=TBAL+$P($G(N8),"^",I)
 S STRG=+$P(N8,"^")_"^"_+$P(N8,"^",2)_"^"_+$P(N8,"^",3)_"^"_+$P(N8,"^",4)_"^"_+$P(N8,"^",5)_"^"_+TBAL_"^"_$P($G(N8),"^",6)
N8Q Q STRG
