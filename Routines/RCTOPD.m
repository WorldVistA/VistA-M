RCTOPD ;WASH IRMFO@ALTOONA,PA/TJK-TOP TRANSMISSION ;2/11/00 3:34 PM
V ;;4.5;Accounts Receivable;**141,187,224,236,229**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ENTER ;Entry point from nightly process
 Q:'$D(RCDOC)
 N DEBTOR,BILL,DEBTOR0,B0,B6,B7,P181DT,PRIN,INT,ADMIN,B4
 N EFFDT,DFN,CNTR,SITE,LN,FN,MN,DOB,SITE,F60DT,VADM
 N PHONE,QUIT,TOTAL,ZIPCODE,FULLNM,RCNT,REPAY,X1,X2
 N ERROR,ADDR,CAT,BILLDT,P10YDT,CURRTOT,HOLD,SITECD,RCNEW
 ;
 ;initialize temporary global, variables
 ;
 K ^XTMP("RCTOPD") S ^XTMP("RCTOPD",0)=DT_U_DT
 S SITE=$E($$SITE^RCMSITE(),1,3),SITECD=$P(^RC(342,1,3),U,5)
 S X1=DT,X2=-181 D C^%DTC S (P181DT,EFFDT)=X
 S X1=DT,X2=-3650 D C^%DTC S P10YDT=X
 S X1=DT,X2=+60 D C^%DTC S F60DT=X
 S (CNTR(1),CNTR(2),CNTR(4),DEBTOR,RCNT)=0
 ;
 ;branch if recertification document
 I RCDOC="Y" D RECERT G EXIT
 ;
 ;branch to do update documents
 D UPDATE I RCDOC="U" G EXIT
 ;
 ;master sheet compilation
 ;
 F  S DEBTOR=$O(^PRCA(430,"C",DEBTOR)) Q:DEBTOR'?1N.N  D
 .N X,RCDFN
 .S RCDFN=$G(^RCD(340,DEBTOR,0))
 .I $P(RCDFN,";",2)["DPT",$$EMERES^PRCAUTL(+RCDFN)]"" Q  ;stop the master sheet compilation for hurricane Katrina sites (patients)
    .Q:$D(^RCD(340,"TOP",DEBTOR))
    .; quit if debtor address marked unknown
    .Q:$P($G(^RCD(340,+DEBTOR,1)),"^",9)=1
    .S DEBTOR6=$G(^RCD(340,DEBTOR,6)),DEBTOR0=$G(^(0)),HOLD=0,RCNEW=1
    .I $P(DEBTOR6,U,2),'$P(DEBTOR6,U,3) Q
    .S QUIT=1,FILE=$$FILE(DEBTOR0) Q:'FILE
    .S EFFDT=P181DT
    .D PROC(DEBTOR,.QUIT,FILE,.HOLD,.EFFDT) Q:QUIT
    .D EN1^RCTOP2(DEBTOR,"M",FILE)
    .D EN1^RCTOP1(DEBTOR,TOTAL,"M",EFFDT,0,FILE)
    .;set hold date in file for employee, ex-employee, vendor records
    .;Austin holds these for 60 days before transmitting to TOP
    .I $G(HOLD) S $P(^RCD(340,DEBTOR,6),U,6)=F60DT
    .Q
 ;compile documents into mail messages--sets referral date in 430
 D COMPILE
EXIT K RCDOC,^XTMP("RCTOPD"),^TMP("RCTOPD"),XMDUZ D KVAR^VADPT
 Q
 ;
