IBCEMSR3  ;BI/ALB - non-MRA PRODUCTIVITY REPORT ;02/14/11
 ;;2.0;INTEGRATED BILLING;**447**;21-MAR-94;Build 80
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
COLLECT2  ; Accumulate information for the Detailed Report
 Q:$D(^TMP($J,"IBCEMSR2","FFORM",IBIFN))                ; Count each CLAIM/BILL only once
 S ^TMP($J,"IBCEMSR2","FFORM",IBIFN)=""                 ; Record CLAIM/BILL use
 I IBOB(.21)="P" D                                      ; Primary
 . I $$PROCSSED^IBCEMSR5(IBIFN) D                       ;   Processed 
 .. D FFORM("FPA",1)                                    ;     Total Number of Processes Requests
 .. I ((IBOB(35)=2)!(IBOB(35)=3)) D                     ;       Auto-processed to secondary
 ... D FFORM("FPAA",1)                                  ;         Total Number auto-processed to secondary
 ... I IBOB(35)=2 D                                     ;           Printed Locally
 .... D FFORM("FPAAA",1)                                ;             Number Printed Locally
 .... D FFORM("FPAAA1",$G(IBOBS(201))-$G(IBOBS(218)))   ;               Total Secondary Charges
 ... I IBOB(35)=3 D                                     ;           Transmitted
 .... D FFORM("FPAAB",1)                                ;             Number Transmitted
 .... D FFORM("FPAAB1",$G(IBOBS(201))-$G(IBOBS(218)))   ;               Total Secondary Charges
 .. I ((IBOB(35)=1)!(IBOB(35)=4)) D                     ;       Sent to Worklist
 ... D FFORM("FPAB",1)                                  ;         Total Number Sent to Worklist
 ... I IBOB(38)="PC" D                                  ;           Processed from worklist
 .... D FFORM("FPABA",1)                                ;             Number processed from worklist
 .... D FFORM("FPABA1",$G(IBOBS(201))-$G(IBOBS(218)))   ;               Total secondary charges
 ... I IBOB(38)="RM" D                                  ;           Removed from worklist
 .... D FFORM("FPABB",1)                                ;             Number removed from worklist
 .... D FFORM("FPABB1",$$TOT^IBCECOB2(IBIFN,1))         ;               Total secondary charges
 ... I IBOB(38)="CA" D                                  ;           Cancelled from worklist
 .... D FFORM("FPABC",1)                                ;             Number cancelled from worklist
 .... D FFORM("FPABC1",$$TOT^IBCECOB2(IBIFN,1))         ;               Total secondary charges
 ... I IBOB(35)=1 D                                     ;           Still on worklist
 .... D FFORM("FPABD",1)                                ;             Number still on worklist
 .... D FFORM("FPABD1",$$TOT^IBCECOB2(IBIFN,1))         ;               Total secondary charges
 .. I $$NOSUB^IBCEMSR5(IBIFN),$P($$BILL^RCJIBFN2(IBIFN),U,2)=22 D  ;  Number without secondary
 ... D FFORM("FPWOS",1)                                 ;         Total number w/out secondary
 .. ;DBIA 1452  ;  Number of EEOBs not collected/closed
 .. I '((IBOB(35)=1)!(IBOB(35)=4)),$$NOSUB^IBCEMSR5(IBIFN),$P($$BILL^RCJIBFN2(IBIFN),U,2)'=22 D
 ... D FFORM("FPNCC",1)                                 ;         Total Number of EEOBs not collected/closed
 . I $$DENIED^IBCEMSR5(IBIFN) D                         ;   Denied
 .. D FFORM("FPB",1)                                    ;     Total Number of Denied Requests
 .. I IBOB(35)=1 D                                      ;           Still on worklist
 ... D SFORM("FPSOW",1)                                 ;             Number still on worklist
 .. I IBOB(38)="PC" D                                   ;           Processed from worklist
 ... D FFORM("FPBXD",1)                                 ;             Number processed from worklist
 .. I IBOB(38)="RM" D                                   ;           Removed from worklist
 ... D FFORM("FPBXA",1)                                 ;             Number removed from worklist
 .. I IBOB(38)="CA" D                                   ;           Cancelled from worklist
 ... D FFORM("FPBXE",1)                                 ;             Number cancelled from worklist
 .. I IBOB(38)="CR" D                                   ;           Corrected from worklist
 ... D FFORM("FPBXB",1)                                 ;             Number corrected from worklist
 ... D FFORM("FPBXB1",IBOB(201))                        ;               Total primary charges
 .. I IBOB(38)="CL" D                                   ;           Cloned from worklist
 ... D FFORM("FPBXC",1)                                 ;             Number cloned from worklist
 ... D FFORM("FPBXC1",IBOB(201))                        ;               Total primary charges
 ;                                                      ;
 I IBOB(.21)="S" D                                      ; Secondary
 . I $$PROCSSED^IBCEMSR5(IBIFN) D                       ;   Processed 
 .. D FFORM("FSA",1)                                    ;     Total Number of Processes Requests
 .. I ((IBOB(35)=2)!(IBOB(35)=3)) D                     ;       Auto-processed to tertiary
 ... D FFORM("FSAA",1)                                  ;         Total Number auto-processed to tertiary
 ... I IBOB(35)=2 D                                     ;           Printed Locally
 .... D FFORM("FSAAA",1)                                ;             Number Printed Locally
 .... D FFORM("FSAAA1",$G(IBOBT(201))-$G(IBOBT(218))-$G(IBOBT(219))) ;  Total tertiary Charges
 ... I IBOB(35)=3 D                                     ;           Transmitted
 .... D FFORM("FSAAB",1)                                ;             Number Transmitted
 .... D FFORM("FSAAB1",$G(IBOBT(201))-$G(IBOBT(218))-$G(IBOBT(219))) ;  Total tertiary Charges
 .. I ((IBOB(35)=1)!(IBOB(35)=4)) D                     ;       Sent to Worklist
 ... D FFORM("FSAB",1)                                  ;         Total Number Sent to Worklist
 ... I IBOB(38)="PC" D                                  ;           Processed from worklist
 .... D FFORM("FSABA",1)                                ;             Number processed from worklist
 .... D FFORM("FSABA1",$G(IBOBT(201))-$G(IBOBT(218))-$G(IBOBT(219)))   ;  Total secondary charges
 ... I IBOB(38)="RM" D                                  ;           Removed from worklist
 .... D FFORM("FSABB",1)                                ;             Number removed from worklist
 .... D FFORM("FSABB1",$$TOT^IBCECOB2(IBIFN,1))         ;               Total tertiary charges
 ... I IBOB(38)="CA" D                                  ;           Cancelled from worklist
 .... D FFORM("FSABC",1)                                ;             Number cancelled from worklist
 .... D FFORM("FSABC1",$$TOT^IBCECOB2(IBIFN,1))         ;               Total tertiary charges
 ... I IBOB(35)=1 D                                     ;           Still on worklist
 .... D FFORM("FSABD",1)                                ;             Number still on worklist
 .... D FFORM("FSABD1",$$TOT^IBCECOB2(IBIFN,1))         ;               Total tertiary charges
 .. I $$NOSUB^IBCEMSR5(IBIFN),$P($$BILL^RCJIBFN2(IBIFN),U,2)=22 D  ;  Number without tertiary
 ... D FFORM("FSWOT",1)                                 ;         Total number w/out tertiary
 .. ;DBIA 1452  ;  Number of EEOBs not collected/closed
 .. I '((IBOB(35)=1)!(IBOB(35)=4)),$$NOSUB^IBCEMSR5(IBIFN),$P($$BILL^RCJIBFN2(IBIFN),U,2)'=22 D
 ... D FFORM("FSNCC",1)                                 ;         Total Number of EEOBs not collected/closed
 . I $$DENIED^IBCEMSR5(IBIFN) D                         ;   Denied
 .. D FFORM("FSB",1)                                    ;     Total Number of Denied Requests
 .. I IBOB(35)=1 D                                      ;           Still on worklist
 ... D SFORM("FSSOW",1)                                 ;             Number still on worklist
 .. I IBOB(38)="PC" D                                   ;           Processed from worklist
 ... D FFORM("FSBXD",1)                                 ;             Number processed from worklist
 .. I IBOB(38)="RM" D                                   ;           Removed from worklist
 ... D FFORM("FSBXA",1)                                 ;             Number removed from worklist
 .. I IBOB(38)="CA" D                                   ;           Cancelled from worklist
 ... D FFORM("FSBXE",1)                                 ;             Number cancelled from worklist
 .. I IBOB(38)="CR" D                                   ;           Corrected from worklist
 ... D FFORM("FSBXB",1)                                 ;             Number corrected from worklist
 ... D FFORM("FSBXB1",$G(IBOBS(201))-$G(IBOBS(218)))    ;               Total tertiary charges
 .. I IBOB(38)="CL" D                                   ;           Cloned from worklist
 ... D FFORM("FSBXC",1)                                 ;             Number cloned from worklist
 ... D FFORM("FSBXC1",$G(IBOBS(201))-$G(IBOBS(218)))    ;               Total tertiary charges
 ;
 Q
 ;
