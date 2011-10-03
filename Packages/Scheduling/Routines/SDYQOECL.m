SDYQOECL ;ALB/MLI - Routine to put entries in file 409.41 ; 10/6/95 [10/6/95 2:28pm]
 ;;5.3;Scheduling;**35**,Aug 13, 1993
 ;
 ; This routine will set the following entries into the OUTPATIENT
 ; CLASSIFICATION TYPE file (#409.41) so that classification
 ; questions are no longer asked for stop codes:
 ;
 ;    149 - RADIATION THERAPY TREATMENT
 ;    150 - COMPUTERIZED TOMOGRAPHY (CT)
 ;    151 - MAGNETIC RESONANCE IMAGING/MRI
 ;    152 - ANGIOGRAM CATHETERIZATION
 ;    153 - INTERVENTIONAL RADIOGRAPHY
 ;
EN ; entry point to add stop codes to file 409.41
 N DA,DIC,DLAYGO,SDYQERR,SDYQSTOP,X,Y
 S SDYQERR=0
 W !,">>>Adding entries to the OUTPATIENT CLASSIFICATION STOP CODE EXCEPTION",!?4,"file (#409.45)..."
 F SDYQSTOP=149:1:153 D
 . W !?4,"Stop code ",SDYQSTOP
 . S DA=$O(^SD(409.45,"B",SDYQSTOP,0))
 . I 'DA D  Q:SDYQERR
 . . K DD,DO
 . . S X=SDYQSTOP,DIC="^SD(409.45,",DIC(0)="L",DLAYGO=409.45
 . . D FILE^DICN S DA=+Y
 . . I Y<0 S SDYQERR=1 W "...could not be added...try again later."
 . . I Y>0 W "...added to file"
 . I $O(^SD(409.45,DA,"E","B",2951001,0)) W "...already in file." Q
 . S DIC="^SD(409.45,"_DA_",""E"",",DIC("P")=$P(^DD(409.45,75,0),"^",2)
 . S DA(1)=DA,X="2951001",DIC(0)="L",DIC("DR")=".02///1" K DLAYGO
 . K DD,DO
 . D FILE^DICN
 . W "...as of 10/1/95."
 Q
