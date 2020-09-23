WEBGRPCS ; HON/CKU - WebVRAM RPCs; June 05, 2020 @ 13:38
 ;;1.0;WEB VISTA REMOTE ACCESS MANAGEMENT;**3**;June 5, 2020;Build 10
 ;
 ; This routine contains the WebVRAM RPCs
 ;
 Q
 ;
 ;
 ; Gets the parameter value as stored in VistA
 ;
 ; RV:      [output] the return value, 
 ;          0 if none, otherwise "error number^text"
 ; ENTITY:  [required] refers to the variable pointer used in the
 ;          the parameter file (#8989.5). may take various forms such as:
 ;              * internal vptr: ien;GLO(FN,
 ;              * external vptr: prefix.entryname
 ;              * 'use current' form: prefix
 ;              * chained list: use any of above, ^ delimited, or 'ALL'
 ; PARAM:   [required] refers to the parameter definition (default external
 ;          form or `internal form)
 ; INST:    [optional] instance, defaults to 1
 ; RVFMT:   [optional] return value format, default to "Q" (internal values)
 ;              "Q" - quick, returns internal value
 ;              "I" - internal, return internal value
 ;              "E" - external, returns external value
 ;              "B" - both, returns internal value^external value
GETPARAM(RV,ENTITY,PARAM,INST,RVFMT) ; short for GET PARAMETER
 S INST=$G(INST,1),RVFMT=$G(RVFMT,"Q")
 S RV=$$GET^XPAR(ENTITY,PARAM,INST,RVFMT)
 Q
 ;
 ;
 ;
 ; Adds the parameter value in VistA
 ;
 ; RV:      [output] the return value
 ; ENTITY:  [required] refers to the variable pointer used in the
 ;          the parameter file (#8989.5). may take various forms such as:
 ;              * internal vptr: ien;GLO(FN,
 ;              * external vptr: prefix.entryname
 ;              * 'use current' form: prefix
 ;              * chained list: use any of above, ^ delimited, or 'ALL'
 ; PARAM:   [required] refers to the parameter definition (default external
 ;          form or `internal form)
 ; VALUE:   [required] defaults to external form; or 'internal
 ; INST:    [optional] instance, defaults to 1
ADDPARAM(RV,ENTITY,PARAM,VALUE,INST) ; short for ADD PARAMETER
 S INST=$G(INST,1) N ERROR
 D ADD^XPAR(ENTITY,PARAM,INST,VALUE,.ERROR)
 S RV=ERROR
 Q
 ;
 ;
 ;
 ; Update the parameter value in VistA
 ;
 ; RV:      [output] the return value
 ; ENTITY:  [required] refers to the variable pointer used in the
 ;          the parameter file (#8989.5). may take various forms such as:
 ;              * internal vptr: ien;GLO(FN,
 ;              * external vptr: prefix.entryname
 ;              * 'use current' form: prefix
 ;              * chained list: use any of above, ^ delimited, or 'ALL'
 ; PARAM:   [required] refers to the parameter definition (default external
 ;          form or `internal form)
 ; VALUE:   [required] defaults to external form; or 'internal
 ; INST:    [optional] instance, defaults to 1
UPDPARAM(RV,ENTITY,PARAM,VALUE,INST) ; short for UPDATE PARAMETER
 S INST=$G(INST,1) N ERROR
 D CHG^XPAR(ENTITY,PARAM,INST,VALUE,.ERROR)
 S RV=ERROR
 Q
 ;
 ;
 ;
 ; Delete the parameter value in VistA
 ;
 ; RV:      the return value, 0 if successful or error^error message
 ; ENTITY:  [required] refers to the variable pointer used in the
 ;          the parameter file (#8989.5). may take various forms such as:
 ;              * internal vptr: ien;GLO(FN,
 ;              * external vptr: prefix.entryname
 ;              * 'use current' form: prefix
 ;              * chained list: use any of above, ^ delimited, or 'ALL'
 ; PARAM:   [required] refers to the parameter definition (internal or 
 ;          external form)
 ; INST:    [optional] instance, defaults to 1
DELPARAM(RV,ENTITY,PARAM,INST) ; short for DELETE PARAMETER
 S INST=$G(INST,1) N ERROR
 D DEL^XPAR(ENTITY,PARAM,INST,.ERROR)
 S RV=ERROR
 Q
