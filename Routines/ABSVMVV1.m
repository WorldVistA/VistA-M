ABSVMVV1 ;OAKLANDFO/DPC-VSS MIGRATION;7/9/2002
 ;;4.0;VOLUNTARY TIMEKEEPING;**31,33**;Jul 1994
 ;
 ;
VALVOL(FLAG,VALRES,START,END) ;Beginning of validation of volunteer data
 ;FLAG=S Send mode; so, build sort template array in XTMP.
 N VOLIEN
 N VOLCNT
 ;
 K ^TMP("ABSVM",$J)
 S VALRES("ERRCNT")=0
 S VALRES("DA")=$$CRERRLOG^ABSVMUT1("V",$G(FLAG))
 I VALRES("DA")=0 W !,"There was an error creating VALIDATION RESULTS entry for Volunteers." Q
 S VOLIEN=$G(START,0),END=$G(END,999999999999999),VOLCNT=0
 F  S VOLIEN=$O(^ABS(503330,VOLIEN)) Q:VOLIEN=""!(VOLIEN>END)  D
 . S VOLCNT=VOLCNT+1
 . D VOLVAL($G(FLAG),VOLIEN)
 . Q
 D ERRCNT^ABSVMUT1(.VALRES)
 Q
 ;
VOLVAL(FLAG,VOLIEN) ;
 N VOL0,VOLIDEN,ERRS,VOL3
 N VOLNAME,SSN,AD1,CITY,DOB,LANG,SEX,STPTR,ZIP
 ;Check if Volunteer had hours. If not, don't process.
 ;Need to add exception for brand new volunteers (entry < 3 mos.)
 I '$D(^TMP("ABSVM","VOLWHRS",$J,VOLIEN)) Q
 S ERRS=0
 S VOL0=$G(^ABS(503330,VOLIEN,0))
 S VOL3=$G(^ABS(503330,VOLIEN,3))
 ;IEN
 I VOL0="" D ADDERR("Volunteer record #"_VOLIEN_" does not exist",.ERRS) D RECERR^ABSVMUT1(.VALRES,.ERRS) Q
 ;NAME
 S VOLNAME=$P(VOL0,U,1)
 I VOLNAME="" D ADDERR("Volunteer record #"_VOLIEN_" does not have a volunteer name.",.ERRS)
 S VOLIDEN="Volunteer record #"_VOLIEN_" with Name "_VOLNAME_" "
 D STDNAME^XLFNAME(.VOLNAME,"C")
 I VOLNAME("FAMILY")="" D ADDERR(VOLIDEN_"is missing a last name.",.ERRS)
 I $L(VOLNAME("FAMILY"))>30 D ADDERR(VOLIDEN_"has a last name longer than 30 characters.",.ERRS)
 I VOLNAME("GIVEN")="" D ADDERR(VOLIDEN_"is missing a first name.",.ERRS)
 I $L(VOLNAME("GIVEN"))>30 D ADDERR(VOLIDEN_"has a first name longer than 30 characters.",.ERRS)
 I $L(VOLNAME("MIDDLE"))>20 D ADDERR(VOLIDEN_"has a middle name longer than 20 characters.",.ERRS)
 I $L(VOLNAME("SUFFIX"))>10 D ADDERR(VOLIDEN_"has a name suffix longer than 10 characters.",.ERRS)
 ;SSN
 D
 . S SSN=$P(VOL0,U,2)
 . I SSN="" D ADDERR(VOLIDEN_"is missing a Social Security Number.",.ERRS) Q
 . I SSN'?9N D ADDERR(VOLIDEN_" has an incorrect SSN: "_SSN_".",.ERRS) Q
 . I $D(^TMP("ABSVM",$J,"SSN",SSN)) D  Q
 .. N ERRORS
 .. S ERRORS(1)="Warning: "_VOLIDEN_"has a duplicate SSN with record "_^TMP("ABSVM",$J,"SSN",SSN)
 .. I $G(VALRES("ERRIEN"))="" D
 ... N ABSIEN
 ... D ABSIEN^ABSVMUT1 Q:'ABSIEN
 ... S VALRES("ERRIEN")=ABSIEN
 ... Q
 .. D WP^DIE(503339.52,VALRES("DA")_","_VALRES("ERRIEN")_",",4,"A","ERRORS")
 .. Q
 . S ^TMP("ABSVM",$J,"SSN",SSN)=VOLIEN
 ;ADDR #1
 S AD1=$P(VOL0,U,3)
 I AD1="" D ADDERR(VOLIDEN_"is missing first line of address.",.ERRS)
 I $L(AD1)>35 D ADDERR(VOLIDEN_"has a first line of address longer than 35 characters.",.ERRS)
 ;CITY
 S CITY=$P(VOL0,U,4)
 I CITY="" D ADDERR(VOLIDEN_"is missing a city.",.ERRS)
 I $L(CITY)>30 D ADDERR(VOLIDEN_"has a city longer than 30 characters.",ERRS)
 ;STATE
 ;MAY NEED CHECK ABBREVIATION AGAINST AN ACCEPTABLE LIST.
 S STPTR=$P(VOL0,U,5)
 I STPTR="" D ADDERR(VOLIDEN_"is missing a state.",.ERRS)
 I STPTR'="",$L($P($G(^DIC(5,STPTR,0)),U,2))'=2 D ADDERR(VOLIDEN_"has incorrect state data.",.ERRS)
 ;ZIP
 S ZIP=$P(VOL0,U,6)
 I ZIP="" D ADDERR(VOLIDEN_"is missing a zip code.",.ERRS)
 I $L(ZIP)>10 D ADDERR(VOLIDEN_"has a zip code longer than 10 characters.",.ERRS)
 ;SEX
 S SEX=$P(VOL0,U,7)
 I SEX="" D ADDERR(VOLIDEN_"is missing a gender designation.",.ERRS)
 I ",M,F,B,G,"'[(","_SEX_",") D ADDERR(VOLIDEN_"has incorrect sex data.",.ERRS)
 ;DOB
 D
 . S DOB=$P(VOL0,U,8)
 . I DOB="" D ADDERR(VOLIDEN_"is missing a data of birth.",.ERRS) Q
 . N RES D DT^DILF("",DOB,.RES)
 . I $L($P(DOB,"."))'=7!(RES=-1) D ADDERR(VOLIDEN_"has incorrect date of birth date.",.ERRS)
 . Q
 ;NICK NAME
 I $L($P(VOL0,U,9))>20 D ADDERR(VOLIDEN_"has a nick name longer than 20 characters.",.ERRS)
 ;ADDR #2
 I $L($P(VOL0,U,10))>35 D ADDERR(VOLIDEN_"has a second line of address longer than 35 characters.",.ERRS)
 ;LANGUAGE
 S LANG=$P(VOL0,U,11)
 I LANG'="",",1,2,"'[(","_LANG_",") D ADDERR(VOLIDEN_"has an incorrect preferred language code.",.ERRS)
 ;PSEUDO SSN
 I $P(VOL0,U,18)'="P",$P(VOL0,1,18)'="" D ADDERR(VOLIDEN_"has an incorect psuedo SSN indicator",.ERRS)
 ;CODE
 I $L($P(VOL0,U,22))>5 D ADDERR(VOLIDEN_"has a Code longer than 5 characters.",.ERRS)
 ;NOK
 I $L($P(VOL3,U,1))>30 D ADDERR(VOLIDEN_"has a Next of Kin longer than 30 characters.",.ERRS)
 ;PHONE
 I $L($P(VOL3,U,2))>30 D ADDERR(VOLIDEN_"has a Telephone Number longer than 30 characters.",.ERRS)
 ;NOK RELATIONSHIP
 I $L($P(VOL3,U,3))>15 D ADDERR(VOLIDEN_"has a Kin's Relationship longer than 15 characters.",.ERRS)
 ;NOK TELEPHONE
 I $L($P(VOL3,U,4))>30 D ADDERR(VOLIDEN_"has a Kin's Telephone longer than 30 characters.",.ERRS)
 ;NOK ALT PHONE
 I $L($P(VOL3,U,5))>30 D ADDERR(VOLIDEN_"has a Kin's Alternate Phone longer than 30 characters.")
 ;ALT PHONE
 I $L($P(VOL3,U,7))>30 D ADDERR(VOLIDEN_"has an Alternate Phone longer than 30 characters.",.ERRS)
 ;Record errors
 I ERRS>0 D RECERR^ABSVMUT1(.VALRES,.ERRS)
 ;If no errors, proceed and add to sort template.
 I $G(FLAG)["S",'ERRS S ^XTMP("ABSVMVOL","IEN",VOLIEN)=""
 ;STATION PROFILE
 D PROF^ABSVMVV2(VOLIEN,VOLIDEN,$G(FLAG),.VALRES)
 ;COMBINATIONS
 D COMBVAL^ABSVMVV3(VOLIEN,VOLIDEN,$G(FLAG),.VALRES)
 ;
 Q
 ;
ADDERR(ERRMSG,ERRS,ABSVIEN) ;
 S ERRS=ERRS+1
 S ERRS(ERRS)=ERRMSG
 Q
