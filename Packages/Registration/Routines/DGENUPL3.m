DGENUPL3 ;ALB/CJM,ISA/KWP,AEG,BRM,ERC,CKN,BAJ,PHH,TDM,LBD - PROCESS INCOMING (Z11 EVENT TYPE) HL7 MESSAGES ; 5/11/11 12:29pm
 ;;5.3;REGISTRATION;**147,230,232,377,404,451,653,688,793,797,841**;Aug 13,1993;Build 7
 ;
 ;
ADDMSG(MSGS,MESSAGE,TOHEC) ;
 ;Description: Used to add a message to an array of messages to be sent.
 ;
 ;Input:
 ;  MSGS - the array to store the message (pass by reference)
 ;  MESSAGE - the message to store
 ;  TOHEC - a flag, if set to 1 it means that HEC should also receive notification
 ;
 ;Output: none
 ;
 I MESSAGE["DATE OF DEATH" Q
 S MSGS(0)=($G(MSGS(0))+1)
 S MSGS(MSGS(0))=MESSAGE
 I ($G(TOHEC)=1) S MSGS("HEC")=1
 Q
 ;
 ;
NOTIFY(DGPAT,MSGS) ;
 ;Description: This is used to send a message to the local mail group
 ;defined by the MAS Parameter ELIGIBILITY UPLOAD MAIL GROUP.The
 ;notification is to be used when specific problems or conditions
 ;regarding the upload of the enrollment or eligibility data.
 ;
 ;Input: 
 ;  OLDPAT -used if the DGPAT elements have not been built
 ;  DGPAT - patient array (pass by reference)
 ;  MSGS - the an array of messages that should be included in the
 ;         notification (pass by reference). If MSGS("HEC")=1
 ;         it means that HEC should also receive notification.
 ;
 ;Output:   none
 ;
 N TEXT,XMDUZ,XMTEXT,XMSUB,XMSTRIP,XMROU,XMY,XMZ,XMDF,COUNT
 N HEADER,NSC,POW,TMPSTR,MAILGRP,ELIG,CD
 ;
 ;if there are no alerts, then quit
 Q:'$G(MSGS(0))
 ;
 ;Get reason for alert.  If there is more than one reason decide which 
 ;reason to display.  'NON-SERVICE' alerts have a higher priority than
 ;other alerts and are therefore displayed before other alerts in the 
 ;subject line, followed by 'POW' alerts in priority.
 S (ELIG,NSC,POW,CD)=0
 S COUNT=0 F  S COUNT=$O(MSGS(COUNT)) Q:'COUNT!NSC  D
 .I MSGS(COUNT)["PREVIOUSLY ELIGIBLE" S ELIG=1 Q
 .I MSGS(COUNT)["NON-SERVICE" S NSC=1 Q
 .I MSGS(COUNT)["POW" S POW=1 Q
 .I MSGS(COUNT)["CD EVALUATION" S CD=1 Q
 .S HEADER=MSGS(COUNT)
 .Q
 D
 .I ELIG S HEADER="Ineligibility Alert: " Q
 .I NSC S HEADER="NSC Alert: " Q
 .I POW&'NSC S HEADER="POW Alert: " Q
 .I CD S HEADER="CD Alert: " Q
 .Q
 ;
 S XMDF=""
 S (XMDUN,XMDUZ)="Registration Enrollment Module"
 ;Phase II Re-Enrollment
 ;DGPAT("SSN") is built by the parser.  DGPAT("NAME"),DGPAT("SEX"),DGPAT("DOB")(are merged into DGPAT from OLDPAT.
 ;The checks below are to setup the DGPAT elements from OLDPAT if NOTIFY is called before the merge. 
 I '$D(DGPAT("NAME")) S DGPAT("NAME")=$G(OLDPAT("NAME"))
 I '$D(DGPAT("SEX")) S DGPAT("SEX")=$G(OLDPAT("SEX"))
 I '$D(DGPAT("DOB")) S DGPAT("DOB")=$G(OLDPAT("DOB"))
 S TMPSTR=" ("_$E(DGPAT("NAME"),1,1)
 S TMPSTR=TMPSTR_$E(DGPAT("SSN"),$L(DGPAT("SSN"))-3,1000)_")"
 S XMSUB=$E(HEADER,1,30)_$E(DGPAT("NAME"),1,25)_TMPSTR
 ;
 ; send msg to local mail group specified in IVM SITE PARAMETER file
 S MAILGRP=+$P($G(^IVM(301.9,1,0)),"^",9)
 S MAILGRP=$$EXTERNAL^DILFD(301.9,.09,"F",MAILGRP)
 I MAILGRP]"" S XMY("G."_MAILGRP)=""
 ;
 ; if flag is set, send msg to remote mail group specified in
 ; the IVM SITE PARAMETER file
 I $G(MSGS("HEC"))=1 D
 .S MAILGRP=$P($G(^IVM(301.9,1,0)),"^",10)
 .S MAILGRP=$$EXTERNAL^DILFD(301.9,.10,"F",MAILGRP)
 .I MAILGRP]"" S XMY("G."_MAILGRP)=""
 ;
 ;
 S XMTEXT="TEXT("
 S TEXT(1)="The enrollment/eligibility upload produced the following alerts:"
 S TEXT(2)="  "
 S TEXT(3)="Patient Name   :     "_DGPAT("NAME")
 S TEXT(4)="SSN            :     "_DGPAT("SSN")
 S TEXT(5)="DOB            :     "_$$EXTERNAL^DILFD(2,$$FIELD^DGENPTA1("DOB"),"F",DGPAT("DOB"))
 S TEXT(6)="SEX            :     "_$$EXTERNAL^DILFD(2,$$FIELD^DGENPTA1("SEX"),"F",DGPAT("SEX"))
 S TEXT(7)=" "
 ;
 S TEXT(8)=" ** Alerts **"
 S TEXT(9)=" "
 S COUNT=0 F  S COUNT=$O(MSGS(COUNT)) Q:'COUNT  S TEXT(10+COUNT)=COUNT_") "_MSGS(COUNT)
 ;
 D ^XMD
 Q
 ;
BEGUPLD(DFN) ;
 ;Description: Sets a lock used to determine if an eligibility/enrollment
 ;upload is in progress. 
 ;
 ;Input:
 ;   DFN - ien, Patient record
 ;
 ;Output:
 ;  Function value - returns 1 if the lock was obtained, 0 otherwise.
 ;
 Q:'$G(DFN) 1
 L +^DGEN("ELIGIBILITY UPLOAD",DFN):3
 Q $T
 ;
ENDUPLD(DFN) ;
 ;Description: Releases the lock obtained by calling $$BEGUPLD(DFN)
 ;
 Q:'$G(DFN)
 L -^DGEN("ELIGIBILITY UPLOAD",DFN)
 Q
 ;
CKUPLOAD(DFN) ;
 ;Description: Checks if an upload is in progress.  If so, it pauses
 ;until it is completed.
 ;The enrollment/eligibility upload can take a while to accomplish.
 ;If the lock is not obtained initially, it is assumed that the upload
 ;is in progress, and a message is displayed to the user.
 ;
 ;Input: DFN
 ;Output: none
 ;
 N I
 I '$$BEGUPLD(DFN) D
 .W !!,"Upload of patient enrollment/eligibility data is in progress ..."
 .D UNLOCK^DGENPTA1(DFN)
 .F I=1:1:50 Q:$$BEGUPLD(DFN)  W "."
 .W !,"Upload of patient enrollment/eligibility data is completed.",!
 D ENDUPLD(DFN)
 Q
SCVET ;moved from DGENUPL4 - DG*5.3*688
 I DGPAT3("VETERAN")'="N" D
 . I DGELG3("SC")="N" S DGPAT3("VETERAN")="Y",DGPAT3("PATYPE")=$O(^DG(391,"B","NSC VETERAN",0))
 . I DGELG3("SC")="Y" S DGPAT3("VETERAN")="Y",DGPAT3("PATYPE")=$O(^DG(391,"B","SC VETERAN",0))
 I DGPAT3("VETERAN")="N" S DGPAT3("PATYPE")=$$NONVET(DGELG("ELIG","CODE"))
 Q
 ;
NONVET(DGCODE) ;map Patient Type from Primary Elig (and POS)
 ;added with DG*5.3*688 - ERC
 ; input:         DGCODE is the Primary Eligibility code
 ; output:        DGTPYE is returned as the value for Patient Type
 N PTELG,DGTYPE
 S (PTELG,DGTYPE)=""
 Q:$G(DGCODE)']"" ""
 S PTELG=$$NATNAME^DGENELA(DGCODE)
 Q:$G(PTELG)']"" ""
 I "CHAMPVA^OTHER FEDERAL AGENCY^REIMBURSABLE INSURANCE^SHARING AGREEMENT"[PTELG S DGTYPE=$$POS(.DGTYPE) Q:DGTYPE DGTYPE
 S DGTYPE=$S(PTELG["ALLIED":"ALLIED VETERAN",PTELG["COLLATERAL":"COLLATERAL",PTELG["EMPLOYEE":"EMPLOYEE",PTELG["TRICARE":"TRICARE",1:"")
 I DGTYPE']"" S DGTYPE="NON-VETERAN (OTHER)" ;default Pat Type
 S DGTYPE=$O(^DG(391,"B",DGTYPE,""))
 Q DGTYPE
POS(DGTYPE) ;for these Elig Codes, check POS to determine Patient Type
 S DGPOS=DGELG("POS")
 I $G(DGPOS)']"" Q ""
 I '$D(^DIC(21,DGPOS,0)) Q ""
 S DGPOS=$P(^DIC(21,DGPOS,0),U)
 S DGTYPE=$S(DGPOS["ACTIVE":"ACTIVE DUTY",DGPOS["OPERAT":"ACTIVE DUTY",DGPOS["RETIR":"MILITARY RETIREE",1:"")
 I $G(DGTYPE)]"" S DGTYPE=$O(^DG(391,"B",DGTYPE,""))
 Q DGTYPE
 ;
 ;ZMH code moved here from DGENUPL2 - DG*5.3*653
ZMH ;Purple Heart, POW, OEF/OIF Conflict Loc, Military Service Episodes, Medal of Honor
 ;PROCESS PH, OEF/OIF, MH & POW FROM ZMH
 ;Process Military Service Episodes (SL,SNL,SNNL,MSD) - DG*5.3*797
 I "^SL^SNL^SNNL^MSD^"[("^"_SEG(2)_"^") D  Q
 . N BOS,SN,DIS,SED,SSD,COM
 . S BOS=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH)))  ;Service Branch
 . S:BOS]"" BOS=$O(^DIC(23,"B",BOS,""))
 . S SN=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH),2))  ;Service Number
 . S DIS=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH),3))  ;Discharge Type
 . S:DIS]"" DIS=$O(^DIC(25,"B",DIS,""))
 . S SED=$$CONVERT^DGENUPL1($P(SEG(4),$E(HLECH)),"DATE")  ;Entry Date
 . I 'SED!ERROR D  Q
 . . D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),"BAD VALUE, ZMH SEGMENT, SEQ 4, SERVICE ENTRY DATE",.ERRCOUNT)
 . S SSD=$$CONVERT^DGENUPL1($P(SEG(4),$E(HLECH),2),"DATE")  ;Sep. Date
 . S COM=$$CONVERT^DGENUPL1($P(SEG(5),$E(HLECH)))  ;Service Component
 . S DGNMSE(-SED)=SED_U_SSD_U_BOS_U_COM_U_SN_U_DIS_U_1
 ;
 I SEG(2)="PH" D  Q  ;Process Purple Heart from ZMH
 . S DGPAT("PHI")=$P(SEG(3),$E(HLECH))
 . S DGELG("PH")=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH)))
 . S DGPAT("PHST")=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH),2))
 . S DGPAT("PHRR")=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH),3))
 ;
 I SEG(2)="OEIF" D  Q
 . N OEIFLOC
 . S OEIFLOC=$P(SEG(3),$E(HLECH))
 . I OEIFLOC="Conflict Unspecified" Q   ;Ignore these entries
 . I OEIFLOC="Unknown OEF/OIF" S OEIFLOC="UNK"
 . S OEIFLOC=$E(OEIFLOC,1,3)
 . Q:((OEIFLOC'="OIF")&(OEIFLOC'="OEF")&(OEIFLOC'="UNK"))
 . S DGOEIF("COUNT")=$G(DGOEIF("COUNT"))+1
 . S DGOEIF("LOC",DGOEIF("COUNT"))=OEIFLOC
 . S DGOEIF("SITE",DGOEIF("COUNT"))=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH),2),"INSTITUTION")
 . S DGOEIF("FR",DGOEIF("COUNT"))=$$CONVERT^DGENUPL1($P(SEG(4),$E(HLECH)),"DATE")
 . S DGOEIF("TO",DGOEIF("COUNT"))=$$CONVERT^DGENUPL1($P(SEG(4),$E(HLECH),2),"DATE")
 . S DGOEIF("LOCK",DGOEIF("COUNT"))=1
 ;
 I SEG(2)="POW" D  ;Process POW from ZMH
 . S DGPAT("POWI")=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH))) ;POW STATUS INDICATED
 . S DGELG("POW")=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH)))
 . S DGPAT("POWLOC")=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH),2))
 . I DGPAT("POWLOC")'="@" S DGPAT("POWLOC")=$$POWLOC(DGPAT("POWLOC"),.ERROR) ;POW CONFINEMENT LOCATION
 . I ERROR D  Q
 . . D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),"BAD VALUE, ZMH SEGMENT, SEQ 3, POW CONFINEMENT LOCATION",.ERRCOUNT)
 . S DGPAT("POWFDT")=$$CONVERT^DGENUPL1($P(SEG(4),$E(HLECH)),"DATE",.ERROR) ;POW FROM DATE
 . I ERROR D  Q
 . . D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),"BAD VALUE, ZMH SEGMENT, SEQ 4, POW FROM DATE",.ERRCOUNT)
 . S DGPAT("POWTDT")=$$CONVERT^DGENUPL1($P(SEG(4),$E(HLECH),2),"DATE",.ERROR) ;POW TO DATE
 . I ERROR D  Q
 . . D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),"BAD VALUE, ZMH SEGMENT, SEQ 4, POW TO DATE",.ERRCOUNT)
 ;
 I SEG(2)="MH" D  ;Process Medal of Honor from ZMH
 . S DGPAT("MOH")=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH))) ;MH STATUS INDICATED
 . S DGELG("MOH")=$$CONVERT^DGENUPL1($P(SEG(3),$E(HLECH)))
 Q
POWLOC(LOC,ERROR) ;POW Confinement Location mapping with HL7 table VA023
 ;  Input: LOC - HL7 code for location
 ; Output: ERROR - Return error 1 on failure
 ;         IEN22 - IEN of file 22
 N TBL023
 S ERROR=0
 I LOC="" S ERROR=1 Q ""
 S TBL023(4)="WWI",TBL023(5)="WWII-EUROPE",TBL023(6)="WWII-PACIFIC"
 S TBL023(7)="KOREAN",TBL023(8)="VIETNAM",TBL023(9)="OTHER"
 S TBL023("A")="PERSIAN GULF",TBL023("B")="YUGOSLAVIA"
 S IEN22=$O(^DIC(22,"C",TBL023(LOC),""))
 I IEN22="" S ERROR=1
 Q IEN22
 ;
