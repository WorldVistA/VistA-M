DG53P574 ; BAY/JAT- Patch DG*5.3*574 Install Utility Routine ; 12/9/03 3:13pm
 ;;5.3;Registration;**574**;AUG 13, 1993
 ;
 ;
 ;
POST ;Main entry point for Post-install items.
 ;
 D POST1
 Q
POST1 ; Refine Kill logic on "BS" crossreference on Patient file
 ; NOIS CALL PUG-0999-50739
 D MES^XPDUTL("Refining the Kill logic of 'BS' crossreference")
 S ^DD(2,.09,1,1,2)="K:$E(X,6,9)'="""" ^DPT(""BS"",$E(X,6,9),DA)"
 Q
