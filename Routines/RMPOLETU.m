RMPOLETU ;EDS/PAK - HO LETTERS - Update Post Letter Transaction file ;7/24/98
 ;;3.0;PROSTHETICS;**29**;Feb 09, 1996
 ;
FILE(DFN,LET,LN,L) ;Update file 665.4 with Patient Letter
 ;
 ;This is a function that sets up an entry in file 665.4.
 ;If it succeeds, it returns ONE.
 ;If it fails, it returns an error_number;error_type.
 ;
 ; I/P : DFN= Pointer to the Patient file (# 2)
 ;       L  = Prosthetics Letter IEN
 ;       LET= Name of word processing style text array to use in MOVE command
 ;       LN = Number of lines printed in LET
 ;
 ;Create Entry
 N DA,DD,DIC,DIK,DINUM,DLAYGO,DO,IEN,X
 S DIC="^RMPR(665.4,",DIC(0)="L",X=DFN,DLAYGO=665.4
 D FILE^DICN
 ;
 I +Y<1 Q "1;Could not create an entry for Patient #"_DFN_"."
 ;
 ;Put fields on zero node
 ;
 S IEN=+Y,X=DFN_U_L_U_DT_U_DUZ_"^^"_RMPO("STA")
 S ^RMPR(665.4,IEN,0)=X
 ;
 ;Move in Word Processing Text
 ;
 M ^RMPR(665.4,IEN,1)=@LET
 S ^RMPR(665.4,IEN,1,0)="^^"_LN_U_LN_DT
 ;
 ;Reindex entry
 ;
 S DIK=DIC,DA=IEN D IX1^DIK
 ;
 Q 1
