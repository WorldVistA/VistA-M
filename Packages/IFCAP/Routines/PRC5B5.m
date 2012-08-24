PRC5B5 ;WISC/PLT-Receiver of AAF-document from FMS V5 ; 06/29/94  2:30 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;invoked from task manager (see trin^prcosrv2)
 ;set accrue y/n in file 442 from AAF-doc.
 ;PRCDA=ri of file 423.6 passed
EN ;AAF-message from sever FMS MESSAGE SEVER routine PRCOSRV2
 N PRCRI,PRCTY,PRCERR,PRCSEQ,A,B
 S PRCRI(423.6)=PRCDA,PRCTY=""
 ;check txn message
 S PRCERR="",PRCSQE="" D CHECK(PRCRI(423.6))
 I PRCERR D  G EXIT
 . N A,B,C
 . S A(1)="IFCAP/FMS AAF MESSAGE IS IN INVALID FORMAT."
 . S A(2)="PLEASE CALL FMS-CONVERSION TEAM USER TO RESEND THIS MESSAGE:"
 . S A(3)=$P($G(^PRCF(423.6,PRCDA,0)),"^")_" WITH IFCAP ERROR: "_PRCERR
 . I PRCTY="" S B(.5)=""
 . E  S X=$$FIRST^PRC0B1("^PRCF(423.5,""B"""_",""CTL-"_PRCTY_""",",0) S X=$S(X:"G."_$$MG^PRC0B2($P(^PRCF(423.5,X,0),"^",2)),1:.5),B(X)=""
 . S C="IFCAP/FMS CONVERSION ERROR MESSAGE-AAF^IFCAP FMS MESSAGE SERVER"
 . D MM^PRC0B2(C,"A(",.B)
 . QUIT
 ;process message
 S A=$T(@PRCTY)
 D PRO(PRCRI(423.6),$P(A," ",1)_"^"_$P(A,";",3,999))
 I PRCERR D  G EXIT
 . N A,B,C
 . S A(1)="IFCAP/FMS CONVERSION MESSAGE "_PRCTY_" PROCESS FAILS"
 . S A(2)="PLEASE CALL FMS-CONVERSION TEAM USER TO RESEND THIS MESSAGE:"
 . S A(3)=$P($G(^PRCF(423.6,PRCDA,0)),"^")_" WITH IFCAP ERROR: "_PRCERR
 . S X=$$FIRST^PRC0B1("^PRCF(423.5,""B"""_",""CTL-"_PRCTY_""",",0) S X=$S(X:"G."_$$MG^PRC0B2($P(^PRCF(423.5,X,0),"^",2)),1:.5),B(X)=""
 . S C="IFCAP/FMS COPY ERROR MESSAGE-AAF^IFCAP FMS MESSAGE SERVER"
 . D MM^PRC0B2(C,"A(",.B)
 . QUIT
 ;send processing done message
 D
 . N A,B,C
 . S A(1)="IFCAP/FMS CONVERSION MESSAGE "_PRCTY_" PROCESSING DONE."
 . S A(2)=$P($G(^PRCF(423.6,PRCDA,0)),"^")
 . S X=$$FIRST^PRC0B1("^PRCF(423.5,""B"""_",""CTL-"_PRCTY_""",",0) S X=$S(X:"G."_$$MG^PRC0B2($P(^PRCF(423.5,X,0),"^",2)),1:.5),B(X)=""
 . S C="IFCAP/FMS PROCESS DONE MESSAGE-AAF^IFCAP FMS MESSAGE SERVER"
 . D MM^PRC0B2(C,"A(",.B)
 . QUIT
 ;
EXIT ;delete fms conversion message in file 423.6
 D KILL^PRCOSRV3(PRCRI(423.6))
 QUIT
 ;
CHECK(PRCA,PRCB) ;PRCA=ri of file 423.6, PRCB=^1 txn class from FMS, ^2=description
 N PRCC,PRCD,A
 S PRCC=$O(^PRCF(423.6,PRCA,1,9999)) I 'PRCC S PRCERR=2 QUIT  ;no message
 S PRCD=$G(^PRCF(423.6,PRCA,1,PRCC,0)) I PRCD="" S PRCERR=2 QUIT
 S PRCTY=$P(PRCD,"^",5),A="" S:PRCTY?1.5A A=$T(@PRCTY)
 I $P(PRCD,"^")'="CTL"!(A="") S PRCERR=3,PRCTY="" QUIT  ;wrong type
 S PRCSEQ=+$P(PRCD,"^",13)_"-"_(+$P(PRCD,"^",14))
 F  S PRCC=$O(^PRCF(423.6,PRCA,1,PRCC)) Q:'PRCC  S PRCD=^(PRCC,0)
 I PRCD'="{" S PRCERR=4 QUIT  ;missing txn delimeter
 QUIT
 ;
PRO(PRCA,PRCB) ;PRCA=ri of file 423.6, PRCB=^1 txn class from FMS, ^2=description
 N PRCC,PRCD,A,B,X,Y
 S PRCC=$O(^PRCF(423.6,PRCA,1,9999))
 F  S PRCC=$O(^PRCF(423.6,PRCA,1,PRCC)) Q:'PRCC  S PRCD=^(PRCC,0) I PRCD?1"AAF".E D
 . S A=$P(PRCD,"^",3),A=$P(A," ",1),A=$E(A,1,3)_"-"_$E(A,4,999),B=""
 . S:$P(PRCD,"^",4)]"" B=$F("NY",$P(PRCD,"^",4))-2
 . S PRCRI(442)=$O(^PRC(442,"B",A,"")) QUIT:'PRCRI(442)
 . D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCRI(442),"30////"_B)
 . QUIT
 QUIT
 ;
 ;
AAF ;;AUTO-ACCRUE DATA
 ;
