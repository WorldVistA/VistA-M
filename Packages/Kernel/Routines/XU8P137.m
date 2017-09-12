XU8P137 ;SF/CIOFO-JDS  Post Init for XU*8*137 ;02/18/2000  10:18
 ;KIDS POST-INIT
 ;
 ;   This Post-Init routine cleans-up problem in the Patch
 ;   Application History sub-file of the Package File and the 
 ;   State File.
 ;
EN D PATCH
 D STATE
 D MMXREF
 Q
 ;
PATCH ;
 ;   Search Patch Application History in the PACKAGE file
 ;   for entries that contain version number_"*"_patch number_
 ;   sequence number.  The PAH field should only have
 ;   patch number_sequence number for released patches.
 ;   If a "*" is found it will be removed leaving patch and sequence 
 ;   numbers.
 ;
 N X,Y,Z,PAHCOMM,PAHXX
 W !,"Searching PACKAGE file to correct Patch Application History .."
 F X=0:0 S X=$O(^DIC(9.4,X)) Q:X'>0  D
 . W "."
 . F Y=0:0 S Y=$O(^DIC(9.4,X,22,Y)) Q:Y'>0  D
 . . W "."
 . . F Z=0:0 S Z=$O(^DIC(9.4,X,22,Y,"PAH",Z)) Q:Z'>0  D
 . . . S PAHCOMM=$P(^DIC(9.4,X,22,Y,"PAH",Z,0),"^",1)
 . . . I PAHCOMM'["*" Q
 . . . S PAHCOMM=$P(PAHCOMM,"*",2)
 . . . K PAHXX
 . . . S PAHXX(9.4901,Z_","_Y_","_X_",",.01)=PAHCOMM
 . . . D FILE^DIE("","PAHXX")
 . . . K PAHXX
 . . . W "."
 . . . Q
 ;
 W !!,"Finished!"
 Q
STATE ;
 ; This routine will remove the following corrupt DD nodes
 ; and Xref that reference Field #3 (COUNTY) of File #5 (STATE):
 ;
 ; 1.  ^DD(5,"IX",3)
 ; 2.  ^DD(5,0,"IX","D",5,3)
 ; 3.  ^DD(5,3,1)
 ; 4.  ^DIC(5,"D")
 ;
 N ZZS0
 S ZZS0=0
 W !!,"Processing State File ..."
P1 ;
 I $D(^DD(5,"IX",3))#2 D
 . S ZZS0=1
 . S X="Removing node: ^DD(5,""IX"",3)" D MES^XPDUTL(X)
 . K ^DD(5,"IX",3) ;Uncomment when thru testing logic
 ;
P2 ;
 I $D(^DD(5,0,"IX","D",5,3))#2 D
 . S ZZS0=1
 . S X="Removing node: ^DD(5,0,""IX"",""D"",5,3)" D MES^XPDUTL(X)
 . K ^DD(5,0,"IX","D",5,3) ;Uncomment when thru testing logic
 ;
P3 ;
 I $D(^DD(5,3,1,0))#2 D
 . S ZZS0=1
 . S X="Removing all Cross References on Field #3 (COUNTY)" D MES^XPDUTL(X)
 . K ^DD(5,3,1) ;Uncomment when thru testing logic
 ;
P4 ;
 I $D(^DIC(5,"D")) D
 . S ZZS0=1
 . S X="Removing the only reported ""Bad Cross Reference"" - ""D""" D MES^XPDUTL(X)
 . K ^DIC(5,"D") ;Uncomment when thru testing logic
 I 'ZZS0 S X="Everything is fine with Field #3 (COUNTY) of file #5 (STATE)." D MES^XPDUTL(X)
 K ZZS0
 Q
 ;
MMXREF ;
 N DIK
 S DIK="^VA(200,",DIK(1)="29^E"
 D ENALL^DIK
 Q
