PXRMVSIT ; SLC/PKR - Visit related info for reminders. ;02/22/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;======================================================
GETDATA(DA,DATA,SVALUE) ;Return data for a specific Visit file entry.
 ;DBIA #2028 for Visit file.
 N DONE,IEN,HTEMP,LOE,TEMP
 S TEMP=^AUPNVSIT(DA,0)
 S DATA("VISIT")=DA
 S DATA("DATE VISIT CREATED")=$P(TEMP,U,2)
 S DATA("DFN")=$P(TEMP,U,5)
 S (DATA("LOC. OF ENCOUNTER"),LOE)=$P(TEMP,U,6)
 ;DBIA #10090
 S DATA("STATION NUMBER")=$$GET1^DIQ(4,LOE,99)
 S DATA("OFFICAL VA NAME")=$$GET1^DIQ(4,LOE,100)
 S DATA("SERVICE CATEGORY")=$P(TEMP,U,7)
 I $G(SVALUE) S DATA("VALUE")=$P(TEMP,U,7)
 S DATA("HOSPITAL LOCATION")=$P(TEMP,U,22)
 ;DBIA #10040, #2804
 I $G(DATA("HOSPITAL LOCATION"))="" S HTEMP=""
 E  S HTEMP=^SC(DATA("HOSPITAL LOCATION"),0)
 S DATA("HLOC")=$P(HTEMP,U,1)
 S DATA("DSS ID")=$P(TEMP,U,8)
 I DATA("DSS ID")="" S DATA("DSS ID")=$P(HTEMP,U,7)
 ;DBIA #557
 I DATA("DSS ID")'="" S DATA("STOP CODE")=$P(^DIC(40.7,DATA("DSS ID"),0),U,2)
 S DATA("OUTSIDE LOCATION")=$G(^AUPNVSIT(DA,21))
 S DATA("COMMENTS")=$G(^AUPNVSIT(DA,811))
 ;DBIA #4850
 S DATA("STATUS")=$$STATUS^SDPCE(DA)
 ;Get the primary provider.
 ;DBIA #3455 for V PROVIDER
 S DATA("PRIMARY PROVIDER")="",IEN="",DONE=0
 F  S IEN=$O(^AUPNVPRV("AD",DA,IEN)) Q:(DONE)!(IEN="")  D
 . S TEMP=^AUPNVPRV(IEN,0)
 . I $P(TEMP,U,4)="P" S DATA("PRIMARY PROVIDER")=$P(TEMP,U,1),DONE=1
 Q
 ;
 ;======================================================
GAPSTAT(VIEN) ;Return the status of the appointment associated with the
 ;visit.
 ;DBIA #4850
 Q $$STATUS^SDPCE(VIEN)
 ;
 ;======================================================
HENC(VIEN,INDENT,NLINES,TEXT) ;Display location and comment for historical
 ;encounters associated with the V files.
 N COMMENT,HLOC,LOCATION,OLOC,NIN,TEXTIN,VDATA
 D GETDATA(VIEN,.VDATA) I VDATA("SERVICE CATEGORY")'="E" Q
 S NIN=0
 S LOCATION=VDATA("LOC. OF ENCOUNTER")
 I LOCATION'="" D
 . S LOCATION=$$GET1^DIQ(4,LOCATION,.01)_" "_$$GET1^DIQ(4,LOCATION,99)
 . S NIN=NIN+1,TEXTIN(NIN)="Location of Encounter: "_LOCATION_"\\"
 S HLOC=VDATA("HOSPITAL LOCATION")
 I HLOC'="" D
 . S HLOC=$$GET1^DIQ(44,HLOC,.01)
 . S NIN=NIN+1,TEXTIN(NIN)="Hospital Location: "_HLOC_"\\"
 S OLOC=VDATA("OUTSIDE LOCATION")
 I OLOC'="" D
 . S NIN=NIN+1,TEXTIN(NIN)="Outside Location: "_OLOC_"\\"
 S COMMENT=VDATA("COMMENT")
 I COMMENT'="" D
 . S NIN=NIN+1,TEXTIN(NIN)="Comment: "_COMMENT
 I NIN>0 D
 . N JND,NOUT,TEXTOUT
 . S NLINES=NLINES+1
 . S TEXT(NLINES)=$$INSCHR^PXRMEXLC(INDENT," ")_"Historical Encounter Information:"
 . D FORMAT^PXRMTEXT(INDENT+2,PXRMRM,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 . F JND=1:1:NOUT S NLINES=NLINES+1,TEXT(NLINES)=TEXTOUT(JND)
 Q
 ;
 ;======================================================
ISHIST(VIEN) ;Return true if the encounter was historical.
 ;DBIA #2028
 I $P($G(^AUPNVSIT(VIEN,0)),U,7)="E" Q 1
 Q 0
 ;
 ;======================================================
VAPSTAT(VIEN) ;Return true if the appointment associated with
 ;the visit has a valid appointment status.
 ;Return false if the status is one of the following:
 ;CANCELLED BY CLINIC
 ;CANCELLED BY CLINIC & AUTO RE-BOOK
 ;CANCELLED BY PATIENT
 ;CANCELLED BY PATIENT & AUTO-REBOOK
 ;DELETED
 ;NO ACTION TAKEN
 ;NO-SHOW
 ;NO-SHOW & AUTO RE-BOOK
 ;NULL
 N STATUS,VALID
 ;DBIA #4850
 S STATUS=$P($$STATUS^SDPCE(VIEN),U,2)
 S VALID=$S(STATUS["CANCELLED":0,STATUS["DELETED":0,STATUS["NO ACTION":0,STATUS["NO-SHOW":0,STATUS="":0,1:1)
 Q VALID
 ;
