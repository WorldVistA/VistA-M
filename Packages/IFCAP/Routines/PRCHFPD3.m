PRCHFPD3 ;WASH-CIOFO/SC-FPDS INPUT TRANSFORM FROM FILE 420.6 ;7/24/00  23:06
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This routine is only excutable at an entry point.
 Q
EN1 ;Input Transform of Field #5 in File #420.6
 N I,PRCLNGTH,PRCHBUS,ARR,J,PRCHTYP
 K:$L(X)<1!($L(X)>30) X
 Q:'$D(X)
 S PRCLNGTH=$L(X)
 F I=1:1:PRCLNGTH D
 . S PRCHBUS=$E(X,I)
 . I PRCHBUS=+PRCHBUS,1234[PRCHBUS D 
 . . S ARR(PRCHBUS)=""
 . . Q
 . Q
 ;
 ;Restore the proper values for Business Type and comma as a delimiter
 ;for more than one Applicable Bus. Type for specific Socio. Group
 ;
 S J=""
 S J=$O(ARR(J)) Q:J=""!(J'=+J)
 S X=J
 F  S J=$O(ARR(J)) Q:J=""  D
 . S X=X_","_J
 . Q
 Q
