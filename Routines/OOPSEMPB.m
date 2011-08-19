OOPSEMPB ;WIOFO/LLH-E/E Employee CA1 data ;10/16/00
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
 ; Employee/Person Address is now only stored in the 2162A node
 ; of file 2260.  Prior to patch 3 it was stored in the CA1A and
 ; CA2A nodes depending on which form was entered.  The address
 ; is only 'pulled' from this location when printing either form.
 ;
 W !!," Federal Employee's Notice of Traumatic Injury and"
 W !," Claim for Continuation of Pay/Compensation (Form CA-1)"
 W !!,"     Employee Data"
 W !,"     -------------"
 N VWIT
 K DIQ,DA,DR S DIC="^OOPS(2260,",DR=".01;1;2;4;5;6;7;16;17",DA=IEN,DIQ="OOPS",DIQ(0)="IE"
 D EN^DIQ1
 K DR,DO,DD
 S DR=""
 S DR(1,2260,1)="63////^S X=PAYP"        ; Pay Plan from PAID
 S DR(1,2260,2)="W !,""  1. NAME OF EMPLOYEE......: "",OOPS(2260,IEN,1,""E"")"
 S DR(1,2260,5)="W !,""  2. SOCIAL SECURITY NUMBER: "",OOPS(2260,IEN,5,""E"")"
 S DR(1,2260,10)="W !,""  3. DATE OF BIRTH.........: "",OOPS(2260,IEN,6,""E"")"
 S DR(1,2260,15)="W !,""  4. SEX...................: "",OOPS(2260,IEN,7,""E"")"
 S DR(1,2260,20)="12  5. HOME TELEPHONE........"
 ; Patch 8 - added error checking for DOL requirements
 S DR(1,2260,21)="I $TR(X,""/-*#"","""")'?10N W !?3,""Phone number must include area code and 7 digits only.  Example 703-123-8789"" S Y=12"
 S DR(1,2260,25)="W !,""  6. GRADE/STEP............: "",OOPS(2260,IEN,16,""E""),""/"",OOPS(2260,IEN,17,""E"")"
 S DR(1,2260,30)="W !,""  7. EMPLOYEE'S HOME MAILING ADDRESS:"""
 S DR(1,2260,35)="8     STREET ADDRESS........"
 S DR(1,2260,36)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=8"
 S DR(1,2260,40)="9     CITY.................."
 S DR(1,2260,41)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=9"
 S DR(1,2260,45)="10     STATE................."
 S DR(1,2260,50)="11     ZIP CODE.............."
 S DR(1,2260,55)="107  8. DEPENDENTS............"
 S DR(1,2260,60)="W !!,""     Description of Injury"""
 S DR(1,2260,65)="W !,""     ---------------------"""
 S DR(1,2260,70)="108  9. PLACE WHERE INJURY OCCURRED..."
 S DR(1,2260,71)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=108"
 ;Patch 8 - AAC requirement add flds 183-185
 S DR(1,2260,72)="183     ADDRESS WHERE INJURY OCCURRED."
 S DR(1,2260,73)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=183"
 S DR(1,2260,74)="184     CITY WHERE INJURY OCCURRED...."
 S DR(1,2260,75)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=184"
 S DR(1,2260,76)="185     STATE WHERE INJURY OCCURRED..."
 S DR(1,2260,77)="181     ZIP CODE WHERE INJURY OCCURRED"
 ;Default the Date/Time Injury Occurred from the 2162
 S DR(1,2260,80)="109 10. DATE/TIME INJURY OCCURRED..//^S X=OOPS(2260,IEN,4,""E"")"
 S DR(1,2260,85)="I $P(X,""."",2)="""" W !,""Time is REQUIRED in this response."" S Y=109"
 S DR(1,2260,90)="I X'="""",'$$FUT^OOPSUTL4($P(X,""."")) S Y=109"
 S DR(1,2260,95)="110 11. DATE OF THIS NOTICE........//^S X=DT"
 S DR(1,2260,100)="I X'="""",'$$FUT^OOPSUTL4($P(X,""."")) S Y=110"
 ; Patch 8 - default Occupation from PAID, if there
 S DR(1,2260,105)="111 12. EMPLOYEE'S OCCUPATION......//^S X=ODESC"
 S DR(1,2260,106)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=111"
 S DR(1,2260,110)="112 13. CAUSE OF INJURY (DESCRIBE WHAT HAPPENED AND WHY)"
 S DR(1,2260,111)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=112"
 S DR(1,2260,112)="126     CAUSE OF INJURY CODE......."
 S DR(1,2260,115)="113 14. NATURE OF INJURY (IDENTIFY BOTH THE INJURY AND THE PART OF THE BODY e.g.       FRACTURE OF LEFT LEG)"
 S DR(1,2260,116)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=113"
 S DR(1,2260,120)="W !!,""     Employee Signature"""
 S DR(1,2260,125)="W !,""     ------------------"""
 S DR(1,2260,130)="114 15. REQUEST PAY OR LEAVE......."
 S DR(1,2260,135)="W !!,""     Witness"""
 S DR(1,2260,140)="W !,""     -------"""
 ; Patch 8 - DOL project.  Added collection of multiple witnesses
 ; note: if Witness Statement entry ever allowed, max length = 528
 S DR(2,2260.0125)=".01:5"
 S DR(2,2260.0125,6)="6////SIGNED WITNESS STATEMENT TO FOLLOW."
 S DR(1,2260,145)="125"         ; call to witness multiple
 S DR(1,2260,146)="S VWIT=$$WIT^OOPSUTL3"
 S DR(1,2260,147)="I +VWIT=0!($P(VWIT,U,2)=0) S Y=125"
 Q
