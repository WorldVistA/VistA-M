RCDMB1MT ;ALB/MR-REPAYMENT PLAN MONITOR ;16-AUG-00
 ;;4.5;Accounts Receivable;**167,171,188**;Mar 20, 1995
 ;
EN ; - Entry point for this program (Called by PRCABJ - AR Nightly Process)
 N BILL,CNT,DATA,DFN,FLG,I,J,LINE,RCPT,PTDA,RCAR,RCAT,RCDA,RCDB,RCRP,RPDT
 N TXT,TYPE,X
 ;
 K ^TMP("RCDMBDAT",$J)
 ;
 ; - Find data required for report.
 S RCDA=""
 F  S RCDA=$O(^PRCA(430,"AC",16,RCDA)) Q:'RCDA  D
 . S RCAR=$G(^PRCA(430,RCDA,0)) Q:'RCAR
 . I '$P($G(^PRCA(430,RCDA,4)),"^") Q  ; No Repayment Plan
 . S RCAT=+$P(RCAR,"^",2)  ;       Gets AR category.
 . S RCDB=$P(RCAR,"^",9)  ;        Gets the pointer to the Debtor file (#340)
 . S RCPT=$$PAT(RCDB) Q:RCPT=""  ; Gets patient info.
 . S DFN=$P(RCPT,"^",4)  ;         Gets the pointer to the Patient file (#2)
 . S RCRP=$$RP(RCDA,RCDB)   ;      Defaulted Repymt.Plan/New Bill entered
 . I 'RCRP,'$P(RCRP,"^",2) Q  ;    Neither case was found
 . ;
 . ; - Sets the temporary global
 . I $P(RCRP,"^") D                    ; Defaulted on the Repayment Plan
 . . S ^TMP("RCDMBDAT",$J,1,DFN)=RCPT
 . . S ^TMP("RCDMBDAT",$J,1,DFN,$P(RCAR,"^"))=""
 . I $P(RCRP,"^",2) D                  ; Had a new bill entered
 . . S ^TMP("RCDMBDAT",$J,2,DFN)=RCPT
 . . S X=""
 . . F  S X=$O(^TMP("RCDMBDAT",$J,"BILL",X)) Q:X=""  D
 . . . S ^TMP("RCDMBDAT",$J,2,DFN,X)=""
 . . K ^TMP("RCDMBDAT",$J,"BILL")
 ;
 ; - No cases to report were found
 S LINE=0 I '$D(^TMP("RCDMBDAT",$J)) G SND
 ;
 ; - Formats and set the data on ^TMP("RCDMBMSG",$J)
 K ^TMP("RCDMBMSG",$J)
 S (TYPE,PTDA,BILL)="",LINE=1
 F  S TYPE=$O(^TMP("RCDMBDAT",$J,TYPE)) Q:TYPE=""  D
 . ; 
 . ; - Prints the Header (Name    SSN...) and updates LINE
 . D HDR(TYPE,.LINE) S CNT=0
 . F  S PTDA=$O(^TMP("RCDMBDAT",$J,TYPE,PTDA)) Q:PTDA=""  D
 . . S DATA=$G(^TMP("RCDMBDAT",$J,TYPE,PTDA))
 . . S CNT=CNT+1,X=""
 . . S $E(X,1)=$P(DATA,"^")     ;   Debtor Name
 . . S $E(X,38)=$P(DATA,"^",2)  ;   SSN
 . . S $E(X,51)=$P(DATA,"^",3)  ;   Phone Number
 . . S FLG=0 I $P(DATA,"^",5)'="" S FLG=1  ; Date of Death
 . . F  S BILL=$O(^TMP("RCDMBDAT",$J,TYPE,PTDA,BILL)) Q:BILL=""  D
 . . . I FLG,X="" S $E(X,6)="DOD: "_$P(DATA,"^",5),FLG=0
 . . . S $E(X,65)=BILL          ;   Bill Number
 . . . S ^TMP("RCDMBMSG",$J,LINE)=X,X=""
 . . . S LINE=LINE+1
 . . I FLG D
 . . . S ^TMP("RCDMBMSG",$J,LINE)="     DOD: "_$P(DATA,"^",5)
 . . . S LINE=LINE+1
 . I CNT'>1 Q
 . S ^TMP("RCDMBMSG",$J,LINE)="",LINE=LINE+1  ;  Skip a line
 . S ^TMP("RCDMBMSG",$J,LINE)="Total of "_CNT_" debtor(s)",LINE=LINE+1
 . S ^TMP("RCDMBMSG",$J,LINE)="",LINE=LINE+1  ;  Skip a line
 ;
SND ; - If one of the two situations or none of them were found, it will
 ;   informed in the e-mail
 ;   
 F I=1,2 D
 . I $D(^TMP("RCDMBDAT",$J,I)) Q
 . F J=1:1:3 S LINE=LINE+1,^TMP("RCDMBMSG",$J,LINE)=""
 . I I=1 D  Q
 . . S ^TMP("RCDMBMSG",$J,LINE)="There were no debtors who defaulted on their repayment plan yesterday."
 . S ^TMP("RCDMBMSG",$J,LINE)="There were no debtors with repayment plans who had new active bills yesterday."
 ;
 D XMD  ;  Sends the Mailman message
 ;
ENQ K ^TMP("RCDMBDAT",$J),^TMP("RCDMBMSG",$J)
 Q
 ;
XMD ; Sets the Mailman variables and send the message
 N DUZ,XMSUB,XMDUZ,XMY,XMDUN,XMMG,XMSCR,XMTEXT,XMZ
 ;
 S XMSUB="AR REPAYMENT PLAN MONITOR",XMDUZ="AR PACKAGE"
 S XMY("G.RC REPAY PLANS")="",XMTEXT="^TMP(""RCDMBMSG"","_$J_","
 ;
 D ^XMD
 ;
 Q
 ;
PAT(DEB) ; - Returns Debtor information
 ;    Input: DEB=AR pointer to Debtor file (#340)
 ;   Output: Name ^ SSN ^ Phone Number ^ Pointer to Patient file ^
 ;           Date of Death (MM/DD/YY)
 ;
 N DEATH,DEBTOR,DFN,NAME,PHONE,SSN,VA,VADM,VAERR,VAPA
 I 'DEB Q ""
 S DEBTOR=$G(^RCD(340,DEB,0)) I $P(DEBTOR,"^")'["DPT" Q ""
 S DFN=+DEBTOR
 D DEM^VADPT S NAME=VADM(1),SSN=$P(VADM(2),"^",2),DEATH=$P(VADM(6),".")
 I DEATH'="" S DEATH=$$DAT(DEATH)
 D ADD^VADPT S PHONE=VAPA(8)
 ;
 Q (NAME_"^"_SSN_"^"_PHONE_"^"_DFN_"^"_DEATH)
 ;
RP(X,DEB) ; - Checks if a Repayment Plan became defaulted or if a new 
 ; bill has been entered to a patient under a Repayment Plan established
 ;   Input: X=Pointer to the AR file #430
 ;          DEB=Pointer to the Detor file #340
 ;  Output: Y=Defaulted? (1-YES/0-NO) ^ New bill entered? (1-YES/0-NO) ^
 ;          Bill(s) # separated by "," (If piece 2 = 1)
 ;
 N ARZ,DEF,ELM,I,NEW,NPMT,RCBL,RP,YST
 ;
 S (DEF,NEW)=0
 S RP=$G(^PRCA(430,X,4)),NPMT=$P(RP,"^",4),YST=$$HTFM^XLFDT($H-1,1)
 ;
 ; - Checks if the patient defaulted on his Repayment Plan
 F I=1:1:NPMT D  Q:DEF
 . S ELM=$G(^PRCA(430,X,5,I,0)) Q:ELM=""
 . I $P(ELM,"^",2) Q
 . I $$FMDIFF^XLFDT(YST,$P(ELM,"^"))=1 D  Q
 . . S DEF=1
 ;
 ; Checks if a Bill became active for the debtor yesterday
 S RCBL=""
 F  S RCBL=$O(^PRCA(430,"C",DEB,RCBL)) Q:RCBL=""  D
 . I RCBL=X Q
 . S ARZ=$G(^PRCA(430,RCBL,0))
 . I $P(ARZ,"^",8)'=16!($P(ARZ,"^",14)'=YST) Q
 . S NEW=1,^TMP("RCDMBDAT",$J,"BILL",$P($G(^PRCA(430,RCBL,0)),"^"))=""
 Q (DEF_"^"_NEW)
 ;
HDR(TP,LN) ; Sets the temporary global with the header of the E-mail
 ; Input: TP=Type of problem (1-Defaulted / 2-New bill)
 ;        LN=Next line to be set on the ^TMP("RCDMBMSG",$J,LN) global
 ;
 N X,I
 I TP=1 D
 . S ^TMP("RCDMBMSG",$J,LN)="The following debtors just defaulted on a Repayment Plan by not making a"
 . S LN=LN+1
 . S ^TMP("RCDMBMSG",$J,LN)="scheduled payment on or before the scheduled payment date: "
 I TP=2 D
 . F I=1,2 S ^TMP("RCDMBMSG",$J,LN)="",LN=LN+1
 . S ^TMP("RCDMBMSG",$J,LN)="The following debtors with a Repayment Plan had a new active bill entered: "
 ;
 S LN=LN+1,^TMP("RCDMBMSG",$J,LN)=""
 S X="",$E(X,1)="Name",$E(X,38)="SSN",$E(X,51)="Phone Number"
 S $E(X,65)=$S(TP=1:"Bill",1:"New Bill")
 S LN=LN+1,^TMP("RCDMBMSG",$J,LN)=X
 S X="",$P(X,"=",79)="" S LN=LN+1,^TMP("RCDMBMSG",$J,LN)=X
 S LN=LN+1
 Q
 ;
DAT(DAT) ;Changes date from FM to MM/DD/YYYY
 N YR
 S YR=DAT\10000+1700
 Q $E(DAT,4,5)_"/"_$E(DAT,6,7)_"/"_YR
