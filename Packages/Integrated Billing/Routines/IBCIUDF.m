IBCIUDF ;DSI/SLM - CLAIMSMANAGER USER DEFINED FIELDS ;21-MAY-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N IBCIDFN,LINETAG,NUM F NUM=1:1:25 S LINETAG="UDF"_NUM D @LINETAG
 Q
UDF1 ;user defined field 1
 ;determine if a sensitive record.  Send "Y" if yes, "N" if no.
 S IBCIUDF(1)=$P($G(^DGCR(399,IBIFN,"U")),U,5)
 S IBCIUDF(1)=$S(IBCIUDF(1)=1:"Y",1:"N")
 Q
UDF2 ;user defined field 2
 ;determine the name of the coder to send.
 N IBCICODR S IBCIUDF(2)=""
 S IBCICODR=$$CODER^IBCIUT5(IBIFN),IBCICODR=$P(IBCICODR,U,3)
 I IBCICODR]"" S IBCIUDF(2)=IBCICODR
 Q
UDF3 ;user defined field 3
 ;determine the name of the biller to send.
 N IBCIBILR S IBCIUDF(3)=""
 S IBCIBILR=$$BILLER^IBCIUT5(IBIFN),IBCIBILR=$P(IBCIBILR,U,2)
 I IBCIBILR]"" S IBCIUDF(3)=IBCIBILR
 Q
UDF4 ;user defined field 4
 ;determine the type of plan for a specific payer sequence
 S IBCIUDF(4)=$$TOP^IBCIUT6(IBIFN)
 Q
UDF5 ;user defined field 5
 S IBCIUDF(5)=""
 Q
UDF6 ;user defined field 6
 S IBCIUDF(6)=""
 Q
UDF7 ;user defined field 7
 S IBCIUDF(7)=""
 Q
UDF8 ;user defined field 8
 S IBCIUDF(8)=""
 Q
UDF9 ;user defined field 9
 S IBCIUDF(9)=""
 Q
UDF10 ;user defined field 10
 S IBCIUDF(10)=""
 Q
UDF11 ;user defined field 11
 S IBCIUDF(11)=""
 Q
UDF12 ;user defined field 12
 S IBCIUDF(12)=""
 Q
UDF13 ;user defined field 13
 S IBCIUDF(13)=""
 Q
UDF14 ;user defined field 14
 S IBCIUDF(14)=""
 Q
UDF15 ;user defined field 15
 S IBCIUDF(15)=""
 Q
UDF16 ;user defined field 16
 S IBCIUDF(16)=""
 Q
UDF17 ;user defined field 17
 S IBCIUDF(17)=""
 Q
UDF18 ;user defined field 18
 S IBCIUDF(18)=""
 Q
UDF19 ;user defined field 19
 S IBCIUDF(19)=""
 Q
UDF20 ;user defined field 20
 S IBCIUDF(20)=""
 Q
UDF21 ;user defined field 21
 S IBCIUDF(21)=""
 Q
UDF22 ;user defined field 22
 S IBCIUDF(22)=""
 Q
UDF23 ;user defined field 23
 S IBCIUDF(23)=""
 Q
UDF24 ;user defined field 24
 S IBCIUDF(24)=""
 Q
UDF25 ;user defined field 25
 S IBCIUDF(25)=""
 Q
