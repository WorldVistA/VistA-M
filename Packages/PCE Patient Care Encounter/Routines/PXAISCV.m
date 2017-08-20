PXAISCV ;SLC/PKR - Validate Standard Code entry. ;12/21/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 84
 ;
VAL ;--Validate enough data.
 ;----Missing the code
 I ($G(PXAA("CODE"))="") D  Q:$G(STOP)
 .S STOP=1 ;--Used to stop do loop
 .S PXAERRF=1 ;--Flag indicates there is an error
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="CODE"
 .S PXAERR(11)=$G(PXAA("CODE"))
 .S PXAERR(12)="The code is missing."
 ;
 ;----Missing the coding system
 I ($G(PXAA("CODING SYSTEM"))="") D  Q:$G(STOP)
 .S STOP=1 ;--Used to stop do loop
 .S PXAERRF=1 ;--Flag indicates there is an error
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="CODING SYSTEM MISSING"
 .S PXAERR(11)=$G(PXAA("CODING SYSTEM"))
 .S PXAERR(12)="The coding system is missing."
 ;
 ;----Is the coding system valid?
 N CODESYSL
 D SCCSL^PXLEX(.CODESYSL)
 I '$D(CODESYSL(PXAA("CODING SYSTEM"))) D  Q:$G(STOP)
 .S STOP=1 ;--Used to stop do loop
 .S PXAERRF=1 ;--Flag indicates there is an error
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="INVALID CODING SYSTEM"
 .S PXAERR(11)=$G(PXAA("CODING SYSTEM"))
 .S PXAERR(12)="This coding system is not supported for V STANDARD CODES."
 ;
 ;----Is the coding system, code pair valid?
 I '$$VCODE^PXLEX(PXAA("CODING SYSTEM"),PXAA("CODE")) D  Q:$G(STOP)
 .S STOP=1
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="CODING SYSTEM, CODE PAIR"
 .S PXAERR(11)=PXAA("CODING SYSTEM")_U_PXAA("CODE")
 .S PXAERR(12)="Invalid code for the coding system."
 ;
 ;----Is the code active on the date of interest?
 N DOI
 S DOI=$G(PXAA("EVENT D/T"))
 I DOI="" S DOI=$P(^AUPNVSIT(PXAVISIT,0),U,1)
 I '$$ISCACT^PXLEX(PXAA("CODING SYSTEM"),PXAA("CODE"),DOI) D  Q:$G(STOP)
 .S STOP=1
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="CODE NOT ACTIVE"
 .S PXAERR(11)=PXAA("CODING SYSTEM")_U_PXAA("CODE")_U_DOI
 .S PXAERR(12)="The code was not active on "_$$FMTE^XLFDT(DOI,"5Z")_"."
 Q
