TIUPXAP3 ;SLC/RMO - Link Document to Visit API ;Apr 11, 2018@12:07
 ;;1.0;TEXT INTEGRATION UTILITIES;**179,290**;Jun 20, 1997;Build 548
 ;
LNKVST(TIUDA,TIUVSIT) ;Entry point to link a document to an existing visit
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- 1=Successful and 0=Failure
 ;           TIUVSIT  Visit file (#9000010) IEN
 N OKF,TIUMVSTF
 ;
 ;Check if document needs to be linked to a visit
 I $D(^TIU(8925,TIUDA,0)),$P(^(0),U,3)'>0 D
 . ;Get existing visit to associate with document
 . D GETVST(TIUDA,.TIUVSIT,.TIUMVSTF)
 . ;If only one visit update the document with the visit
 . I $G(TIUVSIT)>0,'$G(TIUMVSTF) D
 . . I $$UPDVST^TIUPXAP2(TIUDA,TIUVSIT) S OKF=1
 Q +$G(OKF)
 ;
GETVST(TIUDA,TIUVSIT,TIUMVSTF) ;Get visit to associate with document
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- TIUVSIT  Visit file (#9000010) IEN
 ;           TIUMVSTF Multiple Visit Flag
 ;                    1=Multiple Visits
 ;
 N TIUD0,TIUDFN,TIUEDT,TIUHL,TIUVSITS,TIUVSTR
 ;
 ;Set variables
 S TIUD0=$G(^TIU(8925,TIUDA,0))
 S TIUDFN=$P(TIUD0,U,2),TIUEDT=$P(TIUD0,U,7)
 S TIUHL=$P($G(^TIU(8925,TIUDA,12)),U,11)
 S TIUVSTR=TIUHL_";"_TIUEDT_";"_$P(TIUD0,U,13)
 ;
 ;Check if document is an addendum, if it is use visit of parent
 I +$$ISADDNDM^TIULC1(TIUDA) D  G GETVSTQ
 . I $D(^TIU(8925,+$P(TIUD0,U,6),0)),$P(^(0),U,3)>0 S TIUVSIT=$P(^(0),U,3)
 ;
 ;Check if a document has already been entered for the Vstring,
 ;if it has use the visit in the AVSTRV cross-reference
 I +$G(TIUVSTR),+$O(^TIU(8925,"AVSTRV",+TIUDFN,TIUVSTR,0))>0 D  G GETVSTQ:$G(TIUVSIT)>0
 . S TIUVSIT=+$O(^TIU(8925,"AVSTRV",+TIUDFN,TIUVSTR,0))
 . I $P($G(^AUPNVSIT(+TIUVSIT,0)),U,5)'=TIUDFN S TIUVSIT=""
 ;
 ;Check PCE for a visit
 S TIUVSITS=$$GETENC^PXAPI(TIUDFN,TIUEDT,TIUHL)
 I TIUVSITS>0 S TIUVSIT=+TIUVSITS
 ;
 ;Set a flag if multiple visits
 I $P(TIUVSITS,U,2)'="" S TIUMVSTF=1
GETVSTQ K ^TMP("PXKENC",$J)
 Q
LNKSVST(TIUY,TIUDFN,TIUDA,TIUVSTR) ;Entry point to link a document via its
 ;                                  SECONDARY VISIT field to a daily
 ;                                  hospitalization visit
 ; Input  -- TIUDFN   Patient file (#2) IEN
 ;           TIUDA    TIU Document file (#8925) IEN
 ;           TIUVSTR  IEN of visit or visit string
 ; Output -- TIUY=1 for Successful or
 ;                0^Message for Failure
 K TIUY
 S TIUY=0
 S TIUDFN=+$G(TIUDFN) I ('TIUDFN)!('$D(^DPT(TIUDFN))) D  Q
 .S $P(TIUY,U,2)="Invalid patient specified."
 S TIUDA=+$G(TIUDA) I ('TIUDA)!('$D(^TIU(8925,TIUDA))) D  Q
 .S $P(TIUY,U,2)="Invalid document number specified."
 N TIUVSIT,TIUVDT
 S TIUVSTR=$G(TIUVSTR),TIUVSIT=0
 I TIUVSTR?1.N D  Q:$P(TIUY,U,2)'=""
 .S TIUVSIT=TIUVSTR,TIUVSTR=""
 .I ('TIUVSIT)!('$D(^AUPNVSIT(TIUVSIT))) S $P(TIUY,U,2)="Invalid visit specified." Q
 .I $P($G(^AUPNVSIT(TIUVSIT,0)),U,7)'="D" D
 ..S $P(TIUY,U,2)="The specified visit does not have a service category of daily hospitalization."
 I TIUVSTR'="" D  Q:$P(TIUY,U,2)'=""
 .I TIUVSTR'?1.N1";"7N.1".".N1";"1U D  Q
 ..S $P(TIUY,U,2)="Invalid visit string format."
 .I $P(TIUVSTR,";",3)'="D" D  Q
 ..S $P(TIUY,U,2)="The specified visit does not have a service category of daily hospitalization." Q
 .;Check PCE for a visit
 .N TIUVSITS,TIUPXAPI,SUCCESS,PIECE,EXIT
 .S TIUVDT=$P(TIUVSTR,";",2)
 .S TIUVSITS=$$GETENC^PXAPI(TIUDFN,TIUVDT,+TIUVSTR)
 .F PIECE=1:1:$L(TIUVSITS,U)  D  Q:TIUVSIT>0
 ..S TIUVSIT=$P(TIUVSITS,U,PIECE)
 ..I $P($G(^TMP("PXKENC",$J,TIUVSIT,0)),U,7)'="D" S TIUVSIT=0
 .K ^TMP("PXKENC",$J)
 I TIUVSTR="",'TIUVSIT S $P(TIUY,U,2)="No visit specified." Q
 ;No visit found, create one
 I 'TIUVSIT D
 .K ^TMP("TIUPXAPI",$J),TIUVSIT S TIUPXAPI=$NA(^TMP("TIUPXAPI",$J))
 .S @TIUPXAPI@("ENCOUNTER",1,"ENC D/T")=TIUVDT
 .S @TIUPXAPI@("ENCOUNTER",1,"PATIENT")=TIUDFN
 .S @TIUPXAPI@("ENCOUNTER",1,"HOS LOC")=+TIUVSTR
 .S @TIUPXAPI@("ENCOUNTER",1,"SERVICE CATEGORY")=$P(TIUVSTR,";",3)
 .S @TIUPXAPI@("ENCOUNTER",1,"ENCOUNTER TYPE")="P"
 .I $$PROVIDER^TIUPXAP1(DUZ,TIUVDT) S @TIUPXAPI@("PROVIDER",1,"NAME")=DUZ
 .S SUCCESS=$$DATA2PCE^PXAPI(TIUPXAPI,"TIU","TEXT INTEGRATION UTILITIES",.TIUVSIT,DUZ,0)
 .K @TIUPXAPI
 I '+$G(TIUVSIT) D  Q
 .S $P(TIUY,U,2)="Couldn't find nor create a visit for the given visit string."
 ;Set the document's SECONDARY VISIT field
 N TIUDATA
 K SUCCESS
 S TIUDATA(1207)=TIUVSIT
 D FILE^TIUSRVP(.SUCCESS,TIUDA,.TIUDATA,1)
 I '+SUCCESS S $P(TIUY,U,2)=$P(SUCCESS,U,2) Q
 ;Set the parent document's SECONDARY VISIT field
 N TIUDAD
 S TIUDAD=+$P($G(^TIU(8925,TIUDA,0)),U,6)
 I TIUDAD>0 D  Q:$P(TIUY,U,2)'=""
 .I '$D(^TIU(8925,TIUDAD)) S $P(TIUY,U,2)="Parent document not found." Q
 .K SUCCESS,TIUDATA
 .S TIUDATA(1207)=TIUVSIT
 .D FILE^TIUSRVP(.SUCCESS,TIUDAD,.TIUDATA,1)
 .I '+SUCCESS S $P(TIUY,U,2)=$P(SUCCESS,U,2) Q
 S TIUY=1
 Q
