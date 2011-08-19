DGRUUTL ;ALB/GRR - RAI/MDS UTILITY ROUTINE ; 10/11/07 8:42am
 ;;5.3;Registration;**190,444,762**;Aug 13, 1993;Build 3
HLNAME(DGNAME) ;Piece apart name into LAST NAME_"^"_FIRST NAME_"^"_MIDDLE NAME_"^"_SUFFIX
 ;Input DGNAME - Either Last Name, First or First, Middle and Last Name (i.e. SMITH,JOHN R   or  JOHN R SMITH)
 S (DGFN,DGMN,DGLN,DGSUF,P1,P2,P3,P4)=""
 I DGNAME'["," S P=$L(DGNAME," ") F Z=1:1:P S @("P"_Z)=$P(DGNAME," ",Z)
 I DGNAME["," D
 .S P1=$P(DGNAME,","),P2=$P(DGNAME,",",2),DGN=P2_" "_P1
 .S P=$L(DGN," ") F Z=1:1:P S @("P"_Z)=$P(DGN," ",Z)
 S DGSUF=$$SUF(@("P"_P))
 I DGSUF'="" S P=P-1
 I P=4 S DGFN=P1,DGMN=P2,DGLN=P3_" "_P4 G NAMQ
 I P=3 D  G NAMQ
 .I $L($P(P2,"."))=1 S DGFN=P1,DGMN=P2,DGLN=P3 Q
 .I $L($P(P2,"."))=2 S DGFN=P1,DGLN=P2_" "_P3 Q
 .S DGFN=P1,DGMN=P2,DGLN=P3
 S DGFN=P1,DGLN=P2
NAMQ Q DGLN_"^"_DGFN_"^"_DGMN_"^"_DGSUF
 ;
SUF(X) ;COMPARES PASSED DATA TO LIST OF SUFFIX'S AND RETURNS A FOUND SUFFIX OR NULL
 I "^JR.^SR.^II.^III.^IV.^V.^VI.^VII.^VIII.^VIIII.^IX.^X."'[X Q ""
 Q X
 ;
CHKWARD(X) ;RETURNS 1 IF RAI/MDS WARD AND 0 IF NOT
 ;;Input X - Internal Entry Number of Ward in Ward file (#42)
 ;
 Q $S(+X>0:+($$GET1^DIQ(42,X,.035,"I")),1:0)
 ;
MEDICARE(DFN) ;Will retrieve the patient's Medicare Number and return it or return null
 ;Input - DFN patient's IEN
 N DGSUB ;modified p-444
 Q:DFN']"" ""  ;p-444
 S DGSUB=$$HICN^IBCNSU1(DFN) ;p-444
 Q:DGSUB<0 ""  ;no medicare number  p-444
 Q DGSUB
 ;
MEDICAID(DFN) ;Will retrieve the patient's Medicaid Number and return it or a null
 ;Input - DFN patient's IEN
 ;
 ;  Returns the medicaid information from the patient file
 ; P-762 return Medicaid number or 'N'
 N A S A=$$GET1^DIQ(2,DFN,.383)
 S:A="" A="N"
 Q A
 ;
GETAMOV(DFN) ;GET LAST ADMISSION MOVEMENT FOR A PATIENT
 ;
 N I,J S (I,J)=""
 S I=$O(^DGPM("ATID1",DFN,I)) Q:I="" ""
 S J=$O(^DGPM("ATID1",DFN,I,J)) ;ien of admission movement
 Q J
 ;
RELATE(X) ;CONVERT FREE TEXT RELATIONSHIP TO RELATIONSHIP FILE ENTRY NUMBER AND NAME
 N DIC,Y
 S X=$$UPPER^HLFNC(X)
 S X=$S(X="WIFE":"SPOUSE",X="HUSBAND":"SPOUSE",1:X)
 S DIC="^DG(408.11,",DIC(0)="X" D ^DIC
 S:Y<0 Y="99^OTHER" ;DEFAULT IF NOT FOUND IN FILE
 Q Y
 ;
ENC(DGRSEG,DGRMNMT,DGRFLN,DGRFLNM,DGROLDN,DGRNDATA,DGRSIED,DGCIEN) ;CREATE AND SEND MASTER FILE UPDATE HL7 MESSAGE
 ;INPUT:
 ;     DGRSEG  -  File Number
 ;     DGRMNMT -  Message Type (ie INSURANCE)
 ;     DGRFLN  -  Vista File Number (ie 36)
 ;     DGRFLNM -  Vista File Name (ie INSURANCE COMPANY)
 ;     DGROLDN -  Old Name value
 ;     DGRNDATA - New value (ie BLUE CROSS NH/VT)
 ;     DGRSIED -  Server Protocol IEN
 ;     DGRUHLP -  Priority of Message (ie I = Immediate)
 ;
 Q:DGRSEG=""!(DGRMNMT="")!(DGRFLN="")!(DGRFLNM="")!(DGRNDATA="")!(DGRSIED="")  ;Quit if all parameters not passed
 D EN^DGRUGMFU(DGRSEG,DGRMNMT,DGRFLN,DGRFLNM,DGROLDN,DGRNDATA,DGCIEN) ;Call routine which formats the Master File Update
 I $D(^TMP($J,"DGRUGMFU",1)) D  ;If a Master File Update was created, do the following
 .M HLA("HLS")=^TMP($J,"DGRUGMFU") ;Move global array maintaining HL7 message to local array
 .D GENERATE^HLMA("DGRU-RAI-MFU-SERVER","LM",1,.DGRUET,"") ;Call API to generate the HL7 message
 Q
SENDMFU() ;Function to determine if master file updates should be sent
 Q $P($G(^DG(43,1,"HL7")),"^",4)=1
 ;
DOCID(X) ;Insure provider ID not greater than 6 digits
 Q:$E(X,1,3)'="PV1" -1
 N DGDOC,DGNIEN,IEN
 S DGDOC=$P(X,HL("FS"),8),IEN=$P(DGDOC,$E(HL("ECH")))
 I $L(IEN)<7 G EXITDOC
 S DGNIEN=$E(IEN,$L(IEN)-5,$L(IEN)),$P(DGDOC,$E(HL("ECH")))=DGNIEN
 S $P(X,HL("FS"),8)=DGDOC
EXITDOC Q X
 ;
ATTDOC(X) ;get attending physician - p-762
 N ATTPTR,ATTNAME,VAIP D IN5^VADPT S ATTPTR=$P(VAIP(18),"^",1),ATTNAME=$P(VAIP(18),"^",2) K VAIP
 I $L(ATTPTR)>6 S ATTPTR=$E(ATTPTR,$L(ATTPTR)-5,$L(ATTPTR))
 I $G(ATTNAME) S ATTNAME=$$HLNAME(ATTNAME)
 Q ATTPTR_$E(HL("ECH"))_ATTNAME
