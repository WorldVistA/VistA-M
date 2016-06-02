PXAPIIM ;BP/LMT - PCE Immunization APIs ;06/30/15  10:23
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**210**;Aug 12, 1996;Build 21
 ;
 Q
 ;
VIS(PXRESULT,PXVIS,PXDATE) ;Called from VIS^PXAPI
 ;
 ;Input:
 ;  PXRESULT  (required) Return value (passed by reference)
 ;     PXVIS  (required) Pointer to #920
 ;    PXDATE  (optional; defaults to NOW) The date in FileMan format.
 ;                       Used to check the status of the VIS on that date.
 ;Returns:
 ;  PXRESULT("NAME") = VIS Name
 ;  PXRESULT("EDITION DATE") = FileManager Internal Format for date/time
 ;  PXRESULT("EDITION STATUS") = code^value (C^CURRENT or H^HISTORIC)
 ;  PXRESULT("LANGUAGE") = IEN ^ Language (e.g., 1^ENGLISH)
 ;  PXRESULT("2D BAR CODE") = Barcode from the CDC VIS barcode lookup table
 ;  PXRESULT("VIS URL") = Internet URL for this VIS
 ;  PXRESULT("STATUS") = Status based on PXDATE (1^ACTIVE or 0^INACTIVE)
 ;
 N PXDATA,PXFILE,PXIENS,PXLANG,PXSTATUS
 ;
 S PXFILE=920
 S PXIENS=PXVIS_","
 D GETS^DIQ(PXFILE,PXIENS,"*","EI","PXDATA")
 ;
 S PXRESULT("NAME")=$G(PXDATA(PXFILE,PXIENS,.01,"E"))
 S PXRESULT("EDITION DATE")=$G(PXDATA(PXFILE,PXIENS,.02,"I"))
 S PXRESULT("EDITION STATUS")=$G(PXDATA(PXFILE,PXIENS,.03,"I"))_U_$G(PXDATA(PXFILE,PXIENS,.03,"E"))
 S PXRESULT("2D BAR CODE")=$G(PXDATA(PXFILE,PXIENS,100,"E"))
 S PXRESULT("VIS URL")=$G(PXDATA(PXFILE,PXIENS,101,"E"))
 ;
 S PXLANG=$G(PXDATA(PXFILE,PXIENS,.04,"I"))
 I PXLANG D
 . S PXLANG=PXLANG_U_$$GET1^DIQ(PXFILE,PXIENS,".04:1")
 S PXRESULT("LANGUAGE")=PXLANG
 ;
 S PXSTATUS=$$GETSTAT^XTID(PXFILE,.01,PXIENS,PXDATE)
 S PXRESULT("STATUS")=$P(PXSTATUS,U,1)_U_$P(PXSTATUS,U,3)
 ;
 Q
