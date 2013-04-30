DGBTR122 ;PAV - BENEFICIARY/TRAVEL E12.2 ROUTINE; 6/20/2012@1130 ;11/14/11  09:58
 ;;1.0;Beneficiary Travel;**20**;July 25, 2012;Build 185
 Q
EN ;12.2 Audit Report
 W *7,!!,"        ************* BT  Audit Report *************",!
 N DIR,A,AA,B,C,Y,X,I,DA,DIK,DIC,FDA,SDATE,EDATE,SNAME,ENAME,A,DFN,H1,H0,H2,SDATEP,EDATEP,TXT,EXIT,SPR,DEL,DGBTQ,VADM,EXCEL,LINE,PAGE,XDATE,XXDATE
 N XNAME,ZTQUEUED
 S (EXCEL,EXIT)=0,DEL=U
DATE ;
 ;Beginning Date. Compared against the Claim entry date.
 K DIR S DIR("A")="START DATE: ",DIR(0)="DA^2991231:NOW:EX" D ^DIR K DIR
 D ^DIR G:(Y=U)!$G(DTOUT)!$G(DUOUT) EXIT
 S SDATE=Y,SDATEP=$$DP(SDATE),SDATE=SDATE-.0001
 ;Ending Date. Compared against the Claim entry date.
 K DIR S DIR("A")="END DATE:   ",DIR(0)="DA^"_SDATE_":NOW:EX" D ^DIR K DIR
 D ^DIR G:(Y=U)!$G(DTOUT)!$G(DUOUT) EXIT
 S EDATE=Y,EDATEP=$$DP(EDATE)
NAME ;
 ;The name of the first veteran to include in the report (last name).  This can be a partial string. Default value is 'AAA'
 K DIR S DIR("A")="START NAME  ",DIR("B")="AAA",DIR(0)="F^3:30"    ;DIR(0)="F^1:30^K:X'?1A.A.A X"
 D ^DIR G:(Y=U)!$G(DTOUT)!$G(DUOUT) EXIT
 S SNAME=$$UP^XLFSTR(Y)
 ;The name of the last veteran to include in the report (last name).  This can be a partial string.   Default value is 'ZZZ'
 K DIR S DIR("A")="END NAME    ",DIR("B")="ZZZ",DIR(0)="F^3:30"   ;DIR(0)="F^1:30^K:X'?1A.A.A X"
 D ^DIR G:(Y=U)!$G(DTOUT)!$G(DUOUT) EXIT
 S ENAME=$$UP^XLFSTR(Y)
 I SNAME]ENAME W *7,!,"START NAME must be before LAST NAME",! G NAME
 S ENAME=ENAME_"Z"
 S AA="0,1,2,3,4,5,6,7,21,9,10,11,12,13,14,15,16,17,18,19"
 S EXCEL=$$SELEXCEL^DGBTUTL() Q:EXCEL=U  ;
 I 'EXCEL N COLWID S COLWID=255 D PRINTMSG^DGBTUTL
 S DGBTQ=0 D DEVICE^DGBTUTL("BT Audit Report","QUE^DGBTR122",EXCEL,255) Q:$G(DGBTQ)
