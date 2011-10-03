IBCE835 ;ALB/TMP - 835 EDI EXPLANATION OF BENEFITS MSG PROCESSING ;19-JAN-99
 ;;2.0;INTEGRATED BILLING;**137,135,155,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ; MESSAGE HEADER DATA STRING =
 ;   type of message^msg queue^msg #^bill #^^date/time
 ;
HDR(IBCLNO,IBD) ;Process header data
 ; INPUT:
 ;   IBCLNO = claim #
 ;
 ;   ^TMP("IBMSGH",$J,0) = header message text
 ;
 ; OUTPUT:
 ;   IBD array returned with processed data
 ;      "LINE"  = The last line # populated in the message
 ;      "DATE"  = Date/Time of EOB (Fileman format)
 ;      "MRA"   = 1 if MRA, 0 if not
 ;      "X12"   = 1 if X12, 0 if not
 ;
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,0)=MESSAGE HEADER DATA STRING
 ;                                  ,"D",0,1)=header record raw data
 ;                                  ,"D1",1,0)=header record raw data
 ;                                  ,line #)=EOB message lines
 ;
 N CT,IB399,IBD0,IBBILL,LINE,L,X,Y,Z,%DT
 S IBD0=$G(^TMP("IBMSGH",$J,0)),IBD("LINE")=0
 Q:IBD0=""
 S X=$P(IBD0,U,3),X=$E(X,5,8)_$E(X,1,4)_"@"_$P(IBD0,U,4)
 I X S %DT="XTS" D ^%DT
 S IBD("DATE")=$S(Y>0:Y,1:"")
 S IBD("MRA")=$P(IBD0,U,5)
 S IBD("X12")=($P(IBD0,U,2)="X")
 S CT=0
 ;
 I $P(IBD0,U,6)'="" S CT=CT+1 S LINE(CT)=$G(LINE(CT))_"Payer Name: "_$P(IBD0,U,6)
 ;
 I CT D
 . S (L,Z)=0
 . F  S Z=$O(LINE(Z)) Q:'Z  S L=L+1,^TMP("IBMSG",$J,"CLAIM",IBCLNO,L)=LINE(Z)
 . S IBD("LINE")=IBD("LINE")+CT
 ;
 S IB399=+$O(^DGCR(399,"B",$$GETCLM^IBCE277(IBCLNO),""),-1)
 ;
 S IBBILL=$$LAST364^IBCEF4(IB399)
 ;
 S ^TMP("IBMSG",$J,"CLAIM",IBCLNO,0)="835EOB"_U_$G(IBD("MSG#"))_U_$G(IBD("SUBJ"))_U_IBBILL_U_U_IBD("DATE")
 ;
 S ^TMP("IBMSG",$J,"CLAIM",IBCLNO,"D",0,1)="##RAW DATA: "_IBD0
 S ^TMP("IBMSG",$J,"CLAIM",IBCLNO,"D1",1,0)="##RAW DATA: "_IBD0
 Q
 ;
5(IBD) ; Process claim patient ID data
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;
 ; OUTPUT:
 ;   IBD array
 ;      "LINE" = the last line # populated in the message
 ;
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,line#)=claim pt id message lines
 ;                                  ,"D",5,msg seq #)=
 ;                                  ,"D1",msg seq #,5)=
 ;                                       claim pt id message raw data
 ;
 N IBBILL
 S IBBILL=$$GETCLM^IBCE277($P(IBD,U,2))
 ;
 I '$D(^TMP("IBMSG",$J,"CLAIM",IBBILL)) D HDR(IBBILL,.IBD) ;Process header data if not already done for claim
 ;
 I $P(IBD,U,9) D  ;Statement dates
 . S IBD("LINE")=$G(IBD("LINE"))+1
 . S ^TMP("IBMSG",$J,"CLAIM",IBBILL,IBD("LINE"))="Statement Dates: "_$$DATE^IBCE277($P(IBD,U,9))_" - "_$$DATE^IBCE277($P(IBD,U,10))
 ;
 S ^TMP("IBMSG",$J,"CLAIM",IBBILL,"D",5,1)="##RAW DATA: "_IBD
 S ^TMP("IBMSG",$J,"CLAIM",IBBILL,"D1",1,5)="##RAW DATA: "_IBD
 Q
 ;
6(IBD) ; Process 06 record type for corrected name and/or ID# - IB*2*377 - 1/14/08
 NEW IBCLM,Z
 S IBCLM=$$GETCLM^IBCE277($P(IBD,U,2))
 Q:IBCLM=""
 I '$D(^TMP("IBMSG",$J,"CLAIM",IBCLM)) D HDR(IBCLM,.IBD)   ;Process header data if not already done for claim
 ;
 S Z=$G(IBD("LINE"))
 I $P(IBD,U,3)'="" S Z=Z+1,^TMP("IBMSG",$J,"CLAIM",IBCLM,Z)="Corrected Patient Last Name: "_$P(IBD,U,3)
 I $P(IBD,U,4)'="" S Z=Z+1,^TMP("IBMSG",$J,"CLAIM",IBCLM,Z)="Corrected Patient First Name: "_$P(IBD,U,4)
 I $P(IBD,U,5)'="" S Z=Z+1,^TMP("IBMSG",$J,"CLAIM",IBCLM,Z)="Corrected Patient Middle Name: "_$P(IBD,U,5)
 I $P(IBD,U,6)'="" S Z=Z+1,^TMP("IBMSG",$J,"CLAIM",IBCLM,Z)="Corrected Patient ID#: "_$P(IBD,U,6)
 S IBD("LINE")=Z
 ;
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",6,1)="##RAW DATA: "_IBD
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D1",1,6)="##RAW DATA: "_IBD
 Q
 ;
