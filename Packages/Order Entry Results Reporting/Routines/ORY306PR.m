ORY306PR ;ISL/JLC - Post-install for patch OR*3*306 ;12/07/12  06:14
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**306**;Dec 17, 1997;Build 43
 ;
 ;
QPR ; queue provider report to occur monthly
 N WHEN,%,X1,X2,X,Y,YR,DT,MN
 D LMES("Queue Monthly CS Report by Provider...",10,"B")
 D OPTSTAT^XUTMOPT("OR EPCS CS RX BY PROVIDER",.INFO) ;first, check for an existing schedule
 S Y=$P($G(INFO(1)),"^",2)
 D DD^%DT
 S WHEN=Y
 I $P($G(INFO(1)),"^",2)]"" D  ;;already scheduled
 . D LMES("'OR EPCS CS RX BY PROVIDER' scheduled for "_WHEN,15)
 E  D  ;
 . S DT=$$NOW^XLFDT,YR=$E(DT,1,3)+1700,MN=$E(100+$E(DT,4,5),2,99) S MN=MN+1 I MN>12 S MN=1,YR=YR+1
 . S YR=YR-1700,WHEN=$P(YR_$E(MN+100,2,3)_"01",".")_".21"
 . D RESCH^XUTMOPT("OR EPCS CS RX BY PROVIDER",WHEN,"","1M","L")
 . S Y=WHEN
 . D DD^%DT
 . S WHEN=Y
 . D LMES("'OR EPCS CS RX BY PROVIDER' scheduled for "_WHEN,15)
 ;
 D LMES("Continuing...",20)
 D LMES("",1,"B")
 Q
LMES(STR,SPCNUM,BVAR) ; List text in output display
 ;
 ; INPUT:
 ;   STR    - String to output
 ;   SPCNUM - # Leading spaces
 ;   BVAR   - Null: Do not print a blank prior to text (Default) [MES]
 ;            "B" : Print a blank prior to text [BMES]
 N ORMSG
 S ORMSG=""
 S:+$G(SPCNUM)=0 SPCNUM=1
 S $P(ORMSG," ",+$G(SPCNUM))=STR
 D:$G(BVAR)'="B" MES^XPDUTL(ORMSG)
 D:$G(BVAR)="B" BMES^XPDUTL(ORMSG)
 Q
