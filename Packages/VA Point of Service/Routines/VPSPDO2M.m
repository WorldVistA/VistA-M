VPSPDO2M  ;DALOI/KML,WOIFO/BT -  PDO OUTPUT DISPLAY - MEDS ;11/20/11 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Oct 21, 2011;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;IA #10103 - supported use of XLFDT functions
 ;IA #10104 - supported use of XLFSTR function
 ;IA #4533 - supported use of DATA^PSS50 procedure
 ; the medication section of the PDO output specifically for the PATIENT ENTERED ALLERGY MEDICATION REVIEW
 ;  which can be invoked by CPRS TIU components and as an RPC to be called by Vetlink staff-facing interface
 ;
MEDCHNG(OREF,SAVMEDS) ;
 ; INPUT
 ;   OREF    : Object Reference for the VPS PDO object (contains all properties)
 ;   SAVMEDS : array represents the list of active and past medications.  
 ;             Will be used to determine if any changes have occurred since last MRAR.
 ; 
 ; per MRAR requirements for CHANGES SINCE last MRAR a change to the patient's medication profile is:
 ; RX status changes since last MRAR or if a medication was added to the patient's medication profile
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N RXDATA D GET52(OREF,.RXDATA) ; get local med data in file #52
 Q:'$D(RXDATA)
 ; 
 D ADDBLANK^VPSOBJ(OREF) ; add blank line between last section
 D ADDUNDLN^VPSOBJ(OREF) ; DISPLAY UNDERSCORE
 D ADDCJ^VPSOBJ(OREF,"***   CHANGES TO OUTPATIENT MEDICATIONS SINCE MRAR LAST COMPLETED   ***")
 ;
 N VPSX S VPSX=""
 N RXIEN S RXIEN=0
 ;
 F  S RXIEN=$O(RXDATA(RXIEN)) Q:'RXIEN  D
 . I '$D(SAVMEDS(RXDATA(RXIEN,"MEDNAME"))) S ACTION="Filled"   ; added medication since last MRAR
 . E  S ACTION=$S($P(RXDATA(RXIEN,"STATUS"),U,2)["DISCONTINUED":"Discontinued",$P(RXDATA(RXIEN,"STATUS"),U,2)="EXPIRED":"Discontinued",1:"Filled")
 . S VPSX="",VPSX=$$SETFLD^VPSPUTL1(RXDATA(RXIEN,"MEDNAME"),VPSX,COL("MEDNAME"))
 . D ADDPDO^VPSOBJ(OREF,VPSX)
 . I ACTION="Filled" D
 . . S VPSX="",VPSX=$$SETFLD^VPSPUTL1(RXDATA(RXIEN,"SIG"),VPSX,COL("SIG"))
 . . S VPSX=$$SETFLD^VPSPUTL1("Refills left: "_RXDATA(RXIEN,"REFILLS LEFT")_" of "_RXDATA(RXIEN,"# OF REFILLS"),VPSX,COL("REFILLS"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 . . S VPSX="",VPSX=$$SETFLD^VPSPUTL1("Provider: "_RXDATA(RXIEN,"PROVIDER"),VPSX,COL("PROVIDER"))
 . . S VPSX=$$SETFLD^VPSPUTL1("Days supplied: "_RXDATA(RXIEN,"DAYS SUPPLIED"),VPSX,COL("DAYS SUPPLIED"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 . . S VPSX="",VPSX=$$SETFLD^VPSPUTL1("Filled: "_RXDATA(RXIEN,"LAST FILLED")_"d ago",VPSX,COL("FILLED"))
 . . S VPSX=$$SETFLD^VPSPUTL1("Action: "_ACTION,VPSX,COL("MEDS ACTION"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 . I ACTION="Discontinued" D
 . . S VPSX="",VPSX=$$SETFLD^VPSPUTL1(RXDATA(RXIEN,"SIG"),VPSX,COL("SIG"))
 . . S VPSX=$$SETFLD^VPSPUTL1("Action: "_ACTION,VPSX,COL("MEDS ACTION"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 ;
 D ADDBLANK^VPSOBJ(OREF)
 S VPSX="",VPSX=$$SETFLD^VPSPUTL1("Pending medications will NOT display in this section. Please check",VPSX,COL("PENDING STMT"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 S VPSX="",VPSX=$$SETFLD^VPSPUTL1("medication orders for any pending medications that may have been",VPSX,COL("PENDING STMT"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 S VPSX="",VPSX=$$SETFLD^VPSPUTL1("entered since MRAR completed.",VPSX,COL("PENDING STMT"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 Q
 ;
GET52(OREF,RXDATA) ;  get medication profile from PRESCRIPTION file (#52)
 ; INPUT
 ;   OREF   : Object Reference for the VPS PDO object (contains all properties)
 ;   RXDATA : array of data extracted from the temporary global array produced by RX^PSO52API
 ;
 ; ICR 4820 - supported API for outpatient pharmacy procedure RX^PSO52API
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 K ^TMP($J,"VPSPDO1M")
 K RXDATA
 ;
 D RX^PSO52API(PTIEN,"VPSPDO1M",,,"2,M,P,R,ST")  ; get all active medications for today
 D BLD52(OREF,.RXDATA)
 D RX^PSO52API(PTIEN,"VPSPDO1M",,,"2,M,P,R,ST",$P(LMRARDT,"."),DT)  ;date arguments will catch any expired medications between the date of the last mrar and current date
 D BLD52(OREF,.RXDATA)
 Q
 ;
BLD52(OREF,RXDATA) ;
 ; INPUT
 ;   RXDATA - array of data extracted from the temporary global array produced by RX^PSO52API
 ;   RXDATA : array of data extracted from the temporary global array produced by RX^PSO52API
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 Q:$P(^TMP($J,"VPSPDO1M",PTIEN,0),U,2)="NO DATA FOUND"
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 N RXIEN S RXIEN=0
 ;
 F  S RXIEN=$O(^TMP($J,"VPSPDO1M",PTIEN,RXIEN)) Q:'RXIEN  D
 . N FILLED S FILLED=$P(^TMP($J,"VPSPDO1M",PTIEN,RXIEN,22),U)
 . Q:LMRARDT>FILLED  ;medication in local Rx file is older than VPS transaction date/timestamp; does not count as a change
 . S RXDATA(RXIEN,"PROVIDER")=$P(^TMP($J,"VPSPDO1M",PTIEN,RXIEN,4),U,2)
 . S RXDATA(RXIEN,"MEDNAME")=$$GTDRGNM(^TMP($J,"VPSPDO1M",PTIEN,RXIEN,6))
 . S RXDATA(RXIEN,"DAYS SUPPLIED")=^TMP($J,"VPSPDO1M",PTIEN,RXIEN,8)
 . S RXDATA(RXIEN,"# OF REFILLS")=^TMP($J,"VPSPDO1M",PTIEN,RXIEN,9)
 . S RXDATA(RXIEN,"STATUS")=$P(^TMP($J,"VPSPDO1M",PTIEN,RXIEN,100),2)
 . N REFNUM S REFNUM=^TMP($J,"VPSPDO1M",PTIEN,RXIEN,"RF",0)  ; NUMBER OF REFILLS PERFORMED
 . S RXDATA(RXIEN,"REFILL#")=$S($P(REFNUM,U)=-1:0,1:REFNUM)
 . I RXDATA(RXIEN,"REFILL#") S FILLED=$P(^TMP($J,"VPSPDO1M",PTIEN,RXIEN,"RF",RXDATA(RXIEN,"REFILL#"),.01),U)
 . S:'RXDATA(RXIEN,"REFILL#") RXDATA(RXIEN,"REFILL#")=1
 . S RXDATA(RXIEN,"SIG")=^TMP($J,"VPSPDO1M",PTIEN,RXIEN,"M",1,0)
 . S RXDATA(RXIEN,"LAST FILLED")=$S(FILLED]"":$$FMDIFF^XLFDT(DT,FILLED),1:"")
 . S RXDATA(RXIEN,"REFILLS LEFT")=RXDATA(RXIEN,"# OF REFILLS")-RXDATA(RXIEN,"REFILL#")
 Q
 ;
GTDRGNM(DRUG) ; Get Drug Name
 ; INPUT
 ;   DRUG  : Drug IEN ^ local drug name (file #52)
 ; RETURN
 ;   DRUG NAME
 ;
 ; LOGIC
 ;  if available use the VA Print Name (File 50.68/Field 5)
 ;  otherwise Use the Local Print Name.
 ;  To get VA Print Name:
 ;  A. From File 52 - PRESCRIPTION, go first to File 52/Field 6 and follow the pointer to File 50 - DRUG.
 ;  B. Check File 50/Field 22. 
 ;     If the pointer is available, follow this to File 50.68 (VA PRODUCT) and go to step C.
 ;     If the pointer is unavailable, use the name in File 50/Field .01 (GENERIC NAME).
 ;  C. In File 50.68, use the name in File 50.68/Field 5 (VA PRINT NAME)
 ;
 N DRUGIEN S DRUGIEN=$P(DRUG,U)
 Q:DRUGIEN="" ""
 N DRUGNM S DRUGNM=$P(DRUG,U,2) ;local drug name from File 52
 K ^TMP($J,"VPSPDO2M",DRUGIEN)
 D DATA^PSS50(DRUGIEN,,,,,"VPSPDO2M") ;Supported DBIA 4533
 N VADRGIEN S VADRGIEN=$P($G(^TMP($J,"VPSPDO2M",DRUGIEN,22)),U)
 N VAPROD S VAPROD=$$PROD2^PSNAPIS(,VADRGIEN) ;supported ICR 2531
 N VADRGNM S VADRGNM=$P(VAPROD,U) ; VA PRNT NAME
 S:VADRGNM]"" DRUGNM=VADRGNM
 K ^TMP($J,"VPSPDO2M",DRUGIEN)
 Q DRUGNM
