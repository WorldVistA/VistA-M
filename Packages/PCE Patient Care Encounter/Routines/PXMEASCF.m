PXMEASCF ;SLC/PKR Utilities for checking and fixing measurements. ;06/08/2022
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**217**;Aug 12, 1996;Build 134
 ;Check the definition files for measurements that are not completely defined.
 ;For measurements that are completely defined, check the corresponding V-file
 ;for entries that have a MAGNITUDE, but are missing the UCUM CODE. When any of
 ;these are found, set the UCUM CODE to that found in the definition.
 ;
 ;===============================
ASKYN(DEFAULT,TEXT) ;Ask a YES/NO question.
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A")=TEXT
 S DIR("B")=DEFAULT
 S DIR("?")="Enter Y or N."
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S Y=0
 Q Y
 ;
 ;===============================
CFEDU ;Check/fix Education Topics factors that have measurements defined.
 N ALLDEF,ANS,IEN,IND,MAX,MAXDEC,MEASLIST,MIN,NAME,NL,PCAPTION,TEXT,TMP220,UCUMCODE,UCUMDISPLAY
 W !,"Checking Education Topics for complete measurement setup."
 S NAME=""
 F  S NAME=$O(^AUTTEDT("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTEDT("B",NAME,""))
 . S TMP220=$G(^AUTTEDT(IEN,220))
 . I TMP220="" Q
 . S MIN=$P(TMP220,U,1),MAX=$P(TMP220,U,2)
 . S MAXDEC=$P(TMP220,U,3),UCUMCODE=$P(TMP220,U,4)
 . S PCAPTION=$P(TMP220,U,5),UCUMDISPLAY=$P(TMP220,U,6)
 . I (MIN=""),(MAX=""),(MAXDEC=""),(UCUMCODE=""),(PCAPTION=""),(UCUMDISPLAY="") Q
 .;If any of the measurement fields are defined, they all
 .;must be.
 . K TEXT
 . S ALLDEF=1
 . S TEXT(1)=""
 . S TEXT(2)="Education Topic: "_NAME
 . S NL=2
 . I MIN="" S ALLDEF=0,NL=NL+1,TEXT(NL)="MINIMUM VALUE is not defined."
 . I MAX="" S ALLDEF=0,NL=NL+1,TEXT(NL)="MAXIMUM VALUE is not defined."
 . I MAXDEC="" S ALLDEF=0,NL=NL+1,TEXT(NL)="MAXIMUM DECIMALS is not defined."
 . I UCUMCODE="" S ALLDEF=0,NL=NL+1,TEXT(NL)="UCUM CODE is not defined."
 . I PCAPTION="" S ALLDEF=0,NL=NL+1,TEXT(NL)="PROMPT CAPTION is not defined."
 . I UCUMDISPLAY="" S ALLDEF=0,NL=NL+1,TEXT(NL)="UCUM DISPLAY is not defined."
 . I ALLDEF=1 S MEASLIST(NAME)=IEN_U_UCUMCODE  Q
 . F IND=1:1:NL W !,TEXT(IND)
 I $D(MEASLIST) D
 . S ANS=$$ASKYN("Y","Search for and repair V PATIENT ED entries missing the UCUM CODE? ")
 . I ANS=1 D CFVPATED(.MEASLIST)
 Q
 ;
 ;===============================
CFEXAM ;Check/fix Exams that have measurements defined.
 N ALLDEF,ANS,IEN,IND,MAX,MAXDEC,MEASLIST,MIN,NAME,NL,PCAPTION,TEXT,TMP220,UCUMCODE,UCUMDISPLAY
 W !,"Checking Exams for complete measurement setup."
 S NAME=""
 F  S NAME=$O(^AUTTEXAM("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTEXAM("B",NAME,""))
 . S TMP220=$G(^AUTTEXAM(IEN,220))
 . I TMP220="" Q
 . S MIN=$P(TMP220,U,1),MAX=$P(TMP220,U,2)
 . S MAXDEC=$P(TMP220,U,3),UCUMCODE=$P(TMP220,U,4)
 . S PCAPTION=$P(TMP220,U,5),UCUMDISPLAY=$P(TMP220,U,6)
 . I (MIN=""),(MAX=""),(MAXDEC=""),(UCUMCODE=""),(PCAPTION=""),(UCUMDISPLAY="") Q
 .;If any of the measurement fields are defined, they all
 .;must be.
 . K TEXT
 . S ALLDEF=1
 . S TEXT(1)=""
 . S TEXT(2)="Exam: "_NAME
 . S NL=2
 . I MIN="" S ALLDEF=0,NL=NL+1,TEXT(NL)="MINIMUM VALUE is not defined."
 . I MAX="" S ALLDEF=0,NL=NL+1,TEXT(NL)="MAXIMUM VALUE is not defined."
 . I MAXDEC="" S ALLDEF=0,NL=NL+1,TEXT(NL)="MAXIMUM DECIMALS is not defined."
 . I UCUMCODE="" S ALLDEF=0,NL=NL+1,TEXT(NL)="UCUM CODE is not defined."
 . I PCAPTION="" S ALLDEF=0,NL=NL+1,TEXT(NL)="PROMPT CAPTION is not defined."
 . I UCUMDISPLAY="" S ALLDEF=0,NL=NL+1,TEXT(NL)="UCUM DISPLAY is not defined."
 . I ALLDEF=1 S MEASLIST(NAME)=IEN_U_UCUMCODE  Q
 . F IND=1:1:NL W !,TEXT(IND)
 I $D(MEASLIST) D
 . S ANS=$$ASKYN("Y","Search for and repair V EXAM entries missing the UCUM CODE? ")
 . I ANS=1 D CFVEXAM(.MEASLIST)
 Q
 ;
 ;===============================
CFHF ;Check/fix health factors that have measurements defined.
 N ALLDEF,ANS,IEN,IND,MAX,MAXDEC,MEASLIST,MIN,NAME,NL,PCAPTION,TEXT,TMP220,UCUMCODE,UCUMDISPLAY
 W !,"Checking Health Factors for complete measurement setup."
 S NAME=""
 F  S NAME=$O(^AUTTHF("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTHF("B",NAME,""))
 . S TMP220=$G(^AUTTHF(IEN,220))
 . I TMP220="" Q
 . S MIN=$P(TMP220,U,1),MAX=$P(TMP220,U,2)
 . S MAXDEC=$P(TMP220,U,3),UCUMCODE=$P(TMP220,U,4)
 . S PCAPTION=$P(TMP220,U,5),UCUMDISPLAY=$P(TMP220,U,6)
 . I (MIN=""),(MAX=""),(MAXDEC=""),(UCUMCODE=""),(PCAPTION=""),(UCUMDISPLAY="") Q
 .;If any of the measurement fields are defined, they all
 .;must be.
 . K TEXT
 . S ALLDEF=1
 . S TEXT(1)=""
 . S TEXT(2)="Health Factor: "_NAME
 . S NL=2
 . I MIN="" S ALLDEF=0,NL=NL+1,TEXT(NL)="MINIMUM VALUE is not defined."
 . I MAX="" S ALLDEF=0,NL=NL+1,TEXT(NL)="MAXIMUM VALUE is not defined."
 . I MAXDEC="" S ALLDEF=0,NL=NL+1,TEXT(NL)="MAXIMUM DECIMALS is not defined."
 . I UCUMCODE="" S ALLDEF=0,NL=NL+1,TEXT(NL)="UCUM CODE is not defined."
 . I PCAPTION="" S ALLDEF=0,NL=NL+1,TEXT(NL)="PROMPT CAPTION is not defined."
 . I UCUMDISPLAY="" S ALLDEF=0,NL=NL+1,TEXT(NL)="UCUM DISPLAY is not defined."
 . I ALLDEF=1 S MEASLIST(NAME)=IEN_U_UCUMCODE  Q
 . F IND=1:1:NL W !,TEXT(IND)
 I $D(MEASLIST) D
 . S ANS=$$ASKYN("Y","Search for and repair V HEALTH FACTORS entries missing the UCUM CODE? ")
 . I ANS=1 D CFVHF(.MEASLIST)
 Q
 ;
 ;===============================
CFVEXAM(MEASLIST) ; Check V Exam.
 N EXAMIEN,IND,MAGNITUDE,NAME,NSET,TEMP220,TEXT,UCUMCODE,UCUMIEN,VEXAMIEN
 S TEXT(1)="Checking V Exam for missing UCUM CODES."
 S NAME="",NL=1
 F  S NAME=$O(MEASLIST(NAME)) Q:NAME=""  D
 . S NSET=0
 . S EXAMIEN=$P(MEASLIST(NAME),U,1)
 . S UCUMCODE=$P(MEASLIST(NAME),U,2)
 . S VEXAMIEN=""
 . F  S VEXAMIEN=$O(^AUPNVXAM("B",EXAMIEN,VEXAMIEN)) Q:VEXAMIEN=""  D
 .. S TEMP220=$G(^AUPNVXAM(VEXAMIEN,220))
 .. S MAGNITUDE=$P(TEMP220,U,1)
 .. I MAGNITUDE="" Q
 .. S UCUMIEN=$P(TEMP220,U,2)
 .. I UCUMIEN="" S NSET=NSET+1,$P(^AUPNVXAM(VEXAMIEN,220),U,2)=UCUMCODE
 . I NSET>0 D
 .. S NL=NL+1,TEXT(NL)=""
 .. S NL=NL+1,TEXT(NL)="For the Exam: "_NAME
 .. S NL=NL+1,TEXT(NL)="The UCUM CODE was set for "_NSET_" V Exam entries."
 I NL=1 S NL=NL+1,TEXT(NL)="No missing UCUM CODEs were found."
 F IND=1:1:NL W !,TEXT(IND)
 Q
 ;
 ;===============================
CFVHF(MEASLIST) ; Check V Health Factors.
 N HFIEN,IND,MAGNITUDE,NAME,NSET,TEMP220,TEXT,UCUMCODE,UCUMIEN,VHFIEN
 S TEXT(1)="Checking V Health Factors for missing UCUM CODES."
 S NAME="",NL=1
 F  S NAME=$O(MEASLIST(NAME)) Q:NAME=""  D
 . S NSET=0
 . S HFIEN=$P(MEASLIST(NAME),U,1)
 . S UCUMCODE=$P(MEASLIST(NAME),U,2)
 . S VHFIEN=""
 . F  S VHFIEN=$O(^AUPNVHF("B",HFIEN,VHFIEN)) Q:VHFIEN=""  D
 .. S TEMP220=$G(^AUPNVHF(VHFIEN,220))
 .. S MAGNITUDE=$P(TEMP220,U,1)
 .. I MAGNITUDE="" Q
 .. S UCUMIEN=$P(TEMP220,U,2)
 .. I UCUMIEN="" S NSET=NSET+1,$P(^AUPNVHF(VHFIEN,220),U,2)=UCUMCODE
 . I NSET>0 D
 .. S NL=NL+1,TEXT(NL)=""
 .. S NL=NL+1,TEXT(NL)="For the Health Factor: "_NAME
 .. S NL=NL+1,TEXT(NL)="The UCUM CODE was set for "_NSET_" V Health Factor entries."
 I NL=1 S NL=NL+1,TEXT(NL)="No missing UCUM CODEs were found."
 F IND=1:1:NL W !,TEXT(IND)
 Q
 ;
 ;===============================
CFVPATED(MEASLIST) ; Check V Patient Ed.
 N EDUIEN,IND,MAGNITUDE,NAME,NSET,TEMP220,TEXT,UCUMCODE,UCUMIEN,VPATEDIEN
 S TEXT(1)="Checking V Health Factors for missing UCUM CODES."
 S NAME="",NL=1
 F  S NAME=$O(MEASLIST(NAME)) Q:NAME=""  D
 . S NSET=0
 . S EDUIEN=$P(MEASLIST(NAME),U,1)
 . S UCUMCODE=$P(MEASLIST(NAME),U,2)
 . S VPATEDIEN=""
 . F  S VPATEDIEN=$O(^AUPNVPED("B",EDUIEN,VPATEDIEN)) Q:VPATEDIEN=""  D
 .. S TEMP220=$G(^AUPNVPED(VPATEDIEN,220))
 .. S MAGNITUDE=$P(TEMP220,U,1)
 .. I MAGNITUDE="" Q
 .. S UCUMIEN=$P(TEMP220,U,2)
 .. I UCUMIEN="" S NSET=NSET+1,$P(^AUPNVPED(VPATEDIEN,220),U,2)=UCUMCODE
 . I NSET>0 D
 .. S NL=NL+1,TEXT(NL)=""
 .. S NL=NL+1,TEXT(NL)="For the Education Topic: "_NAME
 .. S NL=NL+1,TEXT(NL)="The UCUM CODE was set for "_NSET_" V Patient Ed entries."
 I NL=1 S NL=NL+1,TEXT(NL)="No missing UCUM CODEs were found."
 F IND=1:1:NL W !,TEXT(IND)
 Q
 ;