FFORM(IBACCUM,IBCNTCST)  ; Detail Form Collectors
 ; IBLFTMP(IBDIV2,IBACCUM,IBFT)
 ;         |      |       |
 ;         |      |        - BILL/CLAIM FORM TYPE 2-CMS1500, 3-UB4
 ;         |       --------- ACCUMULATOR FOR COUNTS AND CHARGES
 ;          ---------------- BILL/CLAIM DEFAULT DIVISION, DICT #40.8, ^DG(40.8,)
 S IBLTMP(IBOB(.22),IBACCUM,IBOB(.19))=$G(IBLTMP(IBOB(.22),IBACCUM,IBOB(.19)))+IBCNTCST
 S IBLTMP("DIVISION",IBACCUM,IBOB(.19))=$G(IBLTMP("DIVISION",IBACCUM,IBOB(.19)))+IBCNTCST
 Q
 ;
COLLECT3  ; Accumulate information for the Summary Report
 I IBOB(.21)="P" D                                      ; Primary
 . D SFORM("SPA",1)                                     ; Total number of EEOBs received
 . Q:$D(^TMP($J,"IBCEMSR2","SFORM",IBIFN))              ; Count each CLAIM/BILL only once
 . S ^TMP($J,"IBCEMSR2","SFORM",IBIFN)=""               ; Record CLAIM/BILL use
 . D SFORM("SPACL",1)                                   ; Total number of associated CLAIM/BILLS
 . ; SPAA Calculated Later                              ;   % Processed
 . ; SPAB Calculated Later                              ;   % of Processed auto-processed to secondary
 . I $$PROCSSED^IBCEMSR5(IBIFN) D                       ;   Processed
 .. D SFORM("SPAC",1)                                   ;     Total Number of Processes Requests
 .. I ((IBOB(35)=2)!(IBOB(35)=3)) D                     ;       Auto-processed to secondary
 ... D SFORM("SPACA",1)                                 ;         Total Number auto-processed to secondary
 ... I IBOB(35)=2 D                                     ;           Printed Locally
 .... D SFORM("SPACAA",1)                               ;             Number Printed Locally
 .... D SFORM("SPACAA1",$G(IBOBS(201))-$G(IBOBS(218)))  ;               Total Secondary Charges
 ... I IBOB(35)=3 D                                     ;           Transmitted
 .... D SFORM("SPACAB",1)                               ;             Number Transmitted
 .... D SFORM("SPACAB1",$G(IBOBS(201))-$G(IBOBS(218)))  ;               Total Secondary Charges
 .. I '((IBOB(35)=2)!(IBOB(35)=3)),IBOB(38)="PC" D      ;       Manually processed to secondary
 ... D SFORM("SPACB",1)                                 ;         Number manually processed to secondary
 ... I $G(IBOBS(27))'="",$G(IBOBS(21))="" D             ;           Printed Locally
 .... D SFORM("SPACBA",1)                               ;             Number Printed Locally
 .... D SFORM("SPACBA1",$G(IBOBS(201))-$G(IBOBS(218)))  ;               Total secondary charges
 ... I $G(IBOBS(21))'="",$G(IBOBS(27))="" D             ;           Transmitted
 .... D SFORM("SPACBB",1)                               ;             Number Transmitted
 .... D SFORM("SPACBB1",$G(IBOBS(201))-$G(IBOBS(218)))  ;               Total secondary charges
 .. I $$NOSUB^IBCEMSR5(IBIFN),$P($$BILL^RCJIBFN2(IBIFN),U,2)=22 D  ;       Number without secondary
 ... D SFORM("SPWOS",1)                                 ;         Total number w/out secondary
 .. ;DBIA 1452 ; Number of EEOBs not collected/closed
 .. I '((IBOB(35)=1)!(IBOB(35)=4)),$$NOSUB^IBCEMSR5(IBIFN),$P($$BILL^RCJIBFN2(IBIFN),U,2)'=22 D
 ... D SFORM("SPNCC",1)                                 ;         Total Number of EEOBs not collected/closed
 .. I IBOB(35)=1 D                                      ;           Still on worklist
 ... D SFORM("SPABD",1)                                 ;             Number still on worklist
 . I $$DENIED^IBCEMSR5(IBIFN) D                         ;  Denied
 .. D SFORM("SPAD",1)                                   ;    Number of Denied EEOBs
 ;
 I IBOB(.21)="S" D                                      ; Secondary
 . D SFORM("SSA",1)                                     ; Total number of EEOBs received
 . Q:$D(^TMP($J,"IBCEMSR2","SFORM",IBIFN))              ; Count each CLAIM/BILL only once
 . S ^TMP($J,"IBCEMSR2","SFORM",IBIFN)=""               ; Record CLAIM/BILL use
 . D SFORM("SSACL",1)                                   ; Total number of associated CLAIM/BILLS
 . ; SSAA Calculated Later                              ;   % Processed
 . ; SSAB Calculated Later                              ;   % of Processed auto-processed to tertiary
 . I $$PROCSSED^IBCEMSR5(IBIFN) D                       ;   Processed
 .. D SFORM("SSAC",1)                                   ;     Total Number of Processes Requests
 .. I ((IBOB(35)=2)!(IBOB(35)=3)) D                     ;       Auto-processed to tertiary
 ... D SFORM("SSACA",1)                                 ;         Total Number auto-processed to tertiary
 ... I IBOB(35)=2 D                                     ;           Printed Locally
 .... D SFORM("SSACAA",1)                               ;             Number Printed Locally
 .... D SFORM("SSACAA1",$G(IBOBT(201))-$G(IBOBT(218))-$G(IBOBT(219))) ;    Total tertiary Charges
 ... I IBOB(35)=3 D                                     ;           Transmitted
 .... D SFORM("SSACAB",1)                               ;             Number Transmitted
 .... D SFORM("SSACAB1",$G(IBOBT(201))-$G(IBOBT(218))-$G(IBOBT(219))) ;    Total tertiary Charges
 .. I '((IBOB(35)=2)!(IBOB(35)=3)),IBOB(38)="PC" D      ;       Manually processed to tertiary
 ... D SFORM("SSADB",1)                                 ;         Number manually processed to tertiary
 ... I $G(IBOBT(27))'="",$G(IBOBT(21))="" D             ;           Printed Locally
 .... D SFORM("SSADBA",1)                               ;             Number Printed Locally
 .... D SFORM("SSADBA1",$G(IBOBT(201))-$G(IBOBT(218))-$G(IBOBT(219))) ;    Total tertiary charges
 ... I $G(IBOBT(21))'="",$G(IBOBT(27))="" D             ;           Transmitted
 .... D SFORM("SSPDABB",1)                              ;             Number Transmitted
 .... D SFORM("SSADBB1",$G(IBOBT(201))-$G(IBOBT(218))-$G(IBOBT(219))) ;    Total tertiary charges
 .. I $$NOSUB^IBCEMSR5(IBIFN),$P($$BILL^RCJIBFN2(IBIFN),U,2)=22 D  ;       Number without tertiary
 ... D SFORM("SSWOT",1)                                 ;         Total number w/out tertiary
 .. ;DBIA 1452 ; Number of EEOBs not collected/closed
 .. I '((IBOB(35)=1)!(IBOB(35)=4)),$$NOSUB^IBCEMSR5(IBIFN),$P($$BILL^RCJIBFN2(IBIFN),U,2)'=22 D  ;DBIA 1452 ; Number of EEOBs not collected/closed
 ... D SFORM("SSNCC",1)                                 ;         Total Number of EEOBs not collected/closed
 .. I IBOB(35)=1 D                                      ;           Still on worklist
 ... D SFORM("SSABD",1)                                 ;             Number still on worklist
 . I $$DENIED^IBCEMSR5(IBIFN) D                         ;  Denied
 .. D SFORM("SSAD",1)                                   ;    Number of Denied EEOBs
 ;
 Q
 ;
SFORM(IBACCUM,IBCNTCST)  ; Summary Form Collectors
 ; IBLSTMP(IBDIV2,IBACCUM,IBFT)
 ;         |      |       |
 ;         |      |        - BILL/CLAIM FORM TYPE 2-CMS1500, 3-UB4
 ;         |       --------- ACCUMULATOR IDENTIFIER FOR COUNTS AND CHARGES
 ;          -------------------------- BILL/CLAIM DEFAULT IBDIV2, DICT #40.8, ^DG(40.8,)
 S IBLTMP(IBOB(.22),IBACCUM,IBOB(.19))=$G(IBLTMP(IBOB(.22),IBACCUM,IBOB(.19)))+IBCNTCST
 S IBLTMP("DIVISION",IBACCUM,IBOB(.19))=$G(IBLTMP("DIVISION",IBACCUM,IBOB(.19)))+IBCNTCST
 Q
