RAUTL6 ;HISC/GJC-Utility Routine ;2/19/98  10:52
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
VARACC(DUZ) ; This subroutine will determine the Imaging Location,
 ; Imaging Type, and the Divisional access for a specific individual. 
 ; Divisional Access as well as Imaging Type Access is derived from
 ; the Imaging Locs assigned to each Rad/Nuc Med user.  If the user
 ; holds the RA ALLOC key, that user has access to all Imaging Locs.
 ; This in turn implies that the user has all Divisional and Imaging
 ; Type access related to each specific Imaging Location.
 ;
 Q:'+$G(DUZ)  N RADIV,RAIMG,RAINDX,RAKEY,RALOC,RAMGRKEY
 S RAMGRKEY=0
 ;
 ;                 *** RA ALLOC Key Holder ***
 ; If a RA ALLOC holder, set up Imaging Loc access from file 200.
 ; Format: RACCESS(DUZ,"LOC",IEN of 79.1)=.01 of 79.1, IEN of file 44^.01 of 44
 ;
 I $D(^XUSEC("RA ALLOC",DUZ)) S RAMGRKEY=1 D
 . S RAINDX=0
 . F  S RAINDX=$O(^RA(79.1,RAINDX)) Q:RAINDX'>0  D
 .. S RALOC(0)=$G(^RA(79.1,RAINDX,0)),RALOC(1)=+$P(RALOC(0),U)
 .. Q:RALOC(1)'>0  S RALOC(44)=$P($G(^SC(RALOC(1),0)),U)
 .. S RACCESS(DUZ,"LOC",RAINDX)=RALOC(1)_"^"_RALOC(44)
 .. Q
 . K RALOC
 . Q
 ;
 ;        *** Imaging Location Access ***
 ; If not a RA ALLOC holder, set up Imaging Loc access from file 200.
 ; Format: RACCESS(DUZ,"LOC",IEN of 79.1)=.01 of 79.1, IEN of file 44^.01 of 44
 ;
 I 'RAMGRKEY,($D(^VA(200,DUZ,"RAL",0))),(+$O(^VA(200,DUZ,"RAL",0))) D
 . S RAINDX=0
 . F  S RAINDX=$O(^VA(200,DUZ,"RAL",RAINDX)) Q:RAINDX'>0  D
 .. S RALOC(0)=$G(^VA(200,DUZ,"RAL",RAINDX,0)),RALOC(1)=+$P(RALOC(0),U)
 .. Q:RALOC(1)'>0  S RALOC(44)=+$P($G(^RA(79.1,RALOC(1),0)),U)
 .. S RACCESS(DUZ,"LOC",RALOC(1))=RALOC(44)_"^"_$P($G(^SC(RALOC(44),0)),U)
 .. Q
 . Q
 ;
 ;                 *** Division Access ***
 ; Format: RACCESS(DUZ,"DIV",IEN of 79,IEN of 79.1)="DIV";1 of file 79.1, pntr to file 4^.01 of 4
 ; NOTE: The first piece of the "DIV" node is a pntr to 79 (Rad Div)
 ;       This value is DINUMED with file 4.
 ;
 ; Division is found in the Imaging Location file, ^RA(79.1
 ; it is the first piece of the "DIV" node.  RAINDX is the IEN
 ; of ^RA(79.1
 I $D(RACCESS(DUZ,"LOC")) D
 . S RAINDX=0
 . F  S RAINDX=$O(RACCESS(DUZ,"LOC",RAINDX)) Q:RAINDX'>0  D
 .. S RADIV(0)=$G(^RA(79.1,RAINDX,"DIV")),RADIV(1)=+$P(RADIV(0),U)
 .. Q:RADIV(1)'>0  S RADIV(2)=+$P($G(^RA(79,RADIV(1),0)),U)
 .. S RACCESS(DUZ,"DIV",RADIV(1),RAINDX)=RADIV(2)_"^"_$P($G(^DIC(4,RADIV(2),0)),U)
 .. Q
 . Q
 ;
 ;                 *** Imaging Type Access ***
 ; Format: RACCESS(DUZ,"IMG",IEN of 79.2,IEN of 79.1)=^.01 of 79.2
 ; NOTE: The sixth piece of the "zero" node is a pntr to 79.2 (Img Type)
 ;
 ; Imaging Type is found in the Imaging Location file (#79.1)
 ; it is the sixth piece of the "zero" node.  RAINDX is the IEN
 ; of ^RA(79.1
 I $D(RACCESS(DUZ,"LOC")) D
 . S RAINDX=0
 . F  S RAINDX=$O(RACCESS(DUZ,"LOC",RAINDX)) Q:RAINDX'>0  D
 .. S RAIMG(0)=$G(^RA(79.1,RAINDX,0)),RAIMG(1)=+$P(RAIMG(0),U,6)
 .. Q:RAIMG(1)'>0  S RAIMG(2)=$P($G(^RA(79.2,RAIMG(1),0)),U)
 .. S RACCESS(DUZ,"IMG",RAIMG(1),RAINDX)="^"_RAIMG(2)
 .. Q
 . Q
 Q
DSPDIV ; Display 'Divisional Access' data
 N X0,X1,Y0,Y1,Y2,Y3 S X0=0,Y3=1
 I '$D(RACCESS(RADUZ,"DIV")) D  Q
 . W !?5,"Access to Radiology/Nuclear Medicine Divisional data is not "
 . W "authorized.",$C(7)
 S Y1="<<< Divisions Included >>>"
 W !?5,Y1
 F  S X0=$O(RACCESS(RADUZ,"DIV",X0)) Q:X0'>0  D
 . S X1=$O(RACCESS(RADUZ,"DIV",X0,0)) Q:X1'>0
 . S Y0=$G(RACCESS(RADUZ,"DIV",X0,X1)) Q:Y0']""
 . S Y2=$P(Y0,U,2) D PRINT
 . Q
 W !
 Q
DSPIMG ; Display 'Imaging Type' data
 N X0,X1,Y0,Y1,Y2,Y3 S X0=0,Y3=1
 I '$D(RACCESS(RADUZ,"IMG")) D  Q
 . W !?5,"Access to Imaging Type data is not authorized."
 . W $C(7)
 S Y1="<<< Imaging Types Included >>>"
 W !?5,Y1
 F  S X0=$O(RACCESS(RADUZ,"IMG",X0)) Q:X0'>0  D
 . S X1=0
 . F  S X1=$O(RACCESS(RADUZ,"IMG",X0,X1)) Q:X1'>0  D
 .. S Y0=$G(RACCESS(RADUZ,"IMG",X0,X1)) Q:Y0']""
 .. S Y2=$P(Y0,U,2) D PRINT
 .. Q
 . Q
 W !
 Q
DSPLOC ; Display 'Imaging Location' data
 N X0,Y0,Y1,Y2,Y3 S X0=0,Y3=1
 I '$D(RACCESS(RADUZ,"LOC")) D  Q
 . W !?5,"Access to Imaging Location data is not authorized.",$C(7)
 S Y1="<<< Locations Included >>>"
 W !?5,Y1
 F  S X0=$O(RACCESS(RADUZ,"LOC",X0)) Q:X0'>0  D
 . S Y0=$G(RACCESS(RADUZ,"LOC",X0)) Q:Y0']""
 . S Y2=$P(Y0,U,2) D PRINT
 . Q
 W !
 Q
PRINT ; Print out data
 S Y3='Y3
 I 'Y3 W !?5,Y2
 E  W ?45,Y2
 Q
DIVSION(RADATE,RALIFN) ; Determine the division associated with the Requesting
 ; Location on a Rad/Nuc Med Order.  Use the PIMS utilities in VASITE.
 ; Returns an institution file ptr value or -1 if the division
 ; could not be determined.
 ; Input  - RADATE=a valid FileMan date (internal format)
 ;                 defaults to DT if passed in null
 ;          RALIFN=Req. Location from Rad/Nuc Med Order.
 ; Output - RA1DIV=valid pointer the the Institution File, else -1
 N RA1DIV S:$G(RADATE)="" RADATE=DT
 ; note: field 3.5 in file 44 is named DIVISION & is a pntr to file 40.8
 S RA1DIV=+$$SITE^VASITE(RADATE,+$$GET1^DIQ(44,RALIFN,3.5,"I"))
 ; if $$SITE^VASITE fails, return the medical center division of the
 ; primary medical center division (this is a ptr to file 40.8)
 S:RA1DIV=-1 RA1DIV=+$$SITE^VASITE(RADATE,+$$PRIM^VASITE(RADATE))
 Q RA1DIV
