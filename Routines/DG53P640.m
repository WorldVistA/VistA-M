DG53P640 ;BAY/JAT; UPDATE FILE #45.64;12/7/04 4:29pm ; 12/20/04 7:58pm
 ;;5.3;Registration;**640**;Aug 13,1993
 N LINE,X,DGCODE,DIC,DGDESC,Y,DGX,DGY,DGCNT
 S DGCNT=0
 D BMES^XPDUTL(">>> Adding new codes to file # 45.64")
 F LINE=1:1 S X=$T(ADD+LINE) S DGCODE=$P(X,";;",2) Q:DGCODE="EXIT"  D
 .S DIC="^DGP(45.64,",DIC(0)=""
 .S DGDESC=$P(DGCODE,U,2)
 .I $L(DGDESC)>70 Q
 .S DIC("DR")=".02///"_DGDESC
 .S X=$P(DGCODE,U)
 .I +$O(^DGP(45.64,"B",X,0)) Q
 .K DO D FILE^DICN
 .I Y=-1 Q
 .S DGX=$P(DGCODE,U),DGY=$P(DGCODE,U,2)
 .D MES^XPDUTL("  CODE "_DGX_"     "_DGY_"     added.")
 .S DGCNT=DGCNT+1
 I DGCNT<39 D
 .D MES^XPDUTL("Code(s) missing. Compare with patch description.")
 Q
ADD ;new codes - descriptions cannot exceed 70 char.
 ;;004^station number and suffix invalid
 ;;070^transaction does not match N101 transaction or Master Record
 ;;139^101 transaction equal to preceding 101 transaction or Master Record   
 ;;141^replacement date of admission is later than first date of surgery
 ;;142^replacement date of admission is later than first movement date
 ;;170^transaction does not match 101 trans. or Master Record (131 trans only
 ;;171^update without data in any field except control fields (131 trans only
 ;;441^surgical date in N402 transaction not equal date of one 401
 ;;455^a replacement code or a $ eliminated a required related code
 ;;457^duplicate surg codes or dupe of one in Master in different position
 ;;471^updte without data in any field except control fields (one field reqrd
 ;;472^updte 431/432 date of surgery does not match date of surgery in 401/02
 ;;546^trans. 500 deleted the discharge 501 segment without replacement 501 
 ;;553^diagnostic code used without a required related code
 ;;555^a replacement code or a $ eliminated a required related code
 ;;557^duplicate diag codes or dupe of one in Master in different position
 ;;570^transaction does not match 101 transaction or Master Record
 ;;571^updte without data in any field except control fields (one field reqrd
 ;;572^update date of movement does not match date of movement in record
 ;;573^combined leave and pass days greater than total elapsed days
 ;;645^more than 32 transactions submitted
 ;;655^a replacement code or a $ eliminated a required related code
 ;;670^transaction does not match N101 transaction or Master Record
 ;;716^duplication of a report of death. Type of disposition '6' or '7'
 ;;718^701 without an "X" in ONLY-DX must be accompanied by a 702
 ;;719^trans. accompanied by 701 with "X" in ONLY-DX or "summary diag" codes
 ;;739^discharge segment already in Master Record
 ;;740^date of discharge is later than processing date
 ;;741^date of discharge does not equal last date of transfer
 ;;742^date of discharge for fiscal year before earlier than current FY
 ;;743^replacement date of discharge is earlier than latest date of surgery
 ;;770^no matching 101 transaction or Master Record
 ;;771^updte without data in any field except control fields (one field reqrd
 ;;772^update with matching 101 transaction but without a matching 701/2/3
 ;;775^invalid PHY LOC CDR code
 ;;776^invalid PHY CDE code
 ;;999^six unacceptable edit conditions
 ;;EXIT
 Q
