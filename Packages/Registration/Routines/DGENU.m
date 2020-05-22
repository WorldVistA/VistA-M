DGENU ;ALB/CJM,ISA/KWP,Zoltan,LBD,EG,CKN,ERC,TMK,PWC,TDM,JLS,HM - Enrollment Utilities ;04/24/2006 9:20 AM
 ;;5.3;Registration;**121,122,147,232,314,564,624,672,659,653,688,536,838,841,909,940,972,952**;Aug 13,1993;Build 160
 ;
DISPLAY(DFN) ;
 ;Description: Display status message, current enrollment and
 ;     preferred facility information
 ;Input:
 ;  DFN - Patient IEN
 ;  Output:     none
 ;
 N STATUS
 S STATUS=$$STATUS^DGENA(DFN)
 I 'STATUS W !!,"Patient is NOT enrolled in the VA Patient Enrollment System..."
 E  I STATUS=2 D
 .W !!,"Patient is enrolled in the VA Patient Enrollment System..."
 ; Purple Heart added status 21
 E  I (STATUS=9)!(STATUS=1)!(STATUS=15)!(STATUS=16)!(STATUS=17)!(STATUS=18)!(STATUS=21) D
 .W !!,"Application is pending for enrollment in the VA Patient Enrollment System..."
 E  D
 .W !!,"Patient is NOT enrolled in the VA Patient Enrollment System..."
 D CUR(DFN)
 Q
 ;
