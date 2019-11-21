IBCNERTU ;AITC/TAZ - eIV Processing Real-Time Inquiries ;13-MAR-19
 ;;2.0;INTEGRATED BILLING;**631**;;Build 23;
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
TQ(WEXT,IEN,FRESHDT,DFN,PIEN,OVRFRESH,SRVICEDT) ; Determine how many entries to create in the TQ file and set entries
 ;
 ;INPUT:
 ; WEXT - Which Extract Internal Value (#365.1,.1)
 ; IEN - internal # for the buffer record in file #355.33
 ; FRESHDT - (Service Date - Freshday)- used to check verified date
 ; DFN - Patient's IEN (file 2)
 ; PIEN - Payer's IEN (file 365.12)
 ; OVRFRESH - Freshness OvrRd flag (#355.33,13)
 ; SRVICEDT- Service date (#355.33,18)
 ; 
 N BSID,PASSBUF,PATID,PREL,SID,SIDACT,SIDARRAY,SIDDATA
 ;
 K SIDARRAY
 S BSID=$$GET1^DIQ(355.33,IEN_",",90.03)  ; Subscriber ID from buffer
 S PATID=$$GET1^DIQ(355.33,IEN_",",62.01) ; Patient ID from buffer
 S PREL=$$GET1^DIQ(355.33,IEN_",",60.14,"I")  ; Pat. relationship from buffer
 S SIDDATA=$$SIDCHK^IBCNEDE5(PIEN,DFN,BSID,.SIDARRAY,FRESHDT) ;determine rules to follow
 S SIDACT=$P(SIDDATA,U,1)
 ;
 I SIDACT=3 D BUFF^IBCNEUT2(IEN,18) Q   ; update buffer w/ bang & quit - no subscriber id
 I PREL'=18 D  Q   ; Not Equal to Self/Patient
 .I PATID="" D BUFF^IBCNEUT2(IEN,23) Q  ; update buffer w/ bang & quit - no patient id
 .D SET(IEN,OVRFRESH,1,"") ; set TQ entry
 .Q
 S SID=""
 F  S SID=$O(SIDARRAY(SID)) Q:SID=""  D:$P(SID,"_")'="" SET(IEN,OVRFRESH,1,$P(SID,"_")) ; set TQ w/ 'Pass Buffer' flag
 I SIDACT=4 D SET(IEN,OVRFRESH,1,"") ; set TQ w/ 'Pass Buffer' flag w/ blank subscriber ID
 Q
 ;
 ;
SET(BUFFIEN,OVRFRESH,PASSBUF,SID1) ; Set data and check if set already
 N DATA1,DATA2,DATA5,IBMBI,ORIG
 D RET(.ORIG)
 ;
 ; The hard coded '1' in the 3rd piece of DATA1 sets the Transmission
 ; status of file 365.1 to "Ready to Transmit"
 S DATA1=DFN_U_PIEN_U_1_U_$G(BUFFIEN)_U_SID1_U_FRESHDT_U_PASSBUF ; SETTQ parameter 1
 S $P(DATA1,U,8)=PATID
 ;
 S DATA2=WEXT_U_"V"_U_SRVICEDT_U_"" ; SETTQ parameter 2
 ;
 S DATA5=$$GET1^DIQ(355.33,BUFFIEN_",",.03,"I") ;copy SOI IEN to TQ
 S TQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2,ORIG,$G(OVRFRESH),DATA5) ; File TQ entry
 ;
 Q
 ;
RET(ORIG) ; Record Retrieval - Insurance Buffer
 ;
 S ORIG=$$GET1^DIQ(355.33,IEN_",",20.01) ;Original ins. co.
 S ORIG=ORIG_U_$$GET1^DIQ(355.33,IEN_",",90.02) ;Original group number
 S ORIG=ORIG_U_$$GET1^DIQ(355.33,IEN_",",90.01) ;Original group name
 S ORIG=ORIG_U_$$GET1^DIQ(355.33,IEN_",",90.03) ;; Original subscriber ID
 Q
 ;
