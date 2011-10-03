MCARUTL1 ;HOIFO/WAA-Utility Routine ;11/07/00  11:16
 ;;2.3;Medicine;**29**;09/13/1996
 ; 
 ;    EN() This Entry point will SET/KILL the AV,AF,AS X-references
 ;         for PULMONARY FUNCTION TESTS File (#700).
 ;         FUNT = "SET","KILL" tells what X-ref action to execute
 ;         IEN  = Internal Entry Number of File 700 entry
 ;         PAT  = The internal Entry Number of the patient
 ;         DATE = The Date of the procedure
 ;         XREF = The Cross-Reference to be set.
 ;                "ALL" all 3 cross references for the entry
 ;                "AV" Volume Studies (Field 17, multiple field)
 ;                "AF" Flow Studies   (Field 18, multiple field)
 ;                "AS" Special Study  (Field 32, multiple field)
 ;
EN(FUNT,IEN,PAT,DATE,XREF) ; Main entry point to set or kill X-refs
 Q:FUNT=""  ; Required to tell the program what function to do set/kill
 Q:IEN=""  ; Required to tell the program what entry in 700 to X-ref 
 Q:PAT=""  ; Required to tell the program what patient
 Q:DATE=""  ; Required to tell the program the date of the Procedure
 Q:XREF=""  ; Required to tell the program what X-ref
 I FUNT'="SET",FUNT'="KILL" Q  ; Quit if the FUNT is not a set/kill
 I '($D(^MCAR(700,IEN,0))#10) Q  ; Quit if there is no entry in 700
 I XREF'="ALL" D PRO Q  ; tell the program that it is only one X-ref
 I XREF="ALL" F XREF="AV","AF","AS" D PRO ; Tell the program all
 Q
PRO ; Process the data for the given cross-reference
 N REFN ; this variable will contain the sub node of the entry 
 S REFN=$S(XREF="AV":3,XREF="AF":4,XREF="AS":"S",1:0)
 Q:REFN=0
 Q:'$D(^MCAR(700,IEN,REFN))  ; Quit if there is no data for the entry
 N ENT
 S ENT=0
 Q:($D(^MCAR(700,IEN,REFN,1))'=10)  ; no zero node or children
 F  S ENT=$O(^MCAR(700,IEN,REFN,ENT)) Q:ENT<1  D  ; loop and get each entry
 .Q:'($D(^MCAR(700,IEN,REFN,ENT,0))#10)  ; Quit if no entry
 .N TYPE
 .S TYPE=$P($G(^MCAR(700,IEN,REFN,ENT,0)),U) Q:TYPE=""
 .D ACTION ; Fire off the cross reference
 .Q
 Q
ACTION ;Set the data for the stated cross reference
 N MCDD ; Protect DIC varables
 I FUNT="SET" S ^MCAR(700,XREF,PAT,TYPE,(9999999.9999-DATE),IEN,ENT)="" Q
 I FUNT="KILL" K ^MCAR(700,XREF,PAT,TYPE,(9999999.9999-DATE),IEN,ENT)
 Q