CUR(DFN) ;
 ;Description - displays current enrollment, category, enrollment
 ;  group threshold, preferred facility and source designation
 ;
 N FACNAME,PREFAC,PFSRC,DGEGT,DGEGTIEN,DGENCAT,DGENR,IORVON,IORVOFF
 I $$GET^DGENA($$FINDCUR^DGENA(DFN),.DGENR)
 ;Get enrollment category
 S DGENCAT=$$CATEGORY^DGENA4(DFN)
 ;Display Category in reverse video
 D REV
 ;Get enrollment group threshold
 S DGEGTIEN=$$FINDCUR^DGENEGT
 S DGEGT=$$GET^DGENEGT(DGEGTIEN,.DGEGT)
 ;Preferred facility
 S PREFAC=$$PREF^DGENPTA(DFN,.FACNAME)
 ;Source Designation
 S PFSRC=$$GET1^DIQ(2,DFN_",",27.03)
 W !?3,"Enrollment Date",?35,": ",$S('$G(DGENR("DATE")):"-none-",1:$$EXT^DGENU("DATE",DGENR("DATE")))
 W !?3,"Enrollment Application Date",?35,": ",$S('$G(DGENR("APP")):"-none-",1:$$EXT^DGENU("DATE",DGENR("APP")))
 W !?3,IORVON,"Enrollment Category             : ",$S($G(DGENCAT)="":"-none-",1:$$EXTERNAL^DILFD(27.15,.02,"",DGENCAT)),IORVOFF
 W !?3,"Enrollment Status",?35,": ",$S($G(DGENR("STATUS"))="":"-none-",1:$$EXT^DGENU("STATUS",DGENR("STATUS")))
 W !?3,"Enrollment Priority",?35,": ",$S($G(DGENR("PRIORITY"))="":"-none-",1:DGENR("PRIORITY")),$S($G(DGENR("SUBGRP"))="":"",1:$$EXT("SUBGRP",DGENR("SUBGRP")))
 W !?3,"Preferred Facility",?35,": ",$S($G(FACNAME)'="":FACNAME,1:"-none-")
 W !?3,"Preferred Facility Source",?35,": ",$S($G(PFSRC)'="":PFSRC,1:"-none-")
 W !?3,"Enrollment Group Threshold",?35,": ",$S($G(DGEGT("PRIORITY"))="":"-none-",1:$$EXTERNAL^DILFD(27.16,.02,"",$G(DGEGT("PRIORITY")))),$S($G(DGEGT("SUBGRP"))="":"",1:$$EXTERNAL^DILFD(27.16,.03,"",$G(DGEGT("SUBGRP"))))
 W !
 Q
REV ;Get variables to display text in reverse video
 N X
 S X="IORVON;IORVOFF"
 D ENDR^%ZISS
 Q
PATID(DFN) ;
 ;Description - Called by FileMan as an identifier for the Patient file.
 ;Displays current enrollment status, priority, and preferred facility.
 ;
 ;Input:
 ;  DFN - ien to Patient file
 ;
 N PREFAC,DGENR,OUTPUT
 I '$$GET^DGENA($$FINDCUR^DGENA(DFN),.DGENR) D
 .S OUTPUT="NO ENROLLMENT APPLICATION ON FILE "
 E  D
 .S OUTPUT=$E("PRIORITY:"_DGENR("PRIORITY")_"   ",1,12)_$E("STATUS:"_$$EXT^DGENU("STATUS",DGENR("STATUS"))_"         ",1,26)
 S PREFAC=$$PREF^DGENPTA(DFN)
 S:PREFAC OUTPUT=OUTPUT_"PREFERRED FACILITY:"_$P($G(^DIC(4,PREFAC,99)),"^")
 I $G(IOM) I ($X#$G(IOM))<6 D
 .D EN^DDIOL(OUTPUT,,"?($X+(10-($X#IOM)))")
 E  D
 .D EN^DDIOL(OUTPUT,,"!?10")
 Q
 ;
EXT(SUB,VAL) ;
 ;Description: Given the subscript used in the PATIENT ENROLLMENT array,
 ;     and a field value, returns the external representation of the
 ;     value, as defined in the fields output transform of the PATIENT
 ;     ENROLLMENT file.
 ;Input: 
 ;  SUB - subscript in the array defined by the PATIENT ENROLLMENT object
 ;  VAL - value of the PATIENT ENROLLMENT object attribute named by SUB
 ;Output:
 ;  Function Value - returns the external value of the attribute as
 ;     defined by the PATIENT ENROLLMENT file
 ;
 Q:(($G(SUB)="")!($G(VAL)="")) ""
 ;
 N FLD
 S FLD=$$FIELD(SUB)
 ;
 Q:(FLD="") ""
 Q $$EXTERNAL^DILFD(27.11,FLD,"F",VAL)
 ;
FIELD(SUB) ;
 ;Description: given a subscript in the enrollment array, returns the
 ;     corresponding field number
 N FLD S FLD=""
 D  ;drops out of block once SUB is determined
 .I SUB="APP" S FLD=.01 Q
 .I SUB="DATE" S FLD=.1 Q
 .I SUB="END" S FLD=.11 Q
 .I SUB="DFN" S FLD=.02 Q
 .I SUB="SOURCE" S FLD=.03 Q
 .I SUB="STATUS" S FLD=.04 Q
 .I SUB="REASON" S FLD=.05 Q
 .I SUB="REMARKS" S FLD=25 Q
 .I SUB="FACREC" S FLD=.06 Q
 .I SUB="PRIORITY" S FLD=.07 Q
 .I SUB="EFFDATE" S FLD=.08 Q
 .I SUB="PRIORREC" S FLD=.09 Q
 .I SUB="SUBGRP" S FLD=.12 Q
 .I SUB="RCODE" S FLD=.13 Q  ;DJE field added with DG*5.3*940 - Closed Application - RM#867186
 .I SUB="CODE" S FLD=50.01 Q
 .I SUB="SC" S FLD=50.02 Q
 .I SUB="SCPER" S FLD=50.03 Q
 .I SUB="POW" S FLD=50.04 Q
 .I SUB="A&A" S FLD=50.05 Q
 .I SUB="HB" S FLD=50.06 Q
 .I SUB="VAPEN" S FLD=50.07 Q
 .I SUB="VACKAMT" S FLD=50.08 Q
 .I SUB="DISRET" S FLD=50.09 Q
 .I SUB="DISLOD" S FLD=50.2 Q  ;field added with DG*5.3*672
 .I SUB="MEDICAID" S FLD=50.1 Q
 .I SUB="AO" S FLD=50.11 Q
 .I SUB="AOEXPLOC" S FLD=50.22 Q  ;field added with DG*5.3*688
 .I SUB="IR" S FLD=50.12 Q
 .I SUB="EC" S FLD=50.13 Q    ;name now SW Asia Con, was Env Con DG*5.3*688
 .I SUB="MTSTA" S FLD=50.14 Q
 .I SUB="VCD" S FLD=50.15 Q
 .I SUB="PH" S FLD=50.16 Q
 .I SUB="UNEMPLOY" S FLD=50.17 Q
 .I SUB="CVELEDT" S FLD=50.18 Q
 .I SUB="SHAD" S FLD=50.19 Q  ;field added with DG*5.3*653
 .I SUB="MOH" S FLD=50.23 Q
 .I SUB="CLE" S FLD=50.24 Q      ;field added with DG*5.3*909
 .I SUB="CLEDT" S FLD=50.25 Q    ;field added with DG*5.3*909
 .I SUB="CLEST" S FLD=50.26 Q    ;field added with DG*5.3*909
 .I SUB="CLESOR" S FLD=50.27 Q   ;field added with DG*5.3*909
 .I SUB="MOHAWRDDATE" S FLD=50.28 Q   ;field added with DG*5.3*972 HM
 .I SUB="MOHSTATDATE" S FLD=50.29 Q   ;field added with DG*5.3*972 HM
 .I SUB="MOHEXEMPDATE" S FLD=50.3 Q   ;field added with DG*5.3*972 HM
 .I SUB="OTHTYPE" S FLD=50.31 Q  ; DG*5.3*952
 .I SUB="DATETIME" S FLD=75.01 Q
 .I SUB="USER" S FLD=75.02 Q
 .I SUB="RADEXPM" S FLD=76 Q
 Q FLD
 ;
PROMPT(FILE,FIELD,DEFAULT,RESPONSE,REQUIRE,PRMPTNM) ;
 ;Description: requests user to enter a single field value.
 ;Input:
 ;  FILE - the file #
 ;  FIELD - the field #
 ;  DEFAULT - default value, internal form
 ;  REQUIRE - a flag, (+value)'=0 means to require a value to be
 ;            entered and to return failure otherwise (optional)
 ;  PRMPTNM - Optional
 ;             0 - display field LABEL
 ;             1 - Prompt field TITLE
 ;Output:
 ;  Function Value - 0 on failure, 1 on success
 ;  RESPONSE - value entered by user, pass by reference
 ;
 Q:(('$G(FILE))!('$G(FIELD))) 0
 S REQUIRE=$G(REQUIRE)
 S PRMPTNM=$G(PRMPTNM)
 N DIR,DA,QUIT,AGAIN
 ;
 S DIR(0)=FILE_","_FIELD_$S($G(REQUIRE):"",1:"O")_"AO"
 I $G(DEFAULT)'="" DO
 . S:+$G(PRMPTNM)=0 DIR("A")=$$GET1^DID(FILE,FIELD,"","LABEL")_": "_$$EXTERNAL^DILFD(FILE,FIELD,"F",DEFAULT)_"// "
 . S:+$G(PRMPTNM)>0 DIR("A")=$$GET1^DID(FILE,FIELD,"","TITLE")_": "_$$EXTERNAL^DILFD(FILE,FIELD,"F",DEFAULT)_"// "
 S QUIT=0
 F  D  Q:QUIT
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S QUIT=1 Q
 . I X="@" D  Q:AGAIN
 . . S AGAIN=0
 . . I 'REQUIRE,"Yy"'[$E($$YN^DGENCD1("  Are you sure")_"X") S AGAIN=1 Q
 . . S RESPONSE="" ; This might trigger the "required" message below.
 . E  I X="" S RESPONSE=$G(DEFAULT)
 . E  S RESPONSE=$P(Y,"^")
 . ;
 . ; quit this loop if the user entered value OR value not required
 . I RESPONSE'="" S QUIT=1 Q
 . I 'REQUIRE S QUIT=1 Q
 . W !,"This is a required response. Enter '^' to exit"
 I $D(DTOUT)!$D(DUOUT) Q 0
 Q 1
 ;
INST(VADUZ,VACHK) ;
 ; Description: Determine the institution affiliation associated with a
 ;              user.
 ;
 ;  Input:
 ;     VADUZ =  array if passed by reference:
 ;           VADUZ = DUZ
 ;           VADUZ(2) =  
 ;              o  if this value is null: DUZ(2) (institution affiliated
 ;                    with user, prompted at Kernel sign-on)
 ;              o  if value is not null: site to check as valid for the
 ;                    user (Pointer to INSTITUTION (#4) file)
 ; Output:
 ;   Function Value - Returns pointer to the INSTITUTION (#4) file
 ;    entry that is associated with the user, otherwise the pointer
 ;    to the INSTITUTION (#4) file entry of the primary VA Medical
 ;    Center division is returned.
 ;
 ;    VACHK = passed by reference, returned as:
 ;         null if the value in VADUZ(2) is null
 ;            0 if the value in VADUZ(2) is not null and is not a valid
 ;              site for the user
 ;            1 if the value in VADUZ(2) is not null and is a valid site
 ;              for the user
 ;
 S VACHK=$S($G(VADUZ(2))="":"",1:0)
 I $G(VADUZ(2)) D
 . N X,ZZ
 . Q:'$G(VADUZ)
 . S X=$$DIV4^XUSER(.ZZ,VADUZ)
 . I X,$D(ZZ(VADUZ(2))) S VACHK=1
 I '$G(VADUZ(2)) S VADUZ(2)=$G(DUZ(2))
 Q $S($G(VADUZ(2)):VADUZ(2),1:$P($$SITE^VASITE(),"^"))
 ;
GETINST(DGPREFAC,DGINST) ;Get Institution file data
 ; Input  -- DGPREFAC Institution file IEN
 ; Output -- 1=Successful and 0=Failure
 ;           DGINST - Institution file Array
 N DGINST0,DGINST99,DGOKF
 S DGINST0=$G(^DIC(4,DGPREFAC,0)) G GETQ:DGINST0=""
 S DGINST("NAME")=$P(DGINST0,U)
 S DGINST99=$G(^DIC(4,DGPREFAC,99))
 S DGINST("STANUM")=$P(DGINST99,U)
 S DGOKF=1
GETQ Q +$G(DGOKF)
