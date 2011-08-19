PSSMEDX ;BIR/TS-CROSS REFERENCE LOGIC FOR STANDARD MEDICATION ROUTE POINTER IN 51.2 ;04/04/08
 ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/07;Build 67
 ;
SET ;This routine is called by the AC cross-reference on Field #10 of the Medication Routes (#51.2) File
 I $G(X1(1))=$G(X2(1)) Q
 N PSSHASH
 ;DA represents the current record called by the cross-reference
 S PSSHASH("DA")=DA
 D READ
 Q
 ;
READ ;Set values
 N PSSHASHX,%,%H,%I,X
 D NOW^%DTC S PSSHASHX(51.27,"+1,"_PSSHASH("DA")_",",.01)=%
 S PSSHASHX(51.27,"+1,"_PSSHASH("DA")_",",1)=$G(DUZ)
 S PSSHASHX(51.27,"+1,"_PSSHASH("DA")_",",2)=$G(X1(1))
 S PSSHASHX(51.27,"+1,"_PSSHASH("DA")_",",3)=$G(X2(1))
 D UPDATE^DIE("","PSSHASHX")
 Q
