VAFCUTL1 ;ISA/RJS,Zoltan - UTILITY ROUTINE FOR CIRN ;APR 6, 1999
 ;;5.3;Registration;**149**;Aug 13, 1993
SEND() ;
 Q 1
SEND2(DFN,PARAMS) ;
 ;This function screens out certain patients
 ;the screen can be selected by using the parameter list
 ;if the parameter list contains:
 ;"D", the function will return a 1 if the patient is a Dead patient
 ;"T", the function will return a 1 if the patient is a Test patient
 ;"E", the ...................... 1 ................. an Employee
 ;"V", the ...................... 1 ................. a Non-Veteran
 ;"P", the ...................... 1 ................. Psuedo
 ;otherwise the function returns  0
 ;
 S PARAMS=$G(PARAMS)
 N NAME,SSN,DEATH,PATYPE,STRING,RETURN
 N DIC,VAFCUTLP,DIQ,DA
 S RETURN=0
 S DIC=2,DR=".01;.09;.351;391",DA=DFN,DIQ="VAFCUTLP",DIQ(0)="E,I"
 D EN^DIQ1
 S STRING=""
 S NAME=$G(VAFCUTLP(2,DFN,.01,"E"))
 S SSN=$G(VAFCUTLP(2,DFN,.09,"E"))
 S DEATH=$G(VAFCUTLP(2,DFN,.351,"E"))
 S PATYPE=$G(VAFCUTLP(2,DFN,391,"I"))
 I PARAMS["D"&(DEATH'="") S STRING="D" ;Dead Pt.
 I PARAMS["T" D
 . ;Test patients
 . I ($E(SSN,1,5)="00000") S STRING=STRING_"T" Q
 . I ($E(NAME,1,2)="ZZ") S STRING=STRING_"T"
 I PARAMS["E"&($E(NAME,1,3)="EEE") S STRING=STRING_"E" ;Employee
 I PARAMS["V"&('$$VETERAN($G(PATYPE))) S STRING=STRING_"V" ;Not Veteran
 I PARAMS["P"&(SSN["P") S STRING=STRING_"P"
 I STRING'="" S RETURN="1^"_STRING
 Q RETURN
VETERAN(PATYPE) ;
 I PATYPE="" Q 0
 N DIC,DR,DA,DIQ,VETERAN,VAFCUTLV
 S DIC=391,DR=".05",DA=PATYPE,DIQ="VAFCUTLV",DIQ(0)="E"
 D EN^DIQ1
 S VETERAN=$G(VAFCUTLV(391,DA,.05,"E"))
 I VETERAN=""!(VETERAN="NO") Q 0
 Q 1
