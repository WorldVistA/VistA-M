OOPSSUP3 ;HINES/WAA-S/E Supervisor Edit routine 2162 ;04/15/1998
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
ASIST ;  2162 FORM
 N INCID,SUP,CAT,OBJ,IEN200
 S INCID=$$GET1^DIQ(2260,IEN,3,"I")
 S:INCID'="" INCID=$$GET1^DIQ(2261.2,INCID,.01,"E") ; Getting the type of incident
 S INCID=U_INCID_U
 ; Allow edit of supervisor, secondary supervisor
 ; Also, include logic for Non-PAID employee
 S CAT=$$GET1^DIQ(2260,IEN,2,"I")
 ; Patch 5 - added logic for employee CAT >6
 S SUP=$S((CAT=1!(CAT>6)):" SUPERVISOR...............",CAT=2:" VOLUNTARY SVC SUPERVISOR.",CAT=3:" CONTRACT ADMINISTRATOR...",1:" SAFETY OFFICER...........")
 ; Patch 11 - get service, renumber DR array, add new prompts
 S IEN200=$$GET1^DIQ(2260,IEN,5,"I"),SER=""
 I $G(IEN200)'="" S IEN200=$O(^VA(200,"SSN",IEN200,""))
 I $G(IEN200)'="" S SER=$$GET1^DIQ(200,IEN200,29,"I")
 S DR=""
 S DR(1,2260,1)="86////^S X=SER"
 S DR(1,2260,2)="53"_SUP
 S DR(1,2260,5)="53.1 SECONDARY SUPERVISOR....."
 S DR(1,2260,10)="26 GENERAL SETTING OF INCIDENT........;S X=X;"
 S DR(1,2260,15)="27 LOCATION OF INJURY.................;S X=X;D CARE2^OOPSUTL2(IEN);"
 S DR(1,2260,20)="28 DESCRIPTION OF INCIDENT............"
 ; Patch 5 - added line below
 S DR(1,2260,25)="29.5 HOW IS INCIDENT RELATED TO MEDICAL EMERGENCY"
 S DR(1,2260,30)="29 CHARACTERIZATION OF INJURY........."
 S DR(1,2260,35)="30 BODY PART MOST AFFECTED............"
 S DR(1,2260,40)="30.1 ADDITIONAL BODY PART AFFECTED......"
 S DR(1,2260,45)="31 SIDE OF BODY AFFECTED..............;S X=X;"
SHARPS ; SHARPS DATA
 ; Patch 5 - added Suture Needlestick
 I "^Sharps Exposure^Hollow Bore Needlestick^Suture Needlestick^"'[INCID G FLUID
 S DR(1,2260,50)="34 PATIENT SOURCE....................."
 S DR(1,2260,55)="35 CONTAMINATION......................"
 S DR(1,2260,60)="36 PURPOSE OF SHARP OBJECT..........."
 S DR(1,2260,65)="37 ACTIVITY AT TIME OF INJURY........"
 S DR(1,2260,70)="38 OBJECT CAUSING INJURY.............;S X=X;"
 S DR(1,2260,80)="S OBJ=$$GET1^DIQ(2260,IEN,""38:2"",""I"")"
 S DR(1,2260,85)="I OBJ'=""N"" S Y=""@1"""
 S DR(1,2260,90)="83 DEVICE SIZE......................."
 S DR(1,2260,95)="S Y=""@2"""
 S DR(1,2260,100)="@1"
 S DR(1,2260,105)="83////@"               ; delete if OBJ'="N" or "S"
 S DR(1,2260,110)="@2"
 S DR(1,2260,115)="82 BRAND............................."
 G ALL
FLUID ; Body Fluid Exposer
 I "^Exposure to Body Fluids/Splash^"'[INCID G EVERY
 S DR(1,2260,115)="34 PATIENT SOURCE....................."
 S DR(1,2260,120)="39"                  ; Multiple, DD prompt used - P5
 S DR(1,2260,125)="40"                  ; Multiple, DD prompt used - P5
 S DR(1,2260,130)="41 BODILY FLUID EXPOSURE SOURCE......."
ALL ; ALL TYPE OF EXPOSURES
 ; Patch 5 - Changed logic
 S FAIL=$$GET1^DIQ(2260,IEN,42.5,"E") I FAIL="" S FAIL="No"
 S DR(1,2260,135)="42.5 WAS THERE AN EQUIPMENT/DEVICE/PRODUCT FAILURE//^S X=FAIL;I X=""N"" S Y=""@3"""
 S DR(1,2260,140)="42 DESCRIBE EQUIPMENT/DEVICE/PRODUCT FAILURE.."
 S DR(1,2260,145)="S Y=43"
 S DR(1,2260,150)="@3"
 S DR(1,2260,155)="42////@"
 S DR(1,2260,160)="43 SAFETY DESIGN DEVICE USED....;S X=X;"
 ; started adding for patch 11
 S DR(1,2260,165)="S Y=$S(X=""Y"":""@4"",X=""N"":""@5"",1:""@6"")"
 S DR(1,2260,170)="@4"
 S DR(1,2260,172)="85////@"
 S DR(1,2260,175)="87 DID THE INJURY OCCUR BEFORE THE SAFETY DEVICE WAS ENGAGED.."
 S DR(1,2260,180)="84 SAFETY CHARACTERISTICS......."
 S DR(1,2260,185)="S Y=""@6"""
 S DR(1,2260,190)="@5"
 S DR(1,2260,195)="84////@"
 S DR(1,2260,197)="87////@"
 S DR(1,2260,200)="85 EXPLAIN WHY A SAFETY DEVICE WAS NOT USED..."
 S DR(1,2260,205)="@6"
EVERY ; All Employees
 ; Include CAT=6 Non-PAID employee as employee
 I $$ISEMP^OOPSUTL4(IEN) D
 .S DR(1,2260,210)="32 DUTY RETURNED TO..................."
 .S DR(1,2260,215)="33 LOST TIME..........................;S X=X;"
 .Q
 S DR(1,2260,220)="47 CORRECTIVE ACTION............"
 Q
