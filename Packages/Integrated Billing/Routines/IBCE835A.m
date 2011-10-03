IBCE835A ;ALB/ESG - 835 EDI EOB PROCESSING CONTINUED ;30-APR-03
 ;;2.0;INTEGRATED BILLING;**135**;21-MAR-94
 Q
 ; Continue processing of IBCE835 since that routine grew too large
 ;
37(IBD) ; Process claim level adjustment data for Inpatient MEDICARE
 ; Claim must have been referenced by a previous '05' level
 ;
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;
 ; OUTPUT:
 ;    IBD("LINE") = The last line # populated in the message
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,line #)=claim level adjustment msg
 ;                                  ,"D",37,seq#)=
 ;                                  ,"D1",seq#,37)=
 ;                                          claim level adjust. raw data
 ;
 N IBCLM
 S IBCLM=$$GETCLM^IBCE277($P(IBD,U,2))
 Q:'$D(^TMP("IBMSG",$J,"CLAIM",IBCLM))
 S IBD("LINE")=$G(IBD("LINE"))+1
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,IBD("LINE"))=$S($D(^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",37)):$J("",34),1:"MEDICARE ADJUDICATION MESSAGE(S): ")_"("_$P(IBD,U,4)_")  "_$P(IBD,U,5)
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",37,IBD("LINE"))="##RAW DATA: "_IBD
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D1",IBD("LINE"),37)="##RAW DATA: "_IBD
 Q
 ;
40(IBD) ; Process service line data
 ;
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;
 ; OUTPUT:
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,"D",40,msg seq #)=
 ;                                   "D1",msg seq #,40)=
 ;                                       claim status raw data
 ;    IBD("LINE") = The last line # populated in the message
 ;
 N IBCLM
 S IBCLM=$$GETCLM^IBCE277($P(IBD,U,2))
 S IBD("LINE")=$G(IBD("LINE"))+1
 ;
 I '$D(^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",40)) D
 . S ^TMP("IBMSG",$J,"CLAIM",IBCLM,IBD("LINE"))="Line level detail exists for this claim"
 . S IBD("LINE")=IBD("LINE")+1
 ;
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",40,IBD("LINE"))="##RAW DATA: "_IBD
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D1",IBD("LINE"),40)="##RAW DATA: "_IBD
 ;
 Q
 ;
45(IBD) ; Process service line adjustment data
 ;
 ; INPUT:
 ;   IBD must be passed by reference = entire message line
 ;
 ; OUTPUT:
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,"D",45,msg seq #)=
 ;   ^TMP("IBMSG",$J,"CLAIM",claim #,"D1",msg seq #,45)=
 ;                                       claim status raw data
 ;    IBD("LINE") = The last line # populated in the message
 ;
 N IBCLM
 S IBCLM=$$GETCLM^IBCE277($P(IBD,U,2))
 S IBD("LINE")=$G(IBD("LINE"))+1
 ;
 I '$D(^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",45)) D
 . S ^TMP("IBMSG",$J,"CLAIM",IBCLM,IBD("LINE"))="Line level adjustments exist for this claim"
 . S IBD("LINE")=IBD("LINE")+1
 ;
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D",45,IBD("LINE"))="##RAW DATA: "_IBD
 S ^TMP("IBMSG",$J,"CLAIM",IBCLM,"D1",IBD("LINE"),45)="##RAW DATA: "_IBD
 ;
 Q
 ;
