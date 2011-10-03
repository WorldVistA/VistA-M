OOPSEMP2 ;WIOFO/LLH-E/E Employee CA2 data ;4/24/00
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
 ; Employee/Person Address is now only stored in the 2162A node
 ; of file 2260.  Prior to patch 3 it was stored in the CA1A and
 ; CA2A nodes depending on which form was entered.  The address
 ; is only 'pulled' from this location when printing either form.
 ;
 W !!," Notice of Occupational Disease and Claim for Compensation (Form CA-2)"
 W !!,"     Employee Data"
 W !,"     -------------"
 K DIQ,DA,DR S DIC="^OOPS(2260,",DR=".01;1;2;5;6;7;16;17",DA=IEN,DIQ="OOPS",DIQ(0)="IE"
 D EN^DIQ1
 K DR,DO,DD
 S DR=""
 S DR(1,2260,1)="63////^S X=PAYP"        ; Pay Plan from PAID
 S DR(1,2260,2)="W !,""  1. NAME OF EMPLOYEE......: "",OOPS(2260,IEN,1,""E"")"
 S DR(1,2260,5)="W !,""  2. SOCIAL SECURITY NUMBER: "",OOPS(2260,IEN,5,""E"")"
 S DR(1,2260,10)="W !,""  3. DATE OF BIRTH.........: "",OOPS(2260,IEN,6,""E"")"
 S DR(1,2260,15)="W !,""  4. SEX...................: "",OOPS(2260,IEN,7,""E"")"
 S DR(1,2260,20)="12  5. HOME TELEPHONE........"
 ; Patch 8 - add error checking for DOL requirements
 S DR(1,2260,21)="I $TR(X,""/-*#"","""")'?10N W !?3,""Phone number must include area code and 7 digits only.  Example 703-123-8789"" S Y=12"
 S DR(1,2260,25)="W !,""  6. GRADE/STEP............: "",OOPS(2260,IEN,16,""E""),""/"",OOPS(2260,IEN,17,""E"")"
 S DR(1,2260,30)="W !,""  7. EMPLOYEE'S HOME MAILING ADDRESS:"""
 S DR(1,2260,35)="8     STREET ADDRESS........"
 S DR(1,2260,36)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=8"
 S DR(1,2260,40)="9     CITY.................."
 S DR(1,2260,41)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=9"
 S DR(1,2260,45)="10     STATE................."
 S DR(1,2260,50)="11     ZIP CODE.............."
 S DR(1,2260,55)="207  8. DEPENDENTS............"
 S DR(1,2260,60)="W !!,""     Claim Information"""
 S DR(1,2260,65)="W !,""     -----------------"""
 ; Patch 8 - default Occupation from PAID, if there
 S DR(1,2260,70)="208  9. EMPLOYEE'S OCCUPATION.//^S X=ODESC"
 S DR(1,2260,71)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=208"
 S DR(1,2260,75)="W !,"" 10. LOCATION WHERE YOU WORKED WHEN DISEASE OR ILLNESS OCCURRED:"""
 S DR(1,2260,80)="209     LOCATION..............;I X="""" S Y=214;"
 S DR(1,2260,81)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=209"
 S DR(1,2260,85)="210     STREET ADDRESS........"
 S DR(1,2260,86)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=210"
 S DR(1,2260,90)="211     CITY.................."
 S DR(1,2260,91)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=211"
 S DR(1,2260,95)="212     STATE................."
 S DR(1,2260,100)="213     ZIP CODE.............."
 S DR(1,2260,105)="214 11. DATE YOU FIRST BECAME AWARE OF DISEASE OR ILLNESS;I X="""" S Y=215"
 S DR(1,2260,110)="I X'="""",'$$FUT^OOPSUTL4($P(X,""."")) S Y=214"
 S DR(1,2260,115)="215 12. DATE YOU FIRST REALIZED THE DISEASE OR ILLNESS WAS CAUSED BY YOUR               EMPLOYMENT;I X="""" S Y=216"
 S DR(1,2260,120)="I X'="""",'$$FUT^OOPSUTL4($P(X,""."")) S Y=215"
 S DR(1,2260,125)="216 13. EXPLAIN THE RELATIONSHIP TO YOUR EMPLOYMENT, AND WHY YOU CAME TO THIS           REALIZATION~"
 S DR(1,2260,130)="W !"
 S DR(1,2260,131)="S MAX=$$WP^OOPSUTL4(216)"
 S DR(1,2260,132)="I '$P(MAX,U,2) W !,""Invalid character entered, (~,`, @,#,$,%,^,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=216"
 S DR(1,2260,133)="I +MAX>MAX1 W !!,""Max length for field is "",MAX1,"" characters, you have entered "",+MAX,"".  Please Edit."",! S Y=216"
 ; Patch 8 - Cause of injury required for electronic submission
 S DR(1,2260,134)="126     CAUSE OF INJURY CODE......."
 S DR(1,2260,135)="217 14. NATURE OF DISEASE OR ILLNESS~"
 S DR(1,2260,140)="W !"
 S DR(1,2260,141)="S MAX=$$WP^OOPSUTL4(217)"
 S DR(1,2260,142)="I '$P(MAX,U,2) W !,""Invalid character entered, (~,`, @,#,$,%,^,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=217"
 S DR(1,2260,143)="I +MAX>264 W !!,""Max length for field is 264 characters, you have entered "",+MAX,"".  Please Edit."",! S Y=217"
 S DR(1,2260,145)="218 15. IF THIS NOTICE AND CLAIM WAS NOT FILED WITH THE EMPLOYING AGENCY WITHIN         30 DAYS AFTER DATE SHOWN ABOVE IN ITEM #12, EXPLAIN THE REASON FOR THE          DELAY~"
 S DR(1,2260,150)="W !"
 S DR(1,2260,151)="S MAX=$$WP^OOPSUTL4(218)"
 S DR(1,2260,152)="I '$P(MAX,U,2) W !,""Invalid character entered, (~,`, @,#,$,%,^,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=218"
 S DR(1,2260,153)="I +MAX>MAX1 W !!,""Max length for field is "",MAX1,"" characters, you have entered "",+MAX,"".  Please Edit."",! S Y=218"
 S DR(1,2260,155)="219 16. IF A SEPARATE NARRATIVE STATEMENT IS NOT SUBMITTED WITH THIS FORM, EXPLAIN      REASON FOR DELAY~"
 S DR(1,2260,160)="W !"
 S DR(1,2260,165)="S MAX=$$WP^OOPSUTL4(219)"
 S DR(1,2260,166)="I '$P(MAX,U,2) W !,""Invalid character entered, (~,`, @,#,$,%,^,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=219"
 S DR(1,2260,170)="I +MAX>MAX1 W !!,""Max length for field is "",MAX1,"" characters, you have entered "",+MAX,"".  Please Edit."",! S Y=219"
 S DR(1,2260,175)="220 17. IF MEDICAL REPORTS ARE NOT SUBMITTED WITH THIS FORM, EXPLAIN REASON FOR         DELAY~"
 S DR(1,2260,180)="S MAX=$$WP^OOPSUTL4(220)"
 S DR(1,2260,181)="I '$P(MAX,U,2) W !,""Invalid character entered, (~,`, @,#,$,%,^,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=220"
 S DR(1,2260,185)="I +MAX>MAX1 W !!,""Max length for field is "",MAX1,"" characters, you have entered "",+MAX,"".  Please Edit."",! S Y=220"
 Q
