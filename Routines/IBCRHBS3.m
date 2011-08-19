IBCRHBS3 ;ALB/ARH - RATES: UPLOAD HOST FILES (RC 2+) PARSE ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; IBFILE, IBFLINE, COLUMNS required and VERS expected on entry
 ; Parse lines from the Host Files and place them in XTMP.  
 ; Direct copy of fields, number of fields and placement not changed, but cleaned up (spaces, $, commas removed)
 ;
A ; Inpatient Facility DRG Charges:  process a single line, parse out into individual fields and store in XTMP
 ;
 N LINE,IBI,IBPIECE,IBITYPE,IBCODE,IBXTMP,IBXIFN S IBXTMP="IBCR RC A" I ('$G(COLUMNS))!($G(IBFLINE)="") Q
 ;
 S LINE="" F IBI=1:1:COLUMNS S IBPIECE=$$P(IBFLINE,IBI),IBPIECE=$$STRIP(IBPIECE) S LINE=LINE_IBPIECE_U
 ;
 S IBITYPE=$P(LINE,U,2) I IBITYPE'="DRG",IBITYPE'="SNF" Q
 S IBCODE=$P(LINE,U,1) I IBCODE'?3N Q
 ;
 S IBXIFN=$$SET(IBFILE,IBXTMP,LINE)
 ;
 Q
 ;
B ; Outpatient Facility CPT Charges:  process a single line, parse out into individual fields and store in XTMP
 ;
 N LINE,IBI,IBPIECE,IBITYPE,IBCODE,IBXTMP,IBXIFN S IBXTMP="IBCR RC B" I ('$G(COLUMNS))!($G(IBFLINE)="") Q
 ;
 S LINE="" F IBI=1:1:COLUMNS S IBPIECE=$$P(IBFLINE,IBI),IBPIECE=$$STRIP(IBPIECE) S LINE=LINE_IBPIECE_U
 ;
 S IBITYPE=$P(LINE,U,2) I IBITYPE'="CPT",IBITYPE'="HCPCS",IBITYPE'="PHOSP" Q
 S IBCODE=$P(LINE,U,1) I IBCODE'?5UN Q
 ;
 S IBXIFN=$$SET(IBFILE,IBXTMP,LINE,IBCODE)
 ;
 Q
 ;
C ; Physician CPT Charges:  process a single line, parse out into individual fields and store in XTMP
 ;
 N LINE,IBI,IBPIECE,IBITYPE,IBCODE,IBXTMP,IBXIFN S IBXTMP="IBCR RC C" I ('$G(COLUMNS))!($G(IBFLINE)="") Q
 ;
 S LINE="" F IBI=1:1:COLUMNS S IBPIECE=$$P(IBFLINE,IBI),IBPIECE=$$STRIP(IBPIECE) S LINE=LINE_IBPIECE_U
 ;
 S IBITYPE=$P(LINE,U,2) I IBITYPE'="CPT",IBITYPE'="HCPCS" Q
 S IBCODE=$P(LINE,U,1) I IBCODE'?5UN Q
 ;
 S IBXIFN=$$SET(IBFILE,IBXTMP,LINE,IBCODE)
 ;
 Q
 ;
D ; Service Category Codes:  process a single line, parse out into individual fields and store in XTMP
 ;
 N LINE,IBI,IBPIECE,IBCODE,IBXTMP,IBXIFN S IBXTMP="IBCR RC D" I ('$G(COLUMNS))!($G(IBFLINE)="") Q
 ;
 S LINE="" F IBI=1:1:COLUMNS S IBPIECE=$$P(IBFLINE,IBI),IBPIECE=$$STRIP(IBPIECE) S LINE=LINE_IBPIECE_U
 ;
 S IBCODE=$P(LINE,U,1) I 'IBCODE Q
 ;
 S IBXIFN=$$SET(IBFILE,IBXTMP,LINE,IBCODE)
 ;
 Q
 ;
E ; Area Factors:  process a single line, parse out into individual fields and store in XTMP
 ;
 N LINE,IBI,IBPIECE,IBZIP,IBXTMP,IBXIFN S IBXTMP="IBCR RC E" I ('$G(COLUMNS))!($G(IBFLINE)="") Q
 ;
 S LINE="" F IBI=1:1:COLUMNS S IBPIECE=$$P(IBFLINE,IBI),IBPIECE=$$STRIP(IBPIECE) S LINE=LINE_IBPIECE_U
 ;
 S IBZIP=$P(LINE,U,1) I IBZIP'?3N Q
 ;
 S IBXIFN=$$SET(IBFILE,IBXTMP,LINE,IBZIP) D SETSITE(IBZIP)
 ;
 Q
 ;
F ; Zip Codes and Sites:  process a single line, parse out into individual fields and store in XTMP
 ;
 N LINE,IBSITE,IBZIP,IBNM,IBSTYPE,IBXTMP,IBXIFN S IBXTMP="IBCR RC F" I ('$G(COLUMNS))!($G(IBFLINE)="") Q
 ;
 S IBSITE=$$P(IBFLINE,1),IBSITE=$$STRIP(IBSITE) I IBSITE'?3N0.2UN Q  ; division number
 S IBNM=$$P(IBFLINE,2) ; facility name
 S IBZIP=$$P(IBFLINE,3),IBZIP=$$STRIP(IBZIP) I IBZIP'?3N Q  ; 3-digit zip code
 S IBSTYPE=$$P(IBFLINE,4),IBSTYPE=$$STRIP(IBSTYPE) I 'IBSTYPE Q  ; facility type
 ;
 S LINE=IBSITE_U_IBNM_U_IBZIP_U_IBSTYPE
 ;
 S IBXIFN=$$SET(IBFILE,IBXTMP,LINE,IBZIP) D SETSITE(IBZIP,IBSITE,IBNM,IBSTYPE)
 ;
 Q
 ;
 ;
 ;
SETHDR(IBFILE,IBXRF1) ; set up header for XTMP file
 ;
 N IBX S IBX=IBFILE_" RC v"_$G(VERS)_" Host File Upload, "_$P($$HTE^XLFDT($H,2),":",1,2)_" by "_$P($G(^VA(200,+$G(DUZ),0)),U,1)
 S ^XTMP(IBXRF1,0)=$$FMADD^XLFDT(DT,2)_U_DT_U_IBX_U_0_U_0
 I IBXRF1="IBCR RC SITE" S ^XTMP(IBXRF1,"VERSION")=$G(VERS),^XTMP(IBXRF1,"VERSION INACTIVE")=$$VERSEDT^IBCRHBRV($G(VERS))
 Q
 ;
SET(IBFILE,IBXRF1,LINE,ACROSS) ; set data parsed from host file to XTMP
 N IBX,IBK
 S IBX=$G(^XTMP(IBXRF1,0)) I IBX="" D SETHDR(IBFILE,IBXRF1)
 S IBK=+$P(IBX,U,5)+1,$P(^XTMP(IBXRF1,0),U,5)=IBK
 S ^XTMP(IBXRF1,IBK)=LINE
 ;
 I $G(ACROSS)'="" S ^XTMP(IBXRF1,"A",ACROSS,IBK)=""
 Q IBK
 ;
 ;
SETSITE(ZIP,SITE,NAME,TYPE) ; set up site entries and cross references
 ; the Area Factor File (E) has entries not associated with a VA site, Site/Zip file (F) only has valid VA sites
 ; therefore there are many zip codes (E) with no assigned division but that must be available for selection
 ; these unassigned zip codes are passed in with only Zip defined, 
 ; a temporary Division Number '9yyXy' and Name 'ZIP Code ZZZ' is created, Type is blank to be set by user
 ; if the zip is '000' then these are the Nation wide charges and the corresponding Division Number/Name is used
 N IBXRF1,LINE,IBXIFN
 ;
 I ZIP="000" S SITE="999",NAME="NATIONWIDE AVERAGE",TYPE=""
 I $G(SITE)="" S SITE="9"_$E(ZIP,1,2)_"X"_$E(ZIP,3),NAME="ZIP Code "_ZIP,TYPE=""
 I $O(^XTMP("IBCR RC SITE","C",SITE_" ",0)) W !!,"Site Error: Dupicate Site Numbers: ",SITE
 ;
 S IBXRF1="IBCR RC SITE"
 S LINE=SITE_U_NAME_U_ZIP_U_TYPE
 ;
 S IBXIFN=$$SET(IBXRF1,IBXRF1,LINE)
 ;
 I $G(NAME)'="" S ^XTMP(IBXRF1,"B",NAME,IBXIFN)=""
 I $G(ZIP)'="" S ZIP="ZC "_ZIP S ^XTMP(IBXRF1,"B",ZIP,IBXIFN)=""
 I $G(SITE)'="" S SITE=SITE_" " S ^XTMP(IBXRF1,"B",SITE,IBXIFN)="",^XTMP(IBXRF1,"C",SITE,IBXIFN)=""
 ;
 Q
 ;
 ;
STRIP(IBVAL) ; strip blanks, $, and commas
 N IBI,IBY,IBX S IBY=""
 F IBI=1:1:200 S IBX=$E(IBVAL,IBI) Q:IBX=""  I IBX'=" ",IBX'=",",IBX'="$" S IBY=IBY_IBX
 Q IBY
 ;
 ;
P(LINE,P) ; parse the line and return the piece requested (replaces $P since may be two dilimiters)
 ; the pieces are delimited by a comma, any piece that includes a comma within the text is surrounded by quotes
 N I,U1,U2,PC S U1=",",U2="""",PC=""
 ;
 F I=1:1:P D
 . I $E(LINE)=U2 S LINE=$E(LINE,2,9999),PC=$P(LINE,U2,1),LINE=$P(LINE,U2_U1,2,9999) Q
 . ;
 . S PC=$P(LINE,U1,1),LINE=$P(LINE,U1,2,9999)
 ;
 Q PC
