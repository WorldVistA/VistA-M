LRSCTX1 ;DALOI/JDB - LRSCTX CONTINUED ;04/16/12  10:07
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Reference to LABXCPT^HDISVAP1 supported by DBIA #5026
 ;
 Q
 ;
 ;
FILE(LRFILE,LRIN,LRERROR,HLINFO) ;
 ; Private helper method
 ; Set the new term into the target file
 ; Inputs
 ;   LRFILE: Target File # (61, 61.2, 62)
 ;     LRIN:<byref><opt> Array holding field values.
 ;         :  .01=New entry's .01 field value
 ;         :   20=SCT Code
 ;         :   21=SCT Status code
 ;         :   22=SCT Hierarchy text
 ;  LRERROR:<byref>  See Outputs
 ;   HLINFO:<byref> HL7 info array (from EN^LRSCTX)
 ; Outputs
 ;   The IEN of the entry to use
 ;   LRERROR: Error message for the process.
 ;
 ; $$TRIMS, $$UPs, Removes SCT hierarchy, converts ^ to ~
 N DIERR,LRLCK,LRNIEN,LRFDAIEN,LRMSG,X,Y,LRFMERTS
 N LRFDA,LRFDAIEN,LRMSG,LRIEN,DIERR
 S LRFILE=$G(LRFILE)
 S LRNIEN=0
 K LRERROR
 S LRERROR=""
 S LRLCK=""
 I LRFILE=61 S LRLCK="^LAB(61,0)"
 I LRFILE=61.2 S LRLCK="^LAB(61.2,0)"
 I LRFILE=62 S LRLCK="^LAB(62,0)"
 I LRLCK="" D  Q 0  ;
 . S LRERROR="1^Unknown file # "_LRFILE
 ;
 I $TR($G(LRIN(.01))," ","")="" D  Q 0  ;
 . S LRERROR="1^Term is null"
 ;
 I 'LRERROR D  ;
 . S X=$$GETLOCK^LRUTIL(LRLCK,30)
 . I 'X D  Q  ;
 . . S LRERROR="1^Could not lock file # "_LRFILE
 . ;
 . ; Only set the .01 field first to ensure record creation
 . K LRFDA,LRFDAIEN,LRMSG,LRIEN,DIERR
 . S LRIEN="+1,"
 . S X=$G(LRIN(.01))
 . S X=$$DELHIER^LRSCT(X) ;remove SCT hierarchy if present
 . S X=$$TRIM^XLFSTR(X)
 . S X=$$UP^XLFSTR(X)
 . S X=$TR(X,"^","~")
 . ; LRFMERTS provides info to FileMan during db updates.
 . ; STS team tracks changes for ref lab, local mods, and db loads.
 . ; Must know what triggered FM so correct STS notice is sent.
 . ; LRFMERTS referenced in FM xrefs for creation/change events
 . ; If '$G(LRFMERTS) then must be user/local change
 . S LRFMERTS=1
 . S LRFMERTS("STS","STAT")="NEW" ;new term
 . S LRFMERTS("STS","PROC")="REFLAB" ;from reference lab
 . S LRFDA(1,LRFILE,LRIEN,.01)=X
 . D UPDATE^DIE("","LRFDA(1)","LRFDAIEN","LRMSG")
 . S LRNIEN=$G(LRFDAIEN(1))
 . I $D(LRMSG)!'LRNIEN D  Q  ;
 . . S LRERROR="1^Failed to add new entry to file #"_LRFILE
 . ;
 . Q:'LRNIEN
 . K LRFDA,LRFDAIEN,LRMSG,LRIEN,DIERR
 . S LRIEN=LRNIEN_","
 . S LRFDA(1,LRFILE,LRIEN,21)=$G(LRIN(21)) ;status
 . I $G(LRIN(20))'="" D  ;
 . . S LRFDA(1,LRFILE,LRIEN,20)=$G(LRIN(20))
 . . S LRFDA(1,LRFILE,LRIEN,22)=$G(LRIN(22))
 . D FILE^DIE("E","LRFDA(1)","LRMSG")
 ;
 ; Release lock
 I LRLCK'="" L -@LRLCK
 ;
 ; Notify STS and locals that term has been added.
 I 'LRERROR,LRNIEN D
 . S X=$$NOTIFY(LRIN(.01),LRFILE,LRNIEN,$G(LRIN(20)),.HLINFO)
 ;
 Q LRNIEN
 ;
 ;
