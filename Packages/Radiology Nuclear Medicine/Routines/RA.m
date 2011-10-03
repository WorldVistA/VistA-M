RA ;HCIOFO/SG - RADIOLOGY/NUCLEAR MEDICINE (README) ; 1/22/08 11:30am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 ; LOCAL VARIABLE ------ DESCRIPTION
 ;
 ; RAERROR               Error handling data
 ; RAPARAMS              Package-wide API parameters
 ;
 ; See the source code of the ^RA01 routine for more details.
 ;
 ; NAMESPACE ----------- DESCRIPTION
 ;
 ; RAERR*                Error handling
 ; RAKIDS*               Installation utilities (KIDS)
 ; RALOCK*               Lock/unlock utilities
 ; RAMAG*                Radiology Exam Request/Register API
 ;                       (see ^RAMAG for details)
 ; RAORD*                Exam request
 ; RAREG*                Exam registration
 ; RARP*                 Remote procedures
 ; RAUTL*                Utilities
 ;
 ; DIALOG -------------- DESCRIPTION
 ;
 ; 700000.*              Error messages (see ^RAERR for details)
 ; 700005.*              Generic messages
 ;
 ; MAJOR MENU ---------- DESCRIPTION
 ;
 ; [RA OVERALL]          Rad/Nuc Med Total System Menu
 ;
 ; INITIALS ------------ DEVELOPER
 ;
 ; GJC                   Gregory J. Cebelinski
 ; KAM                   Ken McNeile
 ; PB or PAV             Pavel Brodniansky
 ; RJT                   Robert Troha
 ; SG                    Sergey Gavrilov
 ; SM                    Selina Mo
 ;
 ; NOTATION ------------ DESCRIPTION
 ;
 ; .X                    Parameter X should be passed by reference
 ;
 ; [X]                   Parameter X is optional
 ;
 ; [.X]                  Optional parameter X should be passed by
 ;                       reference
 ;
 ; [.]X                  Parameter X can be either a single value or
 ;                       a list. In the latter case, it should be
 ;                       passed by reference.
 ;
 ; [[.]X]                Optional parameter X can be either a single
 ;                       value or a list.
 ;
 ; ^01:                  First "^"-piece of the value
 ; ^02:                  Second "^"-piece
 ; ^nn:                  Subsequent "^"-pieces
 ;
 Q
