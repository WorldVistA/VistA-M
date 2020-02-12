RGADTP3 ;BIR/CMC-RGADTP2 - CONTINUED ; 12/5/19 12:38pm
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**48,59,63,65,67,68,71,73**;30 Apr 99;Build 2
 ;
 ;MOVED CHKPVT AND DIFF FROM RGADTP2 DUE TO ROUTINE SIZE ISSUE
 Q
CHKPVT(ARRAY) ;CHECKS TO SEE IF OUTSTANDING IDENTITY EDIT IS WAITING TO BE SENT IN THE ADT/HL7 PIVOT FILE
 ;**44 CREATED - ARRAY CONTAINS THE ARRAY ELEMENTS NEEDED TO FIND THE PATIENT IN THE ADT/HL7 PIVOT FILE
 ;RETURNED IS -1^EDIT PENDING IN PIVOT FILE OR 0 IF THERE ISN'T ONE
 I '$D(^VAT(391.71,"C",ARRAY("DFN"))) Q 0
 N PIV,FIELDS
 S PIV=$O(^VAT(391.71,"C",ARRAY("DFN"),"A"),-1) ;get last entry in the pivot file for this patient
 I '$D(^VAT(391.71,"AXMIT",4,PIV))&('$D(^VAT(391.71,"AXMIT",3,PIV))) Q 0
 S FIELDS=$$GET1^DIQ(391.71,PIV_",",2.1,"I")
 I FIELDS[".01;"!(FIELDS[".02;")!(FIELDS[".03;")!(FIELDS[".09;")!(FIELDS[".0906;")!(FIELDS[".2403;")!(FIELDS["994;") Q "-1^DFN "_ARRAY("DFN")_":  Edits made to identity fields waiting to come to MPI, MPI update not processed as of yet."
 Q 0
 ;
DIFF(ARRAY,RGRSDFN,DR,ARAY) ; are there fields to update? **47
 N NAME,SSN,PDOB,SEX,SID,MMN,OLDNAME,OLDHLNAM,OLDMMN,OLDHLMMN,HLNAME,HLMMN,SSNV,MBI,PSNR,PREFNAME
 S DR="",NAME=$$GET1^DIQ(2,+RGRSDFN_",",.01,"I"),HLNAME=ARRAY("NAME")
 ;**48 remove name standardization check
 ;D STDNAME^XLFNAME(.NAME,"F",.OLDNAME) S HLNAME=ARRAY("NAME") D STDNAME^XLFNAME(.HLNAME,"F",.OLDHLNAM)
 ;**71,Story 841921 (mko): If the Name Components flag is not set, and the incoming name is > 30 chars,
 ;    use the name components to build a truncated name
 ;  If the flag is set, then we need to update the Name Components entry rather than the Patient Name.
 ;    Save the incoming components in ARAY(20), when different from existing values
 I '$$GETFLAG^MPIFNAMC D
 .S:$L(HLNAME)>30 (HLNAME,ARRAY("NAME"))=$$FMTNAME(.ARRAY,30)
 .S:NAME'=$G(HLNAME) DR=DR_".01;",ARAY(2,.01)=ARRAY("NAME")
 E  D
 .N DIERR,DIMSG,DIHELP,MSG,NCIENS,TARG
 .S NCIENS=$$GET1^DIQ(2,+RGRSDFN_",",1.01,"I","","MSG")_","
 .D:NCIENS>0 GETS^DIQ(20,NCIENS,"1;2;3;5","I","TARG","MSG")
 .S:$G(TARG(20,NCIENS,1,"I"))'=$G(ARRAY("SURNAME")) ARAY(2,1.01,"FAMILY")=$G(ARRAY("SURNAME"))
 .S:$G(TARG(20,NCIENS,2,"I"))'=$G(ARRAY("FIRST")) ARAY(2,1.01,"GIVEN")=$G(ARRAY("FIRST"))
 .S:$G(TARG(20,NCIENS,3,"I"))'=$G(ARRAY("MIDDLE")) ARAY(2,1.01,"MIDDLE")=$G(ARRAY("MIDDLE"))
 .S:$G(TARG(20,NCIENS,5,"I"))'=$G(ARRAY("SUFFIX")) ARAY(2,1.01,"SUFFIX")=$G(ARRAY("SUFFIX"))
 .S:$D(ARAY(2,1.01)) DR=DR_"1.01;"
 ;**67 - Story 455460 (ckn) - Update Preferred Name
 S PREFNAME=$$GET1^DIQ(2,+RGRSDFN_",",.2405,"I"),HLNAME=$G(ARRAY("PREFERREDNAME"))
 I PREFNAME'=$G(HLNAME) S DR=DR_".2405;",ARAY(2,.2405)=ARRAY("PREFERREDNAME")
 S PDOB=$$GET1^DIQ(2,+RGRSDFN_",",.03,"I") I PDOB'=ARRAY("MPIDOB") S DR=DR_".03;",ARAY(2,.03)=ARRAY("MPIDOB")
 S SSN=$$GET1^DIQ(2,+RGRSDFN_",",.09,"I") D
 .I SSN["P",ARRAY("SSN")=""!(ARRAY("SSN")="@") Q
 .; ^ treat pseudos and null/@ as the same
 .; **47 if incoming SSN value is null/@ and existing SSN isn't a pseudo create a new pseudo SSN
 .I SSN'["P" I ARRAY("SSN")="@"!(ARRAY("SSN")="") S ARRAY("SSN")="P"
 .I SSN'=ARRAY("SSN"),ARRAY("SSN")'="" S DR=DR_".09;",ARAY(2,.09)=ARRAY("SSN")
 S SEX=$$GET1^DIQ(2,+RGRSDFN_",",.02,"I") D
 .I SEX=""&(ARRAY("SEX")="@") Q
 .; ^ treat null and @ as same
 .I SEX'=ARRAY("SEX") S DR=DR_".02;",ARAY(2,.02)=ARRAY("SEX")
 ;**63 Story 174247: Self-ID Gender
 S SID=$$GET1^DIQ(2,+RGRSDFN_",",.024,"I") D
 .I SID="",$G(ARRAY(.024))="@" Q
 .I SID'=$G(ARRAY(.024)) S DR=DR_".024;",ARAY(2,.024)=$G(ARRAY(".024"))
 S SSNV=$$GET1^DIQ(2,+RGRSDFN_",",.0907,"I") I SSNV="" S SSNV="@"
 ;if SSN VERIFICATION STATUS field has been added to the DD then attempt to set it
 N ERROR,LABEL D FIELD^DID(2,.0907,"","LABEL","LABEL","ERROR") I '$D(ERROR("DIERR"))&$D(LABEL("LABEL")) D
 .I SSNV'=ARRAY(.0907) S ARAY(2,.0907)=$G(ARRAY(.0907)),DR=DR_".0907;"
 S PSNR=$$GET1^DIQ(2,+RGRSDFN_",",.0906,"I") I PSNR="" S PSNR="@"
 ;if Pseudo SSN Reason field has been added to the DD then attempt to set it
 N ERROR,LABEL D FIELD^DID(2,.0906,"","LABEL","LABEL","ERROR") I '$D(ERROR("DIERR"))&$D(LABEL("LABEL")) D
 .I PSNR'=ARRAY(.0906) S ARAY(2,.0906)=$G(ARRAY(.0906)),DR=DR_".0906;"
 ; **59, MVI_881 start
 ; S MBI=$$GET1^DIQ(2,+RGRSDFN_",",994,"I") I MBI="" S MBI="@"
 ; I MBI="@"&(ARRAY("MBI")="") Q
 ; ^ treat @ and null as the same
 ; I MBI'=ARRAY("MBI") S DR=DR_"994;",ARAY(2,994)=ARRAY("MBI")
 ; S MMN=$$GET1^DIQ(2,+RGRSDFN_",",.2403,"I") I MMN="" S MMN="@"
 ; D STDNAME^XLFNAME(.MMN,"F",.OLDMMN) S HLMMN=ARRAY("MMN") D STDNAME^XLFNAME(.HLMMN,"F",.OLDHLMMN)
 ; I MMN="@"&($G(HLMMN)="") Q
 ; ^ treat @ and null as same
 ; I MMN'=$G(HLMMN) S DR=DR_".2403;",ARAY(2,.2403)=ARRAY("MMN")
 I $G(ARRAY("MBI"))'="" D
 . S MBI=$$GET1^DIQ(2,+RGRSDFN_",",994,"I") S:MBI="" MBI="@"
 . ; ^ treat @ and null as the same
 . I MBI'=ARRAY("MBI") S DR=DR_"994;",ARAY(2,994)=ARRAY("MBI")
 S HLMMN=$G(ARRAY("MMN"))
 I HLMMN'="" D
 . S MMN=$$GET1^DIQ(2,+RGRSDFN_",",.2403,"I") S:MMN="" MMN="@"
 . I MMN'="@" D STDNAME^XLFNAME(.MMN,"F",.OLDMMN)
 . I HLMMN'="@" D STDNAME^XLFNAME(.HLMMN,"F",.OLDHLMMN)
 . ; ^ treat @ and null as same
 . I MMN'=HLMMN S DR=DR_".2403;",ARAY(2,.2403)=ARRAY("MMN")
 ; update TIN and FIN fields
 N TIN,FIN
 I $G(ARRAY("TIN"))'="" D
 . S TIN=$$GET1^DIQ(2,+RGRSDFN_",",991.08,"I") S:TIN="" TIN="@"
 . I TIN'=ARRAY("TIN") S DR=DR_"991.08;",ARAY(2,991.08)=ARRAY("TIN")
 I $G(ARRAY("FIN"))'="" D
 . S FIN=$$GET1^DIQ(2,+RGRSDFN_",",991.09,"I") S:FIN="" FIN="@"
 . I FIN'=ARRAY("FIN") S DR=DR_"991.09;",ARAY(2,991.09)=ARRAY("FIN")
 ; **59, MVI_881 end
 I $D(ARRAY("ALIAS")) S DR=DR_"1;"
 ;**65 - Story 323009 (ckn): Update DOD fields
 N ODOD,ODODP,ODODLUP,ODODSRC,ODODARY,ODODD,ANSWER,DUPDFLG
 S DUPDFLG=$$CHK^VAFCDODA() ;Date of Death update flag
 ; check for validation of Date of Death- if imprecise date of
 ; death - remove all Date of Death if no existin date of death
 D VAL^DIE(2,+RGRSDFN_",",.351,"R",$G(ARRAY("MPIDOD")),.ANSWER)
 I DUPDFLG D
 . I $G(ARRAY("MPIDOD"))="""@"""!($G(ARRAY("MPIDOD"))="") D  Q
 ..;**68 - Story 500735 (ckn) : Only Delete Date of Death data if
 ..; deletion through PSIM TK OVERRIDE
 .. I '$G(ARRAY("TKOVRDOD")) Q
 .. I $$GET1^DIQ(2,+RGRSDFN_",",.351,"I")="" Q
 .. S DR=DR_".354;",ARAY(2,.354)=$G(ARRAY(.354)) ;Date of death last updated date
 .. ;Remove rest of the DOD fields
 .. S DR=DR_".351;.352;.353;.355;.357;.358;",(ARAY(2,.351),ARAY(2,.352),ARAY(2,.353),ARAY(2,.355),ARAY(2,.357),ARAY(2,.358))="@"
 . I ANSWER="^" S DODIMPF=1_"^"_$G(ARRAY("MPIDOD")) Q  ;Date of Death Imprecise Flag - No update on VistA
 . I $G(ARRAY("MPIDOD"))>0 D  Q
 .. N TUPD S TUPD=0
 .. D GETS^DIQ(2,+RGRSDFN_",",".351;.353;.354;.357","I","ODODARY")
 .. S ODOD=ODODARY(2,+RGRSDFN_",",.351,"I")
 ..; S ODODD=ODODARY(2,+RGRSDFN_",",.357,"I")
 .. S ODODLUP=ODODARY(2,+RGRSDFN_",",.354,"I")
 .. S ODODSRC=ODODARY(2,+RGRSDFN_",",.353,"I")
 ..; I ODOD=ARRAY("MPIDOD") Q  ;No update if no change in Date of Death
 ..;**71 - Story 841797 (ckn)
 ..;DOD metadata update allowed if update is from PSIM TK OVERRIDE even
 ..;if no change in Date of Death
 ..;**131 - Story 1125116 (ckn) DOD metadata update is allowed now regardless
 ..; I ODOD=ARRAY("MPIDOD"),'$G(ARRAY("TKOVRDOD")) Q
 .. I ODOD'=ARRAY("MPIDOD") S DR=DR_".351;",ARAY(2,.351)=$G(ARRAY(.351)),TUPD=1
 ..; I ODODD'=$G(ARRAY("DODDocType")) S DR=DR_".357;",ARAY(2,.357)=$G(ARRAY(.357))
 .. I ODODLUP'=$G(ARRAY("DODLastUpdated")),(ODOD'=ARRAY("MPIDOD")) S DR=DR_".354;",ARAY(2,.354)=$G(ARRAY(.354))
 .. I ODODSRC'=$G(ARRAY("DODSource")) S DR=DR_".353;",ARAY(2,.353)=$G(ARRAY(.353)),TUPD=1
 .. ;S DR=DR_".353;",ARAY(2,.353)=$G(ARRAY(.353))
 .. ;Remove rest of the DOD fields if Date Of Death is getting updated
 .. S DR=DR_".352;.357;.358",ARAY(2,.352)="@",ARAY(2,.358)="@",ARAY(2,.357)="@"
 .. I TUPD S DR=DR_";.355",ARAY(2,.355)="@"
 Q
 ;
FMTNAME(ARRAY,LEN) ;Return a formatted name from cleaned Name Components that doesn't exceed LEN characters in length.
 ;**71,Story 841921 (mko): New function
 N NC
 S:'$G(LEN) LEN=30
 ;
 ;If ARRAY is passed as a string and doesn't have descendants assume it equals "surname^first^middle^suffix"
 D:$D(ARRAY)=1
 . S ARRAY("SURNAME")=$P(ARRAY,"^")
 . S ARRAY("FIRST")=$P(ARRAY,"^",2)
 . S ARRAY("MIDDLE")=$P(ARRAY,"^",3)
 . S ARRAY("SUFFIX")=$P(ARRAY,"^",4)
 ;
 ;Clean the components
 S NC("FAMILY")=$$CLEANC^XLFNAME($G(ARRAY("SURNAME")))
 S NC("GIVEN")=$$CLEANC^XLFNAME($G(ARRAY("FIRST")))
 S NC("MIDDLE")=$$CLEANC^XLFNAME($G(ARRAY("MIDDLE")))
 S NC("SUFFIX")=$$CLEANC^XLFNAME($G(ARRAY("SUFFIX")))
 ;
 ;Build a full name, maximum length LEN
 Q $$NAMEFMT^XLFNAME(.NC,"F","CL"_LEN)
