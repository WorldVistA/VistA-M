LRSCTF1 ;DAL01/JDB - SCT POPULATION/ERT ALERT ;12/22/10  16:08
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Reference to LABXCPT^HDISVAP1 supported by DBIA #5026
 Q
 ;
 ;
NOTIFY(LRTXT,LRFILE,LRFIEN,LRSCT,EXCDATA) ;
 ;LABXCPT^HDISVAP1/5026
 ; Private helper method
 ; Handles ERT/Local notification for "Load Exception" errors.
 ; If an SCT load exception occurs and not in ^XTMP alert ERT.
 ; Inputs
 ;   LRTXT: Code text
 ;  LRFILE: Target file #
 ;  LRFIEN: Target file # IEN
 ;   LRSCT: SCT Code <opt>
 ; EXCDATA:<byref>
 ; Outputs
 ;  String indicating success or error.
 ;     On success returns the new ^XTMP IEN
 ;     On failure returns "0^num^msg"
 ;         ie  "0^1^Term is null"
 ;  Returns transaction # in EXCDATA("TNUM")
 ;
 N DATA,LRIN,NOW,STR,STR2,NOTIFY,SITE
 N TNUM,TMPNM,TEXT,I,II,X,Y,LRHDI,LRHDIERR
 S LRTXT=$G(LRTXT)
 I $TR(LRTXT," ","")="" Q "0^1^Term is null"
 S LRFILE=$G(LRFILE),LRFIEN=$G(LRFIEN),LRSCT=$G(LRSCT)
 S NOTIFY=1 ;status of this process
 S TMPNM="LRSCTF-STS"
 S NOW=$$NOW^XLFDT()
 S TEXT=$$TRIM^XLFSTR(LRTXT),TEXT=$$UP^XLFSTR(TEXT)
 S STR=$E(TEXT,1,200) ;some terms can be long and wont fit in a node
 ; check if this term has been sent already.
 K LRIN
 S LRIN("FILE")=LRFILE,LRIN("SCT")=LRSCT,LRIN("PREV","SCT")=""
 S X=$$OK2LOG^LRERT(.LRTXT,.LRIN,TMPNM)
 I 'X Q "0^2^Notification already sent."
 K DATA,LRHDI,TEXT,STR
 ;
 S TNUM=$$TNUM^LRERT(LRFILE,LRFIEN,NOW,1)
 S EXCDATA("TNUM")=TNUM
 S LRHDI(1,1)=TNUM_"^"_NOW
 S X=$$BLDERTX^LRERT(LRFILE,LRFIEN,"|",.DATA,2,"S")
 S I=0
 F  S I=$O(DATA(I)) Q:'I  S LRHDI(1,1,"SA",I)=DATA(I)
 ; see patch HDI*1.0*7 for array details
 F I=7:1:11  I $G(EXCDATA("SA",I))'="" S LRHDI(1,1,"SA",I)=EXCDATA("SA",I)
 ;
 S LRHDI(1,1,"RD",5)=1
 F I=1:1:6  I $G(EXCDATA("RD",I))'="" S LRHDI(1,1,"RD",I)=EXCDATA("RD",I)
 ;
 S LRHDI(1,1,"TXT")=$G(EXCDATA("TXT"))
 ;
 D LABXCPT^HDISVAP1("LRHDI")
 ; check LRHDI("ERROR")
 K LRHDIERR
 M LRHDIERR("ERROR")=LRHDI("ERROR")
 K LRHDI
 ;
 ; Update ^XTMP
 K LRIN
 S LRIN("TNUM")=TNUM ;trans #
 S LRIN("TDT")=NOW ;trans date/time
 S LRIN("FILE")=LRFILE ; targ file
 S LRIN("FIEN")=LRFIEN ;targ file IEN
 S LRIN("SCT")=LRSCT ;SCT code
 S LRIN("STSEXC")=1 ;STS exception type
 S LRIN("HDIERR")=$S($D(LRHDIERR):1,1:0) ;STS error flag (0 or 1)
 S LRIN("PREV","SCT")=""
 S LRIN("PREV","TEXT")=""
 S X=$$LOGIT^LRERT(.LRTXT,.LRIN,TMPNM)
 I X S EXCDATA("IEN")=X
 I 'X D  ;
 . S Y=$P(X,"^",2)
 . S Y=Y+10 ;new error code group
 . S NOTIFY="0^"_Y_"^$$LOGIT failed: "_$P(X,"^",3)
 I $G(LRHDIERR("ERROR"))'="" S NOTIFY="0^5^LABXCPT failed: "_LRHDIERR("ERROR")
 Q NOTIFY
