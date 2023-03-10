LR7OV0 ;DALOI/STAFF - Update orderable items ;Mar 16, 2021@16:42
 ;;5.2;LAB SERVICE;**121,187,357,361,350,434,543**;Sep 27, 1994;Build 7
 ;
 ;Reference to ^ORD(101.43 supported by DBIA #2843
 ;
TEST(TEST,ICNT) ;Process single test
 ;TEST=test ptr to file 60
 ;ICNT=Current counter in ORUPDMSG(ICNT)
 N TYPE,TESTID,IFN,IFN1,CTR,CTR1,GENW,X0,S0,SAMP,MAX,DMAX,COLLECT,SAMPLE,SPEC,SUBID,SYN,COST,WCOM,Y9,Y10,Y11
 Q:'$D(^LAB(60,TEST,0))  S X0=^(0),COST=$P(X0,"^",11),SUB=$P(X0,"^",4),TYPE=$P(X0,"^",3),CTR1=0
 I $D(^LAB(60,TEST,6)) S (CTR,IFN)=0 F  S IFN=$O(^LAB(60,TEST,6,IFN)) Q:IFN<1  S CTR=CTR+1,GENW(CTR)=^(IFN,0)
 S (CTR,IFN)=0 F  S IFN=$O(^LAB(60,TEST,5,IFN)) Q:IFN<1  S CTR=CTR+1,SYN(CTR)=^(IFN,0)
 S (Y9,Y10,Y11)="" I $P($G(^LAB(60,TEST,64)),"^") S Y9=$P(^(64),"^"),Y10=$P(^LAM(Y9,0),"^"),Y9=$P(^(0),"^",2),Y11="99NLT"
 D
 . S (COLLECT,SAMP,SPEC)=0,TESTID=$$UVID^LR7OU0(TEST,+SPEC,Y9,Y11,Y10,"ORUPDMSG"),ICNT=ICNT+1,ORUPDMSG(ICNT)=$$MFE(MFECODE,TESTID)
 . S ICNT=ICNT+1,ORUPDMSG(ICNT)=$$ZLR("","",CTR1,SUB,"","",COST,TYPE)
 . S IFN1=0 F  S IFN1=$O(^LAB(60,TEST,2,IFN1)) Q:IFN1<1  S X=^(IFN1,0) I $D(^LAB(60,+X,0)) D
 .. N Y9,Y10,Y11 S (Y9,Y10,Y11)="" I $P($G(^LAB(60,+X,64)),"^") S Y9=$P(^(64),"^"),Y10=$P(^LAM(Y9,0),"^"),Y9=$P(^(0),"^",2),Y11="99NLT"
 .. S SUBID=$$UVID^LR7OU0($P(X,"^"),"",Y9,Y11,Y10,"ORUPDMSG"),ICNT=ICNT+1,ORUPDMSG(ICNT)="ZLC||||"_SUBID
 . D ZSY(.SYN),NTE(.GENW,.WCOM)
 Q
 ;
MFE(EVENT,KEY) ;MFE component
 ;EVENT=MAD-Add Record, MDL-Delete Record, MUP-Update Record
 ;      MDC-Deactivate, MAC-Reactivate
 N MFE
 S MFE="MFE|"_EVENT_"|||"_KEY
 Q MFE
 ;
ZLR(SPEC,COLLECT,SEQ,SUB,MAXORD,DMAXORD,COST,TYPE) ;ZLR component
 N ZLR
 S ZLR="ZLR|"_SPEC_"|"_COLLECT_"|"_SEQ_"|"_SUB_"|"_MAXORD_"|"_DMAXORD_"|"_COST_"|"_TYPE
 Q ZLR
 ;
ZSY(SYN) ;ZSY component
 N IFN
 S IFN=0 F  S IFN=$O(SYN(IFN)) Q:IFN<1  S ICNT=ICNT+1,ORUPDMSG(ICNT)="ZSY|"_IFN_"|"_SYN(IFN)
 Q
 ;
NTE(GEN,COM) ;NTE component
 N IFN,CTR S CTR=0
 S ICNT=ICNT+1 D NTE^LR7OU01(CTR,"P","GEN(",ICNT)
 S ICNT=ICNT+1 D NTE^LR7OU01(CTR,"P","COM(",ICNT)
 Q
 ;
MFI(EVENT) ;MFI component
 ;EVENT=REP for initial population of orderables
 ;     =UPD for subsequent updates
 N MFI
 S MFI="MFI|60^Lab Test^99DD||"_EVENT_"|||NE"
 Q MFI
 ;
SINGLE(TEST,MFICODE,MFECODE) ;Message for a single test
 ;TEST= ptr to test in file 60
 ;MFICODE=File Level Event Code
 ;MFECODE=Record Level Event Code
 ;N X,ORUPDMSG,MSG
 L +LR7OV0(TEST):9999
 S MSG="ORUPDMSG",X=$$MSH^LR7OU0("MFN"),ORUPDMSG(1)=X
 S X=$$MFI(MFICODE),ORUPDMSG(2)=X
 D TEST(TEST,2)
 ;W !!,$P(^LAB(60,TEST,0),"^"),! I $D(ORUPDMSG(3)) ZW ORUPDMSG
 ;
 ; If test deleted then mark file 101.43 entry as "inactive"
 I '$D(^LAB(60,TEST,0)) D
 . N TESTID
 . S MFECODE="MDC"
 . S TESTID=$$UVID^LR7OU0(TEST,0,"","","","ORUPDMSG")
 . S ORUPDMSG(3)=$$MFE(MFECODE,TESTID)
 . ;LR*5.2*543: send mail message for manual correction
 . D MAIL
 I $D(ORUPDMSG(3)) S ORUPDMSG="ORUPDMSG" D MSG^XQOR("LR7O ORDERABLE OR",.ORUPDMSG) ;Send update message
 L -LR7OV0(TEST)
 Q
 ;
MAIL ;
 ;LR*5.2*543
 N LR10143,LRNAME,LRMIN,LRMY,LRMSUB,LRMTEXT
 S LR10143=$P(TESTID,"^",4)_";"_$P(TESTID,"^",6)
 S LR10143=$O(^ORD(101.43,"ID",LR10143,0))
 Q:LR10143']""
 S LRNAME=$P($G(^ORD(101.43,LR10143,0)),"^")
 ;Do not send message if name begins with "ZZ".
 ;Transaction has been sent to CPRS to mark the OI inactive, but it
 ;might not have filed yet. So no need to check for the inactive field.
 I $E(LRNAME,1,2)="ZZ" Q
 S LRMIN("FROM")="ORDERABLE ITEMS UPDATE TASK"
 S LRMY(DUZ)="",LRMY("G.LMI")="",LRMY("G.OR CACS")=""
 S LRMSUB="ATTENTION: Lab Test Deleted"
 S LRMTEXT(1)="Lab test IEN: "_TEST_" ("_LRNAME_") has been deleted, but an orderable item"
 S LRMTEXT(2)="(IEN: "_LR10143_") exists in the ORDERABLE ITEMS (#101.43) file."
 S LRMTEXT(3)=" "
 S LRMTEXT(4)="The orderable item should be edited to prefix the name with ""ZZ"" and"
 S LRMTEXT(5)="make sure there is a date in the INACTIVATED (#.1) field."
 S LRMTEXT="LRMTEXT"
 D SENDMSG^XMXAPI(DUZ,LRMSUB,LRMTEXT,.LRMY,.LRMIN,"","")
 Q
 ;
ADD(TEST) ;Add single record to Master file
 N MFICODE,MFECODE S MFECODE="MAD",MFICODE="REP" D SINGLE(TEST,MFICODE,MFECODE)
 Q
 ;
DEL(TEST) ;Delete single record from Master file
 N MFICODE,MFECODE S MFECODE="MDL",MFICODE="UPD" D SINGLE(TEST,MFICODE,MFECODE)
 Q
 ;
UPD(TEST) ;Update record in Master file
 ;Modified for patch LR*5.2*361
 N ZTSAVE,ZTRTN,ZTDESC,ZTDTH,ZTIO
 S ZTSAVE("TEST")=TEST
 S ZTRTN="TUPD^LR7OV0"
 S ZTDESC="LABORATORY TEST FILE HL7 update message"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
TUPD ;Tasked update of record in Master file
 ;Added for patch LR*5.2*361
 N MFICODE,MFECODE S MFECODE="MUP",MFICODE="UPD" D SINGLE(TEST,MFICODE,MFECODE)
 Q
 ;
DEACT(TEST) ;Deactivate record in Master file
 N MFICODE,MFECODE S MFECODE="MDC",MFICODE="UPD" D SINGLE(TEST,MFICODE,MFECODE)
 Q
 ;
REACT(TEST) ;Reactivate record in Master file
 N MFICODE,MFECODE S MFECODE="MAC",MFICODE="UPD" D SINGLE(TEST,MFICODE,MFECODE)
 Q
 ;
 ;Following code added to support LR*5.2*357
 ;Following code modified to support LR*5.2*361
 ;Designed to help update the ORDERABLE ITEMS FILE (file 101.43) after the deletion
 ;of a SYNONYM from the LABORATORY TEST file (file 60).
UPD2(TEST,KSYN) ;Update record in Master file - Modified for LR*5.2*361
 ;TEST = IEN of lab test in file 60
 ;KSYN = IEN of synonym to be deleted from lab test in file 60
 ;Modified for LR*5.2*361
 N ZTSAVE,ZTRTN,ZTDESC,ZTDTH,ZTIO
 S ZTSAVE("TEST")=TEST
 S ZTSAVE("KSYN")=KSYN
 S ZTRTN="TUPD2^LR7OV0"
 S ZTDESC="LABORATORY TEST FILE HL7 update message"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
TUPD2 ;Update record in Master file
 ;TEST = IEN of lab test in file 60
 ;KSYN = IEN of synonym to be deleted from lab test in file 60
 N MFICODE,MFECODE S MFECODE="MUP",MFICODE="UPD" D SINGLE2(TEST,KSYN,MFICODE,MFECODE)
 Q
 ;
SINGLE2(TEST,KSYN,MFICODE,MFECODE) ;Message for a single test
 ;TEST = IEN of lab test in file 60
 ;KSYN = IEN of synonym to be deleted from lab test in file 60
 ;MFICODE = File Level Event Code
 ;MFECODE = Record Level Event Code
 N X,ORUPDMSG,MSG
 S MSG="ORUPDMSG",X=$$MSH^LR7OU0("MFN"),ORUPDMSG(1)=X
 S X=$$MFI(MFICODE),ORUPDMSG(2)=X
 D TEST2(TEST,KSYN,2)
 I $D(ORUPDMSG(3)) S ORUPDMSG="ORUPDMSG" D MSG^XQOR("LR7O ORDERABLE OR",.ORUPDMSG) ;Send update message
 Q
 ;
TEST2(TEST,KSYN,ICNT) ;Process single test
 ;TEST = IEN of lab test in file 60
 ;KSYN = IEN of synonym to be deleted from lab test in file 60
 ;ICNT = Current counter in ORUPDMSG(ICNT)
 N TYPE,TESTID,IFN,IFN1,CTR,CTR1,GENW,X0,S0,SAMP,MAX,DMAX,COLLECT,SAMPLE,SPEC,SYN,SUBID,COST,WCOM,Y9,Y10,Y11
 Q:'$D(^LAB(60,TEST,0))  S X0=^(0),COST=$P(X0,"^",11),SUB=$P(X0,"^",4),TYPE=$P(X0,"^",3),CTR1=0
 I $D(^LAB(60,TEST,6)) S (CTR,IFN)=0 F  S IFN=$O(^LAB(60,TEST,6,IFN)) Q:IFN<1  S CTR=CTR+1,GENW(CTR)=^(IFN,0)
 S (CTR,IFN)=0 F  S IFN=$O(^LAB(60,TEST,5,IFN)) Q:IFN<1  D
 . S:KSYN'=IFN CTR=CTR+1,SYN(CTR)=^LAB(60,TEST,5,IFN,0)
 S (Y9,Y10,Y11)="" I $P($G(^LAB(60,TEST,64)),"^") S Y9=$P(^(64),"^"),Y10=$P(^LAM(Y9,0),"^"),Y9=$P(^(0),"^",2),Y11="99NLT"
 D
 . S (COLLECT,SAMP,SPEC)=0,TESTID=$$UVID^LR7OU0(TEST,+SPEC,Y9,Y11,Y10,"ORUPDMSG"),ICNT=ICNT+1,ORUPDMSG(ICNT)=$$MFE(MFECODE,TESTID)
 . S ICNT=ICNT+1,ORUPDMSG(ICNT)=$$ZLR("","",CTR1,SUB,"","",COST,TYPE)
 . S IFN1=0 F  S IFN1=$O(^LAB(60,TEST,2,IFN1)) Q:IFN1<1  S X=^(IFN1,0) I $D(^LAB(60,+X,0)) D
 .. N Y9,Y10,Y11 S (Y9,Y10,Y11)="" I $P($G(^LAB(60,+X,64)),"^") S Y9=$P(^(64),"^"),Y10=$P(^LAM(Y9,0),"^"),Y9=$P(^(0),"^",2),Y11="99NLT"
 .. S SUBID=$$UVID^LR7OU0($P(X,"^"),"",Y9,Y11,Y10,"ORUPDMSG"),ICNT=ICNT+1,ORUPDMSG(ICNT)="ZLC||||"_SUBID
 . D ZSY(.SYN),NTE(.GENW,.WCOM)
 Q