QUE ;
 S B(0)="DATE ENT^10",B(1)="CLAIM DATE^13",B(2)="PATIENT NAME^25",B(3)="SSN^15",B(4)="ELIG^20",B(5)="SC %^6"
 S B(6)="ACCT^8",B(7)="R/O^5",B(8)="TOT MILES^10",B(9)="CC MODE^11",B(10)="CC FEE^10",B(11)="ECON^9"
 S B(12)="DED^9",B(13)="PAYABLE^9",B(14)="DEP ADDRESS^20",B(15)="DEP CITY^15",B(16)="DEP STATE^18"
 S B(17)="DEP ZIP^8",B(18)="DIV^5",B(19)="REMARKS^45",B(20)="CLERK^18",B(21)="MILEAGE^8"
 S C(0)="DATE ENTERED^10",C(1)="CLAIM DATE^14",C(2)="PATIENT NAME^16",C(3)="SSN^13",C(4)="ELIGIBILITY^16",C(5)="SC PERCENTAGE^5"
 S C(6)="ACCOUNT^16",C(7)="R/O^5",C(8)="TOTAL MILEAGE^7",C(9)="CC MODE^11",C(10)="CC FEE^10",C(11)="MOST ECONOMICAL^9"
 S C(12)="DEDUCTIBLE AMOUNT^7",C(13)="AMOUNT PAYABLE^7",C(14)="PLACE OF DEPARTURE^14",C(15)="CITY OF DEPARTURE^12",C(16)="STATE OF DEPARTURE^14"
 S C(17)="ZIP CODE OF DEPARTURE^8",C(18)="DIVISION^5",C(19)="REMARKS^42",C(20)="WHO ENTERED INTO FILE^18",C(21)="MILES^6" ;,C(21)="MILES ONE WAY^8"
