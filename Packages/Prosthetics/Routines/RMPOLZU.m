RMPOLZU ;EDS/PAK - HO LETTERS - Update Post Letter Transaction file ;7/24/98
 ;;3.0;PROSTHETICS;**29**;Feb 09, 1996
 ;
FILE(DFN,LET,L) ;Update file 665.4 with Patient Letter
 ;
 ;This is a function that sets up an entry in file 665.4.
 ;If it succeeds, it returns ONE.
 ;If it fails, it returns an error_number;error_type.
 ;
 ; I/P : DFN = Pointer to the Patient file (# 2)
 ;       L  = Prosthetics Letter IEN
 ;       LET = Name of word processing style text array to use in MOVE command
 ;
 ;Create Entry
 N DA,DD,DIC,DIK,DINUM,DLAYGO,DO,IEN,X,Y,DIE,DR,DTOUT
 S DIC="^RMPR(665.4,",DIC(0)="L",X=DFN,DLAYGO=665.4
 D FILE^DICN
 ;
 S DA=+Y
 I DA<1 Q "1;Could not create a transaction entry for Patient #"_DFN_"."
 L +^RMPR(665.4,DA):0
 ;
 ;Update fields .01, 2, 4 & 6
 S DA=+Y,DR=".01////"_DFN_";1////"_L_";2////"_DT_";4////"_DUZ_";6////"_RMPO("STA")
 S DIE=665.4 D ^DIE
 I $D(DTOUT) Q "1;Could not complete a transaction entry for Patient #"_DFN_"."
 ;
 ;Move in Word Processing Text
 D WP^DIE(665.4,DA_",",3,"KZ",LET)
 I $D(^TMP("DIERR",$J)) Q "1;Could not complete a transaction entry for Patient #"_DFN_"."
 ;
 L -^RMPR(665.4,DA)
 Q 0
