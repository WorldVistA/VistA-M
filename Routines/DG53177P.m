DG53177P ;ALB/SEK - VALIDATE ELIGIBILITY CODE FILES ROUTINE; 20 JULY 1998
 ;;5.3;Registration;**177**;Aug 13, 1993
 ;
 ; This routine will validate entries in the MAS ELIGIBILITY CODE
 ; file (#8.1) and the ELIGIBILITY CODE file (#8).
 ;
 ; The MAS ELIGIBILITY CODE file will be checked to see that there
 ; are 21 entries with the correct internal entry number (IEN),
 ; name, and inactive flag.
 ; Discrepancies will be printed.
 ;
 ; If discrepancies are found in the MAS ELIGIBILITY CODE file, the
 ; ELIGIBILITY CODE file is not checked and the user is asked to
 ; correct the discrepancies and rerun this routine (D ^DG53177P).
 ;
 ; The following checks will be done on the ELIGIBILITY CODE file:
 ; . Each entry (MAS ELIGIBILITY CODE field) points to an entry in
 ;   the MAS ELIGIBILITY CODE file.  Discrepancies will be printed.
 ; . Inactive entry points to an active entry in the MAS ELIGIBILITY.
 ;   All occurrences will be printed with a message stating this may
 ;   be correct, just listing for further review.
 ; . Active entry points to an inactive entry in the MAS ELIGIBILITY.
 ;   Occurrences will be printed.
 ;
 ;
 ; Checking the MAS ELIGIBILITY CODE file (#8.1)
EN ; 
 D BMES^XPDUTL(">>> Checking the internal entry number(IEN), name, and activity")
 D MES^XPDUTL("    of the 21 entries in the MAS ELIGIBILITY CODE file (#8.1).")
 N DG1,DG2,DGACT,DGIEN,DGN,DGNAME,DGS,DGSACT,DGX,DGX1
 K DGERR
 S DGN=0
 F DG1=1:1 S DGX=$P($T(DATA+DG1),";;",2) G:DGX="QUIT" PRINT D
 .S DGIEN=$P(DGX,"^"),DGNAME=$P(DGX,"^",2),DGACT=$P(DGX,"^",3)
 .S DGS=$G(^DIC(8.1,DGIEN,0)) I DGS']"" S DGN=DGN+1,DGERR(DGN)=DGX_";" Q
 .I DGNAME'=$P(DGS,"^")!(DGACT'=$P(DGS,"^",7)) D  Q
 ..S DGN=DGN+1,DGERR(DGN)=DGX_";A"
 ..Q
 .Q
 ;
PRINT ; Print MAS ELIGIBILITY CODE file discrepancies
 G:'DGN NODEZ
 D BMES^XPDUTL("   The following discrepancies were found:")
 F DG2=1:1:DGN D
 .S DGX=$P($G(DGERR(DG2)),";")
 .S DGIEN=$P(DGX,"^"),DGNAME=$P(DGX,"^",2),DGACT=$P(DGX,"^",3)
 .S DGX1=$P($G(DGERR(DG2)),";",2) I DGX1="" D  Q
 ..D MES^XPDUTL("Missing IEN of "_DGIEN_" - "_DGNAME_" and "_$S(DGACT:"inactive",1:"active"))
 ..Q
 .D MES^XPDUTL("IEN of "_DGIEN_" should be "_DGNAME_" and "_$S(DGACT:"inactive",1:"active"))
 .Q
 ;
NODEZ ; check ^DIC(8.1,0 for 21 entries
 I $P($G(^DIC(8.1,0)),"^",4)>21 D  G CORR
 .D BMES^XPDUTL("   The number of entries in the MAS ELIGIBILITY CODE file is greater than 21")
 ;
 I 'DGN D BMES^XPDUTL("   MAS ELIGIBILITY CODE file (#8.1) is correct.") G CHECK
 ;
CORR D BMES^XPDUTL(">>> Please correct the discrepancies in the MAS ELIGIBILITY CODE file")
 D MES^XPDUTL("    and rerun DG53177P (D ^DG53177P)")
 G QUIT
 ;
CHECK ; Checking the ELIGIBILITY CODE file (#8)
 ;
 D BMES^XPDUTL(">>> Checking the entries in the ELIGIBILITY CODE file (#8).")
 N DG1,DG2,DGP,DGACT,DGN,DGSACT
 ;
 ; Each entry (MAS ELIGIBILITY CODE field) must point to an entry in
 ; the MAS ELIGIBILITY CODE file.
 ;
 S DGN=0,DG1=0
 F  S DG1=$O(^DIC(8,DG1)) G:'DG1 PRINT1 D
 .S DG2=$G(^DIC(8,DG1,0)) Q:DG2=""
 .S DGP=$P(DG2,"^",9)
 .I DGP<1!(DGP>21) S DGN=DGN+1,DGERR(1,DGN)=DG1_"^"_$P(DG2,"^") Q
 .S DGACT=$P($P($T(DATA+DGP),";;",2),"^",3)
 .S DGSACT=$P(DG2,"^",7)
 .I DGSACT=1&(DGACT'=1) S DGN=DGN+1,DGERR(2,DGN)=DG1_"^"_$P(DG2,"^") Q
 .I DGSACT'=1&(DGACT=1) S DGN=DGN+1,DGERR(3,DGN)=DG1_"^"_$P(DG2,"^") Q
 .Q
 ;
PRINT1 ; Print ELIGIBILITY CODE file discrepancies
 I 'DGN D  G QUIT
 . D BMES^XPDUTL("   ELIGIBILITY CODE file (#8) is correct.")
 . D BMES^XPDUTL("   Validation has completed with no discrepancies found")
 .Q
 ;
 N DG1,DG2
 S DG1=0
 F  S DG1=$O(DGERR(DG1)) Q:'DG1  D
 .D @$S(DG1=1:"ERR1",DG1=2:"ERR2",1:"ERR3")
 .S DG2=0
 .F  S DG2=$O(DGERR(DG1,DG2)) Q:'DG2  D
 ..D MES^XPDUTL("    IEN= "_$P(DGERR(DG1,DG2),"^")_"  NAME= "_$P(DGERR(DG1,DG2),"^",2))
 ..Q
 G QUIT1
 ;
ERR1 D BMES^XPDUTL("   The following entries do not point to an entry in the")
 D MES^XPDUTL("      MAS ELIGIBILITY CODE file:")
 Q
 ;
ERR2 D BMES^XPDUTL("   The following inactive entries point to an active")
 D MES^XPDUTL("      entry in the MAS ELIGIBILITY CODE file:")
 D MES^XPDUTL("   These may be correct, just listing for further review.")
 Q
 ;
ERR3 D BMES^XPDUTL("   The following active entries point to an inactive")
 D MES^XPDUTL("      entry in the MAS ELIGIBILITY CODE file:")
 Q
 ;
QUIT1 D BMES^XPDUTL(">>> Please correct the discrepancies in the ELIGIBILITY CODE file")
 D MES^XPDUTL("    and rerun DG53177P (D ^DG53177P)")
 ;
QUIT K DGERR
 Q
 ;
DATA ; IEN^NAME^INACTIVE of MAS ELIGIBILIY CODE file (#8.1)
 ;;1^SERVICE CONNECTED 50% to 100%
 ;;2^AID & ATTENDANCE
 ;;3^SC LESS THAN 50%
 ;;4^NSC, VA PENSION
 ;;5^NSC
 ;;6^OTHER FEDERAL AGENCY
 ;;7^ALLIED VETERAN
 ;;8^HUMANITARIAN EMERGENCY
 ;;9^SHARING AGREEMENT
 ;;10^REIMBURSABLE INSURANCE
 ;;11^DOM. PATIENT^1
 ;;12^CHAMPVA
 ;;13^COLLATERAL OF VET.
 ;;14^EMPLOYEE
 ;;15^HOUSEBOUND
 ;;16^MEXICAN BORDER WAR
 ;;17^WORLD WAR I
 ;;18^PRISONER OF WAR
 ;;19^TRICARE/CHAMPUS
 ;;20^MEDICARE^1
 ;;21^CATASTROPHICALLY DISABLED
 ;;QUIT
