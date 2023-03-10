PXAIVAL ;ISL/PKR - Validation for V-file input. ;05/31/2022
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211,217**;Aug 12, 1996;Build 134
 ;
 ;Some fields are the same for all the V-files, the same validation
 ;routine can be used for all of them.
 ;
 ;====================
DATETIME(FIELDNAM,PXDT,%DT,PXAERR) ;Validate a date and time.
 I PXDT="@" Q 1
 ;Verify it is a valid FileMan date.
 I $$VFMDATE^PXDATE(PXDT,%DT)=-1 D  Q 0
 . S PXAERR(9)=FIELDNAM
 . S PXAERR(11)=PXDT
 . S PXAERR(12)=PXDT_" is not a valid internal FileMan date."
 . I %DT'["R",%DT'["T" S PXAERR(13)="Time is not allowed for this date."
 ;
 ;Verify it is not a future date.
 I $$FUTURE^PXDATE(PXDT) D  Q 0
 . S PXAERR(9)=FIELDNAM
 . S PXAERR(11)=PXDT
 . S PXAERR(12)=PXDT_" is a future date."
 Q 1
 ;
 ;====================
EVENTDT(EVENTDT,%DT,PXAERR) ;Validate EVENT D/T.
 I EVENTDT="@" Q 1
 ;Verify it is a valid FileMan date.
 I $$VFMDATE^PXDATE(EVENTDT,%DT)=-1 D  Q 0
 . S PXAERR(9)="EVENT D/T"
 . S PXAERR(11)=EVENTDT
 . S PXAERR(12)=EVENTDT_" is not a valid FileMan date."
 ;
 ;Verify it is not a future date.
 I $$FUTURE^PXDATE(EVENTDT) D  Q 0
 . S PXAERR(9)="EVENT D/T"
 . S PXAERR(11)=EVENTDT
 . S PXAERR(12)=EVENTDT_" is a future date."
 Q 1
 ;
 ;====================
MAG(MAG,MPARAMS,PXAERR) ;If a measurement is being input verify that the
 ;magnitude is in the allowed range.
 I MAG="@" D  Q 0
 . S PXAERR(9)="MAGNITUDE"
 . S PXAERR(11)=MAG
 . S PXAERR(12)="Measurements cannot be deleted, they can be edited."
 I MAG="" D  Q 0
 . S PXAERR(9)="MAGNITUDE"
 . S PXAERR(11)="NULL"
 . S PXAERR(12)="Magnitude cannot be NULL."
 ;
 N UCUMCHECK,UCUMCODE,UCUMERROR,UCUMIEN,UCUMSPECIAL
 S (UCUMERROR,UCUMSPECIAL)=0
 S UCUMIEN=$P(MPARAMS,U,4)
 I UCUMIEN="" D  Q 0
 . S PXAERR(9)="UCUM CODE"
 . S PXAERR(11)="NULL"
 . S PXAERR(12)="UCUM CODE cannot be NULL."
 ;
 S UCUMCODE=$$UCUMCODE^LEXMUCUM(UCUMIEN)
 I $P(UCUMCODE,U,1)="{unit not defined}" D  Q 0
 . S PXAERR(9)="UCUM CODE"
 . S PXAERR(11)="Unit not defined"
 . S PXAERR(12)=$P(UCUMCODE,U,2)
 ;
 ;There are two UCUM CODES where MAGNITUDE is not a
 ;number: {mm/dd/yyyy} and {clock_time}. These require
 ;special validation.
 S (UCUMERROR,UCUMSPECIAL)=0
 I UCUMCODE="{mm/dd/yyyy}" D
 . S UCUMSPECIAL=1
 . I MAG'?2N1"/"2N1"/"4N D
 .. S PXAERR(9)="UCUM month-day-year"
 .. S PXAERR(11)=MAG
 .. S PXAERR(12)=MAG_" does not follow the format mm/dd/yyyy."
 .. S UCUMERROR=1
 . I UCUMERROR=1 Q
 . N %DT,X,Y
 . S %DT="N",X=MAG
 . D ^%DT
 . I Y=-1 D
 .. S PXAERR(9)="UCUM month-day-year"
 .. S PXAERR(11)=MAG
 .. S PXAERR(12)=MAG_" is not a vaild date."
 .. S UCUMERROR=1
 I UCUMERROR=1 Q 0
 ;
 I UCUMCODE="{clock_time}" D
 . S UCUMSPECIAL=1
 . I MAG'?1.2N1":"2N1(1"AM",1"PM") D
 .. S PXAERR(9)="UCUM clock time e.g 12:30PM"
 .. S PXAERR(11)=MAG
 .. S PXAERR(12)=MAG_" does not follow the format HH:MMAM or HH:MMPM."
 .. S UCUMERROR=1
 . I UCUMERROR=1 Q
 . N HH,MM
 . S HH=$P(MAG,":",1)
 . I (HH<1)!(HH>12) D
 .. S PXAERR(9)="UCUM clock time e.g 12:30PM"
 .. S PXAERR(11)=MAG
 .. S PXAERR(12)=HH_" is not a valid hour."
 .. S UCUMERROR=1
 . I UCUMERROR=1 Q
 . S MM=$P(MAG,":",2),MM=$E(MM,1,2)
 . I (MM<1)!(MM>59) D
 .. S PXAERR(9)="UCUM clock time e.g 12:30PM"
 .. S PXAERR(11)=MAG
 .. S PXAERR(12)=MM_" is not valid for minutes."
 .. S UCUMERROR=1
 I UCUMERROR=1 Q 0
 I UCUMSPECIAL=1 Q 1
 ;
 ;Check for a valid magnitude, a positive or negative number,
 ;up to 14 digits and 9 decimal places.
 I MAG'?0.1(0.1"-",0.1"+")0.14N0.1(1"."0.9N) D  Q 0
 . S PXAERR(9)="MAGNITUDE"
 . S PXAERR(11)=MAG
 . S PXAERR(12)="Magnitude "_MAG_", is not a number in the acceptable range."
 N MAX,MAXDEC,MIN,NUM,NUMDEC
 S MIN=$P(MPARAMS,U,1),MAX=$P(MPARAMS,U,2),MAXDEC=$P(MPARAMS,U,3)
 S NUM=+PXAA("MAGNITUDE")
 I (MIN>NUM)!(MAX<NUM) D  Q 0
 . S PXAERR(9)="MAGNITUDE"
 . S PXAERR(11)=MAG
 . S PXAERR(12)="Magnitude "_MAG_" is outside the range "_MIN_" to "_MAX
 S NUMDEC=$L($P(NUM,".",2))
 I NUMDEC>MAXDEC D  Q 0
 . S PXAERR(9)="MAGNITUDE"
 . S PXAERR(11)=MAG
 . S PXAERR(12)="The maximum number of decimals is "_MAXDEC_", the input contains "_NUMDEC_"."
 ;If magnitude is a fraction does not start with 0 add it.
 Q 1
 ;
 ;====================
PRV(PXDUZ,PRVTYPE,PXAA,PXAERR,PXAVISIT) ;Validate a provider.
 ;PRVTYP can be "ENC PROVIDER" or "ORD PROVIDER".
 I '$$VPRV^PXAIPRVV(PXDUZ,.PXAA,.PXAERR,PXAVISIT) D  Q 0
 . S PXAERR(9)=PRVTYPE_" PROVIDER"
 . S PXAERR(11)=PXDUZ
 Q 1
 ;
 ;====================
SET(FILENUM,FIELDNAM,FIELDNUM,VALUE,PXAERR) ;Validate Set of Codes input.
 I VALUE="@" Q 1
 N EXTERNAL,MSG
 S EXTERNAL=$$EXTERNAL^DILFD(FILENUM,FIELDNUM,"",VALUE,"MSG")
 I (EXTERNAL=""),$D(MSG) D  Q 0
 . S PXAERR(9)=FIELDNAM
 . S PXAERR(11)=VALUE
 . S PXAERR(12)=MSG("DIERR",1,"TEXT",1)
 . S PXAERR(13)=MSG("DIERR",1,"TEXT",2)
 Q 1
 ;
 ;====================
TEXT(FIELDNAM,TEXT,MIN,MAX,PXAERR) ;Validate a free text field.
 I TEXT="@" Q 1
 I (($L(TEXT)<MIN)!($L(TEXT)>MAX)) D  Q 0
 . S PXAERR(9)=FIELDNAM
 . S PXAERR(11)=TEXT
 . S PXAERR(12)="The length of "_FIELDNAM_" is less than "_MIN_" or greater than "_MAX_"."
 Q 1
 ;
 ;====================
VPKG(PKG,PXAERR) ;Is the Package parameter valid?
 N FLAGS,IEN,MSG
 S FLAGS=$S(+PKG=PKG:"A",1:"M")
 S IEN=+$$FIND1^DIC(9.4,"",FLAGS,PKG,"","","MSG")
 I IEN=0 D  Q 0
 . S PXAERR(9)="PKG"
 . S PXAERR(11)="The value is: "_PKG
 . I FLAGS="A" S PXAERR(12)=PKG_" is not a valid pointer to the Package file #9.4"
 . I FLAGS="M" S PXAERR(12)=$G(MSG("DIERR",1,"TEXT",1))
 Q IEN
 ;
 ;====================
VSOURCE(SOURCE,PXAERR) ;Is the Data Source valid?
 I +SOURCE=SOURCE,($D(^PX(839.7,SOURCE,0))) Q SOURCE
 I +SOURCE=SOURCE,('$D(^PX(839.7,SOURCE,0))) D  Q  Q
 . S PXAERR(7)="ENCOUNTER"
 . S PXAERR(9)="DATA2PCE parameter SOURCE"
 . S PXAERR(11)="The value is: "_SOURCE
 . S PXAERR(12)=SOURCE_" is not a valid pointer to the PCE Data Source file #839.7"
 ;
 I ($L(SOURCE)<3)!($L(SOURCE)>64) D  Q 0
 . S PXAERR(7)="ENCOUNTER"
 . S PXAERR(9)="DATA2PCE parameter SOURCE"
 . S PXAERR(11)="The value is: "_SOURCE
 . S PXAERR(12)="The length of SOURCE is less than 3 or greater than 64."
 Q $$SOURCE^PXAPIUTL(SOURCE)
 ;
