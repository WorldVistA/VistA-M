IBATLM3A ;LL/ELZ - TRANSFER PRICING PT INFO SCREEN BUILD ; 16-APR-1999
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N IBX,IBY,IBINPT,IBINS,IBCNT K ^TMP("IBATPT",$J)
 ;
 S IBCNT=0
 S VAIP("D")="LAST" D A5^VADPT ; dbia 10061
 S IBINPT=$G(^DPT(DFN,.105)) ; dbia 10035
 S IBINS=$$INSURED^IBCNS1(DFN)
 ;
 S IBY=""
 D SET("*** Demographic Information ***",.IBY,24,31)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,24,31,IOINHI,IOINORM)
 D SETVALM(.VALMCNT,"")
 ;
 D SET("Sex:",.IBY,21,4)
 D SET($P(VADM(5),"^",2),.IBY,26,15)
 D SET("Date of Birth:",.IBY,52,14)
 D SET($P(VADM(3),"^",2),.IBY,67,13)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("Primary Care Provider:",.IBY,3,22)
 D SET($P($$OUTPTPR^SDUTL3(DFN),"^",2),.IBY,26,15) ; dbia 1252
 D SET("Date of Death:",.IBY,52,14)
 D SET($$DATE(+VADM(6)),.IBY,67,13)
 D SETVALM(.VALMCNT,.IBY)
 D SETVALM(.VALMCNT,"")
 ;
 D SET("Address:",.IBY,17,8)
 F IBX=1:1:3 D:VAPA(IBX)'=""
 . D SET(VAPA(IBX),.IBY,26,30)
 . D SETVALM(.VALMCNT,.IBY)
 D:IBY'="" SETVALM(.VALMCNT,.IBY)
 ;
 D SET(VAPA(4)_", "_$P(VAPA(5),"^",2)_"  "_VAPA(6),.IBY,26,30)
 D SETVALM(.VALMCNT,.IBY)
 D SETVALM(.VALMCNT,"")
 D SETVALM(.VALMCNT,"")
 ;
 D SET("*** Eligibility Information ***",.IBY,24,31)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,24,31,IOINHI,IOINORM)
 D SETVALM(.VALMCNT,"")
 ;
 D SET("Patient Type:",.IBY,12,13)
 D SET($P(VAEL(6),"^",2),.IBY,26,15)
 D SET("Means Test Status:",.IBY,48,18)
 D SET($P(VAEL(9),"^",2),.IBY,67,13)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("Primary Eligibility:",.IBY,5,20)
 D SET($P(VAEL(1),"^",2),.IBY,26,15)
 D SET("Enrollment Priority:",.IBY,46,31)
 D SET($$PRIORITY^DGENA(DFN),.IBY,67,3) ; dbia #2918
 D SETVALM(.VALMCNT,.IBY)
 D SETVALM(.VALMCNT,"")
 ;
 D SET("Secondary Eligibilities:",.IBY,1,24)
 S IBX=0 F  S IBX=$O(VAEL(1,IBX)) Q:IBX<1  D
 . D SET($P(VAEL(1,IBX),"^",2),.IBY,26,30)
 . D SETVALM(.VALMCNT,.IBY)
 D:IBY'="" SETVALM(.VALMCNT,.IBY)
 D SETVALM(.VALMCNT,"")
 ;
 D SETVALM(.VALMCNT,"")
 D SET("*** Insurance Information ***",.IBY,25,29)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,25,29,IOINHI,IOINORM)
 D SETVALM(.VALMCNT,"")
 ;
 I IBINS D ALL^IBCNS1(DFN,"^TMP(""IBINS"",$J)",1) D  K ^TMP("IBINS",$J)
 . S IBX=0 F  S IBX=$O(^TMP("IBINS",$J,IBX))  Q:IBX<1  S IBX(0)=^(IBX,0) D
 .. D SET($P(^DIC(36,+IBX(0),0),"^"),.IBY,5,30)
 .. D SET($P(IBX(0),"^",2),.IBY,35,15)
 .. I $P(IBX(0),"^",18),$D(^IBA(355.3,$P(IBX(0),"^",18),0)) D SET($P(^IBA(355.3,$P(IBX(0),"^",18),0),"^",3),.IBY,60,20)
 .. D SETVALM(.VALMCNT,.IBY)
 E  D SET("Patient has no active insurance information",.IBY,5,75),SETVALM(.VALMCNT,.IBY)
 D SETVALM(.VALMCNT,"")
 ;
 D SETVALM(.VALMCNT,"")
 D SET("*** Inpatient Information ***",.IBY,26,29)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,26,29,IOINHI,IOINORM)
 D SETVALM(.VALMCNT,"")
 ;
 D SET("Inpatient Status:",.IBY,8,17)
 D SET($S(IBINPT:"Active",1:"Inactive"),.IBY,26,10)
 D SETVALM(.VALMCNT,.IBY)
 ;
 D SET("Last Admission:",.IBY,10,17)
 D SET($S(VAIP(1)="":"Never Admitted",1:$P(VAIP(13,1),"^",2)),.IBY,26,17)
 D SET("Ward Location:",.IBY,47,14)
 D SET($P(VAIP(13,4),"^",2),.IBY,62,18)
 D SETVALM(.VALMCNT,.IBY)
 D SETVALM(.VALMCNT,"")
 ;
 D APPTS
 ;
 D KVAR^VADPT ; dbia 10061
 ;
 Q
APPTS ; -- displays last 5 appointments
 ;
 D SETVALM(.VALMCNT,"")
 D SET("*** Last Outpatient Appointments ***",.IBY,22,36)
 D SETVALM(.VALMCNT,.IBY)
 D CNTRL^VALM10(VALMCNT,22,36,IOINHI,IOINORM)
 D SETVALM(.VALMCNT,"")
 ;
 N IBVAL,IBFILTER
 S IBVAL("DFN")=DFN
 S IBVAL("BDT")=0
 S IBVAL("EDT")=$$NOW^XLFDT
 ; screen children and inpatient encounters
 S IBFILTER="I '$P(Y0,""^"",6),$P(Y0,""^"",12)'=8"
 ;
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,IBFILTER,"D APPTCB^IBATLM3A",0,,"BACKWARD")
 ;
 Q
APPTCB ; call back for scan to set up global
 ;
 D SET($$DATE($P(Y0,"^"),5),.IBY,5,17)
 D SET($P(^SC($P(Y0,"^",4),0),"^"),.IBY,25,30) ; dbia 10040
 D SET($$EX^IBATUTL(409.68,.12,$P(Y0,"^",12)),.IBY,60,20)
 D SETVALM(.VALMCNT,.IBY)
 ;
 S IBCNT=IBCNT+1
 S:IBCNT>4 SDSTOP=1
 Q
 ;
SET(TEXT,STRING,COL,LENGTH) ; -- set up string with valm1
 S STRING=$$SETSTR^VALM1($$LOWER^VALM1(TEXT),STRING,COL,LENGTH)
 Q
SETVALM(LINE,TEXT) ; -- sets line for display
 S LINE=LINE+1
 S ^TMP("IBATPT",$J,LINE,0)=TEXT
 S TEXT=""
 Q
DATE(X,Y) ; -- returns date for display
 S:'$D(Y) Y="5D"
 Q $S(X:$$FMTE^XLFDT(X,Y),1:"")