UPDATE ;weekly update compilation
 F  S DEBTOR=$O(^RCD(340,"TOP",DEBTOR)) Q:DEBTOR'?1N.N  D
    .S QUIT=1,DEBTOR0=^RCD(340,DEBTOR,0),DEBTOR6=^(6),DEBTOR4=^(4),FILE=$$FILE(DEBTOR0),EFFDT=$P(DEBTOR4,U,6),RCNEW=0
    .D EN1^RCTOP2(DEBTOR,"U",FILE)
    .D PROC(DEBTOR,.QUIT,FILE,0,.EFFDT) I QUIT D  Q
       ..;process type 4 document if necessary
       ..S TAXID=$$TAXID^RCTOP1(DEBTOR,FILE),OTAXID=$P(DEBTOR4,U)
       ..S NAME=$$NAME^RCTOP1(+DEBTOR0,FILE),ONAME=$P(DEBTOR4,U,2),NAME=$P(NAME,U)
       ..I NAME=ONAME,TAXID=OTAXID Q
       ..D EN1^RCTOP4(NAME,TAXID,DEBTOR4,DEBTOR,FILE)
       ..Q
    .D EN1^RCTOP1(DEBTOR,TOTAL,"U",EFFDT,0,FILE)
    .Q
 ;refund/refund reversal documents
 D REFDOC
 ;compile documents into mail messages--sets referral date in 430
 D:$G(RCDOC)="U" COMPILE
 Q
 ;
RECERT ;send yearly recertification documents
 F  S DEBTOR=$O(^RCD(340,"TOP",DEBTOR)) Q:DEBTOR'?1N.N  D
    .S DEBTOR4=$G(^RCD(340,DEBTOR,4)),TOTAL=$P(DEBTOR4,U,3),EFFDT=$P(DEBTOR4,U,6),DEBTOR0=$G(^(0)),FILE=$$FILE(DEBTOR0)
    .I TOTAL D EN1^RCTOP1(DEBTOR,TOTAL,"Y",EFFDT,0,FILE)
    .Q
 ;compile documents into mail messages
 D COMPILE
 Q
 ;
REFDOC ; refund, refund reversal documents
 N CODE,BILL,DEBTOR,TOTAL,EFFDT,FILE,RFCODE
 F RFCODE=1,3 S CODE=$S(RFCODE=1:"R",1:"RV") D
    .S BILL=0 F  S BILL=$O(^PRCA(430,"TREF",RFCODE,BILL)) Q:'BILL  D
       ..S DEBTOR=$P($G(^PRCA(430,BILL,0)),U,9) Q:'DEBTOR
       ..S TOTAL=$P($G(^(7)),U,18) Q:'TOTAL  ;NAKED TO LINE ABOVE
       ..S EFFDT=$P($G(^RCD(340,+DEBTOR,4)),U,6),FILE=$$FILE(^(0))
       ..D EN1^RCTOP1(DEBTOR,TOTAL,CODE,EFFDT,BILL,FILE)
      ..Q
    .Q
 Q
 ;
