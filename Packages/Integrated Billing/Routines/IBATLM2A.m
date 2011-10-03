IBATLM2A ;LL/ELZ - TRANSFER PRICING PT TRANSACTION DETAIL ; 15-SEP-1998
 ;;2.0;INTEGRATED BILLING;**115,210,266,309,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 N IBX,IBY K ^TMP("IBATEE",$J)
 F IBX=0,4,5,6 S IBDATA(IBX)=$G(^IBAT(351.61,IBIEN,IBX))
 ;
 S IBY=""
 D SET("*** General Information ***",.IBY,26,27)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,26,27,IOINHI,IOINORM)
 D SETVALM(.VALMCNT,"")
 ;
 D SET("Transaction Date:",.IBY,1,17)
 D SET($$DATE($P(IBDATA(0),"^",3)),.IBY,19,19)
 D SET("Event Date:",.IBY,48,11)
 D SET($$DATE($P(IBDATA(0),"^",4)),.IBY,60,20)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("Status:",.IBY,11,7)
 D SET($$EX^IBATUTL(351.61,.05,$P(IBDATA(0),"^",5)),.IBY,19,19)
 D SET("Priced Date:",.IBY,47,12)
 D SET($$DATE($P(IBDATA(0),"^",13)),.IBY,60,20)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("From Date:",.IBY,8,10)
 D SET($$DATE($P(IBDATA(0),"^",9)),.IBY,19,19)
 D SET("To Date:",.IBY,51,8)
 D SET($$DATE($P(IBDATA(0),"^",10)),.IBY,60,20)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("Facility:",.IBY,9,9)
 D SET($$EX^IBATUTL(351.61,.11,$P(IBDATA(0),"^",11)),.IBY,19,19)
 D SETVALM(.VALMCNT,.IBY),SETVALM(.VALMCNT,""),SETVALM(.VALMCNT,"")
 ;
 D SET("*** Workload/Pricing Detail ***",.IBY,24,31)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,24,31,IOINHI,IOINORM)
 ;
 D @$S($P(IBDATA(0),"^",12)["DGPM(":"INPT",$P(IBDATA(0),"^",12)["SCE(":"OUT",$P(IBDATA(0),"^",12)["RMPR(":"RMPR",1:"RX")
 ;
 D SETVALM(.VALMCNT,"")
 D SET("*** Totals ***",.IBY,33,14)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,26,28,IOINHI,IOINORM)
 D SETVALM(.VALMCNT,"")
 ;
 D SET("Bill Amount:",.IBY,6,18)
 D SET($FN($P(IBDATA(6),"^",2),"",2),.IBY,25,54)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("Patient Copay:",.IBY,6,14)
 S $P(IBDATA(6),"^",3)=$$COPAY^IBATUTL(DFN,$P(IBDATA(0),"^",12),$P(IBDATA(0),"^",9),$P(IBDATA(0),"^",10))
 D SET($FN($P(IBDATA(6),"^",3),"",2),.IBY,26,54)
 D SETVALM(.VALMCNT,.IBY)
 ;
 Q
INPT ; -- detail display for inpatient
 N IBDRG,VAIP
 ;
 S IBDRG=$G(^IBAT(351.61,IBIEN,1))
 ;
 S VAIP("E")=+$P(IBDATA(0),"^",12) D IN5^VADPT
 ;
 D SETVALM(.VALMCNT,"")
 D SET("Admission Date:",.IBY,3,15)
 D SET($P(VAIP(13,1),"^",2),.IBY,19,19)
 D SET("Discharge Date:",.IBY,44,15)
 D SET($P(VAIP(17,1),"^",2),.IBY,60,20)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("Ward Location:",.IBY,4,14)
 D SET($P(VAIP(5),"^",2),.IBY,19,19)
 D SET("Treating Specialty:",.IBY,40,19)
 D SET($P(VAIP(8),"^",2),.IBY,60,20)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("DRG:",.IBY,14,4)
 D SET($$EX^IBATUTL(351.61,1.01,$P(IBDRG,"^")),.IBY,19,19)
 D SET("DRG Charge:",.IBY,48,11)
 D SET($FN($P(IBDRG,"^",2),"",2),.IBY,60,20)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("Inpatient LOS:",.IBY,4,14)
 D SET(+$P(IBDRG,"^",3),.IBY,19,19)
 D SET("High Trim Days:",.IBY,44,15)
 D SET(+$P(IBDRG,"^",4),.IBY,60,20)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("Outlier Days:",.IBY,5,13)
 D SET(+$P(IBDRG,"^",5),.IBY,19,19)
 D SET("Outlier Rate:",.IBY,46,13)
 D SET($FN($P(IBDRG,"^",6),"",2),.IBY,60,20)
 D SETVALM(.VALMCNT,.IBY)
 Q
OUT ; -- detail display for outpatient
 N IBX,IBDXLIST,IBSCE,IBPROV,IBDATE
 ;
 D GETGEN^SDOE($P($P(IBDATA(0),"^",12),";"),"IBSCE")
 D GETPRV^SDOE($P($P(IBDATA(0),"^",12),";"),"IBPROV")
 ;
 D GETDX^SDOE($P($P(IBDATA(0),"^",12),";"),"IBDXLIST")
 S IBDATE=$P($G(IBDATA(0)),U,4) ; Event date
 D DX(.IBDXLIST,IBDATE)
 ;
 D SET("Procedure Information:",.IBY,1,22)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,1,22,IOINHI,IOINORM)
 ;
 S IBX=0 F  S IBX=$O(^IBAT(351.61,IBIEN,3,IBX)) Q:IBX<1  D
 . S IBX(0)=$G(^IBAT(351.61,IBIEN,3,IBX,0))
 . S IBX(1)=$$PROC^IBATUTL($P(IBX(0),U),IBDATE)
 . ;
 . D SET(+IBX(1),.IBY,5,6)
 . D SET("-",.IBY,13,1)
 . D SET($P(IBX(1),"^",2),.IBY,15,40)
 . D SET(+$P(IBX(0),"^",2),.IBY,57,3)
 . D SET("x",.IBY,62,1)
 . D SET($FN($P(IBX(0),"^",3),"",2),.IBY,64,15)
 . D SETVALM(.VALMCNT,.IBY)
 D SETVALM(.VALMCNT,"")
 ;
 D SET("Visit Information:",.IBY,1,18)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,1,22,IOINHI,IOINORM)
 ;
 D SET("Location:",.IBY,8,14)
 D SET($P(^SC(+$P(IBSCE(0),"^",4),0),"^"),.IBY,19,46) ; dbia 10040
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SETVALM(.VALMCNT,"")
 D SET("Provider(s):",.IBY,5,17)
 S IBX=0 F  S IBX=$O(IBPROV(IBX)) Q:IBX<.5  D
 . D SET($$GET1^DIQ(200,+IBPROV(IBX),.01),.IBY,19,49) ; dbia 10060
 . D SETVALM(.VALMCNT,.IBY)
 ;
 Q