EN1 S PAGE=0,LINE=99999,$P(H1,"-",IOM-1)="-"
 S H0="************* BT Audit Report "_SDATEP_"-"_EDATEP_" *************",H2="                                  "
 S XDATE=SDATE F  S XDATE=$O(^DGBT(392,"D",XDATE)) Q:'XDATE!(XDATE>EDATE)  D  Q:EXIT
 .S XXDATE="" F  S XXDATE=$O(^DGBT(392,"D",XDATE,XXDATE)) Q:'XXDATE  D  Q:EXIT
 ..K FDA,A D GETS^DIQ(392,XXDATE_",","**","EI","FDA") Q:'$D(FDA)  ;ZW FDA S EXIT=1 Q
 ..S XNAME=$$UP^XLFSTR(FDA(392,XXDATE_",",2,"E")),XNAME=$P(XNAME,U),XNAME=$TR(XNAME,"-"," "),XNAME=$TR(XNAME,"/"," ")
 ..Q:XNAME]ENAME!(SNAME]XNAME)  ;Quit if not between names
 ..Q:FDA(392,XXDATE_",",45.2,"I")    ;Quit if Denied Claim
 ..Q:FDA(392,XXDATE_",",56,"I")="S"  ; Quit if Special Mode
 ..S A(0)=$$DP(FDA(392,XXDATE_",",13,"I"))    ;Date Claim entered
 ..S A(1)=$$DP(FDA(392,XXDATE_",",.01,"I"))    ;Claim Date
 ..S A(2)=FDA(392,XXDATE_",",2,"E")             ;Patient Name
 ..S DFN=FDA(392,XXDATE_",",2,"I") D DEM^VADPT
 ..S A(3)=$P(VADM(2),U,2)                           ;SSN
 ..S A(4)=FDA(392,XXDATE_",",3,"E")             ;Eligibility
 ..S A(5)=FDA(392,XXDATE_",",4,"E")             ;SC Percentage
 ..S A(6)=+FDA(392,XXDATE_",",6,"E")             ;Account
 ..S A(7)=$E(FDA(392,XXDATE_",",31,"E"),1)         ;One Way/Round Trip
 ..S A(8)=$$DLRAMT(FDA(392,XXDATE_",",33,"E"))          ;Total Mileage 
 ..S A(9)=FDA(392,XXDATE_",",44,"E")             ;Common Carrier mode
 ..S A(10)=$$DLRAMT(FDA(392,XXDATE_",",55,"E"))      ;Common Carrier fee 
 ..S A(11)=$$DLRAMT(FDA(392,XXDATE_",",8,"E"))       ;Most economical cost 
 ..S A(12)=$$DLRAMT(FDA(392,XXDATE_",",9,"E"))      ;Deductible amount
 ..S A(13)=$$DLRAMT(FDA(392,XXDATE_",",10,"E"))                       ;Amount payable
 ..S A(14)=FDA(392,XXDATE_",",21,"E")               ;Place of departure 
 ..S A(15)=FDA(392,XXDATE_",",24,"E")               ;City of departure 
 ..S A(16)=FDA(392,XXDATE_",",24.1,"E")            ;State of departure 
 ..S A(17)=FDA(392,XXDATE_",",24.2,"E")            ;Zip code of departure
 ..S A(18)=FDA(392,XXDATE_",",11,"E")            ;Division
 ..S A(19)=FDA(392,XXDATE_",",51,"E")               ;Remarks
 ..S A(20)=FDA(392,XXDATE_",",12,"E")            ;WHO ENTERED INTO FILE
 ..S A(21)=FDA(392,XXDATE_",",32,"E")               ;MILEAGE/ONE WAY
 ..S:A(7)="R" A(21)=A(21)*2              ;If roud trip double miles
 ..I FDA(392,XXDATE_",",56,"I")="S" D          ;Handle special mode
 ...S A(8)=FDA(392,XXDATE_",",60,"E")          ;SP Total Invoice Amount
 ...S A(7)=$E(FDA(392,XXDATE_",",67,"E"),1)      ;SP One Way / Round Trip
 ...S A(21)=FDA(392,XXDATE_",",68,"E")             ;SP Total miles ??
 ...S A(14)=FDA(392,XXDATE_",",73,"E")                ;SP Place of departure
 ...S A(15)=FDA(392,XXDATE_",",75,"E")                ;SP City of departure
 ...S A(16)=FDA(392,XXDATE_",",76,"E")                ;SP State of departure
 ...S A(17)=FDA(392,XXDATE_",",77,"E")                  ;SP Zip code of departure
 ...S A(19)=FDA(392,XXDATE_",",72,"E")                ;SP Remarks
 ..I EXCEL D EXCEL Q
 ..D PRINT
 I IOST["C-" S TT=$$PAUSE^DGBTUTL(EXCEL)
 I IOST'["C-" W !,"REPORT HAS FINISHED"
 D ^%ZISC
 Q
PRINT ;
 N L,T1,TT
 D:LINE>IOSL HEADER Q:EXIT
 S TXT="",L=0
 F L=1:1 S I=$P(AA,",",L) Q:'$L(I)  S T1=$P(B(I),U,2)-$L(A(I)) S:T1'>0 T1=1 S TXT=TXT_$E(A(I),1,$P(B(I),U,2)-1)_$S(I=19:"",1:$E(H2,1,T1))
 U IO F I=0:IOM S TT=$E(TXT,I+1,I+IOM) Q:'$L(TT)  W !,TT
 S LINE=LINE+($L(TXT)\IOM)+3
 U IO W !
 Q
HEADER ;
 S PAGE=PAGE+1,L=0,TXT="",TT=""
 I LINE'=99999,$E(IOST,1,4)="C-VT" U IO S TT=$$PAUSE^DGBTR124() I TT[U S EXIT=1 Q
 U IO W @IOF,?IOM/2-35,H0," Page: ",PAGE,!,H1
 F L=1:1 S I=$P(AA,",",L) Q:'$L(I)  S T1=$P(B(I),U,2)-$L($P(B(I),U)) S TXT=TXT_$P(B(I),U)_$E(H2,1,T1)
 U IO F I=0:IOM S TT=$E(TXT,I+1,I+IOM) Q:'$L(TT)  W !,TT
 U IO W !,H1 S LINE=5
 Q
DP(DATE) ;Set printable date
 Q $E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
EXCEL ;Print to spreadsheet
 D:LINE=99999
 .S LINE=0,TXT="" F L=1:1 S I=$P(AA,",",L) Q:'$L(I)  S TXT=TXT_$TR($P(C(I),U),DEL," ")_$S(I=19:"",1:DEL)
 .U IO W !,TXT
 S TXT="" F L=1:1 S I=$P(AA,",",L) Q:'$L(I)  S TXT=TXT_$TR(A(I),DEL," ")_$S(I=19:"",1:DEL)
 U IO W !,TXT
 Q
DLRAMT(X) D COMMA^%DTC Q $S(EXCEL:"",1:"$")_$TR(X," ","")
EXIT ;
 Q