10(IBD) ; Process claim status data
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;
 ; OUTPUT:
 ;   IBD array returned with processed data
 ;      "CLAIM" = The claim #
 ;      "LINE" = The last line # populated in the message
 ;
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,line#)=claim status message lines
 ;                                  ,"D",10,msg seq #)=
 ;                                  ,"D1",msg seq #,10)=
 ;                                       claim status raw data
 ;
 N IBCLM,CT,LINE,L,Z,Z0,IBDATA,IBSTAT
 S IBCLM=$$GETCLM^IBCE277($P(IBD,U,2))
 Q:IBCLM=""
 ;
 I '$D(^TMP("IBMSG",$J,"CLAIM",IBCLM)) D HDR(IBCLM,.IBD) ;Process header data if not already done for claim
 ;
 S CT=0
 F Z=3:1:6 I $P(IBD,U,Z)="Y" D  Q  ;Claim status
 . S IBSTAT=(Z-2)
 . S CT=CT+1,LINE(CT)="CLAIM STATUS: "_$P("PROCESSED^DENIED^PENDED^REVERSAL",U,IBSTAT)
 I '$G(IBSTAT) D
 . S CT=CT+1,LINE(CT)="CLAIM STATUS: "_$P(IBD,U,7)_" (OTHER)"
 ;
 I $P(IBD,U,8)'="" D  ;Crossed over info
 . S LINE(CT)=LINE(CT)_"  Crossed over to: "_$P(IBD,U,9)_"  "_$P(IBD,U,8)
 ;
 I CT D
 . S L=$G(IBD("LINE")),Z=0
 . F  S Z=$O(LINE(Z)) Q:'Z  S L=L+1,^TMP("IBMSG",$J,"CLAIM",IBCLM,L)=LINE(Z)
 . S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",10,1)="##RAW DATA: "_IBD
 . S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D1",1,10)="##RAW DATA: "_IBD
 . S IBD("LINE")=$G(IBD("LINE"))+CT
 Q
 ;
15(IBD) ; Process claim status data
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;
 ; OUTPUT:
 ;   IBD array
 ;      "LINE" = The last line # populated in the message
 ;
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,"D",15,msg seq #)=
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,"D1",msg seq #,15)=
 ;                                       claim status raw data
 ;
 N IBCLM,Z,Z0,IBDATA
 S IBCLM=$$GETCLM^IBCE277($P(IBD,U,2))
 Q:IBCLM=""
 ;
 I '$D(^TMP("IBMSG",$J,"CLAIM",IBCLM)) D HDR(IBCLM,.IBD) ;Process header data if not already done for claim
 ;
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",15,1)="##RAW DATA: "_IBD
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D1",1,15)="##RAW DATA: "_IBD
 Q
 ;
20(IBD) ; Process claim level adjustment data
 ; Claim must have been referenced by a previous '05' level
 ;
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;
 ; OUTPUT:
 ;    IBD("LINE") = The last line # populated in the message
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,line #)=claim level adjustment
 ;                                  ,"D",20,seq#)=
 ;                                  ,"D1",seq#,20)=
 ;                                          claim level adjust. raw data
 ;
 N IBCLM
 S IBCLM=$$GETCLM^IBCE277($P(IBD,U,2))
 Q:'$D(^TMP("IBMSG",$J,"CLAIM",IBCLM))
 S IBD("LINE")=$G(IBD("LINE"))+1
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,IBD("LINE"))="ADJUSTMENT GROUP: "_$P(IBD,U,3)_"  QTY: "_+$P(IBD,U,6)_", AMT: "_($P(IBD,U,5)/100)
 S IBD("LINE")=IBD("LINE")+1
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,IBD("LINE"))="   REASON: ("_$P(IBD,U,4)_")  "_$P(IBD,U,7)
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",20,IBD("LINE"))="##RAW DATA: "_IBD
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D1",IBD("LINE"),20)="##RAW DATA: "_IBD
 Q
 ;
37(IBD) ; Process claim level adjustment data for Inpatient MEDICARE
 D 37^IBCE835A(.IBD)
 Q
 ;
40(IBD) ; Process service line data
 D 40^IBCE835A(.IBD)
 Q
 ;
45(IBD) ; Process service line adjustment data
 D 45^IBCE835A(.IBD)
 Q
 ;
17(IBD) ; Process claim contact data segment
 D XX(.IBD,17)
 Q
 ;
30(IBD) ; Process MEDICARE inpatient adjudication data (part 1)
 D XX(.IBD,30)
 Q
 ;
35(IBD) ; Process MEDICARE inpatient adjudication data (part 2)
 D XX(.IBD,35)
 Q
 ;
41(IBD) ; Process service line data (part 2)
 D XX(.IBD,41)
 Q
 ;
42(IBD) ; Process service line data (part 3)
 D XX(.IBD,42)
 Q
 ;
99(IBD) ; Process trailer record for non-MRA EOB
 D XX(.IBD,99)
 Q
 ;
XX(IBD,IBID) ; Store non-displayed data nodes in TMP array
 ;
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;   IBID = record id for generic store
 ;
 ; OUTPUT:
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,"D",IBID,msg seq #)=
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,"D1",msg seq #,IBID)=
 ;                                       claim status raw data
 ;    IBD("LINE") = The last line # populated in the message
 ;
 N IBCLM
 S IBCLM=$$GETCLM^IBCE277($P(IBD,U,2))
 ;
 S IBD("LINE")=$G(IBD("LINE"))+1
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",IBID,IBD("LINE"))="##RAW DATA: "_IBD
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D1",IBD("LINE"),IBID)="##RAW DATA: "_IBD
 ;
 Q
 ;