COMPILE ;compiles documents into mail messages and transmits them
 ;builds message array
 N CNT,SEQ,REC,XMDUZ,DOCTYPE,LRTYPE,XMSUB,XMTEXT,XMY,TSEQ,DOCAMT
 S (SEQ,TSEQ)=0
 F I=1,2,4 S TSEQ=TSEQ+($G(CNTR(I))\150)+$S($G(CNTR(I))#150:1,1:0)
 F DOCTYPE=1,2,4 D:$D(^XTMP("RCTOPD",$J,DOCTYPE)) COMPILE1(DOCTYPE,CNTR(DOCTYPE))
 D USRMSG
 Q
COMPILE1(DOCTYPE,CNTR) ; compiles each type of document separately
 S RCNT=RCNT+CNTR
 I '$G(LRTYPE) F I=1,2,4 S:$D(^XTMP("RCTOPD",$J,I)) LRTYPE=I
 F CNT=1:1:CNTR D
    .D:CNT#150=1
       ..K ^XTMP("RCTOPD",$J,"BUILD") S SEQ=SEQ+1
       ..S REC=1,DOCAMT=0
       ..Q
    .S REC=REC+1,^XTMP("RCTOPD",$J,"BUILD",REC)=^XTMP("RCTOPD",$J,DOCTYPE,CNT)_U S:DOCTYPE=1 DOCAMT=DOCAMT+($E(^(REC),135,146)/100)
    .I CNTR=CNT,LRTYPE=DOCTYPE S ^XTMP("RCTOPD",$J,"BUILD",REC+1)="END OF TRANSMISSION FOR SITE# "_SITE_":  TOTAL RECORDS: "_RCNT
    .I $S(CNTR=CNT:1,CNT#150=0:1,1:0) D
       ..S ^XTMP("RCTOPD",$J,"BUILD",1)=SITE_U_$TR($J(SEQ,2)," ",0)_U_$TR($J(TSEQ,2)," ",0)_U_(REC-1)_U_DOCAMT_U
       ..S XMDUZ="AR PACKAGE"
       ..S XMY("XXX@Q-TOP.MED.VA.GOV")=""
       ..S XMY("G.TOP")=""
       ..S XMSUB=SITE_"/TOP TRANSMISSION/SEQ#: "_SEQ_"/"_$$NOW()
       ..S XMTEXT="^XTMP(""RCTOPD"","_$J_",""BUILD"","
       ..D ^XMD
       ..Q
    .Q
 Q
 ;
USRMSG ;sends mailman message of documents sent to user
 N XMY,XMDUZ,XMSUB,X,RCNT
 S XMDUZ="AR PACKAGE",XMY("G.TOP")=""
 S XMSUB="TOP "_$S(RCDOC="M":"MASTER/UPDATE",RCDOC="U":"UPDATE",1:"RECERTIFICATION")_" RECORDS SENT ON "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S ^XTMP("RCTOPD",$J,"REC1",1)="Name                             TIN        TYPE       AMOUNT"
 S ^XTMP("RCTOPD",$J,"REC1",2)="----                             ---        ----       ------"
 S X="",RCNT=3 F  S X=$O(^XTMP("RCTOPD",$J,"REC",X)) Q:X=""  S ^XTMP("RCTOPD",$J,"REC1",RCNT)=^(X),RCNT=RCNT+1
 S ^XTMP("RCTOPD",$J,"REC1",RCNT)="Total Records: "_(RCNT-3)
 S XMTEXT="^XTMP(""RCTOPD"","_$J_",""REC1"","
 D ^XMD
 ;
THIRD ;sends mailman message to user if no third letter found
 Q:'$D(^XTMP("RCTOPD",$J,"THIRD"))
 K ^XTMP("RCTOPD",$J,"REC1")
 S XMDUZ="AR PACKAGE",XMY("G.TOP")=""
 N TCT,TDEB,TDEB0,TBIL,TSP,FST
 S XMSUB="TOP QUALIFIED/NO 3RD LETTER SENT ON "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S ^XTMP("RCTOPD",$J,"REC1",1)="The following list of debtor bills were not sent to TOP."
 S ^XTMP("RCTOPD",$J,"REC1",2)="Please review debtor's account to determine why the third"
        S ^XTMP("RCTOPD",$J,"REC1",3)="notice letter has not been sent:"
 S ^XTMP("RCTOPD",$J,"REC1",4)="Name                               Bill #"
 S ^XTMP("RCTOPD",$J,"REC1",5)="----                               ------"
 S TCT=6,TSP=0,TDEB=""
 F  S TDEB=$O(^XTMP("RCTOPD",$J,"THIRD",TDEB)) Q:TDEB=""  D
 .S FST=1,TBIL=""
 .I FST,TCT'=6 S ^XTMP("RCTOPD",$J,"REC1",TCT)="",TCT=TCT+1,TSP=TSP+1
 .F  S TBIL=$O(^XTMP("RCTOPD",$J,"THIRD",TDEB,TBIL)) Q:TBIL=""  D
 ..S TDEB0=$S(FST:TDEB,1:"")
 ..S ^XTMP("RCTOPD",$J,"REC1",TCT)=TDEB0_$J(" ",35-$L(TDEB0))_TBIL
 ..S TCT=TCT+1,FST=0
 S ^XTMP("RCTOPD",$J,"REC1",TCT)="Total records: "_(TCT-(6+TSP))
 S XMTEXT="^XTMP(""RCTOPD"","_$J_",""REC1"","
 D ^XMD
COMPQ Q
 ;
PROC(DEBTOR,QUIT,FILE,HOLD,EFFDT) ;process bills for a specific debtor
 K ^TMP("RCTOPD",$J,"BILL")
 S DEBTOR0=$G(^RCD(340,DEBTOR,0))
 Q:'FILE
 I FILE=2 S DFN=+DEBTOR0 D DEM^VADPT Q:$E(VADM(2),1,5)="00000"
 S (BILL,TOTAL,REPAY)=0
 I RCNEW,FILE=440 S HOLD=1
 I 'RCNEW,$P(^RCD(340,DEBTOR,6),U,2),'$P(^(6),U,3) G TOTAL
 I RCNEW,$D(^RCD(340,"DMC",1,DEBTOR)) G TOTAL
 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
    .I FILE=2,+VADM(6) S TOTAL=0,REPAY=1 Q
    .S B0=$G(^PRCA(430,BILL,0)),B4=$G(^(4)),B6=$G(^(6)),B7=$G(^(7))
    .Q:$P(B0,U,8)'=16
    .Q:B4
    .Q:'$P(B0,U,2)  S CAT=$P($G(^PRCA(430.2,$P(B0,U,2),0)),U,7)
    .Q:'CAT  I ",16,17,21,22,23,26,27,33,"[(","_CAT_",") Q
    .;check for DOJ referral here
    .I $P(B6,U,4),($P(B6,U,5)="DOJ") Q
    .S BILLDT=$P(B6,U,21) I (BILLDT<P10YDT)!(BILLDT>P181DT)!(BILLDT<$P(DEBTOR6,U,3)) Q
    .I '$P(B6,U,3) D  Q
    ..;no 3rd letter being sent 
    ..N TDEB,TFIL
    ..S TDEB=$G(^RCD(340,DEBTOR,0)),TFIL=$$FILE(TDEB),TDEB=$$NAME^RCTOP1(+TDEB,TFIL),TDEB=$P(TDEB,U,2),^XTMP("RCTOPD",$J,"THIRD",TDEB,$P(B0,U))=""
    .I RCNEW,CAT>12,CAT<15 S HOLD=1
    .I BILLDT,BILLDT<EFFDT S EFFDT=BILLDT
    .S TOTAL=TOTAL+$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
    .S ^TMP("RCTOPD",$J,"BILL",BILL)=""
    .Q
 ;
TOTAL ;set transmission total, reset quit variable
 N RCSWINFO S RCSWINFO=$$SWSTAT^IBBAPI()                  ;PRCA*4.5*229
 I RCNEW,'+RCSWINFO Q:TOTAL<25                            ;PRCA*4.5*229
 I RCNEW,+RCSWINFO Q:TOTAL'>0                             ;PRCA*4.5*229
 ;
 I 'RCNEW S:TOTAL<25 TOTAL=0  S CURRTOT=$P($G(^RCD(340,DEBTOR,4)),U,3) Q:CURRTOT=TOTAL  S TOTAL=TOTAL-CURRTOT
 S QUIT=0
PROCQ Q
 ;
NOW() ;compiles current date,time
 N X,Y,%,%H
 S %H=$H D YX^%DTC
 Q Y
 ;
FILE(DEBTOR0) ;gets file number for debtor
 S FILE=$P($P(DEBTOR0,U),";",2)
 S FILE=$S(FILE["DPT(":2,FILE["PRC(440":440,FILE["VA(200":200,1:0)
FILEQ Q FILE