NOTIFY(LRTXT,LRFILE,LRFIEN,LRSCT,HLINFO) ;
 ;LABXCPT^HDISVAP1/5026
 ; Private helper method
 ; Handles STS/Local notification for "Reference lab" new terms.
 ; If a new term has been added and not in ^XTMP:
 ;  1) alert STS  2) Add entry to ^XTMP  3) Email LAB MAPPING group
 ; Inputs
 ;   LRTXT:
 ;  HLINFO:<byref>
 ; Outputs
 ;  String indicating success or error: Status^Error code^text
 ;     Status: 1=success  0=error
 ;  ie  "0^1^Term is null"  "0^4^"STS & MailMan error"
 ;
 N DATA,SFNM,LR4,LRIN,NOW,SFAC,STR,STR2,NOTIFY,SITE
 N TNUM,TMPNM,TEXT,TYPE,VAF,I,II,X,Y,LRHDI,LRHDIERR
 S LRTXT=$G(LRTXT)
 I $TR(LRTXT," ","")="" Q "0^1^Term is null"
 S LRFILE=$G(LRFILE)
 S LRFIEN=$G(LRFIEN)
 S LRSCT=$G(LRSCT)
 S LR6247=$G(LR6247)
 S NOTIFY=1 ;status of this process
 S TMPNM="LRSCTX-STS"
 S NOW=$$NOW^XLFDT()
 S TEXT=$$TRIM^XLFSTR(LRTXT)
 S TEXT=$$UP^XLFSTR(TEXT)
 S STR=$E(TEXT,1,200) ;some terms can be long and wont fit in a node
 ; check if this term has been sent already.
 K LRIN
 S LRIN("FILE")=LRFILE
 S LRIN("SCT")=LRSCT
 S LRIN("PREV","SCT")=""
 S X=$$OK2LOG^LRERT(.LRTXT,.LRIN)
 I 'X Q "0^2^Notification already sent."
 K TEXT,STR
 S TYPE=0
 S SFNM="" ; Institution Name
 S LR4=$G(HLINFO("R4"))
 S SFAC=$G(HLINFO("MSH",4)) ; sending facility
 I LR4 D
 . S SFNM=$$NAME^XUAF4(LR4) ; sending facility's name
 . S VAF=$$NVAF^LA7VHLU2(LR4) ; 0=VA 1=DOD, 2=Indian Health 3=Other
 . S TYPE=$S(VAF=0:2,VAF=1:1,VAF=2:4,VAF=3:5,1:6)
 ;
 S TNUM=$$TNUM^LRERT(LRFILE,LRFIEN,NOW,2)
 K LRHDI
 S LRHDI(2,1)=TNUM_"^"_NOW
 S LRHDI(2,1,"TXT")="Term added to file #"_LRFILE_" (entry #"_LRFIEN_")"
 S LRHDI(2,1,"EC")=$G(HLINFO("FSEC"))
 K DATA
 S X=$$BLDERTX^LRERT(LRFILE,LRFIEN,"|",.DATA,2,"S")
 ;
 S I=0
 F  S I=$O(DATA(I)) Q:'I  S LRHDI(2,1,"SA",I)=DATA(I)
 ;
 S LRHDI(2,1,"RL",1)=TYPE
 S LRHDI(2,1,"RL",2)=SFAC
 S LRHDI(2,1,"RL",3)=SFNM
 S LRHDI(2,1,"OBX",3)=$G(HLINFO("OBX",3))
 S LRHDI(2,1,"OBX",5)=$G(HLINFO("OBX",5))
 ;
 D LABXCPT^HDISVAP1("LRHDI")
 ; check LRHDI("ERROR") and add error to local email
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
 S LRIN("R6247")=LR6247 ;#62.49 IEN
 S LRIN("STSEXC")=2 ;STS exception type
 S LRIN("HDIERR")=$S($D(LRHDIERR):1,1:0) ;STS error flag (0 or 1)
 S LRIN("PREV","SCT")=""
 S LRIN("PREV","TEXT")=""
 S X=$$LOGIT^LRERT(.LRTXT,.LRIN)
 K LRIN
 ;
 ; Notify local staff of event (G.LAB MAPPING)
 N LRFILENAME,LRMTXT,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,XMMG
 S LRFILENAME=$$GET1^DID(LRFILE,"","","NAME")
 ;
 S XMSUB="Term added to file "_LRFILENAME_" (#"_LRFILE_":"_LRFIEN_")"
 I $L(XMSUB)>65 S XMSUB=$E(XMSUB,1,65)
 ;
 S LRMTXT(1,0)="New term added to file "_LRFILENAME_" #"_LRFILE_" (entry #"_LRFIEN_")"
 S LRMTXT(2,0)=" "
 S LRMTXT(3,0)="New Term: "_LRTXT
 S LRMTXT(4,0)=" "
 S LRMTXT(5,0)="Tracking information below:"
 S LRMTXT(6,0)="Transaction date: "_$$FMTE^XLFDT(NOW)
 S LRMTXT(7,0)="Transaction number: "_TNUM
 S LRMTXT(8,0)="Sending facility: "_SFAC_"  "_SFNM
 S LRMTXT(9,0)="HL7 message ID: "_$G(HLINFO("MSH",11))
 S LRMTXT(10,0)="SNOMED CT code: "_$S(LRSCT'="":LRSCT,1:"n/a")
 S LRMTXT(11,0)=" "
 S LRMTXT(12,0)="HL7 separators: "_$G(HLINFO("FSEC"))
 S LRMTXT(13,0)="OBX-3: "_$G(HLINFO("OBX",3))
 S LRMTXT(14,0)="OBX-5: "_$G(HLINFO("OBX",5))
 ;
 I $D(LRHDIERR) D
 . N NODE
 . S LRMTXT(15,0)=" "
 . S LRMTXT(16,0)="An error occurred when notifying STS:"
 . S NODE="LRHDIERR(0)"
 . S I=$O(LRMTXT("A"),-1)
 . F  S NODE=$Q(@NODE) Q:NODE=""  S I=I+1,LRMTXT(I,0)="    "_NODE
 ;
 ;
 S X=$$UP^XLFSTR($$NAME^XUSER(DUZ,"F"))
 ; If not a Lab app proxy name, use LRLAB,HL as sender
 ; Extra space in "LRLAB, HL" is a workaround for MailMan's "may not be a real user" error when App Proxy user in XMDUZ
 I X=""!(X'?1"LRLAB,"1.E) S XMDUZ="LRLAB, HL"
 ;
 I $$GOTLOCAL^XMXAPIG("LAB MAPPING") S XMY("G.LAB MAPPING")=""
 E  S XMY("G.LMI")=""
 ;
 S XMTEXT="LRMTXT("
 D ^XMD
 I $D(XMMG)!'$G(XMZ) D  ;
 . I $D(LRHDIERR) S NOTIFY="0^3^STS & Mailman error" Q
 . S NOTIFY="0^4^MailMan error"
 ;
 ; Update and store this transaction info in the target file.
 N TDT
 S TDT=NOW
 D SCTUPD^LRERT1
 ;
 Q NOTIFY