RX ; -- detail display for rx
 D SET("Drug:",.IBY,5,5)
 D ZERO^IBRXUTL(+IBDATA(4))
 D SET(^TMP($J,"IBDRUG",+IBDATA(4),.01),.IBY,12,40) ; dbia 4533
 D SET(+$P(IBDATA(4),"^",2),.IBY,55,3)
 D SET("x",.IBY,60,1)
 D SET($FN($P(IBDATA(4),"^",3),"",3),.IBY,62,15)
 D SETVALM(.VALMCNT,.IBY)
 D SETVALM(.VALMCNT,"")
 K ^TMP($J,"IBDRUG")
 Q
RMPR ; -- detail display for prosthetic
 D SETVALM(.VALMCNT,"")
 D SET("Prosthetic Item:",.IBY,5,16)
 D SET($P($$PIN^IBATUTL(+$P(IBDATA(0),"^",12)),U,2),.IBY,23,30) ; dbia 374
 D SET($FN($P(IBDATA(4),"^",5),",",2),.IBY,58,15)
 D SETVALM(.VALMCNT,.IBY)
 D SETVALM(.VALMCNT,"")
 Q
DX(IBDX,IBDATE) ; -- diagnosis info
 N IBX
 ;
 D SETVALM(.VALMCNT,"")
 D SET("Diagnosis Information:",.IBY,1,22)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,1,22,IOINHI,IOINORM)
 ;
 S IBX=0 F  S IBX=$O(IBDX(IBX)) Q:IBX<1  D
 . S IBX(0)=$$ICD9^IBACSV(+IBDX(IBX),$G(IBDATE))
 . ;
 . D SET($P(IBX(0),"^"),.IBY,5,7)
 . D SET("-",.IBY,14,1)
 . D SET($P(IBX(0),"^",3),.IBY,16,30)
 . D SETVALM(.VALMCNT,.IBY)
 D SETVALM(.VALMCNT,"")
 Q
SET(TEXT,STRING,COL,LENGTH) ; -- set up string with valm1
 S STRING=$$SETSTR^VALM1($$LOWER^VALM1(TEXT),STRING,COL,LENGTH)
 Q
SETVALM(LINE,TEXT) ; -- sets line for display
 S LINE=LINE+1
 S ^TMP("IBATEE",$J,LINE,0)=TEXT
 S TEXT=""
 Q
DATE(X) ; -- returns date for display
 Q $$FMTE^XLFDT(X,"5D")
